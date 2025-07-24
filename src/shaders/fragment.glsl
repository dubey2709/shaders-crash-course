// precision mediump float; [only for RawShaderMaterial]
// This line in GLSL sets the default precision for float types in the fragment shader
//variables will default to medium precision (mediump), unless otherwise specified.


// like classes in javascript we have structs in glsl
// struct vec5{
//     float x;
//     float y;
//     float z;
//     float w;
//     float q;
// };

// In GLSL, you cannot define custom constructors or overload them like in C++ 
// meaning you cannot define your own vec5(int) constructor or make automatic int → float conversions inside your own struct constructor.
// vec5 makeVec5(float val) {
//     return vec5(val, val, val, val, val);
// }

// vec5 makeVec5FromInt(int val) {
//     float f = float(val);
//     return vec5(f, f, f, f, f);
// }

// function example
// float sum(float a, float b){
//     return a+b;
// }

uniform sampler2D uTexture;

varying vec3 vPosition;
varying vec3 vNormal;
varying vec2 vUv;

// varyings cannot be modified from the fragment shaders

void main() {
    // vec3 color = vec3(1.0);
    // color.x = 0 (Error) --> color.x = 0.f (Correct)

    // setting all components x, y, z and w to 1
    // vec4 color = vec4(1.0);
    // vec4 color = vec4(vec2(1.0),vec2(0.0));

    // vec5 myVector = vec5(1.0,1.0,1.0,1.0,1.0); // vec5(1.0) doesnt work because it is not a native struct
    // vec5 myVector = makeVec5(1.0);
    // vec5 myVector = makeVec5FromInt(1);

    // SWIZZLE MASKS: In GLSL, swizzling is a way to reorder, duplicate, or extract components from vector types like vec2, vec3, vec4.

    // vec3 color = vec3(1,0,1);

    // color.r = 0.0;
    // color.rg = vec2(1,0); // Note .gr != .rg
    // color.rbg = vec3(0,1,1); // It is same as color.xzy
    // You can either do x, y, z and rgb together
	// gl_FragColor = vec4(color, 1);

    // vec3 color = vec3(1,0,1);
    // gl_FragColor = vec4(color.zzy, 1); // It is same as vec4(1,1,0,1)

    // vec3 color = vec3(1,0,1);
    // color += vec3(0,2,0);
    // color -= vec3(0,1,0);
    // color *= vec3(3,1,1);
    // color /= vec3(0,0,0);

    // float newFloat = mod(color.r,2.0);
    // % does not exist in GLSL and we use mod function

    // if anything goes out of range it is clamped either to zero or one

    // bvec3 isEqual = equal(vec3(1,1,1),vec3(1,0,1));


    // pow(vUv.x,3.0)
    // step(0.5,vUv.x)
    // smoothstep(0.45,0.55,vUv.x): smoothstep() performs smooth Hermite interpolation between 0 and 1 when edge0 < x < edge1.
    // length(uv)
    // fract(vUv.x * 10.0): only returns fractional part 2.5 -> 0.5 and 3.5 -> 0.5
    // mix is used for linear interpolation (aka LERP) between two values
    // dot(vectorA,vectorB) => vectorA.x * vectorB.x + vectorA.y * vectorB.y + vectorA.z * vectorB.z

    // vec2 uv = vUv;
    // uv -= vec2(0.5);
    // uv *= 2.0;

    // vec3 viewDirection = normalize(cameraPosition - vPosition);
    // float fresnel = 1.0 - dot(viewDirection,vNormal);

    // Line: vec4(vec3(step(0.99,1.0-abs(vUv.x - 0.5))),1);
    // Circle: vec4(vec3(step(0.5,length(vUv-0.5))),1);

    const vec3 DESATURATE = vec3(0.2126, 0.7152, 0.0722);
    vec3 color = texture2D(uTexture, vUv).xyz;

    float finalColor = dot(DESATURATE, color);
    gl_FragColor = vec4(vec3(finalColor),1.0);
}

/*

types available in glsl

float, double, int, uint, bool

vec3 -> x, y, z (floats)
vec2 -> x,y
vec4

ivec3 -> stores x, y and z as int
uvec3, bvec3, dvec3


Some Builtin functions:

abs()
min(), max()
mod()
sin(), cos(), tan(), atan()
dot(), cross()
clamp(-0.1,0,1)
step, smoothstep, fract
equal()

*/