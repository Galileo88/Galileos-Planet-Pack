// Compiled shader for custom platforms, uncompressed size: 144.6KB

Shader "Math/Fourier" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 25 math, 3 texture, 1 branch
 //      opengl : 25 math, 3 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 29 math, 3 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 21355
Program "vp" {
SubProgram "opengl " {
// Stats: 25 math, 3 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 25 math, 3 textures, 1 branches
"!!GLES
#version 100

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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
highp vec2 t8;
bool tb12;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb12 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t8.x = t16_0.z / _Size;
    t1.x = sin(t8.x);
    t2 = cos(t8.x);
    t1.y = t2;
    t8.xy = (bool(tb12)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t10_1 = texture(_ReadBuffer0, t1.xz);
    t0.xy = vec2(t8.x * t10_2.y, t8.x * t10_2.w);
    t3.xz = t8.yy * t10_2.xz + (-t0.xy);
    t3.y = dot(t8.xy, t10_2.xy);
    t3.w = dot(t8.xy, t10_2.zw);
    SV_Target0 = t10_1 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
vec2 t8;
bool tb12;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb12 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t8.x = t16_0.z / _Size;
    t1.x = sin(t8.x);
    t2 = cos(t8.x);
    t1.y = t2;
    t8.xy = (bool(tb12)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t10_1 = texture(_ReadBuffer0, t1.xz);
    t0.xy = t8.xx * t10_2.yw;
    t3.xz = t8.yy * t10_2.xz + (-t0.xy);
    t3.y = dot(t8.xy, t10_2.xy);
    t3.w = dot(t8.xy, t10_2.zw);
    SV_Target0 = t10_1 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ButterFlyLookUp] 2D 1
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.x
texld r1, r0.yzzw, s1
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.y
texld r2, r1.yzzw, s0
texld r1, r1.xzzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
add oC0, r1, r3

"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_ButterFlyLookUp] 2D 1
SetTexture 1 [_ReadBuffer0] 2D 0
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:acabacaa
eefiecedonciaoohnagckgnehnnaolaonlebicldabaaaaaagmadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmacaaaa
eaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaacaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 25 math, 3 texture, 1 branch
 //      opengl : 25 math, 3 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 29 math, 3 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 80619
Program "vp" {
SubProgram "opengl " {
// Stats: 25 math, 3 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 25 math, 3 textures, 1 branches
"!!GLES
#version 100

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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
highp vec2 t8;
bool tb12;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb12 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t8.x = t16_0.z / _Size;
    t1.x = sin(t8.x);
    t2 = cos(t8.x);
    t1.y = t2;
    t8.xy = (bool(tb12)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t10_1 = texture(_ReadBuffer0, t1.zx);
    t0.xy = vec2(t8.x * t10_2.y, t8.x * t10_2.w);
    t3.xz = t8.yy * t10_2.xz + (-t0.xy);
    t3.y = dot(t8.xy, t10_2.xy);
    t3.w = dot(t8.xy, t10_2.zw);
    SV_Target0 = t10_1 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
vec2 t8;
bool tb12;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb12 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t8.x = t16_0.z / _Size;
    t1.x = sin(t8.x);
    t2 = cos(t8.x);
    t1.y = t2;
    t8.xy = (bool(tb12)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t10_1 = texture(_ReadBuffer0, t1.zx);
    t0.xy = t8.xx * t10_2.yw;
    t3.xz = t8.yy * t10_2.xz + (-t0.xy);
    t3.y = dot(t8.xy, t10_2.xy);
    t3.w = dot(t8.xy, t10_2.zw);
    SV_Target0 = t10_1 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 29 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ButterFlyLookUp] 2D 1
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.y
texld r1, r0.yzzw, s1
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.x
texld r2, r1.zyzw, s0
texld r1, r1.zxzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
add oC0, r1, r3

"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_ButterFlyLookUp] 2D 1
SetTexture 1 [_ReadBuffer0] 2D 0
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:acabacaa
eefiecedpnclgkphepepeonemdliaedgefegkpijabaaaaaagmadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmacaaaa
eaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaacaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 38 math, 5 texture, 1 branch
 //      opengl : 38 math, 5 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 15 math, 5 texture
 //        d3d9 : 36 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 155202
Program "vp" {
SubProgram "opengl " {
// Stats: 38 math, 5 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReadBuffer1, tmpvar_7);
  vec4 tmpvar_11;
  tmpvar_11.x = ((w_1.x * tmpvar_10.x) - (w_1.y * tmpvar_10.y));
  tmpvar_11.y = ((w_1.y * tmpvar_10.x) + (w_1.x * tmpvar_10.y));
  tmpvar_11.z = ((w_1.x * tmpvar_10.z) - (w_1.y * tmpvar_10.w));
  tmpvar_11.w = ((w_1.y * tmpvar_10.z) + (w_1.x * tmpvar_10.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
  gl_FragData[1] = (texture2D (_ReadBuffer1, tmpvar_6) + tmpvar_11);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 38 math, 5 textures, 1 branches
"!!GLES
#version 100

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
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
uniform lowp sampler2D _ReadBuffer1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
lowp vec4 t10_4;
highp vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t0.xy = vec2(t10.x * t10_2.y, t10.x * t10_2.w);
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.xz);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.xz);
    t10_1 = texture(_ReadBuffer1, t1.yz);
    t0.xy = vec2(t10.x * t10_1.y, t10.x * t10_1.w);
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target1 = t10_2 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
uniform  sampler2D _ReadBuffer1;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
lowp vec4 t10_4;
vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t0.xy = t10.xx * t10_2.yw;
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.xz);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.xz);
    t10_1 = texture(_ReadBuffer1, t1.yz);
    t0.xy = t10.xx * t10_1.yw;
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target1 = t10_2 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 36 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ReadBuffer1] 2D 1
SetTexture 2 [_ButterFlyLookUp] 2D 2
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.x
texld r1, r0.yzzw, s2
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.y
texld r2, r1.yzzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
texld r2, r1.xzzw, s0
add oC0, r3, r2
texld r2, r1.xzzw, s1
texld r1, r1.yzzw, s1
mul r0.yz, r0.x, r1.xyww
mad r3.xz, r0.w, r1, -r0.yyzw
dp2add r3.y, r0.xwzw, r1, c1.y
dp2add r3.w, r0.xwzw, r1.zwzw, c1.y
add oC1, r2, r3

"
}
SubProgram "d3d11 " {
// Stats: 15 math, 5 textures
SetTexture 0 [_ButterFlyLookUp] 2D 2
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:adabadaa
eefiecedfkcopeplidmeijjmolibckelindnkiedabaaaaaaimaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 38 math, 5 texture, 1 branch
 //      opengl : 38 math, 5 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 15 math, 5 texture
 //        d3d9 : 36 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 241359
Program "vp" {
SubProgram "opengl " {
// Stats: 38 math, 5 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReadBuffer1, tmpvar_7);
  vec4 tmpvar_11;
  tmpvar_11.x = ((w_1.x * tmpvar_10.x) - (w_1.y * tmpvar_10.y));
  tmpvar_11.y = ((w_1.y * tmpvar_10.x) + (w_1.x * tmpvar_10.y));
  tmpvar_11.z = ((w_1.x * tmpvar_10.z) - (w_1.y * tmpvar_10.w));
  tmpvar_11.w = ((w_1.y * tmpvar_10.z) + (w_1.x * tmpvar_10.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
  gl_FragData[1] = (texture2D (_ReadBuffer1, tmpvar_6) + tmpvar_11);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 38 math, 5 textures, 1 branches
"!!GLES
#version 100

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
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
uniform lowp sampler2D _ReadBuffer1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
lowp vec4 t10_4;
highp vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t0.xy = vec2(t10.x * t10_2.y, t10.x * t10_2.w);
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.zx);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.zx);
    t10_1 = texture(_ReadBuffer1, t1.zy);
    t0.xy = vec2(t10.x * t10_1.y, t10.x * t10_1.w);
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target1 = t10_2 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
uniform  sampler2D _ReadBuffer1;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
lowp vec4 t10_4;
vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t0.xy = t10.xx * t10_2.yw;
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.zx);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.zx);
    t10_1 = texture(_ReadBuffer1, t1.zy);
    t0.xy = t10.xx * t10_1.yw;
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target1 = t10_2 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 36 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ReadBuffer1] 2D 1
SetTexture 2 [_ButterFlyLookUp] 2D 2
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.y
texld r1, r0.yzzw, s2
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.x
texld r2, r1.zyzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
texld r2, r1.zxzw, s0
add oC0, r3, r2
texld r2, r1.zxzw, s1
texld r1, r1.zyzw, s1
mul r0.yz, r0.x, r1.xyww
mad r3.xz, r0.w, r1, -r0.yyzw
dp2add r3.y, r0.xwzw, r1, c1.y
dp2add r3.w, r0.xwzw, r1.zwzw, c1.y
add oC1, r2, r3

"
}
SubProgram "d3d11 " {
// Stats: 15 math, 5 textures
SetTexture 0 [_ButterFlyLookUp] 2D 2
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:adabadaa
eefiecedgambknnekldohlkjcfebdefjhgpmmofeabaaaaaaimaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 51 math, 7 texture, 1 branch
 //      opengl : 51 math, 7 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 7 texture
 //        d3d9 : 43 math, 7 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 263204
Program "vp" {
SubProgram "opengl " {
// Stats: 51 math, 7 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReadBuffer1, tmpvar_7);
  vec4 tmpvar_11;
  tmpvar_11.x = ((w_1.x * tmpvar_10.x) - (w_1.y * tmpvar_10.y));
  tmpvar_11.y = ((w_1.y * tmpvar_10.x) + (w_1.x * tmpvar_10.y));
  tmpvar_11.z = ((w_1.x * tmpvar_10.z) - (w_1.y * tmpvar_10.w));
  tmpvar_11.w = ((w_1.y * tmpvar_10.z) + (w_1.x * tmpvar_10.w));
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReadBuffer2, tmpvar_7);
  vec4 tmpvar_13;
  tmpvar_13.x = ((w_1.x * tmpvar_12.x) - (w_1.y * tmpvar_12.y));
  tmpvar_13.y = ((w_1.y * tmpvar_12.x) + (w_1.x * tmpvar_12.y));
  tmpvar_13.z = ((w_1.x * tmpvar_12.z) - (w_1.y * tmpvar_12.w));
  tmpvar_13.w = ((w_1.y * tmpvar_12.z) + (w_1.x * tmpvar_12.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
  gl_FragData[1] = (texture2D (_ReadBuffer1, tmpvar_6) + tmpvar_11);
  gl_FragData[2] = (texture2D (_ReadBuffer2, tmpvar_6) + tmpvar_13);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 51 math, 7 textures, 1 branches
"!!GLES
#version 100

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
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReadBuffer2, tmpvar_6);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ReadBuffer2, tmpvar_7);
  highp vec4 input1_20;
  input1_20 = tmpvar_18;
  highp vec4 input2_21;
  input2_21 = tmpvar_19;
  highp vec4 tmpvar_22;
  tmpvar_22.x = ((w_1.x * input2_21.x) - (w_1.y * input2_21.y));
  tmpvar_22.y = ((w_1.y * input2_21.x) + (w_1.x * input2_21.y));
  tmpvar_22.z = ((w_1.x * input2_21.z) - (w_1.y * input2_21.w));
  tmpvar_22.w = ((w_1.y * input2_21.z) + (w_1.x * input2_21.w));
  highp vec4 tmpvar_23;
  tmpvar_23 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (input1_20 + tmpvar_22);
  gl_FragData[2] = tmpvar_25;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
uniform lowp sampler2D _ReadBuffer1;
uniform lowp sampler2D _ReadBuffer2;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
layout(location = 2) out highp vec4 SV_Target2;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
lowp vec4 t10_3;
highp vec4 t4;
lowp vec4 t10_4;
highp vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t0.xy = vec2(t10.x * t10_2.y, t10.x * t10_2.w);
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.xz);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.xz);
    t10_3 = texture(_ReadBuffer1, t1.yz);
    t0.xy = vec2(t10.x * t10_3.y, t10.x * t10_3.w);
    t4.xz = t10.yy * t10_3.xz + (-t0.xy);
    t4.y = dot(t10.xy, t10_3.xy);
    t4.w = dot(t10.xy, t10_3.zw);
    SV_Target1 = t10_2 + t4;
    t10_2 = texture(_ReadBuffer2, t1.xz);
    t10_1 = texture(_ReadBuffer2, t1.yz);
    t0.xy = vec2(t10.x * t10_1.y, t10.x * t10_1.w);
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target2 = t10_2 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
uniform  sampler2D _ReadBuffer1;
uniform  sampler2D _ReadBuffer2;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
out vec4 SV_Target2;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
lowp vec4 t10_3;
vec4 t4;
lowp vec4 t10_4;
vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.x;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.y;
    t10_2 = texture(_ReadBuffer0, t1.yz);
    t0.xy = t10.xx * t10_2.yw;
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.xz);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.xz);
    t10_3 = texture(_ReadBuffer1, t1.yz);
    t0.xy = t10.xx * t10_3.yw;
    t4.xz = t10.yy * t10_3.xz + (-t0.xy);
    t4.y = dot(t10.xy, t10_3.xy);
    t4.w = dot(t10.xy, t10_3.zw);
    SV_Target1 = t10_2 + t4;
    t10_2 = texture(_ReadBuffer2, t1.xz);
    t10_1 = texture(_ReadBuffer2, t1.yz);
    t0.xy = t10.xx * t10_1.yw;
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target2 = t10_2 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 43 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ReadBuffer1] 2D 1
SetTexture 2 [_ReadBuffer2] 2D 2
SetTexture 3 [_ButterFlyLookUp] 2D 3
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.x
texld r1, r0.yzzw, s3
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.y
texld r2, r1.yzzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
texld r2, r1.xzzw, s0
add oC0, r3, r2
texld r2, r1.xzzw, s1
texld r3, r1.yzzw, s1
mul r0.yz, r0.x, r3.xyww
mad r4.xz, r0.w, r3, -r0.yyzw
dp2add r4.y, r0.xwzw, r3, c1.y
dp2add r4.w, r0.xwzw, r3.zwzw, c1.y
add oC1, r2, r4
texld r2, r1.xzzw, s2
texld r1, r1.yzzw, s2
mul r0.yz, r0.x, r1.xyww
mad r3.xz, r0.w, r1, -r0.yyzw
dp2add r3.y, r0.xwzw, r1, c1.y
dp2add r3.w, r0.xwzw, r1.zwzw, c1.y
add oC2, r2, r3

