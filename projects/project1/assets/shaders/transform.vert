#version 410 core

layout(location = 0) in vec3 aPosition;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec2 aUv;

uniform mat4 uModel;
uniform mat4 uModelViewProjection;
uniform mat3 uNormalTransform;

// Captured before fixed-function clipping, in the ClipVertex record order.
precise out vec4 tfClip;
precise out vec3 tfWorldPosition;
precise out vec3 tfNormal;
out vec2 tfUv;

void main() {
    // TODO: apply mvp transformation for each vertices
    /*************************************** TODO BEGIN ******************************************/
    tfClip = vec4(0.0, 0.0, 0.0, 1.0);
    tfWorldPosition = vec3(0.0);
    tfNormal = vec3(0.0, 0.0, 1.0);
    tfUv = vec2(0.0);
    gl_Position = tfClip;
    /**************************************** TODO END *******************************************/
}
