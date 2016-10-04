// Compiled shader for custom platforms, uncompressed size: 24.8KB

Shader "Proland/Ocean/InitDisplacement" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //        gles : 30 math, 2 texture, 6 branch
 //      opengl : 30 math, 2 texture, 6 branch
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 2 texture
 //        d3d9 : 27 math, 2 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 8183
Program "vp" {
SubProgram "opengl " {
// Stats: 30 math, 2 textures, 6 branches
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
uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform vec4 _InverseGridSizes;
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
  vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_12;
  tmpvar_16.z = tmpvar_13;
  tmpvar_16.w = tmpvar_13;
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_14;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_15;
  gl_FragData[0] = (texture2D (_Buffer1, xlv_TEXCOORD0) * tmpvar_16);
  gl_FragData[1] = (texture2D (_Buffer2, xlv_TEXCOORD0) * tmpvar_17);
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
// Stats: 30 math, 2 textures, 6 branches
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
uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform highp vec4 _InverseGridSizes;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 st_1;
  highp float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  highp float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  highp vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  highp vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  highp vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  highp float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  highp float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  highp float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Buffer1, xlv_TEXCOORD0);
  highp vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_12;
  tmpvar_17.y = tmpvar_12;
  tmpvar_17.z = tmpvar_13;
  tmpvar_17.w = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Buffer2, xlv_TEXCOORD0);
  highp vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_14;
  tmpvar_19.y = tmpvar_14;
  tmpvar_19.z = tmpvar_15;
  tmpvar_19.w = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_16 * tmpvar_17);
  gl_FragData[0] = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_18 * tmpvar_19);
  gl_FragData[1] = tmpvar_21;
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
uniform 	vec4 _InverseGridSizes;
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
uniform 	vec4 _InverseGridSizes;
uniform lowp sampler2D _Buffer1;
uniform lowp sampler2D _Buffer2;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
layout(location = 1) out highp vec4 SV_Target1;
highp vec4 t0;
lowp vec4 t10_0;
bvec4 tb0;
highp vec4 t1;
lowp vec4 t10_1;
bool tb1;
highp vec4 t2;
highp float t3;
highp float t4;
bool tb6;
bool tb7;
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
    t1.x = dot(t1.xy, t1.xy);
    t1.y = dot(t1.zw, t1.zw);
    t1.xy = sqrt(t1.xy);
    tb7 = t1.x==0.0;
    t1.x = float(1.0) / t1.x;
    t2.xy = (bool(tb7)) ? vec2(0.0, 0.0) : t1.xx;
    tb1 = t1.y==0.0;
    t4 = float(1.0) / t1.y;
    t2.zw = (bool(tb1)) ? vec2(0.0, 0.0) : vec2(t4);
    t10_1 = texture(_Buffer1, vs_TEXCOORD0.xy);
    SV_Target0 = t2 * t10_1;
    t0.x = dot(t0.xy, t0.xy);
    t0.y = dot(t0.zw, t0.zw);
    t0.xy = sqrt(t0.xy);
    tb6 = t0.x==0.0;
    t0.x = float(1.0) / t0.x;
    t1.xy = (bool(tb6)) ? vec2(0.0, 0.0) : t0.xx;
    tb0.x = t0.y==0.0;
    t3 = float(1.0) / t0.y;
    t1.zw = (tb0.x) ? vec2(0.0, 0.0) : vec2(t3);
    t10_0 = texture(_Buffer2, vs_TEXCOORD0.xy);
    SV_Target1 = t1 * t10_0;
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
uniform 	vec4 _InverseGridSizes;
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
uniform 	vec4 _InverseGridSizes;
uniform  sampler2D _Buffer1;
uniform  sampler2D _Buffer2;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
out vec4 SV_Target1;
vec4 t0;
lowp vec4 t10_0;
bvec4 tb0;
vec4 t1;
lowp vec4 t10_1;
bool tb1;
vec4 t2;
float t3;
float t4;
bool tb6;
bool tb7;
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
    t1.x = dot(t1.xy, t1.xy);
    t1.y = dot(t1.zw, t1.zw);
    t1.xy = sqrt(t1.xy);
    tb7 = t1.x==0.0;
    t1.x = float(1.0) / t1.x;
    t2.xy = (bool(tb7)) ? vec2(0.0, 0.0) : t1.xx;
    tb1 = t1.y==0.0;
    t4 = float(1.0) / t1.y;
    t2.zw = (bool(tb1)) ? vec2(0.0, 0.0) : vec2(t4);
    t10_1 = texture(_Buffer1, vs_TEXCOORD0.xy);
    SV_Target0 = t2 * t10_1;
    t0.x = dot(t0.xy, t0.xy);
    t0.y = dot(t0.zw, t0.zw);
    t0.xy = sqrt(t0.xy);
    tb6 = t0.x==0.0;
    t0.x = float(1.0) / t0.x;
    t1.xy = (bool(tb6)) ? vec2(0.0, 0.0) : t0.xx;
    tb0.x = t0.y==0.0;
    t3 = float(1.0) / t0.y;
    t1.zw = (tb0.x) ? vec2(0.0, 0.0) : vec2(t3);
    t10_0 = texture(_Buffer2, vs_TEXCOORD0.xy);
    SV_Target1 = t1 * t10_0;
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
// Stats: 27 math, 2 textures
Vector 0 [_InverseGridSizes]
SetTexture 0 [_Buffer1] 2D 0
SetTexture 1 [_Buffer2] 2D 1
"ps_3_0
def c1, 0.5, -1, 0, 0
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
add r0, c1.x, -v0.xyxy
add r1, c1.y, v0.xyxy
cmp r0, r0, v0.xyxy, r1
mul r1, r0.zwzw, c0.xxyy
mul r0, r0, c0.zzww
dp2add r1.x, r1, r1, c1.z
dp2add r1.y, r1.zwzw, r1.zwzw, c1.z
rsq r1.y, r1.y
rsq r1.x, r1.x
rcp r1.z, r1.x
cmp r2.xy, -r1.z, c1.z, r1.x
rcp r1.x, r1.y
cmp r2.zw, -r1.x, c1.z, r1.y
texld r1, v0, s0
mul oC0, r2, r1
dp2add r0.x, r0, r0, c1.z
dp2add r0.y, r0.zwzw, r0.zwzw, c1.z
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.z, r0.x
cmp r1.xy, -r0.z, c1.z, r0.x
rcp r0.x, r0.y
cmp r1.zw, -r0.x, c1.z, r0.y
texld r0, v0, s1
mul oC1, r1, r0

"
}
SubProgram "d3d11 " {
// Stats: 20 math, 2 textures
SetTexture 0 [_Buffer1] 2D 0
SetTexture 1 [_Buffer2] 2D 1
ConstBuffer "$Globals" 112
Vector 96 [_InverseGridSizes]
BindCB  "$Globals" 0
"ps_4_0
root12:acabacaa
eefiecedefhappkkcejiciciamdmjjolmdeekgaiabaaaaaapeaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmaeaaaaeaaaaaaaahabaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacadaaaaaadbaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadpegbebaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdhaaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
egbebaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaogaobaaaaaaaaaaaagifcaaa
aaaaaaaaagaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaakgipcaaa
aaaaaaaaagaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaapaaaaahccaabaaaabaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaabiaaaaahecaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaadhaaaaamdcaabaaa
acaaaaaakgakbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
agaabaaaabaaaaaabiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadhaaaaammcaabaaaacaaaaaaagaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgafbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpccabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahccaabaaa
aaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafdcaabaaaaaaaaaaa
egaabaaaaaaaaaaabiaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaadhaaaaamdcaabaaaabaaaaaakgakbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaabiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dhaaaaammcaabaaaabaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahpccabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
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