"
}
SubProgram "d3d11 " {
// Stats: 20 math, 7 textures
SetTexture 0 [_ButterFlyLookUp] 2D 3
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
SetTexture 3 [_ReadBuffer2] 2D 2
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:aeabaeaa
eefiecedjdloofiggfikcpmpfjmnflcpbonphacbabaaaaaakmafaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmaeaaaaeaaaaaaacpabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaadaaaaaadcaaaaakfcaabaaaaeaaaaaapgapbaaaaaaaaaaa
agacbaaaadaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaaeaaaaaa
ogakbaaaaaaaaaaaegaabaaaadaaaaaaapaaaaahicaabaaaaeaaaaaaogakbaaa
aaaaaaaaogakbaaaadaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 51 math, 7 texture, 1 branch
 //      opengl : 51 math, 7 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 7 texture
 //        d3d9 : 43 math, 7 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 343595
Program "vp" {
SubProgram "opengl " {
// Stats: 51 math, 7 textures, 1 branches
"!!GLSL#version 120

#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform float _Size;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 w_1;
  vec4 lookUp_2;
  vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2.w = tmpvar_4.w;
  lookUp_2.xyz = (tmpvar_4.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((tmpvar_4.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_7);
  vec4 tmpvar_9;
  tmpvar_9.x = ((w_1.x * tmpvar_8.x) - (w_1.y * tmpvar_8.y));
  tmpvar_9.y = ((w_1.y * tmpvar_8.x) + (w_1.x * tmpvar_8.y));
  tmpvar_9.z = ((w_1.x * tmpvar_8.z) - (w_1.y * tmpvar_8.w));
  tmpvar_9.w = ((w_1.y * tmpvar_8.z) + (w_1.x * tmpvar_8.w));
  vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReadBuffer1, tmpvar_7);
  vec4 tmpvar_11;
  tmpvar_11.x = ((w_1.x * tmpvar_10.x) - (w_1.y * tmpvar_10.y));
  tmpvar_11.y = ((w_1.y * tmpvar_10.x) + (w_1.x * tmpvar_10.y));
  tmpvar_11.z = ((w_1.x * tmpvar_10.z) - (w_1.y * tmpvar_10.w));
  tmpvar_11.w = ((w_1.y * tmpvar_10.z) + (w_1.x * tmpvar_10.w));
  vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ReadBuffer2, tmpvar_7);
  vec4 tmpvar_13;
  tmpvar_13.x = ((w_1.x * tmpvar_12.x) - (w_1.y * tmpvar_12.y));
  tmpvar_13.y = ((w_1.y * tmpvar_12.x) + (w_1.x * tmpvar_12.y));
  tmpvar_13.z = ((w_1.x * tmpvar_12.z) - (w_1.y * tmpvar_12.w));
  tmpvar_13.w = ((w_1.y * tmpvar_12.z) + (w_1.x * tmpvar_12.w));
  gl_FragData[0] = (texture2D (_ReadBuffer0, tmpvar_6) + tmpvar_9);
  gl_FragData[1] = (texture2D (_ReadBuffer1, tmpvar_6) + tmpvar_11);
  gl_FragData[2] = (texture2D (_ReadBuffer2, tmpvar_6) + tmpvar_13);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
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
// Stats: 51 math, 7 textures, 1 branches
"!!GLES
#version 100

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
#extension GL_EXT_draw_buffers : enable
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.283186 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.283186 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = -(tmpvar_5);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ReadBuffer2, tmpvar_6);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ReadBuffer2, tmpvar_7);
  highp vec4 input1_20;
  input1_20 = tmpvar_18;
  highp vec4 input2_21;
  input2_21 = tmpvar_19;
  highp vec4 tmpvar_22;
  tmpvar_22.x = ((w_1.x * input2_21.x) - (w_1.y * input2_21.y));
  tmpvar_22.y = ((w_1.y * input2_21.x) + (w_1.x * input2_21.y));
  tmpvar_22.z = ((w_1.x * input2_21.z) - (w_1.y * input2_21.w));
  tmpvar_22.w = ((w_1.y * input2_21.z) + (w_1.x * input2_21.w));
  highp vec4 tmpvar_23;
  tmpvar_23 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (input1_20 + tmpvar_22);
  gl_FragData[2] = tmpvar_25;
}


