/*
 * Copyright (C) 2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Don't edit this file!  It is auto-generated by frameworks/rs/api/gen_runtime.

/*
 * rs_math.rsh: TODO Add documentation
 *
 * TODO Add documentation
 */
#ifndef RENDERSCRIPT_RS_MATH_RSH
#define RENDERSCRIPT_RS_MATH_RSH

/*
 * rsClamp: Restrain a value to a range
 *
 * Clamp a value between low and high.
 *
 * Deprecated.  Use clamp() instead.
 *
 * Parameters:
 *   amount The value to clamp
 *   low Lower bound
 *   high Upper bound
 */
extern char __attribute__((const, always_inline, overloadable))
    rsClamp(char amount, char low, char high);

extern uchar __attribute__((const, always_inline, overloadable))
    rsClamp(uchar amount, uchar low, uchar high);

extern short __attribute__((const, always_inline, overloadable))
    rsClamp(short amount, short low, short high);

extern ushort __attribute__((const, always_inline, overloadable))
    rsClamp(ushort amount, ushort low, ushort high);

extern int __attribute__((const, always_inline, overloadable))
    rsClamp(int amount, int low, int high);

extern uint __attribute__((const, always_inline, overloadable))
    rsClamp(uint amount, uint low, uint high);

/*
 * Computes 6 frustum planes from the view projection matrix
 *
 * Parameters:
 *   viewProj matrix to extract planes from
 *   left left plane
 *   right right plane
 *   top top plane
 *   bottom bottom plane
 *   near near plane
 *   far far plane
 */
static inline void __attribute__((always_inline, overloadable))
    rsExtractFrustumPlanes(const rs_matrix4x4* viewProj, float4* left, float4* right, float4* top,
                           float4* bottom, float4* near, float4* far) {
    // x y z w = a b c d in the plane equation
    left->x = viewProj->m[3] + viewProj->m[0];
    left->y = viewProj->m[7] + viewProj->m[4];
    left->z = viewProj->m[11] + viewProj->m[8];
    left->w = viewProj->m[15] + viewProj->m[12];

    right->x = viewProj->m[3] - viewProj->m[0];
    right->y = viewProj->m[7] - viewProj->m[4];
    right->z = viewProj->m[11] - viewProj->m[8];
    right->w = viewProj->m[15] - viewProj->m[12];

    top->x = viewProj->m[3] - viewProj->m[1];
    top->y = viewProj->m[7] - viewProj->m[5];
    top->z = viewProj->m[11] - viewProj->m[9];
    top->w = viewProj->m[15] - viewProj->m[13];

    bottom->x = viewProj->m[3] + viewProj->m[1];
    bottom->y = viewProj->m[7] + viewProj->m[5];
    bottom->z = viewProj->m[11] + viewProj->m[9];
    bottom->w = viewProj->m[15] + viewProj->m[13];

    near->x = viewProj->m[3] + viewProj->m[2];
    near->y = viewProj->m[7] + viewProj->m[6];
    near->z = viewProj->m[11] + viewProj->m[10];
    near->w = viewProj->m[15] + viewProj->m[14];

    far->x = viewProj->m[3] - viewProj->m[2];
    far->y = viewProj->m[7] - viewProj->m[6];
    far->z = viewProj->m[11] - viewProj->m[10];
    far->w = viewProj->m[15] - viewProj->m[14];

    float len = length(left->xyz);
    *left /= len;
    len = length(right->xyz);
    *right /= len;
    len = length(top->xyz);
    *top /= len;
    len = length(bottom->xyz);
    *bottom /= len;
    len = length(near->xyz);
    *near /= len;
    len = length(far->xyz);
    *far /= len;
}

/*
 * Returns the fractional part of a float
 */
extern float __attribute__((const, overloadable))
    rsFrac(float v);

/*
 * Checks if a sphere is withing the 6 frustum planes
 *
 * Parameters:
 *   sphere float4 representing the sphere
 *   left left plane
 *   right right plane
 *   top top plane
 *   bottom bottom plane
 *   near near plane
 *   far far plane
 */
static inline bool __attribute__((always_inline, overloadable))
    rsIsSphereInFrustum(float4* sphere, float4* left, float4* right, float4* top, float4* bottom,
                        float4* near, float4* far) {
    float distToCenter = dot(left->xyz, sphere->xyz) + left->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    distToCenter = dot(right->xyz, sphere->xyz) + right->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    distToCenter = dot(top->xyz, sphere->xyz) + top->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    distToCenter = dot(bottom->xyz, sphere->xyz) + bottom->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    distToCenter = dot(near->xyz, sphere->xyz) + near->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    distToCenter = dot(far->xyz, sphere->xyz) + far->w;
    if (distToCenter < -sphere->w) {
        return false;
    }
    return true;
}

/*
 * Pack floating point (0-1) RGB values into a uchar4.
 *
 * For the float3 variant and the variant that only specifies r, g, b,
 * the alpha component is set to 255 (1.0).
 */
extern uchar4 __attribute__((const, overloadable))
    rsPackColorTo8888(float r, float g, float b);

extern uchar4 __attribute__((const, overloadable))
    rsPackColorTo8888(float r, float g, float b, float a);

extern uchar4 __attribute__((const, overloadable))
    rsPackColorTo8888(float3 color);

extern uchar4 __attribute__((const, overloadable))
    rsPackColorTo8888(float4 color);

/*
 * Return a random value between 0 (or min_value) and max_malue.
 */
extern int __attribute__((overloadable))
    rsRand(int max_value);

extern int __attribute__((overloadable))
    rsRand(int min_value, int max_value);

extern float __attribute__((overloadable))
    rsRand(float max_value);

extern float __attribute__((overloadable))
    rsRand(float min_value, float max_value);

/*
 * Unpack a uchar4 color to float4.  The resulting float range will be (0-1).
 */
extern float4 __attribute__((const))
    rsUnpackColor8888(uchar4 c);

/*
 * Convert from YUV to RGBA.
 */
extern float4 __attribute__((const, overloadable))
    rsYuvToRGBA_float4(uchar y, uchar u, uchar v);

extern uchar4 __attribute__((const, overloadable))
    rsYuvToRGBA_uchar4(uchar y, uchar u, uchar v);

#endif // RENDERSCRIPT_RS_MATH_RSH
