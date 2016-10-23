// Compiled shader for custom platforms, uncompressed size: 19.4KB

Shader "Custom/VolumeDepth" {
SubShader { 
 Tags { "RenderType"="Opaque" "IgnoreProjector"="True"}


 // Stats for Vertex shader:
 //       d3d11 : 35 math
 //        d3d9 : 40 math
 //        gles : 1 math
 //      opengl : 1 math
 // Stats for Fragment shader:
 //       d3d11 : 1 math
 //        d3d9 : 2 math
 Pass {
  Tags { "RenderType"="Opaque" }
  GpuProgramID 2647
Program "vp" {
SubProgram "opengl " {
// Stats: 1 math
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _World2Object;

uniform vec3 _Godray_WorldSunDir;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _Godray_WorldSunDir;
  vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = (_World2Object * tmpvar_3).xyz;
  tmpvar_1 = (gl_ModelViewMatrix * gl_Vertex);
  vec3 tmpvar_5;
  tmpvar_5 = normalize((gl_ModelViewMatrix * tmpvar_4).xyz);
  vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = gl_Normal;
  float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, (gl_ModelViewMatrix * tmpvar_6).xyz);
  float tmpvar_8;
  if ((tmpvar_7 < 0.0)) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  float tmpvar_9;
  if ((tmpvar_5.z < 0.0)) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  vec3 tmpvar_10;
  if (((tmpvar_9 * tmpvar_8) > 0.0)) {
    vec3 linePoint_11;
    linePoint_11 = tmpvar_1.xyz;
    vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    float length_13;
    length_13 = (-(tmpvar_1.xyz).z / lineVec_12.z);
    vec3 tmpvar_14;
    if ((length_13 > 600.0)) {
      tmpvar_14 = (tmpvar_1.xyz + (normalize(lineVec_12) * (length_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_1.xyz - (tmpvar_5 * (tmpvar_8 * 1000000.0)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  tmpvar_2 = (gl_ProjectionMatrix * tmpvar_1);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_2.zw;
}


#endif
#ifdef FRAGMENT
varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_FragData[0] = vec4((xlv_TEXCOORD0.x / xlv_TEXCOORD0.y));
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 40 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 8 [_World2Object] 3
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Vector 11 [_Godray_WorldSunDir]
"vs_3_0
def c12, 0, 600, -600, 1000000
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xy
dp3 r0.x, c0, v1
dp3 r0.y, c1, v1
dp3 r0.z, c2, v1
mov r1.xyz, c11
dp3 r2.x, c8, r1
dp3 r2.y, c9, r1
dp3 r2.z, c10, r1
dp3 r1.x, c0, r2
dp3 r1.y, c1, r2
dp3 r1.z, c2, r2
nrm r2.xyz, r1
dp3 r0.x, r2, r0
slt r0.x, r0.x, c12.x
slt r0.y, r2.z, c12.x
mul r0.y, r0.x, r0.y
mul r0.x, r0.x, c12.w
nrm r1.xyz, -r2
rcp r0.z, -r2.z
dp4 r3.z, c2, v0
mad r0.w, -r3.z, r0.z, c12.z
mul r0.z, r0.z, -r3.z
slt r0.z, c12.y, r0.z
mul r1.xyz, r0.w, r1
dp4 r3.x, c0, v0
dp4 r3.y, c1, v0
mad r1.xyz, r0.z, r1, r3
mad r0.xzw, r2.xyyz, -r0.x, r3.xyyz
lrp r2.xyz, r0.y, r1, r0.xzww
dp4 r2.w, c3, v0
dp4 o0.x, c4, r2
dp4 o0.y, c5, r2
dp4 r0.z, c6, r2
dp4 r0.w, c7, r2
mov o0.zw, r0
mov o1.xy, r0.zwzw

"
}
SubProgram "d3d11 " {
// Stats: 35 math
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 112
Vector 96 [_Godray_WorldSunDir] 3
ConstBuffer "UnityPerDraw" 352
Matrix 64 [glstate_matrix_modelview0]
Matrix 256 [_World2Object]
ConstBuffer "UnityPerFrame" 256
Matrix 0 [glstate_matrix_projection]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityPerFrame" 2
"vs_4_0
root12:aaadaaaa
eefiecedkhllfeblndhfpaiohllflhppbjbafhffabaaaaaageagaaaaadaaaaaa
cmaaaaaahmaaaaaaneaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagiaaaaacaeaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
aaaaaaaaagaaaaaaegiccaaaabaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabaaaaaaaagiacaaaaaaaaaaaagaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaa
agaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaabaaaaaaafaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaa
aeaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaabaaaaaaagaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabaaaaaajicaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaaihcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaaipcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaafaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaabaaaaaaaeaaaaaaagbabaaaaaaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaabaaaaaaagaaaaaa
kgbkbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
abaaaaaaahaaaaaapgbpbaaaaaaaaaaaegaobaaaacaaaaaaaoaaaaahicaabaaa
aaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaabgmedbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaabgeedkaabaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaacaaaaaadhaaaaajhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaadaaaaaafgbfbaaaabaaaaaa
egiccaaaabaaaaaaafaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaabaaaaaa
aeaaaaaaagbabaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaabaaaaaaagaaaaaakgbkbaaaabaaaaaaegacbaaaadaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaaabaaaaakdcaabaaaadaaaaaa
pgapbaaaabaaaaaaaceaaaaaaaaaiadpaaceheejaaaaaaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaakhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaafgafbaaaadaaaaaaegacbaaaacaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaacaaaaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgapbaaaacaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaogakbaaaaaaaaaaa
doaaaaab"
}
SubProgram "gles " {
// Stats: 1 math
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec3 _Godray_WorldSunDir;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _Godray_WorldSunDir;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = (_World2Object * tmpvar_3).xyz;
  tmpvar_1 = (glstate_matrix_modelview0 * _glesVertex);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((glstate_matrix_modelview0 * tmpvar_4).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = _glesNormal;
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, (glstate_matrix_modelview0 * tmpvar_6).xyz);
  highp float tmpvar_8;
  if ((tmpvar_7 < 0.0)) {
    tmpvar_8 = 1.0;
  } else {
    tmpvar_8 = 0.0;
  };
  highp float tmpvar_9;
  if ((tmpvar_5.z < 0.0)) {
    tmpvar_9 = 1.0;
  } else {
    tmpvar_9 = 0.0;
  };
  highp vec3 tmpvar_10;
  if (((tmpvar_9 * tmpvar_8) > 0.0)) {
    highp vec3 linePoint_11;
    linePoint_11 = tmpvar_1.xyz;
    highp vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    highp float length_13;
    length_13 = (-(tmpvar_1.xyz).z / lineVec_12.z);
    highp vec3 tmpvar_14;
    if ((length_13 > 600.0)) {
      tmpvar_14 = (tmpvar_1.xyz + (normalize(lineVec_12) * (length_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_1.xyz - (tmpvar_5 * (tmpvar_8 * 1000000.0)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  tmpvar_2 = (glstate_matrix_projection * tmpvar_1);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_2.zw;
}


#endif
#ifdef FRAGMENT
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = vec4((xlv_TEXCOORD0.x / xlv_TEXCOORD0.y));
  gl_FragData[0] = tmpvar_1;
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
uniform 	vec3 _Godray_WorldSunDir;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
out highp vec2 vs_TEXCOORD0;
highp vec4 t0;
highp vec4 t1;
highp vec4 t2;
highp vec3 t3;
highp float t12;
bool tb12;
highp float t13;
bool tb13;
void main()
{
    t0.xyz = _World2Object[1].xyz * _Godray_WorldSunDir.xyzx.yyy;
    t0.xyz = _World2Object[0].xyz * _Godray_WorldSunDir.xyzx.xxx + t0.xyz;
    t0.xyz = _World2Object[2].xyz * _Godray_WorldSunDir.xyzx.zzz + t0.xyz;
    t1.xyz = t0.yyy * glstate_matrix_modelview0[1].xyz;
    t0.xyw = glstate_matrix_modelview0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = glstate_matrix_modelview0[2].xyz * t0.zzz + t0.xyw;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t12 = dot((-t0.xyz), (-t0.xyz));
    t12 = inversesqrt(t12);
    t1.xyz = vec3(t12) * (-t0.xyz);
    t2 = in_POSITION0.yyyy * glstate_matrix_modelview0[1];
    t2 = glstate_matrix_modelview0[0] * in_POSITION0.xxxx + t2;
    t2 = glstate_matrix_modelview0[2] * in_POSITION0.zzzz + t2;
    t2 = glstate_matrix_modelview0[3] * in_POSITION0.wwww + t2;
    t12 = t2.z / t0.z;
    t13 = t12 + -600.0;
    tb12 = 600.0<t12;
    t1.xyz = t1.xyz * vec3(t13) + t2.xyz;
    t1.xyz = (bool(tb12)) ? t1.xyz : t2.xyz;
    tb12 = t0.z<0.0;
    t12 = tb12 ? 1.0 : float(0.0);
    t3.xyz = in_NORMAL0.yyy * glstate_matrix_modelview0[1].xyz;
    t3.xyz = glstate_matrix_modelview0[0].xyz * in_NORMAL0.xxx + t3.xyz;
    t3.xyz = glstate_matrix_modelview0[2].xyz * in_NORMAL0.zzz + t3.xyz;
    t13 = dot(t0.xyz, t3.xyz);
    tb13 = t13<0.0;
    t3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1000000.0), vec2(bvec2(tb13)));
    t12 = t12 * t3.x;
    t0.xyz = (-t0.xyz) * t3.yyy + t2.xyz;
    tb12 = 0.0<t12;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    t1 = t0.yyyy * glstate_matrix_projection[1];
    t1 = glstate_matrix_projection[0] * t0.xxxx + t1;
    t0 = glstate_matrix_projection[2] * t0.zzzz + t1;
    t0 = glstate_matrix_projection[3] * t2.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = t0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD0.xxxx / vs_TEXCOORD0.yyyy;
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
uniform 	vec3 _Godray_WorldSunDir;
in  vec4 in_POSITION0;
in  vec3 in_NORMAL0;
out vec2 vs_TEXCOORD0;
vec4 t0;
vec4 t1;
vec4 t2;
vec3 t3;
float t12;
bool tb12;
float t13;
bool tb13;
void main()
{
    t0.xyz = _World2Object[1].xyz * _Godray_WorldSunDir.xyzx.yyy;
    t0.xyz = _World2Object[0].xyz * _Godray_WorldSunDir.xyzx.xxx + t0.xyz;
    t0.xyz = _World2Object[2].xyz * _Godray_WorldSunDir.xyzx.zzz + t0.xyz;
    t1.xyz = t0.yyy * glstate_matrix_modelview0[1].xyz;
    t0.xyw = glstate_matrix_modelview0[0].xyz * t0.xxx + t1.xyz;
    t0.xyz = glstate_matrix_modelview0[2].xyz * t0.zzz + t0.xyw;
    t12 = dot(t0.xyz, t0.xyz);
    t12 = inversesqrt(t12);
    t0.xyz = vec3(t12) * t0.xyz;
    t12 = dot((-t0.xyz), (-t0.xyz));
    t12 = inversesqrt(t12);
    t1.xyz = vec3(t12) * (-t0.xyz);
    t2 = in_POSITION0.yyyy * glstate_matrix_modelview0[1];
    t2 = glstate_matrix_modelview0[0] * in_POSITION0.xxxx + t2;
    t2 = glstate_matrix_modelview0[2] * in_POSITION0.zzzz + t2;
    t2 = glstate_matrix_modelview0[3] * in_POSITION0.wwww + t2;
    t12 = t2.z / t0.z;
    t13 = t12 + -600.0;
    tb12 = 600.0<t12;
    t1.xyz = t1.xyz * vec3(t13) + t2.xyz;
    t1.xyz = (bool(tb12)) ? t1.xyz : t2.xyz;
    tb12 = t0.z<0.0;
    t12 = tb12 ? 1.0 : float(0.0);
    t3.xyz = in_NORMAL0.yyy * glstate_matrix_modelview0[1].xyz;
    t3.xyz = glstate_matrix_modelview0[0].xyz * in_NORMAL0.xxx + t3.xyz;
    t3.xyz = glstate_matrix_modelview0[2].xyz * in_NORMAL0.zzz + t3.xyz;
    t13 = dot(t0.xyz, t3.xyz);
    tb13 = t13<0.0;
    t3.xy = mix(vec2(0.0, 0.0), vec2(1.0, 1000000.0), vec2(bvec2(tb13)));
    t12 = t12 * t3.x;
    t0.xyz = (-t0.xyz) * t3.yyy + t2.xyz;
    tb12 = 0.0<t12;
    t0.xyz = (bool(tb12)) ? t1.xyz : t0.xyz;
    t1 = t0.yyyy * glstate_matrix_projection[1];
    t1 = glstate_matrix_projection[0] * t0.xxxx + t1;
    t0 = glstate_matrix_projection[2] * t0.zzzz + t1;
    t0 = glstate_matrix_projection[3] * t2.wwww + t0;
    gl_Position = t0;
    vs_TEXCOORD0.xy = t0.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
void main()
{
    SV_Target0 = vs_TEXCOORD0.xxxx / vs_TEXCOORD0.yyyy;
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
// Stats: 2 math
"ps_3_0
dcl_texcoord v0.xy
rcp r0.x, v0.y
mul oC0, r0.x, v0.x

"
}
SubProgram "d3d11 " {
// Stats: 1 math
"ps_4_0
root12:aaaaaaaa
eefiecedigfiendmdnahegokejhhkficciamodglabaaaaaaaaabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaaaaaaa
eaaaaaaabaaaaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
aoaaaaahpccabaaaaaaaaaaaagbabaaaabaaaaaafgbfbaaaabaaaaaadoaaaaab
"
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