
vec3 coordinates = normal;
coordinates.y += uTime;
vec3 noisecoordinates =  vec3(noise(coordinates));
float pattern = wave(noisecoordinates);

vDisplacement = pattern;

float displacement  = vDisplacement / 3.0;
transformed += normalize(objectNormal) * displacement;
