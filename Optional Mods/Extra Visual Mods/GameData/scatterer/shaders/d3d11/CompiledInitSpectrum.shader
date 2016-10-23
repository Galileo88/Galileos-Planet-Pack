// Compiled shader for all platforms, uncompressed size: 29.9KB

Shader "Proland/Ocean/InitSpectrum" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 42 math, 5 texture
 //        d3d9 : 115 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
#ifndef SHADER_API_OPENGL
    #define SHADER_API_OPENGL 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif

#line 221
struct v2f_vertex_lit {
    vec2 uv;
    vec4 diff;
    vec4 spec;
};
#line 275
struct v2f_img {
    vec4 pos;
    vec2 uv;
};
#line 271
struct appdata_img {
    vec4 vertex;
    vec2 texcoord;
};
#line 25
struct v2f {
    vec4 pos;
    vec2 uv;
};
#line 60
struct appdata_base {
    vec4 vertex;
    vec3 normal;
    vec4 texcoord;
};
#line 31
struct f2a {
    vec4 col0;
    vec4 col1;
    vec4 col2;
};
#line 16
uniform vec4 _Time;
uniform vec4 _SinTime;
uniform vec4 _CosTime;
uniform vec4 unity_DeltaTime;
#line 21
uniform vec3 _WorldSpaceCameraPos;
#line 27
uniform vec4 _ProjectionParams;
#line 33
uniform vec4 _ScreenParams;
uniform vec4 _ZBufferParams;
#line 40
uniform vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform vec4 _WorldSpaceLightPos0;
uniform vec4 _LightPositionRange;
#line 58
uniform vec4 unity_4LightPosX0;
uniform vec4 unity_4LightPosY0;
uniform vec4 unity_4LightPosZ0;
uniform vec4 unity_4LightAtten0;
#line 63
uniform vec4 unity_LightColor[8];
uniform vec4 unity_LightPosition[8];
#line 69
uniform vec4 unity_LightAtten[8];
uniform vec4 unity_SpotDirection[8];
#line 73
uniform vec4 unity_SHAr;
uniform vec4 unity_SHAg;
uniform vec4 unity_SHAb;
uniform vec4 unity_SHBr;
#line 77
uniform vec4 unity_SHBg;
uniform vec4 unity_SHBb;
uniform vec4 unity_SHC;
#line 83
uniform vec3 unity_LightColor0;
uniform vec3 unity_LightColor1;
uniform vec3 unity_LightColor2;
uniform vec3 unity_LightColor3;
#line 90
uniform vec4 unity_ShadowSplitSpheres[4];
uniform vec4 unity_ShadowSplitSqRadii;
uniform vec4 unity_LightShadowBias;
uniform vec4 _LightSplitsNear;
#line 94
uniform vec4 _LightSplitsFar;
uniform mat4 unity_World2Shadow[4];
uniform vec4 _LightShadowData;
uniform vec4 unity_ShadowFadeCenterAndType;
#line 110



#line 122
uniform mat4 _Object2World;
uniform mat4 _World2Object;
uniform vec4 unity_Scale;
#line 133
uniform mat4 glstate_matrix_transpose_modelview0;
#line 149




#line 173


