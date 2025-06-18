#ifndef __Smoothstep_Custom__
#define __Smoothstep_Custom__

#include "Packages/jp.nobnak.shader_graph_library/ShaderLibrary/Smoothstep.hlsl"

void PivotStep1_float(float Min, float Max, float Pivot, float Steep, float In, out float Out) {
    Out = pivotstep(Min, Max, Pivot, Steep, In);
}
void PivotStep4_float(float4 Min, float4 Max, float4 Pivot, float4 Steep, float4 In, out float4 Out) {
    Out = pivotstep(Min, Max, Pivot, Steep, In);
}

#endif