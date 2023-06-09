# WWDC2023 iOS17 SwiftUI Shader Demo with Image Argument

Here's a sample project using the new colorEffect to apply chromatic abberation
on an image

```swift
.colorEffect
```

We use the `Shader.Argument.image` to convert an image which we can sample.

```metal
[[ stitchable ]] half4
chromatic_aberration(float2 position, half4 color, float rSlider, float gSlider, float bSlider, const texture2d<half, access::sample> texture) {
```
