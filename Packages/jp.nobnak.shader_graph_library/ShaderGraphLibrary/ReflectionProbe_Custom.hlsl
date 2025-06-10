#ifndef __PerceptualRoughnessToMipmapLevel_Custom__
#define __PerceptualRoughnessToMipmapLevel_Custom__

#ifndef SHADERGRAPH_PREVIEW
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#endif

#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/ImageBasedLighting.hlsl"

void PerceptualRoughnessToMipmapLevel_float(float perceptualRoughness, out float mipmapLevel) {
    mipmapLevel = PerceptualRoughnessToMipmapLevel(perceptualRoughness);
}

// https://discussions.unity.com/t/unity-6-reflection-probes-in-unlit-shader-graph/1554873/15
void GetReflectionProbe_float(float3 ViewDirWS, float3 PositionWS, float3 NormalsWS, float2 NormalizedScreenSpaceUV, float Roughness, out float3 Cubemap)
{
#ifdef SHADERGRAPH_PREVIEW
    Cubemap = 0;
#else
    half3 reflectionVector = reflect(-normalize(ViewDirWS), normalize(NormalsWS));
    half perceptualRoughness = Roughness;
    float occlusion = 1;

    Cubemap = GlossyEnvironmentReflection(reflectionVector, PositionWS, perceptualRoughness, occlusion, NormalizedScreenSpaceUV);
#endif
}

#endif