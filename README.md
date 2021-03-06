# WebViewCapture

WKWebView extension to take a snapshot image with specific element.

```swift
webView.image("hplogo") { [weak self] image in
    self?.imageView.image = image
}
```

![example screenshot](./screenshot.png)

## Requirements

iOS 11

## Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Alamofire does support its use on supported platforms.

Once you have your Swift package set up, adding WebViewCapture as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ssauma/WebViewCapture.git", .upToNextMajor(from: "0.1.0"))
]
```

## CocoaPods

WebViewCapture is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'WebViewCapture'
```

## Author

Juyeon Lee, juyeonlee@me.com

## License

WebViewCapture is available under the MIT license. See the LICENSE file for more info.
