#ifndef __QUATERNION__
#define __QUATERNION__

#define HALF_DEG2RAD 8.72664625e-3

float4 qnormalize(float3 xyz, float w) {
	return normalize(float4(xyz, w));
}
float4 quaternion(float3 axis, float rad) {
	axis = normalize(axis);
    rad *= 0.5;
	return float4(axis * sin(rad), cos(rad));
}
float4 qfromto(float3 fromDir, float3 toDir) {
	fromDir = normalize(fromDir);
	toDir = normalize(toDir);
	float rad = 0.5 * acos(dot(fromDir, toDir));
	float3 axis = normalize(cross(fromDir, toDir));
	return qnormalize(axis * sin(rad), cos(rad));
}
float4 __qmultiply(float4 a, float4 b) {
	return float4(a.w * b.xyz + b.w * a.xyz + cross(a.xyz, b.xyz), a.w * b.w - dot(a.xyz, b.xyz));
}
float4 qmultiply(float4 a, float4 b) {
	return normalize(__qmultiply(a, b));
}
float3 qrotate(float4 q, float3 v) {
	return __qmultiply(__qmultiply(q, float4(v, 0)), float4(-q.xyz, q.w)).xyz;
}
float3 qrotateinv(float4 q, float3 v) {
	return __qmultiply(__qmultiply(float4(-q.xyz, q.w), float4(v, 0)), q).xyz;
}
float4x4 qmatrix(float4 q) {
	float4x4 m = {
		1.0 - 2.0 * (q.y * q.y + q.z * q.z),
		2.0 * (q.x * q.y - q.z * q.w),
		2.0 * (q.x * q.z + q.y * q.w),
		0.0,

		2.0 * (q.x * q.y + q.z * q.w),
		1.0 - 2.0 * (q.x * q.x + q.z * q.z),
		2.0 * (q.y * q.z - q.x * q.w),
		0.0,

		2.0 * (q.x * q.z - q.y * q.w),
		2.0 * (q.y * q.z + q.x * q.w),
		1.0 - 2.0 * (q.x * q.x + q.y * q.y),
		0.0,

		0, 0, 0, 1
	};
	return m;
}

#endif
