#ifndef __Smoothstep__
#define __Smoothstep__

// References
// - https://math.stackexchange.com/questions/1749250/smoothstep-looking-for-a-continuous-family-of-interpolation-functions
// - https://www.desmos.com/calculator/xs2wdwd7s3
// - https://www.desmos.com/calculator/3zhzwbfrxd?lang=ja

float steepstep(float min, float max, float s, float x)
{
    float t = saturate((x - min) / (max - min));
    float c = s == 2.0 ? 1e10 : -s / (s - 2.0);
    
    float w0 = saturate(2 * t * (1 + c) / (2 * t + c));
    w0 *= w0;
    float out0 = t * w0;
    
    float w1 = saturate(2 * (1 - t) * (1 + c) / (2 * (1 - t) + c));
    w1 *= w1;
    float out1 = 1 - (1 - t) * w1;

    return t <= 0.5 ? out0 : out1;
}
float4 steepstep(float4 min, float4 max, float4 s, float4 x)
{
    float4 t = saturate((x - min) / (max - min));
    float4 c = s == 2.0 ? 1e10 : -s / (s - 2.0);
    
    float4 w0 = saturate(2 * t * (1 + c) / (2 * t + c));
    w0 *= w0;
    float4 out0 = t * w0;
    
    float4 w1 = saturate(2 * (1 - t) * (1 + c) / (2 * (1 - t) + c));
    w1 *= w1;
    float4 out1 = 1 - (1 - t) * w1;

    return t <= 0.5 ? out0 : out1;
}

#define FP(x, n, c) saturate(pow(x, c) / pow(n, c - 1))

float pivotstep(float min, float max, float p, float s, float x) {
    p = saturate((p - min) / (max - min));
    x = (x - min) / (max - min);
    float c = 2.0 / (1 - s) - 1;
    
    return (x <= 0 || 1 <= x || p <= min)
        ? saturate(x)
        : (x < p ? FP(x, p, c) : 1 - FP(1 - x, 1 - p, c));
}
float4 pivotstep(float4 min, float4 max, float4 p, float4 s, float4 x) {
    p = saturate((p - min) / (max - min));
    x = (x - min) / (max - min);
    float4 c = 2.0 / (1 - s) - 1;
    
    return (x <= 0 || 1 <= x || p <= min)
        ? saturate(x)
        : (x < p ? FP(x, p, c) : 1 - FP(1 - x, 1 - p, c));
}

#endif