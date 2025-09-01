# LagRadar iOS SDK - Documentation

LagRadar is an in-app UI performance profiling tool for the iOS platform. It leverages advanced techniques like method swizzling to monitor your application's behavior in real-time. The SDK collects detailed metrics on rendering, responsiveness, and memory allocation, then streams them over the network to an external analytics tool.

The primary goal of LagRadar is to help developers identify and diagnose performance bottlenecks that can lead to UI stuttering and a degraded user experience.

## Getting Started

## Installation

You can add **LagRadar iOS SDK** to your project using Swift Package Manager (SPM):

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:https://github.com/BakJakub/LagRadarSDK.git
3. Select the version rule (e.g. **Exact Version** or **Up to Next Major**).
4. Add the **LagRadarKit** product to your app target.

Integrating the SDK is straightforward. Simply initialize the monitoring at an appropriate point in your app's lifecycle, such as in your `AppDelegate` or `SceneDelegate`.

```swift
import UIKit
import LagRadarKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Start monitoring with the default data publishing interval
        LagRadar.start() 
        
        // You can also specify how often the data should be sent (in seconds)
        // LagRadar.start(publishInterval: 1.0)

        return true
    }
}
```

To stop the SDK's operation, call the `stop()` method:
```swift
LagRadar.stop()
```

## Understanding the Data and Analytics UI

The SDK streams data to a visualization tool that presents it across several specialized tabs. Below is a description of the key metrics and views.

### Key Metrics

In the **Timeline** tab, you will see a list of measurement events, each described by the following metrics:

*   **Screen**
    *   **What it is**: The class name of the active `UIViewController` where the event occurred. The SDK automatically identifies the current screen, allowing you to group performance issues by specific parts of your app. For example: `ProductDetailsViewController`.

*   **Trigger**
    *   **What it is**: The cause that initiated the UI rebuild and started the measurement. Identifying the trigger is crucial to understanding *what* caused the performance load. Examples:
        *   `appear`: The measurement started because a new view controller was about to appear on screen (e.g., from a push navigation or modal presentation).
        *   `- [CartViewController addToCartButtonTapped:]`: The measurement was triggered by a user action—in this case, tapping a button that executed the `addToCartButtonTapped:` method on an instance of `CartViewController`.

*   **Build Ms (Build Time)**
    *   **What it is**: The total time (in milliseconds) from the moment the trigger was activated until the change was fully rendered on the screen. This is the most critical metric, showing how long the user had to wait for a visual response from the app.
    *   **How it's calculated**: `Build Ms` is the time from the start of the measurement (e.g., `viewWillAppear` or `sendAction`) until the `CATransaction.setCompletionBlock` signals that the render loop has finished.

*   **Layout Ms (Layout Time)**
    *   **What it is**: The time (in milliseconds) spent exclusively on calculating the sizes and positions of views.
    *   **How it's calculated**: This is the time measured between the call to `viewWillLayoutSubviews` and `viewDidLayoutSubviews` for the given view controller. A long layout time indicates a complex view hierarchy, Auto Layout issues, or expensive calculations within the layout code.

*   **Display Ms (Display Time)**
    *   **What it is**: The time (in milliseconds) required by the operating system's Render Server to actually draw the changes on the screen after the layout phase is complete.
    *   **How it's calculated**: It is calculated as the difference: `Display Ms = Build Ms - Layout Ms`. High values in this metric may suggest issues related to graphics-intensive operations, such as rendering shadows, transparencies, masks, or complex shapes.

*   **Chart on the right (Build Time Breakdown)**
    *   **What it is**: This is a visual representation of the `Build Ms` metric. It shows what portion of the total build time was consumed by `Layout Ms` (layout calculations) and what portion was consumed by `Display Ms` (rendering).
    *   **What it contains**: A stacked bar chart, allowing for a quick assessment of which phase—layout or rendering—was the bottleneck for a given event.

---

## Analytics Tool Tabs Description

### 1. Tab: Timeline

*   This is the main screen of the tool, displaying a real-time stream of performance events in chronological order (newest at the top). Each row in the list represents one complete measurement of a UI build cycle.
*   **What it contains**:
    *   A list of events with the metrics described above: `Screen`, `Trigger`, `Build Ms`, `Layout Ms`, and `Display Ms`.
    *   A visual breakdown of the build time in the chart for each event.
    *   The ability to filter and sort events to quickly find the most expensive ones.

### 2. Tab: Summary

*   This tab aggregates data collected during the entire profiling session to provide a high-level overview of the application's performance. Instead of looking at individual events, it analyzes trends and points out the biggest problems.
*   **What it contains**:
    *   **Slowest Screens**: A ranking of `UIViewController`s with the longest average or maximum `Build Ms`.
    *   **Slowest Triggers**: A list of user actions or system events that cause the longest UI rebuilds.
    *   **Global Statistics**: Average values for `Build Ms`, `Layout Ms`, and `Display Ms` across the entire application.
    *   **Charts and Histograms**: Visualizations of build time distribution, allowing you to assess whether most rebuilds are fast or if long operations occur frequently.

### 3. Tab: Allocations

*   This tab visualizes the data collected by the `AllocProbe` module. It allows you to monitor how many `UIView` objects are being created over time. This is key to detecting memory leaks or inefficient reuse of cells (`UITableViewCell`, `UICollectionViewCell`).
*   **What it contains**:
    *   **Allocations over time chart**: Shows the number of newly created instances for tracked classes (`UILabel`, `UIImageView`, etc.) in specific time intervals.
    *   **Allocation count table**: A precise count of how many objects of each class have been created since the last report. A sudden spike in allocations after performing an action can indicate a problem.

### 4. Tab: Frames

*   This tab is dedicated to analyzing animation and rendering smoothness (FPS). It uses data from the `FrameSampler` module to provide a detailed assessment of whether the application is running smoothly.
*   **What it contains**:
    *   **FPS over time chart**: A timeline showing the current frames per second, making it easy to identify moments when animations slow down.
    *   **Long Frames counter**: Counts frames that took significantly longer to render than the standard 16.7 ms budget. Each such frame is a potential "stutter" visible to the user.
    *   **Frame time histogram**: A bar chart that groups frames by their rendering time (e.g., 0-16.7ms, 16.7-33ms, 33-50ms, etc.). This allows for a deeper analysis of rendering stability, showing whether most frames meet their time budget. The histogram is available for the entire app and also broken down by individual screens.

