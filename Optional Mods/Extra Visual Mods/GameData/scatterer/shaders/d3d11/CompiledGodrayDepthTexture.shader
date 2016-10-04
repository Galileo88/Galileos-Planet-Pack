// Compiled shader for all platforms, uncompressed size: 14.1KB

Shader "Custom/VolumeDepth" {
SubShader { 
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 35 math
 //        d3d9 : 58 math
 // Stats for Fragment shader:
 //       d3d11 : 1 math
 //        d3d9 : 2 math
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

uniform mat4 _World2Object;

uniform vec3 _Godray_WorldSunDir;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _Godray_WorldSunDir;
  vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_World2Object * tmpvar_2).xyz;
  vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewMatrix * gl_Vertex);
  tmpvar_1 = tmpvar_4;
  vec3 tmpvar_5;
  tmpvar_5 = normalize((gl_ModelViewMatrix * tmpvar_3).xyz);
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
    linePoint_11 = tmpvar_4.xyz;
    vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    float tmpvar_13;
    tmpvar_13 = (-(tmpvar_4.xyz).z / lineVec_12.z);
    vec3 tmpvar_14;
    if ((tmpvar_13 > 600.0)) {
      tmpvar_14 = (tmpvar_4.xyz + (normalize(lineVec_12) * (tmpvar_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_4.xyz - (tmpvar_5 * (tmpvar_8 * 1e+06)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  vec4 tmpvar_16;
  tmpvar_16 = (gl_ProjectionMatrix * tmpvar_1);
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_16.zw;
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
// Stats: 58 math
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_projection]
Matrix 8 [_World2Object]
Vector 12 [_Godray_WorldSunDir]
"vs_3_0
dcl_position0 v0
dcl_normal0 v1
dcl_position o0
dcl_texcoord0 o1
def c13, 0.00000000, 1000000.00000000, 600.00000000, -600.00000000
def c14, 1.00000000, 0, 0, 0
mov r1.xyz, c12
mov r1.w, c13.x
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
dp4 r0.z, r1, c10
mov r0.w, c13.x
dp4 r1.z, r0, c2
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r0.xyw, r0.x, r1.xyzz
mov r1.xyz, v1
mov r1.w, c13.x
dp4 r2.z, r1, c2
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
dp3 r1.x, -r0.xyww, -r0.xyww
dp3 r0.z, r0.xyww, r2
rsq r1.x, r1.x
slt r0.z, r0, c13.x
max r0.z, -r0, r0
slt r0.z, c13.x, r0
add r1.w, r0.z, c13.x
mul r2.xyz, r1.x, -r0.xyww
mul r1.xyz, r0.xyww, r1.w
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad r0.xyz, -r1, c13.y, r0
slt r1.x, r0.w, c13
rcp r1.y, -r0.w
mul r0.w, -r0.z, r1.y
max r1.x, -r1, r1
slt r2.w, c13.x, r1.x
add r1.y, r0.w, c13.w
mad r1.xyz, r2, r1.y, r0
add r2.x, r2.w, c13
slt r2.y, c13.z, r0.w
mul r0.w, r2.x, r1
max r1.w, -r2.y, r2.y
slt r2.w, c13.x, r1
add r1.w, -r2, c14.x
mul r2.xyz, r0, r1.w
slt r0.w, c13.x, r0
max r0.w, -r0, r0
slt r0.w, c13.x, r0
add r1.w, -r0, c14.x
mul r0.xyz, r0, r1.w
mad r1.xyz, r2.w, r1, r2
mad r1.xyz, r0.w, r1, r0
dp4 r1.w, v0, c3
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov o0, r0
mov o1.xy, r0.zwzw
"
}
SubProgram "d3d11 " {
// Stats: 35 math
Bind "vertex" Vertex
Bind "normal" Normal
ConstBuffer "$Globals" 32
Vector 16 [_Godray_WorldSunDir] 3
ConstBuffer "UnityPerDraw" 336
Matrix 64 [glstate_matrix_modelview0]
Matrix 256 [_World2Object]
ConstBuffer "UnityPerFrame" 208
Matrix 0 [glstate_matrix_projection]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityPerFrame" 2
"vs_4_0
eefiecedapaipccnkanhjahchmdjghkjphllaoicabaaaaaageagaaaaadaaaaaa
cmaaaaaahmaaaaaaneaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafaepfdejfeejepeoaaeoepfcenebemaaepfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaa
bdaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagiaaaaacaeaaaaaadiaaaaajhcaabaaaaaaaaaaafgifcaaa
aaaaaaaaabaaaaaaegiccaaaabaaaaaabbaaaaaadcaaaaalhcaabaaaaaaaaaaa
egiccaaaabaaaaaabaaaaaaaagiacaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaabcaaaaaakgikcaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
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
"!!GLES


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
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _Godray_WorldSunDir;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_World2Object * tmpvar_2).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_modelview0 * _glesVertex);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((glstate_matrix_modelview0 * tmpvar_3).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, (glstate_matrix_modelview0 * tmpvar_6).xyz);
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
  highp vec3 tmpvar_10;
  if (((tmpvar_9 * tmpvar_8) > 0.0)) {
    highp vec3 linePoint_11;
    linePoint_11 = tmpvar_4.xyz;
    highp vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    highp float tmpvar_13;
    tmpvar_13 = (-(tmpvar_4.xyz).z / lineVec_12.z);
    highp vec3 tmpvar_14;
    if ((tmpvar_13 > 600.0)) {
      tmpvar_14 = (tmpvar_4.xyz + (normalize(lineVec_12) * (tmpvar_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_4.xyz - (tmpvar_5 * (tmpvar_8 * 1e+06)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_projection * tmpvar_1);
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_16.zw;
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



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


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
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _Godray_WorldSunDir;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_World2Object * tmpvar_2).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_modelview0 * _glesVertex);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((glstate_matrix_modelview0 * tmpvar_3).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, (glstate_matrix_modelview0 * tmpvar_6).xyz);
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
  highp vec3 tmpvar_10;
  if (((tmpvar_9 * tmpvar_8) > 0.0)) {
    highp vec3 linePoint_11;
    linePoint_11 = tmpvar_4.xyz;
    highp vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    highp float tmpvar_13;
    tmpvar_13 = (-(tmpvar_4.xyz).z / lineVec_12.z);
    highp vec3 tmpvar_14;
    if ((tmpvar_13 > 600.0)) {
      tmpvar_14 = (tmpvar_4.xyz + (normalize(lineVec_12) * (tmpvar_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_4.xyz - (tmpvar_5 * (tmpvar_8 * 1e+06)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_projection * tmpvar_1);
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_16.zw;
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



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _World2Object;
uniform highp mat4 glstate_matrix_projection;
uniform highp vec3 _Godray_WorldSunDir;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _Godray_WorldSunDir;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_World2Object * tmpvar_2).xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_modelview0 * _glesVertex);
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((glstate_matrix_modelview0 * tmpvar_3).xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesNormal);
  highp float tmpvar_7;
  tmpvar_7 = dot (tmpvar_5, (glstate_matrix_modelview0 * tmpvar_6).xyz);
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
  highp vec3 tmpvar_10;
  if (((tmpvar_9 * tmpvar_8) > 0.0)) {
    highp vec3 linePoint_11;
    linePoint_11 = tmpvar_4.xyz;
    highp vec3 lineVec_12;
    lineVec_12 = -(tmpvar_5);
    highp float tmpvar_13;
    tmpvar_13 = (-(tmpvar_4.xyz).z / lineVec_12.z);
    highp vec3 tmpvar_14;
    if ((tmpvar_13 > 600.0)) {
      tmpvar_14 = (tmpvar_4.xyz + (normalize(lineVec_12) * (tmpvar_13 - 600.0)));
    } else {
      tmpvar_14 = linePoint_11;
    };
    tmpvar_10 = tmpvar_14;
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (tmpvar_4.xyz - (tmpvar_5 * (tmpvar_8 * 1e+06)));
    tmpvar_1.xyz = tmpvar_15;
    tmpvar_10 = tmpvar_15;
  };
  tmpvar_1.xyz = tmpvar_10;
  highp vec4 tmpvar_16;
  tmpvar_16 = (glstate_matrix_projection * tmpvar_1);
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_16.zw;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = vec4((xlv_TEXCOORD0.x / xlv_TEXCOORD0.y));
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 2 math
"ps_3_0
dcl_texcoord0 v0.xy
rcp r0.x, v0.y
mul oC0, v0.x, r0.x
"
}
SubProgram "d3d11 " {
// Stats: 1 math
"ps_4_0
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