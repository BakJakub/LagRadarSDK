# LagRadarSDK

The **LagRadarSDK** package allows you to monitor your app's UI performance in real time, providing key insights into rendering and layout performance.

## Overview

LagRadarSDK captures essential signals from your app and streams them to the LagRadar macOS panel or any compatible consumer. This data helps developers quickly identify bottlenecks and performance regressions in complex user interfaces.

Collected metrics include:

- **FPS & Long Frames** – Track rendering smoothness and identify frame drops.
- **Build/Layout/Display Timings** – Measure how long it takes to prepare and render each screen.
- **Trigger Information** – Understand which user action (e.g., a button tap) caused a screen transition.
- **Granular Layout Samples** – Pinpoint slow views by measuring per-`UIView` layout cost.

## Installation

You can add LagRadarSDK to your project using Swift Package Manager in Xcode.

1.  In Xcode, go to **File > Add Packages...**
2.  Enter the repository URL in the search bar:
    ```
    https://github.com/BakJakub/LagRadarSDK.git
    ```
3.  Choose your dependency rule (e.g., "Up to Next Major Version") and click "Add Package".
4.  Select the `LagRadarSDK` library and add it to your app's target.

## Usage

The SDK is designed to run only in `DEBUG` builds. While the `start()` function is automatically disabled in Release builds, wrapping it in a `#if DEBUG` block makes this behavior explicit and is the recommended approach.

### For UIKit Apps

Import the library and call `LagRadar.start()` in your `AppDelegate`.

```swift
import UIKit
import LagRadarSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    #if DEBUG
      // Start probes with the default 0.2s publish interval
      LagRadar.start()
    #endif

    return true
  }
}

### For SwiftUI Apps
Import the library and call LagRadar.start() in your main App struct's initializer.

import SwiftUI
import LagRadarSDK

@main
struct MyApp: App {
  init() {
    #if DEBUG
      // Start probes with a custom 0.5s publish interval
      LagRadar.start(publishInterval: 0.2)
    #endif
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}


Public API
LagRadar/start(publishInterval:)
Starts all probes and begins the metric transport loop. The publishInterval parameter controls how often data is sent.

LagRadar/stop()
Stops all active probes and terminates the metric transport loop.