#endif
"
}
SubProgram "gles3 " {
"!!GLES3
#ifdef VERTEX
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	mediump vec4 unity_SHAr;
uniform 	mediump vec4 unity_SHAg;
uniform 	mediump vec4 unity_SHAb;
uniform 	mediump vec4 unity_SHBr;
uniform 	mediump vec4 unity_SHBg;
uniform 	mediump vec4 unity_SHBb;
uniform 	mediump vec4 unity_SHC;
uniform 	mediump vec3 unity_LightColor0;
uniform 	mediump vec3 unity_LightColor1;
uniform 	mediump vec3 unity_LightColor2;
uniform 	mediump vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	mediump vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	lowp vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	lowp vec4 unity_AmbientSky;
uniform 	lowp vec4 unity_AmbientEquator;
uniform 	lowp vec4 unity_AmbientGround;
uniform 	lowp vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	mediump vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	mediump vec4 unity_SpecCube1_HDR;
uniform 	lowp vec4 unity_ColorSpaceGrey;
uniform 	lowp vec4 unity_ColorSpaceDouble;
uniform 	mediump vec4 unity_ColorSpaceDielectricSpec;
uniform 	mediump vec4 unity_ColorSpaceLuminance;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform lowp sampler2D _ButterFlyLookUp;
uniform lowp sampler2D _ReadBuffer0;
uniform lowp sampler2D _ReadBuffer1;
uniform lowp sampler2D _ReadBuffer2;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
layout(location = 2) out highp vec4 SV_Target2;
highp vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
highp vec3 t1;
lowp vec4 t10_1;
highp float t2;
lowp vec4 t10_2;
highp vec4 t3;
lowp vec4 t10_3;
highp vec4 t4;
lowp vec4 t10_4;
highp vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t0.xy = vec2(t10.x * t10_2.y, t10.x * t10_2.w);
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.zx);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.zx);
    t10_3 = texture(_ReadBuffer1, t1.zy);
    t0.xy = vec2(t10.x * t10_3.y, t10.x * t10_3.w);
    t4.xz = t10.yy * t10_3.xz + (-t0.xy);
    t4.y = dot(t10.xy, t10_3.xy);
    t4.w = dot(t10.xy, t10_3.zw);
    SV_Target1 = t10_2 + t4;
    t10_2 = texture(_ReadBuffer2, t1.zx);
    t10_1 = texture(_ReadBuffer2, t1.zy);
    t0.xy = vec2(t10.x * t10_1.y, t10.x * t10_1.w);
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target2 = t10_2 + t3;
    return;
}

