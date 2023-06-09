#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4
colorEffect(float2 position, half4 color, float rSlider, float gSlider, float bSlider, const texture2d<half, access::sample> texture) {

    const half4 r = texture.read(uint2(position.x - rSlider, position.y + rSlider));
    const half4 g = texture.read(uint2(position.x - gSlider, position.y + gSlider));
    const half4 b = texture.read(uint2(position.x - bSlider, position.y + bSlider));

    return half4(r.r, g.g, b.b, color.a);
}

[[ stitchable ]] float2
distortEffect(float2 position, float rSlider, float gSlider, float bSlider) {

    float2 newPos = position;
    if (int(position.x) % int(rSlider) == 0) {
        newPos.x = newPos.x * gSlider;
    }

    return newPos;
}

[[ stitchable ]] half4
layerEffect(float2 position, SwiftUI::Layer layer, float rSlider, float gSlider, float bSlider) {

    float2 newPos = float2(position.x, position.y);
    if (newPos.x > 150) {
        newPos = cos(newPos / rSlider);
    }
    return layer.sample(newPos);
}
