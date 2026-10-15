#version 410 core

// Clip each source triangle like buildScreenTriangles() on the CPU, then emit
// candidate fragments for every triangle in the clipped polygon's fan.
layout(triangles) in;
layout(triangle_strip, max_vertices = 21) out;

in VertexData {
    vec4 clip;
    vec3 worldPosition;
    vec3 normal;
    vec2 uv;
} vertexData[];

// The fragment shader evaluates the screen-space edges itself. These values
// must stay constant across each generated candidate triangle.
flat out vec4 gScreenAndInvW[3];
flat out vec3 gWorld[3];
flat out vec3 gNormal[3];
flat out vec2 gUv[3];

uniform vec2 uExtent;

struct ClipVertex {
    vec4 clip;
    vec3 worldPosition;
    vec3 normal;
    vec2 uv;
};

struct ScreenVertex {
    // xy is pixel position, z is depth, and w is 1 / clip-space w.
    vec4 screenAndInvW;
    vec3 worldPosition;
    vec3 normal;
    vec2 uv;
};

// A triangle clipped by six planes has at most nine vertices. Keep the side
// where dot(plane, vertex.clip) >= 0, just as the CPU clipAgainst() does.
int clipAgainst(inout ClipVertex polygon[9], int count, vec4 plane) {
    // TODO: Clip the polygon against this plane with Sutherland-Hodgman.
    // Hint: visit every edge, including the edge from the last vertex to the first;
    // emit a crossing vertex when the endpoints are on opposite sides.
    /*************************************** TODO BEGIN ******************************************/
    /**************************************** TODO END *******************************************/
}

void main() {
    ClipVertex polygon[9];
    int count = 3;
    for (int i = 0; i < 3; ++i) {
        polygon[i].clip = vertexData[i].clip;
        polygon[i].worldPosition = vertexData[i].worldPosition;
        polygon[i].normal = vertexData[i].normal;
        polygon[i].uv = vertexData[i].uv;
    }

    // OpenGL's homogeneous clip volume is -w <= x, y, z <= w.

    // Clip the source triangle against all six homogeneous clip planes.
    count = clipAgainst(polygon, count, vec4(1, 0, 0, 1));  // left: x + w >= 0
    count = clipAgainst(polygon, count, vec4(-1, 0, 0, 1)); // right: w - x >= 0
    count = clipAgainst(polygon, count, vec4(0, 1, 0, 1));  // bottom: y + w >= 0
    count = clipAgainst(polygon, count, vec4(0, -1, 0, 1)); // top: w - y >= 0
    count = clipAgainst(polygon, count, vec4(0, 0, 1, 1));  // near: z + w >= 0
    count = clipAgainst(polygon, count, vec4(0, 0, -1, 1)); // far: w - z >= 0

    // A convex clipped polygon becomes (0, 1, 2), (0, 2, 3), ... .
    for (int fan = 1; fan + 1 < count; ++fan) {
        ClipVertex triangle[3] = ClipVertex[3](polygon[0], polygon[fan], polygon[fan + 1]);
        ScreenVertex screenTriangle[3];
        // TODO: Convert each clip-space vertex to a ScreenVertex.
        // Hint: divide xyz by clip.w, map NDC xy to pixels and z to [0, 1],
        // and retain 1 / clip.w for perspective-correct interpolation.
        /*************************************** TODO BEGIN ******************************************/
        /**************************************** TODO END *******************************************/

        // TODO: Bound the candidate pixels and emit a primitive covering them.
        // Hint: Convert the screen-space bounds back to NDC; the fragment shader
        //       will perform the exact per-pixel triangle coverage test.
        // Hint: Use EmitVertex/EmitPrimitive
        /*************************************** TODO BEGIN ******************************************/
        /**************************************** TODO END *******************************************/
    }
}
