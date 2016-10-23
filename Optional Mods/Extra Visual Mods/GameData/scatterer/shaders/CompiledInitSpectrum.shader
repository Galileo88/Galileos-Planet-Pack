// Compiled shader for custom platforms, uncompressed size: 33.0KB

Shader "Proland/Ocean/InitSpectrum" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 85 math, 5 texture, 2 branch
 //      opengl : 85 math, 5 texture, 2 branch
 // Stats for Fragment shader:
 //       d3d11 : 42 math, 5 texture
 //        d3d9 : 78 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35952
Program "vp" {
SubProgram "opengl " {
// Stats: 85 math, 5 textures, 2 branches
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
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform vec4 _Offset;
uniform vec4 _InverseGridSizes;
uniform float _T;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 st_1;
  float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Spectrum01, xlv_TEXCOORD0);
  vec4 tmpvar_5;
  vec2 tmpvar_6;
  tmpvar_6 = (_Offset.xy - xlv_TEXCOORD0);
  tmpvar_5 = texture2D (_Spectrum01, tmpvar_6);
  vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Spectrum23, xlv_TEXCOORD0);
  vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Spectrum23, tmpvar_6);
  vec2 tmpvar_9;
  tmpvar_9 = (st_1 * _InverseGridSizes.x);
  vec2 tmpvar_10;
  tmpvar_10 = (st_1 * _InverseGridSizes.y);
  vec2 tmpvar_11;
  tmpvar_11 = (st_1 * _InverseGridSizes.z);
  vec2 tmpvar_12;
  tmpvar_12 = (st_1 * _InverseGridSizes.w);
  vec4 tmpvar_13;
  tmpvar_13 = texture2D (_WTable, xlv_TEXCOORD0);
  float tmpvar_14;
  tmpvar_14 = cos((tmpvar_13.x * _T));
  float tmpvar_15;
  tmpvar_15 = sin((tmpvar_13.x * _T));
  vec2 tmpvar_16;
  tmpvar_16.x = (((tmpvar_4.x + tmpvar_5.x) * tmpvar_14) - ((tmpvar_4.y + tmpvar_5.y) * tmpvar_15));
  tmpvar_16.y = (((tmpvar_4.x - tmpvar_5.x) * tmpvar_15) + ((tmpvar_4.y - tmpvar_5.y) * tmpvar_14));
  float tmpvar_17;
  tmpvar_17 = cos((tmpvar_13.y * _T));
  float tmpvar_18;
  tmpvar_18 = sin((tmpvar_13.y * _T));
  vec2 tmpvar_19;
  tmpvar_19.x = (((tmpvar_4.z + tmpvar_5.z) * tmpvar_17) - ((tmpvar_4.w + tmpvar_5.w) * tmpvar_18));
  tmpvar_19.y = (((tmpvar_4.z - tmpvar_5.z) * tmpvar_18) + ((tmpvar_4.w - tmpvar_5.w) * tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = cos((tmpvar_13.z * _T));
  float tmpvar_21;
  tmpvar_21 = sin((tmpvar_13.z * _T));
  vec2 tmpvar_22;
  tmpvar_22.x = (((tmpvar_7.x + tmpvar_8.x) * tmpvar_20) - ((tmpvar_7.y + tmpvar_8.y) * tmpvar_21));
  tmpvar_22.y = (((tmpvar_7.x - tmpvar_8.x) * tmpvar_21) + ((tmpvar_7.y - tmpvar_8.y) * tmpvar_20));
  float tmpvar_23;
  tmpvar_23 = cos((tmpvar_13.w * _T));
  float tmpvar_24;
  tmpvar_24 = sin((tmpvar_13.w * _T));
  vec2 tmpvar_25;
  tmpvar_25.x = (((tmpvar_7.z + tmpvar_8.z) * tmpvar_23) - ((tmpvar_7.w + tmpvar_8.w) * tmpvar_24));
  tmpvar_25.y = (((tmpvar_7.z - tmpvar_8.z) * tmpvar_24) + ((tmpvar_7.w - tmpvar_8.w) * tmpvar_23));
  vec2 tmpvar_26;
  tmpvar_26.x = -(tmpvar_19.y);
  tmpvar_26.y = tmpvar_19.x;
  vec2 tmpvar_27;
  tmpvar_27.x = -(tmpvar_25.y);
  tmpvar_27.y = tmpvar_25.x;
  vec2 z_28;
  z_28 = (tmpvar_9.x * tmpvar_16);
  vec2 tmpvar_29;
  tmpvar_29.x = -(z_28.y);
  tmpvar_29.y = z_28.x;
  vec2 z_30;
  z_30 = (tmpvar_10.x * tmpvar_19);
  vec2 tmpvar_31;
  tmpvar_31.x = -(z_30.y);
  tmpvar_31.y = z_30.x;
  vec2 z_32;
  z_32 = (tmpvar_11.x * tmpvar_22);
  vec2 tmpvar_33;
  tmpvar_33.x = -(z_32.y);
  tmpvar_33.y = z_32.x;
  vec2 z_34;
  z_34 = (tmpvar_12.x * tmpvar_25);
  vec2 tmpvar_35;
  tmpvar_35.x = -(z_34.y);
  tmpvar_35.y = z_34.x;
  vec4 tmpvar_36;
  tmpvar_36.xy = (tmpvar_16 + tmpvar_26);
  tmpvar_36.zw = (tmpvar_22 + tmpvar_27);
  vec4 tmpvar_37;
  tmpvar_37.xy = (tmpvar_29 - (tmpvar_9.y * tmpvar_16));
  tmpvar_37.zw = (tmpvar_31 - (tmpvar_10.y * tmpvar_19));
  vec4 tmpvar_38;
  tmpvar_38.xy = (tmpvar_33 - (tmpvar_11.y * tmpvar_22));
  tmpvar_38.zw = (tmpvar_35 - (tmpvar_12.y * tmpvar_25));
  gl_FragData[0] = tmpvar_36;
  gl_FragData[1] = tmpvar_37;
  gl_FragData[2] = tmpvar_38;
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
// Stats: 85 math, 5 textures, 2 branches
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
uniform sampler2D _Spectrum01;
uniform sampler2D _Spectrum23;
uniform sampler2D _WTable;
uniform highp vec4 _Offset;
uniform highp vec4 _InverseGridSizes;
uniform highp float _T;
varying highp vec2 xlv_TEXCOORD0;
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
  tmpvar_9 = texture2D (_Spectrum01, xlv_TEXCOORD0);
  s12_5 = tmpvar_9;
  lowp vec4 tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = (_Offset.xy - xlv_TEXCOORD0);
  tmpvar_10 = texture2D (_Spectrum01, tmpvar_11);
  s12c_4 = tmpvar_10;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Spectrum23, xlv_TEXCOORD0);
  s34_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_Spectrum23, tmpvar_11);
  s34c_2 = tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = (st_6 * _InverseGridSizes.x);
  highp vec2 tmpvar_15;
  tmpvar_15 = (st_6 * _InverseGridSizes.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (st_6 * _InverseGridSizes.z);
  highp vec2 tmpvar_17;
  tmpvar_17 = (st_6 * _InverseGridSizes.w);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_WTable, xlv_TEXCOORD0);
  w_1 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = cos((w_1.x * _T));
  highp float tmpvar_20;
  tmpvar_20 = sin((w_1.x * _T));
  highp vec2 tmpvar_21;
  tmpvar_21.x = (((s12_5.x + s12c_4.x) * tmpvar_19) - ((s12_5.y + s12c_4.y) * tmpvar_20));
  tmpvar_21.y = (((s12_5.x - s12c_4.x) * tmpvar_20) + ((s12_5.y - s12c_4.y) * tmpvar_19));
  highp float tmpvar_22;
  tmpvar_22 = cos((w_1.y * _T));
  highp float tmpvar_23;
  tmpvar_23 = sin((w_1.y * _T));
  highp vec2 tmpvar_24;
  tmpvar_24.x = (((s12_5.z + s12c_4.z) * tmpvar_22) - ((s12_5.w + s12c_4.w) * tmpvar_23));
  tmpvar_24.y = (((s12_5.z - s12c_4.z) * tmpvar_23) + ((s12_5.w - s12c_4.w) * tmpvar_22));
  highp float tmpvar_25;
  tmpvar_25 = cos((w_1.z * _T));
  highp float tmpvar_26;
  tmpvar_26 = sin((w_1.z * _T));
  highp vec2 tmpvar_27;
  tmpvar_27.x = (((s34_3.x + s34c_2.x) * tmpvar_25) - ((s34_3.y + s34c_2.y) * tmpvar_26));
  tmpvar_27.y = (((s34_3.x - s34c_2.x) * tmpvar_26) + ((s34_3.y - s34c_2.y) * tmpvar_25));
  highp float tmpvar_28;
  tmpvar_28 = cos((w_1.w * _T));
  highp float tmpvar_29;
  tmpvar_29 = sin((w_1.w * _T));
  highp vec2 tmpvar_30;
  tmpvar_30.x = (((s34_3.z + s34c_2.z) * tmpvar_28) - ((s34_3.w + s34c_2.w) * tmpvar_29));
  tmpvar_30.y = (((s34_3.z - s34c_2.z) * tmpvar_29) + ((s34_3.w - s34c_2.w) * tmpvar_28));
  highp vec2 tmpvar_31;
  tmpvar_31.x = -(tmpvar_24.y);
  tmpvar_31.y = tmpvar_24.x;
  highp vec2 tmpvar_32;
  tmpvar_32.x = -(tmpvar_30.y);
  tmpvar_32.y = tmpvar_30.x;
  highp vec2 z_33;
  z_33 = (tmpvar_14.x * tmpvar_21);
  highp vec2 tmpvar_34;
  tmpvar_34.x = -(z_33.y);
  tmpvar_34.y = z_33.x;
  highp vec2 z_35;
  z_35 = (tmpvar_15.x * tmpvar_24);
  highp vec2 tmpvar_36;
  tmpvar_36.x = -(z_35.y);
  tmpvar_36.y = z_35.x;
  highp vec2 z_37;
  z_37 = (tmpvar_16.x * tmpvar_27);
  highp vec2 tmpvar_38;
  tmpvar_38.x = -(z_37.y);
  tmpvar_38.y = z_37.x;
  highp vec2 z_39;
  z_39 = (tmpvar_17.x * tmpvar_30);
  highp vec2 tmpvar_40;
  tmpvar_40.x = -(z_39.y);
  tmpvar_40.y = z_39.x;
  highp vec4 tmpvar_41;
  tmpvar_41.xy = (tmpvar_21 + tmpvar_31);
  tmpvar_41.zw = (tmpvar_27 + tmpvar_32);
  highp vec4 tmpvar_42;
  tmpvar_42.xy = (tmpvar_34 - (tmpvar_14.y * tmpvar_21));
  tmpvar_42.zw = (tmpvar_36 - (tmpvar_15.y * tmpvar_24));
  highp vec4 tmpvar_43;
  tmpvar_43.xy = (tmpvar_38 - (tmpvar_16.y * tmpvar_27));
  tmpvar_43.zw = (tmpvar_40 - (tmpvar_17.y * tmpvar_30));
  gl_FragData[0] = tmpvar_41;
  gl_FragData[1] = tmpvar_42;
  gl_FragData[2] = tmpvar_43;
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
uniform 	vec4 _Offset;
uniform 	vec4 _InverseGridSizes;
uniform 	float _T;
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
uniform 	vec4 _Offset;
uniform 	vec4 _InverseGridSizes;
uniform 	float _T;
uniform lowp sampler2D _Spectrum01;
uniform lowp sampler2D _Spectrum23;
uniform lowp sampler2D _WTable;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
layout(location = 2) out highp vec4 SV_Target2;
highp vec3 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
highp vec2 t1;
mediump vec4 t16_1;
lowp vec4 t10_1;
highp vec4 t2;
lowp vec4 t10_2;
bvec4 tb2;
highp vec4 t3;
mediump vec4 t16_3;
lowp vec4 t10_3;
highp vec3 t4;
mediump vec4 t16_4;
highp float t5;
highp vec3 t6;
highp vec3 t7;
highp float t8;
highp float t10;
highp float t16;
highp float t24;
void main()
{
    t10_0 = texture(_Spectrum01, vs_TEXCOORD0.xy);
    t1.xy = (-vs_TEXCOORD0.xy) + _Offset.xy;
    t10_2 = texture(_Spectrum01, t1.xy);
    t10_1 = texture(_Spectrum23, t1.xy);
    t16_3 = t10_0 + (-t10_2);
    t16_0 = t10_0 + t10_2;
    t10_2 = texture(_WTable, vs_TEXCOORD0.xy);
    t2 = t10_2 * vec4(_T);
    t4.x = sin(t2.y);
    t5 = cos(t2.y);
    t10 = t16_3.w * t5;
    t6.z = t16_3.z * t4.x + t10;
    t6.x = (-t6.z);
    t7.x = cos(t2.x);
    t2.x = sin(t2.x);
    t8 = t16_0.y * t2.x;
    t0.x = t16_0.x * t7.x + (-t8);
    t10 = t16_3.y * t7.x;
    t0.y = t16_3.x * t2.x + t10;
    t24 = t16_0.w * t4.x;
    t6.y = t16_0.z * t5 + (-t24);
    SV_Target0.xy = t0.xy + t6.xy;
    t10_3 = texture(_Spectrum23, vs_TEXCOORD0.xy);
    t16_4 = (-t10_1) + t10_3;
    t16_1 = t10_1 + t10_3;
    t3.x = cos(t2.w);
    t2.x = sin(t2.w);
    t5 = sin(t2.z);
    t6.x = cos(t2.z);
    t16 = t3.x * t16_4.w;
    t7.z = t16_4.z * t2.x + t16;
    t7.x = (-t7.z);
    t16 = t16_1.y * t5;
    t1.x = t16_1.x * t6.x + (-t16);
    t16 = t16_4.y * t6.x;
    t1.y = t16_4.x * t5 + t16;
    t16 = t16_1.w * t2.x;
    t7.y = t16_1.z * t3.x + (-t16);
    SV_Target0.zw = t1.xy + t7.xy;
    tb2 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), vs_TEXCOORD0.xyxy);
    t3 = vs_TEXCOORD0.xyxy + vec4(-1.0, -1.0, -1.0, -1.0);
    t2.x = (tb2.x) ? t3.x : vs_TEXCOORD0.x;
    t2.y = (tb2.y) ? t3.y : vs_TEXCOORD0.y;
    t2.z = (tb2.z) ? t3.z : vs_TEXCOORD0.x;
    t2.w = (tb2.w) ? t3.w : vs_TEXCOORD0.y;
    t3 = vec4(t2.z * _InverseGridSizes.x, t2.w * _InverseGridSizes.x, t2.z * _InverseGridSizes.y, t2.w * _InverseGridSizes.y);
    t2 = vec4(t2.x * _InverseGridSizes.z, t2.y * _InverseGridSizes.z, t2.z * _InverseGridSizes.w, t2.w * _InverseGridSizes.w);
    t4.xy = t0.xy * t3.xx;
    t4.z = (-t4.y);
    SV_Target1.xy = (-t3.yy) * t0.xy + t4.zx;
    t0.xy = vec2(t6.y * t3.z, t6.z * t3.z);
    t0.z = (-t0.y);
    SV_Target1.zw = (-t3.ww) * t6.yz + t0.zx;
    t0.xy = t1.xy * t2.xx;
    t0.z = (-t0.y);
    SV_Target2.xy = (-t2.yy) * t1.xy + t0.zx;
    t0.xy = vec2(t7.y * t2.z, t7.z * t2.z);
    t0.z = (-t0.y);
    SV_Target2.zw = (-t2.ww) * t7.yz + t0.zx;
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
uniform 	vec4 _Offset;
uniform 	vec4 _InverseGridSizes;
uniform 	float _T;
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
uniform 	vec4 _Offset;
uniform 	vec4 _InverseGridSizes;
uniform 	float _T;
uniform  sampler2D _Spectrum01;
uniform  sampler2D _Spectrum23;
uniform  sampler2D _WTable;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
out vec4 SV_Target2;
vec3 t0;
mediump vec4 t16_0;
lowp vec4 t10_0;
vec2 t1;
mediump vec4 t16_1;
lowp vec4 t10_1;
vec4 t2;
lowp vec4 t10_2;
bvec4 tb2;
vec4 t3;
mediump vec4 t16_3;
lowp vec4 t10_3;
vec3 t4;
mediump vec4 t16_4;
float t5;
vec3 t6;
vec3 t7;
float t8;
float t10;
float t16;
float t24;
void main()
{
    t10_0 = texture(_Spectrum01, vs_TEXCOORD0.xy);
    t1.xy = (-vs_TEXCOORD0.xy) + _Offset.xy;
    t10_2 = texture(_Spectrum01, t1.xy);
    t10_1 = texture(_Spectrum23, t1.xy);
    t16_3 = t10_0 + (-t10_2);
    t16_0 = t10_0 + t10_2;
    t10_2 = texture(_WTable, vs_TEXCOORD0.xy);
    t2 = t10_2 * vec4(_T);
    t4.x = sin(t2.y);
    t5 = cos(t2.y);
    t10 = t16_3.w * t5;
    t6.z = t16_3.z * t4.x + t10;
    t6.x = (-t6.z);
    t7.x = cos(t2.x);
    t2.x = sin(t2.x);
    t8 = t16_0.y * t2.x;
    t0.x = t16_0.x * t7.x + (-t8);
    t10 = t16_3.y * t7.x;
    t0.y = t16_3.x * t2.x + t10;
    t24 = t16_0.w * t4.x;
    t6.y = t16_0.z * t5 + (-t24);
    SV_Target0.xy = t0.xy + t6.xy;
    t10_3 = texture(_Spectrum23, vs_TEXCOORD0.xy);
    t16_4 = (-t10_1) + t10_3;
    t16_1 = t10_1 + t10_3;
    t3.x = cos(t2.w);
    t2.x = sin(t2.w);
    t5 = sin(t2.z);
    t6.x = cos(t2.z);
    t16 = t3.x * t16_4.w;
    t7.z = t16_4.z * t2.x + t16;
    t7.x = (-t7.z);
    t16 = t16_1.y * t5;
    t1.x = t16_1.x * t6.x + (-t16);
    t16 = t16_4.y * t6.x;
    t1.y = t16_4.x * t5 + t16;
    t16 = t16_1.w * t2.x;
    t7.y = t16_1.z * t3.x + (-t16);
    SV_Target0.zw = t1.xy + t7.xy;
    tb2 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), vs_TEXCOORD0.xyxy);
    t3 = vs_TEXCOORD0.xyxy + vec4(-1.0, -1.0, -1.0, -1.0);
    t2.x = (tb2.x) ? t3.x : vs_TEXCOORD0.x;
    t2.y = (tb2.y) ? t3.y : vs_TEXCOORD0.y;
    t2.z = (tb2.z) ? t3.z : vs_TEXCOORD0.x;
    t2.w = (tb2.w) ? t3.w : vs_TEXCOORD0.y;
    t3 = t2.zwzw * _InverseGridSizes.xxyy;
    t2 = t2 * _InverseGridSizes.zzww;
    t4.xy = t0.xy * t3.xx;
    t4.z = (-t4.y);
    SV_Target1.xy = (-t3.yy) * t0.xy + t4.zx;
    t0.xy = t6.yz * t3.zz;
    t0.z = (-t0.y);
    SV_Target1.zw = (-t3.ww) * t6.yz + t0.zx;
    t0.xy = t1.xy * t2.xx;
    t0.z = (-t0.y);
    SV_Target2.xy = (-t2.yy) * t1.xy + t0.zx;
    t0.xy = t7.yz * t2.zz;
    t0.z = (-t0.y);
    SV_Target2.zw = (-t2.ww) * t7.yz + t0.zx;
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
// Stats: 78 math, 5 textures
Vector 1 [_InverseGridSizes]
Vector 0 [_Offset]
Float 2 [_T]
SetTexture 0 [_Spectrum01] 2D 0
SetTexture 1 [_Spectrum23] 2D 1
SetTexture 2 [_WTable] 2D 2
"ps_3_0
def c3, 0.5, -1, 0.159154937, 0
def c4, 6.28318548, -3.14159274, 0, 0
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld r0, v0, s2
mul r0, r0, c2.x
mad r0, r0, c3.z, c3.x
frc r0, r0
mad r0, r0, c4.x, c4.y
sincos r1.xy, r0.y
texld r2, v0, s0
add r1.zw, c0.xyxy, -v0.xyxy
texld r3, r1.zwzw, s0
texld r4, r1.zwzw, s1
add r5, r2, -r3
add r2, r2, r3
mul r1.zw, r1.xyyx, r5
add r3.z, r1.w, r1.z
mov r3.x, -r3.z
sincos r6.xy, r0.x
mul r0.x, r2.y, r6.y
mad r0.x, r2.x, r6.x, -r0.x
mul r1.zw, r5.xyxy, r6.xyyx
add r0.y, r1.w, r1.z
mul r1.y, r1.y, r2.w
mad r3.y, r2.z, r1.x, -r1.y
add oC0.xy, r0, r3
sincos r1.xy, r0.w
sincos r2.xy, r0.z
texld r5, v0, s1
add r6, -r4, r5
add r4, r4, r5
mul r0.zw, r1.xyyx, r6
mul r1.zw, r2.xyyx, r6.xyxy
add r5.y, r1.w, r1.z
add r6.z, r0.w, r0.z
mov r6.x, -r6.z
mul r0.z, r2.y, r4.y
mad r5.x, r4.x, r2.x, -r0.z
mul r0.z, r1.y, r4.w
mad r6.y, r4.z, r1.x, -r0.z
add oC0.zw, r5.xyxy, r6.xyxy
add r1, c3.x, -v0.xyxy
add r2, c3.y, v0.xyxy
cmp r1, r1, v0.xyxy, r2
mul r2, r1.zwzw, c1.xxyy
mul r1, r1, c1.zzww
mul r4.xy, r0, r2.x
mov r4.z, -r4.y
mad oC1.xy, r2.y, -r0, r4.zxzw
mul r0.xy, r3.yzzw, r2.z
mov r0.z, -r0.y
mad oC1.zw, r2.w, -r3.xyyz, r0.xyzx
mul r0.xy, r5, r1.x
mov r0.z, -r0.y
mad oC2.xy, r1.y, -r5, r0.zxzw
mul r0.xy, r6.yzzw, r1.z
mov r0.z, -r0.y
mad oC2.zw, r1.w, -r6.xyyz, r0.xyzx

"
}
SubProgram "d3d11 " {
// Stats: 42 math, 5 textures
SetTexture 0 [_Spectrum01] 2D 0
SetTexture 1 [_Spectrum23] 2D 1
SetTexture 2 [_WTable] 2D 2
ConstBuffer "$Globals" 144
Vector 96 [_Offset]
Vector 112 [_InverseGridSizes]
Float 128 [_T]
BindCB  "$Globals" 0
"ps_4_0
root12:adabadaa
eefiecededgggmngkgcdbgmdaahpoahcjipbdfhbabaaaaaabeaiaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcceahaaaaeaaaaaaamjabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacaiaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaajdcaabaaa
abaaaaaaegbabaiaebaaaaaaabaaaaaaegiacaaaaaaaaaaaagaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaaipcaabaaaadaaaaaaegaobaaaaaaaaaaaegaobaiaebaaaaaa
acaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaa
aiaaaaaaenaaaaahbcaabaaaaeaaaaaabcaabaaaafaaaaaabkaabaaaacaaaaaa
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
diaaaaaipcaabaaaadaaaaaaogaobaaaacaaaaaaagifcaaaaaaaaaaaahaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaakgipcaaaaaaaaaaaahaaaaaa
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