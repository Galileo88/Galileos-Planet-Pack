// Compiled shader for custom platforms, uncompressed size: 35.1KB

Shader "Proland/Ocean/InitJacobians" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 102 math, 5 texture, 6 branch
 //      opengl : 102 math, 5 texture, 6 branch
 // Stats for Fragment shader:
 //       d3d11 : 42 math, 5 texture
 //        d3d9 : 85 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 31557
Program "vp" {
SubProgram "opengl " {
// Stats: 102 math, 5 textures, 6 branches
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
  float tmpvar_13;
  tmpvar_13 = sqrt(dot (tmpvar_9, tmpvar_9));
  float tmpvar_14;
  tmpvar_14 = sqrt(dot (tmpvar_10, tmpvar_10));
  float tmpvar_15;
  tmpvar_15 = sqrt(dot (tmpvar_11, tmpvar_11));
  float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_12, tmpvar_12));
  float tmpvar_17;
  if ((tmpvar_13 == 0.0)) {
    tmpvar_17 = 0.0;
  } else {
    tmpvar_17 = (1.0/(tmpvar_13));
  };
  float tmpvar_18;
  if ((tmpvar_14 == 0.0)) {
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = (1.0/(tmpvar_14));
  };
  float tmpvar_19;
  if ((tmpvar_15 == 0.0)) {
    tmpvar_19 = 0.0;
  } else {
    tmpvar_19 = (1.0/(tmpvar_15));
  };
  float tmpvar_20;
  if ((tmpvar_16 == 0.0)) {
    tmpvar_20 = 0.0;
  } else {
    tmpvar_20 = (1.0/(tmpvar_16));
  };
  vec4 tmpvar_21;
  tmpvar_21 = texture2D (_WTable, xlv_TEXCOORD0);
  float tmpvar_22;
  tmpvar_22 = cos((tmpvar_21.x * _T));
  float tmpvar_23;
  tmpvar_23 = sin((tmpvar_21.x * _T));
  vec2 tmpvar_24;
  tmpvar_24.x = (((tmpvar_4.x + tmpvar_5.x) * tmpvar_22) - ((tmpvar_4.y + tmpvar_5.y) * tmpvar_23));
  tmpvar_24.y = (((tmpvar_4.x - tmpvar_5.x) * tmpvar_23) + ((tmpvar_4.y - tmpvar_5.y) * tmpvar_22));
  float tmpvar_25;
  tmpvar_25 = cos((tmpvar_21.y * _T));
  float tmpvar_26;
  tmpvar_26 = sin((tmpvar_21.y * _T));
  vec2 tmpvar_27;
  tmpvar_27.x = (((tmpvar_4.z + tmpvar_5.z) * tmpvar_25) - ((tmpvar_4.w + tmpvar_5.w) * tmpvar_26));
  tmpvar_27.y = (((tmpvar_4.z - tmpvar_5.z) * tmpvar_26) + ((tmpvar_4.w - tmpvar_5.w) * tmpvar_25));
  float tmpvar_28;
  tmpvar_28 = cos((tmpvar_21.z * _T));
  float tmpvar_29;
  tmpvar_29 = sin((tmpvar_21.z * _T));
  vec2 tmpvar_30;
  tmpvar_30.x = (((tmpvar_7.x + tmpvar_8.x) * tmpvar_28) - ((tmpvar_7.y + tmpvar_8.y) * tmpvar_29));
  tmpvar_30.y = (((tmpvar_7.x - tmpvar_8.x) * tmpvar_29) + ((tmpvar_7.y - tmpvar_8.y) * tmpvar_28));
  float tmpvar_31;
  tmpvar_31 = cos((tmpvar_21.w * _T));
  float tmpvar_32;
  tmpvar_32 = sin((tmpvar_21.w * _T));
  vec2 tmpvar_33;
  tmpvar_33.x = (((tmpvar_7.z + tmpvar_8.z) * tmpvar_31) - ((tmpvar_7.w + tmpvar_8.w) * tmpvar_32));
  tmpvar_33.y = (((tmpvar_7.z - tmpvar_8.z) * tmpvar_32) + ((tmpvar_7.w - tmpvar_8.w) * tmpvar_31));
  vec4 tmpvar_34;
  tmpvar_34.x = tmpvar_17;
  tmpvar_34.y = tmpvar_18;
  tmpvar_34.z = tmpvar_19;
  tmpvar_34.w = tmpvar_20;
  vec2 tmpvar_35;
  tmpvar_35 = (tmpvar_9 * tmpvar_9);
  vec2 tmpvar_36;
  tmpvar_36 = (tmpvar_10 * tmpvar_10);
  vec2 tmpvar_37;
  tmpvar_37 = (tmpvar_11 * tmpvar_11);
  vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_12 * tmpvar_12);
  vec4 tmpvar_39;
  tmpvar_39.x = tmpvar_24.x;
  tmpvar_39.y = tmpvar_27.x;
  tmpvar_39.z = tmpvar_30.x;
  tmpvar_39.w = tmpvar_33.x;
  vec4 tmpvar_40;
  tmpvar_40.x = tmpvar_35.x;
  tmpvar_40.y = tmpvar_36.x;
  tmpvar_40.z = tmpvar_37.x;
  tmpvar_40.w = tmpvar_38.x;
  vec4 tmpvar_41;
  tmpvar_41.x = tmpvar_35.y;
  tmpvar_41.y = tmpvar_36.y;
  tmpvar_41.z = tmpvar_37.y;
  tmpvar_41.w = tmpvar_38.y;
  vec4 tmpvar_42;
  tmpvar_42.x = (tmpvar_9.x * tmpvar_9.y);
  tmpvar_42.y = (tmpvar_10.x * tmpvar_10.y);
  tmpvar_42.z = (tmpvar_11.x * tmpvar_11.y);
  tmpvar_42.w = (tmpvar_12.x * tmpvar_12.y);
  gl_FragData[0] = (-(tmpvar_39) * (tmpvar_40 * tmpvar_34));
  gl_FragData[1] = (-(tmpvar_39) * (tmpvar_41 * tmpvar_34));
  gl_FragData[2] = (-(tmpvar_39) * (tmpvar_42 * tmpvar_34));
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
// Stats: 102 math, 5 textures, 6 branches
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
  highp float tmpvar_18;
  tmpvar_18 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_19;
  tmpvar_19 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_20;
  tmpvar_20 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_22;
  if ((tmpvar_18 == 0.0)) {
    tmpvar_22 = 0.0;
  } else {
    tmpvar_22 = (1.0/(tmpvar_18));
  };
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
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_WTable, xlv_TEXCOORD0);
  w_1 = tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = cos((w_1.x * _T));
  highp float tmpvar_28;
  tmpvar_28 = sin((w_1.x * _T));
  highp vec2 tmpvar_29;
  tmpvar_29.x = (((s12_5.x + s12c_4.x) * tmpvar_27) - ((s12_5.y + s12c_4.y) * tmpvar_28));
  tmpvar_29.y = (((s12_5.x - s12c_4.x) * tmpvar_28) + ((s12_5.y - s12c_4.y) * tmpvar_27));
  highp float tmpvar_30;
  tmpvar_30 = cos((w_1.y * _T));
  highp float tmpvar_31;
  tmpvar_31 = sin((w_1.y * _T));
  highp vec2 tmpvar_32;
  tmpvar_32.x = (((s12_5.z + s12c_4.z) * tmpvar_30) - ((s12_5.w + s12c_4.w) * tmpvar_31));
  tmpvar_32.y = (((s12_5.z - s12c_4.z) * tmpvar_31) + ((s12_5.w - s12c_4.w) * tmpvar_30));
  highp float tmpvar_33;
  tmpvar_33 = cos((w_1.z * _T));
  highp float tmpvar_34;
  tmpvar_34 = sin((w_1.z * _T));
  highp vec2 tmpvar_35;
  tmpvar_35.x = (((s34_3.x + s34c_2.x) * tmpvar_33) - ((s34_3.y + s34c_2.y) * tmpvar_34));
  tmpvar_35.y = (((s34_3.x - s34c_2.x) * tmpvar_34) + ((s34_3.y - s34c_2.y) * tmpvar_33));
  highp float tmpvar_36;
  tmpvar_36 = cos((w_1.w * _T));
  highp float tmpvar_37;
  tmpvar_37 = sin((w_1.w * _T));
  highp vec2 tmpvar_38;
  tmpvar_38.x = (((s34_3.z + s34c_2.z) * tmpvar_36) - ((s34_3.w + s34c_2.w) * tmpvar_37));
  tmpvar_38.y = (((s34_3.z - s34c_2.z) * tmpvar_37) + ((s34_3.w - s34c_2.w) * tmpvar_36));
  highp vec4 tmpvar_39;
  tmpvar_39.x = tmpvar_22;
  tmpvar_39.y = tmpvar_23;
  tmpvar_39.z = tmpvar_24;
  tmpvar_39.w = tmpvar_25;
  highp vec2 tmpvar_40;
  tmpvar_40 = (tmpvar_14 * tmpvar_14);
  highp vec2 tmpvar_41;
  tmpvar_41 = (tmpvar_15 * tmpvar_15);
  highp vec2 tmpvar_42;
  tmpvar_42 = (tmpvar_16 * tmpvar_16);
  highp vec2 tmpvar_43;
  tmpvar_43 = (tmpvar_17 * tmpvar_17);
  highp vec4 tmpvar_44;
  tmpvar_44.x = tmpvar_29.x;
  tmpvar_44.y = tmpvar_32.x;
  tmpvar_44.z = tmpvar_35.x;
  tmpvar_44.w = tmpvar_38.x;
  highp vec4 tmpvar_45;
  tmpvar_45.x = tmpvar_40.x;
  tmpvar_45.y = tmpvar_41.x;
  tmpvar_45.z = tmpvar_42.x;
  tmpvar_45.w = tmpvar_43.x;
  highp vec4 tmpvar_46;
  tmpvar_46.x = tmpvar_40.y;
  tmpvar_46.y = tmpvar_41.y;
  tmpvar_46.z = tmpvar_42.y;
  tmpvar_46.w = tmpvar_43.y;
  highp vec4 tmpvar_47;
  tmpvar_47.x = (tmpvar_14.x * tmpvar_14.y);
  tmpvar_47.y = (tmpvar_15.x * tmpvar_15.y);
  tmpvar_47.z = (tmpvar_16.x * tmpvar_16.y);
  tmpvar_47.w = (tmpvar_17.x * tmpvar_17.y);
  highp vec4 tmpvar_48;
  tmpvar_48 = (-(tmpvar_44) * (tmpvar_45 * tmpvar_39));
  gl_FragData[0] = tmpvar_48;
  highp vec4 tmpvar_49;
  tmpvar_49 = (-(tmpvar_44) * (tmpvar_46 * tmpvar_39));
  gl_FragData[1] = tmpvar_49;
  highp vec4 tmpvar_50;
  tmpvar_50 = (-(tmpvar_44) * (tmpvar_47 * tmpvar_39));
  gl_FragData[2] = tmpvar_50;
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
highp vec4 t0;
bvec4 tb0;
highp vec4 t1;
highp vec4 t2;
highp vec4 t3;
mediump vec4 t16_3;
lowp vec4 t10_3;
highp vec4 t4;
mediump vec4 t16_4;
lowp vec4 t10_4;
highp vec4 t5;
lowp vec4 t10_5;
highp vec4 t6;
highp float t7;
highp float t8;
lowp vec4 t10_9;
bool tb12;
highp float t13;
bool tb13;
void main()
{
    tb0 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), vs_TEXCOORD0.xyxy);
    t1 = vs_TEXCOORD0.xyxy + vec4(-1.0, -1.0, -1.0, -1.0);
    t0.x = (tb0.x) ? t1.x : vs_TEXCOORD0.x;
    t0.y = (tb0.y) ? t1.y : vs_TEXCOORD0.y;
    t0.z = (tb0.z) ? t1.z : vs_TEXCOORD0.x;
    t0.w = (tb0.w) ? t1.w : vs_TEXCOORD0.y;
    t1 = vec4(t0.z * _InverseGridSizes.x, t0.w * _InverseGridSizes.x, t0.z * _InverseGridSizes.y, t0.w * _InverseGridSizes.y);
    t0 = vec4(t0.x * _InverseGridSizes.z, t0.y * _InverseGridSizes.z, t0.z * _InverseGridSizes.w, t0.w * _InverseGridSizes.w);
    t2.x = dot(t1.xy, t1.xy);
    t2.x = sqrt(t2.x);
    tb12 = t2.x==0.0;
    t2.x = float(1.0) / t2.x;
    t2.x = (tb12) ? 0.0 : t2.x;
    t3.x = dot(t1.zw, t1.zw);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.y = (tb13) ? 0.0 : t3.x;
    t3.x = dot(t0.xy, t0.xy);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.z = (tb13) ? 0.0 : t3.x;
    t3.x = dot(t0.zw, t0.zw);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.w = (tb13) ? 0.0 : t3.x;
    t3 = t1.ywxz * t1.ywxz;
    t1.xy = vec2(t1.y * t1.x, t1.w * t1.z);
    t4.xy = t3.zw;
    t5 = t0 * t0;
    t1.zw = vec2(t0.y * t0.x, t0.w * t0.z);
    t0 = t2 * t1;
    t4.zw = t5.xz;
    t3.zw = t5.yw;
    t1 = t2 * t3;
    t2 = t2 * t4;
    t10_3 = texture(_Spectrum01, vs_TEXCOORD0.xy);
    t4.xy = (-vs_TEXCOORD0.xy) + _Offset.xy;
    t10_5 = texture(_Spectrum01, t4.xy);
    t10_4 = texture(_Spectrum23, t4.xy);
    t16_3 = t10_3 + t10_5;
    t10_5 = texture(_WTable, vs_TEXCOORD0.xy);
    t5 = t10_5 * vec4(_T);
    t6.x = cos(t5.x);
    t5.x = sin(t5.x);
    t13 = t16_3.y * t5.x;
    t6.x = t16_3.x * t6.x + (-t13);
    t3.x = sin(t5.y);
    t5.x = cos(t5.y);
    t3.x = t3.x * t16_3.w;
    t6.y = t16_3.z * t5.x + (-t3.x);
    t3.x = sin(t5.z);
    t5.x = cos(t5.z);
    t7 = sin(t5.w);
    t8 = cos(t5.w);
    t10_9 = texture(_Spectrum23, vs_TEXCOORD0.xy);
    t16_4 = t10_4 + t10_9;
    t3.x = t3.x * t16_4.y;
    t6.z = t16_4.x * t5.x + (-t3.x);
    t3.x = t7 * t16_4.w;
    t6.w = t16_4.z * t8 + (-t3.x);
    SV_Target0 = t2 * (-t6);
    SV_Target1 = t1 * (-t6);
    SV_Target2 = t0 * (-t6);
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
vec4 t0;
bvec4 tb0;
vec4 t1;
vec4 t2;
vec4 t3;
mediump vec4 t16_3;
lowp vec4 t10_3;
vec4 t4;
mediump vec4 t16_4;
lowp vec4 t10_4;
vec4 t5;
lowp vec4 t10_5;
vec4 t6;
float t7;
float t8;
lowp vec4 t10_9;
bool tb12;
float t13;
bool tb13;
void main()
{
    tb0 = lessThan(vec4(0.5, 0.5, 0.5, 0.5), vs_TEXCOORD0.xyxy);
    t1 = vs_TEXCOORD0.xyxy + vec4(-1.0, -1.0, -1.0, -1.0);
    t0.x = (tb0.x) ? t1.x : vs_TEXCOORD0.x;
    t0.y = (tb0.y) ? t1.y : vs_TEXCOORD0.y;
    t0.z = (tb0.z) ? t1.z : vs_TEXCOORD0.x;
    t0.w = (tb0.w) ? t1.w : vs_TEXCOORD0.y;
    t1 = t0.zwzw * _InverseGridSizes.xxyy;
    t0 = t0 * _InverseGridSizes.zzww;
    t2.x = dot(t1.xy, t1.xy);
    t2.x = sqrt(t2.x);
    tb12 = t2.x==0.0;
    t2.x = float(1.0) / t2.x;
    t2.x = (tb12) ? 0.0 : t2.x;
    t3.x = dot(t1.zw, t1.zw);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.y = (tb13) ? 0.0 : t3.x;
    t3.x = dot(t0.xy, t0.xy);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.z = (tb13) ? 0.0 : t3.x;
    t3.x = dot(t0.zw, t0.zw);
    t3.x = sqrt(t3.x);
    tb13 = t3.x==0.0;
    t3.x = float(1.0) / t3.x;
    t2.w = (tb13) ? 0.0 : t3.x;
    t3 = t1.ywxz * t1.ywxz;
    t1.xy = t1.yw * t1.xz;
    t4.xy = t3.zw;
    t5 = t0 * t0;
    t1.zw = t0.yw * t0.xz;
    t0 = t2 * t1;
    t4.zw = t5.xz;
    t3.zw = t5.yw;
    t1 = t2 * t3;
    t2 = t2 * t4;
    t10_3 = texture(_Spectrum01, vs_TEXCOORD0.xy);
    t4.xy = (-vs_TEXCOORD0.xy) + _Offset.xy;
    t10_5 = texture(_Spectrum01, t4.xy);
    t10_4 = texture(_Spectrum23, t4.xy);
    t16_3 = t10_3 + t10_5;
    t10_5 = texture(_WTable, vs_TEXCOORD0.xy);
    t5 = t10_5 * vec4(_T);
    t6.x = cos(t5.x);
    t5.x = sin(t5.x);
    t13 = t16_3.y * t5.x;
    t6.x = t16_3.x * t6.x + (-t13);
    t3.x = sin(t5.y);
    t5.x = cos(t5.y);
    t3.x = t3.x * t16_3.w;
    t6.y = t16_3.z * t5.x + (-t3.x);
    t3.x = sin(t5.z);
    t5.x = cos(t5.z);
    t7 = sin(t5.w);
    t8 = cos(t5.w);
    t10_9 = texture(_Spectrum23, vs_TEXCOORD0.xy);
    t16_4 = t10_4 + t10_9;
    t3.x = t3.x * t16_4.y;
    t6.z = t16_4.x * t5.x + (-t3.x);
    t3.x = t7 * t16_4.w;
    t6.w = t16_4.z * t8 + (-t3.x);
    SV_Target0 = t2 * (-t6);
    SV_Target1 = t1 * (-t6);
    SV_Target2 = t0 * (-t6);
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
// Stats: 85 math, 5 textures
Vector 1 [_InverseGridSizes]
Vector 0 [_Offset]
Float 2 [_T]
SetTexture 0 [_Spectrum01] 2D 0
SetTexture 1 [_Spectrum23] 2D 1
SetTexture 2 [_WTable] 2D 2
"ps_3_0
def c3, 0.5, -1, 0, 0.159154937
def c4, 6.28318548, -3.14159274, 0, 0
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
add r0, c3.x, -v0.xyxy
add r1, c3.y, v0.xyxy
cmp r0, r0, v0.xyxy, r1
mul r1, r0.zwzw, c1.xxyy
mul r0, r0, c1.zzww
dp2add r2.x, r1, r1, c3.z
rsq r2.x, r2.x
rcp r2.y, r2.x
cmp r2.x, -r2.y, c3.z, r2.x
dp2add r3.x, r1.zwzw, r1.zwzw, c3.z
rsq r3.x, r3.x
rcp r3.y, r3.x
cmp r2.y, -r3.y, c3.z, r3.x
dp2add r3.x, r0, r0, c3.z
rsq r3.x, r3.x
rcp r3.y, r3.x
cmp r2.z, -r3.y, c3.z, r3.x
dp2add r3.x, r0.zwzw, r0.zwzw, c3.z
rsq r3.x, r3.x
rcp r3.y, r3.x
cmp r2.w, -r3.y, c3.z, r3.x
mul r3, r1.ywxz, r1.ywxz
mul r1.xy, r1.ywzw, r1.xzzw
mov r4.xy, r3.zwzw
mul r5, r0, r0
mul r1.zw, r0.xyyw, r0.xyxz
mul r0, r2, r1
mov r4.zw, r5.xyxz
mov r3.zw, r5.xyyw
mul r1, r2, r3
mul r2, r2, r4
texld r3, v0, s2
mul r3, r3, c2.x
mad r3, r3, c3.w, c3.x
frc r3, r3
mad r3, r3, c4.x, c4.y
sincos r4.xy, r3.x
texld r5, v0, s0
add r4.zw, c0.xyxy, -v0.xyxy
texld r6, r4.zwzw, s0
texld r7, r4.zwzw, s1
add r5, r5, r6
mul r3.x, r4.y, r5.y
mad r4.x, r5.x, r4.x, -r3.x
sincos r6.xy, r3.y
mul r3.x, r5.w, r6.y
mad r4.y, r5.z, r6.x, -r3.x
sincos r5.xy, r3.z
sincos r6.xy, r3.w
texld r3, v0, s1
add r3, r7, r3
mul r3.y, r5.y, r3.y
mad r4.z, r3.x, r5.x, -r3.y
mul r3.x, r6.y, r3.w
mad r4.w, r3.z, r6.x, -r3.x
mul oC0, r2, -r4
mul oC1, r1, -r4
mul oC2, r0, -r4

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
eefiecedkclafdfhfaakdbfflhkjcflmcfgcgbiiabaaaaaalmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmmahaaaaeaaaaaaapdabaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadpccabaaaacaaaaaagiaaaaacakaaaaaadbaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadpegbebaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdhaaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
egbebaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaogaobaaaaaaaaaaaagifcaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaakgipcaaa
aaaaaaaaahaaaaaaapaaaaahbcaabaaaacaaaaaaegaabaaaabaaaaaaegaabaaa
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
abaaaaaaegiacaaaaaaaaaaaagaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaaipcaabaaa
afaaaaaaegaobaaaafaaaaaaagiacaaaaaaaaaaaaiaaaaaaenaaaaahbcaabaaa
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