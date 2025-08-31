// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LagRadarSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LagRadarSDK",
            targets: ["LagRadarSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "LagRadarSDK",
            url: "https://github.com/user-attachments/files/22062890/LagRadarKit.xcframework.zip",
            checksum: "de2b80b5d720580403ca4859ab1899fda54811e9b821880b17695ae1465960e7"
        )
    ]
)
