// Compiled shader for all platforms, uncompressed size: 256.7KB

Shader "Sky/AtmosphereGhoss" {
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IgnoreProjector"="True" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 15 math
 //        d3d9 : 20 math, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 152 math, 1 texture, 2 branch
 //        d3d9 : 243 math, 1 texture, 1 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IgnoreProjector"="True" "RenderType"="Transparent" }
  ZWrite Off
  Cull Front
  Fog { Mode Off }
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float Rg;
uniform float Rt;
uniform mat4 _ViewProjInv;
uniform float _experimentalAtmoScale;
uniform vec3 _camPos;
uniform float _Post_Extinction_Tint;
uniform float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec3 worldPos_2;
  bool infinite_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  infinite_3 = (tmpvar_4.x == 1.0);
  vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_5.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_5.z = tmpvar_4.x;
  vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  worldPos_2 = tmpvar_7;
  float tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_7 - _camPos);
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = (2.0 * dot (tmpvar_9, _camPos));
  float tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * tmpvar_11) - ((4.0 * tmpvar_10) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_12 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_11) - sqrt(tmpvar_12)) / (2.0 * tmpvar_10));
  };
  bool tmpvar_13;
  tmpvar_13 = (tmpvar_8 > 0.0);
  if ((!(tmpvar_13) && infinite_3)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    vec3 tmpvar_14;
    tmpvar_14 = (_camPos + (tmpvar_8 * (tmpvar_7 - _camPos)));
    vec3 arg0_15;
    arg0_15 = (tmpvar_14 - _camPos);
    vec3 arg0_16;
    arg0_16 = (tmpvar_7 - _camPos);
    bool tmpvar_17;
    tmpvar_17 = (sqrt(dot (arg0_15, arg0_15)) < sqrt(dot (arg0_16, arg0_16)));
    if ((tmpvar_13 && tmpvar_17)) {
      worldPos_2 = tmpvar_14;
    };
    float tmpvar_18;
    tmpvar_18 = sqrt(dot (worldPos_2, worldPos_2));
    if ((tmpvar_18 < (Rg + 10.0))) {
      worldPos_2 = ((Rg + 10.0) * normalize(worldPos_2));
    };
    vec3 camera_19;
    camera_19 = _camPos;
    vec3 _point_20;
    _point_20 = worldPos_2;
    vec3 extinction_21;
    float mu_22;
    float rMu_23;
    float r_24;
    float d_25;
    extinction_21 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_26;
    tmpvar_26 = (worldPos_2 - _camPos);
    float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    d_25 = tmpvar_27;
    float tmpvar_28;
    tmpvar_28 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_29;
    tmpvar_29 = normalize((tmpvar_26 / tmpvar_27));
    float tmpvar_30;
    tmpvar_30 = sqrt(dot (_camPos, _camPos));
    r_24 = tmpvar_30;
    if ((tmpvar_30 < (0.9 * Rg))) {
      camera_19.y = (_camPos.y + Rg);
      _point_20.y = (worldPos_2.y + Rg);
      r_24 = sqrt(dot (camera_19, camera_19));
    };
    float tmpvar_31;
    tmpvar_31 = dot (camera_19, tmpvar_29);
    rMu_23 = tmpvar_31;
    mu_22 = (tmpvar_31 / r_24);
    vec3 tmpvar_32;
    tmpvar_32 = (_point_20 - (tmpvar_29 * clamp (1.0, 0.0, tmpvar_27)));
    _point_20 = tmpvar_32;
    float f_33;
    f_33 = (((tmpvar_31 * tmpvar_31) - (r_24 * r_24)) + (tmpvar_28 * tmpvar_28));
    float tmpvar_34;
    if ((f_33 >= 0.0)) {
      tmpvar_34 = sqrt(f_33);
    } else {
      tmpvar_34 = 1e+30;
    };
    float tmpvar_35;
    tmpvar_35 = max ((-(tmpvar_31) - tmpvar_34), 0.0);
    if (((tmpvar_35 > 0.0) && (tmpvar_35 < tmpvar_27))) {
      camera_19 = (camera_19 + (tmpvar_35 * tmpvar_29));
      float tmpvar_36;
      tmpvar_36 = (tmpvar_31 + tmpvar_35);
      rMu_23 = tmpvar_36;
      mu_22 = (tmpvar_36 / tmpvar_28);
      r_24 = tmpvar_28;
      d_25 = (tmpvar_27 - tmpvar_35);
    };
    if ((r_24 < (Rg + 1600.0))) {
      float tmpvar_37;
      tmpvar_37 = ((Rg + 1600.0) / r_24);
      r_24 = (r_24 * tmpvar_37);
      rMu_23 = (rMu_23 * tmpvar_37);
      _point_20 = (tmpvar_32 * tmpvar_37);
    };
    float tmpvar_38;
    float H_39;
    H_39 = (HR * _experimentalAtmoScale);
    vec2 tmpvar_40;
    tmpvar_40.x = mu_22;
    tmpvar_40.y = (mu_22 + (d_25 / r_24));
    vec2 tmpvar_41;
    tmpvar_41 = (sqrt(((0.5 / H_39) * r_24)) * tmpvar_40);
    vec2 tmpvar_42;
    tmpvar_42 = sign(tmpvar_41);
    vec2 tmpvar_43;
    tmpvar_43 = (tmpvar_41 * tmpvar_41);
    float tmpvar_44;
    if ((tmpvar_42.y > tmpvar_42.x)) {
      tmpvar_44 = exp(tmpvar_43.x);
    } else {
      tmpvar_44 = 0.0;
    };
    vec2 tmpvar_45;
    tmpvar_45.x = 1.0;
    tmpvar_45.y = exp(((-(d_25) / H_39) * ((d_25 / (2.0 * r_24)) + mu_22)));
    tmpvar_38 = ((sqrt(((6.2831 * H_39) * r_24)) * exp(((Rg - r_24) / H_39))) * (tmpvar_44 + dot (((tmpvar_42 / ((2.3193 * abs(tmpvar_41)) + sqrt(((1.52 * tmpvar_43) + 4.0)))) * tmpvar_45), vec2(1.0, -1.0))));
    float H_46;
    H_46 = (HM * _experimentalAtmoScale);
    vec2 tmpvar_47;
    tmpvar_47.x = mu_22;
    tmpvar_47.y = (mu_22 + (d_25 / r_24));
    vec2 tmpvar_48;
    tmpvar_48 = (sqrt(((0.5 / H_46) * r_24)) * tmpvar_47);
    vec2 tmpvar_49;
    tmpvar_49 = sign(tmpvar_48);
    vec2 tmpvar_50;
    tmpvar_50 = (tmpvar_48 * tmpvar_48);
    float tmpvar_51;
    if ((tmpvar_49.y > tmpvar_49.x)) {
      tmpvar_51 = exp(tmpvar_50.x);
    } else {
      tmpvar_51 = 0.0;
    };
    vec2 tmpvar_52;
    tmpvar_52.x = 1.0;
    tmpvar_52.y = exp(((-(d_25) / H_46) * ((d_25 / (2.0 * r_24)) + mu_22)));
    extinction_21 = min (exp(((-(betaR) * tmpvar_38) - (betaMEx * ((sqrt(((6.2831 * H_46) * r_24)) * exp(((Rg - r_24) / H_46))) * (tmpvar_51 + dot (((tmpvar_49 / ((2.3193 * abs(tmpvar_48)) + sqrt(((1.52 * tmpvar_50) + 4.0)))) * tmpvar_52), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    float tmpvar_53;
    tmpvar_53 = (((extinction_21.x + extinction_21.y) + extinction_21.z) / 3.0);
    vec3 tmpvar_54;
    tmpvar_54.x = ((_Post_Extinction_Tint * extinction_21.x) + ((1.0 - _Post_Extinction_Tint) * tmpvar_53));
    tmpvar_54.y = ((_Post_Extinction_Tint * extinction_21.y) + ((1.0 - _Post_Extinction_Tint) * tmpvar_53));
    tmpvar_54.z = ((_Post_Extinction_Tint * extinction_21.z) + ((1.0 - _Post_Extinction_Tint) * tmpvar_53));
    vec4 tmpvar_55;
    tmpvar_55.w = 1.0;
    tmpvar_55.xyz = mix (vec3(1.0, 1.0, 1.0), tmpvar_54, vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_55;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math, 1 branches
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c11, 0.50000000, 0.00000000, 1.00000000, 0
dcl_position0 v0
dp4 r1.z, v0, c7
dp4 r0.x, v0, c4
rcp r0.z, r1.z
mov r0.w, r1.z
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c11.x
mov r1.w, c11.y
mov r1.x, r2
mul r1.y, r2, c8.x
mad r1.xy, r2.z, c9.zwzw, r1
mul r2.zw, r1.xyxy, r0.z
mov r2.xy, r2.zwzw
dp4 r0.z, v0, c6
if_lt c10.y, r1.w
add r2.y, -r2, c11.z
endif
mov o0, r0
dp4 r0.x, v0, c2
mov o1.xyw, r1.xyzz
mov o2.xy, r2
mov o3.xy, r2.zwzw
mov o1.z, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Bind "vertex" Vertex
ConstBuffer "$Globals" 400
Vector 304 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedhbeoekmaekcmlodplodmclggkniidjejabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcomacaaaaeaaaabaallaaaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaaaaaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaaegambaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabdaaaaaaabeaaaaaaaaaaaaa
dhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _camPos;
uniform highp float _Post_Extinction_Tint;
uniform highp float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 worldPos_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 / tmpvar_7.w).xyz;
  worldPos_2 = tmpvar_8;
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8 - _camPos);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = (2.0 * dot (tmpvar_10, _camPos));
  highp float tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_13 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
  };
  bool tmpvar_14;
  tmpvar_14 = (tmpvar_9 > 0.0);
  if ((!(tmpvar_14) && infinite_3)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (_camPos + (tmpvar_9 * (tmpvar_8 - _camPos)));
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_15 - _camPos);
    highp vec3 arg0_17;
    arg0_17 = (tmpvar_8 - _camPos);
    bool tmpvar_18;
    tmpvar_18 = (sqrt(dot (arg0_16, arg0_16)) < sqrt(dot (arg0_17, arg0_17)));
    if ((tmpvar_14 && tmpvar_18)) {
      worldPos_2 = tmpvar_15;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (worldPos_2, worldPos_2));
    if ((tmpvar_19 < (Rg + 10.0))) {
      worldPos_2 = ((Rg + 10.0) * normalize(worldPos_2));
    };
    highp vec3 camera_20;
    camera_20 = _camPos;
    highp vec3 _point_21;
    _point_21 = worldPos_2;
    highp vec3 extinction_22;
    highp float mu_23;
    highp float rMu_24;
    highp float r_25;
    highp float d_26;
    extinction_22 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_27;
    tmpvar_27 = (worldPos_2 - _camPos);
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    d_26 = tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_30;
    tmpvar_30 = normalize((tmpvar_27 / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (_camPos, _camPos));
    r_25 = tmpvar_31;
    if ((tmpvar_31 < (0.9 * Rg))) {
      camera_20.y = (_camPos.y + Rg);
      _point_21.y = (worldPos_2.y + Rg);
      r_25 = sqrt(dot (camera_20, camera_20));
    };
    highp float tmpvar_32;
    tmpvar_32 = dot (camera_20, tmpvar_30);
    rMu_24 = tmpvar_32;
    mu_23 = (tmpvar_32 / r_25);
    highp vec3 tmpvar_33;
    tmpvar_33 = (_point_21 - (tmpvar_30 * clamp (1.0, 0.0, tmpvar_28)));
    _point_21 = tmpvar_33;
    highp float f_34;
    f_34 = (((tmpvar_32 * tmpvar_32) - (r_25 * r_25)) + (tmpvar_29 * tmpvar_29));
    highp float tmpvar_35;
    if ((f_34 >= 0.0)) {
      tmpvar_35 = sqrt(f_34);
    } else {
      tmpvar_35 = 1e+30;
    };
    highp float tmpvar_36;
    tmpvar_36 = max ((-(tmpvar_32) - tmpvar_35), 0.0);
    if (((tmpvar_36 > 0.0) && (tmpvar_36 < tmpvar_28))) {
      camera_20 = (camera_20 + (tmpvar_36 * tmpvar_30));
      highp float tmpvar_37;
      tmpvar_37 = (tmpvar_32 + tmpvar_36);
      rMu_24 = tmpvar_37;
      mu_23 = (tmpvar_37 / tmpvar_29);
      r_25 = tmpvar_29;
      d_26 = (tmpvar_28 - tmpvar_36);
    };
    if ((r_25 < (Rg + 1600.0))) {
      highp float tmpvar_38;
      tmpvar_38 = ((Rg + 1600.0) / r_25);
      r_25 = (r_25 * tmpvar_38);
      rMu_24 = (rMu_24 * tmpvar_38);
      _point_21 = (tmpvar_33 * tmpvar_38);
    };
    highp float tmpvar_39;
    highp float H_40;
    H_40 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_41;
    tmpvar_41.x = mu_23;
    tmpvar_41.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_42;
    tmpvar_42 = (sqrt(((0.5 / H_40) * r_25)) * tmpvar_41);
    highp vec2 tmpvar_43;
    tmpvar_43 = sign(tmpvar_42);
    highp vec2 tmpvar_44;
    tmpvar_44 = (tmpvar_42 * tmpvar_42);
    highp float tmpvar_45;
    if ((tmpvar_43.y > tmpvar_43.x)) {
      tmpvar_45 = exp(tmpvar_44.x);
    } else {
      tmpvar_45 = 0.0;
    };
    highp vec2 tmpvar_46;
    tmpvar_46.x = 1.0;
    tmpvar_46.y = exp(((-(d_26) / H_40) * ((d_26 / (2.0 * r_25)) + mu_23)));
    tmpvar_39 = ((sqrt(((6.2831 * H_40) * r_25)) * exp(((Rg - r_25) / H_40))) * (tmpvar_45 + dot (((tmpvar_43 / ((2.3193 * abs(tmpvar_42)) + sqrt(((1.52 * tmpvar_44) + 4.0)))) * tmpvar_46), vec2(1.0, -1.0))));
    highp float H_47;
    H_47 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_48;
    tmpvar_48.x = mu_23;
    tmpvar_48.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_49;
    tmpvar_49 = (sqrt(((0.5 / H_47) * r_25)) * tmpvar_48);
    highp vec2 tmpvar_50;
    tmpvar_50 = sign(tmpvar_49);
    highp vec2 tmpvar_51;
    tmpvar_51 = (tmpvar_49 * tmpvar_49);
    highp float tmpvar_52;
    if ((tmpvar_50.y > tmpvar_50.x)) {
      tmpvar_52 = exp(tmpvar_51.x);
    } else {
      tmpvar_52 = 0.0;
    };
    highp vec2 tmpvar_53;
    tmpvar_53.x = 1.0;
    tmpvar_53.y = exp(((-(d_26) / H_47) * ((d_26 / (2.0 * r_25)) + mu_23)));
    extinction_22 = min (exp(((-(betaR) * tmpvar_39) - (betaMEx * ((sqrt(((6.2831 * H_47) * r_25)) * exp(((Rg - r_25) / H_47))) * (tmpvar_52 + dot (((tmpvar_50 / ((2.3193 * abs(tmpvar_49)) + sqrt(((1.52 * tmpvar_51) + 4.0)))) * tmpvar_53), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float tmpvar_54;
    tmpvar_54 = (((extinction_22.x + extinction_22.y) + extinction_22.z) / 3.0);
    highp vec3 tmpvar_55;
    tmpvar_55.x = ((_Post_Extinction_Tint * extinction_22.x) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.y = ((_Post_Extinction_Tint * extinction_22.y) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.z = ((_Post_Extinction_Tint * extinction_22.z) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    highp vec4 tmpvar_56;
    tmpvar_56.w = 1.0;
    tmpvar_56.xyz = mix (vec3(1.0, 1.0, 1.0), tmpvar_55, vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_56;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _camPos;
uniform highp float _Post_Extinction_Tint;
uniform highp float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 worldPos_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 / tmpvar_7.w).xyz;
  worldPos_2 = tmpvar_8;
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8 - _camPos);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = (2.0 * dot (tmpvar_10, _camPos));
  highp float tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_13 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
  };
  bool tmpvar_14;
  tmpvar_14 = (tmpvar_9 > 0.0);
  if ((!(tmpvar_14) && infinite_3)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (_camPos + (tmpvar_9 * (tmpvar_8 - _camPos)));
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_15 - _camPos);
    highp vec3 arg0_17;
    arg0_17 = (tmpvar_8 - _camPos);
    bool tmpvar_18;
    tmpvar_18 = (sqrt(dot (arg0_16, arg0_16)) < sqrt(dot (arg0_17, arg0_17)));
    if ((tmpvar_14 && tmpvar_18)) {
      worldPos_2 = tmpvar_15;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (worldPos_2, worldPos_2));
    if ((tmpvar_19 < (Rg + 10.0))) {
      worldPos_2 = ((Rg + 10.0) * normalize(worldPos_2));
    };
    highp vec3 camera_20;
    camera_20 = _camPos;
    highp vec3 _point_21;
    _point_21 = worldPos_2;
    highp vec3 extinction_22;
    highp float mu_23;
    highp float rMu_24;
    highp float r_25;
    highp float d_26;
    extinction_22 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_27;
    tmpvar_27 = (worldPos_2 - _camPos);
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    d_26 = tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_30;
    tmpvar_30 = normalize((tmpvar_27 / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (_camPos, _camPos));
    r_25 = tmpvar_31;
    if ((tmpvar_31 < (0.9 * Rg))) {
      camera_20.y = (_camPos.y + Rg);
      _point_21.y = (worldPos_2.y + Rg);
      r_25 = sqrt(dot (camera_20, camera_20));
    };
    highp float tmpvar_32;
    tmpvar_32 = dot (camera_20, tmpvar_30);
    rMu_24 = tmpvar_32;
    mu_23 = (tmpvar_32 / r_25);
    highp vec3 tmpvar_33;
    tmpvar_33 = (_point_21 - (tmpvar_30 * clamp (1.0, 0.0, tmpvar_28)));
    _point_21 = tmpvar_33;
    highp float f_34;
    f_34 = (((tmpvar_32 * tmpvar_32) - (r_25 * r_25)) + (tmpvar_29 * tmpvar_29));
    highp float tmpvar_35;
    if ((f_34 >= 0.0)) {
      tmpvar_35 = sqrt(f_34);
    } else {
      tmpvar_35 = 1e+30;
    };
    highp float tmpvar_36;
    tmpvar_36 = max ((-(tmpvar_32) - tmpvar_35), 0.0);
    if (((tmpvar_36 > 0.0) && (tmpvar_36 < tmpvar_28))) {
      camera_20 = (camera_20 + (tmpvar_36 * tmpvar_30));
      highp float tmpvar_37;
      tmpvar_37 = (tmpvar_32 + tmpvar_36);
      rMu_24 = tmpvar_37;
      mu_23 = (tmpvar_37 / tmpvar_29);
      r_25 = tmpvar_29;
      d_26 = (tmpvar_28 - tmpvar_36);
    };
    if ((r_25 < (Rg + 1600.0))) {
      highp float tmpvar_38;
      tmpvar_38 = ((Rg + 1600.0) / r_25);
      r_25 = (r_25 * tmpvar_38);
      rMu_24 = (rMu_24 * tmpvar_38);
      _point_21 = (tmpvar_33 * tmpvar_38);
    };
    highp float tmpvar_39;
    highp float H_40;
    H_40 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_41;
    tmpvar_41.x = mu_23;
    tmpvar_41.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_42;
    tmpvar_42 = (sqrt(((0.5 / H_40) * r_25)) * tmpvar_41);
    highp vec2 tmpvar_43;
    tmpvar_43 = sign(tmpvar_42);
    highp vec2 tmpvar_44;
    tmpvar_44 = (tmpvar_42 * tmpvar_42);
    highp float tmpvar_45;
    if ((tmpvar_43.y > tmpvar_43.x)) {
      tmpvar_45 = exp(tmpvar_44.x);
    } else {
      tmpvar_45 = 0.0;
    };
    highp vec2 tmpvar_46;
    tmpvar_46.x = 1.0;
    tmpvar_46.y = exp(((-(d_26) / H_40) * ((d_26 / (2.0 * r_25)) + mu_23)));
    tmpvar_39 = ((sqrt(((6.2831 * H_40) * r_25)) * exp(((Rg - r_25) / H_40))) * (tmpvar_45 + dot (((tmpvar_43 / ((2.3193 * abs(tmpvar_42)) + sqrt(((1.52 * tmpvar_44) + 4.0)))) * tmpvar_46), vec2(1.0, -1.0))));
    highp float H_47;
    H_47 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_48;
    tmpvar_48.x = mu_23;
    tmpvar_48.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_49;
    tmpvar_49 = (sqrt(((0.5 / H_47) * r_25)) * tmpvar_48);
    highp vec2 tmpvar_50;
    tmpvar_50 = sign(tmpvar_49);
    highp vec2 tmpvar_51;
    tmpvar_51 = (tmpvar_49 * tmpvar_49);
    highp float tmpvar_52;
    if ((tmpvar_50.y > tmpvar_50.x)) {
      tmpvar_52 = exp(tmpvar_51.x);
    } else {
      tmpvar_52 = 0.0;
    };
    highp vec2 tmpvar_53;
    tmpvar_53.x = 1.0;
    tmpvar_53.y = exp(((-(d_26) / H_47) * ((d_26 / (2.0 * r_25)) + mu_23)));
    extinction_22 = min (exp(((-(betaR) * tmpvar_39) - (betaMEx * ((sqrt(((6.2831 * H_47) * r_25)) * exp(((Rg - r_25) / H_47))) * (tmpvar_52 + dot (((tmpvar_50 / ((2.3193 * abs(tmpvar_49)) + sqrt(((1.52 * tmpvar_51) + 4.0)))) * tmpvar_53), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float tmpvar_54;
    tmpvar_54 = (((extinction_22.x + extinction_22.y) + extinction_22.z) / 3.0);
    highp vec3 tmpvar_55;
    tmpvar_55.x = ((_Post_Extinction_Tint * extinction_22.x) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.y = ((_Post_Extinction_Tint * extinction_22.y) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.z = ((_Post_Extinction_Tint * extinction_22.z) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    highp vec4 tmpvar_56;
    tmpvar_56.w = 1.0;
    tmpvar_56.xyz = mix (vec3(1.0, 1.0, 1.0), tmpvar_55, vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_56;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _camPos;
uniform highp float _Post_Extinction_Tint;
uniform highp float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 worldPos_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 / tmpvar_7.w).xyz;
  worldPos_2 = tmpvar_8;
  highp float tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_8 - _camPos);
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_10, tmpvar_10);
  highp float tmpvar_12;
  tmpvar_12 = (2.0 * dot (tmpvar_10, _camPos));
  highp float tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_13 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
  };
  bool tmpvar_14;
  tmpvar_14 = (tmpvar_9 > 0.0);
  if ((!(tmpvar_14) && infinite_3)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_15;
    tmpvar_15 = (_camPos + (tmpvar_9 * (tmpvar_8 - _camPos)));
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_15 - _camPos);
    highp vec3 arg0_17;
    arg0_17 = (tmpvar_8 - _camPos);
    bool tmpvar_18;
    tmpvar_18 = (sqrt(dot (arg0_16, arg0_16)) < sqrt(dot (arg0_17, arg0_17)));
    if ((tmpvar_14 && tmpvar_18)) {
      worldPos_2 = tmpvar_15;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (worldPos_2, worldPos_2));
    if ((tmpvar_19 < (Rg + 10.0))) {
      worldPos_2 = ((Rg + 10.0) * normalize(worldPos_2));
    };
    highp vec3 camera_20;
    camera_20 = _camPos;
    highp vec3 _point_21;
    _point_21 = worldPos_2;
    highp vec3 extinction_22;
    highp float mu_23;
    highp float rMu_24;
    highp float r_25;
    highp float d_26;
    extinction_22 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_27;
    tmpvar_27 = (worldPos_2 - _camPos);
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    d_26 = tmpvar_28;
    highp float tmpvar_29;
    tmpvar_29 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_30;
    tmpvar_30 = normalize((tmpvar_27 / tmpvar_28));
    highp float tmpvar_31;
    tmpvar_31 = sqrt(dot (_camPos, _camPos));
    r_25 = tmpvar_31;
    if ((tmpvar_31 < (0.9 * Rg))) {
      camera_20.y = (_camPos.y + Rg);
      _point_21.y = (worldPos_2.y + Rg);
      r_25 = sqrt(dot (camera_20, camera_20));
    };
    highp float tmpvar_32;
    tmpvar_32 = dot (camera_20, tmpvar_30);
    rMu_24 = tmpvar_32;
    mu_23 = (tmpvar_32 / r_25);
    highp vec3 tmpvar_33;
    tmpvar_33 = (_point_21 - (tmpvar_30 * clamp (1.0, 0.0, tmpvar_28)));
    _point_21 = tmpvar_33;
    highp float f_34;
    f_34 = (((tmpvar_32 * tmpvar_32) - (r_25 * r_25)) + (tmpvar_29 * tmpvar_29));
    highp float tmpvar_35;
    if ((f_34 >= 0.0)) {
      tmpvar_35 = sqrt(f_34);
    } else {
      tmpvar_35 = 1e+30;
    };
    highp float tmpvar_36;
    tmpvar_36 = max ((-(tmpvar_32) - tmpvar_35), 0.0);
    if (((tmpvar_36 > 0.0) && (tmpvar_36 < tmpvar_28))) {
      camera_20 = (camera_20 + (tmpvar_36 * tmpvar_30));
      highp float tmpvar_37;
      tmpvar_37 = (tmpvar_32 + tmpvar_36);
      rMu_24 = tmpvar_37;
      mu_23 = (tmpvar_37 / tmpvar_29);
      r_25 = tmpvar_29;
      d_26 = (tmpvar_28 - tmpvar_36);
    };
    if ((r_25 < (Rg + 1600.0))) {
      highp float tmpvar_38;
      tmpvar_38 = ((Rg + 1600.0) / r_25);
      r_25 = (r_25 * tmpvar_38);
      rMu_24 = (rMu_24 * tmpvar_38);
      _point_21 = (tmpvar_33 * tmpvar_38);
    };
    highp float tmpvar_39;
    highp float H_40;
    H_40 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_41;
    tmpvar_41.x = mu_23;
    tmpvar_41.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_42;
    tmpvar_42 = (sqrt(((0.5 / H_40) * r_25)) * tmpvar_41);
    highp vec2 tmpvar_43;
    tmpvar_43 = sign(tmpvar_42);
    highp vec2 tmpvar_44;
    tmpvar_44 = (tmpvar_42 * tmpvar_42);
    highp float tmpvar_45;
    if ((tmpvar_43.y > tmpvar_43.x)) {
      tmpvar_45 = exp(tmpvar_44.x);
    } else {
      tmpvar_45 = 0.0;
    };
    highp vec2 tmpvar_46;
    tmpvar_46.x = 1.0;
    tmpvar_46.y = exp(((-(d_26) / H_40) * ((d_26 / (2.0 * r_25)) + mu_23)));
    tmpvar_39 = ((sqrt(((6.2831 * H_40) * r_25)) * exp(((Rg - r_25) / H_40))) * (tmpvar_45 + dot (((tmpvar_43 / ((2.3193 * abs(tmpvar_42)) + sqrt(((1.52 * tmpvar_44) + 4.0)))) * tmpvar_46), vec2(1.0, -1.0))));
    highp float H_47;
    H_47 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_48;
    tmpvar_48.x = mu_23;
    tmpvar_48.y = (mu_23 + (d_26 / r_25));
    highp vec2 tmpvar_49;
    tmpvar_49 = (sqrt(((0.5 / H_47) * r_25)) * tmpvar_48);
    highp vec2 tmpvar_50;
    tmpvar_50 = sign(tmpvar_49);
    highp vec2 tmpvar_51;
    tmpvar_51 = (tmpvar_49 * tmpvar_49);
    highp float tmpvar_52;
    if ((tmpvar_50.y > tmpvar_50.x)) {
      tmpvar_52 = exp(tmpvar_51.x);
    } else {
      tmpvar_52 = 0.0;
    };
    highp vec2 tmpvar_53;
    tmpvar_53.x = 1.0;
    tmpvar_53.y = exp(((-(d_26) / H_47) * ((d_26 / (2.0 * r_25)) + mu_23)));
    extinction_22 = min (exp(((-(betaR) * tmpvar_39) - (betaMEx * ((sqrt(((6.2831 * H_47) * r_25)) * exp(((Rg - r_25) / H_47))) * (tmpvar_52 + dot (((tmpvar_50 / ((2.3193 * abs(tmpvar_49)) + sqrt(((1.52 * tmpvar_51) + 4.0)))) * tmpvar_53), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float tmpvar_54;
    tmpvar_54 = (((extinction_22.x + extinction_22.y) + extinction_22.z) / 3.0);
    highp vec3 tmpvar_55;
    tmpvar_55.x = ((_Post_Extinction_Tint * extinction_22.x) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.y = ((_Post_Extinction_Tint * extinction_22.y) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    tmpvar_55.z = ((_Post_Extinction_Tint * extinction_22.z) + ((1.0 - _Post_Extinction_Tint) * tmpvar_54));
    highp vec4 tmpvar_56;
    tmpvar_56.w = 1.0;
    tmpvar_56.xyz = mix (vec3(1.0, 1.0, 1.0), tmpvar_55, vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_56;
  };
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
// Stats: 243 math, 1 textures, 1 branches
Matrix 0 [_ViewProjInv]
Float 4 [HR]
Vector 5 [betaR]
Float 6 [HM]
Vector 7 [betaMEx]
Float 8 [Rg]
Float 9 [Rt]
Float 10 [_experimentalAtmoScale]
Vector 11 [_camPos]
Float 12 [_Post_Extinction_Tint]
Float 13 [postExtinctionMultiplier]
SetTexture 0 [_customDepthTexture] 2D 0
"ps_3_0
dcl_2d s0
def c14, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c15, 4.00000000, 0.89999998, -10.00000000, 10.00000000
def c16, 1000000015047466200000000000000.00000000, -1600.00000000, 1600.00000000, 6.28310013
def c17, 2.71828198, 0.50000000, 2.31929994, 0.33333334
def c18, 1.51999998, 4.00000000, 0, 0
dcl_texcoord2 v0.xy
texld r3.x, v0, s0
mad r1.xy, v0, c14.x, c14.y
mov r1.w, c14.z
mov r1.z, r3.x
dp4 r3.y, r1, c3
dp4 r2.z, r1, c2
dp4 r2.y, r1, c1
dp4 r2.x, r1, c0
rcp r1.w, r3.y
mov r1.xyz, c11
dp3 r1.y, c14.w, r1
mul r2.xyz, r2, r1.w
dp3 r1.x, c11, c11
add r1.w, r1.x, -r1.y
add r1.xyz, r2, -c11
mad r3.y, -c8.x, c8.x, r1.w
dp3 r1.w, r1, r1
dp3 r1.x, r1, c11
mul r3.y, r1.w, r3
mul r1.w, r1, c14.x
mul r1.x, r1, c14
mul r1.y, r3, c15.x
mad r1.y, r1.x, r1.x, -r1
cmp_pp r1.z, r1.y, c14, c14.w
cmp r2.w, r1.y, r2, c14.y
rsq r1.y, r1.y
rcp r1.y, r1.y
add r1.x, -r1, -r1.y
rcp r1.w, r1.w
mul r1.x, r1, r1.w
cmp r2.w, -r1.z, r2, r1.x
add r1.x, r3, c14.y
abs r1.y, r1.x
cmp r1.w, -r2, c14, c14.z
abs_pp r1.x, r1.w
cmp r1.y, -r1, c14.z, c14.w
cmp_pp r1.x, -r1, c14.z, c14.w
mul_pp r1.x, r1, r1.y
cmp_pp r1.y, -r1.x, c14.z, c14.w
cmp_pp oC0, -r1.x, r0, c14.z
if_gt r1.y, c14.w
add r0.xyz, r2, -c11
mul r1.xyz, r2.w, r0
dp3 r0.y, r0, r0
dp3 r0.x, r1, r1
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.x, r0, -r0.y
cmp r0.x, r0, c14.w, c14.z
add r1.xyz, r1, c11
mul_pp r0.x, r1.w, r0
cmp r0.xyz, -r0.x, r2, r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r1.w, r0.w
mul r1.xyz, r0.w, r0
mov r0.w, c8.x
add r0.w, c15, r0
mul r1.xyz, r0.w, r1
add r1.w, r1, -c8.x
add r0.w, r1, c15.z
cmp r0.xyz, r0.w, r0, r1
add r0.xyz, r0, -c11
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, r0
dp3 r0.x, r1, r1
rsq r2.z, r0.x
mov r0.y, c11
add r2.y, c8.x, r0
dp3 r1.w, c11, c11
rsq r1.w, r1.w
mul r1.xyz, r2.z, r1
rcp r0.w, r0.w
mov r0.xz, c11
rcp r1.w, r1.w
mov r0.y, c8.x
mad r2.x, c15.y, -r0.y, r1.w
cmp r0.y, r2.x, c11, r2
dp3 r2.y, r0, r0
dp3 r0.x, r0, r1
rsq r2.y, r2.y
rcp r0.y, r2.y
cmp r0.y, r2.x, r1.w, r0
mul r1.x, r0.y, r0.y
mov r0.z, c9.x
add r0.z, -c8.x, r0
mul r0.z, r0, c10.x
mov r1.w, c8.x
add r0.z, r0, c8.x
mad r1.x, r0, r0, -r1
mad r1.x, r0.z, r0.z, r1
rsq r1.y, r1.x
rcp r1.y, r1.y
cmp r1.x, r1, r1.y, c16
add r1.x, -r0, -r1
max r1.x, r1, c14.w
add r1.y, r1.x, -r0.w
cmp r1.z, r1.y, c14.w, c14
cmp r1.y, -r1.x, c14.w, c14.z
mul_pp r1.y, r1, r1.z
cmp r2.x, -r1.y, r0.y, r0.z
add r1.z, r2.x, -c8.x
add r2.y, r1.z, c16
mov r1.z, c6.x
mul r1.z, c10.x, r1
add r1.w, c16.z, r1
cmp r1.w, r2.y, r2.x, r1
rcp r4.y, r1.z
mul r2.x, r1.w, r4.y
mul r2.x, r2, c17.y
rsq r2.x, r2.x
rcp r2.z, r2.x
add r2.x, -r1, r0.w
cmp r3.w, -r1.y, r0, r2.x
add r1.x, r1, r0
rcp r0.y, r0.y
rcp r0.z, r0.z
rcp r2.y, r1.w
mul r0.z, r1.x, r0
mul r0.x, r0, r0.y
cmp r1.x, -r1.y, r0, r0.z
mad r1.y, r3.w, r2, r1.x
mul r0.xy, r1, r2.z
mul r2.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c14.w, c14.z
cmp r2.xy, r0, c14.w, c14.z
add r2.xy, r0.zwzw, -r2
mad r0.zw, r2, c18.x, c18.y
rsq r0.z, r0.z
rsq r0.w, r0.w
abs r0.xy, r0
mul r2.w, r1, c14.x
mul r1.z, r1.w, r1
rcp r0.z, r0.z
rcp r0.w, r0.w
mad r3.xy, r0, c17.z, r0.zwzw
rcp r0.x, r2.w
mad r4.x, r3.w, r0, r1
mul r0.y, -r3.w, r4
mul r2.w, r4.x, r0.y
pow r0, c17.x, r2.w
rcp r3.x, r3.x
rcp r3.y, r3.y
mul r0.zw, r2.xyxy, r3.xyxy
mov r0.x, c14.z
mul r0.xy, r0.zwzw, r0
mul r0.xy, r0, c14.zyzw
add r2.w, r0.x, r0.y
pow r0, c17.x, r2.z
mov r0.y, c4.x
mul r3.x, c10, r0.y
add r3.y, -r1.w, c8.x
add r2.x, r2.y, -r2
cmp r0.y, -r2.x, c14.w, r0.x
rcp r3.z, r3.x
mul r0.x, r1.w, r3.z
mul r0.x, r0, c17.y
add r2.x, r0.y, r2.w
rsq r2.y, r0.x
mul r2.z, r3.y, r4.y
pow r0, c17.x, r2.z
mul r0.y, r1.z, c16.w
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.y, r0.x, r0.z
mul r0.z, r0.y, r2.x
rcp r0.x, r2.y
mul r0.xy, r0.x, r1
mul r1.xyz, r0.z, c7
mul r2.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c14.w, c14.z
cmp r2.xy, r0, c14.w, c14.z
add r2.xy, r0.zwzw, -r2
mad r0.zw, r2, c18.x, c18.y
rsq r0.z, r0.z
rsq r0.w, r0.w
mul r2.w, r3.z, -r3
mul r2.w, r2, r4.x
abs r0.xy, r0
rcp r0.z, r0.z
rcp r0.w, r0.w
mad r4.zw, r0.xyxy, c17.z, r0
pow r0, c17.x, r2.w
rcp r4.x, r4.z
rcp r4.y, r4.w
mul r0.zw, r2.xyxy, r4.xyxy
mov r0.x, c14.z
mul r4.xy, r0.zwzw, r0
pow r0, c17.x, r2.z
mul r0.zw, r4.xyxy, c14.xyzy
mov r0.y, r0.x
add r0.x, r2.y, -r2
add r0.z, r0, r0.w
cmp r0.x, -r0, c14.w, r0.y
add r2.y, r0.x, r0.z
mul r2.x, r3.y, r3.z
pow r0, c17.x, r2.x
mul r1.w, r3.x, r1
mul r0.y, r1.w, c16.w
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r0.x, r0, r2.y
mad r1.xyz, r0.x, -c5, -r1
pow r0, c17.x, r1.x
mov r1.x, r0
pow r0, c17.x, r1.z
pow r2, c17.x, r1.y
mov r1.z, r0
mov r1.y, r2
min r0.xyz, r1, c14.z
add r0.w, r0.x, r0.y
add r1.x, r0.z, r0.w
mov r0.w, c12.x
mul r1.x, r1, c17.w
add r0.w, c14.z, -r0
mul r0.w, r0, r1.x
mad r0.xyz, r0, c12.x, r0.w
add r0.xyz, r0, c14.y
mul r0.xyz, r0, c13.x
add oC0.xyz, r0, c14.z
mov oC0.w, c14.z
endif
"
}
SubProgram "d3d11 " {
// Stats: 152 math, 1 textures, 2 branches
SetTexture 0 [_customDepthTexture] 2D 0
ConstBuffer "$Globals" 400
Matrix 160 [_ViewProjInv]
Float 52 [HR]
Vector 64 [betaR] 3
Float 76 [HM]
Vector 96 [betaMEx] 3
Float 112 [Rg]
Float 116 [Rt]
Float 228 [_experimentalAtmoScale]
Vector 272 [_camPos] 3
Float 284 [_Post_Extinction_Tint]
Float 288 [postExtinctionMultiplier]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkfjpohdkkdafnneofpicgnbmmffbdpchabaaaaaagmbfaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchmbeaaaaeaaaaaaabpafaaaafjaaaaaeegiocaaa
aaaaaaaabdaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaabiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdcaaaaapmcaabaaaaaaaaaaakgbobaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialp
diaaaaaipcaabaaaabaaaaaapgapbaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaa
dcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaa
egaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaanaaaaaaaoaaaaahncaabaaaaaaaaaaaagajbaaa
abaaaaaapgapbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaigadbaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaabbaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaabbaaaaaaaaaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaaaaaaaaabbaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaamicaabaaaacaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaackaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaabnaaaaah
icaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaa
acaaaaaabkaabaaaacaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaacaaaaaaaaaaaaahccaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadhaaaaajbcaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialpdbaaaaahccaabaaaacaaaaaa
abeaaaaaaaaaaaaaakaabaaaacaaaaaadlaaaaaficaabaaaacaaaaaabkaabaaa
acaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaacaaaaaa
bpaaaeadbkaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdoaaaaabbfaaaaabdiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaagaabaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaalgcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaa
aceaaaaaaaaaaaaaaaaacaebaaaamieeaaaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahlcaabaaaacaaaaaapgapbaaaaaaaaaaaegaibaaaaaaaaaaa
diaaaaahlcaabaaaacaaaaaafgafbaaaabaaaaaaegambaaaacaaaaaadhaaaaaj
hcaabaaaaaaaaaaaagaabaaaabaaaaaaegadbaaaacaaaaaaegacbaaaaaaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
bbaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaadaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagaabaaaadaaaaaaaaaaaaakicaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaalccaabaaa
aeaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaoaaaaaaakiacaaaaaaaaaaa
ahaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafccaabaaaabaaaaaackaabaaa
acaaaaaadiaaaaaiicaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaa
ggggggdpdbaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaajbcaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
bbaaaaaadgaaaaaggcaabaaaacaaaaaaagiccaaaaaaaaaaabbaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficaabaaa
acaaaaaadkaabaaaabaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaaaaaaaaa
bbaaaaaadhaaaaajdcaabaaaacaaaaaapgapbaaaaaaaaaaamgaabaaaacaaaaaa
egaabaaaabaaaaaadgaaaaagmcaabaaaacaaaaaaagiicaaaaaaaaaaabbaaaaaa
baaaaaahbcaabaaaaaaaaaaacgalbaaaacaaaaaaegacbaaaaaaaaaaaaoaaaaah
ecaabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaaaaaaaaaa
bnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaakccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaamkpcejpbaaaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaa
abeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaadaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaaaoaaaaahecaabaaaaeaaaaaaakaabaaaaaaaaaaabkaabaaaaeaaaaaa
aaaaaaaibcaabaaaaeaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaadaaaaaa
dgaaaaafccaabaaaadaaaaaabkaabaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaa
kgakbaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadbaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaadhaaaaajccaabaaaaaaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaaaaaaaaadiaaaaajbcaabaaa
abaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaaoaaaaaaaoaaaaah
ccaabaaaabaaaaaaabeaaaaaaaaaaadpakaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaaoaaaaahecaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
diaaaaahgcaabaaaabaaaaaakgalbaaaaaaaaaaafgafbaaaabaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaajgafbaaa
abaaaaaadbaaaaakmcaabaaaacaaaaaafgajbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaahhcaabaaaadaaaaaafgagbaaaabaaaaaafgagbaaaabaaaaaadbaaaaah
icaabaaaabaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahecaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
acaaaaaadcaaaaapmcaabaaaacaaaaaafgajbaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaafmipmcdpfmipmcdpaceaaaaaaaaaaaaaaaaaaaaaaaaaiaeaaaaaiaea
elaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadcaaaaangcaabaaaabaaaaaa
fgagbaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaa
kgalbaaaacaaaaaaaoaaaaahgcaabaaaabaaaaaaagabbaaaacaaaaaafgagbaaa
abaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
abaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaacaaaaaaaaaaaaah
ccaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaadaaaaaaakaabaaa
acaaaaaadgaaaaaifcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaadiaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaaagabbaaaadaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaajecaabaaaacaaaaaabkaabaiaebaaaaaa
aaaaaaaaakiacaaaaaaaaaaaahaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaa
acaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaadlkklidpbjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaaapaaaaakccaabaaa
abaaaaaajgafbaaaabaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
aaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaajccaabaaa
abaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaaaaaaaaaaaoaaaaaaaoaaaaah
ecaabaaaabaaaaaaabeaaaaaaaaaaadpbkaabaaaabaaaaaadiaaaaahecaabaaa
abaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahmcaabaaaaaaaaaaakgaobaaaaaaaaaaakgakbaaa
abaaaaaadbaaaaakmcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaakgaobaaaaaaaaaaadbaaaaakjcaabaaaacaaaaaakgaobaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaabaaaaaa
kgaobaiaebaaaaaaabaaaaaaagambaaaacaaaaaaclaaaaafmcaabaaaabaaaaaa
kgaobaaaabaaaaaadiaaaaahhcaabaaaaeaaaaaakgalbaaaaaaaaaaakgalbaaa
aaaaaaaadbaaaaahbcaabaaaacaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaacaaaaaaakaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaabaaaaahbcaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaajgafbaaaaeaaaaaa
aceaaaaafmipmcdpfmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaea
aaaaaaaaaaaaaaaaelaaaaafdcaabaaaadaaaaaaegaabaaaadaaaaaadcaaaaan
mcaabaaaaaaaaaaakgaobaiaibaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
gjgpbeeagjgpbeeaagaebaaaadaaaaaaaoaaaaahmcaabaaaaaaaaaaakgaobaaa
abaaaaaakgaobaaaaaaaaaaaaoaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaadaaaaaaakaabaaaaaaaaaaadiaaaaahfcaabaaa
aaaaaaaakgalbaaaaaaaaaaakgalbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaciapmjeaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aoaaaaahicaabaaaaaaaaaaackaabaaaacaaaaaabkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaaaaaaaaaapaaaaakbcaabaaaaaaaaaaaigaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaagaaaaaadcaaaaamhcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaa
aeaaaaaaagaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaa
bjaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaddaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaklkkkkdoaaaaaaajbcaabaaaabaaaaaadkiacaia
ebaaaaaaaaaaaaaabbaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaa
aaaaaaaabbaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
dcaaaaanhccabaaaaaaaaaaaagiacaaaaaaaaaaabcaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 15 math
 //        d3d9 : 20 math, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 351 avg math (341..362), 1 avg texture (1..2), 2 branch
 //        d3d9 : 524 avg math (509..539), 17 avg texture (17..18), 1 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IgnoreProjector"="True" "RenderType"="Transparent" }
  ZWrite Off
  Cull Front
  Fog { Mode Off }
  Blend OneMinusDstColor One
Program "vp" {
SubProgram "opengl " {
Keywords { "GODRAYS_OFF" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform float M_PI;
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float mieG;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform mat4 _ViewProjInv;
uniform float _experimentalAtmoScale;
uniform float _global_alpha;
uniform float _Exposure;
uniform float _global_depth;
uniform vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform float _openglThreshold;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  bool infinite_2;
  vec4 tmpvar_3;
  tmpvar_3 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  infinite_2 = (tmpvar_3.x == 1.0);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_4.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_4.z = tmpvar_3.x;
  vec4 tmpvar_5;
  tmpvar_5 = (_ViewProjInv * tmpvar_4);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_5.w).xyz;
  float tmpvar_7;
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_6 - _camPos);
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_8, tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = (2.0 * dot (tmpvar_8, _camPos));
  float tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * tmpvar_10) - ((4.0 * tmpvar_9) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_11 < 0.0)) {
    tmpvar_7 = -1.0;
  } else {
    tmpvar_7 = ((-(tmpvar_10) - sqrt(tmpvar_11)) / (2.0 * tmpvar_9));
  };
  bool tmpvar_12;
  tmpvar_12 = (tmpvar_7 > 0.0);
  if ((!(tmpvar_12) && infinite_2)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_13;
    tmpvar_13 = (_camPos + (tmpvar_7 * (tmpvar_6 - _camPos)));
    vec3 arg0_14;
    arg0_14 = (tmpvar_13 - _camPos);
    vec3 arg0_15;
    arg0_15 = (tmpvar_6 - _camPos);
    bool tmpvar_16;
    tmpvar_16 = (sqrt(dot (arg0_14, arg0_14)) < sqrt(dot (arg0_15, arg0_15)));
    vec3 tmpvar_17;
    if ((tmpvar_12 && tmpvar_16)) {
      tmpvar_17 = tmpvar_13;
    } else {
      tmpvar_17 = tmpvar_6;
    };
    float tmpvar_18;
    tmpvar_18 = sqrt(dot (tmpvar_17, tmpvar_17));
    vec3 tmpvar_19;
    if ((tmpvar_18 < (Rg + _openglThreshold))) {
      tmpvar_19 = ((Rg + _openglThreshold) * normalize(tmpvar_17));
    } else {
      tmpvar_19 = tmpvar_17;
    };
    vec3 tmpvar_20;
    vec3 camera_21;
    camera_21 = _camPos;
    vec3 _point_22;
    _point_22 = tmpvar_19;
    vec3 extinction_23;
    vec4 inScatter0_24;
    float muS1_25;
    float mu1_26;
    vec4 inScatter_27;
    float mu_28;
    float rMu_29;
    float r_30;
    float d_31;
    extinction_23 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_32;
    tmpvar_32 = (tmpvar_19 - _camPos);
    float tmpvar_33;
    tmpvar_33 = sqrt(dot (tmpvar_32, tmpvar_32));
    d_31 = tmpvar_33;
    float tmpvar_34;
    tmpvar_34 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_35;
    tmpvar_35 = normalize((tmpvar_32 / tmpvar_33));
    float tmpvar_36;
    tmpvar_36 = sqrt(dot (_camPos, _camPos));
    r_30 = tmpvar_36;
    if ((tmpvar_36 < (0.9 * Rg))) {
      camera_21.y = (_camPos.y + Rg);
      _point_22.y = (tmpvar_19.y + Rg);
      r_30 = sqrt(dot (camera_21, camera_21));
    };
    float tmpvar_37;
    tmpvar_37 = dot (camera_21, tmpvar_35);
    rMu_29 = tmpvar_37;
    mu_28 = (tmpvar_37 / r_30);
    vec3 tmpvar_38;
    tmpvar_38 = (_point_22 - (tmpvar_35 * clamp (1.0, 0.0, tmpvar_33)));
    _point_22 = tmpvar_38;
    float f_39;
    f_39 = (((tmpvar_37 * tmpvar_37) - (r_30 * r_30)) + (tmpvar_34 * tmpvar_34));
    float tmpvar_40;
    if ((f_39 >= 0.0)) {
      tmpvar_40 = sqrt(f_39);
    } else {
      tmpvar_40 = 1e+30;
    };
    float tmpvar_41;
    tmpvar_41 = max ((-(tmpvar_37) - tmpvar_40), 0.0);
    if (((tmpvar_41 > 0.0) && (tmpvar_41 < tmpvar_33))) {
      camera_21 = (camera_21 + (tmpvar_41 * tmpvar_35));
      float tmpvar_42;
      tmpvar_42 = (tmpvar_37 + tmpvar_41);
      rMu_29 = tmpvar_42;
      mu_28 = (tmpvar_42 / tmpvar_34);
      r_30 = tmpvar_34;
      d_31 = (tmpvar_33 - tmpvar_41);
    };
    float tmpvar_43;
    tmpvar_43 = dot (tmpvar_35, SUN_DIR);
    float tmpvar_44;
    tmpvar_44 = (dot (camera_21, SUN_DIR) / r_30);
    if ((r_30 < (Rg + 1600.0))) {
      float tmpvar_45;
      tmpvar_45 = ((Rg + 1600.0) / r_30);
      r_30 = (r_30 * tmpvar_45);
      rMu_29 = (rMu_29 * tmpvar_45);
      _point_22 = (tmpvar_38 * tmpvar_45);
    };
    float tmpvar_46;
    tmpvar_46 = sqrt(dot (_point_22, _point_22));
    mu1_26 = (dot (_point_22, tmpvar_35) / tmpvar_46);
    muS1_25 = (dot (_point_22, SUN_DIR) / tmpvar_46);
    float tmpvar_47;
    float H_48;
    H_48 = (HR * _experimentalAtmoScale);
    vec2 tmpvar_49;
    tmpvar_49.x = mu_28;
    tmpvar_49.y = (mu_28 + (d_31 / r_30));
    vec2 tmpvar_50;
    tmpvar_50 = (sqrt(((0.5 / H_48) * r_30)) * tmpvar_49);
    vec2 tmpvar_51;
    tmpvar_51 = sign(tmpvar_50);
    vec2 tmpvar_52;
    tmpvar_52 = (tmpvar_50 * tmpvar_50);
    float tmpvar_53;
    if ((tmpvar_51.y > tmpvar_51.x)) {
      tmpvar_53 = exp(tmpvar_52.x);
    } else {
      tmpvar_53 = 0.0;
    };
    vec2 tmpvar_54;
    tmpvar_54.x = 1.0;
    tmpvar_54.y = exp(((-(d_31) / H_48) * ((d_31 / (2.0 * r_30)) + mu_28)));
    tmpvar_47 = ((sqrt(((6.2831 * H_48) * r_30)) * exp(((Rg - r_30) / H_48))) * (tmpvar_53 + dot (((tmpvar_51 / ((2.3193 * abs(tmpvar_50)) + sqrt(((1.52 * tmpvar_52) + 4.0)))) * tmpvar_54), vec2(1.0, -1.0))));
    float H_55;
    H_55 = (HM * _experimentalAtmoScale);
    vec2 tmpvar_56;
    tmpvar_56.x = mu_28;
    tmpvar_56.y = (mu_28 + (d_31 / r_30));
    vec2 tmpvar_57;
    tmpvar_57 = (sqrt(((0.5 / H_55) * r_30)) * tmpvar_56);
    vec2 tmpvar_58;
    tmpvar_58 = sign(tmpvar_57);
    vec2 tmpvar_59;
    tmpvar_59 = (tmpvar_57 * tmpvar_57);
    float tmpvar_60;
    if ((tmpvar_58.y > tmpvar_58.x)) {
      tmpvar_60 = exp(tmpvar_59.x);
    } else {
      tmpvar_60 = 0.0;
    };
    vec2 tmpvar_61;
    tmpvar_61.x = 1.0;
    tmpvar_61.y = exp(((-(d_31) / H_55) * ((d_31 / (2.0 * r_30)) + mu_28)));
    extinction_23 = min (exp(((-(betaR) * tmpvar_47) - (betaMEx * ((sqrt(((6.2831 * H_55) * r_30)) * exp(((Rg - r_30) / H_55))) * (tmpvar_60 + dot (((tmpvar_58 / ((2.3193 * abs(tmpvar_57)) + sqrt(((1.52 * tmpvar_59) + 4.0)))) * tmpvar_61), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    float uMu_62;
    float uR_63;
    float tmpvar_64;
    tmpvar_64 = sqrt(((tmpvar_34 * tmpvar_34) - (Rg * Rg)));
    float tmpvar_65;
    tmpvar_65 = sqrt(((r_30 * r_30) - (Rg * Rg)));
    float tmpvar_66;
    tmpvar_66 = (r_30 * mu_28);
    float tmpvar_67;
    tmpvar_67 = (((tmpvar_66 * tmpvar_66) - (r_30 * r_30)) + (Rg * Rg));
    vec4 tmpvar_68;
    if (((tmpvar_66 < 0.0) && (tmpvar_67 > 0.0))) {
      vec4 tmpvar_69;
      tmpvar_69.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_69.w = (0.5 - (0.5 / RES_MU));
      tmpvar_68 = tmpvar_69;
    } else {
      vec4 tmpvar_70;
      tmpvar_70.x = -1.0;
      tmpvar_70.y = (tmpvar_64 * tmpvar_64);
      tmpvar_70.z = tmpvar_64;
      tmpvar_70.w = (0.5 + (0.5 / RES_MU));
      tmpvar_68 = tmpvar_70;
    };
    uR_63 = ((0.5 / RES_R) + ((tmpvar_65 / tmpvar_64) * (1.0 - (1.0/(RES_R)))));
    uMu_62 = (tmpvar_68.w + ((((tmpvar_66 * tmpvar_68.x) + sqrt((tmpvar_67 + tmpvar_68.y))) / (tmpvar_65 + tmpvar_68.z)) * (0.5 - (1.0/(RES_MU)))));
    float y_over_x_71;
    y_over_x_71 = (max (tmpvar_44, -0.1975) * 5.34962);
    float x_72;
    x_72 = (y_over_x_71 * inversesqrt(((y_over_x_71 * y_over_x_71) + 1.0)));
    float tmpvar_73;
    tmpvar_73 = ((0.5 / RES_MU_S) + (((((sign(x_72) * (1.5708 - (sqrt((1.0 - abs(x_72))) * (1.5708 + (abs(x_72) * (-0.214602 + (abs(x_72) * (0.0865667 + (abs(x_72) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    float tmpvar_74;
    tmpvar_74 = (((tmpvar_43 + 1.0) / 2.0) * (RES_NU - 1.0));
    float tmpvar_75;
    tmpvar_75 = floor(tmpvar_74);
    float tmpvar_76;
    tmpvar_76 = (tmpvar_74 - tmpvar_75);
    float tmpvar_77;
    tmpvar_77 = (floor(((uR_63 * RES_R) - 1.0)) / RES_R);
    float tmpvar_78;
    tmpvar_78 = (floor((uR_63 * RES_R)) / RES_R);
    float tmpvar_79;
    tmpvar_79 = fract((uR_63 * RES_R));
    vec4 tmpvar_80;
    tmpvar_80.zw = vec2(0.0, 0.0);
    tmpvar_80.x = ((tmpvar_75 + tmpvar_73) / RES_NU);
    tmpvar_80.y = ((uMu_62 / RES_R) + tmpvar_77);
    vec4 tmpvar_81;
    tmpvar_81.zw = vec2(0.0, 0.0);
    tmpvar_81.x = (((tmpvar_75 + tmpvar_73) + 1.0) / RES_NU);
    tmpvar_81.y = ((uMu_62 / RES_R) + tmpvar_77);
    vec4 tmpvar_82;
    tmpvar_82.zw = vec2(0.0, 0.0);
    tmpvar_82.x = ((tmpvar_75 + tmpvar_73) / RES_NU);
    tmpvar_82.y = ((uMu_62 / RES_R) + tmpvar_78);
    vec4 tmpvar_83;
    tmpvar_83.zw = vec2(0.0, 0.0);
    tmpvar_83.x = (((tmpvar_75 + tmpvar_73) + 1.0) / RES_NU);
    tmpvar_83.y = ((uMu_62 / RES_R) + tmpvar_78);
    inScatter0_24 = ((((texture2DLod (_Inscatter, tmpvar_80.xy, 0.0) * (1.0 - tmpvar_76)) + (texture2DLod (_Inscatter, tmpvar_81.xy, 0.0) * tmpvar_76)) * (1.0 - tmpvar_79)) + (((texture2DLod (_Inscatter, tmpvar_82.xy, 0.0) * (1.0 - tmpvar_76)) + (texture2DLod (_Inscatter, tmpvar_83.xy, 0.0) * tmpvar_76)) * tmpvar_79));
    float uMu_84;
    float uR_85;
    float tmpvar_86;
    tmpvar_86 = sqrt(((tmpvar_34 * tmpvar_34) - (Rg * Rg)));
    float tmpvar_87;
    tmpvar_87 = sqrt(((tmpvar_46 * tmpvar_46) - (Rg * Rg)));
    float tmpvar_88;
    tmpvar_88 = (tmpvar_46 * mu1_26);
    float tmpvar_89;
    tmpvar_89 = (((tmpvar_88 * tmpvar_88) - (tmpvar_46 * tmpvar_46)) + (Rg * Rg));
    vec4 tmpvar_90;
    if (((tmpvar_88 < 0.0) && (tmpvar_89 > 0.0))) {
      vec4 tmpvar_91;
      tmpvar_91.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_91.w = (0.5 - (0.5 / RES_MU));
      tmpvar_90 = tmpvar_91;
    } else {
      vec4 tmpvar_92;
      tmpvar_92.x = -1.0;
      tmpvar_92.y = (tmpvar_86 * tmpvar_86);
      tmpvar_92.z = tmpvar_86;
      tmpvar_92.w = (0.5 + (0.5 / RES_MU));
      tmpvar_90 = tmpvar_92;
    };
    uR_85 = ((0.5 / RES_R) + ((tmpvar_87 / tmpvar_86) * (1.0 - (1.0/(RES_R)))));
    uMu_84 = (tmpvar_90.w + ((((tmpvar_88 * tmpvar_90.x) + sqrt((tmpvar_89 + tmpvar_90.y))) / (tmpvar_87 + tmpvar_90.z)) * (0.5 - (1.0/(RES_MU)))));
    float y_over_x_93;
    y_over_x_93 = (max (muS1_25, -0.1975) * 5.34962);
    float x_94;
    x_94 = (y_over_x_93 * inversesqrt(((y_over_x_93 * y_over_x_93) + 1.0)));
    float tmpvar_95;
    tmpvar_95 = ((0.5 / RES_MU_S) + (((((sign(x_94) * (1.5708 - (sqrt((1.0 - abs(x_94))) * (1.5708 + (abs(x_94) * (-0.214602 + (abs(x_94) * (0.0865667 + (abs(x_94) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    float tmpvar_96;
    tmpvar_96 = (((tmpvar_43 + 1.0) / 2.0) * (RES_NU - 1.0));
    float tmpvar_97;
    tmpvar_97 = floor(tmpvar_96);
    float tmpvar_98;
    tmpvar_98 = (tmpvar_96 - tmpvar_97);
    float tmpvar_99;
    tmpvar_99 = (floor(((uR_85 * RES_R) - 1.0)) / RES_R);
    float tmpvar_100;
    tmpvar_100 = (floor((uR_85 * RES_R)) / RES_R);
    float tmpvar_101;
    tmpvar_101 = fract((uR_85 * RES_R));
    vec4 tmpvar_102;
    tmpvar_102.zw = vec2(0.0, 0.0);
    tmpvar_102.x = ((tmpvar_97 + tmpvar_95) / RES_NU);
    tmpvar_102.y = ((uMu_84 / RES_R) + tmpvar_99);
    vec4 tmpvar_103;
    tmpvar_103.zw = vec2(0.0, 0.0);
    tmpvar_103.x = (((tmpvar_97 + tmpvar_95) + 1.0) / RES_NU);
    tmpvar_103.y = ((uMu_84 / RES_R) + tmpvar_99);
    vec4 tmpvar_104;
    tmpvar_104.zw = vec2(0.0, 0.0);
    tmpvar_104.x = ((tmpvar_97 + tmpvar_95) / RES_NU);
    tmpvar_104.y = ((uMu_84 / RES_R) + tmpvar_100);
    vec4 tmpvar_105;
    tmpvar_105.zw = vec2(0.0, 0.0);
    tmpvar_105.x = (((tmpvar_97 + tmpvar_95) + 1.0) / RES_NU);
    tmpvar_105.y = ((uMu_84 / RES_R) + tmpvar_100);
    vec4 tmpvar_106;
    tmpvar_106 = max ((inScatter0_24 - (((((texture2DLod (_Inscatter, tmpvar_102.xy, 0.0) * (1.0 - tmpvar_98)) + (texture2DLod (_Inscatter, tmpvar_103.xy, 0.0) * tmpvar_98)) * (1.0 - tmpvar_101)) + (((texture2DLod (_Inscatter, tmpvar_104.xy, 0.0) * (1.0 - tmpvar_98)) + (texture2DLod (_Inscatter, tmpvar_105.xy, 0.0) * tmpvar_98)) * tmpvar_101)) * extinction_23.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_27.xyz = tmpvar_106.xyz;
    float t_107;
    t_107 = max (min ((tmpvar_44 / 0.02), 1.0), 0.0);
    inScatter_27.w = (tmpvar_106.w * (t_107 * (t_107 * (3.0 - (2.0 * t_107)))));
    tmpvar_20 = (((tmpvar_106.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_43 * tmpvar_43)))) + ((((tmpvar_106.xyz * inScatter_27.w) / max (tmpvar_106.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_43)), -1.5)) * (1.0 + (tmpvar_43 * tmpvar_43))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    float tmpvar_108;
    vec3 arg0_109;
    arg0_109 = (tmpvar_19 - _camPos);
    tmpvar_108 = sqrt(dot (arg0_109, arg0_109));
    float tmpvar_110;
    if ((tmpvar_108 <= _global_depth)) {
      tmpvar_110 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_108) / _global_depth))));
    } else {
      tmpvar_110 = 1.0;
    };
    vec3 L_111;
    vec3 tmpvar_112;
    tmpvar_112 = (tmpvar_20 * _Exposure);
    L_111 = tmpvar_112;
    float tmpvar_113;
    if ((tmpvar_112.x < 1.413)) {
      tmpvar_113 = pow ((tmpvar_112.x * 0.38317), 0.454545);
    } else {
      tmpvar_113 = (1.0 - exp(-(tmpvar_112.x)));
    };
    L_111.x = tmpvar_113;
    float tmpvar_114;
    if ((tmpvar_112.y < 1.413)) {
      tmpvar_114 = pow ((tmpvar_112.y * 0.38317), 0.454545);
    } else {
      tmpvar_114 = (1.0 - exp(-(tmpvar_112.y)));
    };
    L_111.y = tmpvar_114;
    float tmpvar_115;
    if ((tmpvar_112.z < 1.413)) {
      tmpvar_115 = pow ((tmpvar_112.z * 0.38317), 0.454545);
    } else {
      tmpvar_115 = (1.0 - exp(-(tmpvar_112.z)));
    };
    L_111.z = tmpvar_115;
    vec4 tmpvar_116;
    tmpvar_116.w = 1.0;
    tmpvar_116.xyz = ((L_111 * _global_alpha) * tmpvar_110);
    tmpvar_1 = tmpvar_116;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math, 1 branches
Keywords { "GODRAYS_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c11, 0.50000000, 0.00000000, 1.00000000, 0
dcl_position0 v0
dp4 r1.z, v0, c7
dp4 r0.x, v0, c4
rcp r0.z, r1.z
mov r0.w, r1.z
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c11.x
mov r1.w, c11.y
mov r1.x, r2
mul r1.y, r2, c8.x
mad r1.xy, r2.z, c9.zwzw, r1
mul r2.zw, r1.xyxy, r0.z
mov r2.xy, r2.zwzw
dp4 r0.z, v0, c6
if_lt c10.y, r1.w
add r2.y, -r2, c11.z
endif
mov o0, r0
dp4 r0.x, v0, c2
mov o1.xyw, r1.xyzz
mov o2.xy, r2
mov o3.xy, r2.zwzw
mov o1.z, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "GODRAYS_OFF" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 384
Vector 288 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedolhbppepeekhlhlpfmgecgplbldgmcheabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcomacaaaaeaaaabaallaaaaaafjaaaaaeegiocaaa
aaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaaaaaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaaegambaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaaabeaaaaaaaaaaaaa
dhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  bool infinite_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_3 = tmpvar_4;
  infinite_2 = (depth_3 == 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_5.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_5.z = depth_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_7 - _camPos);
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = (2.0 * dot (tmpvar_9, _camPos));
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * tmpvar_11) - ((4.0 * tmpvar_10) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_12 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_11) - sqrt(tmpvar_12)) / (2.0 * tmpvar_10));
  };
  bool tmpvar_13;
  tmpvar_13 = (tmpvar_8 > 0.0);
  if ((!(tmpvar_13) && infinite_2)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_14;
    tmpvar_14 = (_camPos + (tmpvar_8 * (tmpvar_7 - _camPos)));
    highp vec3 arg0_15;
    arg0_15 = (tmpvar_14 - _camPos);
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_7 - _camPos);
    bool tmpvar_17;
    tmpvar_17 = (sqrt(dot (arg0_15, arg0_15)) < sqrt(dot (arg0_16, arg0_16)));
    highp vec3 tmpvar_18;
    if ((tmpvar_13 && tmpvar_17)) {
      tmpvar_18 = tmpvar_14;
    } else {
      tmpvar_18 = tmpvar_7;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (tmpvar_18, tmpvar_18));
    highp vec3 tmpvar_20;
    if ((tmpvar_19 < (Rg + _openglThreshold))) {
      tmpvar_20 = ((Rg + _openglThreshold) * normalize(tmpvar_18));
    } else {
      tmpvar_20 = tmpvar_18;
    };
    highp vec3 tmpvar_21;
    highp vec3 camera_22;
    camera_22 = _camPos;
    highp vec3 _point_23;
    _point_23 = tmpvar_20;
    highp vec3 extinction_24;
    highp vec4 inScatter0_25;
    highp float muS1_26;
    highp float mu1_27;
    highp vec4 inScatter_28;
    highp float mu_29;
    highp float rMu_30;
    highp float r_31;
    highp float d_32;
    extinction_24 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_33;
    tmpvar_33 = (tmpvar_20 - _camPos);
    highp float tmpvar_34;
    tmpvar_34 = sqrt(dot (tmpvar_33, tmpvar_33));
    d_32 = tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_36;
    tmpvar_36 = normalize((tmpvar_33 / tmpvar_34));
    highp float tmpvar_37;
    tmpvar_37 = sqrt(dot (_camPos, _camPos));
    r_31 = tmpvar_37;
    if ((tmpvar_37 < (0.9 * Rg))) {
      camera_22.y = (_camPos.y + Rg);
      _point_23.y = (tmpvar_20.y + Rg);
      r_31 = sqrt(dot (camera_22, camera_22));
    };
    highp float tmpvar_38;
    tmpvar_38 = dot (camera_22, tmpvar_36);
    rMu_30 = tmpvar_38;
    mu_29 = (tmpvar_38 / r_31);
    highp vec3 tmpvar_39;
    tmpvar_39 = (_point_23 - (tmpvar_36 * clamp (1.0, 0.0, tmpvar_34)));
    _point_23 = tmpvar_39;
    highp float f_40;
    f_40 = (((tmpvar_38 * tmpvar_38) - (r_31 * r_31)) + (tmpvar_35 * tmpvar_35));
    highp float tmpvar_41;
    if ((f_40 >= 0.0)) {
      tmpvar_41 = sqrt(f_40);
    } else {
      tmpvar_41 = 1e+30;
    };
    highp float tmpvar_42;
    tmpvar_42 = max ((-(tmpvar_38) - tmpvar_41), 0.0);
    if (((tmpvar_42 > 0.0) && (tmpvar_42 < tmpvar_34))) {
      camera_22 = (camera_22 + (tmpvar_42 * tmpvar_36));
      highp float tmpvar_43;
      tmpvar_43 = (tmpvar_38 + tmpvar_42);
      rMu_30 = tmpvar_43;
      mu_29 = (tmpvar_43 / tmpvar_35);
      r_31 = tmpvar_35;
      d_32 = (tmpvar_34 - tmpvar_42);
    };
    highp float tmpvar_44;
    tmpvar_44 = dot (tmpvar_36, SUN_DIR);
    highp float tmpvar_45;
    tmpvar_45 = (dot (camera_22, SUN_DIR) / r_31);
    if ((r_31 < (Rg + 1600.0))) {
      highp float tmpvar_46;
      tmpvar_46 = ((Rg + 1600.0) / r_31);
      r_31 = (r_31 * tmpvar_46);
      rMu_30 = (rMu_30 * tmpvar_46);
      _point_23 = (tmpvar_39 * tmpvar_46);
    };
    highp float tmpvar_47;
    tmpvar_47 = sqrt(dot (_point_23, _point_23));
    mu1_27 = (dot (_point_23, tmpvar_36) / tmpvar_47);
    muS1_26 = (dot (_point_23, SUN_DIR) / tmpvar_47);
    highp float tmpvar_48;
    highp float H_49;
    H_49 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_50;
    tmpvar_50.x = mu_29;
    tmpvar_50.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_51;
    tmpvar_51 = (sqrt(((0.5 / H_49) * r_31)) * tmpvar_50);
    highp vec2 tmpvar_52;
    tmpvar_52 = sign(tmpvar_51);
    highp vec2 tmpvar_53;
    tmpvar_53 = (tmpvar_51 * tmpvar_51);
    highp float tmpvar_54;
    if ((tmpvar_52.y > tmpvar_52.x)) {
      tmpvar_54 = exp(tmpvar_53.x);
    } else {
      tmpvar_54 = 0.0;
    };
    highp vec2 tmpvar_55;
    tmpvar_55.x = 1.0;
    tmpvar_55.y = exp(((-(d_32) / H_49) * ((d_32 / (2.0 * r_31)) + mu_29)));
    tmpvar_48 = ((sqrt(((6.2831 * H_49) * r_31)) * exp(((Rg - r_31) / H_49))) * (tmpvar_54 + dot (((tmpvar_52 / ((2.3193 * abs(tmpvar_51)) + sqrt(((1.52 * tmpvar_53) + 4.0)))) * tmpvar_55), vec2(1.0, -1.0))));
    highp float H_56;
    H_56 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_57;
    tmpvar_57.x = mu_29;
    tmpvar_57.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_58;
    tmpvar_58 = (sqrt(((0.5 / H_56) * r_31)) * tmpvar_57);
    highp vec2 tmpvar_59;
    tmpvar_59 = sign(tmpvar_58);
    highp vec2 tmpvar_60;
    tmpvar_60 = (tmpvar_58 * tmpvar_58);
    highp float tmpvar_61;
    if ((tmpvar_59.y > tmpvar_59.x)) {
      tmpvar_61 = exp(tmpvar_60.x);
    } else {
      tmpvar_61 = 0.0;
    };
    highp vec2 tmpvar_62;
    tmpvar_62.x = 1.0;
    tmpvar_62.y = exp(((-(d_32) / H_56) * ((d_32 / (2.0 * r_31)) + mu_29)));
    extinction_24 = min (exp(((-(betaR) * tmpvar_48) - (betaMEx * ((sqrt(((6.2831 * H_56) * r_31)) * exp(((Rg - r_31) / H_56))) * (tmpvar_61 + dot (((tmpvar_59 / ((2.3193 * abs(tmpvar_58)) + sqrt(((1.52 * tmpvar_60) + 4.0)))) * tmpvar_62), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_63;
    highp float uR_64;
    highp float tmpvar_65;
    tmpvar_65 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_66;
    tmpvar_66 = sqrt(((r_31 * r_31) - (Rg * Rg)));
    highp float tmpvar_67;
    tmpvar_67 = (r_31 * mu_29);
    highp float tmpvar_68;
    tmpvar_68 = (((tmpvar_67 * tmpvar_67) - (r_31 * r_31)) + (Rg * Rg));
    highp vec4 tmpvar_69;
    if (((tmpvar_67 < 0.0) && (tmpvar_68 > 0.0))) {
      highp vec4 tmpvar_70;
      tmpvar_70.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_70.w = (0.5 - (0.5 / RES_MU));
      tmpvar_69 = tmpvar_70;
    } else {
      highp vec4 tmpvar_71;
      tmpvar_71.x = -1.0;
      tmpvar_71.y = (tmpvar_65 * tmpvar_65);
      tmpvar_71.z = tmpvar_65;
      tmpvar_71.w = (0.5 + (0.5 / RES_MU));
      tmpvar_69 = tmpvar_71;
    };
    uR_64 = ((0.5 / RES_R) + ((tmpvar_66 / tmpvar_65) * (1.0 - (1.0/(RES_R)))));
    uMu_63 = (tmpvar_69.w + ((((tmpvar_67 * tmpvar_69.x) + sqrt((tmpvar_68 + tmpvar_69.y))) / (tmpvar_66 + tmpvar_69.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_72;
    y_over_x_72 = (max (tmpvar_45, -0.1975) * 5.34962);
    highp float x_73;
    x_73 = (y_over_x_72 * inversesqrt(((y_over_x_72 * y_over_x_72) + 1.0)));
    highp float tmpvar_74;
    tmpvar_74 = ((0.5 / RES_MU_S) + (((((sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_75;
    tmpvar_75 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_76;
    tmpvar_76 = floor(tmpvar_75);
    highp float tmpvar_77;
    tmpvar_77 = (tmpvar_75 - tmpvar_76);
    highp float tmpvar_78;
    tmpvar_78 = (floor(((uR_64 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_79;
    tmpvar_79 = (floor((uR_64 * RES_R)) / RES_R);
    highp float tmpvar_80;
    tmpvar_80 = fract((uR_64 * RES_R));
    highp vec4 tmpvar_81;
    tmpvar_81.zw = vec2(0.0, 0.0);
    tmpvar_81.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_81.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_82;
    tmpvar_82 = texture2DLodEXT (_Inscatter, tmpvar_81.xy, 0.0);
    highp vec4 tmpvar_83;
    tmpvar_83.zw = vec2(0.0, 0.0);
    tmpvar_83.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_83.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_84;
    tmpvar_84 = texture2DLodEXT (_Inscatter, tmpvar_83.xy, 0.0);
    highp vec4 tmpvar_85;
    tmpvar_85.zw = vec2(0.0, 0.0);
    tmpvar_85.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_85.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_86;
    tmpvar_86 = texture2DLodEXT (_Inscatter, tmpvar_85.xy, 0.0);
    highp vec4 tmpvar_87;
    tmpvar_87.zw = vec2(0.0, 0.0);
    tmpvar_87.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_87.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_88;
    tmpvar_88 = texture2DLodEXT (_Inscatter, tmpvar_87.xy, 0.0);
    inScatter0_25 = ((((tmpvar_82 * (1.0 - tmpvar_77)) + (tmpvar_84 * tmpvar_77)) * (1.0 - tmpvar_80)) + (((tmpvar_86 * (1.0 - tmpvar_77)) + (tmpvar_88 * tmpvar_77)) * tmpvar_80));
    highp float uMu_89;
    highp float uR_90;
    highp float tmpvar_91;
    tmpvar_91 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_92;
    tmpvar_92 = sqrt(((tmpvar_47 * tmpvar_47) - (Rg * Rg)));
    highp float tmpvar_93;
    tmpvar_93 = (tmpvar_47 * mu1_27);
    highp float tmpvar_94;
    tmpvar_94 = (((tmpvar_93 * tmpvar_93) - (tmpvar_47 * tmpvar_47)) + (Rg * Rg));
    highp vec4 tmpvar_95;
    if (((tmpvar_93 < 0.0) && (tmpvar_94 > 0.0))) {
      highp vec4 tmpvar_96;
      tmpvar_96.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_96.w = (0.5 - (0.5 / RES_MU));
      tmpvar_95 = tmpvar_96;
    } else {
      highp vec4 tmpvar_97;
      tmpvar_97.x = -1.0;
      tmpvar_97.y = (tmpvar_91 * tmpvar_91);
      tmpvar_97.z = tmpvar_91;
      tmpvar_97.w = (0.5 + (0.5 / RES_MU));
      tmpvar_95 = tmpvar_97;
    };
    uR_90 = ((0.5 / RES_R) + ((tmpvar_92 / tmpvar_91) * (1.0 - (1.0/(RES_R)))));
    uMu_89 = (tmpvar_95.w + ((((tmpvar_93 * tmpvar_95.x) + sqrt((tmpvar_94 + tmpvar_95.y))) / (tmpvar_92 + tmpvar_95.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_98;
    y_over_x_98 = (max (muS1_26, -0.1975) * 5.34962);
    highp float x_99;
    x_99 = (y_over_x_98 * inversesqrt(((y_over_x_98 * y_over_x_98) + 1.0)));
    highp float tmpvar_100;
    tmpvar_100 = ((0.5 / RES_MU_S) + (((((sign(x_99) * (1.5708 - (sqrt((1.0 - abs(x_99))) * (1.5708 + (abs(x_99) * (-0.214602 + (abs(x_99) * (0.0865667 + (abs(x_99) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_101;
    tmpvar_101 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_102;
    tmpvar_102 = floor(tmpvar_101);
    highp float tmpvar_103;
    tmpvar_103 = (tmpvar_101 - tmpvar_102);
    highp float tmpvar_104;
    tmpvar_104 = (floor(((uR_90 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_105;
    tmpvar_105 = (floor((uR_90 * RES_R)) / RES_R);
    highp float tmpvar_106;
    tmpvar_106 = fract((uR_90 * RES_R));
    highp vec4 tmpvar_107;
    tmpvar_107.zw = vec2(0.0, 0.0);
    tmpvar_107.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_107.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_108;
    tmpvar_108 = texture2DLodEXT (_Inscatter, tmpvar_107.xy, 0.0);
    highp vec4 tmpvar_109;
    tmpvar_109.zw = vec2(0.0, 0.0);
    tmpvar_109.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_109.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_110;
    tmpvar_110 = texture2DLodEXT (_Inscatter, tmpvar_109.xy, 0.0);
    highp vec4 tmpvar_111;
    tmpvar_111.zw = vec2(0.0, 0.0);
    tmpvar_111.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_111.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_112;
    tmpvar_112 = texture2DLodEXT (_Inscatter, tmpvar_111.xy, 0.0);
    highp vec4 tmpvar_113;
    tmpvar_113.zw = vec2(0.0, 0.0);
    tmpvar_113.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_113.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_114;
    tmpvar_114 = texture2DLodEXT (_Inscatter, tmpvar_113.xy, 0.0);
    highp vec4 tmpvar_115;
    tmpvar_115 = max ((inScatter0_25 - (((((tmpvar_108 * (1.0 - tmpvar_103)) + (tmpvar_110 * tmpvar_103)) * (1.0 - tmpvar_106)) + (((tmpvar_112 * (1.0 - tmpvar_103)) + (tmpvar_114 * tmpvar_103)) * tmpvar_106)) * extinction_24.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_28.xyz = tmpvar_115.xyz;
    highp float t_116;
    t_116 = max (min ((tmpvar_45 / 0.02), 1.0), 0.0);
    inScatter_28.w = (tmpvar_115.w * (t_116 * (t_116 * (3.0 - (2.0 * t_116)))));
    tmpvar_21 = (((tmpvar_115.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_44 * tmpvar_44)))) + ((((tmpvar_115.xyz * inScatter_28.w) / max (tmpvar_115.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_44)), -1.5)) * (1.0 + (tmpvar_44 * tmpvar_44))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_117;
    highp vec3 arg0_118;
    arg0_118 = (tmpvar_20 - _camPos);
    tmpvar_117 = sqrt(dot (arg0_118, arg0_118));
    highp float tmpvar_119;
    if ((tmpvar_117 <= _global_depth)) {
      tmpvar_119 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_117) / _global_depth))));
    } else {
      tmpvar_119 = 1.0;
    };
    highp vec3 L_120;
    highp vec3 tmpvar_121;
    tmpvar_121 = (tmpvar_21 * _Exposure);
    L_120 = tmpvar_121;
    highp float tmpvar_122;
    if ((tmpvar_121.x < 1.413)) {
      tmpvar_122 = pow ((tmpvar_121.x * 0.38317), 0.454545);
    } else {
      tmpvar_122 = (1.0 - exp(-(tmpvar_121.x)));
    };
    L_120.x = tmpvar_122;
    highp float tmpvar_123;
    if ((tmpvar_121.y < 1.413)) {
      tmpvar_123 = pow ((tmpvar_121.y * 0.38317), 0.454545);
    } else {
      tmpvar_123 = (1.0 - exp(-(tmpvar_121.y)));
    };
    L_120.y = tmpvar_123;
    highp float tmpvar_124;
    if ((tmpvar_121.z < 1.413)) {
      tmpvar_124 = pow ((tmpvar_121.z * 0.38317), 0.454545);
    } else {
      tmpvar_124 = (1.0 - exp(-(tmpvar_121.z)));
    };
    L_120.z = tmpvar_124;
    highp vec4 tmpvar_125;
    tmpvar_125.w = 1.0;
    tmpvar_125.xyz = ((L_120 * _global_alpha) * tmpvar_119);
    tmpvar_1 = tmpvar_125;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "GODRAYS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  bool infinite_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_3 = tmpvar_4;
  infinite_2 = (depth_3 == 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_5.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_5.z = depth_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_7 - _camPos);
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = (2.0 * dot (tmpvar_9, _camPos));
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * tmpvar_11) - ((4.0 * tmpvar_10) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_12 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_11) - sqrt(tmpvar_12)) / (2.0 * tmpvar_10));
  };
  bool tmpvar_13;
  tmpvar_13 = (tmpvar_8 > 0.0);
  if ((!(tmpvar_13) && infinite_2)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_14;
    tmpvar_14 = (_camPos + (tmpvar_8 * (tmpvar_7 - _camPos)));
    highp vec3 arg0_15;
    arg0_15 = (tmpvar_14 - _camPos);
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_7 - _camPos);
    bool tmpvar_17;
    tmpvar_17 = (sqrt(dot (arg0_15, arg0_15)) < sqrt(dot (arg0_16, arg0_16)));
    highp vec3 tmpvar_18;
    if ((tmpvar_13 && tmpvar_17)) {
      tmpvar_18 = tmpvar_14;
    } else {
      tmpvar_18 = tmpvar_7;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (tmpvar_18, tmpvar_18));
    highp vec3 tmpvar_20;
    if ((tmpvar_19 < (Rg + _openglThreshold))) {
      tmpvar_20 = ((Rg + _openglThreshold) * normalize(tmpvar_18));
    } else {
      tmpvar_20 = tmpvar_18;
    };
    highp vec3 tmpvar_21;
    highp vec3 camera_22;
    camera_22 = _camPos;
    highp vec3 _point_23;
    _point_23 = tmpvar_20;
    highp vec3 extinction_24;
    highp vec4 inScatter0_25;
    highp float muS1_26;
    highp float mu1_27;
    highp vec4 inScatter_28;
    highp float mu_29;
    highp float rMu_30;
    highp float r_31;
    highp float d_32;
    extinction_24 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_33;
    tmpvar_33 = (tmpvar_20 - _camPos);
    highp float tmpvar_34;
    tmpvar_34 = sqrt(dot (tmpvar_33, tmpvar_33));
    d_32 = tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_36;
    tmpvar_36 = normalize((tmpvar_33 / tmpvar_34));
    highp float tmpvar_37;
    tmpvar_37 = sqrt(dot (_camPos, _camPos));
    r_31 = tmpvar_37;
    if ((tmpvar_37 < (0.9 * Rg))) {
      camera_22.y = (_camPos.y + Rg);
      _point_23.y = (tmpvar_20.y + Rg);
      r_31 = sqrt(dot (camera_22, camera_22));
    };
    highp float tmpvar_38;
    tmpvar_38 = dot (camera_22, tmpvar_36);
    rMu_30 = tmpvar_38;
    mu_29 = (tmpvar_38 / r_31);
    highp vec3 tmpvar_39;
    tmpvar_39 = (_point_23 - (tmpvar_36 * clamp (1.0, 0.0, tmpvar_34)));
    _point_23 = tmpvar_39;
    highp float f_40;
    f_40 = (((tmpvar_38 * tmpvar_38) - (r_31 * r_31)) + (tmpvar_35 * tmpvar_35));
    highp float tmpvar_41;
    if ((f_40 >= 0.0)) {
      tmpvar_41 = sqrt(f_40);
    } else {
      tmpvar_41 = 1e+30;
    };
    highp float tmpvar_42;
    tmpvar_42 = max ((-(tmpvar_38) - tmpvar_41), 0.0);
    if (((tmpvar_42 > 0.0) && (tmpvar_42 < tmpvar_34))) {
      camera_22 = (camera_22 + (tmpvar_42 * tmpvar_36));
      highp float tmpvar_43;
      tmpvar_43 = (tmpvar_38 + tmpvar_42);
      rMu_30 = tmpvar_43;
      mu_29 = (tmpvar_43 / tmpvar_35);
      r_31 = tmpvar_35;
      d_32 = (tmpvar_34 - tmpvar_42);
    };
    highp float tmpvar_44;
    tmpvar_44 = dot (tmpvar_36, SUN_DIR);
    highp float tmpvar_45;
    tmpvar_45 = (dot (camera_22, SUN_DIR) / r_31);
    if ((r_31 < (Rg + 1600.0))) {
      highp float tmpvar_46;
      tmpvar_46 = ((Rg + 1600.0) / r_31);
      r_31 = (r_31 * tmpvar_46);
      rMu_30 = (rMu_30 * tmpvar_46);
      _point_23 = (tmpvar_39 * tmpvar_46);
    };
    highp float tmpvar_47;
    tmpvar_47 = sqrt(dot (_point_23, _point_23));
    mu1_27 = (dot (_point_23, tmpvar_36) / tmpvar_47);
    muS1_26 = (dot (_point_23, SUN_DIR) / tmpvar_47);
    highp float tmpvar_48;
    highp float H_49;
    H_49 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_50;
    tmpvar_50.x = mu_29;
    tmpvar_50.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_51;
    tmpvar_51 = (sqrt(((0.5 / H_49) * r_31)) * tmpvar_50);
    highp vec2 tmpvar_52;
    tmpvar_52 = sign(tmpvar_51);
    highp vec2 tmpvar_53;
    tmpvar_53 = (tmpvar_51 * tmpvar_51);
    highp float tmpvar_54;
    if ((tmpvar_52.y > tmpvar_52.x)) {
      tmpvar_54 = exp(tmpvar_53.x);
    } else {
      tmpvar_54 = 0.0;
    };
    highp vec2 tmpvar_55;
    tmpvar_55.x = 1.0;
    tmpvar_55.y = exp(((-(d_32) / H_49) * ((d_32 / (2.0 * r_31)) + mu_29)));
    tmpvar_48 = ((sqrt(((6.2831 * H_49) * r_31)) * exp(((Rg - r_31) / H_49))) * (tmpvar_54 + dot (((tmpvar_52 / ((2.3193 * abs(tmpvar_51)) + sqrt(((1.52 * tmpvar_53) + 4.0)))) * tmpvar_55), vec2(1.0, -1.0))));
    highp float H_56;
    H_56 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_57;
    tmpvar_57.x = mu_29;
    tmpvar_57.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_58;
    tmpvar_58 = (sqrt(((0.5 / H_56) * r_31)) * tmpvar_57);
    highp vec2 tmpvar_59;
    tmpvar_59 = sign(tmpvar_58);
    highp vec2 tmpvar_60;
    tmpvar_60 = (tmpvar_58 * tmpvar_58);
    highp float tmpvar_61;
    if ((tmpvar_59.y > tmpvar_59.x)) {
      tmpvar_61 = exp(tmpvar_60.x);
    } else {
      tmpvar_61 = 0.0;
    };
    highp vec2 tmpvar_62;
    tmpvar_62.x = 1.0;
    tmpvar_62.y = exp(((-(d_32) / H_56) * ((d_32 / (2.0 * r_31)) + mu_29)));
    extinction_24 = min (exp(((-(betaR) * tmpvar_48) - (betaMEx * ((sqrt(((6.2831 * H_56) * r_31)) * exp(((Rg - r_31) / H_56))) * (tmpvar_61 + dot (((tmpvar_59 / ((2.3193 * abs(tmpvar_58)) + sqrt(((1.52 * tmpvar_60) + 4.0)))) * tmpvar_62), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_63;
    highp float uR_64;
    highp float tmpvar_65;
    tmpvar_65 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_66;
    tmpvar_66 = sqrt(((r_31 * r_31) - (Rg * Rg)));
    highp float tmpvar_67;
    tmpvar_67 = (r_31 * mu_29);
    highp float tmpvar_68;
    tmpvar_68 = (((tmpvar_67 * tmpvar_67) - (r_31 * r_31)) + (Rg * Rg));
    highp vec4 tmpvar_69;
    if (((tmpvar_67 < 0.0) && (tmpvar_68 > 0.0))) {
      highp vec4 tmpvar_70;
      tmpvar_70.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_70.w = (0.5 - (0.5 / RES_MU));
      tmpvar_69 = tmpvar_70;
    } else {
      highp vec4 tmpvar_71;
      tmpvar_71.x = -1.0;
      tmpvar_71.y = (tmpvar_65 * tmpvar_65);
      tmpvar_71.z = tmpvar_65;
      tmpvar_71.w = (0.5 + (0.5 / RES_MU));
      tmpvar_69 = tmpvar_71;
    };
    uR_64 = ((0.5 / RES_R) + ((tmpvar_66 / tmpvar_65) * (1.0 - (1.0/(RES_R)))));
    uMu_63 = (tmpvar_69.w + ((((tmpvar_67 * tmpvar_69.x) + sqrt((tmpvar_68 + tmpvar_69.y))) / (tmpvar_66 + tmpvar_69.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_72;
    y_over_x_72 = (max (tmpvar_45, -0.1975) * 5.34962);
    highp float x_73;
    x_73 = (y_over_x_72 * inversesqrt(((y_over_x_72 * y_over_x_72) + 1.0)));
    highp float tmpvar_74;
    tmpvar_74 = ((0.5 / RES_MU_S) + (((((sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_75;
    tmpvar_75 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_76;
    tmpvar_76 = floor(tmpvar_75);
    highp float tmpvar_77;
    tmpvar_77 = (tmpvar_75 - tmpvar_76);
    highp float tmpvar_78;
    tmpvar_78 = (floor(((uR_64 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_79;
    tmpvar_79 = (floor((uR_64 * RES_R)) / RES_R);
    highp float tmpvar_80;
    tmpvar_80 = fract((uR_64 * RES_R));
    highp vec4 tmpvar_81;
    tmpvar_81.zw = vec2(0.0, 0.0);
    tmpvar_81.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_81.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_82;
    tmpvar_82 = texture2DLodEXT (_Inscatter, tmpvar_81.xy, 0.0);
    highp vec4 tmpvar_83;
    tmpvar_83.zw = vec2(0.0, 0.0);
    tmpvar_83.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_83.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_84;
    tmpvar_84 = texture2DLodEXT (_Inscatter, tmpvar_83.xy, 0.0);
    highp vec4 tmpvar_85;
    tmpvar_85.zw = vec2(0.0, 0.0);
    tmpvar_85.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_85.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_86;
    tmpvar_86 = texture2DLodEXT (_Inscatter, tmpvar_85.xy, 0.0);
    highp vec4 tmpvar_87;
    tmpvar_87.zw = vec2(0.0, 0.0);
    tmpvar_87.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_87.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_88;
    tmpvar_88 = texture2DLodEXT (_Inscatter, tmpvar_87.xy, 0.0);
    inScatter0_25 = ((((tmpvar_82 * (1.0 - tmpvar_77)) + (tmpvar_84 * tmpvar_77)) * (1.0 - tmpvar_80)) + (((tmpvar_86 * (1.0 - tmpvar_77)) + (tmpvar_88 * tmpvar_77)) * tmpvar_80));
    highp float uMu_89;
    highp float uR_90;
    highp float tmpvar_91;
    tmpvar_91 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_92;
    tmpvar_92 = sqrt(((tmpvar_47 * tmpvar_47) - (Rg * Rg)));
    highp float tmpvar_93;
    tmpvar_93 = (tmpvar_47 * mu1_27);
    highp float tmpvar_94;
    tmpvar_94 = (((tmpvar_93 * tmpvar_93) - (tmpvar_47 * tmpvar_47)) + (Rg * Rg));
    highp vec4 tmpvar_95;
    if (((tmpvar_93 < 0.0) && (tmpvar_94 > 0.0))) {
      highp vec4 tmpvar_96;
      tmpvar_96.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_96.w = (0.5 - (0.5 / RES_MU));
      tmpvar_95 = tmpvar_96;
    } else {
      highp vec4 tmpvar_97;
      tmpvar_97.x = -1.0;
      tmpvar_97.y = (tmpvar_91 * tmpvar_91);
      tmpvar_97.z = tmpvar_91;
      tmpvar_97.w = (0.5 + (0.5 / RES_MU));
      tmpvar_95 = tmpvar_97;
    };
    uR_90 = ((0.5 / RES_R) + ((tmpvar_92 / tmpvar_91) * (1.0 - (1.0/(RES_R)))));
    uMu_89 = (tmpvar_95.w + ((((tmpvar_93 * tmpvar_95.x) + sqrt((tmpvar_94 + tmpvar_95.y))) / (tmpvar_92 + tmpvar_95.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_98;
    y_over_x_98 = (max (muS1_26, -0.1975) * 5.34962);
    highp float x_99;
    x_99 = (y_over_x_98 * inversesqrt(((y_over_x_98 * y_over_x_98) + 1.0)));
    highp float tmpvar_100;
    tmpvar_100 = ((0.5 / RES_MU_S) + (((((sign(x_99) * (1.5708 - (sqrt((1.0 - abs(x_99))) * (1.5708 + (abs(x_99) * (-0.214602 + (abs(x_99) * (0.0865667 + (abs(x_99) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_101;
    tmpvar_101 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_102;
    tmpvar_102 = floor(tmpvar_101);
    highp float tmpvar_103;
    tmpvar_103 = (tmpvar_101 - tmpvar_102);
    highp float tmpvar_104;
    tmpvar_104 = (floor(((uR_90 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_105;
    tmpvar_105 = (floor((uR_90 * RES_R)) / RES_R);
    highp float tmpvar_106;
    tmpvar_106 = fract((uR_90 * RES_R));
    highp vec4 tmpvar_107;
    tmpvar_107.zw = vec2(0.0, 0.0);
    tmpvar_107.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_107.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_108;
    tmpvar_108 = texture2DLodEXT (_Inscatter, tmpvar_107.xy, 0.0);
    highp vec4 tmpvar_109;
    tmpvar_109.zw = vec2(0.0, 0.0);
    tmpvar_109.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_109.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_110;
    tmpvar_110 = texture2DLodEXT (_Inscatter, tmpvar_109.xy, 0.0);
    highp vec4 tmpvar_111;
    tmpvar_111.zw = vec2(0.0, 0.0);
    tmpvar_111.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_111.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_112;
    tmpvar_112 = texture2DLodEXT (_Inscatter, tmpvar_111.xy, 0.0);
    highp vec4 tmpvar_113;
    tmpvar_113.zw = vec2(0.0, 0.0);
    tmpvar_113.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_113.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_114;
    tmpvar_114 = texture2DLodEXT (_Inscatter, tmpvar_113.xy, 0.0);
    highp vec4 tmpvar_115;
    tmpvar_115 = max ((inScatter0_25 - (((((tmpvar_108 * (1.0 - tmpvar_103)) + (tmpvar_110 * tmpvar_103)) * (1.0 - tmpvar_106)) + (((tmpvar_112 * (1.0 - tmpvar_103)) + (tmpvar_114 * tmpvar_103)) * tmpvar_106)) * extinction_24.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_28.xyz = tmpvar_115.xyz;
    highp float t_116;
    t_116 = max (min ((tmpvar_45 / 0.02), 1.0), 0.0);
    inScatter_28.w = (tmpvar_115.w * (t_116 * (t_116 * (3.0 - (2.0 * t_116)))));
    tmpvar_21 = (((tmpvar_115.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_44 * tmpvar_44)))) + ((((tmpvar_115.xyz * inScatter_28.w) / max (tmpvar_115.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_44)), -1.5)) * (1.0 + (tmpvar_44 * tmpvar_44))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_117;
    highp vec3 arg0_118;
    arg0_118 = (tmpvar_20 - _camPos);
    tmpvar_117 = sqrt(dot (arg0_118, arg0_118));
    highp float tmpvar_119;
    if ((tmpvar_117 <= _global_depth)) {
      tmpvar_119 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_117) / _global_depth))));
    } else {
      tmpvar_119 = 1.0;
    };
    highp vec3 L_120;
    highp vec3 tmpvar_121;
    tmpvar_121 = (tmpvar_21 * _Exposure);
    L_120 = tmpvar_121;
    highp float tmpvar_122;
    if ((tmpvar_121.x < 1.413)) {
      tmpvar_122 = pow ((tmpvar_121.x * 0.38317), 0.454545);
    } else {
      tmpvar_122 = (1.0 - exp(-(tmpvar_121.x)));
    };
    L_120.x = tmpvar_122;
    highp float tmpvar_123;
    if ((tmpvar_121.y < 1.413)) {
      tmpvar_123 = pow ((tmpvar_121.y * 0.38317), 0.454545);
    } else {
      tmpvar_123 = (1.0 - exp(-(tmpvar_121.y)));
    };
    L_120.y = tmpvar_123;
    highp float tmpvar_124;
    if ((tmpvar_121.z < 1.413)) {
      tmpvar_124 = pow ((tmpvar_121.z * 0.38317), 0.454545);
    } else {
      tmpvar_124 = (1.0 - exp(-(tmpvar_121.z)));
    };
    L_120.z = tmpvar_124;
    highp vec4 tmpvar_125;
    tmpvar_125.w = 1.0;
    tmpvar_125.xyz = ((L_120 * _global_alpha) * tmpvar_119);
    tmpvar_1 = tmpvar_125;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  bool infinite_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_3 = tmpvar_4;
  infinite_2 = (depth_3 == 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_5.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_5.z = depth_3;
  highp vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_7 - _camPos);
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_9, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = (2.0 * dot (tmpvar_9, _camPos));
  highp float tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * tmpvar_11) - ((4.0 * tmpvar_10) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_12 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_11) - sqrt(tmpvar_12)) / (2.0 * tmpvar_10));
  };
  bool tmpvar_13;
  tmpvar_13 = (tmpvar_8 > 0.0);
  if ((!(tmpvar_13) && infinite_2)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_14;
    tmpvar_14 = (_camPos + (tmpvar_8 * (tmpvar_7 - _camPos)));
    highp vec3 arg0_15;
    arg0_15 = (tmpvar_14 - _camPos);
    highp vec3 arg0_16;
    arg0_16 = (tmpvar_7 - _camPos);
    bool tmpvar_17;
    tmpvar_17 = (sqrt(dot (arg0_15, arg0_15)) < sqrt(dot (arg0_16, arg0_16)));
    highp vec3 tmpvar_18;
    if ((tmpvar_13 && tmpvar_17)) {
      tmpvar_18 = tmpvar_14;
    } else {
      tmpvar_18 = tmpvar_7;
    };
    highp float tmpvar_19;
    tmpvar_19 = sqrt(dot (tmpvar_18, tmpvar_18));
    highp vec3 tmpvar_20;
    if ((tmpvar_19 < (Rg + _openglThreshold))) {
      tmpvar_20 = ((Rg + _openglThreshold) * normalize(tmpvar_18));
    } else {
      tmpvar_20 = tmpvar_18;
    };
    highp vec3 tmpvar_21;
    highp vec3 camera_22;
    camera_22 = _camPos;
    highp vec3 _point_23;
    _point_23 = tmpvar_20;
    highp vec3 extinction_24;
    highp vec4 inScatter0_25;
    highp float muS1_26;
    highp float mu1_27;
    highp vec4 inScatter_28;
    highp float mu_29;
    highp float rMu_30;
    highp float r_31;
    highp float d_32;
    extinction_24 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_33;
    tmpvar_33 = (tmpvar_20 - _camPos);
    highp float tmpvar_34;
    tmpvar_34 = sqrt(dot (tmpvar_33, tmpvar_33));
    d_32 = tmpvar_34;
    highp float tmpvar_35;
    tmpvar_35 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_36;
    tmpvar_36 = normalize((tmpvar_33 / tmpvar_34));
    highp float tmpvar_37;
    tmpvar_37 = sqrt(dot (_camPos, _camPos));
    r_31 = tmpvar_37;
    if ((tmpvar_37 < (0.9 * Rg))) {
      camera_22.y = (_camPos.y + Rg);
      _point_23.y = (tmpvar_20.y + Rg);
      r_31 = sqrt(dot (camera_22, camera_22));
    };
    highp float tmpvar_38;
    tmpvar_38 = dot (camera_22, tmpvar_36);
    rMu_30 = tmpvar_38;
    mu_29 = (tmpvar_38 / r_31);
    highp vec3 tmpvar_39;
    tmpvar_39 = (_point_23 - (tmpvar_36 * clamp (1.0, 0.0, tmpvar_34)));
    _point_23 = tmpvar_39;
    highp float f_40;
    f_40 = (((tmpvar_38 * tmpvar_38) - (r_31 * r_31)) + (tmpvar_35 * tmpvar_35));
    highp float tmpvar_41;
    if ((f_40 >= 0.0)) {
      tmpvar_41 = sqrt(f_40);
    } else {
      tmpvar_41 = 1e+30;
    };
    highp float tmpvar_42;
    tmpvar_42 = max ((-(tmpvar_38) - tmpvar_41), 0.0);
    if (((tmpvar_42 > 0.0) && (tmpvar_42 < tmpvar_34))) {
      camera_22 = (camera_22 + (tmpvar_42 * tmpvar_36));
      highp float tmpvar_43;
      tmpvar_43 = (tmpvar_38 + tmpvar_42);
      rMu_30 = tmpvar_43;
      mu_29 = (tmpvar_43 / tmpvar_35);
      r_31 = tmpvar_35;
      d_32 = (tmpvar_34 - tmpvar_42);
    };
    highp float tmpvar_44;
    tmpvar_44 = dot (tmpvar_36, SUN_DIR);
    highp float tmpvar_45;
    tmpvar_45 = (dot (camera_22, SUN_DIR) / r_31);
    if ((r_31 < (Rg + 1600.0))) {
      highp float tmpvar_46;
      tmpvar_46 = ((Rg + 1600.0) / r_31);
      r_31 = (r_31 * tmpvar_46);
      rMu_30 = (rMu_30 * tmpvar_46);
      _point_23 = (tmpvar_39 * tmpvar_46);
    };
    highp float tmpvar_47;
    tmpvar_47 = sqrt(dot (_point_23, _point_23));
    mu1_27 = (dot (_point_23, tmpvar_36) / tmpvar_47);
    muS1_26 = (dot (_point_23, SUN_DIR) / tmpvar_47);
    highp float tmpvar_48;
    highp float H_49;
    H_49 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_50;
    tmpvar_50.x = mu_29;
    tmpvar_50.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_51;
    tmpvar_51 = (sqrt(((0.5 / H_49) * r_31)) * tmpvar_50);
    highp vec2 tmpvar_52;
    tmpvar_52 = sign(tmpvar_51);
    highp vec2 tmpvar_53;
    tmpvar_53 = (tmpvar_51 * tmpvar_51);
    highp float tmpvar_54;
    if ((tmpvar_52.y > tmpvar_52.x)) {
      tmpvar_54 = exp(tmpvar_53.x);
    } else {
      tmpvar_54 = 0.0;
    };
    highp vec2 tmpvar_55;
    tmpvar_55.x = 1.0;
    tmpvar_55.y = exp(((-(d_32) / H_49) * ((d_32 / (2.0 * r_31)) + mu_29)));
    tmpvar_48 = ((sqrt(((6.2831 * H_49) * r_31)) * exp(((Rg - r_31) / H_49))) * (tmpvar_54 + dot (((tmpvar_52 / ((2.3193 * abs(tmpvar_51)) + sqrt(((1.52 * tmpvar_53) + 4.0)))) * tmpvar_55), vec2(1.0, -1.0))));
    highp float H_56;
    H_56 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_57;
    tmpvar_57.x = mu_29;
    tmpvar_57.y = (mu_29 + (d_32 / r_31));
    highp vec2 tmpvar_58;
    tmpvar_58 = (sqrt(((0.5 / H_56) * r_31)) * tmpvar_57);
    highp vec2 tmpvar_59;
    tmpvar_59 = sign(tmpvar_58);
    highp vec2 tmpvar_60;
    tmpvar_60 = (tmpvar_58 * tmpvar_58);
    highp float tmpvar_61;
    if ((tmpvar_59.y > tmpvar_59.x)) {
      tmpvar_61 = exp(tmpvar_60.x);
    } else {
      tmpvar_61 = 0.0;
    };
    highp vec2 tmpvar_62;
    tmpvar_62.x = 1.0;
    tmpvar_62.y = exp(((-(d_32) / H_56) * ((d_32 / (2.0 * r_31)) + mu_29)));
    extinction_24 = min (exp(((-(betaR) * tmpvar_48) - (betaMEx * ((sqrt(((6.2831 * H_56) * r_31)) * exp(((Rg - r_31) / H_56))) * (tmpvar_61 + dot (((tmpvar_59 / ((2.3193 * abs(tmpvar_58)) + sqrt(((1.52 * tmpvar_60) + 4.0)))) * tmpvar_62), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_63;
    highp float uR_64;
    highp float tmpvar_65;
    tmpvar_65 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_66;
    tmpvar_66 = sqrt(((r_31 * r_31) - (Rg * Rg)));
    highp float tmpvar_67;
    tmpvar_67 = (r_31 * mu_29);
    highp float tmpvar_68;
    tmpvar_68 = (((tmpvar_67 * tmpvar_67) - (r_31 * r_31)) + (Rg * Rg));
    highp vec4 tmpvar_69;
    if (((tmpvar_67 < 0.0) && (tmpvar_68 > 0.0))) {
      highp vec4 tmpvar_70;
      tmpvar_70.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_70.w = (0.5 - (0.5 / RES_MU));
      tmpvar_69 = tmpvar_70;
    } else {
      highp vec4 tmpvar_71;
      tmpvar_71.x = -1.0;
      tmpvar_71.y = (tmpvar_65 * tmpvar_65);
      tmpvar_71.z = tmpvar_65;
      tmpvar_71.w = (0.5 + (0.5 / RES_MU));
      tmpvar_69 = tmpvar_71;
    };
    uR_64 = ((0.5 / RES_R) + ((tmpvar_66 / tmpvar_65) * (1.0 - (1.0/(RES_R)))));
    uMu_63 = (tmpvar_69.w + ((((tmpvar_67 * tmpvar_69.x) + sqrt((tmpvar_68 + tmpvar_69.y))) / (tmpvar_66 + tmpvar_69.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_72;
    y_over_x_72 = (max (tmpvar_45, -0.1975) * 5.34962);
    highp float x_73;
    x_73 = (y_over_x_72 * inversesqrt(((y_over_x_72 * y_over_x_72) + 1.0)));
    highp float tmpvar_74;
    tmpvar_74 = ((0.5 / RES_MU_S) + (((((sign(x_73) * (1.5708 - (sqrt((1.0 - abs(x_73))) * (1.5708 + (abs(x_73) * (-0.214602 + (abs(x_73) * (0.0865667 + (abs(x_73) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_75;
    tmpvar_75 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_76;
    tmpvar_76 = floor(tmpvar_75);
    highp float tmpvar_77;
    tmpvar_77 = (tmpvar_75 - tmpvar_76);
    highp float tmpvar_78;
    tmpvar_78 = (floor(((uR_64 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_79;
    tmpvar_79 = (floor((uR_64 * RES_R)) / RES_R);
    highp float tmpvar_80;
    tmpvar_80 = fract((uR_64 * RES_R));
    highp vec4 tmpvar_81;
    tmpvar_81.zw = vec2(0.0, 0.0);
    tmpvar_81.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_81.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_82;
    tmpvar_82 = textureLod (_Inscatter, tmpvar_81.xy, 0.0);
    highp vec4 tmpvar_83;
    tmpvar_83.zw = vec2(0.0, 0.0);
    tmpvar_83.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_83.y = ((uMu_63 / RES_R) + tmpvar_78);
    lowp vec4 tmpvar_84;
    tmpvar_84 = textureLod (_Inscatter, tmpvar_83.xy, 0.0);
    highp vec4 tmpvar_85;
    tmpvar_85.zw = vec2(0.0, 0.0);
    tmpvar_85.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
    tmpvar_85.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_86;
    tmpvar_86 = textureLod (_Inscatter, tmpvar_85.xy, 0.0);
    highp vec4 tmpvar_87;
    tmpvar_87.zw = vec2(0.0, 0.0);
    tmpvar_87.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
    tmpvar_87.y = ((uMu_63 / RES_R) + tmpvar_79);
    lowp vec4 tmpvar_88;
    tmpvar_88 = textureLod (_Inscatter, tmpvar_87.xy, 0.0);
    inScatter0_25 = ((((tmpvar_82 * (1.0 - tmpvar_77)) + (tmpvar_84 * tmpvar_77)) * (1.0 - tmpvar_80)) + (((tmpvar_86 * (1.0 - tmpvar_77)) + (tmpvar_88 * tmpvar_77)) * tmpvar_80));
    highp float uMu_89;
    highp float uR_90;
    highp float tmpvar_91;
    tmpvar_91 = sqrt(((tmpvar_35 * tmpvar_35) - (Rg * Rg)));
    highp float tmpvar_92;
    tmpvar_92 = sqrt(((tmpvar_47 * tmpvar_47) - (Rg * Rg)));
    highp float tmpvar_93;
    tmpvar_93 = (tmpvar_47 * mu1_27);
    highp float tmpvar_94;
    tmpvar_94 = (((tmpvar_93 * tmpvar_93) - (tmpvar_47 * tmpvar_47)) + (Rg * Rg));
    highp vec4 tmpvar_95;
    if (((tmpvar_93 < 0.0) && (tmpvar_94 > 0.0))) {
      highp vec4 tmpvar_96;
      tmpvar_96.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_96.w = (0.5 - (0.5 / RES_MU));
      tmpvar_95 = tmpvar_96;
    } else {
      highp vec4 tmpvar_97;
      tmpvar_97.x = -1.0;
      tmpvar_97.y = (tmpvar_91 * tmpvar_91);
      tmpvar_97.z = tmpvar_91;
      tmpvar_97.w = (0.5 + (0.5 / RES_MU));
      tmpvar_95 = tmpvar_97;
    };
    uR_90 = ((0.5 / RES_R) + ((tmpvar_92 / tmpvar_91) * (1.0 - (1.0/(RES_R)))));
    uMu_89 = (tmpvar_95.w + ((((tmpvar_93 * tmpvar_95.x) + sqrt((tmpvar_94 + tmpvar_95.y))) / (tmpvar_92 + tmpvar_95.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_98;
    y_over_x_98 = (max (muS1_26, -0.1975) * 5.34962);
    highp float x_99;
    x_99 = (y_over_x_98 * inversesqrt(((y_over_x_98 * y_over_x_98) + 1.0)));
    highp float tmpvar_100;
    tmpvar_100 = ((0.5 / RES_MU_S) + (((((sign(x_99) * (1.5708 - (sqrt((1.0 - abs(x_99))) * (1.5708 + (abs(x_99) * (-0.214602 + (abs(x_99) * (0.0865667 + (abs(x_99) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_101;
    tmpvar_101 = (((tmpvar_44 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_102;
    tmpvar_102 = floor(tmpvar_101);
    highp float tmpvar_103;
    tmpvar_103 = (tmpvar_101 - tmpvar_102);
    highp float tmpvar_104;
    tmpvar_104 = (floor(((uR_90 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_105;
    tmpvar_105 = (floor((uR_90 * RES_R)) / RES_R);
    highp float tmpvar_106;
    tmpvar_106 = fract((uR_90 * RES_R));
    highp vec4 tmpvar_107;
    tmpvar_107.zw = vec2(0.0, 0.0);
    tmpvar_107.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_107.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_108;
    tmpvar_108 = textureLod (_Inscatter, tmpvar_107.xy, 0.0);
    highp vec4 tmpvar_109;
    tmpvar_109.zw = vec2(0.0, 0.0);
    tmpvar_109.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_109.y = ((uMu_89 / RES_R) + tmpvar_104);
    lowp vec4 tmpvar_110;
    tmpvar_110 = textureLod (_Inscatter, tmpvar_109.xy, 0.0);
    highp vec4 tmpvar_111;
    tmpvar_111.zw = vec2(0.0, 0.0);
    tmpvar_111.x = ((tmpvar_102 + tmpvar_100) / RES_NU);
    tmpvar_111.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_112;
    tmpvar_112 = textureLod (_Inscatter, tmpvar_111.xy, 0.0);
    highp vec4 tmpvar_113;
    tmpvar_113.zw = vec2(0.0, 0.0);
    tmpvar_113.x = (((tmpvar_102 + tmpvar_100) + 1.0) / RES_NU);
    tmpvar_113.y = ((uMu_89 / RES_R) + tmpvar_105);
    lowp vec4 tmpvar_114;
    tmpvar_114 = textureLod (_Inscatter, tmpvar_113.xy, 0.0);
    highp vec4 tmpvar_115;
    tmpvar_115 = max ((inScatter0_25 - (((((tmpvar_108 * (1.0 - tmpvar_103)) + (tmpvar_110 * tmpvar_103)) * (1.0 - tmpvar_106)) + (((tmpvar_112 * (1.0 - tmpvar_103)) + (tmpvar_114 * tmpvar_103)) * tmpvar_106)) * extinction_24.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_28.xyz = tmpvar_115.xyz;
    highp float t_116;
    t_116 = max (min ((tmpvar_45 / 0.02), 1.0), 0.0);
    inScatter_28.w = (tmpvar_115.w * (t_116 * (t_116 * (3.0 - (2.0 * t_116)))));
    tmpvar_21 = (((tmpvar_115.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_44 * tmpvar_44)))) + ((((tmpvar_115.xyz * inScatter_28.w) / max (tmpvar_115.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_44)), -1.5)) * (1.0 + (tmpvar_44 * tmpvar_44))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_117;
    highp vec3 arg0_118;
    arg0_118 = (tmpvar_20 - _camPos);
    tmpvar_117 = sqrt(dot (arg0_118, arg0_118));
    highp float tmpvar_119;
    if ((tmpvar_117 <= _global_depth)) {
      tmpvar_119 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_117) / _global_depth))));
    } else {
      tmpvar_119 = 1.0;
    };
    highp vec3 L_120;
    highp vec3 tmpvar_121;
    tmpvar_121 = (tmpvar_21 * _Exposure);
    L_120 = tmpvar_121;
    highp float tmpvar_122;
    if ((tmpvar_121.x < 1.413)) {
      tmpvar_122 = pow ((tmpvar_121.x * 0.38317), 0.454545);
    } else {
      tmpvar_122 = (1.0 - exp(-(tmpvar_121.x)));
    };
    L_120.x = tmpvar_122;
    highp float tmpvar_123;
    if ((tmpvar_121.y < 1.413)) {
      tmpvar_123 = pow ((tmpvar_121.y * 0.38317), 0.454545);
    } else {
      tmpvar_123 = (1.0 - exp(-(tmpvar_121.y)));
    };
    L_120.y = tmpvar_123;
    highp float tmpvar_124;
    if ((tmpvar_121.z < 1.413)) {
      tmpvar_124 = pow ((tmpvar_121.z * 0.38317), 0.454545);
    } else {
      tmpvar_124 = (1.0 - exp(-(tmpvar_121.z)));
    };
    L_120.z = tmpvar_124;
    highp vec4 tmpvar_125;
    tmpvar_125.w = 1.0;
    tmpvar_125.xyz = ((L_120 * _global_alpha) * tmpvar_119);
    tmpvar_1 = tmpvar_125;
  };
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
Keywords { "GODRAYS_ON" }
"!!GLSL
#ifdef VERTEX
uniform vec4 _ProjectionParams;


varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_3;
  vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform float M_PI;
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float mieG;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform mat4 _ViewProjInv;
uniform float _experimentalAtmoScale;
uniform float _global_alpha;
uniform float _Exposure;
uniform float _global_depth;
uniform vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform float _openglThreshold;
varying vec2 xlv_TEXCOORD2;
void main ()
{
  vec4 tmpvar_1;
  bool infinite_2;
  float depth_3;
  vec4 tmpvar_4;
  tmpvar_4 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  float tmpvar_5;
  tmpvar_5 = tmpvar_4.x;
  depth_3 = tmpvar_5;
  infinite_2 = (tmpvar_4.x == 1.0);
  vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = tmpvar_5;
  vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = (1.0 - abs(dot (normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx))), normalize(((tmpvar_7 / tmpvar_7.w).xyz - _camPos)))));
  vec4 tmpvar_9;
  tmpvar_9 = texture2D (_godrayDepthTexture, xlv_TEXCOORD2);
  if ((((tmpvar_9.x > 0.0) && (tmpvar_9.x < tmpvar_4.x)) && (tmpvar_4.x < 1.0))) {
    depth_3 = mix (tmpvar_4.x, tmpvar_9.x, tmpvar_8);
  };
  vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_3;
  vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  float tmpvar_13;
  vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if ((!(tmpvar_18) && infinite_2)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    vec3 tmpvar_23;
    if ((tmpvar_18 && tmpvar_22)) {
      tmpvar_23 = tmpvar_19;
    } else {
      tmpvar_23 = tmpvar_12;
    };
    float tmpvar_24;
    tmpvar_24 = sqrt(dot (tmpvar_23, tmpvar_23));
    vec3 tmpvar_25;
    if ((tmpvar_24 < (Rg + _openglThreshold))) {
      tmpvar_25 = ((Rg + _openglThreshold) * normalize(tmpvar_23));
    } else {
      tmpvar_25 = tmpvar_23;
    };
    vec3 tmpvar_26;
    vec3 camera_27;
    camera_27 = _camPos;
    vec3 _point_28;
    _point_28 = tmpvar_25;
    vec3 extinction_29;
    vec4 inScatter0_30;
    float muS1_31;
    float mu1_32;
    vec4 inScatter_33;
    float mu_34;
    float rMu_35;
    float r_36;
    float d_37;
    extinction_29 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_38;
    tmpvar_38 = (tmpvar_25 - _camPos);
    float tmpvar_39;
    tmpvar_39 = sqrt(dot (tmpvar_38, tmpvar_38));
    d_37 = tmpvar_39;
    float tmpvar_40;
    tmpvar_40 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_41;
    tmpvar_41 = normalize((tmpvar_38 / tmpvar_39));
    float tmpvar_42;
    tmpvar_42 = sqrt(dot (_camPos, _camPos));
    r_36 = tmpvar_42;
    if ((tmpvar_42 < (0.9 * Rg))) {
      camera_27.y = (_camPos.y + Rg);
      _point_28.y = (tmpvar_25.y + Rg);
      r_36 = sqrt(dot (camera_27, camera_27));
    };
    float tmpvar_43;
    tmpvar_43 = dot (camera_27, tmpvar_41);
    rMu_35 = tmpvar_43;
    mu_34 = (tmpvar_43 / r_36);
    vec3 tmpvar_44;
    tmpvar_44 = (_point_28 - (tmpvar_41 * clamp (1.0, 0.0, tmpvar_39)));
    _point_28 = tmpvar_44;
    float f_45;
    f_45 = (((tmpvar_43 * tmpvar_43) - (r_36 * r_36)) + (tmpvar_40 * tmpvar_40));
    float tmpvar_46;
    if ((f_45 >= 0.0)) {
      tmpvar_46 = sqrt(f_45);
    } else {
      tmpvar_46 = 1e+30;
    };
    float tmpvar_47;
    tmpvar_47 = max ((-(tmpvar_43) - tmpvar_46), 0.0);
    if (((tmpvar_47 > 0.0) && (tmpvar_47 < tmpvar_39))) {
      camera_27 = (camera_27 + (tmpvar_47 * tmpvar_41));
      float tmpvar_48;
      tmpvar_48 = (tmpvar_43 + tmpvar_47);
      rMu_35 = tmpvar_48;
      mu_34 = (tmpvar_48 / tmpvar_40);
      r_36 = tmpvar_40;
      d_37 = (tmpvar_39 - tmpvar_47);
    };
    float tmpvar_49;
    tmpvar_49 = dot (tmpvar_41, SUN_DIR);
    float tmpvar_50;
    tmpvar_50 = (dot (camera_27, SUN_DIR) / r_36);
    if ((r_36 < (Rg + 1600.0))) {
      float tmpvar_51;
      tmpvar_51 = ((Rg + 1600.0) / r_36);
      r_36 = (r_36 * tmpvar_51);
      rMu_35 = (rMu_35 * tmpvar_51);
      _point_28 = (tmpvar_44 * tmpvar_51);
    };
    float tmpvar_52;
    tmpvar_52 = sqrt(dot (_point_28, _point_28));
    mu1_32 = (dot (_point_28, tmpvar_41) / tmpvar_52);
    muS1_31 = (dot (_point_28, SUN_DIR) / tmpvar_52);
    float tmpvar_53;
    float H_54;
    H_54 = (HR * _experimentalAtmoScale);
    vec2 tmpvar_55;
    tmpvar_55.x = mu_34;
    tmpvar_55.y = (mu_34 + (d_37 / r_36));
    vec2 tmpvar_56;
    tmpvar_56 = (sqrt(((0.5 / H_54) * r_36)) * tmpvar_55);
    vec2 tmpvar_57;
    tmpvar_57 = sign(tmpvar_56);
    vec2 tmpvar_58;
    tmpvar_58 = (tmpvar_56 * tmpvar_56);
    float tmpvar_59;
    if ((tmpvar_57.y > tmpvar_57.x)) {
      tmpvar_59 = exp(tmpvar_58.x);
    } else {
      tmpvar_59 = 0.0;
    };
    vec2 tmpvar_60;
    tmpvar_60.x = 1.0;
    tmpvar_60.y = exp(((-(d_37) / H_54) * ((d_37 / (2.0 * r_36)) + mu_34)));
    tmpvar_53 = ((sqrt(((6.2831 * H_54) * r_36)) * exp(((Rg - r_36) / H_54))) * (tmpvar_59 + dot (((tmpvar_57 / ((2.3193 * abs(tmpvar_56)) + sqrt(((1.52 * tmpvar_58) + 4.0)))) * tmpvar_60), vec2(1.0, -1.0))));
    float H_61;
    H_61 = (HM * _experimentalAtmoScale);
    vec2 tmpvar_62;
    tmpvar_62.x = mu_34;
    tmpvar_62.y = (mu_34 + (d_37 / r_36));
    vec2 tmpvar_63;
    tmpvar_63 = (sqrt(((0.5 / H_61) * r_36)) * tmpvar_62);
    vec2 tmpvar_64;
    tmpvar_64 = sign(tmpvar_63);
    vec2 tmpvar_65;
    tmpvar_65 = (tmpvar_63 * tmpvar_63);
    float tmpvar_66;
    if ((tmpvar_64.y > tmpvar_64.x)) {
      tmpvar_66 = exp(tmpvar_65.x);
    } else {
      tmpvar_66 = 0.0;
    };
    vec2 tmpvar_67;
    tmpvar_67.x = 1.0;
    tmpvar_67.y = exp(((-(d_37) / H_61) * ((d_37 / (2.0 * r_36)) + mu_34)));
    extinction_29 = min (exp(((-(betaR) * tmpvar_53) - (betaMEx * ((sqrt(((6.2831 * H_61) * r_36)) * exp(((Rg - r_36) / H_61))) * (tmpvar_66 + dot (((tmpvar_64 / ((2.3193 * abs(tmpvar_63)) + sqrt(((1.52 * tmpvar_65) + 4.0)))) * tmpvar_67), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    float uMu_68;
    float uR_69;
    float tmpvar_70;
    tmpvar_70 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    float tmpvar_71;
    tmpvar_71 = sqrt(((r_36 * r_36) - (Rg * Rg)));
    float tmpvar_72;
    tmpvar_72 = (r_36 * mu_34);
    float tmpvar_73;
    tmpvar_73 = (((tmpvar_72 * tmpvar_72) - (r_36 * r_36)) + (Rg * Rg));
    vec4 tmpvar_74;
    if (((tmpvar_72 < 0.0) && (tmpvar_73 > 0.0))) {
      vec4 tmpvar_75;
      tmpvar_75.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_75.w = (0.5 - (0.5 / RES_MU));
      tmpvar_74 = tmpvar_75;
    } else {
      vec4 tmpvar_76;
      tmpvar_76.x = -1.0;
      tmpvar_76.y = (tmpvar_70 * tmpvar_70);
      tmpvar_76.z = tmpvar_70;
      tmpvar_76.w = (0.5 + (0.5 / RES_MU));
      tmpvar_74 = tmpvar_76;
    };
    uR_69 = ((0.5 / RES_R) + ((tmpvar_71 / tmpvar_70) * (1.0 - (1.0/(RES_R)))));
    uMu_68 = (tmpvar_74.w + ((((tmpvar_72 * tmpvar_74.x) + sqrt((tmpvar_73 + tmpvar_74.y))) / (tmpvar_71 + tmpvar_74.z)) * (0.5 - (1.0/(RES_MU)))));
    float y_over_x_77;
    y_over_x_77 = (max (tmpvar_50, -0.1975) * 5.34962);
    float x_78;
    x_78 = (y_over_x_77 * inversesqrt(((y_over_x_77 * y_over_x_77) + 1.0)));
    float tmpvar_79;
    tmpvar_79 = ((0.5 / RES_MU_S) + (((((sign(x_78) * (1.5708 - (sqrt((1.0 - abs(x_78))) * (1.5708 + (abs(x_78) * (-0.214602 + (abs(x_78) * (0.0865667 + (abs(x_78) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    float tmpvar_80;
    tmpvar_80 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    float tmpvar_81;
    tmpvar_81 = floor(tmpvar_80);
    float tmpvar_82;
    tmpvar_82 = (tmpvar_80 - tmpvar_81);
    float tmpvar_83;
    tmpvar_83 = (floor(((uR_69 * RES_R) - 1.0)) / RES_R);
    float tmpvar_84;
    tmpvar_84 = (floor((uR_69 * RES_R)) / RES_R);
    float tmpvar_85;
    tmpvar_85 = fract((uR_69 * RES_R));
    vec4 tmpvar_86;
    tmpvar_86.zw = vec2(0.0, 0.0);
    tmpvar_86.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_86.y = ((uMu_68 / RES_R) + tmpvar_83);
    vec4 tmpvar_87;
    tmpvar_87.zw = vec2(0.0, 0.0);
    tmpvar_87.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_87.y = ((uMu_68 / RES_R) + tmpvar_83);
    vec4 tmpvar_88;
    tmpvar_88.zw = vec2(0.0, 0.0);
    tmpvar_88.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_88.y = ((uMu_68 / RES_R) + tmpvar_84);
    vec4 tmpvar_89;
    tmpvar_89.zw = vec2(0.0, 0.0);
    tmpvar_89.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_89.y = ((uMu_68 / RES_R) + tmpvar_84);
    inScatter0_30 = ((((texture2DLod (_Inscatter, tmpvar_86.xy, 0.0) * (1.0 - tmpvar_82)) + (texture2DLod (_Inscatter, tmpvar_87.xy, 0.0) * tmpvar_82)) * (1.0 - tmpvar_85)) + (((texture2DLod (_Inscatter, tmpvar_88.xy, 0.0) * (1.0 - tmpvar_82)) + (texture2DLod (_Inscatter, tmpvar_89.xy, 0.0) * tmpvar_82)) * tmpvar_85));
    float uMu_90;
    float uR_91;
    float tmpvar_92;
    tmpvar_92 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    float tmpvar_93;
    tmpvar_93 = sqrt(((tmpvar_52 * tmpvar_52) - (Rg * Rg)));
    float tmpvar_94;
    tmpvar_94 = (tmpvar_52 * mu1_32);
    float tmpvar_95;
    tmpvar_95 = (((tmpvar_94 * tmpvar_94) - (tmpvar_52 * tmpvar_52)) + (Rg * Rg));
    vec4 tmpvar_96;
    if (((tmpvar_94 < 0.0) && (tmpvar_95 > 0.0))) {
      vec4 tmpvar_97;
      tmpvar_97.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_97.w = (0.5 - (0.5 / RES_MU));
      tmpvar_96 = tmpvar_97;
    } else {
      vec4 tmpvar_98;
      tmpvar_98.x = -1.0;
      tmpvar_98.y = (tmpvar_92 * tmpvar_92);
      tmpvar_98.z = tmpvar_92;
      tmpvar_98.w = (0.5 + (0.5 / RES_MU));
      tmpvar_96 = tmpvar_98;
    };
    uR_91 = ((0.5 / RES_R) + ((tmpvar_93 / tmpvar_92) * (1.0 - (1.0/(RES_R)))));
    uMu_90 = (tmpvar_96.w + ((((tmpvar_94 * tmpvar_96.x) + sqrt((tmpvar_95 + tmpvar_96.y))) / (tmpvar_93 + tmpvar_96.z)) * (0.5 - (1.0/(RES_MU)))));
    float y_over_x_99;
    y_over_x_99 = (max (muS1_31, -0.1975) * 5.34962);
    float x_100;
    x_100 = (y_over_x_99 * inversesqrt(((y_over_x_99 * y_over_x_99) + 1.0)));
    float tmpvar_101;
    tmpvar_101 = ((0.5 / RES_MU_S) + (((((sign(x_100) * (1.5708 - (sqrt((1.0 - abs(x_100))) * (1.5708 + (abs(x_100) * (-0.214602 + (abs(x_100) * (0.0865667 + (abs(x_100) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    float tmpvar_102;
    tmpvar_102 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    float tmpvar_103;
    tmpvar_103 = floor(tmpvar_102);
    float tmpvar_104;
    tmpvar_104 = (tmpvar_102 - tmpvar_103);
    float tmpvar_105;
    tmpvar_105 = (floor(((uR_91 * RES_R) - 1.0)) / RES_R);
    float tmpvar_106;
    tmpvar_106 = (floor((uR_91 * RES_R)) / RES_R);
    float tmpvar_107;
    tmpvar_107 = fract((uR_91 * RES_R));
    vec4 tmpvar_108;
    tmpvar_108.zw = vec2(0.0, 0.0);
    tmpvar_108.x = ((tmpvar_103 + tmpvar_101) / RES_NU);
    tmpvar_108.y = ((uMu_90 / RES_R) + tmpvar_105);
    vec4 tmpvar_109;
    tmpvar_109.zw = vec2(0.0, 0.0);
    tmpvar_109.x = (((tmpvar_103 + tmpvar_101) + 1.0) / RES_NU);
    tmpvar_109.y = ((uMu_90 / RES_R) + tmpvar_105);
    vec4 tmpvar_110;
    tmpvar_110.zw = vec2(0.0, 0.0);
    tmpvar_110.x = ((tmpvar_103 + tmpvar_101) / RES_NU);
    tmpvar_110.y = ((uMu_90 / RES_R) + tmpvar_106);
    vec4 tmpvar_111;
    tmpvar_111.zw = vec2(0.0, 0.0);
    tmpvar_111.x = (((tmpvar_103 + tmpvar_101) + 1.0) / RES_NU);
    tmpvar_111.y = ((uMu_90 / RES_R) + tmpvar_106);
    vec4 tmpvar_112;
    tmpvar_112 = max ((inScatter0_30 - (((((texture2DLod (_Inscatter, tmpvar_108.xy, 0.0) * (1.0 - tmpvar_104)) + (texture2DLod (_Inscatter, tmpvar_109.xy, 0.0) * tmpvar_104)) * (1.0 - tmpvar_107)) + (((texture2DLod (_Inscatter, tmpvar_110.xy, 0.0) * (1.0 - tmpvar_104)) + (texture2DLod (_Inscatter, tmpvar_111.xy, 0.0) * tmpvar_104)) * tmpvar_107)) * extinction_29.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_33.xyz = tmpvar_112.xyz;
    float t_113;
    t_113 = max (min ((tmpvar_50 / 0.02), 1.0), 0.0);
    inScatter_33.w = (tmpvar_112.w * (t_113 * (t_113 * (3.0 - (2.0 * t_113)))));
    tmpvar_26 = (((tmpvar_112.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_49 * tmpvar_49)))) + ((((tmpvar_112.xyz * inScatter_33.w) / max (tmpvar_112.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_49)), -1.5)) * (1.0 + (tmpvar_49 * tmpvar_49))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    float tmpvar_114;
    vec3 arg0_115;
    arg0_115 = (tmpvar_25 - _camPos);
    tmpvar_114 = sqrt(dot (arg0_115, arg0_115));
    float tmpvar_116;
    if ((tmpvar_114 <= _global_depth)) {
      tmpvar_116 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_114) / _global_depth))));
    } else {
      tmpvar_116 = 1.0;
    };
    vec3 L_117;
    vec3 tmpvar_118;
    tmpvar_118 = (tmpvar_26 * _Exposure);
    L_117 = tmpvar_118;
    float tmpvar_119;
    if ((tmpvar_118.x < 1.413)) {
      tmpvar_119 = pow ((tmpvar_118.x * 0.38317), 0.454545);
    } else {
      tmpvar_119 = (1.0 - exp(-(tmpvar_118.x)));
    };
    L_117.x = tmpvar_119;
    float tmpvar_120;
    if ((tmpvar_118.y < 1.413)) {
      tmpvar_120 = pow ((tmpvar_118.y * 0.38317), 0.454545);
    } else {
      tmpvar_120 = (1.0 - exp(-(tmpvar_118.y)));
    };
    L_117.y = tmpvar_120;
    float tmpvar_121;
    if ((tmpvar_118.z < 1.413)) {
      tmpvar_121 = pow ((tmpvar_118.z * 0.38317), 0.454545);
    } else {
      tmpvar_121 = (1.0 - exp(-(tmpvar_118.z)));
    };
    L_117.z = tmpvar_121;
    vec4 tmpvar_122;
    tmpvar_122.w = 1.0;
    tmpvar_122.xyz = ((L_117 * _global_alpha) * tmpvar_116);
    tmpvar_1 = tmpvar_122;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 20 math, 1 branches
Keywords { "GODRAYS_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [_MainTex_TexelSize]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c11, 0.50000000, 0.00000000, 1.00000000, 0
dcl_position0 v0
dp4 r1.z, v0, c7
dp4 r0.x, v0, c4
rcp r0.z, r1.z
mov r0.w, r1.z
dp4 r0.y, v0, c5
mul r2.xyz, r0.xyww, c11.x
mov r1.w, c11.y
mov r1.x, r2
mul r1.y, r2, c8.x
mad r1.xy, r2.z, c9.zwzw, r1
mul r2.zw, r1.xyxy, r0.z
mov r2.xy, r2.zwzw
dp4 r0.z, v0, c6
if_lt c10.y, r1.w
add r2.y, -r2, c11.z
endif
mov o0, r0
dp4 r0.x, v0, c2
mov o1.xyw, r1.xyzz
mov o2.xy, r2
mov o3.xy, r2.zwzw
mov o1.z, -r0.x
"
}
SubProgram "d3d11 " {
// Stats: 15 math
Keywords { "GODRAYS_ON" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 384
Vector 288 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedolhbppepeekhlhlpfmgecgplbldgmcheabaaaaaabmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaciabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklfdeieefcomacaaaaeaaaabaallaaaaaafjaaaaaeegiocaaa
aaaaaaaabdaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaiaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaadcaaaaak
ecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaackbabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaa
ahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaaaaaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaaegambaaa
aaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabcaaaaaaabeaaaaaaaaaaaaa
dhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform highp float _openglThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float godrayDepth_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - abs(dot (normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx))), normalize(((tmpvar_7 / tmpvar_7.w).xyz - _camPos)))));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_godrayDepthTexture, xlv_TEXCOORD2).x;
  godrayDepth_2 = tmpvar_9;
  if ((((godrayDepth_2 > 0.0) && (godrayDepth_2 < depth_4)) && (depth_4 < 1.0))) {
    depth_4 = mix (depth_4, godrayDepth_2, tmpvar_8);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_4;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if ((!(tmpvar_18) && infinite_3)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    highp vec3 tmpvar_23;
    if ((tmpvar_18 && tmpvar_22)) {
      tmpvar_23 = tmpvar_19;
    } else {
      tmpvar_23 = tmpvar_12;
    };
    highp float tmpvar_24;
    tmpvar_24 = sqrt(dot (tmpvar_23, tmpvar_23));
    highp vec3 tmpvar_25;
    if ((tmpvar_24 < (Rg + _openglThreshold))) {
      tmpvar_25 = ((Rg + _openglThreshold) * normalize(tmpvar_23));
    } else {
      tmpvar_25 = tmpvar_23;
    };
    highp vec3 tmpvar_26;
    highp vec3 camera_27;
    camera_27 = _camPos;
    highp vec3 _point_28;
    _point_28 = tmpvar_25;
    highp vec3 extinction_29;
    highp vec4 inScatter0_30;
    highp float muS1_31;
    highp float mu1_32;
    highp vec4 inScatter_33;
    highp float mu_34;
    highp float rMu_35;
    highp float r_36;
    highp float d_37;
    extinction_29 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_38;
    tmpvar_38 = (tmpvar_25 - _camPos);
    highp float tmpvar_39;
    tmpvar_39 = sqrt(dot (tmpvar_38, tmpvar_38));
    d_37 = tmpvar_39;
    highp float tmpvar_40;
    tmpvar_40 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_41;
    tmpvar_41 = normalize((tmpvar_38 / tmpvar_39));
    highp float tmpvar_42;
    tmpvar_42 = sqrt(dot (_camPos, _camPos));
    r_36 = tmpvar_42;
    if ((tmpvar_42 < (0.9 * Rg))) {
      camera_27.y = (_camPos.y + Rg);
      _point_28.y = (tmpvar_25.y + Rg);
      r_36 = sqrt(dot (camera_27, camera_27));
    };
    highp float tmpvar_43;
    tmpvar_43 = dot (camera_27, tmpvar_41);
    rMu_35 = tmpvar_43;
    mu_34 = (tmpvar_43 / r_36);
    highp vec3 tmpvar_44;
    tmpvar_44 = (_point_28 - (tmpvar_41 * clamp (1.0, 0.0, tmpvar_39)));
    _point_28 = tmpvar_44;
    highp float f_45;
    f_45 = (((tmpvar_43 * tmpvar_43) - (r_36 * r_36)) + (tmpvar_40 * tmpvar_40));
    highp float tmpvar_46;
    if ((f_45 >= 0.0)) {
      tmpvar_46 = sqrt(f_45);
    } else {
      tmpvar_46 = 1e+30;
    };
    highp float tmpvar_47;
    tmpvar_47 = max ((-(tmpvar_43) - tmpvar_46), 0.0);
    if (((tmpvar_47 > 0.0) && (tmpvar_47 < tmpvar_39))) {
      camera_27 = (camera_27 + (tmpvar_47 * tmpvar_41));
      highp float tmpvar_48;
      tmpvar_48 = (tmpvar_43 + tmpvar_47);
      rMu_35 = tmpvar_48;
      mu_34 = (tmpvar_48 / tmpvar_40);
      r_36 = tmpvar_40;
      d_37 = (tmpvar_39 - tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = dot (tmpvar_41, SUN_DIR);
    highp float tmpvar_50;
    tmpvar_50 = (dot (camera_27, SUN_DIR) / r_36);
    if ((r_36 < (Rg + 1600.0))) {
      highp float tmpvar_51;
      tmpvar_51 = ((Rg + 1600.0) / r_36);
      r_36 = (r_36 * tmpvar_51);
      rMu_35 = (rMu_35 * tmpvar_51);
      _point_28 = (tmpvar_44 * tmpvar_51);
    };
    highp float tmpvar_52;
    tmpvar_52 = sqrt(dot (_point_28, _point_28));
    mu1_32 = (dot (_point_28, tmpvar_41) / tmpvar_52);
    muS1_31 = (dot (_point_28, SUN_DIR) / tmpvar_52);
    highp float tmpvar_53;
    highp float H_54;
    H_54 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_55;
    tmpvar_55.x = mu_34;
    tmpvar_55.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_56;
    tmpvar_56 = (sqrt(((0.5 / H_54) * r_36)) * tmpvar_55);
    highp vec2 tmpvar_57;
    tmpvar_57 = sign(tmpvar_56);
    highp vec2 tmpvar_58;
    tmpvar_58 = (tmpvar_56 * tmpvar_56);
    highp float tmpvar_59;
    if ((tmpvar_57.y > tmpvar_57.x)) {
      tmpvar_59 = exp(tmpvar_58.x);
    } else {
      tmpvar_59 = 0.0;
    };
    highp vec2 tmpvar_60;
    tmpvar_60.x = 1.0;
    tmpvar_60.y = exp(((-(d_37) / H_54) * ((d_37 / (2.0 * r_36)) + mu_34)));
    tmpvar_53 = ((sqrt(((6.2831 * H_54) * r_36)) * exp(((Rg - r_36) / H_54))) * (tmpvar_59 + dot (((tmpvar_57 / ((2.3193 * abs(tmpvar_56)) + sqrt(((1.52 * tmpvar_58) + 4.0)))) * tmpvar_60), vec2(1.0, -1.0))));
    highp float H_61;
    H_61 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_62;
    tmpvar_62.x = mu_34;
    tmpvar_62.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_63;
    tmpvar_63 = (sqrt(((0.5 / H_61) * r_36)) * tmpvar_62);
    highp vec2 tmpvar_64;
    tmpvar_64 = sign(tmpvar_63);
    highp vec2 tmpvar_65;
    tmpvar_65 = (tmpvar_63 * tmpvar_63);
    highp float tmpvar_66;
    if ((tmpvar_64.y > tmpvar_64.x)) {
      tmpvar_66 = exp(tmpvar_65.x);
    } else {
      tmpvar_66 = 0.0;
    };
    highp vec2 tmpvar_67;
    tmpvar_67.x = 1.0;
    tmpvar_67.y = exp(((-(d_37) / H_61) * ((d_37 / (2.0 * r_36)) + mu_34)));
    extinction_29 = min (exp(((-(betaR) * tmpvar_53) - (betaMEx * ((sqrt(((6.2831 * H_61) * r_36)) * exp(((Rg - r_36) / H_61))) * (tmpvar_66 + dot (((tmpvar_64 / ((2.3193 * abs(tmpvar_63)) + sqrt(((1.52 * tmpvar_65) + 4.0)))) * tmpvar_67), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_68;
    highp float uR_69;
    highp float tmpvar_70;
    tmpvar_70 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_71;
    tmpvar_71 = sqrt(((r_36 * r_36) - (Rg * Rg)));
    highp float tmpvar_72;
    tmpvar_72 = (r_36 * mu_34);
    highp float tmpvar_73;
    tmpvar_73 = (((tmpvar_72 * tmpvar_72) - (r_36 * r_36)) + (Rg * Rg));
    highp vec4 tmpvar_74;
    if (((tmpvar_72 < 0.0) && (tmpvar_73 > 0.0))) {
      highp vec4 tmpvar_75;
      tmpvar_75.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_75.w = (0.5 - (0.5 / RES_MU));
      tmpvar_74 = tmpvar_75;
    } else {
      highp vec4 tmpvar_76;
      tmpvar_76.x = -1.0;
      tmpvar_76.y = (tmpvar_70 * tmpvar_70);
      tmpvar_76.z = tmpvar_70;
      tmpvar_76.w = (0.5 + (0.5 / RES_MU));
      tmpvar_74 = tmpvar_76;
    };
    uR_69 = ((0.5 / RES_R) + ((tmpvar_71 / tmpvar_70) * (1.0 - (1.0/(RES_R)))));
    uMu_68 = (tmpvar_74.w + ((((tmpvar_72 * tmpvar_74.x) + sqrt((tmpvar_73 + tmpvar_74.y))) / (tmpvar_71 + tmpvar_74.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_77;
    y_over_x_77 = (max (tmpvar_50, -0.1975) * 5.34962);
    highp float x_78;
    x_78 = (y_over_x_77 * inversesqrt(((y_over_x_77 * y_over_x_77) + 1.0)));
    highp float tmpvar_79;
    tmpvar_79 = ((0.5 / RES_MU_S) + (((((sign(x_78) * (1.5708 - (sqrt((1.0 - abs(x_78))) * (1.5708 + (abs(x_78) * (-0.214602 + (abs(x_78) * (0.0865667 + (abs(x_78) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_80;
    tmpvar_80 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_81;
    tmpvar_81 = floor(tmpvar_80);
    highp float tmpvar_82;
    tmpvar_82 = (tmpvar_80 - tmpvar_81);
    highp float tmpvar_83;
    tmpvar_83 = (floor(((uR_69 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_84;
    tmpvar_84 = (floor((uR_69 * RES_R)) / RES_R);
    highp float tmpvar_85;
    tmpvar_85 = fract((uR_69 * RES_R));
    highp vec4 tmpvar_86;
    tmpvar_86.zw = vec2(0.0, 0.0);
    tmpvar_86.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_86.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_87;
    tmpvar_87 = texture2DLodEXT (_Inscatter, tmpvar_86.xy, 0.0);
    highp vec4 tmpvar_88;
    tmpvar_88.zw = vec2(0.0, 0.0);
    tmpvar_88.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_88.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_89;
    tmpvar_89 = texture2DLodEXT (_Inscatter, tmpvar_88.xy, 0.0);
    highp vec4 tmpvar_90;
    tmpvar_90.zw = vec2(0.0, 0.0);
    tmpvar_90.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_90.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_91;
    tmpvar_91 = texture2DLodEXT (_Inscatter, tmpvar_90.xy, 0.0);
    highp vec4 tmpvar_92;
    tmpvar_92.zw = vec2(0.0, 0.0);
    tmpvar_92.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_92.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_93;
    tmpvar_93 = texture2DLodEXT (_Inscatter, tmpvar_92.xy, 0.0);
    inScatter0_30 = ((((tmpvar_87 * (1.0 - tmpvar_82)) + (tmpvar_89 * tmpvar_82)) * (1.0 - tmpvar_85)) + (((tmpvar_91 * (1.0 - tmpvar_82)) + (tmpvar_93 * tmpvar_82)) * tmpvar_85));
    highp float uMu_94;
    highp float uR_95;
    highp float tmpvar_96;
    tmpvar_96 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_97;
    tmpvar_97 = sqrt(((tmpvar_52 * tmpvar_52) - (Rg * Rg)));
    highp float tmpvar_98;
    tmpvar_98 = (tmpvar_52 * mu1_32);
    highp float tmpvar_99;
    tmpvar_99 = (((tmpvar_98 * tmpvar_98) - (tmpvar_52 * tmpvar_52)) + (Rg * Rg));
    highp vec4 tmpvar_100;
    if (((tmpvar_98 < 0.0) && (tmpvar_99 > 0.0))) {
      highp vec4 tmpvar_101;
      tmpvar_101.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_101.w = (0.5 - (0.5 / RES_MU));
      tmpvar_100 = tmpvar_101;
    } else {
      highp vec4 tmpvar_102;
      tmpvar_102.x = -1.0;
      tmpvar_102.y = (tmpvar_96 * tmpvar_96);
      tmpvar_102.z = tmpvar_96;
      tmpvar_102.w = (0.5 + (0.5 / RES_MU));
      tmpvar_100 = tmpvar_102;
    };
    uR_95 = ((0.5 / RES_R) + ((tmpvar_97 / tmpvar_96) * (1.0 - (1.0/(RES_R)))));
    uMu_94 = (tmpvar_100.w + ((((tmpvar_98 * tmpvar_100.x) + sqrt((tmpvar_99 + tmpvar_100.y))) / (tmpvar_97 + tmpvar_100.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_103;
    y_over_x_103 = (max (muS1_31, -0.1975) * 5.34962);
    highp float x_104;
    x_104 = (y_over_x_103 * inversesqrt(((y_over_x_103 * y_over_x_103) + 1.0)));
    highp float tmpvar_105;
    tmpvar_105 = ((0.5 / RES_MU_S) + (((((sign(x_104) * (1.5708 - (sqrt((1.0 - abs(x_104))) * (1.5708 + (abs(x_104) * (-0.214602 + (abs(x_104) * (0.0865667 + (abs(x_104) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_106;
    tmpvar_106 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_107;
    tmpvar_107 = floor(tmpvar_106);
    highp float tmpvar_108;
    tmpvar_108 = (tmpvar_106 - tmpvar_107);
    highp float tmpvar_109;
    tmpvar_109 = (floor(((uR_95 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_110;
    tmpvar_110 = (floor((uR_95 * RES_R)) / RES_R);
    highp float tmpvar_111;
    tmpvar_111 = fract((uR_95 * RES_R));
    highp vec4 tmpvar_112;
    tmpvar_112.zw = vec2(0.0, 0.0);
    tmpvar_112.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_112.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_113;
    tmpvar_113 = texture2DLodEXT (_Inscatter, tmpvar_112.xy, 0.0);
    highp vec4 tmpvar_114;
    tmpvar_114.zw = vec2(0.0, 0.0);
    tmpvar_114.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_114.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_115;
    tmpvar_115 = texture2DLodEXT (_Inscatter, tmpvar_114.xy, 0.0);
    highp vec4 tmpvar_116;
    tmpvar_116.zw = vec2(0.0, 0.0);
    tmpvar_116.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_116.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_117;
    tmpvar_117 = texture2DLodEXT (_Inscatter, tmpvar_116.xy, 0.0);
    highp vec4 tmpvar_118;
    tmpvar_118.zw = vec2(0.0, 0.0);
    tmpvar_118.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_118.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_119;
    tmpvar_119 = texture2DLodEXT (_Inscatter, tmpvar_118.xy, 0.0);
    highp vec4 tmpvar_120;
    tmpvar_120 = max ((inScatter0_30 - (((((tmpvar_113 * (1.0 - tmpvar_108)) + (tmpvar_115 * tmpvar_108)) * (1.0 - tmpvar_111)) + (((tmpvar_117 * (1.0 - tmpvar_108)) + (tmpvar_119 * tmpvar_108)) * tmpvar_111)) * extinction_29.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_33.xyz = tmpvar_120.xyz;
    highp float t_121;
    t_121 = max (min ((tmpvar_50 / 0.02), 1.0), 0.0);
    inScatter_33.w = (tmpvar_120.w * (t_121 * (t_121 * (3.0 - (2.0 * t_121)))));
    tmpvar_26 = (((tmpvar_120.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_49 * tmpvar_49)))) + ((((tmpvar_120.xyz * inScatter_33.w) / max (tmpvar_120.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_49)), -1.5)) * (1.0 + (tmpvar_49 * tmpvar_49))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_122;
    highp vec3 arg0_123;
    arg0_123 = (tmpvar_25 - _camPos);
    tmpvar_122 = sqrt(dot (arg0_123, arg0_123));
    highp float tmpvar_124;
    if ((tmpvar_122 <= _global_depth)) {
      tmpvar_124 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_122) / _global_depth))));
    } else {
      tmpvar_124 = 1.0;
    };
    highp vec3 L_125;
    highp vec3 tmpvar_126;
    tmpvar_126 = (tmpvar_26 * _Exposure);
    L_125 = tmpvar_126;
    highp float tmpvar_127;
    if ((tmpvar_126.x < 1.413)) {
      tmpvar_127 = pow ((tmpvar_126.x * 0.38317), 0.454545);
    } else {
      tmpvar_127 = (1.0 - exp(-(tmpvar_126.x)));
    };
    L_125.x = tmpvar_127;
    highp float tmpvar_128;
    if ((tmpvar_126.y < 1.413)) {
      tmpvar_128 = pow ((tmpvar_126.y * 0.38317), 0.454545);
    } else {
      tmpvar_128 = (1.0 - exp(-(tmpvar_126.y)));
    };
    L_125.y = tmpvar_128;
    highp float tmpvar_129;
    if ((tmpvar_126.z < 1.413)) {
      tmpvar_129 = pow ((tmpvar_126.z * 0.38317), 0.454545);
    } else {
      tmpvar_129 = (1.0 - exp(-(tmpvar_126.z)));
    };
    L_125.z = tmpvar_129;
    highp vec4 tmpvar_130;
    tmpvar_130.w = 1.0;
    tmpvar_130.xyz = ((L_125 * _global_alpha) * tmpvar_124);
    tmpvar_1 = tmpvar_130;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "GODRAYS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform highp float _openglThreshold;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float godrayDepth_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - abs(dot (normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx))), normalize(((tmpvar_7 / tmpvar_7.w).xyz - _camPos)))));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_godrayDepthTexture, xlv_TEXCOORD2).x;
  godrayDepth_2 = tmpvar_9;
  if ((((godrayDepth_2 > 0.0) && (godrayDepth_2 < depth_4)) && (depth_4 < 1.0))) {
    depth_4 = mix (depth_4, godrayDepth_2, tmpvar_8);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_4;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if ((!(tmpvar_18) && infinite_3)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    highp vec3 tmpvar_23;
    if ((tmpvar_18 && tmpvar_22)) {
      tmpvar_23 = tmpvar_19;
    } else {
      tmpvar_23 = tmpvar_12;
    };
    highp float tmpvar_24;
    tmpvar_24 = sqrt(dot (tmpvar_23, tmpvar_23));
    highp vec3 tmpvar_25;
    if ((tmpvar_24 < (Rg + _openglThreshold))) {
      tmpvar_25 = ((Rg + _openglThreshold) * normalize(tmpvar_23));
    } else {
      tmpvar_25 = tmpvar_23;
    };
    highp vec3 tmpvar_26;
    highp vec3 camera_27;
    camera_27 = _camPos;
    highp vec3 _point_28;
    _point_28 = tmpvar_25;
    highp vec3 extinction_29;
    highp vec4 inScatter0_30;
    highp float muS1_31;
    highp float mu1_32;
    highp vec4 inScatter_33;
    highp float mu_34;
    highp float rMu_35;
    highp float r_36;
    highp float d_37;
    extinction_29 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_38;
    tmpvar_38 = (tmpvar_25 - _camPos);
    highp float tmpvar_39;
    tmpvar_39 = sqrt(dot (tmpvar_38, tmpvar_38));
    d_37 = tmpvar_39;
    highp float tmpvar_40;
    tmpvar_40 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_41;
    tmpvar_41 = normalize((tmpvar_38 / tmpvar_39));
    highp float tmpvar_42;
    tmpvar_42 = sqrt(dot (_camPos, _camPos));
    r_36 = tmpvar_42;
    if ((tmpvar_42 < (0.9 * Rg))) {
      camera_27.y = (_camPos.y + Rg);
      _point_28.y = (tmpvar_25.y + Rg);
      r_36 = sqrt(dot (camera_27, camera_27));
    };
    highp float tmpvar_43;
    tmpvar_43 = dot (camera_27, tmpvar_41);
    rMu_35 = tmpvar_43;
    mu_34 = (tmpvar_43 / r_36);
    highp vec3 tmpvar_44;
    tmpvar_44 = (_point_28 - (tmpvar_41 * clamp (1.0, 0.0, tmpvar_39)));
    _point_28 = tmpvar_44;
    highp float f_45;
    f_45 = (((tmpvar_43 * tmpvar_43) - (r_36 * r_36)) + (tmpvar_40 * tmpvar_40));
    highp float tmpvar_46;
    if ((f_45 >= 0.0)) {
      tmpvar_46 = sqrt(f_45);
    } else {
      tmpvar_46 = 1e+30;
    };
    highp float tmpvar_47;
    tmpvar_47 = max ((-(tmpvar_43) - tmpvar_46), 0.0);
    if (((tmpvar_47 > 0.0) && (tmpvar_47 < tmpvar_39))) {
      camera_27 = (camera_27 + (tmpvar_47 * tmpvar_41));
      highp float tmpvar_48;
      tmpvar_48 = (tmpvar_43 + tmpvar_47);
      rMu_35 = tmpvar_48;
      mu_34 = (tmpvar_48 / tmpvar_40);
      r_36 = tmpvar_40;
      d_37 = (tmpvar_39 - tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = dot (tmpvar_41, SUN_DIR);
    highp float tmpvar_50;
    tmpvar_50 = (dot (camera_27, SUN_DIR) / r_36);
    if ((r_36 < (Rg + 1600.0))) {
      highp float tmpvar_51;
      tmpvar_51 = ((Rg + 1600.0) / r_36);
      r_36 = (r_36 * tmpvar_51);
      rMu_35 = (rMu_35 * tmpvar_51);
      _point_28 = (tmpvar_44 * tmpvar_51);
    };
    highp float tmpvar_52;
    tmpvar_52 = sqrt(dot (_point_28, _point_28));
    mu1_32 = (dot (_point_28, tmpvar_41) / tmpvar_52);
    muS1_31 = (dot (_point_28, SUN_DIR) / tmpvar_52);
    highp float tmpvar_53;
    highp float H_54;
    H_54 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_55;
    tmpvar_55.x = mu_34;
    tmpvar_55.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_56;
    tmpvar_56 = (sqrt(((0.5 / H_54) * r_36)) * tmpvar_55);
    highp vec2 tmpvar_57;
    tmpvar_57 = sign(tmpvar_56);
    highp vec2 tmpvar_58;
    tmpvar_58 = (tmpvar_56 * tmpvar_56);
    highp float tmpvar_59;
    if ((tmpvar_57.y > tmpvar_57.x)) {
      tmpvar_59 = exp(tmpvar_58.x);
    } else {
      tmpvar_59 = 0.0;
    };
    highp vec2 tmpvar_60;
    tmpvar_60.x = 1.0;
    tmpvar_60.y = exp(((-(d_37) / H_54) * ((d_37 / (2.0 * r_36)) + mu_34)));
    tmpvar_53 = ((sqrt(((6.2831 * H_54) * r_36)) * exp(((Rg - r_36) / H_54))) * (tmpvar_59 + dot (((tmpvar_57 / ((2.3193 * abs(tmpvar_56)) + sqrt(((1.52 * tmpvar_58) + 4.0)))) * tmpvar_60), vec2(1.0, -1.0))));
    highp float H_61;
    H_61 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_62;
    tmpvar_62.x = mu_34;
    tmpvar_62.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_63;
    tmpvar_63 = (sqrt(((0.5 / H_61) * r_36)) * tmpvar_62);
    highp vec2 tmpvar_64;
    tmpvar_64 = sign(tmpvar_63);
    highp vec2 tmpvar_65;
    tmpvar_65 = (tmpvar_63 * tmpvar_63);
    highp float tmpvar_66;
    if ((tmpvar_64.y > tmpvar_64.x)) {
      tmpvar_66 = exp(tmpvar_65.x);
    } else {
      tmpvar_66 = 0.0;
    };
    highp vec2 tmpvar_67;
    tmpvar_67.x = 1.0;
    tmpvar_67.y = exp(((-(d_37) / H_61) * ((d_37 / (2.0 * r_36)) + mu_34)));
    extinction_29 = min (exp(((-(betaR) * tmpvar_53) - (betaMEx * ((sqrt(((6.2831 * H_61) * r_36)) * exp(((Rg - r_36) / H_61))) * (tmpvar_66 + dot (((tmpvar_64 / ((2.3193 * abs(tmpvar_63)) + sqrt(((1.52 * tmpvar_65) + 4.0)))) * tmpvar_67), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_68;
    highp float uR_69;
    highp float tmpvar_70;
    tmpvar_70 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_71;
    tmpvar_71 = sqrt(((r_36 * r_36) - (Rg * Rg)));
    highp float tmpvar_72;
    tmpvar_72 = (r_36 * mu_34);
    highp float tmpvar_73;
    tmpvar_73 = (((tmpvar_72 * tmpvar_72) - (r_36 * r_36)) + (Rg * Rg));
    highp vec4 tmpvar_74;
    if (((tmpvar_72 < 0.0) && (tmpvar_73 > 0.0))) {
      highp vec4 tmpvar_75;
      tmpvar_75.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_75.w = (0.5 - (0.5 / RES_MU));
      tmpvar_74 = tmpvar_75;
    } else {
      highp vec4 tmpvar_76;
      tmpvar_76.x = -1.0;
      tmpvar_76.y = (tmpvar_70 * tmpvar_70);
      tmpvar_76.z = tmpvar_70;
      tmpvar_76.w = (0.5 + (0.5 / RES_MU));
      tmpvar_74 = tmpvar_76;
    };
    uR_69 = ((0.5 / RES_R) + ((tmpvar_71 / tmpvar_70) * (1.0 - (1.0/(RES_R)))));
    uMu_68 = (tmpvar_74.w + ((((tmpvar_72 * tmpvar_74.x) + sqrt((tmpvar_73 + tmpvar_74.y))) / (tmpvar_71 + tmpvar_74.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_77;
    y_over_x_77 = (max (tmpvar_50, -0.1975) * 5.34962);
    highp float x_78;
    x_78 = (y_over_x_77 * inversesqrt(((y_over_x_77 * y_over_x_77) + 1.0)));
    highp float tmpvar_79;
    tmpvar_79 = ((0.5 / RES_MU_S) + (((((sign(x_78) * (1.5708 - (sqrt((1.0 - abs(x_78))) * (1.5708 + (abs(x_78) * (-0.214602 + (abs(x_78) * (0.0865667 + (abs(x_78) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_80;
    tmpvar_80 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_81;
    tmpvar_81 = floor(tmpvar_80);
    highp float tmpvar_82;
    tmpvar_82 = (tmpvar_80 - tmpvar_81);
    highp float tmpvar_83;
    tmpvar_83 = (floor(((uR_69 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_84;
    tmpvar_84 = (floor((uR_69 * RES_R)) / RES_R);
    highp float tmpvar_85;
    tmpvar_85 = fract((uR_69 * RES_R));
    highp vec4 tmpvar_86;
    tmpvar_86.zw = vec2(0.0, 0.0);
    tmpvar_86.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_86.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_87;
    tmpvar_87 = texture2DLodEXT (_Inscatter, tmpvar_86.xy, 0.0);
    highp vec4 tmpvar_88;
    tmpvar_88.zw = vec2(0.0, 0.0);
    tmpvar_88.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_88.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_89;
    tmpvar_89 = texture2DLodEXT (_Inscatter, tmpvar_88.xy, 0.0);
    highp vec4 tmpvar_90;
    tmpvar_90.zw = vec2(0.0, 0.0);
    tmpvar_90.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_90.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_91;
    tmpvar_91 = texture2DLodEXT (_Inscatter, tmpvar_90.xy, 0.0);
    highp vec4 tmpvar_92;
    tmpvar_92.zw = vec2(0.0, 0.0);
    tmpvar_92.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_92.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_93;
    tmpvar_93 = texture2DLodEXT (_Inscatter, tmpvar_92.xy, 0.0);
    inScatter0_30 = ((((tmpvar_87 * (1.0 - tmpvar_82)) + (tmpvar_89 * tmpvar_82)) * (1.0 - tmpvar_85)) + (((tmpvar_91 * (1.0 - tmpvar_82)) + (tmpvar_93 * tmpvar_82)) * tmpvar_85));
    highp float uMu_94;
    highp float uR_95;
    highp float tmpvar_96;
    tmpvar_96 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_97;
    tmpvar_97 = sqrt(((tmpvar_52 * tmpvar_52) - (Rg * Rg)));
    highp float tmpvar_98;
    tmpvar_98 = (tmpvar_52 * mu1_32);
    highp float tmpvar_99;
    tmpvar_99 = (((tmpvar_98 * tmpvar_98) - (tmpvar_52 * tmpvar_52)) + (Rg * Rg));
    highp vec4 tmpvar_100;
    if (((tmpvar_98 < 0.0) && (tmpvar_99 > 0.0))) {
      highp vec4 tmpvar_101;
      tmpvar_101.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_101.w = (0.5 - (0.5 / RES_MU));
      tmpvar_100 = tmpvar_101;
    } else {
      highp vec4 tmpvar_102;
      tmpvar_102.x = -1.0;
      tmpvar_102.y = (tmpvar_96 * tmpvar_96);
      tmpvar_102.z = tmpvar_96;
      tmpvar_102.w = (0.5 + (0.5 / RES_MU));
      tmpvar_100 = tmpvar_102;
    };
    uR_95 = ((0.5 / RES_R) + ((tmpvar_97 / tmpvar_96) * (1.0 - (1.0/(RES_R)))));
    uMu_94 = (tmpvar_100.w + ((((tmpvar_98 * tmpvar_100.x) + sqrt((tmpvar_99 + tmpvar_100.y))) / (tmpvar_97 + tmpvar_100.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_103;
    y_over_x_103 = (max (muS1_31, -0.1975) * 5.34962);
    highp float x_104;
    x_104 = (y_over_x_103 * inversesqrt(((y_over_x_103 * y_over_x_103) + 1.0)));
    highp float tmpvar_105;
    tmpvar_105 = ((0.5 / RES_MU_S) + (((((sign(x_104) * (1.5708 - (sqrt((1.0 - abs(x_104))) * (1.5708 + (abs(x_104) * (-0.214602 + (abs(x_104) * (0.0865667 + (abs(x_104) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_106;
    tmpvar_106 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_107;
    tmpvar_107 = floor(tmpvar_106);
    highp float tmpvar_108;
    tmpvar_108 = (tmpvar_106 - tmpvar_107);
    highp float tmpvar_109;
    tmpvar_109 = (floor(((uR_95 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_110;
    tmpvar_110 = (floor((uR_95 * RES_R)) / RES_R);
    highp float tmpvar_111;
    tmpvar_111 = fract((uR_95 * RES_R));
    highp vec4 tmpvar_112;
    tmpvar_112.zw = vec2(0.0, 0.0);
    tmpvar_112.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_112.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_113;
    tmpvar_113 = texture2DLodEXT (_Inscatter, tmpvar_112.xy, 0.0);
    highp vec4 tmpvar_114;
    tmpvar_114.zw = vec2(0.0, 0.0);
    tmpvar_114.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_114.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_115;
    tmpvar_115 = texture2DLodEXT (_Inscatter, tmpvar_114.xy, 0.0);
    highp vec4 tmpvar_116;
    tmpvar_116.zw = vec2(0.0, 0.0);
    tmpvar_116.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_116.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_117;
    tmpvar_117 = texture2DLodEXT (_Inscatter, tmpvar_116.xy, 0.0);
    highp vec4 tmpvar_118;
    tmpvar_118.zw = vec2(0.0, 0.0);
    tmpvar_118.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_118.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_119;
    tmpvar_119 = texture2DLodEXT (_Inscatter, tmpvar_118.xy, 0.0);
    highp vec4 tmpvar_120;
    tmpvar_120 = max ((inScatter0_30 - (((((tmpvar_113 * (1.0 - tmpvar_108)) + (tmpvar_115 * tmpvar_108)) * (1.0 - tmpvar_111)) + (((tmpvar_117 * (1.0 - tmpvar_108)) + (tmpvar_119 * tmpvar_108)) * tmpvar_111)) * extinction_29.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_33.xyz = tmpvar_120.xyz;
    highp float t_121;
    t_121 = max (min ((tmpvar_50 / 0.02), 1.0), 0.0);
    inScatter_33.w = (tmpvar_120.w * (t_121 * (t_121 * (3.0 - (2.0 * t_121)))));
    tmpvar_26 = (((tmpvar_120.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_49 * tmpvar_49)))) + ((((tmpvar_120.xyz * inScatter_33.w) / max (tmpvar_120.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_49)), -1.5)) * (1.0 + (tmpvar_49 * tmpvar_49))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_122;
    highp vec3 arg0_123;
    arg0_123 = (tmpvar_25 - _camPos);
    tmpvar_122 = sqrt(dot (arg0_123, arg0_123));
    highp float tmpvar_124;
    if ((tmpvar_122 <= _global_depth)) {
      tmpvar_124 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_122) / _global_depth))));
    } else {
      tmpvar_124 = 1.0;
    };
    highp vec3 L_125;
    highp vec3 tmpvar_126;
    tmpvar_126 = (tmpvar_26 * _Exposure);
    L_125 = tmpvar_126;
    highp float tmpvar_127;
    if ((tmpvar_126.x < 1.413)) {
      tmpvar_127 = pow ((tmpvar_126.x * 0.38317), 0.454545);
    } else {
      tmpvar_127 = (1.0 - exp(-(tmpvar_126.x)));
    };
    L_125.x = tmpvar_127;
    highp float tmpvar_128;
    if ((tmpvar_126.y < 1.413)) {
      tmpvar_128 = pow ((tmpvar_126.y * 0.38317), 0.454545);
    } else {
      tmpvar_128 = (1.0 - exp(-(tmpvar_126.y)));
    };
    L_125.y = tmpvar_128;
    highp float tmpvar_129;
    if ((tmpvar_126.z < 1.413)) {
      tmpvar_129 = pow ((tmpvar_126.z * 0.38317), 0.454545);
    } else {
      tmpvar_129 = (1.0 - exp(-(tmpvar_126.z)));
    };
    L_125.z = tmpvar_129;
    highp vec4 tmpvar_130;
    tmpvar_130.w = 1.0;
    tmpvar_130.xyz = ((L_125 * _global_alpha) * tmpvar_124);
    tmpvar_1 = tmpvar_130;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  highp vec2 tmpvar_6;
  tmpvar_6 = (o_3.xy / tmpvar_2.w);
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp mat4 _ViewProjInv;
uniform highp float _experimentalAtmoScale;
uniform highp float _global_alpha;
uniform highp float _Exposure;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform highp float _openglThreshold;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float godrayDepth_2;
  bool infinite_3;
  highp float depth_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_4 = tmpvar_5;
  infinite_3 = (depth_4 == 1.0);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_6.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_6.z = depth_4;
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ViewProjInv * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (1.0 - abs(dot (normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx))), normalize(((tmpvar_7 / tmpvar_7.w).xyz - _camPos)))));
  lowp float tmpvar_9;
  tmpvar_9 = texture (_godrayDepthTexture, xlv_TEXCOORD2).x;
  godrayDepth_2 = tmpvar_9;
  if ((((godrayDepth_2 > 0.0) && (godrayDepth_2 < depth_4)) && (depth_4 < 1.0))) {
    depth_4 = mix (depth_4, godrayDepth_2, tmpvar_8);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.x = ((xlv_TEXCOORD2.x * 2.0) - 1.0);
  tmpvar_10.y = ((xlv_TEXCOORD2.y * 2.0) - 1.0);
  tmpvar_10.z = depth_4;
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ViewProjInv * tmpvar_10);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 / tmpvar_11.w).xyz;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_12 - _camPos);
  highp float tmpvar_15;
  tmpvar_15 = dot (tmpvar_14, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = (2.0 * dot (tmpvar_14, _camPos));
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (dot (_camPos, _camPos) - (Rg * Rg))));
  if ((tmpvar_17 < 0.0)) {
    tmpvar_13 = -1.0;
  } else {
    tmpvar_13 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
  };
  bool tmpvar_18;
  tmpvar_18 = (tmpvar_13 > 0.0);
  if ((!(tmpvar_18) && infinite_3)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_19;
    tmpvar_19 = (_camPos + (tmpvar_13 * (tmpvar_12 - _camPos)));
    highp vec3 arg0_20;
    arg0_20 = (tmpvar_19 - _camPos);
    highp vec3 arg0_21;
    arg0_21 = (tmpvar_12 - _camPos);
    bool tmpvar_22;
    tmpvar_22 = (sqrt(dot (arg0_20, arg0_20)) < sqrt(dot (arg0_21, arg0_21)));
    highp vec3 tmpvar_23;
    if ((tmpvar_18 && tmpvar_22)) {
      tmpvar_23 = tmpvar_19;
    } else {
      tmpvar_23 = tmpvar_12;
    };
    highp float tmpvar_24;
    tmpvar_24 = sqrt(dot (tmpvar_23, tmpvar_23));
    highp vec3 tmpvar_25;
    if ((tmpvar_24 < (Rg + _openglThreshold))) {
      tmpvar_25 = ((Rg + _openglThreshold) * normalize(tmpvar_23));
    } else {
      tmpvar_25 = tmpvar_23;
    };
    highp vec3 tmpvar_26;
    highp vec3 camera_27;
    camera_27 = _camPos;
    highp vec3 _point_28;
    _point_28 = tmpvar_25;
    highp vec3 extinction_29;
    highp vec4 inScatter0_30;
    highp float muS1_31;
    highp float mu1_32;
    highp vec4 inScatter_33;
    highp float mu_34;
    highp float rMu_35;
    highp float r_36;
    highp float d_37;
    extinction_29 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_38;
    tmpvar_38 = (tmpvar_25 - _camPos);
    highp float tmpvar_39;
    tmpvar_39 = sqrt(dot (tmpvar_38, tmpvar_38));
    d_37 = tmpvar_39;
    highp float tmpvar_40;
    tmpvar_40 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_41;
    tmpvar_41 = normalize((tmpvar_38 / tmpvar_39));
    highp float tmpvar_42;
    tmpvar_42 = sqrt(dot (_camPos, _camPos));
    r_36 = tmpvar_42;
    if ((tmpvar_42 < (0.9 * Rg))) {
      camera_27.y = (_camPos.y + Rg);
      _point_28.y = (tmpvar_25.y + Rg);
      r_36 = sqrt(dot (camera_27, camera_27));
    };
    highp float tmpvar_43;
    tmpvar_43 = dot (camera_27, tmpvar_41);
    rMu_35 = tmpvar_43;
    mu_34 = (tmpvar_43 / r_36);
    highp vec3 tmpvar_44;
    tmpvar_44 = (_point_28 - (tmpvar_41 * clamp (1.0, 0.0, tmpvar_39)));
    _point_28 = tmpvar_44;
    highp float f_45;
    f_45 = (((tmpvar_43 * tmpvar_43) - (r_36 * r_36)) + (tmpvar_40 * tmpvar_40));
    highp float tmpvar_46;
    if ((f_45 >= 0.0)) {
      tmpvar_46 = sqrt(f_45);
    } else {
      tmpvar_46 = 1e+30;
    };
    highp float tmpvar_47;
    tmpvar_47 = max ((-(tmpvar_43) - tmpvar_46), 0.0);
    if (((tmpvar_47 > 0.0) && (tmpvar_47 < tmpvar_39))) {
      camera_27 = (camera_27 + (tmpvar_47 * tmpvar_41));
      highp float tmpvar_48;
      tmpvar_48 = (tmpvar_43 + tmpvar_47);
      rMu_35 = tmpvar_48;
      mu_34 = (tmpvar_48 / tmpvar_40);
      r_36 = tmpvar_40;
      d_37 = (tmpvar_39 - tmpvar_47);
    };
    highp float tmpvar_49;
    tmpvar_49 = dot (tmpvar_41, SUN_DIR);
    highp float tmpvar_50;
    tmpvar_50 = (dot (camera_27, SUN_DIR) / r_36);
    if ((r_36 < (Rg + 1600.0))) {
      highp float tmpvar_51;
      tmpvar_51 = ((Rg + 1600.0) / r_36);
      r_36 = (r_36 * tmpvar_51);
      rMu_35 = (rMu_35 * tmpvar_51);
      _point_28 = (tmpvar_44 * tmpvar_51);
    };
    highp float tmpvar_52;
    tmpvar_52 = sqrt(dot (_point_28, _point_28));
    mu1_32 = (dot (_point_28, tmpvar_41) / tmpvar_52);
    muS1_31 = (dot (_point_28, SUN_DIR) / tmpvar_52);
    highp float tmpvar_53;
    highp float H_54;
    H_54 = (HR * _experimentalAtmoScale);
    highp vec2 tmpvar_55;
    tmpvar_55.x = mu_34;
    tmpvar_55.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_56;
    tmpvar_56 = (sqrt(((0.5 / H_54) * r_36)) * tmpvar_55);
    highp vec2 tmpvar_57;
    tmpvar_57 = sign(tmpvar_56);
    highp vec2 tmpvar_58;
    tmpvar_58 = (tmpvar_56 * tmpvar_56);
    highp float tmpvar_59;
    if ((tmpvar_57.y > tmpvar_57.x)) {
      tmpvar_59 = exp(tmpvar_58.x);
    } else {
      tmpvar_59 = 0.0;
    };
    highp vec2 tmpvar_60;
    tmpvar_60.x = 1.0;
    tmpvar_60.y = exp(((-(d_37) / H_54) * ((d_37 / (2.0 * r_36)) + mu_34)));
    tmpvar_53 = ((sqrt(((6.2831 * H_54) * r_36)) * exp(((Rg - r_36) / H_54))) * (tmpvar_59 + dot (((tmpvar_57 / ((2.3193 * abs(tmpvar_56)) + sqrt(((1.52 * tmpvar_58) + 4.0)))) * tmpvar_60), vec2(1.0, -1.0))));
    highp float H_61;
    H_61 = (HM * _experimentalAtmoScale);
    highp vec2 tmpvar_62;
    tmpvar_62.x = mu_34;
    tmpvar_62.y = (mu_34 + (d_37 / r_36));
    highp vec2 tmpvar_63;
    tmpvar_63 = (sqrt(((0.5 / H_61) * r_36)) * tmpvar_62);
    highp vec2 tmpvar_64;
    tmpvar_64 = sign(tmpvar_63);
    highp vec2 tmpvar_65;
    tmpvar_65 = (tmpvar_63 * tmpvar_63);
    highp float tmpvar_66;
    if ((tmpvar_64.y > tmpvar_64.x)) {
      tmpvar_66 = exp(tmpvar_65.x);
    } else {
      tmpvar_66 = 0.0;
    };
    highp vec2 tmpvar_67;
    tmpvar_67.x = 1.0;
    tmpvar_67.y = exp(((-(d_37) / H_61) * ((d_37 / (2.0 * r_36)) + mu_34)));
    extinction_29 = min (exp(((-(betaR) * tmpvar_53) - (betaMEx * ((sqrt(((6.2831 * H_61) * r_36)) * exp(((Rg - r_36) / H_61))) * (tmpvar_66 + dot (((tmpvar_64 / ((2.3193 * abs(tmpvar_63)) + sqrt(((1.52 * tmpvar_65) + 4.0)))) * tmpvar_67), vec2(1.0, -1.0))))))), vec3(1.0, 1.0, 1.0));
    highp float uMu_68;
    highp float uR_69;
    highp float tmpvar_70;
    tmpvar_70 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_71;
    tmpvar_71 = sqrt(((r_36 * r_36) - (Rg * Rg)));
    highp float tmpvar_72;
    tmpvar_72 = (r_36 * mu_34);
    highp float tmpvar_73;
    tmpvar_73 = (((tmpvar_72 * tmpvar_72) - (r_36 * r_36)) + (Rg * Rg));
    highp vec4 tmpvar_74;
    if (((tmpvar_72 < 0.0) && (tmpvar_73 > 0.0))) {
      highp vec4 tmpvar_75;
      tmpvar_75.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_75.w = (0.5 - (0.5 / RES_MU));
      tmpvar_74 = tmpvar_75;
    } else {
      highp vec4 tmpvar_76;
      tmpvar_76.x = -1.0;
      tmpvar_76.y = (tmpvar_70 * tmpvar_70);
      tmpvar_76.z = tmpvar_70;
      tmpvar_76.w = (0.5 + (0.5 / RES_MU));
      tmpvar_74 = tmpvar_76;
    };
    uR_69 = ((0.5 / RES_R) + ((tmpvar_71 / tmpvar_70) * (1.0 - (1.0/(RES_R)))));
    uMu_68 = (tmpvar_74.w + ((((tmpvar_72 * tmpvar_74.x) + sqrt((tmpvar_73 + tmpvar_74.y))) / (tmpvar_71 + tmpvar_74.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_77;
    y_over_x_77 = (max (tmpvar_50, -0.1975) * 5.34962);
    highp float x_78;
    x_78 = (y_over_x_77 * inversesqrt(((y_over_x_77 * y_over_x_77) + 1.0)));
    highp float tmpvar_79;
    tmpvar_79 = ((0.5 / RES_MU_S) + (((((sign(x_78) * (1.5708 - (sqrt((1.0 - abs(x_78))) * (1.5708 + (abs(x_78) * (-0.214602 + (abs(x_78) * (0.0865667 + (abs(x_78) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_80;
    tmpvar_80 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_81;
    tmpvar_81 = floor(tmpvar_80);
    highp float tmpvar_82;
    tmpvar_82 = (tmpvar_80 - tmpvar_81);
    highp float tmpvar_83;
    tmpvar_83 = (floor(((uR_69 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_84;
    tmpvar_84 = (floor((uR_69 * RES_R)) / RES_R);
    highp float tmpvar_85;
    tmpvar_85 = fract((uR_69 * RES_R));
    highp vec4 tmpvar_86;
    tmpvar_86.zw = vec2(0.0, 0.0);
    tmpvar_86.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_86.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_87;
    tmpvar_87 = textureLod (_Inscatter, tmpvar_86.xy, 0.0);
    highp vec4 tmpvar_88;
    tmpvar_88.zw = vec2(0.0, 0.0);
    tmpvar_88.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_88.y = ((uMu_68 / RES_R) + tmpvar_83);
    lowp vec4 tmpvar_89;
    tmpvar_89 = textureLod (_Inscatter, tmpvar_88.xy, 0.0);
    highp vec4 tmpvar_90;
    tmpvar_90.zw = vec2(0.0, 0.0);
    tmpvar_90.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
    tmpvar_90.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_91;
    tmpvar_91 = textureLod (_Inscatter, tmpvar_90.xy, 0.0);
    highp vec4 tmpvar_92;
    tmpvar_92.zw = vec2(0.0, 0.0);
    tmpvar_92.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
    tmpvar_92.y = ((uMu_68 / RES_R) + tmpvar_84);
    lowp vec4 tmpvar_93;
    tmpvar_93 = textureLod (_Inscatter, tmpvar_92.xy, 0.0);
    inScatter0_30 = ((((tmpvar_87 * (1.0 - tmpvar_82)) + (tmpvar_89 * tmpvar_82)) * (1.0 - tmpvar_85)) + (((tmpvar_91 * (1.0 - tmpvar_82)) + (tmpvar_93 * tmpvar_82)) * tmpvar_85));
    highp float uMu_94;
    highp float uR_95;
    highp float tmpvar_96;
    tmpvar_96 = sqrt(((tmpvar_40 * tmpvar_40) - (Rg * Rg)));
    highp float tmpvar_97;
    tmpvar_97 = sqrt(((tmpvar_52 * tmpvar_52) - (Rg * Rg)));
    highp float tmpvar_98;
    tmpvar_98 = (tmpvar_52 * mu1_32);
    highp float tmpvar_99;
    tmpvar_99 = (((tmpvar_98 * tmpvar_98) - (tmpvar_52 * tmpvar_52)) + (Rg * Rg));
    highp vec4 tmpvar_100;
    if (((tmpvar_98 < 0.0) && (tmpvar_99 > 0.0))) {
      highp vec4 tmpvar_101;
      tmpvar_101.xyz = vec3(1.0, 0.0, 0.0);
      tmpvar_101.w = (0.5 - (0.5 / RES_MU));
      tmpvar_100 = tmpvar_101;
    } else {
      highp vec4 tmpvar_102;
      tmpvar_102.x = -1.0;
      tmpvar_102.y = (tmpvar_96 * tmpvar_96);
      tmpvar_102.z = tmpvar_96;
      tmpvar_102.w = (0.5 + (0.5 / RES_MU));
      tmpvar_100 = tmpvar_102;
    };
    uR_95 = ((0.5 / RES_R) + ((tmpvar_97 / tmpvar_96) * (1.0 - (1.0/(RES_R)))));
    uMu_94 = (tmpvar_100.w + ((((tmpvar_98 * tmpvar_100.x) + sqrt((tmpvar_99 + tmpvar_100.y))) / (tmpvar_97 + tmpvar_100.z)) * (0.5 - (1.0/(RES_MU)))));
    highp float y_over_x_103;
    y_over_x_103 = (max (muS1_31, -0.1975) * 5.34962);
    highp float x_104;
    x_104 = (y_over_x_103 * inversesqrt(((y_over_x_103 * y_over_x_103) + 1.0)));
    highp float tmpvar_105;
    tmpvar_105 = ((0.5 / RES_MU_S) + (((((sign(x_104) * (1.5708 - (sqrt((1.0 - abs(x_104))) * (1.5708 + (abs(x_104) * (-0.214602 + (abs(x_104) * (0.0865667 + (abs(x_104) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
    highp float tmpvar_106;
    tmpvar_106 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float tmpvar_107;
    tmpvar_107 = floor(tmpvar_106);
    highp float tmpvar_108;
    tmpvar_108 = (tmpvar_106 - tmpvar_107);
    highp float tmpvar_109;
    tmpvar_109 = (floor(((uR_95 * RES_R) - 1.0)) / RES_R);
    highp float tmpvar_110;
    tmpvar_110 = (floor((uR_95 * RES_R)) / RES_R);
    highp float tmpvar_111;
    tmpvar_111 = fract((uR_95 * RES_R));
    highp vec4 tmpvar_112;
    tmpvar_112.zw = vec2(0.0, 0.0);
    tmpvar_112.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_112.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_113;
    tmpvar_113 = textureLod (_Inscatter, tmpvar_112.xy, 0.0);
    highp vec4 tmpvar_114;
    tmpvar_114.zw = vec2(0.0, 0.0);
    tmpvar_114.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_114.y = ((uMu_94 / RES_R) + tmpvar_109);
    lowp vec4 tmpvar_115;
    tmpvar_115 = textureLod (_Inscatter, tmpvar_114.xy, 0.0);
    highp vec4 tmpvar_116;
    tmpvar_116.zw = vec2(0.0, 0.0);
    tmpvar_116.x = ((tmpvar_107 + tmpvar_105) / RES_NU);
    tmpvar_116.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_117;
    tmpvar_117 = textureLod (_Inscatter, tmpvar_116.xy, 0.0);
    highp vec4 tmpvar_118;
    tmpvar_118.zw = vec2(0.0, 0.0);
    tmpvar_118.x = (((tmpvar_107 + tmpvar_105) + 1.0) / RES_NU);
    tmpvar_118.y = ((uMu_94 / RES_R) + tmpvar_110);
    lowp vec4 tmpvar_119;
    tmpvar_119 = textureLod (_Inscatter, tmpvar_118.xy, 0.0);
    highp vec4 tmpvar_120;
    tmpvar_120 = max ((inScatter0_30 - (((((tmpvar_113 * (1.0 - tmpvar_108)) + (tmpvar_115 * tmpvar_108)) * (1.0 - tmpvar_111)) + (((tmpvar_117 * (1.0 - tmpvar_108)) + (tmpvar_119 * tmpvar_108)) * tmpvar_111)) * extinction_29.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
    inScatter_33.xyz = tmpvar_120.xyz;
    highp float t_121;
    t_121 = max (min ((tmpvar_50 / 0.02), 1.0), 0.0);
    inScatter_33.w = (tmpvar_120.w * (t_121 * (t_121 * (3.0 - (2.0 * t_121)))));
    tmpvar_26 = (((tmpvar_120.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_49 * tmpvar_49)))) + ((((tmpvar_120.xyz * inScatter_33.w) / max (tmpvar_120.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_49)), -1.5)) * (1.0 + (tmpvar_49 * tmpvar_49))) / (2.0 + (mieG * mieG))))) * SUN_INTENSITY);
    highp float tmpvar_122;
    highp vec3 arg0_123;
    arg0_123 = (tmpvar_25 - _camPos);
    tmpvar_122 = sqrt(dot (arg0_123, arg0_123));
    highp float tmpvar_124;
    if ((tmpvar_122 <= _global_depth)) {
      tmpvar_124 = (1.0 - exp((-1.0 * ((4.0 * tmpvar_122) / _global_depth))));
    } else {
      tmpvar_124 = 1.0;
    };
    highp vec3 L_125;
    highp vec3 tmpvar_126;
    tmpvar_126 = (tmpvar_26 * _Exposure);
    L_125 = tmpvar_126;
    highp float tmpvar_127;
    if ((tmpvar_126.x < 1.413)) {
      tmpvar_127 = pow ((tmpvar_126.x * 0.38317), 0.454545);
    } else {
      tmpvar_127 = (1.0 - exp(-(tmpvar_126.x)));
    };
    L_125.x = tmpvar_127;
    highp float tmpvar_128;
    if ((tmpvar_126.y < 1.413)) {
      tmpvar_128 = pow ((tmpvar_126.y * 0.38317), 0.454545);
    } else {
      tmpvar_128 = (1.0 - exp(-(tmpvar_126.y)));
    };
    L_125.y = tmpvar_128;
    highp float tmpvar_129;
    if ((tmpvar_126.z < 1.413)) {
      tmpvar_129 = pow ((tmpvar_126.z * 0.38317), 0.454545);
    } else {
      tmpvar_129 = (1.0 - exp(-(tmpvar_126.z)));
    };
    L_125.z = tmpvar_129;
    highp vec4 tmpvar_130;
    tmpvar_130.w = 1.0;
    tmpvar_130.xyz = ((L_125 * _global_alpha) * tmpvar_124);
    tmpvar_1 = tmpvar_130;
  };
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GODRAYS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 509 math, 17 textures, 1 branches
Keywords { "GODRAYS_OFF" }
Matrix 0 [_ViewProjInv]
Float 4 [M_PI]
Float 5 [HR]
Vector 6 [betaR]
Float 7 [HM]
Vector 8 [betaMEx]
Float 9 [mieG]
Float 10 [Rg]
Float 11 [Rt]
Float 12 [RES_R]
Float 13 [RES_MU]
Float 14 [RES_MU_S]
Float 15 [RES_NU]
Vector 16 [SUN_DIR]
Float 17 [SUN_INTENSITY]
Float 18 [_experimentalAtmoScale]
Float 19 [_global_alpha]
Float 20 [_Exposure]
Float 21 [_global_depth]
Vector 22 [_camPos]
Float 23 [_openglThreshold]
SetTexture 0 [_customDepthTexture] 2D 0
SetTexture 1 [_Inscatter] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c24, 2.00000000, -1.00000000, 1.00000000, 0.00000000
def c25, 4.00000000, 16.00000000, 0.89999998, 1000000015047466200000000000000.00000000
def c26, 1600.00000000, -0.19750001, 5.34960032, -0.12123910
def c27, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c28, 0.99999559, 1.57079601, 0.90909088, 0.74000001
def c29, 0.50000000, 6.28310013, 2.71828198, 2.31929994
def c30, 1.51999998, 4.00000000, 3.00000000, -1.50000000
def c31, 50.00000000, 2.00000000, 3.00000000, 0.00010000
def c32, 1.50000000, -1.41299999, 0.38317001, 0.45454544
dcl_texcoord2 v0.xy
texld r0.x, v0, s0
mov r3.z, r0.x
mad r3.xy, v0, c24.x, c24.y
mov r3.w, c24.z
dp4 r0.z, r3, c3
dp4 r2.z, r3, c2
dp4 r2.y, r3, c1
dp4 r2.x, r3, c0
rcp r0.z, r0.z
mov r3.xyz, c22
mul r2.xyz, r2, r0.z
dp3 r0.w, c24.w, r3
dp3 r0.z, c22, c22
add r0.z, r0, -r0.w
add r3.xyz, r2, -c22
dp3 r0.w, r3, r3
mad r0.z, -c10.x, c10.x, r0
mul r2.w, r0, r0.z
dp3 r0.z, r3, c22
mul r0.z, r0, c24.x
mul r2.w, r2, c25.x
mad r2.w, r0.z, r0.z, -r2
cmp_pp r3.x, r2.w, c24.z, c24.w
cmp r0.y, r2.w, r0, c24
rsq r2.w, r2.w
mul r3.y, r0.w, c24.x
rcp r0.w, r2.w
add r0.z, -r0, -r0.w
rcp r2.w, r3.y
mul r0.z, r0, r2.w
cmp r0.y, -r3.x, r0, r0.z
add r0.z, r0.x, c24.y
abs r0.w, r0.z
cmp r0.x, -r0.y, c24.w, c24.z
abs_pp r0.z, r0.x
cmp r0.w, -r0, c24.z, c24
cmp_pp r0.z, -r0, c24, c24.w
mul_pp r0.z, r0, r0.w
cmp_pp r0.w, -r0.z, c24.z, c24
cmp_pp oC0, -r0.z, r1, c24.w
if_gt r0.w, c24.w
add r1.xyz, r2, -c22
rcp r10.y, c12.x
mul r3.xyz, r0.y, r1
dp3 r0.z, r1, r1
dp3 r0.y, r3, r3
add r1.xyz, r3, c22
rcp r7.w, c14.x
rsq r0.z, r0.z
rsq r0.y, r0.y
mov r5.xz, c22
rcp r9.z, c15.x
add r8.w, -r7, c24.z
mul r9.w, c10.x, c10.x
mov r3.x, c24.y
rcp r0.z, r0.z
rcp r0.y, r0.y
add r0.y, r0, -r0.z
cmp r0.y, r0, c24.w, c24.z
mul_pp r0.x, r0, r0.y
cmp r0.xyz, -r0.x, r2, r1
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mov r1.x, c10
add r1.x, c23, r1
rcp r0.w, r0.w
mul r2.xyz, r1.x, r2
add r0.w, r0, -r1.x
cmp r0.xyz, r0.w, r0, r2
add r1.xyz, r0, -c22
dp3 r0.w, r1, r1
rsq r1.w, r0.w
mul r1.xyz, r1.w, r1
dp3 r0.w, r1, r1
rsq r2.x, r0.w
mul r6.xyz, r2.x, r1
mov r0.w, c22.y
add r2.w, c10.x, r0
dp3 r2.y, c22, c22
rsq r2.y, r2.y
rcp r6.w, r1.w
dp3 r5.w, r6, c16
rcp r2.y, r2.y
mov r0.w, c10.x
mad r2.z, c25, -r0.w, r2.y
cmp r5.y, r2.z, c22, r2.w
dp3 r0.w, r5, r5
rsq r0.w, r0.w
rcp r1.x, r0.w
cmp r12.z, r2, r2.y, r1.x
mov r0.w, c11.x
add r0.w, -c10.x, r0
mul r0.w, r0, c18.x
dp3 r11.z, r6, r5
mul r1.x, r12.z, r12.z
add r11.w, r0, c10.x
mad r1.x, r11.z, r11.z, -r1
mad r0.w, r11, r11, r1.x
rsq r1.x, r0.w
rcp r1.x, r1.x
cmp r0.w, r0, r1.x, c25
add r0.w, -r11.z, -r0
max r11.y, r0.w, c24.w
add r0.w, r11.y, -r6
cmp r1.x, r0.w, c24.w, c24.z
cmp r0.w, -r11.y, c24, c24.z
mul_pp r12.x, r0.w, r1
cmp r7.z, -r12.x, r12, r11.w
add r1.x, r0.y, c10
mov r0.w, c10.x
add r12.w, c26.x, r0
rcp r12.y, r7.z
add r13.z, r7, -r12.w
cmp r0.y, r2.z, r0, r1.x
mov_sat r0.w, r6
mad r0.xyz, -r6, r0.w, r0
mul r1.y, r12.w, r12
mul r1.xyz, r0, r1.y
cmp r0.xyz, r13.z, r0, r1
dp3 r0.w, r0, r0
dp3 r1.x, r0, c16
dp3 r0.x, r6, r0
rsq r0.w, r0.w
mad r0.z, r11.w, r11.w, -r9.w
mul r1.x, r0.w, r1
max r1.x, r1, c26.y
mul r1.x, r1, c26.z
abs r1.y, r1.x
max r1.z, r1.y, c24
rcp r1.w, r1.z
min r1.z, r1.y, c24
mul r1.z, r1, r1.w
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c27, c27.y
mad r2.x, r2, r1.w, c26.w
mad r2.x, r2, r1.w, c27.z
mad r2.x, r2, r1.w, c27.w
mad r1.w, r2.x, r1, c28.x
mul r1.z, r1.w, r1
rsq r10.x, r0.z
add r1.w, -r1.z, c28.y
add r1.y, r1, c24
cmp r1.y, -r1, r1.z, r1.w
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c15.x
add r1.z, c24.y, r1.y
add r1.y, r5.w, c24.z
mul r1.y, r1, r1.z
rcp r1.z, r0.w
mul r1.y, r1, c29.x
frc r9.x, r1.y
mad r1.x, r1, c28.z, c28.w
add r11.x, -r9, c24.z
add r9.y, r1, -r9.x
mad r1.x, r1, r8.w, r7.w
mad r1.x, r1, c29, r9.y
mul r8.x, r1, r9.z
add r1.y, r1.x, c24.z
mul r7.x, r9.z, r1.y
rcp r1.y, c13.x
mul r0.x, r0.w, r0
mul r1.x, r1.z, r0
mul r0.y, r1.z, r1.z
mad r0.y, r1.x, r1.x, -r0
mad r1.w, c10.x, c10.x, r0.y
mad r1.z, r1, r1, -r9.w
rsq r1.z, r1.z
mad r3.w, r1.y, c29.x, c29.x
cmp r0.y, -r1.w, c24.w, c24.z
cmp r0.x, r1, c24.w, c24.z
mul_pp r0.x, r0, r0.y
rcp r0.y, r10.x
mul r3.y, r0, r0
mov r3.z, r0.y
mad r2.w, -r1.y, c29.x, c29.x
mov r2.xyz, c24.zwww
cmp r0, -r0.x, r3, r2
add r0.y, r0, r1.w
rcp r1.z, r1.z
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.x, r1, r0, r0.y
add r0.y, r0.z, r1.z
mul r1.w, r10.x, r1.z
add r10.z, -r10.y, c24
rcp r0.y, r0.y
mul r1.w, r1, r10.z
mad r1.w, r10.y, c29.x, r1
mul r1.w, r1, c12.x
add r0.z, r1.w, c24.y
frc r13.x, r1.w
mul r0.x, r0, r0.y
frc r1.x, r0.z
add r0.y, r0.z, -r1.x
add r10.w, -r1.y, c29.x
mad r4.w, r0.x, r10, r0
mul r0.y, r0, r10
mad r1.y, r4.w, r10, r0
mov r4.x, r8
mov r4.y, r1
mov r4.z, c24.w
texldl r0, r4.xyzz, s1
add r4.x, r1.w, -r13
mul r4.x, r10.y, r4
mad r7.y, r4.w, r10, r4.x
mov r8.y, r7
mov r1.x, r7
mov r1.z, c24.w
texldl r1, r1.xyzz, s1
mul r1, r9.x, r1
mad r4, r0, r11.x, r1
mov r8.z, c24.w
texldl r0, r8.xyzz, s1
cmp r8.z, r13, r7, r12.w
mov r1.x, c5
mul r13.y, c18.x, r1.x
rcp r13.z, r13.y
mov r7.z, c24.w
texldl r1, r7.xyzz, s1
mul r8.x, r8.z, r13.z
mul r7.x, r8, c29
rsq r8.x, r7.x
mul r1, r9.x, r1
mad r0, r11.x, r0, r1
rcp r7.x, r12.z
add r7.z, -r11.y, r6.w
cmp r7.z, -r12.x, r6.w, r7
mul r1, r13.x, r0
rcp r7.y, r8.z
add r8.y, r11, r11.z
rcp r11.w, r11.w
mul r8.y, r8, r11.w
mul r7.x, r11.z, r7
cmp r7.x, -r12, r7, r8.y
mad r7.y, r7.z, r7, r7.x
rcp r8.x, r8.x
mul r8.xy, r8.x, r7
mul r11.zw, r8.xyxy, r8.xyxy
mad r0.xy, r11.zwzw, c30.x, c30.y
rsq r0.x, r0.x
rsq r0.y, r0.y
cmp r0.zw, -r8.xyxy, c24.w, c24.z
cmp r12.zw, r8.xyxy, c24.w, c24.z
add r12.zw, r0, -r12
abs r0.zw, r8.xyxy
mul r8.x, r8.z, c24
rcp r11.w, r8.x
mad r11.w, r7.z, r11, r7.x
rcp r0.x, r0.x
rcp r0.y, r0.y
mad r8.xy, r0.zwzw, c29.w, r0
mul r0.x, r13.z, -r7.z
mul r13.w, r0.x, r11
pow r0, c29.z, r13.w
rcp r8.x, r8.x
rcp r8.y, r8.y
mul r0.zw, r12, r8.xyxy
mov r0.x, c24.z
mul r0.xy, r0.zwzw, r0
add r0.z, -r13.x, c24
mad r1, r4, r0.z, r1
mul r0.xy, r0, c24.zyzw
mov r0.z, c7.x
add r4.x, r0, r0.y
mul r13.x, c18, r0.z
pow r0, c29.z, r11.z
add r4.y, r12.w, -r12.z
rcp r12.z, r13.x
mul r0.y, r8.z, r12.z
cmp r0.x, -r4.y, c24.w, r0
add r11.z, -r8, c10.x
mul r0.y, r0, c29.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r4.zw, r7.xyxy, r0.y
add r8.x, r0, r4
mul r8.y, r11.z, r13.z
mul r4.xy, r4.zwzw, r4.zwzw
pow r0, c29.z, r8.y
mul r7.y, r13, r8.z
mul r0.y, r7, c29
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r7.y, r0.x, r8.x
mad r0.xy, r4, c30.x, c30.y
rsq r0.y, r0.y
rsq r0.x, r0.x
abs r0.zw, r4
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r0.xy, r0.zwzw, c29.w, r0
cmp r0.zw, r4, c24.w, c24.z
cmp r4.zw, -r4, c24.w, c24.z
add r4.zw, r4, -r0
mul r0.w, -r7.z, r12.z
rcp r8.x, r0.x
rcp r8.y, r0.y
mad r0.xyz, r6, r11.y, r5
mul r6.xy, r4.zwzw, r8
cmp r0.xyz, -r12.x, r5, r0
dp3 r0.x, r0, c16
mul r4.y, r11.w, r0.w
mul r5.x, r12.y, r0
pow r0, c29.z, r4.y
max r0.x, r5, c26.y
mul r4.y, r0.x, c26.z
abs r5.y, r4
max r0.z, r5.y, c24
rcp r0.w, r0.z
mov r0.x, c24.z
mul r0.xy, r6, r0
min r0.z, r5.y, c24
mul r6.x, r0.z, r0.w
mul r0.xy, r0, c24.zyzw
add r5.z, r0.x, r0.y
pow r0, c29.z, r4.x
mul r6.y, r6.x, r6.x
add r4.z, r4.w, -r4
mad r4.w, r6.y, c27.x, c27.y
mad r0.y, r4.w, r6, c26.w
cmp r0.x, -r4.z, c24.w, r0
mad r0.y, r0, r6, c27.z
mad r0.y, r0, r6, c27.w
mad r0.y, r0, r6, c28.x
add r4.w, r0.x, r5.z
mul r5.z, r0.y, r6.x
mul r4.z, r11, r12
pow r0, c29.z, r4.z
mul r4.x, r8.z, r13
mul r0.y, r4.x, c29
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
add r0.y, r5, c24
add r0.z, -r5, c28.y
cmp r0.w, -r0.y, r5.z, r0.z
mul r0.x, r0, r4.w
cmp r0.w, r4.y, r0, -r0
mul r0.xyz, r0.x, c8
mad r4.xyz, r7.y, -c6, -r0
mad r4.w, r0, c28.z, c28
pow r0, c29.z, r4.x
mad r0.y, r8.w, r4.w, r7.w
mad r0.z, r0.y, c29.x, r9.y
add r4.w, r0.z, c24.z
mul r8.x, r9.z, r4.w
mul r0.y, r8.z, r7.x
mul r0.w, r8.z, r8.z
mad r0.w, r0.y, r0.y, -r0
mad r4.x, c10, c10, r0.w
mad r5.y, r8.z, r8.z, -r9.w
cmp r4.w, -r4.x, c24, c24.z
cmp r0.w, r0.y, c24, c24.z
mul_pp r0.w, r0, r4
cmp r2, -r0.w, r3, r2
add r0.w, r2.y, r4.x
rsq r4.w, r5.y
rcp r3.x, r4.w
mul r2.y, r10.x, r3.x
rsq r0.w, r0.w
mul r2.y, r10.z, r2
rcp r0.w, r0.w
mad r0.w, r0.y, r2.x, r0
add r2.x, r2.z, r3
rcp r2.x, r2.x
mul r0.w, r0, r2.x
mad r2.y, r10, c29.x, r2
mul r2.y, r2, c12.x
frc r0.y, r2
add r2.z, r2.y, -r0.y
mad r0.w, r10, r0, r2
mul r2.x, r10.y, r2.z
mad r8.y, r10, r0.w, r2.x
add r2.x, r2.y, c24.y
frc r2.y, r2.x
add r2.x, r2, -r2.y
mov r8.z, c24.w
texldl r3, r8.xyzz, s1
mov r6.x, r8
mul r2.x, r10.y, r2
mad r6.y, r10, r0.w, r2.x
mov r6.z, c24.w
texldl r2, r6.xyzz, s1
mul r7, r9.x, r3
mul r8.x, r9.z, r0.z
mov r8.z, c24.w
texldl r3, r8.xyzz, s1
mad r3, r11.x, r3, r7
mul r7, r9.x, r2
mul r3, r0.y, r3
add r0.y, -r0, c24.z
mov r4.x, r0
mov r2.x, r8
mov r2.z, c24.w
mov r2.y, r6
texldl r2, r2.xyzz, s1
mad r2, r11.x, r2, r7
mad r2, r2, r0.y, r3
pow r0, c29.z, r4.z
pow r3, c29.z, r4.y
mul_sat r3.x, r5, c31
mov r4.y, r3
mov r4.z, r0
min r0.xyz, r4, c24.z
mad r0, -r1, r0.xyzx, r2
mad r1.y, -r3.x, c31, c31.z
mul r1.x, r3, r3
mul r2.x, r1, r1.y
max r1, r0, c24.w
mul r0.y, r1.w, r2.x
mul r2.xyz, r1, r0.y
max r0.y, r1.x, c31.w
rcp r0.y, r0.y
mul r3.xyz, r2, r0.y
mul r0.x, r5.w, c9
mul r0.x, r0, c24
mad r0.x, c9, c9, -r0
add r1.w, r0.x, c24.z
pow r0, r1.w, c30.w
mov r0.w, r0.x
mul r0.z, -c9.x, c9.x
add r0.y, r0.z, c24.z
mov r0.x, c4
mul r0.x, c25, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.y
add r0.z, -r0, c24.x
mul r0.x, r0, r0.w
mad r0.y, r5.w, r5.w, c24.z
mul r0.w, r0.y, r0.x
mov r0.x, c4
rcp r0.z, r0.z
mul r0.x, c25.y, r0
rcp r0.x, r0.x
mul r0.z, r0.w, r0
rcp r2.x, c6.x
rcp r2.z, c6.z
rcp r2.y, c6.y
mul r2.xyz, r2, c6.x
mul r2.xyz, r3, r2
mul r2.xyz, r0.z, r2
mul r0.x, r0, r0.y
mul r2.xyz, r2, c32.x
mul r0.xyz, r0.x, r1
mad r0.xyz, r0, c30.z, r2
mul r0.xyz, r0, c17.x
mul r3.xyz, r0, c20.x
mul r2.y, r3.z, c32.z
pow r0, r2.y, c32.w
pow r1, c29.z, -r3.z
mov r0.y, r1.x
pow r1, c29.z, -r3.x
mov r0.z, r0.x
add r1.y, r3, c32
mul r1.z, r3.y, c32
add r2.x, r3.z, c32.y
add r0.x, -r0.y, c24.z
cmp r3.z, r2.x, r0.x, r0
pow r0, r1.z, c32.w
pow r2, c29.z, -r3.y
mov r0.y, r2.x
mov r0.z, r0.x
add r0.x, -r0.y, c24.z
rcp r0.y, c21.x
mul r0.y, r6.w, r0
cmp r3.y, r1, r0.x, r0.z
mov r0.x, r1
add r2.y, -r0.x, c24.z
mul r0.x, r3, c32.z
pow r1, r0.x, c32.w
mul r2.z, r0.y, c25.x
pow r0, c29.z, -r2.z
mov r0.y, r1.x
add r2.x, r3, c32.y
cmp r3.x, r2, r2.y, r0.y
add r0.y, -r0.x, c24.z
add r0.x, r6.w, -c21
cmp r0.w, -r0.x, r0.y, c24.z
mul r0.xyz, r3, c19.x
mul oC0.xyz, r0, r0.w
mov oC0.w, c24.z
endif
"
}
SubProgram "d3d11 " {
// Stats: 341 math, 1 textures, 2 branches
Keywords { "GODRAYS_OFF" }
SetTexture 0 [_customDepthTexture] 2D 1
SetTexture 1 [_Inscatter] 2D 0
ConstBuffer "$Globals" 384
Matrix 160 [_ViewProjInv]
Float 32 [M_PI]
Float 52 [HR]
Vector 64 [betaR] 3
Float 76 [HM]
Vector 96 [betaMEx] 3
Float 108 [mieG]
Float 112 [Rg]
Float 116 [Rt]
Float 124 [RES_R]
Float 128 [RES_MU]
Float 132 [RES_MU_S]
Float 136 [RES_NU]
Vector 144 [SUN_DIR] 3
Float 156 [SUN_INTENSITY]
Float 228 [_experimentalAtmoScale]
Float 236 [_global_alpha]
Float 240 [_Exposure]
Float 244 [_global_depth]
Vector 272 [_camPos] 3
Float 304 [_openglThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedadhhpnonkiapokmjaekkblpfdgihpgedabaaaaaalacpaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmacoaaaaeaaaaaaalaalaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaapmcaabaaaaaaaaaaakgbobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdiaaaaai
pcaabaaaabaaaaaapgapbaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaanaaaaaaaoaaaaahncaabaaaaaaaaaaaagajbaaaabaaaaaa
pgapbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaigadbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaabbaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaabbaaaaaaaaaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaaaaaaaaabbaaaaaaegiccaaa
aaaaaaaabbaaaaaadiaaaaajicaabaaaacaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaaaaaaaaaahaaaaaadcaaaaambcaabaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaackaabaaaacaaaaaadiaaaaah
bcaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaaadaaaaaabnaaaaah
bcaabaaaadaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaa
acaaaaaabkaabaaaacaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaacaaaaaaaaaaaaahccaabaaa
acaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaabkaabaaaacaaaaaadhaaaaajbcaabaaaacaaaaaaakaabaaa
adaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialpdbaaaaahccaabaaaacaaaaaa
abeaaaaaaaaaaaaaakaabaaaacaaaaaadlaaaaafbcaabaaaadaaaaaabkaabaaa
acaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaadaaaaaa
bpaaaeadbkaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabdiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaagaabaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaagaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadbaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaegacbaaaabaaaaaaigadbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaa
akiacaaaaaaaaaaabdaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaafgafbaaaabaaaaaaagajbaaaadaaaaaadhaaaaajhcaabaaaaaaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaabbaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaafbcaabaaa
adaaaaaadkaabaaaabaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
agaabaaaadaaaaaaaaaaaaakicaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaa
ahaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaalccaabaaaaeaaaaaadkaabaaa
abaaaaaabkiacaaaaaaaaaaaaoaaaaaaakiacaaaaaaaaaaaahaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadiaaaaai
icaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaaggggggdpdbaaaaah
icaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaajccaabaaa
afaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaabbaaaaaaaaaaaaai
ccaabaaaagaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadgaaaaag
fcaabaaaafaaaaaaagiccaaaaaaaaaaabbaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaafecaabaaaagaaaaaadkaabaaa
adaaaaaadgaaaaafbcaabaaaagaaaaaabkaabaaaafaaaaaadgaaaaagbcaabaaa
acaaaaaabkiacaaaaaaaaaaabbaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaa
aaaaaaaadhaaaaajhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaagaaaaaa
egacbaaaacaaaaaadgaaaaagfcaabaaaafaaaaaaagiccaaaaaaaaaaabbaaaaaa
dgaaaaafccaabaaaafaaaaaaakaabaaaacaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaaoaaaaahecaabaaaadaaaaaabkaabaaa
aaaaaaaackaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaiadpdgaaaaaficaabaaaaaaaaaaabkaabaaaacaaaaaadcaaaaak
hcaabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaapgapbaaaabaaaaaamgacbaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaacaaaaaa
dcaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaeaaaaaabkaabaaa
aeaaaaaaakaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaak
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
mkpcejpbaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaaabaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajhcaabaaaahaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahecaabaaaaeaaaaaa
bkaabaaaaaaaaaaabkaabaaaaeaaaaaaaaaaaaaibcaabaaaaeaaaaaaakaabaia
ebaaaaaaaaaaaaaaakaabaaaadaaaaaadhaaaaajlcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaibaaaahaaaaaaegaibaaaafaaaaaadgaaaaafccaabaaaadaaaaaa
ckaabaaaacaaaaaadhaaaaajhcaabaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaajaaaaaabaaaaaaibcaabaaaaaaaaaaaegadbaaaaaaaaaaa
egiccaaaaaaaaaaaajaaaaaaaaaaaaaiccaabaaaaaaaaaaaakiacaaaaaaaaaaa
ahaaaaaaabeaaaaaaaaamieedbaaaaahicaabaaaaaaaaaaabkaabaaaafaaaaaa
bkaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaafgafbaaa
afaaaaaadiaaaaahhcaabaaaahaaaaaafgafbaaaaaaaaaaaegacbaaaagaaaaaa
aaaaaaaiicaabaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaamiee
dgaaaaaficaabaaaagaaaaaabkaabaaaafaaaaaadhaaaaajpcaabaaaagaaaaaa
pgapbaaaaaaaaaaaegaobaaaahaaaaaaegaobaaaagaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaaficaabaaaaaaaaaaa
bkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
abaaaaaabaaaaaaiccaabaaaabaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaa
ajaaaaaaaoaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaa
diaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaa
aoaaaaaaaoaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaadpbkaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaadkaabaaaagaaaaaackaabaaaabaaaaaaelaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaahicaabaaaabaaaaaaakaabaaa
afaaaaaadkaabaaaagaaaaaaaaaaaaahicaabaaaafaaaaaadkaabaaaabaaaaaa
ckaabaaaafaaaaaadiaaaaahmcaabaaaabaaaaaakgakbaaaabaaaaaakgaobaaa
afaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaogakbaaaabaaaaaadbaaaaakgcaabaaaadaaaaaakgalbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaa
egaabaiaebaaaaaaacaaaaaajgafbaaaadaaaaaaclaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadiaaaaahocaabaaaadaaaaaakgaobaaaabaaaaaakgaobaaa
abaaaaaadbaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaaf
ccaabaaaadaaaaaabkaabaaaadaaaaaaabaaaaahecaabaaaacaaaaaackaabaaa
acaaaaaabkaabaaaadaaaaaadcaaaaapgcaabaaaadaaaaaakgalbaaaadaaaaaa
aceaaaaaaaaaaaaafmipmcdpfmipmcdpaaaaaaaaaceaaaaaaaaaaaaaaaaaiaea
aaaaiaeaaaaaaaaaelaaaaafgcaabaaaadaaaaaafgagbaaaadaaaaaadcaaaaan
mcaabaaaabaaaaaakgaobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
gjgpbeeagjgpbeeafgajbaaaadaaaaaaaoaaaaahmcaabaaaabaaaaaaagaebaaa
acaaaaaakgaobaaaabaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaa
afaaaaaabkaabaaaabaaaaaaaaaaaaahccaabaaaacaaaaaadkaabaaaagaaaaaa
dkaabaaaagaaaaaaaoaaaaahccaabaaaacaaaaaaakaabaaaafaaaaaabkaabaaa
acaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaaafaaaaaabkaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaa
ahaaaaaaakaabaaaacaaaaaadgaaaaaifcaabaaaahaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaadiaaaaahmcaabaaaabaaaaaakgaobaaaabaaaaaa
agaebaaaahaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaadkaabaaa
agaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaciapmjea
elaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaajccaabaaaadaaaaaa
dkaabaiaebaaaaaaagaaaaaaakiacaaaaaaaaaaaahaaaaaaaoaaaaahccaabaaa
abaaaaaabkaabaaaadaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaacaaaaaa
apaaaaakecaabaaaabaaaaaaogakbaaaabaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaaaaaaaaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
acaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaajecaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaaaaaaaaaa
aoaaaaaaaoaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaadpckaabaaaabaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaabaaaaaaelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahfcaabaaaacaaaaaakgalbaaa
afaaaaaapgapbaaaabaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaagaibaaaacaaaaaadbaaaaakfcaabaaaaeaaaaaa
agacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
mcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaibaaaaeaaaaaaclaaaaaf
mcaabaaaadaaaaaakgaobaaaadaaaaaadiaaaaahncaabaaaaeaaaaaaagaibaaa
acaaaaaaagaibaaaacaaaaaadbaaaaahicaabaaaabaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaa
dlkklidpbjaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaaeaaaaaadcaaaaapfcaabaaaaeaaaaaa
kgalbaaaaeaaaaaaaceaaaaafmipmcdpaaaaaaaafmipmcdpaaaaaaaaaceaaaaa
aaaaiaeaaaaaaaaaaaaaiaeaaaaaaaaaelaaaaaffcaabaaaaeaaaaaaagacbaaa
aeaaaaaadcaaaaanfcaabaaaacaaaaaaagacbaiaibaaaaaaacaaaaaaaceaaaaa
gjgpbeeaaaaaaaaagjgpbeeaaaaaaaaaagacbaaaaeaaaaaaaoaaaaahfcaabaaa
acaaaaaakgalbaaaadaaaaaaagacbaaaacaaaaaaaoaaaaaiecaabaaaadaaaaaa
akaabaiaebaaaaaaafaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaahaaaaaabkaabaaaacaaaaaa
diaaaaahdcaabaaaacaaaaaaigaabaaaacaaaaaaogakbaaaahaaaaaadiaaaaah
ecaabaaaacaaaaaackaabaaaabaaaaaadkaabaaaagaaaaaadiaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaciapmjeaelaaaaafecaabaaaacaaaaaa
ckaabaaaacaaaaaaaoaaaaahecaabaaaabaaaaaabkaabaaaadaaaaaackaabaaa
abaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadlkklidp
bjaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaaaacaaaaaaapaaaaakbcaabaaaacaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaipcaabaaaahaaaaaakgakbaaa
abaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaampcaabaaaahaaaaaaegiccaia
ebaaaaaaaaaaaaaaaeaaaaaafgafbaaaabaaaaaaegaobaiaebaaaaaaahaaaaaa
diaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaadlkklidpdlkklidp
dlkklidpdlkklidpbjaaaaafpcaabaaaahaaaaaaegaobaaaahaaaaaaddaaaaak
pcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdcaaaaakccaabaaaabaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaa
dkaabaiaebaaaaaaacaaaaaaelaaaaafecaabaaaaeaaaaaabkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaagaaaaaadcaaaaak
ecaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaagaaaaaadkaabaiaebaaaaaa
acaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaackaabaaaafaaaaaadkaabaaaagaaaaaadcaaaaakccaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaal
ccaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaa
bkaabaaaabaaaaaadbaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaaaaadbaaaaahccaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaabaaaaaa
abaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaoaaaaal
gcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaaagibcaaa
aaaaaaaaaiaaaaaaaaaaaaaiicaabaaaafaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaaadpdiaaaaahccaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaa
aeaaaaaaaaaaaaahicaabaaaaeaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaadp
dgaaaaaihcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaafbcaabaaaaeaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaaagaaaaaa
agaabaaaacaaaaaaigaobaaaafaaaaaaegaobaaaaeaaaaaaaoaaaaaibcaabaaa
acaaaaaaabeaaaaaaaaaaadpdkiacaaaaaaaaaaaahaaaaaaaoaaaaahccaabaaa
acaaaaaackaabaaaabaaaaaackaabaaaaeaaaaaaaoaaaaalicaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkiacaaaaaaaaaaaahaaaaaa
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadp
dcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaafgagbaaaagaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaalmcaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpagiecaaaaaaaaaaaaiaaaaaa
aaaaaaalmcaabaaaabaaaaaakgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaiadpdcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaa
ckaabaaaabaaaaaadkaabaaaagaaaaaadeaaaaahccaabaaaadaaaaaaakaabaaa
aaaaaaaaabeaaaaahbdneklodiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaabodakleaddaaaaaiecaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abeaaaaaaaaaiadpdeaaaaaiicaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaa
abeaaaaaaaaaiadpaoaaaaakicaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdkaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaadkaabaaa
adaaaaaackaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaackaabaaaadaaaaaa
ckaabaaaadaaaaaadcaaaaajbcaabaaaagaaaaaadkaabaaaadaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaagaaaaaadkaabaaaadaaaaaa
akaabaaaagaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaagaaaaaadkaabaaa
adaaaaaaakaabaaaagaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaadaaaaaa
dkaabaaaadaaaaaaakaabaaaagaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaa
agaaaaaadkaabaaaadaaaaaackaabaaaadaaaaaadbaaaaaiccaabaaaagaaaaaa
abeaaaaaaaaaiadpbkaabaiaibaaaaaaadaaaaaadcaaaaajbcaabaaaagaaaaaa
akaabaaaagaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahbcaabaaa
agaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaadcaaaaajecaabaaaadaaaaaa
ckaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaaddaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaaadaaaaaa
bkaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaadhaaaaakccaabaaaadaaaaaa
bkaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
ccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaacolkgidpabeaaaaakehadndp
diaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaa
aaaaaaahecaabaaaadaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaadpaaaaaaaiicaabaaa
adaaaaaackiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaahbcaabaaa
agaaaaaadkaabaaaadaaaaaackaabaaaadaaaaaaebaaaaafbcaabaaaagaaaaaa
akaabaaaagaaaaaadcaaaaakecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaa
adaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaaiicaabaaaadaaaaaabkaabaaa
acaaaaaadkiacaaaaaaaaaaaahaaaaaadcaaaaakccaabaaaacaaaaaabkaabaaa
acaaaaaadkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaialpebaaaaafccaabaaa
acaaaaaabkaabaaaacaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaa
dkiacaaaaaaaaaaaahaaaaaaebaaaaafccaabaaaagaaaaaadkaabaaaadaaaaaa
aoaaaaaiccaabaaaagaaaaaabkaabaaaagaaaaaadkiacaaaaaaaaaaaahaaaaaa
bkaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaaaaaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaagaaaaaaaoaaaaaiccaabaaaaiaaaaaabkaabaaa
adaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaaiccaabaaaabaaaaaabkaabaaa
abaaaaaadkiacaaaaaaaaaaaahaaaaaaaaaaaaahecaabaaaaiaaaaaabkaabaaa
acaaaaaabkaabaaaabaaaaaaeiaaaaalpcaabaaaajaaaaaajgafbaaaaiaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaa
acaaaaaackaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaaiaaaaaa
bkaabaaaadaaaaaackiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaaakaaaaaa
igaabaaaaiaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaakaaaaaakgakbaaaadaaaaaaegaobaaaakaaaaaadcaaaaaj
pcaabaaaajaaaaaaegaobaaaajaaaaaafgafbaaaacaaaaaaegaobaaaakaaaaaa
aaaaaaahicaabaaaaiaaaaaabkaabaaaagaaaaaabkaabaaaabaaaaaaeiaaaaal
pcaabaaaakaaaaaangafbaaaaiaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaamgaabaaaaiaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaiaaaaaa
kgakbaaaadaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaaiaaaaaaegaobaaa
akaaaaaafgafbaaaacaaaaaaegaobaaaaiaaaaaaaaaaaaaiccaabaaaabaaaaaa
dkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaaiaaaaaa
pgapbaaaadaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaaiaaaaaaegaobaaa
ajaaaaaafgafbaaaabaaaaaaegaobaaaaiaaaaaadcaaaaamccaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaabkaabaaa
aaaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakccaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaaaaaaaaa
dcaaaaalccaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaa
ahaaaaaabkaabaaaaaaaaaaadbaaaaahccaabaaaadaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadbaaaaahicaabaaaadaaaaaaabeaaaaaaaaaaaaabkaabaaa
aaaaaaaaabaaaaahccaabaaaadaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaa
dhaaaaajpcaabaaaafaaaaaafgafbaaaadaaaaaaegaobaaaafaaaaaaegaobaaa
aeaaaaaaaoaaaaahccaabaaaadaaaaaabkaabaaaabaaaaaackaabaaaaeaaaaaa
dcaaaaajbcaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaafaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaabaaaaaaakaabaaaafaaaaaabkaabaaaaaaaaaaaaaaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaafaaaaaaaoaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaafaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaabodakleaddaaaaaibcaabaaaabaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaabaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaaiicaabaaa
acaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
ecaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaddaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadhaaaaakicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaa
kehadndpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpckaabaaa
acaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaa
ahaaaaaadcaaaaakccaabaaaabaaaaaaakaabaaaacaaaaaadkiacaaaaaaaaaaa
ahaaaaaaabeaaaaaaaaaialpebaaaaafgcaabaaaabaaaaaafgaebaaaabaaaaaa
aoaaaaaigcaabaaaabaaaaaafgagbaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaa
bkaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaagaaaaaaaoaaaaaiccaabaaaaeaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaaaaaaaahmcaabaaaaeaaaaaafgajbaaa
abaaaaaafgafbaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaajgafbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaaeaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaaagaaaaaa
igaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaagaaaaaakgakbaaaadaaaaaaegaobaaaagaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaafaaaaaafgafbaaaacaaaaaaegaobaaaagaaaaaa
eiaaaaalpcaabaaaagaaaaaangafbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaamgaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
aeaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaagaaaaaafgafbaaaacaaaaaaegaobaaaaeaaaaaaaaaaaaaiccaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
abaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaaabaaaaaa
egaobaaaafaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaa
abaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaahaaaaaaegaobaaaaiaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaeiecdcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadiaaaaah
lcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaaacaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaahlcaabaaaaaaaaaaa
egambaaaaaaaaaaaagaabaaaabaaaaaaaoaaaaajhcaabaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaaegiccaaaaaaaaaaaaeaaaaaadiaaaaahlcaabaaaaaaaaaaa
egambaaaaaaaaaaaegaibaaaabaaaaaadiaaaaaldcaabaaaabaaaaaaagiacaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaiaebaaaaiaeaaaaaaaaaaaaaaaaaaoaaaaak
dcaabaaaabaaaaaaaceaaaaaaaaaeaeaaaaamadpaaaaaaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaamicaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaa
agaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaahdcaabaaa
abaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaaogcaabaaaadaaaaaa
pgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaeaaaaaaaaaapaaaaaiecaabaaaaaaaaaaakgakbaaaaaaaaaaa
pgipcaaaaaaaaaaaagaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaabkaabaaaadaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaabaaaaaa
ckaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
adaaaaaadiaaaaahhcaabaaaaaaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaa
ajaaaaaabnaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaaakaabaaa
adaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaea
aoaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaapaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaadlkklilpbjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadbaaaaakhcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaacpnnledpcpnnledpcpnnledpaaaaaaaadiaaaaak
pcaabaaaacaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedodlkklilpnmcomedo
dlkklilpcpaaaaafdcaabaaaaaaaaaaaigaabaaaacaaaaaadiaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaacplkoidocplkoidoaaaaaaaaaaaaaaaa
bjaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaabjaaaaafdcaabaaaacaaaaaa
ngafbaaaacaaaaaaaaaaaaaldcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadhaaaaajdcaabaaaacaaaaaa
egaabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaacaaaaaadiaaaaakdcaabaaa
aaaaaaaakgakbaaaaaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaa
acaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaacaaaaaapgipcaaaaaaaaaaaaoaaaaaadiaaaaah
hccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "GODRAYS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "GODRAYS_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 539 math, 18 textures, 1 branches
Keywords { "GODRAYS_ON" }
Matrix 0 [_ViewProjInv]
Float 4 [M_PI]
Float 5 [HR]
Vector 6 [betaR]
Float 7 [HM]
Vector 8 [betaMEx]
Float 9 [mieG]
Float 10 [Rg]
Float 11 [Rt]
Float 12 [RES_R]
Float 13 [RES_MU]
Float 14 [RES_MU_S]
Float 15 [RES_NU]
Vector 16 [SUN_DIR]
Float 17 [SUN_INTENSITY]
Float 18 [_experimentalAtmoScale]
Float 19 [_global_alpha]
Float 20 [_Exposure]
Float 21 [_global_depth]
Vector 22 [_camPos]
Float 23 [_openglThreshold]
SetTexture 0 [_customDepthTexture] 2D 0
SetTexture 1 [_godrayDepthTexture] 2D 1
SetTexture 2 [_Inscatter] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c24, 0.00000000, 1.00000000, -1.00000000, 2.00000000
def c25, 4.00000000, 16.00000000, 0.89999998, 1000000015047466200000000000000.00000000
def c26, 1600.00000000, -0.19750001, 5.34960032, -0.12123910
def c27, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c28, 0.99999559, 1.57079601, 0.90909088, 0.74000001
def c29, 0.50000000, 6.28310013, 2.71828198, 2.31929994
def c30, 1.51999998, 4.00000000, 3.00000000, -1.50000000
def c31, 50.00000000, 2.00000000, 3.00000000, 0.00010000
def c32, 1.50000000, -1.41299999, 0.38317001, 0.45454544
dcl_texcoord2 v0.xy
texld r0.x, v0, s0
mad r3.xy, v0, c24.w, c24.z
mov r4.xy, r3
mov r4.z, r0.x
mov r4.w, c24.y
dp4 r0.z, r4, c3
mov r3.w, c24.y
add r1.w, r0.x, c24.z
dp4 r1.z, r4, c2
dp4 r1.y, r4, c1
dp4 r1.x, r4, c0
rcp r0.z, r0.z
mad r1.xyz, r1, r0.z, -c22
mov r4.xyz, c22
mul r5.xyz, c16.yzxw, r4.zxyw
dp3 r0.w, r1, r1
mov r4.xyz, c22
mad r4.xyz, c16.zxyw, r4.yzxw, -r5
rsq r0.w, r0.w
dp3 r0.z, r4, r4
mul r5.xyz, r0.w, r1
rsq r0.z, r0.z
mul r1.xyz, r0.z, r4
dp3 r0.z, r1, r5
texld r1.x, v0, s1
abs r0.z, r0
add r0.w, r1.x, -r0.x
add r0.z, -r0, c24.y
mad r1.z, r0, r0.w, r0.x
add r0.z, r1.x, -r0.x
cmp r0.w, r0.z, c24.x, c24.y
cmp r0.z, -r1.x, c24.x, c24.y
mul_pp r0.z, r0, r0.w
cmp r1.y, r1.w, c24.x, c24
mul_pp r0.z, r0, r1.y
cmp r3.z, -r0, r0.x, r1
dp4 r0.x, r3, c3
dp4 r1.z, r3, c2
dp4 r1.y, r3, c1
dp4 r1.x, r3, c0
rcp r0.x, r0.x
mov r3.xyz, c22
mul r1.xyz, r1, r0.x
dp3 r0.z, c24.x, r3
dp3 r0.x, c22, c22
add r0.x, r0, -r0.z
add r3.xyz, r1, -c22
dp3 r0.z, r3, r3
mad r0.x, -c10, c10, r0
mul r0.w, r0.z, r0.x
dp3 r0.x, r3, c22
mul r0.x, r0, c24.w
mul r0.w, r0, c25.x
mad r0.w, r0.x, r0.x, -r0
cmp_pp r3.x, r0.w, c24.y, c24
cmp r0.y, r0.w, r0, c24.z
rsq r0.w, r0.w
mul r3.y, r0.z, c24.w
rcp r0.z, r0.w
add r0.x, -r0, -r0.z
rcp r0.w, r3.y
mul r0.x, r0, r0.w
cmp r0.y, -r3.x, r0, r0.x
cmp r0.x, -r0.y, c24, c24.y
abs_pp r0.z, r0.x
abs r0.w, r1
cmp r0.w, -r0, c24.y, c24.x
cmp_pp r0.z, -r0, c24.y, c24.x
mul_pp r0.z, r0, r0.w
cmp_pp r0.w, -r0.z, c24.y, c24.x
cmp_pp oC0, -r0.z, r2, c24.x
if_gt r0.w, c24.x
add r2.xyz, r1, -c22
rcp r10.y, c12.x
mul r3.xyz, r0.y, r2
dp3 r0.z, r2, r2
dp3 r0.y, r3, r3
add r2.xyz, r3, c22
rcp r7.w, c14.x
rsq r0.z, r0.z
rsq r0.y, r0.y
mov r5.xz, c22
rcp r9.z, c15.x
add r8.w, -r7, c24.y
mul r9.w, c10.x, c10.x
mov r3.x, c24.z
rcp r0.z, r0.z
rcp r0.y, r0.y
add r0.y, r0, -r0.z
cmp r0.y, r0, c24.x, c24
mul_pp r0.x, r0, r0.y
cmp r0.xyz, -r0.x, r1, r2
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r2.xyz, r0.w, r0
mov r1.x, c10
add r1.x, c23, r1
rcp r0.w, r0.w
mul r2.xyz, r1.x, r2
add r0.w, r0, -r1.x
cmp r0.xyz, r0.w, r0, r2
add r1.xyz, r0, -c22
dp3 r0.w, r1, r1
rsq r1.w, r0.w
mul r1.xyz, r1.w, r1
dp3 r0.w, r1, r1
rsq r2.x, r0.w
mul r6.xyz, r2.x, r1
mov r0.w, c22.y
add r2.w, c10.x, r0
dp3 r2.y, c22, c22
rsq r2.y, r2.y
rcp r6.w, r1.w
dp3 r5.w, r6, c16
rcp r2.y, r2.y
mov r0.w, c10.x
mad r2.z, c25, -r0.w, r2.y
cmp r5.y, r2.z, c22, r2.w
dp3 r0.w, r5, r5
rsq r0.w, r0.w
rcp r1.x, r0.w
cmp r12.z, r2, r2.y, r1.x
mov r0.w, c11.x
add r0.w, -c10.x, r0
mul r0.w, r0, c18.x
dp3 r11.z, r6, r5
mul r1.x, r12.z, r12.z
add r11.w, r0, c10.x
mad r1.x, r11.z, r11.z, -r1
mad r0.w, r11, r11, r1.x
rsq r1.x, r0.w
rcp r1.x, r1.x
cmp r0.w, r0, r1.x, c25
add r0.w, -r11.z, -r0
max r11.y, r0.w, c24.x
add r0.w, r11.y, -r6
cmp r1.x, r0.w, c24, c24.y
cmp r0.w, -r11.y, c24.x, c24.y
mul_pp r12.x, r0.w, r1
cmp r7.z, -r12.x, r12, r11.w
add r1.x, r0.y, c10
mov r0.w, c10.x
add r12.w, c26.x, r0
rcp r12.y, r7.z
add r13.z, r7, -r12.w
cmp r0.y, r2.z, r0, r1.x
mov_sat r0.w, r6
mad r0.xyz, -r6, r0.w, r0
mul r1.y, r12.w, r12
mul r1.xyz, r0, r1.y
cmp r0.xyz, r13.z, r0, r1
dp3 r0.w, r0, r0
dp3 r1.x, r0, c16
dp3 r0.x, r6, r0
rsq r0.w, r0.w
mad r0.z, r11.w, r11.w, -r9.w
mul r1.x, r0.w, r1
max r1.x, r1, c26.y
mul r1.x, r1, c26.z
abs r1.y, r1.x
max r1.z, r1.y, c24.y
rcp r1.w, r1.z
min r1.z, r1.y, c24.y
mul r1.z, r1, r1.w
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c27, c27.y
mad r2.x, r2, r1.w, c26.w
mad r2.x, r2, r1.w, c27.z
mad r2.x, r2, r1.w, c27.w
mad r1.w, r2.x, r1, c28.x
mul r1.z, r1.w, r1
rsq r10.x, r0.z
add r1.w, -r1.z, c28.y
add r1.y, r1, c24.z
cmp r1.y, -r1, r1.z, r1.w
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c15.x
add r1.z, c24, r1.y
add r1.y, r5.w, c24
mul r1.y, r1, r1.z
rcp r1.z, r0.w
mul r1.y, r1, c29.x
frc r9.x, r1.y
mad r1.x, r1, c28.z, c28.w
add r11.x, -r9, c24.y
add r9.y, r1, -r9.x
mad r1.x, r1, r8.w, r7.w
mad r1.x, r1, c29, r9.y
mul r8.x, r1, r9.z
add r1.y, r1.x, c24
mul r7.x, r9.z, r1.y
rcp r1.y, c13.x
mul r0.x, r0.w, r0
mul r1.x, r1.z, r0
mul r0.y, r1.z, r1.z
mad r0.y, r1.x, r1.x, -r0
mad r1.w, c10.x, c10.x, r0.y
mad r1.z, r1, r1, -r9.w
rsq r1.z, r1.z
mad r3.w, r1.y, c29.x, c29.x
cmp r0.y, -r1.w, c24.x, c24
cmp r0.x, r1, c24, c24.y
mul_pp r0.x, r0, r0.y
rcp r0.y, r10.x
mul r3.y, r0, r0
mov r3.z, r0.y
mad r2.w, -r1.y, c29.x, c29.x
mov r2.xyz, c24.yxxw
cmp r0, -r0.x, r3, r2
add r0.y, r0, r1.w
rcp r1.z, r1.z
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.x, r1, r0, r0.y
add r0.y, r0.z, r1.z
mul r1.w, r10.x, r1.z
add r10.z, -r10.y, c24.y
rcp r0.y, r0.y
mul r1.w, r1, r10.z
mad r1.w, r10.y, c29.x, r1
mul r1.w, r1, c12.x
add r0.z, r1.w, c24
frc r13.x, r1.w
mul r0.x, r0, r0.y
frc r1.x, r0.z
add r0.y, r0.z, -r1.x
add r10.w, -r1.y, c29.x
mad r4.w, r0.x, r10, r0
mul r0.y, r0, r10
mad r1.y, r4.w, r10, r0
mov r4.x, r8
mov r4.y, r1
mov r4.z, c24.x
texldl r0, r4.xyzz, s2
add r4.x, r1.w, -r13
mul r4.x, r10.y, r4
mad r7.y, r4.w, r10, r4.x
mov r8.y, r7
mov r1.x, r7
mov r1.z, c24.x
texldl r1, r1.xyzz, s2
mul r1, r9.x, r1
mad r4, r0, r11.x, r1
mov r8.z, c24.x
texldl r0, r8.xyzz, s2
cmp r8.z, r13, r7, r12.w
mov r1.x, c5
mul r13.y, c18.x, r1.x
rcp r13.z, r13.y
mov r7.z, c24.x
texldl r1, r7.xyzz, s2
mul r8.x, r8.z, r13.z
mul r7.x, r8, c29
rsq r8.x, r7.x
mul r1, r9.x, r1
mad r0, r11.x, r0, r1
rcp r7.x, r12.z
add r7.z, -r11.y, r6.w
cmp r7.z, -r12.x, r6.w, r7
mul r1, r13.x, r0
rcp r7.y, r8.z
add r8.y, r11, r11.z
rcp r11.w, r11.w
mul r8.y, r8, r11.w
mul r7.x, r11.z, r7
cmp r7.x, -r12, r7, r8.y
mad r7.y, r7.z, r7, r7.x
rcp r8.x, r8.x
mul r8.xy, r8.x, r7
mul r11.zw, r8.xyxy, r8.xyxy
mad r0.xy, r11.zwzw, c30.x, c30.y
rsq r0.x, r0.x
rsq r0.y, r0.y
cmp r0.zw, -r8.xyxy, c24.x, c24.y
cmp r12.zw, r8.xyxy, c24.x, c24.y
add r12.zw, r0, -r12
abs r0.zw, r8.xyxy
mul r8.x, r8.z, c24.w
rcp r11.w, r8.x
mad r11.w, r7.z, r11, r7.x
rcp r0.x, r0.x
rcp r0.y, r0.y
mad r8.xy, r0.zwzw, c29.w, r0
mul r0.x, r13.z, -r7.z
mul r13.w, r0.x, r11
pow r0, c29.z, r13.w
rcp r8.x, r8.x
rcp r8.y, r8.y
mul r0.zw, r12, r8.xyxy
mov r0.x, c24.y
mul r0.xy, r0.zwzw, r0
add r0.z, -r13.x, c24.y
mad r1, r4, r0.z, r1
mul r0.xy, r0, c24.yzzw
mov r0.z, c7.x
add r4.x, r0, r0.y
mul r13.x, c18, r0.z
pow r0, c29.z, r11.z
add r4.y, r12.w, -r12.z
rcp r12.z, r13.x
mul r0.y, r8.z, r12.z
cmp r0.x, -r4.y, c24, r0
add r11.z, -r8, c10.x
mul r0.y, r0, c29.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r4.zw, r7.xyxy, r0.y
add r8.x, r0, r4
mul r8.y, r11.z, r13.z
mul r4.xy, r4.zwzw, r4.zwzw
pow r0, c29.z, r8.y
mul r7.y, r13, r8.z
mul r0.y, r7, c29
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r7.y, r0.x, r8.x
mad r0.xy, r4, c30.x, c30.y
rsq r0.y, r0.y
rsq r0.x, r0.x
abs r0.zw, r4
rcp r0.y, r0.y
rcp r0.x, r0.x
mad r0.xy, r0.zwzw, c29.w, r0
cmp r0.zw, r4, c24.x, c24.y
cmp r4.zw, -r4, c24.x, c24.y
add r4.zw, r4, -r0
mul r0.w, -r7.z, r12.z
rcp r8.x, r0.x
rcp r8.y, r0.y
mad r0.xyz, r6, r11.y, r5
mul r6.xy, r4.zwzw, r8
cmp r0.xyz, -r12.x, r5, r0
dp3 r0.x, r0, c16
mul r4.y, r11.w, r0.w
mul r5.x, r12.y, r0
pow r0, c29.z, r4.y
max r0.x, r5, c26.y
mul r4.y, r0.x, c26.z
abs r5.y, r4
max r0.z, r5.y, c24.y
rcp r0.w, r0.z
mov r0.x, c24.y
mul r0.xy, r6, r0
min r0.z, r5.y, c24.y
mul r6.x, r0.z, r0.w
mul r0.xy, r0, c24.yzzw
add r5.z, r0.x, r0.y
pow r0, c29.z, r4.x
mul r6.y, r6.x, r6.x
add r4.z, r4.w, -r4
mad r4.w, r6.y, c27.x, c27.y
mad r0.y, r4.w, r6, c26.w
cmp r0.x, -r4.z, c24, r0
mad r0.y, r0, r6, c27.z
mad r0.y, r0, r6, c27.w
mad r0.y, r0, r6, c28.x
add r4.w, r0.x, r5.z
mul r5.z, r0.y, r6.x
mul r4.z, r11, r12
pow r0, c29.z, r4.z
mul r4.x, r8.z, r13
mul r0.y, r4.x, c29
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
add r0.y, r5, c24.z
add r0.z, -r5, c28.y
cmp r0.w, -r0.y, r5.z, r0.z
mul r0.x, r0, r4.w
cmp r0.w, r4.y, r0, -r0
mul r0.xyz, r0.x, c8
mad r4.xyz, r7.y, -c6, -r0
mad r4.w, r0, c28.z, c28
pow r0, c29.z, r4.x
mad r0.y, r8.w, r4.w, r7.w
mad r0.z, r0.y, c29.x, r9.y
add r4.w, r0.z, c24.y
mul r8.x, r9.z, r4.w
mul r0.y, r8.z, r7.x
mul r0.w, r8.z, r8.z
mad r0.w, r0.y, r0.y, -r0
mad r4.x, c10, c10, r0.w
mad r5.y, r8.z, r8.z, -r9.w
cmp r4.w, -r4.x, c24.x, c24.y
cmp r0.w, r0.y, c24.x, c24.y
mul_pp r0.w, r0, r4
cmp r2, -r0.w, r3, r2
add r0.w, r2.y, r4.x
rsq r4.w, r5.y
rcp r3.x, r4.w
mul r2.y, r10.x, r3.x
rsq r0.w, r0.w
mul r2.y, r10.z, r2
rcp r0.w, r0.w
mad r0.w, r0.y, r2.x, r0
add r2.x, r2.z, r3
rcp r2.x, r2.x
mul r0.w, r0, r2.x
mad r2.y, r10, c29.x, r2
mul r2.y, r2, c12.x
frc r0.y, r2
add r2.z, r2.y, -r0.y
mad r0.w, r10, r0, r2
mul r2.x, r10.y, r2.z
mad r8.y, r10, r0.w, r2.x
add r2.x, r2.y, c24.z
frc r2.y, r2.x
add r2.x, r2, -r2.y
mov r8.z, c24.x
texldl r3, r8.xyzz, s2
mov r6.x, r8
mul r2.x, r10.y, r2
mad r6.y, r10, r0.w, r2.x
mov r6.z, c24.x
texldl r2, r6.xyzz, s2
mul r7, r9.x, r3
mul r8.x, r9.z, r0.z
mov r8.z, c24.x
texldl r3, r8.xyzz, s2
mad r3, r11.x, r3, r7
mul r7, r9.x, r2
mul r3, r0.y, r3
add r0.y, -r0, c24
mov r4.x, r0
mov r2.x, r8
mov r2.z, c24.x
mov r2.y, r6
texldl r2, r2.xyzz, s2
mad r2, r11.x, r2, r7
mad r2, r2, r0.y, r3
pow r0, c29.z, r4.z
pow r3, c29.z, r4.y
mul_sat r3.x, r5, c31
mov r4.y, r3
mov r4.z, r0
min r0.xyz, r4, c24.y
mad r0, -r1, r0.xyzx, r2
mad r1.y, -r3.x, c31, c31.z
mul r1.x, r3, r3
mul r2.x, r1, r1.y
max r1, r0, c24.x
mul r0.y, r1.w, r2.x
mul r2.xyz, r1, r0.y
max r0.y, r1.x, c31.w
rcp r0.y, r0.y
mul r3.xyz, r2, r0.y
mul r0.x, r5.w, c9
mul r0.x, r0, c24.w
mad r0.x, c9, c9, -r0
add r1.w, r0.x, c24.y
pow r0, r1.w, c30.w
mov r0.w, r0.x
mul r0.z, -c9.x, c9.x
add r0.y, r0.z, c24
mov r0.x, c4
mul r0.x, c25, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.y
add r0.z, -r0, c24.w
mul r0.x, r0, r0.w
mad r0.y, r5.w, r5.w, c24
mul r0.w, r0.y, r0.x
mov r0.x, c4
rcp r0.z, r0.z
mul r0.x, c25.y, r0
rcp r0.x, r0.x
mul r0.z, r0.w, r0
rcp r2.x, c6.x
rcp r2.z, c6.z
rcp r2.y, c6.y
mul r2.xyz, r2, c6.x
mul r2.xyz, r3, r2
mul r2.xyz, r0.z, r2
mul r0.x, r0, r0.y
mul r2.xyz, r2, c32.x
mul r0.xyz, r0.x, r1
mad r0.xyz, r0, c30.z, r2
mul r0.xyz, r0, c17.x
mul r3.xyz, r0, c20.x
mul r2.y, r3.z, c32.z
pow r0, r2.y, c32.w
pow r1, c29.z, -r3.z
mov r0.y, r1.x
pow r1, c29.z, -r3.x
mov r0.z, r0.x
add r1.y, r3, c32
mul r1.z, r3.y, c32
add r2.x, r3.z, c32.y
add r0.x, -r0.y, c24.y
cmp r3.z, r2.x, r0.x, r0
pow r0, r1.z, c32.w
pow r2, c29.z, -r3.y
mov r0.y, r2.x
mov r0.z, r0.x
add r0.x, -r0.y, c24.y
rcp r0.y, c21.x
mul r0.y, r6.w, r0
cmp r3.y, r1, r0.x, r0.z
mov r0.x, r1
add r2.y, -r0.x, c24
mul r0.x, r3, c32.z
pow r1, r0.x, c32.w
mul r2.z, r0.y, c25.x
pow r0, c29.z, -r2.z
mov r0.y, r1.x
add r2.x, r3, c32.y
cmp r3.x, r2, r2.y, r0.y
add r0.y, -r0.x, c24
add r0.x, r6.w, -c21
cmp r0.w, -r0.x, r0.y, c24.y
mul r0.xyz, r3, c19.x
mul oC0.xyz, r0, r0.w
mov oC0.w, c24.y
endif
"
}
SubProgram "d3d11 " {
// Stats: 362 math, 2 textures, 2 branches
Keywords { "GODRAYS_ON" }
SetTexture 0 [_customDepthTexture] 2D 1
SetTexture 1 [_godrayDepthTexture] 2D 2
SetTexture 2 [_Inscatter] 2D 0
ConstBuffer "$Globals" 384
Matrix 160 [_ViewProjInv]
Float 32 [M_PI]
Float 52 [HR]
Vector 64 [betaR] 3
Float 76 [HM]
Vector 96 [betaMEx] 3
Float 108 [mieG]
Float 112 [Rg]
Float 116 [Rt]
Float 124 [RES_R]
Float 128 [RES_MU]
Float 132 [RES_MU_S]
Float 136 [RES_NU]
Vector 144 [SUN_DIR] 3
Float 156 [SUN_INTENSITY]
Float 228 [_experimentalAtmoScale]
Float 236 [_global_alpha]
Float 240 [_Exposure]
Float 244 [_global_depth]
Vector 272 [_camPos] 3
Float 304 [_openglThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbogkhbhmgcalilfjdfogdliengaefcnfabaaaaaajedcaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckedbaaaaeaaaaaaagjamaaaafjaaaaaeegiocaaa
aaaaaaaabeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
biaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaap
mcaabaaaaaaaaaaakgbobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdiaaaaaipcaabaaa
abaaaaaapgapbaaaaaaaaaaaegiocaaaaaaaaaaaalaaaaaadcaaaaakpcaabaaa
abaaaaaaegiocaaaaaaaaaaaakaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
dcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaaaaaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
aaaaaaaaanaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaiaebaaaaaa
aaaaaaaabbaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaadaaaaaa
jgiecaaaaaaaaaaaajaaaaaacgijcaaaaaaaaaaabbaaaaaadcaaaaamhcaabaaa
adaaaaaajgiecaaaaaaaaaaabbaaaaaacgijcaaaaaaaaaaaajaaaaaaegacbaia
ebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaa
adaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
mbaaaaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaogbkbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahccaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaaaaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
bkaabaaaacaaaaaadbaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaadhaaaaajbcaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaanaaaaaaaoaaaaahncaabaaaaaaaaaaaagajbaaa
abaaaaaapgapbaaaabaaaaaaaaaaaaajhcaabaaaabaaaaaaigadbaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaabbaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaabbaaaaaaaaaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaacaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaaaaaaaaabbaaaaaa
egiccaaaaaaaaaaabbaaaaaadiaaaaajicaabaaaacaaaaaaakiacaaaaaaaaaaa
ahaaaaaaakiacaaaaaaaaaaaahaaaaaadcaaaaambcaabaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaackaabaaaacaaaaaa
diaaaaahbcaabaaaadaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaa
acaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaaakaabaiaebaaaaaaadaaaaaa
bnaaaaahbcaabaaaadaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaalbcaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaacaaaaaaaaaaaaah
ccaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaaaoaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadhaaaaajbcaabaaaacaaaaaa
akaabaaaadaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaialpdbaaaaahccaabaaa
acaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadlaaaaafbcaabaaaadaaaaaa
bkaabaaaacaaaaaaabaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
adaaaaaabpaaaeadbkaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabdiaaaaahhcaabaaa
adaaaaaaegacbaaaabaaaaaaagaabaaaacaaaaaadcaaaaakhcaabaaaabaaaaaa
agaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaabbaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dbaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadhaaaaajhcaabaaa
aaaaaaaafgafbaaaaaaaaaaaegacbaaaabaaaaaaigadbaaaaaaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaajccaabaaaabaaaaaaakiacaaaaaaaaaaa
ahaaaaaaakiacaaaaaaaaaaabdaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagajbaaaadaaaaaadhaaaaajhcaabaaa
aaaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaabbaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
bcaabaaaadaaaaaadkaabaaaabaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaagaabaaaadaaaaaaaaaaaaakicaabaaaabaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaalccaabaaaaeaaaaaa
dkaabaaaabaaaaaabkiacaaaaaaaaaaaaoaaaaaaakiacaaaaaaaaaaaahaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaa
diaaaaaiicaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaaggggggdp
dbaaaaahicaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaj
ccaabaaaafaaaaaaakiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaabbaaaaaa
aaaaaaaiccaabaaaagaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
dgaaaaagfcaabaaaafaaaaaaagiccaaaaaaaaaaabbaaaaaabaaaaaahicaabaaa
adaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaafecaabaaaagaaaaaa
dkaabaaaadaaaaaadgaaaaafbcaabaaaagaaaaaabkaabaaaafaaaaaadgaaaaag
bcaabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadgaaaaafccaabaaaacaaaaaa
bkaabaaaaaaaaaaadhaaaaajhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaacaaaaaadgaaaaagfcaabaaaafaaaaaaagiccaaaaaaaaaaa
bbaaaaaadgaaaaafccaabaaaafaaaaaaakaabaaaacaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaoaaaaahecaabaaaadaaaaaa
bkaabaaaaaaaaaaackaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaaakaabaaa
adaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaaaaaaaaabkaabaaaacaaaaaa
dcaaaaakhcaabaaaagaaaaaaegacbaiaebaaaaaaabaaaaaapgapbaaaabaaaaaa
mgacbaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaackaabaaa
acaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaeaaaaaa
bkaabaaaaeaaaaaaakaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
abeaaaaamkpcejpbaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaaabaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajhcaabaaa
ahaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaaaaaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahecaabaaa
aeaaaaaabkaabaaaaaaaaaaabkaabaaaaeaaaaaaaaaaaaaibcaabaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaaakaabaaaadaaaaaadhaaaaajlcaabaaaaaaaaaaa
kgakbaaaaaaaaaaaegaibaaaahaaaaaaegaibaaaafaaaaaadgaaaaafccaabaaa
adaaaaaackaabaaaacaaaaaadhaaaaajhcaabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaabaaaaaaiecaabaaaaaaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaajaaaaaabaaaaaaibcaabaaaaaaaaaaaegadbaaa
aaaaaaaaegiccaaaaaaaaaaaajaaaaaaaaaaaaaiccaabaaaaaaaaaaaakiacaaa
aaaaaaaaahaaaaaaabeaaaaaaaaamieedbaaaaahicaabaaaaaaaaaaabkaabaaa
afaaaaaabkaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
fgafbaaaafaaaaaadiaaaaahhcaabaaaahaaaaaafgafbaaaaaaaaaaaegacbaaa
agaaaaaaaaaaaaaiicaabaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaaabeaaaaa
aaaamieedgaaaaaficaabaaaagaaaaaabkaabaaaafaaaaaadhaaaaajpcaabaaa
agaaaaaapgapbaaaaaaaaaaaegaobaaaahaaaaaaegaobaaaagaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaaficaabaaa
aaaaaaaabkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaagaaaaaa
egacbaaaabaaaaaabaaaaaaiccaabaaaabaaaaaaegacbaaaagaaaaaaegiccaaa
aaaaaaaaajaaaaaaaoaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaadiaaaaajccaabaaaabaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaaoaaaaaaaoaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaadpbkaabaaa
abaaaaaadiaaaaahecaabaaaabaaaaaadkaabaaaagaaaaaackaabaaaabaaaaaa
elaaaaafecaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaahicaabaaaabaaaaaa
akaabaaaafaaaaaadkaabaaaagaaaaaaaaaaaaahicaabaaaafaaaaaadkaabaaa
abaaaaaackaabaaaafaaaaaadiaaaaahmcaabaaaabaaaaaakgakbaaaabaaaaaa
kgaobaaaafaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaogakbaaaabaaaaaadbaaaaakgcaabaaaadaaaaaakgalbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaajgafbaaaadaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaahocaabaaaadaaaaaakgaobaaaabaaaaaa
kgaobaaaabaaaaaadbaaaaahecaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaadlkklidp
bjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaabaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaabkaabaaaadaaaaaadcaaaaapgcaabaaaadaaaaaakgalbaaa
adaaaaaaaceaaaaaaaaaaaaafmipmcdpfmipmcdpaaaaaaaaaceaaaaaaaaaaaaa
aaaaiaeaaaaaiaeaaaaaaaaaelaaaaafgcaabaaaadaaaaaafgagbaaaadaaaaaa
dcaaaaanmcaabaaaabaaaaaakgaobaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaagjgpbeeagjgpbeeafgajbaaaadaaaaaaaoaaaaahmcaabaaaabaaaaaa
agaebaaaacaaaaaakgaobaaaabaaaaaaaoaaaaaibcaabaaaacaaaaaaakaabaia
ebaaaaaaafaaaaaabkaabaaaabaaaaaaaaaaaaahccaabaaaacaaaaaadkaabaaa
agaaaaaadkaabaaaagaaaaaaaoaaaaahccaabaaaacaaaaaaakaabaaaafaaaaaa
bkaabaaaacaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaaafaaaaaabkaabaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaf
ccaabaaaahaaaaaaakaabaaaacaaaaaadgaaaaaifcaabaaaahaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaadiaaaaahmcaabaaaabaaaaaakgaobaaa
abaaaaaaagaebaaaahaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaabaaaaaa
dkaabaaaagaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
ciapmjeaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaajccaabaaa
adaaaaaadkaabaiaebaaaaaaagaaaaaaakiacaaaaaaaaaaaahaaaaaaaoaaaaah
ccaabaaaabaaaaaabkaabaaaadaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
acaaaaaaapaaaaakecaabaaaabaaaaaaogakbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
ckaabaaaacaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaajecaabaaaabaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaa
aaaaaaaaaoaaaaaaaoaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaadpckaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaabaaaaaa
elaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahfcaabaaaacaaaaaa
kgalbaaaafaaaaaapgapbaaaabaaaaaadbaaaaakmcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagaibaaaacaaaaaadbaaaaakfcaabaaa
aeaaaaaaagacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaadaaaaaakgaobaiaebaaaaaaadaaaaaaagaibaaaaeaaaaaa
claaaaafmcaabaaaadaaaaaakgaobaaaadaaaaaadiaaaaahncaabaaaaeaaaaaa
agaibaaaacaaaaaaagaibaaaacaaaaaadbaaaaahicaabaaaabaaaaaackaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
abeaaaaadlkklidpbjaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaaeaaaaaadcaaaaapfcaabaaa
aeaaaaaakgalbaaaaeaaaaaaaceaaaaafmipmcdpaaaaaaaafmipmcdpaaaaaaaa
aceaaaaaaaaaiaeaaaaaaaaaaaaaiaeaaaaaaaaaelaaaaaffcaabaaaaeaaaaaa
agacbaaaaeaaaaaadcaaaaanfcaabaaaacaaaaaaagacbaiaibaaaaaaacaaaaaa
aceaaaaagjgpbeeaaaaaaaaagjgpbeeaaaaaaaaaagacbaaaaeaaaaaaaoaaaaah
fcaabaaaacaaaaaakgalbaaaadaaaaaaagacbaaaacaaaaaaaoaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaafaaaaaackaabaaaabaaaaaadiaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaahaaaaaabkaabaaa
acaaaaaadiaaaaahdcaabaaaacaaaaaaigaabaaaacaaaaaaogakbaaaahaaaaaa
diaaaaahecaabaaaacaaaaaackaabaaaabaaaaaadkaabaaaagaaaaaadiaaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaciapmjeaelaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaaaoaaaaahecaabaaaabaaaaaabkaabaaaadaaaaaa
ckaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaackaabaaaacaaaaaaapaaaaakbcaabaaaacaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadiaaaaaipcaabaaaahaaaaaa
kgakbaaaabaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaampcaabaaaahaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaafgafbaaaabaaaaaaegaobaiaebaaaaaa
ahaaaaaadiaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaadlkklidp
dlkklidpdlkklidpdlkklidpbjaaaaafpcaabaaaahaaaaaaegaobaaaahaaaaaa
ddaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdcaaaaakccaabaaaabaaaaaabkaabaaaaeaaaaaabkaabaaa
aeaaaaaadkaabaiaebaaaaaaacaaaaaaelaaaaafecaabaaaaeaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaagaaaaaa
dcaaaaakecaabaaaabaaaaaadkaabaaaagaaaaaadkaabaaaagaaaaaadkaabaia
ebaaaaaaacaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaafaaaaaadkaabaaaagaaaaaadcaaaaakccaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
dcaaaaalccaabaaaabaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaa
ahaaaaaabkaabaaaabaaaaaadbaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaaadbaaaaahccaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaa
abaaaaaaabaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaa
aoaaaaalgcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaaaa
agibcaaaaaaaaaaaaiaaaaaaaaaaaaaiicaabaaaafaaaaaabkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaadpdiaaaaahccaabaaaaeaaaaaackaabaaaaeaaaaaa
ckaabaaaaeaaaaaaaaaaaaahicaabaaaaeaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaaadpdgaaaaaihcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafbcaabaaaaeaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaa
agaaaaaaagaabaaaacaaaaaaigaobaaaafaaaaaaegaobaaaaeaaaaaaaoaaaaai
bcaabaaaacaaaaaaabeaaaaaaaaaaadpdkiacaaaaaaaaaaaahaaaaaaaoaaaaah
ccaabaaaacaaaaaackaabaaaabaaaaaackaabaaaaeaaaaaaaoaaaaalicaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkiacaaaaaaaaaaa
ahaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaafgagbaaa
agaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaajccaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaagaaaaaabkaabaaaabaaaaaaaoaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaalmcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpagiecaaaaaaaaaaa
aiaaaaaaaaaaaaalmcaabaaaabaaaaaakgaobaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaiadpdcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaadkaabaaaagaaaaaadeaaaaahccaabaaaadaaaaaa
akaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahccaabaaaadaaaaaabkaabaaa
adaaaaaaabeaaaaabodakleaddaaaaaiecaabaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaaadaaaaaabkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaa
dkaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaackaabaaa
adaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaaagaaaaaadkaabaaaadaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaagaaaaaadkaabaaa
adaaaaaaakaabaaaagaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaagaaaaaa
dkaabaaaadaaaaaaakaabaaaagaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
adaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaagaaaaaadkaabaaaadaaaaaackaabaaaadaaaaaadbaaaaaiccaabaaa
agaaaaaaabeaaaaaaaaaiadpbkaabaiaibaaaaaaadaaaaaadcaaaaajbcaabaaa
agaaaaaaakaabaaaagaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
bcaabaaaagaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaadcaaaaajecaabaaa
adaaaaaackaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaaddaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpdbaaaaaiccaabaaa
adaaaaaabkaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaadhaaaaakccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaa
dcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaacolkgidpabeaaaaa
kehadndpdiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaadp
dcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaaabaaaaaackaabaaa
acaaaaaaaaaaaaahecaabaaaadaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaadpaaaaaaai
icaabaaaadaaaaaackiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaah
bcaabaaaagaaaaaadkaabaaaadaaaaaackaabaaaadaaaaaaebaaaaafbcaabaaa
agaaaaaaakaabaaaagaaaaaadcaaaaakecaabaaaadaaaaaackaabaaaadaaaaaa
dkaabaaaadaaaaaaakaabaiaebaaaaaaagaaaaaadiaaaaaiicaabaaaadaaaaaa
bkaabaaaacaaaaaadkiacaaaaaaaaaaaahaaaaaadcaaaaakccaabaaaacaaaaaa
bkaabaaaacaaaaaadkiacaaaaaaaaaaaahaaaaaaabeaaaaaaaaaialpebaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaa
acaaaaaadkiacaaaaaaaaaaaahaaaaaaebaaaaafccaabaaaagaaaaaadkaabaaa
adaaaaaaaoaaaaaiccaabaaaagaaaaaabkaabaaaagaaaaaadkiacaaaaaaaaaaa
ahaaaaaabkaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaaaaaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaakaabaaaagaaaaaaaoaaaaaiccaabaaaaiaaaaaa
bkaabaaaadaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaadkiacaaaaaaaaaaaahaaaaaaaaaaaaahecaabaaaaiaaaaaa
bkaabaaaacaaaaaabkaabaaaabaaaaaaeiaaaaalpcaabaaaajaaaaaajgafbaaa
aiaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaacaaaaaackaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaa
aiaaaaaabkaabaaaadaaaaaackiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaigaabaaaaiaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaakaaaaaakgakbaaaadaaaaaaegaobaaaakaaaaaa
dcaaaaajpcaabaaaajaaaaaaegaobaaaajaaaaaafgafbaaaacaaaaaaegaobaaa
akaaaaaaaaaaaaahicaabaaaaiaaaaaabkaabaaaagaaaaaabkaabaaaabaaaaaa
eiaaaaalpcaabaaaakaaaaaangafbaaaaiaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaamgaabaaaaiaaaaaa
eghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
aiaaaaaakgakbaaaadaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaaiaaaaaa
egaobaaaakaaaaaafgafbaaaacaaaaaaegaobaaaaiaaaaaaaaaaaaaiccaabaaa
abaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
aiaaaaaapgapbaaaadaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaaiaaaaaa
egaobaaaajaaaaaafgafbaaaabaaaaaaegaobaaaaiaaaaaadcaaaaamccaabaaa
abaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaaakiacaaaaaaaaaaaahaaaaaa
bkaabaaaaaaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaak
ccaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaalccaabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaaakiacaaa
aaaaaaaaahaaaaaabkaabaaaaaaaaaaadbaaaaahccaabaaaadaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaaadaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabaaaaahccaabaaaadaaaaaadkaabaaaadaaaaaabkaabaaa
adaaaaaadhaaaaajpcaabaaaafaaaaaafgafbaaaadaaaaaaegaobaaaafaaaaaa
egaobaaaaeaaaaaaaoaaaaahccaabaaaadaaaaaabkaabaaaabaaaaaackaabaaa
aeaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
afaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaaakaabaaaabaaaaaaakaabaaaafaaaaaabkaabaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaafaaaaaaaoaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaafaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaabodakleaddaaaaaibcaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaabaaaaaadkaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaai
icaabaaaacaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaaaaaaaaadcaaaaaj
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
abaaaaahecaabaaaabaaaaaadkaabaaaacaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
ddaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaai
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadhaaaaak
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaacolkgidp
abeaaaaakehadndpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
ckaabaaaacaaaaaadiaaaaaibcaabaaaabaaaaaaakaabaaaacaaaaaadkiacaaa
aaaaaaaaahaaaaaadcaaaaakccaabaaaabaaaaaaakaabaaaacaaaaaadkiacaaa
aaaaaaaaahaaaaaaabeaaaaaaaaaialpebaaaaafgcaabaaaabaaaaaafgaebaaa
abaaaaaaaoaaaaaigcaabaaaabaaaaaafgagbaaaabaaaaaapgipcaaaaaaaaaaa
ahaaaaaabkaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaagaaaaaaaoaaaaaiccaabaaaaeaaaaaa
dkaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaaaoaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaaaaaaaahmcaabaaaaeaaaaaa
fgajbaaaabaaaaaafgafbaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaajgafbaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaa
aeaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaa
agaaaaaaigaabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaagaaaaaakgakbaaaadaaaaaaegaobaaaagaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaafaaaaaafgafbaaaacaaaaaaegaobaaa
agaaaaaaeiaaaaalpcaabaaaagaaaaaangafbaaaaeaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaamgaabaaa
aeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaaeaaaaaakgakbaaaadaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaagaaaaaafgafbaaaacaaaaaaegaobaaaaeaaaaaaaaaaaaai
ccaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
pcaabaaaabaaaaaaagaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaafaaaaaafgafbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaahaaaaaaegaobaaa
aiaaaaaadeaaaaakpcaabaaaacaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadicaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaeiecdcaaaaajccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaa
diaaaaahlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaaacaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaabhlhnbdiaoaaaaahlcaabaaa
aaaaaaaaegambaaaaaaaaaaaagaabaaaabaaaaaaaoaaaaajhcaabaaaabaaaaaa
agiacaaaaaaaaaaaaeaaaaaaegiccaaaaaaaaaaaaeaaaaaadiaaaaahlcaabaaa
aaaaaaaaegambaaaaaaaaaaaegaibaaaabaaaaaadiaaaaaldcaabaaaabaaaaaa
agiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiaebaaaaiaeaaaaaaaaaaaaaaaaa
aoaaaaakdcaabaaaabaaaaaaaceaaaaaaaaaeaeaaaaamadpaaaaaaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaamicaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaadcaaaaaogcaabaaa
adaaaaaapgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaeaaaaaaaaaapaaaaaiecaabaaaaaaaaaaakgakbaaa
aaaaaaaapgipcaaaaaaaaaaaagaaaaaaaaaaaaaiecaabaaaaaaaaaaackaabaia
ebaaaaaaaaaaaaaabkaabaaaadaaaaaacpaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaamalp
bjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaa
abaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
aaaaaaaaajaaaaaabnaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaa
akaabaaaadaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaiaeaaoaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaa
apaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaadbaaaaakhcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaacpnnledpcpnnledpcpnnledpaaaaaaaa
diaaaaakpcaabaaaacaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedodlkklilp
nmcomedodlkklilpcpaaaaafdcaabaaaaaaaaaaaigaabaaaacaaaaaadiaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaacplkoidocplkoidoaaaaaaaa
aaaaaaaabjaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaabjaaaaafdcaabaaa
acaaaaaangafbaaaacaaaaaaaaaaaaaldcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadhaaaaajdcaabaaa
acaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaacaaaaaadiaaaaak
dcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaaj
ecaabaaaacaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaacaaaaaapgipcaaaaaaaaaaaaoaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "GODRAYS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_ON" }
"!!GLES3"
}
}
 }
}
}