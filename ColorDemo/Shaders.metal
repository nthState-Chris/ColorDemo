#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4
chromatic_aberration(float2 position, half4 color, float rSlider, float gSlider, float bSlider, const texture2d<half, access::sample> texture) {

    const half4 r = texture.read(uint2(position.x - rSlider, position.y + rSlider));
    const half4 g = texture.read(uint2(position.x - gSlider, position.y + gSlider));
    const half4 b = texture.read(uint2(position.x - bSlider, position.y + bSlider));

    return half4(r.r, g.g, b.b, color.a);
}
