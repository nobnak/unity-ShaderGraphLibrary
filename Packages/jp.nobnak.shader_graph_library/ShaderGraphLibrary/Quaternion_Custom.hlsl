#ifndef __Quaternion_Custom__
#define __Quaternion_Custom__

#include "Packages/jp.nobnak.shader_graph_library/ShaderLibrary/Quaternion.hlsl"

void Quaternion_float(float3 axis, float rad, out float4 q) {
    q = quaternion(axis, rad);
}
void QRotate_float(float4 q, float3 v, out float3 r) {
    r = qrotate(q, v);
}

#endif