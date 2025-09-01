// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LagRadarSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LagRadarKit",
            targets: ["LagRadarKit"])
    ],
    targets: [
        .binaryTarget(
            name: "LagRadarKit",
            url: "https://github.com/user-attachments/files/22071692/LagRadarKit.xcframework.zip",
            checksum: "21323e1e6df15617e9524613d86690cf1d9d6920a04f4dc540b5db8589f98ec6"
        )
    ]
)
