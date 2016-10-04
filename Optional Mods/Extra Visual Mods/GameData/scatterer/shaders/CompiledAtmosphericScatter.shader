// Compiled shader for custom platforms, uncompressed size: 311.6KB

Shader "Sky/AtmosphereGhoss" {
SubShader { 
 Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 20 math
 //        d3d9 : 24 math
 //        gles : 177 math, 1 texture, 11 branch
 //      opengl : 177 math, 1 texture, 11 branch
 // Stats for Fragment shader:
 //       d3d11 : 154 math, 1 texture, 4 branch
 //        d3d9 : 197 math, 1 texture, 4 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Front
  Blend DstColor Zero
  GpuProgramID 35102
Program "vp" {
SubProgram "opengl " {
// Stats: 177 math, 1 textures, 11 branches
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec2 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float Rg;
uniform float Rt;
uniform float _experimentalAtmoScale;
uniform mat4 _ViewProjInv;
uniform vec3 _camPos;
uniform float _Post_Extinction_Tint;
uniform float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
uniform float _openglThreshold;
float xlat_mutableRt;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  bool tmpvar_3;
  tmpvar_3 = (tmpvar_2.x == 1.0);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_4.z = tmpvar_2.x;
  vec4 tmpvar_5;
  tmpvar_5 = (_ViewProjInv * tmpvar_4);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_5.w).xyz;
  float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  float tmpvar_8;
  tmpvar_8 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  float tmpvar_10;
  if ((tmpvar_9 < 0.0)) {
    tmpvar_10 = -1.0;
  } else {
    tmpvar_10 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_11;
  tmpvar_11 = (tmpvar_10 > 0.0);
  if ((!(tmpvar_11) && tmpvar_3)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    vec3 tmpvar_12;
    tmpvar_12 = (_camPos + (tmpvar_10 * xlv_TEXCOORD3));
    vec3 x_13;
    x_13 = (tmpvar_12 - _camPos);
    vec3 x_14;
    x_14 = (tmpvar_6 - _camPos);
    bool tmpvar_15;
    tmpvar_15 = (sqrt(dot (x_13, x_13)) < sqrt(dot (x_14, x_14)));
    vec3 tmpvar_16;
    if ((tmpvar_11 && tmpvar_15)) {
      tmpvar_16 = tmpvar_12;
    } else {
      tmpvar_16 = tmpvar_6;
    };
    float tmpvar_17;
    tmpvar_17 = sqrt(dot (tmpvar_16, tmpvar_16));
    vec3 tmpvar_18;
    if ((tmpvar_17 < (Rg + _openglThreshold))) {
      tmpvar_18 = ((Rg + _openglThreshold) * normalize(tmpvar_16));
    } else {
      tmpvar_18 = tmpvar_16;
    };
    vec3 camera_19;
    camera_19 = _camPos;
    float mu_20;
    float rMu_21;
    float r_22;
    float d_23;
    vec3 viewdir_24;
    vec3 extinction_25;
    extinction_25 = vec3(1.0, 1.0, 1.0);
    vec3 tmpvar_26;
    tmpvar_26 = (tmpvar_18 - _camPos);
    float tmpvar_27;
    tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
    d_23 = tmpvar_27;
    viewdir_24 = (tmpvar_26 / tmpvar_27);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_28;
    tmpvar_28 = normalize(viewdir_24);
    viewdir_24 = tmpvar_28;
    float tmpvar_29;
    tmpvar_29 = sqrt(dot (_camPos, _camPos));
    r_22 = tmpvar_29;
    if ((tmpvar_29 < (0.9 * Rg))) {
      camera_19.y = (_camPos.y + Rg);
      r_22 = sqrt(dot (camera_19, camera_19));
    };
    float tmpvar_30;
    tmpvar_30 = dot (camera_19, tmpvar_28);
    rMu_21 = tmpvar_30;
    mu_20 = (tmpvar_30 / r_22);
    float f_31;
    f_31 = (((tmpvar_30 * tmpvar_30) - (r_22 * r_22)) + (xlat_mutableRt * xlat_mutableRt));
    float tmpvar_32;
    if ((f_31 >= 0.0)) {
      tmpvar_32 = sqrt(f_31);
    } else {
      tmpvar_32 = 1e-06;
    };
    float tmpvar_33;
    tmpvar_33 = max ((-(tmpvar_30) - tmpvar_32), 0.0);
    if (((tmpvar_33 > 0.0) && (tmpvar_33 < tmpvar_27))) {
      rMu_21 = (tmpvar_30 + tmpvar_33);
      mu_20 = (rMu_21 / xlat_mutableRt);
      r_22 = xlat_mutableRt;
      d_23 = (tmpvar_27 - tmpvar_33);
    };
    if ((r_22 <= xlat_mutableRt)) {
      if ((r_22 < (Rg + 1600.0))) {
        r_22 = (r_22 * ((Rg + 1600.0) / r_22));
      };
      float tmpvar_34;
      float H_35;
      H_35 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_36;
      tmpvar_36.x = mu_20;
      tmpvar_36.y = (mu_20 + (d_23 / r_22));
      vec2 tmpvar_37;
      tmpvar_37 = (sqrt((
        (0.5 / H_35)
       * r_22)) * tmpvar_36);
      vec2 tmpvar_38;
      tmpvar_38 = sign(tmpvar_37);
      vec2 tmpvar_39;
      tmpvar_39 = (tmpvar_37 * tmpvar_37);
      float tmpvar_40;
      if ((tmpvar_38.y > tmpvar_38.x)) {
        tmpvar_40 = exp(tmpvar_39.x);
      } else {
        tmpvar_40 = 0.0;
      };
      vec2 tmpvar_41;
      tmpvar_41.x = 1.0;
      tmpvar_41.y = exp(((
        -(d_23)
       / H_35) * (
        (d_23 / (2.0 * r_22))
       + mu_20)));
      tmpvar_34 = ((sqrt(
        ((6.2831 * H_35) * r_22)
      ) * exp(
        ((Rg - r_22) / H_35)
      )) * (tmpvar_40 + dot (
        ((tmpvar_38 / ((2.3193 * 
          abs(tmpvar_37)
        ) + sqrt(
          ((1.52 * tmpvar_39) + 4.0)
        ))) * tmpvar_41)
      , vec2(1.0, -1.0))));
      float H_42;
      H_42 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_43;
      tmpvar_43.x = mu_20;
      tmpvar_43.y = (mu_20 + (d_23 / r_22));
      vec2 tmpvar_44;
      tmpvar_44 = (sqrt((
        (0.5 / H_42)
       * r_22)) * tmpvar_43);
      vec2 tmpvar_45;
      tmpvar_45 = sign(tmpvar_44);
      vec2 tmpvar_46;
      tmpvar_46 = (tmpvar_44 * tmpvar_44);
      float tmpvar_47;
      if ((tmpvar_45.y > tmpvar_45.x)) {
        tmpvar_47 = exp(tmpvar_46.x);
      } else {
        tmpvar_47 = 0.0;
      };
      vec2 tmpvar_48;
      tmpvar_48.x = 1.0;
      tmpvar_48.y = exp(((
        -(d_23)
       / H_42) * (
        (d_23 / (2.0 * r_22))
       + mu_20)));
      extinction_25 = min (exp((
        (-(betaR) * tmpvar_34)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_42) * r_22)
        ) * exp(
          ((Rg - r_22) / H_42)
        )) * (tmpvar_47 + dot (
          ((tmpvar_45 / ((2.3193 * 
            abs(tmpvar_44)
          ) + sqrt(
            ((1.52 * tmpvar_46) + 4.0)
          ))) * tmpvar_48)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
    } else {
      extinction_25 = vec3(1.0, 1.0, 1.0);
    };
    vec4 tmpvar_49;
    tmpvar_49.w = 1.0;
    tmpvar_49.xyz = mix (vec3(1.0, 1.0, 1.0), ((vec3(_Post_Extinction_Tint) * extinction_25) + (vec3(
      (1.0 - _Post_Extinction_Tint)
    ) * vec3(
      (((extinction_25.x + extinction_25.y) + extinction_25.z) / 3.0)
    ))), vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_49;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Bind "vertex" Vertex
Matrix 7 [_Object2World] 3
Matrix 4 [glstate_matrix_modelview0] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_TexelSize]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
"vs_3_0
def c14, 0.5, 0, -2, 1
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xy
dcl_texcoord2 o3.xy
dcl_texcoord3 o4.xyz
dp4 o0.z, c2, v0
dp4 r0.x, c6, v0
mov o1.z, -r0.x
dp4 r0.x, c7, v0
dp4 r0.y, c8, v0
dp4 r0.z, c9, v0
add o4.xyz, r0, -c10
dp4 r0.x, c0, v0
dp4 r0.y, c1, v0
dp4 r0.w, c3, v0
mov o0.xyw, r0
mul r1.xz, r0.xyww, c14.x
mul r0.x, r0.y, c11.x
mul r1.w, r0.x, c14.x
mad r0.xy, r1.z, c12.zwzw, r1.xwzw
rcp r0.z, r0.w
mul r1.xy, r0.z, r0
mov o1.xyw, r0
mad r0.x, r1.y, c14.z, c14.w
mov r0.y, c14.y
slt r0.y, c13.y, r0.y
mad r1.z, r0.y, r0.x, r1.y
mov o2.xy, r1.xzzw
mov o3.xy, r1

"
}
SubProgram "d3d11 " {
// Stats: 20 math
Bind "vertex" Vertex
ConstBuffer "$Globals" 496
Vector 400 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedaloffdbnikemgpdmanppjjihabkionmbabaaaaaapmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaeaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcleadaaaaeaaaabaaonaaaaaafjaaaaaeegiocaaaaaaaaaaabkaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaa
aaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaa
egambaaaaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabjaaaaaaabeaaaaa
aaaaaaaadhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 177 math, 1 textures, 11 branches
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float _experimentalAtmoScale;
uniform highp mat4 _ViewProjInv;
uniform highp vec3 _camPos;
uniform highp float _Post_Extinction_Tint;
uniform highp float postExtinctionMultiplier;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
highp float xlat_mutableRt;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  mediump vec4 tmpvar_1;
  highp float depth_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_2 = tmpvar_3;
  bool tmpvar_4;
  tmpvar_4 = (depth_2 == 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_5.z = depth_2;
  highp vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  highp float tmpvar_9;
  tmpvar_9 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_9 * tmpvar_9) - ((4.0 * tmpvar_8) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_11;
  if ((tmpvar_10 < 0.0)) {
    tmpvar_11 = -1.0;
  } else {
    tmpvar_11 = ((-(tmpvar_9) - sqrt(tmpvar_10)) / (2.0 * tmpvar_8));
  };
  bool tmpvar_12;
  tmpvar_12 = (tmpvar_11 > 0.0);
  if ((!(tmpvar_12) && tmpvar_4)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp vec3 tmpvar_13;
    tmpvar_13 = (_camPos + (tmpvar_11 * xlv_TEXCOORD3));
    highp vec3 x_14;
    x_14 = (tmpvar_13 - _camPos);
    highp vec3 x_15;
    x_15 = (tmpvar_7 - _camPos);
    bool tmpvar_16;
    tmpvar_16 = (sqrt(dot (x_14, x_14)) < sqrt(dot (x_15, x_15)));
    highp vec3 tmpvar_17;
    if ((tmpvar_12 && tmpvar_16)) {
      tmpvar_17 = tmpvar_13;
    } else {
      tmpvar_17 = tmpvar_7;
    };
    highp float tmpvar_18;
    tmpvar_18 = sqrt(dot (tmpvar_17, tmpvar_17));
    highp vec3 tmpvar_19;
    if ((tmpvar_18 < (Rg + _openglThreshold))) {
      tmpvar_19 = ((Rg + _openglThreshold) * normalize(tmpvar_17));
    } else {
      tmpvar_19 = tmpvar_17;
    };
    highp vec3 camera_20;
    camera_20 = _camPos;
    highp float mu_21;
    highp float rMu_22;
    highp float r_23;
    highp float d_24;
    highp vec3 viewdir_25;
    highp vec3 extinction_26;
    extinction_26 = vec3(1.0, 1.0, 1.0);
    highp vec3 tmpvar_27;
    tmpvar_27 = (tmpvar_19 - _camPos);
    highp float tmpvar_28;
    tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
    d_24 = tmpvar_28;
    viewdir_25 = (tmpvar_27 / tmpvar_28);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize(viewdir_25);
    viewdir_25 = tmpvar_29;
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (_camPos, _camPos));
    r_23 = tmpvar_30;
    if ((tmpvar_30 < (0.9 * Rg))) {
      camera_20.y = (_camPos.y + Rg);
      r_23 = sqrt(dot (camera_20, camera_20));
    };
    highp float tmpvar_31;
    tmpvar_31 = dot (camera_20, tmpvar_29);
    rMu_22 = tmpvar_31;
    mu_21 = (tmpvar_31 / r_23);
    highp float f_32;
    f_32 = (((tmpvar_31 * tmpvar_31) - (r_23 * r_23)) + (xlat_mutableRt * xlat_mutableRt));
    highp float tmpvar_33;
    if ((f_32 >= 0.0)) {
      tmpvar_33 = sqrt(f_32);
    } else {
      tmpvar_33 = 1e-06;
    };
    highp float tmpvar_34;
    tmpvar_34 = max ((-(tmpvar_31) - tmpvar_33), 0.0);
    if (((tmpvar_34 > 0.0) && (tmpvar_34 < tmpvar_28))) {
      rMu_22 = (tmpvar_31 + tmpvar_34);
      mu_21 = (rMu_22 / xlat_mutableRt);
      r_23 = xlat_mutableRt;
      d_24 = (tmpvar_28 - tmpvar_34);
    };
    if ((r_23 <= xlat_mutableRt)) {
      if ((r_23 < (Rg + 1600.0))) {
        r_23 = (r_23 * ((Rg + 1600.0) / r_23));
      };
      highp float tmpvar_35;
      highp float H_36;
      H_36 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_37;
      tmpvar_37.x = mu_21;
      tmpvar_37.y = (mu_21 + (d_24 / r_23));
      highp vec2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_23)) * tmpvar_37);
      highp vec2 tmpvar_39;
      tmpvar_39 = sign(tmpvar_38);
      highp vec2 tmpvar_40;
      tmpvar_40 = (tmpvar_38 * tmpvar_38);
      highp float tmpvar_41;
      if ((tmpvar_39.y > tmpvar_39.x)) {
        tmpvar_41 = exp(tmpvar_40.x);
      } else {
        tmpvar_41 = 0.0;
      };
      highp vec2 tmpvar_42;
      tmpvar_42.x = 1.0;
      tmpvar_42.y = exp(((
        -(d_24)
       / H_36) * (
        (d_24 / (2.0 * r_23))
       + mu_21)));
      tmpvar_35 = ((sqrt(
        ((6.2831 * H_36) * r_23)
      ) * exp(
        ((Rg - r_23) / H_36)
      )) * (tmpvar_41 + dot (
        ((tmpvar_39 / ((2.3193 * 
          abs(tmpvar_38)
        ) + sqrt(
          ((1.52 * tmpvar_40) + 4.0)
        ))) * tmpvar_42)
      , vec2(1.0, -1.0))));
      highp float H_43;
      H_43 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_44;
      tmpvar_44.x = mu_21;
      tmpvar_44.y = (mu_21 + (d_24 / r_23));
      highp vec2 tmpvar_45;
      tmpvar_45 = (sqrt((
        (0.5 / H_43)
       * r_23)) * tmpvar_44);
      highp vec2 tmpvar_46;
      tmpvar_46 = sign(tmpvar_45);
      highp vec2 tmpvar_47;
      tmpvar_47 = (tmpvar_45 * tmpvar_45);
      highp float tmpvar_48;
      if ((tmpvar_46.y > tmpvar_46.x)) {
        tmpvar_48 = exp(tmpvar_47.x);
      } else {
        tmpvar_48 = 0.0;
      };
      highp vec2 tmpvar_49;
      tmpvar_49.x = 1.0;
      tmpvar_49.y = exp(((
        -(d_24)
       / H_43) * (
        (d_24 / (2.0 * r_23))
       + mu_21)));
      extinction_26 = min (exp((
        (-(betaR) * tmpvar_35)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_43) * r_23)
        ) * exp(
          ((Rg - r_23) / H_43)
        )) * (tmpvar_48 + dot (
          ((tmpvar_46 / ((2.3193 * 
            abs(tmpvar_45)
          ) + sqrt(
            ((1.52 * tmpvar_47) + 4.0)
          ))) * tmpvar_49)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
    } else {
      extinction_26 = vec3(1.0, 1.0, 1.0);
    };
    highp vec4 tmpvar_50;
    tmpvar_50.w = 1.0;
    tmpvar_50.xyz = mix (vec3(1.0, 1.0, 1.0), ((vec3(_Post_Extinction_Tint) * extinction_26) + (vec3(
      (1.0 - _Post_Extinction_Tint)
    ) * vec3(
      (((extinction_26.x + extinction_26.y) + extinction_26.z) / 3.0)
    ))), vec3(postExtinctionMultiplier));
    tmpvar_1 = tmpvar_50;
  };
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	float _Post_Extinction_Tint;
uniform 	float postExtinctionMultiplier;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec4 t1;
highp float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	float _Post_Extinction_Tint;
uniform 	float postExtinctionMultiplier;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform lowp sampler2D _customDepthTexture;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
highp vec4 t0;
lowp float t10_0;
highp vec4 t1;
highp int ti1;
bool tb1;
highp vec4 t2;
highp ivec4 ti2;
bool tb2;
highp vec4 t3;
highp vec4 t4;
highp float t5;
highp int ti5;
bool tb5;
highp vec2 t6;
bool tb6;
highp vec3 t7;
highp vec2 t10;
highp int ti10;
bool tb10;
highp vec2 t11;
highp ivec2 ti11;
bool tb11;
highp vec2 t12;
highp ivec2 ti12;
highp float t15;
highp int ti15;
bool tb15;
highp float t16;
bool tb16;
highp float t17;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy).x;
    tb5 = t10_0==1.0;
    t10.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t15 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t15 + t15;
    t6.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t11.x = (-Rg) * Rg + t6.x;
    t11.x = t10.x * t11.x;
    t11.x = t11.x * 4.0;
    t1.x = t1.x * t1.x + (-t11.x);
    tb11 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t15 = (-t15) * 2.0 + (-t1.x);
    t10.x = t10.x + t10.x;
    t10.x = t15 / t10.x;
    t10.x = (tb11) ? -1.0 : t10.x;
    ti15 = int((0.0<t10.x) ? 0xFFFFFFFFu : uint(0u));
    ti1 = ~ti15;
    ti5 = tb5 ? ti1 : int(0);
    if((uint(ti5))!=uint(0u)){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t1.xz = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t1.zzzz * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t1.xxxx + t2;
    t2 = _ViewProjInv[2] * vec4(t10_0) + t2;
    t2 = t2 + _ViewProjInv[3];
    t1.xzw = t2.xyz / t2.www;
    t2.xyz = t10.xxx * vs_TEXCOORD3.xyz;
    t0.xyz = t10.xxx * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t2.x = dot(t2.xyz, t2.xyz);
    t7.xyz = t1.xzw + (-_camPos.xyzx.xyz);
    t2.y = dot(t7.xyz, t7.xyz);
    t2.xy = sqrt(t2.xy);
    tb2 = t2.x<t2.y;
    ti15 = tb2 ? ti15 : int(0);
    t0.xyz = (int(ti15) != 0) ? t0.xyz : t1.xzw;
    t15 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t15);
    t11.x = Rg + _openglThreshold;
    tb1 = t1.x<t11.x;
    t15 = inversesqrt(t15);
    t2.xyz = vec3(t15) * t0.xyz;
    t2.xyz = t11.xxx * t2.xyz;
    t0.xyz = (bool(tb1)) ? t2.xyz : t0.xyz;
    t0.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t15 = dot(t0.xyz, t0.xyz);
    t2.x = sqrt(t15);
    t0.xyz = t0.xyz / t2.xxx;
    t15 = (-Rg) + Rt;
    t3.y = t15 * _experimentalAtmoScale + Rg;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t0.xyz = vec3(t15) * t0.xyz;
    t1.y = sqrt(t6.x);
    t15 = Rg * 0.899999976;
    tb15 = t1.y<t15;
    t4.x = Rg + _camPos.xyzx.y;
    t4.yz = _camPos.xyzx.xz;
    t11.x = dot(t4.xyz, t4.xyz);
    t4.w = sqrt(t11.x);
    t1.xzw = _camPos.xyzx.yxz;
    t1.xy = (bool(tb15)) ? t4.xw : t1.xy;
    t0.x = dot(t1.zxw, t0.xyz);
    t2.z = t0.x / t1.y;
    t5 = t1.y * t1.y;
    t5 = t0.x * t0.x + (-t5);
    t5 = t3.y * t3.y + t5;
    tb10 = t5>=0.0;
    t5 = sqrt(t5);
    t5 = (tb10) ? (-t5) : -9.99999997e-007;
    t5 = t5 + (-t0.x);
    t5 = max(t5, 0.0);
    tb10 = 0.0<t5;
    tb15 = t5<t2.x;
    ti10 = int(uint(tb15) * 0xffffffffu & uint(tb10) * 0xffffffffu);
    t0.x = t5 + t0.x;
    t3.z = t0.x / t3.y;
    t3.x = (-t5) + t2.x;
    t2.y = t1.y;
    t0.xyz = (int(ti10) != 0) ? t3.xyz : t2.xyz;
    tb1 = t3.y>=t0.y;
    if(tb1){
        t1.x = Rg + 1600.0;
        tb6 = t0.y<t1.x;
        t5 = (tb6) ? t1.x : t0.y;
        t1.x = HR * _experimentalAtmoScale;
        t6.x = 0.5 / t1.x;
        t6.x = t5 * t6.x;
        t6.x = sqrt(t6.x);
        t11.x = t0.x / t5;
        t0.w = t0.z + t11.x;
        t6.xy = vec2(t0.z * t6.x, t0.w * t6.x);
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t6.xyxx).xy) * 0xFFFFFFFFu);
        ti12.xy = ivec2(uvec2(lessThan(t6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti12.xy;
        t2.xy = vec2(ti2.xy);
        t3.xyz = t6.xxy * t6.xxy;
        tb16 = t2.x<t2.y;
        t12.x = t3.x * 1.44269502;
        t12.x = exp2(t12.x);
        t16 = tb16 ? t12.x : float(0.0);
        t12.xy = t3.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t12.xy = sqrt(t12.xy);
        t6.xy = abs(t6.xy) * vec2(2.31929994, 2.31929994) + t12.xy;
        t6.xy = t2.xy / t6.xy;
        t2.x = (-t0.x) / t1.x;
        t7.x = t5 + t5;
        t7.x = t0.x / t7.x;
        t7.x = t0.z + t7.x;
        t2.x = t7.x * t2.x;
        t2.x = t2.x * 1.44269502;
        t3.y = exp2(t2.x);
        t3.xz = vec2(1.0, 1.0);
        t6.xy = t6.xy * t3.xy;
        t2.x = t5 * t1.x;
        t2.x = t2.x * 6.28310013;
        t2.x = sqrt(t2.x);
        t12.x = (-t5) + Rg;
        t1.x = t12.x / t1.x;
        t1.x = t1.x * 1.44269502;
        t1.x = exp2(t1.x);
        t1.x = t1.x * t2.x;
        t6.x = dot(t6.xy, vec2(1.0, -1.0));
        t6.x = t6.x + t16;
        t1.x = t6.x * t1.x;
        t6.x = HM * _experimentalAtmoScale;
        t11.x = 0.5 / t6.x;
        t11.x = t5 * t11.x;
        t11.x = sqrt(t11.x);
        t10.xy = vec2(t0.z * t11.x, t0.w * t11.x);
        ti11.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t10.xyxy).xy) * 0xFFFFFFFFu);
        ti2.xw = ivec2(uvec2(lessThan(t10.xxxy, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
        ti11.xy = (-ti11.xy) + ti2.xw;
        t11.xy = vec2(ti11.xy);
        t4.xyz = t10.xxy * t10.xxy;
        tb2 = t11.x<t11.y;
        t17 = t4.x * 1.44269502;
        t17 = exp2(t17);
        t2.x = tb2 ? t17 : float(0.0);
        t3.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t3.xy = sqrt(t3.xy);
        t10.xy = abs(t10.xy) * vec2(2.31929994, 2.31929994) + t3.xy;
        t10.xy = t11.xy / t10.xy;
        t0.x = (-t0.x) / t6.x;
        t0.x = t7.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t3.w = exp2(t0.x);
        t0.xz = vec2(t10.x * t3.z, t10.y * t3.w);
        t5 = t5 * t6.x;
        t5 = t5 * 6.28310013;
        t5 = sqrt(t5);
        t15 = t12.x / t6.x;
        t15 = t15 * 1.44269502;
        t15 = exp2(t15);
        t5 = t15 * t5;
        t0.x = dot(t0.xz, vec2(1.0, -1.0));
        t0.x = t0.x + t2.x;
        t0.x = t0.x * t5;
        t0.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xyz = (-betaR.xyzx.xyz) * t1.xxx + (-t0.xyz);
        t0.xyz = t0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t0.xyz = exp2(t0.xyz);
        t0.xyz = min(t0.xyz, vec3(1.0, 1.0, 1.0));
    } else {
        t0.xyz = vec3(1.0, 1.0, 1.0);
    //ENDIF
    }
    t15 = t0.y + t0.x;
    t15 = t0.z + t15;
    t15 = t15 * 0.333333343;
    t1.x = (-_Post_Extinction_Tint) + 1.0;
    t15 = t15 * t1.x;
    t0.xyz = vec3(vec3(_Post_Extinction_Tint, _Post_Extinction_Tint, _Post_Extinction_Tint)) * t0.xyz + vec3(t15);
    t0.xyz = t0.xyz + vec3(-1.0, -1.0, -1.0);
    t0.xyz = vec3(postExtinctionMultiplier) * t0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	float _Post_Extinction_Tint;
uniform 	float postExtinctionMultiplier;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in  vec4 in_POSITION0;
out vec4 vs_TEXCOORD0;
out vec2 vs_TEXCOORD1;
 vec4 phase0_Output0_2;
out vec2 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
vec4 t0;
vec4 t1;
float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	float _Post_Extinction_Tint;
uniform 	float postExtinctionMultiplier;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform  sampler2D _customDepthTexture;
in  vec2 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
out vec4 SV_Target0;
vec4 t0;
lowp vec4 t10_0;
vec4 t1;
int ti1;
bool tb1;
vec4 t2;
ivec4 ti2;
bool tb2;
vec4 t3;
vec4 t4;
float t5;
int ti5;
bool tb5;
vec2 t6;
bool tb6;
vec3 t7;
vec2 t10;
int ti10;
bool tb10;
vec2 t11;
ivec2 ti11;
bool tb11;
vec2 t12;
ivec2 ti12;
float t15;
int ti15;
bool tb15;
float t16;
bool tb16;
float t17;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy);
    tb5 = t10_0.x==1.0;
    t10.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t15 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t15 + t15;
    t6.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t11.x = (-Rg) * Rg + t6.x;
    t11.x = t10.x * t11.x;
    t11.x = t11.x * 4.0;
    t1.x = t1.x * t1.x + (-t11.x);
    tb11 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t15 = (-t15) * 2.0 + (-t1.x);
    t10.x = t10.x + t10.x;
    t10.x = t15 / t10.x;
    t10.x = (tb11) ? -1.0 : t10.x;
    ti15 = int((0.0<t10.x) ? 0xFFFFFFFFu : uint(0u));
    ti1 = ~ti15;
    ti5 = tb5 ? ti1 : int(0);
    if((uint(ti5))!=uint(0u)){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t1.xz = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t1.zzzz * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t1.xxxx + t2;
    t2 = _ViewProjInv[2] * t10_0.xxxx + t2;
    t2 = t2 + _ViewProjInv[3];
    t1.xzw = t2.xyz / t2.www;
    t2.xyz = t10.xxx * vs_TEXCOORD3.xyz;
    t0.xyz = t10.xxx * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t2.x = dot(t2.xyz, t2.xyz);
    t7.xyz = t1.xzw + (-_camPos.xyzx.xyz);
    t2.y = dot(t7.xyz, t7.xyz);
    t2.xy = sqrt(t2.xy);
    tb2 = t2.x<t2.y;
    ti15 = tb2 ? ti15 : int(0);
    t0.xyz = (int(ti15) != 0) ? t0.xyz : t1.xzw;
    t15 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t15);
    t11.x = Rg + _openglThreshold;
    tb1 = t1.x<t11.x;
    t15 = inversesqrt(t15);
    t2.xyz = vec3(t15) * t0.xyz;
    t2.xyz = t11.xxx * t2.xyz;
    t0.xyz = (bool(tb1)) ? t2.xyz : t0.xyz;
    t0.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t15 = dot(t0.xyz, t0.xyz);
    t2.x = sqrt(t15);
    t0.xyz = t0.xyz / t2.xxx;
    t15 = (-Rg) + Rt;
    t3.y = t15 * _experimentalAtmoScale + Rg;
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t0.xyz = vec3(t15) * t0.xyz;
    t1.y = sqrt(t6.x);
    t15 = Rg * 0.899999976;
    tb15 = t1.y<t15;
    t4.x = Rg + _camPos.xyzx.y;
    t4.yz = _camPos.xyzx.xz;
    t11.x = dot(t4.xyz, t4.xyz);
    t4.w = sqrt(t11.x);
    t1.xzw = _camPos.xyzx.yxz;
    t1.xy = (bool(tb15)) ? t4.xw : t1.xy;
    t0.x = dot(t1.zxw, t0.xyz);
    t2.z = t0.x / t1.y;
    t5 = t1.y * t1.y;
    t5 = t0.x * t0.x + (-t5);
    t5 = t3.y * t3.y + t5;
    tb10 = t5>=0.0;
    t5 = sqrt(t5);
    t5 = (tb10) ? (-t5) : -9.99999997e-007;
    t5 = t5 + (-t0.x);
    t5 = max(t5, 0.0);
    tb10 = 0.0<t5;
    tb15 = t5<t2.x;
    ti10 = int(uint(tb15) * 0xffffffffu & uint(tb10) * 0xffffffffu);
    t0.x = t5 + t0.x;
    t3.z = t0.x / t3.y;
    t3.x = (-t5) + t2.x;
    t2.y = t1.y;
    t0.xyz = (int(ti10) != 0) ? t3.xyz : t2.xyz;
    tb1 = t3.y>=t0.y;
    if(tb1){
        t1.x = Rg + 1600.0;
        tb6 = t0.y<t1.x;
        t5 = (tb6) ? t1.x : t0.y;
        t1.x = HR * _experimentalAtmoScale;
        t6.x = 0.5 / t1.x;
        t6.x = t5 * t6.x;
        t6.x = sqrt(t6.x);
        t11.x = t0.x / t5;
        t0.w = t0.z + t11.x;
        t6.xy = t0.zw * t6.xx;
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t6.xyxx).xy) * 0xFFFFFFFFu);
        ti12.xy = ivec2(uvec2(lessThan(t6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti12.xy;
        t2.xy = vec2(ti2.xy);
        t3.xyz = t6.xxy * t6.xxy;
        tb16 = t2.x<t2.y;
        t12.x = t3.x * 1.44269502;
        t12.x = exp2(t12.x);
        t16 = tb16 ? t12.x : float(0.0);
        t12.xy = t3.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t12.xy = sqrt(t12.xy);
        t6.xy = abs(t6.xy) * vec2(2.31929994, 2.31929994) + t12.xy;
        t6.xy = t2.xy / t6.xy;
        t2.x = (-t0.x) / t1.x;
        t7.x = t5 + t5;
        t7.x = t0.x / t7.x;
        t7.x = t0.z + t7.x;
        t2.x = t7.x * t2.x;
        t2.x = t2.x * 1.44269502;
        t3.y = exp2(t2.x);
        t3.xz = vec2(1.0, 1.0);
        t6.xy = t6.xy * t3.xy;
        t2.x = t5 * t1.x;
        t2.x = t2.x * 6.28310013;
        t2.x = sqrt(t2.x);
        t12.x = (-t5) + Rg;
        t1.x = t12.x / t1.x;
        t1.x = t1.x * 1.44269502;
        t1.x = exp2(t1.x);
        t1.x = t1.x * t2.x;
        t6.x = dot(t6.xy, vec2(1.0, -1.0));
        t6.x = t6.x + t16;
        t1.x = t6.x * t1.x;
        t6.x = HM * _experimentalAtmoScale;
        t11.x = 0.5 / t6.x;
        t11.x = t5 * t11.x;
        t11.x = sqrt(t11.x);
        t10.xy = t0.zw * t11.xx;
        ti11.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t10.xyxy).xy) * 0xFFFFFFFFu);
        ti2.xw = ivec2(uvec2(lessThan(t10.xxxy, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
        ti11.xy = (-ti11.xy) + ti2.xw;
        t11.xy = vec2(ti11.xy);
        t4.xyz = t10.xxy * t10.xxy;
        tb2 = t11.x<t11.y;
        t17 = t4.x * 1.44269502;
        t17 = exp2(t17);
        t2.x = tb2 ? t17 : float(0.0);
        t3.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t3.xy = sqrt(t3.xy);
        t10.xy = abs(t10.xy) * vec2(2.31929994, 2.31929994) + t3.xy;
        t10.xy = t11.xy / t10.xy;
        t0.x = (-t0.x) / t6.x;
        t0.x = t7.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t3.w = exp2(t0.x);
        t0.xz = t10.xy * t3.zw;
        t5 = t5 * t6.x;
        t5 = t5 * 6.28310013;
        t5 = sqrt(t5);
        t15 = t12.x / t6.x;
        t15 = t15 * 1.44269502;
        t15 = exp2(t15);
        t5 = t15 * t5;
        t0.x = dot(t0.xz, vec2(1.0, -1.0));
        t0.x = t0.x + t2.x;
        t0.x = t0.x * t5;
        t0.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xyz = (-betaR.xyzx.xyz) * t1.xxx + (-t0.xyz);
        t0.xyz = t0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t0.xyz = exp2(t0.xyz);
        t0.xyz = min(t0.xyz, vec3(1.0, 1.0, 1.0));
    } else {
        t0.xyz = vec3(1.0, 1.0, 1.0);
    //ENDIF
    }
    t15 = t0.y + t0.x;
    t15 = t0.z + t15;
    t15 = t15 * 0.333333343;
    t1.x = (-_Post_Extinction_Tint) + 1.0;
    t15 = t15 * t1.x;
    t0.xyz = vec3(vec3(_Post_Extinction_Tint, _Post_Extinction_Tint, _Post_Extinction_Tint)) * t0.xyz + vec3(t15);
    t0.xyz = t0.xyz + vec3(-1.0, -1.0, -1.0);
    SV_Target0.xyz = vec3(postExtinctionMultiplier) * t0.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = 1.0;
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
// Stats: 197 math, 1 textures, 4 branches
Matrix 0 [_ViewProjInv]
Float 6 [HM]
Float 4 [HR]
Float 8 [Rg]
Float 9 [Rt]
Float 12 [_Post_Extinction_Tint]
Vector 11 [_camPos]
Float 10 [_experimentalAtmoScale]
Float 14 [_openglThreshold]
Vector 7 [betaMEx]
Vector 5 [betaR]
Float 13 [postExtinctionMultiplier]
SetTexture 0 [_customDepthTexture] 2D 0
"ps_3_0
def c15, 0.899999976, -9.99999997e-007, 1600, 0.5
def c16, -1, 4, 2, -0
def c17, 6.28310013, 0.333333343, 0, 0
def c18, 1.44269502, 1.51999998, 4, 2.31929994
def c19, 2, 0, -1, 1
dcl_texcoord2 v0.xy
dcl_texcoord3 v1.xyz
dcl_2d s0
texld r0, v0, s0
add r0.y, r0.x, c16.x
dp3 r0.z, v1, v1
dp3 r0.w, v1, c11
add r1.x, r0.w, r0.w
dp3 r1.y, c11, c11
mad r1.z, c8.x, -c8.x, r1.y
mul r1.z, r0.z, r1.z
mul r1.z, r1.z, c16.y
mad r1.x, r1.x, r1.x, -r1.z
rsq r1.z, r1.x
rcp r1.z, r1.z
mad r0.w, r0.w, -c16.z, -r1.z
add r0.z, r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.z, r0.w
cmp r0.z, r1.x, r0.z, c16.x
cmp r0.y, -r0_abs.y, -c16.x, -c16.w
cmp r0.y, -r0.z, r0.y, -c16.w
if_ne r0.y, -r0.y
mov_pp r1.xzw, -c16.x
else
mad r2.xyw, v0.xyzx, c19.xxzy, c19.zzzw
mov r2.z, r0.x
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp4 r0.x, c3, r2
rcp r0.x, r0.x
mul r2.xyz, r0.x, r3
mul r4.xyz, r0.z, v1
mad r5.xyz, r0.z, v1, c11
dp3 r0.y, r4, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r3.xyz, r3, r0.x, -c11
dp3 r0.x, r3, r3
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.x, -r0.x, r0.y
cmp r0.x, r0.x, c16.w, c16.x
cmp r0.x, -r0.z, -c16.w, r0.x
cmp r0.xyz, r0.x, r2, r5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r2.x, r0.w
mov r3.x, c8.x
add r2.y, r3.x, c14.x
add r2.x, -r2.y, r2.x
mul r3.yzw, r0.w, r0.xxyz
mul r2.yzw, r2.y, r3
cmp r0.xyz, r2.x, r0, r2.yzww
add r0.xyz, r0, -c11
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r2.x, r0.w
mul r0.xyz, r0.w, r0
add r0.w, -r3.x, c9.x
mad r4.y, r0.w, c10.x, r3.x
rsq r0.w, r1.y
rcp r5.y, r0.w
mad r0.w, r3.x, -c15.x, r5.y
add r6.x, r3.x, c11.y
mov r6.yz, c11.xxzw
dp3 r1.y, r6, r6
rsq r1.y, r1.y
rcp r6.w, r1.y
mov r5.xzw, c11.yyxz
cmp r5.xy, r0.w, r5, r6.xwzw
dp3 r0.x, r5.zxww, r0
rcp r0.y, r5.y
mul r2.z, r0.y, r0.x
mul r0.y, r5.y, r5.y
mad r0.y, r0.x, r0.x, -r0.y
mad r0.y, r4.y, r4.y, r0.y
rsq r0.z, r0.y
rcp r0.z, r0.z
cmp r0.y, r0.y, -r0.z, c15.y
add r0.y, r0.y, -r0.x
max r1.y, r0.y, -c16.w
add r0.y, -r2.x, r1.y
add r0.x, r0.x, r1.y
rcp r0.z, r4.y
mul r4.z, r0.z, r0.x
add r4.x, -r1.y, r2.x
cmp r0.x, r0.y, c16.w, c16.x
cmp r0.x, -r1.y, -c16.w, r0.x
mov r2.y, r5.y
cmp r0.xyz, r0.x, r2, r4
if_ge r4.y, r0.y
add r1.y, r3.x, c15.z
add r2.x, r0.y, -r1.y
rcp r2.y, r0.y
mul r1.y, r1.y, r2.y
mul r1.y, r0.y, r1.y
cmp r0.y, r2.x, r0.y, r1.y
mov r2.x, c10.x
mul r1.y, r2.x, c4.x
rcp r2.y, r1.y
mul r2.z, r0.y, r2.y
mul r2.z, r2.z, c15.w
rsq r2.z, r2.z
rcp r2.z, r2.z
rcp r2.w, r0.y
mad r0.w, r0.x, r2.w, r0.z
mul r2.zw, r0, r2.z
cmp r3.xy, -r2.zwzw, -c16.w, -c16.x
cmp r3.zw, r2, c16.w, c16.x
add r3.xy, r3.zwzw, r3
mul r4.xyz, r2.zzww, r2.zzww
add r3.z, -r3.y, r3.x
mul r3.w, r4.x, c18.x
exp r3.w, r3.w
cmp r3.z, r3.z, -c16.w, r3.w
mad r4.xy, r4.yzzw, c18.y, c18.z
rsq r3.w, r4.x
rsq r4.x, r4.y
rcp r5.x, r3.w
rcp r5.y, r4.x
mad r2.zw, r2_abs, c18.w, r5.xyxy
rcp r4.x, r2.z
rcp r4.y, r2.w
mul r2.zw, r3.xyxy, r4.xyxy
mul r3.x, -r0.x, r2.y
add r3.y, r0.y, r0.y
rcp r3.y, r3.y
mad r3.y, r0.x, r3.y, r0.z
mul r3.x, r3.y, r3.x
mul r3.x, r3.x, c18.x
exp r4.y, r3.x
mov r4.xz, -c16.x
mul r2.zw, r2, r4.xyxy
mul r1.y, r0.y, r1.y
mul r1.y, r1.y, c17.x
rsq r1.y, r1.y
rcp r1.y, r1.y
add r3.x, -r0.y, c8.x
mul r2.y, r2.y, r3.x
mul r2.y, r2.y, c18.x
exp r2.y, r2.y
mul r1.y, r1.y, r2.y
dp2add r2.y, r2.zwzw, c19.wzzw, r3.z
mul r1.y, r1.y, r2.y
mul r2.x, r2.x, c6.x
rcp r2.y, r2.x
mul r2.z, r0.y, r2.y
mul r2.z, r2.z, c15.w
rsq r2.z, r2.z
rcp r2.z, r2.z
mul r0.zw, r0, r2.z
cmp r2.zw, -r0, -c16.w, -c16.x
cmp r3.zw, r0, c16.w, c16.x
add r2.zw, r2, r3
mul r5.xyz, r0.zzww, r0.zzww
add r3.z, -r2.w, r2.z
mul r3.w, r5.x, c18.x
exp r3.w, r3.w
cmp r3.z, r3.z, -c16.w, r3.w
mad r4.xy, r5.yzzw, c18.y, c18.z
rsq r3.w, r4.x
rsq r4.x, r4.y
rcp r5.x, r3.w
rcp r5.y, r4.x
mad r0.zw, r0_abs, c18.w, r5.xyxy
rcp r4.x, r0.z
rcp r4.y, r0.w
mul r0.zw, r2, r4.xyxy
mul r0.x, -r0.x, r2.y
mul r0.x, r3.y, r0.x
mul r0.x, r0.x, c18.x
exp r4.w, r0.x
mul r0.xz, r0.zyww, r4.zyww
mul r0.y, r0.y, r2.x
mul r0.y, r0.y, c17.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r0.w, r2.y, r3.x
mul r0.w, r0.w, c18.x
exp r0.w, r0.w
mul r0.y, r0.w, r0.y
dp2add r0.x, r0.xzzw, c19.wzzw, r3.z
mul r0.x, r0.x, r0.y
mul r0.xyz, r0.x, c7
mad r0.xyz, -c5, r1.y, -r0
mul r0.xyz, r0, c18.x
exp_sat r2.x, r0.x
exp_sat r2.y, r0.y
exp_sat r2.z, r0.z
else
mov_pp r2.xyz, -c16.x
endif
add r0.x, r2.y, r2.x
add r0.x, r2.z, r0.x
mul r0.x, r0.x, c17.y
lrp r3.xyz, c12.x, r2, r0.x
add r0.xyz, r3, c16.x
mov r2.x, c16.x
mad_pp r1.xzw, c13.x, r0.xyyz, -r2.x
endif
mov_pp oC0.xyz, r1.xzww
mov_pp oC0.w, -c16.x

"
}
SubProgram "d3d11 " {
// Stats: 154 math, 1 textures, 4 branches
SetTexture 0 [_customDepthTexture] 2D 0
ConstBuffer "$Globals" 496
Matrix 256 [_ViewProjInv]
Float 132 [HR]
Vector 144 [betaR] 3
Float 156 [HM]
Vector 176 [betaMEx] 3
Float 196 [Rg]
Float 200 [Rt]
Float 244 [_experimentalAtmoScale]
Vector 368 [_camPos] 3
Float 380 [_Post_Extinction_Tint]
Float 384 [postExtinctionMultiplier]
Float 416 [_openglThreshold]
BindCB  "$Globals" 0
"ps_4_0
root12:abababaa
eefiecedhooobknhbbbhcapjigcnjkfjgddehkakabaaaaaaoibfaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoabeaaaaeaaaaaaadiafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
mcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaa
bhaaaaaaaaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaajccaabaaaabaaaaaaegiccaaaaaaaaaaabhaaaaaaegiccaaaaaaaaaaa
bhaaaaaadcaaaaamecaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaa
bkiacaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaiaeadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaadbaaaaahecaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaalicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaaeaakaabaiaebaaaaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadhaaaaajecaabaaaaaaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaialpckaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadlaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaabpaaaeadbkaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdoaaaaabbfaaaaabdcaaaaapfcaabaaaabaaaaaakgblbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaaaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaadiaaaaaipcaabaaaacaaaaaakgakbaaaabaaaaaaegiocaaa
aaaaaaaabbaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabcaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaaoaaaaahncaabaaa
abaaaaaaagajbaaaacaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
kgakbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaabhaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaajocaabaaaacaaaaaa
agaobaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaabhaaaaaabaaaaaahccaabaaa
acaaaaaajgahbaaaacaaaaaajgahbaaaacaaaaaaelaaaaafdcaabaaaacaaaaaa
egaabaaaacaaaaaadbaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaa
dhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaigadbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajecaabaaaabaaaaaa
bkiacaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaabkaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dhaaaaajhcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaabhaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaelaaaaafbcaabaaaacaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagaabaaaacaaaaaaaaaaaaakicaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaal
ccaabaaaadaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaa
aaaaaaaaamaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
abeaaaaaggggggdpdbaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaajbcaabaaaaeaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaabhaaaaaadgaaaaaggcaabaaaaeaaaaaaagiccaaaaaaaaaaabhaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaf
icaabaaaaeaaaaaackaabaaaabaaaaaadgaaaaagncaabaaaabaaaaaafgiicaaa
aaaaaaaabhaaaaaadhaaaaajdcaabaaaabaaaaaapgapbaaaaaaaaaaamgaabaaa
aeaaaaaaegaabaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaacgalbaaaabaaaaaa
egacbaaaaaaaaaaaaoaaaaahecaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaabkaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
ccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
lndhiglfaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaah
icaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaacaaaaaaabaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahecaabaaaadaaaaaaakaabaaa
aaaaaaaabkaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaacaaaaaadgaaaaafccaabaaaacaaaaaabkaabaaaabaaaaaa
dhaaaaajhcaabaaaaaaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabnaaaaahbcaabaaaabaaaaaabkaabaaaadaaaaaabkaabaaaaaaaaaaa
bpaaaeadakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaa
amaaaaaaabeaaaaaaaaamieedbaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
akaabaaaabaaaaaadhaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaaaaaaaaaaadiaaaaajbcaabaaaabaaaaaabkiacaaaaaaaaaaa
aiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaa
aaaaaadpakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
bkaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaoaaaaah
ecaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaahgcaabaaaabaaaaaa
kgalbaaaaaaaaaaafgafbaaaabaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaajgafbaaaabaaaaaadbaaaaakmcaabaaa
acaaaaaafgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaa
claaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
fgagbaaaabaaaaaafgagbaaaabaaaaaadbaaaaahicaabaaaabaaaaaaakaabaaa
acaaaaaabkaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaaakaabaaaadaaaaaa
abeaaaaadlkklidpbjaaaaafecaabaaaacaaaaaackaabaaaacaaaaaaabaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaadcaaaaapmcaabaaa
acaaaaaafgajbaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaafmipmcdpfmipmcdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaiaeaaaaaiaeaelaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadcaaaaangcaabaaaabaaaaaafgagbaiaibaaaaaaabaaaaaa
aceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaakgalbaaaacaaaaaaaoaaaaah
gcaabaaaabaaaaaaagabbaaaacaaaaaafgagbaaaabaaaaaaaoaaaaaibcaabaaa
acaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaahccaabaaa
acaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahccaabaaaacaaaaaa
akaabaaaaaaaaaaabkaabaaaacaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaa
aaaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaadaaaaaaakaabaaaacaaaaaadgaaaaaifcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaadiaaaaahgcaabaaa
abaaaaaafgagbaaaabaaaaaaagabbaaaadaaaaaadiaaaaahbcaabaaaacaaaaaa
bkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaajecaabaaaacaaaaaabkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaa
amaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaacaaaaaaapaaaaakccaabaaaabaaaaaajgafbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaabkaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaajccaabaaaabaaaaaadkiacaaaaaaaaaaa
ajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahecaabaaaabaaaaaaabeaaaaa
aaaaaadpbkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaaaaaaaaa
ckaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
mcaabaaaaaaaaaaakgaobaaaaaaaaaaakgakbaaaabaaaaaadbaaaaakmcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakgaobaaaaaaaaaaa
dbaaaaakjcaabaaaacaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaimcaabaaaabaaaaaakgaobaiaebaaaaaaabaaaaaa
agambaaaacaaaaaaclaaaaafmcaabaaaabaaaaaakgaobaaaabaaaaaadiaaaaah
hcaabaaaaeaaaaaakgalbaaaaaaaaaaakgalbaaaaaaaaaaadbaaaaahbcaabaaa
acaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaacaaaaaa
akaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaaabaaaaahbcaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaa
dcaaaaapdcaabaaaadaaaaaajgafbaaaaeaaaaaaaceaaaaafmipmcdpfmipmcdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaaelaaaaaf
dcaabaaaadaaaaaaegaabaaaadaaaaaadcaaaaanmcaabaaaaaaaaaaakgaobaia
ibaaaaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaagjgpbeeagjgpbeeaagaebaaa
adaaaaaaaoaaaaahmcaabaaaaaaaaaaakgaobaaaabaaaaaakgaobaaaaaaaaaaa
aoaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
adaaaaaaakaabaaaaaaaaaaadiaaaaahfcaabaaaaaaaaaaakgalbaaaaaaaaaaa
kgalbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
abaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaciapmjea
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaa
ckaabaaaacaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaaapaaaaak
bcaabaaaaaaaaaaaigaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaam
hcaabaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaaagaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaabjaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaddaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaabcaaaaabdgaaaaaihcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabfaaaaabaaaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaklkkkkdoaaaaaaajbcaabaaaabaaaaaadkiacaiaebaaaaaa
aaaaaaaabhaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaa
bhaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadcaaaaan
hccabaaaaaaaaaaaagiacaaaaaaaaaaabiaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
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
 //       d3d11 : 20 math
 //        d3d9 : 24 math
 //        gles : 510 avg math (503..517), 9 avg texture (9..10), 17 avg branch (17..18)
 //      opengl : 510 avg math (503..517), 9 avg texture (9..10), 17 avg branch (17..18)
 // Stats for Fragment shader:
 //       d3d11 : 348 avg math (340..357), 1 avg texture (1..2), 4 branch
 //        d3d9 : 446 avg math (439..453), 17 avg texture (17..18), 4 branch
 Pass {
  Tags { "QUEUE"="Transparent-5" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Front
  Blend OneMinusDstColor One
  GpuProgramID 72055
Program "vp" {
SubProgram "opengl " {
// Stats: 503 math, 9 textures, 17 branches
Keywords { "GODRAYS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec2 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
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
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform float _experimentalAtmoScale;
uniform mat4 _ViewProjInv;
uniform float _global_alpha;
uniform float _global_depth;
uniform vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform float _openglThreshold;
float xlat_mutableRt;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  bool tmpvar_3;
  tmpvar_3 = (tmpvar_2.x == 1.0);
  vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_4.z = tmpvar_2.x;
  vec4 tmpvar_5;
  tmpvar_5 = (_ViewProjInv * tmpvar_4);
  vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 / tmpvar_5.w).xyz;
  float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  float tmpvar_8;
  tmpvar_8 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  float tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_8) - ((4.0 * tmpvar_7) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  float tmpvar_10;
  if ((tmpvar_9 < 0.0)) {
    tmpvar_10 = -1.0;
  } else {
    tmpvar_10 = ((-(tmpvar_8) - sqrt(tmpvar_9)) / (2.0 * tmpvar_7));
  };
  bool tmpvar_11;
  tmpvar_11 = (tmpvar_10 > 0.0);
  if ((!(tmpvar_11) && tmpvar_3)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_12;
    tmpvar_12 = (_camPos + (tmpvar_10 * xlv_TEXCOORD3));
    vec3 x_13;
    x_13 = (tmpvar_12 - _camPos);
    vec3 x_14;
    x_14 = (tmpvar_6 - _camPos);
    bool tmpvar_15;
    tmpvar_15 = (sqrt(dot (x_13, x_13)) < sqrt(dot (x_14, x_14)));
    vec3 tmpvar_16;
    if ((tmpvar_11 && tmpvar_15)) {
      tmpvar_16 = tmpvar_12;
    } else {
      tmpvar_16 = tmpvar_6;
    };
    float tmpvar_17;
    tmpvar_17 = sqrt(dot (tmpvar_16, tmpvar_16));
    vec3 tmpvar_18;
    if ((tmpvar_17 < (Rg + _openglThreshold))) {
      tmpvar_18 = ((Rg + _openglThreshold) * normalize(tmpvar_16));
    } else {
      tmpvar_18 = tmpvar_16;
    };
    vec3 tmpvar_19;
    vec3 camera_20;
    camera_20 = _camPos;
    vec3 _point_21;
    _point_21 = tmpvar_18;
    float mu_22;
    float rMu_23;
    float r_24;
    float d_25;
    vec3 viewdir_26;
    vec3 result_27;
    result_27 = vec3(0.0, 0.0, 0.0);
    vec3 tmpvar_28;
    tmpvar_28 = (tmpvar_18 - _camPos);
    float tmpvar_29;
    tmpvar_29 = sqrt(dot (tmpvar_28, tmpvar_28));
    d_25 = tmpvar_29;
    viewdir_26 = (tmpvar_28 / tmpvar_29);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_30;
    tmpvar_30 = normalize(viewdir_26);
    viewdir_26 = tmpvar_30;
    float tmpvar_31;
    tmpvar_31 = sqrt(dot (_camPos, _camPos));
    r_24 = tmpvar_31;
    if ((tmpvar_31 < (0.9 * Rg))) {
      camera_20.y = (_camPos.y + Rg);
      _point_21.y = (tmpvar_18.y + Rg);
      r_24 = sqrt(dot (camera_20, camera_20));
    };
    float tmpvar_32;
    tmpvar_32 = dot (camera_20, tmpvar_30);
    rMu_23 = tmpvar_32;
    mu_22 = (tmpvar_32 / r_24);
    _point_21 = (_point_21 - (tmpvar_30 * clamp (1.0, 0.0, tmpvar_29)));
    float f_33;
    f_33 = (((tmpvar_32 * tmpvar_32) - (r_24 * r_24)) + (xlat_mutableRt * xlat_mutableRt));
    float tmpvar_34;
    if ((f_33 >= 0.0)) {
      tmpvar_34 = sqrt(f_33);
    } else {
      tmpvar_34 = 1e-06;
    };
    float tmpvar_35;
    tmpvar_35 = max ((-(tmpvar_32) - tmpvar_34), 0.0);
    if (((tmpvar_35 > 0.0) && (tmpvar_35 < tmpvar_29))) {
      camera_20 = (camera_20 + (tmpvar_35 * tmpvar_30));
      rMu_23 = (tmpvar_32 + tmpvar_35);
      mu_22 = (rMu_23 / xlat_mutableRt);
      r_24 = xlat_mutableRt;
      d_25 = (tmpvar_29 - tmpvar_35);
    };
    if ((r_24 <= xlat_mutableRt)) {
      vec4 inScatter_36;
      float tmpvar_37;
      tmpvar_37 = dot (tmpvar_30, SUN_DIR);
      float tmpvar_38;
      tmpvar_38 = (dot (camera_20, SUN_DIR) / r_24);
      if ((r_24 < (Rg + 1600.0))) {
        float tmpvar_39;
        tmpvar_39 = ((Rg + 1600.0) / r_24);
        r_24 = (r_24 * tmpvar_39);
        rMu_23 = (rMu_23 * tmpvar_39);
        _point_21 = (_point_21 * tmpvar_39);
      };
      float tmpvar_40;
      tmpvar_40 = sqrt(dot (_point_21, _point_21));
      float tmpvar_41;
      tmpvar_41 = (dot (_point_21, tmpvar_30) / tmpvar_40);
      float tmpvar_42;
      tmpvar_42 = (dot (_point_21, SUN_DIR) / tmpvar_40);
      float tmpvar_43;
      float H_44;
      H_44 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_45;
      tmpvar_45.x = mu_22;
      tmpvar_45.y = (mu_22 + (d_25 / r_24));
      vec2 tmpvar_46;
      tmpvar_46 = (sqrt((
        (0.5 / H_44)
       * r_24)) * tmpvar_45);
      vec2 tmpvar_47;
      tmpvar_47 = sign(tmpvar_46);
      vec2 tmpvar_48;
      tmpvar_48 = (tmpvar_46 * tmpvar_46);
      float tmpvar_49;
      if ((tmpvar_47.y > tmpvar_47.x)) {
        tmpvar_49 = exp(tmpvar_48.x);
      } else {
        tmpvar_49 = 0.0;
      };
      vec2 tmpvar_50;
      tmpvar_50.x = 1.0;
      tmpvar_50.y = exp(((
        -(d_25)
       / H_44) * (
        (d_25 / (2.0 * r_24))
       + mu_22)));
      tmpvar_43 = ((sqrt(
        ((6.2831 * H_44) * r_24)
      ) * exp(
        ((Rg - r_24) / H_44)
      )) * (tmpvar_49 + dot (
        ((tmpvar_47 / ((2.3193 * 
          abs(tmpvar_46)
        ) + sqrt(
          ((1.52 * tmpvar_48) + 4.0)
        ))) * tmpvar_50)
      , vec2(1.0, -1.0))));
      float H_51;
      H_51 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_52;
      tmpvar_52.x = mu_22;
      tmpvar_52.y = (mu_22 + (d_25 / r_24));
      vec2 tmpvar_53;
      tmpvar_53 = (sqrt((
        (0.5 / H_51)
       * r_24)) * tmpvar_52);
      vec2 tmpvar_54;
      tmpvar_54 = sign(tmpvar_53);
      vec2 tmpvar_55;
      tmpvar_55 = (tmpvar_53 * tmpvar_53);
      float tmpvar_56;
      if ((tmpvar_54.y > tmpvar_54.x)) {
        tmpvar_56 = exp(tmpvar_55.x);
      } else {
        tmpvar_56 = 0.0;
      };
      vec2 tmpvar_57;
      tmpvar_57.x = 1.0;
      tmpvar_57.y = exp(((
        -(d_25)
       / H_51) * (
        (d_25 / (2.0 * r_24))
       + mu_22)));
      vec3 tmpvar_58;
      tmpvar_58 = min (exp((
        (-(betaR) * tmpvar_43)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_51) * r_24)
        ) * exp(
          ((Rg - r_24) / H_51)
        )) * (tmpvar_56 + dot (
          ((tmpvar_54 / ((2.3193 * 
            abs(tmpvar_53)
          ) + sqrt(
            ((1.52 * tmpvar_55) + 4.0)
          ))) * tmpvar_57)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
      vec4 tmpvar_59;
      float _lerp_60;
      float tmpvar_61;
      float tmpvar_62;
      tmpvar_62 = (Rg * Rg);
      tmpvar_61 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_62));
      float tmpvar_63;
      tmpvar_63 = sqrt(((r_24 * r_24) - tmpvar_62));
      float tmpvar_64;
      tmpvar_64 = (r_24 * mu_22);
      float tmpvar_65;
      tmpvar_65 = (((tmpvar_64 * tmpvar_64) - (r_24 * r_24)) + tmpvar_62);
      vec4 tmpvar_66;
      if (((tmpvar_64 < 0.0) && (tmpvar_65 > 0.0))) {
        vec4 tmpvar_67;
        tmpvar_67.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_67.w = (0.5 - (0.5 / RES_MU));
        tmpvar_66 = tmpvar_67;
      } else {
        vec4 tmpvar_68;
        tmpvar_68.x = -1.0;
        tmpvar_68.y = (tmpvar_61 * tmpvar_61);
        tmpvar_68.z = tmpvar_61;
        tmpvar_68.w = (0.5 + (0.5 / RES_MU));
        tmpvar_66 = tmpvar_68;
      };
      float tmpvar_69;
      tmpvar_69 = ((0.5 / RES_R) + ((tmpvar_63 / tmpvar_61) * (1.0 - 
        (1.0/(RES_R))
      )));
      float tmpvar_70;
      tmpvar_70 = (tmpvar_66.w + ((
        ((tmpvar_64 * tmpvar_66.x) + sqrt((tmpvar_65 + tmpvar_66.y)))
       / 
        (tmpvar_63 + tmpvar_66.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      float y_over_x_71;
      y_over_x_71 = (max (tmpvar_38, -0.1975) * 5.349625);
      float tmpvar_72;
      tmpvar_72 = (min (abs(y_over_x_71), 1.0) / max (abs(y_over_x_71), 1.0));
      float tmpvar_73;
      tmpvar_73 = (tmpvar_72 * tmpvar_72);
      tmpvar_73 = (((
        ((((
          ((((-0.01213232 * tmpvar_73) + 0.05368138) * tmpvar_73) - 0.1173503)
         * tmpvar_73) + 0.1938925) * tmpvar_73) - 0.3326756)
       * tmpvar_73) + 0.9999793) * tmpvar_72);
      tmpvar_73 = (tmpvar_73 + (float(
        (abs(y_over_x_71) > 1.0)
      ) * (
        (tmpvar_73 * -2.0)
       + 1.570796)));
      float tmpvar_74;
      tmpvar_74 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_73 * sign(y_over_x_71)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      float tmpvar_75;
      tmpvar_75 = (((tmpvar_37 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_76;
      tmpvar_76 = floor(tmpvar_75);
      _lerp_60 = (tmpvar_75 - tmpvar_76);
      float tmpvar_77;
      tmpvar_77 = (floor((
        (tmpvar_69 * RES_R)
       - 1.0)) / RES_R);
      float tmpvar_78;
      tmpvar_78 = (floor((tmpvar_69 * RES_R)) / RES_R);
      float tmpvar_79;
      tmpvar_79 = fract((tmpvar_69 * RES_R));
      vec4 tmpvar_80;
      tmpvar_80.zw = vec2(0.0, 0.0);
      tmpvar_80.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
      tmpvar_80.y = ((tmpvar_70 / RES_R) + tmpvar_77);
      vec4 tmpvar_81;
      tmpvar_81.zw = vec2(0.0, 0.0);
      tmpvar_81.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
      tmpvar_81.y = ((tmpvar_70 / RES_R) + tmpvar_77);
      vec4 tmpvar_82;
      tmpvar_82.zw = vec2(0.0, 0.0);
      tmpvar_82.x = ((tmpvar_76 + tmpvar_74) / RES_NU);
      tmpvar_82.y = ((tmpvar_70 / RES_R) + tmpvar_78);
      vec4 tmpvar_83;
      tmpvar_83.zw = vec2(0.0, 0.0);
      tmpvar_83.x = (((tmpvar_76 + tmpvar_74) + 1.0) / RES_NU);
      tmpvar_83.y = ((tmpvar_70 / RES_R) + tmpvar_78);
      tmpvar_59 = (((
        (texture2DLod (_Inscatter, tmpvar_80.xy, 0.0) * (1.0 - _lerp_60))
       + 
        (texture2DLod (_Inscatter, tmpvar_81.xy, 0.0) * _lerp_60)
      ) * (1.0 - tmpvar_79)) + ((
        (texture2DLod (_Inscatter, tmpvar_82.xy, 0.0) * (1.0 - _lerp_60))
       + 
        (texture2DLod (_Inscatter, tmpvar_83.xy, 0.0) * _lerp_60)
      ) * tmpvar_79));
      float _lerp_84;
      float tmpvar_85;
      float tmpvar_86;
      tmpvar_86 = (Rg * Rg);
      tmpvar_85 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_86));
      float tmpvar_87;
      tmpvar_87 = sqrt(((tmpvar_40 * tmpvar_40) - tmpvar_86));
      float tmpvar_88;
      tmpvar_88 = (tmpvar_40 * tmpvar_41);
      float tmpvar_89;
      tmpvar_89 = (((tmpvar_88 * tmpvar_88) - (tmpvar_40 * tmpvar_40)) + tmpvar_86);
      vec4 tmpvar_90;
      if (((tmpvar_88 < 0.0) && (tmpvar_89 > 0.0))) {
        vec4 tmpvar_91;
        tmpvar_91.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_91.w = (0.5 - (0.5 / RES_MU));
        tmpvar_90 = tmpvar_91;
      } else {
        vec4 tmpvar_92;
        tmpvar_92.x = -1.0;
        tmpvar_92.y = (tmpvar_85 * tmpvar_85);
        tmpvar_92.z = tmpvar_85;
        tmpvar_92.w = (0.5 + (0.5 / RES_MU));
        tmpvar_90 = tmpvar_92;
      };
      float tmpvar_93;
      tmpvar_93 = ((0.5 / RES_R) + ((tmpvar_87 / tmpvar_85) * (1.0 - 
        (1.0/(RES_R))
      )));
      float tmpvar_94;
      tmpvar_94 = (tmpvar_90.w + ((
        ((tmpvar_88 * tmpvar_90.x) + sqrt((tmpvar_89 + tmpvar_90.y)))
       / 
        (tmpvar_87 + tmpvar_90.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      float y_over_x_95;
      y_over_x_95 = (max (tmpvar_42, -0.1975) * 5.349625);
      float tmpvar_96;
      tmpvar_96 = (min (abs(y_over_x_95), 1.0) / max (abs(y_over_x_95), 1.0));
      float tmpvar_97;
      tmpvar_97 = (tmpvar_96 * tmpvar_96);
      tmpvar_97 = (((
        ((((
          ((((-0.01213232 * tmpvar_97) + 0.05368138) * tmpvar_97) - 0.1173503)
         * tmpvar_97) + 0.1938925) * tmpvar_97) - 0.3326756)
       * tmpvar_97) + 0.9999793) * tmpvar_96);
      tmpvar_97 = (tmpvar_97 + (float(
        (abs(y_over_x_95) > 1.0)
      ) * (
        (tmpvar_97 * -2.0)
       + 1.570796)));
      float tmpvar_98;
      tmpvar_98 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_97 * sign(y_over_x_95)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      float tmpvar_99;
      tmpvar_99 = (((tmpvar_37 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_100;
      tmpvar_100 = floor(tmpvar_99);
      _lerp_84 = (tmpvar_99 - tmpvar_100);
      float tmpvar_101;
      tmpvar_101 = (floor((
        (tmpvar_93 * RES_R)
       - 1.0)) / RES_R);
      float tmpvar_102;
      tmpvar_102 = (floor((tmpvar_93 * RES_R)) / RES_R);
      float tmpvar_103;
      tmpvar_103 = fract((tmpvar_93 * RES_R));
      vec4 tmpvar_104;
      tmpvar_104.zw = vec2(0.0, 0.0);
      tmpvar_104.x = ((tmpvar_100 + tmpvar_98) / RES_NU);
      tmpvar_104.y = ((tmpvar_94 / RES_R) + tmpvar_101);
      vec4 tmpvar_105;
      tmpvar_105.zw = vec2(0.0, 0.0);
      tmpvar_105.x = (((tmpvar_100 + tmpvar_98) + 1.0) / RES_NU);
      tmpvar_105.y = ((tmpvar_94 / RES_R) + tmpvar_101);
      vec4 tmpvar_106;
      tmpvar_106.zw = vec2(0.0, 0.0);
      tmpvar_106.x = ((tmpvar_100 + tmpvar_98) / RES_NU);
      tmpvar_106.y = ((tmpvar_94 / RES_R) + tmpvar_102);
      vec4 tmpvar_107;
      tmpvar_107.zw = vec2(0.0, 0.0);
      tmpvar_107.x = (((tmpvar_100 + tmpvar_98) + 1.0) / RES_NU);
      tmpvar_107.y = ((tmpvar_94 / RES_R) + tmpvar_102);
      vec4 tmpvar_108;
      tmpvar_108 = max ((tmpvar_59 - (
        ((((texture2DLod (_Inscatter, tmpvar_104.xy, 0.0) * 
          (1.0 - _lerp_84)
        ) + (texture2DLod (_Inscatter, tmpvar_105.xy, 0.0) * _lerp_84)) * (1.0 - tmpvar_103)) + (((texture2DLod (_Inscatter, tmpvar_106.xy, 0.0) * 
          (1.0 - _lerp_84)
        ) + (texture2DLod (_Inscatter, tmpvar_107.xy, 0.0) * _lerp_84)) * tmpvar_103))
       * tmpvar_58.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      inScatter_36.xyz = tmpvar_108.xyz;
      float tmpvar_109;
      tmpvar_109 = clamp ((tmpvar_38 / 0.02), 0.0, 1.0);
      inScatter_36.w = (tmpvar_108.w * (tmpvar_109 * (tmpvar_109 * 
        (3.0 - (2.0 * tmpvar_109))
      )));
      float tmpvar_110;
      tmpvar_110 = (mieG * mieG);
      result_27 = ((tmpvar_108.xyz * (
        (3.0 / (16.0 * M_PI))
       * 
        (1.0 + (tmpvar_37 * tmpvar_37))
      )) + ((
        ((tmpvar_108.xyz * inScatter_36.w) / max (tmpvar_108.x, 0.0001))
       * 
        (betaR.x / betaR)
      ) * (
        ((((1.5 / 
          (4.0 * M_PI)
        ) * (1.0 - tmpvar_110)) * pow ((
          (1.0 + tmpvar_110)
         - 
          ((2.0 * mieG) * tmpvar_37)
        ), -1.5)) * (1.0 + (tmpvar_37 * tmpvar_37)))
       / 
        (2.0 + tmpvar_110)
      )));
    } else {
      result_27 = vec3(0.0, 0.0, 0.0);
    };
    tmpvar_19 = (result_27 * SUN_INTENSITY);
    float tmpvar_111;
    vec3 x_112;
    x_112 = (tmpvar_18 - _camPos);
    tmpvar_111 = sqrt(dot (x_112, x_112));
    float tmpvar_113;
    if ((tmpvar_111 <= _global_depth)) {
      tmpvar_113 = (1.0 - exp(-(
        ((4.0 * tmpvar_111) / _global_depth)
      )));
    } else {
      tmpvar_113 = 1.0;
    };
    vec3 L_114;
    L_114 = (tmpvar_19 * _Exposure);
    float tmpvar_115;
    if ((L_114.x < 1.413)) {
      tmpvar_115 = pow ((L_114.x * 0.38317), 0.4545454);
    } else {
      tmpvar_115 = (1.0 - exp(-(L_114.x)));
    };
    L_114.x = tmpvar_115;
    float tmpvar_116;
    if ((L_114.y < 1.413)) {
      tmpvar_116 = pow ((L_114.y * 0.38317), 0.4545454);
    } else {
      tmpvar_116 = (1.0 - exp(-(L_114.y)));
    };
    L_114.y = tmpvar_116;
    float tmpvar_117;
    if ((L_114.z < 1.413)) {
      tmpvar_117 = pow ((L_114.z * 0.38317), 0.4545454);
    } else {
      tmpvar_117 = (1.0 - exp(-(L_114.z)));
    };
    L_114.z = tmpvar_117;
    vec4 tmpvar_118;
    tmpvar_118.w = 1.0;
    tmpvar_118.xyz = ((L_114 * _global_alpha) * tmpvar_113);
    tmpvar_1 = tmpvar_118;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "GODRAYS_OFF" }
Bind "vertex" Vertex
Matrix 7 [_Object2World] 3
Matrix 4 [glstate_matrix_modelview0] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_TexelSize]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
"vs_3_0
def c14, 0.5, 0, -2, 1
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xy
dcl_texcoord2 o3.xy
dcl_texcoord3 o4.xyz
dp4 o0.z, c2, v0
dp4 r0.x, c6, v0
mov o1.z, -r0.x
dp4 r0.x, c7, v0
dp4 r0.y, c8, v0
dp4 r0.z, c9, v0
add o4.xyz, r0, -c10
dp4 r0.x, c0, v0
dp4 r0.y, c1, v0
dp4 r0.w, c3, v0
mov o0.xyw, r0
mul r1.xz, r0.xyww, c14.x
mul r0.x, r0.y, c11.x
mul r1.w, r0.x, c14.x
mad r0.xy, r1.z, c12.zwzw, r1.xwzw
rcp r0.z, r0.w
mul r1.xy, r0.z, r0
mov o1.xyw, r0
mad r0.x, r1.y, c14.z, c14.w
mov r0.y, c14.y
slt r0.y, c13.y, r0.y
mad r1.z, r0.y, r0.x, r1.y
mov o2.xy, r1.xzzw
mov o3.xy, r1

"
}
SubProgram "d3d11 " {
// Stats: 20 math
Keywords { "GODRAYS_OFF" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 480
Vector 384 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedhdhfoppakaalmddiagnpnbmggbfobaobabaaaaaapmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaeaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcleadaaaaeaaaabaaonaaaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaa
aaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaa
egambaaaaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabiaaaaaaabeaaaaa
aaaaaaaadhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 503 math, 9 textures, 17 branches
Keywords { "GODRAYS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_texture2DLodEXT(lowp sampler2D sampler, highp vec2 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return texture2DLodEXT(sampler, coord, lod);
#else
	return texture2D(sampler, coord, lod);
#endif
}

uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp float _experimentalAtmoScale;
uniform highp mat4 _ViewProjInv;
uniform highp float _global_alpha;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform highp float _openglThreshold;
highp float xlat_mutableRt;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  mediump vec4 tmpvar_1;
  highp float depth_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_2 = tmpvar_3;
  bool tmpvar_4;
  tmpvar_4 = (depth_2 == 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_5.z = depth_2;
  highp vec4 tmpvar_6;
  tmpvar_6 = (_ViewProjInv * tmpvar_5);
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 / tmpvar_6.w).xyz;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  highp float tmpvar_9;
  tmpvar_9 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  highp float tmpvar_10;
  tmpvar_10 = ((tmpvar_9 * tmpvar_9) - ((4.0 * tmpvar_8) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_11;
  if ((tmpvar_10 < 0.0)) {
    tmpvar_11 = -1.0;
  } else {
    tmpvar_11 = ((-(tmpvar_9) - sqrt(tmpvar_10)) / (2.0 * tmpvar_8));
  };
  bool tmpvar_12;
  tmpvar_12 = (tmpvar_11 > 0.0);
  if ((!(tmpvar_12) && tmpvar_4)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_13;
    tmpvar_13 = (_camPos + (tmpvar_11 * xlv_TEXCOORD3));
    highp vec3 x_14;
    x_14 = (tmpvar_13 - _camPos);
    highp vec3 x_15;
    x_15 = (tmpvar_7 - _camPos);
    bool tmpvar_16;
    tmpvar_16 = (sqrt(dot (x_14, x_14)) < sqrt(dot (x_15, x_15)));
    highp vec3 tmpvar_17;
    if ((tmpvar_12 && tmpvar_16)) {
      tmpvar_17 = tmpvar_13;
    } else {
      tmpvar_17 = tmpvar_7;
    };
    highp float tmpvar_18;
    tmpvar_18 = sqrt(dot (tmpvar_17, tmpvar_17));
    highp vec3 tmpvar_19;
    if ((tmpvar_18 < (Rg + _openglThreshold))) {
      tmpvar_19 = ((Rg + _openglThreshold) * normalize(tmpvar_17));
    } else {
      tmpvar_19 = tmpvar_17;
    };
    highp vec3 tmpvar_20;
    highp vec3 camera_21;
    camera_21 = _camPos;
    highp vec3 _point_22;
    _point_22 = tmpvar_19;
    highp float mu_23;
    highp float rMu_24;
    highp float r_25;
    highp float d_26;
    highp vec3 viewdir_27;
    highp vec3 result_28;
    result_28 = vec3(0.0, 0.0, 0.0);
    highp vec3 tmpvar_29;
    tmpvar_29 = (tmpvar_19 - _camPos);
    highp float tmpvar_30;
    tmpvar_30 = sqrt(dot (tmpvar_29, tmpvar_29));
    d_26 = tmpvar_30;
    viewdir_27 = (tmpvar_29 / tmpvar_30);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_31;
    tmpvar_31 = normalize(viewdir_27);
    viewdir_27 = tmpvar_31;
    highp float tmpvar_32;
    tmpvar_32 = sqrt(dot (_camPos, _camPos));
    r_25 = tmpvar_32;
    if ((tmpvar_32 < (0.9 * Rg))) {
      camera_21.y = (_camPos.y + Rg);
      _point_22.y = (tmpvar_19.y + Rg);
      r_25 = sqrt(dot (camera_21, camera_21));
    };
    highp float tmpvar_33;
    tmpvar_33 = dot (camera_21, tmpvar_31);
    rMu_24 = tmpvar_33;
    mu_23 = (tmpvar_33 / r_25);
    _point_22 = (_point_22 - (tmpvar_31 * clamp (1.0, 0.0, tmpvar_30)));
    highp float f_34;
    f_34 = (((tmpvar_33 * tmpvar_33) - (r_25 * r_25)) + (xlat_mutableRt * xlat_mutableRt));
    highp float tmpvar_35;
    if ((f_34 >= 0.0)) {
      tmpvar_35 = sqrt(f_34);
    } else {
      tmpvar_35 = 1e-06;
    };
    highp float tmpvar_36;
    tmpvar_36 = max ((-(tmpvar_33) - tmpvar_35), 0.0);
    if (((tmpvar_36 > 0.0) && (tmpvar_36 < tmpvar_30))) {
      camera_21 = (camera_21 + (tmpvar_36 * tmpvar_31));
      rMu_24 = (tmpvar_33 + tmpvar_36);
      mu_23 = (rMu_24 / xlat_mutableRt);
      r_25 = xlat_mutableRt;
      d_26 = (tmpvar_30 - tmpvar_36);
    };
    if ((r_25 <= xlat_mutableRt)) {
      highp vec4 inScatter_37;
      highp float tmpvar_38;
      tmpvar_38 = dot (tmpvar_31, SUN_DIR);
      highp float tmpvar_39;
      tmpvar_39 = (dot (camera_21, SUN_DIR) / r_25);
      if ((r_25 < (Rg + 1600.0))) {
        highp float tmpvar_40;
        tmpvar_40 = ((Rg + 1600.0) / r_25);
        r_25 = (r_25 * tmpvar_40);
        rMu_24 = (rMu_24 * tmpvar_40);
        _point_22 = (_point_22 * tmpvar_40);
      };
      highp float tmpvar_41;
      tmpvar_41 = sqrt(dot (_point_22, _point_22));
      highp float tmpvar_42;
      tmpvar_42 = (dot (_point_22, tmpvar_31) / tmpvar_41);
      highp float tmpvar_43;
      tmpvar_43 = (dot (_point_22, SUN_DIR) / tmpvar_41);
      highp float tmpvar_44;
      highp float H_45;
      H_45 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_46;
      tmpvar_46.x = mu_23;
      tmpvar_46.y = (mu_23 + (d_26 / r_25));
      highp vec2 tmpvar_47;
      tmpvar_47 = (sqrt((
        (0.5 / H_45)
       * r_25)) * tmpvar_46);
      highp vec2 tmpvar_48;
      tmpvar_48 = sign(tmpvar_47);
      highp vec2 tmpvar_49;
      tmpvar_49 = (tmpvar_47 * tmpvar_47);
      highp float tmpvar_50;
      if ((tmpvar_48.y > tmpvar_48.x)) {
        tmpvar_50 = exp(tmpvar_49.x);
      } else {
        tmpvar_50 = 0.0;
      };
      highp vec2 tmpvar_51;
      tmpvar_51.x = 1.0;
      tmpvar_51.y = exp(((
        -(d_26)
       / H_45) * (
        (d_26 / (2.0 * r_25))
       + mu_23)));
      tmpvar_44 = ((sqrt(
        ((6.2831 * H_45) * r_25)
      ) * exp(
        ((Rg - r_25) / H_45)
      )) * (tmpvar_50 + dot (
        ((tmpvar_48 / ((2.3193 * 
          abs(tmpvar_47)
        ) + sqrt(
          ((1.52 * tmpvar_49) + 4.0)
        ))) * tmpvar_51)
      , vec2(1.0, -1.0))));
      highp float H_52;
      H_52 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_53;
      tmpvar_53.x = mu_23;
      tmpvar_53.y = (mu_23 + (d_26 / r_25));
      highp vec2 tmpvar_54;
      tmpvar_54 = (sqrt((
        (0.5 / H_52)
       * r_25)) * tmpvar_53);
      highp vec2 tmpvar_55;
      tmpvar_55 = sign(tmpvar_54);
      highp vec2 tmpvar_56;
      tmpvar_56 = (tmpvar_54 * tmpvar_54);
      highp float tmpvar_57;
      if ((tmpvar_55.y > tmpvar_55.x)) {
        tmpvar_57 = exp(tmpvar_56.x);
      } else {
        tmpvar_57 = 0.0;
      };
      highp vec2 tmpvar_58;
      tmpvar_58.x = 1.0;
      tmpvar_58.y = exp(((
        -(d_26)
       / H_52) * (
        (d_26 / (2.0 * r_25))
       + mu_23)));
      highp vec3 tmpvar_59;
      tmpvar_59 = min (exp((
        (-(betaR) * tmpvar_44)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_52) * r_25)
        ) * exp(
          ((Rg - r_25) / H_52)
        )) * (tmpvar_57 + dot (
          ((tmpvar_55 / ((2.3193 * 
            abs(tmpvar_54)
          ) + sqrt(
            ((1.52 * tmpvar_56) + 4.0)
          ))) * tmpvar_58)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
      highp vec4 tmpvar_60;
      highp float _lerp_61;
      highp float tmpvar_62;
      highp float tmpvar_63;
      tmpvar_63 = (Rg * Rg);
      tmpvar_62 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_63));
      highp float tmpvar_64;
      tmpvar_64 = sqrt(((r_25 * r_25) - tmpvar_63));
      highp float tmpvar_65;
      tmpvar_65 = (r_25 * mu_23);
      highp float tmpvar_66;
      tmpvar_66 = (((tmpvar_65 * tmpvar_65) - (r_25 * r_25)) + tmpvar_63);
      highp vec4 tmpvar_67;
      if (((tmpvar_65 < 0.0) && (tmpvar_66 > 0.0))) {
        highp vec4 tmpvar_68;
        tmpvar_68.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_68.w = (0.5 - (0.5 / RES_MU));
        tmpvar_67 = tmpvar_68;
      } else {
        highp vec4 tmpvar_69;
        tmpvar_69.x = -1.0;
        tmpvar_69.y = (tmpvar_62 * tmpvar_62);
        tmpvar_69.z = tmpvar_62;
        tmpvar_69.w = (0.5 + (0.5 / RES_MU));
        tmpvar_67 = tmpvar_69;
      };
      highp float tmpvar_70;
      tmpvar_70 = ((0.5 / RES_R) + ((tmpvar_64 / tmpvar_62) * (1.0 - 
        (1.0/(RES_R))
      )));
      highp float tmpvar_71;
      tmpvar_71 = (tmpvar_67.w + ((
        ((tmpvar_65 * tmpvar_67.x) + sqrt((tmpvar_66 + tmpvar_67.y)))
       / 
        (tmpvar_64 + tmpvar_67.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      highp float y_over_x_72;
      y_over_x_72 = (max (tmpvar_39, -0.1975) * 5.349625);
      highp float tmpvar_73;
      tmpvar_73 = (min (abs(y_over_x_72), 1.0) / max (abs(y_over_x_72), 1.0));
      highp float tmpvar_74;
      tmpvar_74 = (tmpvar_73 * tmpvar_73);
      tmpvar_74 = (((
        ((((
          ((((-0.01213232 * tmpvar_74) + 0.05368138) * tmpvar_74) - 0.1173503)
         * tmpvar_74) + 0.1938925) * tmpvar_74) - 0.3326756)
       * tmpvar_74) + 0.9999793) * tmpvar_73);
      tmpvar_74 = (tmpvar_74 + (float(
        (abs(y_over_x_72) > 1.0)
      ) * (
        (tmpvar_74 * -2.0)
       + 1.570796)));
      highp float tmpvar_75;
      tmpvar_75 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_74 * sign(y_over_x_72)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      highp float tmpvar_76;
      tmpvar_76 = (((tmpvar_38 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_77;
      tmpvar_77 = floor(tmpvar_76);
      _lerp_61 = (tmpvar_76 - tmpvar_77);
      highp float tmpvar_78;
      tmpvar_78 = (floor((
        (tmpvar_70 * RES_R)
       - 1.0)) / RES_R);
      highp float tmpvar_79;
      tmpvar_79 = (floor((tmpvar_70 * RES_R)) / RES_R);
      highp float tmpvar_80;
      tmpvar_80 = fract((tmpvar_70 * RES_R));
      highp vec4 tmpvar_81;
      tmpvar_81.zw = vec2(0.0, 0.0);
      tmpvar_81.x = ((tmpvar_77 + tmpvar_75) / RES_NU);
      tmpvar_81.y = ((tmpvar_71 / RES_R) + tmpvar_78);
      lowp vec4 tmpvar_82;
      tmpvar_82 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_81.xy, 0.0);
      highp vec4 tmpvar_83;
      tmpvar_83.zw = vec2(0.0, 0.0);
      tmpvar_83.x = (((tmpvar_77 + tmpvar_75) + 1.0) / RES_NU);
      tmpvar_83.y = ((tmpvar_71 / RES_R) + tmpvar_78);
      lowp vec4 tmpvar_84;
      tmpvar_84 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_83.xy, 0.0);
      highp vec4 tmpvar_85;
      tmpvar_85.zw = vec2(0.0, 0.0);
      tmpvar_85.x = ((tmpvar_77 + tmpvar_75) / RES_NU);
      tmpvar_85.y = ((tmpvar_71 / RES_R) + tmpvar_79);
      lowp vec4 tmpvar_86;
      tmpvar_86 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_85.xy, 0.0);
      highp vec4 tmpvar_87;
      tmpvar_87.zw = vec2(0.0, 0.0);
      tmpvar_87.x = (((tmpvar_77 + tmpvar_75) + 1.0) / RES_NU);
      tmpvar_87.y = ((tmpvar_71 / RES_R) + tmpvar_79);
      lowp vec4 tmpvar_88;
      tmpvar_88 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_87.xy, 0.0);
      tmpvar_60 = (((
        (tmpvar_82 * (1.0 - _lerp_61))
       + 
        (tmpvar_84 * _lerp_61)
      ) * (1.0 - tmpvar_80)) + ((
        (tmpvar_86 * (1.0 - _lerp_61))
       + 
        (tmpvar_88 * _lerp_61)
      ) * tmpvar_80));
      highp float _lerp_89;
      highp float tmpvar_90;
      highp float tmpvar_91;
      tmpvar_91 = (Rg * Rg);
      tmpvar_90 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_91));
      highp float tmpvar_92;
      tmpvar_92 = sqrt(((tmpvar_41 * tmpvar_41) - tmpvar_91));
      highp float tmpvar_93;
      tmpvar_93 = (tmpvar_41 * tmpvar_42);
      highp float tmpvar_94;
      tmpvar_94 = (((tmpvar_93 * tmpvar_93) - (tmpvar_41 * tmpvar_41)) + tmpvar_91);
      highp vec4 tmpvar_95;
      if (((tmpvar_93 < 0.0) && (tmpvar_94 > 0.0))) {
        highp vec4 tmpvar_96;
        tmpvar_96.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_96.w = (0.5 - (0.5 / RES_MU));
        tmpvar_95 = tmpvar_96;
      } else {
        highp vec4 tmpvar_97;
        tmpvar_97.x = -1.0;
        tmpvar_97.y = (tmpvar_90 * tmpvar_90);
        tmpvar_97.z = tmpvar_90;
        tmpvar_97.w = (0.5 + (0.5 / RES_MU));
        tmpvar_95 = tmpvar_97;
      };
      highp float tmpvar_98;
      tmpvar_98 = ((0.5 / RES_R) + ((tmpvar_92 / tmpvar_90) * (1.0 - 
        (1.0/(RES_R))
      )));
      highp float tmpvar_99;
      tmpvar_99 = (tmpvar_95.w + ((
        ((tmpvar_93 * tmpvar_95.x) + sqrt((tmpvar_94 + tmpvar_95.y)))
       / 
        (tmpvar_92 + tmpvar_95.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      highp float y_over_x_100;
      y_over_x_100 = (max (tmpvar_43, -0.1975) * 5.349625);
      highp float tmpvar_101;
      tmpvar_101 = (min (abs(y_over_x_100), 1.0) / max (abs(y_over_x_100), 1.0));
      highp float tmpvar_102;
      tmpvar_102 = (tmpvar_101 * tmpvar_101);
      tmpvar_102 = (((
        ((((
          ((((-0.01213232 * tmpvar_102) + 0.05368138) * tmpvar_102) - 0.1173503)
         * tmpvar_102) + 0.1938925) * tmpvar_102) - 0.3326756)
       * tmpvar_102) + 0.9999793) * tmpvar_101);
      tmpvar_102 = (tmpvar_102 + (float(
        (abs(y_over_x_100) > 1.0)
      ) * (
        (tmpvar_102 * -2.0)
       + 1.570796)));
      highp float tmpvar_103;
      tmpvar_103 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_102 * sign(y_over_x_100)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      highp float tmpvar_104;
      tmpvar_104 = (((tmpvar_38 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_105;
      tmpvar_105 = floor(tmpvar_104);
      _lerp_89 = (tmpvar_104 - tmpvar_105);
      highp float tmpvar_106;
      tmpvar_106 = (floor((
        (tmpvar_98 * RES_R)
       - 1.0)) / RES_R);
      highp float tmpvar_107;
      tmpvar_107 = (floor((tmpvar_98 * RES_R)) / RES_R);
      highp float tmpvar_108;
      tmpvar_108 = fract((tmpvar_98 * RES_R));
      highp vec4 tmpvar_109;
      tmpvar_109.zw = vec2(0.0, 0.0);
      tmpvar_109.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
      tmpvar_109.y = ((tmpvar_99 / RES_R) + tmpvar_106);
      lowp vec4 tmpvar_110;
      tmpvar_110 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_109.xy, 0.0);
      highp vec4 tmpvar_111;
      tmpvar_111.zw = vec2(0.0, 0.0);
      tmpvar_111.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
      tmpvar_111.y = ((tmpvar_99 / RES_R) + tmpvar_106);
      lowp vec4 tmpvar_112;
      tmpvar_112 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_111.xy, 0.0);
      highp vec4 tmpvar_113;
      tmpvar_113.zw = vec2(0.0, 0.0);
      tmpvar_113.x = ((tmpvar_105 + tmpvar_103) / RES_NU);
      tmpvar_113.y = ((tmpvar_99 / RES_R) + tmpvar_107);
      lowp vec4 tmpvar_114;
      tmpvar_114 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_113.xy, 0.0);
      highp vec4 tmpvar_115;
      tmpvar_115.zw = vec2(0.0, 0.0);
      tmpvar_115.x = (((tmpvar_105 + tmpvar_103) + 1.0) / RES_NU);
      tmpvar_115.y = ((tmpvar_99 / RES_R) + tmpvar_107);
      lowp vec4 tmpvar_116;
      tmpvar_116 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_115.xy, 0.0);
      highp vec4 tmpvar_117;
      tmpvar_117 = max ((tmpvar_60 - (
        ((((tmpvar_110 * 
          (1.0 - _lerp_89)
        ) + (tmpvar_112 * _lerp_89)) * (1.0 - tmpvar_108)) + (((tmpvar_114 * 
          (1.0 - _lerp_89)
        ) + (tmpvar_116 * _lerp_89)) * tmpvar_108))
       * tmpvar_59.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      inScatter_37.xyz = tmpvar_117.xyz;
      highp float tmpvar_118;
      tmpvar_118 = clamp ((tmpvar_39 / 0.02), 0.0, 1.0);
      inScatter_37.w = (tmpvar_117.w * (tmpvar_118 * (tmpvar_118 * 
        (3.0 - (2.0 * tmpvar_118))
      )));
      highp float tmpvar_119;
      tmpvar_119 = (mieG * mieG);
      result_28 = ((tmpvar_117.xyz * (
        (3.0 / (16.0 * M_PI))
       * 
        (1.0 + (tmpvar_38 * tmpvar_38))
      )) + ((
        ((tmpvar_117.xyz * inScatter_37.w) / max (tmpvar_117.x, 0.0001))
       * 
        (betaR.x / betaR)
      ) * (
        ((((1.5 / 
          (4.0 * M_PI)
        ) * (1.0 - tmpvar_119)) * pow ((
          (1.0 + tmpvar_119)
         - 
          ((2.0 * mieG) * tmpvar_38)
        ), -1.5)) * (1.0 + (tmpvar_38 * tmpvar_38)))
       / 
        (2.0 + tmpvar_119)
      )));
    } else {
      result_28 = vec3(0.0, 0.0, 0.0);
    };
    tmpvar_20 = (result_28 * SUN_INTENSITY);
    highp float tmpvar_120;
    highp vec3 x_121;
    x_121 = (tmpvar_19 - _camPos);
    tmpvar_120 = sqrt(dot (x_121, x_121));
    highp float tmpvar_122;
    if ((tmpvar_120 <= _global_depth)) {
      tmpvar_122 = (1.0 - exp(-(
        ((4.0 * tmpvar_120) / _global_depth)
      )));
    } else {
      tmpvar_122 = 1.0;
    };
    highp vec3 L_123;
    L_123 = (tmpvar_20 * _Exposure);
    highp float tmpvar_124;
    if ((L_123.x < 1.413)) {
      tmpvar_124 = pow ((L_123.x * 0.38317), 0.4545454);
    } else {
      tmpvar_124 = (1.0 - exp(-(L_123.x)));
    };
    L_123.x = tmpvar_124;
    highp float tmpvar_125;
    if ((L_123.y < 1.413)) {
      tmpvar_125 = pow ((L_123.y * 0.38317), 0.4545454);
    } else {
      tmpvar_125 = (1.0 - exp(-(L_123.y)));
    };
    L_123.y = tmpvar_125;
    highp float tmpvar_126;
    if ((L_123.z < 1.413)) {
      tmpvar_126 = pow ((L_123.z * 0.38317), 0.4545454);
    } else {
      tmpvar_126 = (1.0 - exp(-(L_123.z)));
    };
    L_123.z = tmpvar_126;
    highp vec4 tmpvar_127;
    tmpvar_127.w = 1.0;
    tmpvar_127.xyz = ((L_123 * _global_alpha) * tmpvar_122);
    tmpvar_1 = tmpvar_127;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_OFF" }
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec4 t1;
highp float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform lowp sampler2D _customDepthTexture;
uniform lowp sampler2D _Inscatter;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
highp vec4 t0;
lowp float t10_0;
bool tb0;
highp vec4 t1;
highp int ti1;
bvec3 tb1;
highp vec4 t2;
highp vec3 t3;
highp vec4 t4;
lowp vec4 t10_4;
highp ivec3 ti4;
highp vec4 t5;
highp ivec2 ti5;
highp vec4 t6;
lowp vec4 t10_6;
highp vec4 t7;
lowp vec4 t10_7;
highp vec4 t8;
lowp vec4 t10_8;
highp vec4 t9;
lowp vec4 t10_9;
highp vec4 t10;
lowp vec4 t10_10;
highp vec3 t11;
highp int ti11;
bool tb11;
highp vec3 t12;
highp int ti12;
bool tb12;
highp vec2 t13;
highp vec3 t14;
highp ivec2 ti14;
highp float t22;
bool tb22;
highp vec2 t23;
highp int ti23;
bool tb23;
highp float t24;
bool tb24;
highp float t25;
highp float t33;
highp int ti33;
bool tb33;
highp float t34;
bool tb34;
highp float t35;
highp int ti35;
bool tb35;
highp float t36;
bool tb36;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy).x;
    tb11 = t10_0==1.0;
    t22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t33 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t33 + t33;
    t12.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t23.x = Rg * Rg;
    t34 = (-Rg) * Rg + t12.x;
    t34 = t22 * t34;
    t34 = t34 * 4.0;
    t1.x = t1.x * t1.x + (-t34);
    tb34 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t33 = (-t33) * 2.0 + (-t1.x);
    t22 = t22 + t22;
    t22 = t33 / t22;
    t22 = (tb34) ? -1.0 : t22;
    ti33 = int((0.0<t22) ? 0xFFFFFFFFu : uint(0u));
    ti1 = ~ti33;
    ti11 = tb11 ? ti1 : int(0);
    if((uint(ti11))!=uint(0u)){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t1.xw = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t1.wwww * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t1.xxxx + t2;
    t2 = _ViewProjInv[2] * vec4(t10_0) + t2;
    t2 = t2 + _ViewProjInv[3];
    t2.xyz = t2.xyz / t2.www;
    t3.xyz = vec3(t22) * vs_TEXCOORD3.xyz;
    t0.xyz = vec3(t22) * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t1.x = dot(t3.xyz, t3.xyz);
    t3.xyz = t2.xyz + (-_camPos.xyzx.xyz);
    t1.w = dot(t3.xyz, t3.xyz);
    t1.xw = sqrt(t1.xw);
    tb1.x = t1.x<t1.w;
    ti33 = tb1.x ? ti33 : int(0);
    t0.xyz = (int(ti33) != 0) ? t0.xyz : t2.xyz;
    t33 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t33);
    t34 = Rg + _openglThreshold;
    tb1.x = t1.x<t34;
    t33 = inversesqrt(t33);
    t2.xyz = vec3(t33) * t0.xyz;
    t2.xyz = vec3(t34) * t2.xyz;
    t0.xyz = (tb1.x) ? t2.xyz : t0.xyz;
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t1.x = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t1.x);
    t2.xyz = t2.xyz / t3.xxx;
    t1.x = (-Rg) + Rt;
    t4.y = t1.x * _experimentalAtmoScale + Rg;
    t1.x = dot(t2.xyz, t2.xyz);
    t1.x = inversesqrt(t1.x);
    t2.xyz = t1.xxx * t2.xyz;
    t5.z = sqrt(t12.x);
    t1.x = Rg * 0.899999976;
    tb1.x = t5.z<t1.x;
    t6.y = Rg + _camPos.xyzx.y;
    t7.y = t0.y + Rg;
    t6.xz = _camPos.xyzx.xz;
    t12.x = dot(t6.xyz, t6.xyz);
    t7.z = sqrt(t12.x);
    t7.x = t6.y;
    t5.x = _camPos.xyzx.y;
    t5.y = t0.y;
    t1.xyw = (tb1.x) ? t7.xyz : t5.xyz;
    t5.xz = _camPos.xyzx.xz;
    t5.y = t1.x;
    t11.x = dot(t5.xyz, t2.xyz);
    t3.z = t11.x / t1.w;
    t1.x = t1.w * t1.w;
    t1.x = t11.x * t11.x + (-t1.x);
    t1.x = t4.y * t4.y + t1.x;
    tb35 = t1.x>=0.0;
    t1.x = sqrt(t1.x);
    t1.x = (tb35) ? (-t1.x) : -9.99999997e-007;
    t1.x = (-t11.x) + t1.x;
    t1.x = max(t1.x, 0.0);
    tb35 = 0.0<t1.x;
    tb36 = t1.x<t3.x;
    ti35 = int(uint(tb35) * 0xffffffffu & uint(tb36) * 0xffffffffu);
    t11.x = t11.x + t1.x;
    t4.z = t11.x / t4.y;
    t4.x = (-t1.x) + t3.x;
    t3.y = t1.w;
    t6.xyz = (int(ti35) != 0) ? t4.xyz : t3.xyz;
    tb11 = t4.y>=t6.y;
    if(tb11){
        t11.x = min(t3.x, 1.0);
        t0.w = t1.y;
        t0.xyz = (-t2.xyz) * t11.xxx + t0.xwz;
        t1.xyw = t1.xxx * t2.xyz + t5.xyz;
        t1.xyw = (int(ti35) != 0) ? t1.xyw : t5.xyz;
        t35 = dot(t2.xyz, SUN_DIR.xyzx.xyz);
        t1.x = dot(t1.xyw, SUN_DIR.xyzx.xyz);
        t1.y = Rg + 1600.0;
        tb34 = t6.y<t1.y;
        t1.xy = t1.xy / t6.yy;
        t5.xyz = t0.xyz * t1.yyy;
        t5.w = Rg + 1600.0;
        t0.w = t6.y;
        t0 = (bool(tb34)) ? t5 : t0;
        t12.x = dot(t0.xyz, t0.xyz);
        t34 = sqrt(t12.x);
        t2.x = dot(t0.xyz, t2.xyz);
        t0.x = dot(t0.xyz, SUN_DIR.xyzx.xyz);
        t0.x = t0.x / t34;
        t11.x = HR * _experimentalAtmoScale;
        t22 = 0.5 / t11.x;
        t22 = t0.w * t22;
        t22 = sqrt(t22);
        t34 = t6.x / t0.w;
        t6.w = t34 + t6.z;
        t13.xy = vec2(float(t22) * t6.z, float(t22) * t6.w);
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xyxx).xy) * 0xFFFFFFFFu);
        ti4.xz = ivec2(uvec2(lessThan(t13.xxyx, vec4(0.0, 0.0, 0.0, 0.0)).xz) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti4.xz;
        t14.xy = vec2(ti14.xy);
        t4.xzw = t13.xxy * t13.xxy;
        tb22 = t14.x<t14.y;
        t34 = t4.x * 1.44269502;
        t34 = exp2(t34);
        t22 = tb22 ? t34 : float(0.0);
        t4.xz = t4.zw * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xz = sqrt(t4.xz);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t4.xz;
        t13.xy = t14.xy / t13.xy;
        t34 = (-t6.x) / t11.x;
        t14.x = t0.w + t0.w;
        t14.x = t6.x / t14.x;
        t14.x = t6.z + t14.x;
        t34 = t34 * t14.x;
        t34 = t34 * 1.44269502;
        t5.y = exp2(t34);
        t5.xz = vec2(1.0, 1.0);
        t13.xy = t13.xy * t5.xy;
        t34 = t11.x * t0.w;
        t34 = t34 * 6.28310013;
        t34 = sqrt(t34);
        t25 = (-t0.w) + Rg;
        t11.x = t25 / t11.x;
        t11.x = t11.x * 1.44269502;
        t11.x = exp2(t11.x);
        t11.x = t11.x * t34;
        t34 = dot(t13.xy, vec2(1.0, -1.0));
        t22 = t22 + t34;
        t11.x = t22 * t11.x;
        t22 = HM * _experimentalAtmoScale;
        t34 = 0.5 / t22;
        t34 = t0.w * t34;
        t34 = sqrt(t34);
        t13.xy = vec2(t6.z * float(t34), t6.w * float(t34));
        ti4.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xxyx).xz) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t13.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xz = (-ti4.xz) + ti5.xy;
        t4.xz = vec2(ti4.xz);
        t7.xyz = t13.xxy * t13.xxy;
        tb34 = t4.x<t4.z;
        t36 = t7.x * 1.44269502;
        t36 = exp2(t36);
        t34 = tb34 ? t36 : float(0.0);
        t5.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t13.xy = t4.xz / t13.xy;
        t36 = (-t6.x) / t22;
        t14.x = t14.x * t36;
        t14.x = t14.x * 1.44269502;
        t5.w = exp2(t14.x);
        t13.xy = vec2(t13.x * t5.z, t13.y * t5.w);
        t14.x = t22 * t0.w;
        t14.x = t14.x * 6.28310013;
        t14.x = sqrt(t14.x);
        t22 = t25 / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t14.x;
        t13.x = dot(t13.xy, vec2(1.0, -1.0));
        t34 = t34 + t13.x;
        t22 = t22 * t34;
        t5 = vec4(t22) * betaMEx.xyzx.xyzx;
        t5 = (-betaR.xyzx.xyzx) * t11.xxxx + (-t5);
        t5 = t5 * vec4(1.44269502, 1.44269502, 1.44269502, 1.44269502);
        t5 = exp2(t5);
        t5 = min(t5, vec4(1.0, 1.0, 1.0, 1.0));
        t11.x = t4.y * t4.y + (-t23.x);
        t4.z = sqrt(t11.x);
        t11.x = t0.w * t0.w;
        t22 = t0.w * t0.w + (-t23.x);
        t11.y = sqrt(t22);
        t33 = t6.z * t0.w;
        t11.x = t33 * t33 + (-t11.x);
        t11.x = Rg * Rg + t11.x;
        tb23 = t33<0.0;
        tb34 = 0.0<t11.x;
        ti23 = int(uint(tb34) * 0xffffffffu & uint(tb23) * 0xffffffffu);
        t14.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
        t6.w = (-t14.x) + 0.5;
        t4.y = t4.z * t4.z;
        t4.w = t14.x + 0.5;
        t6.xyz = vec3(1.0, 0.0, 0.0);
        t4.x = -1.0;
        t7 = (int(ti23) != 0) ? t6.xzzw : t4;
        t23.x = t11.y / t4.z;
        t8.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
        t8.xyz = (-t8.xyz) + vec3(1.0, 0.5, 1.0);
        t23.x = t23.x * t8.x + t14.y;
        t11.xy = vec2(t11.x + t7.y, t11.y + t7.z);
        t11.x = sqrt(t11.x);
        t11.x = t33 * t7.x + t11.x;
        t11.x = t11.x / t11.y;
        t11.x = t11.x * t8.y + t7.w;
        t22 = max(t1.x, -0.197500005);
        t22 = t22 * 5.34962368;
        t33 = min(abs(t22), 1.0);
        t34 = max(abs(t22), 1.0);
        t34 = float(1.0) / t34;
        t33 = t33 * t34;
        t34 = t33 * t33;
        t13.x = t34 * 0.0208350997 + -0.0851330012;
        t13.x = t34 * t13.x + 0.180141002;
        t13.x = t34 * t13.x + -0.330299497;
        t34 = t34 * t13.x + 0.999866009;
        t13.x = t33 * t34;
        tb24 = 1.0<abs(t22);
        t13.x = t13.x * -2.0 + 1.57079637;
        t13.x = tb24 ? t13.x : float(0.0);
        t33 = t33 * t34 + t13.x;
        t22 = min(t22, 1.0);
        tb22 = t22<(-t22);
        t22 = (tb22) ? (-t33) : t33;
        t22 = t22 * 0.909090877 + 0.74000001;
        t22 = t22 * 0.5;
        t22 = t22 * t8.z + t14.z;
        t33 = t35 + 1.0;
        t33 = t33 * 0.5;
        t34 = RES_NU + -1.0;
        t13.x = t33 * t34;
        t13.x = floor(t13.x);
        t33 = t33 * t34 + (-t13.x);
        t34 = t23.x * RES_R;
        t23.x = t23.x * RES_R + -1.0;
        t23.x = floor(t23.x);
        t23.x = t23.x / RES_R;
        t24 = floor(t34);
        t24 = t24 / RES_R;
        t34 = fract(t34);
        t22 = t22 + t13.x;
        t7.y = t22 / RES_NU;
        t11.x = t11.x / RES_R;
        t7.z = t23.x + t11.x;
        t10_9 = textureLod(_Inscatter, t7.yz, 0.0);
        t23.x = (-t33) + 1.0;
        t22 = t22 + 1.0;
        t7.x = t22 / RES_NU;
        t10_10 = textureLod(_Inscatter, t7.xz, 0.0);
        t10 = vec4(t33) * t10_10;
        t9 = t10_9 * t23.xxxx + t10;
        t7.w = t24 + t11.x;
        t10_10 = textureLod(_Inscatter, t7.yw, 0.0);
        t10_7 = textureLod(_Inscatter, t7.xw, 0.0);
        t7 = vec4(t33) * t10_7;
        t7 = t10_10 * t23.xxxx + t7;
        t11.x = (-t34) + 1.0;
        t7 = vec4(t34) * t7;
        t7 = t9 * t11.xxxx + t7;
        t11.x = (-Rg) * Rg + t12.x;
        t11.x = sqrt(t11.x);
        t22 = t2.x * t2.x + (-t12.x);
        t11.y = Rg * Rg + t22;
        tb12 = t2.x<0.0;
        tb34 = 0.0<t11.y;
        ti12 = int(uint(tb34) * 0xffffffffu & uint(tb12) * 0xffffffffu);
        t6 = (int(ti12) != 0) ? t6 : t4;
        t12.x = t11.x / t4.z;
        t12.x = t12.x * t8.x + t14.y;
        t11.xy = vec2(t11.x + t6.z, t11.y + t6.y);
        t22 = sqrt(t11.y);
        t22 = t2.x * t6.x + t22;
        t11.x = t22 / t11.x;
        t11.x = t11.x * t8.y + t6.w;
        t0.x = max(t0.x, -0.197500005);
        t0.x = t0.x * 5.34962368;
        t22 = min(abs(t0.x), 1.0);
        t34 = max(abs(t0.x), 1.0);
        t34 = float(1.0) / t34;
        t22 = t22 * t34;
        t34 = t22 * t22;
        t2.x = t34 * 0.0208350997 + -0.0851330012;
        t2.x = t34 * t2.x + 0.180141002;
        t2.x = t34 * t2.x + -0.330299497;
        t34 = t34 * t2.x + 0.999866009;
        t2.x = t22 * t34;
        tb24 = 1.0<abs(t0.x);
        t2.x = t2.x * -2.0 + 1.57079637;
        t2.x = tb24 ? t2.x : float(0.0);
        t22 = t22 * t34 + t2.x;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t22) : t22;
        t0.x = t0.x * 0.909090877 + 0.74000001;
        t0.x = t8.z * t0.x;
        t0.x = t0.x * 0.5 + t14.z;
        t22 = t12.x * RES_R;
        t12.x = t12.x * RES_R + -1.0;
        t12.x = floor(t12.x);
        t12.z = floor(t22);
        t12.xz = t12.xz / vec2(RES_R);
        t22 = fract(t22);
        t0.x = t0.x + t13.x;
        t4.y = t0.x / RES_NU;
        t11.x = t11.x / RES_R;
        t4.zw = t12.xz + t11.xx;
        t10_6 = textureLod(_Inscatter, t4.yz, 0.0);
        t0.x = t0.x + 1.0;
        t4.x = t0.x / RES_NU;
        t10_8 = textureLod(_Inscatter, t4.xz, 0.0);
        t8 = vec4(t33) * t10_8;
        t6 = t10_6 * t23.xxxx + t8;
        t10_8 = textureLod(_Inscatter, t4.yw, 0.0);
        t10_4 = textureLod(_Inscatter, t4.xw, 0.0);
        t4 = vec4(t33) * t10_4;
        t4 = t10_8 * t23.xxxx + t4;
        t0.x = (-t22) + 1.0;
        t4 = vec4(t22) * t4;
        t0 = t6 * t0.xxxx + t4;
        t0 = (-t0) * t5 + t7;
        t4 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
        t11.x = t1.x * 50.0;
        t11.x = clamp(t11.x, 0.0, 1.0);
        t22 = t11.x * -2.0 + 3.0;
        t11.x = t11.x * t11.x;
        t11.x = t11.x * t22;
        t11.x = t11.x * t4.w;
        t11.xyz = t11.xxx * t4.xyz;
        t0.x = max(t0.x, 9.99999975e-005);
        t0.xyz = t11.xyz / t0.xxx;
        t1.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
        t0.xyz = t0.xyz * t1.xyz;
        t1.xy = vec2(M_PI) * vec2(16.0, 4.0);
        t1.xy = vec2(3.0, 1.5) / t1.xy;
        t33 = t35 * t35 + 1.0;
        t1.x = t33 * t1.x;
        t23.x = (-mieG) * mieG + 1.0;
        t12.x = t23.x * t1.y;
        t23.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
        t2.x = dot(vec2(t35), vec2(vec2(mieG, mieG)));
        t23.x = t23.x + (-t2.x);
        t23.x = log2(t23.x);
        t23.x = t23.x * -1.5;
        t23.x = exp2(t23.x);
        t12.x = t23.x * t12.x;
        t33 = t33 * t12.x;
        t33 = t33 / t23.y;
        t0.xyz = vec3(t33) * t0.xyz;
        t0.xyz = t4.xyz * t1.xxx + t0.xyz;
    } else {
        t0.xyz = vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    t0.xyz = t0.xyz * vec3(vec3(SUN_INTENSITY, SUN_INTENSITY, SUN_INTENSITY));
    tb33 = _global_depth>=t3.x;
    t1.x = t3.x * 4.0;
    t1.x = t1.x / _global_depth;
    t1.x = t1.x * -1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t33 = (tb33) ? t1.x : 1.0;
    t0.xyz = t0.xyz * vec3(_Exposure);
    tb1.xyz = lessThan(t0.xyzx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t0.xy = log2(t2.xz);
    t0.xy = t0.xy * vec2(0.454545468, 0.454545468);
    t0.xy = exp2(t0.xy);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t2.x = (tb1.x) ? t0.x : t2.x;
    t2.y = (tb1.y) ? t0.y : t2.y;
    t0.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = log2(t0.x);
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    t11.x = exp2(t0.y);
    t11.x = (-t11.x) + 1.0;
    t2.z = (tb1.z) ? t0.x : t11.x;
    t0.xyz = t2.xyz * vec3(vec3(_global_alpha, _global_alpha, _global_alpha));
    t0.xyz = vec3(t33) * t0.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "GODRAYS_OFF" }
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in  vec4 in_POSITION0;
out vec4 vs_TEXCOORD0;
out vec2 vs_TEXCOORD1;
 vec4 phase0_Output0_2;
out vec2 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
vec4 t0;
vec4 t1;
float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform  sampler2D _customDepthTexture;
uniform  sampler2D _Inscatter;
in  vec2 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
out vec4 SV_Target0;
vec4 t0;
lowp vec4 t10_0;
bool tb0;
vec4 t1;
int ti1;
bvec3 tb1;
vec4 t2;
vec3 t3;
vec4 t4;
lowp vec4 t10_4;
ivec3 ti4;
vec4 t5;
ivec2 ti5;
vec4 t6;
lowp vec4 t10_6;
vec4 t7;
lowp vec4 t10_7;
vec4 t8;
lowp vec4 t10_8;
vec4 t9;
lowp vec4 t10_9;
vec4 t10;
lowp vec4 t10_10;
vec3 t11;
int ti11;
bool tb11;
vec3 t12;
int ti12;
bool tb12;
vec2 t13;
vec3 t14;
ivec2 ti14;
float t22;
bool tb22;
vec2 t23;
int ti23;
bool tb23;
float t24;
bool tb24;
float t25;
float t33;
int ti33;
bool tb33;
float t34;
bool tb34;
float t35;
int ti35;
bool tb35;
float t36;
bool tb36;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy);
    tb11 = t10_0.x==1.0;
    t22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t33 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t33 + t33;
    t12.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t23.x = Rg * Rg;
    t34 = (-Rg) * Rg + t12.x;
    t34 = t22 * t34;
    t34 = t34 * 4.0;
    t1.x = t1.x * t1.x + (-t34);
    tb34 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t33 = (-t33) * 2.0 + (-t1.x);
    t22 = t22 + t22;
    t22 = t33 / t22;
    t22 = (tb34) ? -1.0 : t22;
    ti33 = int((0.0<t22) ? 0xFFFFFFFFu : uint(0u));
    ti1 = ~ti33;
    ti11 = tb11 ? ti1 : int(0);
    if((uint(ti11))!=uint(0u)){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t1.xw = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t1.wwww * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t1.xxxx + t2;
    t2 = _ViewProjInv[2] * t10_0.xxxx + t2;
    t2 = t2 + _ViewProjInv[3];
    t2.xyz = t2.xyz / t2.www;
    t3.xyz = vec3(t22) * vs_TEXCOORD3.xyz;
    t0.xyz = vec3(t22) * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t1.x = dot(t3.xyz, t3.xyz);
    t3.xyz = t2.xyz + (-_camPos.xyzx.xyz);
    t1.w = dot(t3.xyz, t3.xyz);
    t1.xw = sqrt(t1.xw);
    tb1.x = t1.x<t1.w;
    ti33 = tb1.x ? ti33 : int(0);
    t0.xyz = (int(ti33) != 0) ? t0.xyz : t2.xyz;
    t33 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t33);
    t34 = Rg + _openglThreshold;
    tb1.x = t1.x<t34;
    t33 = inversesqrt(t33);
    t2.xyz = vec3(t33) * t0.xyz;
    t2.xyz = vec3(t34) * t2.xyz;
    t0.xyz = (tb1.x) ? t2.xyz : t0.xyz;
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t1.x = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t1.x);
    t2.xyz = t2.xyz / t3.xxx;
    t1.x = (-Rg) + Rt;
    t4.y = t1.x * _experimentalAtmoScale + Rg;
    t1.x = dot(t2.xyz, t2.xyz);
    t1.x = inversesqrt(t1.x);
    t2.xyz = t1.xxx * t2.xyz;
    t5.z = sqrt(t12.x);
    t1.x = Rg * 0.899999976;
    tb1.x = t5.z<t1.x;
    t6.y = Rg + _camPos.xyzx.y;
    t7.y = t0.y + Rg;
    t6.xz = _camPos.xyzx.xz;
    t12.x = dot(t6.xyz, t6.xyz);
    t7.z = sqrt(t12.x);
    t7.x = t6.y;
    t5.x = _camPos.xyzx.y;
    t5.y = t0.y;
    t1.xyw = (tb1.x) ? t7.xyz : t5.xyz;
    t5.xz = _camPos.xyzx.xz;
    t5.y = t1.x;
    t11.x = dot(t5.xyz, t2.xyz);
    t3.z = t11.x / t1.w;
    t1.x = t1.w * t1.w;
    t1.x = t11.x * t11.x + (-t1.x);
    t1.x = t4.y * t4.y + t1.x;
    tb35 = t1.x>=0.0;
    t1.x = sqrt(t1.x);
    t1.x = (tb35) ? (-t1.x) : -9.99999997e-007;
    t1.x = (-t11.x) + t1.x;
    t1.x = max(t1.x, 0.0);
    tb35 = 0.0<t1.x;
    tb36 = t1.x<t3.x;
    ti35 = int(uint(tb35) * 0xffffffffu & uint(tb36) * 0xffffffffu);
    t11.x = t11.x + t1.x;
    t4.z = t11.x / t4.y;
    t4.x = (-t1.x) + t3.x;
    t3.y = t1.w;
    t6.xyz = (int(ti35) != 0) ? t4.xyz : t3.xyz;
    tb11 = t4.y>=t6.y;
    if(tb11){
        t11.x = min(t3.x, 1.0);
        t0.w = t1.y;
        t0.xyz = (-t2.xyz) * t11.xxx + t0.xwz;
        t1.xyw = t1.xxx * t2.xyz + t5.xyz;
        t1.xyw = (int(ti35) != 0) ? t1.xyw : t5.xyz;
        t35 = dot(t2.xyz, SUN_DIR.xyzx.xyz);
        t1.x = dot(t1.xyw, SUN_DIR.xyzx.xyz);
        t1.y = Rg + 1600.0;
        tb34 = t6.y<t1.y;
        t1.xy = t1.xy / t6.yy;
        t5.xyz = t0.xyz * t1.yyy;
        t5.w = Rg + 1600.0;
        t0.w = t6.y;
        t0 = (bool(tb34)) ? t5 : t0;
        t12.x = dot(t0.xyz, t0.xyz);
        t34 = sqrt(t12.x);
        t2.x = dot(t0.xyz, t2.xyz);
        t0.x = dot(t0.xyz, SUN_DIR.xyzx.xyz);
        t0.x = t0.x / t34;
        t11.x = HR * _experimentalAtmoScale;
        t22 = 0.5 / t11.x;
        t22 = t0.w * t22;
        t22 = sqrt(t22);
        t34 = t6.x / t0.w;
        t6.w = t34 + t6.z;
        t13.xy = vec2(t22) * t6.zw;
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xyxx).xy) * 0xFFFFFFFFu);
        ti4.xz = ivec2(uvec2(lessThan(t13.xxyx, vec4(0.0, 0.0, 0.0, 0.0)).xz) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti4.xz;
        t14.xy = vec2(ti14.xy);
        t4.xzw = t13.xxy * t13.xxy;
        tb22 = t14.x<t14.y;
        t34 = t4.x * 1.44269502;
        t34 = exp2(t34);
        t22 = tb22 ? t34 : float(0.0);
        t4.xz = t4.zw * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xz = sqrt(t4.xz);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t4.xz;
        t13.xy = t14.xy / t13.xy;
        t34 = (-t6.x) / t11.x;
        t14.x = t0.w + t0.w;
        t14.x = t6.x / t14.x;
        t14.x = t6.z + t14.x;
        t34 = t34 * t14.x;
        t34 = t34 * 1.44269502;
        t5.y = exp2(t34);
        t5.xz = vec2(1.0, 1.0);
        t13.xy = t13.xy * t5.xy;
        t34 = t11.x * t0.w;
        t34 = t34 * 6.28310013;
        t34 = sqrt(t34);
        t25 = (-t0.w) + Rg;
        t11.x = t25 / t11.x;
        t11.x = t11.x * 1.44269502;
        t11.x = exp2(t11.x);
        t11.x = t11.x * t34;
        t34 = dot(t13.xy, vec2(1.0, -1.0));
        t22 = t22 + t34;
        t11.x = t22 * t11.x;
        t22 = HM * _experimentalAtmoScale;
        t34 = 0.5 / t22;
        t34 = t0.w * t34;
        t34 = sqrt(t34);
        t13.xy = t6.zw * vec2(t34);
        ti4.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xxyx).xz) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t13.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xz = (-ti4.xz) + ti5.xy;
        t4.xz = vec2(ti4.xz);
        t7.xyz = t13.xxy * t13.xxy;
        tb34 = t4.x<t4.z;
        t36 = t7.x * 1.44269502;
        t36 = exp2(t36);
        t34 = tb34 ? t36 : float(0.0);
        t5.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t13.xy = t4.xz / t13.xy;
        t36 = (-t6.x) / t22;
        t14.x = t14.x * t36;
        t14.x = t14.x * 1.44269502;
        t5.w = exp2(t14.x);
        t13.xy = t13.xy * t5.zw;
        t14.x = t22 * t0.w;
        t14.x = t14.x * 6.28310013;
        t14.x = sqrt(t14.x);
        t22 = t25 / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t14.x;
        t13.x = dot(t13.xy, vec2(1.0, -1.0));
        t34 = t34 + t13.x;
        t22 = t22 * t34;
        t5 = vec4(t22) * betaMEx.xyzx.xyzx;
        t5 = (-betaR.xyzx.xyzx) * t11.xxxx + (-t5);
        t5 = t5 * vec4(1.44269502, 1.44269502, 1.44269502, 1.44269502);
        t5 = exp2(t5);
        t5 = min(t5, vec4(1.0, 1.0, 1.0, 1.0));
        t11.x = t4.y * t4.y + (-t23.x);
        t4.z = sqrt(t11.x);
        t11.x = t0.w * t0.w;
        t22 = t0.w * t0.w + (-t23.x);
        t11.y = sqrt(t22);
        t33 = t6.z * t0.w;
        t11.x = t33 * t33 + (-t11.x);
        t11.x = Rg * Rg + t11.x;
        tb23 = t33<0.0;
        tb34 = 0.0<t11.x;
        ti23 = int(uint(tb34) * 0xffffffffu & uint(tb23) * 0xffffffffu);
        t14.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
        t6.w = (-t14.x) + 0.5;
        t4.y = t4.z * t4.z;
        t4.w = t14.x + 0.5;
        t6.xyz = vec3(1.0, 0.0, 0.0);
        t4.x = -1.0;
        t7 = (int(ti23) != 0) ? t6.xzzw : t4;
        t23.x = t11.y / t4.z;
        t8.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
        t8.xyz = (-t8.xyz) + vec3(1.0, 0.5, 1.0);
        t23.x = t23.x * t8.x + t14.y;
        t11.xy = t11.xy + t7.yz;
        t11.x = sqrt(t11.x);
        t11.x = t33 * t7.x + t11.x;
        t11.x = t11.x / t11.y;
        t11.x = t11.x * t8.y + t7.w;
        t22 = max(t1.x, -0.197500005);
        t22 = t22 * 5.34962368;
        t33 = min(abs(t22), 1.0);
        t34 = max(abs(t22), 1.0);
        t34 = float(1.0) / t34;
        t33 = t33 * t34;
        t34 = t33 * t33;
        t13.x = t34 * 0.0208350997 + -0.0851330012;
        t13.x = t34 * t13.x + 0.180141002;
        t13.x = t34 * t13.x + -0.330299497;
        t34 = t34 * t13.x + 0.999866009;
        t13.x = t33 * t34;
        tb24 = 1.0<abs(t22);
        t13.x = t13.x * -2.0 + 1.57079637;
        t13.x = tb24 ? t13.x : float(0.0);
        t33 = t33 * t34 + t13.x;
        t22 = min(t22, 1.0);
        tb22 = t22<(-t22);
        t22 = (tb22) ? (-t33) : t33;
        t22 = t22 * 0.909090877 + 0.74000001;
        t22 = t22 * 0.5;
        t22 = t22 * t8.z + t14.z;
        t33 = t35 + 1.0;
        t33 = t33 * 0.5;
        t34 = RES_NU + -1.0;
        t13.x = t33 * t34;
        t13.x = floor(t13.x);
        t33 = t33 * t34 + (-t13.x);
        t34 = t23.x * RES_R;
        t23.x = t23.x * RES_R + -1.0;
        t23.x = floor(t23.x);
        t23.x = t23.x / RES_R;
        t24 = floor(t34);
        t24 = t24 / RES_R;
        t34 = fract(t34);
        t22 = t22 + t13.x;
        t7.y = t22 / RES_NU;
        t11.x = t11.x / RES_R;
        t7.z = t23.x + t11.x;
        t10_9 = textureLod(_Inscatter, t7.yz, 0.0);
        t23.x = (-t33) + 1.0;
        t22 = t22 + 1.0;
        t7.x = t22 / RES_NU;
        t10_10 = textureLod(_Inscatter, t7.xz, 0.0);
        t10 = vec4(t33) * t10_10;
        t9 = t10_9 * t23.xxxx + t10;
        t7.w = t24 + t11.x;
        t10_10 = textureLod(_Inscatter, t7.yw, 0.0);
        t10_7 = textureLod(_Inscatter, t7.xw, 0.0);
        t7 = vec4(t33) * t10_7;
        t7 = t10_10 * t23.xxxx + t7;
        t11.x = (-t34) + 1.0;
        t7 = vec4(t34) * t7;
        t7 = t9 * t11.xxxx + t7;
        t11.x = (-Rg) * Rg + t12.x;
        t11.x = sqrt(t11.x);
        t22 = t2.x * t2.x + (-t12.x);
        t11.y = Rg * Rg + t22;
        tb12 = t2.x<0.0;
        tb34 = 0.0<t11.y;
        ti12 = int(uint(tb34) * 0xffffffffu & uint(tb12) * 0xffffffffu);
        t6 = (int(ti12) != 0) ? t6 : t4;
        t12.x = t11.x / t4.z;
        t12.x = t12.x * t8.x + t14.y;
        t11.xy = t11.xy + t6.zy;
        t22 = sqrt(t11.y);
        t22 = t2.x * t6.x + t22;
        t11.x = t22 / t11.x;
        t11.x = t11.x * t8.y + t6.w;
        t0.x = max(t0.x, -0.197500005);
        t0.x = t0.x * 5.34962368;
        t22 = min(abs(t0.x), 1.0);
        t34 = max(abs(t0.x), 1.0);
        t34 = float(1.0) / t34;
        t22 = t22 * t34;
        t34 = t22 * t22;
        t2.x = t34 * 0.0208350997 + -0.0851330012;
        t2.x = t34 * t2.x + 0.180141002;
        t2.x = t34 * t2.x + -0.330299497;
        t34 = t34 * t2.x + 0.999866009;
        t2.x = t22 * t34;
        tb24 = 1.0<abs(t0.x);
        t2.x = t2.x * -2.0 + 1.57079637;
        t2.x = tb24 ? t2.x : float(0.0);
        t22 = t22 * t34 + t2.x;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t22) : t22;
        t0.x = t0.x * 0.909090877 + 0.74000001;
        t0.x = t8.z * t0.x;
        t0.x = t0.x * 0.5 + t14.z;
        t22 = t12.x * RES_R;
        t12.x = t12.x * RES_R + -1.0;
        t12.x = floor(t12.x);
        t12.z = floor(t22);
        t12.xz = t12.xz / vec2(RES_R);
        t22 = fract(t22);
        t0.x = t0.x + t13.x;
        t4.y = t0.x / RES_NU;
        t11.x = t11.x / RES_R;
        t4.zw = t12.xz + t11.xx;
        t10_6 = textureLod(_Inscatter, t4.yz, 0.0);
        t0.x = t0.x + 1.0;
        t4.x = t0.x / RES_NU;
        t10_8 = textureLod(_Inscatter, t4.xz, 0.0);
        t8 = vec4(t33) * t10_8;
        t6 = t10_6 * t23.xxxx + t8;
        t10_8 = textureLod(_Inscatter, t4.yw, 0.0);
        t10_4 = textureLod(_Inscatter, t4.xw, 0.0);
        t4 = vec4(t33) * t10_4;
        t4 = t10_8 * t23.xxxx + t4;
        t0.x = (-t22) + 1.0;
        t4 = vec4(t22) * t4;
        t0 = t6 * t0.xxxx + t4;
        t0 = (-t0) * t5 + t7;
        t4 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
        t11.x = t1.x * 50.0;
        t11.x = clamp(t11.x, 0.0, 1.0);
        t22 = t11.x * -2.0 + 3.0;
        t11.x = t11.x * t11.x;
        t11.x = t11.x * t22;
        t11.x = t11.x * t4.w;
        t11.xyz = t11.xxx * t4.xyz;
        t0.x = max(t0.x, 9.99999975e-005);
        t0.xyz = t11.xyz / t0.xxx;
        t1.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
        t0.xyz = t0.xyz * t1.xyz;
        t1.xy = vec2(M_PI) * vec2(16.0, 4.0);
        t1.xy = vec2(3.0, 1.5) / t1.xy;
        t33 = t35 * t35 + 1.0;
        t1.x = t33 * t1.x;
        t23.x = (-mieG) * mieG + 1.0;
        t12.x = t23.x * t1.y;
        t23.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
        t2.x = dot(vec2(t35), vec2(vec2(mieG, mieG)));
        t23.x = t23.x + (-t2.x);
        t23.x = log2(t23.x);
        t23.x = t23.x * -1.5;
        t23.x = exp2(t23.x);
        t12.x = t23.x * t12.x;
        t33 = t33 * t12.x;
        t33 = t33 / t23.y;
        t0.xyz = vec3(t33) * t0.xyz;
        t0.xyz = t4.xyz * t1.xxx + t0.xyz;
    } else {
        t0.xyz = vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    t0.xyz = t0.xyz * vec3(vec3(SUN_INTENSITY, SUN_INTENSITY, SUN_INTENSITY));
    tb33 = _global_depth>=t3.x;
    t1.x = t3.x * 4.0;
    t1.x = t1.x / _global_depth;
    t1.x = t1.x * -1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t33 = (tb33) ? t1.x : 1.0;
    t0.xyz = t0.xyz * vec3(_Exposure);
    tb1.xyz = lessThan(t0.xyzx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t0.xy = log2(t2.xz);
    t0.xy = t0.xy * vec2(0.454545468, 0.454545468);
    t0.xy = exp2(t0.xy);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t2.x = (tb1.x) ? t0.x : t2.x;
    t2.y = (tb1.y) ? t0.y : t2.y;
    t0.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = log2(t0.x);
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    t11.x = exp2(t0.y);
    t11.x = (-t11.x) + 1.0;
    t2.z = (tb1.z) ? t0.x : t11.x;
    t0.xyz = t2.xyz * vec3(vec3(_global_alpha, _global_alpha, _global_alpha));
    SV_Target0.xyz = vec3(t33) * t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 517 math, 10 textures, 18 branches
Keywords { "GODRAYS_ON" }
"!!GLSL#version 120

#ifdef VERTEX
uniform vec3 _WorldSpaceCameraPos;
uniform vec4 _ProjectionParams;


uniform mat4 _Object2World;
varying vec4 xlv_TEXCOORD0;
varying vec2 xlv_TEXCOORD1;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  vec2 tmpvar_3;
  tmpvar_1 = (gl_ModelViewProjectionMatrix * gl_Vertex);
  vec4 o_4;
  vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((gl_ModelViewMatrix * gl_Vertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * gl_Vertex).xyz - _WorldSpaceCameraPos);
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
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform vec3 SUN_DIR;
uniform float SUN_INTENSITY;
uniform float _experimentalAtmoScale;
uniform mat4 _ViewProjInv;
uniform float _global_alpha;
uniform float _global_depth;
uniform vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform float _openglThreshold;
float xlat_mutableRt;
varying vec2 xlv_TEXCOORD2;
varying vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  vec4 tmpvar_1;
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_customDepthTexture, xlv_TEXCOORD2);
  float tmpvar_3;
  tmpvar_3 = tmpvar_2.x;
  bool tmpvar_4;
  tmpvar_4 = (tmpvar_2.x == 1.0);
  float tmpvar_5;
  tmpvar_5 = (1.0 - abs(dot (
    normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx)))
  , 
    normalize(xlv_TEXCOORD3)
  )));
  vec4 tmpvar_6;
  tmpvar_6 = texture2D (_godrayDepthTexture, xlv_TEXCOORD2);
  float tmpvar_7;
  if ((((tmpvar_6.x > 0.0) && (tmpvar_6.x < tmpvar_2.x)) && (tmpvar_2.x < 1.0))) {
    tmpvar_7 = mix (tmpvar_2.x, tmpvar_6.x, tmpvar_5);
  } else {
    tmpvar_7 = tmpvar_3;
  };
  vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_8.z = tmpvar_7;
  vec4 tmpvar_9;
  tmpvar_9 = (_ViewProjInv * tmpvar_8);
  vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 / tmpvar_9.w).xyz;
  float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  float tmpvar_12;
  tmpvar_12 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  float tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  float tmpvar_14;
  if ((tmpvar_13 < 0.0)) {
    tmpvar_14 = -1.0;
  } else {
    tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
  };
  bool tmpvar_15;
  tmpvar_15 = (tmpvar_14 > 0.0);
  if ((!(tmpvar_15) && tmpvar_4)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    vec3 tmpvar_16;
    tmpvar_16 = (_camPos + (tmpvar_14 * xlv_TEXCOORD3));
    vec3 x_17;
    x_17 = (tmpvar_16 - _camPos);
    vec3 x_18;
    x_18 = (tmpvar_10 - _camPos);
    bool tmpvar_19;
    tmpvar_19 = (sqrt(dot (x_17, x_17)) < sqrt(dot (x_18, x_18)));
    vec3 tmpvar_20;
    if ((tmpvar_15 && tmpvar_19)) {
      tmpvar_20 = tmpvar_16;
    } else {
      tmpvar_20 = tmpvar_10;
    };
    float tmpvar_21;
    tmpvar_21 = sqrt(dot (tmpvar_20, tmpvar_20));
    vec3 tmpvar_22;
    if ((tmpvar_21 < (Rg + _openglThreshold))) {
      tmpvar_22 = ((Rg + _openglThreshold) * normalize(tmpvar_20));
    } else {
      tmpvar_22 = tmpvar_20;
    };
    vec3 tmpvar_23;
    vec3 camera_24;
    camera_24 = _camPos;
    vec3 _point_25;
    _point_25 = tmpvar_22;
    float mu_26;
    float rMu_27;
    float r_28;
    float d_29;
    vec3 viewdir_30;
    vec3 result_31;
    result_31 = vec3(0.0, 0.0, 0.0);
    vec3 tmpvar_32;
    tmpvar_32 = (tmpvar_22 - _camPos);
    float tmpvar_33;
    tmpvar_33 = sqrt(dot (tmpvar_32, tmpvar_32));
    d_29 = tmpvar_33;
    viewdir_30 = (tmpvar_32 / tmpvar_33);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    vec3 tmpvar_34;
    tmpvar_34 = normalize(viewdir_30);
    viewdir_30 = tmpvar_34;
    float tmpvar_35;
    tmpvar_35 = sqrt(dot (_camPos, _camPos));
    r_28 = tmpvar_35;
    if ((tmpvar_35 < (0.9 * Rg))) {
      camera_24.y = (_camPos.y + Rg);
      _point_25.y = (tmpvar_22.y + Rg);
      r_28 = sqrt(dot (camera_24, camera_24));
    };
    float tmpvar_36;
    tmpvar_36 = dot (camera_24, tmpvar_34);
    rMu_27 = tmpvar_36;
    mu_26 = (tmpvar_36 / r_28);
    _point_25 = (_point_25 - (tmpvar_34 * clamp (1.0, 0.0, tmpvar_33)));
    float f_37;
    f_37 = (((tmpvar_36 * tmpvar_36) - (r_28 * r_28)) + (xlat_mutableRt * xlat_mutableRt));
    float tmpvar_38;
    if ((f_37 >= 0.0)) {
      tmpvar_38 = sqrt(f_37);
    } else {
      tmpvar_38 = 1e-06;
    };
    float tmpvar_39;
    tmpvar_39 = max ((-(tmpvar_36) - tmpvar_38), 0.0);
    if (((tmpvar_39 > 0.0) && (tmpvar_39 < tmpvar_33))) {
      camera_24 = (camera_24 + (tmpvar_39 * tmpvar_34));
      rMu_27 = (tmpvar_36 + tmpvar_39);
      mu_26 = (rMu_27 / xlat_mutableRt);
      r_28 = xlat_mutableRt;
      d_29 = (tmpvar_33 - tmpvar_39);
    };
    if ((r_28 <= xlat_mutableRt)) {
      vec4 inScatter_40;
      float tmpvar_41;
      tmpvar_41 = dot (tmpvar_34, SUN_DIR);
      float tmpvar_42;
      tmpvar_42 = (dot (camera_24, SUN_DIR) / r_28);
      if ((r_28 < (Rg + 1600.0))) {
        float tmpvar_43;
        tmpvar_43 = ((Rg + 1600.0) / r_28);
        r_28 = (r_28 * tmpvar_43);
        rMu_27 = (rMu_27 * tmpvar_43);
        _point_25 = (_point_25 * tmpvar_43);
      };
      float tmpvar_44;
      tmpvar_44 = sqrt(dot (_point_25, _point_25));
      float tmpvar_45;
      tmpvar_45 = (dot (_point_25, tmpvar_34) / tmpvar_44);
      float tmpvar_46;
      tmpvar_46 = (dot (_point_25, SUN_DIR) / tmpvar_44);
      float tmpvar_47;
      float H_48;
      H_48 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_49;
      tmpvar_49.x = mu_26;
      tmpvar_49.y = (mu_26 + (d_29 / r_28));
      vec2 tmpvar_50;
      tmpvar_50 = (sqrt((
        (0.5 / H_48)
       * r_28)) * tmpvar_49);
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
      tmpvar_54.y = exp(((
        -(d_29)
       / H_48) * (
        (d_29 / (2.0 * r_28))
       + mu_26)));
      tmpvar_47 = ((sqrt(
        ((6.2831 * H_48) * r_28)
      ) * exp(
        ((Rg - r_28) / H_48)
      )) * (tmpvar_53 + dot (
        ((tmpvar_51 / ((2.3193 * 
          abs(tmpvar_50)
        ) + sqrt(
          ((1.52 * tmpvar_52) + 4.0)
        ))) * tmpvar_54)
      , vec2(1.0, -1.0))));
      float H_55;
      H_55 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_56;
      tmpvar_56.x = mu_26;
      tmpvar_56.y = (mu_26 + (d_29 / r_28));
      vec2 tmpvar_57;
      tmpvar_57 = (sqrt((
        (0.5 / H_55)
       * r_28)) * tmpvar_56);
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
      tmpvar_61.y = exp(((
        -(d_29)
       / H_55) * (
        (d_29 / (2.0 * r_28))
       + mu_26)));
      vec3 tmpvar_62;
      tmpvar_62 = min (exp((
        (-(betaR) * tmpvar_47)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_55) * r_28)
        ) * exp(
          ((Rg - r_28) / H_55)
        )) * (tmpvar_60 + dot (
          ((tmpvar_58 / ((2.3193 * 
            abs(tmpvar_57)
          ) + sqrt(
            ((1.52 * tmpvar_59) + 4.0)
          ))) * tmpvar_61)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
      vec4 tmpvar_63;
      float _lerp_64;
      float tmpvar_65;
      float tmpvar_66;
      tmpvar_66 = (Rg * Rg);
      tmpvar_65 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_66));
      float tmpvar_67;
      tmpvar_67 = sqrt(((r_28 * r_28) - tmpvar_66));
      float tmpvar_68;
      tmpvar_68 = (r_28 * mu_26);
      float tmpvar_69;
      tmpvar_69 = (((tmpvar_68 * tmpvar_68) - (r_28 * r_28)) + tmpvar_66);
      vec4 tmpvar_70;
      if (((tmpvar_68 < 0.0) && (tmpvar_69 > 0.0))) {
        vec4 tmpvar_71;
        tmpvar_71.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_71.w = (0.5 - (0.5 / RES_MU));
        tmpvar_70 = tmpvar_71;
      } else {
        vec4 tmpvar_72;
        tmpvar_72.x = -1.0;
        tmpvar_72.y = (tmpvar_65 * tmpvar_65);
        tmpvar_72.z = tmpvar_65;
        tmpvar_72.w = (0.5 + (0.5 / RES_MU));
        tmpvar_70 = tmpvar_72;
      };
      float tmpvar_73;
      tmpvar_73 = ((0.5 / RES_R) + ((tmpvar_67 / tmpvar_65) * (1.0 - 
        (1.0/(RES_R))
      )));
      float tmpvar_74;
      tmpvar_74 = (tmpvar_70.w + ((
        ((tmpvar_68 * tmpvar_70.x) + sqrt((tmpvar_69 + tmpvar_70.y)))
       / 
        (tmpvar_67 + tmpvar_70.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      float y_over_x_75;
      y_over_x_75 = (max (tmpvar_42, -0.1975) * 5.349625);
      float tmpvar_76;
      tmpvar_76 = (min (abs(y_over_x_75), 1.0) / max (abs(y_over_x_75), 1.0));
      float tmpvar_77;
      tmpvar_77 = (tmpvar_76 * tmpvar_76);
      tmpvar_77 = (((
        ((((
          ((((-0.01213232 * tmpvar_77) + 0.05368138) * tmpvar_77) - 0.1173503)
         * tmpvar_77) + 0.1938925) * tmpvar_77) - 0.3326756)
       * tmpvar_77) + 0.9999793) * tmpvar_76);
      tmpvar_77 = (tmpvar_77 + (float(
        (abs(y_over_x_75) > 1.0)
      ) * (
        (tmpvar_77 * -2.0)
       + 1.570796)));
      float tmpvar_78;
      tmpvar_78 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_77 * sign(y_over_x_75)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      float tmpvar_79;
      tmpvar_79 = (((tmpvar_41 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_80;
      tmpvar_80 = floor(tmpvar_79);
      _lerp_64 = (tmpvar_79 - tmpvar_80);
      float tmpvar_81;
      tmpvar_81 = (floor((
        (tmpvar_73 * RES_R)
       - 1.0)) / RES_R);
      float tmpvar_82;
      tmpvar_82 = (floor((tmpvar_73 * RES_R)) / RES_R);
      float tmpvar_83;
      tmpvar_83 = fract((tmpvar_73 * RES_R));
      vec4 tmpvar_84;
      tmpvar_84.zw = vec2(0.0, 0.0);
      tmpvar_84.x = ((tmpvar_80 + tmpvar_78) / RES_NU);
      tmpvar_84.y = ((tmpvar_74 / RES_R) + tmpvar_81);
      vec4 tmpvar_85;
      tmpvar_85.zw = vec2(0.0, 0.0);
      tmpvar_85.x = (((tmpvar_80 + tmpvar_78) + 1.0) / RES_NU);
      tmpvar_85.y = ((tmpvar_74 / RES_R) + tmpvar_81);
      vec4 tmpvar_86;
      tmpvar_86.zw = vec2(0.0, 0.0);
      tmpvar_86.x = ((tmpvar_80 + tmpvar_78) / RES_NU);
      tmpvar_86.y = ((tmpvar_74 / RES_R) + tmpvar_82);
      vec4 tmpvar_87;
      tmpvar_87.zw = vec2(0.0, 0.0);
      tmpvar_87.x = (((tmpvar_80 + tmpvar_78) + 1.0) / RES_NU);
      tmpvar_87.y = ((tmpvar_74 / RES_R) + tmpvar_82);
      tmpvar_63 = (((
        (texture2DLod (_Inscatter, tmpvar_84.xy, 0.0) * (1.0 - _lerp_64))
       + 
        (texture2DLod (_Inscatter, tmpvar_85.xy, 0.0) * _lerp_64)
      ) * (1.0 - tmpvar_83)) + ((
        (texture2DLod (_Inscatter, tmpvar_86.xy, 0.0) * (1.0 - _lerp_64))
       + 
        (texture2DLod (_Inscatter, tmpvar_87.xy, 0.0) * _lerp_64)
      ) * tmpvar_83));
      float _lerp_88;
      float tmpvar_89;
      float tmpvar_90;
      tmpvar_90 = (Rg * Rg);
      tmpvar_89 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_90));
      float tmpvar_91;
      tmpvar_91 = sqrt(((tmpvar_44 * tmpvar_44) - tmpvar_90));
      float tmpvar_92;
      tmpvar_92 = (tmpvar_44 * tmpvar_45);
      float tmpvar_93;
      tmpvar_93 = (((tmpvar_92 * tmpvar_92) - (tmpvar_44 * tmpvar_44)) + tmpvar_90);
      vec4 tmpvar_94;
      if (((tmpvar_92 < 0.0) && (tmpvar_93 > 0.0))) {
        vec4 tmpvar_95;
        tmpvar_95.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_95.w = (0.5 - (0.5 / RES_MU));
        tmpvar_94 = tmpvar_95;
      } else {
        vec4 tmpvar_96;
        tmpvar_96.x = -1.0;
        tmpvar_96.y = (tmpvar_89 * tmpvar_89);
        tmpvar_96.z = tmpvar_89;
        tmpvar_96.w = (0.5 + (0.5 / RES_MU));
        tmpvar_94 = tmpvar_96;
      };
      float tmpvar_97;
      tmpvar_97 = ((0.5 / RES_R) + ((tmpvar_91 / tmpvar_89) * (1.0 - 
        (1.0/(RES_R))
      )));
      float tmpvar_98;
      tmpvar_98 = (tmpvar_94.w + ((
        ((tmpvar_92 * tmpvar_94.x) + sqrt((tmpvar_93 + tmpvar_94.y)))
       / 
        (tmpvar_91 + tmpvar_94.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      float y_over_x_99;
      y_over_x_99 = (max (tmpvar_46, -0.1975) * 5.349625);
      float tmpvar_100;
      tmpvar_100 = (min (abs(y_over_x_99), 1.0) / max (abs(y_over_x_99), 1.0));
      float tmpvar_101;
      tmpvar_101 = (tmpvar_100 * tmpvar_100);
      tmpvar_101 = (((
        ((((
          ((((-0.01213232 * tmpvar_101) + 0.05368138) * tmpvar_101) - 0.1173503)
         * tmpvar_101) + 0.1938925) * tmpvar_101) - 0.3326756)
       * tmpvar_101) + 0.9999793) * tmpvar_100);
      tmpvar_101 = (tmpvar_101 + (float(
        (abs(y_over_x_99) > 1.0)
      ) * (
        (tmpvar_101 * -2.0)
       + 1.570796)));
      float tmpvar_102;
      tmpvar_102 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_101 * sign(y_over_x_99)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      float tmpvar_103;
      tmpvar_103 = (((tmpvar_41 + 1.0) / 2.0) * (RES_NU - 1.0));
      float tmpvar_104;
      tmpvar_104 = floor(tmpvar_103);
      _lerp_88 = (tmpvar_103 - tmpvar_104);
      float tmpvar_105;
      tmpvar_105 = (floor((
        (tmpvar_97 * RES_R)
       - 1.0)) / RES_R);
      float tmpvar_106;
      tmpvar_106 = (floor((tmpvar_97 * RES_R)) / RES_R);
      float tmpvar_107;
      tmpvar_107 = fract((tmpvar_97 * RES_R));
      vec4 tmpvar_108;
      tmpvar_108.zw = vec2(0.0, 0.0);
      tmpvar_108.x = ((tmpvar_104 + tmpvar_102) / RES_NU);
      tmpvar_108.y = ((tmpvar_98 / RES_R) + tmpvar_105);
      vec4 tmpvar_109;
      tmpvar_109.zw = vec2(0.0, 0.0);
      tmpvar_109.x = (((tmpvar_104 + tmpvar_102) + 1.0) / RES_NU);
      tmpvar_109.y = ((tmpvar_98 / RES_R) + tmpvar_105);
      vec4 tmpvar_110;
      tmpvar_110.zw = vec2(0.0, 0.0);
      tmpvar_110.x = ((tmpvar_104 + tmpvar_102) / RES_NU);
      tmpvar_110.y = ((tmpvar_98 / RES_R) + tmpvar_106);
      vec4 tmpvar_111;
      tmpvar_111.zw = vec2(0.0, 0.0);
      tmpvar_111.x = (((tmpvar_104 + tmpvar_102) + 1.0) / RES_NU);
      tmpvar_111.y = ((tmpvar_98 / RES_R) + tmpvar_106);
      vec4 tmpvar_112;
      tmpvar_112 = max ((tmpvar_63 - (
        ((((texture2DLod (_Inscatter, tmpvar_108.xy, 0.0) * 
          (1.0 - _lerp_88)
        ) + (texture2DLod (_Inscatter, tmpvar_109.xy, 0.0) * _lerp_88)) * (1.0 - tmpvar_107)) + (((texture2DLod (_Inscatter, tmpvar_110.xy, 0.0) * 
          (1.0 - _lerp_88)
        ) + (texture2DLod (_Inscatter, tmpvar_111.xy, 0.0) * _lerp_88)) * tmpvar_107))
       * tmpvar_62.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      inScatter_40.xyz = tmpvar_112.xyz;
      float tmpvar_113;
      tmpvar_113 = clamp ((tmpvar_42 / 0.02), 0.0, 1.0);
      inScatter_40.w = (tmpvar_112.w * (tmpvar_113 * (tmpvar_113 * 
        (3.0 - (2.0 * tmpvar_113))
      )));
      float tmpvar_114;
      tmpvar_114 = (mieG * mieG);
      result_31 = ((tmpvar_112.xyz * (
        (3.0 / (16.0 * M_PI))
       * 
        (1.0 + (tmpvar_41 * tmpvar_41))
      )) + ((
        ((tmpvar_112.xyz * inScatter_40.w) / max (tmpvar_112.x, 0.0001))
       * 
        (betaR.x / betaR)
      ) * (
        ((((1.5 / 
          (4.0 * M_PI)
        ) * (1.0 - tmpvar_114)) * pow ((
          (1.0 + tmpvar_114)
         - 
          ((2.0 * mieG) * tmpvar_41)
        ), -1.5)) * (1.0 + (tmpvar_41 * tmpvar_41)))
       / 
        (2.0 + tmpvar_114)
      )));
    } else {
      result_31 = vec3(0.0, 0.0, 0.0);
    };
    tmpvar_23 = (result_31 * SUN_INTENSITY);
    float tmpvar_115;
    vec3 x_116;
    x_116 = (tmpvar_22 - _camPos);
    tmpvar_115 = sqrt(dot (x_116, x_116));
    float tmpvar_117;
    if ((tmpvar_115 <= _global_depth)) {
      tmpvar_117 = (1.0 - exp(-(
        ((4.0 * tmpvar_115) / _global_depth)
      )));
    } else {
      tmpvar_117 = 1.0;
    };
    vec3 L_118;
    L_118 = (tmpvar_23 * _Exposure);
    float tmpvar_119;
    if ((L_118.x < 1.413)) {
      tmpvar_119 = pow ((L_118.x * 0.38317), 0.4545454);
    } else {
      tmpvar_119 = (1.0 - exp(-(L_118.x)));
    };
    L_118.x = tmpvar_119;
    float tmpvar_120;
    if ((L_118.y < 1.413)) {
      tmpvar_120 = pow ((L_118.y * 0.38317), 0.4545454);
    } else {
      tmpvar_120 = (1.0 - exp(-(L_118.y)));
    };
    L_118.y = tmpvar_120;
    float tmpvar_121;
    if ((L_118.z < 1.413)) {
      tmpvar_121 = pow ((L_118.z * 0.38317), 0.4545454);
    } else {
      tmpvar_121 = (1.0 - exp(-(L_118.z)));
    };
    L_118.z = tmpvar_121;
    vec4 tmpvar_122;
    tmpvar_122.w = 1.0;
    tmpvar_122.xyz = ((L_118 * _global_alpha) * tmpvar_117);
    tmpvar_1 = tmpvar_122;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 24 math
Keywords { "GODRAYS_ON" }
Bind "vertex" Vertex
Matrix 7 [_Object2World] 3
Matrix 4 [glstate_matrix_modelview0] 3
Matrix 0 [glstate_matrix_mvp]
Vector 13 [_MainTex_TexelSize]
Vector 11 [_ProjectionParams]
Vector 12 [_ScreenParams]
Vector 10 [_WorldSpaceCameraPos]
"vs_3_0
def c14, 0.5, 0, -2, 1
dcl_position v0
dcl_position o0
dcl_texcoord o1
dcl_texcoord1 o2.xy
dcl_texcoord2 o3.xy
dcl_texcoord3 o4.xyz
dp4 o0.z, c2, v0
dp4 r0.x, c6, v0
mov o1.z, -r0.x
dp4 r0.x, c7, v0
dp4 r0.y, c8, v0
dp4 r0.z, c9, v0
add o4.xyz, r0, -c10
dp4 r0.x, c0, v0
dp4 r0.y, c1, v0
dp4 r0.w, c3, v0
mov o0.xyw, r0
mul r1.xz, r0.xyww, c14.x
mul r0.x, r0.y, c11.x
mul r1.w, r0.x, c14.x
mad r0.xy, r1.z, c12.zwzw, r1.xwzw
rcp r0.z, r0.w
mul r1.xy, r0.z, r0
mov o1.xyw, r0
mad r0.x, r1.y, c14.z, c14.w
mov r0.y, c14.y
slt r0.y, c13.y, r0.y
mad r1.z, r0.y, r0.x, r1.y
mov o2.xy, r1.xzzw
mov o3.xy, r1

"
}
SubProgram "d3d11 " {
// Stats: 20 math
Keywords { "GODRAYS_ON" }
Bind "vertex" Vertex
ConstBuffer "$Globals" 480
Vector 384 [_MainTex_TexelSize]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedhdhfoppakaalmddiagnpnbmggbfobaobabaaaaaapmaeaaaaadaaaaaa
cmaaaaaakaaaaaaaeaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
fdeieefcleadaaaaeaaaabaaonaaaaaafjaaaaaeegiocaaaaaaaaaaabjaaaaaa
fjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabaaaaaaa
fpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaiecaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaacaaaaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaaeaaaaaaakbabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaaacaaaaaaagaaaaaa
ckbabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaackiacaaa
acaaaaaaahaaaaaadkbabaaaaaaaaaaackaabaaaaaaaaaaadgaaaaageccabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpaaaaaaahdcaabaaa
aaaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadgaaaaaflccabaaaabaaaaaa
egambaaaaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaagabbaaaaaaaaaaapgapbaaa
aaaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaabiaaaaaaabeaaaaa
aaaaaaaadhaaaaajcccabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadgaaaaafnccabaaaacaaaaaaagajbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaadaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 517 math, 10 textures, 18 branches
Keywords { "GODRAYS_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_1.zw;
  tmpvar_2.xyw = o_4.xyw;
  tmpvar_3 = (o_4.xy / tmpvar_1.w);
  tmpvar_2.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_texture2DLodEXT(lowp sampler2D sampler, highp vec2 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return texture2DLodEXT(sampler, coord, lod);
#else
	return texture2D(sampler, coord, lod);
#endif
}

uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float mieG;
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
uniform highp float _experimentalAtmoScale;
uniform highp mat4 _ViewProjInv;
uniform highp float _global_alpha;
uniform highp float _global_depth;
uniform highp vec3 _camPos;
uniform sampler2D _customDepthTexture;
uniform sampler2D _godrayDepthTexture;
uniform highp float _openglThreshold;
highp float xlat_mutableRt;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  xlat_mutableRt = Rt;
  mediump vec4 tmpvar_1;
  highp float godrayDepth_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_customDepthTexture, xlv_TEXCOORD2).x;
  depth_3 = tmpvar_4;
  bool tmpvar_5;
  tmpvar_5 = (depth_3 == 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - abs(dot (
    normalize(((_camPos.yzx * SUN_DIR.zxy) - (_camPos.zxy * SUN_DIR.yzx)))
  , 
    normalize(xlv_TEXCOORD3)
  )));
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_godrayDepthTexture, xlv_TEXCOORD2).x;
  godrayDepth_2 = tmpvar_7;
  highp float tmpvar_8;
  if ((((godrayDepth_2 > 0.0) && (godrayDepth_2 < depth_3)) && (depth_3 < 1.0))) {
    tmpvar_8 = mix (depth_3, godrayDepth_2, tmpvar_6);
  } else {
    tmpvar_8 = depth_3;
  };
  depth_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xy = ((xlv_TEXCOORD2 * vec2(2.0, 2.0)) - vec2(1.0, 1.0));
  tmpvar_9.z = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10 = (_ViewProjInv * tmpvar_9);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10 / tmpvar_10.w).xyz;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  highp float tmpvar_13;
  tmpvar_13 = (2.0 * dot (xlv_TEXCOORD3, _camPos));
  highp float tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (
    dot (_camPos, _camPos)
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_15;
  if ((tmpvar_14 < 0.0)) {
    tmpvar_15 = -1.0;
  } else {
    tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
  };
  bool tmpvar_16;
  tmpvar_16 = (tmpvar_15 > 0.0);
  if ((!(tmpvar_16) && tmpvar_5)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_17;
    tmpvar_17 = (_camPos + (tmpvar_15 * xlv_TEXCOORD3));
    highp vec3 x_18;
    x_18 = (tmpvar_17 - _camPos);
    highp vec3 x_19;
    x_19 = (tmpvar_11 - _camPos);
    bool tmpvar_20;
    tmpvar_20 = (sqrt(dot (x_18, x_18)) < sqrt(dot (x_19, x_19)));
    highp vec3 tmpvar_21;
    if ((tmpvar_16 && tmpvar_20)) {
      tmpvar_21 = tmpvar_17;
    } else {
      tmpvar_21 = tmpvar_11;
    };
    highp float tmpvar_22;
    tmpvar_22 = sqrt(dot (tmpvar_21, tmpvar_21));
    highp vec3 tmpvar_23;
    if ((tmpvar_22 < (Rg + _openglThreshold))) {
      tmpvar_23 = ((Rg + _openglThreshold) * normalize(tmpvar_21));
    } else {
      tmpvar_23 = tmpvar_21;
    };
    highp vec3 tmpvar_24;
    highp vec3 camera_25;
    camera_25 = _camPos;
    highp vec3 _point_26;
    _point_26 = tmpvar_23;
    highp float mu_27;
    highp float rMu_28;
    highp float r_29;
    highp float d_30;
    highp vec3 viewdir_31;
    highp vec3 result_32;
    result_32 = vec3(0.0, 0.0, 0.0);
    highp vec3 tmpvar_33;
    tmpvar_33 = (tmpvar_23 - _camPos);
    highp float tmpvar_34;
    tmpvar_34 = sqrt(dot (tmpvar_33, tmpvar_33));
    d_30 = tmpvar_34;
    viewdir_31 = (tmpvar_33 / tmpvar_34);
    xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
    highp vec3 tmpvar_35;
    tmpvar_35 = normalize(viewdir_31);
    viewdir_31 = tmpvar_35;
    highp float tmpvar_36;
    tmpvar_36 = sqrt(dot (_camPos, _camPos));
    r_29 = tmpvar_36;
    if ((tmpvar_36 < (0.9 * Rg))) {
      camera_25.y = (_camPos.y + Rg);
      _point_26.y = (tmpvar_23.y + Rg);
      r_29 = sqrt(dot (camera_25, camera_25));
    };
    highp float tmpvar_37;
    tmpvar_37 = dot (camera_25, tmpvar_35);
    rMu_28 = tmpvar_37;
    mu_27 = (tmpvar_37 / r_29);
    _point_26 = (_point_26 - (tmpvar_35 * clamp (1.0, 0.0, tmpvar_34)));
    highp float f_38;
    f_38 = (((tmpvar_37 * tmpvar_37) - (r_29 * r_29)) + (xlat_mutableRt * xlat_mutableRt));
    highp float tmpvar_39;
    if ((f_38 >= 0.0)) {
      tmpvar_39 = sqrt(f_38);
    } else {
      tmpvar_39 = 1e-06;
    };
    highp float tmpvar_40;
    tmpvar_40 = max ((-(tmpvar_37) - tmpvar_39), 0.0);
    if (((tmpvar_40 > 0.0) && (tmpvar_40 < tmpvar_34))) {
      camera_25 = (camera_25 + (tmpvar_40 * tmpvar_35));
      rMu_28 = (tmpvar_37 + tmpvar_40);
      mu_27 = (rMu_28 / xlat_mutableRt);
      r_29 = xlat_mutableRt;
      d_30 = (tmpvar_34 - tmpvar_40);
    };
    if ((r_29 <= xlat_mutableRt)) {
      highp vec4 inScatter_41;
      highp float tmpvar_42;
      tmpvar_42 = dot (tmpvar_35, SUN_DIR);
      highp float tmpvar_43;
      tmpvar_43 = (dot (camera_25, SUN_DIR) / r_29);
      if ((r_29 < (Rg + 1600.0))) {
        highp float tmpvar_44;
        tmpvar_44 = ((Rg + 1600.0) / r_29);
        r_29 = (r_29 * tmpvar_44);
        rMu_28 = (rMu_28 * tmpvar_44);
        _point_26 = (_point_26 * tmpvar_44);
      };
      highp float tmpvar_45;
      tmpvar_45 = sqrt(dot (_point_26, _point_26));
      highp float tmpvar_46;
      tmpvar_46 = (dot (_point_26, tmpvar_35) / tmpvar_45);
      highp float tmpvar_47;
      tmpvar_47 = (dot (_point_26, SUN_DIR) / tmpvar_45);
      highp float tmpvar_48;
      highp float H_49;
      H_49 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_50;
      tmpvar_50.x = mu_27;
      tmpvar_50.y = (mu_27 + (d_30 / r_29));
      highp vec2 tmpvar_51;
      tmpvar_51 = (sqrt((
        (0.5 / H_49)
       * r_29)) * tmpvar_50);
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
      tmpvar_55.y = exp(((
        -(d_30)
       / H_49) * (
        (d_30 / (2.0 * r_29))
       + mu_27)));
      tmpvar_48 = ((sqrt(
        ((6.2831 * H_49) * r_29)
      ) * exp(
        ((Rg - r_29) / H_49)
      )) * (tmpvar_54 + dot (
        ((tmpvar_52 / ((2.3193 * 
          abs(tmpvar_51)
        ) + sqrt(
          ((1.52 * tmpvar_53) + 4.0)
        ))) * tmpvar_55)
      , vec2(1.0, -1.0))));
      highp float H_56;
      H_56 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_57;
      tmpvar_57.x = mu_27;
      tmpvar_57.y = (mu_27 + (d_30 / r_29));
      highp vec2 tmpvar_58;
      tmpvar_58 = (sqrt((
        (0.5 / H_56)
       * r_29)) * tmpvar_57);
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
      tmpvar_62.y = exp(((
        -(d_30)
       / H_56) * (
        (d_30 / (2.0 * r_29))
       + mu_27)));
      highp vec3 tmpvar_63;
      tmpvar_63 = min (exp((
        (-(betaR) * tmpvar_48)
       - 
        (betaMEx * ((sqrt(
          ((6.2831 * H_56) * r_29)
        ) * exp(
          ((Rg - r_29) / H_56)
        )) * (tmpvar_61 + dot (
          ((tmpvar_59 / ((2.3193 * 
            abs(tmpvar_58)
          ) + sqrt(
            ((1.52 * tmpvar_60) + 4.0)
          ))) * tmpvar_62)
        , vec2(1.0, -1.0)))))
      )), vec3(1.0, 1.0, 1.0));
      highp vec4 tmpvar_64;
      highp float _lerp_65;
      highp float tmpvar_66;
      highp float tmpvar_67;
      tmpvar_67 = (Rg * Rg);
      tmpvar_66 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_67));
      highp float tmpvar_68;
      tmpvar_68 = sqrt(((r_29 * r_29) - tmpvar_67));
      highp float tmpvar_69;
      tmpvar_69 = (r_29 * mu_27);
      highp float tmpvar_70;
      tmpvar_70 = (((tmpvar_69 * tmpvar_69) - (r_29 * r_29)) + tmpvar_67);
      highp vec4 tmpvar_71;
      if (((tmpvar_69 < 0.0) && (tmpvar_70 > 0.0))) {
        highp vec4 tmpvar_72;
        tmpvar_72.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_72.w = (0.5 - (0.5 / RES_MU));
        tmpvar_71 = tmpvar_72;
      } else {
        highp vec4 tmpvar_73;
        tmpvar_73.x = -1.0;
        tmpvar_73.y = (tmpvar_66 * tmpvar_66);
        tmpvar_73.z = tmpvar_66;
        tmpvar_73.w = (0.5 + (0.5 / RES_MU));
        tmpvar_71 = tmpvar_73;
      };
      highp float tmpvar_74;
      tmpvar_74 = ((0.5 / RES_R) + ((tmpvar_68 / tmpvar_66) * (1.0 - 
        (1.0/(RES_R))
      )));
      highp float tmpvar_75;
      tmpvar_75 = (tmpvar_71.w + ((
        ((tmpvar_69 * tmpvar_71.x) + sqrt((tmpvar_70 + tmpvar_71.y)))
       / 
        (tmpvar_68 + tmpvar_71.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      highp float y_over_x_76;
      y_over_x_76 = (max (tmpvar_43, -0.1975) * 5.349625);
      highp float tmpvar_77;
      tmpvar_77 = (min (abs(y_over_x_76), 1.0) / max (abs(y_over_x_76), 1.0));
      highp float tmpvar_78;
      tmpvar_78 = (tmpvar_77 * tmpvar_77);
      tmpvar_78 = (((
        ((((
          ((((-0.01213232 * tmpvar_78) + 0.05368138) * tmpvar_78) - 0.1173503)
         * tmpvar_78) + 0.1938925) * tmpvar_78) - 0.3326756)
       * tmpvar_78) + 0.9999793) * tmpvar_77);
      tmpvar_78 = (tmpvar_78 + (float(
        (abs(y_over_x_76) > 1.0)
      ) * (
        (tmpvar_78 * -2.0)
       + 1.570796)));
      highp float tmpvar_79;
      tmpvar_79 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_78 * sign(y_over_x_76)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      highp float tmpvar_80;
      tmpvar_80 = (((tmpvar_42 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_81;
      tmpvar_81 = floor(tmpvar_80);
      _lerp_65 = (tmpvar_80 - tmpvar_81);
      highp float tmpvar_82;
      tmpvar_82 = (floor((
        (tmpvar_74 * RES_R)
       - 1.0)) / RES_R);
      highp float tmpvar_83;
      tmpvar_83 = (floor((tmpvar_74 * RES_R)) / RES_R);
      highp float tmpvar_84;
      tmpvar_84 = fract((tmpvar_74 * RES_R));
      highp vec4 tmpvar_85;
      tmpvar_85.zw = vec2(0.0, 0.0);
      tmpvar_85.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
      tmpvar_85.y = ((tmpvar_75 / RES_R) + tmpvar_82);
      lowp vec4 tmpvar_86;
      tmpvar_86 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_85.xy, 0.0);
      highp vec4 tmpvar_87;
      tmpvar_87.zw = vec2(0.0, 0.0);
      tmpvar_87.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
      tmpvar_87.y = ((tmpvar_75 / RES_R) + tmpvar_82);
      lowp vec4 tmpvar_88;
      tmpvar_88 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_87.xy, 0.0);
      highp vec4 tmpvar_89;
      tmpvar_89.zw = vec2(0.0, 0.0);
      tmpvar_89.x = ((tmpvar_81 + tmpvar_79) / RES_NU);
      tmpvar_89.y = ((tmpvar_75 / RES_R) + tmpvar_83);
      lowp vec4 tmpvar_90;
      tmpvar_90 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_89.xy, 0.0);
      highp vec4 tmpvar_91;
      tmpvar_91.zw = vec2(0.0, 0.0);
      tmpvar_91.x = (((tmpvar_81 + tmpvar_79) + 1.0) / RES_NU);
      tmpvar_91.y = ((tmpvar_75 / RES_R) + tmpvar_83);
      lowp vec4 tmpvar_92;
      tmpvar_92 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_91.xy, 0.0);
      tmpvar_64 = (((
        (tmpvar_86 * (1.0 - _lerp_65))
       + 
        (tmpvar_88 * _lerp_65)
      ) * (1.0 - tmpvar_84)) + ((
        (tmpvar_90 * (1.0 - _lerp_65))
       + 
        (tmpvar_92 * _lerp_65)
      ) * tmpvar_84));
      highp float _lerp_93;
      highp float tmpvar_94;
      highp float tmpvar_95;
      tmpvar_95 = (Rg * Rg);
      tmpvar_94 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_95));
      highp float tmpvar_96;
      tmpvar_96 = sqrt(((tmpvar_45 * tmpvar_45) - tmpvar_95));
      highp float tmpvar_97;
      tmpvar_97 = (tmpvar_45 * tmpvar_46);
      highp float tmpvar_98;
      tmpvar_98 = (((tmpvar_97 * tmpvar_97) - (tmpvar_45 * tmpvar_45)) + tmpvar_95);
      highp vec4 tmpvar_99;
      if (((tmpvar_97 < 0.0) && (tmpvar_98 > 0.0))) {
        highp vec4 tmpvar_100;
        tmpvar_100.xyz = vec3(1.0, 0.0, 0.0);
        tmpvar_100.w = (0.5 - (0.5 / RES_MU));
        tmpvar_99 = tmpvar_100;
      } else {
        highp vec4 tmpvar_101;
        tmpvar_101.x = -1.0;
        tmpvar_101.y = (tmpvar_94 * tmpvar_94);
        tmpvar_101.z = tmpvar_94;
        tmpvar_101.w = (0.5 + (0.5 / RES_MU));
        tmpvar_99 = tmpvar_101;
      };
      highp float tmpvar_102;
      tmpvar_102 = ((0.5 / RES_R) + ((tmpvar_96 / tmpvar_94) * (1.0 - 
        (1.0/(RES_R))
      )));
      highp float tmpvar_103;
      tmpvar_103 = (tmpvar_99.w + ((
        ((tmpvar_97 * tmpvar_99.x) + sqrt((tmpvar_98 + tmpvar_99.y)))
       / 
        (tmpvar_96 + tmpvar_99.z)
      ) * (0.5 - 
        (1.0/(RES_MU))
      )));
      highp float y_over_x_104;
      y_over_x_104 = (max (tmpvar_47, -0.1975) * 5.349625);
      highp float tmpvar_105;
      tmpvar_105 = (min (abs(y_over_x_104), 1.0) / max (abs(y_over_x_104), 1.0));
      highp float tmpvar_106;
      tmpvar_106 = (tmpvar_105 * tmpvar_105);
      tmpvar_106 = (((
        ((((
          ((((-0.01213232 * tmpvar_106) + 0.05368138) * tmpvar_106) - 0.1173503)
         * tmpvar_106) + 0.1938925) * tmpvar_106) - 0.3326756)
       * tmpvar_106) + 0.9999793) * tmpvar_105);
      tmpvar_106 = (tmpvar_106 + (float(
        (abs(y_over_x_104) > 1.0)
      ) * (
        (tmpvar_106 * -2.0)
       + 1.570796)));
      highp float tmpvar_107;
      tmpvar_107 = ((0.5 / RES_MU_S) + ((
        (((tmpvar_106 * sign(y_over_x_104)) / 1.1) + 0.74)
       * 0.5) * (1.0 - 
        (1.0/(RES_MU_S))
      )));
      highp float tmpvar_108;
      tmpvar_108 = (((tmpvar_42 + 1.0) / 2.0) * (RES_NU - 1.0));
      highp float tmpvar_109;
      tmpvar_109 = floor(tmpvar_108);
      _lerp_93 = (tmpvar_108 - tmpvar_109);
      highp float tmpvar_110;
      tmpvar_110 = (floor((
        (tmpvar_102 * RES_R)
       - 1.0)) / RES_R);
      highp float tmpvar_111;
      tmpvar_111 = (floor((tmpvar_102 * RES_R)) / RES_R);
      highp float tmpvar_112;
      tmpvar_112 = fract((tmpvar_102 * RES_R));
      highp vec4 tmpvar_113;
      tmpvar_113.zw = vec2(0.0, 0.0);
      tmpvar_113.x = ((tmpvar_109 + tmpvar_107) / RES_NU);
      tmpvar_113.y = ((tmpvar_103 / RES_R) + tmpvar_110);
      lowp vec4 tmpvar_114;
      tmpvar_114 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_113.xy, 0.0);
      highp vec4 tmpvar_115;
      tmpvar_115.zw = vec2(0.0, 0.0);
      tmpvar_115.x = (((tmpvar_109 + tmpvar_107) + 1.0) / RES_NU);
      tmpvar_115.y = ((tmpvar_103 / RES_R) + tmpvar_110);
      lowp vec4 tmpvar_116;
      tmpvar_116 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_115.xy, 0.0);
      highp vec4 tmpvar_117;
      tmpvar_117.zw = vec2(0.0, 0.0);
      tmpvar_117.x = ((tmpvar_109 + tmpvar_107) / RES_NU);
      tmpvar_117.y = ((tmpvar_103 / RES_R) + tmpvar_111);
      lowp vec4 tmpvar_118;
      tmpvar_118 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_117.xy, 0.0);
      highp vec4 tmpvar_119;
      tmpvar_119.zw = vec2(0.0, 0.0);
      tmpvar_119.x = (((tmpvar_109 + tmpvar_107) + 1.0) / RES_NU);
      tmpvar_119.y = ((tmpvar_103 / RES_R) + tmpvar_111);
      lowp vec4 tmpvar_120;
      tmpvar_120 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_119.xy, 0.0);
      highp vec4 tmpvar_121;
      tmpvar_121 = max ((tmpvar_64 - (
        ((((tmpvar_114 * 
          (1.0 - _lerp_93)
        ) + (tmpvar_116 * _lerp_93)) * (1.0 - tmpvar_112)) + (((tmpvar_118 * 
          (1.0 - _lerp_93)
        ) + (tmpvar_120 * _lerp_93)) * tmpvar_112))
       * tmpvar_63.xyzx)), vec4(0.0, 0.0, 0.0, 0.0));
      inScatter_41.xyz = tmpvar_121.xyz;
      highp float tmpvar_122;
      tmpvar_122 = clamp ((tmpvar_43 / 0.02), 0.0, 1.0);
      inScatter_41.w = (tmpvar_121.w * (tmpvar_122 * (tmpvar_122 * 
        (3.0 - (2.0 * tmpvar_122))
      )));
      highp float tmpvar_123;
      tmpvar_123 = (mieG * mieG);
      result_32 = ((tmpvar_121.xyz * (
        (3.0 / (16.0 * M_PI))
       * 
        (1.0 + (tmpvar_42 * tmpvar_42))
      )) + ((
        ((tmpvar_121.xyz * inScatter_41.w) / max (tmpvar_121.x, 0.0001))
       * 
        (betaR.x / betaR)
      ) * (
        ((((1.5 / 
          (4.0 * M_PI)
        ) * (1.0 - tmpvar_123)) * pow ((
          (1.0 + tmpvar_123)
         - 
          ((2.0 * mieG) * tmpvar_42)
        ), -1.5)) * (1.0 + (tmpvar_42 * tmpvar_42)))
       / 
        (2.0 + tmpvar_123)
      )));
    } else {
      result_32 = vec3(0.0, 0.0, 0.0);
    };
    tmpvar_24 = (result_32 * SUN_INTENSITY);
    highp float tmpvar_124;
    highp vec3 x_125;
    x_125 = (tmpvar_23 - _camPos);
    tmpvar_124 = sqrt(dot (x_125, x_125));
    highp float tmpvar_126;
    if ((tmpvar_124 <= _global_depth)) {
      tmpvar_126 = (1.0 - exp(-(
        ((4.0 * tmpvar_124) / _global_depth)
      )));
    } else {
      tmpvar_126 = 1.0;
    };
    highp vec3 L_127;
    L_127 = (tmpvar_24 * _Exposure);
    highp float tmpvar_128;
    if ((L_127.x < 1.413)) {
      tmpvar_128 = pow ((L_127.x * 0.38317), 0.4545454);
    } else {
      tmpvar_128 = (1.0 - exp(-(L_127.x)));
    };
    L_127.x = tmpvar_128;
    highp float tmpvar_129;
    if ((L_127.y < 1.413)) {
      tmpvar_129 = pow ((L_127.y * 0.38317), 0.4545454);
    } else {
      tmpvar_129 = (1.0 - exp(-(L_127.y)));
    };
    L_127.y = tmpvar_129;
    highp float tmpvar_130;
    if ((L_127.z < 1.413)) {
      tmpvar_130 = pow ((L_127.z * 0.38317), 0.4545454);
    } else {
      tmpvar_130 = (1.0 - exp(-(L_127.z)));
    };
    L_127.z = tmpvar_130;
    highp vec4 tmpvar_131;
    tmpvar_131.w = 1.0;
    tmpvar_131.xyz = ((L_127 * _global_alpha) * tmpvar_126);
    tmpvar_1 = tmpvar_131;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_ON" }
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
highp  vec4 phase0_Output0_2;
out highp vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
highp vec4 t0;
highp vec4 t1;
highp float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform lowp sampler2D _customDepthTexture;
uniform lowp sampler2D _godrayDepthTexture;
uniform lowp sampler2D _Inscatter;
in highp vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
highp vec4 t0;
lowp float t10_0;
bool tb0;
highp vec4 t1;
highp int ti1;
bvec3 tb1;
highp vec4 t2;
bool tb2;
highp vec3 t3;
highp vec4 t4;
lowp vec4 t10_4;
highp ivec3 ti4;
highp vec4 t5;
highp ivec2 ti5;
highp vec4 t6;
lowp vec4 t10_6;
highp vec4 t7;
lowp vec4 t10_7;
highp vec4 t8;
lowp vec4 t10_8;
highp vec4 t9;
lowp vec4 t10_9;
highp vec4 t10;
lowp vec4 t10_10;
highp vec3 t11;
highp int ti11;
bool tb11;
highp vec3 t12;
highp int ti12;
bool tb12;
highp vec2 t13;
highp vec3 t14;
highp ivec2 ti14;
highp float t22;
mediump float t16_22;
lowp float t10_22;
bool tb22;
highp vec2 t23;
highp int ti23;
bool tb23;
highp float t24;
bool tb24;
highp float t25;
highp float t33;
highp int ti33;
bool tb33;
highp float t34;
highp int ti34;
bool tb34;
highp float t35;
highp int ti35;
bool tb35;
highp float t36;
bool tb36;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy).x;
    tb11 = t10_0==1.0;
    t22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t33 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t33 + t33;
    t12.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t23.x = Rg * Rg;
    t34 = (-Rg) * Rg + t12.x;
    t34 = t22 * t34;
    t34 = t34 * 4.0;
    t1.x = t1.x * t1.x + (-t34);
    tb34 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t33 = (-t33) * 2.0 + (-t1.x);
    t1.x = t22 + t22;
    t33 = t33 / t1.x;
    t33 = (tb34) ? -1.0 : t33;
    ti1 = int((0.0<t33) ? 0xFFFFFFFFu : uint(0u));
    ti34 = ~ti1;
    ti11 = tb11 ? ti34 : int(0);
    if((uint(ti11))!=uint(0u)){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t2.xyz = SUN_DIR.xyzx.yzx * _camPos.xyzx.zxy;
    t2.xyz = _camPos.xyzx.yzx * SUN_DIR.xyzx.zxy + (-t2.xyz);
    t11.x = dot(t2.xyz, t2.xyz);
    t11.x = inversesqrt(t11.x);
    t2.xyz = t11.xxx * t2.xyz;
    t11.x = inversesqrt(t22);
    t3.xyz = t11.xxx * vs_TEXCOORD3.xyz;
    t11.x = dot(t2.xyz, t3.xyz);
    t11.x = -abs(t11.x) + 1.0;
    t10_22 = texture(_godrayDepthTexture, vs_TEXCOORD2.xy).x;
    tb34 = 0.0<t10_22;
    tb2 = t10_22<t10_0;
    ti34 = int(uint(tb34) * 0xffffffffu & uint(tb2) * 0xffffffffu);
    tb2 = t10_0<1.0;
    ti34 = tb2 ? ti34 : int(0);
    t16_22 = (-t10_0) + t10_22;
    t11.x = t11.x * t16_22 + t10_0;
    t0.x = (ti34 != 0) ? t11.x : t10_0;
    t11.xy = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t11.yyyy * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t11.xxxx + t2;
    t2 = _ViewProjInv[2] * t0.xxxx + t2;
    t2 = t2 + _ViewProjInv[3];
    t0.xyz = t2.xyz / t2.www;
    t2.xyz = vec3(t33) * vs_TEXCOORD3.xyz;
    t3.xyz = vec3(t33) * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t33 = dot(t2.xyz, t2.xyz);
    t33 = sqrt(t33);
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t34 = dot(t2.xyz, t2.xyz);
    t34 = sqrt(t34);
    tb33 = t33<t34;
    ti33 = tb33 ? ti1 : int(0);
    t0.xyz = (int(ti33) != 0) ? t3.xyz : t0.xyz;
    t33 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t33);
    t34 = Rg + _openglThreshold;
    tb1.x = t1.x<t34;
    t33 = inversesqrt(t33);
    t2.xyz = vec3(t33) * t0.xyz;
    t2.xyz = vec3(t34) * t2.xyz;
    t0.xyz = (tb1.x) ? t2.xyz : t0.xyz;
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t1.x = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t1.x);
    t2.xyz = t2.xyz / t3.xxx;
    t1.x = (-Rg) + Rt;
    t4.y = t1.x * _experimentalAtmoScale + Rg;
    t1.x = dot(t2.xyz, t2.xyz);
    t1.x = inversesqrt(t1.x);
    t2.xyz = t1.xxx * t2.xyz;
    t5.z = sqrt(t12.x);
    t1.x = Rg * 0.899999976;
    tb1.x = t5.z<t1.x;
    t6.y = Rg + _camPos.xyzx.y;
    t7.y = t0.y + Rg;
    t6.xz = _camPos.xyzx.xz;
    t12.x = dot(t6.xyz, t6.xyz);
    t7.z = sqrt(t12.x);
    t7.x = t6.y;
    t5.x = _camPos.xyzx.y;
    t5.y = t0.y;
    t1.xyw = (tb1.x) ? t7.xyz : t5.xyz;
    t5.xz = _camPos.xyzx.xz;
    t5.y = t1.x;
    t11.x = dot(t5.xyz, t2.xyz);
    t3.z = t11.x / t1.w;
    t1.x = t1.w * t1.w;
    t1.x = t11.x * t11.x + (-t1.x);
    t1.x = t4.y * t4.y + t1.x;
    tb35 = t1.x>=0.0;
    t1.x = sqrt(t1.x);
    t1.x = (tb35) ? (-t1.x) : -9.99999997e-007;
    t1.x = (-t11.x) + t1.x;
    t1.x = max(t1.x, 0.0);
    tb35 = 0.0<t1.x;
    tb36 = t1.x<t3.x;
    ti35 = int(uint(tb35) * 0xffffffffu & uint(tb36) * 0xffffffffu);
    t11.x = t11.x + t1.x;
    t4.z = t11.x / t4.y;
    t4.x = (-t1.x) + t3.x;
    t3.y = t1.w;
    t6.xyz = (int(ti35) != 0) ? t4.xyz : t3.xyz;
    tb11 = t4.y>=t6.y;
    if(tb11){
        t11.x = min(t3.x, 1.0);
        t0.w = t1.y;
        t0.xyz = (-t2.xyz) * t11.xxx + t0.xwz;
        t1.xyw = t1.xxx * t2.xyz + t5.xyz;
        t1.xyw = (int(ti35) != 0) ? t1.xyw : t5.xyz;
        t35 = dot(t2.xyz, SUN_DIR.xyzx.xyz);
        t1.x = dot(t1.xyw, SUN_DIR.xyzx.xyz);
        t1.y = Rg + 1600.0;
        tb34 = t6.y<t1.y;
        t1.xy = t1.xy / t6.yy;
        t5.xyz = t0.xyz * t1.yyy;
        t5.w = Rg + 1600.0;
        t0.w = t6.y;
        t0 = (bool(tb34)) ? t5 : t0;
        t12.x = dot(t0.xyz, t0.xyz);
        t34 = sqrt(t12.x);
        t2.x = dot(t0.xyz, t2.xyz);
        t0.x = dot(t0.xyz, SUN_DIR.xyzx.xyz);
        t0.x = t0.x / t34;
        t11.x = HR * _experimentalAtmoScale;
        t22 = 0.5 / t11.x;
        t22 = t0.w * t22;
        t22 = sqrt(t22);
        t34 = t6.x / t0.w;
        t6.w = t34 + t6.z;
        t13.xy = vec2(float(t22) * t6.z, float(t22) * t6.w);
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xyxx).xy) * 0xFFFFFFFFu);
        ti4.xz = ivec2(uvec2(lessThan(t13.xxyx, vec4(0.0, 0.0, 0.0, 0.0)).xz) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti4.xz;
        t14.xy = vec2(ti14.xy);
        t4.xzw = t13.xxy * t13.xxy;
        tb22 = t14.x<t14.y;
        t34 = t4.x * 1.44269502;
        t34 = exp2(t34);
        t22 = tb22 ? t34 : float(0.0);
        t4.xz = t4.zw * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xz = sqrt(t4.xz);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t4.xz;
        t13.xy = t14.xy / t13.xy;
        t34 = (-t6.x) / t11.x;
        t14.x = t0.w + t0.w;
        t14.x = t6.x / t14.x;
        t14.x = t6.z + t14.x;
        t34 = t34 * t14.x;
        t34 = t34 * 1.44269502;
        t5.y = exp2(t34);
        t5.xz = vec2(1.0, 1.0);
        t13.xy = t13.xy * t5.xy;
        t34 = t11.x * t0.w;
        t34 = t34 * 6.28310013;
        t34 = sqrt(t34);
        t25 = (-t0.w) + Rg;
        t11.x = t25 / t11.x;
        t11.x = t11.x * 1.44269502;
        t11.x = exp2(t11.x);
        t11.x = t11.x * t34;
        t34 = dot(t13.xy, vec2(1.0, -1.0));
        t22 = t22 + t34;
        t11.x = t22 * t11.x;
        t22 = HM * _experimentalAtmoScale;
        t34 = 0.5 / t22;
        t34 = t0.w * t34;
        t34 = sqrt(t34);
        t13.xy = vec2(t6.z * float(t34), t6.w * float(t34));
        ti4.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xxyx).xz) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t13.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xz = (-ti4.xz) + ti5.xy;
        t4.xz = vec2(ti4.xz);
        t7.xyz = t13.xxy * t13.xxy;
        tb34 = t4.x<t4.z;
        t36 = t7.x * 1.44269502;
        t36 = exp2(t36);
        t34 = tb34 ? t36 : float(0.0);
        t5.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t13.xy = t4.xz / t13.xy;
        t36 = (-t6.x) / t22;
        t14.x = t14.x * t36;
        t14.x = t14.x * 1.44269502;
        t5.w = exp2(t14.x);
        t13.xy = vec2(t13.x * t5.z, t13.y * t5.w);
        t14.x = t22 * t0.w;
        t14.x = t14.x * 6.28310013;
        t14.x = sqrt(t14.x);
        t22 = t25 / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t14.x;
        t13.x = dot(t13.xy, vec2(1.0, -1.0));
        t34 = t34 + t13.x;
        t22 = t22 * t34;
        t5 = vec4(t22) * betaMEx.xyzx.xyzx;
        t5 = (-betaR.xyzx.xyzx) * t11.xxxx + (-t5);
        t5 = t5 * vec4(1.44269502, 1.44269502, 1.44269502, 1.44269502);
        t5 = exp2(t5);
        t5 = min(t5, vec4(1.0, 1.0, 1.0, 1.0));
        t11.x = t4.y * t4.y + (-t23.x);
        t4.z = sqrt(t11.x);
        t11.x = t0.w * t0.w;
        t22 = t0.w * t0.w + (-t23.x);
        t11.y = sqrt(t22);
        t33 = t6.z * t0.w;
        t11.x = t33 * t33 + (-t11.x);
        t11.x = Rg * Rg + t11.x;
        tb23 = t33<0.0;
        tb34 = 0.0<t11.x;
        ti23 = int(uint(tb34) * 0xffffffffu & uint(tb23) * 0xffffffffu);
        t14.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
        t6.w = (-t14.x) + 0.5;
        t4.y = t4.z * t4.z;
        t4.w = t14.x + 0.5;
        t6.xyz = vec3(1.0, 0.0, 0.0);
        t4.x = -1.0;
        t7 = (int(ti23) != 0) ? t6.xzzw : t4;
        t23.x = t11.y / t4.z;
        t8.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
        t8.xyz = (-t8.xyz) + vec3(1.0, 0.5, 1.0);
        t23.x = t23.x * t8.x + t14.y;
        t11.xy = vec2(t11.x + t7.y, t11.y + t7.z);
        t11.x = sqrt(t11.x);
        t11.x = t33 * t7.x + t11.x;
        t11.x = t11.x / t11.y;
        t11.x = t11.x * t8.y + t7.w;
        t22 = max(t1.x, -0.197500005);
        t22 = t22 * 5.34962368;
        t33 = min(abs(t22), 1.0);
        t34 = max(abs(t22), 1.0);
        t34 = float(1.0) / t34;
        t33 = t33 * t34;
        t34 = t33 * t33;
        t13.x = t34 * 0.0208350997 + -0.0851330012;
        t13.x = t34 * t13.x + 0.180141002;
        t13.x = t34 * t13.x + -0.330299497;
        t34 = t34 * t13.x + 0.999866009;
        t13.x = t33 * t34;
        tb24 = 1.0<abs(t22);
        t13.x = t13.x * -2.0 + 1.57079637;
        t13.x = tb24 ? t13.x : float(0.0);
        t33 = t33 * t34 + t13.x;
        t22 = min(t22, 1.0);
        tb22 = t22<(-t22);
        t22 = (tb22) ? (-t33) : t33;
        t22 = t22 * 0.909090877 + 0.74000001;
        t22 = t22 * 0.5;
        t22 = t22 * t8.z + t14.z;
        t33 = t35 + 1.0;
        t33 = t33 * 0.5;
        t34 = RES_NU + -1.0;
        t13.x = t33 * t34;
        t13.x = floor(t13.x);
        t33 = t33 * t34 + (-t13.x);
        t34 = t23.x * RES_R;
        t23.x = t23.x * RES_R + -1.0;
        t23.x = floor(t23.x);
        t23.x = t23.x / RES_R;
        t24 = floor(t34);
        t24 = t24 / RES_R;
        t34 = fract(t34);
        t22 = t22 + t13.x;
        t7.y = t22 / RES_NU;
        t11.x = t11.x / RES_R;
        t7.z = t23.x + t11.x;
        t10_9 = textureLod(_Inscatter, t7.yz, 0.0);
        t23.x = (-t33) + 1.0;
        t22 = t22 + 1.0;
        t7.x = t22 / RES_NU;
        t10_10 = textureLod(_Inscatter, t7.xz, 0.0);
        t10 = vec4(t33) * t10_10;
        t9 = t10_9 * t23.xxxx + t10;
        t7.w = t24 + t11.x;
        t10_10 = textureLod(_Inscatter, t7.yw, 0.0);
        t10_7 = textureLod(_Inscatter, t7.xw, 0.0);
        t7 = vec4(t33) * t10_7;
        t7 = t10_10 * t23.xxxx + t7;
        t11.x = (-t34) + 1.0;
        t7 = vec4(t34) * t7;
        t7 = t9 * t11.xxxx + t7;
        t11.x = (-Rg) * Rg + t12.x;
        t11.x = sqrt(t11.x);
        t22 = t2.x * t2.x + (-t12.x);
        t11.y = Rg * Rg + t22;
        tb12 = t2.x<0.0;
        tb34 = 0.0<t11.y;
        ti12 = int(uint(tb34) * 0xffffffffu & uint(tb12) * 0xffffffffu);
        t6 = (int(ti12) != 0) ? t6 : t4;
        t12.x = t11.x / t4.z;
        t12.x = t12.x * t8.x + t14.y;
        t11.xy = vec2(t11.x + t6.z, t11.y + t6.y);
        t22 = sqrt(t11.y);
        t22 = t2.x * t6.x + t22;
        t11.x = t22 / t11.x;
        t11.x = t11.x * t8.y + t6.w;
        t0.x = max(t0.x, -0.197500005);
        t0.x = t0.x * 5.34962368;
        t22 = min(abs(t0.x), 1.0);
        t34 = max(abs(t0.x), 1.0);
        t34 = float(1.0) / t34;
        t22 = t22 * t34;
        t34 = t22 * t22;
        t2.x = t34 * 0.0208350997 + -0.0851330012;
        t2.x = t34 * t2.x + 0.180141002;
        t2.x = t34 * t2.x + -0.330299497;
        t34 = t34 * t2.x + 0.999866009;
        t2.x = t22 * t34;
        tb24 = 1.0<abs(t0.x);
        t2.x = t2.x * -2.0 + 1.57079637;
        t2.x = tb24 ? t2.x : float(0.0);
        t22 = t22 * t34 + t2.x;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t22) : t22;
        t0.x = t0.x * 0.909090877 + 0.74000001;
        t0.x = t8.z * t0.x;
        t0.x = t0.x * 0.5 + t14.z;
        t22 = t12.x * RES_R;
        t12.x = t12.x * RES_R + -1.0;
        t12.x = floor(t12.x);
        t12.z = floor(t22);
        t12.xz = t12.xz / vec2(RES_R);
        t22 = fract(t22);
        t0.x = t0.x + t13.x;
        t4.y = t0.x / RES_NU;
        t11.x = t11.x / RES_R;
        t4.zw = t12.xz + t11.xx;
        t10_6 = textureLod(_Inscatter, t4.yz, 0.0);
        t0.x = t0.x + 1.0;
        t4.x = t0.x / RES_NU;
        t10_8 = textureLod(_Inscatter, t4.xz, 0.0);
        t8 = vec4(t33) * t10_8;
        t6 = t10_6 * t23.xxxx + t8;
        t10_8 = textureLod(_Inscatter, t4.yw, 0.0);
        t10_4 = textureLod(_Inscatter, t4.xw, 0.0);
        t4 = vec4(t33) * t10_4;
        t4 = t10_8 * t23.xxxx + t4;
        t0.x = (-t22) + 1.0;
        t4 = vec4(t22) * t4;
        t0 = t6 * t0.xxxx + t4;
        t0 = (-t0) * t5 + t7;
        t4 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
        t11.x = t1.x * 50.0;
        t11.x = clamp(t11.x, 0.0, 1.0);
        t22 = t11.x * -2.0 + 3.0;
        t11.x = t11.x * t11.x;
        t11.x = t11.x * t22;
        t11.x = t11.x * t4.w;
        t11.xyz = t11.xxx * t4.xyz;
        t0.x = max(t0.x, 9.99999975e-005);
        t0.xyz = t11.xyz / t0.xxx;
        t1.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
        t0.xyz = t0.xyz * t1.xyz;
        t1.xy = vec2(M_PI) * vec2(16.0, 4.0);
        t1.xy = vec2(3.0, 1.5) / t1.xy;
        t33 = t35 * t35 + 1.0;
        t1.x = t33 * t1.x;
        t23.x = (-mieG) * mieG + 1.0;
        t12.x = t23.x * t1.y;
        t23.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
        t2.x = dot(vec2(t35), vec2(vec2(mieG, mieG)));
        t23.x = t23.x + (-t2.x);
        t23.x = log2(t23.x);
        t23.x = t23.x * -1.5;
        t23.x = exp2(t23.x);
        t12.x = t23.x * t12.x;
        t33 = t33 * t12.x;
        t33 = t33 / t23.y;
        t0.xyz = vec3(t33) * t0.xyz;
        t0.xyz = t4.xyz * t1.xxx + t0.xyz;
    } else {
        t0.xyz = vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    t0.xyz = t0.xyz * vec3(vec3(SUN_INTENSITY, SUN_INTENSITY, SUN_INTENSITY));
    tb33 = _global_depth>=t3.x;
    t1.x = t3.x * 4.0;
    t1.x = t1.x / _global_depth;
    t1.x = t1.x * -1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t33 = (tb33) ? t1.x : 1.0;
    t0.xyz = t0.xyz * vec3(_Exposure);
    tb1.xyz = lessThan(t0.xyzx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t0.xy = log2(t2.xz);
    t0.xy = t0.xy * vec2(0.454545468, 0.454545468);
    t0.xy = exp2(t0.xy);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t2.x = (tb1.x) ? t0.x : t2.x;
    t2.y = (tb1.y) ? t0.y : t2.y;
    t0.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = log2(t0.x);
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    t11.x = exp2(t0.y);
    t11.x = (-t11.x) + 1.0;
    t2.z = (tb1.z) ? t0.x : t11.x;
    t0.xyz = t2.xyz * vec3(vec3(_global_alpha, _global_alpha, _global_alpha));
    t0.xyz = vec3(t33) * t0.xyz;
    SV_Target0.xyz = t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "GODRAYS_ON" }
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
in  vec4 in_POSITION0;
out vec4 vs_TEXCOORD0;
out vec2 vs_TEXCOORD1;
 vec4 phase0_Output0_2;
out vec2 vs_TEXCOORD2;
out vec3 vs_TEXCOORD3;
vec4 t0;
vec4 t1;
float t4;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    t0 = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    gl_Position = t0;
    t4 = in_POSITION0.y * glstate_matrix_modelview0[1].z;
    t4 = glstate_matrix_modelview0[0].z * in_POSITION0.x + t4;
    t4 = glstate_matrix_modelview0[2].z * in_POSITION0.z + t4;
    t4 = glstate_matrix_modelview0[3].z * in_POSITION0.w + t4;
    vs_TEXCOORD0.z = (-t4);
    t0.y = t0.y * _ProjectionParams.x;
    t1.xzw = t0.xwy * vec3(0.5, 0.5, 0.5);
    t0.xy = t1.zz + t1.xw;
    phase0_Output0_2 = t0.xyxy / t0.wwww;
    vs_TEXCOORD0.xyw = t0.xyw;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    t0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    vs_TEXCOORD3.xyz = t0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
vs_TEXCOORD1 = phase0_Output0_2.xy;
vs_TEXCOORD2 = phase0_Output0_2.zw;
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
uniform 	float TRANSMITTANCE_W;
uniform 	float TRANSMITTANCE_H;
uniform 	float SKY_W;
uniform 	float SKY_H;
uniform 	float M_PI;
uniform 	vec3 EARTH_POS;
uniform 	float SCALE;
uniform 	float HR;
uniform 	vec3 betaR;
uniform 	float HM;
uniform 	vec3 betaMSca;
uniform 	vec3 betaMEx;
uniform 	float mieG;
uniform 	float _Exposure;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float RL;
uniform 	float RES_R;
uniform 	float RES_MU;
uniform 	float RES_MU_S;
uniform 	float RES_NU;
uniform 	vec3 SUN_DIR;
uniform 	float SUN_INTENSITY;
uniform 	float _Sun_Intensity;
uniform 	float _experimentalAtmoScale;
uniform 	float _viewdirOffset;
uniform 	mat4 _ViewProjInv;
uniform 	float _Scale;
uniform 	float _global_alpha;
uniform 	float _global_depth;
uniform 	float _Ocean_Sigma;
uniform 	float fakeOcean;
uniform 	float _fade;
uniform 	vec3 _Ocean_Color;
uniform 	vec3 _camPos;
uniform 	vec4 _MainTex_TexelSize;
uniform 	float _openglThreshold;
uniform 	float _horizonDepth;
uniform 	mat4 _Globals_CameraToWorld;
uniform  sampler2D _customDepthTexture;
uniform  sampler2D _godrayDepthTexture;
uniform  sampler2D _Inscatter;
in  vec2 vs_TEXCOORD2;
in  vec3 vs_TEXCOORD3;
out vec4 SV_Target0;
vec4 t0;
lowp vec4 t10_0;
bool tb0;
vec4 t1;
int ti1;
bvec3 tb1;
vec4 t2;
lowp vec4 t10_2;
vec3 t3;
vec4 t4;
lowp vec4 t10_4;
ivec3 ti4;
vec4 t5;
ivec2 ti5;
vec4 t6;
lowp vec4 t10_6;
vec4 t7;
lowp vec4 t10_7;
vec4 t8;
lowp vec4 t10_8;
vec4 t9;
lowp vec4 t10_9;
vec4 t10;
lowp vec4 t10_10;
vec3 t11;
int ti11;
bool tb11;
vec3 t12;
int ti12;
bool tb12;
vec2 t13;
vec3 t14;
ivec2 ti14;
float t22;
int ti22;
bool tb22;
vec2 t23;
int ti23;
bool tb23;
float t24;
bool tb24;
float t25;
float t33;
int ti33;
bool tb33;
float t34;
mediump float t16_34;
int ti34;
bool tb34;
float t35;
int ti35;
bool tb35;
float t36;
bool tb36;
void main()
{
    t10_0 = texture(_customDepthTexture, vs_TEXCOORD2.xy);
    tb11 = t10_0.x==1.0;
    t22 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    t33 = dot(vs_TEXCOORD3.xyz, _camPos.xyzx.xyz);
    t1.x = t33 + t33;
    t12.x = dot(_camPos.xyzx.xyz, _camPos.xyzx.xyz);
    t23.x = Rg * Rg;
    t34 = (-Rg) * Rg + t12.x;
    t34 = t22 * t34;
    t34 = t34 * 4.0;
    t1.x = t1.x * t1.x + (-t34);
    tb34 = t1.x<0.0;
    t1.x = sqrt(t1.x);
    t33 = (-t33) * 2.0 + (-t1.x);
    t1.x = t22 + t22;
    t33 = t33 / t1.x;
    t33 = (tb34) ? -1.0 : t33;
    ti1 = int((0.0<t33) ? 0xFFFFFFFFu : uint(0u));
    ti34 = ~ti1;
    ti11 = tb11 ? ti34 : int(0);
    if((uint(ti11))!=uint(0u)){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t2.xyz = SUN_DIR.xyzx.yzx * _camPos.xyzx.zxy;
    t2.xyz = _camPos.xyzx.yzx * SUN_DIR.xyzx.zxy + (-t2.xyz);
    t11.x = dot(t2.xyz, t2.xyz);
    t11.x = inversesqrt(t11.x);
    t2.xyz = t11.xxx * t2.xyz;
    t11.x = inversesqrt(t22);
    t3.xyz = t11.xxx * vs_TEXCOORD3.xyz;
    t11.x = dot(t2.xyz, t3.xyz);
    t11.x = -abs(t11.x) + 1.0;
    t10_2 = texture(_godrayDepthTexture, vs_TEXCOORD2.xy);
    tb22 = 0.0<t10_2.x;
    tb34 = t10_2.x<t10_0.x;
    ti22 = int(uint(tb22) * 0xffffffffu & uint(tb34) * 0xffffffffu);
    tb34 = t10_0.x<1.0;
    ti22 = tb34 ? ti22 : int(0);
    t16_34 = (-t10_0.x) + t10_2.x;
    t11.x = t11.x * t16_34 + t10_0.x;
    t0.x = (ti22 != 0) ? t11.x : t10_0.x;
    t11.xy = vs_TEXCOORD2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    t2 = t11.yyyy * _ViewProjInv[1];
    t2 = _ViewProjInv[0] * t11.xxxx + t2;
    t2 = _ViewProjInv[2] * t0.xxxx + t2;
    t2 = t2 + _ViewProjInv[3];
    t0.xyz = t2.xyz / t2.www;
    t2.xyz = vec3(t33) * vs_TEXCOORD3.xyz;
    t3.xyz = vec3(t33) * vs_TEXCOORD3.xyz + _camPos.xyzx.xyz;
    t33 = dot(t2.xyz, t2.xyz);
    t33 = sqrt(t33);
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t34 = dot(t2.xyz, t2.xyz);
    t34 = sqrt(t34);
    tb33 = t33<t34;
    ti33 = tb33 ? ti1 : int(0);
    t0.xyz = (int(ti33) != 0) ? t3.xyz : t0.xyz;
    t33 = dot(t0.xyz, t0.xyz);
    t1.x = sqrt(t33);
    t34 = Rg + _openglThreshold;
    tb1.x = t1.x<t34;
    t33 = inversesqrt(t33);
    t2.xyz = vec3(t33) * t0.xyz;
    t2.xyz = vec3(t34) * t2.xyz;
    t0.xyz = (tb1.x) ? t2.xyz : t0.xyz;
    t2.xyz = t0.xyz + (-_camPos.xyzx.xyz);
    t1.x = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t1.x);
    t2.xyz = t2.xyz / t3.xxx;
    t1.x = (-Rg) + Rt;
    t4.y = t1.x * _experimentalAtmoScale + Rg;
    t1.x = dot(t2.xyz, t2.xyz);
    t1.x = inversesqrt(t1.x);
    t2.xyz = t1.xxx * t2.xyz;
    t5.z = sqrt(t12.x);
    t1.x = Rg * 0.899999976;
    tb1.x = t5.z<t1.x;
    t6.y = Rg + _camPos.xyzx.y;
    t7.y = t0.y + Rg;
    t6.xz = _camPos.xyzx.xz;
    t12.x = dot(t6.xyz, t6.xyz);
    t7.z = sqrt(t12.x);
    t7.x = t6.y;
    t5.x = _camPos.xyzx.y;
    t5.y = t0.y;
    t1.xyw = (tb1.x) ? t7.xyz : t5.xyz;
    t5.xz = _camPos.xyzx.xz;
    t5.y = t1.x;
    t11.x = dot(t5.xyz, t2.xyz);
    t3.z = t11.x / t1.w;
    t1.x = t1.w * t1.w;
    t1.x = t11.x * t11.x + (-t1.x);
    t1.x = t4.y * t4.y + t1.x;
    tb35 = t1.x>=0.0;
    t1.x = sqrt(t1.x);
    t1.x = (tb35) ? (-t1.x) : -9.99999997e-007;
    t1.x = (-t11.x) + t1.x;
    t1.x = max(t1.x, 0.0);
    tb35 = 0.0<t1.x;
    tb36 = t1.x<t3.x;
    ti35 = int(uint(tb35) * 0xffffffffu & uint(tb36) * 0xffffffffu);
    t11.x = t11.x + t1.x;
    t4.z = t11.x / t4.y;
    t4.x = (-t1.x) + t3.x;
    t3.y = t1.w;
    t6.xyz = (int(ti35) != 0) ? t4.xyz : t3.xyz;
    tb11 = t4.y>=t6.y;
    if(tb11){
        t11.x = min(t3.x, 1.0);
        t0.w = t1.y;
        t0.xyz = (-t2.xyz) * t11.xxx + t0.xwz;
        t1.xyw = t1.xxx * t2.xyz + t5.xyz;
        t1.xyw = (int(ti35) != 0) ? t1.xyw : t5.xyz;
        t35 = dot(t2.xyz, SUN_DIR.xyzx.xyz);
        t1.x = dot(t1.xyw, SUN_DIR.xyzx.xyz);
        t1.y = Rg + 1600.0;
        tb34 = t6.y<t1.y;
        t1.xy = t1.xy / t6.yy;
        t5.xyz = t0.xyz * t1.yyy;
        t5.w = Rg + 1600.0;
        t0.w = t6.y;
        t0 = (bool(tb34)) ? t5 : t0;
        t12.x = dot(t0.xyz, t0.xyz);
        t34 = sqrt(t12.x);
        t2.x = dot(t0.xyz, t2.xyz);
        t0.x = dot(t0.xyz, SUN_DIR.xyzx.xyz);
        t0.x = t0.x / t34;
        t11.x = HR * _experimentalAtmoScale;
        t22 = 0.5 / t11.x;
        t22 = t0.w * t22;
        t22 = sqrt(t22);
        t34 = t6.x / t0.w;
        t6.w = t34 + t6.z;
        t13.xy = vec2(t22) * t6.zw;
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xyxx).xy) * 0xFFFFFFFFu);
        ti4.xz = ivec2(uvec2(lessThan(t13.xxyx, vec4(0.0, 0.0, 0.0, 0.0)).xz) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti4.xz;
        t14.xy = vec2(ti14.xy);
        t4.xzw = t13.xxy * t13.xxy;
        tb22 = t14.x<t14.y;
        t34 = t4.x * 1.44269502;
        t34 = exp2(t34);
        t22 = tb22 ? t34 : float(0.0);
        t4.xz = t4.zw * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xz = sqrt(t4.xz);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t4.xz;
        t13.xy = t14.xy / t13.xy;
        t34 = (-t6.x) / t11.x;
        t14.x = t0.w + t0.w;
        t14.x = t6.x / t14.x;
        t14.x = t6.z + t14.x;
        t34 = t34 * t14.x;
        t34 = t34 * 1.44269502;
        t5.y = exp2(t34);
        t5.xz = vec2(1.0, 1.0);
        t13.xy = t13.xy * t5.xy;
        t34 = t11.x * t0.w;
        t34 = t34 * 6.28310013;
        t34 = sqrt(t34);
        t25 = (-t0.w) + Rg;
        t11.x = t25 / t11.x;
        t11.x = t11.x * 1.44269502;
        t11.x = exp2(t11.x);
        t11.x = t11.x * t34;
        t34 = dot(t13.xy, vec2(1.0, -1.0));
        t22 = t22 + t34;
        t11.x = t22 * t11.x;
        t22 = HM * _experimentalAtmoScale;
        t34 = 0.5 / t22;
        t34 = t0.w * t34;
        t34 = sqrt(t34);
        t13.xy = t6.zw * vec2(t34);
        ti4.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t13.xxyx).xz) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t13.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xz = (-ti4.xz) + ti5.xy;
        t4.xz = vec2(ti4.xz);
        t7.xyz = t13.xxy * t13.xxy;
        tb34 = t4.x<t4.z;
        t36 = t7.x * 1.44269502;
        t36 = exp2(t36);
        t34 = tb34 ? t36 : float(0.0);
        t5.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t13.xy = abs(t13.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t13.xy = t4.xz / t13.xy;
        t36 = (-t6.x) / t22;
        t14.x = t14.x * t36;
        t14.x = t14.x * 1.44269502;
        t5.w = exp2(t14.x);
        t13.xy = t13.xy * t5.zw;
        t14.x = t22 * t0.w;
        t14.x = t14.x * 6.28310013;
        t14.x = sqrt(t14.x);
        t22 = t25 / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t14.x;
        t13.x = dot(t13.xy, vec2(1.0, -1.0));
        t34 = t34 + t13.x;
        t22 = t22 * t34;
        t5 = vec4(t22) * betaMEx.xyzx.xyzx;
        t5 = (-betaR.xyzx.xyzx) * t11.xxxx + (-t5);
        t5 = t5 * vec4(1.44269502, 1.44269502, 1.44269502, 1.44269502);
        t5 = exp2(t5);
        t5 = min(t5, vec4(1.0, 1.0, 1.0, 1.0));
        t11.x = t4.y * t4.y + (-t23.x);
        t4.z = sqrt(t11.x);
        t11.x = t0.w * t0.w;
        t22 = t0.w * t0.w + (-t23.x);
        t11.y = sqrt(t22);
        t33 = t6.z * t0.w;
        t11.x = t33 * t33 + (-t11.x);
        t11.x = Rg * Rg + t11.x;
        tb23 = t33<0.0;
        tb34 = 0.0<t11.x;
        ti23 = int(uint(tb34) * 0xffffffffu & uint(tb23) * 0xffffffffu);
        t14.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
        t6.w = (-t14.x) + 0.5;
        t4.y = t4.z * t4.z;
        t4.w = t14.x + 0.5;
        t6.xyz = vec3(1.0, 0.0, 0.0);
        t4.x = -1.0;
        t7 = (int(ti23) != 0) ? t6.xzzw : t4;
        t23.x = t11.y / t4.z;
        t8.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
        t8.xyz = (-t8.xyz) + vec3(1.0, 0.5, 1.0);
        t23.x = t23.x * t8.x + t14.y;
        t11.xy = t11.xy + t7.yz;
        t11.x = sqrt(t11.x);
        t11.x = t33 * t7.x + t11.x;
        t11.x = t11.x / t11.y;
        t11.x = t11.x * t8.y + t7.w;
        t22 = max(t1.x, -0.197500005);
        t22 = t22 * 5.34962368;
        t33 = min(abs(t22), 1.0);
        t34 = max(abs(t22), 1.0);
        t34 = float(1.0) / t34;
        t33 = t33 * t34;
        t34 = t33 * t33;
        t13.x = t34 * 0.0208350997 + -0.0851330012;
        t13.x = t34 * t13.x + 0.180141002;
        t13.x = t34 * t13.x + -0.330299497;
        t34 = t34 * t13.x + 0.999866009;
        t13.x = t33 * t34;
        tb24 = 1.0<abs(t22);
        t13.x = t13.x * -2.0 + 1.57079637;
        t13.x = tb24 ? t13.x : float(0.0);
        t33 = t33 * t34 + t13.x;
        t22 = min(t22, 1.0);
        tb22 = t22<(-t22);
        t22 = (tb22) ? (-t33) : t33;
        t22 = t22 * 0.909090877 + 0.74000001;
        t22 = t22 * 0.5;
        t22 = t22 * t8.z + t14.z;
        t33 = t35 + 1.0;
        t33 = t33 * 0.5;
        t34 = RES_NU + -1.0;
        t13.x = t33 * t34;
        t13.x = floor(t13.x);
        t33 = t33 * t34 + (-t13.x);
        t34 = t23.x * RES_R;
        t23.x = t23.x * RES_R + -1.0;
        t23.x = floor(t23.x);
        t23.x = t23.x / RES_R;
        t24 = floor(t34);
        t24 = t24 / RES_R;
        t34 = fract(t34);
        t22 = t22 + t13.x;
        t7.y = t22 / RES_NU;
        t11.x = t11.x / RES_R;
        t7.z = t23.x + t11.x;
        t10_9 = textureLod(_Inscatter, t7.yz, 0.0);
        t23.x = (-t33) + 1.0;
        t22 = t22 + 1.0;
        t7.x = t22 / RES_NU;
        t10_10 = textureLod(_Inscatter, t7.xz, 0.0);
        t10 = vec4(t33) * t10_10;
        t9 = t10_9 * t23.xxxx + t10;
        t7.w = t24 + t11.x;
        t10_10 = textureLod(_Inscatter, t7.yw, 0.0);
        t10_7 = textureLod(_Inscatter, t7.xw, 0.0);
        t7 = vec4(t33) * t10_7;
        t7 = t10_10 * t23.xxxx + t7;
        t11.x = (-t34) + 1.0;
        t7 = vec4(t34) * t7;
        t7 = t9 * t11.xxxx + t7;
        t11.x = (-Rg) * Rg + t12.x;
        t11.x = sqrt(t11.x);
        t22 = t2.x * t2.x + (-t12.x);
        t11.y = Rg * Rg + t22;
        tb12 = t2.x<0.0;
        tb34 = 0.0<t11.y;
        ti12 = int(uint(tb34) * 0xffffffffu & uint(tb12) * 0xffffffffu);
        t6 = (int(ti12) != 0) ? t6 : t4;
        t12.x = t11.x / t4.z;
        t12.x = t12.x * t8.x + t14.y;
        t11.xy = t11.xy + t6.zy;
        t22 = sqrt(t11.y);
        t22 = t2.x * t6.x + t22;
        t11.x = t22 / t11.x;
        t11.x = t11.x * t8.y + t6.w;
        t0.x = max(t0.x, -0.197500005);
        t0.x = t0.x * 5.34962368;
        t22 = min(abs(t0.x), 1.0);
        t34 = max(abs(t0.x), 1.0);
        t34 = float(1.0) / t34;
        t22 = t22 * t34;
        t34 = t22 * t22;
        t2.x = t34 * 0.0208350997 + -0.0851330012;
        t2.x = t34 * t2.x + 0.180141002;
        t2.x = t34 * t2.x + -0.330299497;
        t34 = t34 * t2.x + 0.999866009;
        t2.x = t22 * t34;
        tb24 = 1.0<abs(t0.x);
        t2.x = t2.x * -2.0 + 1.57079637;
        t2.x = tb24 ? t2.x : float(0.0);
        t22 = t22 * t34 + t2.x;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t22) : t22;
        t0.x = t0.x * 0.909090877 + 0.74000001;
        t0.x = t8.z * t0.x;
        t0.x = t0.x * 0.5 + t14.z;
        t22 = t12.x * RES_R;
        t12.x = t12.x * RES_R + -1.0;
        t12.x = floor(t12.x);
        t12.z = floor(t22);
        t12.xz = t12.xz / vec2(RES_R);
        t22 = fract(t22);
        t0.x = t0.x + t13.x;
        t4.y = t0.x / RES_NU;
        t11.x = t11.x / RES_R;
        t4.zw = t12.xz + t11.xx;
        t10_6 = textureLod(_Inscatter, t4.yz, 0.0);
        t0.x = t0.x + 1.0;
        t4.x = t0.x / RES_NU;
        t10_8 = textureLod(_Inscatter, t4.xz, 0.0);
        t8 = vec4(t33) * t10_8;
        t6 = t10_6 * t23.xxxx + t8;
        t10_8 = textureLod(_Inscatter, t4.yw, 0.0);
        t10_4 = textureLod(_Inscatter, t4.xw, 0.0);
        t4 = vec4(t33) * t10_4;
        t4 = t10_8 * t23.xxxx + t4;
        t0.x = (-t22) + 1.0;
        t4 = vec4(t22) * t4;
        t0 = t6 * t0.xxxx + t4;
        t0 = (-t0) * t5 + t7;
        t4 = max(t0, vec4(0.0, 0.0, 0.0, 0.0));
        t11.x = t1.x * 50.0;
        t11.x = clamp(t11.x, 0.0, 1.0);
        t22 = t11.x * -2.0 + 3.0;
        t11.x = t11.x * t11.x;
        t11.x = t11.x * t22;
        t11.x = t11.x * t4.w;
        t11.xyz = t11.xxx * t4.xyz;
        t0.x = max(t0.x, 9.99999975e-005);
        t0.xyz = t11.xyz / t0.xxx;
        t1.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
        t0.xyz = t0.xyz * t1.xyz;
        t1.xy = vec2(M_PI) * vec2(16.0, 4.0);
        t1.xy = vec2(3.0, 1.5) / t1.xy;
        t33 = t35 * t35 + 1.0;
        t1.x = t33 * t1.x;
        t23.x = (-mieG) * mieG + 1.0;
        t12.x = t23.x * t1.y;
        t23.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
        t2.x = dot(vec2(t35), vec2(vec2(mieG, mieG)));
        t23.x = t23.x + (-t2.x);
        t23.x = log2(t23.x);
        t23.x = t23.x * -1.5;
        t23.x = exp2(t23.x);
        t12.x = t23.x * t12.x;
        t33 = t33 * t12.x;
        t33 = t33 / t23.y;
        t0.xyz = vec3(t33) * t0.xyz;
        t0.xyz = t4.xyz * t1.xxx + t0.xyz;
    } else {
        t0.xyz = vec3(0.0, 0.0, 0.0);
    //ENDIF
    }
    t0.xyz = t0.xyz * vec3(vec3(SUN_INTENSITY, SUN_INTENSITY, SUN_INTENSITY));
    tb33 = _global_depth>=t3.x;
    t1.x = t3.x * 4.0;
    t1.x = t1.x / _global_depth;
    t1.x = t1.x * -1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t33 = (tb33) ? t1.x : 1.0;
    t0.xyz = t0.xyz * vec3(_Exposure);
    tb1.xyz = lessThan(t0.xyzx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t0.xy = log2(t2.xz);
    t0.xy = t0.xy * vec2(0.454545468, 0.454545468);
    t0.xy = exp2(t0.xy);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t2.x = (tb1.x) ? t0.x : t2.x;
    t2.y = (tb1.y) ? t0.y : t2.y;
    t0.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = log2(t0.x);
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    t11.x = exp2(t0.y);
    t11.x = (-t11.x) + 1.0;
    t2.z = (tb1.z) ? t0.x : t11.x;
    t0.xyz = t2.xyz * vec3(vec3(_global_alpha, _global_alpha, _global_alpha));
    SV_Target0.xyz = vec3(t33) * t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "GODRAYS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 439 math, 17 textures, 4 branches
Keywords { "GODRAYS_OFF" }
Matrix 0 [_ViewProjInv]
Float 7 [HM]
Float 5 [HR]
Float 4 [M_PI]
Float 14 [RES_MU]
Float 15 [RES_MU_S]
Float 16 [RES_NU]
Float 13 [RES_R]
Float 11 [Rg]
Float 12 [Rt]
Vector 17 [SUN_DIR]
Float 18 [SUN_INTENSITY]
Float 10 [_Exposure]
Vector 22 [_camPos]
Float 19 [_experimentalAtmoScale]
Float 20 [_global_alpha]
Float 21 [_global_depth]
Float 23 [_openglThreshold]
Vector 8 [betaMEx]
Vector 6 [betaR]
Float 9 [mieG]
SetTexture 0 [_Inscatter] 2D 0
SetTexture 1 [_customDepthTexture] 2D 1
"ps_3_0
def c24, -1, 4, 2, -0
def c25, 0.899999976, -9.99999997e-007, 1600, 0.5
def c26, 6.28310013, 0.197500005, 5.34962368, 50
def c27, 1.44269502, 1.51999998, 4, 2.31929994
def c28, -1.05655074, 0.0208350997, -0.0851330012, 0.180141002
def c29, -0.330299497, 0.999866009, -2, 1.57079637
def c30, 0.909090877, 0.74000001, -2, 3
def c31, 0.383170009, -1.44269502, 0, 0
def c32, -9.99999975e-005, 10000, 16, 4
def c33, 1.5, -1.5, -1.41299999, 0.454545468
def c34, 2, 0, -1, 1
dcl_texcoord2 v0.xy
dcl_texcoord3 v1.xyz
dcl_2d s0
dcl_2d s1
texld r0, v0, s1
add r0.y, r0.x, c24.x
dp3 r0.z, v1, v1
dp3 r0.w, v1, c22
add r1.x, r0.w, r0.w
dp3 r1.y, c22, c22
mul r1.z, c11.x, c11.x
mad r1.w, c11.x, -c11.x, r1.y
mul r1.w, r0.z, r1.w
mul r1.w, r1.w, c24.y
mad r1.x, r1.x, r1.x, -r1.w
rsq r1.w, r1.x
rcp r1.w, r1.w
mad r0.w, r0.w, -c24.z, -r1.w
add r0.z, r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0.z, r0.w
cmp r0.z, r1.x, r0.z, c24.x
cmp r0.y, -r0_abs.y, -c24.x, -c24.w
cmp r0.y, -r0.z, r0.y, -c24.w
cmp_pp oC0.w, -r0.y, -c24.x, -c24.w
if_ne r0.y, -r0.y
mov_pp oC0.xyz, -c24.w
else
mad r2.xyw, v0.xyzx, c34.xxzy, c34.zzzw
mov r2.z, r0.x
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp4 r0.x, c3, r2
rcp r0.x, r0.x
mul r2.xyz, r0.x, r3
mul r4.xyz, r0.z, v1
mad r5.xyz, r0.z, v1, c22
dp3 r0.y, r4, r4
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r3.xyz, r3, r0.x, -c22
dp3 r0.x, r3, r3
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.x, -r0.x, r0.y
cmp r0.x, r0.x, c24.w, c24.x
cmp r0.x, -r0.z, -c24.w, r0.x
cmp r0.xyz, r0.x, r2, r5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r1.x, r0.w
mov r2.x, c11.x
add r1.w, r2.x, c23.x
add r1.x, -r1.w, r1.x
mul r2.yzw, r0.w, r0.xxyz
mul r2.yzw, r1.w, r2
cmp r0.xyz, r1.x, r0, r2.yzww
add r2.yzw, r0.xxyz, -c22.xxyz
dp3 r1.x, r2.yzww, r2.yzww
rsq r1.x, r1.x
rcp r3.x, r1.x
mul r2.yzw, r1.x, r2
add r1.x, -r2.x, c12.x
mad r4.y, r1.x, c19.x, r2.x
rsq r1.x, r1.y
rcp r5.z, r1.x
mad r1.x, r2.x, -c25.x, r5.z
add r6.y, r2.x, c22.y
add r7.y, r0.y, c11.x
mov r6.xz, c22
dp3 r1.y, r6, r6
rsq r1.y, r1.y
rcp r7.z, r1.y
mov r5.x, c22.y
mov r5.y, r0.y
mov r7.x, r6.y
cmp r1.xyw, r1.x, r5.xyzz, r7.xyzz
mov r5.xz, c22
mov r5.y, r1.x
dp3 r0.y, r5, r2.yzww
rcp r1.x, r1.w
mul r3.z, r0.y, r1.x
mul r1.x, r1.w, r1.w
mad r1.x, r0.y, r0.y, -r1.x
mad r1.x, r4.y, r4.y, r1.x
rsq r3.w, r1.x
rcp r3.w, r3.w
cmp r1.x, r1.x, -r3.w, c25.y
add r1.x, -r0.y, r1.x
max r3.w, r1.x, -c24.w
add r1.x, -r3.x, r3.w
add r0.y, r0.y, r3.w
rcp r4.w, r4.y
mul r4.z, r0.y, r4.w
add r4.x, -r3.w, r3.x
cmp r0.y, r1.x, c24.w, c24.x
cmp r0.y, -r3.w, -c24.w, r0.y
mov r3.y, r1.w
cmp r6.xyz, r0.y, r3, r4
if_ge r4.y, r6.y
min r1.x, r3.x, -c24.x
mov r0.w, r1.y
mad r7.xyz, r2.yzww, -r1.x, r0.xwzw
mad r0.xzw, r3.w, r2.yyzw, r5.xyyz
cmp r0.xyz, r0.y, r5, r0.xzww
dp3 r0.w, r2.yzww, c17
dp3 r0.x, r0, c17
rcp r0.y, r6.y
mul r0.z, r0.y, r0.x
add r1.x, r2.x, c25.z
add r1.y, -r1.x, r6.y
mul r1.x, r0.y, r1.x
mul r5.w, r1.x, r6.y
mul r5.xyz, r1.x, r7
mov r7.w, r6.y
cmp r5, r1.y, r7, r5
dp3 r1.x, r5, r5
rsq r1.x, r1.x
rcp r1.y, r1.x
dp3 r1.w, r5, r2.yzww
mul r1.w, r1.x, r1.w
dp3 r2.x, r5, c17
mul r2.y, r1.x, r2.x
mov r4.x, c19.x
mul r2.z, r4.x, c5.x
rcp r2.w, r2.z
mul r3.y, r2.w, r5.w
mul r3.y, r3.y, c25.w
rsq r3.y, r3.y
rcp r3.y, r3.y
rcp r3.z, r5.w
mad r6.w, r6.x, r3.z, r6.z
mul r3.yz, r3.y, r6.xzww
cmp r4.zw, -r3.xyyz, -c24.w, -c24.x
cmp r5.xy, r3.yzzw, c24.w, c24.x
add r4.zw, r4, r5.xyxy
mul r5.xyz, r3.yyzw, r3.yyzw
add r3.w, -r4.w, r4.z
mul r5.x, r5.x, c27.x
exp r5.x, r5.x
cmp r3.w, r3.w, -c24.w, r5.x
mad r5.xy, r5.yzzw, c27.y, c27.z
rsq r5.x, r5.x
rsq r5.y, r5.y
rcp r7.x, r5.x
rcp r7.y, r5.y
mad r3.yz, r3_abs, c27.w, r7.xxyw
rcp r5.x, r3.y
rcp r5.y, r3.z
mul r3.yz, r4.xzww, r5.xxyw
mul r4.z, r2.w, -r6.x
add r4.w, r5.w, r5.w
rcp r4.w, r4.w
mad r4.w, r6.x, r4.w, r6.z
mul r4.z, r4.w, r4.z
mul r4.z, r4.z, c27.x
exp r7.y, r4.z
mov r7.xz, -c24.x
mul r3.yz, r3, r7.xxyw
mul r2.z, r2.z, r5.w
mul r2.z, r2.z, c26.x
rsq r2.z, r2.z
rcp r2.z, r2.z
add r4.z, -r5.w, c11.x
mul r2.w, r2.w, r4.z
mul r2.w, r2.w, c27.x
exp r2.w, r2.w
mul r2.z, r2.w, r2.z
dp2add r2.w, r3.yzzw, c34.wzzw, r3.w
mul r2.z, r2.w, r2.z
mul r2.w, r4.x, c7.x
rcp r3.y, r2.w
mul r3.z, r3.y, r5.w
mul r3.z, r3.z, c25.w
rsq r3.z, r3.z
rcp r3.z, r3.z
mul r3.zw, r6, r3.z
cmp r5.xy, -r3.zwzw, -c24.w, -c24.x
cmp r6.yw, r3.xzzw, c24.w, c24.x
add r5.xy, r5, r6.ywzw
mul r8.xyz, r3.zzww, r3.zzww
add r4.x, -r5.y, r5.x
mul r5.z, r8.x, c27.x
exp r5.z, r5.z
cmp r4.x, r4.x, -c24.w, r5.z
mad r6.yw, r8.xyzz, c27.y, c27.z
rsq r5.z, r6.y
rsq r6.y, r6.w
rcp r7.x, r5.z
rcp r7.y, r6.y
mad r3.zw, r3_abs, c27.w, r7.xyxy
rcp r7.x, r3.z
rcp r7.y, r3.w
mul r3.zw, r5.xyxy, r7.xyxy
mul r5.x, r3.y, -r6.x
mul r4.w, r4.w, r5.x
mul r4.w, r4.w, c27.x
exp r7.w, r4.w
mul r3.zw, r3, r7
mul r2.w, r2.w, r5.w
mul r2.w, r2.w, c26.x
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r3.y, r3.y, r4.z
mul r3.y, r3.y, c27.x
exp r3.y, r3.y
mul r2.w, r2.w, r3.y
dp2add r3.y, r3.zwzw, c34.wzzw, r4.x
mul r2.w, r2.w, r3.y
mul r3.yzw, r2.w, c8.xxyz
mad r3.yzw, -c6.xxyz, r2.z, -r3
mul r3.yzw, r3, c27.x
exp_sat r7.xw, r3.y
exp_sat r7.y, r3.z
exp_sat r7.z, r3.w
mad r2.z, r4.y, r4.y, -r1.z
rsq r2.z, r2.z
rcp r4.z, r2.z
mul r2.w, r5.w, r5.w
mad r3.y, r5.w, r5.w, -r1.z
rsq r3.y, r3.y
rcp r3.y, r3.y
mul r3.z, r6.z, r5.w
mad r2.w, r3.z, r3.z, -r2.w
mad r2.w, c11.x, c11.x, r2.w
rcp r3.w, c14.x
mad r5.w, r3.w, -c25.w, c25.w
mul r4.y, r4.z, r4.z
mad r4.w, r3.w, c25.w, c25.w
cmp r6.x, -r2.w, c24.w, c24.x
cmp r6.x, r3.z, -c24.w, r6.x
mov r4.x, c24.x
mov r5.xyz, -c24.xwww
cmp r6, r6.x, r4, r5.xzzw
rcp r8.x, c13.x
mul r8.y, r2.z, r3.y
lrp r9.x, r8.x, c25.w, r8.y
add r2.w, r2.w, r6.y
rsq r2.w, r2.w
rcp r2.w, r2.w
mad r2.w, r3.z, r6.x, r2.w
add r3.y, r3.y, r6.z
rcp r3.y, r3.y
mul r2.w, r2.w, r3.y
add r3.y, -r3.w, c25.w
mad r2.w, r2.w, r3.y, r6.w
rcp r3.z, c15.x
mad r0.x, r0.x, r0.y, c26.y
mul r0.yz, r0.z, c26.xwzw
cmp r0.x, r0.x, r0.z, c28.x
mov_sat r0.z, r0_abs.x
add r3.w, r0_abs.x, c24.x
rcp r6.x, r0_abs.x
cmp r3.w, r3.w, r6.x, -c24.x
mul r0.z, r0.z, r3.w
mul r3.w, r0.z, r0.z
mad r6.x, r3.w, c28.y, c28.z
mad r6.x, r3.w, r6.x, c28.w
mad r6.x, r3.w, r6.x, c29.x
mad r3.w, r3.w, r6.x, c29.y
mul r0.z, r0.z, r3.w
add r3.w, -r0_abs.x, -c24.x
cmp r3.w, r3.w, -c24.w, -c24.x
mad r6.x, r0.z, c29.z, c29.w
mad r0.z, r6.x, r3.w, r0.z
min r3.w, r0.x, -c24.x
cmp r0.x, r3.w, -c24.w, -c24.x
add r3.w, r0.z, r0.z
mad r0.x, r0.x, -r3.w, r0.z
mad r0.x, r0.x, c30.x, c30.y
mul r0.x, r0.x, c25.w
add r0.z, -r3.z, -c24.x
lrp r6.x, r3.z, c25.w, r0.x
add r0.x, r0.w, -c24.x
mul r0.x, r0.x, c25.w
mov r10.xz, c24
add r3.w, r10.x, c16.x
mul r6.y, r0.x, r3.w
frc r6.z, r6.y
add r6.y, -r6.z, r6.y
mad r0.x, r0.x, r3.w, -r6.y
mul r3.w, r9.x, c13.x
mad r6.z, r9.x, c13.x, r10.x
frc r6.w, r3.w
add r6.z, -r6.w, r6.z
add r3.w, r3.w, -r6.w
add r6.x, r6.x, r6.y
rcp r8.y, c16.x
mul r9.y, r6.x, r8.y
mul r2.w, r8.x, r2.w
mad r9.z, r6.z, r8.x, r2.w
mov r9.w, -c24.w
texldl r11, r9.yzww, s0
add r6.x, r6.x, -c24.x
mul r9.x, r8.y, r6.x
texldl r12, r9.xzww, s0
lrp r13, r0.x, r12, r11
mad r11.y, r3.w, r8.x, r2.w
mov r11.xzw, r9.yyww
texldl r12, r11, s0
mov r11.xzw, r9.xyww
texldl r9, r11, s0
lrp r11, r0.x, r9, r12
lrp r9, r6.w, r11, r13
mul r2.w, r1.y, r1.y
mad r1.z, r1.y, r1.y, -r1.z
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.y, r1.w, r1.y
mad r1.w, r1.y, r1.y, -r2.w
mad r1.w, c11.x, c11.x, r1.w
cmp r2.w, -r1.w, c24.w, c24.x
cmp r2.w, r1.y, -c24.w, r2.w
cmp r4, r2.w, r4, r5
mul r2.z, r2.z, r1.z
lrp r3.w, r8.x, c25.w, r2.z
add r1.zw, r1, r4.xyzy
rsq r1.w, r1.w
rcp r1.w, r1.w
mad r1.y, r1.y, r4.x, r1.w
rcp r1.z, r1.z
mul r1.y, r1.z, r1.y
mad r1.y, r1.y, r3.y, r4.w
mad r1.x, r2.x, r1.x, c26.y
mul r1.z, r2.y, c26.z
cmp r1.x, r1.x, r1.z, c28.x
mov_sat r1.z, r1_abs.x
add r1.w, r1_abs.x, c24.x
rcp r2.x, r1_abs.x
cmp r1.w, r1.w, r2.x, -c24.x
mul r1.z, r1.w, r1.z
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c28.y, c28.z
mad r2.x, r1.w, r2.x, c28.w
mad r2.x, r1.w, r2.x, c29.x
mad r1.w, r1.w, r2.x, c29.y
mul r1.z, r1.w, r1.z
add r1.w, -r1_abs.x, -c24.x
cmp r1.w, r1.w, -c24.w, -c24.x
mad r2.x, r1.z, c29.z, c29.w
mad r1.z, r2.x, r1.w, r1.z
min r2.x, r1.x, -c24.x
cmp r1.x, r2.x, -c24.w, -c24.x
add r1.w, r1.z, r1.z
mad r1.x, r1.x, -r1.w, r1.z
mad r1.x, r1.x, c30.x, c30.y
mul r0.z, r0.z, r1.x
mul r0.z, r0.z, c25.w
mad r0.z, r3.z, c25.w, r0.z
mul r1.x, r3.w, c13.x
mad r1.z, r3.w, c13.x, r10.x
frc r1.w, r1.x
add r1.xz, -r1.w, r1
add r0.z, r0.z, r6.y
mul r2.y, r8.y, r0.z
mul r1.y, r8.x, r1.y
mad r2.z, r1.z, r8.x, r1.y
mov r2.w, -c24.w
texldl r4, r2.yzww, s0
add r0.z, r0.z, -c24.x
mul r2.x, r8.y, r0.z
texldl r5, r2.xzww, s0
lrp r6, r0.x, r5, r4
mad r4.y, r1.x, r8.x, r1.y
mov r4.xzw, r2.yyww
texldl r5, r4, s0
mov r4.xzw, r2.xyww
texldl r2, r4, s0
lrp r4, r0.x, r2, r5
lrp r2, r1.w, r4, r6
mad r1, r2, -r7, r9
max r2, r1, -c24.w
mov_sat r0.y, r0.y
mad r0.x, r0.y, c30.z, c30.w
mul r0.y, r0.y, r0.y
mul r0.x, r0.y, r0.x
mul r0.x, r0.x, r2.w
mul r0.xyz, r0.x, r2
add r1.y, r1.x, c32.x
rcp r1.x, r1.x
cmp r1.x, r1.y, r1.x, c32.y
mul r0.xyz, r0, r1.x
rcp r1.x, c6.x
rcp r1.y, c6.y
rcp r1.z, c6.z
mul r1.xyz, r1, c6.x
mul r0.xyz, r0, r1
mov r1.zw, c32
mul r1.xy, r1.zwzw, c4.x
rcp r1.x, r1.x
mul r1.x, r1.x, c30.w
mad r1.z, r0.w, r0.w, -c24.x
rcp r1.y, r1.y
mul r1.y, r1.y, c33.x
mad r1.w, c9.x, -c9.x, -r10.x
mul r1.xy, r1.zwzw, r1
mad r3.yz, c9.x, c9.x, r10_abs.xxzw
dp2add r0.w, r0.w, -c9.x, r3.y
pow r1.w, r0.w, c33.y
mul r0.w, r1.w, r1.y
mul r0.w, r1.z, r0.w
rcp r1.y, r3.z
mul r0.w, r0.w, r1.y
mul r0.xyz, r0.w, r0
mad r0.xyz, r2, r1.x, r0
else
mov_pp r0.xyz, -c24.w
endif
mul r0.xyz, r0, c18.x
add r0.w, -r3.x, c21.x
mul r1.x, r3.x, c24.y
rcp r1.y, c21.x
mul r1.x, r1.y, r1.x
mul r1.x, r1.x, -c27.x
exp r1.x, r1.x
add r1.x, -r1.x, -c24.x
cmp r0.w, r0.w, r1.x, -c24.x
mul r1.xyz, r0, c10.x
mov r2.z, c33.z
mad r0.xyz, r0, c10.x, r2.z
mul r2, r1.xxyy, c31.xyxy
pow r1.x, r2.x, c33.w
exp r1.y, r2.y
add r1.y, -r1.y, -c24.x
cmp r3.x, r0.x, r1.y, r1.x
pow r0.x, r2.z, c33.w
exp r1.x, r2.w
add r1.x, -r1.x, -c24.x
cmp r3.y, r0.y, r1.x, r0.x
mul r0.xy, r1.z, c31
pow r1.x, r0.x, c33.w
exp r0.x, r0.y
add r0.x, -r0.x, -c24.x
cmp r3.z, r0.z, r0.x, r1.x
mul r0.xyz, r3, c20.x
mul_pp oC0.xyz, r0.w, r0
endif

"
}
SubProgram "d3d11 " {
// Stats: 340 math, 1 textures, 4 branches
Keywords { "GODRAYS_OFF" }
SetTexture 0 [_customDepthTexture] 2D 1
SetTexture 1 [_Inscatter] 2D 0
ConstBuffer "$Globals" 480
Matrix 256 [_ViewProjInv]
Float 112 [M_PI]
Float 132 [HR]
Vector 144 [betaR] 3
Float 156 [HM]
Vector 176 [betaMEx] 3
Float 188 [mieG]
Float 192 [_Exposure]
Float 196 [Rg]
Float 200 [Rt]
Float 208 [RES_R]
Float 212 [RES_MU]
Float 216 [RES_MU_S]
Float 220 [RES_NU]
Vector 224 [SUN_DIR] 3
Float 236 [SUN_INTENSITY]
Float 244 [_experimentalAtmoScale]
Float 324 [_global_alpha]
Float 328 [_global_depth]
Vector 368 [_camPos] 3
Float 400 [_openglThreshold]
BindCB  "$Globals" 0
"ps_4_0
root12:acabacaa
eefiecedpiahpfepppbdmggppedjepagcggdoppfabaaaaaanecpaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmmcoaaaaeaaaaaaaldalaaaafjaaaaaeegiocaaaaaaaaaaabkaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
alaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaabiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpbaaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaa
baaaaaaiicaabaaaaaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaabhaaaaaa
aaaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaaj
ccaabaaaabaaaaaaegiccaaaaaaaaaaabhaaaaaaegiccaaaaaaaaaaabhaaaaaa
diaaaaajecaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaa
amaaaaaadcaaaaamicaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaa
bkiacaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiaeadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadbaaaaahicaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaalicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaaeaakaabaiaebaaaaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadhaaaaajecaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaa
aaaaialpckaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadlaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaaabaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaabpaaaeadbkaabaaa
aaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadoaaaaabbfaaaaabdcaaaaapjcaabaaaabaaaaaakgbobaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaeaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaialpdiaaaaaipcaabaaaacaaaaaapgapbaaaabaaaaaaegiocaaa
aaaaaaaabbaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
agaabaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabcaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaaoaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaadaaaaaa
kgakbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaabhaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaaaaaaaajhcaabaaaadaaaaaa
egacbaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaabhaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafjcaabaaaabaaaaaa
agambaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
elaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaa
bkiacaaaaaaaaaaaamaaaaaaakiacaaaaaaaaaaabjaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dhaaaaajhcaabaaaaaaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaa
aaaaaaaabhaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaabaaaaaaaoaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaagaabaaaadaaaaaaaaaaaaakbcaabaaaabaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaal
ccaabaaaaeaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaa
aaaaaaaaamaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaelaaaaafecaabaaaafaaaaaa
bkaabaaaabaaaaaadiaaaaaibcaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaa
abeaaaaaggggggdpdbaaaaahbcaabaaaabaaaaaackaabaaaafaaaaaaakaabaaa
abaaaaaaaaaaaaajccaabaaaagaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaabhaaaaaaaaaaaaaiccaabaaaahaaaaaabkaabaaaaaaaaaaabkiacaaa
aaaaaaaaamaaaaaadgaaaaagfcaabaaaagaaaaaaagiccaaaaaaaaaaabhaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaaf
ecaabaaaahaaaaaabkaabaaaabaaaaaadgaaaaafbcaabaaaahaaaaaabkaabaaa
agaaaaaadgaaaaagbcaabaaaafaaaaaabkiacaaaaaaaaaaabhaaaaaadgaaaaaf
ccaabaaaafaaaaaabkaabaaaaaaaaaaadhaaaaajlcaabaaaabaaaaaaagaabaaa
abaaaaaaegaibaaaahaaaaaaegaibaaaafaaaaaadgaaaaagfcaabaaaafaaaaaa
agiccaaaaaaaaaaabhaaaaaadgaaaaafccaabaaaafaaaaaaakaabaaaabaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaacaaaaaaaoaaaaah
ecaabaaaadaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaaakaabaaaabaaaaaa
bnaaaaahicaabaaaacaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaakbcaabaaaabaaaaaadkaabaaa
acaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaalndhiglfaaaaaaaibcaabaaa
abaaaaaabkaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadeaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaaacaaaaaa
abeaaaaaaaaaaaaaakaabaaaabaaaaaadbaaaaahicaabaaaadaaaaaaakaabaaa
abaaaaaaakaabaaaadaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
dkaabaaaadaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
abaaaaaaaoaaaaahecaabaaaaeaaaaaabkaabaaaaaaaaaaabkaabaaaaeaaaaaa
aaaaaaaibcaabaaaaeaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaadaaaaaa
dgaaaaafccaabaaaadaaaaaadkaabaaaabaaaaaadhaaaaajhcaabaaaagaaaaaa
pgapbaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaabnaaaaahccaabaaa
aaaaaaaabkaabaaaaeaaaaaabkaabaaaagaaaaaabpaaaeadbkaabaaaaaaaaaaa
ddaaaaahccaabaaaaaaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpdgaaaaaf
icaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaia
ebaaaaaaacaaaaaafgafbaaaaaaaaaaamgacbaaaaaaaaaaadcaaaaajlcaabaaa
abaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaaegaibaaaafaaaaaadhaaaaaj
lcaabaaaabaaaaaapgapbaaaacaaaaaaegambaaaabaaaaaaegaibaaaafaaaaaa
baaaaaaiicaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaa
baaaaaaibcaabaaaabaaaaaaegadbaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaa
aaaaaaaiccaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaamiee
dbaaaaahicaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegaabaaaabaaaaaafgafbaaaagaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaaaaaaaaiicaabaaaafaaaaaa
bkiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaamieedgaaaaaficaabaaaaaaaaaaa
bkaabaaaagaaaaaadhaaaaajpcaabaaaaaaaaaaapgapbaaaabaaaaaaegaobaaa
afaaaaaaegaobaaaaaaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaelaaaaaficaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaajccaabaaaaaaaaaaa
bkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaadpbkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaaaoaaaaahicaabaaaabaaaaaaakaabaaaagaaaaaadkaabaaaaaaaaaaa
aaaaaaahicaabaaaagaaaaaadkaabaaaabaaaaaackaabaaaagaaaaaadiaaaaah
gcaabaaaacaaaaaakgakbaaaaaaaaaaakgalbaaaagaaaaaadbaaaaakgcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgagbaaaacaaaaaa
dbaaaaakfcaabaaaaeaaaaaafgagbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaigcaabaaaadaaaaaafgagbaiaebaaaaaaadaaaaaa
agacbaaaaeaaaaaaclaaaaafgcaabaaaadaaaaaafgagbaaaadaaaaaadiaaaaah
ncaabaaaaeaaaaaafgajbaaaacaaaaaafgajbaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaa
akaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaapfcaabaaaaeaaaaaakgalbaaaaeaaaaaaaceaaaaafmipmcdpaaaaaaaa
fmipmcdpaaaaaaaaaceaaaaaaaaaiaeaaaaaaaaaaaaaiaeaaaaaaaaaelaaaaaf
fcaabaaaaeaaaaaaagacbaaaaeaaaaaadcaaaaangcaabaaaacaaaaaafgagbaia
ibaaaaaaacaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaaagacbaaa
aeaaaaaaaoaaaaahgcaabaaaacaaaaaafgagbaaaadaaaaaafgagbaaaacaaaaaa
aoaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaagaaaaaabkaabaaaaaaaaaaa
aaaaaaahccaabaaaadaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
ccaabaaaadaaaaaaakaabaaaagaaaaaabkaabaaaadaaaaaaaaaaaaahccaabaaa
adaaaaaackaabaaaagaaaaaabkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaafaaaaaadkaabaaaabaaaaaa
dgaaaaaifcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
diaaaaahgcaabaaaacaaaaaafgagbaaaacaaaaaaagabbaaaafaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaciapmjeaelaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaaaaaaaaajecaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaaaoaaaaahccaabaaaaaaaaaaackaabaaaadaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaaapaaaaakicaabaaaabaaaaaa
jgafbaaaacaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajecaabaaaaaaaaaaa
dkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahicaabaaa
abaaaaaaabeaaaaaaaaaaadpckaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahgcaabaaaacaaaaaakgalbaaaagaaaaaapgapbaaaabaaaaaa
dbaaaaakfcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
fgagbaaaacaaaaaadbaaaaakdcaabaaaafaaaaaajgafbaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaifcaabaaaaeaaaaaaagacbaia
ebaaaaaaaeaaaaaaagabbaaaafaaaaaaclaaaaaffcaabaaaaeaaaaaaagacbaaa
aeaaaaaadiaaaaahhcaabaaaahaaaaaafgagbaaaacaaaaaafgagbaaaacaaaaaa
dbaaaaahicaabaaaabaaaaaaakaabaaaaeaaaaaackaabaaaaeaaaaaadiaaaaah
icaabaaaadaaaaaaakaabaaaahaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaaabaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaadaaaaaadcaaaaapdcaabaaaafaaaaaajgafbaaaahaaaaaaaceaaaaa
fmipmcdpfmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaa
aaaaaaaaelaaaaafdcaabaaaafaaaaaaegaabaaaafaaaaaadcaaaaangcaabaaa
acaaaaaafgagbaiaibaaaaaaacaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeea
aaaaaaaaagabbaaaafaaaaaaaoaaaaahgcaabaaaacaaaaaaagacbaaaaeaaaaaa
fgagbaaaacaaaaaaaoaaaaaiicaabaaaadaaaaaaakaabaiaebaaaaaaagaaaaaa
ckaabaaaaaaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaa
adaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaadlkklidp
bjaaaaaficaabaaaafaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaaacaaaaaa
fgagbaaaacaaaaaakgalbaaaafaaaaaadiaaaaahccaabaaaadaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaaciapmjeaelaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaah
ecaabaaaaaaaaaaackaabaaaadaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
adaaaaaaapaaaaakccaabaaaacaaaaaajgafbaaaacaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
bkaabaaaacaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadiaaaaaipcaabaaaafaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaadcaaaaampcaabaaaafaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaa
fgafbaaaaaaaaaaaegaobaiaebaaaaaaafaaaaaadiaaaaakpcaabaaaafaaaaaa
egaobaaaafaaaaaaaceaaaaadlkklidpdlkklidpdlkklidpdlkklidpbjaaaaaf
pcaabaaaafaaaaaaegaobaaaafaaaaaaddaaaaakpcaabaaaafaaaaaaegaobaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdcaaaaakccaabaaa
aaaaaaaabkaabaaaaeaaaaaabkaabaaaaeaaaaaackaabaiaebaaaaaaabaaaaaa
elaaaaafecaabaaaaeaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaelaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaagaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaabkiacaaa
aaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaabkaabaaaaaaaaaaadbaaaaah
ecaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaa
abaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaaabaaaaahecaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaalocaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgiicaaaaaaaaaaaanaaaaaaaaaaaaai
icaabaaaagaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaadpdiaaaaah
ccaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaaaeaaaaaaaaaaaaahicaabaaa
aeaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaadpdgaaaaaihcaabaaaagaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaa
abeaaaaaaaaaialpdhaaaaajpcaabaaaahaaaaaakgakbaaaabaaaaaaigaobaaa
agaaaaaaegaobaaaaeaaaaaaaoaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaa
ckaabaaaaeaaaaaaaoaaaaalhcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegiccaaaaaaaaaaaanaaaaaaaaaaaaalhcaabaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaaaceaaaaaaaaaiadpaaaaaadpaaaaiadpaaaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaa
adaaaaaaaaaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaafgagbaaaahaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaahaaaaaabkaabaaaaaaaaaaaaoaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaiaaaaaadkaabaaaahaaaaaadeaaaaahecaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaahbdneklodiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaabodakleaddaaaaaiicaabaaaaaaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaaabaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaacaaaaaadkaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajccaabaaaacaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajccaabaaa
acaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaaj
icaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaadiphhpdp
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadbaaaaai
ecaabaaaacaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaadcaaaaaj
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
abaaaaahccaabaaaacaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaa
ddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadhaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidp
abeaaaaakehadndpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaiaaaaaa
dkaabaaaadaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadp
aaaaaaaiicaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialp
diaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaebaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaabkaabaiaebaaaaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaakecaabaaa
abaaaaaackaabaaaabaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialp
ebaaaaafecaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaaiecaabaaaabaaaaaa
ckaabaaaabaaaaaaakiacaaaaaaaaaaaanaaaaaaebaaaaafecaabaaaacaaaaaa
dkaabaaaabaaaaaaaoaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaa
aaaaaaaaanaaaaaabkaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaaaoaaaaaiccaabaaa
ahaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaaoaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaaaaaaaaahecaabaaa
ahaaaaaackaabaaaabaaaaaabkaabaaaaaaaaaaaeiaaaaalpcaabaaaajaaaaaa
jgafbaaaahaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaaiecaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
aaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaai
bcaabaaaahaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaeiaaaaal
pcaabaaaakaaaaaaigaabaaaahaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahpcaabaaaakaaaaaapgapbaaaaaaaaaaaegaobaaa
akaaaaaadcaaaaajpcaabaaaajaaaaaaegaobaaaajaaaaaakgakbaaaabaaaaaa
egaobaaaakaaaaaaaaaaaaahicaabaaaahaaaaaackaabaaaacaaaaaabkaabaaa
aaaaaaaaeiaaaaalpcaabaaaakaaaaaangafbaaaahaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaamgaabaaa
ahaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaahaaaaaapgapbaaaaaaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaa
ahaaaaaaegaobaaaakaaaaaakgakbaaaabaaaaaaegaobaaaahaaaaaaaaaaaaai
ccaabaaaaaaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
pcaabaaaahaaaaaapgapbaaaabaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaa
ahaaaaaaegaobaaaajaaaaaafgafbaaaaaaaaaaaegaobaaaahaaaaaadcaaaaam
ccaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaa
amaaaaaabkaabaaaabaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakecaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaabkaabaia
ebaaaaaaabaaaaaadcaaaaalecaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
bkiacaaaaaaaaaaaamaaaaaackaabaaaaaaaaaaadbaaaaahccaabaaaabaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaackaabaaaaaaaaaaaabaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaa
bkaabaaaabaaaaaadhaaaaajpcaabaaaagaaaaaafgafbaaaabaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaaaoaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
ckaabaaaaeaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaa
aiaaaaaackaabaaaadaaaaaaaaaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaa
kgajbaaaagaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaagaaaaaackaabaaaaaaaaaaa
aoaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaiaaaaaadkaabaaaagaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabodakleaddaaaaaiecaabaaa
aaaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaa
abaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaa
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaadbaaaaaiecaabaaaacaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaa
aaaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahbcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaaddaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaacolkgidpabeaaaaakehadndpdiaaaaahbcaabaaaaaaaaaaackaabaaa
aiaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdkaabaaaadaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaakccaabaaaabaaaaaabkaabaaa
abaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpebaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaebaaaaaficaabaaaabaaaaaackaabaaaaaaaaaaa
aoaaaaaikcaabaaaabaaaaaafganbaaaabaaaaaaagiacaaaaaaaaaaaanaaaaaa
bkaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaacaaaaaaaoaaaaaiccaabaaaaeaaaaaaakaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaaaaaaaahmcaabaaaaeaaaaaafganbaaa
abaaaaaafgafbaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaajgafbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaaeaaaaaa
akaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaeiaaaaalpcaabaaaaiaaaaaa
igaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaaiaaaaaapgapbaaaaaaaaaaaegaobaaaaiaaaaaadcaaaaaj
pcaabaaaagaaaaaaegaobaaaagaaaaaakgakbaaaabaaaaaaegaobaaaaiaaaaaa
eiaaaaalpcaabaaaaiaaaaaangafbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaamgaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
aeaaaaaapgapbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaaiaaaaaakgakbaaaabaaaaaaegaobaaaaeaaaaaaaaaaaaaibcaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaa
aeaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaa
egaobaaaagaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaiaebaaaaaaaaaaaaaaegaobaaaafaaaaaaegaobaaaahaaaaaa
deaaaaakpcaabaaaaeaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadicaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaeiecdcaaaaajecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaeaaaaaadiaaaaah
ocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaaaeaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaagaabaaaaaaaaaaaaoaaaaajhcaabaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaldcaabaaaabaaaaaaagiacaaa
aaaaaaaaahaaaaaaaceaaaaaaaaaiaebaaaaiaeaaaaaaaaaaaaaaaaaaoaaaaak
dcaabaaaabaaaaaaaceaaaaaaaaaeaeaaaaamadpaaaaaaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaamecaabaaaabaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaa
dkiacaaaaaaaaaaaalaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaa
ckaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaaomcaabaaaabaaaaaapgipcaaa
aaaaaaaaalaaaaaapgipcaaaaaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaiadpaaaaaaeaapaaaaaibcaabaaaacaaaaaapgapbaaaacaaaaaapgipcaaa
aaaaaaaaalaaaaaaaaaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaaakaabaia
ebaaaaaaacaaaaaacpaaaaafecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaamalpbjaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaeaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
bcaaaaabdgaaaaaihcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaabfaaaaabdiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaa
aaaaaaaaaoaaaaaabnaaaaaiicaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaa
akaabaaaadaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaiaeaaoaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaa
beaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaadlkklilp
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaamaaaaaadbaaaaakhcaabaaa
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
diaaaaaihcaabaaaaaaaaaaaegacbaaaacaaaaaafgifcaaaaaaaaaaabeaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_OFF" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "GODRAYS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "GODRAYS_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 453 math, 18 textures, 4 branches
Keywords { "GODRAYS_ON" }
Matrix 0 [_ViewProjInv]
Float 7 [HM]
Float 5 [HR]
Float 4 [M_PI]
Float 14 [RES_MU]
Float 15 [RES_MU_S]
Float 16 [RES_NU]
Float 13 [RES_R]
Float 11 [Rg]
Float 12 [Rt]
Vector 17 [SUN_DIR]
Float 18 [SUN_INTENSITY]
Float 10 [_Exposure]
Vector 22 [_camPos]
Float 19 [_experimentalAtmoScale]
Float 20 [_global_alpha]
Float 21 [_global_depth]
Float 23 [_openglThreshold]
Vector 8 [betaMEx]
Vector 6 [betaR]
Float 9 [mieG]
SetTexture 0 [_Inscatter] 2D 0
SetTexture 1 [_customDepthTexture] 2D 1
SetTexture 2 [_godrayDepthTexture] 2D 2
"ps_3_0
def c24, -1, 4, 2, -0
def c25, 0.899999976, -9.99999997e-007, 1600, 0.5
def c26, 6.28310013, 0.197500005, 5.34962368, 50
def c27, 1.44269502, 1.51999998, 4, 2.31929994
def c28, -1.05655074, 0.0208350997, -0.0851330012, 0.180141002
def c29, -0.330299497, 0.999866009, -2, 1.57079637
def c30, 0.909090877, 0.74000001, -2, 3
def c31, 0.383170009, -1.44269502, 0, 0
def c32, -9.99999975e-005, 10000, 16, 4
def c33, 1.5, -1.5, -1.41299999, 0.454545468
def c34, 2, 0, -1, 1
dcl_texcoord2 v0.xy
dcl_texcoord3 v1.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
texld r0, v0, s1
add r0.y, r0.x, c24.x
dp3 r0.z, v1, v1
dp3 r0.w, v1, c22
add r1.x, r0.w, r0.w
dp3 r1.y, c22, c22
mul r1.z, c11.x, c11.x
mad r1.w, c11.x, -c11.x, r1.y
mul r1.w, r0.z, r1.w
mul r1.w, r1.w, c24.y
mad r1.x, r1.x, r1.x, -r1.w
rsq r1.w, r1.x
rcp r1.w, r1.w
mad r0.w, r0.w, -c24.z, -r1.w
add r1.w, r0.z, r0.z
rcp r1.w, r1.w
mul r0.w, r0.w, r1.w
cmp r0.w, r1.x, r0.w, c24.x
cmp r1.x, -r0_abs.y, -c24.x, -c24.w
cmp r1.x, -r0.w, r1.x, -c24.w
cmp_pp oC0.w, -r1.x, -c24.x, -c24.w
if_ne r1.x, -r1.x
mov_pp oC0.xyz, -c24.w
else
mov r2.xyz, c22
mul r3.xyz, r2.zxyw, c17.yzxw
mad r2.xzw, r2.yyzx, c17.zyxy, -r3.xyyz
nrm r3.xyz, r2.xzww
rsq r0.z, r0.z
mul r2.xzw, r0.z, v1.xyyz
dp3 r0.z, r3, r2.xzww
add r0.z, -r0_abs.z, -c24.x
texld r3, v0, s2
add r1.x, -r0.x, r3.x
mad r0.z, r0.z, r1.x, r0.x
cmp r0.y, r0.y, c24.w, c24.x
cmp r0.y, r1.x, -c24.w, r0.y
cmp r0.y, -r3.x, -c24.w, r0.y
cmp r3.z, r0.y, r0.x, r0.z
mad r3.xyw, v0.xyzx, c34.xxzy, c34.zzzw
dp4 r0.x, c0, r3
dp4 r0.y, c1, r3
dp4 r0.z, c2, r3
dp4 r1.x, c3, r3
rcp r1.x, r1.x
mul r2.xzw, r0.xyyz, r1.x
mul r3.xyz, r0.w, v1
mad r4.xyz, r0.w, v1, c22
dp3 r1.w, r3, r3
rsq r1.w, r1.w
rcp r1.w, r1.w
mad r0.xyz, r0, r1.x, -c22
dp3 r0.x, r0, r0
rsq r0.x, r0.x
rcp r0.x, r0.x
add r0.x, -r0.x, r1.w
cmp r0.x, r0.x, c24.w, c24.x
cmp r0.x, -r0.w, -c24.w, r0.x
cmp r0.xyz, r0.x, r2.xzww, r4
dp3 r0.w, r0, r0
rsq r0.w, r0.w
rcp r1.x, r0.w
mov r2.x, c11.x
add r1.w, r2.x, c23.x
add r1.x, -r1.w, r1.x
mul r3.xyz, r0.w, r0
mul r3.xyz, r1.w, r3
cmp r0.xyz, r1.x, r0, r3
add r3.xyz, r0, -c22
dp3 r1.x, r3, r3
rsq r1.x, r1.x
rcp r4.x, r1.x
mul r3.xyz, r1.x, r3
add r1.x, -r2.x, c12.x
mad r5.y, r1.x, c19.x, r2.x
rsq r1.x, r1.y
rcp r6.z, r1.x
mad r1.x, r2.x, -c25.x, r6.z
add r7.y, r2.y, c11.x
add r8.y, r0.y, c11.x
mov r7.xz, c22
dp3 r1.y, r7, r7
rsq r1.y, r1.y
rcp r8.z, r1.y
mov r6.x, c22.y
mov r6.y, r0.y
mov r8.x, r7.y
cmp r1.xyw, r1.x, r6.xyzz, r8.xyzz
mov r6.xz, c22
mov r6.y, r1.x
dp3 r0.y, r6, r3
rcp r1.x, r1.w
mul r4.z, r0.y, r1.x
mul r1.x, r1.w, r1.w
mad r1.x, r0.y, r0.y, -r1.x
mad r1.x, r5.y, r5.y, r1.x
rsq r2.y, r1.x
rcp r2.y, r2.y
cmp r1.x, r1.x, -r2.y, c25.y
add r1.x, -r0.y, r1.x
max r2.y, r1.x, -c24.w
add r1.x, -r4.x, r2.y
add r0.y, r0.y, r2.y
rcp r2.z, r5.y
mul r5.z, r0.y, r2.z
add r5.x, -r2.y, r4.x
cmp r0.y, r1.x, c24.w, c24.x
cmp r0.y, -r2.y, -c24.w, r0.y
mov r4.y, r1.w
cmp r7.xyz, r0.y, r4, r5
if_ge r5.y, r7.y
min r1.x, r4.x, -c24.x
mov r0.w, r1.y
mad r8.xyz, r3, -r1.x, r0.xwzw
mad r0.xzw, r2.y, r3.xyyz, r6.xyyz
cmp r0.xyz, r0.y, r6, r0.xzww
dp3 r0.w, r3, c17
dp3 r0.x, r0, c17
rcp r0.y, r7.y
mul r0.z, r0.y, r0.x
add r1.x, r2.x, c25.z
add r1.y, -r1.x, r7.y
mul r1.x, r0.y, r1.x
mul r2.w, r1.x, r7.y
mul r2.xyz, r1.x, r8
mov r8.w, r7.y
cmp r2, r1.y, r8, r2
dp3 r1.x, r2, r2
rsq r1.x, r1.x
rcp r1.y, r1.x
dp3 r1.w, r2, r3
mul r1.w, r1.x, r1.w
dp3 r2.x, r2, c17
mul r2.y, r1.x, r2.x
mov r3.x, c19.x
mul r2.z, r3.x, c5.x
rcp r3.y, r2.z
mul r3.z, r2.w, r3.y
mul r3.z, r3.z, c25.w
rsq r3.z, r3.z
rcp r3.z, r3.z
rcp r3.w, r2.w
mad r7.w, r7.x, r3.w, r7.z
mul r3.zw, r3.z, r7
cmp r4.yz, -r3.xzww, -c24.w, -c24.x
cmp r5.xz, r3.zyww, c24.w, c24.x
add r4.yz, r4, r5.xxzw
mul r5.xzw, r3.zyzw, r3.zyzw
add r4.w, -r4.z, r4.y
mul r5.x, r5.x, c27.x
exp r5.x, r5.x
cmp r4.w, r4.w, -c24.w, r5.x
mad r5.xz, r5.zyww, c27.y, c27.z
rsq r5.x, r5.x
rsq r5.z, r5.z
rcp r6.x, r5.x
rcp r6.y, r5.z
mad r3.zw, r3_abs, c27.w, r6.xyxy
rcp r6.x, r3.z
rcp r6.y, r3.w
mul r3.zw, r4.xyyz, r6.xyxy
mul r4.y, r3.y, -r7.x
add r4.z, r2.w, r2.w
rcp r4.z, r4.z
mad r4.z, r7.x, r4.z, r7.z
mul r4.y, r4.z, r4.y
mul r4.y, r4.y, c27.x
exp r6.y, r4.y
mov r6.xz, -c24.x
mul r3.zw, r3, r6.xyxy
mul r2.z, r2.z, r2.w
mul r2.z, r2.z, c26.x
rsq r2.z, r2.z
rcp r2.z, r2.z
add r4.y, -r2.w, c11.x
mul r3.y, r3.y, r4.y
mul r3.y, r3.y, c27.x
exp r3.y, r3.y
mul r2.z, r2.z, r3.y
dp2add r3.y, r3.zwzw, c34.wzzw, r4.w
mul r2.z, r2.z, r3.y
mul r3.x, r3.x, c7.x
rcp r3.y, r3.x
mul r3.xz, r2.w, r3.xyyw
mul r3.z, r3.z, c25.w
rsq r3.z, r3.z
rcp r3.z, r3.z
mul r3.zw, r7, r3.z
cmp r5.xz, -r3.zyww, -c24.w, -c24.x
cmp r6.xy, r3.zwzw, c24.w, c24.x
add r5.xz, r5, r6.xyyw
mul r8.xyz, r3.zzww, r3.zzww
add r4.w, -r5.z, r5.x
mul r5.w, r8.x, c27.x
exp r5.w, r5.w
cmp r4.w, r4.w, -c24.w, r5.w
mad r6.xy, r8.yzzw, c27.y, c27.z
rsq r5.w, r6.x
rsq r6.x, r6.y
rcp r8.x, r5.w
rcp r8.y, r6.x
mad r3.zw, r3_abs, c27.w, r8.xyxy
rcp r6.x, r3.z
rcp r6.y, r3.w
mul r3.zw, r5.xyxz, r6.xyxy
mul r5.x, r3.y, -r7.x
mul r4.z, r4.z, r5.x
mul r4.z, r4.z, c27.x
exp r6.w, r4.z
mul r3.zw, r3, r6
mul r3.x, r3.x, c26.x
rsq r3.x, r3.x
rcp r3.x, r3.x
mul r3.y, r3.y, r4.y
mul r3.y, r3.y, c27.x
exp r3.y, r3.y
mul r3.x, r3.y, r3.x
dp2add r3.y, r3.zwzw, c34.wzzw, r4.w
mul r3.x, r3.y, r3.x
mul r3.xyz, r3.x, c8
mad r3.xyz, -c6, r2.z, -r3
mul r3.xyz, r3, c27.x
exp_sat r6.xw, r3.x
exp_sat r6.y, r3.y
exp_sat r6.z, r3.z
mad r2.z, r5.y, r5.y, -r1.z
rsq r2.z, r2.z
rcp r3.z, r2.z
mul r4.y, r2.w, r2.w
mad r4.z, r2.w, r2.w, -r1.z
rsq r4.z, r4.z
rcp r4.z, r4.z
mul r2.w, r7.z, r2.w
mad r4.y, r2.w, r2.w, -r4.y
mad r4.y, c11.x, c11.x, r4.y
rcp r4.w, c14.x
mad r5.w, r4.w, -c25.w, c25.w
mul r3.y, r3.z, r3.z
mad r3.w, r4.w, c25.w, c25.w
cmp r7.x, -r4.y, c24.w, c24.x
cmp r7.x, r2.w, -c24.w, r7.x
mov r3.x, c24.x
mov r5.xyz, -c24.xwww
cmp r7, r7.x, r3, r5.xzzw
rcp r8.x, c13.x
mul r8.y, r2.z, r4.z
lrp r9.x, r8.x, c25.w, r8.y
add r4.y, r4.y, r7.y
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r2.w, r2.w, r7.x, r4.y
add r4.y, r4.z, r7.z
rcp r4.y, r4.y
mul r2.w, r2.w, r4.y
add r4.y, -r4.w, c25.w
mad r2.w, r2.w, r4.y, r7.w
rcp r4.z, c15.x
mad r0.x, r0.x, r0.y, c26.y
mul r0.yz, r0.z, c26.xwzw
cmp r0.x, r0.x, r0.z, c28.x
mov_sat r0.z, r0_abs.x
add r4.w, r0_abs.x, c24.x
rcp r7.x, r0_abs.x
cmp r4.w, r4.w, r7.x, -c24.x
mul r0.z, r0.z, r4.w
mul r4.w, r0.z, r0.z
mad r7.x, r4.w, c28.y, c28.z
mad r7.x, r4.w, r7.x, c28.w
mad r7.x, r4.w, r7.x, c29.x
mad r4.w, r4.w, r7.x, c29.y
mul r0.z, r0.z, r4.w
add r4.w, -r0_abs.x, -c24.x
cmp r4.w, r4.w, -c24.w, -c24.x
mad r7.x, r0.z, c29.z, c29.w
mad r0.z, r7.x, r4.w, r0.z
min r4.w, r0.x, -c24.x
cmp r0.x, r4.w, -c24.w, -c24.x
add r4.w, r0.z, r0.z
mad r0.x, r0.x, -r4.w, r0.z
mad r0.x, r0.x, c30.x, c30.y
mul r0.x, r0.x, c25.w
add r0.z, -r4.z, -c24.x
lrp r7.x, r4.z, c25.w, r0.x
add r0.x, r0.w, -c24.x
mul r0.x, r0.x, c25.w
mov r10.xz, c24
add r4.w, r10.x, c16.x
mul r7.y, r0.x, r4.w
frc r7.z, r7.y
add r7.y, -r7.z, r7.y
mad r0.x, r0.x, r4.w, -r7.y
mul r4.w, r9.x, c13.x
mad r7.z, r9.x, c13.x, r10.x
frc r7.w, r4.w
add r7.z, -r7.w, r7.z
add r4.w, r4.w, -r7.w
add r7.x, r7.x, r7.y
rcp r8.y, c16.x
mul r9.y, r7.x, r8.y
mul r2.w, r8.x, r2.w
mad r9.z, r7.z, r8.x, r2.w
mov r9.w, -c24.w
texldl r11, r9.yzww, s0
add r7.x, r7.x, -c24.x
mul r9.x, r8.y, r7.x
texldl r12, r9.xzww, s0
lrp r13, r0.x, r12, r11
mad r11.y, r4.w, r8.x, r2.w
mov r11.xzw, r9.yyww
texldl r12, r11, s0
mov r11.xzw, r9.xyww
texldl r9, r11, s0
lrp r11, r0.x, r9, r12
lrp r9, r7.w, r11, r13
mul r2.w, r1.y, r1.y
mad r1.z, r1.y, r1.y, -r1.z
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.y, r1.w, r1.y
mad r1.w, r1.y, r1.y, -r2.w
mad r1.w, c11.x, c11.x, r1.w
cmp r2.w, -r1.w, c24.w, c24.x
cmp r2.w, r1.y, -c24.w, r2.w
cmp r3, r2.w, r3, r5
mul r2.z, r2.z, r1.z
lrp r4.w, r8.x, c25.w, r2.z
add r1.zw, r1, r3.xyzy
rsq r1.w, r1.w
rcp r1.w, r1.w
mad r1.y, r1.y, r3.x, r1.w
rcp r1.z, r1.z
mul r1.y, r1.z, r1.y
mad r1.y, r1.y, r4.y, r3.w
mad r1.x, r2.x, r1.x, c26.y
mul r1.z, r2.y, c26.z
cmp r1.x, r1.x, r1.z, c28.x
mov_sat r1.z, r1_abs.x
add r1.w, r1_abs.x, c24.x
rcp r2.x, r1_abs.x
cmp r1.w, r1.w, r2.x, -c24.x
mul r1.z, r1.w, r1.z
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c28.y, c28.z
mad r2.x, r1.w, r2.x, c28.w
mad r2.x, r1.w, r2.x, c29.x
mad r1.w, r1.w, r2.x, c29.y
mul r1.z, r1.w, r1.z
add r1.w, -r1_abs.x, -c24.x
cmp r1.w, r1.w, -c24.w, -c24.x
mad r2.x, r1.z, c29.z, c29.w
mad r1.z, r2.x, r1.w, r1.z
min r2.x, r1.x, -c24.x
cmp r1.x, r2.x, -c24.w, -c24.x
add r1.w, r1.z, r1.z
mad r1.x, r1.x, -r1.w, r1.z
mad r1.x, r1.x, c30.x, c30.y
mul r0.z, r0.z, r1.x
mul r0.z, r0.z, c25.w
mad r0.z, r4.z, c25.w, r0.z
mul r1.x, r4.w, c13.x
mad r1.z, r4.w, c13.x, r10.x
frc r1.w, r1.x
add r1.xz, -r1.w, r1
add r0.z, r0.z, r7.y
mul r2.y, r8.y, r0.z
mul r1.y, r8.x, r1.y
mad r2.z, r1.z, r8.x, r1.y
mov r2.w, -c24.w
texldl r3, r2.yzww, s0
add r0.z, r0.z, -c24.x
mul r2.x, r8.y, r0.z
texldl r5, r2.xzww, s0
lrp r7, r0.x, r5, r3
mad r3.y, r1.x, r8.x, r1.y
mov r3.xzw, r2.yyww
texldl r5, r3, s0
mov r3.xzw, r2.xyww
texldl r2, r3, s0
lrp r3, r0.x, r2, r5
lrp r2, r1.w, r3, r7
mad r1, r2, -r6, r9
max r2, r1, -c24.w
mov_sat r0.y, r0.y
mad r0.x, r0.y, c30.z, c30.w
mul r0.y, r0.y, r0.y
mul r0.x, r0.y, r0.x
mul r0.x, r0.x, r2.w
mul r0.xyz, r0.x, r2
add r1.y, r1.x, c32.x
rcp r1.x, r1.x
cmp r1.x, r1.y, r1.x, c32.y
mul r0.xyz, r0, r1.x
rcp r1.x, c6.x
rcp r1.y, c6.y
rcp r1.z, c6.z
mul r1.xyz, r1, c6.x
mul r0.xyz, r0, r1
mov r1.zw, c32
mul r1.xy, r1.zwzw, c4.x
rcp r1.x, r1.x
mul r1.x, r1.x, c30.w
mad r1.z, r0.w, r0.w, -c24.x
rcp r1.y, r1.y
mul r1.y, r1.y, c33.x
mad r1.w, c9.x, -c9.x, -r10.x
mul r1.xy, r1.zwzw, r1
mad r3.xy, c9.x, c9.x, r10_abs.xzzw
dp2add r0.w, r0.w, -c9.x, r3.x
pow r1.w, r0.w, c33.y
mul r0.w, r1.w, r1.y
mul r0.w, r1.z, r0.w
rcp r1.y, r3.y
mul r0.w, r0.w, r1.y
mul r0.xyz, r0.w, r0
mad r0.xyz, r2, r1.x, r0
else
mov_pp r0.xyz, -c24.w
endif
mul r0.xyz, r0, c18.x
add r0.w, -r4.x, c21.x
mul r1.x, r4.x, c24.y
rcp r1.y, c21.x
mul r1.x, r1.y, r1.x
mul r1.x, r1.x, -c27.x
exp r1.x, r1.x
add r1.x, -r1.x, -c24.x
cmp r0.w, r0.w, r1.x, -c24.x
mul r1.xyz, r0, c10.x
mov r2.z, c33.z
mad r0.xyz, r0, c10.x, r2.z
mul r2, r1.xxyy, c31.xyxy
pow r1.x, r2.x, c33.w
exp r1.y, r2.y
add r1.y, -r1.y, -c24.x
cmp r3.x, r0.x, r1.y, r1.x
pow r0.x, r2.z, c33.w
exp r1.x, r2.w
add r1.x, -r1.x, -c24.x
cmp r3.y, r0.y, r1.x, r0.x
mul r0.xy, r1.z, c31
pow r1.x, r0.x, c33.w
exp r0.x, r0.y
add r0.x, -r0.x, -c24.x
cmp r3.z, r0.z, r0.x, r1.x
mul r0.xyz, r3, c20.x
mul_pp oC0.xyz, r0.w, r0
endif

"
}
SubProgram "d3d11 " {
// Stats: 357 math, 2 textures, 4 branches
Keywords { "GODRAYS_ON" }
SetTexture 0 [_customDepthTexture] 2D 1
SetTexture 1 [_godrayDepthTexture] 2D 2
SetTexture 2 [_Inscatter] 2D 0
ConstBuffer "$Globals" 480
Matrix 256 [_ViewProjInv]
Float 112 [M_PI]
Float 132 [HR]
Vector 144 [betaR] 3
Float 156 [HM]
Vector 176 [betaMEx] 3
Float 188 [mieG]
Float 192 [_Exposure]
Float 196 [Rg]
Float 200 [Rt]
Float 208 [RES_R]
Float 212 [RES_MU]
Float 216 [RES_MU_S]
Float 220 [RES_NU]
Vector 224 [SUN_DIR] 3
Float 236 [SUN_INTENSITY]
Float 244 [_experimentalAtmoScale]
Float 324 [_global_alpha]
Float 328 [_global_depth]
Vector 368 [_camPos] 3
Float 400 [_openglThreshold]
BindCB  "$Globals" 0
"ps_4_0
root12:adabadaa
eefiecedhamidgkeiflhehngieelecnlolakcnniabaaaaaacidcaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefccadbaaaaeaaaaaaaeiamaaaafjaaaaaeegiocaaaaaaaaaaabkaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaabiaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
baaaaaahecaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaabaaaaaai
icaabaaaaaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaabhaaaaaaaaaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaajccaabaaa
abaaaaaaegiccaaaaaaaaaaabhaaaaaaegiccaaaaaaaaaaabhaaaaaadiaaaaaj
ecaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaa
dcaaaaamicaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiaeadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadbaaaaahicaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaalicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaea
akaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaialp
dkaabaaaaaaaaaaadbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaa
aaaaaaaadlaaaaaficaabaaaabaaaaaaakaabaaaabaaaaaaabaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaabpaaaeadbkaabaaaaaaaaaaa
dgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaabbfaaaaabdiaaaaajhcaabaaaacaaaaaajgiecaaaaaaaaaaaaoaaaaaa
cgijcaaaaaaaaaaabhaaaaaadcaaaaamhcaabaaaacaaaaaajgiecaaaaaaaaaaa
bhaaaaaacgijcaaaaaaaaaaaaoaaaaaaegacbaiaebaaaaaaacaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaafgafbaaaaaaaaaaa
egacbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
hcaabaaaadaaaaaafgafbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahccaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaaiccaabaaaaaaaaaaa
bkaabaiambaaaaaaaaaaaaaaabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
ogbkbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadbaaaaahecaabaaa
aaaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaaaaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadbaaaaahicaabaaaabaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaaakaabaaa
acaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaabaaaaaa
akaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaapgcaabaaaaaaaaaaakgblbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadiaaaaaipcaabaaaacaaaaaakgakbaaaaaaaaaaaegiocaaa
aaaaaaaabbaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaabaaaaaaa
fgafbaaaaaaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaa
aaaaaaaabcaaaaaaagaabaaaaaaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaabdaaaaaaaoaaaaahhcaabaaa
aaaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaapgapbaaa
aaaaaaaaegbcbaaaadaaaaaaegiccaaaaaaaaaaabhaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaaaaaaaaabhaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaajicaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaa
akiacaaaaaaaaaaabjaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
dkaabaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadhaaaaajhcaabaaaaaaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegiccaiaebaaaaaaaaaaaaaabhaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaa
adaaaaaaakaabaaaabaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
agaabaaaadaaaaaaaaaaaaakbcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
amaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaalccaabaaaaeaaaaaaakaabaaa
abaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaaaaaaaaaaamaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaaelaaaaafecaabaaaafaaaaaabkaabaaaabaaaaaadiaaaaai
bcaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaaabeaaaaaggggggdpdbaaaaah
bcaabaaaabaaaaaackaabaaaafaaaaaaakaabaaaabaaaaaaaaaaaaajccaabaaa
agaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaabhaaaaaaaaaaaaai
ccaabaaaahaaaaaabkaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaadgaaaaag
fcaabaaaagaaaaaaagiccaaaaaaaaaaabhaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaafecaabaaaahaaaaaabkaabaaa
abaaaaaadgaaaaafbcaabaaaahaaaaaabkaabaaaagaaaaaadgaaaaagbcaabaaa
afaaaaaabkiacaaaaaaaaaaabhaaaaaadgaaaaafccaabaaaafaaaaaabkaabaaa
aaaaaaaadhaaaaajlcaabaaaabaaaaaaagaabaaaabaaaaaaegaibaaaahaaaaaa
egaibaaaafaaaaaadgaaaaagfcaabaaaafaaaaaaagiccaaaaaaaaaaabhaaaaaa
dgaaaaafccaabaaaafaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaacaaaaaaaoaaaaahecaabaaaadaaaaaabkaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
aeaaaaaabkaabaaaaeaaaaaaakaabaaaabaaaaaabnaaaaahicaabaaaacaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadhaaaaakbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaalndhiglfaaaaaaaibcaabaaaabaaaaaabkaabaiaebaaaaaa
aaaaaaaaakaabaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadbaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaaakaabaaa
abaaaaaadbaaaaahicaabaaaadaaaaaaakaabaaaabaaaaaaakaabaaaadaaaaaa
abaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahecaabaaa
aeaaaaaabkaabaaaaaaaaaaabkaabaaaaeaaaaaaaaaaaaaibcaabaaaaeaaaaaa
akaabaiaebaaaaaaabaaaaaaakaabaaaadaaaaaadgaaaaafccaabaaaadaaaaaa
dkaabaaaabaaaaaadhaaaaajhcaabaaaagaaaaaapgapbaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaabnaaaaahccaabaaaaaaaaaaabkaabaaaaeaaaaaa
bkaabaaaagaaaaaabpaaaeadbkaabaaaaaaaaaaaddaaaaahccaabaaaaaaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaaaaaaaaabkaabaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaafgafbaaa
aaaaaaaamgacbaaaaaaaaaaadcaaaaajlcaabaaaabaaaaaaagaabaaaabaaaaaa
egaibaaaacaaaaaaegaibaaaafaaaaaadhaaaaajlcaabaaaabaaaaaapgapbaaa
acaaaaaaegambaaaabaaaaaaegaibaaaafaaaaaabaaaaaaiicaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaaoaaaaaabaaaaaaibcaabaaaabaaaaaa
egadbaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaaaaaaaaaiccaabaaaabaaaaaa
bkiacaaaaaaaaaaaamaaaaaaabeaaaaaaaaamieedbaaaaahicaabaaaabaaaaaa
bkaabaaaagaaaaaabkaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaa
abaaaaaafgafbaaaagaaaaaadiaaaaahhcaabaaaafaaaaaaegacbaaaaaaaaaaa
fgafbaaaabaaaaaaaaaaaaaiicaabaaaafaaaaaabkiacaaaaaaaaaaaamaaaaaa
abeaaaaaaaaamieedgaaaaaficaabaaaaaaaaaaabkaabaaaagaaaaaadhaaaaaj
pcaabaaaaaaaaaaapgapbaaaabaaaaaaegaobaaaafaaaaaaegaobaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaelaaaaaf
icaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaaoaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaajccaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
bkiacaaaaaaaaaaaapaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaadp
bkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahicaabaaa
abaaaaaaakaabaaaagaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaagaaaaaa
dkaabaaaabaaaaaackaabaaaagaaaaaadiaaaaahgcaabaaaacaaaaaakgakbaaa
aaaaaaaakgalbaaaagaaaaaadbaaaaakgcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaafgagbaaaacaaaaaadbaaaaakfcaabaaaaeaaaaaa
fgagbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
gcaabaaaadaaaaaafgagbaiaebaaaaaaadaaaaaaagacbaaaaeaaaaaaclaaaaaf
gcaabaaaadaaaaaafgagbaaaadaaaaaadiaaaaahncaabaaaaeaaaaaafgajbaaa
acaaaaaafgajbaaaacaaaaaadbaaaaahecaabaaaaaaaaaaabkaabaaaadaaaaaa
ckaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaaeaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaabaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaapfcaabaaaaeaaaaaa
kgalbaaaaeaaaaaaaceaaaaafmipmcdpaaaaaaaafmipmcdpaaaaaaaaaceaaaaa
aaaaiaeaaaaaaaaaaaaaiaeaaaaaaaaaelaaaaaffcaabaaaaeaaaaaaagacbaaa
aeaaaaaadcaaaaangcaabaaaacaaaaaafgagbaiaibaaaaaaacaaaaaaaceaaaaa
aaaaaaaagjgpbeeagjgpbeeaaaaaaaaaagacbaaaaeaaaaaaaoaaaaahgcaabaaa
acaaaaaafgagbaaaadaaaaaafgagbaaaacaaaaaaaoaaaaaiicaabaaaabaaaaaa
akaabaiaebaaaaaaagaaaaaabkaabaaaaaaaaaaaaaaaaaahccaabaaaadaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahccaabaaaadaaaaaaakaabaaa
agaaaaaabkaabaaaadaaaaaaaaaaaaahccaabaaaadaaaaaackaabaaaagaaaaaa
bkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
adaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaadlkklidp
bjaaaaafccaabaaaafaaaaaadkaabaaaabaaaaaadgaaaaaifcaabaaaafaaaaaa
aceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaadiaaaaahgcaabaaaacaaaaaa
fgagbaaaacaaaaaaagabbaaaafaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaciapmjeaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaj
ecaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaa
aoaaaaahccaabaaaaaaaaaaackaabaaaadaaaaaabkaabaaaaaaaaaaadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dkaabaaaabaaaaaaapaaaaakicaabaaaabaaaaaajgafbaaaacaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaajecaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaa
bkiacaaaaaaaaaaaapaaaaaaaoaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaadp
ckaabaaaaaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahgcaabaaa
acaaaaaakgalbaaaagaaaaaapgapbaaaabaaaaaadbaaaaakfcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgagbaaaacaaaaaadbaaaaak
dcaabaaaafaaaaaajgafbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaboaaaaaifcaabaaaaeaaaaaaagacbaiaebaaaaaaaeaaaaaaagabbaaa
afaaaaaaclaaaaaffcaabaaaaeaaaaaaagacbaaaaeaaaaaadiaaaaahhcaabaaa
ahaaaaaafgagbaaaacaaaaaafgagbaaaacaaaaaadbaaaaahicaabaaaabaaaaaa
akaabaaaaeaaaaaackaabaaaaeaaaaaadiaaaaahicaabaaaadaaaaaaakaabaaa
ahaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaa
abaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaadaaaaaadcaaaaap
dcaabaaaafaaaaaajgafbaaaahaaaaaaaceaaaaafmipmcdpfmipmcdpaaaaaaaa
aaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaaelaaaaafdcaabaaa
afaaaaaaegaabaaaafaaaaaadcaaaaangcaabaaaacaaaaaafgagbaiaibaaaaaa
acaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaaagabbaaaafaaaaaa
aoaaaaahgcaabaaaacaaaaaaagacbaaaaeaaaaaafgagbaaaacaaaaaaaoaaaaai
icaabaaaadaaaaaaakaabaiaebaaaaaaagaaaaaackaabaaaaaaaaaaadiaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaafaaaaaa
bkaabaaaadaaaaaadiaaaaahgcaabaaaacaaaaaafgagbaaaacaaaaaakgalbaaa
afaaaaaadiaaaaahccaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaciapmjeaelaaaaaf
ccaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaahecaabaaaaaaaaaaackaabaaa
adaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaadaaaaaaapaaaaakccaabaaa
acaaaaaajgafbaaaacaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
aaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaaipcaabaaa
afaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaampcaabaaa
afaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaafgafbaaaaaaaaaaaegaobaia
ebaaaaaaafaaaaaadiaaaaakpcaabaaaafaaaaaaegaobaaaafaaaaaaaceaaaaa
dlkklidpdlkklidpdlkklidpdlkklidpbjaaaaafpcaabaaaafaaaaaaegaobaaa
afaaaaaaddaaaaakpcaabaaaafaaaaaaegaobaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdcaaaaakccaabaaaaaaaaaaabkaabaaaaeaaaaaa
bkaabaaaaeaaaaaackaabaiaebaaaaaaabaaaaaaelaaaaafecaabaaaaeaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaakecaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaiaebaaaaaaabaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaackaabaaaagaaaaaadkaabaaaaaaaaaaadcaaaaak
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaalccaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaabkaabaaaaaaaaaaadbaaaaahecaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaa
bkaabaaaaaaaaaaaabaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaa
abaaaaaaaoaaaaalocaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaadpfgiicaaaaaaaaaaaanaaaaaaaaaaaaaiicaabaaaagaaaaaabkaabaia
ebaaaaaaadaaaaaaabeaaaaaaaaaaadpdiaaaaahccaabaaaaeaaaaaackaabaaa
aeaaaaaackaabaaaaeaaaaaaaaaaaaahicaabaaaaeaaaaaabkaabaaaadaaaaaa
abeaaaaaaaaaaadpdgaaaaaihcaabaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaaabeaaaaaaaaaialpdhaaaaaj
pcaabaaaahaaaaaakgakbaaaabaaaaaaigaobaaaagaaaaaaegaobaaaaeaaaaaa
aoaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaaeaaaaaaaoaaaaal
hcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaa
aaaaaaaaanaaaaaaaaaaaaalhcaabaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaa
aceaaaaaaaaaiadpaaaaaadpaaaaiadpaaaaaaaadcaaaaajecaabaaaabaaaaaa
ckaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaadaaaaaaaaaaaaahgcaabaaa
aaaaaaaafgagbaaaaaaaaaaafgagbaaaahaaaaaaelaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
ahaaaaaabkaabaaaaaaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aiaaaaaadkaabaaaahaaaaaadeaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaahbdneklodiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
bodakleaddaaaaaiicaabaaaaaaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaaiicaabaaaabaaaaaackaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaaabeaaaaaochgdidodcaaaaajccaabaaaacaaaaaadkaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaabkaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaacaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiecaabaaaacaaaaaaabeaaaaa
aaaaiadpckaabaiaibaaaaaaaaaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahccaabaaaacaaaaaa
ckaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaddaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaadhaaaaakecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaakehadndpdiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaiaaaaaadkaabaaaadaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaaiicaabaaaabaaaaaa
dkiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaaacaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaa
acaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
bkaabaiaebaaaaaaacaaaaaadiaaaaaiicaabaaaabaaaaaackaabaaaabaaaaaa
akiacaaaaaaaaaaaanaaaaaadcaaaaakecaabaaaabaaaaaackaabaaaabaaaaaa
akiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpebaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaaaoaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaaakiacaaa
aaaaaaaaanaaaaaaebaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaaaoaaaaai
ecaabaaaacaaaaaackaabaaaacaaaaaaakiacaaaaaaaaaaaanaaaaaabkaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaacaaaaaaaoaaaaaiccaabaaaahaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaanaaaaaaaaaaaaahecaabaaaahaaaaaackaabaaaabaaaaaa
bkaabaaaaaaaaaaaeiaaaaalpcaabaaaajaaaaaajgafbaaaahaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiecaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpaaaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaahaaaaaackaabaaa
aaaaaaaadkiacaaaaaaaaaaaanaaaaaaeiaaaaalpcaabaaaakaaaaaaigaabaaa
ahaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaakaaaaaapgapbaaaaaaaaaaaegaobaaaakaaaaaadcaaaaajpcaabaaa
ajaaaaaaegaobaaaajaaaaaakgakbaaaabaaaaaaegaobaaaakaaaaaaaaaaaaah
icaabaaaahaaaaaackaabaaaacaaaaaabkaabaaaaaaaaaaaeiaaaaalpcaabaaa
akaaaaaangafbaaaahaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaahaaaaaamgaabaaaahaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaahaaaaaapgapbaaa
aaaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaaakaaaaaa
kgakbaaaabaaaaaaegaobaaaahaaaaaaaaaaaaaiccaabaaaaaaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaahaaaaaapgapbaaa
abaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaaajaaaaaa
fgafbaaaaaaaaaaaegaobaaaahaaaaaadcaaaaamccaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaabkaabaaaabaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakecaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaal
ecaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaa
ckaabaaaaaaaaaaadbaaaaahccaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaackaabaaaaaaaaaaa
abaaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadhaaaaaj
pcaabaaaagaaaaaafgafbaaaabaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaa
aoaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaackaabaaaaeaaaaaadcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaadaaaaaa
aaaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaakgajbaaaagaaaaaaelaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaagaaaaaackaabaaaaaaaaaaaaoaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaiaaaaaadkaabaaaagaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaahbdneklodiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaabodakleaddaaaaaiecaabaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaaiicaabaaaabaaaaaaakaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaabaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaacaaaaaadkaabaaa
abaaaaaaakaabaaaacaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaacaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaacaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadbaaaaaiecaabaaa
acaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaaaaaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
bcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadhaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaa
kehadndpdiaaaaahbcaabaaaaaaaaaaackaabaaaaiaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaa
adaaaaaadiaaaaaiecaabaaaaaaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaadcaaaaakccaabaaaabaaaaaabkaabaaaabaaaaaaakiacaaaaaaaaaaa
anaaaaaaabeaaaaaaaaaialpebaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaa
ebaaaaaficaabaaaabaaaaaackaabaaaaaaaaaaaaoaaaaaikcaabaaaabaaaaaa
fganbaaaabaaaaaaagiacaaaaaaaaaaaanaaaaaabkaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
acaaaaaaaoaaaaaiccaabaaaaeaaaaaaakaabaaaaaaaaaaadkiacaaaaaaaaaaa
anaaaaaaaoaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaa
anaaaaaaaaaaaaahmcaabaaaaeaaaaaafganbaaaabaaaaaafgafbaaaaaaaaaaa
eiaaaaalpcaabaaaagaaaaaajgafbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaaibcaabaaaaeaaaaaaakaabaaaaaaaaaaadkiacaaa
aaaaaaaaanaaaaaaeiaaaaalpcaabaaaaiaaaaaaigaabaaaaeaaaaaaeghobaaa
acaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaiaaaaaa
pgapbaaaaaaaaaaaegaobaaaaiaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaa
agaaaaaakgakbaaaabaaaaaaegaobaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
ngafbaaaaeaaaaaaeghobaaaacaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
eiaaaaalpcaabaaaaeaaaaaamgaabaaaaeaaaaaaeghobaaaacaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaeaaaaaapgapbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaaiaaaaaakgakbaaa
abaaaaaaegaobaaaaeaaaaaaaaaaaaaibcaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaaeaaaaaakgakbaaaaaaaaaaa
egaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaaagaaaaaaagaabaaa
aaaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaiaebaaaaaa
aaaaaaaaegaobaaaafaaaaaaegaobaaaahaaaaaadeaaaaakpcaabaaaaeaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadicaaaah
ccaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaeiecdcaaaaajecaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadkaabaaaaeaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaa
aaaaaaaaagajbaaaaeaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaabhlhnbdiaoaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaaoaaaaajhcaabaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaegiccaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaldcaabaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaaceaaaaa
aaaaiaebaaaaiaeaaaaaaaaaaaaaaaaaaoaaaaakdcaabaaaabaaaaaaaceaaaaa
aaaaeaeaaaaamadpaaaaaaaaaaaaaaaaegaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaamecaabaaa
abaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadkiacaaaaaaaaaaaalaaaaaa
abeaaaaaaaaaiadpdiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaaomcaabaaaabaaaaaapgipcaaaaaaaaaaaalaaaaaapgipcaaa
aaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaeaapaaaaai
bcaabaaaacaaaaaapgapbaaaacaaaaaapgipcaaaaaaaaaaaalaaaaaaaaaaaaai
ecaabaaaabaaaaaackaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaacpaaaaaf
ecaabaaaabaaaaaackaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaamalpbjaaaaafecaabaaaabaaaaaackaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaaoaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aeaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaabcaaaaabdgaaaaaihcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabfaaaaabdiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaaaoaaaaaabnaaaaai
icaabaaaaaaaaaaackiacaaaaaaaaaaabeaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiaeaaoaaaaaibcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaabeaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaadlkklilpbjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaamaaaaaadbaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaacpnnledpcpnnledpcpnnledpaaaaaaaadiaaaaakpcaabaaaacaaaaaa
agafbaaaaaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaf
dcaabaaaaaaaaaaaigaabaaaacaaaaaadiaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaacplkoidocplkoidoaaaaaaaaaaaaaaaabjaaaaafdcaabaaa
aaaaaaaaegaabaaaaaaaaaaabjaaaaafdcaabaaaacaaaaaangafbaaaacaaaaaa
aaaaaaaldcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadhaaaaajdcaabaaaacaaaaaaegaabaaaabaaaaaa
egaabaaaaaaaaaaaegaabaaaacaaaaaadiaaaaakdcaabaaaaaaaaaaakgakbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaacpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaacplkoidobjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabjaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaaacaaaaaackaabaaa
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egacbaaaacaaaaaafgifcaaaaaaaaaaabeaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "GODRAYS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GODRAYS_ON" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "GODRAYS_ON" }
"!!GL3x"
}
}
 }
}
}