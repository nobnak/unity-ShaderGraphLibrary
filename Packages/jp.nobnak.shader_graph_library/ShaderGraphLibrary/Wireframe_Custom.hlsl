#ifndef __Wireframe_Custom__
#define __Wireframe_Custom__

#include "Packages/jp.nobnak.shader_graph_library/ShaderLibrary/Wireframe.hlsl"

void wireframe_float(float4 In, float gain, out float Out)
{
	Out = wireframe(In, gain);
}
void wireframe_half(half4 In, half gain, out half Out)
{
	Out = wireframe(In, gain);
}

#endif