// Compiled shader for custom platforms, uncompressed size: 318.9KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 //        gles : 347 avg math (250..445), 1 texture, 14 avg branch (10..19)
 //      opengl : 347 avg math (250..445), 1 texture, 14 avg branch (10..19)
 // Stats for Fragment shader:
 //       d3d11 : 210 avg math (151..269), 9 avg branch (4..14)
 //        d3d9 : 256 avg math (188..324), 2 texture, 12 avg branch (4..20)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend DstColor Zero
  GpuProgramID 13739
Program "vp" {
SubProgram "opengl " {
// Stats: 250 math, 1 textures, 10 branches
Keywords { "ECLIPSES_OFF" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _Transmittance;
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float Rg;
uniform float Rt;
uniform float _experimentalAtmoScale;
uniform vec3 _Globals_Origin;
uniform float _Extinction_Tint;
uniform float extinctionMultiplier;
uniform float extinctionRimFade;
float xlat_mutableRt;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_4 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_6));
  rMu_3 = tmpvar_9;
  mu_2 = (tmpvar_9 / tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt(
    (((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_10 > 0.0)) {
    rMu_3 = (tmpvar_9 + tmpvar_10);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_11;
    tmpvar_11 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      float tmpvar_15;
      tmpvar_15 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = (tmpvar_18 - tmpvar_22);
      float tmpvar_24;
      float H_25;
      H_25 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_26;
      tmpvar_26.x = mu_2;
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_4));
      vec2 tmpvar_27;
      tmpvar_27 = (sqrt((
        (0.5 / H_25)
       * r_4)) * tmpvar_26);
      vec2 tmpvar_28;
      tmpvar_28 = sign(tmpvar_27);
      vec2 tmpvar_29;
      tmpvar_29 = (tmpvar_27 * tmpvar_27);
      float tmpvar_30;
      if ((tmpvar_28.y > tmpvar_28.x)) {
        tmpvar_30 = exp(tmpvar_29.x);
      } else {
        tmpvar_30 = 0.0;
      };
      vec2 tmpvar_31;
      tmpvar_31.x = 1.0;
      tmpvar_31.y = exp(((
        -(tmpvar_23)
       / H_25) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      tmpvar_24 = ((sqrt(
        ((6.2831 * H_25) * r_4)
      ) * exp(
        ((Rg - r_4) / H_25)
      )) * (tmpvar_30 + dot (
        ((tmpvar_28 / ((2.3193 * 
          abs(tmpvar_27)
        ) + sqrt(
          ((1.52 * tmpvar_29) + 4.0)
        ))) * tmpvar_31)
      , vec2(1.0, -1.0))));
      float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_4));
      vec2 tmpvar_34;
      tmpvar_34 = (sqrt((
        (0.5 / H_32)
       * r_4)) * tmpvar_33);
      vec2 tmpvar_35;
      tmpvar_35 = sign(tmpvar_34);
      vec2 tmpvar_36;
      tmpvar_36 = (tmpvar_34 * tmpvar_34);
      float tmpvar_37;
      if ((tmpvar_35.y > tmpvar_35.x)) {
        tmpvar_37 = exp(tmpvar_36.x);
      } else {
        tmpvar_37 = 0.0;
      };
      vec2 tmpvar_38;
      tmpvar_38.x = 1.0;
      tmpvar_38.y = exp(((
        -(tmpvar_23)
       / H_32) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_24) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_32)
         * r_4)) * exp((
          (Rg - r_4)
         / H_32))) * (tmpvar_37 + dot ((
          (tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt((
            (1.52 * tmpvar_36)
           + 4.0))))
         * tmpvar_38), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_39;
      y_over_x_39 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_40;
      tmpvar_40 = (min (abs(y_over_x_39), 1.0) / max (abs(y_over_x_39), 1.0));
      float tmpvar_41;
      tmpvar_41 = (tmpvar_40 * tmpvar_40);
      tmpvar_41 = (((
        ((((
          ((((-0.01213232 * tmpvar_41) + 0.05368138) * tmpvar_41) - 0.1173503)
         * tmpvar_41) + 0.1938925) * tmpvar_41) - 0.3326756)
       * tmpvar_41) + 0.9999793) * tmpvar_40);
      tmpvar_41 = (tmpvar_41 + (float(
        (abs(y_over_x_39) > 1.0)
      ) * (
        (tmpvar_41 * -2.0)
       + 1.570796)));
      vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((tmpvar_41 * sign(y_over_x_39)) / 1.5);
      tmpvar_42.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      extinction_5 = texture2DLod (_Transmittance, tmpvar_42.xy, 0.0).xyz;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    float tmpvar_43;
    tmpvar_43 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_44;
    tmpvar_44 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_45;
    tmpvar_45 = ((tmpvar_44 * tmpvar_44) - ((4.0 * tmpvar_43) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_46;
    if ((tmpvar_45 < 0.0)) {
      tmpvar_46 = -1.0;
    } else {
      tmpvar_46 = ((-(tmpvar_44) - sqrt(tmpvar_45)) / (2.0 * tmpvar_43));
    };
    bool tmpvar_47;
    tmpvar_47 = (tmpvar_46 > 0.0);
    if (!(tmpvar_47)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    };
    vec4 tmpvar_48;
    tmpvar_48.w = 1.0;
    tmpvar_48.xyz = extinction_5;
    tmpvar_1 = tmpvar_48;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedfjicacgdojlnjhcbpknjldogdgpohelmabaaaaaahmacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaa
eaaaabaafpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
aaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 250 math, 1 textures, 10 branches
Keywords { "ECLIPSES_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _Transmittance;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _Globals_Origin;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
highp float xlat_mutableRt;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float rMu_3;
  highp float r_4;
  highp vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_6));
  rMu_3 = tmpvar_9;
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt(
    (((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_10 > 0.0)) {
    rMu_3 = (tmpvar_9 + tmpvar_10);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      highp float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      highp float tmpvar_23;
      tmpvar_23 = (tmpvar_18 - tmpvar_22);
      highp float tmpvar_24;
      highp float H_25;
      H_25 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_26;
      tmpvar_26.x = mu_2;
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_4));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt((
        (0.5 / H_25)
       * r_4)) * tmpvar_26);
      highp vec2 tmpvar_28;
      tmpvar_28 = sign(tmpvar_27);
      highp vec2 tmpvar_29;
      tmpvar_29 = (tmpvar_27 * tmpvar_27);
      highp float tmpvar_30;
      if ((tmpvar_28.y > tmpvar_28.x)) {
        tmpvar_30 = exp(tmpvar_29.x);
      } else {
        tmpvar_30 = 0.0;
      };
      highp vec2 tmpvar_31;
      tmpvar_31.x = 1.0;
      tmpvar_31.y = exp(((
        -(tmpvar_23)
       / H_25) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      tmpvar_24 = ((sqrt(
        ((6.2831 * H_25) * r_4)
      ) * exp(
        ((Rg - r_4) / H_25)
      )) * (tmpvar_30 + dot (
        ((tmpvar_28 / ((2.3193 * 
          abs(tmpvar_27)
        ) + sqrt(
          ((1.52 * tmpvar_29) + 4.0)
        ))) * tmpvar_31)
      , vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_4));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt((
        (0.5 / H_32)
       * r_4)) * tmpvar_33);
      highp vec2 tmpvar_35;
      tmpvar_35 = sign(tmpvar_34);
      highp vec2 tmpvar_36;
      tmpvar_36 = (tmpvar_34 * tmpvar_34);
      highp float tmpvar_37;
      if ((tmpvar_35.y > tmpvar_35.x)) {
        tmpvar_37 = exp(tmpvar_36.x);
      } else {
        tmpvar_37 = 0.0;
      };
      highp vec2 tmpvar_38;
      tmpvar_38.x = 1.0;
      tmpvar_38.y = exp(((
        -(tmpvar_23)
       / H_32) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_24) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_32)
         * r_4)) * exp((
          (Rg - r_4)
         / H_32))) * (tmpvar_37 + dot ((
          (tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt((
            (1.52 * tmpvar_36)
           + 4.0))))
         * tmpvar_38), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_41;
      tmpvar_41 = (min (abs(y_over_x_40), 1.0) / max (abs(y_over_x_40), 1.0));
      highp float tmpvar_42;
      tmpvar_42 = (tmpvar_41 * tmpvar_41);
      tmpvar_42 = (((
        ((((
          ((((-0.01213232 * tmpvar_42) + 0.05368138) * tmpvar_42) - 0.1173503)
         * tmpvar_42) + 0.1938925) * tmpvar_42) - 0.3326756)
       * tmpvar_42) + 0.9999793) * tmpvar_41);
      tmpvar_42 = (tmpvar_42 + (float(
        (abs(y_over_x_40) > 1.0)
      ) * (
        (tmpvar_42 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((tmpvar_42 * sign(y_over_x_40)) / 1.5);
      tmpvar_43.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_39 = tmpvar_44.xyz;
      extinction_5 = tmpvar_39;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    highp float tmpvar_45;
    tmpvar_45 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_46;
    tmpvar_46 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_47;
    tmpvar_47 = ((tmpvar_46 * tmpvar_46) - ((4.0 * tmpvar_45) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_48;
    if ((tmpvar_47 < 0.0)) {
      tmpvar_48 = -1.0;
    } else {
      tmpvar_48 = ((-(tmpvar_46) - sqrt(tmpvar_47)) / (2.0 * tmpvar_45));
    };
    bool tmpvar_49;
    tmpvar_49 = (tmpvar_48 > 0.0);
    if (!(tmpvar_49)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    };
    highp vec4 tmpvar_50;
    tmpvar_50.w = 1.0;
    tmpvar_50.xyz = extinction_5;
    tmpvar_1 = tmpvar_50;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform lowp sampler2D _Transmittance;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec3 t0;
highp vec3 t1;
highp vec2 t2;
highp ivec2 ti2;
highp vec3 t3;
highp vec4 t4;
highp vec3 t5;
highp float t6;
highp vec3 t7;
highp float t8;
highp float t12;
bool tb12;
highp float t13;
bool tb13;
highp vec2 t14;
highp ivec2 ti14;
bool tb14;
highp vec2 t15;
highp ivec2 ti15;
highp float t18;
bool tb18;
highp float t19;
bool tb19;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t18 = (-Rg) + Rt;
    t1.x = t18 * _experimentalAtmoScale;
    t2.x = t18 * _experimentalAtmoScale + Rg;
    t7.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t18 = dot(t7.xyz, t7.xyz);
    t3.x = sqrt(t18);
    t7.x = dot(t7.xyz, t0.xyz);
    t3.y = t7.x / t3.x;
    t18 = t7.x * t7.x + (-t18);
    t18 = t2.x * t2.x + t18;
    t18 = sqrt(t18);
    t18 = (-t18) + (-t7.x);
    t18 = max(t18, 0.0);
    tb13 = 0.0<t18;
    t18 = t18 + t7.x;
    t2.y = t18 / t2.x;
    t3.xy = (bool(tb13)) ? t2.xy : t3.xy;
    tb18 = t2.x<t3.x;
    if(tb18){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t0.x = dot(t0.xyz, t0.xyz);
    t6 = t7.x + t7.x;
    t12 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t18 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t12 = t18 + t12;
    t18 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t12 = (-t18) * 2.0 + t12;
    t18 = (-Rg) * Rg + t12;
    t6 = t6 * t6;
    t13 = t0.x * 4.0;
    t18 = (-t13) * t18 + t6;
    tb19 = t18<0.0;
    t18 = sqrt(t18);
    t18 = (-t7.x) * 2.0 + (-t18);
    t0.x = t0.x + t0.x;
    t18 = t18 / t0.x;
    t18 = (tb19) ? -1.0 : t18;
    tb19 = 0.0<t18;
    if(tb19){
        t12 = (-t2.x) * t2.x + t12;
        t6 = (-t13) * t12 + t6;
        tb12 = t6<0.0;
        t6 = sqrt(t6);
        t6 = (-t7.x) * 2.0 + (-t6);
        t0.x = t6 / t0.x;
        t0.x = (tb12) ? 1.0 : (-t0.x);
        t0.x = t0.x + t18;
        t6 = HR * _experimentalAtmoScale;
        t12 = 0.5 / t6;
        t12 = t3.x * t12;
        t12 = sqrt(t12);
        t7.x = t0.x / t3.x;
        t3.z = t7.x + t3.y;
        t7.xy = vec2(float(t12) * t3.y, float(t12) * t3.z);
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t7.xyxx).xy) * 0xFFFFFFFFu);
        ti14.xy = ivec2(uvec2(lessThan(t7.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti14.xy;
        t2.xy = vec2(ti2.xy);
        t4.xyz = t7.xxy * t7.xxy;
        tb12 = t2.x<t2.y;
        t19 = t4.x * 1.44269502;
        t19 = exp2(t19);
        t12 = tb12 ? t19 : float(0.0);
        t14.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t14.xy = sqrt(t14.xy);
        t7.xy = abs(t7.xy) * vec2(2.31929994, 2.31929994) + t14.xy;
        t7.xy = t2.xy / t7.xy;
        t19 = (-t0.x) / t6;
        t2.x = t3.x + t3.x;
        t2.x = t0.x / t2.x;
        t2.x = t3.y + t2.x;
        t19 = t19 * t2.x;
        t19 = t19 * 1.44269502;
        t4.y = exp2(t19);
        t4.xz = vec2(1.0, 1.0);
        t7.xy = t7.xy * t4.xy;
        t19 = t6 * t3.x;
        t19 = t19 * 6.28310013;
        t19 = sqrt(t19);
        t8 = (-t3.x) + Rg;
        t6 = t8 / t6;
        t6 = t6 * 1.44269502;
        t6 = exp2(t6);
        t6 = t6 * t19;
        t7.x = dot(t7.xy, vec2(1.0, -1.0));
        t12 = t12 + t7.x;
        t6 = t12 * t6;
        t12 = HM * _experimentalAtmoScale;
        t7.x = 0.5 / t12;
        t7.x = t3.x * t7.x;
        t7.x = sqrt(t7.x);
        t7.xy = vec2(t3.y * t7.x, t3.z * t7.x);
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t7.xyxy).xy) * 0xFFFFFFFFu);
        ti15.xy = ivec2(uvec2(lessThan(t7.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti15.xy;
        t14.xy = vec2(ti14.xy);
        t5.xyz = t7.xxy * t7.xxy;
        tb19 = t14.x<t14.y;
        t15.x = t5.x * 1.44269502;
        t15.x = exp2(t15.x);
        t19 = tb19 ? t15.x : float(0.0);
        t15.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t15.xy = sqrt(t15.xy);
        t7.xy = abs(t7.xy) * vec2(2.31929994, 2.31929994) + t15.xy;
        t7.xy = t14.xy / t7.xy;
        t0.x = (-t0.x) / t12;
        t0.x = t2.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t4.w = exp2(t0.x);
        t7.xy = vec2(t7.x * t4.z, t7.y * t4.w);
        t0.x = t12 * t3.x;
        t0.x = t0.x * 6.28310013;
        t0.x = sqrt(t0.x);
        t12 = t8 / t12;
        t12 = t12 * 1.44269502;
        t12 = exp2(t12);
        t0.x = t12 * t0.x;
        t12 = dot(t7.xy, vec2(1.0, -1.0));
        t12 = t12 + t19;
        t0.x = t12 * t0.x;
        t7.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xyz = (-betaR.xyzx.xyz) * vec3(t6) + (-t7.xyz);
        t0.xyz = t0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t0.xyz = exp2(t0.xyz);
    } else {
        t7.x = t3.x + (-Rg);
        t1.x = t7.x / t1.x;
        t1.y = sqrt(t1.x);
        t13 = t3.y + 0.150000006;
        t13 = t13 * 12.262105;
        t19 = min(abs(t13), 1.0);
        t2.x = max(abs(t13), 1.0);
        t2.x = float(1.0) / t2.x;
        t19 = t19 * t2.x;
        t2.x = t19 * t19;
        t8 = t2.x * 0.0208350997 + -0.0851330012;
        t8 = t2.x * t8 + 0.180141002;
        t8 = t2.x * t8 + -0.330299497;
        t2.x = t2.x * t8 + 0.999866009;
        t8 = t19 * t2.x;
        tb14 = 1.0<abs(t13);
        t8 = t8 * -2.0 + 1.57079637;
        t8 = tb14 ? t8 : float(0.0);
        t19 = t19 * t2.x + t8;
        t13 = min(t13, 1.0);
        tb13 = t13<(-t13);
        t13 = (tb13) ? (-t19) : t19;
        t1.x = t13 * 0.666666687;
        t0.xyz = textureLod(_Transmittance, t1.xy, 0.0).xyz;
    //ENDIF
    }
    t1.x = t0.y + t0.x;
    t1.x = t0.z + t1.x;
    t1.x = t1.x * 0.333333343;
    t7.x = (-_Extinction_Tint) + 1.0;
    t1.x = t1.x * t7.x;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t0.xyz + t1.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb18 = 0.0>=t18;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb18)) ? t1.xyz : t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_OFF" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform  sampler2D _Transmittance;
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
vec3 t1;
vec4 t2;
ivec2 ti2;
vec3 t3;
vec4 t4;
vec3 t5;
float t6;
vec3 t7;
float t8;
float t12;
bool tb12;
float t13;
bool tb13;
vec2 t14;
ivec2 ti14;
vec2 t15;
ivec2 ti15;
float t18;
bool tb18;
float t19;
bool tb19;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t18 = dot(t0.xyz, t0.xyz);
    t18 = inversesqrt(t18);
    t0.xyz = vec3(t18) * t0.xyz;
    t18 = (-Rg) + Rt;
    t1.x = t18 * _experimentalAtmoScale;
    t2.x = t18 * _experimentalAtmoScale + Rg;
    t7.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t18 = dot(t7.xyz, t7.xyz);
    t3.x = sqrt(t18);
    t7.x = dot(t7.xyz, t0.xyz);
    t3.y = t7.x / t3.x;
    t18 = t7.x * t7.x + (-t18);
    t18 = t2.x * t2.x + t18;
    t18 = sqrt(t18);
    t18 = (-t18) + (-t7.x);
    t18 = max(t18, 0.0);
    tb13 = 0.0<t18;
    t18 = t18 + t7.x;
    t2.y = t18 / t2.x;
    t3.xy = (bool(tb13)) ? t2.xy : t3.xy;
    tb18 = t2.x<t3.x;
    if(tb18){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t0.x = dot(t0.xyz, t0.xyz);
    t6 = t7.x + t7.x;
    t12 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t18 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t12 = t18 + t12;
    t18 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t12 = (-t18) * 2.0 + t12;
    t18 = (-Rg) * Rg + t12;
    t6 = t6 * t6;
    t13 = t0.x * 4.0;
    t18 = (-t13) * t18 + t6;
    tb19 = t18<0.0;
    t18 = sqrt(t18);
    t18 = (-t7.x) * 2.0 + (-t18);
    t0.x = t0.x + t0.x;
    t18 = t18 / t0.x;
    t18 = (tb19) ? -1.0 : t18;
    tb19 = 0.0<t18;
    if(tb19){
        t12 = (-t2.x) * t2.x + t12;
        t6 = (-t13) * t12 + t6;
        tb12 = t6<0.0;
        t6 = sqrt(t6);
        t6 = (-t7.x) * 2.0 + (-t6);
        t0.x = t6 / t0.x;
        t0.x = (tb12) ? 1.0 : (-t0.x);
        t0.x = t0.x + t18;
        t6 = HR * _experimentalAtmoScale;
        t12 = 0.5 / t6;
        t12 = t3.x * t12;
        t12 = sqrt(t12);
        t7.x = t0.x / t3.x;
        t3.z = t7.x + t3.y;
        t7.xy = vec2(t12) * t3.yz;
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t7.xyxx).xy) * 0xFFFFFFFFu);
        ti14.xy = ivec2(uvec2(lessThan(t7.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti14.xy;
        t2.xy = vec2(ti2.xy);
        t4.xyz = t7.xxy * t7.xxy;
        tb12 = t2.x<t2.y;
        t19 = t4.x * 1.44269502;
        t19 = exp2(t19);
        t12 = tb12 ? t19 : float(0.0);
        t14.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t14.xy = sqrt(t14.xy);
        t7.xy = abs(t7.xy) * vec2(2.31929994, 2.31929994) + t14.xy;
        t7.xy = t2.xy / t7.xy;
        t19 = (-t0.x) / t6;
        t2.x = t3.x + t3.x;
        t2.x = t0.x / t2.x;
        t2.x = t3.y + t2.x;
        t19 = t19 * t2.x;
        t19 = t19 * 1.44269502;
        t4.y = exp2(t19);
        t4.xz = vec2(1.0, 1.0);
        t7.xy = t7.xy * t4.xy;
        t19 = t6 * t3.x;
        t19 = t19 * 6.28310013;
        t19 = sqrt(t19);
        t8 = (-t3.x) + Rg;
        t6 = t8 / t6;
        t6 = t6 * 1.44269502;
        t6 = exp2(t6);
        t6 = t6 * t19;
        t7.x = dot(t7.xy, vec2(1.0, -1.0));
        t12 = t12 + t7.x;
        t6 = t12 * t6;
        t12 = HM * _experimentalAtmoScale;
        t7.x = 0.5 / t12;
        t7.x = t3.x * t7.x;
        t7.x = sqrt(t7.x);
        t7.xy = t3.yz * t7.xx;
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t7.xyxy).xy) * 0xFFFFFFFFu);
        ti15.xy = ivec2(uvec2(lessThan(t7.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti15.xy;
        t14.xy = vec2(ti14.xy);
        t5.xyz = t7.xxy * t7.xxy;
        tb19 = t14.x<t14.y;
        t15.x = t5.x * 1.44269502;
        t15.x = exp2(t15.x);
        t19 = tb19 ? t15.x : float(0.0);
        t15.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t15.xy = sqrt(t15.xy);
        t7.xy = abs(t7.xy) * vec2(2.31929994, 2.31929994) + t15.xy;
        t7.xy = t14.xy / t7.xy;
        t0.x = (-t0.x) / t12;
        t0.x = t2.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t4.w = exp2(t0.x);
        t7.xy = t7.xy * t4.zw;
        t0.x = t12 * t3.x;
        t0.x = t0.x * 6.28310013;
        t0.x = sqrt(t0.x);
        t12 = t8 / t12;
        t12 = t12 * 1.44269502;
        t12 = exp2(t12);
        t0.x = t12 * t0.x;
        t12 = dot(t7.xy, vec2(1.0, -1.0));
        t12 = t12 + t19;
        t0.x = t12 * t0.x;
        t7.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xyz = (-betaR.xyzx.xyz) * vec3(t6) + (-t7.xyz);
        t0.xyz = t0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t2.xyz = exp2(t0.xyz);
    } else {
        t0.x = t3.x + (-Rg);
        t0.x = t0.x / t1.x;
        t0.y = sqrt(t0.x);
        t12 = t3.y + 0.150000006;
        t12 = t12 * 12.262105;
        t1.x = min(abs(t12), 1.0);
        t7.x = max(abs(t12), 1.0);
        t7.x = float(1.0) / t7.x;
        t1.x = t7.x * t1.x;
        t7.x = t1.x * t1.x;
        t13 = t7.x * 0.0208350997 + -0.0851330012;
        t13 = t7.x * t13 + 0.180141002;
        t13 = t7.x * t13 + -0.330299497;
        t7.x = t7.x * t13 + 0.999866009;
        t13 = t7.x * t1.x;
        tb19 = 1.0<abs(t12);
        t13 = t13 * -2.0 + 1.57079637;
        t13 = tb19 ? t13 : float(0.0);
        t1.x = t1.x * t7.x + t13;
        t12 = min(t12, 1.0);
        tb12 = t12<(-t12);
        t12 = (tb12) ? (-t1.x) : t1.x;
        t0.x = t12 * 0.666666687;
        t2 = textureLod(_Transmittance, t0.xy, 0.0);
    //ENDIF
    }
    t0.x = t2.y + t2.x;
    t0.x = t2.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t6 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t6;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t2.xyz + t0.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb18 = 0.0>=t18;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb18)) ? t1.xyz : t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 445 math, 1 textures, 19 branches
Keywords { "ECLIPSES_ON" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _Transmittance;
uniform float HR;
uniform vec3 betaR;
uniform float HM;
uniform vec3 betaMEx;
uniform float Rg;
uniform float Rt;
uniform float _experimentalAtmoScale;
uniform vec3 _Globals_Origin;
uniform float _Extinction_Tint;
uniform float extinctionMultiplier;
uniform float extinctionRimFade;
uniform float extinctionGroundFade;
uniform vec4 sunPosAndRadius;
uniform mat4 lightOccluders1;
uniform mat4 lightOccluders2;
float xlat_mutableRt;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_4 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_6));
  rMu_3 = tmpvar_9;
  mu_2 = (tmpvar_9 / tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt(
    (((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_10 > 0.0)) {
    rMu_3 = (tmpvar_9 + tmpvar_10);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_11;
    tmpvar_11 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      float tmpvar_15;
      tmpvar_15 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = (tmpvar_18 - tmpvar_22);
      float tmpvar_24;
      float H_25;
      H_25 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_26;
      tmpvar_26.x = mu_2;
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_4));
      vec2 tmpvar_27;
      tmpvar_27 = (sqrt((
        (0.5 / H_25)
       * r_4)) * tmpvar_26);
      vec2 tmpvar_28;
      tmpvar_28 = sign(tmpvar_27);
      vec2 tmpvar_29;
      tmpvar_29 = (tmpvar_27 * tmpvar_27);
      float tmpvar_30;
      if ((tmpvar_28.y > tmpvar_28.x)) {
        tmpvar_30 = exp(tmpvar_29.x);
      } else {
        tmpvar_30 = 0.0;
      };
      vec2 tmpvar_31;
      tmpvar_31.x = 1.0;
      tmpvar_31.y = exp(((
        -(tmpvar_23)
       / H_25) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      tmpvar_24 = ((sqrt(
        ((6.2831 * H_25) * r_4)
      ) * exp(
        ((Rg - r_4) / H_25)
      )) * (tmpvar_30 + dot (
        ((tmpvar_28 / ((2.3193 * 
          abs(tmpvar_27)
        ) + sqrt(
          ((1.52 * tmpvar_29) + 4.0)
        ))) * tmpvar_31)
      , vec2(1.0, -1.0))));
      float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_4));
      vec2 tmpvar_34;
      tmpvar_34 = (sqrt((
        (0.5 / H_32)
       * r_4)) * tmpvar_33);
      vec2 tmpvar_35;
      tmpvar_35 = sign(tmpvar_34);
      vec2 tmpvar_36;
      tmpvar_36 = (tmpvar_34 * tmpvar_34);
      float tmpvar_37;
      if ((tmpvar_35.y > tmpvar_35.x)) {
        tmpvar_37 = exp(tmpvar_36.x);
      } else {
        tmpvar_37 = 0.0;
      };
      vec2 tmpvar_38;
      tmpvar_38.x = 1.0;
      tmpvar_38.y = exp(((
        -(tmpvar_23)
       / H_32) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_24) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_32)
         * r_4)) * exp((
          (Rg - r_4)
         / H_32))) * (tmpvar_37 + dot ((
          (tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt((
            (1.52 * tmpvar_36)
           + 4.0))))
         * tmpvar_38), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_39;
      y_over_x_39 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_40;
      tmpvar_40 = (min (abs(y_over_x_39), 1.0) / max (abs(y_over_x_39), 1.0));
      float tmpvar_41;
      tmpvar_41 = (tmpvar_40 * tmpvar_40);
      tmpvar_41 = (((
        ((((
          ((((-0.01213232 * tmpvar_41) + 0.05368138) * tmpvar_41) - 0.1173503)
         * tmpvar_41) + 0.1938925) * tmpvar_41) - 0.3326756)
       * tmpvar_41) + 0.9999793) * tmpvar_40);
      tmpvar_41 = (tmpvar_41 + (float(
        (abs(y_over_x_39) > 1.0)
      ) * (
        (tmpvar_41 * -2.0)
       + 1.570796)));
      vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((tmpvar_41 * sign(y_over_x_39)) / 1.5);
      tmpvar_42.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      extinction_5 = texture2DLod (_Transmittance, tmpvar_42.xy, 0.0).xyz;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    float tmpvar_43;
    tmpvar_43 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_44;
    tmpvar_44 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_45;
    tmpvar_45 = ((tmpvar_44 * tmpvar_44) - ((4.0 * tmpvar_43) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_46;
    if ((tmpvar_45 < 0.0)) {
      tmpvar_46 = -1.0;
    } else {
      tmpvar_46 = ((-(tmpvar_44) - sqrt(tmpvar_45)) / (2.0 * tmpvar_43));
    };
    bool tmpvar_47;
    tmpvar_47 = (tmpvar_46 > 0.0);
    if (!(tmpvar_47)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    } else {
      float eclipseShadow_48;
      eclipseShadow_48 = 1.0;
      float tmpvar_49;
      float tmpvar_50;
      tmpvar_50 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_51;
      tmpvar_51 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_52;
      tmpvar_52 = ((tmpvar_51 * tmpvar_51) - ((4.0 * tmpvar_50) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      if ((tmpvar_52 < 0.0)) {
        tmpvar_49 = -1.0;
      } else {
        float tmpvar_53;
        tmpvar_53 = ((-(tmpvar_51) - sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
        float tmpvar_54;
        if ((tmpvar_53 < 0.0)) {
          tmpvar_54 = ((-(tmpvar_51) + sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
        } else {
          tmpvar_54 = tmpvar_53;
        };
        tmpvar_49 = tmpvar_54;
      };
      if ((tmpvar_49 != -1.0)) {
        int j_55;
        int i_56;
        vec3 worldPos_57;
        worldPos_57 = (_WorldSpaceCameraPos + (tmpvar_6 * tmpvar_49));
        i_56 = 0;
        while (true) {
          if ((i_56 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_56] <= 0.0)) {
            break;
          };
          vec4 v_58;
          v_58.x = lightOccluders1[0][i_56];
          v_58.y = lightOccluders1[1][i_56];
          v_58.z = lightOccluders1[2][i_56];
          v_58.w = lightOccluders1[3][i_56];
          vec3 sphereDirection_59;
          vec3 lightDirection_60;
          vec3 tmpvar_61;
          tmpvar_61 = (sunPosAndRadius.xyz - worldPos_57);
          float tmpvar_62;
          tmpvar_62 = sqrt(dot (tmpvar_61, tmpvar_61));
          lightDirection_60 = (tmpvar_61 / vec3(tmpvar_62));
          vec3 tmpvar_63;
          tmpvar_63 = (v_58.xyz - worldPos_57);
          float tmpvar_64;
          tmpvar_64 = sqrt(dot (tmpvar_63, tmpvar_63));
          sphereDirection_59 = (tmpvar_63 / tmpvar_64);
          vec3 tmpvar_65;
          tmpvar_65 = ((lightDirection_60.yzx * sphereDirection_59.zxy) - (lightDirection_60.zxy * sphereDirection_59.yzx));
          float tmpvar_66;
          tmpvar_66 = min (1.0, sqrt(dot (tmpvar_65, tmpvar_65)));
          float tmpvar_67;
          tmpvar_67 = min (1.0, (vec3(lightOccluders1[3][i_56]) / tmpvar_64).x);
          float tmpvar_68;
          tmpvar_68 = clamp (((
            (-((vec3(tmpvar_62) * (
              (sign(tmpvar_66) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_66))
              ) * (1.570796 + 
                (abs(tmpvar_66) * (-0.2146018 + (abs(tmpvar_66) * (0.08656672 + 
                  (abs(tmpvar_66) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_67) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_67))
              ) * (1.570796 + 
                (abs(tmpvar_67) * (-0.2146018 + (abs(tmpvar_67) * (0.08656672 + 
                  (abs(tmpvar_67) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_69;
          tmpvar_69 = clamp ((dot (lightDirection_60, sphereDirection_59) / 0.2), 0.0, 1.0);
          eclipseShadow_48 = (eclipseShadow_48 * (1.0 - (
            (tmpvar_68 * (tmpvar_68 * (3.0 - (2.0 * tmpvar_68))))
           * 
            (tmpvar_69 * (tmpvar_69 * (3.0 - (2.0 * tmpvar_69))))
          )));
          i_56++;
        };
        j_55 = 0;
        while (true) {
          if ((j_55 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_55] <= 0.0)) {
            break;
          };
          vec4 v_70;
          v_70.x = lightOccluders2[0][j_55];
          v_70.y = lightOccluders2[1][j_55];
          v_70.z = lightOccluders2[2][j_55];
          v_70.w = lightOccluders2[3][j_55];
          vec3 sphereDirection_71;
          vec3 lightDirection_72;
          vec3 tmpvar_73;
          tmpvar_73 = (sunPosAndRadius.xyz - worldPos_57);
          float tmpvar_74;
          tmpvar_74 = sqrt(dot (tmpvar_73, tmpvar_73));
          lightDirection_72 = (tmpvar_73 / vec3(tmpvar_74));
          vec3 tmpvar_75;
          tmpvar_75 = (v_70.xyz - worldPos_57);
          float tmpvar_76;
          tmpvar_76 = sqrt(dot (tmpvar_75, tmpvar_75));
          sphereDirection_71 = (tmpvar_75 / tmpvar_76);
          vec3 tmpvar_77;
          tmpvar_77 = ((lightDirection_72.yzx * sphereDirection_71.zxy) - (lightDirection_72.zxy * sphereDirection_71.yzx));
          float tmpvar_78;
          tmpvar_78 = min (1.0, sqrt(dot (tmpvar_77, tmpvar_77)));
          float tmpvar_79;
          tmpvar_79 = min (1.0, (vec3(lightOccluders2[3][j_55]) / tmpvar_76).x);
          float tmpvar_80;
          tmpvar_80 = clamp (((
            (-((vec3(tmpvar_74) * (
              (sign(tmpvar_78) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_78))
              ) * (1.570796 + 
                (abs(tmpvar_78) * (-0.2146018 + (abs(tmpvar_78) * (0.08656672 + 
                  (abs(tmpvar_78) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_79) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_79))
              ) * (1.570796 + 
                (abs(tmpvar_79) * (-0.2146018 + (abs(tmpvar_79) * (0.08656672 + 
                  (abs(tmpvar_79) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_81;
          tmpvar_81 = clamp ((dot (lightDirection_72, sphereDirection_71) / 0.2), 0.0, 1.0);
          eclipseShadow_48 = (eclipseShadow_48 * (1.0 - (
            (tmpvar_80 * (tmpvar_80 * (3.0 - (2.0 * tmpvar_80))))
           * 
            (tmpvar_81 * (tmpvar_81 * (3.0 - (2.0 * tmpvar_81))))
          )));
          j_55++;
        };
      };
      extinction_5 = (extinction_5 * eclipseShadow_48);
      extinction_5 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_5));
    };
    vec4 tmpvar_82;
    tmpvar_82.w = 1.0;
    tmpvar_82.xyz = extinction_5;
    tmpvar_1 = tmpvar_82;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedfjicacgdojlnjhcbpknjldogdgpohelmabaaaaaahmacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaa
eaaaabaafpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
aaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 445 math, 1 textures, 19 branches
Keywords { "ECLIPSES_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _Transmittance;
uniform highp float HR;
uniform highp vec3 betaR;
uniform highp float HM;
uniform highp vec3 betaMEx;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float _experimentalAtmoScale;
uniform highp vec3 _Globals_Origin;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
uniform highp float extinctionGroundFade;
uniform highp vec4 sunPosAndRadius;
uniform highp mat4 lightOccluders1;
uniform highp mat4 lightOccluders2;
highp float xlat_mutableRt;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float rMu_3;
  highp float r_4;
  highp vec3 extinction_5;
  extinction_5 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_4 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_6));
  rMu_3 = tmpvar_9;
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt(
    (((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_10 > 0.0)) {
    rMu_3 = (tmpvar_9 + tmpvar_10);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      highp float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      highp float tmpvar_23;
      tmpvar_23 = (tmpvar_18 - tmpvar_22);
      highp float tmpvar_24;
      highp float H_25;
      H_25 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_26;
      tmpvar_26.x = mu_2;
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_4));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt((
        (0.5 / H_25)
       * r_4)) * tmpvar_26);
      highp vec2 tmpvar_28;
      tmpvar_28 = sign(tmpvar_27);
      highp vec2 tmpvar_29;
      tmpvar_29 = (tmpvar_27 * tmpvar_27);
      highp float tmpvar_30;
      if ((tmpvar_28.y > tmpvar_28.x)) {
        tmpvar_30 = exp(tmpvar_29.x);
      } else {
        tmpvar_30 = 0.0;
      };
      highp vec2 tmpvar_31;
      tmpvar_31.x = 1.0;
      tmpvar_31.y = exp(((
        -(tmpvar_23)
       / H_25) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      tmpvar_24 = ((sqrt(
        ((6.2831 * H_25) * r_4)
      ) * exp(
        ((Rg - r_4) / H_25)
      )) * (tmpvar_30 + dot (
        ((tmpvar_28 / ((2.3193 * 
          abs(tmpvar_27)
        ) + sqrt(
          ((1.52 * tmpvar_29) + 4.0)
        ))) * tmpvar_31)
      , vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_4));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt((
        (0.5 / H_32)
       * r_4)) * tmpvar_33);
      highp vec2 tmpvar_35;
      tmpvar_35 = sign(tmpvar_34);
      highp vec2 tmpvar_36;
      tmpvar_36 = (tmpvar_34 * tmpvar_34);
      highp float tmpvar_37;
      if ((tmpvar_35.y > tmpvar_35.x)) {
        tmpvar_37 = exp(tmpvar_36.x);
      } else {
        tmpvar_37 = 0.0;
      };
      highp vec2 tmpvar_38;
      tmpvar_38.x = 1.0;
      tmpvar_38.y = exp(((
        -(tmpvar_23)
       / H_32) * (
        (tmpvar_23 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_24) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_32)
         * r_4)) * exp((
          (Rg - r_4)
         / H_32))) * (tmpvar_37 + dot ((
          (tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt((
            (1.52 * tmpvar_36)
           + 4.0))))
         * tmpvar_38), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_41;
      tmpvar_41 = (min (abs(y_over_x_40), 1.0) / max (abs(y_over_x_40), 1.0));
      highp float tmpvar_42;
      tmpvar_42 = (tmpvar_41 * tmpvar_41);
      tmpvar_42 = (((
        ((((
          ((((-0.01213232 * tmpvar_42) + 0.05368138) * tmpvar_42) - 0.1173503)
         * tmpvar_42) + 0.1938925) * tmpvar_42) - 0.3326756)
       * tmpvar_42) + 0.9999793) * tmpvar_41);
      tmpvar_42 = (tmpvar_42 + (float(
        (abs(y_over_x_40) > 1.0)
      ) * (
        (tmpvar_42 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((tmpvar_42 * sign(y_over_x_40)) / 1.5);
      tmpvar_43.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_39 = tmpvar_44.xyz;
      extinction_5 = tmpvar_39;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    highp float tmpvar_45;
    tmpvar_45 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_46;
    tmpvar_46 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_47;
    tmpvar_47 = ((tmpvar_46 * tmpvar_46) - ((4.0 * tmpvar_45) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_48;
    if ((tmpvar_47 < 0.0)) {
      tmpvar_48 = -1.0;
    } else {
      tmpvar_48 = ((-(tmpvar_46) - sqrt(tmpvar_47)) / (2.0 * tmpvar_45));
    };
    bool tmpvar_49;
    tmpvar_49 = (tmpvar_48 > 0.0);
    if (!(tmpvar_49)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    } else {
      highp float eclipseShadow_50;
      eclipseShadow_50 = 1.0;
      highp float tmpvar_51;
      highp float tmpvar_52;
      tmpvar_52 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_53;
      tmpvar_53 = (2.0 * dot (tmpvar_6, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_54;
      tmpvar_54 = ((tmpvar_53 * tmpvar_53) - ((4.0 * tmpvar_52) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      if ((tmpvar_54 < 0.0)) {
        tmpvar_51 = -1.0;
      } else {
        highp float tmpvar_55;
        tmpvar_55 = ((-(tmpvar_53) - sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
        highp float tmpvar_56;
        if ((tmpvar_55 < 0.0)) {
          tmpvar_56 = ((-(tmpvar_53) + sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
        } else {
          tmpvar_56 = tmpvar_55;
        };
        tmpvar_51 = tmpvar_56;
      };
      if ((tmpvar_51 != -1.0)) {
        highp int j_57;
        highp int i_58;
        highp vec3 worldPos_59;
        worldPos_59 = (_WorldSpaceCameraPos + (tmpvar_6 * tmpvar_51));
        i_58 = 0;
        while (true) {
          if ((i_58 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_58] <= 0.0)) {
            break;
          };
          highp vec4 v_60;
          v_60.x = lightOccluders1[0][i_58];
          v_60.y = lightOccluders1[1][i_58];
          v_60.z = lightOccluders1[2][i_58];
          v_60.w = lightOccluders1[3][i_58];
          highp vec3 sphereDirection_61;
          highp vec3 lightDirection_62;
          highp vec3 tmpvar_63;
          tmpvar_63 = (sunPosAndRadius.xyz - worldPos_59);
          highp float tmpvar_64;
          tmpvar_64 = sqrt(dot (tmpvar_63, tmpvar_63));
          lightDirection_62 = (tmpvar_63 / vec3(tmpvar_64));
          highp vec3 tmpvar_65;
          tmpvar_65 = (v_60.xyz - worldPos_59);
          highp float tmpvar_66;
          tmpvar_66 = sqrt(dot (tmpvar_65, tmpvar_65));
          sphereDirection_61 = (tmpvar_65 / tmpvar_66);
          highp vec3 tmpvar_67;
          tmpvar_67 = ((lightDirection_62.yzx * sphereDirection_61.zxy) - (lightDirection_62.zxy * sphereDirection_61.yzx));
          highp float tmpvar_68;
          tmpvar_68 = min (1.0, sqrt(dot (tmpvar_67, tmpvar_67)));
          highp float tmpvar_69;
          tmpvar_69 = min (1.0, (vec3(lightOccluders1[3][i_58]) / tmpvar_66).x);
          highp float tmpvar_70;
          tmpvar_70 = clamp (((
            (-((vec3(tmpvar_64) * (
              (sign(tmpvar_68) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_68))
              ) * (1.570796 + 
                (abs(tmpvar_68) * (-0.2146018 + (abs(tmpvar_68) * (0.08656672 + 
                  (abs(tmpvar_68) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_69) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_69))
              ) * (1.570796 + 
                (abs(tmpvar_69) * (-0.2146018 + (abs(tmpvar_69) * (0.08656672 + 
                  (abs(tmpvar_69) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_71;
          tmpvar_71 = clamp ((dot (lightDirection_62, sphereDirection_61) / 0.2), 0.0, 1.0);
          eclipseShadow_50 = (eclipseShadow_50 * (1.0 - (
            (tmpvar_70 * (tmpvar_70 * (3.0 - (2.0 * tmpvar_70))))
           * 
            (tmpvar_71 * (tmpvar_71 * (3.0 - (2.0 * tmpvar_71))))
          )));
          i_58++;
        };
        j_57 = 0;
        while (true) {
          if ((j_57 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_57] <= 0.0)) {
            break;
          };
          highp vec4 v_72;
          v_72.x = lightOccluders2[0][j_57];
          v_72.y = lightOccluders2[1][j_57];
          v_72.z = lightOccluders2[2][j_57];
          v_72.w = lightOccluders2[3][j_57];
          highp vec3 sphereDirection_73;
          highp vec3 lightDirection_74;
          highp vec3 tmpvar_75;
          tmpvar_75 = (sunPosAndRadius.xyz - worldPos_59);
          highp float tmpvar_76;
          tmpvar_76 = sqrt(dot (tmpvar_75, tmpvar_75));
          lightDirection_74 = (tmpvar_75 / vec3(tmpvar_76));
          highp vec3 tmpvar_77;
          tmpvar_77 = (v_72.xyz - worldPos_59);
          highp float tmpvar_78;
          tmpvar_78 = sqrt(dot (tmpvar_77, tmpvar_77));
          sphereDirection_73 = (tmpvar_77 / tmpvar_78);
          highp vec3 tmpvar_79;
          tmpvar_79 = ((lightDirection_74.yzx * sphereDirection_73.zxy) - (lightDirection_74.zxy * sphereDirection_73.yzx));
          highp float tmpvar_80;
          tmpvar_80 = min (1.0, sqrt(dot (tmpvar_79, tmpvar_79)));
          highp float tmpvar_81;
          tmpvar_81 = min (1.0, (vec3(lightOccluders2[3][j_57]) / tmpvar_78).x);
          highp float tmpvar_82;
          tmpvar_82 = clamp (((
            (-((vec3(tmpvar_76) * (
              (sign(tmpvar_80) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_80))
              ) * (1.570796 + 
                (abs(tmpvar_80) * (-0.2146018 + (abs(tmpvar_80) * (0.08656672 + 
                  (abs(tmpvar_80) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_81) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_81))
              ) * (1.570796 + 
                (abs(tmpvar_81) * (-0.2146018 + (abs(tmpvar_81) * (0.08656672 + 
                  (abs(tmpvar_81) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_83;
          tmpvar_83 = clamp ((dot (lightDirection_74, sphereDirection_73) / 0.2), 0.0, 1.0);
          eclipseShadow_50 = (eclipseShadow_50 * (1.0 - (
            (tmpvar_82 * (tmpvar_82 * (3.0 - (2.0 * tmpvar_82))))
           * 
            (tmpvar_83 * (tmpvar_83 * (3.0 - (2.0 * tmpvar_83))))
          )));
          j_57++;
        };
      };
      extinction_5 = (extinction_5 * eclipseShadow_50);
      extinction_5 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_5));
    };
    highp vec4 tmpvar_84;
    tmpvar_84.w = 1.0;
    tmpvar_84.xyz = extinction_5;
    tmpvar_1 = tmpvar_84;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
// XXX ADRENOCONSTARRAYBUG
#define immediateConstBufferF (vec4[4] (\
	vec4(1, 0, 0, 0), \
	vec4(0, 1, 0, 0), \
	vec4(0, 0, 1, 0), \
	vec4(0, 0, 0, 1)))
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
uniform lowp sampler2D _Transmittance;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec3 t0;
highp vec3 t1;
bool tb1;
highp vec2 t2;
highp int ti2;
bool tb2;
highp vec3 t3;
highp vec3 t4;
highp vec3 t5;
highp ivec3 ti5;
highp vec4 t6;
highp ivec2 ti6;
highp vec3 t7;
highp vec3 t9;
highp float t10;
highp int ti10;
bool tb10;
highp float t11;
highp vec2 t12;
highp vec2 t13;
highp float t17;
bool tb17;
highp float t18;
bool tb18;
highp float t19;
bool tb19;
highp vec2 t20;
highp ivec2 ti20;
highp float t24;
bool tb24;
highp float t25;
highp float t26;
bool tb26;
highp float t27;
bool tb27;
highp float t28;
highp float t29;
bool tb29;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t0.xyz = vec3(t24) * t0.xyz;
    t24 = (-Rg) + Rt;
    t1.x = t24 * _experimentalAtmoScale;
    t2.x = t24 * _experimentalAtmoScale + Rg;
    t9.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t24 = dot(t9.xyz, t9.xyz);
    t3.x = sqrt(t24);
    t9.x = dot(t9.xyz, t0.xyz);
    t3.y = t9.x / t3.x;
    t24 = t9.x * t9.x + (-t24);
    t24 = t2.x * t2.x + t24;
    t24 = sqrt(t24);
    t24 = (-t24) + (-t9.x);
    t24 = max(t24, 0.0);
    tb17 = 0.0<t24;
    t24 = t24 + t9.x;
    t2.y = t24 / t2.x;
    t3.xy = (bool(tb17)) ? t2.xy : t3.xy;
    tb24 = t2.x<t3.x;
    if(tb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t24 = dot(t0.xyz, t0.xyz);
    t17 = t9.x + t9.x;
    t25 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t10 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t25 = t25 + t10;
    t10 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t25 = (-t10) * 2.0 + t25;
    t10 = (-Rg) * Rg + t25;
    t17 = t17 * t17;
    t18 = t24 * 4.0;
    t10 = (-t18) * t10 + t17;
    tb26 = t10<0.0;
    t10 = sqrt(t10);
    t10 = (-t9.x) * 2.0 + (-t10);
    t24 = t24 + t24;
    t10 = t10 / t24;
    t10 = (tb26) ? -1.0 : t10;
    tb26 = 0.0<t10;
    if(tb26){
        t26 = (-t2.x) * t2.x + t25;
        t26 = (-t18) * t26 + t17;
        tb27 = t26<0.0;
        t26 = sqrt(t26);
        t26 = (-t9.x) * 2.0 + (-t26);
        t26 = t26 / t24;
        t26 = (tb27) ? 1.0 : (-t26);
        t26 = t26 + t10;
        t27 = HR * _experimentalAtmoScale;
        t4.x = 0.5 / t27;
        t4.x = t3.x * t4.x;
        t4.x = sqrt(t4.x);
        t12.x = t26 / t3.x;
        t3.z = t3.y + t12.x;
        t4.xy = vec2(t3.y * t4.x, t3.z * t4.x);
        ti20.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t4.xyxy).xy) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t4.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti20.xy = (-ti20.xy) + ti5.xy;
        t20.xy = vec2(ti20.xy);
        t5.xyz = t4.xxy * t4.xxy;
        tb29 = t20.x<t20.y;
        t5.x = t5.x * 1.44269502;
        t5.x = exp2(t5.x);
        t5.x = tb29 ? t5.x : float(0.0);
        t13.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t13.xy = sqrt(t13.xy);
        t4.xy = abs(t4.xy) * vec2(2.31929994, 2.31929994) + t13.xy;
        t4.xy = t20.xy / t4.xy;
        t20.x = (-t26) / t27;
        t28 = t3.x + t3.x;
        t28 = t26 / t28;
        t28 = t3.y + t28;
        t20.x = t28 * t20.x;
        t20.x = t20.x * 1.44269502;
        t6.y = exp2(t20.x);
        t6.xz = vec2(1.0, 1.0);
        t4.xy = t4.xy * t6.xy;
        t20.x = t27 * t3.x;
        t20.x = t20.x * 6.28310013;
        t20.x = sqrt(t20.x);
        t13.x = (-t3.x) + Rg;
        t27 = t13.x / t27;
        t27 = t27 * 1.44269502;
        t27 = exp2(t27);
        t27 = t27 * t20.x;
        t4.x = dot(t4.xy, vec2(1.0, -1.0));
        t4.x = t4.x + t5.x;
        t27 = t27 * t4.x;
        t4.x = HM * _experimentalAtmoScale;
        t12.x = 0.5 / t4.x;
        t12.x = t3.x * t12.x;
        t12.x = sqrt(t12.x);
        t12.xy = vec2(t3.y * t12.x, t3.z * t12.x);
        ti5.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t12.xxyx).xz) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t12.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti5.xz = (-ti5.xz) + ti6.xy;
        t5.xz = vec2(ti5.xz);
        t7.xyz = t12.xxy * t12.xxy;
        tb19 = t5.x<t5.z;
        t29 = t7.x * 1.44269502;
        t29 = exp2(t29);
        t19 = tb19 ? t29 : float(0.0);
        t6.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t12.xy = abs(t12.xy) * vec2(2.31929994, 2.31929994) + t6.xy;
        t12.xy = t5.xz / t12.xy;
        t26 = (-t26) / t4.x;
        t26 = t28 * t26;
        t26 = t26 * 1.44269502;
        t6.w = exp2(t26);
        t12.xy = vec2(t12.x * t6.z, t12.y * t6.w);
        t26 = t3.x * t4.x;
        t26 = t26 * 6.28310013;
        t26 = sqrt(t26);
        t4.x = t13.x / t4.x;
        t4.x = t4.x * 1.44269502;
        t4.x = exp2(t4.x);
        t26 = t26 * t4.x;
        t4.x = dot(t12.xy, vec2(1.0, -1.0));
        t19 = t19 + t4.x;
        t26 = t26 * t19;
        t4.xyz = vec3(t26) * betaMEx.xyzx.xyz;
        t4.xyz = (-betaR.xyzx.xyz) * vec3(t27) + (-t4.xyz);
        t4.xyz = t4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t4.xyz = exp2(t4.xyz);
    } else {
        t26 = t3.x + (-Rg);
        t1.x = t26 / t1.x;
        t5.y = sqrt(t1.x);
        t1.x = t3.y + 0.150000006;
        t1.x = t1.x * 12.262105;
        t26 = min(abs(t1.x), 1.0);
        t3.x = max(abs(t1.x), 1.0);
        t3.x = float(1.0) / t3.x;
        t26 = t26 * t3.x;
        t3.x = t26 * t26;
        t11 = t3.x * 0.0208350997 + -0.0851330012;
        t11 = t3.x * t11 + 0.180141002;
        t11 = t3.x * t11 + -0.330299497;
        t3.x = t3.x * t11 + 0.999866009;
        t11 = t26 * t3.x;
        tb19 = 1.0<abs(t1.x);
        t11 = t11 * -2.0 + 1.57079637;
        t11 = tb19 ? t11 : float(0.0);
        t26 = t26 * t3.x + t11;
        t1.x = min(t1.x, 1.0);
        tb1 = t1.x<(-t1.x);
        t1.x = (tb1) ? (-t26) : t26;
        t5.x = t1.x * 0.666666687;
        t4.xyz = textureLod(_Transmittance, t5.xy, 0.0).xyz;
    //ENDIF
    }
    t1.x = t4.y + t4.x;
    t1.x = t4.z + t1.x;
    t1.x = t1.x * 0.333333343;
    t26 = (-_Extinction_Tint) + 1.0;
    t1.x = t1.x * t26;
    t3.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t4.xyz + t1.xxx;
    t3.xyz = t3.xyz * vec3(extinctionMultiplier);
    tb1 = 0.0>=t10;
    if(tb1){
        t1.x = (-extinctionRimFade) + 1.0;
        t4.xyz = t1.xxx * t3.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t1.x = (-t2.x) * t2.x + t25;
        t1.x = (-t18) * t1.x + t17;
        tb17 = t1.x>=0.0;
        t1.x = sqrt(t1.x);
        t25 = (-t9.x) * 2.0 + (-t1.x);
        t25 = t25 / t24;
        tb2 = t25<0.0;
        t1.x = (-t9.x) * 2.0 + t1.x;
        t24 = t1.x / t24;
        t24 = (tb2) ? t24 : t25;
        t24 = (tb17) ? t24 : -1.0;
        tb1 = t24!=-1.0;
        if(tb1){
            t0.xyz = t0.xyz * vec3(t24) + _WorldSpaceCameraPos.xyzx.xyz;
            t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
            t24 = dot(t1.xyz, t1.xyz);
            t24 = sqrt(t24);
            t1.xyz = t1.xyz / vec3(t24);
            t25 = 1.0;
            ti2 = 0x0;
            while(true){
                tb10 = ti2>=0x4;
                if(tb10){break;}
                t10 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
                tb18 = 0.0>=t10;
                if(tb18){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
                t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
                t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t18 = dot(t5.xyz, t5.xyz);
                t18 = sqrt(t18);
                t5.xyz = t5.xyz / vec3(t18);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t26 = dot(t6.xyz, t6.xyz);
                t26 = sqrt(t26);
                t26 = min(t26, 1.0);
                t27 = (-t26) + 1.0;
                t27 = sqrt(t27);
                t28 = t26 * -0.0187292993 + 0.0742610022;
                t28 = t28 * t26 + -0.212114394;
                t26 = t28 * t26 + 1.57072878;
                t26 = (-t26) * t27 + 1.57079637;
                t10 = t10 / t18;
                t10 = min(t10, 1.0);
                t18 = -abs(t10) + 1.0;
                t18 = sqrt(t18);
                t27 = abs(t10) * -0.0187292993 + 0.0742610022;
                t27 = t27 * abs(t10) + -0.212114394;
                t27 = t27 * abs(t10) + 1.57072878;
                t28 = t18 * t27;
                t28 = t28 * -2.0 + 3.14159274;
                tb10 = t10<(-t10);
                t10 = tb10 ? t28 : float(0.0);
                t10 = t27 * t18 + t10;
                t10 = (-t10) + 1.57079637;
                t10 = (-t10) + t26;
                t10 = t24 * t10;
                t10 = (-t10) / sunPosAndRadius.w;
                t10 = t10 + 1.0;
                t10 = t10 * 0.5;
                t10 = clamp(t10, 0.0, 1.0);
                t18 = t10 * -2.0 + 3.0;
                t10 = t10 * t10;
                t10 = t10 * t18;
                t18 = dot(t1.xyz, t5.xyz);
                t18 = t18 * 5.0;
                t18 = clamp(t18, 0.0, 1.0);
                t26 = t18 * -2.0 + 3.0;
                t18 = t18 * t18;
                t18 = t18 * t26;
                t10 = (-t10) * t18 + 1.0;
                t25 = t25 * t10;
                ti2 = ti2 + 0x1;
            }
            t2.x = t25;
            ti10 = 0x0;
            while(true){
                tb18 = ti10>=0x4;
                if(tb18){break;}
                t18 = dot(lightOccluders2[3], immediateConstBufferF[ti10]);
                tb26 = 0.0>=t18;
                if(tb26){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti10]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti10]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti10]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t26 = dot(t5.xyz, t5.xyz);
                t26 = sqrt(t26);
                t5.xyz = t5.xyz / vec3(t26);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t27 = dot(t6.xyz, t6.xyz);
                t27 = sqrt(t27);
                t27 = min(t27, 1.0);
                t28 = (-t27) + 1.0;
                t28 = sqrt(t28);
                t29 = t27 * -0.0187292993 + 0.0742610022;
                t29 = t29 * t27 + -0.212114394;
                t27 = t29 * t27 + 1.57072878;
                t27 = (-t27) * t28 + 1.57079637;
                t18 = t18 / t26;
                t18 = min(t18, 1.0);
                t26 = -abs(t18) + 1.0;
                t26 = sqrt(t26);
                t28 = abs(t18) * -0.0187292993 + 0.0742610022;
                t28 = t28 * abs(t18) + -0.212114394;
                t28 = t28 * abs(t18) + 1.57072878;
                t29 = t26 * t28;
                t29 = t29 * -2.0 + 3.14159274;
                tb18 = t18<(-t18);
                t18 = tb18 ? t29 : float(0.0);
                t18 = t28 * t26 + t18;
                t18 = (-t18) + 1.57079637;
                t18 = (-t18) + t27;
                t18 = t24 * t18;
                t18 = (-t18) / sunPosAndRadius.w;
                t18 = t18 + 1.0;
                t18 = t18 * 0.5;
                t18 = clamp(t18, 0.0, 1.0);
                t26 = t18 * -2.0 + 3.0;
                t18 = t18 * t18;
                t18 = t18 * t26;
                t26 = dot(t1.xyz, t5.xyz);
                t26 = t26 * 5.0;
                t26 = clamp(t26, 0.0, 1.0);
                t27 = t26 * -2.0 + 3.0;
                t26 = t26 * t26;
                t26 = t26 * t27;
                t18 = (-t18) * t26 + 1.0;
                t2.x = t18 * t2.x;
                ti10 = ti10 + 0x1;
            }
        } else {
            t2.x = 1.0;
        //ENDIF
        }
        t0.xyz = t2.xxx * t3.xyz;
        t24 = (-extinctionGroundFade) + 1.0;
        t4.xyz = vec3(t24) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_ON" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
// XXX ADRENOCONSTARRAYBUG
#define immediateConstBufferF (vec4[4] (\
	vec4(1, 0, 0, 0), \
	vec4(0, 1, 0, 0), \
	vec4(0, 0, 1, 0), \
	vec4(0, 0, 0, 1)))
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _Extinction_Tint;
uniform 	float extinctionMultiplier;
uniform 	float extinctionRimFade;
uniform 	float extinctionGroundFade;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
uniform  sampler2D _Transmittance;
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec3 t0;
vec3 t1;
bool tb1;
vec2 t2;
int ti2;
bool tb2;
vec3 t3;
vec4 t4;
vec3 t5;
ivec3 ti5;
vec4 t6;
ivec2 ti6;
vec3 t7;
vec3 t9;
float t10;
int ti10;
bool tb10;
float t11;
vec2 t12;
vec2 t13;
float t17;
bool tb17;
float t18;
bool tb18;
float t19;
bool tb19;
vec2 t20;
ivec2 ti20;
float t24;
bool tb24;
float t25;
float t26;
bool tb26;
float t27;
bool tb27;
float t28;
float t29;
bool tb29;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t0.xyz = vec3(t24) * t0.xyz;
    t24 = (-Rg) + Rt;
    t1.x = t24 * _experimentalAtmoScale;
    t2.x = t24 * _experimentalAtmoScale + Rg;
    t9.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t24 = dot(t9.xyz, t9.xyz);
    t3.x = sqrt(t24);
    t9.x = dot(t9.xyz, t0.xyz);
    t3.y = t9.x / t3.x;
    t24 = t9.x * t9.x + (-t24);
    t24 = t2.x * t2.x + t24;
    t24 = sqrt(t24);
    t24 = (-t24) + (-t9.x);
    t24 = max(t24, 0.0);
    tb17 = 0.0<t24;
    t24 = t24 + t9.x;
    t2.y = t24 / t2.x;
    t3.xy = (bool(tb17)) ? t2.xy : t3.xy;
    tb24 = t2.x<t3.x;
    if(tb24){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t24 = dot(t0.xyz, t0.xyz);
    t17 = t9.x + t9.x;
    t25 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t10 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t25 = t25 + t10;
    t10 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t25 = (-t10) * 2.0 + t25;
    t10 = (-Rg) * Rg + t25;
    t17 = t17 * t17;
    t18 = t24 * 4.0;
    t10 = (-t18) * t10 + t17;
    tb26 = t10<0.0;
    t10 = sqrt(t10);
    t10 = (-t9.x) * 2.0 + (-t10);
    t24 = t24 + t24;
    t10 = t10 / t24;
    t10 = (tb26) ? -1.0 : t10;
    tb26 = 0.0<t10;
    if(tb26){
        t26 = (-t2.x) * t2.x + t25;
        t26 = (-t18) * t26 + t17;
        tb27 = t26<0.0;
        t26 = sqrt(t26);
        t26 = (-t9.x) * 2.0 + (-t26);
        t26 = t26 / t24;
        t26 = (tb27) ? 1.0 : (-t26);
        t26 = t26 + t10;
        t27 = HR * _experimentalAtmoScale;
        t4.x = 0.5 / t27;
        t4.x = t3.x * t4.x;
        t4.x = sqrt(t4.x);
        t12.x = t26 / t3.x;
        t3.z = t3.y + t12.x;
        t4.xy = t3.yz * t4.xx;
        ti20.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t4.xyxy).xy) * 0xFFFFFFFFu);
        ti5.xy = ivec2(uvec2(lessThan(t4.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti20.xy = (-ti20.xy) + ti5.xy;
        t20.xy = vec2(ti20.xy);
        t5.xyz = t4.xxy * t4.xxy;
        tb29 = t20.x<t20.y;
        t5.x = t5.x * 1.44269502;
        t5.x = exp2(t5.x);
        t5.x = tb29 ? t5.x : float(0.0);
        t13.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t13.xy = sqrt(t13.xy);
        t4.xy = abs(t4.xy) * vec2(2.31929994, 2.31929994) + t13.xy;
        t4.xy = t20.xy / t4.xy;
        t20.x = (-t26) / t27;
        t28 = t3.x + t3.x;
        t28 = t26 / t28;
        t28 = t3.y + t28;
        t20.x = t28 * t20.x;
        t20.x = t20.x * 1.44269502;
        t6.y = exp2(t20.x);
        t6.xz = vec2(1.0, 1.0);
        t4.xy = t4.xy * t6.xy;
        t20.x = t27 * t3.x;
        t20.x = t20.x * 6.28310013;
        t20.x = sqrt(t20.x);
        t13.x = (-t3.x) + Rg;
        t27 = t13.x / t27;
        t27 = t27 * 1.44269502;
        t27 = exp2(t27);
        t27 = t27 * t20.x;
        t4.x = dot(t4.xy, vec2(1.0, -1.0));
        t4.x = t4.x + t5.x;
        t27 = t27 * t4.x;
        t4.x = HM * _experimentalAtmoScale;
        t12.x = 0.5 / t4.x;
        t12.x = t3.x * t12.x;
        t12.x = sqrt(t12.x);
        t12.xy = t3.yz * t12.xx;
        ti5.xz = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t12.xxyx).xz) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t12.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti5.xz = (-ti5.xz) + ti6.xy;
        t5.xz = vec2(ti5.xz);
        t7.xyz = t12.xxy * t12.xxy;
        tb19 = t5.x<t5.z;
        t29 = t7.x * 1.44269502;
        t29 = exp2(t29);
        t19 = tb19 ? t29 : float(0.0);
        t6.xy = t7.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t12.xy = abs(t12.xy) * vec2(2.31929994, 2.31929994) + t6.xy;
        t12.xy = t5.xz / t12.xy;
        t26 = (-t26) / t4.x;
        t26 = t28 * t26;
        t26 = t26 * 1.44269502;
        t6.w = exp2(t26);
        t12.xy = t12.xy * t6.zw;
        t26 = t3.x * t4.x;
        t26 = t26 * 6.28310013;
        t26 = sqrt(t26);
        t4.x = t13.x / t4.x;
        t4.x = t4.x * 1.44269502;
        t4.x = exp2(t4.x);
        t26 = t26 * t4.x;
        t4.x = dot(t12.xy, vec2(1.0, -1.0));
        t19 = t19 + t4.x;
        t26 = t26 * t19;
        t4.xyz = vec3(t26) * betaMEx.xyzx.xyz;
        t4.xyz = (-betaR.xyzx.xyz) * vec3(t27) + (-t4.xyz);
        t4.xyz = t4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t4.xyz = exp2(t4.xyz);
    } else {
        t26 = t3.x + (-Rg);
        t1.x = t26 / t1.x;
        t5.y = sqrt(t1.x);
        t1.x = t3.y + 0.150000006;
        t1.x = t1.x * 12.262105;
        t26 = min(abs(t1.x), 1.0);
        t3.x = max(abs(t1.x), 1.0);
        t3.x = float(1.0) / t3.x;
        t26 = t26 * t3.x;
        t3.x = t26 * t26;
        t11 = t3.x * 0.0208350997 + -0.0851330012;
        t11 = t3.x * t11 + 0.180141002;
        t11 = t3.x * t11 + -0.330299497;
        t3.x = t3.x * t11 + 0.999866009;
        t11 = t26 * t3.x;
        tb19 = 1.0<abs(t1.x);
        t11 = t11 * -2.0 + 1.57079637;
        t11 = tb19 ? t11 : float(0.0);
        t26 = t26 * t3.x + t11;
        t1.x = min(t1.x, 1.0);
        tb1 = t1.x<(-t1.x);
        t1.x = (tb1) ? (-t26) : t26;
        t5.x = t1.x * 0.666666687;
        t4 = textureLod(_Transmittance, t5.xy, 0.0);
    //ENDIF
    }
    t1.x = t4.y + t4.x;
    t1.x = t4.z + t1.x;
    t1.x = t1.x * 0.333333343;
    t26 = (-_Extinction_Tint) + 1.0;
    t1.x = t1.x * t26;
    t3.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t4.xyz + t1.xxx;
    t3.xyz = t3.xyz * vec3(extinctionMultiplier);
    tb1 = 0.0>=t10;
    if(tb1){
        t1.x = (-extinctionRimFade) + 1.0;
        t4.xyz = t1.xxx * t3.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t1.x = (-t2.x) * t2.x + t25;
        t1.x = (-t18) * t1.x + t17;
        tb17 = t1.x>=0.0;
        t1.x = sqrt(t1.x);
        t25 = (-t9.x) * 2.0 + (-t1.x);
        t25 = t25 / t24;
        tb2 = t25<0.0;
        t1.x = (-t9.x) * 2.0 + t1.x;
        t24 = t1.x / t24;
        t24 = (tb2) ? t24 : t25;
        t24 = (tb17) ? t24 : -1.0;
        tb1 = t24!=-1.0;
        if(tb1){
            t0.xyz = t0.xyz * vec3(t24) + _WorldSpaceCameraPos.xyzx.xyz;
            t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
            t24 = dot(t1.xyz, t1.xyz);
            t24 = sqrt(t24);
            t1.xyz = t1.xyz / vec3(t24);
            t25 = 1.0;
            ti2 = 0x0;
            while(true){
                tb10 = ti2>=0x4;
                if(tb10){break;}
                t10 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
                tb18 = 0.0>=t10;
                if(tb18){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
                t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
                t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t18 = dot(t5.xyz, t5.xyz);
                t18 = sqrt(t18);
                t5.xyz = t5.xyz / vec3(t18);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t26 = dot(t6.xyz, t6.xyz);
                t26 = sqrt(t26);
                t26 = min(t26, 1.0);
                t27 = (-t26) + 1.0;
                t27 = sqrt(t27);
                t28 = t26 * -0.0187292993 + 0.0742610022;
                t28 = t28 * t26 + -0.212114394;
                t26 = t28 * t26 + 1.57072878;
                t26 = (-t26) * t27 + 1.57079637;
                t10 = t10 / t18;
                t10 = min(t10, 1.0);
                t18 = -abs(t10) + 1.0;
                t18 = sqrt(t18);
                t27 = abs(t10) * -0.0187292993 + 0.0742610022;
                t27 = t27 * abs(t10) + -0.212114394;
                t27 = t27 * abs(t10) + 1.57072878;
                t28 = t18 * t27;
                t28 = t28 * -2.0 + 3.14159274;
                tb10 = t10<(-t10);
                t10 = tb10 ? t28 : float(0.0);
                t10 = t27 * t18 + t10;
                t10 = (-t10) + 1.57079637;
                t10 = (-t10) + t26;
                t10 = t24 * t10;
                t10 = (-t10) / sunPosAndRadius.w;
                t10 = t10 + 1.0;
                t10 = t10 * 0.5;
                t10 = clamp(t10, 0.0, 1.0);
                t18 = t10 * -2.0 + 3.0;
                t10 = t10 * t10;
                t10 = t10 * t18;
                t18 = dot(t1.xyz, t5.xyz);
                t18 = t18 * 5.0;
                t18 = clamp(t18, 0.0, 1.0);
                t26 = t18 * -2.0 + 3.0;
                t18 = t18 * t18;
                t18 = t18 * t26;
                t10 = (-t10) * t18 + 1.0;
                t25 = t25 * t10;
                ti2 = ti2 + 0x1;
            }
            t2.x = t25;
            ti10 = 0x0;
            while(true){
                tb18 = ti10>=0x4;
                if(tb18){break;}
                t18 = dot(lightOccluders2[3], immediateConstBufferF[ti10]);
                tb26 = 0.0>=t18;
                if(tb26){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti10]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti10]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti10]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t26 = dot(t5.xyz, t5.xyz);
                t26 = sqrt(t26);
                t5.xyz = t5.xyz / vec3(t26);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t27 = dot(t6.xyz, t6.xyz);
                t27 = sqrt(t27);
                t27 = min(t27, 1.0);
                t28 = (-t27) + 1.0;
                t28 = sqrt(t28);
                t29 = t27 * -0.0187292993 + 0.0742610022;
                t29 = t29 * t27 + -0.212114394;
                t27 = t29 * t27 + 1.57072878;
                t27 = (-t27) * t28 + 1.57079637;
                t18 = t18 / t26;
                t18 = min(t18, 1.0);
                t26 = -abs(t18) + 1.0;
                t26 = sqrt(t26);
                t28 = abs(t18) * -0.0187292993 + 0.0742610022;
                t28 = t28 * abs(t18) + -0.212114394;
                t28 = t28 * abs(t18) + 1.57072878;
                t29 = t26 * t28;
                t29 = t29 * -2.0 + 3.14159274;
                tb18 = t18<(-t18);
                t18 = tb18 ? t29 : float(0.0);
                t18 = t28 * t26 + t18;
                t18 = (-t18) + 1.57079637;
                t18 = (-t18) + t27;
                t18 = t24 * t18;
                t18 = (-t18) / sunPosAndRadius.w;
                t18 = t18 + 1.0;
                t18 = t18 * 0.5;
                t18 = clamp(t18, 0.0, 1.0);
                t26 = t18 * -2.0 + 3.0;
                t18 = t18 * t18;
                t18 = t18 * t26;
                t26 = dot(t1.xyz, t5.xyz);
                t26 = t26 * 5.0;
                t26 = clamp(t26, 0.0, 1.0);
                t27 = t26 * -2.0 + 3.0;
                t26 = t26 * t26;
                t26 = t26 * t27;
                t18 = (-t18) * t26 + 1.0;
                t2.x = t18 * t2.x;
                ti10 = ti10 + 0x1;
            }
        } else {
            t2.x = 1.0;
        //ENDIF
        }
        t0.xyz = t2.xxx * t3.xyz;
        t24 = (-extinctionGroundFade) + 1.0;
        t4.xyz = vec3(t24) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t4.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 188 math, 2 textures, 4 branches
Keywords { "ECLIPSES_OFF" }
Float 3 [HM]
Float 1 [HR]
Float 5 [Rg]
Float 6 [Rt]
Float 9 [_Extinction_Tint]
Vector 8 [_Globals_Origin]
Vector 0 [_WorldSpaceCameraPos]
Float 7 [_experimentalAtmoScale]
Vector 4 [betaMEx]
Vector 2 [betaR]
Float 10 [extinctionMultiplier]
Float 11 [extinctionRimFade]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
def c12, -1, 1, 0.5, 0
def c13, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c14, 1.44269502, 1.51999998, 4, 2.31929994
def c15, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c16, -2, 1.57079637, 0.666666687, 0.333333343
def c17, -9.99999997e-007, 0, 2, 4
dcl_texcoord v0.xyz
dcl_2d s0
add r0.xyz, -c0, v0
nrm r1.xyz, r0
mov r0.x, c5.x
add r0.y, -r0.x, c6.x
mul r0.z, r0.y, c7.x
mad r0.x, r0.y, c7.x, r0.x
mov r2.xyz, c0
add r3.xyz, r2, -c8
dp3 r0.w, r3, r3
rsq r0.w, r0.w
rcp r4.x, r0.w
dp3 r1.w, r3, r1
mul r4.y, r0.w, r1.w
mul r0.w, r4.x, r4.x
mad r0.w, r1.w, r1.w, -r0.w
mad r0.w, r0.x, r0.x, r0.w
rsq r2.w, r0.w
rcp r2.w, r2.w
cmp r0.w, r0.w, -r2.w, c17.x
add r0.w, r0.w, -r1.w
max r2.w, r0.w, c17.y
add r0.w, r1.w, r2.w
rcp r3.x, r0.x
mul r0.y, r0.w, r3.x
cmp r3.xy, -r2.w, r4, r0
if_lt r0.x, r3.x
mov r4.xyz, c12.y
else
dp3 r0.y, r1, r1
add r0.w, r1.w, r1.w
dp3 r1.x, c8, c8
dp3 r1.y, c0, c0
add r1.x, r1.y, r1.x
dp3 r1.y, c8, r2
mad r1.x, r1.y, -c17.z, r1.x
mad r1.y, c5.x, -c5.x, r1.x
mul r0.w, r0.w, r0.w
mul r1.z, r0.y, c17.w
mad r1.y, r1.z, -r1.y, r0.w
rsq r2.x, r1.y
rcp r2.x, r2.x
mad r2.x, r1.w, -c17.z, -r2.x
add r0.y, r0.y, r0.y
rcp r0.y, r0.y
mul r2.x, r0.y, r2.x
cmp r1.y, r1.y, r2.x, c12.x
if_lt -r1.y, c17.y
mad r0.x, r0.x, -r0.x, r1.x
mad r0.x, r1.z, -r0.x, r0.w
rsq r0.w, r0.x
rcp r0.w, r0.w
mad r0.w, r1.w, -c17.z, -r0.w
mul r0.y, r0.y, r0.w
cmp r0.x, r0.x, -r0.y, c12.y
add r0.x, r0.x, r1.y
mov r1.x, c7.x
mul r0.y, r1.x, c1.x
rcp r0.w, r0.y
mul r1.z, r0.w, r3.x
mul r1.z, r1.z, c12.z
rsq r1.z, r1.z
rcp r1.z, r1.z
rcp r1.w, r3.x
mad r3.z, r0.x, r1.w, r3.y
mul r1.zw, r1.z, r3.xyyz
cmp r2.xy, -r1.zwzw, c12.w, c12.y
cmp r2.zw, r1, -c12.w, -c12.y
add r2.xy, r2.zwzw, r2
mul r5.xyz, r1.zzww, r1.zzww
add r2.z, -r2.y, r2.x
mul r2.w, r5.x, c14.x
exp r2.w, r2.w
cmp r2.z, r2.z, c17.y, r2.w
mad r5.xy, r5.yzzw, c14.y, c14.z
rsq r2.w, r5.x
rsq r3.w, r5.y
rcp r5.x, r2.w
rcp r5.y, r3.w
mad r1.zw, r1_abs, c14.w, r5.xyxy
rcp r5.x, r1.z
rcp r5.y, r1.w
mul r1.zw, r2.xyxy, r5.xyxy
mul r2.x, r0.w, -r0.x
add r2.y, r3.x, r3.x
rcp r2.y, r2.y
mad r2.y, r0.x, r2.y, r3.y
mul r2.x, r2.y, r2.x
mul r2.x, r2.x, c14.x
exp r5.y, r2.x
mov r5.xz, c12.y
mul r1.zw, r1, r5.xyxy
mul r0.y, r0.y, r3.x
mul r0.y, r0.y, c13.x
rsq r0.y, r0.y
rcp r0.y, r0.y
add r2.x, -r3.x, c5.x
mul r0.w, r0.w, r2.x
mul r0.w, r0.w, c14.x
exp r0.w, r0.w
mul r0.y, r0.w, r0.y
dp2add r0.w, r1.zwzw, c12.yxzw, r2.z
mul r0.y, r0.w, r0.y
mul r0.w, r1.x, c3.x
rcp r1.x, r0.w
mul r1.z, r1.x, r3.x
mul r1.z, r1.z, c12.z
rsq r1.z, r1.z
rcp r1.z, r1.z
mul r1.zw, r3.xyyz, r1.z
cmp r2.zw, -r1, c12.w, c12.y
cmp r3.zw, r1, -c12.w, -c12.y
add r2.zw, r2, r3
mul r6.xyz, r1.zzww, r1.zzww
add r3.z, -r2.w, r2.z
mul r3.w, r6.x, c14.x
exp r3.w, r3.w
cmp r3.z, r3.z, c17.y, r3.w
mad r5.xy, r6.yzzw, c14.y, c14.z
rsq r3.w, r5.x
rsq r4.w, r5.y
rcp r5.x, r3.w
rcp r5.y, r4.w
mad r1.zw, r1_abs, c14.w, r5.xyxy
rcp r5.x, r1.z
rcp r5.y, r1.w
mul r1.zw, r2, r5.xyxy
mul r0.x, -r0.x, r1.x
mul r0.x, r2.y, r0.x
mul r0.x, r0.x, c14.x
exp r5.w, r0.x
mul r1.zw, r1, r5
mul r0.x, r0.w, r3.x
mul r0.x, r0.x, c13.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.w, r1.x, r2.x
mul r0.w, r0.w, c14.x
exp r0.w, r0.w
mul r0.x, r0.w, r0.x
dp2add r0.w, r1.zwzw, c12.yxzw, r3.z
mul r0.x, r0.w, r0.x
mul r1.xzw, r0.x, c4.xyyz
mad r0.xyw, -c2.xyzz, r0.y, -r1.xzzw
mul r0.xyw, r0, c14.x
exp r2.x, r0.x
exp r2.y, r0.y
exp r2.z, r0.w
else
add r0.x, r3.x, -c5.x
rcp r0.y, r0.z
mul r0.x, r0.y, r0.x
rsq r0.x, r0.x
rcp r0.y, r0.x
add r1.x, r3.y, c13.y
mul r1.x, r1.x, c13.z
mov_sat r1.z, r1_abs.x
add r1.w, r1_abs.x, c12.x
rcp r3.x, r1_abs.x
cmp r1.w, r1.w, r3.x, c12.y
mul r1.z, r1.w, r1.z
mul r1.w, r1.z, r1.z
mad r3.x, r1.w, c15.x, c15.y
mad r3.x, r1.w, r3.x, c13.w
mad r3.x, r1.w, r3.x, c15.z
mad r1.w, r1.w, r3.x, c15.w
mul r1.z, r1.w, r1.z
add r1.w, -r1_abs.x, c12.y
cmp r1.w, r1.w, c12.w, c12.y
mad r3.x, r1.z, c16.x, c16.y
mad r1.z, r3.x, r1.w, r1.z
min r3.x, r1.x, c12.y
cmp r1.x, r3.x, c12.w, c12.y
add r1.w, r1.z, r1.z
mad r1.x, r1.x, -r1.w, r1.z
mul r0.x, r1.x, c16.z
mov r0.zw, c17.y
texldl r2, r0, s0
endif
add r0.x, r2.y, r2.x
add r0.x, r2.z, r0.x
mul r0.x, r0.x, c16.w
lrp r1.xzw, c9.x, r2.xyyz, r0.x
mul r0.xyz, r1.xzww, c10.x
mov r2.y, c12.y
lrp r1.xzw, r0.xyyz, r2.y, c11.x
cmp r4.xyz, -r1.y, r1.xzww, r0
endif
mov oC0.xyz, r4
mov oC0.w, c12.y

"
}
SubProgram "d3d11 " {
// Stats: 151 math, 4 branches
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 432
Float 132 [HR]
Vector 144 [betaR] 3
Float 156 [HM]
Vector 176 [betaMEx] 3
Float 196 [Rg]
Float 200 [Rt]
Float 244 [_experimentalAtmoScale]
Vector 400 [_Globals_Origin] 3
Float 412 [_Extinction_Tint]
Float 416 [extinctionMultiplier]
Float 420 [extinctionRimFade]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
root12:abacabaa
eefiecedijbiplpfjjoppnmgkkhmhchjilecmikmabaaaaaapabeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdabeaaaa
eaaaaaaaamafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakicaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaai
bcaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaadcaaaaal
bcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaa
aaaaaaaaamaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
bjaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaa
abaaaaaajgahbaaaabaaaaaaelaaaaafbcaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaaaoaaaaah
ccaabaaaadaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaadcaaaaakicaabaaa
aaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaaacaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadhaaaaajdcaabaaaadaaaaaakgakbaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaadaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaabpaaaeaddkaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaabbfaaaaab
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaah
ccaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaajecaabaaa
aaaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaabaaaaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaea
ckaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaa
amaaaaaabkiacaaaaaaaaaaaamaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaakicaabaaaaaaaaaaackaabaia
ebaaaaaaabaaaaaadkaabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaalicaabaaaaaaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeadkaabaiaebaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaialpdkaabaaaaaaaaaaadbaaaaahicaabaaaabaaaaaaabeaaaaa
aaaaaaaadkaabaaaaaaaaaaabpaaaeaddkaabaaaabaaaaaadcaaaaakecaabaaa
aaaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaa
dcaaaaakccaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaalccaabaaa
aaaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaa
aaaaaaaaaoaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
dhaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaia
ebaaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaajccaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabkiacaaa
aaaaaaaaapaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaadpbkaabaaa
aaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaadaaaaaackaabaaaaaaaaaaa
elaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaahecaabaaaadaaaaaabkaabaaa
abaaaaaabkaabaaaadaaaaaadiaaaaahgcaabaaaabaaaaaakgakbaaaaaaaaaaa
fgagbaaaadaaaaaadbaaaaakdcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaajgafbaaaabaaaaaadbaaaaakmcaabaaaacaaaaaafgajbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaa
acaaaaaaegaabaiaebaaaaaaacaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaa
acaaaaaaegaabaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaafgagbaaaabaaaaaa
fgagbaaaabaaaaaadbaaaaahecaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaa
acaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaaeaaaaaaabeaaaaadlkklidp
bjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaapmcaabaaaacaaaaaafgajbaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaafmipmcdpfmipmcdpaceaaaaaaaaaaaaa
aaaaaaaaaaaaiaeaaaaaiaeaelaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaa
dcaaaaangcaabaaaabaaaaaafgagbaiaibaaaaaaabaaaaaaaceaaaaaaaaaaaaa
gjgpbeeagjgpbeeaaaaaaaaakgalbaaaacaaaaaaaoaaaaahgcaabaaaabaaaaaa
agabbaaaacaaaaaafgagbaaaabaaaaaaaoaaaaaiicaabaaaabaaaaaaakaabaia
ebaaaaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaaaoaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaa
akaabaaaacaaaaaaaaaaaaahbcaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaa
acaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaa
diaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaaf
ccaabaaaaeaaaaaadkaabaaaabaaaaaadgaaaaaifcaabaaaaeaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaiadpaaaaaaaadiaaaaahgcaabaaaabaaaaaafgagbaaa
abaaaaaaagabbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaaaaaaaaa
akaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
ciapmjeaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaajccaabaaa
acaaaaaaakaabaiaebaaaaaaadaaaaaabkiacaaaaaaaaaaaamaaaaaaaoaaaaah
ccaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaa
abaaaaaaapaaaaakccaabaaaabaaaaaajgafbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaajecaabaaaaaaaaaaadkiacaaaaaaaaaaaajaaaaaabkiacaaa
aaaaaaaaapaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaadpckaabaaa
aaaaaaaadiaaaaahccaabaaaabaaaaaaakaabaaaadaaaaaabkaabaaaabaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahgcaabaaaabaaaaaa
fgagbaaaadaaaaaafgafbaaaabaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgajbaaaabaaaaaadbaaaaakmcaabaaa
adaaaaaafgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaacaaaaaakgaobaiaebaaaaaaacaaaaaakgaobaaaadaaaaaa
claaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadiaaaaahhcaabaaaafaaaaaa
fgagbaaaabaaaaaafgagbaaaabaaaaaadbaaaaahicaabaaaabaaaaaackaabaaa
acaaaaaadkaabaaaacaaaaaadiaaaaahecaabaaaadaaaaaaakaabaaaafaaaaaa
abeaaaaadlkklidpbjaaaaafecaabaaaadaaaaaackaabaaaadaaaaaaabaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaadaaaaaadcaaaaapmcaabaaa
adaaaaaafgajbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaafmipmcdpfmipmcdp
aceaaaaaaaaaaaaaaaaaaaaaaaaaiaeaaaaaiaeaelaaaaafmcaabaaaadaaaaaa
kgaobaaaadaaaaaadcaaaaangcaabaaaabaaaaaafgagbaiaibaaaaaaabaaaaaa
aceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaakgalbaaaadaaaaaaaoaaaaah
gcaabaaaabaaaaaakgalbaaaacaaaaaafgagbaaaabaaaaaaaoaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaeaaaaaaakaabaaa
aaaaaaaadiaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaakgalbaaaaeaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaaoaaaaahecaabaaaaaaaaaaabkaabaaaacaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaapaaaaakecaabaaaaaaaaaaa
jgafbaaaabaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaaiocaabaaaabaaaaaa
agaabaaaaaaaaaaaagijcaaaaaaaaaaaalaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaaajaaaaaafgafbaaaaaaaaaaajgahbaiaebaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaadlkklidp
dlkklidpdlkklidpaaaaaaaabjaaaaafhcaabaaaacaaaaaaegacbaaaaaaaaaaa
bcaaaaabaaaaaaajbcaabaaaaaaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaaelaaaaafccaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaahecaabaaa
aaaaaaaabkaabaaaadaaaaaaabeaaaaajkjjbjdodiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaajfdbeeebddaaaaaibcaabaaaabaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaabaaaaaackaabaia
ibaaaaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajecaabaaa
abaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaaj
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdp
diaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadbaaaaai
icaabaaaabaaaaaaabeaaaaaaaaaiadpckaabaiaibaaaaaaaaaaaaaadcaaaaaj
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdp
abaaaaahecaabaaaabaaaaaadkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaa
ddaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaiaebaaaaaaaaaaaaaadhaaaaak
ecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaklkkckdp
eiaaaaalpcaabaaaacaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaabfaaaaabaaaaaaahbcaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
klkkkkdoaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaabjaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaabkaaaaaabnaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
bkaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaafgifcaaaaaaaaaaabkaaaaaadhaaaaajhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 324 math, 2 textures, 20 branches
Keywords { "ECLIPSES_ON" }
Matrix 0 [lightOccluders1]
Matrix 4 [lightOccluders2]
Float 11 [HM]
Float 9 [HR]
Float 13 [Rg]
Float 14 [Rt]
Float 17 [_Extinction_Tint]
Vector 16 [_Globals_Origin]
Vector 8 [_WorldSpaceCameraPos]
Float 15 [_experimentalAtmoScale]
Vector 12 [betaMEx]
Vector 10 [betaR]
Float 20 [extinctionGroundFade]
Float 18 [extinctionMultiplier]
Float 19 [extinctionRimFade]
Vector 21 [sunPosAndRadius]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
def c22, -9.99999997e-007, 0, 2, 4
def c23, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c24, 1.44269502, 1.51999998, 4, 2.31929994
def c25, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c26, -2, 1.57079637, 0.666666687, 0.333333343
def c27, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c28, -2, 3.14159274, 3, 5
def c29, -1, 1, 0.5, 0
def c30, -0, -1, -2, -3
defi i0, 4, 0, 0, 0
dcl_texcoord v0.xyz
dcl_2d s0
add r0.xyz, -c8, v0
nrm r1.xyz, r0
mov r0.x, c13.x
add r0.y, -r0.x, c14.x
mul r0.z, r0.y, c15.x
mad r0.x, r0.y, c15.x, r0.x
mov r2.xyz, c8
add r3.xyz, r2, -c16
dp3 r0.w, r3, r3
rsq r0.w, r0.w
rcp r4.x, r0.w
dp3 r1.w, r3, r1
mul r4.y, r0.w, r1.w
mul r0.w, r4.x, r4.x
mad r0.w, r1.w, r1.w, -r0.w
mad r0.w, r0.x, r0.x, r0.w
rsq r2.w, r0.w
rcp r2.w, r2.w
cmp r0.w, r0.w, -r2.w, c22.x
add r0.w, r0.w, -r1.w
max r2.w, r0.w, c22.y
add r0.w, r1.w, r2.w
rcp r3.x, r0.x
mul r0.y, r0.w, r3.x
cmp r3.xy, -r2.w, r4, r0
if_lt r0.x, r3.x
mov r4.xyz, c29.y
else
dp3 r0.y, r1, r1
add r0.w, r1.w, r1.w
dp3 r2.w, c16, c16
dp3 r3.w, c8, c8
add r2.w, r2.w, r3.w
dp3 r2.x, c16, r2
mad r2.x, r2.x, -c22.z, r2.w
mad r2.y, c13.x, -c13.x, r2.x
mul r0.w, r0.w, r0.w
mul r2.z, r0.y, c22.w
mad r2.y, r2.z, -r2.y, r0.w
rsq r2.w, r2.y
rcp r2.w, r2.w
mad r2.w, r1.w, -c22.z, -r2.w
add r0.y, r0.y, r0.y
rcp r0.y, r0.y
mul r2.w, r0.y, r2.w
cmp r2.y, r2.y, r2.w, c29.x
if_lt -r2.y, c22.y
mad r2.w, r0.x, -r0.x, r2.x
mad r2.w, r2.z, -r2.w, r0.w
rsq r3.w, r2.w
rcp r3.w, r3.w
mad r3.w, r1.w, -c22.z, -r3.w
mul r3.w, r0.y, r3.w
cmp r2.w, r2.w, -r3.w, c29.y
add r2.w, r2.w, r2.y
mov r5.x, c15.x
mul r3.w, r5.x, c9.x
rcp r4.w, r3.w
mul r5.y, r3.x, r4.w
mul r5.y, r5.y, c29.z
rsq r5.y, r5.y
rcp r5.y, r5.y
rcp r5.z, r3.x
mad r3.z, r2.w, r5.z, r3.y
mul r5.yz, r3, r5.y
cmp r6.xy, -r5.yzzw, c29.w, c29.y
cmp r6.zw, r5.xyyz, -c29.w, -c29.y
add r6.xy, r6.zwzw, r6
mul r7.xyz, r5.yyzw, r5.yyzw
add r5.w, -r6.y, r6.x
mul r6.z, r7.x, c24.x
exp r6.z, r6.z
cmp r5.w, r5.w, c22.y, r6.z
mad r6.zw, r7.xyyz, c24.y, c24.z
rsq r6.z, r6.z
rsq r6.w, r6.w
rcp r7.x, r6.z
rcp r7.y, r6.w
mad r5.yz, r5_abs, c24.w, r7.xxyw
rcp r7.x, r5.y
rcp r7.y, r5.z
mul r5.yz, r6.xxyw, r7.xxyw
mul r6.x, -r2.w, r4.w
add r6.y, r3.x, r3.x
rcp r6.y, r6.y
mad r6.y, r2.w, r6.y, r3.y
mul r6.x, r6.y, r6.x
mul r6.x, r6.x, c24.x
exp r7.y, r6.x
mov r7.xz, c29.y
mul r5.yz, r5, r7.xxyw
mul r3.w, r3.w, r3.x
mul r3.w, r3.w, c23.x
rsq r3.w, r3.w
rcp r3.w, r3.w
add r6.x, -r3.x, c13.x
mul r4.w, r4.w, r6.x
mul r4.w, r4.w, c24.x
exp r4.w, r4.w
mul r3.w, r3.w, r4.w
dp2add r4.w, r5.yzzw, c29.yxzw, r5.w
mul r3.w, r3.w, r4.w
mul r4.w, r5.x, c11.x
rcp r5.x, r4.w
mul r5.y, r3.x, r5.x
mul r5.y, r5.y, c29.z
rsq r5.y, r5.y
rcp r5.y, r5.y
mul r5.yz, r3, r5.y
cmp r6.zw, -r5.xyyz, c29.w, c29.y
cmp r7.xy, r5.yzzw, -c29.w, -c29.y
add r6.zw, r6, r7.xyxy
mul r8.xyz, r5.yyzw, r5.yyzw
add r3.z, -r6.w, r6.z
mul r5.w, r8.x, c24.x
exp r5.w, r5.w
cmp r3.z, r3.z, c22.y, r5.w
mad r7.xy, r8.yzzw, c24.y, c24.z
rsq r5.w, r7.x
rsq r7.x, r7.y
rcp r8.x, r5.w
rcp r8.y, r7.x
mad r5.yz, r5_abs, c24.w, r8.xxyw
rcp r7.x, r5.y
rcp r7.y, r5.z
mul r5.yz, r6.xzww, r7.xxyw
mul r2.w, -r2.w, r5.x
mul r2.w, r6.y, r2.w
mul r2.w, r2.w, c24.x
exp r7.w, r2.w
mul r5.yz, r5, r7.xzww
mul r2.w, r3.x, r4.w
mul r2.w, r2.w, c23.x
rsq r2.w, r2.w
rcp r2.w, r2.w
mul r4.w, r5.x, r6.x
mul r4.w, r4.w, c24.x
exp r4.w, r4.w
mul r2.w, r2.w, r4.w
dp2add r3.z, r5.yzzw, c29.yxzw, r3.z
mul r2.w, r2.w, r3.z
mul r5.xyz, r2.w, c12
mad r5.xyz, -c10, r3.w, -r5
mul r5.xyz, r5, c24.x
exp r6.x, r5.x
exp r6.y, r5.y
exp r6.z, r5.z
else
add r2.w, r3.x, -c13.x
rcp r0.z, r0.z
mul r0.z, r0.z, r2.w
rsq r0.z, r0.z
rcp r5.y, r0.z
add r0.z, r3.y, c23.y
mul r0.z, r0.z, c23.z
mov_sat r2.w, r0_abs.z
add r3.x, r0_abs.z, c29.x
rcp r3.y, r0_abs.z
cmp r3.x, r3.x, r3.y, c29.y
mul r2.w, r2.w, r3.x
mul r3.x, r2.w, r2.w
mad r3.y, r3.x, c25.x, c25.y
mad r3.y, r3.x, r3.y, c23.w
mad r3.y, r3.x, r3.y, c25.z
mad r3.x, r3.x, r3.y, c25.w
mul r2.w, r2.w, r3.x
add r3.x, -r0_abs.z, c29.y
cmp r3.x, r3.x, c29.w, c29.y
mad r3.y, r2.w, c26.x, c26.y
mad r2.w, r3.y, r3.x, r2.w
min r3.x, r0.z, c29.y
cmp r0.z, r3.x, c29.w, c29.y
add r3.x, r2.w, r2.w
mad r0.z, r0.z, -r3.x, r2.w
mul r5.x, r0.z, c26.z
mov r5.zw, c22.y
texldl r6, r5, s0
endif
add r0.z, r6.y, r6.x
add r0.z, r6.z, r0.z
mul r0.z, r0.z, c26.w
lrp r3.xyz, c17.x, r6, r0.z
mul r3.xyz, r3, c18.x
if_lt -r2.y, c22.y
mad r0.x, r0.x, -r0.x, r2.x
mad r0.x, r2.z, -r0.x, r0.w
rsq r0.z, r0.x
rcp r0.z, r0.z
mad r0.w, r1.w, -c22.z, -r0.z
mul r0.w, r0.y, r0.w
mad r0.z, r1.w, -c22.z, r0.z
mul r0.y, r0.y, r0.z
cmp r0.y, r0.w, r0.w, r0.y
cmp r0.x, r0.x, r0.y, c29.x
add r0.y, r0.x, c29.y
if_ne r0.y, -r0.y
mad r0.xyz, r1, r0.x, c8
add r1.xyz, -r0, c21
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rcp r1.w, r0.w
mul r1.xyz, r0.w, r1
rcp r0.w, c21.w
mov r2.x, c29.y
mov r2.y, c22.y
rep i0
add r5, r2.y, c30
mov r6.y, c22.y
cmp r2.z, -r5_abs.x, c0.w, r6.y
cmp r2.z, -r5_abs.y, c1.w, r2.z
cmp r2.z, -r5_abs.z, c2.w, r2.z
cmp r2.z, -r5_abs.w, c3.w, r2.z
if_ge -r2.z, c22.y
break_ne c29.y, -c29.y
endif
cmp r6.xyz, -r5_abs.x, c0, r6.y
cmp r6.xyz, -r5_abs.y, c1, r6
cmp r5.xyz, -r5_abs.z, c2, r6
cmp r5.xyz, -r5_abs.w, c3, r5
add r5.xyz, -r0, r5
dp3 r2.w, r5, r5
rsq r2.w, r2.w
mul r5.xyz, r2.w, r5
mul r6.xyz, r1.zxyw, r5.yzxw
mad r6.xyz, r1.yzxw, r5.zxyw, -r6
dp3 r3.w, r6, r6
rsq r3.w, r3.w
rcp r3.w, r3.w
min r4.w, r3.w, c29.y
add r3.w, -r4.w, c29.y
rsq r3.w, r3.w
rcp r3.w, r3.w
mad r5.w, r4.w, c27.x, c27.y
mad r5.w, r5.w, r4.w, c27.z
mad r4.w, r5.w, r4.w, c27.w
mad r3.w, r4.w, -r3.w, c26.y
mul r2.z, r2.w, r2.z
min r4.w, r2.z, c29.y
add r2.z, -r4_abs.w, c29.y
rsq r2.z, r2.z
rcp r2.z, r2.z
mad r2.w, r4_abs.w, c27.x, c27.y
mad r2.w, r2.w, r4_abs.w, c27.z
mad r2.w, r2.w, r4_abs.w, c27.w
mul r2.z, r2.z, r2.w
mad r2.w, r2.z, c28.x, c28.y
cmp r4.w, r4.w, c29.w, c29.y
mad r2.z, r2.w, r4.w, r2.z
add r2.z, -r2.z, c26.y
add r2.z, -r2.z, r3.w
mul r2.z, r1.w, r2.z
mad r2.z, -r2.z, r0.w, c29.y
mul_sat r2.z, r2.z, c29.z
mad r2.w, r2.z, c28.x, c28.z
mul r2.z, r2.z, r2.z
mul r2.z, r2.z, r2.w
dp3 r2.w, r1, r5
mul_sat r2.w, r2.w, c28.w
mad r3.w, r2.w, c28.x, c28.z
mul r2.w, r2.w, r2.w
mul r2.w, r2.w, r3.w
mad r2.z, r2.z, -r2.w, c29.y
mul r2.x, r2.z, r2.x
add r2.y, r2.y, c29.y
endrep
mov r2.y, r2.x
mov r2.z, c22.y
rep i0
add r5, r2.z, c30
mov r6.y, c22.y
cmp r2.w, -r5_abs.x, c4.w, r6.y
cmp r2.w, -r5_abs.y, c5.w, r2.w
cmp r2.w, -r5_abs.z, c6.w, r2.w
cmp r2.w, -r5_abs.w, c7.w, r2.w
if_ge -r2.w, c22.y
break_ne c29.y, -c29.y
endif
cmp r6.xyz, -r5_abs.x, c4, r6.y
cmp r6.xyz, -r5_abs.y, c5, r6
cmp r5.xyz, -r5_abs.z, c6, r6
cmp r5.xyz, -r5_abs.w, c7, r5
add r5.xyz, -r0, r5
dp3 r3.w, r5, r5
rsq r3.w, r3.w
mul r5.xyz, r3.w, r5
mul r6.xyz, r1.zxyw, r5.yzxw
mad r6.xyz, r1.yzxw, r5.zxyw, -r6
dp3 r4.w, r6, r6
rsq r4.w, r4.w
rcp r4.w, r4.w
min r5.w, r4.w, c29.y
add r4.w, -r5.w, c29.y
rsq r4.w, r4.w
rcp r4.w, r4.w
mad r6.x, r5.w, c27.x, c27.y
mad r6.x, r6.x, r5.w, c27.z
mad r5.w, r6.x, r5.w, c27.w
mad r4.w, r5.w, -r4.w, c26.y
mul r2.w, r2.w, r3.w
min r3.w, r2.w, c29.y
add r2.w, -r3_abs.w, c29.y
rsq r2.w, r2.w
rcp r2.w, r2.w
mad r5.w, r3_abs.w, c27.x, c27.y
mad r5.w, r5.w, r3_abs.w, c27.z
mad r5.w, r5.w, r3_abs.w, c27.w
mul r2.w, r2.w, r5.w
mad r5.w, r2.w, c28.x, c28.y
cmp r3.w, r3.w, c29.w, c29.y
mad r2.w, r5.w, r3.w, r2.w
add r2.w, -r2.w, c26.y
add r2.w, -r2.w, r4.w
mul r2.w, r1.w, r2.w
mad r2.w, -r2.w, r0.w, c29.y
mul_sat r2.w, r2.w, c29.z
mad r3.w, r2.w, c28.x, c28.z
mul r2.w, r2.w, r2.w
mul r2.w, r2.w, r3.w
dp3 r3.w, r1, r5
mul_sat r3.w, r3.w, c28.w
mad r4.w, r3.w, c28.x, c28.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.w
mad r2.w, r2.w, -r3.w, c29.y
mul r2.y, r2.w, r2.y
add r2.z, r2.z, c29.y
endrep
else
mov r2.y, c29.y
endif
mul r0.xyz, r2.y, r3
mov r1.y, c29.y
lrp r4.xyz, r0, r1.y, c20.x
else
mov r0.y, c29.y
lrp r4.xyz, r3, r0.y, c19.x
endif
endif
mov oC0.xyz, r4
mov oC0.w, c29.y

"
}
SubProgram "d3d11 " {
// Stats: 269 math, 14 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 576
Matrix 448 [lightOccluders1]
Matrix 512 [lightOccluders2]
Float 132 [HR]
Vector 144 [betaR] 3
Float 156 [HM]
Vector 176 [betaMEx] 3
Float 196 [Rg]
Float 200 [Rt]
Float 244 [_experimentalAtmoScale]
Vector 400 [_Globals_Origin] 3
Float 412 [_Extinction_Tint]
Float 416 [extinctionMultiplier]
Float 420 [extinctionRimFade]
Float 424 [extinctionGroundFade]
Vector 432 [sunPosAndRadius]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
root12:abacabaa
eefiecedgjpkkkginjofcfcnlpnlgbkgaphpnkcgabaaaaaamaceaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaceaaaa
eaaaaaaaaaajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaaceaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaiaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
icaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaadiaaaaaibcaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
apaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
apaaaaaabkiacaaaaaaaaaaaamaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaabjaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaelaaaaafbcaabaaaadaaaaaa
dkaabaaaaaaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaa
aaaaaaaaaoaaaaahccaabaaaadaaaaaabkaabaaaabaaaaaaakaabaaaadaaaaaa
dcaaaaakicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaiaebaaaaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaaaoaaaaahccaabaaa
acaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajdcaabaaaadaaaaaa
kgakbaaaabaaaaaaegaabaaaacaaaaaaegaabaaaadaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaabpaaaeaddkaabaaaaaaaaaaa
dgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
doaaaaabbfaaaaabbaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
baaaaaajicaabaaaabaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaa
bjaaaaaabaaaaaajccaabaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaabaaaaaajccaabaaaacaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaa
abaaaaaaaeaaaaaadcaaaaakicaabaaaabaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaaaeadkaabaaaabaaaaaadcaaaaamccaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaadkaabaaaabaaaaaa
diaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaadiaaaaah
ecaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaakccaabaaa
acaaaaaackaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaackaabaaaabaaaaaa
dbaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaaf
ccaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaalccaabaaaacaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaacaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajccaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaialpbkaabaaaacaaaaaadbaaaaahicaabaaa
acaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaeaddkaabaaaacaaaaaa
dcaaaaakicaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaadcaaaaakicaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaa
dkaabaaaacaaaaaackaabaaaabaaaaaadbaaaaahicaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaalicaabaaaacaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaea
dkaabaiaebaaaaaaacaaaaaaaoaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
dkaabaaaaaaaaaaadhaaaaakicaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaiadpdkaabaiaebaaaaaaacaaaaaaaaaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaabkaabaaaacaaaaaadiaaaaajicaabaaaadaaaaaabkiacaaaaaaaaaaa
aiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahbcaabaaaaeaaaaaaabeaaaaa
aaaaaadpdkaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaaadaaaaaa
akaabaaaaeaaaaaaelaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaaaoaaaaah
ccaabaaaaeaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaaaaaaaaahecaabaaa
adaaaaaabkaabaaaadaaaaaabkaabaaaaeaaaaaadiaaaaahdcaabaaaaeaaaaaa
jgafbaaaadaaaaaaagaabaaaaeaaaaaadbaaaaakmcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagaebaaaaeaaaaaadbaaaaakdcaabaaa
afaaaaaaegaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
boaaaaaimcaabaaaaeaaaaaakgaobaiaebaaaaaaaeaaaaaaagaebaaaafaaaaaa
claaaaafmcaabaaaaeaaaaaakgaobaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaa
agabbaaaaeaaaaaaagabbaaaaeaaaaaadbaaaaahicaabaaaafaaaaaackaabaaa
aeaaaaaadkaabaaaaeaaaaaadiaaaaahbcaabaaaafaaaaaaakaabaaaafaaaaaa
abeaaaaadlkklidpbjaaaaafbcaabaaaafaaaaaaakaabaaaafaaaaaaabaaaaah
bcaabaaaafaaaaaaakaabaaaafaaaaaadkaabaaaafaaaaaadcaaaaapgcaabaaa
afaaaaaafgagbaaaafaaaaaaaceaaaaaaaaaaaaafmipmcdpfmipmcdpaaaaaaaa
aceaaaaaaaaaaaaaaaaaiaeaaaaaiaeaaaaaaaaaelaaaaafgcaabaaaafaaaaaa
fgagbaaaafaaaaaadcaaaaandcaabaaaaeaaaaaaegaabaiaibaaaaaaaeaaaaaa
aceaaaaagjgpbeeagjgpbeeaaaaaaaaaaaaaaaaajgafbaaaafaaaaaaaoaaaaah
dcaabaaaaeaaaaaaogakbaaaaeaaaaaaegaabaaaaeaaaaaaaoaaaaaiecaabaaa
aeaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaaadaaaaaaaaaaaaahicaabaaa
aeaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaaaoaaaaahicaabaaaaeaaaaaa
dkaabaaaacaaaaaadkaabaaaaeaaaaaaaaaaaaahicaabaaaaeaaaaaabkaabaaa
adaaaaaadkaabaaaaeaaaaaadiaaaaahecaabaaaaeaaaaaadkaabaaaaeaaaaaa
ckaabaaaaeaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaaeaaaaaaabeaaaaa
dlkklidpbjaaaaafccaabaaaagaaaaaackaabaaaaeaaaaaadgaaaaaifcaabaaa
agaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaadiaaaaahdcaabaaa
aeaaaaaaegaabaaaaeaaaaaaegaabaaaagaaaaaadiaaaaahecaabaaaaeaaaaaa
dkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaa
aeaaaaaaabeaaaaaciapmjeaelaaaaafecaabaaaaeaaaaaackaabaaaaeaaaaaa
aaaaaaajccaabaaaafaaaaaaakaabaiaebaaaaaaadaaaaaabkiacaaaaaaaaaaa
amaaaaaaaoaaaaahicaabaaaadaaaaaabkaabaaaafaaaaaadkaabaaaadaaaaaa
diaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaackaabaaaaeaaaaaaapaaaaakbcaabaaaaeaaaaaaegaabaaaaeaaaaaa
aceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaakaabaaaafaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaakaabaaaaeaaaaaadiaaaaajbcaabaaaaeaaaaaadkiacaaaaaaaaaaa
ajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahccaabaaaaeaaaaaaabeaaaaa
aaaaaadpakaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaaakaabaaaadaaaaaa
bkaabaaaaeaaaaaaelaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaadiaaaaah
gcaabaaaaeaaaaaafgagbaaaadaaaaaafgafbaaaaeaaaaaadbaaaaakfcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgagbaaaaeaaaaaa
dbaaaaakdcaabaaaagaaaaaajgafbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaifcaabaaaafaaaaaaagacbaiaebaaaaaaafaaaaaa
agabbaaaagaaaaaaclaaaaaffcaabaaaafaaaaaaagacbaaaafaaaaaadiaaaaah
hcaabaaaahaaaaaafgagbaaaaeaaaaaafgagbaaaaeaaaaaadbaaaaahecaabaaa
adaaaaaaakaabaaaafaaaaaackaabaaaafaaaaaadiaaaaahicaabaaaafaaaaaa
akaabaaaahaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaafaaaaaadkaabaaa
afaaaaaaabaaaaahecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaaafaaaaaa
dcaaaaapdcaabaaaagaaaaaajgafbaaaahaaaaaaaceaaaaafmipmcdpfmipmcdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaaelaaaaaf
dcaabaaaagaaaaaaegaabaaaagaaaaaadcaaaaangcaabaaaaeaaaaaafgagbaia
ibaaaaaaaeaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaaagabbaaa
agaaaaaaaoaaaaahgcaabaaaaeaaaaaaagacbaaaafaaaaaafgagbaaaaeaaaaaa
aoaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaaeaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaaeaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
agaaaaaadkaabaaaacaaaaaadiaaaaahgcaabaaaaeaaaaaafgagbaaaaeaaaaaa
kgalbaaaagaaaaaadiaaaaahicaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaa
aeaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaciapmjea
elaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaoaaaaahbcaabaaaaeaaaaaa
bkaabaaaafaaaaaaakaabaaaaeaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaa
aeaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaaeaaaaaaapaaaaak
bcaabaaaaeaaaaaajgafbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaa
aaaaaaaaaaaaaaahecaabaaaadaaaaaackaabaaaadaaaaaaakaabaaaaeaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaadiaaaaai
hcaabaaaaeaaaaaapgapbaaaacaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaam
hcaabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaapgapbaaaadaaaaaa
egacbaiaebaaaaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaabjaaaaafhcaabaaaaeaaaaaa
egacbaaaaeaaaaaabcaaaaabaaaaaaajicaabaaaacaaaaaaakaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaaaoaaaaahbcaabaaaabaaaaaadkaabaaa
acaaaaaaakaabaaaabaaaaaaelaaaaafccaabaaaafaaaaaaakaabaaaabaaaaaa
aaaaaaahbcaabaaaabaaaaaabkaabaaaadaaaaaaabeaaaaajkjjbjdodiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaajfdbeeebddaaaaaiicaabaaa
acaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdeaaaaaibcaabaaa
adaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaakbcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaadaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
ccaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaochgdido
dcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
aebnkjlodcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaadiphhpdpdiaaaaahccaabaaaadaaaaaadkaabaaaacaaaaaaakaabaaa
adaaaaaadbaaaaaiecaabaaaadaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaa
abaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpabaaaaahccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaa
bkaabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaiadpdbaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaadhaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaadkaabaaaacaaaaaadiaaaaahbcaabaaaafaaaaaaakaabaaaabaaaaaa
abeaaaaaklkkckdpeiaaaaalpcaabaaaaeaaaaaaegaabaaaafaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaabfaaaaabaaaaaaahbcaabaaa
abaaaaaabkaabaaaaeaaaaaaakaabaaaaeaaaaaaaaaaaaahbcaabaaaabaaaaaa
ckaabaaaaeaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaklkkkkdoaaaaaaajicaabaaaacaaaaaadkiacaiaebaaaaaa
aaaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaa
bjaaaaaaegacbaaaaeaaaaaaagaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaadaaaaaaagiacaaaaaaaaaaabkaaaaaabnaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaeadakaabaaaabaaaaaaaaaaaaaj
bcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabkaaaaaaabeaaaaaaaaaiadp
dcaaaaakhcaabaaaaeaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaafgifcaaa
aaaaaaaabkaaaaaabcaaaaabdcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaa
ckaabaiaebaaaaaaacaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabnaaaaah
ecaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaalicaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaaaeaakaabaiaebaaaaaaabaaaaaaaoaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadbaaaaahbcaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaaeaakaabaaaabaaaaaaaoaaaaahicaabaaa
aaaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajicaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaialpdjaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaialpbpaaaeadakaabaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaa
egiccaaaabaaaaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaaegiccaaaaaaaaaaablaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadgaaaaaf
icaabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaafbcaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aeaaaaaaadaaaeadbkaabaaaacaaaaaabbaaaaajccaabaaaacaaaaaaegiocaaa
aaaaaaaabpaaaaaaegjojaaaakaabaaaacaaaaaabnaaaaahecaabaaaacaaaaaa
abeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaeadckaabaaaacaaaaaaacaaaaab
bfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaaaaaaaaaabmaaaaaaegjojaaa
akaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaaegiocaaaaaaaaaaabnaaaaaa
egjojaaaakaabaaaacaaaaaabbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaa
boaaaaaaegjojaaaakaabaaaacaaaaaaaaaaaaaihcaabaaaafaaaaaaegacbaia
ebaaaaaaaaaaaaaaegacbaaaafaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
afaaaaaaegacbaaaafaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaa
aoaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaakgakbaaaacaaaaaadiaaaaah
hcaabaaaagaaaaaacgajbaaaabaaaaaajgaebaaaafaaaaaadcaaaaakhcaabaaa
agaaaaaajgaebaaaabaaaaaacgajbaaaafaaaaaaegacbaiaebaaaaaaagaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaa
dcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaajicaabaaaaeaaaaaadkaabaaaaeaaaaaadkaabaaaacaaaaaa
abeaaaaaiedefjlodcaaaaajicaabaaaacaaaaaadkaabaaaaeaaaaaadkaabaaa
acaaaaaaabeaaaaakeanmjdpdcaaaaakicaabaaaacaaaaaadkaabaiaebaaaaaa
acaaaaaadkaabaaaadaaaaaaabeaaaaanlapmjdpaoaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaackaabaaaacaaaaaaddaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaacaaaaaabkaabaiambaaaaaa
acaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaa
dcaaaaakicaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaadaaaaaadkaabaaa
adaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdpdiaaaaahicaabaaa
aeaaaaaackaabaaaacaaaaaadkaabaaaadaaaaaadcaaaaajicaabaaaaeaaaaaa
dkaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaaiccaabaaa
acaaaaaabkaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaadkaabaaaaeaaaaaadcaaaaajccaabaaaacaaaaaa
dkaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaacaaaaaaaaaaaaaiccaabaaa
acaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaanlapmjdpaaaaaaaiccaabaaa
acaaaaaabkaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaa
acaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaaaoaaaaajccaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpdicaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaajecaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaackaabaaaacaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaafaaaaaadicaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
aaaakaeadcaaaaajicaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
dcaaaaakccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaaboaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaabaaaaaa
bgaaaaabdgaaaaafbcaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaafccaabaaa
acaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahecaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaeaaaaaaadaaaeadckaabaaaacaaaaaabbaaaaajecaabaaa
acaaaaaaegiocaaaaaaaaaaacdaaaaaaegjojaaabkaabaaaacaaaaaabnaaaaah
icaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaabpaaaeaddkaabaaa
acaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaaaaaaaaaa
caaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaaegiocaaa
aaaaaaaacbaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaajecaabaaaafaaaaaa
egiocaaaaaaaaaaaccaaaaaaegjojaaabkaabaaaacaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaafaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaaaoaaaaahhcaabaaaafaaaaaaegacbaaaafaaaaaapgapbaaa
acaaaaaadiaaaaahhcaabaaaagaaaaaacgajbaaaabaaaaaajgaebaaaafaaaaaa
dcaaaaakhcaabaaaagaaaaaajgaebaaaabaaaaaacgajbaaaafaaaaaaegacbaia
ebaaaaaaagaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaagaaaaaaegacbaaa
agaaaaaaelaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaaddaaaaahicaabaaa
adaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaeaaaaaa
dkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaeaaaaaa
dkaabaaaaeaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaa
dkaabaaaadaaaaaaabeaaaaaiedefjlodcaaaaajicaabaaaadaaaaaadkaabaaa
afaaaaaadkaabaaaadaaaaaaabeaaaaakeanmjdpdcaaaaakicaabaaaadaaaaaa
dkaabaiaebaaaaaaadaaaaaadkaabaaaaeaaaaaaabeaaaaanlapmjdpaoaaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaaddaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaacaaaaaa
ckaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaakicaabaaaaeaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaaeaaaaaadkaabaaa
aeaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaa
aeaaaaaadkaabaaaaeaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaakeanmjdp
diaaaaahicaabaaaafaaaaaadkaabaaaacaaaaaadkaabaaaaeaaaaaadcaaaaaj
icaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejea
dbaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaa
abaaaaahecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaafaaaaaadcaaaaaj
ecaabaaaacaaaaaadkaabaaaaeaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
aaaaaaaiecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaanlapmjdp
aaaaaaaiecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaadkaabaaaadaaaaaa
diaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaoaaaaaj
ecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaablaaaaaa
aaaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdicaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaajicaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaafaaaaaadicaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaakaeadcaaaaajicaabaaaadaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
dkaabaaaadaaaaaadcaaaaakecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaacaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaboaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaaabaaaaaabgaaaaabbcaaaaabdgaaaaafbcaabaaaacaaaaaaabeaaaaa
aaaaiadpbfaaaaabdiaaaaahhcaabaaaaaaaaaaaagaabaaaacaaaaaaegacbaaa
adaaaaaaaaaaaaajicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaabkaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaakgikcaaaaaaaaaaabkaaaaaabfaaaaabdgaaaaafhccabaaaaaaaaaaa
egacbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "gles " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_ON" }
"!!GL3x"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 //        gles : 326 avg math (230..423), 4 texture, 13 avg branch (8..18)
 //      opengl : 326 avg math (230..423), 4 texture, 13 avg branch (8..18)
 // Stats for Fragment shader:
 //       d3d11 : 215 avg math (157..274), 4 avg branch (0..8)
 //        d3d9 : 270 avg math (202..338), 8 texture, 7 avg branch (0..14)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend One One
  GpuProgramID 108995
Program "vp" {
SubProgram "opengl " {
// Stats: 230 math, 4 textures, 8 branches
Keywords { "ECLIPSES_OFF" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _Inscatter;
uniform float M_PI;
uniform vec3 betaR;
uniform float mieG;
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform float _Sun_Intensity;
uniform float _experimentalAtmoScale;
uniform float _viewdirOffset;
uniform float _Alpha_Global;
uniform vec3 _Globals_Origin;
uniform float _RimExposure;
uniform vec3 _Sun_WorldSunDir;
float xlat_mutableRt;
float xlat_mutable_Exposure;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  xlat_mutableRt = Rt;
  xlat_mutable_Exposure = _Exposure;
  vec3 tmpvar_1;
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  float tmpvar_5;
  if ((tmpvar_4 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_3) - sqrt(tmpvar_4)) / (2.0 * tmpvar_2));
  };
  bool tmpvar_6;
  tmpvar_6 = (tmpvar_5 > 0.0);
  if (!(tmpvar_6)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 camera_7;
  camera_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  vec3 viewdir_8;
  viewdir_8.yz = tmpvar_1.yz;
  float rMu_9;
  float r_10;
  vec3 result_11;
  result_11 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(viewdir_8);
  viewdir_8 = tmpvar_12;
  float tmpvar_13;
  tmpvar_13 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = dot (camera_7, tmpvar_12);
  rMu_9 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = max ((-(tmpvar_14) - sqrt(
    (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_15 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_15 * tmpvar_12));
    rMu_9 = (tmpvar_14 + tmpvar_15);
    r_10 = xlat_mutableRt;
  };
  float tmpvar_16;
  tmpvar_16 = dot (tmpvar_12, _Sun_WorldSunDir);
  float tmpvar_17;
  tmpvar_17 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  vec4 tmpvar_18;
  float _lerp_19;
  float tmpvar_20;
  float tmpvar_21;
  tmpvar_21 = (Rg * Rg);
  tmpvar_20 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_21));
  float tmpvar_22;
  tmpvar_22 = sqrt(((r_10 * r_10) - tmpvar_21));
  float tmpvar_23;
  tmpvar_23 = (r_10 * (rMu_9 / r_10));
  float tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * tmpvar_23) - (r_10 * r_10)) + tmpvar_21);
  vec4 tmpvar_25;
  if (((tmpvar_23 < 0.0) && (tmpvar_24 > 0.0))) {
    vec4 tmpvar_26;
    tmpvar_26.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_26.w = (0.5 - (0.5 / RES_MU));
    tmpvar_25 = tmpvar_26;
  } else {
    vec4 tmpvar_27;
    tmpvar_27.x = -1.0;
    tmpvar_27.y = (tmpvar_20 * tmpvar_20);
    tmpvar_27.z = tmpvar_20;
    tmpvar_27.w = (0.5 + (0.5 / RES_MU));
    tmpvar_25 = tmpvar_27;
  };
  float tmpvar_28;
  tmpvar_28 = ((0.5 / RES_R) + ((tmpvar_22 / tmpvar_20) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_29;
  tmpvar_29 = (tmpvar_25.w + ((
    ((tmpvar_23 * tmpvar_25.x) + sqrt((tmpvar_24 + tmpvar_25.y)))
   / 
    (tmpvar_22 + tmpvar_25.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_30;
  y_over_x_30 = (max (tmpvar_17, -0.1975) * 5.349625);
  float tmpvar_31;
  tmpvar_31 = (min (abs(y_over_x_30), 1.0) / max (abs(y_over_x_30), 1.0));
  float tmpvar_32;
  tmpvar_32 = (tmpvar_31 * tmpvar_31);
  tmpvar_32 = (((
    ((((
      ((((-0.01213232 * tmpvar_32) + 0.05368138) * tmpvar_32) - 0.1173503)
     * tmpvar_32) + 0.1938925) * tmpvar_32) - 0.3326756)
   * tmpvar_32) + 0.9999793) * tmpvar_31);
  tmpvar_32 = (tmpvar_32 + (float(
    (abs(y_over_x_30) > 1.0)
  ) * (
    (tmpvar_32 * -2.0)
   + 1.570796)));
  float tmpvar_33;
  tmpvar_33 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_32 * sign(y_over_x_30)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_34;
  tmpvar_34 = (((tmpvar_16 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_35;
  tmpvar_35 = floor(tmpvar_34);
  _lerp_19 = (tmpvar_34 - tmpvar_35);
  float tmpvar_36;
  tmpvar_36 = (floor((
    (tmpvar_28 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_37;
  tmpvar_37 = (floor((tmpvar_28 * RES_R)) / RES_R);
  float tmpvar_38;
  tmpvar_38 = fract((tmpvar_28 * RES_R));
  vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_35 + tmpvar_33) / RES_NU);
  tmpvar_39.y = ((tmpvar_29 / RES_R) + tmpvar_36);
  vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_35 + tmpvar_33) + 1.0) / RES_NU);
  tmpvar_40.y = ((tmpvar_29 / RES_R) + tmpvar_36);
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_35 + tmpvar_33) / RES_NU);
  tmpvar_41.y = ((tmpvar_29 / RES_R) + tmpvar_37);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = (((tmpvar_35 + tmpvar_33) + 1.0) / RES_NU);
  tmpvar_42.y = ((tmpvar_29 / RES_R) + tmpvar_37);
  tmpvar_18 = (((
    (texture2DLod (_Inscatter, tmpvar_39.xy, 0.0) * (1.0 - _lerp_19))
   + 
    (texture2DLod (_Inscatter, tmpvar_40.xy, 0.0) * _lerp_19)
  ) * (1.0 - tmpvar_38)) + ((
    (texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * (1.0 - _lerp_19))
   + 
    (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * _lerp_19)
  ) * tmpvar_38));
  if ((r_10 <= xlat_mutableRt)) {
    float tmpvar_43;
    tmpvar_43 = (mieG * mieG);
    result_11 = ((tmpvar_18.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_16 * tmpvar_16))
    )) + ((
      ((tmpvar_18.xyz * tmpvar_18.w) / max (tmpvar_18.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_43)) * pow ((
        (1.0 + tmpvar_43)
       - 
        ((2.0 * mieG) * tmpvar_16)
      ), -1.5)) * (1.0 + (tmpvar_16 * tmpvar_16)))
     / 
      (2.0 + tmpvar_43)
    )));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  vec3 L_44;
  L_44 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  float tmpvar_45;
  if ((L_44.x < 1.413)) {
    tmpvar_45 = pow ((L_44.x * 0.38317), 0.4545454);
  } else {
    tmpvar_45 = (1.0 - exp(-(L_44.x)));
  };
  L_44.x = tmpvar_45;
  float tmpvar_46;
  if ((L_44.y < 1.413)) {
    tmpvar_46 = pow ((L_44.y * 0.38317), 0.4545454);
  } else {
    tmpvar_46 = (1.0 - exp(-(L_44.y)));
  };
  L_44.y = tmpvar_46;
  float tmpvar_47;
  if ((L_44.z < 1.413)) {
    tmpvar_47 = pow ((L_44.z * 0.38317), 0.4545454);
  } else {
    tmpvar_47 = (1.0 - exp(-(L_44.z)));
  };
  L_44.z = tmpvar_47;
  vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = (_Alpha_Global * L_44);
  gl_FragData[0] = tmpvar_48;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedfjicacgdojlnjhcbpknjldogdgpohelmabaaaaaahmacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaa
eaaaabaafpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
aaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 230 math, 4 textures, 8 branches
Keywords { "ECLIPSES_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform highp float _experimentalAtmoScale;
uniform highp float _viewdirOffset;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_Origin;
uniform highp float _RimExposure;
uniform highp vec3 _Sun_WorldSunDir;
highp float xlat_mutableRt;
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  xlat_mutableRt = Rt;
  xlat_mutable_Exposure = _Exposure;
  highp vec3 tmpvar_1;
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_5;
  if ((tmpvar_4 < 0.0)) {
    tmpvar_5 = -1.0;
  } else {
    tmpvar_5 = ((-(tmpvar_3) - sqrt(tmpvar_4)) / (2.0 * tmpvar_2));
  };
  bool tmpvar_6;
  tmpvar_6 = (tmpvar_5 > 0.0);
  if (!(tmpvar_6)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 camera_7;
  camera_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp vec3 viewdir_8;
  viewdir_8.yz = tmpvar_1.yz;
  highp float rMu_9;
  highp float r_10;
  highp vec3 result_11;
  result_11 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(viewdir_8);
  viewdir_8 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (camera_7, tmpvar_12);
  rMu_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max ((-(tmpvar_14) - sqrt(
    (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_15 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_15 * tmpvar_12));
    rMu_9 = (tmpvar_14 + tmpvar_15);
    r_10 = xlat_mutableRt;
  };
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_12, _Sun_WorldSunDir);
  highp float tmpvar_17;
  tmpvar_17 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_18;
  highp float _lerp_19;
  highp float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = (Rg * Rg);
  tmpvar_20 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_21));
  highp float tmpvar_22;
  tmpvar_22 = sqrt(((r_10 * r_10) - tmpvar_21));
  highp float tmpvar_23;
  tmpvar_23 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_23 * tmpvar_23) - (r_10 * r_10)) + tmpvar_21);
  highp vec4 tmpvar_25;
  if (((tmpvar_23 < 0.0) && (tmpvar_24 > 0.0))) {
    highp vec4 tmpvar_26;
    tmpvar_26.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_26.w = (0.5 - (0.5 / RES_MU));
    tmpvar_25 = tmpvar_26;
  } else {
    highp vec4 tmpvar_27;
    tmpvar_27.x = -1.0;
    tmpvar_27.y = (tmpvar_20 * tmpvar_20);
    tmpvar_27.z = tmpvar_20;
    tmpvar_27.w = (0.5 + (0.5 / RES_MU));
    tmpvar_25 = tmpvar_27;
  };
  highp float tmpvar_28;
  tmpvar_28 = ((0.5 / RES_R) + ((tmpvar_22 / tmpvar_20) * (1.0 - 
    (1.0/(RES_R))
  )));
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_25.w + ((
    ((tmpvar_23 * tmpvar_25.x) + sqrt((tmpvar_24 + tmpvar_25.y)))
   / 
    (tmpvar_22 + tmpvar_25.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_17, -0.1975) * 5.349625);
  highp float tmpvar_31;
  tmpvar_31 = (min (abs(y_over_x_30), 1.0) / max (abs(y_over_x_30), 1.0));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_31 * tmpvar_31);
  tmpvar_32 = (((
    ((((
      ((((-0.01213232 * tmpvar_32) + 0.05368138) * tmpvar_32) - 0.1173503)
     * tmpvar_32) + 0.1938925) * tmpvar_32) - 0.3326756)
   * tmpvar_32) + 0.9999793) * tmpvar_31);
  tmpvar_32 = (tmpvar_32 + (float(
    (abs(y_over_x_30) > 1.0)
  ) * (
    (tmpvar_32 * -2.0)
   + 1.570796)));
  highp float tmpvar_33;
  tmpvar_33 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_32 * sign(y_over_x_30)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  highp float tmpvar_34;
  tmpvar_34 = (((tmpvar_16 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_35;
  tmpvar_35 = floor(tmpvar_34);
  _lerp_19 = (tmpvar_34 - tmpvar_35);
  highp float tmpvar_36;
  tmpvar_36 = (floor((
    (tmpvar_28 * RES_R)
   - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((tmpvar_28 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((tmpvar_28 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_35 + tmpvar_33) / RES_NU);
  tmpvar_39.y = ((tmpvar_29 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_35 + tmpvar_33) + 1.0) / RES_NU);
  tmpvar_41.y = ((tmpvar_29 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_35 + tmpvar_33) / RES_NU);
  tmpvar_43.y = ((tmpvar_29 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_35 + tmpvar_33) + 1.0) / RES_NU);
  tmpvar_45.y = ((tmpvar_29 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_18 = (((
    (tmpvar_40 * (1.0 - _lerp_19))
   + 
    (tmpvar_42 * _lerp_19)
  ) * (1.0 - tmpvar_38)) + ((
    (tmpvar_44 * (1.0 - _lerp_19))
   + 
    (tmpvar_46 * _lerp_19)
  ) * tmpvar_38));
  if ((r_10 <= xlat_mutableRt)) {
    highp float tmpvar_47;
    tmpvar_47 = (mieG * mieG);
    result_11 = ((tmpvar_18.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_16 * tmpvar_16))
    )) + ((
      ((tmpvar_18.xyz * tmpvar_18.w) / max (tmpvar_18.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_47)) * pow ((
        (1.0 + tmpvar_47)
       - 
        ((2.0 * mieG) * tmpvar_16)
      ), -1.5)) * (1.0 + (tmpvar_16 * tmpvar_16)))
     / 
      (2.0 + tmpvar_47)
    )));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_48;
  L_48 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  highp float tmpvar_49;
  if ((L_48.x < 1.413)) {
    tmpvar_49 = pow ((L_48.x * 0.38317), 0.4545454);
  } else {
    tmpvar_49 = (1.0 - exp(-(L_48.x)));
  };
  L_48.x = tmpvar_49;
  highp float tmpvar_50;
  if ((L_48.y < 1.413)) {
    tmpvar_50 = pow ((L_48.y * 0.38317), 0.4545454);
  } else {
    tmpvar_50 = (1.0 - exp(-(L_48.y)));
  };
  L_48.y = tmpvar_50;
  highp float tmpvar_51;
  if ((L_48.z < 1.413)) {
    tmpvar_51 = pow ((L_48.z * 0.38317), 0.4545454);
  } else {
    tmpvar_51 = (1.0 - exp(-(L_48.z)));
  };
  L_48.z = tmpvar_51;
  highp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = (_Alpha_Global * L_48);
  gl_FragData[0] = tmpvar_52;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform lowp sampler2D _Inscatter;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec4 t0;
bvec4 tb0;
highp vec4 t1;
lowp vec4 t10_1;
highp int ti1;
highp vec3 t2;
highp vec4 t3;
bool tb3;
highp vec3 t4;
highp vec4 t5;
lowp vec4 t10_5;
highp vec4 t6;
lowp vec4 t10_6;
highp vec3 t7;
highp float t8;
highp vec3 t9;
bool tb9;
highp vec3 t10;
highp float t11;
highp float t12;
highp float t16;
highp float t17;
bool tb17;
highp vec2 t18;
bool tb20;
highp float t24;
highp int ti24;
highp float t25;
highp float t26;
highp int ti26;
bool tb26;
highp float t27;
bool tb27;
void main()
{
    t0.xyz = vec3(1.0, 0.0, 0.0);
    t1.x = -1.0;
    t2.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t26 = dot(t2.xyz, t2.xyz);
    t26 = inversesqrt(t26);
    t3.x = t2.x * t26 + _viewdirOffset;
    t3.yzw = vec3(t26) * t2.xyz;
    t2.x = dot(t3.xzw, t3.xzw);
    t2.x = inversesqrt(t2.x);
    t2.xyz = t2.xxx * t3.xzw;
    t4.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t5.y = dot(t4.xyz, t2.xyz);
    t26 = dot(t4.xyz, t4.xyz);
    t3.x = t5.y * t5.y + (-t26);
    t5.x = sqrt(t26);
    t26 = (-Rg) + Rt;
    t6.x = t26 * _experimentalAtmoScale + Rg;
    t26 = t6.x * t6.x + t3.x;
    t26 = sqrt(t26);
    t26 = (-t26) + (-t5.y);
    t26 = max(t26, 0.0);
    t6.y = t26 + t5.y;
    tb3 = 0.0<t26;
    t7.xyz = vec3(t26) * t2.xyz + t4.xyz;
    t2.x = dot(t2.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t10.xyz = (bool(tb3)) ? t7.xyz : t4.xyz;
    t4.x = dot(t3.yzw, t4.xyz);
    t11 = dot(t3.yzw, t3.yzw);
    t3.xz = (bool(tb3)) ? t6.xy : t5.xy;
    t10.x = dot(t10.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t10.x = t10.x / t3.x;
    t10.x = max(t10.x, -0.197500005);
    t10.x = t10.x * 5.34962368;
    t18.x = t3.x * t3.x;
    t18.x = t3.z * t3.z + (-t18.x);
    t18.x = Rg * Rg + t18.x;
    tb26 = 0.0<t18.x;
    tb27 = t3.z<0.0;
    ti26 = int(uint(tb26) * 0xffffffffu & uint(tb27) * 0xffffffffu);
    t27 = Rg * Rg;
    t12 = t6.x * t6.x + (-t27);
    tb20 = t6.x>=t3.x;
    t3.x = t3.x * t3.x + (-t27);
    t3.x = sqrt(t3.x);
    t1.z = sqrt(t12);
    t1.y = t1.z * t1.z;
    t5.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t0.w = (-t5.x) + 0.5;
    t1.w = t5.x + 0.5;
    t0 = (int(ti26) != 0) ? t0 : t1;
    t1.x = t3.x / t1.z;
    t16 = t0.z + t3.x;
    t8 = t0.y + t18.x;
    t8 = sqrt(t8);
    t0.x = t3.z * t0.x + t8;
    t0.x = t0.x / t16;
    t9.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t9.xyz = (-t9.xyz) + vec3(1.0, 0.5, 1.0);
    t0.x = t0.x * t9.y + t0.w;
    t8 = t1.x * t9.x + t5.y;
    t16 = t8 * RES_R + -1.0;
    t8 = t8 * RES_R;
    t0.z = floor(t16);
    t0.xz = t0.xz / vec2(RES_R);
    t6.z = t0.z + t0.x;
    t16 = max(abs(t10.x), 1.0);
    t16 = float(1.0) / t16;
    t24 = min(abs(t10.x), 1.0);
    t16 = t16 * t24;
    t24 = t16 * t16;
    t1.x = t24 * 0.0208350997 + -0.0851330012;
    t1.x = t24 * t1.x + 0.180141002;
    t1.x = t24 * t1.x + -0.330299497;
    t24 = t24 * t1.x + 0.999866009;
    t1.x = t24 * t16;
    t1.x = t1.x * -2.0 + 1.57079637;
    tb9 = 1.0<abs(t10.x);
    t17 = min(t10.x, 1.0);
    tb17 = t17<(-t17);
    t1.x = tb9 ? t1.x : float(0.0);
    t16 = t16 * t24 + t1.x;
    t16 = (tb17) ? (-t16) : t16;
    t16 = t16 * 0.909090877 + 0.74000001;
    t16 = t16 * 0.5;
    t16 = t16 * t9.z + t5.z;
    t24 = t2.x + 1.0;
    t24 = t24 * 0.5;
    t1.x = RES_NU + -1.0;
    t9.x = t24 * t1.x;
    t9.x = floor(t9.x);
    t16 = t16 + t9.x;
    t24 = t24 * t1.x + (-t9.x);
    t1.x = t16 + 1.0;
    t6.y = t16 / RES_NU;
    t6.x = t1.x / RES_NU;
    t10_1 = textureLod(_Inscatter, t6.xz, 0.0);
    t10_5 = textureLod(_Inscatter, t6.yz, 0.0);
    t1 = vec4(t24) * t10_1;
    t16 = (-t24) + 1.0;
    t1 = t10_5 * vec4(t16) + t1;
    t10.x = floor(t8);
    t8 = fract(t8);
    t10.x = t10.x / RES_R;
    t6.w = t0.x + t10.x;
    t10_5 = textureLod(_Inscatter, t6.xw, 0.0);
    t10_6 = textureLod(_Inscatter, t6.yw, 0.0);
    t5 = vec4(t24) * t10_5;
    t5 = t10_6 * vec4(t16) + t5;
    t5 = vec4(t8) * t5;
    t0.x = (-t8) + 1.0;
    t0 = t1 * t0.xxxx + t5;
    t1.xyz = t0.www * t0.xyz;
    t24 = max(t0.x, 9.99999975e-005);
    t1.xyz = t1.xyz / vec3(t24);
    t10.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t1.xyz = t1.xyz * t10.xyz;
    t24 = dot(t2.xx, vec2(vec2(mieG, mieG)));
    t25 = t2.x * t2.x + 1.0;
    t2.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t24 = (-t24) + t2.x;
    t24 = log2(t24);
    t24 = t24 * -1.5;
    t24 = exp2(t24);
    t2.x = (-mieG) * mieG + 1.0;
    t18.xy = vec2(M_PI) * vec2(16.0, 4.0);
    t18.xy = vec2(3.0, 1.5) / t18.xy;
    t2.x = t2.x * t18.y;
    t18.x = t25 * t18.x;
    t24 = t24 * t2.x;
    t24 = t25 * t24;
    t24 = t24 / t2.y;
    t1.xyz = vec3(t24) * t1.xyz;
    t0.xyz = t0.xyz * t18.xxx + t1.xyz;
    t0.xyz = mix(vec3(0.0, 0.0, 0.0), t0.xyz, vec3(bvec3(tb20)));
    t0.xyz = t0.xyz * vec3(_Sun_Intensity);
    t24 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t1.x = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t24 = t24 + t1.x;
    t1.x = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t24 = (-t1.x) * 2.0 + t24;
    t24 = (-Rg) * Rg + t24;
    t24 = t11 * t24;
    t1.x = t11 + t11;
    t24 = t24 * 4.0;
    t9.x = t4.x + t4.x;
    t24 = t9.x * t9.x + (-t24);
    t9.x = sqrt(t24);
    ti24 = int((t24<0.0) ? 0xFFFFFFFFu : uint(0u));
    t9.x = (-t4.x) * 2.0 + (-t9.x);
    t1.x = t9.x / t1.x;
    ti1 = int((0.0>=t1.x) ? 0xFFFFFFFFu : uint(0u));
    ti24 = int(uint(ti24) | uint(ti1));
    t24 = (ti24 != 0) ? _RimExposure : _Exposure;
    t0.xyz = vec3(t24) * t0.xyz;
    t1 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t1.xz);
    t9.xz = exp2(t1.yw);
    t9.xz = (-t9.xz) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb0.xyw = lessThan(t0.xyxz, vec4(1.41299999, 1.41299999, 0.0, 1.41299999)).xyw;
    t2.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = (tb0.x) ? t1.x : t9.x;
    t0.y = (tb0.y) ? t1.z : t9.z;
    t1.x = log2(t2.x);
    t9.x = exp2(t2.y);
    t9.x = (-t9.x) + 1.0;
    t1.x = t1.x * 0.454545468;
    t1.x = exp2(t1.x);
    t0.z = (tb0.w) ? t1.x : t9.x;
    SV_Target0.xyz = t0.xyz * vec3(vec3(_Alpha_Global, _Alpha_Global, _Alpha_Global));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_OFF" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform  sampler2D _Inscatter;
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec4 t0;
bvec4 tb0;
vec4 t1;
lowp vec4 t10_1;
int ti1;
vec3 t2;
vec4 t3;
bool tb3;
vec3 t4;
vec4 t5;
lowp vec4 t10_5;
vec4 t6;
lowp vec4 t10_6;
vec3 t7;
float t8;
vec3 t9;
bool tb9;
vec3 t10;
float t11;
float t12;
float t16;
float t17;
bool tb17;
vec2 t18;
bool tb20;
float t24;
int ti24;
float t25;
float t26;
int ti26;
bool tb26;
float t27;
bool tb27;
void main()
{
    t0.xyz = vec3(1.0, 0.0, 0.0);
    t1.x = -1.0;
    t2.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t26 = dot(t2.xyz, t2.xyz);
    t26 = inversesqrt(t26);
    t3.x = t2.x * t26 + _viewdirOffset;
    t3.yzw = vec3(t26) * t2.xyz;
    t2.x = dot(t3.xzw, t3.xzw);
    t2.x = inversesqrt(t2.x);
    t2.xyz = t2.xxx * t3.xzw;
    t4.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t5.y = dot(t4.xyz, t2.xyz);
    t26 = dot(t4.xyz, t4.xyz);
    t3.x = t5.y * t5.y + (-t26);
    t5.x = sqrt(t26);
    t26 = (-Rg) + Rt;
    t6.x = t26 * _experimentalAtmoScale + Rg;
    t26 = t6.x * t6.x + t3.x;
    t26 = sqrt(t26);
    t26 = (-t26) + (-t5.y);
    t26 = max(t26, 0.0);
    t6.y = t26 + t5.y;
    tb3 = 0.0<t26;
    t7.xyz = vec3(t26) * t2.xyz + t4.xyz;
    t2.x = dot(t2.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t10.xyz = (bool(tb3)) ? t7.xyz : t4.xyz;
    t4.x = dot(t3.yzw, t4.xyz);
    t11 = dot(t3.yzw, t3.yzw);
    t3.xz = (bool(tb3)) ? t6.xy : t5.xy;
    t10.x = dot(t10.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t10.x = t10.x / t3.x;
    t10.x = max(t10.x, -0.197500005);
    t10.x = t10.x * 5.34962368;
    t18.x = t3.x * t3.x;
    t18.x = t3.z * t3.z + (-t18.x);
    t18.x = Rg * Rg + t18.x;
    tb26 = 0.0<t18.x;
    tb27 = t3.z<0.0;
    ti26 = int(uint(tb26) * 0xffffffffu & uint(tb27) * 0xffffffffu);
    t27 = Rg * Rg;
    t12 = t6.x * t6.x + (-t27);
    tb20 = t6.x>=t3.x;
    t3.x = t3.x * t3.x + (-t27);
    t3.x = sqrt(t3.x);
    t1.z = sqrt(t12);
    t1.y = t1.z * t1.z;
    t5.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t0.w = (-t5.x) + 0.5;
    t1.w = t5.x + 0.5;
    t0 = (int(ti26) != 0) ? t0 : t1;
    t1.x = t3.x / t1.z;
    t16 = t0.z + t3.x;
    t8 = t0.y + t18.x;
    t8 = sqrt(t8);
    t0.x = t3.z * t0.x + t8;
    t0.x = t0.x / t16;
    t9.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t9.xyz = (-t9.xyz) + vec3(1.0, 0.5, 1.0);
    t0.x = t0.x * t9.y + t0.w;
    t8 = t1.x * t9.x + t5.y;
    t16 = t8 * RES_R + -1.0;
    t8 = t8 * RES_R;
    t0.z = floor(t16);
    t0.xz = t0.xz / vec2(RES_R);
    t6.z = t0.z + t0.x;
    t16 = max(abs(t10.x), 1.0);
    t16 = float(1.0) / t16;
    t24 = min(abs(t10.x), 1.0);
    t16 = t16 * t24;
    t24 = t16 * t16;
    t1.x = t24 * 0.0208350997 + -0.0851330012;
    t1.x = t24 * t1.x + 0.180141002;
    t1.x = t24 * t1.x + -0.330299497;
    t24 = t24 * t1.x + 0.999866009;
    t1.x = t24 * t16;
    t1.x = t1.x * -2.0 + 1.57079637;
    tb9 = 1.0<abs(t10.x);
    t17 = min(t10.x, 1.0);
    tb17 = t17<(-t17);
    t1.x = tb9 ? t1.x : float(0.0);
    t16 = t16 * t24 + t1.x;
    t16 = (tb17) ? (-t16) : t16;
    t16 = t16 * 0.909090877 + 0.74000001;
    t16 = t16 * 0.5;
    t16 = t16 * t9.z + t5.z;
    t24 = t2.x + 1.0;
    t24 = t24 * 0.5;
    t1.x = RES_NU + -1.0;
    t9.x = t24 * t1.x;
    t9.x = floor(t9.x);
    t16 = t16 + t9.x;
    t24 = t24 * t1.x + (-t9.x);
    t1.x = t16 + 1.0;
    t6.y = t16 / RES_NU;
    t6.x = t1.x / RES_NU;
    t10_1 = textureLod(_Inscatter, t6.xz, 0.0);
    t10_5 = textureLod(_Inscatter, t6.yz, 0.0);
    t1 = vec4(t24) * t10_1;
    t16 = (-t24) + 1.0;
    t1 = t10_5 * vec4(t16) + t1;
    t10.x = floor(t8);
    t8 = fract(t8);
    t10.x = t10.x / RES_R;
    t6.w = t0.x + t10.x;
    t10_5 = textureLod(_Inscatter, t6.xw, 0.0);
    t10_6 = textureLod(_Inscatter, t6.yw, 0.0);
    t5 = vec4(t24) * t10_5;
    t5 = t10_6 * vec4(t16) + t5;
    t5 = vec4(t8) * t5;
    t0.x = (-t8) + 1.0;
    t0 = t1 * t0.xxxx + t5;
    t1.xyz = t0.www * t0.xyz;
    t24 = max(t0.x, 9.99999975e-005);
    t1.xyz = t1.xyz / vec3(t24);
    t10.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t1.xyz = t1.xyz * t10.xyz;
    t24 = dot(t2.xx, vec2(vec2(mieG, mieG)));
    t25 = t2.x * t2.x + 1.0;
    t2.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t24 = (-t24) + t2.x;
    t24 = log2(t24);
    t24 = t24 * -1.5;
    t24 = exp2(t24);
    t2.x = (-mieG) * mieG + 1.0;
    t18.xy = vec2(M_PI) * vec2(16.0, 4.0);
    t18.xy = vec2(3.0, 1.5) / t18.xy;
    t2.x = t2.x * t18.y;
    t18.x = t25 * t18.x;
    t24 = t24 * t2.x;
    t24 = t25 * t24;
    t24 = t24 / t2.y;
    t1.xyz = vec3(t24) * t1.xyz;
    t0.xyz = t0.xyz * t18.xxx + t1.xyz;
    t0.xyz = mix(vec3(0.0, 0.0, 0.0), t0.xyz, vec3(bvec3(tb20)));
    t0.xyz = t0.xyz * vec3(_Sun_Intensity);
    t24 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t1.x = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t24 = t24 + t1.x;
    t1.x = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t24 = (-t1.x) * 2.0 + t24;
    t24 = (-Rg) * Rg + t24;
    t24 = t11 * t24;
    t1.x = t11 + t11;
    t24 = t24 * 4.0;
    t9.x = t4.x + t4.x;
    t24 = t9.x * t9.x + (-t24);
    t9.x = sqrt(t24);
    ti24 = int((t24<0.0) ? 0xFFFFFFFFu : uint(0u));
    t9.x = (-t4.x) * 2.0 + (-t9.x);
    t1.x = t9.x / t1.x;
    ti1 = int((0.0>=t1.x) ? 0xFFFFFFFFu : uint(0u));
    ti24 = int(uint(ti24) | uint(ti1));
    t24 = (ti24 != 0) ? _RimExposure : _Exposure;
    t0.xyz = vec3(t24) * t0.xyz;
    t1 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t1.xz);
    t9.xz = exp2(t1.yw);
    t9.xz = (-t9.xz) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb0.xyw = lessThan(t0.xyxz, vec4(1.41299999, 1.41299999, 0.0, 1.41299999)).xyw;
    t2.xy = t0.zz * vec2(0.383170009, -1.44269502);
    t0.x = (tb0.x) ? t1.x : t9.x;
    t0.y = (tb0.y) ? t1.z : t9.z;
    t1.x = log2(t2.x);
    t9.x = exp2(t2.y);
    t9.x = (-t9.x) + 1.0;
    t1.x = t1.x * 0.454545468;
    t1.x = exp2(t1.x);
    t0.z = (tb0.w) ? t1.x : t9.x;
    SV_Target0.xyz = t0.xyz * vec3(vec3(_Alpha_Global, _Alpha_Global, _Alpha_Global));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 423 math, 4 textures, 18 branches
Keywords { "ECLIPSES_ON" }
"!!GLSL#version 120

#ifdef VERTEX

uniform mat4 _Object2World;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = (_Object2World * gl_Vertex).xyz;
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform vec3 _WorldSpaceCameraPos;
uniform sampler2D _Inscatter;
uniform float M_PI;
uniform vec3 betaR;
uniform float mieG;
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform float RES_R;
uniform float RES_MU;
uniform float RES_MU_S;
uniform float RES_NU;
uniform float _Sun_Intensity;
uniform float _experimentalAtmoScale;
uniform float _viewdirOffset;
uniform float _Alpha_Global;
uniform vec3 _Globals_Origin;
uniform float _RimExposure;
uniform vec3 _Sun_WorldSunDir;
uniform vec4 sunPosAndRadius;
uniform mat4 lightOccluders1;
uniform mat4 lightOccluders2;
float xlat_mutableRt;
float xlat_mutable_Exposure;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  xlat_mutableRt = Rt;
  xlat_mutable_Exposure = _Exposure;
  float eclipseShadow_1;
  vec3 worldPos_2;
  vec3 inscatter_3;
  vec3 tmpvar_4;
  tmpvar_4 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * tmpvar_6) - ((4.0 * tmpvar_5) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  float tmpvar_8;
  if ((tmpvar_7 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_6) - sqrt(tmpvar_7)) / (2.0 * tmpvar_5));
  };
  bool tmpvar_9;
  tmpvar_9 = (tmpvar_8 > 0.0);
  if (!(tmpvar_9)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 camera_10;
  camera_10 = (_WorldSpaceCameraPos - _Globals_Origin);
  vec3 viewdir_11;
  viewdir_11.yz = tmpvar_4.yz;
  float rMu_12;
  float r_13;
  vec3 result_14;
  result_14 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_11.x = (tmpvar_4.x + _viewdirOffset);
  vec3 tmpvar_15;
  tmpvar_15 = normalize(viewdir_11);
  viewdir_11 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = sqrt(dot (camera_10, camera_10));
  r_13 = tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = dot (camera_10, tmpvar_15);
  rMu_12 = tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = max ((-(tmpvar_17) - sqrt(
    (((tmpvar_17 * tmpvar_17) - (tmpvar_16 * tmpvar_16)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_18 > 0.0)) {
    camera_10 = (camera_10 + (tmpvar_18 * tmpvar_15));
    rMu_12 = (tmpvar_17 + tmpvar_18);
    r_13 = xlat_mutableRt;
  };
  float tmpvar_19;
  tmpvar_19 = dot (tmpvar_15, _Sun_WorldSunDir);
  float tmpvar_20;
  tmpvar_20 = (dot (camera_10, _Sun_WorldSunDir) / r_13);
  vec4 tmpvar_21;
  float _lerp_22;
  float tmpvar_23;
  float tmpvar_24;
  tmpvar_24 = (Rg * Rg);
  tmpvar_23 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_24));
  float tmpvar_25;
  tmpvar_25 = sqrt(((r_13 * r_13) - tmpvar_24));
  float tmpvar_26;
  tmpvar_26 = (r_13 * (rMu_12 / r_13));
  float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 * tmpvar_26) - (r_13 * r_13)) + tmpvar_24);
  vec4 tmpvar_28;
  if (((tmpvar_26 < 0.0) && (tmpvar_27 > 0.0))) {
    vec4 tmpvar_29;
    tmpvar_29.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_29.w = (0.5 - (0.5 / RES_MU));
    tmpvar_28 = tmpvar_29;
  } else {
    vec4 tmpvar_30;
    tmpvar_30.x = -1.0;
    tmpvar_30.y = (tmpvar_23 * tmpvar_23);
    tmpvar_30.z = tmpvar_23;
    tmpvar_30.w = (0.5 + (0.5 / RES_MU));
    tmpvar_28 = tmpvar_30;
  };
  float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_R) + ((tmpvar_25 / tmpvar_23) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w + ((
    ((tmpvar_26 * tmpvar_28.x) + sqrt((tmpvar_27 + tmpvar_28.y)))
   / 
    (tmpvar_25 + tmpvar_28.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_33;
  y_over_x_33 = (max (tmpvar_20, -0.1975) * 5.349625);
  float tmpvar_34;
  tmpvar_34 = (min (abs(y_over_x_33), 1.0) / max (abs(y_over_x_33), 1.0));
  float tmpvar_35;
  tmpvar_35 = (tmpvar_34 * tmpvar_34);
  tmpvar_35 = (((
    ((((
      ((((-0.01213232 * tmpvar_35) + 0.05368138) * tmpvar_35) - 0.1173503)
     * tmpvar_35) + 0.1938925) * tmpvar_35) - 0.3326756)
   * tmpvar_35) + 0.9999793) * tmpvar_34);
  tmpvar_35 = (tmpvar_35 + (float(
    (abs(y_over_x_33) > 1.0)
  ) * (
    (tmpvar_35 * -2.0)
   + 1.570796)));
  float tmpvar_36;
  tmpvar_36 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_35 * sign(y_over_x_33)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_37;
  tmpvar_37 = (((tmpvar_19 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_38;
  tmpvar_38 = floor(tmpvar_37);
  _lerp_22 = (tmpvar_37 - tmpvar_38);
  float tmpvar_39;
  tmpvar_39 = (floor((
    (tmpvar_31 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_40;
  tmpvar_40 = (floor((tmpvar_31 * RES_R)) / RES_R);
  float tmpvar_41;
  tmpvar_41 = fract((tmpvar_31 * RES_R));
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_38 + tmpvar_36) / RES_NU);
  tmpvar_42.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_38 + tmpvar_36) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = ((tmpvar_38 + tmpvar_36) / RES_NU);
  tmpvar_44.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_38 + tmpvar_36) + 1.0) / RES_NU);
  tmpvar_45.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  tmpvar_21 = (((
    (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * (1.0 - _lerp_22))
   + 
    (texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * _lerp_22)
  ) * (1.0 - tmpvar_41)) + ((
    (texture2DLod (_Inscatter, tmpvar_44.xy, 0.0) * (1.0 - _lerp_22))
   + 
    (texture2DLod (_Inscatter, tmpvar_45.xy, 0.0) * _lerp_22)
  ) * tmpvar_41));
  if ((r_13 <= xlat_mutableRt)) {
    float tmpvar_46;
    tmpvar_46 = (mieG * mieG);
    result_14 = ((tmpvar_21.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_19 * tmpvar_19))
    )) + ((
      ((tmpvar_21.xyz * tmpvar_21.w) / max (tmpvar_21.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_46)) * pow ((
        (1.0 + tmpvar_46)
       - 
        ((2.0 * mieG) * tmpvar_19)
      ), -1.5)) * (1.0 + (tmpvar_19 * tmpvar_19)))
     / 
      (2.0 + tmpvar_46)
    )));
  } else {
    result_14 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_14 * _Sun_Intensity);
  float tmpvar_47;
  float tmpvar_48;
  tmpvar_48 = dot (tmpvar_4, tmpvar_4);
  float tmpvar_49;
  tmpvar_49 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_50;
  tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (xlat_mutableRt * xlat_mutableRt)
  )));
  if ((tmpvar_50 < 0.0)) {
    tmpvar_47 = -1.0;
  } else {
    float tmpvar_51;
    tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    float tmpvar_52;
    if ((tmpvar_51 < 0.0)) {
      tmpvar_52 = ((-(tmpvar_49) + sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    } else {
      tmpvar_52 = tmpvar_51;
    };
    tmpvar_47 = tmpvar_52;
  };
  if ((tmpvar_47 != -1.0)) {
    worldPos_2 = (_WorldSpaceCameraPos + (tmpvar_4 * tmpvar_47));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_47 != -1.0)) {
    int j_53;
    int i_54;
    i_54 = 0;
    while (true) {
      if ((i_54 >= 4)) {
        break;
      };
      if ((lightOccluders1[3][i_54] <= 0.0)) {
        break;
      };
      vec4 v_55;
      v_55.x = lightOccluders1[0][i_54];
      v_55.y = lightOccluders1[1][i_54];
      v_55.z = lightOccluders1[2][i_54];
      v_55.w = lightOccluders1[3][i_54];
      vec3 sphereDirection_56;
      vec3 lightDirection_57;
      vec3 tmpvar_58;
      tmpvar_58 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_59;
      tmpvar_59 = sqrt(dot (tmpvar_58, tmpvar_58));
      lightDirection_57 = (tmpvar_58 / vec3(tmpvar_59));
      vec3 tmpvar_60;
      tmpvar_60 = (v_55.xyz - worldPos_2);
      float tmpvar_61;
      tmpvar_61 = sqrt(dot (tmpvar_60, tmpvar_60));
      sphereDirection_56 = (tmpvar_60 / tmpvar_61);
      vec3 tmpvar_62;
      tmpvar_62 = ((lightDirection_57.yzx * sphereDirection_56.zxy) - (lightDirection_57.zxy * sphereDirection_56.yzx));
      float tmpvar_63;
      tmpvar_63 = min (1.0, sqrt(dot (tmpvar_62, tmpvar_62)));
      float tmpvar_64;
      tmpvar_64 = min (1.0, (vec3(lightOccluders1[3][i_54]) / tmpvar_61).x);
      float tmpvar_65;
      tmpvar_65 = clamp (((
        (-((vec3(tmpvar_59) * (
          (sign(tmpvar_63) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_63))
          ) * (1.570796 + 
            (abs(tmpvar_63) * (-0.2146018 + (abs(tmpvar_63) * (0.08656672 + 
              (abs(tmpvar_63) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_64) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_64))
          ) * (1.570796 + 
            (abs(tmpvar_64) * (-0.2146018 + (abs(tmpvar_64) * (0.08656672 + 
              (abs(tmpvar_64) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_66;
      tmpvar_66 = clamp ((dot (lightDirection_57, sphereDirection_56) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_65 * (tmpvar_65 * (3.0 - (2.0 * tmpvar_65))))
       * 
        (tmpvar_66 * (tmpvar_66 * (3.0 - (2.0 * tmpvar_66))))
      )));
      i_54++;
    };
    j_53 = 0;
    while (true) {
      if ((j_53 >= 4)) {
        break;
      };
      if ((lightOccluders2[3][j_53] <= 0.0)) {
        break;
      };
      vec4 v_67;
      v_67.x = lightOccluders2[0][j_53];
      v_67.y = lightOccluders2[1][j_53];
      v_67.z = lightOccluders2[2][j_53];
      v_67.w = lightOccluders2[3][j_53];
      vec3 sphereDirection_68;
      vec3 lightDirection_69;
      vec3 tmpvar_70;
      tmpvar_70 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_71;
      tmpvar_71 = sqrt(dot (tmpvar_70, tmpvar_70));
      lightDirection_69 = (tmpvar_70 / vec3(tmpvar_71));
      vec3 tmpvar_72;
      tmpvar_72 = (v_67.xyz - worldPos_2);
      float tmpvar_73;
      tmpvar_73 = sqrt(dot (tmpvar_72, tmpvar_72));
      sphereDirection_68 = (tmpvar_72 / tmpvar_73);
      vec3 tmpvar_74;
      tmpvar_74 = ((lightDirection_69.yzx * sphereDirection_68.zxy) - (lightDirection_69.zxy * sphereDirection_68.yzx));
      float tmpvar_75;
      tmpvar_75 = min (1.0, sqrt(dot (tmpvar_74, tmpvar_74)));
      float tmpvar_76;
      tmpvar_76 = min (1.0, (vec3(lightOccluders2[3][j_53]) / tmpvar_73).x);
      float tmpvar_77;
      tmpvar_77 = clamp (((
        (-((vec3(tmpvar_71) * (
          (sign(tmpvar_75) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_75))
          ) * (1.570796 + 
            (abs(tmpvar_75) * (-0.2146018 + (abs(tmpvar_75) * (0.08656672 + 
              (abs(tmpvar_75) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_76) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_76))
          ) * (1.570796 + 
            (abs(tmpvar_76) * (-0.2146018 + (abs(tmpvar_76) * (0.08656672 + 
              (abs(tmpvar_76) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_78;
      tmpvar_78 = clamp ((dot (lightDirection_69, sphereDirection_68) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_77 * (tmpvar_77 * (3.0 - (2.0 * tmpvar_77))))
       * 
        (tmpvar_78 * (tmpvar_78 * (3.0 - (2.0 * tmpvar_78))))
      )));
      j_53++;
    };
  };
  vec3 L_79;
  L_79 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  float tmpvar_80;
  if ((L_79.x < 1.413)) {
    tmpvar_80 = pow ((L_79.x * 0.38317), 0.4545454);
  } else {
    tmpvar_80 = (1.0 - exp(-(L_79.x)));
  };
  L_79.x = tmpvar_80;
  float tmpvar_81;
  if ((L_79.y < 1.413)) {
    tmpvar_81 = pow ((L_79.y * 0.38317), 0.4545454);
  } else {
    tmpvar_81 = (1.0 - exp(-(L_79.y)));
  };
  L_79.y = tmpvar_81;
  float tmpvar_82;
  if ((L_79.z < 1.413)) {
    tmpvar_82 = pow ((L_79.z * 0.38317), 0.4545454);
  } else {
    tmpvar_82 = (1.0 - exp(-(L_79.z)));
  };
  L_79.z = tmpvar_82;
  vec4 tmpvar_83;
  tmpvar_83.w = 1.0;
  tmpvar_83.xyz = (_Alpha_Global * L_79);
  gl_FragData[0] = tmpvar_83;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
Matrix 4 [_Object2World] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_position o0
dcl_texcoord o1.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o1.x, c4, v0
dp4 o1.y, c5, v0
dp4 o1.z, c6, v0

"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedfjicacgdojlnjhcbpknjldogdgpohelmabaaaaaahmacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchmabaaaa
eaaaabaafpaaaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaafpaaaaadpcbabaaa
aaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
aaaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
// Stats: 423 math, 4 textures, 18 branches
Keywords { "ECLIPSES_ON" }
"!!GLES
#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
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

uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _Inscatter;
uniform highp float M_PI;
uniform highp vec3 betaR;
uniform highp float mieG;
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
uniform highp float _Sun_Intensity;
uniform highp float _experimentalAtmoScale;
uniform highp float _viewdirOffset;
uniform highp float _Alpha_Global;
uniform highp vec3 _Globals_Origin;
uniform highp float _RimExposure;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec4 sunPosAndRadius;
uniform highp mat4 lightOccluders1;
uniform highp mat4 lightOccluders2;
highp float xlat_mutableRt;
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  xlat_mutableRt = Rt;
  xlat_mutable_Exposure = _Exposure;
  highp float eclipseShadow_1;
  highp vec3 worldPos_2;
  highp vec3 inscatter_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_6;
  tmpvar_6 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * tmpvar_6) - ((4.0 * tmpvar_5) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_8;
  if ((tmpvar_7 < 0.0)) {
    tmpvar_8 = -1.0;
  } else {
    tmpvar_8 = ((-(tmpvar_6) - sqrt(tmpvar_7)) / (2.0 * tmpvar_5));
  };
  bool tmpvar_9;
  tmpvar_9 = (tmpvar_8 > 0.0);
  if (!(tmpvar_9)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 camera_10;
  camera_10 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp vec3 viewdir_11;
  viewdir_11.yz = tmpvar_4.yz;
  highp float rMu_12;
  highp float r_13;
  highp vec3 result_14;
  result_14 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_11.x = (tmpvar_4.x + _viewdirOffset);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(viewdir_11);
  viewdir_11 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (camera_10, camera_10));
  r_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (camera_10, tmpvar_15);
  rMu_12 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max ((-(tmpvar_17) - sqrt(
    (((tmpvar_17 * tmpvar_17) - (tmpvar_16 * tmpvar_16)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_18 > 0.0)) {
    camera_10 = (camera_10 + (tmpvar_18 * tmpvar_15));
    rMu_12 = (tmpvar_17 + tmpvar_18);
    r_13 = xlat_mutableRt;
  };
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_15, _Sun_WorldSunDir);
  highp float tmpvar_20;
  tmpvar_20 = (dot (camera_10, _Sun_WorldSunDir) / r_13);
  highp vec4 tmpvar_21;
  highp float _lerp_22;
  highp float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (Rg * Rg);
  tmpvar_23 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_24));
  highp float tmpvar_25;
  tmpvar_25 = sqrt(((r_13 * r_13) - tmpvar_24));
  highp float tmpvar_26;
  tmpvar_26 = (r_13 * (rMu_12 / r_13));
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 * tmpvar_26) - (r_13 * r_13)) + tmpvar_24);
  highp vec4 tmpvar_28;
  if (((tmpvar_26 < 0.0) && (tmpvar_27 > 0.0))) {
    highp vec4 tmpvar_29;
    tmpvar_29.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_29.w = (0.5 - (0.5 / RES_MU));
    tmpvar_28 = tmpvar_29;
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.x = -1.0;
    tmpvar_30.y = (tmpvar_23 * tmpvar_23);
    tmpvar_30.z = tmpvar_23;
    tmpvar_30.w = (0.5 + (0.5 / RES_MU));
    tmpvar_28 = tmpvar_30;
  };
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_R) + ((tmpvar_25 / tmpvar_23) * (1.0 - 
    (1.0/(RES_R))
  )));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w + ((
    ((tmpvar_26 * tmpvar_28.x) + sqrt((tmpvar_27 + tmpvar_28.y)))
   / 
    (tmpvar_25 + tmpvar_28.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  highp float y_over_x_33;
  y_over_x_33 = (max (tmpvar_20, -0.1975) * 5.349625);
  highp float tmpvar_34;
  tmpvar_34 = (min (abs(y_over_x_33), 1.0) / max (abs(y_over_x_33), 1.0));
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_34 * tmpvar_34);
  tmpvar_35 = (((
    ((((
      ((((-0.01213232 * tmpvar_35) + 0.05368138) * tmpvar_35) - 0.1173503)
     * tmpvar_35) + 0.1938925) * tmpvar_35) - 0.3326756)
   * tmpvar_35) + 0.9999793) * tmpvar_34);
  tmpvar_35 = (tmpvar_35 + (float(
    (abs(y_over_x_33) > 1.0)
  ) * (
    (tmpvar_35 * -2.0)
   + 1.570796)));
  highp float tmpvar_36;
  tmpvar_36 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_35 * sign(y_over_x_33)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  highp float tmpvar_37;
  tmpvar_37 = (((tmpvar_19 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_38;
  tmpvar_38 = floor(tmpvar_37);
  _lerp_22 = (tmpvar_37 - tmpvar_38);
  highp float tmpvar_39;
  tmpvar_39 = (floor((
    (tmpvar_31 * RES_R)
   - 1.0)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = (floor((tmpvar_31 * RES_R)) / RES_R);
  highp float tmpvar_41;
  tmpvar_41 = fract((tmpvar_31 * RES_R));
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_38 + tmpvar_36) / RES_NU);
  tmpvar_42.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_38 + tmpvar_36) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_44.xy, 0.0);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = ((tmpvar_38 + tmpvar_36) / RES_NU);
  tmpvar_46.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_46.xy, 0.0);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = (((tmpvar_38 + tmpvar_36) + 1.0) / RES_NU);
  tmpvar_48.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_49;
  tmpvar_49 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_48.xy, 0.0);
  tmpvar_21 = (((
    (tmpvar_43 * (1.0 - _lerp_22))
   + 
    (tmpvar_45 * _lerp_22)
  ) * (1.0 - tmpvar_41)) + ((
    (tmpvar_47 * (1.0 - _lerp_22))
   + 
    (tmpvar_49 * _lerp_22)
  ) * tmpvar_41));
  if ((r_13 <= xlat_mutableRt)) {
    highp float tmpvar_50;
    tmpvar_50 = (mieG * mieG);
    result_14 = ((tmpvar_21.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_19 * tmpvar_19))
    )) + ((
      ((tmpvar_21.xyz * tmpvar_21.w) / max (tmpvar_21.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_50)) * pow ((
        (1.0 + tmpvar_50)
       - 
        ((2.0 * mieG) * tmpvar_19)
      ), -1.5)) * (1.0 + (tmpvar_19 * tmpvar_19)))
     / 
      (2.0 + tmpvar_50)
    )));
  } else {
    result_14 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_14 * _Sun_Intensity);
  highp float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_53;
  tmpvar_53 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_54;
  tmpvar_54 = ((tmpvar_53 * tmpvar_53) - ((4.0 * tmpvar_52) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (xlat_mutableRt * xlat_mutableRt)
  )));
  if ((tmpvar_54 < 0.0)) {
    tmpvar_51 = -1.0;
  } else {
    highp float tmpvar_55;
    tmpvar_55 = ((-(tmpvar_53) - sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
    highp float tmpvar_56;
    if ((tmpvar_55 < 0.0)) {
      tmpvar_56 = ((-(tmpvar_53) + sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
    } else {
      tmpvar_56 = tmpvar_55;
    };
    tmpvar_51 = tmpvar_56;
  };
  if ((tmpvar_51 != -1.0)) {
    worldPos_2 = (_WorldSpaceCameraPos + (tmpvar_4 * tmpvar_51));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_51 != -1.0)) {
    highp int j_57;
    highp int i_58;
    i_58 = 0;
    while (true) {
      if ((i_58 >= 4)) {
        break;
      };
      if ((lightOccluders1[3][i_58] <= 0.0)) {
        break;
      };
      highp vec4 v_59;
      v_59.x = lightOccluders1[0][i_58];
      v_59.y = lightOccluders1[1][i_58];
      v_59.z = lightOccluders1[2][i_58];
      v_59.w = lightOccluders1[3][i_58];
      highp vec3 sphereDirection_60;
      highp vec3 lightDirection_61;
      highp vec3 tmpvar_62;
      tmpvar_62 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_63;
      tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
      lightDirection_61 = (tmpvar_62 / vec3(tmpvar_63));
      highp vec3 tmpvar_64;
      tmpvar_64 = (v_59.xyz - worldPos_2);
      highp float tmpvar_65;
      tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
      sphereDirection_60 = (tmpvar_64 / tmpvar_65);
      highp vec3 tmpvar_66;
      tmpvar_66 = ((lightDirection_61.yzx * sphereDirection_60.zxy) - (lightDirection_61.zxy * sphereDirection_60.yzx));
      highp float tmpvar_67;
      tmpvar_67 = min (1.0, sqrt(dot (tmpvar_66, tmpvar_66)));
      highp float tmpvar_68;
      tmpvar_68 = min (1.0, (vec3(lightOccluders1[3][i_58]) / tmpvar_65).x);
      highp float tmpvar_69;
      tmpvar_69 = clamp (((
        (-((vec3(tmpvar_63) * (
          (sign(tmpvar_67) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_67))
          ) * (1.570796 + 
            (abs(tmpvar_67) * (-0.2146018 + (abs(tmpvar_67) * (0.08656672 + 
              (abs(tmpvar_67) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_68) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_68))
          ) * (1.570796 + 
            (abs(tmpvar_68) * (-0.2146018 + (abs(tmpvar_68) * (0.08656672 + 
              (abs(tmpvar_68) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      highp float tmpvar_70;
      tmpvar_70 = clamp ((dot (lightDirection_61, sphereDirection_60) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_69 * (tmpvar_69 * (3.0 - (2.0 * tmpvar_69))))
       * 
        (tmpvar_70 * (tmpvar_70 * (3.0 - (2.0 * tmpvar_70))))
      )));
      i_58++;
    };
    j_57 = 0;
    while (true) {
      if ((j_57 >= 4)) {
        break;
      };
      if ((lightOccluders2[3][j_57] <= 0.0)) {
        break;
      };
      highp vec4 v_71;
      v_71.x = lightOccluders2[0][j_57];
      v_71.y = lightOccluders2[1][j_57];
      v_71.z = lightOccluders2[2][j_57];
      v_71.w = lightOccluders2[3][j_57];
      highp vec3 sphereDirection_72;
      highp vec3 lightDirection_73;
      highp vec3 tmpvar_74;
      tmpvar_74 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_75;
      tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
      lightDirection_73 = (tmpvar_74 / vec3(tmpvar_75));
      highp vec3 tmpvar_76;
      tmpvar_76 = (v_71.xyz - worldPos_2);
      highp float tmpvar_77;
      tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
      sphereDirection_72 = (tmpvar_76 / tmpvar_77);
      highp vec3 tmpvar_78;
      tmpvar_78 = ((lightDirection_73.yzx * sphereDirection_72.zxy) - (lightDirection_73.zxy * sphereDirection_72.yzx));
      highp float tmpvar_79;
      tmpvar_79 = min (1.0, sqrt(dot (tmpvar_78, tmpvar_78)));
      highp float tmpvar_80;
      tmpvar_80 = min (1.0, (vec3(lightOccluders2[3][j_57]) / tmpvar_77).x);
      highp float tmpvar_81;
      tmpvar_81 = clamp (((
        (-((vec3(tmpvar_75) * (
          (sign(tmpvar_79) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_79))
          ) * (1.570796 + 
            (abs(tmpvar_79) * (-0.2146018 + (abs(tmpvar_79) * (0.08656672 + 
              (abs(tmpvar_79) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_80) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_80))
          ) * (1.570796 + 
            (abs(tmpvar_80) * (-0.2146018 + (abs(tmpvar_80) * (0.08656672 + 
              (abs(tmpvar_80) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      highp float tmpvar_82;
      tmpvar_82 = clamp ((dot (lightDirection_73, sphereDirection_72) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_81 * (tmpvar_81 * (3.0 - (2.0 * tmpvar_81))))
       * 
        (tmpvar_82 * (tmpvar_82 * (3.0 - (2.0 * tmpvar_82))))
      )));
      j_57++;
    };
  };
  highp vec3 L_83;
  L_83 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  highp float tmpvar_84;
  if ((L_83.x < 1.413)) {
    tmpvar_84 = pow ((L_83.x * 0.38317), 0.4545454);
  } else {
    tmpvar_84 = (1.0 - exp(-(L_83.x)));
  };
  L_83.x = tmpvar_84;
  highp float tmpvar_85;
  if ((L_83.y < 1.413)) {
    tmpvar_85 = pow ((L_83.y * 0.38317), 0.4545454);
  } else {
    tmpvar_85 = (1.0 - exp(-(L_83.y)));
  };
  L_83.y = tmpvar_85;
  highp float tmpvar_86;
  if ((L_83.z < 1.413)) {
    tmpvar_86 = pow ((L_83.z * 0.38317), 0.4545454);
  } else {
    tmpvar_86 = (1.0 - exp(-(L_83.z)));
  };
  L_83.z = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87.w = 1.0;
  tmpvar_87.xyz = (_Alpha_Global * L_83);
  gl_FragData[0] = tmpvar_87;
}


#endif
"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
highp vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
precision highp float;
precision highp int;
// XXX ADRENOCONSTARRAYBUG
#define immediateConstBufferF (vec4[4] (\
	vec4(1, 0, 0, 0), \
	vec4(0, 1, 0, 0), \
	vec4(0, 0, 1, 0), \
	vec4(0, 0, 0, 1)))
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
uniform lowp sampler2D _Inscatter;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec4 t0;
bool tb0;
highp vec4 t1;
bvec3 tb1;
highp vec4 t2;
bool tb2;
highp float t3;
highp int ti3;
bool tb3;
highp vec3 t4;
highp int ti4;
highp vec4 t5;
lowp vec4 t10_5;
highp vec4 t6;
lowp vec4 t10_6;
highp vec4 t7;
lowp vec4 t10_7;
highp float t8;
bool tb8;
highp float t10;
highp float t11;
highp int ti11;
bool tb11;
highp vec3 t12;
bool tb12;
highp float t13;
highp float t16;
highp float t18;
highp float t19;
highp int ti19;
highp vec2 t20;
bool tb20;
highp float t24;
bool tb24;
highp float t25;
highp float t26;
highp int ti26;
bool tb26;
highp float t27;
bool tb27;
highp float t28;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t1.yzw = vec3(t24) * t0.xyz;
    t8 = dot(t1.yzw, t1.yzw);
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t16 = dot(t1.yzw, t2.xyz);
    t26 = t16 + t16;
    t3 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t11 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t3 = t11 + t3;
    t11 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t3 = (-t11) * 2.0 + t3;
    t11 = Rg * Rg;
    t19 = (-Rg) * Rg + t3;
    t26 = t26 * t26;
    t27 = t8 * 4.0;
    t19 = (-t27) * t19 + t26;
    ti4 = int((t19<0.0) ? 0xFFFFFFFFu : uint(0u));
    t19 = sqrt(t19);
    t19 = (-t16) * 2.0 + (-t19);
    t8 = t8 + t8;
    t19 = t19 / t8;
    ti19 = int((0.0>=t19) ? 0xFFFFFFFFu : uint(0u));
    ti19 = int(uint(ti19) | uint(ti4));
    t19 = (ti19 != 0) ? _RimExposure : _Exposure;
    t4.x = (-Rg) + Rt;
    t4.x = t4.x * _experimentalAtmoScale + Rg;
    t1.x = t0.x * t24 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t1.xzw;
    t0.x = dot(t2.xyz, t2.xyz);
    t6.x = sqrt(t0.x);
    t6.y = dot(t2.xyz, t5.xyz);
    t0.x = t6.y * t6.y + (-t0.x);
    t0.x = t4.x * t4.x + t0.x;
    t0.x = sqrt(t0.x);
    t0.x = (-t0.x) + (-t6.y);
    t0.x = max(t0.x, 0.0);
    tb24 = 0.0<t0.x;
    t7.xyz = t0.xxx * t5.xyz + t2.xyz;
    t4.y = t0.x + t6.y;
    t2.xyz = (bool(tb24)) ? t7.xyz : t2.xyz;
    t0.xw = (bool(tb24)) ? t4.xy : t6.xy;
    t1.x = dot(t5.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t2.x = dot(t2.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t2.x = t2.x / t0.x;
    t10 = t4.x * t4.x + (-t11);
    t5.z = sqrt(t10);
    t10 = t0.x * t0.x;
    t18 = t0.x * t0.x + (-t11);
    t18 = sqrt(t18);
    t10 = t0.w * t0.w + (-t10);
    t10 = Rg * Rg + t10;
    tb11 = t0.w<0.0;
    tb12 = 0.0<t10;
    ti11 = int(uint(tb11) * 0xffffffffu & uint(tb12) * 0xffffffffu);
    t12.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t6.w = (-t12.x) + 0.5;
    t5.y = t5.z * t5.z;
    t5.w = t12.x + 0.5;
    t6.xyz = vec3(1.0, 0.0, 0.0);
    t5.x = -1.0;
    t6 = (int(ti11) != 0) ? t6 : t5;
    t11 = t18 / t5.z;
    t5.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t5.xyz = (-t5.xyz) + vec3(1.0, 0.5, 1.0);
    t11 = t11 * t5.x + t12.y;
    t10 = t10 + t6.y;
    t10 = sqrt(t10);
    t24 = t0.w * t6.x + t10;
    t10 = t18 + t6.z;
    t24 = t24 / t10;
    t24 = t24 * t5.y + t6.w;
    t2.x = max(t2.x, -0.197500005);
    t2.x = t2.x * 5.34962368;
    t10 = min(abs(t2.x), 1.0);
    t18 = max(abs(t2.x), 1.0);
    t18 = float(1.0) / t18;
    t10 = t18 * t10;
    t18 = t10 * t10;
    t12.x = t18 * 0.0208350997 + -0.0851330012;
    t12.x = t18 * t12.x + 0.180141002;
    t12.x = t18 * t12.x + -0.330299497;
    t18 = t18 * t12.x + 0.999866009;
    t12.x = t18 * t10;
    tb20 = 1.0<abs(t2.x);
    t12.x = t12.x * -2.0 + 1.57079637;
    t12.x = tb20 ? t12.x : float(0.0);
    t10 = t10 * t18 + t12.x;
    t2.x = min(t2.x, 1.0);
    tb2 = t2.x<(-t2.x);
    t2.x = (tb2) ? (-t10) : t10;
    t2.x = t2.x * 0.909090877 + 0.74000001;
    t2.x = t2.x * 0.5;
    t2.x = t2.x * t5.z + t12.z;
    t10 = t1.x + 1.0;
    t10 = t10 * 0.5;
    t18 = RES_NU + -1.0;
    t12.x = t18 * t10;
    t12.x = floor(t12.x);
    t10 = t10 * t18 + (-t12.x);
    t18 = t11 * RES_R;
    t11 = t11 * RES_R + -1.0;
    t11 = floor(t11);
    t11 = t11 / RES_R;
    t20.x = floor(t18);
    t20.x = t20.x / RES_R;
    t18 = fract(t18);
    t2.x = t2.x + t12.x;
    t5.y = t2.x / RES_NU;
    t24 = t24 / RES_R;
    t5.z = t11 + t24;
    t10_6 = textureLod(_Inscatter, t5.yz, 0.0);
    t11 = (-t10) + 1.0;
    t2.x = t2.x + 1.0;
    t5.x = t2.x / RES_NU;
    t10_7 = textureLod(_Inscatter, t5.xz, 0.0);
    t7 = vec4(t10) * t10_7;
    t6 = t10_6 * vec4(t11) + t7;
    t5.w = t20.x + t24;
    t10_7 = textureLod(_Inscatter, t5.yw, 0.0);
    t10_5 = textureLod(_Inscatter, t5.xw, 0.0);
    t5 = vec4(t10) * t10_5;
    t5 = t10_7 * vec4(t11) + t5;
    t24 = (-t18) + 1.0;
    t5 = vec4(t18) * t5;
    t5 = t6 * vec4(t24) + t5;
    tb0 = t4.x>=t0.x;
    t2.xyz = t5.www * t5.xyz;
    t24 = max(t5.x, 9.99999975e-005);
    t2.xyz = t2.xyz / vec3(t24);
    t12.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t2.xyz = t2.xyz * t12.xyz;
    t12.xy = vec2(M_PI) * vec2(16.0, 4.0);
    t12.xy = vec2(3.0, 1.5) / t12.xy;
    t24 = t1.x * t1.x + 1.0;
    t11 = t24 * t12.x;
    t12.x = (-mieG) * mieG + 1.0;
    t12.x = t12.x * t12.y;
    t20.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t1.x = dot(t1.xx, vec2(vec2(mieG, mieG)));
    t1.x = (-t1.x) + t20.x;
    t1.x = log2(t1.x);
    t1.x = t1.x * -1.5;
    t1.x = exp2(t1.x);
    t1.x = t1.x * t12.x;
    t24 = t24 * t1.x;
    t24 = t24 / t20.y;
    t2.xyz = vec3(t24) * t2.xyz;
    t2.xyz = t5.xyz * vec3(t11) + t2.xyz;
    t2.xyz = mix(vec3(0.0, 0.0, 0.0), t2.xyz, vec3(bvec3(tb0)));
    t2.xyz = t2.xyz * vec3(_Sun_Intensity);
    t0.x = (-t4.x) * t4.x + t3;
    t0.x = (-t27) * t0.x + t26;
    tb24 = t0.x>=0.0;
    t0.x = sqrt(t0.x);
    t1.x = (-t16) * 2.0 + (-t0.x);
    t1.x = t1.x / t8;
    tb26 = t1.x<0.0;
    t0.x = (-t16) * 2.0 + t0.x;
    t0.x = t0.x / t8;
    t0.x = (tb26) ? t0.x : t1.x;
    t0.x = (tb24) ? t0.x : -1.0;
    tb8 = t0.x!=-1.0;
    if(tb8){
        t0.xyz = t1.yzw * t0.xxx + _WorldSpaceCameraPos.xyzx.xyz;
        t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
        t24 = dot(t1.xyz, t1.xyz);
        t24 = sqrt(t24);
        t1.xyz = t1.xyz / vec3(t24);
        t25 = 1.0;
        ti26 = 0x0;
        while(true){
            tb3 = ti26>=0x4;
            if(tb3){break;}
            t3 = dot(lightOccluders1[3], immediateConstBufferF[ti26]);
            tb11 = 0.0>=t3;
            if(tb11){
                break;
            //ENDIF
            }
            t4.x = dot(lightOccluders1[0], immediateConstBufferF[ti26]);
            t4.y = dot(lightOccluders1[1], immediateConstBufferF[ti26]);
            t4.z = dot(lightOccluders1[2], immediateConstBufferF[ti26]);
            t4.xyz = (-t0.xyz) + t4.xyz;
            t11 = dot(t4.xyz, t4.xyz);
            t11 = sqrt(t11);
            t4.xyz = t4.xyz / vec3(t11);
            t5.xyz = t1.zxy * t4.yzx;
            t5.xyz = t1.yzx * t4.zxy + (-t5.xyz);
            t27 = dot(t5.xyz, t5.xyz);
            t27 = sqrt(t27);
            t27 = min(t27, 1.0);
            t28 = (-t27) + 1.0;
            t28 = sqrt(t28);
            t5.x = t27 * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * t27 + -0.212114394;
            t27 = t5.x * t27 + 1.57072878;
            t27 = (-t27) * t28 + 1.57079637;
            t3 = t3 / t11;
            t3 = min(t3, 1.0);
            t11 = -abs(t3) + 1.0;
            t11 = sqrt(t11);
            t28 = abs(t3) * -0.0187292993 + 0.0742610022;
            t28 = t28 * abs(t3) + -0.212114394;
            t28 = t28 * abs(t3) + 1.57072878;
            t5.x = t11 * t28;
            t5.x = t5.x * -2.0 + 3.14159274;
            tb3 = t3<(-t3);
            t3 = tb3 ? t5.x : float(0.0);
            t3 = t28 * t11 + t3;
            t3 = (-t3) + 1.57079637;
            t3 = (-t3) + t27;
            t3 = t24 * t3;
            t3 = (-t3) / sunPosAndRadius.w;
            t3 = t3 + 1.0;
            t3 = t3 * 0.5;
            t3 = clamp(t3, 0.0, 1.0);
            t11 = t3 * -2.0 + 3.0;
            t3 = t3 * t3;
            t3 = t3 * t11;
            t11 = dot(t1.xyz, t4.xyz);
            t11 = t11 * 5.0;
            t11 = clamp(t11, 0.0, 1.0);
            t27 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t27;
            t3 = (-t3) * t11 + 1.0;
            t25 = t25 * t3;
            ti26 = ti26 + 0x1;
        }
        t26 = t25;
        ti3 = 0x0;
        while(true){
            tb11 = ti3>=0x4;
            if(tb11){break;}
            t11 = dot(lightOccluders2[3], immediateConstBufferF[ti3]);
            tb27 = 0.0>=t11;
            if(tb27){
                break;
            //ENDIF
            }
            t4.x = dot(lightOccluders2[0], immediateConstBufferF[ti3]);
            t4.y = dot(lightOccluders2[1], immediateConstBufferF[ti3]);
            t4.z = dot(lightOccluders2[2], immediateConstBufferF[ti3]);
            t4.xyz = (-t0.xyz) + t4.xyz;
            t27 = dot(t4.xyz, t4.xyz);
            t27 = sqrt(t27);
            t4.xyz = t4.xyz / vec3(t27);
            t5.xyz = t1.zxy * t4.yzx;
            t5.xyz = t1.yzx * t4.zxy + (-t5.xyz);
            t28 = dot(t5.xyz, t5.xyz);
            t28 = sqrt(t28);
            t28 = min(t28, 1.0);
            t5.x = (-t28) + 1.0;
            t5.x = sqrt(t5.x);
            t13 = t28 * -0.0187292993 + 0.0742610022;
            t13 = t13 * t28 + -0.212114394;
            t28 = t13 * t28 + 1.57072878;
            t28 = (-t28) * t5.x + 1.57079637;
            t11 = t11 / t27;
            t11 = min(t11, 1.0);
            t27 = -abs(t11) + 1.0;
            t27 = sqrt(t27);
            t5.x = abs(t11) * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * abs(t11) + -0.212114394;
            t5.x = t5.x * abs(t11) + 1.57072878;
            t13 = t27 * t5.x;
            t13 = t13 * -2.0 + 3.14159274;
            tb11 = t11<(-t11);
            t11 = tb11 ? t13 : float(0.0);
            t11 = t5.x * t27 + t11;
            t11 = (-t11) + 1.57079637;
            t11 = (-t11) + t28;
            t11 = t24 * t11;
            t11 = (-t11) / sunPosAndRadius.w;
            t11 = t11 + 1.0;
            t11 = t11 * 0.5;
            t11 = clamp(t11, 0.0, 1.0);
            t27 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t27;
            t27 = dot(t1.xyz, t4.xyz);
            t27 = t27 * 5.0;
            t27 = clamp(t27, 0.0, 1.0);
            t4.x = t27 * -2.0 + 3.0;
            t27 = t27 * t27;
            t27 = t27 * t4.x;
            t11 = (-t11) * t27 + 1.0;
            t26 = t26 * t11;
            ti3 = ti3 + 0x1;
        }
    } else {
        t26 = 1.0;
    //ENDIF
    }
    t0.xyz = vec3(t26) * t2.xyz;
    t0.xyz = vec3(t19) * t0.xyz;
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
    t8 = exp2(t0.y);
    t8 = (-t8) + 1.0;
    t2.z = (tb1.z) ? t0.x : t8;
    SV_Target0.xyz = t2.xyz * vec3(vec3(_Alpha_Global, _Alpha_Global, _Alpha_Global));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_ON" }
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
in  vec4 in_POSITION0;
out vec3 vs_TEXCOORD0;
vec4 t0;
void main()
{
    t0 = in_POSITION0.yyyy * glstate_matrix_mvp[1];
    t0 = glstate_matrix_mvp[0] * in_POSITION0.xxxx + t0;
    t0 = glstate_matrix_mvp[2] * in_POSITION0.zzzz + t0;
    gl_Position = glstate_matrix_mvp[3] * in_POSITION0.wwww + t0;
    t0.xyz = in_POSITION0.yyy * _Object2World[1].xyz;
    t0.xyz = _Object2World[0].xyz * in_POSITION0.xxx + t0.xyz;
    t0.xyz = _Object2World[2].xyz * in_POSITION0.zzz + t0.xyz;
    vs_TEXCOORD0.xyz = _Object2World[3].xyz * in_POSITION0.www + t0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 150
#extension GL_ARB_shader_bit_encoding : enable
// XXX ADRENOCONSTARRAYBUG
#define immediateConstBufferF (vec4[4] (\
	vec4(1, 0, 0, 0), \
	vec4(0, 1, 0, 0), \
	vec4(0, 0, 1, 0), \
	vec4(0, 0, 0, 1)))
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
uniform 	float _Alpha_Global;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float _RimExposure;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec4 sunPosAndRadius;
uniform 	mat4 lightOccluders1;
uniform 	mat4 lightOccluders2;
uniform  sampler2D _Inscatter;
in  vec3 vs_TEXCOORD0;
out vec4 SV_Target0;
vec4 t0;
bool tb0;
vec4 t1;
bvec3 tb1;
vec4 t2;
bool tb2;
float t3;
int ti3;
bool tb3;
vec3 t4;
int ti4;
vec4 t5;
lowp vec4 t10_5;
vec4 t6;
lowp vec4 t10_6;
vec4 t7;
lowp vec4 t10_7;
float t8;
bool tb8;
float t10;
float t11;
int ti11;
bool tb11;
vec3 t12;
bool tb12;
float t13;
float t16;
float t18;
float t19;
int ti19;
vec2 t20;
bool tb20;
float t24;
bool tb24;
float t25;
float t26;
int ti26;
bool tb26;
float t27;
bool tb27;
float t28;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t1.yzw = vec3(t24) * t0.xyz;
    t8 = dot(t1.yzw, t1.yzw);
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t16 = dot(t1.yzw, t2.xyz);
    t26 = t16 + t16;
    t3 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t11 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t3 = t11 + t3;
    t11 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t3 = (-t11) * 2.0 + t3;
    t11 = Rg * Rg;
    t19 = (-Rg) * Rg + t3;
    t26 = t26 * t26;
    t27 = t8 * 4.0;
    t19 = (-t27) * t19 + t26;
    ti4 = int((t19<0.0) ? 0xFFFFFFFFu : uint(0u));
    t19 = sqrt(t19);
    t19 = (-t16) * 2.0 + (-t19);
    t8 = t8 + t8;
    t19 = t19 / t8;
    ti19 = int((0.0>=t19) ? 0xFFFFFFFFu : uint(0u));
    ti19 = int(uint(ti19) | uint(ti4));
    t19 = (ti19 != 0) ? _RimExposure : _Exposure;
    t4.x = (-Rg) + Rt;
    t4.x = t4.x * _experimentalAtmoScale + Rg;
    t1.x = t0.x * t24 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t1.xzw;
    t0.x = dot(t2.xyz, t2.xyz);
    t6.x = sqrt(t0.x);
    t6.y = dot(t2.xyz, t5.xyz);
    t0.x = t6.y * t6.y + (-t0.x);
    t0.x = t4.x * t4.x + t0.x;
    t0.x = sqrt(t0.x);
    t0.x = (-t0.x) + (-t6.y);
    t0.x = max(t0.x, 0.0);
    tb24 = 0.0<t0.x;
    t7.xyz = t0.xxx * t5.xyz + t2.xyz;
    t4.y = t0.x + t6.y;
    t2.xyz = (bool(tb24)) ? t7.xyz : t2.xyz;
    t0.xw = (bool(tb24)) ? t4.xy : t6.xy;
    t1.x = dot(t5.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t2.x = dot(t2.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t2.x = t2.x / t0.x;
    t10 = t4.x * t4.x + (-t11);
    t5.z = sqrt(t10);
    t10 = t0.x * t0.x;
    t18 = t0.x * t0.x + (-t11);
    t18 = sqrt(t18);
    t10 = t0.w * t0.w + (-t10);
    t10 = Rg * Rg + t10;
    tb11 = t0.w<0.0;
    tb12 = 0.0<t10;
    ti11 = int(uint(tb11) * 0xffffffffu & uint(tb12) * 0xffffffffu);
    t12.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t6.w = (-t12.x) + 0.5;
    t5.y = t5.z * t5.z;
    t5.w = t12.x + 0.5;
    t6.xyz = vec3(1.0, 0.0, 0.0);
    t5.x = -1.0;
    t6 = (int(ti11) != 0) ? t6 : t5;
    t11 = t18 / t5.z;
    t5.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t5.xyz = (-t5.xyz) + vec3(1.0, 0.5, 1.0);
    t11 = t11 * t5.x + t12.y;
    t10 = t10 + t6.y;
    t10 = sqrt(t10);
    t24 = t0.w * t6.x + t10;
    t10 = t18 + t6.z;
    t24 = t24 / t10;
    t24 = t24 * t5.y + t6.w;
    t2.x = max(t2.x, -0.197500005);
    t2.x = t2.x * 5.34962368;
    t10 = min(abs(t2.x), 1.0);
    t18 = max(abs(t2.x), 1.0);
    t18 = float(1.0) / t18;
    t10 = t18 * t10;
    t18 = t10 * t10;
    t12.x = t18 * 0.0208350997 + -0.0851330012;
    t12.x = t18 * t12.x + 0.180141002;
    t12.x = t18 * t12.x + -0.330299497;
    t18 = t18 * t12.x + 0.999866009;
    t12.x = t18 * t10;
    tb20 = 1.0<abs(t2.x);
    t12.x = t12.x * -2.0 + 1.57079637;
    t12.x = tb20 ? t12.x : float(0.0);
    t10 = t10 * t18 + t12.x;
    t2.x = min(t2.x, 1.0);
    tb2 = t2.x<(-t2.x);
    t2.x = (tb2) ? (-t10) : t10;
    t2.x = t2.x * 0.909090877 + 0.74000001;
    t2.x = t2.x * 0.5;
    t2.x = t2.x * t5.z + t12.z;
    t10 = t1.x + 1.0;
    t10 = t10 * 0.5;
    t18 = RES_NU + -1.0;
    t12.x = t18 * t10;
    t12.x = floor(t12.x);
    t10 = t10 * t18 + (-t12.x);
    t18 = t11 * RES_R;
    t11 = t11 * RES_R + -1.0;
    t11 = floor(t11);
    t11 = t11 / RES_R;
    t20.x = floor(t18);
    t20.x = t20.x / RES_R;
    t18 = fract(t18);
    t2.x = t2.x + t12.x;
    t5.y = t2.x / RES_NU;
    t24 = t24 / RES_R;
    t5.z = t11 + t24;
    t10_6 = textureLod(_Inscatter, t5.yz, 0.0);
    t11 = (-t10) + 1.0;
    t2.x = t2.x + 1.0;
    t5.x = t2.x / RES_NU;
    t10_7 = textureLod(_Inscatter, t5.xz, 0.0);
    t7 = vec4(t10) * t10_7;
    t6 = t10_6 * vec4(t11) + t7;
    t5.w = t20.x + t24;
    t10_7 = textureLod(_Inscatter, t5.yw, 0.0);
    t10_5 = textureLod(_Inscatter, t5.xw, 0.0);
    t5 = vec4(t10) * t10_5;
    t5 = t10_7 * vec4(t11) + t5;
    t24 = (-t18) + 1.0;
    t5 = vec4(t18) * t5;
    t5 = t6 * vec4(t24) + t5;
    tb0 = t4.x>=t0.x;
    t2.xyz = t5.www * t5.xyz;
    t24 = max(t5.x, 9.99999975e-005);
    t2.xyz = t2.xyz / vec3(t24);
    t12.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t2.xyz = t2.xyz * t12.xyz;
    t12.xy = vec2(M_PI) * vec2(16.0, 4.0);
    t12.xy = vec2(3.0, 1.5) / t12.xy;
    t24 = t1.x * t1.x + 1.0;
    t11 = t24 * t12.x;
    t12.x = (-mieG) * mieG + 1.0;
    t12.x = t12.x * t12.y;
    t20.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t1.x = dot(t1.xx, vec2(vec2(mieG, mieG)));
    t1.x = (-t1.x) + t20.x;
    t1.x = log2(t1.x);
    t1.x = t1.x * -1.5;
    t1.x = exp2(t1.x);
    t1.x = t1.x * t12.x;
    t24 = t24 * t1.x;
    t24 = t24 / t20.y;
    t2.xyz = vec3(t24) * t2.xyz;
    t2.xyz = t5.xyz * vec3(t11) + t2.xyz;
    t2.xyz = mix(vec3(0.0, 0.0, 0.0), t2.xyz, vec3(bvec3(tb0)));
    t2.xyz = t2.xyz * vec3(_Sun_Intensity);
    t0.x = (-t4.x) * t4.x + t3;
    t0.x = (-t27) * t0.x + t26;
    tb24 = t0.x>=0.0;
    t0.x = sqrt(t0.x);
    t1.x = (-t16) * 2.0 + (-t0.x);
    t1.x = t1.x / t8;
    tb26 = t1.x<0.0;
    t0.x = (-t16) * 2.0 + t0.x;
    t0.x = t0.x / t8;
    t0.x = (tb26) ? t0.x : t1.x;
    t0.x = (tb24) ? t0.x : -1.0;
    tb8 = t0.x!=-1.0;
    if(tb8){
        t0.xyz = t1.yzw * t0.xxx + _WorldSpaceCameraPos.xyzx.xyz;
        t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
        t24 = dot(t1.xyz, t1.xyz);
        t24 = sqrt(t24);
        t1.xyz = t1.xyz / vec3(t24);
        t25 = 1.0;
        ti26 = 0x0;
        while(true){
            tb3 = ti26>=0x4;
            if(tb3){break;}
            t3 = dot(lightOccluders1[3], immediateConstBufferF[ti26]);
            tb11 = 0.0>=t3;
            if(tb11){
                break;
            //ENDIF
            }
            t4.x = dot(lightOccluders1[0], immediateConstBufferF[ti26]);
            t4.y = dot(lightOccluders1[1], immediateConstBufferF[ti26]);
            t4.z = dot(lightOccluders1[2], immediateConstBufferF[ti26]);
            t4.xyz = (-t0.xyz) + t4.xyz;
            t11 = dot(t4.xyz, t4.xyz);
            t11 = sqrt(t11);
            t4.xyz = t4.xyz / vec3(t11);
            t5.xyz = t1.zxy * t4.yzx;
            t5.xyz = t1.yzx * t4.zxy + (-t5.xyz);
            t27 = dot(t5.xyz, t5.xyz);
            t27 = sqrt(t27);
            t27 = min(t27, 1.0);
            t28 = (-t27) + 1.0;
            t28 = sqrt(t28);
            t5.x = t27 * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * t27 + -0.212114394;
            t27 = t5.x * t27 + 1.57072878;
            t27 = (-t27) * t28 + 1.57079637;
            t3 = t3 / t11;
            t3 = min(t3, 1.0);
            t11 = -abs(t3) + 1.0;
            t11 = sqrt(t11);
            t28 = abs(t3) * -0.0187292993 + 0.0742610022;
            t28 = t28 * abs(t3) + -0.212114394;
            t28 = t28 * abs(t3) + 1.57072878;
            t5.x = t11 * t28;
            t5.x = t5.x * -2.0 + 3.14159274;
            tb3 = t3<(-t3);
            t3 = tb3 ? t5.x : float(0.0);
            t3 = t28 * t11 + t3;
            t3 = (-t3) + 1.57079637;
            t3 = (-t3) + t27;
            t3 = t24 * t3;
            t3 = (-t3) / sunPosAndRadius.w;
            t3 = t3 + 1.0;
            t3 = t3 * 0.5;
            t3 = clamp(t3, 0.0, 1.0);
            t11 = t3 * -2.0 + 3.0;
            t3 = t3 * t3;
            t3 = t3 * t11;
            t11 = dot(t1.xyz, t4.xyz);
            t11 = t11 * 5.0;
            t11 = clamp(t11, 0.0, 1.0);
            t27 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t27;
            t3 = (-t3) * t11 + 1.0;
            t25 = t25 * t3;
            ti26 = ti26 + 0x1;
        }
        t26 = t25;
        ti3 = 0x0;
        while(true){
            tb11 = ti3>=0x4;
            if(tb11){break;}
            t11 = dot(lightOccluders2[3], immediateConstBufferF[ti3]);
            tb27 = 0.0>=t11;
            if(tb27){
                break;
            //ENDIF
            }
            t4.x = dot(lightOccluders2[0], immediateConstBufferF[ti3]);
            t4.y = dot(lightOccluders2[1], immediateConstBufferF[ti3]);
            t4.z = dot(lightOccluders2[2], immediateConstBufferF[ti3]);
            t4.xyz = (-t0.xyz) + t4.xyz;
            t27 = dot(t4.xyz, t4.xyz);
            t27 = sqrt(t27);
            t4.xyz = t4.xyz / vec3(t27);
            t5.xyz = t1.zxy * t4.yzx;
            t5.xyz = t1.yzx * t4.zxy + (-t5.xyz);
            t28 = dot(t5.xyz, t5.xyz);
            t28 = sqrt(t28);
            t28 = min(t28, 1.0);
            t5.x = (-t28) + 1.0;
            t5.x = sqrt(t5.x);
            t13 = t28 * -0.0187292993 + 0.0742610022;
            t13 = t13 * t28 + -0.212114394;
            t28 = t13 * t28 + 1.57072878;
            t28 = (-t28) * t5.x + 1.57079637;
            t11 = t11 / t27;
            t11 = min(t11, 1.0);
            t27 = -abs(t11) + 1.0;
            t27 = sqrt(t27);
            t5.x = abs(t11) * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * abs(t11) + -0.212114394;
            t5.x = t5.x * abs(t11) + 1.57072878;
            t13 = t27 * t5.x;
            t13 = t13 * -2.0 + 3.14159274;
            tb11 = t11<(-t11);
            t11 = tb11 ? t13 : float(0.0);
            t11 = t5.x * t27 + t11;
            t11 = (-t11) + 1.57079637;
            t11 = (-t11) + t28;
            t11 = t24 * t11;
            t11 = (-t11) / sunPosAndRadius.w;
            t11 = t11 + 1.0;
            t11 = t11 * 0.5;
            t11 = clamp(t11, 0.0, 1.0);
            t27 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t27;
            t27 = dot(t1.xyz, t4.xyz);
            t27 = t27 * 5.0;
            t27 = clamp(t27, 0.0, 1.0);
            t4.x = t27 * -2.0 + 3.0;
            t27 = t27 * t27;
            t27 = t27 * t4.x;
            t11 = (-t11) * t27 + 1.0;
            t26 = t26 * t11;
            ti3 = ti3 + 0x1;
        }
    } else {
        t26 = 1.0;
    //ENDIF
    }
    t0.xyz = vec3(t26) * t2.xyz;
    t0.xyz = vec3(t19) * t0.xyz;
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
    t8 = exp2(t0.y);
    t8 = (-t8) + 1.0;
    t2.z = (tb1.z) ? t0.x : t8;
    SV_Target0.xyz = t2.xyz * vec3(vec3(_Alpha_Global, _Alpha_Global, _Alpha_Global));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 202 math, 8 textures
Keywords { "ECLIPSES_OFF" }
Float 1 [M_PI]
Float 8 [RES_MU]
Float 9 [RES_MU_S]
Float 10 [RES_NU]
Float 7 [RES_R]
Float 5 [Rg]
Float 6 [Rt]
Float 14 [_Alpha_Global]
Float 4 [_Exposure]
Vector 15 [_Globals_Origin]
Float 16 [_RimExposure]
Float 11 [_Sun_Intensity]
Vector 17 [_Sun_WorldSunDir]
Vector 0 [_WorldSpaceCameraPos]
Float 12 [_experimentalAtmoScale]
Float 13 [_viewdirOffset]
Vector 2 [betaR]
Float 3 [mieG]
SetTexture 0 [_Inscatter] 2D 0
"ps_3_0
def c18, 0, 0.5, -0, -1
def c19, 0.197500005, 5.34962368, -1.05655074, 0.180141002
def c20, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c21, -2, 1.57079637, 0.909090877, 0.74000001
def c22, 0.383170009, -1.44269502, 0.454545468, 0
def c23, -9.99999975e-005, 10000, 16, 4
def c24, 3, 1.5, -1.5, -1.41299999
def c25, 2, 4, 1, -9.99999997e-007
dcl_texcoord v0.xyz
dcl_2d s0
mov r0.x, -c25.z
mov r1.xyz, -c18.wzzw
mov r2.xyz, c0
add r3.xyz, r2, -c15
dp3 r2.w, r3, r3
rsq r2.w, r2.w
rcp r4.x, r2.w
mul r2.w, r4.x, r4.x
add r5.xyz, -c0, v0
dp3 r3.w, r5, r5
rsq r3.w, r3.w
mad r6.x, r5.x, r3.w, c13.x
mul r6.yzw, r3.w, r5.xxyz
nrm r5.xyz, r6.xzww
dp3 r4.y, r3, r5
mad r2.w, r4.y, r4.y, -r2.w
mov r6.x, c5.x
add r3.w, -r6.x, c6.x
mad r7.x, r3.w, c12.x, r6.x
mad r2.w, r7.x, r7.x, r2.w
rsq r3.w, r2.w
rcp r3.w, r3.w
cmp r2.w, r2.w, -r3.w, c25.w
add r2.w, r2.w, -r4.y
max r3.w, r2.w, c18.x
add r7.y, r3.w, r4.y
cmp r4.xy, -r3.w, r4, r7
mul r2.w, r4.x, r4.x
rcp r4.z, r4.x
mul r4.y, r4.z, r4.y
mul r4.y, r4.y, r4.x
mad r2.w, r4.y, r4.y, -r2.w
mad r2.w, c5.x, c5.x, r2.w
cmp r4.w, -r2.w, c18.z, c18.w
cmp r4.w, r4.y, c18.x, r4.w
mul r5.w, c5.x, c5.x
mad r6.x, r7.x, r7.x, -r5.w
add r7.x, -r4.x, r7.x
mad r4.x, r4.x, r4.x, -r5.w
rsq r4.x, r4.x
rcp r4.x, r4.x
rsq r5.w, r6.x
rcp r0.z, r5.w
mul r5.w, r4.x, r5.w
mul r0.y, r0.z, r0.z
rcp r6.x, c8.x
mad r1.w, r6.x, -c18.y, c18.y
mad r0.w, r6.x, c18.y, c18.y
add r6.x, -r6.x, c18.y
cmp r0, r4.w, r0, r1
add r0.y, r0.y, r2.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.x, r4.y, r0.x, r0.y
add r0.y, r0.z, r4.x
rcp r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.x, r0.x, r6.x, r0.w
rcp r0.y, c7.x
mul r0.x, r0.y, r0.x
lrp r1.x, r0.y, c18.y, r5.w
mul r0.z, r1.x, c7.x
mov r8.xz, c25
mad r0.w, r1.x, c7.x, -r8.z
frc r1.x, r0.z
add r0.zw, r0, -r1.x
mad r9.y, r0.z, r0.y, r0.x
mad r1.yzw, r3.w, r5.xxyz, r3.xxyz
cmp r1.yzw, -r3.w, r3.xxyz, r1
dp3 r0.z, r6.yzww, r3
dp3 r2.w, r6.yzww, r6.yzww
dp3 r1.y, r1.yzww, c17
dp3 r1.z, r5, c17
mul r1.w, r4.z, r1.y
mad r1.y, r1.y, r4.z, c19.x
mul r1.w, r1.w, c19.y
cmp r1.y, r1.y, r1.w, c19.z
add r1.w, r1_abs.y, -c25.z
rcp r3.x, r1_abs.y
cmp r1.w, r1.w, r3.x, c25.z
mov_sat r3.x, r1_abs.y
mul r1.w, r1.w, r3.x
mul r3.x, r1.w, r1.w
mad r3.y, r3.x, c20.x, c20.y
mad r3.y, r3.x, r3.y, c19.w
mad r3.y, r3.x, r3.y, c20.z
mad r3.x, r3.x, r3.y, c20.w
mul r1.w, r1.w, r3.x
mad r3.x, r1.w, c21.x, c21.y
add r3.y, -r1_abs.y, c25.z
min r3.z, r1.y, c25.z
cmp r1.y, r3.z, -c18.z, -c18.w
cmp r3.y, r3.y, -c18.z, -c18.w
mad r1.w, r3.x, r3.y, r1.w
add r3.x, r1.w, r1.w
mad r1.y, r1.y, -r3.x, r1.w
mad r1.y, r1.y, c21.z, c21.w
mul r1.y, r1.y, c18.y
rcp r1.w, c9.x
lrp r3.x, r1.w, c18.y, r1.y
add r1.y, r1.z, c25.z
mul r1.y, r1.y, c18.y
add r1.w, -r8.z, c10.x
mul r3.y, r1.w, r1.y
frc r3.z, r3.y
add r3.y, -r3.z, r3.y
add r3.x, r3.x, r3.y
mad r1.y, r1.y, r1.w, -r3.y
add r1.w, r3.x, c25.z
rcp r3.y, c10.x
mul r4.x, r1.w, r3.y
mul r4.y, r3.y, r3.x
mov r4.w, c18.x
mov r9.xzw, r4.xyww
texldl r3, r9, s0
mov r9.xzw, r4.yyww
texldl r5, r9, s0
lrp r6, r1.y, r3, r5
mad r4.z, r0.w, r0.y, r0.x
texldl r3, r4.yzww, s0
texldl r4, r4.xzww, s0
lrp r5, r1.y, r4, r3
lrp r3, r1.x, r6, r5
add r0.x, r3.x, c23.x
rcp r0.y, r3.x
cmp r0.x, r0.x, r0.y, c23.y
mul r1.xyw, r3.w, r3.xyzz
mul r0.xyw, r0.x, r1
rcp r4.x, c2.x
rcp r4.y, c2.y
rcp r4.z, c2.z
mul r1.xyw, r4.xyzz, c2.x
mul r0.xyw, r0, r1
mad r1.xy, c3.x, c3.x, r8.zxzw
dp2add r1.x, r1.z, -c3.x, r1.x
mad r1.z, r1.z, r1.z, c25.z
rcp r1.y, r1.y
pow r3.w, r1.x, c24.z
mov r4.zw, c23
mul r1.xw, r4.zyzw, c1.x
rcp r1.w, r1.w
rcp r1.x, r1.x
mul r1.xw, r1, c24.xyzy
mul r1.x, r1.z, r1.x
mad r4.x, c3.x, -c3.x, r8.z
mul r1.w, r1.w, r4.x
mul r1.w, r3.w, r1.w
mul r1.z, r1.z, r1.w
mul r1.y, r1.y, r1.z
mul r0.xyw, r0, r1.y
mad r0.xyw, r3.xyzz, r1.x, r0
mul r0.xyw, r0, c11.x
cmp r0.xyw, r7.x, r0, c18.x
dp3 r1.x, c15, c15
dp3 r1.y, c0, c0
add r1.x, r1.y, r1.x
dp3 r1.y, c15, r2
mad r1.x, r1.y, -c25.x, r1.x
mad r1.x, c5.x, -c5.x, r1.x
mul r1.x, r2.w, r1.x
add r1.y, r2.w, r2.w
rcp r1.y, r1.y
mul r1.x, r1.x, c25.y
add r1.z, r0.z, r0.z
mad r1.x, r1.z, r1.z, -r1.x
rsq r1.z, r1.x
rcp r1.z, r1.z
mad r0.z, r0.z, -c25.x, -r1.z
mul r0.z, r1.y, r0.z
cmp r0.z, r1.x, -r0.z, c25.z
mov r1.x, c16.x
cmp r0.z, r0.z, r1.x, c4.x
mul r1.xyz, r0.z, r0.xyww
mad r0.xyz, r0.xyww, r0.z, c24.w
mul r1.zw, r1.z, c22.xyxy
mul r2, r1.xxyy, c22.xyxy
exp r0.w, r1.w
pow r3.x, r1.z, c22.z
add r0.w, -r0.w, c25.z
cmp r1.z, r0.z, r0.w, r3.x
exp r0.z, r2.y
add r0.z, -r0.z, c25.z
pow r0.w, r2.x, c22.z
cmp r1.x, r0.x, r0.z, r0.w
exp r0.x, r2.w
pow r0.z, r2.z, c22.z
add r0.x, -r0.x, c25.z
cmp r1.y, r0.y, r0.x, r0.z
mul oC0.xyz, r1, c14.x
mov oC0.w, c25.z

"
}
SubProgram "d3d11 " {
// Stats: 157 math
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 432
Float 112 [M_PI]
Vector 144 [betaR] 3
Float 188 [mieG]
Float 192 [_Exposure]
Float 196 [Rg]
Float 200 [Rt]
Float 208 [RES_R]
Float 212 [RES_MU]
Float 216 [RES_MU_S]
Float 220 [RES_NU]
Float 240 [_Sun_Intensity]
Float 244 [_experimentalAtmoScale]
Float 248 [_viewdirOffset]
Float 252 [_Alpha_Global]
Vector 400 [_Globals_Origin] 3
Float 412 [_RimExposure]
Vector 416 [_Sun_WorldSunDir] 3
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
root12:abacabaa
eefieceddgmicmjpojmkggnneepalhekimompneiabaaaaaafmbgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmbfaaaa
eaaaaaaaghafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aiaaaaaadgaaaaaihcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaialpaaaaaaajhcaabaaa
acaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
acaaaaaadkaabaaaacaaaaaadcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaackiacaaaaaaaaaaaapaaaaaadiaaaaahocaabaaaadaaaaaa
pgapbaaaacaaaaaaagajbaaaacaaaaaabaaaaaahbcaabaaaacaaaaaaigadbaaa
adaaaaaaigadbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaaigadbaaaadaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaabjaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahccaabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
bcaabaaaadaaaaaabkaabaaaafaaaaaabkaabaaaafaaaaaadkaabaiaebaaaaaa
acaaaaaaelaaaaafbcaabaaaafaaaaaadkaabaaaacaaaaaaaaaaaaakicaabaaa
acaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaa
dcaaaaalbcaabaaaagaaaaaadkaabaaaacaaaaaabkiacaaaaaaaaaaaapaaaaaa
bkiacaaaaaaaaaaaamaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaaagaaaaaa
akaabaaaagaaaaaaakaabaaaadaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaaaaaaaaajicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaabkaabaia
ebaaaaaaafaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaaaaaaaaaahccaabaaaagaaaaaadkaabaaaacaaaaaabkaabaaaafaaaaaa
dbaaaaahbcaabaaaadaaaaaaabeaaaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
hcaabaaaahaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
baaaaaaibcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabkaaaaaa
dhaaaaajocaabaaaacaaaaaaagaabaaaadaaaaaaagajbaaaahaaaaaaagajbaaa
aeaaaaaabaaaaaahbcaabaaaaeaaaaaajgahbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahccaabaaaadaaaaaajgahbaaaadaaaaaajgahbaaaadaaaaaadhaaaaaj
fcaabaaaadaaaaaaagaabaaaadaaaaaaagabbaaaagaaaaaaagabbaaaafaaaaaa
baaaaaaiccaabaaaacaaaaaajgahbaaaacaaaaaaegiccaaaaaaaaaaabkaaaaaa
aoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadeaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaahbdneklodiaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaaabeaaaaabodakleadiaaaaahecaabaaaacaaaaaa
akaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakecaabaaaacaaaaaackaabaaa
adaaaaaackaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalecaabaaa
acaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaackaabaaa
acaaaaaadbaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaa
dbaaaaahicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaadiaaaaajicaabaaa
adaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaak
ccaabaaaaeaaaaaaakaabaaaagaaaaaaakaabaaaagaaaaaadkaabaiaebaaaaaa
adaaaaaabnaaaaahecaabaaaaeaaaaaaakaabaaaagaaaaaaakaabaaaadaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaadaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaaelaaaaaf
ecaabaaaabaaaaaabkaabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaaaoaaaaalhcaabaaaafaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaaanaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaafaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaa
abaaaaaaakaabaaaafaaaaaaabeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaa
abaaaaaaakaabaaaadaaaaaackaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaalocaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
agijcaaaaaaaaaaaanaaaaaaaaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaadpaaaaiadpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaaebaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaanaaaaaaaaaaaaah
ecaabaaaagaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaaiecaabaaa
aaaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaa
ddaaaaaiicaabaaaaaaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaochgdido
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaa
aebnkjlodcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaadiphhpdpdiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaama
abeaaaaanlapmjdpdbaaaaaiccaabaaaabaaaaaaabeaaaaaaaaaiadpbkaabaia
ibaaaaaaacaaaaaaddaaaaahecaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaiadpdbaaaaaiecaabaaaabaaaaaackaabaaaabaaaaaackaabaiaebaaaaaa
abaaaaaaabaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadhaaaaakecaabaaaaaaaaaaackaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaacolkgidpabeaaaaakehadndpdiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaabaaaaaackaabaaaafaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpaaaaaaaibcaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
abeaaaaaaaaaialpdiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaebaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaiccaabaaa
agaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaanaaaaaaaoaaaaaibcaabaaa
agaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaaeiaaaaalpcaabaaa
abaaaaaaigaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaafaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaaabaaaaaaegaobaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaa
aaaaaaaabkaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaaiccaabaaa
acaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaanaaaaaaaaaaaaahicaabaaa
agaaaaaaakaabaaaaaaaaaaabkaabaaaacaaaaaaeiaaaaalpcaabaaaafaaaaaa
mgaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
eiaaaaalpcaabaaaagaaaaaangafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaafaaaaaapgapbaaaaaaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaakgakbaaa
aaaaaaaaegaobaaaafaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaaaaaaaaa
egaobaaaafaaaaaaaaaaaaaibcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajpcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaa
aaaaaaaaegaobaaaafaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
bhlhnbdiaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaa
aoaaaaajocaabaaaacaaaaaaagiacaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaa
ajaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaajgahbaaaacaaaaaa
apaaaaaiicaabaaaaaaaaaaaagaabaaaacaaaaaapgipcaaaaaaaaaaaalaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaaodcaabaaaacaaaaaapgipcaaaaaaaaaaaalaaaaaapgipcaaa
aaaaaaaaalaaaaaaaceaaaaaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaamalpbjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaambcaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadkiacaaa
aaaaaaaaalaaaaaaabeaaaaaaaaaiadpdiaaaaalmcaabaaaacaaaaaaagiacaaa
aaaaaaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiaebaaaaiaeaaoaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaamadpkgaobaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
kgakbaaaacaaaaaaegacbaaaabaaaaaaabaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaakgakbaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaapaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaaaaaaaaa
bjaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaajbcaabaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaajbcaabaaaabaaaaaaegiccaaa
aaaaaaaabjaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeadkaabaaaaaaaaaaadcaaaaam
icaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaa
amaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaadaaaaaa
dkaabaaaaaaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaaadaaaaaabkaabaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaea
aaaaaaahccaabaaaabaaaaaaakaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaak
icaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaaelaaaaafccaabaaaabaaaaaadkaabaaaaaaaaaaadbaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaalccaabaaaabaaaaaa
akaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaabaaaaaa
aoaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaah
bcaabaaaabaaaaaaabeaaaaaaaaaaaaaakaabaaaabaaaaaadmaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaalicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaabjaaaaaaakiacaaaaaaaaaaaamaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaak
pcaabaaaabaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedodlkklilpnmcomedo
dlkklilpcpaaaaaffcaabaaaabaaaaaaagacbaaaabaaaaaabjaaaaafkcaabaaa
abaaaaaafganbaaaabaaaaaaaaaaaaalkcaabaaaabaaaaaafganbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaakfcaabaaa
abaaaaaaagacbaaaabaaaaaaaceaaaaacplkoidoaaaaaaaacplkoidoaaaaaaaa
bjaaaaaffcaabaaaabaaaaaaagacbaaaabaaaaaadbaaaaaklcaabaaaaaaaaaaa
egaibaaaaaaaaaaaaceaaaaacpnnledpcpnnledpaaaaaaaacpnnledpdiaaaaak
dcaabaaaacaaaaaakgakbaaaaaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaa
aaaaaaaadhaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaaigaabaaaabaaaaaa
ngafbaaaabaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaaf
ccaabaaaabaaaaaabkaabaaaacaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaa
apaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 338 math, 8 textures, 14 branches
Keywords { "ECLIPSES_ON" }
Matrix 0 [lightOccluders1]
Matrix 4 [lightOccluders2]
Float 9 [M_PI]
Float 16 [RES_MU]
Float 17 [RES_MU_S]
Float 18 [RES_NU]
Float 15 [RES_R]
Float 13 [Rg]
Float 14 [Rt]
Float 22 [_Alpha_Global]
Float 12 [_Exposure]
Vector 23 [_Globals_Origin]
Float 24 [_RimExposure]
Float 19 [_Sun_Intensity]
Vector 25 [_Sun_WorldSunDir]
Vector 8 [_WorldSpaceCameraPos]
Float 20 [_experimentalAtmoScale]
Float 21 [_viewdirOffset]
Vector 10 [betaR]
Float 11 [mieG]
Vector 26 [sunPosAndRadius]
SetTexture 0 [_Inscatter] 2D 0
"ps_3_0
def c27, 2, 4, 1, -9.99999997e-007
def c28, 0.197500005, 5.34962368, -1.05655074, 0.180141002
def c29, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c30, -2, 1.57079637, 0.909090877, 0.74000001
def c31, -0, -1, -2, -3
def c32, -0.0187292993, 0.0742610022, 1.57072878, 5
def c33, 3, 1.5, -1.5, -0.212114394
def c34, -2, 3.14159274, 3, -1.41299999
def c35, 0.383170009, -1.44269502, 0.454545468, 0
def c36, 0, 0.5, -0, -1
def c37, -9.99999975e-005, 10000, 16, 4
defi i0, 4, 0, 0, 0
dcl_texcoord v0.xyz
dcl_2d s0
add r0.xyz, -c8, v0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.yzw, r0.w, r0.xxyz
dp3 r0.y, r1.yzww, r1.yzww
mov r2.xyz, c8
add r3.xyz, r2, -c23
dp3 r0.z, r1.yzww, r3
add r2.w, r0.z, r0.z
dp3 r3.w, c23, c23
dp3 r4.x, c8, c8
add r3.w, r3.w, r4.x
dp3 r2.x, c23, r2
mad r2.x, r2.x, -c27.x, r3.w
mul r2.y, c13.x, c13.x
mad r2.z, c13.x, -c13.x, r2.x
mul r2.w, r2.w, r2.w
mul r3.w, r0.y, c27.y
mad r2.z, r3.w, -r2.z, r2.w
rsq r4.x, r2.z
rcp r4.x, r4.x
mad r4.x, r0.z, -c27.x, -r4.x
add r0.y, r0.y, r0.y
rcp r0.y, r0.y
mul r4.x, r0.y, r4.x
cmp r2.z, r2.z, -r4.x, c27.z
mov r4.x, c24.x
cmp r2.z, r2.z, r4.x, c12.x
mov r4.x, c13.x
add r4.y, -r4.x, c14.x
mad r4.x, r4.y, c20.x, r4.x
mad r1.x, r0.x, r0.w, c21.x
nrm r5.xyz, r1.xzww
dp3 r0.x, r3, r3
rsq r0.x, r0.x
rcp r6.x, r0.x
dp3 r6.y, r3, r5
mul r0.x, r6.x, r6.x
mad r0.x, r6.y, r6.y, -r0.x
mad r0.x, r4.x, r4.x, r0.x
rsq r0.w, r0.x
rcp r0.w, r0.w
cmp r0.x, r0.x, -r0.w, c27.w
add r0.x, r0.x, -r6.y
max r1.x, r0.x, c36.x
mad r7.xyz, r1.x, r5, r3
add r4.y, r1.x, r6.y
cmp r3.xyz, -r1.x, r3, r7
cmp r0.xw, -r1.x, r6.xyzy, r4.xyzy
dp3 r1.x, r5, c25
dp3 r3.x, r3, c25
rcp r3.y, r0.x
mul r3.z, r3.y, r3.x
mul r0.w, r0.w, r3.y
mad r4.y, r4.x, r4.x, -r2.y
rsq r4.y, r4.y
rcp r5.z, r4.y
mul r4.z, r0.x, r0.x
mad r2.y, r0.x, r0.x, -r2.y
rsq r2.y, r2.y
rcp r2.y, r2.y
mul r0.w, r0.w, r0.x
mad r4.z, r0.w, r0.w, -r4.z
mad r4.z, c13.x, c13.x, r4.z
rcp r4.w, c16.x
mad r6.w, r4.w, -c36.y, c36.y
mul r5.y, r5.z, r5.z
mad r5.w, r4.w, c36.y, c36.y
cmp r7.x, -r4.z, c36.z, c36.w
cmp r7.x, r0.w, c36.x, r7.x
mov r5.x, -c27.z
mov r6.xyz, -c36.wzzw
cmp r5, r7.x, r5, r6
rcp r6.x, c15.x
mul r4.y, r4.y, r2.y
lrp r7.x, r6.x, c36.y, r4.y
add r4.y, r4.z, r5.y
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r0.w, r0.w, r5.x, r4.y
add r2.y, r2.y, r5.z
rcp r2.y, r2.y
mul r0.w, r0.w, r2.y
add r2.y, -r4.w, c36.y
mad r0.w, r0.w, r2.y, r5.w
rcp r2.y, c17.x
mad r3.x, r3.x, r3.y, c28.x
mul r3.y, r3.z, c28.y
cmp r3.x, r3.x, r3.y, c28.z
mov_sat r3.y, r3_abs.x
add r3.z, r3_abs.x, -c27.z
rcp r4.y, r3_abs.x
cmp r3.z, r3.z, r4.y, c27.z
mul r3.y, r3.z, r3.y
mul r3.z, r3.y, r3.y
mad r4.y, r3.z, c29.x, c29.y
mad r4.y, r3.z, r4.y, c28.w
mad r4.y, r3.z, r4.y, c29.z
mad r3.z, r3.z, r4.y, c29.w
mul r3.y, r3.z, r3.y
add r3.z, -r3_abs.x, c27.z
cmp r3.z, r3.z, -c36.z, -c36.w
mad r4.y, r3.y, c30.x, c30.y
mad r3.y, r4.y, r3.z, r3.y
min r4.y, r3.x, c27.z
cmp r3.x, r4.y, -c36.z, -c36.w
add r3.z, r3.y, r3.y
mad r3.x, r3.x, -r3.z, r3.y
mad r3.x, r3.x, c30.z, c30.w
mul r3.x, r3.x, c36.y
lrp r4.y, r2.y, c36.y, r3.x
add r2.y, r1.x, c27.z
mul r2.y, r2.y, c36.y
mov r3.xz, c27
add r3.y, -r3.z, c18.x
mul r4.z, r2.y, r3.y
frc r4.w, r4.z
add r4.z, -r4.w, r4.z
mad r2.y, r2.y, r3.y, -r4.z
mul r3.y, r7.x, c15.x
mad r4.w, r7.x, c15.x, -r3.z
frc r5.x, r3.y
add r4.w, r4.w, -r5.x
add r3.y, r3.y, -r5.x
add r4.y, r4.y, r4.z
rcp r4.z, c18.x
mul r7.y, r4.z, r4.y
mul r0.w, r6.x, r0.w
mad r7.z, r4.w, r6.x, r0.w
mov r7.w, c36.x
texldl r8, r7.yzww, s0
add r4.y, r4.y, c27.z
mul r7.x, r4.z, r4.y
texldl r9, r7.xzww, s0
lrp r10, r2.y, r9, r8
mad r6.y, r3.y, r6.x, r0.w
mov r6.xzw, r7.yyww
texldl r8, r6, s0
mov r6.xzw, r7.xyww
texldl r6, r6, s0
lrp r7, r2.y, r6, r8
lrp r6, r5.x, r7, r10
add r0.x, -r0.x, r4.x
mul r4.yzw, r6.w, r6.xxyz
add r0.w, r6.x, c37.x
rcp r2.y, r6.x
cmp r0.w, r0.w, r2.y, c37.y
mul r4.yzw, r0.w, r4
rcp r5.x, c10.x
rcp r5.y, c10.y
rcp r5.z, c10.z
mul r5.xyz, r5, c10.x
mul r4.yzw, r4, r5.xxyz
mov r5.zw, c37
mul r5.xy, r5.zwzw, c9.x
rcp r0.w, r5.x
mul r0.w, r0.w, c33.x
mad r2.y, r1.x, r1.x, c27.z
mul r0.w, r0.w, r2.y
rcp r3.y, r5.y
mul r3.y, r3.y, c33.y
mad r5.x, c11.x, -c11.x, r3.z
mul r3.y, r3.y, r5.x
mad r3.xz, c11.x, c11.x, r3.zyxw
dp2add r1.x, r1.x, -c11.x, r3.x
pow r3.x, r1.x, c33.z
mul r1.x, r3.x, r3.y
mul r1.x, r2.y, r1.x
rcp r2.y, r3.z
mul r1.x, r1.x, r2.y
mul r3.xyz, r1.x, r4.yzww
mad r3.xyz, r6, r0.w, r3
mul r3.xyz, r3, c19.x
mad r0.w, r4.x, -r4.x, r2.x
mad r0.w, r3.w, -r0.w, r2.w
rsq r1.x, r0.w
rcp r1.x, r1.x
mad r2.x, r0.z, -c27.x, -r1.x
mul r2.x, r0.y, r2.x
mad r0.z, r0.z, -c27.x, r1.x
mul r0.y, r0.y, r0.z
cmp r0.y, r2.x, r2.x, r0.y
cmp r0.y, r0.w, r0.y, -c27.z
add r0.z, r0.y, c27.z
if_ne r0.z, -r0.z
mad r0.yzw, r1, r0.y, c8.xxyz
add r1.xyz, -r0.yzww, c26
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp r2.x, r1.w
mul r1.xyz, r1.w, r1
rcp r1.w, c26.w
mov r2.y, c27.z
mov r2.w, c36.x
rep i0
add r4, r2.w, c31
mov r5.x, c36.x
cmp r3.w, -r4_abs.x, c0.w, r5.x
cmp r3.w, -r4_abs.y, c1.w, r3.w
cmp r3.w, -r4_abs.z, c2.w, r3.w
cmp r3.w, -r4_abs.w, c3.w, r3.w
if_ge -r3.w, c36.x
break_ne c27.z, -c27.z
endif
cmp r5.xyz, -r4_abs.x, c0, r5.x
cmp r5.xyz, -r4_abs.y, c1, r5
cmp r4.xyz, -r4_abs.z, c2, r5
cmp r4.xyz, -r4_abs.w, c3, r4
add r4.xyz, -r0.yzww, r4
dp3 r4.w, r4, r4
rsq r4.w, r4.w
mul r4.xyz, r4.w, r4
mul r5.xyz, r1.zxyw, r4.yzxw
mad r5.xyz, r1.yzxw, r4.zxyw, -r5
dp3 r5.x, r5, r5
rsq r5.x, r5.x
rcp r5.x, r5.x
min r6.x, r5.x, c27.z
add r5.x, -r6.x, c27.z
rsq r5.x, r5.x
rcp r5.x, r5.x
mad r5.y, r6.x, c32.x, c32.y
mad r5.y, r5.y, r6.x, c33.w
mad r5.y, r5.y, r6.x, c32.z
mad r5.x, r5.y, -r5.x, c30.y
mul r3.w, r3.w, r4.w
min r4.w, r3.w, c27.z
add r3.w, -r4_abs.w, c27.z
rsq r3.w, r3.w
rcp r3.w, r3.w
mad r5.y, r4_abs.w, c32.x, c32.y
mad r5.y, r5.y, r4_abs.w, c33.w
mad r5.y, r5.y, r4_abs.w, c32.z
mul r3.w, r3.w, r5.y
mad r5.y, r3.w, c34.x, c34.y
cmp r4.w, r4.w, -c36.z, -c36.w
mad r3.w, r5.y, r4.w, r3.w
add r3.w, -r3.w, c30.y
add r3.w, -r3.w, r5.x
mul r3.w, r2.x, r3.w
mad r3.w, -r3.w, r1.w, c27.z
mul_sat r3.w, r3.w, c36.y
mad r4.w, r3.w, c34.x, c34.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.w
dp3 r4.x, r1, r4
mul_sat r4.x, r4.x, c32.w
mad r4.y, r4.x, c34.x, c34.z
mul r4.x, r4.x, r4.x
mul r4.x, r4.x, r4.y
mad r3.w, r3.w, -r4.x, c27.z
mul r2.y, r2.y, r3.w
add r2.w, r2.w, c27.z
endrep
mov r2.w, r2.y
mov r3.w, c36.x
rep i0
add r4, r3.w, c31
mov r5.x, c36.x
cmp r5.y, -r4_abs.x, c4.w, r5.x
cmp r5.y, -r4_abs.y, c5.w, r5.y
cmp r5.y, -r4_abs.z, c6.w, r5.y
cmp r5.y, -r4_abs.w, c7.w, r5.y
if_ge -r5.y, c36.x
break_ne c27.z, -c27.z
endif
cmp r5.xzw, -r4_abs.x, c4.xyyz, r5.x
cmp r5.xzw, -r4_abs.y, c5.xyyz, r5
cmp r4.xyz, -r4_abs.z, c6, r5.xzww
cmp r4.xyz, -r4_abs.w, c7, r4
add r4.xyz, -r0.yzww, r4
dp3 r4.w, r4, r4
rsq r4.w, r4.w
mul r4.xyz, r4.w, r4
mul r5.xzw, r1.zyxy, r4.yyzx
mad r5.xzw, r1.yyzx, r4.zyxy, -r5
dp3 r5.x, r5.xzww, r5.xzww
rsq r5.x, r5.x
rcp r5.x, r5.x
min r6.x, r5.x, c27.z
add r5.x, -r6.x, c27.z
rsq r5.x, r5.x
rcp r5.x, r5.x
mad r5.z, r6.x, c32.x, c32.y
mad r5.z, r5.z, r6.x, c33.w
mad r5.z, r5.z, r6.x, c32.z
mad r5.x, r5.z, -r5.x, c30.y
mul r4.w, r4.w, r5.y
min r5.y, r4.w, c27.z
add r4.w, -r5_abs.y, c27.z
rsq r4.w, r4.w
rcp r4.w, r4.w
mad r5.z, r5_abs.y, c32.x, c32.y
mad r5.z, r5.z, r5_abs.y, c33.w
mad r5.z, r5.z, r5_abs.y, c32.z
mul r4.w, r4.w, r5.z
mad r5.z, r4.w, c34.x, c34.y
cmp r5.y, r5.y, -c36.z, -c36.w
mad r4.w, r5.z, r5.y, r4.w
add r4.w, -r4.w, c30.y
add r4.w, -r4.w, r5.x
mul r4.w, r2.x, r4.w
mad r4.w, -r4.w, r1.w, c27.z
mul_sat r4.w, r4.w, c36.y
mad r5.x, r4.w, c34.x, c34.z
mul r4.w, r4.w, r4.w
mul r4.w, r4.w, r5.x
dp3 r4.x, r1, r4
mul_sat r4.x, r4.x, c32.w
mad r4.y, r4.x, c34.x, c34.z
mul r4.x, r4.x, r4.x
mul r4.x, r4.x, r4.y
mad r4.x, r4.w, -r4.x, c27.z
mul r2.w, r2.w, r4.x
add r3.w, r3.w, c27.z
endrep
else
mov r2.w, c27.z
endif
mul r0.yzw, r2.w, r3.xxyz
cmp r0.xyz, r0.x, r0.yzww, c36.x
mul r1.xyz, r2.z, r0
mad r0.xyz, r0, r2.z, c34.w
mul r2, r1.xxyy, c35.xyxy
pow r0.w, r2.x, c35.z
exp r1.x, r2.y
add r1.x, -r1.x, c27.z
cmp r3.x, r0.x, r1.x, r0.w
pow r0.x, r2.z, c35.z
exp r0.w, r2.w
add r0.w, -r0.w, c27.z
cmp r3.y, r0.y, r0.w, r0.x
mul r0.xy, r1.z, c35
pow r1.x, r0.x, c35.z
exp r0.x, r0.y
add r0.x, -r0.x, c27.z
cmp r3.z, r0.z, r0.x, r1.x
mul oC0.xyz, r3, c22.x
mov oC0.w, c27.z

"
}
SubProgram "d3d11 " {
// Stats: 274 math, 8 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 576
Matrix 448 [lightOccluders1]
Matrix 512 [lightOccluders2]
Float 112 [M_PI]
Vector 144 [betaR] 3
Float 188 [mieG]
Float 192 [_Exposure]
Float 196 [Rg]
Float 200 [Rt]
Float 208 [RES_R]
Float 212 [RES_MU]
Float 216 [RES_MU_S]
Float 220 [RES_NU]
Float 240 [_Sun_Intensity]
Float 244 [_experimentalAtmoScale]
Float 248 [_viewdirOffset]
Float 252 [_Alpha_Global]
Vector 400 [_Globals_Origin] 3
Float 412 [_RimExposure]
Vector 416 [_Sun_WorldSunDir] 3
Vector 432 [sunPosAndRadius]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
root12:abacabaa
eefiecedckigpgbeogkfjccejcejpebgpgglcjkgabaaaaaapmcfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmcfaaaa
eaaaaaaaepajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaaceaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaiaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaabjaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaah
icaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabaaaaaajbcaabaaa
adaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaaj
ccaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaabaaaaaaj
ccaabaaaadaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaabaaaaaaaeaaaaaa
dcaaaaakbcaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaaea
akaabaaaadaaaaaadiaaaaajccaabaaaadaaaaaabkiacaaaaaaaaaaaamaaaaaa
bkiacaaaaaaaaaaaamaaaaaadcaaaaamecaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaaakaabaaaadaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
adaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaakecaabaaaadaaaaaa
dkaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadkaabaaaacaaaaaadbaaaaah
bcaabaaaaeaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaafecaabaaa
adaaaaaackaabaaaadaaaaaadcaaaaalecaabaaaadaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaaeackaabaiaebaaaaaaadaaaaaaaaaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahecaabaaaadaaaaaa
ckaabaaaadaaaaaabkaabaaaaaaaaaaabnaaaaahecaabaaaadaaaaaaabeaaaaa
aaaaaaaackaabaaaadaaaaaadmaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaaeaaaaaadhaaaaalecaabaaaadaaaaaackaabaaaadaaaaaadkiacaaa
aaaaaaaabjaaaaaaakiacaaaaaaaaaaaamaaaaaaaaaaaaakbcaabaaaaeaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaal
bcaabaaaaeaaaaaaakaabaaaaeaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaa
aaaaaaaaamaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaapaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaa
abaaaaaaigadbaaaabaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaaigadbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaa
agaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaagaaaaaaegacbaaaacaaaaaa
egacbaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaabkaabaaaagaaaaaabkaabaaa
agaaaaaaakaabaiaebaaaaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aeaaaaaaakaabaaaaeaaaaaaakaabaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaa
bkaabaiaebaaaaaaagaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaajhcaabaaaahaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaa
egacbaaaacaaaaaaaaaaaaahccaabaaaaeaaaaaaakaabaaaaaaaaaaabkaabaaa
agaaaaaadhaaaaajhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaahaaaaaa
egacbaaaacaaaaaadhaaaaajjcaabaaaaaaaaaaapgapbaaaaaaaaaaaagaebaaa
aeaaaaaaagaebaaaagaaaaaabaaaaaaibcaabaaaabaaaaaaegacbaaaafaaaaaa
egiccaaaaaaaaaaabkaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaabkaaaaaaaoaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaadcaaaaakccaabaaaacaaaaaaakaabaaaaeaaaaaaakaabaaa
aeaaaaaabkaabaiaebaaaaaaadaaaaaaelaaaaafecaabaaaafaaaaaabkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakecaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaadaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaebaaaaaa
acaaaaaadcaaaaalccaabaaaacaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaabkaabaaaacaaaaaadbaaaaahccaabaaaadaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadbaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaa
bkaabaaaacaaaaaaabaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaaa
aeaaaaaaaoaaaaalocaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaadpfgiicaaaaaaaaaaaanaaaaaaaaaaaaaiicaabaaaagaaaaaabkaabaia
ebaaaaaaaeaaaaaaabeaaaaaaaaaaadpdiaaaaahccaabaaaafaaaaaackaabaaa
afaaaaaackaabaaaafaaaaaaaaaaaaahicaabaaaafaaaaaabkaabaaaaeaaaaaa
abeaaaaaaaaaaadpdgaaaaaihcaabaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafbcaabaaaafaaaaaaabeaaaaaaaaaialpdhaaaaaj
pcaabaaaagaaaaaafgafbaaaadaaaaaaegaobaaaagaaaaaaegaobaaaafaaaaaa
aoaaaaahccaabaaaadaaaaaackaabaaaacaaaaaackaabaaaafaaaaaaaoaaaaal
hcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaa
aaaaaaaaanaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaaadpaaaaiadpaaaaaaaadcaaaaajccaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaafaaaaaackaabaaaaeaaaaaaaaaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaabkaabaaaagaaaaaaelaaaaafccaabaaaacaaaaaa
bkaabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
agaaaaaabkaabaaaacaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaaacaaaaaa
ckaabaaaagaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaafaaaaaa
dkaabaaaagaaaaaadeaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
hbdneklodiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaabodaklea
ddaaaaaiccaabaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
deaaaaaiecaabaaaacaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
aoaaaaakecaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
ckaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaackaabaaaacaaaaaabkaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
dcaaaaajccaabaaaaeaaaaaackaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajccaabaaaaeaaaaaackaabaaaacaaaaaabkaabaaaaeaaaaaa
abeaaaaaochgdidodcaaaaajccaabaaaaeaaaaaackaabaaaacaaaaaabkaabaaa
aeaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaaaaeaaaaaaabeaaaaadiphhpdpdiaaaaahccaabaaaaeaaaaaackaabaaa
acaaaaaabkaabaaaacaaaaaadbaaaaaiecaabaaaaeaaaaaaabeaaaaaaaaaiadp
akaabaiaibaaaaaaacaaaaaadcaaaaajccaabaaaaeaaaaaabkaabaaaaeaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahccaabaaaaeaaaaaackaabaaa
aeaaaaaabkaabaaaaeaaaaaadcaaaaajccaabaaaacaaaaaabkaabaaaacaaaaaa
ckaabaaaacaaaaaabkaabaaaaeaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaadhaaaaakbcaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaabkaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaacolkgidpabeaaaaakehadndpdiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaajbcaabaaaacaaaaaa
akaabaaaacaaaaaackaabaaaafaaaaaadkaabaaaaeaaaaaaaaaaaaahccaabaaa
acaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaaadpaaaaaaaiecaabaaaacaaaaaadkiacaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaaaeaaaaaackaabaaa
acaaaaaabkaabaaaacaaaaaaebaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaakccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaabkaabaia
ebaaaaaaaeaaaaaadiaaaaaiecaabaaaacaaaaaabkaabaaaadaaaaaaakiacaaa
aaaaaaaaanaaaaaadcaaaaakccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaa
aaaaaaaaanaaaaaaabeaaaaaaaaaialpebaaaaafccaabaaaadaaaaaabkaabaaa
adaaaaaaaoaaaaaiccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaa
anaaaaaaebaaaaafecaabaaaaeaaaaaackaabaaaacaaaaaaaoaaaaaiecaabaaa
aeaaaaaackaabaaaaeaaaaaaakiacaaaaaaaaaaaanaaaaaabkaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaaaaeaaaaaaaoaaaaaiccaabaaaafaaaaaaakaabaaaacaaaaaadkiacaaa
aaaaaaaaanaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaanaaaaaaaaaaaaahecaabaaaafaaaaaabkaabaaaadaaaaaadkaabaaa
aaaaaaaaeiaaaaalpcaabaaaagaaaaaajgafbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaadaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaafaaaaaaakaabaaaacaaaaaa
dkiacaaaaaaaaaaaanaaaaaaeiaaaaalpcaabaaaahaaaaaaigaabaaaafaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaa
ahaaaaaafgafbaaaacaaaaaaegaobaaaahaaaaaadcaaaaajpcaabaaaagaaaaaa
egaobaaaagaaaaaafgafbaaaadaaaaaaegaobaaaahaaaaaaaaaaaaahicaabaaa
afaaaaaackaabaaaaeaaaaaadkaabaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaa
ngafbaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
eiaaaaalpcaabaaaafaaaaaamgaabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaacaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaahaaaaaafgafbaaa
adaaaaaaegaobaaaafaaaaaaaaaaaaaiicaabaaaaaaaaaaackaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaiadpdiaaaaahpcaabaaaafaaaaaakgakbaaaacaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaafaaaaaabnaaaaahbcaabaaaaaaaaaaaakaabaaaaeaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaafaaaaaaegacbaaa
afaaaaaadeaaaaahicaabaaaaaaaaaaaakaabaaaafaaaaaaabeaaaaabhlhnbdi
aoaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaaoaaaaaj
ocaabaaaaeaaaaaaagiacaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaaajaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaajgahbaaaaeaaaaaadiaaaaal
gcaabaaaaeaaaaaaagiacaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaaaaaaaaiaeb
aaaaiaeaaaaaaaaaaoaaaaakgcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaeaea
aaaamadpaaaaaaaafgagbaaaaeaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaadaaaaaa
dkaabaaaaaaaaaaabkaabaaaaeaaaaaadcaaaaamccaabaaaaeaaaaaadkiacaia
ebaaaaaaaaaaaaaaalaaaaaadkiacaaaaaaaaaaaalaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaackaabaaaaeaaaaaadcaaaaao
mcaabaaaaeaaaaaapgipcaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaalaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaeaapaaaaaibcaabaaaabaaaaaa
agaabaaaabaaaaaapgipcaaaaaaaaaaaalaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaaeaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaamalpbjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgafbaaa
adaaaaaaegacbaaaacaaaaaaabaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaagiacaaa
aaaaaaaaapaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaaeaaaaaa
akaabaaaaeaaaaaaakaabaaaadaaaaaadcaaaaakbcaabaaaaaaaaaaadkaabaia
ebaaaaaaadaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaabnaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaaeaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaadbaaaaahicaabaaaacaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaaeaakaabaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaajbcaabaaaaaaaaaaadkaabaaa
acaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaialpdjaaaaahccaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaialpbpaaaeadbkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
egiccaaaaaaaaaaablaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaeaaaaaa
adaaaeadakaabaaaadaaaaaabbaaaaajbcaabaaaadaaaaaaegiocaaaaaaaaaaa
bpaaaaaaegjojaaadkaabaaaacaaaaaabnaaaaahccaabaaaadaaaaaaabeaaaaa
aaaaaaaaakaabaaaadaaaaaabpaaaeadbkaabaaaadaaaaaaacaaaaabbfaaaaab
bbaaaaajbcaabaaaaeaaaaaaegiocaaaaaaaaaaabmaaaaaaegjojaaadkaabaaa
acaaaaaabbaaaaajccaabaaaaeaaaaaaegiocaaaaaaaaaaabnaaaaaaegjojaaa
dkaabaaaacaaaaaabbaaaaajecaabaaaaeaaaaaaegiocaaaaaaaaaaaboaaaaaa
egjojaaadkaabaaaacaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaaeaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaelaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaafgafbaaaadaaaaaadiaaaaahhcaabaaa
afaaaaaacgajbaaaabaaaaaajgaebaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaa
jgaebaaaabaaaaaacgajbaaaaeaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaah
icaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaaddaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaeaaaaaadkaabaiaebaaaaaaadaaaaaa
abeaaaaaaaaaiadpelaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadcaaaaaj
bcaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaajbcaabaaaafaaaaaaakaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaa
iedefjlodcaaaaajicaabaaaadaaaaaaakaabaaaafaaaaaadkaabaaaadaaaaaa
abeaaaaakeanmjdpdcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaa
dkaabaaaaeaaaaaaabeaaaaanlapmjdpaoaaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaabkaabaaaadaaaaaaddaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaadaaaaaaakaabaiambaaaaaaadaaaaaa
abeaaaaaaaaaiadpelaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaak
icaabaaaaeaaaaaaakaabaiaibaaaaaaadaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakicaabaaaaeaaaaaadkaabaaaaeaaaaaaakaabaiaibaaaaaa
adaaaaaaabeaaaaaiedefjlodcaaaaakicaabaaaaeaaaaaadkaabaaaaeaaaaaa
akaabaiaibaaaaaaadaaaaaaabeaaaaakeanmjdpdiaaaaahbcaabaaaafaaaaaa
bkaabaaaadaaaaaadkaabaaaaeaaaaaadcaaaaajbcaabaaaafaaaaaaakaabaaa
afaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaaibcaabaaaadaaaaaa
akaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaaabaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaaakaabaaaafaaaaaadcaaaaajbcaabaaaadaaaaaadkaabaaa
aeaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaaabeaaaaanlapmjdpaaaaaaaibcaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaadkaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaa
dkaabaaaaaaaaaaaakaabaaaadaaaaaaaoaaaaajbcaabaaaadaaaaaaakaabaia
ebaaaaaaadaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaiadpdicaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaaabeaaaaaaaaaaadpdcaaaaajccaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaaadaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaa
bkaabaaaadaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaa
aeaaaaaadicaaaahccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaakaea
dcaaaaajicaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaa
diaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadcaaaaak
bcaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaa
boaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaab
dgaaaaaficaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaafbcaabaaaadaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaaadaaaaaaakaabaaaadaaaaaa
abeaaaaaaeaaaaaaadaaaeadbkaabaaaadaaaaaabbaaaaajccaabaaaadaaaaaa
egiocaaaaaaaaaaacdaaaaaaegjojaaaakaabaaaadaaaaaabnaaaaahicaabaaa
adaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaabpaaaeaddkaabaaaadaaaaaa
acaaaaabbfaaaaabbbaaaaajbcaabaaaaeaaaaaaegiocaaaaaaaaaaacaaaaaaa
egjojaaaakaabaaaadaaaaaabbaaaaajccaabaaaaeaaaaaaegiocaaaaaaaaaaa
cbaaaaaaegjojaaaakaabaaaadaaaaaabbaaaaajecaabaaaaeaaaaaaegiocaaa
aaaaaaaaccaaaaaaegjojaaaakaabaaaadaaaaaaaaaaaaaihcaabaaaaeaaaaaa
egacbaiaebaaaaaaaaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaaelaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaaaoaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaapgapbaaaadaaaaaa
diaaaaahhcaabaaaafaaaaaacgajbaaaabaaaaaajgaebaaaaeaaaaaadcaaaaak
hcaabaaaafaaaaaajgaebaaaabaaaaaacgajbaaaaeaaaaaaegacbaiaebaaaaaa
afaaaaaabaaaaaahicaabaaaaeaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaa
elaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaaddaaaaahicaabaaaaeaaaaaa
dkaabaaaaeaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaafaaaaaadkaabaia
ebaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaafaaaaaaakaabaaa
afaaaaaadcaaaaajccaabaaaafaaaaaadkaabaaaaeaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaajccaabaaaafaaaaaabkaabaaaafaaaaaadkaabaaa
aeaaaaaaabeaaaaaiedefjlodcaaaaajicaabaaaaeaaaaaabkaabaaaafaaaaaa
dkaabaaaaeaaaaaaabeaaaaakeanmjdpdcaaaaakicaabaaaaeaaaaaadkaabaia
ebaaaaaaaeaaaaaaakaabaaaafaaaaaaabeaaaaanlapmjdpaoaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaaddaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaadaaaaaabkaabaia
mbaaaaaaadaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaadcaaaaakbcaabaaaafaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakbcaabaaaafaaaaaaakaabaaaafaaaaaa
bkaabaiaibaaaaaaadaaaaaaabeaaaaaiedefjlodcaaaaakbcaabaaaafaaaaaa
akaabaaaafaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaakeanmjdpdiaaaaah
ccaabaaaafaaaaaadkaabaaaadaaaaaaakaabaaaafaaaaaadcaaaaajccaabaaa
afaaaaaabkaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaai
ccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaaabaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaaaafaaaaaadcaaaaajccaabaaa
adaaaaaaakaabaaaafaaaaaadkaabaaaadaaaaaabkaabaaaadaaaaaaaaaaaaai
ccaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaanlapmjdpaaaaaaai
ccaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaadkaabaaaaeaaaaaadiaaaaah
ccaabaaaadaaaaaadkaabaaaaaaaaaaabkaabaaaadaaaaaaaoaaaaajccaabaaa
adaaaaaabkaabaiaebaaaaaaadaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpdicaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaaadpdcaaaaajicaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaa
adaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahccaabaaaadaaaaaa
bkaabaaaadaaaaaadkaabaaaadaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaaeaaaaaadicaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaakaeadcaaaaajbcaabaaaaeaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
dkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaa
aeaaaaaadcaaaaakccaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
bkaabaaaadaaaaaaboaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
abaaaaaabgaaaaabbcaaaaabdgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bfaaaaabdiaaaaahhcaabaaaaaaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaakgakbaaaadaaaaaaegacbaaaaaaaaaaadbaaaaak
hcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaacpnnledpcpnnledpcpnnledp
aaaaaaaadiaaaaakpcaabaaaacaaaaaaagafbaaaaaaaaaaaaceaaaaanmcomedo
dlkklilpnmcomedodlkklilpcpaaaaafdcaabaaaaaaaaaaaigaabaaaacaaaaaa
diaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaacplkoidocplkoido
aaaaaaaaaaaaaaaabjaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaabjaaaaaf
dcaabaaaacaaaaaangafbaaaacaaaaaaaaaaaaaldcaabaaaacaaaaaaegaabaia
ebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadhaaaaaj
dcaabaaaacaaaaaaegaabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaacaaaaaa
diaaaaakdcaabaaaaaaaaaaakgakbaaaaaaaaaaaaceaaaaanmcomedodlkklilp
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaacplkoidobjaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dhaaaaajecaabaaaacaaaaaackaabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaacaaaaaapgipcaaaaaaaaaaa
apaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_ON" }
"!!GL3x"
}
}
 }
}
}