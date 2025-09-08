#ifndef __WIREFRAME_CGINC__
#define __WIREFRAME_CGINC__

static const float CUTOFF = 0.5;

float wireframe(float4 bary, float gain)
{
	float4 d = fwidth(bary);
	float4 l = smoothstep(0, gain * d, bary);
	float lmin = min(min(l.x, l.y), min(l.z, l.w));
	//return saturate(1 - lmin);
	//return smoothstep(CUTOFF - 0.1, CUTOFF + 0.1, 1 - lmin);
	return step(CUTOFF, 1 - lmin);
}
float wireframe(float3 b, float gain)
{
	return wireframe(float4(b, 1), gain);
}
float wireframe(float2 b, float gain)
{
	return wireframe(float4(b, 1, 1), gain);
}
float wireframe(float b, float gain)
{
	return wireframe(float4(b, 1, 1, 1), gain);
}

#endif