#endif
"
}
SubProgram "glcore " {
"!!GL3x
#ifdef VERTEX
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 unity_DeltaTime;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ScreenParams;
uniform 	vec4 _ZBufferParams;
uniform 	vec4 unity_OrthoParams;
uniform 	vec4 unity_CameraWorldClipPlanes[6];
uniform 	mat4 unity_CameraProjection;
uniform 	mat4 unity_CameraInvProjection;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	vec4 unity_4LightAtten0;
uniform 	vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 unity_SHAr;
uniform 	vec4 unity_SHAg;
uniform 	vec4 unity_SHAb;
uniform 	vec4 unity_SHBr;
uniform 	vec4 unity_SHBg;
uniform 	vec4 unity_SHBb;
uniform 	vec4 unity_SHC;
uniform 	vec3 unity_LightColor0;
uniform 	vec3 unity_LightColor1;
uniform 	vec3 unity_LightColor2;
uniform 	vec3 unity_LightColor3;
uniform 	vec4 unity_ShadowSplitSpheres[4];
uniform 	vec4 unity_ShadowSplitSqRadii;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 _LightSplitsNear;
uniform 	vec4 _LightSplitsFar;
uniform 	mat4 unity_World2Shadow[4];
uniform 	vec4 _LightShadowData;
uniform 	vec4 unity_ShadowFadeCenterAndType;
uniform 	mat4 glstate_matrix_mvp;
uniform 	mat4 glstate_matrix_modelview0;
uniform 	mat4 glstate_matrix_invtrans_modelview0;
uniform 	mat4 _Object2World;
uniform 	mat4 _World2Object;
uniform 	vec4 unity_LODFade;
uniform 	vec4 unity_WorldTransformParams;
uniform 	mat4 glstate_matrix_transpose_modelview0;
uniform 	mat4 glstate_matrix_projection;
uniform 	vec4 glstate_lightmodel_ambient;
uniform 	mat4 unity_MatrixV;
uniform 	mat4 unity_MatrixVP;
uniform 	vec4 unity_AmbientSky;
uniform 	vec4 unity_AmbientEquator;
uniform 	vec4 unity_AmbientGround;
uniform 	vec4 unity_FogColor;
uniform 	vec4 unity_FogParams;
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_DynamicLightmapST;
uniform 	vec4 unity_SpecCube0_BoxMax;
uniform 	vec4 unity_SpecCube0_BoxMin;
uniform 	vec4 unity_SpecCube0_ProbePosition;
uniform 	vec4 unity_SpecCube0_HDR;
uniform 	vec4 unity_SpecCube1_BoxMax;
uniform 	vec4 unity_SpecCube1_BoxMin;
uniform 	vec4 unity_SpecCube1_ProbePosition;
uniform 	vec4 unity_SpecCube1_HDR;
uniform 	vec4 unity_ColorSpaceGrey;
uniform 	vec4 unity_ColorSpaceDouble;
uniform 	vec4 unity_ColorSpaceDielectricSpec;
uniform 	vec4 unity_ColorSpaceLuminance;
uniform 	vec4 unity_Lightmap_HDR;
uniform 	vec4 unity_DynamicLightmap_HDR;
uniform 	float _Size;
uniform  sampler2D _ButterFlyLookUp;
uniform  sampler2D _ReadBuffer0;
uniform  sampler2D _ReadBuffer1;
uniform  sampler2D _ReadBuffer2;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
out vec4 SV_Target2;
vec2 t0;
mediump vec3 t16_0;
lowp vec4 t10_0;
vec3 t1;
lowp vec4 t10_1;
float t2;
lowp vec4 t10_2;
vec4 t3;
lowp vec4 t10_3;
vec4 t4;
lowp vec4 t10_4;
vec2 t10;
bool tb15;
void main()
{
    t0.x = vs_TEXCOORD0.y;
    t0.y = 0.0;
    t10_0 = texture(_ButterFlyLookUp, t0.xy);
    tb15 = 0.5<t10_0.w;
    t16_0.xyz = t10_0.xyz * vec3(255.0, 255.0, 1602.21216);
    t10.x = t16_0.z / _Size;
    t1.x = sin(t10.x);
    t2 = cos(t10.x);
    t1.y = t2;
    t10.xy = (bool(tb15)) ? (-t1.xy) : t1.xy;
    t1.x = _Size + -1.0;
    t1.xy = t16_0.xy / t1.xx;
    t1.z = vs_TEXCOORD0.x;
    t10_2 = texture(_ReadBuffer0, t1.zy);
    t0.xy = t10.xx * t10_2.yw;
    t3.xz = t10.yy * t10_2.xz + (-t0.xy);
    t10_4 = texture(_ReadBuffer0, t1.zx);
    t3.y = dot(t10.xy, t10_2.xy);
    t3.w = dot(t10.xy, t10_2.zw);
    SV_Target0 = t3 + t10_4;
    t10_2 = texture(_ReadBuffer1, t1.zx);
    t10_3 = texture(_ReadBuffer1, t1.zy);
    t0.xy = t10.xx * t10_3.yw;
    t4.xz = t10.yy * t10_3.xz + (-t0.xy);
    t4.y = dot(t10.xy, t10_3.xy);
    t4.w = dot(t10.xy, t10_3.zw);
    SV_Target1 = t10_2 + t4;
    t10_2 = texture(_ReadBuffer2, t1.zx);
    t10_1 = texture(_ReadBuffer2, t1.zy);
    t0.xy = t10.xx * t10_1.yw;
    t3.xz = t10.yy * t10_1.xz + (-t0.xy);
    t3.y = dot(t10.xy, t10_1.xy);
    t3.w = dot(t10.xy, t10_1.zw);
    SV_Target2 = t10_2 + t3;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 43 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ReadBuffer0] 2D 0
SetTexture 1 [_ReadBuffer1] 2D 1
SetTexture 2 [_ReadBuffer2] 2D 2
SetTexture 3 [_ButterFlyLookUp] 2D 3
"ps_3_0
def c1, 1, 0, 255, 1602.21216
def c2, 0.159154937, 0.5, 6.28318548, -3.14159274
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
rcp r0.x, c0.x
mul r0.yz, c1.xxyw, v0.y
texld r1, r0.yzzw, s3
mul r0.yzw, r1.xxyz, c1.xzzw
add r1.x, -r1.w, c2.y
mul r0.x, r0.x, r0.w
mad r0.x, r0.x, c2.x, c2.y
frc r0.x, r0.x
mad r0.x, r0.x, c2.z, c2.w
sincos r2.xy, r0.x
cmp r0.xw, r1.x, r2.yyzx, -r2.yyzx
mov r1.x, c1.x
add r1.x, -r1.x, c0.x
rcp r1.x, r1.x
mul r1.xy, r0.yzzw, r1.x
mov r1.z, v0.x
texld r2, r1.zyzw, s0
mul r0.yz, r0.x, r2.xyww
mad r3.xz, r0.w, r2, -r0.yyzw
dp2add r3.y, r0.xwzw, r2, c1.y
dp2add r3.w, r0.xwzw, r2.zwzw, c1.y
texld r2, r1.zxzw, s0
add oC0, r3, r2
texld r2, r1.zxzw, s1
texld r3, r1.zyzw, s1
mul r0.yz, r0.x, r3.xyww
mad r4.xz, r0.w, r3, -r0.yyzw
dp2add r4.y, r0.xwzw, r3, c1.y
dp2add r4.w, r0.xwzw, r3.zwzw, c1.y
add oC1, r2, r4
texld r2, r1.zxzw, s2
texld r1, r1.zyzw, s2
mul r0.yz, r0.x, r1.xyww
mad r3.xz, r0.w, r1, -r0.yyzw
dp2add r3.y, r0.xwzw, r1, c1.y
dp2add r3.w, r0.xwzw, r1.zwzw, c1.y
add oC2, r2, r3

"
}
SubProgram "d3d11 " {
// Stats: 20 math, 7 textures
SetTexture 0 [_ButterFlyLookUp] 2D 3
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
SetTexture 3 [_ReadBuffer2] 2D 2
ConstBuffer "$Globals" 112
Float 96 [_Size]
BindCB  "$Globals" 0
"ps_4_0
root12:aeabaeaa
eefiecedhecjlnnbpjilkaglpfcoljlnhflkclmlabaaaaaakmafaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmaeaaaaeaaaaaaacpabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaagaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaadaaaaaadcaaaaakfcaabaaaaeaaaaaapgapbaaaaaaaaaaa
agacbaaaadaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaaeaaaaaa
ogakbaaaaaaaaaaaegaabaaaadaaaaaaapaaaaahicaabaaaaeaaaaaaogakbaaa
aaaaaaaaogakbaaaadaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
SubProgram "glcore " {
"!!GL3x"
}
}
 }
}
}