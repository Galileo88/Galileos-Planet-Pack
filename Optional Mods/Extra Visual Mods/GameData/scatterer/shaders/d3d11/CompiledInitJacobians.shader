// Compiled shader for all platforms, uncompressed size: 32.4KB

Shader "Proland/Ocean/InitJacobians" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 42 math, 5 texture
 //        d3d9 : 117 math, 5 texture
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
    float K1 = length(k1);
    float K2 = length(k2);
    float K3 = length(k3);
    float K4 = length(k4);
    #line 81
    float IK1 = (( (K1 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K1) ));
    float IK2 = (( (K2 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K2) ));
    float IK3 = (( (K3 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K3) ));
    float IK4 = (( (K4 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K4) ));
    #line 86
    vec4 w = texture2D( _WTable, uv);
    vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 90
    vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    #line 94
    vec4 IK = vec4( IK1, IK2, IK3, IK4);
    vec2 k1Squared = (k1 * k1);
    vec2 k2Squared = (k2 * k2);
    vec2 k3Squared = (k3 * k3);
    #line 98
    vec2 k4Squared = (k4 * k4);
    #line 103
    vec4 tmp = vec4( h1.x, h2.x, h3.x, h4.x);
    f2a OUT;
    #line 107
    OUT.col0 = ((-tmp) * (vec4( k1Squared.x, k2Squared.x, k3Squared.x, k4Squared.x) * IK));
    OUT.col1 = ((-tmp) * (vec4( k1Squared.y, k2Squared.y, k3Squared.y, k4Squared.y) * IK));
    OUT.col2 = ((-tmp) * (vec4( (k1.x * k1.y), (k2.x * k2.y), (k3.x * k3.y), (k4.x * k4.y)) * IK));
    #line 111
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
0:123(15): error: array index must be < 2
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
    highp float K1 = length(k1);
    highp float K2 = length(k2);
    highp float K3 = length(k3);
    highp float K4 = length(k4);
    #line 81
    highp float IK1 = (( (K1 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K1) ));
    highp float IK2 = (( (K2 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K2) ));
    highp float IK3 = (( (K3 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K3) ));
    highp float IK4 = (( (K4 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K4) ));
    #line 86
    highp vec4 w = texture2D( _WTable, uv);
    highp vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    highp vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 90
    highp vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    highp vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    #line 94
    highp vec4 IK = vec4( IK1, IK2, IK3, IK4);
    highp vec2 k1Squared = (k1 * k1);
    highp vec2 k2Squared = (k2 * k2);
    highp vec2 k3Squared = (k3 * k3);
    #line 98
    highp vec2 k4Squared = (k4 * k4);
    #line 103
    highp vec4 tmp = vec4( h1.x, h2.x, h3.x, h4.x);
    f2a OUT;
    #line 107
    OUT.col0 = ((-tmp) * (vec4( k1Squared.x, k2Squared.x, k3Squared.x, k4Squared.x) * IK));
    OUT.col1 = ((-tmp) * (vec4( k1Squared.y, k2Squared.y, k3Squared.y, k4Squared.y) * IK));
    OUT.col2 = ((-tmp) * (vec4( (k1.x * k1.y), (k2.x * k2.y), (k3.x * k3.y), (k4.x * k4.y)) * IK));
    #line 111
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
0:123(15): error: array index must be < 2
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
    highp float K1 = length(k1);
    highp float K2 = length(k2);
    highp float K3 = length(k3);
    highp float K4 = length(k4);
    #line 81
    highp float IK1 = (( (K1 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K1) ));
    highp float IK2 = (( (K2 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K2) ));
    highp float IK3 = (( (K3 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K3) ));
    highp float IK4 = (( (K4 == 0.0) ) ? ( 0.0 ) : ( (1.0 / K4) ));
    #line 86
    highp vec4 w = texture2D( _WTable, uv);
    highp vec2 h1 = GetSpectrum( w.x, s12.xy, s12c.xy);
    highp vec2 h2 = GetSpectrum( w.y, s12.zw, s12c.zw);
    #line 90
    highp vec2 h3 = GetSpectrum( w.z, s34.xy, s34c.xy);
    highp vec2 h4 = GetSpectrum( w.w, s34.zw, s34c.zw);
    #line 94
    highp vec4 IK = vec4( IK1, IK2, IK3, IK4);
    highp vec2 k1Squared = (k1 * k1);
    highp vec2 k2Squared = (k2 * k2);
    highp vec2 k3Squared = (k3 * k3);
    #line 98
    highp vec2 k4Squared = (k4 * k4);
    #line 103
    highp vec4 tmp = vec4( h1.x, h2.x, h3.x, h4.x);
    f2a OUT;
    #line 107
    OUT.col0 = ((-tmp) * (vec4( k1Squared.x, k2Squared.x, k3Squared.x, k4Squared.x) * IK));
    OUT.col1 = ((-tmp) * (vec4( k1Squared.y, k2Squared.y, k3Squared.y, k4Squared.y) * IK));
    OUT.col2 = ((-tmp) * (vec4( (k1.x * k1.y), (k2.x * k2.y), (k3.x * k3.y), (k4.x * k4.y)) * IK));
    #line 111
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
0:123(15): error: array index must be < 2
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
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_22;
  tmpvar_22 = sqrt(dot (tmpvar_18, tmpvar_18));
  highp float tmpvar_23;
  if ((tmpvar_19 == 0.0)) {
    tmpvar_23 = 0.0;
  } else {
    tmpvar_23 = (1.0/(tmpvar_19));
  };
  highp float tmpvar_24;
  if ((tmpvar_20 == 0.0)) {
    tmpvar_24 = 0.0;
  } else {
    tmpvar_24 = (1.0/(tmpvar_20));
  };
  highp float tmpvar_25;
  if ((tmpvar_21 == 0.0)) {
    tmpvar_25 = 0.0;
  } else {
    tmpvar_25 = (1.0/(tmpvar_21));
  };
  highp float tmpvar_26;
  if ((tmpvar_22 == 0.0)) {
    tmpvar_26 = 0.0;
  } else {
    tmpvar_26 = (1.0/(tmpvar_22));
  };
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture (_WTable, xlv_TEXCOORD0);
  w_1 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = cos((w_1.x * _T));
  highp float tmpvar_29;
  tmpvar_29 = sin((w_1.x * _T));
  highp vec2 tmpvar_30;
  tmpvar_30.x = (((s12_5.x + s12c_4.x) * tmpvar_28) - ((s12_5.y + s12c_4.y) * tmpvar_29));
  tmpvar_30.y = (((s12_5.x - s12c_4.x) * tmpvar_29) + ((s12_5.y - s12c_4.y) * tmpvar_28));
  highp float tmpvar_31;
  tmpvar_31 = cos((w_1.y * _T));
  highp float tmpvar_32;
  tmpvar_32 = sin((w_1.y * _T));
  highp vec2 tmpvar_33;
  tmpvar_33.x = (((s12_5.z + s12c_4.z) * tmpvar_31) - ((s12_5.w + s12c_4.w) * tmpvar_32));
  tmpvar_33.y = (((s12_5.z - s12c_4.z) * tmpvar_32) + ((s12_5.w - s12c_4.w) * tmpvar_31));
  highp float tmpvar_34;
  tmpvar_34 = cos((w_1.z * _T));
  highp float tmpvar_35;
  tmpvar_35 = sin((w_1.z * _T));
  highp vec2 tmpvar_36;
  tmpvar_36.x = (((s34_3.x + s34c_2.x) * tmpvar_34) - ((s34_3.y + s34c_2.y) * tmpvar_35));
  tmpvar_36.y = (((s34_3.x - s34c_2.x) * tmpvar_35) + ((s34_3.y - s34c_2.y) * tmpvar_34));
  highp float tmpvar_37;
  tmpvar_37 = cos((w_1.w * _T));
  highp float tmpvar_38;
  tmpvar_38 = sin((w_1.w * _T));
  highp vec2 tmpvar_39;
  tmpvar_39.x = (((s34_3.z + s34c_2.z) * tmpvar_37) - ((s34_3.w + s34c_2.w) * tmpvar_38));
  tmpvar_39.y = (((s34_3.z - s34c_2.z) * tmpvar_38) + ((s34_3.w - s34c_2.w) * tmpvar_37));
  highp vec4 tmpvar_40;
  tmpvar_40.x = tmpvar_23;
  tmpvar_40.y = tmpvar_24;
  tmpvar_40.z = tmpvar_25;
  tmpvar_40.w = tmpvar_26;
  highp vec2 tmpvar_41;
  tmpvar_41 = (tmpvar_15 * tmpvar_15);
  highp vec2 tmpvar_42;
  tmpvar_42 = (tmpvar_16 * tmpvar_16);
  highp vec2 tmpvar_43;
  tmpvar_43 = (tmpvar_17 * tmpvar_17);
  highp vec2 tmpvar_44;
  tmpvar_44 = (tmpvar_18 * tmpvar_18);
  highp vec4 tmpvar_45;
  tmpvar_45.x = tmpvar_30.x;
  tmpvar_45.y = tmpvar_33.x;
  tmpvar_45.z = tmpvar_36.x;
  tmpvar_45.w = tmpvar_39.x;
  highp vec4 tmpvar_46;
  tmpvar_46.x = tmpvar_41.x;
  tmpvar_46.y = tmpvar_42.x;
  tmpvar_46.z = tmpvar_43.x;
  tmpvar_46.w = tmpvar_44.x;
  highp vec4 tmpvar_47;
  tmpvar_47.x = tmpvar_41.y;
  tmpvar_47.y = tmpvar_42.y;
  tmpvar_47.z = tmpvar_43.y;
  tmpvar_47.w = tmpvar_44.y;
  highp vec4 tmpvar_48;
  tmpvar_48.x = (tmpvar_15.x * tmpvar_15.y);
  tmpvar_48.y = (tmpvar_16.x * tmpvar_16.y);
  tmpvar_48.z = (tmpvar_17.x * tmpvar_17.y);
  tmpvar_48.w = (tmpvar_18.x * tmpvar_18.y);
  highp vec4 tmpvar_49;
  tmpvar_49 = (-(tmpvar_45) * (tmpvar_46 * tmpvar_40));
  _glesFragData[0] = tmpvar_49;
  highp vec4 tmpvar_50;
  tmpvar_50 = (-(tmpvar_45) * (tmpvar_47 * tmpvar_40));
  _glesFragData[1] = tmpvar_50;
  highp vec4 tmpvar_51;
  tmpvar_51 = (-(tmpvar_45) * (tmpvar_48 * tmpvar_40));
  _glesFragData[2] = tmpvar_51;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 117 math, 5 textures
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
def c3, -0.50000000, -1.00000000, 0.00000000, 0
def c4, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
texld r4, v0, s2
add r0.y, v0.x, c3
add r0.x, v0, c3
cmp r0.x, -r0, v0, r0.y
add r0.z, v0.y, c3.y
add r0.y, v0, c3.x
cmp r0.y, -r0, v0, r0.z
mul r9.zw, r0.xyxy, c1.x
mul r9.xy, r0, c1.y
mul r10.zw, r9, r9
mul r10.xy, r9, r9
add r0.w, r10.x, r10.y
rsq r1.x, r0.w
rcp r1.y, r1.x
abs r1.y, r1
add r0.z, r10, r10.w
rsq r0.z, r0.z
rcp r0.w, r0.z
abs r0.w, r0
cmp r3.x, -r0.w, c3.z, r0.z
mul r0.zw, r0.xyxy, c1.z
mul r0.xy, r0, c1.w
mul r7.xzw, r0.xyyx, r0.xyyy
mul r8.xyz, r0.zwzw, r0.zwww
add r0.y, r7.x, r7.z
rsq r0.z, r0.y
rcp r0.w, r0.z
abs r0.w, r0
cmp r3.w, -r0, c3.z, r0.z
mov r0.w, r7.x
add r0.x, r8, r8.y
rsq r0.x, r0.x
rcp r0.y, r0.x
abs r0.y, r0
cmp r3.z, -r0.y, c3, r0.x
cmp r3.y, -r1, c3.z, r1.x
add r7.xy, -v0, c0
texld r1, r7, s0
mov r0.x, r10.z
mov r0.y, r10.x
mov r0.z, r8.x
mul r2, r0, r3
texld r0, v0, s0
add r0.y, r0, r1
mul r1.y, r4, c2.x
add r0.x, r0, r1
mul r4.x, r4, c2
mad r1.x, r4, c4, c4.y
frc r1.x, r1
mad r1.x, r1, c4.z, c4.w
sincos r6.xy, r1.x
mul r0.y, r0, r6
mad r4.x, r0, r6, -r0.y
mad r1.y, r1, c4.x, c4
frc r1.x, r1.y
mad r1.x, r1, c4.z, c4.w
sincos r5.xy, r1.x
add r0.x, r0.w, r1.w
mul r0.y, r0.x, r5
add r0.x, r0.z, r1.z
mad r4.y, r0.x, r5.x, -r0
texld r1, r7, s1
texld r0, v0, s1
add r0.y, r0, r1
mul r1.y, r4.w, c2.x
add r0.x, r0, r1
mul r4.z, r4, c2.x
mad r1.x, r4.z, c4, c4.y
frc r1.x, r1
mad r1.x, r1, c4.z, c4.w
sincos r6.xy, r1.x
mad r1.y, r1, c4.x, c4
frc r1.x, r1.y
mad r1.x, r1, c4.z, c4.w
mul r0.y, r0, r6
mad r4.z, r0.x, r6.x, -r0.y
add r0.x, r0.w, r1.w
sincos r5.xy, r1.x
mul r0.y, r0.x, r5
add r0.x, r0.z, r1.z
mad r4.w, r0.x, r5.x, -r0.y
mov r0.x, r10.w
mov r0.y, r10
mov r0.w, r7.z
mov r0.z, r8.y
mul r1, r3, r0
mul r0.x, r9.z, r9.w
mul r0.y, r9.x, r9
mov r0.w, r7
mov r0.z, r8
mul r0, r3, r0
mul oC0, -r4, r2
mul oC1, -r4, r1
mul oC2, -r4, r0
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
eefiecedanfbbidgkgdpoenkgahlmmmhcghiehfaabaaaaaalmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmmahaaaaeaaaaaaapdabaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacakaaaaaadbaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadpegbebaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdhaaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
egbebaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaogaobaaaaaaaaaaaagifcaaa
aaaaaaaaacaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaakgipcaaa
aaaaaaaaacaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaabiaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaaoaaaaakbcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaacaaaaaadhaaaaaj
bcaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaa
apaaaaahbcaabaaaadaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaabiaaaaahccaabaaaadaaaaaaakaabaaa
adaaaaaaabeaaaaaaaaaaaaaaoaaaaakbcaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaadhaaaaajccaabaaaacaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaaaaakaabaaaadaaaaaaapaaaaahbcaabaaa
adaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaafbcaabaaaadaaaaaa
akaabaaaadaaaaaabiaaaaahccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaaaaaaoaaaaakbcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaadaaaaaadhaaaaajecaabaaaacaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaaaaakaabaaaadaaaaaaapaaaaahbcaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaaaaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaa
biaaaaahccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaaoaaaaak
bcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaa
adaaaaaadhaaaaajicaabaaaacaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaaaa
akaabaaaadaaaaaadiaaaaahpcaabaaaadaaaaaangaibaaaabaaaaaangaibaaa
abaaaaaadiaaaaahdcaabaaaabaaaaaangafbaaaabaaaaaaigaabaaaabaaaaaa
dgaaaaafdcaabaaaaeaaaaaaogakbaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
egaobaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaahmcaabaaaabaaaaaafganbaaa
aaaaaaaaagaibaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaa
egaobaaaabaaaaaadgaaaaafmcaabaaaaeaaaaaaagaibaaaafaaaaaadgaaaaaf
mcaabaaaadaaaaaafganbaaaafaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaajdcaabaaaaeaaaaaaegbabaiaebaaaaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaa
afaaaaaaegaobaaaafaaaaaaagiacaaaaaaaaaaaadaaaaaaenaaaaahbcaabaaa
afaaaaaabcaabaaaagaaaaaaakaabaaaafaaaaaadiaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaafaaaaaadcaaaaakbcaabaaaagaaaaaaakaabaaa
adaaaaaaakaabaaaagaaaaaabkaabaiaebaaaaaaadaaaaaaenaaaaahbcaabaaa
adaaaaaabcaabaaaafaaaaaabkaabaaaafaaaaaadiaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaadkaabaaaadaaaaaadcaaaaakccaabaaaagaaaaaackaabaaa
adaaaaaaakaabaaaafaaaaaaakaabaiaebaaaaaaadaaaaaaenaaaaahbcaabaaa
adaaaaaabcaabaaaafaaaaaackaabaaaafaaaaaaenaaaaahbcaabaaaahaaaaaa
bcaabaaaaiaaaaaadkaabaaaafaaaaaaefaaaaajpcaabaaaajaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaajaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaabkaabaaaaeaaaaaadcaaaaakecaabaaaagaaaaaaakaabaaaaeaaaaaa
akaabaaaafaaaaaaakaabaiaebaaaaaaadaaaaaadiaaaaahbcaabaaaadaaaaaa
akaabaaaahaaaaaadkaabaaaaeaaaaaadcaaaaakicaabaaaagaaaaaackaabaaa
aeaaaaaaakaabaaaaiaaaaaaakaabaiaebaaaaaaadaaaaaadiaaaaaipccabaaa
aaaaaaaaegaobaaaacaaaaaaegaobaiaebaaaaaaagaaaaaadiaaaaaipccabaaa
abaaaaaaegaobaaaabaaaaaaegaobaiaebaaaaaaagaaaaaadiaaaaaipccabaaa
acaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaaagaaaaaadoaaaaab"
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