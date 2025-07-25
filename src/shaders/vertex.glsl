// uniform mat4 projectionMatrix;
// uniform mat4 modelViewMatrix; // we have two matrices modelMatrix and viewMatrrix
// attribute vec3 position; 

// uniform mat4 modelMatrix; // Its an interface variable
// uniform mat4 viewMatrix;

// (mat4 == mat2X2)


// attribute: vertex specific data that we are storing in an array, supported in vertex shader only
// uniform is same for every single vertex. Its same used across all vertices (also works with fragment shaders)

// Global shared variables
// Constant across a single draw call

// normals: A normal vector describes the orientation (facing direction) of a vertex or surface — crucial for shading and lighting realism. (Vec3)
// A normal vector is perpendicular to the surface at a vertex — not the vertex itself and each vertex has a normal

// So we have vertex data, and we want to fill the triangle with values like color or texture. Since we can't determine everything from just 3 vertices
// directly, the GPU interpolates values across the triangle, and then runs the fragment shader per pixel using those interpolated values.

// Storage Qualifier	A modifier that describes how/where a variable is used

// UVs are 2D coordinates (u, v) that map a texture image onto a 3D model.

// Lerp: Linear Interpolation

// flat is a qualifier that tells the GPU not to interpolate a varying variable between the vertex and fragment shaders.

varying vec3 vPosition;
// communication between vertex shader and fragment shader
varying vec3 vNormal;
varying vec2 vUv;

void main() {
	// Transform -> position, scale, rotation
	// modelMatrix -> position, scale and rotation of our model (transform of our model)
	// viewMatrix -> position and oritentation of our camera
	// projectionMatrix -> projects our object onto the screen (aspect ratio and the perspective)

	// Order MVP reverse (fixed)
	// gl_Position = projectionMatrix * modelMatrix * viewMatrix * vec4( position, 1.0 );

	vPosition = position;
	vNormal = normal;
	vUv = uv;

	vec4 modelViewPosition = modelViewMatrix * vec4( position, 1.0 );
	vec4 projectedPosition = projectionMatrix * modelViewPosition;
	gl_Position = projectedPosition;
}