#line 182
uniform mat4 unity_MatrixV;
uniform mat4 unity_MatrixVP;
#line 48
uniform vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 18
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform vec4 _Offset;
#line 22
uniform vec4 _InverseGridSizes;
uniform float _T;
#line 38
#line 46
#line 53
vec2 COMPLEX( in vec2 z ) {
    #line 55
    return vec2( (-z.y), z.x);
}
#line 46
vec2 GetSpectrum( in float w, in vec2 s0, in vec2 s0c ) {
    float c = cos((w * _T));
    float s = sin((w * _T));
    #line 50
    return vec2( (((s0.x + s0c.x) * c) - ((s0.y + s0c.y) * s)), (((s0.x - s0c.x) * s) + ((s0.y - s0c.y) * c)));
}
#line 58
f2a frag( in v2f IN ) {
    #line 60
    vec2 uv = IN.uv.xy;
    vec2 st;
    st.x = (( (uv.x > 0.5) ) ? ( (uv.x - 1.0) ) : ( uv.x ));
    #line 64
    st.y = (( (uv.y > 0.5) ) ? ( (uv.y - 1.0) ) : ( uv.y ));
    vec4 s12 = texture2D( _Spectrum01, uv);
    vec4 s12c = texture2D( _Spectrum01, (_Offset.xy - uv));
    #line 68
    vec4 s34 = texture2D( _Spectrum23, uv);
    vec4 s34c = texture2D( _Spectrum23, (_Offset.xy - uv));
    vec2 k1 = (st * _InverseGridSizes.x);
    #line 72
    vec2 k2 = (st * _InverseGridSizes.y);
    vec2 k3 = (st * _InverseGridSizes.z);
    vec2 k4 = (st * _InverseGridSizes.w);
    #line 76
    vec4 w = texture2D( _WTable, uv);
    vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 80
    vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    vec2 h12 = (h1 + COMPLEX( h2));
    #line 84
    vec2 h34 = (h3 + COMPLEX( h4));
    vec2 n1 = (COMPLEX( (k1.x * h1)) - (k1.y * h1));
    vec2 n2 = (COMPLEX( (k2.x * h2)) - (k2.y * h2));
    #line 88
    vec2 n3 = (COMPLEX( (k3.x * h3)) - (k3.y * h3));
    vec2 n4 = (COMPLEX( (k4.x * h4)) - (k4.y * h4));
    f2a OUT;
    #line 93
    OUT.col0 = vec4( h12, h34);
    OUT.col1 = vec4( n1, n2);
    OUT.col2 = vec4( n3, n4);
    #line 97
    return OUT;
}
varying vec2 xlv_TEXCOORD0;
void main() {
    f2a xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:29(2): warning: empty declaration
0:65(2): warning: empty declaration
0:36(2): warning: empty declaration
0:109(15): error: array index must be < 2
*/

#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddolmmcahcgjmjpiinclfhjokihhgamkaabaaaaaaaeacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif

#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 25
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 31
struct f2a {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 18
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform highp vec4 _Offset;
#line 22
uniform highp vec4 _InverseGridSizes;
uniform highp float _T;
#line 38
#line 46
#line 53
highp vec2 COMPLEX( in highp vec2 z ) {
    #line 55
    return vec2( (-z.y), z.x);
}
#line 46
highp vec2 GetSpectrum( in highp float w, in highp vec2 s0, in highp vec2 s0c ) {
    highp float c = cos((w * _T));
    highp float s = sin((w * _T));
    #line 50
    return vec2( (((s0.x + s0c.x) * c) - ((s0.y + s0c.y) * s)), (((s0.x - s0c.x) * s) + ((s0.y - s0c.y) * c)));
}
#line 58
f2a frag( in v2f IN ) {
    #line 60
    highp vec2 uv = IN.uv.xy;
    highp vec2 st;
    st.x = (( (uv.x > 0.5) ) ? ( (uv.x - 1.0) ) : ( uv.x ));
    #line 64
    st.y = (( (uv.y > 0.5) ) ? ( (uv.y - 1.0) ) : ( uv.y ));
    highp vec4 s12 = texture2D( _Spectrum01, uv);
    highp vec4 s12c = texture2D( _Spectrum01, (_Offset.xy - uv));
    #line 68
    highp vec4 s34 = texture2D( _Spectrum23, uv);
    highp vec4 s34c = texture2D( _Spectrum23, (_Offset.xy - uv));
    highp vec2 k1 = (st * _InverseGridSizes.x);
    #line 72
    highp vec2 k2 = (st * _InverseGridSizes.y);
    highp vec2 k3 = (st * _InverseGridSizes.z);
    highp vec2 k4 = (st * _InverseGridSizes.w);
    #line 76
    highp vec4 w = texture2D( _WTable, uv);
    highp vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    highp vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 80
    highp vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    highp vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    highp vec2 h12 = (h1 + COMPLEX( h2));
    #line 84
    highp vec2 h34 = (h3 + COMPLEX( h4));
    highp vec2 n1 = (COMPLEX( (k1.x * h1)) - (k1.y * h1));
    highp vec2 n2 = (COMPLEX( (k2.x * h2)) - (k2.y * h2));
    #line 88
    highp vec2 n3 = (COMPLEX( (k3.x * h3)) - (k3.y * h3));
    highp vec2 n4 = (COMPLEX( (k4.x * h4)) - (k4.y * h4));
    f2a OUT;
    #line 93
    OUT.col0 = vec4( h12, h34);
    OUT.col1 = vec4( n1, n2);
    OUT.col2 = vec4( n3, n4);
    #line 97
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:29(2): warning: empty declaration
0:65(2): warning: empty declaration
0:36(2): warning: empty declaration
0:109(15): error: array index must be < 2
*/


#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif

#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 25
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 31
struct f2a {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 18
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform highp vec4 _Offset;
#line 22
uniform highp vec4 _InverseGridSizes;
uniform highp float _T;
#line 38
#line 46
#line 53
highp vec2 COMPLEX( in highp vec2 z ) {
    #line 55
    return vec2( (-z.y), z.x);
}
#line 46
highp vec2 GetSpectrum( in highp float w, in highp vec2 s0, in highp vec2 s0c ) {
    highp float c = cos((w * _T));
    highp float s = sin((w * _T));
    #line 50
    return vec2( (((s0.x + s0c.x) * c) - ((s0.y + s0c.y) * s)), (((s0.x - s0c.x) * s) + ((s0.y - s0c.y) * c)));
}
#line 58
f2a frag( in v2f IN ) {
    #line 60
    highp vec2 uv = IN.uv.xy;
    highp vec2 st;
    st.x = (( (uv.x > 0.5) ) ? ( (uv.x - 1.0) ) : ( uv.x ));
    #line 64
    st.y = (( (uv.y > 0.5) ) ? ( (uv.y - 1.0) ) : ( uv.y ));
    highp vec4 s12 = texture2D( _Spectrum01, uv);
    highp vec4 s12c = texture2D( _Spectrum01, (_Offset.xy - uv));
    #line 68
    highp vec4 s34 = texture2D( _Spectrum23, uv);
    highp vec4 s34c = texture2D( _Spectrum23, (_Offset.xy - uv));
    highp vec2 k1 = (st * _InverseGridSizes.x);
    #line 72
    highp vec2 k2 = (st * _InverseGridSizes.y);
    highp vec2 k3 = (st * _InverseGridSizes.z);
    highp vec2 k4 = (st * _InverseGridSizes.w);
    #line 76
    highp vec4 w = texture2D( _WTable, uv);
    highp vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    highp vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 80
    highp vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    highp vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    highp vec2 h12 = (h1 + COMPLEX( h2));
    #line 84
    highp vec2 h34 = (h3 + COMPLEX( h4));
    highp vec2 n1 = (COMPLEX( (k1.x * h1)) - (k1.y * h1));
    highp vec2 n2 = (COMPLEX( (k2.x * h2)) - (k2.y * h2));
    #line 88
    highp vec2 n3 = (COMPLEX( (k3.x * h3)) - (k3.y * h3));
    highp vec2 n4 = (COMPLEX( (k4.x * h4)) - (k4.y * h4));
    f2a OUT;
    #line 93
    OUT.col0 = vec4( h12, h34);
    OUT.col1 = vec4( n1, n2);
    OUT.col2 = vec4( n3, n4);
    #line 97
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:29(2): warning: empty declaration
0:65(2): warning: empty declaration
0:36(2): warning: empty declaration
0:109(15): error: array index must be < 2
*/


#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform highp vec4 _Offset;
uniform highp vec4 _InverseGridSizes;
uniform highp float _T;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 w_1;
  highp vec4 s34c_2;
  highp vec4 s34_3;
  highp vec4 s12c_4;
  highp vec4 s12_5;
  highp vec2 st_6;
  highp float tmpvar_7;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_7 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_7 = xlv_TEXCOORD0.x;
  };
  st_6.x = tmpvar_7;
  highp float tmpvar_8;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_8 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_8 = xlv_TEXCOORD0.y;
  };
  st_6.y = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_Spectrum01, xlv_TEXCOORD0);
  s12_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (_Offset.xy - xlv_TEXCOORD0);
  tmpvar_10 = texture (_Spectrum01, P_11);
  s12c_4 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_Spectrum23, xlv_TEXCOORD0);
  s34_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (_Offset.xy - xlv_TEXCOORD0);
  tmpvar_13 = texture (_Spectrum23, P_14);
  s34c_2 = tmpvar_13;
  highp vec2 tmpvar_15;
  tmpvar_15 = (st_6 * _InverseGridSizes.x);
  highp vec2 tmpvar_16;
  tmpvar_16 = (st_6 * _InverseGridSizes.y);
  highp vec2 tmpvar_17;
  tmpvar_17 = (st_6 * _InverseGridSizes.z);
  highp vec2 tmpvar_18;
  tmpvar_18 = (st_6 * _InverseGridSizes.w);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture (_WTable, xlv_TEXCOORD0);
  w_1 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = cos((w_1.x * _T));
  highp float tmpvar_21;
  tmpvar_21 = sin((w_1.x * _T));
  highp vec2 tmpvar_22;
  tmpvar_22.x = (((s12_5.x + s12c_4.x) * tmpvar_20) - ((s12_5.y + s12c_4.y) * tmpvar_21));
  tmpvar_22.y = (((s12_5.x - s12c_4.x) * tmpvar_21) + ((s12_5.y - s12c_4.y) * tmpvar_20));
  highp float tmpvar_23;
  tmpvar_23 = cos((w_1.y * _T));
  highp float tmpvar_24;
  tmpvar_24 = sin((w_1.y * _T));
  highp vec2 tmpvar_25;
  tmpvar_25.x = (((s12_5.z + s12c_4.z) * tmpvar_23) - ((s12_5.w + s12c_4.w) * tmpvar_24));
  tmpvar_25.y = (((s12_5.z - s12c_4.z) * tmpvar_24) + ((s12_5.w - s12c_4.w) * tmpvar_23));
  highp float tmpvar_26;
  tmpvar_26 = cos((w_1.z * _T));
  highp float tmpvar_27;
  tmpvar_27 = sin((w_1.z * _T));
  highp vec2 tmpvar_28;
  tmpvar_28.x = (((s34_3.x + s34c_2.x) * tmpvar_26) - ((s34_3.y + s34c_2.y) * tmpvar_27));
  tmpvar_28.y = (((s34_3.x - s34c_2.x) * tmpvar_27) + ((s34_3.y - s34c_2.y) * tmpvar_26));
  highp float tmpvar_29;
  tmpvar_29 = cos((w_1.w * _T));
  highp float tmpvar_30;
  tmpvar_30 = sin((w_1.w * _T));
  highp vec2 tmpvar_31;
  tmpvar_31.x = (((s34_3.z + s34c_2.z) * tmpvar_29) - ((s34_3.w + s34c_2.w) * tmpvar_30));
  tmpvar_31.y = (((s34_3.z - s34c_2.z) * tmpvar_30) + ((s34_3.w - s34c_2.w) * tmpvar_29));
  highp vec2 tmpvar_32;
  tmpvar_32.x = -(tmpvar_25.y);
  tmpvar_32.y = tmpvar_25.x;
  highp vec2 tmpvar_33;
  tmpvar_33.x = -(tmpvar_31.y);
  tmpvar_33.y = tmpvar_31.x;
  highp vec2 z_34;
  z_34 = (tmpvar_15.x * tmpvar_22);
  highp vec2 tmpvar_35;
  tmpvar_35.x = -(z_34.y);
  tmpvar_35.y = z_34.x;
  highp vec2 z_36;
  z_36 = (tmpvar_16.x * tmpvar_25);
  highp vec2 tmpvar_37;
  tmpvar_37.x = -(z_36.y);
  tmpvar_37.y = z_36.x;
  highp vec2 z_38;
  z_38 = (tmpvar_17.x * tmpvar_28);
  highp vec2 tmpvar_39;
  tmpvar_39.x = -(z_38.y);
  tmpvar_39.y = z_38.x;
  highp vec2 z_40;
  z_40 = (tmpvar_18.x * tmpvar_31);
  highp vec2 tmpvar_41;
  tmpvar_41.x = -(z_40.y);
  tmpvar_41.y = z_40.x;
  highp vec4 tmpvar_42;
  tmpvar_42.xy = (tmpvar_22 + tmpvar_32);
  tmpvar_42.zw = (tmpvar_28 + tmpvar_33);
  highp vec4 tmpvar_43;
  tmpvar_43.xy = (tmpvar_35 - (tmpvar_15.y * tmpvar_22));
  tmpvar_43.zw = (tmpvar_37 - (tmpvar_16.y * tmpvar_25));
  highp vec4 tmpvar_44;
  tmpvar_44.xy = (tmpvar_39 - (tmpvar_17.y * tmpvar_28));
  tmpvar_44.zw = (tmpvar_41 - (tmpvar_18.y * tmpvar_31));
  _glesFragData[0] = tmpvar_42;
  _glesFragData[1] = tmpvar_43;
  _glesFragData[2] = tmpvar_44;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 115 math, 5 textures
Vector 0 [_Offset]
Vector 1 [_InverseGridSizes]
Float 2 [_T]
SetTexture 0 [_Spectrum01] 2D 0
SetTexture 1 [_Spectrum23] 2D 1
SetTexture 2 [_WTable] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c4, -0.50000000, -1.00000000, 0, 0
dcl_texcoord0 v0.xy
texld r4, v0, s2
add r5.xy, -v0, c0
mul r0.x, r4, c2
mad r0.y, r0.x, c3.x, c3
frc r0.z, r0.y
mad r0.z, r0, c3, c3.w
sincos r3.xy, r0.z
mul r0.w, r4.y, c2.x
mad r0.z, r0.w, c3.x, c3.y
texld r1, v0, s0
texld r2, r5, s0
add r0.y, r1, r2
frc r0.z, r0
add r0.x, r1, r2
mul r0.y, r0, r3
mad r3.z, r0.x, r3.x, -r0.y
mad r3.w, r0.z, c3.z, c3
sincos r0.xy, r3.w
add r0.z, r1.y, -r2.y
add r0.w, r1, -r2
mul r1.y, r0.w, r0.x
add r0.w, r1.z, -r2.z
mad r4.x, r0.w, r0.y, r1.y
mul r0.w, r3.x, r0.z
add r0.z, r1.x, -r2.x
mad r3.w, r3.y, r0.z, r0
add r0.w, r1, r2
add r0.z, r1, r2
mul r1.y, r4.z, c2.x
mul r0.y, r0, r0.w
mad r1.y, r1, c3.x, c3
frc r0.w, r1.y
mad r4.z, r0.x, r0, -r0.y
mad r1.z, r0.w, c3, c3.w
sincos r0.xy, r1.z
texld r2, r5, s1
mov r1.x, -r4
mov r1.y, r4.z
add oC0.xy, r3.zwzw, r1
texld r1, v0, s1
add r0.z, r1.y, r2.y
mul r0.w, r0.z, r0.y
add r0.z, r1.x, r2.x
mad r3.x, r0.z, r0, -r0.w
mul r0.w, r4, c2.x
add r0.z, r1.x, -r2.x
mad r1.x, r0.w, c3, c3.y
add r0.w, r1.y, -r2.y
mul r0.x, r0, r0.w
frc r1.x, r1
mad r3.y, r0, r0.z, r0.x
mad r1.x, r1, c3.z, c3.w
sincos r0.xy, r1.x
add r0.z, r1.w, -r2.w
mul r0.w, r0.z, r0.x
add r0.z, r1, -r2
mad r4.y, r0.z, r0, r0.w
add r1.x, r1.w, r2.w
mul r0.z, r0.y, r1.x
add r0.y, r1.z, r2.z
mad r5.x, r0, r0.y, -r0.z
mov r0.x, -r4.y
mov r0.y, r5.x
add r0.w, v0.x, c4.y
add r0.z, v0.x, c4.x
cmp r0.z, -r0, v0.x, r0.w
add r1.x, v0.y, c4.y
add r0.w, v0.y, c4.x
cmp r0.w, -r0, v0.y, r1.x
mul r1.xy, r0.zwzw, c1.y
mov r4.w, r4.x
mul r1.zw, r1.x, r4
mul r2.zw, r0, c1.x
add oC0.zw, r3.xyxy, r0.xyxy
mul r0.xy, r3.zwzw, r2.z
mov r2.y, r0.x
mov r2.x, -r0.y
mov r0.x, -r1.w
mov r0.y, r1.z
mul r1.zw, r0, c1.z
mad oC1.zw, -r1.y, r4, r0.xyxy
mul r0.xy, r3, r1.z
mad oC1.xy, r3.zwzw, -r2.w, r2
mov r5.y, r4
mul r0.zw, r0, c1.w
mul r1.xy, r0.z, r5
mov r2.y, r0.x
mov r2.x, -r0.y
mov r0.y, r1.x
mov r0.x, -r1.y
mad oC2.xy, r3, -r1.w, r2
mad oC2.zw, -r0.w, r5.xyxy, r0.xyxy
"
}
SubProgram "d3d11 " {
// Stats: 42 math, 5 textures
SetTexture 0 [_Spectrum01] 2D 0
SetTexture 1 [_Spectrum23] 2D 1
SetTexture 2 [_WTable] 2D 2
ConstBuffer "$Globals" 64
Vector 16 [_Offset]
Vector 32 [_InverseGridSizes]
Float 48 [_T]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbamjldgfodjjmkmfjpgiecooihiphdbdabaaaaaabeaiaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcceahaaaaeaaaaaaamjabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacaiaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajdcaabaaa
abaaaaaaegbabaiaebaaaaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaa
adaaaaaaenaaaaahbcaabaaaaeaaaaaabcaabaaaafaaaaaabkaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaaakaabaaaafaaaaaadcaaaaaj
ecaabaaaagaaaaaackaabaaaadaaaaaaakaabaaaaeaaaaaabkaabaaaacaaaaaa
dgaaaaagbcaabaaaagaaaaaackaabaiaebaaaaaaagaaaaaaenaaaaahbcaabaaa
acaaaaaabcaabaaaahaaaaaaakaabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaacaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaahaaaaaabkaabaiaebaaaaaaaaaaaaaadiaaaaahccaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaahaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaeaaaaaadcaaaaakccaabaaaagaaaaaa
ckaabaaaaaaaaaaaakaabaaaafaaaaaadkaabaiaebaaaaaaaaaaaaaaaaaaaaah
dccabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaagaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaai
pcaabaaaaeaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaenaaaaahbcaabaaa
acaaaaaabcaabaaaadaaaaaadkaabaaaacaaaaaaenaaaaahbcaabaaaafaaaaaa
bcaabaaaagaaaaaackaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaa
adaaaaaadkaabaaaaeaaaaaadcaaaaajecaabaaaahaaaaaackaabaaaaeaaaaaa
akaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaagbcaabaaaahaaaaaackaabaia
ebaaaaaaahaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaa
afaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaagaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaaeaaaaaa
akaabaaaagaaaaaadcaaaaajccaabaaaabaaaaaaakaabaaaaeaaaaaaakaabaaa
afaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadcaaaaakccaabaaaahaaaaaackaabaaaabaaaaaaakaabaaa
adaaaaaackaabaiaebaaaaaaaaaaaaaaaaaaaaahmccabaaaaaaaaaaaagaebaaa
abaaaaaaagaebaaaahaaaaaadbaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaadpegbebaaaabaaaaaaaaaaaaakpcaabaaaadaaaaaa
egbebaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaialpdhaaaaaj
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaegbebaaaabaaaaaa
diaaaaaipcaabaaaadaaaaaaogaobaaaacaaaaaaagifcaaaaaaaaaaaacaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaakgipcaaaaaaaaaaaacaaaaaa
diaaaaahdcaabaaaaeaaaaaaegaabaaaaaaaaaaaagaabaaaadaaaaaadgaaaaag
ecaabaaaaeaaaaaabkaabaiaebaaaaaaaeaaaaaadcaaaaakdccabaaaabaaaaaa
fgafbaiaebaaaaaaadaaaaaaegaabaaaaaaaaaaacgakbaaaaeaaaaaadiaaaaah
dcaabaaaaaaaaaaajgafbaaaagaaaaaakgakbaaaadaaaaaadgaaaaagecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakmccabaaaabaaaaaapgapbaia
ebaaaaaaadaaaaaafgajbaaaagaaaaaakgacbaaaaaaaaaaadiaaaaahdcaabaaa
aaaaaaaaegaabaaaabaaaaaaagaabaaaacaaaaaadgaaaaagecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaadcaaaaakdccabaaaacaaaaaafgafbaiaebaaaaaa
acaaaaaaegaabaaaabaaaaaacgakbaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaa
jgafbaaaahaaaaaakgakbaaaacaaaaaadgaaaaagecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakmccabaaaacaaaaaapgapbaiaebaaaaaaacaaaaaa
fgajbaaaahaaaaaakgacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
}