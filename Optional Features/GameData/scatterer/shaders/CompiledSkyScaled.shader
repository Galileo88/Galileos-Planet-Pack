// Compiled shader for custom platforms, uncompressed size: 319.3KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 //        gles : 348 avg math (251..446), 1 texture, 14 avg branch (10..19)
 //      opengl : 348 avg math (251..446), 1 texture, 14 avg branch (10..19)
 // Stats for Fragment shader:
 //       d3d11 : 211 avg math (152..270), 9 avg branch (4..14)
 //        d3d9 : 257 avg math (190..324), 2 texture, 12 avg branch (4..20)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend DstColor Zero
  GpuProgramID 20372
Program "vp" {
SubProgram "opengl " {
// Stats: 251 math, 1 textures, 10 branches
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
  tmpvar_6 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_6 - _Globals_Origin);
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_4 = tmpvar_9;
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_7));
  rMu_3 = tmpvar_10;
  mu_2 = (tmpvar_10 / tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt(
    (((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_11 > 0.0)) {
    rMu_3 = (tmpvar_10 + tmpvar_11);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_12;
    tmpvar_12 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      float tmpvar_16;
      tmpvar_16 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      float tmpvar_20;
      tmpvar_20 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      float tmpvar_23;
      if ((tmpvar_22 < 0.0)) {
        tmpvar_23 = -1.0;
      } else {
        tmpvar_23 = ((-(tmpvar_21) - sqrt(tmpvar_22)) / (2.0 * tmpvar_20));
      };
      float tmpvar_24;
      tmpvar_24 = (tmpvar_19 - tmpvar_23);
      float tmpvar_25;
      float H_26;
      H_26 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_27;
      tmpvar_27.x = mu_2;
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_4));
      vec2 tmpvar_28;
      tmpvar_28 = (sqrt((
        (0.5 / H_26)
       * r_4)) * tmpvar_27);
      vec2 tmpvar_29;
      tmpvar_29 = sign(tmpvar_28);
      vec2 tmpvar_30;
      tmpvar_30 = (tmpvar_28 * tmpvar_28);
      float tmpvar_31;
      if ((tmpvar_29.y > tmpvar_29.x)) {
        tmpvar_31 = exp(tmpvar_30.x);
      } else {
        tmpvar_31 = 0.0;
      };
      vec2 tmpvar_32;
      tmpvar_32.x = 1.0;
      tmpvar_32.y = exp(((
        -(tmpvar_24)
       / H_26) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      tmpvar_25 = ((sqrt(
        ((6.2831 * H_26) * r_4)
      ) * exp(
        ((Rg - r_4) / H_26)
      )) * (tmpvar_31 + dot (
        ((tmpvar_29 / ((2.3193 * 
          abs(tmpvar_28)
        ) + sqrt(
          ((1.52 * tmpvar_30) + 4.0)
        ))) * tmpvar_32)
      , vec2(1.0, -1.0))));
      float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_4));
      vec2 tmpvar_35;
      tmpvar_35 = (sqrt((
        (0.5 / H_33)
       * r_4)) * tmpvar_34);
      vec2 tmpvar_36;
      tmpvar_36 = sign(tmpvar_35);
      vec2 tmpvar_37;
      tmpvar_37 = (tmpvar_35 * tmpvar_35);
      float tmpvar_38;
      if ((tmpvar_36.y > tmpvar_36.x)) {
        tmpvar_38 = exp(tmpvar_37.x);
      } else {
        tmpvar_38 = 0.0;
      };
      vec2 tmpvar_39;
      tmpvar_39.x = 1.0;
      tmpvar_39.y = exp(((
        -(tmpvar_24)
       / H_33) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_25) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_33)
         * r_4)) * exp((
          (Rg - r_4)
         / H_33))) * (tmpvar_38 + dot ((
          (tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt((
            (1.52 * tmpvar_37)
           + 4.0))))
         * tmpvar_39), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_41;
      tmpvar_41 = (min (abs(y_over_x_40), 1.0) / max (abs(y_over_x_40), 1.0));
      float tmpvar_42;
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
      vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((tmpvar_42 * sign(y_over_x_40)) / 1.5);
      tmpvar_43.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      extinction_5 = texture2DLod (_Transmittance, tmpvar_43.xy, 0.0).xyz;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    float tmpvar_44;
    tmpvar_44 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_45;
    tmpvar_45 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    float tmpvar_46;
    tmpvar_46 = ((tmpvar_45 * tmpvar_45) - ((4.0 * tmpvar_44) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_47;
    if ((tmpvar_46 < 0.0)) {
      tmpvar_47 = -1.0;
    } else {
      tmpvar_47 = ((-(tmpvar_45) - sqrt(tmpvar_46)) / (2.0 * tmpvar_44));
    };
    bool tmpvar_48;
    tmpvar_48 = (tmpvar_47 > 0.0);
    if (!(tmpvar_48)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    };
    vec4 tmpvar_49;
    tmpvar_49.w = 1.0;
    tmpvar_49.xyz = extinction_5;
    tmpvar_1 = tmpvar_49;
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
// Stats: 251 math, 1 textures, 10 branches
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
  tmpvar_6 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_6 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_4 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_7));
  rMu_3 = tmpvar_10;
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt(
    (((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_11 > 0.0)) {
    rMu_3 = (tmpvar_10 + tmpvar_11);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      highp float tmpvar_23;
      if ((tmpvar_22 < 0.0)) {
        tmpvar_23 = -1.0;
      } else {
        tmpvar_23 = ((-(tmpvar_21) - sqrt(tmpvar_22)) / (2.0 * tmpvar_20));
      };
      highp float tmpvar_24;
      tmpvar_24 = (tmpvar_19 - tmpvar_23);
      highp float tmpvar_25;
      highp float H_26;
      H_26 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_27;
      tmpvar_27.x = mu_2;
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_4));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt((
        (0.5 / H_26)
       * r_4)) * tmpvar_27);
      highp vec2 tmpvar_29;
      tmpvar_29 = sign(tmpvar_28);
      highp vec2 tmpvar_30;
      tmpvar_30 = (tmpvar_28 * tmpvar_28);
      highp float tmpvar_31;
      if ((tmpvar_29.y > tmpvar_29.x)) {
        tmpvar_31 = exp(tmpvar_30.x);
      } else {
        tmpvar_31 = 0.0;
      };
      highp vec2 tmpvar_32;
      tmpvar_32.x = 1.0;
      tmpvar_32.y = exp(((
        -(tmpvar_24)
       / H_26) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      tmpvar_25 = ((sqrt(
        ((6.2831 * H_26) * r_4)
      ) * exp(
        ((Rg - r_4) / H_26)
      )) * (tmpvar_31 + dot (
        ((tmpvar_29 / ((2.3193 * 
          abs(tmpvar_28)
        ) + sqrt(
          ((1.52 * tmpvar_30) + 4.0)
        ))) * tmpvar_32)
      , vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_4));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt((
        (0.5 / H_33)
       * r_4)) * tmpvar_34);
      highp vec2 tmpvar_36;
      tmpvar_36 = sign(tmpvar_35);
      highp vec2 tmpvar_37;
      tmpvar_37 = (tmpvar_35 * tmpvar_35);
      highp float tmpvar_38;
      if ((tmpvar_36.y > tmpvar_36.x)) {
        tmpvar_38 = exp(tmpvar_37.x);
      } else {
        tmpvar_38 = 0.0;
      };
      highp vec2 tmpvar_39;
      tmpvar_39.x = 1.0;
      tmpvar_39.y = exp(((
        -(tmpvar_24)
       / H_33) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_25) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_33)
         * r_4)) * exp((
          (Rg - r_4)
         / H_33))) * (tmpvar_38 + dot ((
          (tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt((
            (1.52 * tmpvar_37)
           + 4.0))))
         * tmpvar_39), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_42;
      tmpvar_42 = (min (abs(y_over_x_41), 1.0) / max (abs(y_over_x_41), 1.0));
      highp float tmpvar_43;
      tmpvar_43 = (tmpvar_42 * tmpvar_42);
      tmpvar_43 = (((
        ((((
          ((((-0.01213232 * tmpvar_43) + 0.05368138) * tmpvar_43) - 0.1173503)
         * tmpvar_43) + 0.1938925) * tmpvar_43) - 0.3326756)
       * tmpvar_43) + 0.9999793) * tmpvar_42);
      tmpvar_43 = (tmpvar_43 + (float(
        (abs(y_over_x_41) > 1.0)
      ) * (
        (tmpvar_43 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_44;
      tmpvar_44.zw = vec2(0.0, 0.0);
      tmpvar_44.x = ((tmpvar_43 * sign(y_over_x_41)) / 1.5);
      tmpvar_44.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      lowp vec4 tmpvar_45;
      tmpvar_45 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_44.xy, 0.0);
      tmpvar_40 = tmpvar_45.xyz;
      extinction_5 = tmpvar_40;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    highp float tmpvar_46;
    tmpvar_46 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_47;
    tmpvar_47 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    highp float tmpvar_48;
    tmpvar_48 = ((tmpvar_47 * tmpvar_47) - ((4.0 * tmpvar_46) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_49;
    if ((tmpvar_48 < 0.0)) {
      tmpvar_49 = -1.0;
    } else {
      tmpvar_49 = ((-(tmpvar_47) - sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    };
    bool tmpvar_50;
    tmpvar_50 = (tmpvar_49 > 0.0);
    if (!(tmpvar_50)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    };
    highp vec4 tmpvar_51;
    tmpvar_51.w = 1.0;
    tmpvar_51.xyz = extinction_5;
    tmpvar_1 = tmpvar_51;
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
highp vec4 t0;
highp vec3 t1;
highp vec2 t2;
highp ivec2 ti2;
highp vec3 t3;
highp vec4 t4;
highp vec3 t5;
highp float t6;
bool tb6;
highp float t7;
bool tb7;
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
bool tb20;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t18 = dot(t1.xyz, t1.xyz);
    t18 = inversesqrt(t18);
    t1.xyz = vec3(t18) * t1.xyz;
    t18 = (-Rg) + Rt;
    t19 = t18 * _experimentalAtmoScale;
    t2.x = t18 * _experimentalAtmoScale + Rg;
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t18 = dot(t3.xyz, t3.xyz);
    t4.x = sqrt(t18);
    t14.x = dot(t3.xyz, t1.xyz);
    t4.y = t14.x / t4.x;
    t18 = t14.x * t14.x + (-t18);
    t18 = t2.x * t2.x + t18;
    t18 = sqrt(t18);
    t18 = (-t18) + (-t14.x);
    t18 = max(t18, 0.0);
    tb20 = 0.0<t18;
    t18 = t18 + t14.x;
    t2.y = t18 / t2.x;
    t3.xy = (bool(tb20)) ? t2.xy : t4.xy;
    tb18 = t2.x<t3.x;
    if(tb18){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t18 = dot(t1.xyz, t1.xyz);
    t1.x = t14.x + t14.x;
    t7 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t13 = dot(t0.xyz, t0.xyz);
    t7 = t13 + t7;
    t0.x = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t0.x = (-t0.x) * 2.0 + t7;
    t6 = (-Rg) * Rg + t0.x;
    t12 = t1.x * t1.x;
    t1.x = t18 * 4.0;
    t6 = (-t1.x) * t6 + t12;
    tb7 = t6<0.0;
    t6 = sqrt(t6);
    t6 = (-t14.x) * 2.0 + (-t6);
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = (tb7) ? -1.0 : t6;
    tb7 = 0.0<t6;
    if(tb7){
        t0.x = (-t2.x) * t2.x + t0.x;
        t0.x = (-t1.x) * t0.x + t12;
        tb12 = t0.x<0.0;
        t0.x = sqrt(t0.x);
        t0.x = (-t14.x) * 2.0 + (-t0.x);
        t0.x = t0.x / t18;
        t0.x = (tb12) ? 1.0 : (-t0.x);
        t0.x = t0.x + t6;
        t12 = HR * _experimentalAtmoScale;
        t18 = 0.5 / t12;
        t18 = t3.x * t18;
        t18 = sqrt(t18);
        t1.x = t0.x / t3.x;
        t3.z = t1.x + t3.y;
        t1.xy = vec2(float(t18) * t3.y, float(t18) * t3.z);
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t1.xyxx).xy) * 0xFFFFFFFFu);
        ti14.xy = ivec2(uvec2(lessThan(t1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti14.xy;
        t2.xy = vec2(ti2.xy);
        t4.xyz = t1.xxy * t1.xxy;
        tb18 = t2.x<t2.y;
        t13 = t4.x * 1.44269502;
        t13 = exp2(t13);
        t18 = tb18 ? t13 : float(0.0);
        t14.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t14.xy = sqrt(t14.xy);
        t1.xy = abs(t1.xy) * vec2(2.31929994, 2.31929994) + t14.xy;
        t1.xy = t2.xy / t1.xy;
        t13 = (-t0.x) / t12;
        t2.x = t3.x + t3.x;
        t2.x = t0.x / t2.x;
        t2.x = t3.y + t2.x;
        t13 = t13 * t2.x;
        t13 = t13 * 1.44269502;
        t4.y = exp2(t13);
        t4.xz = vec2(1.0, 1.0);
        t1.xy = t1.xy * t4.xy;
        t13 = t12 * t3.x;
        t13 = t13 * 6.28310013;
        t13 = sqrt(t13);
        t8 = (-t3.x) + Rg;
        t12 = t8 / t12;
        t12 = t12 * 1.44269502;
        t12 = exp2(t12);
        t12 = t12 * t13;
        t1.x = dot(t1.xy, vec2(1.0, -1.0));
        t18 = t18 + t1.x;
        t12 = t18 * t12;
        t18 = HM * _experimentalAtmoScale;
        t1.x = 0.5 / t18;
        t1.x = t3.x * t1.x;
        t1.x = sqrt(t1.x);
        t1.xy = vec2(t3.y * t1.x, t3.z * t1.x);
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t1.xyxy).xy) * 0xFFFFFFFFu);
        ti15.xy = ivec2(uvec2(lessThan(t1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti15.xy;
        t14.xy = vec2(ti14.xy);
        t5.xyz = t1.xxy * t1.xxy;
        tb13 = t14.x<t14.y;
        t15.x = t5.x * 1.44269502;
        t15.x = exp2(t15.x);
        t13 = tb13 ? t15.x : float(0.0);
        t15.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t15.xy = sqrt(t15.xy);
        t1.xy = abs(t1.xy) * vec2(2.31929994, 2.31929994) + t15.xy;
        t1.xy = t14.xy / t1.xy;
        t0.x = (-t0.x) / t18;
        t0.x = t2.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t4.w = exp2(t0.x);
        t1.xy = vec2(t1.x * t4.z, t1.y * t4.w);
        t0.x = t18 * t3.x;
        t0.x = t0.x * 6.28310013;
        t0.x = sqrt(t0.x);
        t18 = t8 / t18;
        t18 = t18 * 1.44269502;
        t18 = exp2(t18);
        t0.x = t18 * t0.x;
        t18 = dot(t1.xy, vec2(1.0, -1.0));
        t18 = t18 + t13;
        t0.x = t18 * t0.x;
        t1.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xzw = (-betaR.xyzx.xyz) * vec3(t12) + (-t1.xyz);
        t0.xzw = t0.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
        t0.xzw = exp2(t0.xzw);
    } else {
        t1.x = t3.x + (-Rg);
        t1.x = t1.x / t19;
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
        t0.xzw = textureLod(_Transmittance, t1.xy, 0.0).xyz;
    //ENDIF
    }
    t1.x = t0.z + t0.x;
    t1.x = t0.w + t1.x;
    t1.x = t1.x * 0.333333343;
    t7 = (-_Extinction_Tint) + 1.0;
    t1.x = t1.x * t7;
    t0.xzw = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t0.xzw + t1.xxx;
    t0.xzw = t0.xzw * vec3(extinctionMultiplier);
    tb6 = 0.0>=t6;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xzw + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb6)) ? t1.xyz : t0.xzw;
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
vec4 t0;
bool tb0;
vec3 t1;
vec4 t2;
ivec2 ti2;
vec3 t3;
vec4 t4;
vec3 t5;
float t6;
bool tb6;
float t7;
bool tb7;
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
bool tb20;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t18 = dot(t1.xyz, t1.xyz);
    t18 = inversesqrt(t18);
    t1.xyz = vec3(t18) * t1.xyz;
    t18 = (-Rg) + Rt;
    t19 = t18 * _experimentalAtmoScale;
    t2.x = t18 * _experimentalAtmoScale + Rg;
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t18 = dot(t3.xyz, t3.xyz);
    t4.x = sqrt(t18);
    t14.x = dot(t3.xyz, t1.xyz);
    t4.y = t14.x / t4.x;
    t18 = t14.x * t14.x + (-t18);
    t18 = t2.x * t2.x + t18;
    t18 = sqrt(t18);
    t18 = (-t18) + (-t14.x);
    t18 = max(t18, 0.0);
    tb20 = 0.0<t18;
    t18 = t18 + t14.x;
    t2.y = t18 / t2.x;
    t3.xy = (bool(tb20)) ? t2.xy : t4.xy;
    tb18 = t2.x<t3.x;
    if(tb18){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t18 = dot(t1.xyz, t1.xyz);
    t1.x = t14.x + t14.x;
    t7 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t13 = dot(t0.xyz, t0.xyz);
    t7 = t13 + t7;
    t0.x = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t0.x = (-t0.x) * 2.0 + t7;
    t6 = (-Rg) * Rg + t0.x;
    t12 = t1.x * t1.x;
    t1.x = t18 * 4.0;
    t6 = (-t1.x) * t6 + t12;
    tb7 = t6<0.0;
    t6 = sqrt(t6);
    t6 = (-t14.x) * 2.0 + (-t6);
    t18 = t18 + t18;
    t6 = t6 / t18;
    t6 = (tb7) ? -1.0 : t6;
    tb7 = 0.0<t6;
    if(tb7){
        t0.x = (-t2.x) * t2.x + t0.x;
        t0.x = (-t1.x) * t0.x + t12;
        tb12 = t0.x<0.0;
        t0.x = sqrt(t0.x);
        t0.x = (-t14.x) * 2.0 + (-t0.x);
        t0.x = t0.x / t18;
        t0.x = (tb12) ? 1.0 : (-t0.x);
        t0.x = t0.x + t6;
        t12 = HR * _experimentalAtmoScale;
        t18 = 0.5 / t12;
        t18 = t3.x * t18;
        t18 = sqrt(t18);
        t1.x = t0.x / t3.x;
        t3.z = t1.x + t3.y;
        t1.xy = vec2(t18) * t3.yz;
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t1.xyxx).xy) * 0xFFFFFFFFu);
        ti14.xy = ivec2(uvec2(lessThan(t1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti14.xy;
        t2.xy = vec2(ti2.xy);
        t4.xyz = t1.xxy * t1.xxy;
        tb18 = t2.x<t2.y;
        t13 = t4.x * 1.44269502;
        t13 = exp2(t13);
        t18 = tb18 ? t13 : float(0.0);
        t14.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t14.xy = sqrt(t14.xy);
        t1.xy = abs(t1.xy) * vec2(2.31929994, 2.31929994) + t14.xy;
        t1.xy = t2.xy / t1.xy;
        t13 = (-t0.x) / t12;
        t2.x = t3.x + t3.x;
        t2.x = t0.x / t2.x;
        t2.x = t3.y + t2.x;
        t13 = t13 * t2.x;
        t13 = t13 * 1.44269502;
        t4.y = exp2(t13);
        t4.xz = vec2(1.0, 1.0);
        t1.xy = t1.xy * t4.xy;
        t13 = t12 * t3.x;
        t13 = t13 * 6.28310013;
        t13 = sqrt(t13);
        t8 = (-t3.x) + Rg;
        t12 = t8 / t12;
        t12 = t12 * 1.44269502;
        t12 = exp2(t12);
        t12 = t12 * t13;
        t1.x = dot(t1.xy, vec2(1.0, -1.0));
        t18 = t18 + t1.x;
        t12 = t18 * t12;
        t18 = HM * _experimentalAtmoScale;
        t1.x = 0.5 / t18;
        t1.x = t3.x * t1.x;
        t1.x = sqrt(t1.x);
        t1.xy = t3.yz * t1.xx;
        ti14.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t1.xyxy).xy) * 0xFFFFFFFFu);
        ti15.xy = ivec2(uvec2(lessThan(t1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti14.xy = (-ti14.xy) + ti15.xy;
        t14.xy = vec2(ti14.xy);
        t5.xyz = t1.xxy * t1.xxy;
        tb13 = t14.x<t14.y;
        t15.x = t5.x * 1.44269502;
        t15.x = exp2(t15.x);
        t13 = tb13 ? t15.x : float(0.0);
        t15.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t15.xy = sqrt(t15.xy);
        t1.xy = abs(t1.xy) * vec2(2.31929994, 2.31929994) + t15.xy;
        t1.xy = t14.xy / t1.xy;
        t0.x = (-t0.x) / t18;
        t0.x = t2.x * t0.x;
        t0.x = t0.x * 1.44269502;
        t4.w = exp2(t0.x);
        t1.xy = t1.xy * t4.zw;
        t0.x = t18 * t3.x;
        t0.x = t0.x * 6.28310013;
        t0.x = sqrt(t0.x);
        t18 = t8 / t18;
        t18 = t18 * 1.44269502;
        t18 = exp2(t18);
        t0.x = t18 * t0.x;
        t18 = dot(t1.xy, vec2(1.0, -1.0));
        t18 = t18 + t13;
        t0.x = t18 * t0.x;
        t1.xyz = t0.xxx * betaMEx.xyzx.xyz;
        t0.xzw = (-betaR.xyzx.xyz) * vec3(t12) + (-t1.xyz);
        t0.xzw = t0.xzw * vec3(1.44269502, 1.44269502, 1.44269502);
        t2.xyz = exp2(t0.xzw);
    } else {
        t0.x = t3.x + (-Rg);
        t0.x = t0.x / t19;
        t1.y = sqrt(t0.x);
        t0.x = t3.y + 0.150000006;
        t0.x = t0.x * 12.262105;
        t12 = min(abs(t0.x), 1.0);
        t18 = max(abs(t0.x), 1.0);
        t18 = float(1.0) / t18;
        t12 = t18 * t12;
        t18 = t12 * t12;
        t13 = t18 * 0.0208350997 + -0.0851330012;
        t13 = t18 * t13 + 0.180141002;
        t13 = t18 * t13 + -0.330299497;
        t18 = t18 * t13 + 0.999866009;
        t13 = t18 * t12;
        tb19 = 1.0<abs(t0.x);
        t13 = t13 * -2.0 + 1.57079637;
        t13 = tb19 ? t13 : float(0.0);
        t12 = t12 * t18 + t13;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t12) : t12;
        t1.x = t0.x * 0.666666687;
        t2 = textureLod(_Transmittance, t1.xy, 0.0);
    //ENDIF
    }
    t0.x = t2.y + t2.x;
    t0.x = t2.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t12 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t12;
    t0.xzw = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t2.xyz + t0.xxx;
    t0.xzw = t0.xzw * vec3(extinctionMultiplier);
    tb6 = 0.0>=t6;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xzw + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb6)) ? t1.xyz : t0.xzw;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 446 math, 1 textures, 19 branches
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
  tmpvar_6 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_6 - _Globals_Origin);
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_4 = tmpvar_9;
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_7));
  rMu_3 = tmpvar_10;
  mu_2 = (tmpvar_10 / tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt(
    (((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_11 > 0.0)) {
    rMu_3 = (tmpvar_10 + tmpvar_11);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_12;
    tmpvar_12 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      float tmpvar_16;
      tmpvar_16 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      float tmpvar_20;
      tmpvar_20 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      float tmpvar_23;
      if ((tmpvar_22 < 0.0)) {
        tmpvar_23 = -1.0;
      } else {
        tmpvar_23 = ((-(tmpvar_21) - sqrt(tmpvar_22)) / (2.0 * tmpvar_20));
      };
      float tmpvar_24;
      tmpvar_24 = (tmpvar_19 - tmpvar_23);
      float tmpvar_25;
      float H_26;
      H_26 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_27;
      tmpvar_27.x = mu_2;
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_4));
      vec2 tmpvar_28;
      tmpvar_28 = (sqrt((
        (0.5 / H_26)
       * r_4)) * tmpvar_27);
      vec2 tmpvar_29;
      tmpvar_29 = sign(tmpvar_28);
      vec2 tmpvar_30;
      tmpvar_30 = (tmpvar_28 * tmpvar_28);
      float tmpvar_31;
      if ((tmpvar_29.y > tmpvar_29.x)) {
        tmpvar_31 = exp(tmpvar_30.x);
      } else {
        tmpvar_31 = 0.0;
      };
      vec2 tmpvar_32;
      tmpvar_32.x = 1.0;
      tmpvar_32.y = exp(((
        -(tmpvar_24)
       / H_26) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      tmpvar_25 = ((sqrt(
        ((6.2831 * H_26) * r_4)
      ) * exp(
        ((Rg - r_4) / H_26)
      )) * (tmpvar_31 + dot (
        ((tmpvar_29 / ((2.3193 * 
          abs(tmpvar_28)
        ) + sqrt(
          ((1.52 * tmpvar_30) + 4.0)
        ))) * tmpvar_32)
      , vec2(1.0, -1.0))));
      float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_4));
      vec2 tmpvar_35;
      tmpvar_35 = (sqrt((
        (0.5 / H_33)
       * r_4)) * tmpvar_34);
      vec2 tmpvar_36;
      tmpvar_36 = sign(tmpvar_35);
      vec2 tmpvar_37;
      tmpvar_37 = (tmpvar_35 * tmpvar_35);
      float tmpvar_38;
      if ((tmpvar_36.y > tmpvar_36.x)) {
        tmpvar_38 = exp(tmpvar_37.x);
      } else {
        tmpvar_38 = 0.0;
      };
      vec2 tmpvar_39;
      tmpvar_39.x = 1.0;
      tmpvar_39.y = exp(((
        -(tmpvar_24)
       / H_33) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_25) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_33)
         * r_4)) * exp((
          (Rg - r_4)
         / H_33))) * (tmpvar_38 + dot ((
          (tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt((
            (1.52 * tmpvar_37)
           + 4.0))))
         * tmpvar_39), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_41;
      tmpvar_41 = (min (abs(y_over_x_40), 1.0) / max (abs(y_over_x_40), 1.0));
      float tmpvar_42;
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
      vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((tmpvar_42 * sign(y_over_x_40)) / 1.5);
      tmpvar_43.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      extinction_5 = texture2DLod (_Transmittance, tmpvar_43.xy, 0.0).xyz;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    float tmpvar_44;
    tmpvar_44 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_45;
    tmpvar_45 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    float tmpvar_46;
    tmpvar_46 = ((tmpvar_45 * tmpvar_45) - ((4.0 * tmpvar_44) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_47;
    if ((tmpvar_46 < 0.0)) {
      tmpvar_47 = -1.0;
    } else {
      tmpvar_47 = ((-(tmpvar_45) - sqrt(tmpvar_46)) / (2.0 * tmpvar_44));
    };
    bool tmpvar_48;
    tmpvar_48 = (tmpvar_47 > 0.0);
    if (!(tmpvar_48)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    } else {
      float eclipseShadow_49;
      eclipseShadow_49 = 1.0;
      float tmpvar_50;
      float tmpvar_51;
      tmpvar_51 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_52;
      tmpvar_52 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      float tmpvar_53;
      tmpvar_53 = ((tmpvar_52 * tmpvar_52) - ((4.0 * tmpvar_51) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      if ((tmpvar_53 < 0.0)) {
        tmpvar_50 = -1.0;
      } else {
        float tmpvar_54;
        tmpvar_54 = ((-(tmpvar_52) - sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
        float tmpvar_55;
        if ((tmpvar_54 < 0.0)) {
          tmpvar_55 = ((-(tmpvar_52) + sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
        } else {
          tmpvar_55 = tmpvar_54;
        };
        tmpvar_50 = tmpvar_55;
      };
      if ((tmpvar_50 != -1.0)) {
        int j_56;
        int i_57;
        vec3 worldPos_58;
        worldPos_58 = (tmpvar_6 + (tmpvar_7 * tmpvar_50));
        i_57 = 0;
        while (true) {
          if ((i_57 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_57] <= 0.0)) {
            break;
          };
          vec4 v_59;
          v_59.x = lightOccluders1[0][i_57];
          v_59.y = lightOccluders1[1][i_57];
          v_59.z = lightOccluders1[2][i_57];
          v_59.w = lightOccluders1[3][i_57];
          vec3 sphereDirection_60;
          vec3 lightDirection_61;
          vec3 tmpvar_62;
          tmpvar_62 = (sunPosAndRadius.xyz - worldPos_58);
          float tmpvar_63;
          tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
          lightDirection_61 = (tmpvar_62 / vec3(tmpvar_63));
          vec3 tmpvar_64;
          tmpvar_64 = (v_59.xyz - worldPos_58);
          float tmpvar_65;
          tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
          sphereDirection_60 = (tmpvar_64 / tmpvar_65);
          vec3 tmpvar_66;
          tmpvar_66 = ((lightDirection_61.yzx * sphereDirection_60.zxy) - (lightDirection_61.zxy * sphereDirection_60.yzx));
          float tmpvar_67;
          tmpvar_67 = min (1.0, sqrt(dot (tmpvar_66, tmpvar_66)));
          float tmpvar_68;
          tmpvar_68 = min (1.0, (vec3(lightOccluders1[3][i_57]) / tmpvar_65).x);
          float tmpvar_69;
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
          float tmpvar_70;
          tmpvar_70 = clamp ((dot (lightDirection_61, sphereDirection_60) / 0.2), 0.0, 1.0);
          eclipseShadow_49 = (eclipseShadow_49 * (1.0 - (
            (tmpvar_69 * (tmpvar_69 * (3.0 - (2.0 * tmpvar_69))))
           * 
            (tmpvar_70 * (tmpvar_70 * (3.0 - (2.0 * tmpvar_70))))
          )));
          i_57++;
        };
        j_56 = 0;
        while (true) {
          if ((j_56 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_56] <= 0.0)) {
            break;
          };
          vec4 v_71;
          v_71.x = lightOccluders2[0][j_56];
          v_71.y = lightOccluders2[1][j_56];
          v_71.z = lightOccluders2[2][j_56];
          v_71.w = lightOccluders2[3][j_56];
          vec3 sphereDirection_72;
          vec3 lightDirection_73;
          vec3 tmpvar_74;
          tmpvar_74 = (sunPosAndRadius.xyz - worldPos_58);
          float tmpvar_75;
          tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
          lightDirection_73 = (tmpvar_74 / vec3(tmpvar_75));
          vec3 tmpvar_76;
          tmpvar_76 = (v_71.xyz - worldPos_58);
          float tmpvar_77;
          tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
          sphereDirection_72 = (tmpvar_76 / tmpvar_77);
          vec3 tmpvar_78;
          tmpvar_78 = ((lightDirection_73.yzx * sphereDirection_72.zxy) - (lightDirection_73.zxy * sphereDirection_72.yzx));
          float tmpvar_79;
          tmpvar_79 = min (1.0, sqrt(dot (tmpvar_78, tmpvar_78)));
          float tmpvar_80;
          tmpvar_80 = min (1.0, (vec3(lightOccluders2[3][j_56]) / tmpvar_77).x);
          float tmpvar_81;
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
          float tmpvar_82;
          tmpvar_82 = clamp ((dot (lightDirection_73, sphereDirection_72) / 0.2), 0.0, 1.0);
          eclipseShadow_49 = (eclipseShadow_49 * (1.0 - (
            (tmpvar_81 * (tmpvar_81 * (3.0 - (2.0 * tmpvar_81))))
           * 
            (tmpvar_82 * (tmpvar_82 * (3.0 - (2.0 * tmpvar_82))))
          )));
          j_56++;
        };
      };
      extinction_5 = (extinction_5 * eclipseShadow_49);
      extinction_5 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_5));
    };
    vec4 tmpvar_83;
    tmpvar_83.w = 1.0;
    tmpvar_83.xyz = extinction_5;
    tmpvar_1 = tmpvar_83;
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
// Stats: 446 math, 1 textures, 19 branches
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
  tmpvar_6 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_6 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_4 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_7));
  rMu_3 = tmpvar_10;
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt(
    (((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_11 > 0.0)) {
    rMu_3 = (tmpvar_10 + tmpvar_11);
    mu_2 = (rMu_3 / xlat_mutableRt);
    r_4 = xlat_mutableRt;
  };
  if ((r_4 > xlat_mutableRt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      highp float tmpvar_23;
      if ((tmpvar_22 < 0.0)) {
        tmpvar_23 = -1.0;
      } else {
        tmpvar_23 = ((-(tmpvar_21) - sqrt(tmpvar_22)) / (2.0 * tmpvar_20));
      };
      highp float tmpvar_24;
      tmpvar_24 = (tmpvar_19 - tmpvar_23);
      highp float tmpvar_25;
      highp float H_26;
      H_26 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_27;
      tmpvar_27.x = mu_2;
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_4));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt((
        (0.5 / H_26)
       * r_4)) * tmpvar_27);
      highp vec2 tmpvar_29;
      tmpvar_29 = sign(tmpvar_28);
      highp vec2 tmpvar_30;
      tmpvar_30 = (tmpvar_28 * tmpvar_28);
      highp float tmpvar_31;
      if ((tmpvar_29.y > tmpvar_29.x)) {
        tmpvar_31 = exp(tmpvar_30.x);
      } else {
        tmpvar_31 = 0.0;
      };
      highp vec2 tmpvar_32;
      tmpvar_32.x = 1.0;
      tmpvar_32.y = exp(((
        -(tmpvar_24)
       / H_26) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      tmpvar_25 = ((sqrt(
        ((6.2831 * H_26) * r_4)
      ) * exp(
        ((Rg - r_4) / H_26)
      )) * (tmpvar_31 + dot (
        ((tmpvar_29 / ((2.3193 * 
          abs(tmpvar_28)
        ) + sqrt(
          ((1.52 * tmpvar_30) + 4.0)
        ))) * tmpvar_32)
      , vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_4));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt((
        (0.5 / H_33)
       * r_4)) * tmpvar_34);
      highp vec2 tmpvar_36;
      tmpvar_36 = sign(tmpvar_35);
      highp vec2 tmpvar_37;
      tmpvar_37 = (tmpvar_35 * tmpvar_35);
      highp float tmpvar_38;
      if ((tmpvar_36.y > tmpvar_36.x)) {
        tmpvar_38 = exp(tmpvar_37.x);
      } else {
        tmpvar_38 = 0.0;
      };
      highp vec2 tmpvar_39;
      tmpvar_39.x = 1.0;
      tmpvar_39.y = exp(((
        -(tmpvar_24)
       / H_33) * (
        (tmpvar_24 / (2.0 * r_4))
       + mu_2)));
      extinction_5 = exp(((
        -(betaR)
       * tmpvar_25) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_33)
         * r_4)) * exp((
          (Rg - r_4)
         / H_33))) * (tmpvar_38 + dot ((
          (tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt((
            (1.52 * tmpvar_37)
           + 4.0))))
         * tmpvar_39), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_42;
      tmpvar_42 = (min (abs(y_over_x_41), 1.0) / max (abs(y_over_x_41), 1.0));
      highp float tmpvar_43;
      tmpvar_43 = (tmpvar_42 * tmpvar_42);
      tmpvar_43 = (((
        ((((
          ((((-0.01213232 * tmpvar_43) + 0.05368138) * tmpvar_43) - 0.1173503)
         * tmpvar_43) + 0.1938925) * tmpvar_43) - 0.3326756)
       * tmpvar_43) + 0.9999793) * tmpvar_42);
      tmpvar_43 = (tmpvar_43 + (float(
        (abs(y_over_x_41) > 1.0)
      ) * (
        (tmpvar_43 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_44;
      tmpvar_44.zw = vec2(0.0, 0.0);
      tmpvar_44.x = ((tmpvar_43 * sign(y_over_x_41)) / 1.5);
      tmpvar_44.y = sqrt(((r_4 - Rg) / (xlat_mutableRt - Rg)));
      lowp vec4 tmpvar_45;
      tmpvar_45 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_44.xy, 0.0);
      tmpvar_40 = tmpvar_45.xyz;
      extinction_5 = tmpvar_40;
    };
    extinction_5 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_5) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_5.x + extinction_5.y) + extinction_5.z) / 3.0)
    ))));
    highp float tmpvar_46;
    tmpvar_46 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_47;
    tmpvar_47 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
    highp float tmpvar_48;
    tmpvar_48 = ((tmpvar_47 * tmpvar_47) - ((4.0 * tmpvar_46) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_49;
    if ((tmpvar_48 < 0.0)) {
      tmpvar_49 = -1.0;
    } else {
      tmpvar_49 = ((-(tmpvar_47) - sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    };
    bool tmpvar_50;
    tmpvar_50 = (tmpvar_49 > 0.0);
    if (!(tmpvar_50)) {
      extinction_5 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_5));
    } else {
      highp float eclipseShadow_51;
      eclipseShadow_51 = 1.0;
      highp float tmpvar_52;
      highp float tmpvar_53;
      tmpvar_53 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_54;
      tmpvar_54 = (2.0 * dot (tmpvar_7, (tmpvar_6 - _Globals_Origin)));
      highp float tmpvar_55;
      tmpvar_55 = ((tmpvar_54 * tmpvar_54) - ((4.0 * tmpvar_53) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_6, tmpvar_6)) - (2.0 * dot (_Globals_Origin, tmpvar_6)))
       - 
        (xlat_mutableRt * xlat_mutableRt)
      )));
      if ((tmpvar_55 < 0.0)) {
        tmpvar_52 = -1.0;
      } else {
        highp float tmpvar_56;
        tmpvar_56 = ((-(tmpvar_54) - sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
        highp float tmpvar_57;
        if ((tmpvar_56 < 0.0)) {
          tmpvar_57 = ((-(tmpvar_54) + sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
        } else {
          tmpvar_57 = tmpvar_56;
        };
        tmpvar_52 = tmpvar_57;
      };
      if ((tmpvar_52 != -1.0)) {
        highp int j_58;
        highp int i_59;
        highp vec3 worldPos_60;
        worldPos_60 = (tmpvar_6 + (tmpvar_7 * tmpvar_52));
        i_59 = 0;
        while (true) {
          if ((i_59 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_59] <= 0.0)) {
            break;
          };
          highp vec4 v_61;
          v_61.x = lightOccluders1[0][i_59];
          v_61.y = lightOccluders1[1][i_59];
          v_61.z = lightOccluders1[2][i_59];
          v_61.w = lightOccluders1[3][i_59];
          highp vec3 sphereDirection_62;
          highp vec3 lightDirection_63;
          highp vec3 tmpvar_64;
          tmpvar_64 = (sunPosAndRadius.xyz - worldPos_60);
          highp float tmpvar_65;
          tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
          lightDirection_63 = (tmpvar_64 / vec3(tmpvar_65));
          highp vec3 tmpvar_66;
          tmpvar_66 = (v_61.xyz - worldPos_60);
          highp float tmpvar_67;
          tmpvar_67 = sqrt(dot (tmpvar_66, tmpvar_66));
          sphereDirection_62 = (tmpvar_66 / tmpvar_67);
          highp vec3 tmpvar_68;
          tmpvar_68 = ((lightDirection_63.yzx * sphereDirection_62.zxy) - (lightDirection_63.zxy * sphereDirection_62.yzx));
          highp float tmpvar_69;
          tmpvar_69 = min (1.0, sqrt(dot (tmpvar_68, tmpvar_68)));
          highp float tmpvar_70;
          tmpvar_70 = min (1.0, (vec3(lightOccluders1[3][i_59]) / tmpvar_67).x);
          highp float tmpvar_71;
          tmpvar_71 = clamp (((
            (-((vec3(tmpvar_65) * (
              (sign(tmpvar_69) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_69))
              ) * (1.570796 + 
                (abs(tmpvar_69) * (-0.2146018 + (abs(tmpvar_69) * (0.08656672 + 
                  (abs(tmpvar_69) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_70) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_70))
              ) * (1.570796 + 
                (abs(tmpvar_70) * (-0.2146018 + (abs(tmpvar_70) * (0.08656672 + 
                  (abs(tmpvar_70) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_72;
          tmpvar_72 = clamp ((dot (lightDirection_63, sphereDirection_62) / 0.2), 0.0, 1.0);
          eclipseShadow_51 = (eclipseShadow_51 * (1.0 - (
            (tmpvar_71 * (tmpvar_71 * (3.0 - (2.0 * tmpvar_71))))
           * 
            (tmpvar_72 * (tmpvar_72 * (3.0 - (2.0 * tmpvar_72))))
          )));
          i_59++;
        };
        j_58 = 0;
        while (true) {
          if ((j_58 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_58] <= 0.0)) {
            break;
          };
          highp vec4 v_73;
          v_73.x = lightOccluders2[0][j_58];
          v_73.y = lightOccluders2[1][j_58];
          v_73.z = lightOccluders2[2][j_58];
          v_73.w = lightOccluders2[3][j_58];
          highp vec3 sphereDirection_74;
          highp vec3 lightDirection_75;
          highp vec3 tmpvar_76;
          tmpvar_76 = (sunPosAndRadius.xyz - worldPos_60);
          highp float tmpvar_77;
          tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
          lightDirection_75 = (tmpvar_76 / vec3(tmpvar_77));
          highp vec3 tmpvar_78;
          tmpvar_78 = (v_73.xyz - worldPos_60);
          highp float tmpvar_79;
          tmpvar_79 = sqrt(dot (tmpvar_78, tmpvar_78));
          sphereDirection_74 = (tmpvar_78 / tmpvar_79);
          highp vec3 tmpvar_80;
          tmpvar_80 = ((lightDirection_75.yzx * sphereDirection_74.zxy) - (lightDirection_75.zxy * sphereDirection_74.yzx));
          highp float tmpvar_81;
          tmpvar_81 = min (1.0, sqrt(dot (tmpvar_80, tmpvar_80)));
          highp float tmpvar_82;
          tmpvar_82 = min (1.0, (vec3(lightOccluders2[3][j_58]) / tmpvar_79).x);
          highp float tmpvar_83;
          tmpvar_83 = clamp (((
            (-((vec3(tmpvar_77) * (
              (sign(tmpvar_81) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_81))
              ) * (1.570796 + 
                (abs(tmpvar_81) * (-0.2146018 + (abs(tmpvar_81) * (0.08656672 + 
                  (abs(tmpvar_81) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_82) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_82))
              ) * (1.570796 + 
                (abs(tmpvar_82) * (-0.2146018 + (abs(tmpvar_82) * (0.08656672 + 
                  (abs(tmpvar_82) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_84;
          tmpvar_84 = clamp ((dot (lightDirection_75, sphereDirection_74) / 0.2), 0.0, 1.0);
          eclipseShadow_51 = (eclipseShadow_51 * (1.0 - (
            (tmpvar_83 * (tmpvar_83 * (3.0 - (2.0 * tmpvar_83))))
           * 
            (tmpvar_84 * (tmpvar_84 * (3.0 - (2.0 * tmpvar_84))))
          )));
          j_58++;
        };
      };
      extinction_5 = (extinction_5 * eclipseShadow_51);
      extinction_5 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_5));
    };
    highp vec4 tmpvar_85;
    tmpvar_85.w = 1.0;
    tmpvar_85.xyz = extinction_5;
    tmpvar_1 = tmpvar_85;
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
highp vec2 t2;
highp int ti2;
bool tb2;
highp vec3 t3;
highp vec2 t4;
highp vec3 t5;
highp vec4 t6;
highp ivec2 ti6;
highp vec2 t7;
highp ivec2 ti7;
highp vec3 t8;
highp float t11;
highp int ti11;
bool tb11;
highp float t12;
highp vec3 t13;
bool tb13;
highp float t20;
bool tb20;
highp float t21;
bool tb21;
highp float t22;
bool tb22;
highp vec2 t23;
highp ivec2 ti23;
bool tb23;
highp vec2 t25;
highp ivec2 ti25;
highp float t27;
bool tb27;
highp float t28;
bool tb28;
highp float t29;
bool tb29;
highp float t30;
highp float t31;
bool tb31;
highp float t32;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t27 = dot(t1.xyz, t1.xyz);
    t27 = inversesqrt(t27);
    t1.xyz = vec3(t27) * t1.xyz;
    t27 = (-Rg) + Rt;
    t28 = t27 * _experimentalAtmoScale;
    t2.x = t27 * _experimentalAtmoScale + Rg;
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t27 = dot(t3.xyz, t3.xyz);
    t4.x = sqrt(t27);
    t20 = dot(t3.xyz, t1.xyz);
    t4.y = t20 / t4.x;
    t27 = t20 * t20 + (-t27);
    t27 = t2.x * t2.x + t27;
    t27 = sqrt(t27);
    t27 = (-t27) + (-t20);
    t27 = max(t27, 0.0);
    tb29 = 0.0<t27;
    t27 = t27 + t20;
    t2.y = t27 / t2.x;
    t3.xy = (bool(tb29)) ? t2.xy : t4.xy;
    tb27 = t2.x<t3.x;
    if(tb27){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t27 = dot(t1.xyz, t1.xyz);
    t11 = t20 + t20;
    t29 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t30 = dot(t0.xyz, t0.xyz);
    t29 = t29 + t30;
    t30 = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t29 = (-t30) * 2.0 + t29;
    t30 = (-Rg) * Rg + t29;
    t11 = t11 * t11;
    t4.x = t27 * 4.0;
    t30 = (-t4.x) * t30 + t11;
    tb13 = t30<0.0;
    t30 = sqrt(t30);
    t30 = (-t20) * 2.0 + (-t30);
    t27 = t27 + t27;
    t30 = t30 / t27;
    t30 = (tb13) ? -1.0 : t30;
    tb13 = 0.0<t30;
    if(tb13){
        t13.x = (-t2.x) * t2.x + t29;
        t13.x = (-t4.x) * t13.x + t11;
        tb22 = t13.x<0.0;
        t13.x = sqrt(t13.x);
        t13.x = (-t20) * 2.0 + (-t13.x);
        t13.x = t13.x / t27;
        t13.x = (tb22) ? 1.0 : (-t13.x);
        t13.x = t30 + t13.x;
        t22 = HR * _experimentalAtmoScale;
        t31 = 0.5 / t22;
        t31 = t3.x * t31;
        t31 = sqrt(t31);
        t5.x = t13.x / t3.x;
        t3.z = t3.y + t5.x;
        t5.xy = vec2(t3.y * float(t31), t3.z * float(t31));
        ti23.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t5.xyxy).xy) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t5.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti23.xy = (-ti23.xy) + ti6.xy;
        t23.xy = vec2(ti23.xy);
        t6.xyz = t5.xxy * t5.xxy;
        tb31 = t23.x<t23.y;
        t6.x = t6.x * 1.44269502;
        t6.x = exp2(t6.x);
        t31 = tb31 ? t6.x : float(0.0);
        t6.xy = t6.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t5.xy = abs(t5.xy) * vec2(2.31929994, 2.31929994) + t6.xy;
        t5.xy = t23.xy / t5.xy;
        t23.x = (-t13.x) / t22;
        t32 = t3.x + t3.x;
        t32 = t13.x / t32;
        t32 = t3.y + t32;
        t23.x = t32 * t23.x;
        t23.x = t23.x * 1.44269502;
        t6.y = exp2(t23.x);
        t6.xz = vec2(1.0, 1.0);
        t5.xy = t5.xy * t6.xy;
        t23.x = t3.x * t22;
        t23.x = t23.x * 6.28310013;
        t23.x = sqrt(t23.x);
        t6.x = (-t3.x) + Rg;
        t22 = t6.x / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t23.x;
        t5.x = dot(t5.xy, vec2(1.0, -1.0));
        t31 = t31 + t5.x;
        t22 = t31 * t22;
        t31 = HM * _experimentalAtmoScale;
        t5.x = 0.5 / t31;
        t5.x = t3.x * t5.x;
        t5.x = sqrt(t5.x);
        t5.xy = vec2(t3.y * t5.x, t3.z * t5.x);
        ti7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t5.xyxx).xy) * 0xFFFFFFFFu);
        ti25.xy = ivec2(uvec2(lessThan(t5.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti7.xy = (-ti7.xy) + ti25.xy;
        t7.xy = vec2(ti7.xy);
        t8.xyz = t5.xxy * t5.xxy;
        tb21 = t7.x<t7.y;
        t23.x = t8.x * 1.44269502;
        t23.x = exp2(t23.x);
        t21 = tb21 ? t23.x : float(0.0);
        t25.xy = t8.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t25.xy = sqrt(t25.xy);
        t5.xy = abs(t5.xy) * vec2(2.31929994, 2.31929994) + t25.xy;
        t5.xy = t7.xy / t5.xy;
        t13.x = (-t13.x) / t31;
        t13.x = t32 * t13.x;
        t13.x = t13.x * 1.44269502;
        t6.w = exp2(t13.x);
        t5.xy = vec2(t5.x * t6.z, t5.y * t6.w);
        t13.x = t3.x * t31;
        t13.x = t13.x * 6.28310013;
        t13.x = sqrt(t13.x);
        t31 = t6.x / t31;
        t31 = t31 * 1.44269502;
        t31 = exp2(t31);
        t13.x = t31 * t13.x;
        t31 = dot(t5.xy, vec2(1.0, -1.0));
        t21 = t21 + t31;
        t21 = t21 * t13.x;
        t5.xyz = vec3(t21) * betaMEx.xyzx.xyz;
        t13.xyz = (-betaR.xyzx.xyz) * vec3(t22) + (-t5.xyz);
        t13.xyz = t13.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t13.xyz = exp2(t13.xyz);
    } else {
        t3.x = t3.x + (-Rg);
        t28 = t3.x / t28;
        t5.y = sqrt(t28);
        t28 = t3.y + 0.150000006;
        t28 = t28 * 12.262105;
        t3.x = min(abs(t28), 1.0);
        t12 = max(abs(t28), 1.0);
        t12 = float(1.0) / t12;
        t3.x = t12 * t3.x;
        t12 = t3.x * t3.x;
        t21 = t12 * 0.0208350997 + -0.0851330012;
        t21 = t12 * t21 + 0.180141002;
        t21 = t12 * t21 + -0.330299497;
        t12 = t12 * t21 + 0.999866009;
        t21 = t12 * t3.x;
        tb23 = 1.0<abs(t28);
        t21 = t21 * -2.0 + 1.57079637;
        t21 = tb23 ? t21 : float(0.0);
        t3.x = t3.x * t12 + t21;
        t28 = min(t28, 1.0);
        tb28 = t28<(-t28);
        t28 = (tb28) ? (-t3.x) : t3.x;
        t5.x = t28 * 0.666666687;
        t13.xyz = textureLod(_Transmittance, t5.xy, 0.0).xyz;
    //ENDIF
    }
    t28 = t13.y + t13.x;
    t28 = t13.z + t28;
    t28 = t28 * 0.333333343;
    t3.x = (-_Extinction_Tint) + 1.0;
    t28 = t28 * t3.x;
    t3.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t13.xyz + vec3(t28);
    t3.xyz = t3.xyz * vec3(extinctionMultiplier);
    tb28 = 0.0>=t30;
    if(tb28){
        t28 = (-extinctionRimFade) + 1.0;
        t13.xyz = vec3(t28) * t3.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t28 = (-t2.x) * t2.x + t29;
        t28 = (-t4.x) * t28 + t11;
        tb2 = t28>=0.0;
        t28 = sqrt(t28);
        t11 = (-t20) * 2.0 + (-t28);
        t11 = t11 / t27;
        tb29 = t11<0.0;
        t28 = (-t20) * 2.0 + t28;
        t27 = t28 / t27;
        t27 = (tb29) ? t27 : t11;
        t27 = (tb2) ? t27 : -1.0;
        tb28 = t27!=-1.0;
        if(tb28){
            t0.xyz = t1.xyz * vec3(t27) + t0.xyz;
            t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
            t27 = dot(t1.xyz, t1.xyz);
            t27 = sqrt(t27);
            t1.xyz = t1.xyz / vec3(t27);
            t28 = 1.0;
            ti2 = 0x0;
            while(true){
                tb11 = ti2>=0x4;
                if(tb11){break;}
                t11 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
                tb20 = 0.0>=t11;
                if(tb20){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
                t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
                t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t20 = dot(t5.xyz, t5.xyz);
                t20 = sqrt(t20);
                t5.xyz = t5.xyz / vec3(t20);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t29 = dot(t6.xyz, t6.xyz);
                t29 = sqrt(t29);
                t29 = min(t29, 1.0);
                t30 = (-t29) + 1.0;
                t30 = sqrt(t30);
                t4.x = t29 * -0.0187292993 + 0.0742610022;
                t4.x = t4.x * t29 + -0.212114394;
                t29 = t4.x * t29 + 1.57072878;
                t29 = (-t29) * t30 + 1.57079637;
                t11 = t11 / t20;
                t11 = min(t11, 1.0);
                t20 = -abs(t11) + 1.0;
                t20 = sqrt(t20);
                t30 = abs(t11) * -0.0187292993 + 0.0742610022;
                t30 = t30 * abs(t11) + -0.212114394;
                t30 = t30 * abs(t11) + 1.57072878;
                t4.x = t20 * t30;
                t4.x = t4.x * -2.0 + 3.14159274;
                tb11 = t11<(-t11);
                t11 = tb11 ? t4.x : float(0.0);
                t11 = t30 * t20 + t11;
                t11 = (-t11) + 1.57079637;
                t11 = (-t11) + t29;
                t11 = t27 * t11;
                t11 = (-t11) / sunPosAndRadius.w;
                t11 = t11 + 1.0;
                t11 = t11 * 0.5;
                t11 = clamp(t11, 0.0, 1.0);
                t20 = t11 * -2.0 + 3.0;
                t11 = t11 * t11;
                t11 = t11 * t20;
                t20 = dot(t1.xyz, t5.xyz);
                t20 = t20 * 5.0;
                t20 = clamp(t20, 0.0, 1.0);
                t29 = t20 * -2.0 + 3.0;
                t20 = t20 * t20;
                t20 = t20 * t29;
                t11 = (-t11) * t20 + 1.0;
                t28 = t28 * t11;
                ti2 = ti2 + 0x1;
            }
            t2.x = t28;
            ti11 = 0x0;
            while(true){
                tb20 = ti11>=0x4;
                if(tb20){break;}
                t20 = dot(lightOccluders2[3], immediateConstBufferF[ti11]);
                tb29 = 0.0>=t20;
                if(tb29){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti11]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti11]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti11]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t29 = dot(t5.xyz, t5.xyz);
                t29 = sqrt(t29);
                t5.xyz = t5.xyz / vec3(t29);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t30 = dot(t6.xyz, t6.xyz);
                t30 = sqrt(t30);
                t30 = min(t30, 1.0);
                t4.x = (-t30) + 1.0;
                t4.x = sqrt(t4.x);
                t32 = t30 * -0.0187292993 + 0.0742610022;
                t32 = t32 * t30 + -0.212114394;
                t30 = t32 * t30 + 1.57072878;
                t30 = (-t30) * t4.x + 1.57079637;
                t20 = t20 / t29;
                t20 = min(t20, 1.0);
                t29 = -abs(t20) + 1.0;
                t29 = sqrt(t29);
                t4.x = abs(t20) * -0.0187292993 + 0.0742610022;
                t4.x = t4.x * abs(t20) + -0.212114394;
                t4.x = t4.x * abs(t20) + 1.57072878;
                t32 = t29 * t4.x;
                t32 = t32 * -2.0 + 3.14159274;
                tb20 = t20<(-t20);
                t20 = tb20 ? t32 : float(0.0);
                t20 = t4.x * t29 + t20;
                t20 = (-t20) + 1.57079637;
                t20 = (-t20) + t30;
                t20 = t27 * t20;
                t20 = (-t20) / sunPosAndRadius.w;
                t20 = t20 + 1.0;
                t20 = t20 * 0.5;
                t20 = clamp(t20, 0.0, 1.0);
                t29 = t20 * -2.0 + 3.0;
                t20 = t20 * t20;
                t20 = t20 * t29;
                t29 = dot(t1.xyz, t5.xyz);
                t29 = t29 * 5.0;
                t29 = clamp(t29, 0.0, 1.0);
                t30 = t29 * -2.0 + 3.0;
                t29 = t29 * t29;
                t29 = t29 * t30;
                t20 = (-t20) * t29 + 1.0;
                t2.x = t20 * t2.x;
                ti11 = ti11 + 0x1;
            }
        } else {
            t2.x = 1.0;
        //ENDIF
        }
        t0.xyz = t2.xxx * t3.xyz;
        t27 = (-extinctionGroundFade) + 1.0;
        t13.xyz = vec3(t27) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t13.xyz;
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
vec2 t2;
int ti2;
bool tb2;
vec3 t3;
vec2 t4;
vec4 t5;
vec4 t6;
ivec2 ti6;
vec2 t7;
ivec2 ti7;
vec3 t8;
float t11;
int ti11;
bool tb11;
float t12;
vec3 t13;
bool tb13;
float t20;
bool tb20;
float t21;
bool tb21;
float t22;
bool tb22;
vec2 t23;
ivec2 ti23;
vec2 t25;
ivec2 ti25;
float t27;
bool tb27;
float t28;
bool tb28;
float t29;
bool tb29;
float t30;
float t31;
bool tb31;
float t32;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t27 = dot(t1.xyz, t1.xyz);
    t27 = inversesqrt(t27);
    t1.xyz = vec3(t27) * t1.xyz;
    t27 = (-Rg) + Rt;
    t28 = t27 * _experimentalAtmoScale;
    t2.x = t27 * _experimentalAtmoScale + Rg;
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t27 = dot(t3.xyz, t3.xyz);
    t4.x = sqrt(t27);
    t20 = dot(t3.xyz, t1.xyz);
    t4.y = t20 / t4.x;
    t27 = t20 * t20 + (-t27);
    t27 = t2.x * t2.x + t27;
    t27 = sqrt(t27);
    t27 = (-t27) + (-t20);
    t27 = max(t27, 0.0);
    tb29 = 0.0<t27;
    t27 = t27 + t20;
    t2.y = t27 / t2.x;
    t3.xy = (bool(tb29)) ? t2.xy : t4.xy;
    tb27 = t2.x<t3.x;
    if(tb27){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t27 = dot(t1.xyz, t1.xyz);
    t11 = t20 + t20;
    t29 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t30 = dot(t0.xyz, t0.xyz);
    t29 = t29 + t30;
    t30 = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t29 = (-t30) * 2.0 + t29;
    t30 = (-Rg) * Rg + t29;
    t11 = t11 * t11;
    t4.x = t27 * 4.0;
    t30 = (-t4.x) * t30 + t11;
    tb13 = t30<0.0;
    t30 = sqrt(t30);
    t30 = (-t20) * 2.0 + (-t30);
    t27 = t27 + t27;
    t30 = t30 / t27;
    t30 = (tb13) ? -1.0 : t30;
    tb13 = 0.0<t30;
    if(tb13){
        t13.x = (-t2.x) * t2.x + t29;
        t13.x = (-t4.x) * t13.x + t11;
        tb22 = t13.x<0.0;
        t13.x = sqrt(t13.x);
        t13.x = (-t20) * 2.0 + (-t13.x);
        t13.x = t13.x / t27;
        t13.x = (tb22) ? 1.0 : (-t13.x);
        t13.x = t30 + t13.x;
        t22 = HR * _experimentalAtmoScale;
        t31 = 0.5 / t22;
        t31 = t3.x * t31;
        t31 = sqrt(t31);
        t5.x = t13.x / t3.x;
        t3.z = t3.y + t5.x;
        t5.xy = t3.yz * vec2(t31);
        ti23.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t5.xyxy).xy) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t5.xyxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti23.xy = (-ti23.xy) + ti6.xy;
        t23.xy = vec2(ti23.xy);
        t6.xyz = t5.xxy * t5.xxy;
        tb31 = t23.x<t23.y;
        t6.x = t6.x * 1.44269502;
        t6.x = exp2(t6.x);
        t31 = tb31 ? t6.x : float(0.0);
        t6.xy = t6.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t5.xy = abs(t5.xy) * vec2(2.31929994, 2.31929994) + t6.xy;
        t5.xy = t23.xy / t5.xy;
        t23.x = (-t13.x) / t22;
        t32 = t3.x + t3.x;
        t32 = t13.x / t32;
        t32 = t3.y + t32;
        t23.x = t32 * t23.x;
        t23.x = t23.x * 1.44269502;
        t6.y = exp2(t23.x);
        t6.xz = vec2(1.0, 1.0);
        t5.xy = t5.xy * t6.xy;
        t23.x = t3.x * t22;
        t23.x = t23.x * 6.28310013;
        t23.x = sqrt(t23.x);
        t6.x = (-t3.x) + Rg;
        t22 = t6.x / t22;
        t22 = t22 * 1.44269502;
        t22 = exp2(t22);
        t22 = t22 * t23.x;
        t5.x = dot(t5.xy, vec2(1.0, -1.0));
        t31 = t31 + t5.x;
        t22 = t31 * t22;
        t31 = HM * _experimentalAtmoScale;
        t5.x = 0.5 / t31;
        t5.x = t3.x * t5.x;
        t5.x = sqrt(t5.x);
        t5.xy = t3.yz * t5.xx;
        ti7.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t5.xyxx).xy) * 0xFFFFFFFFu);
        ti25.xy = ivec2(uvec2(lessThan(t5.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti7.xy = (-ti7.xy) + ti25.xy;
        t7.xy = vec2(ti7.xy);
        t8.xyz = t5.xxy * t5.xxy;
        tb21 = t7.x<t7.y;
        t23.x = t8.x * 1.44269502;
        t23.x = exp2(t23.x);
        t21 = tb21 ? t23.x : float(0.0);
        t25.xy = t8.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t25.xy = sqrt(t25.xy);
        t5.xy = abs(t5.xy) * vec2(2.31929994, 2.31929994) + t25.xy;
        t5.xy = t7.xy / t5.xy;
        t13.x = (-t13.x) / t31;
        t13.x = t32 * t13.x;
        t13.x = t13.x * 1.44269502;
        t6.w = exp2(t13.x);
        t5.xy = t5.xy * t6.zw;
        t13.x = t3.x * t31;
        t13.x = t13.x * 6.28310013;
        t13.x = sqrt(t13.x);
        t31 = t6.x / t31;
        t31 = t31 * 1.44269502;
        t31 = exp2(t31);
        t13.x = t31 * t13.x;
        t31 = dot(t5.xy, vec2(1.0, -1.0));
        t21 = t21 + t31;
        t21 = t21 * t13.x;
        t5.xyz = vec3(t21) * betaMEx.xyzx.xyz;
        t13.xyz = (-betaR.xyzx.xyz) * vec3(t22) + (-t5.xyz);
        t13.xyz = t13.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t5.xyz = exp2(t13.xyz);
    } else {
        t3.x = t3.x + (-Rg);
        t28 = t3.x / t28;
        t6.y = sqrt(t28);
        t28 = t3.y + 0.150000006;
        t28 = t28 * 12.262105;
        t3.x = min(abs(t28), 1.0);
        t12 = max(abs(t28), 1.0);
        t12 = float(1.0) / t12;
        t3.x = t12 * t3.x;
        t12 = t3.x * t3.x;
        t21 = t12 * 0.0208350997 + -0.0851330012;
        t21 = t12 * t21 + 0.180141002;
        t21 = t12 * t21 + -0.330299497;
        t12 = t12 * t21 + 0.999866009;
        t21 = t12 * t3.x;
        tb13 = 1.0<abs(t28);
        t21 = t21 * -2.0 + 1.57079637;
        t21 = tb13 ? t21 : float(0.0);
        t3.x = t3.x * t12 + t21;
        t28 = min(t28, 1.0);
        tb28 = t28<(-t28);
        t28 = (tb28) ? (-t3.x) : t3.x;
        t6.x = t28 * 0.666666687;
        t5 = textureLod(_Transmittance, t6.xy, 0.0);
    //ENDIF
    }
    t28 = t5.y + t5.x;
    t28 = t5.z + t28;
    t28 = t28 * 0.333333343;
    t3.x = (-_Extinction_Tint) + 1.0;
    t28 = t28 * t3.x;
    t3.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t5.xyz + vec3(t28);
    t3.xyz = t3.xyz * vec3(extinctionMultiplier);
    tb28 = 0.0>=t30;
    if(tb28){
        t28 = (-extinctionRimFade) + 1.0;
        t13.xyz = vec3(t28) * t3.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t28 = (-t2.x) * t2.x + t29;
        t28 = (-t4.x) * t28 + t11;
        tb2 = t28>=0.0;
        t28 = sqrt(t28);
        t11 = (-t20) * 2.0 + (-t28);
        t11 = t11 / t27;
        tb29 = t11<0.0;
        t28 = (-t20) * 2.0 + t28;
        t27 = t28 / t27;
        t27 = (tb29) ? t27 : t11;
        t27 = (tb2) ? t27 : -1.0;
        tb28 = t27!=-1.0;
        if(tb28){
            t0.xyz = t1.xyz * vec3(t27) + t0.xyz;
            t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
            t27 = dot(t1.xyz, t1.xyz);
            t27 = sqrt(t27);
            t1.xyz = t1.xyz / vec3(t27);
            t28 = 1.0;
            ti2 = 0x0;
            while(true){
                tb11 = ti2>=0x4;
                if(tb11){break;}
                t11 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
                tb20 = 0.0>=t11;
                if(tb20){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
                t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
                t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t20 = dot(t5.xyz, t5.xyz);
                t20 = sqrt(t20);
                t5.xyz = t5.xyz / vec3(t20);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t29 = dot(t6.xyz, t6.xyz);
                t29 = sqrt(t29);
                t29 = min(t29, 1.0);
                t30 = (-t29) + 1.0;
                t30 = sqrt(t30);
                t4.x = t29 * -0.0187292993 + 0.0742610022;
                t4.x = t4.x * t29 + -0.212114394;
                t29 = t4.x * t29 + 1.57072878;
                t29 = (-t29) * t30 + 1.57079637;
                t11 = t11 / t20;
                t11 = min(t11, 1.0);
                t20 = -abs(t11) + 1.0;
                t20 = sqrt(t20);
                t30 = abs(t11) * -0.0187292993 + 0.0742610022;
                t30 = t30 * abs(t11) + -0.212114394;
                t30 = t30 * abs(t11) + 1.57072878;
                t4.x = t20 * t30;
                t4.x = t4.x * -2.0 + 3.14159274;
                tb11 = t11<(-t11);
                t11 = tb11 ? t4.x : float(0.0);
                t11 = t30 * t20 + t11;
                t11 = (-t11) + 1.57079637;
                t11 = (-t11) + t29;
                t11 = t27 * t11;
                t11 = (-t11) / sunPosAndRadius.w;
                t11 = t11 + 1.0;
                t11 = t11 * 0.5;
                t11 = clamp(t11, 0.0, 1.0);
                t20 = t11 * -2.0 + 3.0;
                t11 = t11 * t11;
                t11 = t11 * t20;
                t20 = dot(t1.xyz, t5.xyz);
                t20 = t20 * 5.0;
                t20 = clamp(t20, 0.0, 1.0);
                t29 = t20 * -2.0 + 3.0;
                t20 = t20 * t20;
                t20 = t20 * t29;
                t11 = (-t11) * t20 + 1.0;
                t28 = t28 * t11;
                ti2 = ti2 + 0x1;
            }
            t2.x = t28;
            ti11 = 0x0;
            while(true){
                tb20 = ti11>=0x4;
                if(tb20){break;}
                t20 = dot(lightOccluders2[3], immediateConstBufferF[ti11]);
                tb29 = 0.0>=t20;
                if(tb29){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti11]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti11]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti11]);
                t5.xyz = (-t0.xyz) + t5.xyz;
                t29 = dot(t5.xyz, t5.xyz);
                t29 = sqrt(t29);
                t5.xyz = t5.xyz / vec3(t29);
                t6.xyz = t1.zxy * t5.yzx;
                t6.xyz = t1.yzx * t5.zxy + (-t6.xyz);
                t30 = dot(t6.xyz, t6.xyz);
                t30 = sqrt(t30);
                t30 = min(t30, 1.0);
                t4.x = (-t30) + 1.0;
                t4.x = sqrt(t4.x);
                t32 = t30 * -0.0187292993 + 0.0742610022;
                t32 = t32 * t30 + -0.212114394;
                t30 = t32 * t30 + 1.57072878;
                t30 = (-t30) * t4.x + 1.57079637;
                t20 = t20 / t29;
                t20 = min(t20, 1.0);
                t29 = -abs(t20) + 1.0;
                t29 = sqrt(t29);
                t4.x = abs(t20) * -0.0187292993 + 0.0742610022;
                t4.x = t4.x * abs(t20) + -0.212114394;
                t4.x = t4.x * abs(t20) + 1.57072878;
                t32 = t29 * t4.x;
                t32 = t32 * -2.0 + 3.14159274;
                tb20 = t20<(-t20);
                t20 = tb20 ? t32 : float(0.0);
                t20 = t4.x * t29 + t20;
                t20 = (-t20) + 1.57079637;
                t20 = (-t20) + t30;
                t20 = t27 * t20;
                t20 = (-t20) / sunPosAndRadius.w;
                t20 = t20 + 1.0;
                t20 = t20 * 0.5;
                t20 = clamp(t20, 0.0, 1.0);
                t29 = t20 * -2.0 + 3.0;
                t20 = t20 * t20;
                t20 = t20 * t29;
                t29 = dot(t1.xyz, t5.xyz);
                t29 = t29 * 5.0;
                t29 = clamp(t29, 0.0, 1.0);
                t30 = t29 * -2.0 + 3.0;
                t29 = t29 * t29;
                t29 = t29 * t30;
                t20 = (-t20) * t29 + 1.0;
                t2.x = t20 * t2.x;
                ti11 = ti11 + 0x1;
            }
        } else {
            t2.x = 1.0;
        //ENDIF
        }
        t0.xyz = t2.xxx * t3.xyz;
        t27 = (-extinctionGroundFade) + 1.0;
        t13.xyz = vec3(t27) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t13.xyz;
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
// Stats: 190 math, 2 textures, 4 branches
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
def c12, 6000, -9.99999997e-007, 0, 2
def c13, 4, -1, 1, 0.5
def c14, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c15, 1.44269502, 1.51999998, 4, 2.31929994
def c16, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c17, -2, 1.57079637, 0.666666687, 0.333333343
def c18, 0, 1, -0, -1
dcl_texcoord v0.xyz
dcl_2d s0
mov r0.x, c12.x
mul r0.yzw, r0.x, c0.xxyz
add r1.xyz, -c0, v0
nrm r2.xyz, r1
mov r1.x, c5.x
add r1.y, -r1.x, c6.x
mul r1.z, r1.y, c7.x
mad r1.x, r1.y, c7.x, r1.x
mov r3.xyz, c8
mad r3.xyz, c0, r0.x, -r3
dp3 r0.x, r3, r3
rsq r0.x, r0.x
rcp r4.x, r0.x
dp3 r1.w, r3, r2
mul r4.y, r0.x, r1.w
mul r0.x, r4.x, r4.x
mad r0.x, r1.w, r1.w, -r0.x
mad r0.x, r1.x, r1.x, r0.x
rsq r2.w, r0.x
rcp r2.w, r2.w
cmp r0.x, r0.x, -r2.w, c12.y
add r0.x, r0.x, -r1.w
max r2.w, r0.x, c12.z
add r0.x, r1.w, r2.w
rcp r3.x, r1.x
mul r1.y, r0.x, r3.x
cmp r3.xy, -r2.w, r4, r1
if_lt r1.x, r3.x
mov r4.xyz, c13.z
else
dp3 r0.x, r2, r2
add r1.y, r1.w, r1.w
dp3 r2.x, c8, c8
dp3 r2.y, r0.yzww, r0.yzww
add r2.x, r2.y, r2.x
dp3 r0.y, c8, r0.yzww
mad r0.y, r0.y, -c12.w, r2.x
mad r0.z, c5.x, -c5.x, r0.y
mul r0.w, r1.y, r1.y
mul r1.y, r0.x, c13.x
mad r0.z, r1.y, -r0.z, r0.w
rsq r2.x, r0.z
rcp r2.x, r2.x
mad r2.x, r1.w, -c12.w, -r2.x
add r0.x, r0.x, r0.x
rcp r0.x, r0.x
mul r2.x, r0.x, r2.x
cmp r0.z, r0.z, r2.x, c13.y
if_lt -r0.z, c12.z
mad r0.y, r1.x, -r1.x, r0.y
mad r0.y, r1.y, -r0.y, r0.w
rsq r0.w, r0.y
rcp r0.w, r0.w
mad r0.w, r1.w, -c12.w, -r0.w
mul r0.x, r0.x, r0.w
cmp r0.x, r0.y, -r0.x, c13.z
add r0.x, r0.x, r0.z
mov r1.x, c7.x
mul r0.y, r1.x, c1.x
rcp r0.w, r0.y
mul r1.y, r0.w, r3.x
mul r1.y, r1.y, c13.w
rsq r1.y, r1.y
rcp r1.y, r1.y
rcp r1.w, r3.x
mad r3.z, r0.x, r1.w, r3.y
mul r1.yw, r1.y, r3.xyzz
cmp r2.xy, -r1.ywzw, c18.x, c18.y
cmp r2.zw, r1.xyyw, c18.z, c18.w
add r2.xy, r2.zwzw, r2
mul r5.xyz, r1.yyww, r1.yyww
add r2.z, -r2.y, r2.x
mul r2.w, r5.x, c15.x
exp r2.w, r2.w
cmp r2.z, r2.z, c12.z, r2.w
mad r5.xy, r5.yzzw, c15.y, c15.z
rsq r2.w, r5.x
rsq r3.w, r5.y
rcp r5.x, r2.w
rcp r5.y, r3.w
mad r1.yw, r1_abs, c15.w, r5.xxzy
rcp r5.x, r1.y
rcp r5.y, r1.w
mul r1.yw, r2.xxzy, r5.xxzy
mul r2.x, r0.w, -r0.x
add r2.y, r3.x, r3.x
rcp r2.y, r2.y
mad r2.y, r0.x, r2.y, r3.y
mul r2.x, r2.y, r2.x
mul r2.x, r2.x, c15.x
exp r5.y, r2.x
mov r5.xz, c13.z
mul r1.yw, r1, r5.xxzy
mul r0.y, r0.y, r3.x
mul r0.y, r0.y, c14.x
rsq r0.y, r0.y
rcp r0.y, r0.y
add r2.x, -r3.x, c5.x
mul r0.w, r0.w, r2.x
mul r0.w, r0.w, c15.x
exp r0.w, r0.w
mul r0.y, r0.w, r0.y
dp2add r0.w, r1.ywzw, c13.zyzw, r2.z
mul r0.y, r0.w, r0.y
mul r0.w, r1.x, c3.x
rcp r1.x, r0.w
mul r1.y, r1.x, r3.x
mul r1.y, r1.y, c13.w
rsq r1.y, r1.y
rcp r1.y, r1.y
mul r1.yw, r3.xyzz, r1.y
cmp r2.zw, -r1.xyyw, c18.x, c18.y
cmp r3.zw, r1.xyyw, c18.z, c18.w
add r2.zw, r2, r3
mul r6.xyz, r1.yyww, r1.yyww
add r3.z, -r2.w, r2.z
mul r3.w, r6.x, c15.x
exp r3.w, r3.w
cmp r3.z, r3.z, c12.z, r3.w
mad r5.xy, r6.yzzw, c15.y, c15.z
rsq r3.w, r5.x
rsq r4.w, r5.y
rcp r5.x, r3.w
rcp r5.y, r4.w
mad r1.yw, r1_abs, c15.w, r5.xxzy
rcp r5.x, r1.y
rcp r5.y, r1.w
mul r1.yw, r2.xzzw, r5.xxzy
mul r0.x, -r0.x, r1.x
mul r0.x, r2.y, r0.x
mul r0.x, r0.x, c15.x
exp r5.w, r0.x
mul r1.yw, r1, r5.xzzw
mul r0.x, r0.w, r3.x
mul r0.x, r0.x, c14.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.w, r1.x, r2.x
mul r0.w, r0.w, c15.x
exp r0.w, r0.w
mul r0.x, r0.w, r0.x
dp2add r0.w, r1.ywzw, c13.zyzw, r3.z
mul r0.x, r0.w, r0.x
mul r1.xyw, r0.x, c4.xyzz
mad r0.xyw, -c2.xyzz, r0.y, -r1
mul r0.xyw, r0, c15.x
exp r2.x, r0.x
exp r2.y, r0.y
exp r2.z, r0.w
else
add r0.x, r3.x, -c5.x
rcp r0.y, r1.z
mul r0.x, r0.y, r0.x
rsq r0.x, r0.x
rcp r1.y, r0.x
add r0.x, r3.y, c14.y
mul r0.x, r0.x, c14.z
mov_sat r0.y, r0_abs.x
add r0.w, r0_abs.x, c13.y
rcp r3.x, r0_abs.x
cmp r0.w, r0.w, r3.x, c13.z
mul r0.y, r0.w, r0.y
mul r0.w, r0.y, r0.y
mad r3.x, r0.w, c16.x, c16.y
mad r3.x, r0.w, r3.x, c14.w
mad r3.x, r0.w, r3.x, c16.z
mad r0.w, r0.w, r3.x, c16.w
mul r0.y, r0.w, r0.y
add r0.w, -r0_abs.x, c13.z
cmp r0.w, r0.w, c18.x, c18.y
mad r3.x, r0.y, c17.x, c17.y
mad r0.y, r3.x, r0.w, r0.y
min r3.x, r0.x, c13.z
cmp r0.x, r3.x, c18.x, c18.y
add r0.w, r0.y, r0.y
mad r0.x, r0.x, -r0.w, r0.y
mul r1.x, r0.x, c17.z
mov r1.zw, c12.z
texldl r2, r1, s0
endif
add r0.x, r2.y, r2.x
add r0.x, r2.z, r0.x
mul r0.x, r0.x, c17.w
lrp r1.xyz, c9.x, r2, r0.x
mul r0.xyw, r1.xyzz, c10.x
mov r1.z, c13.z
lrp r2.xyz, r0.xyww, r1.z, c11.x
cmp r4.xyz, -r0.z, r2, r0.xyww
endif
mov oC0.xyz, r4
mov oC0.w, c13.z

"
}
SubProgram "d3d11 " {
// Stats: 152 math, 4 branches
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
eefiecedabmbknhaggaiabbnmnckjngjiigpgaehabaaaaaacebfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgebeaaaa
eaaaaaaabjafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaakicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaa
aaaaaaaaamaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaapaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaapaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaaphcaabaaaadaaaaaa
egiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaa
egiccaiaebaaaaaaaaaaaaaabjaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaaeaaaaaadkaabaaaaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaoaaaaah
ccaabaaaaeaaaaaackaabaaaacaaaaaaakaabaaaaeaaaaaadcaaaaakicaabaaa
aaaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaajicaabaaa
aaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaiaebaaaaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaahicaabaaa
acaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaackaabaaaacaaaaaaaoaaaaahccaabaaaacaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadhaaaaajdcaabaaaadaaaaaapgapbaaaacaaaaaa
egaabaaaacaaaaaaegaabaaaaeaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaabpaaaeaddkaabaaaaaaaaaaadgaaaaaipccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdoaaaaabbfaaaaab
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaackaabaaaacaaaaaackaabaaaacaaaaaabaaaaaajccaabaaa
abaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaa
egiccaaaaaaaaaaabjaaaaaaegacbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaeabkaabaaaabaaaaaadcaaaaam
ccaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaa
amaaaaaaakaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaiaeadcaaaaakccaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaabkaabaaa
aaaaaaaackaabaaaaaaaaaaadbaaaaahccaabaaaabaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaaeabkaabaia
ebaaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaajccaabaaaaaaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaialpbkaabaaa
aaaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaa
bpaaaeadbkaabaaaabaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaa
acaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaah
ecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaaeaakaabaiaebaaaaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaiaebaaaaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaajecaabaaa
aaaaaaaabkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpckaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaaakaabaaaadaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaaaaaaaaahecaabaaaadaaaaaaakaabaaaabaaaaaabkaabaaaadaaaaaa
diaaaaahdcaabaaaabaaaaaapgapbaaaaaaaaaaajgafbaaaadaaaaaadbaaaaak
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegaabaaa
abaaaaaadbaaaaakmcaabaaaacaaaaaaagaebaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaa
acaaaaaaogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaa
diaaaaahhcaabaaaaeaaaaaaagabbaaaabaaaaaaagabbaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaaakaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaadcaaaaapmcaabaaaacaaaaaafgajbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaafmipmcdpfmipmcdpaceaaaaaaaaaaaaaaaaaaaaaaaaaiaeaaaaaiaea
elaaaaafmcaabaaaacaaaaaakgaobaaaacaaaaaadcaaaaandcaabaaaabaaaaaa
egaabaiaibaaaaaaabaaaaaaaceaaaaagjgpbeeagjgpbeeaaaaaaaaaaaaaaaaa
ogakbaaaacaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
abaaaaaaaoaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaa
aoaaaaahbcaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaacaaaaaaaaaaaaah
bcaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaeaaaaaackaabaaa
abaaaaaadgaaaaaifcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaadiaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaaeaaaaaa
diaaaaahecaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaciapmjeaelaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaaaaaaaaajccaabaaaacaaaaaaakaabaiaebaaaaaa
adaaaaaabkiacaaaaaaaaaaaamaaaaaaaoaaaaahecaabaaaaaaaaaaabkaabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaapaaaaakbcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaajicaabaaa
aaaaaaaadkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaah
bcaabaaaabaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaadaaaaaaakaabaaaabaaaaaaelaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahdcaabaaaabaaaaaajgafbaaaadaaaaaaagaabaaa
abaaaaaadbaaaaakmcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaagaebaaaabaaaaaadbaaaaakmcaabaaaadaaaaaaagaebaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaacaaaaaa
kgaobaiaebaaaaaaacaaaaaakgaobaaaadaaaaaaclaaaaafmcaabaaaacaaaaaa
kgaobaaaacaaaaaadiaaaaahhcaabaaaafaaaaaaagabbaaaabaaaaaaagabbaaa
abaaaaaadbaaaaahecaabaaaabaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahecaabaaaadaaaaaaakaabaaaafaaaaaaabeaaaaadlkklidpbjaaaaaf
ecaabaaaadaaaaaackaabaaaadaaaaaaabaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaadaaaaaadcaaaaapmcaabaaaadaaaaaafgajbaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaafmipmcdpfmipmcdpaceaaaaaaaaaaaaaaaaaaaaa
aaaaiaeaaaaaiaeaelaaaaafmcaabaaaadaaaaaakgaobaaaadaaaaaadcaaaaan
dcaabaaaabaaaaaaegaabaiaibaaaaaaabaaaaaaaceaaaaagjgpbeeagjgpbeea
aaaaaaaaaaaaaaaaogakbaaaadaaaaaaaoaaaaahdcaabaaaabaaaaaaogakbaaa
acaaaaaaegaabaaaabaaaaaaaoaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaaeaaaaaaakaabaaaaaaaaaaadiaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaaeaaaaaadiaaaaahbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaadaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
aoaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaaapaaaaakicaabaaaaaaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaagaabaaaaaaaaaaaegiccaaa
aaaaaaaaalaaaaaadcaaaaamncaabaaaaaaaaaaaagijcaiaebaaaaaaaaaaaaaa
ajaaaaaakgakbaaaaaaaaaaaagajbaiaebaaaaaaabaaaaaadiaaaaakncaabaaa
aaaaaaaaagaobaaaaaaaaaaaaceaaaaadlkklidpaaaaaaaadlkklidpdlkklidp
bjaaaaafhcaabaaaacaaaaaaigadbaaaaaaaaaaabcaaaaabaaaaaaajbcaabaaa
aaaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaaoaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaabaaaaaaelaaaaafccaabaaa
abaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaadaaaaaa
abeaaaaajkjjbjdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
jfdbeeebddaaaaaiecaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdeaaaaaiicaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaaabeaaaaa
aaaaiadpaoaaaaakicaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajecaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajecaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaabaaaaaadkaabaaaaaaaaaaa
ckaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaaaaaaaaadkaabaaa
aaaaaaaackaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahecaabaaaabaaaaaa
dkaabaaaaaaaaaaackaabaaaaaaaaaaadbaaaaaiicaabaaaabaaaaaaabeaaaaa
aaaaiadpakaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahecaabaaaabaaaaaa
dkaabaaaabaaaaaackaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaddaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaaacaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
bfaaaaabaaaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkkkdoaaaaaaajecaabaaa
aaaaaaaadkiacaiaebaaaaaaaaaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakncaabaaa
aaaaaaaapgipcaaaaaaaaaaabjaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaa
diaaaaaincaabaaaaaaaaaaaagaobaaaaaaaaaaaagiacaaaaaaaaaaabkaaaaaa
bnaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabkaaaaaaabeaaaaaaaaaiadp
dcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaaigadbaaaaaaaaaaafgifcaaa
aaaaaaaabkaaaaaadhaaaaajhccabaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaaigadbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
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
def c22, 6000, -9.99999997e-007, 0, 2
def c23, 4, -1, 1, 0.5
def c24, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c25, 1.44269502, 1.51999998, 4, 2.31929994
def c26, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c27, -2, 1.57079637, 0.666666687, 0.333333343
def c28, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c29, -2, 3.14159274, 3, 5
def c30, -0, -1, -2, -3
def c31, 0, 1, -0, -1
defi i0, 4, 0, 0, 0
dcl_texcoord v0.xyz
dcl_2d s0
mov r0.xz, c22
mul r1.xyz, r0.x, c8
add r2.xyz, -c8, v0
nrm r3.xyz, r2
mov r2.x, c13.x
add r0.y, -r2.x, c14.x
mul r0.w, r0.y, c15.x
mad r2.x, r0.y, c15.x, r2.x
mov r4.xyz, c16
mad r4.xyz, c8, r0.x, -r4
dp3 r0.x, r4, r4
rsq r0.x, r0.x
rcp r5.x, r0.x
dp3 r0.y, r4, r3
mul r5.y, r0.x, r0.y
mul r0.x, r5.x, r5.x
mad r0.x, r0.y, r0.y, -r0.x
mad r0.x, r2.x, r2.x, r0.x
rsq r1.w, r0.x
rcp r1.w, r1.w
cmp r0.x, r0.x, -r1.w, c22.y
add r0.x, r0.x, -r0.y
max r1.w, r0.x, c22.z
add r0.x, r0.y, r1.w
rcp r2.z, r2.x
mul r2.y, r0.x, r2.z
cmp r4.xy, -r1.w, r5, r2
if_lt r2.x, r4.x
mov r2.yzw, c23.z
else
dp3 r0.x, r3, r3
add r1.w, r0.y, r0.y
dp3 r3.w, c16, c16
dp3 r4.w, r1, r1
add r3.w, r3.w, r4.w
dp3 r4.w, c16, r1
mad r3.w, r4.w, -c22.w, r3.w
mad r4.w, c13.x, -c13.x, r3.w
mul r1.w, r1.w, r1.w
mul r5.x, r0.x, c23.x
mad r4.w, r5.x, -r4.w, r1.w
rsq r5.y, r4.w
rcp r5.y, r5.y
mad r5.y, r0.y, -c22.w, -r5.y
add r0.x, r0.x, r0.x
rcp r0.x, r0.x
mul r5.y, r0.x, r5.y
cmp r4.w, r4.w, r5.y, c23.y
if_lt -r4.w, c22.z
mad r5.y, r2.x, -r2.x, r3.w
mad r5.y, r5.x, -r5.y, r1.w
rsq r5.z, r5.y
rcp r5.z, r5.z
mad r5.z, r0.y, -c22.w, -r5.z
mul r5.z, r0.x, r5.z
cmp r5.y, r5.y, -r5.z, c23.z
add r5.y, r4.w, r5.y
mov r6.x, c15.x
mul r5.z, r6.x, c9.x
rcp r5.w, r5.z
mul r6.y, r4.x, r5.w
mul r6.y, r6.y, c23.w
rsq r6.y, r6.y
rcp r6.y, r6.y
rcp r6.z, r4.x
mad r4.z, r5.y, r6.z, r4.y
mul r6.yz, r4, r6.y
cmp r7.xy, -r6.yzzw, c31.x, c31.y
cmp r7.zw, r6.xyyz, c31.z, c31.w
add r7.xy, r7.zwzw, r7
mul r8.xyz, r6.yyzw, r6.yyzw
add r6.w, -r7.y, r7.x
mul r7.z, r8.x, c25.x
exp r7.z, r7.z
cmp r6.w, r6.w, c22.z, r7.z
mad r7.zw, r8.xyyz, c25.y, c25.z
rsq r7.z, r7.z
rsq r7.w, r7.w
rcp r8.x, r7.z
rcp r8.y, r7.w
mad r6.yz, r6_abs, c25.w, r8.xxyw
rcp r8.x, r6.y
rcp r8.y, r6.z
mul r6.yz, r7.xxyw, r8.xxyw
mul r7.x, r5.w, -r5.y
add r7.y, r4.x, r4.x
rcp r7.y, r7.y
mad r7.y, r5.y, r7.y, r4.y
mul r7.x, r7.y, r7.x
mul r7.x, r7.x, c25.x
exp r8.y, r7.x
mov r8.xz, c23.z
mul r6.yz, r6, r8.xxyw
mul r5.z, r4.x, r5.z
mul r5.z, r5.z, c24.x
rsq r5.z, r5.z
rcp r5.z, r5.z
add r7.x, -r4.x, c13.x
mul r5.w, r5.w, r7.x
mul r5.w, r5.w, c25.x
exp r5.w, r5.w
mul r5.z, r5.w, r5.z
dp2add r5.w, r6.yzzw, c23.zyzw, r6.w
mul r5.z, r5.w, r5.z
mul r5.w, r6.x, c11.x
rcp r6.x, r5.w
mul r6.y, r4.x, r6.x
mul r6.y, r6.y, c23.w
rsq r6.y, r6.y
rcp r6.y, r6.y
mul r6.yz, r4, r6.y
cmp r7.zw, -r6.xyyz, c31.x, c31.y
cmp r8.xy, r6.yzzw, c31.z, c31.w
add r7.zw, r7, r8.xyxy
mul r9.xyz, r6.yyzw, r6.yyzw
add r4.z, -r7.w, r7.z
mul r6.w, r9.x, c25.x
exp r6.w, r6.w
cmp r4.z, r4.z, c22.z, r6.w
mad r8.xy, r9.yzzw, c25.y, c25.z
rsq r6.w, r8.x
rsq r8.x, r8.y
rcp r9.x, r6.w
rcp r9.y, r8.x
mad r6.yz, r6_abs, c25.w, r9.xxyw
rcp r8.x, r6.y
rcp r8.y, r6.z
mul r6.yz, r7.xzww, r8.xxyw
mul r5.y, -r5.y, r6.x
mul r5.y, r7.y, r5.y
mul r5.y, r5.y, c25.x
exp r8.w, r5.y
mul r6.yz, r6, r8.xzww
mul r5.y, r4.x, r5.w
mul r5.y, r5.y, c24.x
rsq r5.y, r5.y
rcp r5.y, r5.y
mul r5.w, r6.x, r7.x
mul r5.w, r5.w, c25.x
exp r5.w, r5.w
mul r5.y, r5.w, r5.y
dp2add r4.z, r6.yzzw, c23.zyzw, r4.z
mul r4.z, r4.z, r5.y
mul r6.xyz, r4.z, c12
mad r5.yzw, -c10.xxyz, r5.z, -r6.xxyz
mul r5.yzw, r5, c25.x
exp r6.x, r5.y
exp r6.y, r5.z
exp r6.z, r5.w
else
add r4.x, r4.x, -c13.x
rcp r0.w, r0.w
mul r0.w, r0.w, r4.x
rsq r0.w, r0.w
rcp r7.y, r0.w
add r0.w, r4.y, c24.y
mul r0.w, r0.w, c24.z
mov_sat r4.x, r0_abs.w
add r4.y, r0_abs.w, c23.y
rcp r4.z, r0_abs.w
cmp r4.y, r4.y, r4.z, c23.z
mul r4.x, r4.y, r4.x
mul r4.y, r4.x, r4.x
mad r4.z, r4.y, c26.x, c26.y
mad r4.z, r4.y, r4.z, c24.w
mad r4.z, r4.y, r4.z, c26.z
mad r4.y, r4.y, r4.z, c26.w
mul r4.x, r4.y, r4.x
add r4.y, -r0_abs.w, c23.z
cmp r4.y, r4.y, c31.x, c31.y
mad r4.z, r4.x, c27.x, c27.y
mad r4.x, r4.z, r4.y, r4.x
min r4.y, r0.w, c23.z
cmp r0.w, r4.y, c31.x, c31.y
add r4.y, r4.x, r4.x
mad r0.w, r0.w, -r4.y, r4.x
mul r7.x, r0.w, c27.z
mov r7.zw, c22.z
texldl r6, r7, s0
endif
add r0.w, r6.y, r6.x
add r0.w, r6.z, r0.w
mul r0.w, r0.w, c27.w
lrp r4.xyz, c17.x, r6, r0.w
mul r4.xyz, r4, c18.x
if_lt -r4.w, c22.z
mad r0.w, r2.x, -r2.x, r3.w
mad r0.w, r5.x, -r0.w, r1.w
rsq r1.w, r0.w
rcp r1.w, r1.w
mad r2.x, r0.y, -c22.w, -r1.w
mul r2.x, r0.x, r2.x
mad r0.y, r0.y, -c22.w, r1.w
mul r0.x, r0.x, r0.y
cmp r0.x, r2.x, r2.x, r0.x
cmp r0.x, r0.w, r0.x, c23.y
add r0.y, r0.x, c23.z
if_ne r0.y, -r0.y
mad r0.xyw, r3.xyzz, r0.x, r1.xyzz
add r1.xyz, -r0.xyww, c21
dp3 r1.w, r1, r1
rsq r1.w, r1.w
rcp r2.x, r1.w
mul r1.xyz, r1.w, r1
rcp r1.w, c21.w
mov r3.x, c23.z
mov r3.y, c22.z
rep i0
add r5, r3.y, c30
cmp r3.z, -r5_abs.x, c0.w, r0.z
cmp r3.z, -r5_abs.y, c1.w, r3.z
cmp r3.z, -r5_abs.z, c2.w, r3.z
cmp r3.z, -r5_abs.w, c3.w, r3.z
if_ge -r3.z, c22.z
break_ne c23.z, -c23.z
endif
cmp r6.xyz, -r5_abs.x, c0, r0.z
cmp r6.xyz, -r5_abs.y, c1, r6
cmp r5.xyz, -r5_abs.z, c2, r6
cmp r5.xyz, -r5_abs.w, c3, r5
add r5.xyz, -r0.xyww, r5
dp3 r3.w, r5, r5
rsq r3.w, r3.w
mul r5.xyz, r3.w, r5
mul r6.xyz, r1.zxyw, r5.yzxw
mad r6.xyz, r1.yzxw, r5.zxyw, -r6
dp3 r4.w, r6, r6
rsq r4.w, r4.w
rcp r4.w, r4.w
min r5.w, r4.w, c23.z
add r4.w, -r5.w, c23.z
rsq r4.w, r4.w
rcp r4.w, r4.w
mad r6.x, r5.w, c28.x, c28.y
mad r6.x, r6.x, r5.w, c28.z
mad r5.w, r6.x, r5.w, c28.w
mad r4.w, r5.w, -r4.w, c27.y
mul r3.z, r3.w, r3.z
min r5.w, r3.z, c23.z
add r3.z, -r5_abs.w, c23.z
rsq r3.z, r3.z
rcp r3.z, r3.z
mad r3.w, r5_abs.w, c28.x, c28.y
mad r3.w, r3.w, r5_abs.w, c28.z
mad r3.w, r3.w, r5_abs.w, c28.w
mul r3.z, r3.z, r3.w
mad r3.w, r3.z, c29.x, c29.y
cmp r5.w, r5.w, c31.x, c31.y
mad r3.z, r3.w, r5.w, r3.z
add r3.z, -r3.z, c27.y
add r3.z, -r3.z, r4.w
mul r3.z, r2.x, r3.z
mad r3.z, -r3.z, r1.w, c23.z
mul_sat r3.z, r3.z, c23.w
mad r3.w, r3.z, c29.x, c29.z
mul r3.z, r3.z, r3.z
mul r3.z, r3.z, r3.w
dp3 r3.w, r1, r5
mul_sat r3.w, r3.w, c29.w
mad r4.w, r3.w, c29.x, c29.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.w
mad r3.z, r3.z, -r3.w, c23.z
mul r3.x, r3.z, r3.x
add r3.y, r3.y, c23.z
endrep
mov r3.y, r3.x
mov r3.z, c22.z
rep i0
add r5, r3.z, c30
cmp r3.w, -r5_abs.x, c4.w, r0.z
cmp r3.w, -r5_abs.y, c5.w, r3.w
cmp r3.w, -r5_abs.z, c6.w, r3.w
cmp r3.w, -r5_abs.w, c7.w, r3.w
if_ge -r3.w, c22.z
break_ne c23.z, -c23.z
endif
cmp r6.xyz, -r5_abs.x, c4, r0.z
cmp r6.xyz, -r5_abs.y, c5, r6
cmp r5.xyz, -r5_abs.z, c6, r6
cmp r5.xyz, -r5_abs.w, c7, r5
add r5.xyz, -r0.xyww, r5
dp3 r4.w, r5, r5
rsq r4.w, r4.w
mul r5.xyz, r4.w, r5
mul r6.xyz, r1.zxyw, r5.yzxw
mad r6.xyz, r1.yzxw, r5.zxyw, -r6
dp3 r5.w, r6, r6
rsq r5.w, r5.w
rcp r5.w, r5.w
min r6.x, r5.w, c23.z
add r5.w, -r6.x, c23.z
rsq r5.w, r5.w
rcp r5.w, r5.w
mad r6.y, r6.x, c28.x, c28.y
mad r6.y, r6.y, r6.x, c28.z
mad r6.x, r6.y, r6.x, c28.w
mad r5.w, r6.x, -r5.w, c27.y
mul r3.w, r3.w, r4.w
min r4.w, r3.w, c23.z
add r3.w, -r4_abs.w, c23.z
rsq r3.w, r3.w
rcp r3.w, r3.w
mad r6.x, r4_abs.w, c28.x, c28.y
mad r6.x, r6.x, r4_abs.w, c28.z
mad r6.x, r6.x, r4_abs.w, c28.w
mul r3.w, r3.w, r6.x
mad r6.x, r3.w, c29.x, c29.y
cmp r4.w, r4.w, c31.x, c31.y
mad r3.w, r6.x, r4.w, r3.w
add r3.w, -r3.w, c27.y
add r3.w, -r3.w, r5.w
mul r3.w, r2.x, r3.w
mad r3.w, -r3.w, r1.w, c23.z
mul_sat r3.w, r3.w, c23.w
mad r4.w, r3.w, c29.x, c29.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.w
dp3 r4.w, r1, r5
mul_sat r4.w, r4.w, c29.w
mad r5.x, r4.w, c29.x, c29.z
mul r4.w, r4.w, r4.w
mul r4.w, r4.w, r5.x
mad r3.w, r3.w, -r4.w, c23.z
mul r3.y, r3.w, r3.y
add r3.z, r3.z, c23.z
endrep
else
mov r3.y, c23.z
endif
mul r0.xyz, r3.y, r4
mov r1.z, c23.z
lrp r2.yzw, r0.xxyz, r1.z, c20.x
else
mov r0.z, c23.z
lrp r2.yzw, r4.xxyz, r0.z, c19.x
endif
endif
mov oC0.xyz, r2.yzww
mov oC0.w, c23.z

"
}
SubProgram "d3d11 " {
// Stats: 270 math, 14 branches
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
eefiecedbookjekpgmmgklhdaafipjekchgcembaabaaaaaapaceaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaceaaaa
eaaaaaaaamajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaaceaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacajaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaa
amaaaaaackiacaaaaaaaaaaaamaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaapaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaap
hcaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallef
aaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabjaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaaeaaaaaa
dkaabaaaaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaaaoaaaaahccaabaaaaeaaaaaackaabaaaacaaaaaaakaabaaaaeaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaajicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaiaebaaaaaa
acaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dbaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaaaoaaaaahccaabaaa
acaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajdcaabaaaadaaaaaa
pgapbaaaacaaaaaaegaabaaaacaaaaaaegaabaaaaeaaaaaadbaaaaahicaabaaa
aaaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaabpaaaeaddkaabaaaaaaaaaaa
dgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
doaaaaabbfaaaaabbaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaaacaaaaaackaabaaaacaaaaaa
baaaaaajicaabaaaacaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaa
bjaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaabaaaaaai
icaabaaaadaaaaaaegiccaaaaaaaaaaabjaaaaaaegacbaaaaaaaaaaadcaaaaak
icaabaaaacaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaaeadkaabaaa
acaaaaaadcaaaaamicaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaa
bkiacaaaaaaaaaaaamaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaaeaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiaeadcaaaaakicaabaaaadaaaaaaakaabaiaebaaaaaa
aeaaaaaadkaabaaaadaaaaaabkaabaaaacaaaaaadbaaaaahccaabaaaaeaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaadcaaaaalicaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaaaeadkaabaiaebaaaaaaadaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
dkaabaaaaaaaaaaadhaaaaajicaabaaaadaaaaaabkaabaaaaeaaaaaaabeaaaaa
aaaaialpdkaabaaaadaaaaaadbaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaa
dkaabaaaadaaaaaabpaaaeadbkaabaaaaeaaaaaadcaaaaakccaabaaaaeaaaaaa
akaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaak
ccaabaaaaeaaaaaaakaabaiaebaaaaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaa
acaaaaaadbaaaaahecaabaaaaeaaaaaabkaabaaaaeaaaaaaabeaaaaaaaaaaaaa
elaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaadcaaaaalccaabaaaaeaaaaaa
ckaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaaeabkaabaiaebaaaaaaaeaaaaaa
aoaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaaaaaaaaadhaaaaak
ccaabaaaaeaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaiadpbkaabaiaebaaaaaa
aeaaaaaaaaaaaaahccaabaaaaeaaaaaadkaabaaaadaaaaaabkaabaaaaeaaaaaa
diaaaaajecaabaaaaeaaaaaabkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaa
apaaaaaaaoaaaaahicaabaaaaeaaaaaaabeaaaaaaaaaaadpckaabaaaaeaaaaaa
diaaaaahicaabaaaaeaaaaaaakaabaaaadaaaaaadkaabaaaaeaaaaaaelaaaaaf
icaabaaaaeaaaaaadkaabaaaaeaaaaaaaoaaaaahbcaabaaaafaaaaaabkaabaaa
aeaaaaaaakaabaaaadaaaaaaaaaaaaahecaabaaaadaaaaaabkaabaaaadaaaaaa
akaabaaaafaaaaaadiaaaaahdcaabaaaafaaaaaajgafbaaaadaaaaaapgapbaaa
aeaaaaaadbaaaaakmcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaagaebaaaafaaaaaadbaaaaakdcaabaaaagaaaaaaegaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaimcaabaaaafaaaaaa
kgaobaiaebaaaaaaafaaaaaaagaebaaaagaaaaaaclaaaaafmcaabaaaafaaaaaa
kgaobaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaagabbaaaafaaaaaaagabbaaa
afaaaaaadbaaaaahicaabaaaaeaaaaaackaabaaaafaaaaaadkaabaaaafaaaaaa
diaaaaahbcaabaaaagaaaaaaakaabaaaagaaaaaaabeaaaaadlkklidpbjaaaaaf
bcaabaaaagaaaaaaakaabaaaagaaaaaaabaaaaahicaabaaaaeaaaaaadkaabaaa
aeaaaaaaakaabaaaagaaaaaadcaaaaapdcaabaaaagaaaaaajgafbaaaagaaaaaa
aceaaaaafmipmcdpfmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaea
aaaaaaaaaaaaaaaaelaaaaafdcaabaaaagaaaaaaegaabaaaagaaaaaadcaaaaan
dcaabaaaafaaaaaaegaabaiaibaaaaaaafaaaaaaaceaaaaagjgpbeeagjgpbeea
aaaaaaaaaaaaaaaaegaabaaaagaaaaaaaoaaaaahdcaabaaaafaaaaaaogakbaaa
afaaaaaaegaabaaaafaaaaaaaoaaaaaiecaabaaaafaaaaaabkaabaiaebaaaaaa
aeaaaaaackaabaaaaeaaaaaaaaaaaaahicaabaaaafaaaaaaakaabaaaadaaaaaa
akaabaaaadaaaaaaaoaaaaahicaabaaaafaaaaaabkaabaaaaeaaaaaadkaabaaa
afaaaaaaaaaaaaahicaabaaaafaaaaaabkaabaaaadaaaaaadkaabaaaafaaaaaa
diaaaaahecaabaaaafaaaaaadkaabaaaafaaaaaackaabaaaafaaaaaadiaaaaah
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaa
agaaaaaackaabaaaafaaaaaadgaaaaaifcaabaaaagaaaaaaaceaaaaaaaaaiadp
aaaaaaaaaaaaiadpaaaaaaaadiaaaaahdcaabaaaafaaaaaaegaabaaaafaaaaaa
egaabaaaagaaaaaadiaaaaahecaabaaaafaaaaaaakaabaaaadaaaaaackaabaaa
aeaaaaaadiaaaaahecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaciapmjea
elaaaaafecaabaaaafaaaaaackaabaaaafaaaaaaaaaaaaajbcaabaaaagaaaaaa
akaabaiaebaaaaaaadaaaaaabkiacaaaaaaaaaaaamaaaaaaaoaaaaahecaabaaa
aeaaaaaaakaabaaaagaaaaaackaabaaaaeaaaaaadiaaaaahecaabaaaaeaaaaaa
ckaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaeaaaaaackaabaaa
aeaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaaafaaaaaa
apaaaaakbcaabaaaafaaaaaaegaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaaaaaaaaaaaaaaaaaaaahicaabaaaaeaaaaaadkaabaaaaeaaaaaaakaabaaa
afaaaaaadiaaaaahecaabaaaaeaaaaaadkaabaaaaeaaaaaackaabaaaaeaaaaaa
diaaaaajicaabaaaaeaaaaaadkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaa
apaaaaaaaoaaaaahbcaabaaaafaaaaaaabeaaaaaaaaaaadpdkaabaaaaeaaaaaa
diaaaaahbcaabaaaafaaaaaaakaabaaaadaaaaaaakaabaaaafaaaaaaelaaaaaf
bcaabaaaafaaaaaaakaabaaaafaaaaaadiaaaaahdcaabaaaafaaaaaajgafbaaa
adaaaaaaagaabaaaafaaaaaadbaaaaakdcaabaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegaabaaaafaaaaaadbaaaaakmcaabaaaahaaaaaa
agaebaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaai
dcaabaaaahaaaaaaegaabaiaebaaaaaaahaaaaaaogakbaaaahaaaaaaclaaaaaf
dcaabaaaahaaaaaaegaabaaaahaaaaaadiaaaaahhcaabaaaaiaaaaaaagabbaaa
afaaaaaaagabbaaaafaaaaaadbaaaaahecaabaaaadaaaaaaakaabaaaahaaaaaa
bkaabaaaahaaaaaadiaaaaahecaabaaaafaaaaaaakaabaaaaiaaaaaaabeaaaaa
dlkklidpbjaaaaafecaabaaaafaaaaaackaabaaaafaaaaaaabaaaaahecaabaaa
adaaaaaackaabaaaadaaaaaackaabaaaafaaaaaadcaaaaapmcaabaaaahaaaaaa
fgajbaaaaiaaaaaaaceaaaaaaaaaaaaaaaaaaaaafmipmcdpfmipmcdpaceaaaaa
aaaaaaaaaaaaaaaaaaaaiaeaaaaaiaeaelaaaaafmcaabaaaahaaaaaakgaobaaa
ahaaaaaadcaaaaandcaabaaaafaaaaaaegaabaiaibaaaaaaafaaaaaaaceaaaaa
gjgpbeeagjgpbeeaaaaaaaaaaaaaaaaaogakbaaaahaaaaaaaoaaaaahdcaabaaa
afaaaaaaegaabaaaahaaaaaaegaabaaaafaaaaaaaoaaaaaiccaabaaaaeaaaaaa
bkaabaiaebaaaaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaa
dkaabaaaafaaaaaabkaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaabkaabaaa
aeaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaagaaaaaabkaabaaaaeaaaaaa
diaaaaahdcaabaaaafaaaaaaegaabaaaafaaaaaaogakbaaaagaaaaaadiaaaaah
ccaabaaaaeaaaaaaakaabaaaadaaaaaadkaabaaaaeaaaaaadiaaaaahccaabaaa
aeaaaaaabkaabaaaaeaaaaaaabeaaaaaciapmjeaelaaaaafccaabaaaaeaaaaaa
bkaabaaaaeaaaaaaaoaaaaahicaabaaaaeaaaaaaakaabaaaagaaaaaadkaabaaa
aeaaaaaadiaaaaahicaabaaaaeaaaaaadkaabaaaaeaaaaaaabeaaaaadlkklidp
bjaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaa
dkaabaaaaeaaaaaabkaabaaaaeaaaaaaapaaaaakicaabaaaaeaaaaaaegaabaaa
afaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaa
adaaaaaackaabaaaadaaaaaadkaabaaaaeaaaaaadiaaaaahecaabaaaadaaaaaa
ckaabaaaadaaaaaabkaabaaaaeaaaaaadiaaaaaihcaabaaaafaaaaaakgakbaaa
adaaaaaaegiccaaaaaaaaaaaalaaaaaadcaaaaamocaabaaaaeaaaaaaagijcaia
ebaaaaaaaaaaaaaaajaaaaaakgakbaaaaeaaaaaaagajbaiaebaaaaaaafaaaaaa
diaaaaakocaabaaaaeaaaaaafgaobaaaaeaaaaaaaceaaaaaaaaaaaaadlkklidp
dlkklidpdlkklidpbjaaaaafhcaabaaaafaaaaaajgahbaaaaeaaaaaabcaaaaab
aaaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
amaaaaaaaoaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaaabaaaaaa
elaaaaafccaabaaaagaaaaaadkaabaaaabaaaaaaaaaaaaahicaabaaaabaaaaaa
bkaabaaaadaaaaaaabeaaaaajkjjbjdodiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaajfdbeeebddaaaaaibcaabaaaadaaaaaadkaabaiaibaaaaaa
abaaaaaaabeaaaaaaaaaiadpdeaaaaaiccaabaaaadaaaaaadkaabaiaibaaaaaa
abaaaaaaabeaaaaaaaaaiadpaoaaaaakccaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpbkaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaaadaaaaaaakaabaaa
adaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaadaaaaaabkaabaaa
adaaaaaackaabaaaadaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaadaaaaaa
bkaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaebnkjlodcaaaaajccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaadbaaaaaiccaabaaa
aeaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaabaaaaaadcaaaaajecaabaaa
adaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
ecaabaaaadaaaaaabkaabaaaaeaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpdbaaaaaiicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadhaaaaakicaabaaa
abaaaaaadkaabaaaabaaaaaaakaabaiaebaaaaaaadaaaaaaakaabaaaadaaaaaa
diaaaaahbcaabaaaagaaaaaadkaabaaaabaaaaaaabeaaaaaklkkckdpeiaaaaal
pcaabaaaafaaaaaaegaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaabfaaaaabaaaaaaahicaabaaaabaaaaaabkaabaaaafaaaaaa
akaabaaaafaaaaaaaaaaaaahicaabaaaabaaaaaackaabaaaafaaaaaadkaabaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaklkkkkdo
aaaaaaajbcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaabjaaaaaaegacbaaaafaaaaaa
pgapbaaaabaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaa
aaaaaaaabkaaaaaabnaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaa
adaaaaaabpaaaeaddkaabaaaabaaaaaaaaaaaaajicaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaabkaaaaaaabeaaaaaaaaaiadpdcaaaaakocaabaaaaeaaaaaa
pgapbaaaabaaaaaaagajbaaaadaaaaaafgifcaaaaaaaaaaabkaaaaaabcaaaaab
dcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaabnaaaaahbcaabaaaacaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalccaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaaea
dkaabaiaebaaaaaaabaaaaaaaoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
dkaabaaaaaaaaaaadbaaaaahicaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaakicaabaaaabaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaaaeadkaabaaaabaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaa
aaaaaaaabkaabaaaacaaaaaadhaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaialpdjaaaaahicaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaialpbpaaaeaddkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaj
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaablaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
dgaaaaafbcaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaaacaaaaaa
bbaaaaajccaabaaaacaaaaaaegiocaaaaaaaaaaabpaaaaaaegjojaaaakaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
bpaaaeadckaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaa
egiocaaaaaaaaaaabmaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajccaabaaa
afaaaaaaegiocaaaaaaaaaaabnaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaaj
ecaabaaaafaaaaaaegiocaaaaaaaaaaaboaaaaaaegjojaaaakaabaaaacaaaaaa
aaaaaaaihcaabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaafaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaaaoaaaaahhcaabaaaafaaaaaaegacbaaa
afaaaaaakgakbaaaacaaaaaadiaaaaahhcaabaaaagaaaaaacgajbaaaabaaaaaa
jgaebaaaafaaaaaadcaaaaakhcaabaaaagaaaaaajgaebaaaabaaaaaacgajbaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
agaaaaaaegacbaaaagaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
ddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadcaaaaajbcaabaaaaeaaaaaadkaabaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaajbcaabaaaaeaaaaaa
akaabaaaaeaaaaaadkaabaaaacaaaaaaabeaaaaaiedefjlodcaaaaajicaabaaa
acaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaaabeaaaaakeanmjdpdcaaaaak
icaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaaadaaaaaaabeaaaaa
nlapmjdpaoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaa
ddaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaai
ecaabaaaacaaaaaabkaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaacaaaaaackaabaaaacaaaaaadcaaaaakicaabaaaadaaaaaabkaabaia
ibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaa
adaaaaaadkaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlo
dcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaa
abeaaaaakeanmjdpdiaaaaahbcaabaaaaeaaaaaackaabaaaacaaaaaadkaabaaa
adaaaaaadcaaaaajbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaama
abeaaaaanlapejeadbaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaia
ebaaaaaaacaaaaaaabaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
aeaaaaaadcaaaaajccaabaaaacaaaaaadkaabaaaadaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaaaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaanlapmjdpaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaa
dkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaa
acaaaaaaaoaaaaajccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaadkiacaaa
aaaaaaaablaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
aaaaiadpdicaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaadp
dcaaaaajecaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaabaaaaaah
ecaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaadicaaaahecaabaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaakaeadcaaaaajicaabaaaacaaaaaa
ckaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaa
acaaaaaackaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakccaabaaaacaaaaaabkaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaabkaabaaaacaaaaaaboaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaabdgaaaaafbcaabaaaacaaaaaa
dkaabaaaabaaaaaadgaaaaafccaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaab
cbaaaaahecaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaead
ckaabaaaacaaaaaabbaaaaajecaabaaaacaaaaaaegiocaaaaaaaaaaacdaaaaaa
egjojaaabkaabaaaacaaaaaabnaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaa
ckaabaaaacaaaaaabpaaaeaddkaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaaj
bcaabaaaafaaaaaaegiocaaaaaaaaaaacaaaaaaaegjojaaabkaabaaaacaaaaaa
bbaaaaajccaabaaaafaaaaaaegiocaaaaaaaaaaacbaaaaaaegjojaaabkaabaaa
acaaaaaabbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaaccaaaaaaegjojaaa
bkaabaaaacaaaaaaaaaaaaaihcaabaaaafaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaafaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaa
afaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaoaaaaahhcaabaaa
afaaaaaaegacbaaaafaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaagaaaaaa
cgajbaaaabaaaaaajgaebaaaafaaaaaadcaaaaakhcaabaaaagaaaaaajgaebaaa
abaaaaaacgajbaaaafaaaaaaegacbaiaebaaaaaaagaaaaaabaaaaaahicaabaaa
adaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaelaaaaaficaabaaaadaaaaaa
dkaabaaaadaaaaaaddaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaiadpaaaaaaaibcaabaaaaeaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpelaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaajicaabaaa
afaaaaaadkaabaaaadaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaaj
icaabaaaafaaaaaadkaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaaiedefjlo
dcaaaaajicaabaaaadaaaaaadkaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaa
keanmjdpdcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaakaabaaa
aeaaaaaaabeaaaaanlapmjdpaoaaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
dkaabaaaacaaaaaaddaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakbcaabaaa
aeaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaakbcaabaaaaeaaaaaaakaabaaaaeaaaaaackaabaiaibaaaaaaacaaaaaa
abeaaaaaiedefjlodcaaaaakbcaabaaaaeaaaaaaakaabaaaaeaaaaaackaabaia
ibaaaaaaacaaaaaaabeaaaaakeanmjdpdiaaaaahicaabaaaafaaaaaadkaabaaa
acaaaaaaakaabaaaaeaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaaiecaabaaaacaaaaaackaabaaa
acaaaaaackaabaiaebaaaaaaacaaaaaaabaaaaahecaabaaaacaaaaaackaabaaa
acaaaaaadkaabaaaafaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaaeaaaaaa
dkaabaaaacaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaackaabaia
ebaaaaaaacaaaaaaabeaaaaanlapmjdpaaaaaaaiecaabaaaacaaaaaackaabaia
ebaaaaaaacaaaaaadkaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaa
aaaaaaaackaabaaaacaaaaaaaoaaaaajecaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaa
acaaaaaaabeaaaaaaaaaiadpdicaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
abeaaaaaaaaaaadpdcaaaaajicaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaafaaaaaa
dicaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaakaeadcaaaaaj
icaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaadcaaaaakecaabaaa
acaaaaaackaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaboaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaabbcaaaaab
dgaaaaafbcaabaaaacaaaaaaabeaaaaaaaaaiadpbfaaaaabdiaaaaahhcaabaaa
aaaaaaaaagaabaaaacaaaaaaegacbaaaadaaaaaaaaaaaaajicaabaaaaaaaaaaa
ckiacaiaebaaaaaaaaaaaaaabkaaaaaaabeaaaaaaaaaiadpdcaaaaakocaabaaa
aeaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaakgikcaaaaaaaaaaabkaaaaaa
bfaaaaabdgaaaaafhccabaaaaaaaaaaajgahbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
 //        gles : 327 avg math (231..424), 4 texture, 13 avg branch (8..18)
 //      opengl : 327 avg math (231..424), 4 texture, 13 avg branch (8..18)
 // Stats for Fragment shader:
 //       d3d11 : 216 avg math (158..275), 4 avg branch (0..8)
 //        d3d9 : 271 avg math (203..339), 8 texture, 7 avg branch (0..14)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend One One
  GpuProgramID 127531
Program "vp" {
SubProgram "opengl " {
// Stats: 231 math, 4 textures, 8 branches
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
  tmpvar_1 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_2;
  tmpvar_2 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_3;
  tmpvar_3 = dot (tmpvar_2, tmpvar_2);
  float tmpvar_4;
  tmpvar_4 = (2.0 * dot (tmpvar_2, (tmpvar_1 - _Globals_Origin)));
  float tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1)))
   - 
    (Rg * Rg)
  )));
  float tmpvar_6;
  if ((tmpvar_5 < 0.0)) {
    tmpvar_6 = -1.0;
  } else {
    tmpvar_6 = ((-(tmpvar_4) - sqrt(tmpvar_5)) / (2.0 * tmpvar_3));
  };
  bool tmpvar_7;
  tmpvar_7 = (tmpvar_6 > 0.0);
  if (!(tmpvar_7)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 camera_8;
  camera_8 = (tmpvar_1 - _Globals_Origin);
  vec3 viewdir_9;
  viewdir_9.yz = tmpvar_2.yz;
  float rMu_10;
  float r_11;
  vec3 result_12;
  result_12 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_9);
  viewdir_9 = tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = dot (camera_8, tmpvar_13);
  rMu_10 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt(
    (((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_16 * tmpvar_13));
    rMu_10 = (tmpvar_15 + tmpvar_16);
    r_11 = xlat_mutableRt;
  };
  float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  float tmpvar_18;
  tmpvar_18 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  vec4 tmpvar_19;
  float _lerp_20;
  float tmpvar_21;
  float tmpvar_22;
  tmpvar_22 = (Rg * Rg);
  tmpvar_21 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_22));
  float tmpvar_23;
  tmpvar_23 = sqrt(((r_11 * r_11) - tmpvar_22));
  float tmpvar_24;
  tmpvar_24 = (r_11 * (rMu_10 / r_11));
  float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_11 * r_11)) + tmpvar_22);
  vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_21 * tmpvar_21);
    tmpvar_28.z = tmpvar_21;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  float tmpvar_29;
  tmpvar_29 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_21) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_30;
  tmpvar_30 = (tmpvar_26.w + ((
    ((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y)))
   / 
    (tmpvar_23 + tmpvar_26.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_31;
  y_over_x_31 = (max (tmpvar_18, -0.1975) * 5.349625);
  float tmpvar_32;
  tmpvar_32 = (min (abs(y_over_x_31), 1.0) / max (abs(y_over_x_31), 1.0));
  float tmpvar_33;
  tmpvar_33 = (tmpvar_32 * tmpvar_32);
  tmpvar_33 = (((
    ((((
      ((((-0.01213232 * tmpvar_33) + 0.05368138) * tmpvar_33) - 0.1173503)
     * tmpvar_33) + 0.1938925) * tmpvar_33) - 0.3326756)
   * tmpvar_33) + 0.9999793) * tmpvar_32);
  tmpvar_33 = (tmpvar_33 + (float(
    (abs(y_over_x_31) > 1.0)
  ) * (
    (tmpvar_33 * -2.0)
   + 1.570796)));
  float tmpvar_34;
  tmpvar_34 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_33 * sign(y_over_x_31)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_35;
  tmpvar_35 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_36;
  tmpvar_36 = floor(tmpvar_35);
  _lerp_20 = (tmpvar_35 - tmpvar_36);
  float tmpvar_37;
  tmpvar_37 = (floor((
    (tmpvar_29 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_38;
  tmpvar_38 = (floor((tmpvar_29 * RES_R)) / RES_R);
  float tmpvar_39;
  tmpvar_39 = fract((tmpvar_29 * RES_R));
  vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_40.y = ((tmpvar_30 / RES_R) + tmpvar_37);
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_41.y = ((tmpvar_30 / RES_R) + tmpvar_37);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_42.y = ((tmpvar_30 / RES_R) + tmpvar_38);
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_30 / RES_R) + tmpvar_38);
  tmpvar_19 = (((
    (texture2DLod (_Inscatter, tmpvar_40.xy, 0.0) * (1.0 - _lerp_20))
   + 
    (texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * _lerp_20)
  ) * (1.0 - tmpvar_39)) + ((
    (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * (1.0 - _lerp_20))
   + 
    (texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * _lerp_20)
  ) * tmpvar_39));
  if ((r_11 <= xlat_mutableRt)) {
    float tmpvar_44;
    tmpvar_44 = (mieG * mieG);
    result_12 = ((tmpvar_19.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_17 * tmpvar_17))
    )) + ((
      ((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_44)) * pow ((
        (1.0 + tmpvar_44)
       - 
        ((2.0 * mieG) * tmpvar_17)
      ), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17)))
     / 
      (2.0 + tmpvar_44)
    )));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  vec3 L_45;
  L_45 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  float tmpvar_46;
  if ((L_45.x < 1.413)) {
    tmpvar_46 = pow ((L_45.x * 0.38317), 0.4545454);
  } else {
    tmpvar_46 = (1.0 - exp(-(L_45.x)));
  };
  L_45.x = tmpvar_46;
  float tmpvar_47;
  if ((L_45.y < 1.413)) {
    tmpvar_47 = pow ((L_45.y * 0.38317), 0.4545454);
  } else {
    tmpvar_47 = (1.0 - exp(-(L_45.y)));
  };
  L_45.y = tmpvar_47;
  float tmpvar_48;
  if ((L_45.z < 1.413)) {
    tmpvar_48 = pow ((L_45.z * 0.38317), 0.4545454);
  } else {
    tmpvar_48 = (1.0 - exp(-(L_45.z)));
  };
  L_45.z = tmpvar_48;
  vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = (_Alpha_Global * L_45);
  gl_FragData[0] = tmpvar_49;
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
// Stats: 231 math, 4 textures, 8 branches
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
  tmpvar_1 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_3;
  tmpvar_3 = dot (tmpvar_2, tmpvar_2);
  highp float tmpvar_4;
  tmpvar_4 = (2.0 * dot (tmpvar_2, (tmpvar_1 - _Globals_Origin)));
  highp float tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1)))
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_6;
  if ((tmpvar_5 < 0.0)) {
    tmpvar_6 = -1.0;
  } else {
    tmpvar_6 = ((-(tmpvar_4) - sqrt(tmpvar_5)) / (2.0 * tmpvar_3));
  };
  bool tmpvar_7;
  tmpvar_7 = (tmpvar_6 > 0.0);
  if (!(tmpvar_7)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 camera_8;
  camera_8 = (tmpvar_1 - _Globals_Origin);
  highp vec3 viewdir_9;
  viewdir_9.yz = tmpvar_2.yz;
  highp float rMu_10;
  highp float r_11;
  highp vec3 result_12;
  result_12 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_9);
  viewdir_9 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (camera_8, tmpvar_13);
  rMu_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt(
    (((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_16 * tmpvar_13));
    rMu_10 = (tmpvar_15 + tmpvar_16);
    r_11 = xlat_mutableRt;
  };
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  highp float tmpvar_18;
  tmpvar_18 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_19;
  highp float _lerp_20;
  highp float tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (Rg * Rg);
  tmpvar_21 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_22));
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((r_11 * r_11) - tmpvar_22));
  highp float tmpvar_24;
  tmpvar_24 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_11 * r_11)) + tmpvar_22);
  highp vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    highp vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    highp vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_21 * tmpvar_21);
    tmpvar_28.z = tmpvar_21;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  highp float tmpvar_29;
  tmpvar_29 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_21) * (1.0 - 
    (1.0/(RES_R))
  )));
  highp float tmpvar_30;
  tmpvar_30 = (tmpvar_26.w + ((
    ((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y)))
   / 
    (tmpvar_23 + tmpvar_26.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  highp float y_over_x_31;
  y_over_x_31 = (max (tmpvar_18, -0.1975) * 5.349625);
  highp float tmpvar_32;
  tmpvar_32 = (min (abs(y_over_x_31), 1.0) / max (abs(y_over_x_31), 1.0));
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_32 * tmpvar_32);
  tmpvar_33 = (((
    ((((
      ((((-0.01213232 * tmpvar_33) + 0.05368138) * tmpvar_33) - 0.1173503)
     * tmpvar_33) + 0.1938925) * tmpvar_33) - 0.3326756)
   * tmpvar_33) + 0.9999793) * tmpvar_32);
  tmpvar_33 = (tmpvar_33 + (float(
    (abs(y_over_x_31) > 1.0)
  ) * (
    (tmpvar_33 * -2.0)
   + 1.570796)));
  highp float tmpvar_34;
  tmpvar_34 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_33 * sign(y_over_x_31)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_36;
  tmpvar_36 = floor(tmpvar_35);
  _lerp_20 = (tmpvar_35 - tmpvar_36);
  highp float tmpvar_37;
  tmpvar_37 = (floor((
    (tmpvar_29 * RES_R)
   - 1.0)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = (floor((tmpvar_29 * RES_R)) / RES_R);
  highp float tmpvar_39;
  tmpvar_39 = fract((tmpvar_29 * RES_R));
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_40.y = ((tmpvar_30 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_40.xy, 0.0);
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_42.y = ((tmpvar_30 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_44.y = ((tmpvar_30 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_44.xy, 0.0);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_46.y = ((tmpvar_30 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_47;
  tmpvar_47 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_46.xy, 0.0);
  tmpvar_19 = (((
    (tmpvar_41 * (1.0 - _lerp_20))
   + 
    (tmpvar_43 * _lerp_20)
  ) * (1.0 - tmpvar_39)) + ((
    (tmpvar_45 * (1.0 - _lerp_20))
   + 
    (tmpvar_47 * _lerp_20)
  ) * tmpvar_39));
  if ((r_11 <= xlat_mutableRt)) {
    highp float tmpvar_48;
    tmpvar_48 = (mieG * mieG);
    result_12 = ((tmpvar_19.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_17 * tmpvar_17))
    )) + ((
      ((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_48)) * pow ((
        (1.0 + tmpvar_48)
       - 
        ((2.0 * mieG) * tmpvar_17)
      ), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17)))
     / 
      (2.0 + tmpvar_48)
    )));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_49;
  L_49 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  highp float tmpvar_50;
  if ((L_49.x < 1.413)) {
    tmpvar_50 = pow ((L_49.x * 0.38317), 0.4545454);
  } else {
    tmpvar_50 = (1.0 - exp(-(L_49.x)));
  };
  L_49.x = tmpvar_50;
  highp float tmpvar_51;
  if ((L_49.y < 1.413)) {
    tmpvar_51 = pow ((L_49.y * 0.38317), 0.4545454);
  } else {
    tmpvar_51 = (1.0 - exp(-(L_49.y)));
  };
  L_49.y = tmpvar_51;
  highp float tmpvar_52;
  if ((L_49.z < 1.413)) {
    tmpvar_52 = pow ((L_49.z * 0.38317), 0.4545454);
  } else {
    tmpvar_52 = (1.0 - exp(-(L_49.z)));
  };
  L_49.z = tmpvar_52;
  highp vec4 tmpvar_53;
  tmpvar_53.w = 1.0;
  tmpvar_53.xyz = (_Alpha_Global * L_49);
  gl_FragData[0] = tmpvar_53;
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
    t4.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
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
    t1.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t25 = dot(t1.xyz, t1.xyz);
    t1.x = dot(_Globals_Origin.xyzx.xyz, t1.xyz);
    t24 = t24 + t25;
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
    t4.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
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
    t1.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t25 = dot(t1.xyz, t1.xyz);
    t1.x = dot(_Globals_Origin.xyzx.xyz, t1.xyz);
    t24 = t24 + t25;
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
// Stats: 424 math, 4 textures, 18 branches
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
  tmpvar_4 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, tmpvar_5);
  float tmpvar_7;
  tmpvar_7 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4)))
   - 
    (Rg * Rg)
  )));
  float tmpvar_9;
  if ((tmpvar_8 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_7) - sqrt(tmpvar_8)) / (2.0 * tmpvar_6));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_9 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 camera_11;
  camera_11 = (tmpvar_4 - _Globals_Origin);
  vec3 viewdir_12;
  viewdir_12.yz = tmpvar_5.yz;
  float rMu_13;
  float r_14;
  vec3 result_15;
  result_15 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _viewdirOffset);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_12);
  viewdir_12 = tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = dot (camera_11, tmpvar_16);
  rMu_13 = tmpvar_18;
  float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_18) - sqrt(
    (((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_19 * tmpvar_16));
    rMu_13 = (tmpvar_18 + tmpvar_19);
    r_14 = xlat_mutableRt;
  };
  float tmpvar_20;
  tmpvar_20 = dot (tmpvar_16, _Sun_WorldSunDir);
  float tmpvar_21;
  tmpvar_21 = (dot (camera_11, _Sun_WorldSunDir) / r_14);
  vec4 tmpvar_22;
  float _lerp_23;
  float tmpvar_24;
  float tmpvar_25;
  tmpvar_25 = (Rg * Rg);
  tmpvar_24 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_25));
  float tmpvar_26;
  tmpvar_26 = sqrt(((r_14 * r_14) - tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = (r_14 * (rMu_13 / r_14));
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_27 * tmpvar_27) - (r_14 * r_14)) + tmpvar_25);
  vec4 tmpvar_29;
  if (((tmpvar_27 < 0.0) && (tmpvar_28 > 0.0))) {
    vec4 tmpvar_30;
    tmpvar_30.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_30.w = (0.5 - (0.5 / RES_MU));
    tmpvar_29 = tmpvar_30;
  } else {
    vec4 tmpvar_31;
    tmpvar_31.x = -1.0;
    tmpvar_31.y = (tmpvar_24 * tmpvar_24);
    tmpvar_31.z = tmpvar_24;
    tmpvar_31.w = (0.5 + (0.5 / RES_MU));
    tmpvar_29 = tmpvar_31;
  };
  float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_R) + ((tmpvar_26 / tmpvar_24) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_33;
  tmpvar_33 = (tmpvar_29.w + ((
    ((tmpvar_27 * tmpvar_29.x) + sqrt((tmpvar_28 + tmpvar_29.y)))
   / 
    (tmpvar_26 + tmpvar_29.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_34;
  y_over_x_34 = (max (tmpvar_21, -0.1975) * 5.349625);
  float tmpvar_35;
  tmpvar_35 = (min (abs(y_over_x_34), 1.0) / max (abs(y_over_x_34), 1.0));
  float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  tmpvar_36 = (((
    ((((
      ((((-0.01213232 * tmpvar_36) + 0.05368138) * tmpvar_36) - 0.1173503)
     * tmpvar_36) + 0.1938925) * tmpvar_36) - 0.3326756)
   * tmpvar_36) + 0.9999793) * tmpvar_35);
  tmpvar_36 = (tmpvar_36 + (float(
    (abs(y_over_x_34) > 1.0)
  ) * (
    (tmpvar_36 * -2.0)
   + 1.570796)));
  float tmpvar_37;
  tmpvar_37 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_36 * sign(y_over_x_34)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_38;
  tmpvar_38 = (((tmpvar_20 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_39;
  tmpvar_39 = floor(tmpvar_38);
  _lerp_23 = (tmpvar_38 - tmpvar_39);
  float tmpvar_40;
  tmpvar_40 = (floor((
    (tmpvar_32 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_41;
  tmpvar_41 = (floor((tmpvar_32 * RES_R)) / RES_R);
  float tmpvar_42;
  tmpvar_42 = fract((tmpvar_32 * RES_R));
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_39 + tmpvar_37) / RES_NU);
  tmpvar_43.y = ((tmpvar_33 / RES_R) + tmpvar_40);
  vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_39 + tmpvar_37) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_33 / RES_R) + tmpvar_40);
  vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = ((tmpvar_39 + tmpvar_37) / RES_NU);
  tmpvar_45.y = ((tmpvar_33 / RES_R) + tmpvar_41);
  vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = (((tmpvar_39 + tmpvar_37) + 1.0) / RES_NU);
  tmpvar_46.y = ((tmpvar_33 / RES_R) + tmpvar_41);
  tmpvar_22 = (((
    (texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * (1.0 - _lerp_23))
   + 
    (texture2DLod (_Inscatter, tmpvar_44.xy, 0.0) * _lerp_23)
  ) * (1.0 - tmpvar_42)) + ((
    (texture2DLod (_Inscatter, tmpvar_45.xy, 0.0) * (1.0 - _lerp_23))
   + 
    (texture2DLod (_Inscatter, tmpvar_46.xy, 0.0) * _lerp_23)
  ) * tmpvar_42));
  if ((r_14 <= xlat_mutableRt)) {
    float tmpvar_47;
    tmpvar_47 = (mieG * mieG);
    result_15 = ((tmpvar_22.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_20 * tmpvar_20))
    )) + ((
      ((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_47)) * pow ((
        (1.0 + tmpvar_47)
       - 
        ((2.0 * mieG) * tmpvar_20)
      ), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20)))
     / 
      (2.0 + tmpvar_47)
    )));
  } else {
    result_15 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_15 * _Sun_Intensity);
  float tmpvar_48;
  float tmpvar_49;
  tmpvar_49 = dot (tmpvar_5, tmpvar_5);
  float tmpvar_50;
  tmpvar_50 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  float tmpvar_51;
  tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4)))
   - 
    (xlat_mutableRt * xlat_mutableRt)
  )));
  if ((tmpvar_51 < 0.0)) {
    tmpvar_48 = -1.0;
  } else {
    float tmpvar_52;
    tmpvar_52 = ((-(tmpvar_50) - sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    float tmpvar_53;
    if ((tmpvar_52 < 0.0)) {
      tmpvar_53 = ((-(tmpvar_50) + sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    } else {
      tmpvar_53 = tmpvar_52;
    };
    tmpvar_48 = tmpvar_53;
  };
  if ((tmpvar_48 != -1.0)) {
    worldPos_2 = (tmpvar_4 + (tmpvar_5 * tmpvar_48));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_48 != -1.0)) {
    int j_54;
    int i_55;
    i_55 = 0;
    while (true) {
      if ((i_55 >= 4)) {
        break;
      };
      if ((lightOccluders1[3][i_55] <= 0.0)) {
        break;
      };
      vec4 v_56;
      v_56.x = lightOccluders1[0][i_55];
      v_56.y = lightOccluders1[1][i_55];
      v_56.z = lightOccluders1[2][i_55];
      v_56.w = lightOccluders1[3][i_55];
      vec3 sphereDirection_57;
      vec3 lightDirection_58;
      vec3 tmpvar_59;
      tmpvar_59 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_60;
      tmpvar_60 = sqrt(dot (tmpvar_59, tmpvar_59));
      lightDirection_58 = (tmpvar_59 / vec3(tmpvar_60));
      vec3 tmpvar_61;
      tmpvar_61 = (v_56.xyz - worldPos_2);
      float tmpvar_62;
      tmpvar_62 = sqrt(dot (tmpvar_61, tmpvar_61));
      sphereDirection_57 = (tmpvar_61 / tmpvar_62);
      vec3 tmpvar_63;
      tmpvar_63 = ((lightDirection_58.yzx * sphereDirection_57.zxy) - (lightDirection_58.zxy * sphereDirection_57.yzx));
      float tmpvar_64;
      tmpvar_64 = min (1.0, sqrt(dot (tmpvar_63, tmpvar_63)));
      float tmpvar_65;
      tmpvar_65 = min (1.0, (vec3(lightOccluders1[3][i_55]) / tmpvar_62).x);
      float tmpvar_66;
      tmpvar_66 = clamp (((
        (-((vec3(tmpvar_60) * (
          (sign(tmpvar_64) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_64))
          ) * (1.570796 + 
            (abs(tmpvar_64) * (-0.2146018 + (abs(tmpvar_64) * (0.08656672 + 
              (abs(tmpvar_64) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_65) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_65))
          ) * (1.570796 + 
            (abs(tmpvar_65) * (-0.2146018 + (abs(tmpvar_65) * (0.08656672 + 
              (abs(tmpvar_65) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_67;
      tmpvar_67 = clamp ((dot (lightDirection_58, sphereDirection_57) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_66 * (tmpvar_66 * (3.0 - (2.0 * tmpvar_66))))
       * 
        (tmpvar_67 * (tmpvar_67 * (3.0 - (2.0 * tmpvar_67))))
      )));
      i_55++;
    };
    j_54 = 0;
    while (true) {
      if ((j_54 >= 4)) {
        break;
      };
      if ((lightOccluders2[3][j_54] <= 0.0)) {
        break;
      };
      vec4 v_68;
      v_68.x = lightOccluders2[0][j_54];
      v_68.y = lightOccluders2[1][j_54];
      v_68.z = lightOccluders2[2][j_54];
      v_68.w = lightOccluders2[3][j_54];
      vec3 sphereDirection_69;
      vec3 lightDirection_70;
      vec3 tmpvar_71;
      tmpvar_71 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_72;
      tmpvar_72 = sqrt(dot (tmpvar_71, tmpvar_71));
      lightDirection_70 = (tmpvar_71 / vec3(tmpvar_72));
      vec3 tmpvar_73;
      tmpvar_73 = (v_68.xyz - worldPos_2);
      float tmpvar_74;
      tmpvar_74 = sqrt(dot (tmpvar_73, tmpvar_73));
      sphereDirection_69 = (tmpvar_73 / tmpvar_74);
      vec3 tmpvar_75;
      tmpvar_75 = ((lightDirection_70.yzx * sphereDirection_69.zxy) - (lightDirection_70.zxy * sphereDirection_69.yzx));
      float tmpvar_76;
      tmpvar_76 = min (1.0, sqrt(dot (tmpvar_75, tmpvar_75)));
      float tmpvar_77;
      tmpvar_77 = min (1.0, (vec3(lightOccluders2[3][j_54]) / tmpvar_74).x);
      float tmpvar_78;
      tmpvar_78 = clamp (((
        (-((vec3(tmpvar_72) * (
          (sign(tmpvar_76) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_76))
          ) * (1.570796 + 
            (abs(tmpvar_76) * (-0.2146018 + (abs(tmpvar_76) * (0.08656672 + 
              (abs(tmpvar_76) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_77) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_77))
          ) * (1.570796 + 
            (abs(tmpvar_77) * (-0.2146018 + (abs(tmpvar_77) * (0.08656672 + 
              (abs(tmpvar_77) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_79;
      tmpvar_79 = clamp ((dot (lightDirection_70, sphereDirection_69) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_78 * (tmpvar_78 * (3.0 - (2.0 * tmpvar_78))))
       * 
        (tmpvar_79 * (tmpvar_79 * (3.0 - (2.0 * tmpvar_79))))
      )));
      j_54++;
    };
  };
  vec3 L_80;
  L_80 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  float tmpvar_81;
  if ((L_80.x < 1.413)) {
    tmpvar_81 = pow ((L_80.x * 0.38317), 0.4545454);
  } else {
    tmpvar_81 = (1.0 - exp(-(L_80.x)));
  };
  L_80.x = tmpvar_81;
  float tmpvar_82;
  if ((L_80.y < 1.413)) {
    tmpvar_82 = pow ((L_80.y * 0.38317), 0.4545454);
  } else {
    tmpvar_82 = (1.0 - exp(-(L_80.y)));
  };
  L_80.y = tmpvar_82;
  float tmpvar_83;
  if ((L_80.z < 1.413)) {
    tmpvar_83 = pow ((L_80.z * 0.38317), 0.4545454);
  } else {
    tmpvar_83 = (1.0 - exp(-(L_80.z)));
  };
  L_80.z = tmpvar_83;
  vec4 tmpvar_84;
  tmpvar_84.w = 1.0;
  tmpvar_84.xyz = (_Alpha_Global * L_80);
  gl_FragData[0] = tmpvar_84;
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
// Stats: 424 math, 4 textures, 18 branches
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
  tmpvar_4 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, tmpvar_5);
  highp float tmpvar_7;
  tmpvar_7 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4)))
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_9;
  if ((tmpvar_8 < 0.0)) {
    tmpvar_9 = -1.0;
  } else {
    tmpvar_9 = ((-(tmpvar_7) - sqrt(tmpvar_8)) / (2.0 * tmpvar_6));
  };
  bool tmpvar_10;
  tmpvar_10 = (tmpvar_9 > 0.0);
  if (!(tmpvar_10)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 camera_11;
  camera_11 = (tmpvar_4 - _Globals_Origin);
  highp vec3 viewdir_12;
  viewdir_12.yz = tmpvar_5.yz;
  highp float rMu_13;
  highp float r_14;
  highp vec3 result_15;
  result_15 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _viewdirOffset);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_12);
  viewdir_12 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (camera_11, tmpvar_16);
  rMu_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_18) - sqrt(
    (((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (xlat_mutableRt * xlat_mutableRt))
  )), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_19 * tmpvar_16));
    rMu_13 = (tmpvar_18 + tmpvar_19);
    r_14 = xlat_mutableRt;
  };
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_16, _Sun_WorldSunDir);
  highp float tmpvar_21;
  tmpvar_21 = (dot (camera_11, _Sun_WorldSunDir) / r_14);
  highp vec4 tmpvar_22;
  highp float _lerp_23;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (Rg * Rg);
  tmpvar_24 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_25));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(((r_14 * r_14) - tmpvar_25));
  highp float tmpvar_27;
  tmpvar_27 = (r_14 * (rMu_13 / r_14));
  highp float tmpvar_28;
  tmpvar_28 = (((tmpvar_27 * tmpvar_27) - (r_14 * r_14)) + tmpvar_25);
  highp vec4 tmpvar_29;
  if (((tmpvar_27 < 0.0) && (tmpvar_28 > 0.0))) {
    highp vec4 tmpvar_30;
    tmpvar_30.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_30.w = (0.5 - (0.5 / RES_MU));
    tmpvar_29 = tmpvar_30;
  } else {
    highp vec4 tmpvar_31;
    tmpvar_31.x = -1.0;
    tmpvar_31.y = (tmpvar_24 * tmpvar_24);
    tmpvar_31.z = tmpvar_24;
    tmpvar_31.w = (0.5 + (0.5 / RES_MU));
    tmpvar_29 = tmpvar_31;
  };
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_R) + ((tmpvar_26 / tmpvar_24) * (1.0 - 
    (1.0/(RES_R))
  )));
  highp float tmpvar_33;
  tmpvar_33 = (tmpvar_29.w + ((
    ((tmpvar_27 * tmpvar_29.x) + sqrt((tmpvar_28 + tmpvar_29.y)))
   / 
    (tmpvar_26 + tmpvar_29.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  highp float y_over_x_34;
  y_over_x_34 = (max (tmpvar_21, -0.1975) * 5.349625);
  highp float tmpvar_35;
  tmpvar_35 = (min (abs(y_over_x_34), 1.0) / max (abs(y_over_x_34), 1.0));
  highp float tmpvar_36;
  tmpvar_36 = (tmpvar_35 * tmpvar_35);
  tmpvar_36 = (((
    ((((
      ((((-0.01213232 * tmpvar_36) + 0.05368138) * tmpvar_36) - 0.1173503)
     * tmpvar_36) + 0.1938925) * tmpvar_36) - 0.3326756)
   * tmpvar_36) + 0.9999793) * tmpvar_35);
  tmpvar_36 = (tmpvar_36 + (float(
    (abs(y_over_x_34) > 1.0)
  ) * (
    (tmpvar_36 * -2.0)
   + 1.570796)));
  highp float tmpvar_37;
  tmpvar_37 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_36 * sign(y_over_x_34)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  highp float tmpvar_38;
  tmpvar_38 = (((tmpvar_20 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_39;
  tmpvar_39 = floor(tmpvar_38);
  _lerp_23 = (tmpvar_38 - tmpvar_39);
  highp float tmpvar_40;
  tmpvar_40 = (floor((
    (tmpvar_32 * RES_R)
   - 1.0)) / RES_R);
  highp float tmpvar_41;
  tmpvar_41 = (floor((tmpvar_32 * RES_R)) / RES_R);
  highp float tmpvar_42;
  tmpvar_42 = fract((tmpvar_32 * RES_R));
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_39 + tmpvar_37) / RES_NU);
  tmpvar_43.y = ((tmpvar_33 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_39 + tmpvar_37) + 1.0) / RES_NU);
  tmpvar_45.y = ((tmpvar_33 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.x = ((tmpvar_39 + tmpvar_37) / RES_NU);
  tmpvar_47.y = ((tmpvar_33 / RES_R) + tmpvar_41);
  lowp vec4 tmpvar_48;
  tmpvar_48 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_47.xy, 0.0);
  highp vec4 tmpvar_49;
  tmpvar_49.zw = vec2(0.0, 0.0);
  tmpvar_49.x = (((tmpvar_39 + tmpvar_37) + 1.0) / RES_NU);
  tmpvar_49.y = ((tmpvar_33 / RES_R) + tmpvar_41);
  lowp vec4 tmpvar_50;
  tmpvar_50 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_49.xy, 0.0);
  tmpvar_22 = (((
    (tmpvar_44 * (1.0 - _lerp_23))
   + 
    (tmpvar_46 * _lerp_23)
  ) * (1.0 - tmpvar_42)) + ((
    (tmpvar_48 * (1.0 - _lerp_23))
   + 
    (tmpvar_50 * _lerp_23)
  ) * tmpvar_42));
  if ((r_14 <= xlat_mutableRt)) {
    highp float tmpvar_51;
    tmpvar_51 = (mieG * mieG);
    result_15 = ((tmpvar_22.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_20 * tmpvar_20))
    )) + ((
      ((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_51)) * pow ((
        (1.0 + tmpvar_51)
       - 
        ((2.0 * mieG) * tmpvar_20)
      ), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20)))
     / 
      (2.0 + tmpvar_51)
    )));
  } else {
    result_15 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_15 * _Sun_Intensity);
  highp float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_5, tmpvar_5);
  highp float tmpvar_54;
  tmpvar_54 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  highp float tmpvar_55;
  tmpvar_55 = ((tmpvar_54 * tmpvar_54) - ((4.0 * tmpvar_53) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4)))
   - 
    (xlat_mutableRt * xlat_mutableRt)
  )));
  if ((tmpvar_55 < 0.0)) {
    tmpvar_52 = -1.0;
  } else {
    highp float tmpvar_56;
    tmpvar_56 = ((-(tmpvar_54) - sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
    highp float tmpvar_57;
    if ((tmpvar_56 < 0.0)) {
      tmpvar_57 = ((-(tmpvar_54) + sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
    } else {
      tmpvar_57 = tmpvar_56;
    };
    tmpvar_52 = tmpvar_57;
  };
  if ((tmpvar_52 != -1.0)) {
    worldPos_2 = (tmpvar_4 + (tmpvar_5 * tmpvar_52));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_52 != -1.0)) {
    highp int j_58;
    highp int i_59;
    i_59 = 0;
    while (true) {
      if ((i_59 >= 4)) {
        break;
      };
      if ((lightOccluders1[3][i_59] <= 0.0)) {
        break;
      };
      highp vec4 v_60;
      v_60.x = lightOccluders1[0][i_59];
      v_60.y = lightOccluders1[1][i_59];
      v_60.z = lightOccluders1[2][i_59];
      v_60.w = lightOccluders1[3][i_59];
      highp vec3 sphereDirection_61;
      highp vec3 lightDirection_62;
      highp vec3 tmpvar_63;
      tmpvar_63 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_64;
      tmpvar_64 = sqrt(dot (tmpvar_63, tmpvar_63));
      lightDirection_62 = (tmpvar_63 / vec3(tmpvar_64));
      highp vec3 tmpvar_65;
      tmpvar_65 = (v_60.xyz - worldPos_2);
      highp float tmpvar_66;
      tmpvar_66 = sqrt(dot (tmpvar_65, tmpvar_65));
      sphereDirection_61 = (tmpvar_65 / tmpvar_66);
      highp vec3 tmpvar_67;
      tmpvar_67 = ((lightDirection_62.yzx * sphereDirection_61.zxy) - (lightDirection_62.zxy * sphereDirection_61.yzx));
      highp float tmpvar_68;
      tmpvar_68 = min (1.0, sqrt(dot (tmpvar_67, tmpvar_67)));
      highp float tmpvar_69;
      tmpvar_69 = min (1.0, (vec3(lightOccluders1[3][i_59]) / tmpvar_66).x);
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
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_70 * (tmpvar_70 * (3.0 - (2.0 * tmpvar_70))))
       * 
        (tmpvar_71 * (tmpvar_71 * (3.0 - (2.0 * tmpvar_71))))
      )));
      i_59++;
    };
    j_58 = 0;
    while (true) {
      if ((j_58 >= 4)) {
        break;
      };
      if ((lightOccluders2[3][j_58] <= 0.0)) {
        break;
      };
      highp vec4 v_72;
      v_72.x = lightOccluders2[0][j_58];
      v_72.y = lightOccluders2[1][j_58];
      v_72.z = lightOccluders2[2][j_58];
      v_72.w = lightOccluders2[3][j_58];
      highp vec3 sphereDirection_73;
      highp vec3 lightDirection_74;
      highp vec3 tmpvar_75;
      tmpvar_75 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_76;
      tmpvar_76 = sqrt(dot (tmpvar_75, tmpvar_75));
      lightDirection_74 = (tmpvar_75 / vec3(tmpvar_76));
      highp vec3 tmpvar_77;
      tmpvar_77 = (v_72.xyz - worldPos_2);
      highp float tmpvar_78;
      tmpvar_78 = sqrt(dot (tmpvar_77, tmpvar_77));
      sphereDirection_73 = (tmpvar_77 / tmpvar_78);
      highp vec3 tmpvar_79;
      tmpvar_79 = ((lightDirection_74.yzx * sphereDirection_73.zxy) - (lightDirection_74.zxy * sphereDirection_73.yzx));
      highp float tmpvar_80;
      tmpvar_80 = min (1.0, sqrt(dot (tmpvar_79, tmpvar_79)));
      highp float tmpvar_81;
      tmpvar_81 = min (1.0, (vec3(lightOccluders2[3][j_58]) / tmpvar_78).x);
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
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_82 * (tmpvar_82 * (3.0 - (2.0 * tmpvar_82))))
       * 
        (tmpvar_83 * (tmpvar_83 * (3.0 - (2.0 * tmpvar_83))))
      )));
      j_58++;
    };
  };
  highp vec3 L_84;
  L_84 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  highp float tmpvar_85;
  if ((L_84.x < 1.413)) {
    tmpvar_85 = pow ((L_84.x * 0.38317), 0.4545454);
  } else {
    tmpvar_85 = (1.0 - exp(-(L_84.x)));
  };
  L_84.x = tmpvar_85;
  highp float tmpvar_86;
  if ((L_84.y < 1.413)) {
    tmpvar_86 = pow ((L_84.y * 0.38317), 0.4545454);
  } else {
    tmpvar_86 = (1.0 - exp(-(L_84.y)));
  };
  L_84.y = tmpvar_86;
  highp float tmpvar_87;
  if ((L_84.z < 1.413)) {
    tmpvar_87 = pow ((L_84.z * 0.38317), 0.4545454);
  } else {
    tmpvar_87 = (1.0 - exp(-(L_84.z)));
  };
  L_84.z = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88.w = 1.0;
  tmpvar_88.xyz = (_Alpha_Global * L_84);
  gl_FragData[0] = tmpvar_88;
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
highp vec3 t0;
highp vec3 t1;
bvec3 tb1;
highp vec4 t2;
highp int ti2;
bool tb2;
highp vec3 t3;
highp vec4 t4;
highp vec3 t5;
highp vec4 t6;
lowp vec4 t10_6;
highp vec4 t7;
lowp vec4 t10_7;
highp vec4 t8;
lowp vec4 t10_8;
highp float t9;
highp float t10;
highp float t11;
highp int ti11;
bool tb11;
highp float t12;
highp int ti12;
bool tb12;
highp float t13;
highp int ti13;
highp vec3 t14;
highp float t19;
highp float t20;
bool tb20;
highp float t21;
bool tb21;
highp float t22;
highp float t27;
highp float t28;
highp float t29;
bool tb29;
highp float t30;
highp float t31;
highp int ti31;
bool tb31;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t27 = dot(t1.xyz, t1.xyz);
    t27 = inversesqrt(t27);
    t2.yzw = vec3(t27) * t1.xyz;
    t10 = dot(t2.yzw, t2.yzw);
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t19 = dot(t2.yzw, t3.xyz);
    t28 = t19 + t19;
    t30 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t4.x = dot(t0.xyz, t0.xyz);
    t30 = t30 + t4.x;
    t4.x = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t30 = (-t4.x) * 2.0 + t30;
    t4.x = Rg * Rg;
    t13 = (-Rg) * Rg + t30;
    t28 = t28 * t28;
    t22 = t10 * 4.0;
    t13 = (-t22) * t13 + t28;
    ti31 = int((t13<0.0) ? 0xFFFFFFFFu : uint(0u));
    t13 = sqrt(t13);
    t13 = (-t19) * 2.0 + (-t13);
    t10 = t10 + t10;
    t13 = t13 / t10;
    ti13 = int((0.0>=t13) ? 0xFFFFFFFFu : uint(0u));
    ti13 = int(uint(ti13) | uint(ti31));
    t13 = (ti13 != 0) ? _RimExposure : _Exposure;
    t31 = (-Rg) + Rt;
    t5.x = t31 * _experimentalAtmoScale + Rg;
    t2.x = t1.x * t27 + _viewdirOffset;
    t27 = dot(t2.xzw, t2.xzw);
    t27 = inversesqrt(t27);
    t6.xyz = vec3(t27) * t2.xzw;
    t27 = dot(t3.xyz, t3.xyz);
    t7.x = sqrt(t27);
    t7.y = dot(t3.xyz, t6.xyz);
    t27 = t7.y * t7.y + (-t27);
    t27 = t5.x * t5.x + t27;
    t27 = sqrt(t27);
    t27 = (-t27) + (-t7.y);
    t27 = max(t27, 0.0);
    tb1.x = 0.0<t27;
    t8.xyz = vec3(t27) * t6.xyz + t3.xyz;
    t5.y = t27 + t7.y;
    t3.xyz = (tb1.x) ? t8.xyz : t3.xyz;
    t14.xy = (tb1.x) ? t5.xy : t7.xy;
    t27 = dot(t6.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.x = dot(t3.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.x = t1.x / t14.x;
    t2.x = t5.x * t5.x + (-t4.x);
    t6.z = sqrt(t2.x);
    t2.x = t14.x * t14.x;
    t3.x = t14.x * t14.x + (-t4.x);
    t3.x = sqrt(t3.x);
    t2.x = t14.y * t14.y + (-t2.x);
    t2.x = Rg * Rg + t2.x;
    tb12 = t14.y<0.0;
    tb21 = 0.0<t2.x;
    ti12 = int(uint(tb21) * 0xffffffffu & uint(tb12) * 0xffffffffu);
    t7.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t8.w = (-t7.x) + 0.5;
    t6.y = t6.z * t6.z;
    t6.w = t7.x + 0.5;
    t8.xyz = vec3(1.0, 0.0, 0.0);
    t6.x = -1.0;
    t8 = (int(ti12) != 0) ? t8 : t6;
    t12 = t3.x / t6.z;
    t6.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t6.xyz = (-t6.xyz) + vec3(1.0, 0.5, 1.0);
    t12 = t12 * t6.x + t7.y;
    t2.x = t2.x + t8.y;
    t2.x = sqrt(t2.x);
    t2.x = t14.y * t8.x + t2.x;
    t3.x = t3.x + t8.z;
    t2.x = t2.x / t3.x;
    t2.x = t2.x * t6.y + t8.w;
    t1.x = max(t1.x, -0.197500005);
    t1.x = t1.x * 5.34962368;
    t3.x = min(abs(t1.x), 1.0);
    t21 = max(abs(t1.x), 1.0);
    t21 = float(1.0) / t21;
    t3.x = t21 * t3.x;
    t21 = t3.x * t3.x;
    t4.x = t21 * 0.0208350997 + -0.0851330012;
    t4.x = t21 * t4.x + 0.180141002;
    t4.x = t21 * t4.x + -0.330299497;
    t21 = t21 * t4.x + 0.999866009;
    t4.x = t21 * t3.x;
    tb31 = 1.0<abs(t1.x);
    t4.x = t4.x * -2.0 + 1.57079637;
    t4.x = tb31 ? t4.x : float(0.0);
    t3.x = t3.x * t21 + t4.x;
    t1.x = min(t1.x, 1.0);
    tb1.x = t1.x<(-t1.x);
    t1.x = (tb1.x) ? (-t3.x) : t3.x;
    t1.x = t1.x * 0.909090877 + 0.74000001;
    t1.x = t1.x * 0.5;
    t1.x = t1.x * t6.z + t7.z;
    t3.x = t27 + 1.0;
    t3.x = t3.x * 0.5;
    t21 = RES_NU + -1.0;
    t4.x = t21 * t3.x;
    t4.x = floor(t4.x);
    t3.x = t3.x * t21 + (-t4.x);
    t21 = t12 * RES_R;
    t12 = t12 * RES_R + -1.0;
    t12 = floor(t12);
    t12 = t12 / RES_R;
    t31 = floor(t21);
    t31 = t31 / RES_R;
    t21 = fract(t21);
    t1.x = t1.x + t4.x;
    t6.y = t1.x / RES_NU;
    t2.x = t2.x / RES_R;
    t6.z = t12 + t2.x;
    t10_7 = textureLod(_Inscatter, t6.yz, 0.0);
    t12 = (-t3.x) + 1.0;
    t1.x = t1.x + 1.0;
    t6.x = t1.x / RES_NU;
    t10_8 = textureLod(_Inscatter, t6.xz, 0.0);
    t8 = t3.xxxx * t10_8;
    t7 = t10_7 * vec4(t12) + t8;
    t6.w = t31 + t2.x;
    t10_8 = textureLod(_Inscatter, t6.yw, 0.0);
    t10_6 = textureLod(_Inscatter, t6.xw, 0.0);
    t6 = t3.xxxx * t10_6;
    t6 = t10_8 * vec4(t12) + t6;
    t1.x = (-t21) + 1.0;
    t6 = vec4(t21) * t6;
    t6 = t7 * t1.xxxx + t6;
    tb1.x = t5.x>=t14.x;
    t3.xyz = t6.www * t6.xyz;
    t2.x = max(t6.x, 9.99999975e-005);
    t3.xyz = t3.xyz / t2.xxx;
    t14.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t3.xyz = t3.xyz * t14.xyz;
    t4.xw = vec2(M_PI) * vec2(16.0, 4.0);
    t4.xw = vec2(3.0, 1.5) / t4.xw;
    t2.x = t27 * t27 + 1.0;
    t4.x = t2.x * t4.x;
    t14.x = (-mieG) * mieG + 1.0;
    t31 = t4.w * t14.x;
    t14.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t27 = dot(vec2(t27), vec2(vec2(mieG, mieG)));
    t27 = (-t27) + t14.x;
    t27 = log2(t27);
    t27 = t27 * -1.5;
    t27 = exp2(t27);
    t27 = t27 * t31;
    t27 = t2.x * t27;
    t27 = t27 / t14.y;
    t3.xyz = vec3(t27) * t3.xyz;
    t3.xyz = t6.xyz * t4.xxx + t3.xyz;
    t3.xyz = mix(vec3(0.0, 0.0, 0.0), t3.xyz, vec3(tb1.xxx));
    t3.xyz = t3.xyz * vec3(_Sun_Intensity);
    t27 = (-t5.x) * t5.x + t30;
    t27 = (-t22) * t27 + t28;
    tb1.x = t27>=0.0;
    t27 = sqrt(t27);
    t28 = (-t19) * 2.0 + (-t27);
    t28 = t28 / t10;
    tb2 = t28<0.0;
    t27 = (-t19) * 2.0 + t27;
    t27 = t27 / t10;
    t27 = (tb2) ? t27 : t28;
    t27 = (tb1.x) ? t27 : -1.0;
    tb1.x = t27!=-1.0;
    if(tb1.x){
        t0.xyz = t2.yzw * vec3(t27) + t0.xyz;
        t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
        t27 = dot(t1.xyz, t1.xyz);
        t27 = sqrt(t27);
        t1.xyz = t1.xyz / vec3(t27);
        t28 = 1.0;
        ti2 = 0x0;
        while(true){
            tb11 = ti2>=0x4;
            if(tb11){break;}
            t11 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
            tb20 = 0.0>=t11;
            if(tb20){
                break;
            //ENDIF
            }
            t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
            t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
            t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
            t4.xzw = (-t0.xyz) + t5.xyz;
            t20 = dot(t4.xzw, t4.xzw);
            t20 = sqrt(t20);
            t4.xzw = t4.xzw / vec3(t20);
            t5.xyz = t1.zxy * t4.zwx;
            t5.xyz = t1.yzx * t4.wxz + (-t5.xyz);
            t29 = dot(t5.xyz, t5.xyz);
            t29 = sqrt(t29);
            t29 = min(t29, 1.0);
            t30 = (-t29) + 1.0;
            t30 = sqrt(t30);
            t5.x = t29 * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * t29 + -0.212114394;
            t29 = t5.x * t29 + 1.57072878;
            t29 = (-t29) * t30 + 1.57079637;
            t11 = t11 / t20;
            t11 = min(t11, 1.0);
            t20 = -abs(t11) + 1.0;
            t20 = sqrt(t20);
            t30 = abs(t11) * -0.0187292993 + 0.0742610022;
            t30 = t30 * abs(t11) + -0.212114394;
            t30 = t30 * abs(t11) + 1.57072878;
            t5.x = t20 * t30;
            t5.x = t5.x * -2.0 + 3.14159274;
            tb11 = t11<(-t11);
            t11 = tb11 ? t5.x : float(0.0);
            t11 = t30 * t20 + t11;
            t11 = (-t11) + 1.57079637;
            t11 = (-t11) + t29;
            t11 = t27 * t11;
            t11 = (-t11) / sunPosAndRadius.w;
            t11 = t11 + 1.0;
            t11 = t11 * 0.5;
            t11 = clamp(t11, 0.0, 1.0);
            t20 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t20;
            t20 = dot(t1.xyz, t4.xzw);
            t20 = t20 * 5.0;
            t20 = clamp(t20, 0.0, 1.0);
            t29 = t20 * -2.0 + 3.0;
            t20 = t20 * t20;
            t20 = t20 * t29;
            t11 = (-t11) * t20 + 1.0;
            t28 = t28 * t11;
            ti2 = ti2 + 0x1;
        }
        t2.x = t28;
        ti11 = 0x0;
        while(true){
            tb20 = ti11>=0x4;
            if(tb20){break;}
            t20 = dot(lightOccluders2[3], immediateConstBufferF[ti11]);
            tb29 = 0.0>=t20;
            if(tb29){
                break;
            //ENDIF
            }
            t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti11]);
            t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti11]);
            t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti11]);
            t4.xzw = (-t0.xyz) + t5.xyz;
            t29 = dot(t4.xzw, t4.xzw);
            t29 = sqrt(t29);
            t4.xzw = t4.xzw / vec3(t29);
            t5.xyz = t1.zxy * t4.zwx;
            t5.xyz = t1.yzx * t4.wxz + (-t5.xyz);
            t30 = dot(t5.xyz, t5.xyz);
            t30 = sqrt(t30);
            t30 = min(t30, 1.0);
            t5.x = (-t30) + 1.0;
            t5.x = sqrt(t5.x);
            t14.x = t30 * -0.0187292993 + 0.0742610022;
            t14.x = t14.x * t30 + -0.212114394;
            t30 = t14.x * t30 + 1.57072878;
            t30 = (-t30) * t5.x + 1.57079637;
            t20 = t20 / t29;
            t20 = min(t20, 1.0);
            t29 = -abs(t20) + 1.0;
            t29 = sqrt(t29);
            t5.x = abs(t20) * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * abs(t20) + -0.212114394;
            t5.x = t5.x * abs(t20) + 1.57072878;
            t14.x = t29 * t5.x;
            t14.x = t14.x * -2.0 + 3.14159274;
            tb20 = t20<(-t20);
            t20 = tb20 ? t14.x : float(0.0);
            t20 = t5.x * t29 + t20;
            t20 = (-t20) + 1.57079637;
            t20 = (-t20) + t30;
            t20 = t27 * t20;
            t20 = (-t20) / sunPosAndRadius.w;
            t20 = t20 + 1.0;
            t20 = t20 * 0.5;
            t20 = clamp(t20, 0.0, 1.0);
            t29 = t20 * -2.0 + 3.0;
            t20 = t20 * t20;
            t20 = t20 * t29;
            t29 = dot(t1.xyz, t4.xzw);
            t29 = t29 * 5.0;
            t29 = clamp(t29, 0.0, 1.0);
            t30 = t29 * -2.0 + 3.0;
            t29 = t29 * t29;
            t29 = t29 * t30;
            t20 = (-t20) * t29 + 1.0;
            t2.x = t20 * t2.x;
            ti11 = ti11 + 0x1;
        }
    } else {
        t2.x = 1.0;
    //ENDIF
    }
    t0.xyz = t2.xxx * t3.xyz;
    t0.xyz = vec3(t13) * t0.xyz;
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
    t9 = exp2(t0.y);
    t9 = (-t9) + 1.0;
    t2.z = (tb1.z) ? t0.x : t9;
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
vec3 t0;
vec3 t1;
bvec3 tb1;
vec4 t2;
int ti2;
bool tb2;
vec3 t3;
vec4 t4;
vec3 t5;
vec4 t6;
lowp vec4 t10_6;
vec4 t7;
lowp vec4 t10_7;
vec4 t8;
lowp vec4 t10_8;
float t9;
float t10;
float t11;
int ti11;
bool tb11;
float t12;
int ti12;
bool tb12;
float t13;
int ti13;
vec3 t14;
float t19;
float t20;
bool tb20;
float t21;
bool tb21;
float t22;
float t27;
float t28;
float t29;
bool tb29;
float t30;
float t31;
int ti31;
bool tb31;
void main()
{
    t0.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0);
    t1.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t27 = dot(t1.xyz, t1.xyz);
    t27 = inversesqrt(t27);
    t2.yzw = vec3(t27) * t1.xyz;
    t10 = dot(t2.yzw, t2.yzw);
    t3.xyz = _WorldSpaceCameraPos.xyzx.xyz * vec3(6000.0, 6000.0, 6000.0) + (-_Globals_Origin.xyzx.xyz);
    t19 = dot(t2.yzw, t3.xyz);
    t28 = t19 + t19;
    t30 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t4.x = dot(t0.xyz, t0.xyz);
    t30 = t30 + t4.x;
    t4.x = dot(_Globals_Origin.xyzx.xyz, t0.xyz);
    t30 = (-t4.x) * 2.0 + t30;
    t4.x = Rg * Rg;
    t13 = (-Rg) * Rg + t30;
    t28 = t28 * t28;
    t22 = t10 * 4.0;
    t13 = (-t22) * t13 + t28;
    ti31 = int((t13<0.0) ? 0xFFFFFFFFu : uint(0u));
    t13 = sqrt(t13);
    t13 = (-t19) * 2.0 + (-t13);
    t10 = t10 + t10;
    t13 = t13 / t10;
    ti13 = int((0.0>=t13) ? 0xFFFFFFFFu : uint(0u));
    ti13 = int(uint(ti13) | uint(ti31));
    t13 = (ti13 != 0) ? _RimExposure : _Exposure;
    t31 = (-Rg) + Rt;
    t5.x = t31 * _experimentalAtmoScale + Rg;
    t2.x = t1.x * t27 + _viewdirOffset;
    t27 = dot(t2.xzw, t2.xzw);
    t27 = inversesqrt(t27);
    t6.xyz = vec3(t27) * t2.xzw;
    t27 = dot(t3.xyz, t3.xyz);
    t7.x = sqrt(t27);
    t7.y = dot(t3.xyz, t6.xyz);
    t27 = t7.y * t7.y + (-t27);
    t27 = t5.x * t5.x + t27;
    t27 = sqrt(t27);
    t27 = (-t27) + (-t7.y);
    t27 = max(t27, 0.0);
    tb1.x = 0.0<t27;
    t8.xyz = vec3(t27) * t6.xyz + t3.xyz;
    t5.y = t27 + t7.y;
    t3.xyz = (tb1.x) ? t8.xyz : t3.xyz;
    t14.xy = (tb1.x) ? t5.xy : t7.xy;
    t27 = dot(t6.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.x = dot(t3.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.x = t1.x / t14.x;
    t2.x = t5.x * t5.x + (-t4.x);
    t6.z = sqrt(t2.x);
    t2.x = t14.x * t14.x;
    t3.x = t14.x * t14.x + (-t4.x);
    t3.x = sqrt(t3.x);
    t2.x = t14.y * t14.y + (-t2.x);
    t2.x = Rg * Rg + t2.x;
    tb12 = t14.y<0.0;
    tb21 = 0.0<t2.x;
    ti12 = int(uint(tb21) * 0xffffffffu & uint(tb12) * 0xffffffffu);
    t7.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t8.w = (-t7.x) + 0.5;
    t6.y = t6.z * t6.z;
    t6.w = t7.x + 0.5;
    t8.xyz = vec3(1.0, 0.0, 0.0);
    t6.x = -1.0;
    t8 = (int(ti12) != 0) ? t8 : t6;
    t12 = t3.x / t6.z;
    t6.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t6.xyz = (-t6.xyz) + vec3(1.0, 0.5, 1.0);
    t12 = t12 * t6.x + t7.y;
    t2.x = t2.x + t8.y;
    t2.x = sqrt(t2.x);
    t2.x = t14.y * t8.x + t2.x;
    t3.x = t3.x + t8.z;
    t2.x = t2.x / t3.x;
    t2.x = t2.x * t6.y + t8.w;
    t1.x = max(t1.x, -0.197500005);
    t1.x = t1.x * 5.34962368;
    t3.x = min(abs(t1.x), 1.0);
    t21 = max(abs(t1.x), 1.0);
    t21 = float(1.0) / t21;
    t3.x = t21 * t3.x;
    t21 = t3.x * t3.x;
    t4.x = t21 * 0.0208350997 + -0.0851330012;
    t4.x = t21 * t4.x + 0.180141002;
    t4.x = t21 * t4.x + -0.330299497;
    t21 = t21 * t4.x + 0.999866009;
    t4.x = t21 * t3.x;
    tb31 = 1.0<abs(t1.x);
    t4.x = t4.x * -2.0 + 1.57079637;
    t4.x = tb31 ? t4.x : float(0.0);
    t3.x = t3.x * t21 + t4.x;
    t1.x = min(t1.x, 1.0);
    tb1.x = t1.x<(-t1.x);
    t1.x = (tb1.x) ? (-t3.x) : t3.x;
    t1.x = t1.x * 0.909090877 + 0.74000001;
    t1.x = t1.x * 0.5;
    t1.x = t1.x * t6.z + t7.z;
    t3.x = t27 + 1.0;
    t3.x = t3.x * 0.5;
    t21 = RES_NU + -1.0;
    t4.x = t21 * t3.x;
    t4.x = floor(t4.x);
    t3.x = t3.x * t21 + (-t4.x);
    t21 = t12 * RES_R;
    t12 = t12 * RES_R + -1.0;
    t12 = floor(t12);
    t12 = t12 / RES_R;
    t31 = floor(t21);
    t31 = t31 / RES_R;
    t21 = fract(t21);
    t1.x = t1.x + t4.x;
    t6.y = t1.x / RES_NU;
    t2.x = t2.x / RES_R;
    t6.z = t12 + t2.x;
    t10_7 = textureLod(_Inscatter, t6.yz, 0.0);
    t12 = (-t3.x) + 1.0;
    t1.x = t1.x + 1.0;
    t6.x = t1.x / RES_NU;
    t10_8 = textureLod(_Inscatter, t6.xz, 0.0);
    t8 = t3.xxxx * t10_8;
    t7 = t10_7 * vec4(t12) + t8;
    t6.w = t31 + t2.x;
    t10_8 = textureLod(_Inscatter, t6.yw, 0.0);
    t10_6 = textureLod(_Inscatter, t6.xw, 0.0);
    t6 = t3.xxxx * t10_6;
    t6 = t10_8 * vec4(t12) + t6;
    t1.x = (-t21) + 1.0;
    t6 = vec4(t21) * t6;
    t6 = t7 * t1.xxxx + t6;
    tb1.x = t5.x>=t14.x;
    t3.xyz = t6.www * t6.xyz;
    t2.x = max(t6.x, 9.99999975e-005);
    t3.xyz = t3.xyz / t2.xxx;
    t14.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t3.xyz = t3.xyz * t14.xyz;
    t4.xw = vec2(M_PI) * vec2(16.0, 4.0);
    t4.xw = vec2(3.0, 1.5) / t4.xw;
    t2.x = t27 * t27 + 1.0;
    t4.x = t2.x * t4.x;
    t14.x = (-mieG) * mieG + 1.0;
    t31 = t4.w * t14.x;
    t14.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t27 = dot(vec2(t27), vec2(vec2(mieG, mieG)));
    t27 = (-t27) + t14.x;
    t27 = log2(t27);
    t27 = t27 * -1.5;
    t27 = exp2(t27);
    t27 = t27 * t31;
    t27 = t2.x * t27;
    t27 = t27 / t14.y;
    t3.xyz = vec3(t27) * t3.xyz;
    t3.xyz = t6.xyz * t4.xxx + t3.xyz;
    t3.xyz = mix(vec3(0.0, 0.0, 0.0), t3.xyz, vec3(tb1.xxx));
    t3.xyz = t3.xyz * vec3(_Sun_Intensity);
    t27 = (-t5.x) * t5.x + t30;
    t27 = (-t22) * t27 + t28;
    tb1.x = t27>=0.0;
    t27 = sqrt(t27);
    t28 = (-t19) * 2.0 + (-t27);
    t28 = t28 / t10;
    tb2 = t28<0.0;
    t27 = (-t19) * 2.0 + t27;
    t27 = t27 / t10;
    t27 = (tb2) ? t27 : t28;
    t27 = (tb1.x) ? t27 : -1.0;
    tb1.x = t27!=-1.0;
    if(tb1.x){
        t0.xyz = t2.yzw * vec3(t27) + t0.xyz;
        t1.xyz = (-t0.xyz) + sunPosAndRadius.xyz;
        t27 = dot(t1.xyz, t1.xyz);
        t27 = sqrt(t27);
        t1.xyz = t1.xyz / vec3(t27);
        t28 = 1.0;
        ti2 = 0x0;
        while(true){
            tb11 = ti2>=0x4;
            if(tb11){break;}
            t11 = dot(lightOccluders1[3], immediateConstBufferF[ti2]);
            tb20 = 0.0>=t11;
            if(tb20){
                break;
            //ENDIF
            }
            t5.x = dot(lightOccluders1[0], immediateConstBufferF[ti2]);
            t5.y = dot(lightOccluders1[1], immediateConstBufferF[ti2]);
            t5.z = dot(lightOccluders1[2], immediateConstBufferF[ti2]);
            t4.xzw = (-t0.xyz) + t5.xyz;
            t20 = dot(t4.xzw, t4.xzw);
            t20 = sqrt(t20);
            t4.xzw = t4.xzw / vec3(t20);
            t5.xyz = t1.zxy * t4.zwx;
            t5.xyz = t1.yzx * t4.wxz + (-t5.xyz);
            t29 = dot(t5.xyz, t5.xyz);
            t29 = sqrt(t29);
            t29 = min(t29, 1.0);
            t30 = (-t29) + 1.0;
            t30 = sqrt(t30);
            t5.x = t29 * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * t29 + -0.212114394;
            t29 = t5.x * t29 + 1.57072878;
            t29 = (-t29) * t30 + 1.57079637;
            t11 = t11 / t20;
            t11 = min(t11, 1.0);
            t20 = -abs(t11) + 1.0;
            t20 = sqrt(t20);
            t30 = abs(t11) * -0.0187292993 + 0.0742610022;
            t30 = t30 * abs(t11) + -0.212114394;
            t30 = t30 * abs(t11) + 1.57072878;
            t5.x = t20 * t30;
            t5.x = t5.x * -2.0 + 3.14159274;
            tb11 = t11<(-t11);
            t11 = tb11 ? t5.x : float(0.0);
            t11 = t30 * t20 + t11;
            t11 = (-t11) + 1.57079637;
            t11 = (-t11) + t29;
            t11 = t27 * t11;
            t11 = (-t11) / sunPosAndRadius.w;
            t11 = t11 + 1.0;
            t11 = t11 * 0.5;
            t11 = clamp(t11, 0.0, 1.0);
            t20 = t11 * -2.0 + 3.0;
            t11 = t11 * t11;
            t11 = t11 * t20;
            t20 = dot(t1.xyz, t4.xzw);
            t20 = t20 * 5.0;
            t20 = clamp(t20, 0.0, 1.0);
            t29 = t20 * -2.0 + 3.0;
            t20 = t20 * t20;
            t20 = t20 * t29;
            t11 = (-t11) * t20 + 1.0;
            t28 = t28 * t11;
            ti2 = ti2 + 0x1;
        }
        t2.x = t28;
        ti11 = 0x0;
        while(true){
            tb20 = ti11>=0x4;
            if(tb20){break;}
            t20 = dot(lightOccluders2[3], immediateConstBufferF[ti11]);
            tb29 = 0.0>=t20;
            if(tb29){
                break;
            //ENDIF
            }
            t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti11]);
            t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti11]);
            t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti11]);
            t4.xzw = (-t0.xyz) + t5.xyz;
            t29 = dot(t4.xzw, t4.xzw);
            t29 = sqrt(t29);
            t4.xzw = t4.xzw / vec3(t29);
            t5.xyz = t1.zxy * t4.zwx;
            t5.xyz = t1.yzx * t4.wxz + (-t5.xyz);
            t30 = dot(t5.xyz, t5.xyz);
            t30 = sqrt(t30);
            t30 = min(t30, 1.0);
            t5.x = (-t30) + 1.0;
            t5.x = sqrt(t5.x);
            t14.x = t30 * -0.0187292993 + 0.0742610022;
            t14.x = t14.x * t30 + -0.212114394;
            t30 = t14.x * t30 + 1.57072878;
            t30 = (-t30) * t5.x + 1.57079637;
            t20 = t20 / t29;
            t20 = min(t20, 1.0);
            t29 = -abs(t20) + 1.0;
            t29 = sqrt(t29);
            t5.x = abs(t20) * -0.0187292993 + 0.0742610022;
            t5.x = t5.x * abs(t20) + -0.212114394;
            t5.x = t5.x * abs(t20) + 1.57072878;
            t14.x = t29 * t5.x;
            t14.x = t14.x * -2.0 + 3.14159274;
            tb20 = t20<(-t20);
            t20 = tb20 ? t14.x : float(0.0);
            t20 = t5.x * t29 + t20;
            t20 = (-t20) + 1.57079637;
            t20 = (-t20) + t30;
            t20 = t27 * t20;
            t20 = (-t20) / sunPosAndRadius.w;
            t20 = t20 + 1.0;
            t20 = t20 * 0.5;
            t20 = clamp(t20, 0.0, 1.0);
            t29 = t20 * -2.0 + 3.0;
            t20 = t20 * t20;
            t20 = t20 * t29;
            t29 = dot(t1.xyz, t4.xzw);
            t29 = t29 * 5.0;
            t29 = clamp(t29, 0.0, 1.0);
            t30 = t29 * -2.0 + 3.0;
            t29 = t29 * t29;
            t29 = t29 * t30;
            t20 = (-t20) * t29 + 1.0;
            t2.x = t20 * t2.x;
            ti11 = ti11 + 0x1;
        }
    } else {
        t2.x = 1.0;
    //ENDIF
    }
    t0.xyz = t2.xxx * t3.xyz;
    t0.xyz = vec3(t13) * t0.xyz;
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
    t9 = exp2(t0.y);
    t9 = (-t9) + 1.0;
    t2.z = (tb1.z) ? t0.x : t9;
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
// Stats: 203 math, 8 textures
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
def c18, 6000, 2, 4, 1
def c19, -9.99999997e-007, 0, 0.5, 1
def c20, 0.197500005, 5.34962368, -1.05655074, 0.180141002
def c21, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c22, -2, 1.57079637, 0.909090877, 0.74000001
def c23, 0.383170009, -1.44269502, 0.454545468, 0
def c24, -9.99999975e-005, 10000, 16, 4
def c25, 3, 1.5, -1.5, -1.41299999
dcl_texcoord v0.xyz
dcl_2d s0
mov r0.x, -c18.w
mov r1.xyz, c19.wyyw
mov r2.xyw, c18
mov r3.xyz, c15
mad r3.xyz, c0, r2.x, -r3
dp3 r2.z, r3, r3
rsq r2.z, r2.z
rcp r4.x, r2.z
mul r2.z, r4.x, r4.x
add r5.xyz, -c0, v0
dp3 r3.w, r5, r5
rsq r3.w, r3.w
mad r6.x, r5.x, r3.w, c13.x
mul r6.yzw, r3.w, r5.xxyz
nrm r5.xyz, r6.xzww
dp3 r4.y, r3, r5
mad r2.z, r4.y, r4.y, -r2.z
mov r6.x, c5.x
add r3.w, -r6.x, c6.x
mad r7.x, r3.w, c12.x, r6.x
mad r2.z, r7.x, r7.x, r2.z
rsq r3.w, r2.z
rcp r3.w, r3.w
cmp r2.z, r2.z, -r3.w, c19.x
add r2.z, r2.z, -r4.y
max r3.w, r2.z, c19.y
add r7.y, r3.w, r4.y
cmp r4.xy, -r3.w, r4, r7
mul r2.z, r4.x, r4.x
rcp r4.z, r4.x
mul r4.y, r4.z, r4.y
mul r4.y, r4.y, r4.x
mad r2.z, r4.y, r4.y, -r2.z
mad r2.z, c5.x, c5.x, r2.z
cmp r4.w, -r2.z, -c19.y, -c19.w
cmp r4.w, r4.y, c19.y, r4.w
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
mad r1.w, r6.x, -c19.z, c19.z
mad r0.w, r6.x, c19.z, c19.z
add r6.x, -r6.x, c19.z
cmp r0, r4.w, r0, r1
add r0.y, r0.y, r2.z
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.x, r4.y, r0.x, r0.y
add r0.y, r0.z, r4.x
rcp r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.x, r0.x, r6.x, r0.w
rcp r0.y, c7.x
mul r0.x, r0.y, r0.x
lrp r1.x, r0.y, c19.z, r5.w
mul r0.z, r1.x, c7.x
mad r0.w, r1.x, c7.x, -r2.w
frc r1.x, r0.z
add r0.zw, r0, -r1.x
mad r8.y, r0.z, r0.y, r0.x
mad r1.yzw, r3.w, r5.xxyz, r3.xxyz
cmp r1.yzw, -r3.w, r3.xxyz, r1
dp3 r0.z, r6.yzww, r3
dp3 r2.z, r6.yzww, r6.yzww
dp3 r1.y, r1.yzww, c17
dp3 r1.z, r5, c17
mul r1.w, r4.z, r1.y
mad r1.y, r1.y, r4.z, c20.x
mul r1.w, r1.w, c20.y
cmp r1.y, r1.y, r1.w, c20.z
add r1.w, r1_abs.y, -c18.w
rcp r3.x, r1_abs.y
cmp r1.w, r1.w, r3.x, c18.w
mov_sat r3.x, r1_abs.y
mul r1.w, r1.w, r3.x
mul r3.x, r1.w, r1.w
mad r3.y, r3.x, c21.x, c21.y
mad r3.y, r3.x, r3.y, c20.w
mad r3.y, r3.x, r3.y, c21.z
mad r3.x, r3.x, r3.y, c21.w
mul r1.w, r1.w, r3.x
mad r3.x, r1.w, c22.x, c22.y
add r3.y, -r1_abs.y, c18.w
min r3.z, r1.y, c18.w
cmp r1.y, r3.z, c19.y, c19.w
cmp r3.y, r3.y, c19.y, c19.w
mad r1.w, r3.x, r3.y, r1.w
add r3.x, r1.w, r1.w
mad r1.y, r1.y, -r3.x, r1.w
mad r1.y, r1.y, c22.z, c22.w
mul r1.y, r1.y, c19.z
rcp r1.w, c9.x
lrp r3.x, r1.w, c19.z, r1.y
add r1.y, r1.z, c18.w
mul r1.y, r1.y, c19.z
add r1.w, -r2.w, c10.x
mul r3.y, r1.w, r1.y
frc r3.z, r3.y
add r3.y, -r3.z, r3.y
add r3.x, r3.x, r3.y
mad r1.y, r1.y, r1.w, -r3.y
add r1.w, r3.x, c18.w
rcp r3.y, c10.x
mul r4.x, r1.w, r3.y
mul r4.y, r3.y, r3.x
mov r4.w, c19.y
mov r8.xzw, r4.xyww
texldl r3, r8, s0
mov r8.xzw, r4.yyww
texldl r5, r8, s0
lrp r6, r1.y, r3, r5
mad r4.z, r0.w, r0.y, r0.x
texldl r3, r4.yzww, s0
texldl r4, r4.xzww, s0
lrp r5, r1.y, r4, r3
lrp r3, r1.x, r6, r5
add r0.x, r3.x, c24.x
rcp r0.y, r3.x
cmp r0.x, r0.x, r0.y, c24.y
mul r1.xyw, r3.w, r3.xyzz
mul r0.xyw, r0.x, r1
rcp r4.x, c2.x
rcp r4.y, c2.y
rcp r4.z, c2.z
mul r1.xyw, r4.xyzz, c2.x
mul r0.xyw, r0, r1
mad r1.xy, c3.x, c3.x, r2.wyzw
dp2add r1.x, r1.z, -c3.x, r1.x
mad r1.z, r1.z, r1.z, c18.w
rcp r1.y, r1.y
pow r2.y, r1.x, c25.z
mov r4.zw, c24
mul r1.xw, r4.zyzw, c1.x
rcp r1.w, r1.w
rcp r1.x, r1.x
mul r1.xw, r1, c25.xyzy
mul r1.x, r1.z, r1.x
mad r2.w, c3.x, -c3.x, r2.w
mul r1.w, r1.w, r2.w
mul r1.w, r2.y, r1.w
mul r1.z, r1.z, r1.w
mul r1.y, r1.y, r1.z
mul r0.xyw, r0, r1.y
mad r0.xyw, r3.xyzz, r1.x, r0
mul r0.xyw, r0, c11.x
cmp r0.xyw, r7.x, r0, c19.y
dp3 r1.x, c15, c15
mul r1.yzw, r2.x, c0.xxyz
dp3 r2.x, r1.yzww, r1.yzww
dp3 r1.y, c15, r1.yzww
add r1.x, r1.x, r2.x
mad r1.x, r1.y, -c18.y, r1.x
mad r1.x, c5.x, -c5.x, r1.x
mul r1.x, r2.z, r1.x
add r1.y, r2.z, r2.z
rcp r1.y, r1.y
mul r1.x, r1.x, c18.z
add r1.z, r0.z, r0.z
mad r1.x, r1.z, r1.z, -r1.x
rsq r1.z, r1.x
rcp r1.z, r1.z
mad r0.z, r0.z, -c18.y, -r1.z
mul r0.z, r1.y, r0.z
cmp r0.z, r1.x, -r0.z, c18.w
mov r1.x, c16.x
cmp r0.z, r0.z, r1.x, c4.x
mul r1.xyz, r0.z, r0.xyww
mad r0.xyz, r0.xyww, r0.z, c25.w
mul r1.zw, r1.z, c23.xyxy
mul r2, r1.xxyy, c23.xyxy
exp r0.w, r1.w
pow r3.x, r1.z, c23.z
add r0.w, -r0.w, c18.w
cmp r1.z, r0.z, r0.w, r3.x
exp r0.z, r2.y
add r0.z, -r0.z, c18.w
pow r0.w, r2.x, c23.z
cmp r1.x, r0.x, r0.z, r0.w
exp r0.x, r2.w
pow r0.z, r2.z, c23.z
add r0.x, -r0.x, c18.w
cmp r1.y, r0.y, r0.x, r0.z
mul oC0.xyz, r1, c14.x
mov oC0.w, c18.w

"
}
SubProgram "d3d11 " {
// Stats: 158 math
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
eefiecedeicpjgllecchmckmihpdckdfdfngfpnnabaaaaaajabgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnabfaaaa
eaaaaaaaheafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
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
diaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaaigadbaaaadaaaaaadcaaaaap
hcaabaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallef
aaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabjaaaaaabaaaaaahccaabaaa
afaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaakbcaabaaaadaaaaaabkaabaaa
afaaaaaabkaabaaaafaaaaaadkaabaiaebaaaaaaacaaaaaaelaaaaafbcaabaaa
afaaaaaadkaabaaaacaaaaaaaaaaaaakicaabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaalbcaabaaaagaaaaaa
dkaabaaaacaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaaaaaaaaaaamaaaaaa
dcaaaaajicaabaaaacaaaaaaakaabaaaagaaaaaaakaabaaaagaaaaaaakaabaaa
adaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaabkaabaiaebaaaaaaafaaaaaadeaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahccaabaaa
agaaaaaadkaabaaaacaaaaaabkaabaaaafaaaaaadbaaaaahbcaabaaaadaaaaaa
abeaaaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajhcaabaaaahaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaabkaaaaaadhaaaaajocaabaaaacaaaaaa
agaabaaaadaaaaaaagajbaaaahaaaaaaagajbaaaaeaaaaaabaaaaaahbcaabaaa
aeaaaaaajgahbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahccaabaaaadaaaaaa
jgahbaaaadaaaaaajgahbaaaadaaaaaadhaaaaajfcaabaaaadaaaaaaagaabaaa
adaaaaaaagabbaaaagaaaaaaagabbaaaafaaaaaabaaaaaaiccaabaaaacaaaaaa
jgahbaaaacaaaaaaegiccaaaaaaaaaaabkaaaaaaaoaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaadeaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaahbdneklodiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaabodakleadiaaaaahecaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaadaaaaaackaabaaaadaaaaaa
ckaabaiaebaaaaaaacaaaaaadcaaaaalecaabaaaacaaaaaabkiacaaaaaaaaaaa
amaaaaaabkiacaaaaaaaaaaaamaaaaaackaabaaaacaaaaaadbaaaaahicaabaaa
acaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaadbaaaaahicaabaaaadaaaaaa
ckaabaaaadaaaaaaabeaaaaaaaaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaadkaabaaaadaaaaaadiaaaaajicaabaaaadaaaaaabkiacaaaaaaaaaaa
amaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaakccaabaaaaeaaaaaaakaabaaa
agaaaaaaakaabaaaagaaaaaadkaabaiaebaaaaaaadaaaaaabnaaaaahecaabaaa
aeaaaaaaakaabaaaagaaaaaaakaabaaaadaaaaaadcaaaaakbcaabaaaadaaaaaa
akaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaaelaaaaafecaabaaaabaaaaaabkaabaaa
aeaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
aoaaaaalhcaabaaaafaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
bgigcaaaaaaaaaaaanaaaaaaaaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaa
afaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaaabaaaaaaakaabaaaafaaaaaa
abeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaapgapbaaaacaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaa
ckaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaalocaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaaanaaaaaa
aaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaadpaaaaiadpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaafaaaaaadcaaaaakecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaaebaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaaifcaabaaaaaaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaanaaaaaaaaaaaaahecaabaaaagaaaaaackaabaaa
aaaaaaaaakaabaaaaaaaaaaadeaaaaaiecaabaaaaaaaaaaabkaabaiaibaaaaaa
acaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaiicaabaaaaaaaaaaa
bkaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaah
bcaabaaaabaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaai
ccaabaaaabaaaaaaabeaaaaaaaaaiadpbkaabaiaibaaaaaaacaaaaaaddaaaaah
ecaabaaaabaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaa
abaaaaaackaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakecaabaaa
aaaaaaaackaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaa
kehadndpdiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaajecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaackaabaaa
afaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaai
bcaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaah
ccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaaiccaabaaaagaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaanaaaaaaaoaaaaaibcaabaaaagaaaaaaakaabaaaabaaaaaa
dkiacaaaaaaaaaaaanaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaaagaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
afaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaajpcaabaaaabaaaaaaegaobaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabkaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaa
akiacaaaaaaaaaaaanaaaaaaaaaaaaahicaabaaaagaaaaaaakaabaaaaaaaaaaa
bkaabaaaacaaaaaaeiaaaaalpcaabaaaafaaaaaamgaabaaaagaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
ngafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaafaaaaaapgapbaaaaaaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaafaaaaaaegaobaaaagaaaaaakgakbaaaaaaaaaaaegaobaaaafaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaaaaaaaaaegaobaaaafaaaaaaaaaaaaai
bcaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaj
pcaabaaaaaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaafaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaah
icaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaaoaaaaajocaabaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaajgahbaaaacaaaaaaapaaaaaiicaabaaaaaaaaaaa
agaabaaaacaaaaaapgipcaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaa
acaaaaaapgipcaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaalaaaaaaaceaaaaa
aaaaiadpaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalp
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaalaaaaaadkiacaaaaaaaaaaaalaaaaaaabeaaaaa
aaaaiadpdiaaaaalmcaabaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiaebaaaaiaeaaoaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaeaeaaaaamadpkgaobaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaaabaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaakgakbaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaa
baaaaaajicaabaaaaaaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaa
bjaaaaaadiaaaaalhcaabaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaabaaaaaaegiccaaaaaaaaaaa
bjaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeadkaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaabkaabaaaadaaaaaadkaabaaaaaaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeaaaaaaaahccaabaaaabaaaaaa
akaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaabkaabaaa
abaaaaaabkaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaelaaaaafccaabaaa
abaaaaaadkaabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadcaaaaalccaabaaaabaaaaaaakaabaiaebaaaaaaaeaaaaaa
abeaaaaaaaaaaaeabkaabaiaebaaaaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaabnaaaaahbcaabaaaabaaaaaaabeaaaaa
aaaaaaaaakaabaaaabaaaaaadmaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaadhaaaaalicaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaabjaaaaaaakiacaaaaaaaaaaaamaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakpcaabaaaabaaaaaaagafbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaffcaabaaa
abaaaaaaagacbaaaabaaaaaabjaaaaafkcaabaaaabaaaaaafganbaaaabaaaaaa
aaaaaaalkcaabaaaabaaaaaafganbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaaaaaaaaiadpdiaaaaakfcaabaaaabaaaaaaagacbaaaabaaaaaa
aceaaaaacplkoidoaaaaaaaacplkoidoaaaaaaaabjaaaaaffcaabaaaabaaaaaa
agacbaaaabaaaaaadbaaaaaklcaabaaaaaaaaaaaegaibaaaaaaaaaaaaceaaaaa
cpnnledpcpnnledpaaaaaaaacpnnledpdiaaaaakdcaabaaaacaaaaaakgakbaaa
aaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaadhaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaigaabaaaabaaaaaangafbaaaabaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaacaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
acaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaacplkoido
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadhaaaaajecaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaaihccabaaa
aaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaaapaaaaaadgaaaaaficcabaaa
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
// Stats: 339 math, 8 textures, 14 branches
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
def c27, 6000, 2, 4, 1
def c28, -9.99999997e-007, 0, 0.5, 1
def c29, 0.197500005, 5.34962368, -1.05655074, 0.180141002
def c30, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c31, -2, 1.57079637, 0.909090877, 0.74000001
def c32, -0, -1, -2, -3
def c33, -0.0187292993, 0.0742610022, 1.57072878, 5
def c34, 3, 1.5, -1.5, -0.212114394
def c35, -2, 3.14159274, 3, -1.41299999
def c36, 0.383170009, -1.44269502, 0.454545468, 0
def c37, -9.99999975e-005, 10000, 16, 4
defi i0, 4, 0, 0, 0
dcl_texcoord v0.xyz
dcl_2d s0
mov r0.xyw, c27
mul r1.xyz, r0.x, c8
add r2.xyz, -c8, v0
dp3 r0.z, r2, r2
rsq r0.z, r0.z
mul r3.yzw, r0.z, r2.xxyz
dp3 r1.w, r3.yzww, r3.yzww
mov r4.xyz, c23
mad r2.yzw, c8.xxyz, r0.x, -r4.xxyz
dp3 r0.x, r3.yzww, r2.yzww
add r4.x, r0.x, r0.x
dp3 r4.y, c23, c23
dp3 r4.z, r1, r1
add r4.y, r4.z, r4.y
dp3 r4.z, c23, r1
mad r4.y, r4.z, -c27.y, r4.y
mul r4.z, c13.x, c13.x
mad r4.w, c13.x, -c13.x, r4.y
mul r4.x, r4.x, r4.x
mul r5.x, r1.w, c27.z
mad r4.w, r5.x, -r4.w, r4.x
rsq r5.y, r4.w
rcp r5.y, r5.y
mad r5.y, r0.x, -c27.y, -r5.y
add r1.w, r1.w, r1.w
rcp r1.w, r1.w
mul r5.y, r1.w, r5.y
cmp r4.w, r4.w, -r5.y, c27.w
mov r6.x, c24.x
cmp r4.w, r4.w, r6.x, c12.x
mov r6.x, c13.x
add r5.y, -r6.x, c14.x
mad r6.x, r5.y, c20.x, r6.x
mad r3.x, r2.x, r0.z, c21.x
nrm r7.xyz, r3.xzww
dp3 r0.z, r2.yzww, r2.yzww
rsq r0.z, r0.z
rcp r8.x, r0.z
dp3 r8.y, r2.yzww, r7
mul r0.z, r8.x, r8.x
mad r0.z, r8.y, r8.y, -r0.z
mad r0.z, r6.x, r6.x, r0.z
rsq r2.x, r0.z
rcp r2.x, r2.x
cmp r0.z, r0.z, -r2.x, c28.x
add r0.z, r0.z, -r8.y
max r2.x, r0.z, c28.y
mad r5.yzw, r2.x, r7.xxyz, r2
add r6.y, r2.x, r8.y
cmp r2.yzw, -r2.x, r2, r5
cmp r5.yz, -r2.x, r8.xxyw, r6.xxyw
dp3 r0.z, r7, c25
dp3 r2.x, r2.yzww, c25
rcp r2.y, r5.y
mul r2.z, r2.y, r2.x
mul r2.w, r2.y, r5.z
mad r3.x, r6.x, r6.x, -r4.z
rsq r3.x, r3.x
rcp r7.z, r3.x
mul r5.z, r5.y, r5.y
mad r4.z, r5.y, r5.y, -r4.z
rsq r4.z, r4.z
rcp r4.z, r4.z
mul r2.w, r2.w, r5.y
mad r5.z, r2.w, r2.w, -r5.z
mad r5.z, c13.x, c13.x, r5.z
rcp r5.w, c16.x
mad r8.w, r5.w, -c28.z, c28.z
mul r7.y, r7.z, r7.z
mad r7.w, r5.w, c28.z, c28.z
cmp r6.y, -r5.z, -c28.y, -c28.w
cmp r6.y, r2.w, c28.y, r6.y
mov r7.x, -c27.w
mov r8.xyz, c28.wyyw
cmp r7, r6.y, r7, r8
rcp r6.y, c15.x
mul r3.x, r3.x, r4.z
lrp r8.x, r6.y, c28.z, r3.x
add r3.x, r5.z, r7.y
rsq r3.x, r3.x
rcp r3.x, r3.x
mad r2.w, r2.w, r7.x, r3.x
add r3.x, r4.z, r7.z
rcp r3.x, r3.x
mul r2.w, r2.w, r3.x
add r3.x, -r5.w, c28.z
mad r2.w, r2.w, r3.x, r7.w
rcp r3.x, c17.x
mad r2.x, r2.x, r2.y, c29.x
mul r2.y, r2.z, c29.y
cmp r2.x, r2.x, r2.y, c29.z
mov_sat r2.y, r2_abs.x
add r2.z, r2_abs.x, -c27.w
rcp r4.z, r2_abs.x
cmp r2.z, r2.z, r4.z, c27.w
mul r2.y, r2.z, r2.y
mul r2.z, r2.y, r2.y
mad r4.z, r2.z, c30.x, c30.y
mad r4.z, r2.z, r4.z, c29.w
mad r4.z, r2.z, r4.z, c30.z
mad r2.z, r2.z, r4.z, c30.w
mul r2.y, r2.z, r2.y
add r2.z, -r2_abs.x, c27.w
cmp r2.z, r2.z, c28.y, c28.w
mad r4.z, r2.y, c31.x, c31.y
mad r2.y, r4.z, r2.z, r2.y
min r4.z, r2.x, c27.w
cmp r2.x, r4.z, c28.y, c28.w
add r2.z, r2.y, r2.y
mad r2.x, r2.x, -r2.z, r2.y
mad r2.x, r2.x, c31.z, c31.w
mul r2.x, r2.x, c28.z
lrp r4.z, r3.x, c28.z, r2.x
add r2.x, r0.z, c27.w
mul r2.x, r2.x, c28.z
add r2.y, -r0.w, c18.x
mul r2.z, r2.y, r2.x
frc r3.x, r2.z
add r2.z, r2.z, -r3.x
mad r2.x, r2.x, r2.y, -r2.z
mul r2.y, r8.x, c15.x
mad r3.x, r8.x, c15.x, -r0.w
frc r5.z, r2.y
add r3.x, r3.x, -r5.z
add r2.y, r2.y, -r5.z
add r2.z, r4.z, r2.z
rcp r4.z, c18.x
mul r7.y, r2.z, r4.z
mul r2.w, r6.y, r2.w
mad r7.z, r3.x, r6.y, r2.w
mov r7.w, c28.y
texldl r8, r7.yzww, s0
add r2.z, r2.z, c27.w
mul r7.x, r4.z, r2.z
texldl r9, r7.xzww, s0
lrp r10, r2.x, r9, r8
mad r8.y, r2.y, r6.y, r2.w
mov r8.xzw, r7.yyww
texldl r9, r8, s0
mov r8.xzw, r7.xyww
texldl r7, r8, s0
lrp r8, r2.x, r7, r9
lrp r2, r5.z, r8, r10
add r3.x, -r5.y, r6.x
mul r5.yzw, r2.w, r2.xxyz
add r2.w, r2.x, c37.x
rcp r4.z, r2.x
cmp r2.w, r2.w, r4.z, c37.y
mul r5.yzw, r2.w, r5
rcp r7.x, c10.x
rcp r7.y, c10.y
rcp r7.z, c10.z
mul r6.yzw, r7.xxyz, c10.x
mul r5.yzw, r5, r6
mov r6.zw, c37
mul r6.yz, r6.xzww, c9.x
rcp r2.w, r6.y
mul r2.w, r2.w, c34.x
mad r4.z, r0.z, r0.z, c27.w
mul r2.w, r2.w, r4.z
rcp r6.y, r6.z
mul r6.y, r6.y, c34.y
mad r6.z, c11.x, -c11.x, r0.w
mul r6.y, r6.z, r6.y
mad r0.yw, c11.x, c11.x, r0.xwzy
dp2add r0.y, r0.z, -c11.x, r0.y
pow r6.z, r0.y, c34.z
mul r0.y, r6.z, r6.y
mul r0.y, r4.z, r0.y
rcp r0.z, r0.w
mul r0.y, r0.z, r0.y
mul r0.yzw, r0.y, r5
mad r0.yzw, r2.xxyz, r2.w, r0
mul r0.yzw, r0, c19.x
mad r2.x, r6.x, -r6.x, r4.y
mad r2.x, r5.x, -r2.x, r4.x
rsq r2.y, r2.x
rcp r2.y, r2.y
mad r2.z, r0.x, -c27.y, -r2.y
mul r2.z, r1.w, r2.z
mad r0.x, r0.x, -c27.y, r2.y
mul r0.x, r1.w, r0.x
cmp r0.x, r2.z, r2.z, r0.x
cmp r0.x, r2.x, r0.x, -c27.w
add r1.w, r0.x, c27.w
if_ne r1.w, -r1.w
mad r1.xyz, r3.yzww, r0.x, r1
add r2.xyz, -r1, c26
dp3 r0.x, r2, r2
rsq r0.x, r0.x
rcp r1.w, r0.x
mul r2.xyz, r0.x, r2
rcp r0.x, c26.w
mov r2.w, c27.w
mov r3.y, c28.y
rep i0
add r5, r3.y, c32
mov r4.y, c28.y
cmp r3.z, -r5_abs.x, c0.w, r4.y
cmp r3.z, -r5_abs.y, c1.w, r3.z
cmp r3.z, -r5_abs.z, c2.w, r3.z
cmp r3.z, -r5_abs.w, c3.w, r3.z
if_ge -r3.z, c28.y
break_ne c27.w, -c27.w
endif
cmp r4.xyz, -r5_abs.x, c0, r4.y
cmp r4.xyz, -r5_abs.y, c1, r4
cmp r4.xyz, -r5_abs.z, c2, r4
cmp r4.xyz, -r5_abs.w, c3, r4
add r4.xyz, -r1, r4
dp3 r3.w, r4, r4
rsq r3.w, r3.w
mul r4.xyz, r3.w, r4
mul r5.xyz, r2.zxyw, r4.yzxw
mad r5.xyz, r2.yzxw, r4.zxyw, -r5
dp3 r5.x, r5, r5
rsq r5.x, r5.x
rcp r5.x, r5.x
min r6.x, r5.x, c27.w
add r5.x, -r6.x, c27.w
rsq r5.x, r5.x
rcp r5.x, r5.x
mad r5.y, r6.x, c33.x, c33.y
mad r5.y, r5.y, r6.x, c34.w
mad r5.y, r5.y, r6.x, c33.z
mad r5.x, r5.y, -r5.x, c31.y
mul r3.z, r3.w, r3.z
min r5.y, r3.z, c27.w
add r3.z, -r5_abs.y, c27.w
rsq r3.z, r3.z
rcp r3.z, r3.z
mad r3.w, r5_abs.y, c33.x, c33.y
mad r3.w, r3.w, r5_abs.y, c34.w
mad r3.w, r3.w, r5_abs.y, c33.z
mul r3.z, r3.z, r3.w
mad r3.w, r3.z, c35.x, c35.y
cmp r5.y, r5.y, c28.y, c28.w
mad r3.z, r3.w, r5.y, r3.z
add r3.z, -r3.z, c31.y
add r3.z, -r3.z, r5.x
mul r3.z, r1.w, r3.z
mad r3.z, -r3.z, r0.x, c27.w
mul_sat r3.z, r3.z, c28.z
mad r3.w, r3.z, c35.x, c35.z
mul r3.z, r3.z, r3.z
mul r3.z, r3.z, r3.w
dp3 r3.w, r2, r4
mul_sat r3.w, r3.w, c33.w
mad r4.x, r3.w, c35.x, c35.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.x
mad r3.z, r3.z, -r3.w, c27.w
mul r2.w, r2.w, r3.z
add r3.y, r3.y, c27.w
endrep
mov r3.y, r2.w
mov r3.z, c28.y
rep i0
add r5, r3.z, c32
mov r4.y, c28.y
cmp r3.w, -r5_abs.x, c4.w, r4.y
cmp r3.w, -r5_abs.y, c5.w, r3.w
cmp r3.w, -r5_abs.z, c6.w, r3.w
cmp r3.w, -r5_abs.w, c7.w, r3.w
if_ge -r3.w, c28.y
break_ne c27.w, -c27.w
endif
cmp r4.xyz, -r5_abs.x, c4, r4.y
cmp r4.xyz, -r5_abs.y, c5, r4
cmp r4.xyz, -r5_abs.z, c6, r4
cmp r4.xyz, -r5_abs.w, c7, r4
add r4.xyz, -r1, r4
dp3 r5.x, r4, r4
rsq r5.x, r5.x
mul r4.xyz, r4, r5.x
mul r5.yzw, r2.xzxy, r4.xyzx
mad r5.yzw, r2.xyzx, r4.xzxy, -r5
dp3 r5.y, r5.yzww, r5.yzww
rsq r5.y, r5.y
rcp r5.y, r5.y
min r6.x, r5.y, c27.w
add r5.y, -r6.x, c27.w
rsq r5.y, r5.y
rcp r5.y, r5.y
mad r5.z, r6.x, c33.x, c33.y
mad r5.z, r5.z, r6.x, c34.w
mad r5.z, r5.z, r6.x, c33.z
mad r5.y, r5.z, -r5.y, c31.y
mul r3.w, r3.w, r5.x
min r5.x, r3.w, c27.w
add r3.w, -r5_abs.x, c27.w
rsq r3.w, r3.w
rcp r3.w, r3.w
mad r5.z, r5_abs.x, c33.x, c33.y
mad r5.z, r5.z, r5_abs.x, c34.w
mad r5.z, r5.z, r5_abs.x, c33.z
mul r3.w, r3.w, r5.z
mad r5.z, r3.w, c35.x, c35.y
cmp r5.x, r5.x, c28.y, c28.w
mad r3.w, r5.z, r5.x, r3.w
add r3.w, -r3.w, c31.y
add r3.w, -r3.w, r5.y
mul r3.w, r1.w, r3.w
mad r3.w, -r3.w, r0.x, c27.w
mul_sat r3.w, r3.w, c28.z
mad r5.x, r3.w, c35.x, c35.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r5.x
dp3 r4.x, r2, r4
mul_sat r4.x, r4.x, c33.w
mad r4.y, r4.x, c35.x, c35.z
mul r4.x, r4.x, r4.x
mul r4.x, r4.x, r4.y
mad r3.w, r3.w, -r4.x, c27.w
mul r3.y, r3.w, r3.y
add r3.z, r3.z, c27.w
endrep
else
mov r3.y, c27.w
endif
mul r0.xyz, r0.yzww, r3.y
cmp r0.xyz, r3.x, r0, c28.y
mul r1.xyz, r4.w, r0
mad r0.xyz, r0, r4.w, c35.w
mul r2, r1.xxyy, c36.xyxy
pow r0.w, r2.x, c36.z
exp r1.x, r2.y
add r1.x, -r1.x, c27.w
cmp r3.x, r0.x, r1.x, r0.w
pow r0.x, r2.z, c36.z
exp r0.w, r2.w
add r0.w, -r0.w, c27.w
cmp r3.y, r0.y, r0.w, r0.x
mul r0.xy, r1.z, c36
pow r1.x, r0.x, c36.z
exp r0.x, r0.y
add r0.x, -r0.x, c27.w
cmp r3.z, r0.z, r0.x, r1.x
mul oC0.xyz, r3, c22.x
mov oC0.w, c27.w

"
}
SubProgram "d3d11 " {
// Stats: 275 math, 8 branches
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
eefiecedcecblilcfhficankbbjhnpbjidmkbipdabaaaaaacmcgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmcfaaaa
eaaaaaaaflajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaaceaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacajaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaaacaaaaaapgapbaaaaaaaaaaa
agajbaaaabaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaa
acaaaaaadcaaaaaphcaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabjaaaaaa
baaaaaahecaabaaaabaaaaaajgahbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaah
icaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaabaaaaaajicaabaaa
adaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaah
bcaabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaa
adaaaaaadkaabaaaadaaaaaaakaabaaaaeaaaaaabaaaaaaibcaabaaaaeaaaaaa
egiccaaaaaaaaaaabjaaaaaaegacbaaaaaaaaaaadcaaaaakicaabaaaadaaaaaa
akaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaaaeadkaabaaaadaaaaaadiaaaaaj
bcaabaaaaeaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaa
dcaaaaamccaabaaaaeaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahecaabaaaaeaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiaeadcaaaaakccaabaaaaeaaaaaackaabaiaebaaaaaaaeaaaaaa
bkaabaaaaeaaaaaadkaabaaaabaaaaaadbaaaaahicaabaaaaeaaaaaabkaabaaa
aeaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaalccaabaaaaeaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaea
bkaabaiaebaaaaaaaeaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaaaoaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaa
abaaaaaabnaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaabkaabaaaaeaaaaaa
dmaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaaeaaaaaadhaaaaal
ccaabaaaaeaaaaaabkaabaaaaeaaaaaadkiacaaaaaaaaaaabjaaaaaaakiacaaa
aaaaaaaaamaaaaaaaaaaaaakicaabaaaaeaaaaaabkiacaiaebaaaaaaaaaaaaaa
amaaaaaackiacaaaaaaaaaaaamaaaaaadcaaaaalbcaabaaaafaaaaaadkaabaaa
aeaaaaaabkiacaaaaaaaaaaaapaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
apaaaaaabaaaaaahicaabaaaaaaaaaaaigadbaaaacaaaaaaigadbaaaacaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaa
pgapbaaaaaaaaaaaigadbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaadaaaaaaelaaaaafbcaabaaaahaaaaaadkaabaaaaaaaaaaa
baaaaaahccaabaaaahaaaaaaegacbaaaadaaaaaaegacbaaaagaaaaaadcaaaaak
icaabaaaaaaaaaaabkaabaaaahaaaaaabkaabaaaahaaaaaadkaabaiaebaaaaaa
aaaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaa
dkaabaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaaj
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaiaebaaaaaaahaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaah
bcaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aiaaaaaapgapbaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaaaaaaaaah
ccaabaaaafaaaaaadkaabaaaaaaaaaaabkaabaaaahaaaaaadhaaaaajhcaabaaa
adaaaaaaagaabaaaabaaaaaaegacbaaaaiaaaaaaegacbaaaadaaaaaadhaaaaaj
gcaabaaaafaaaaaaagaabaaaabaaaaaaagabbaaaafaaaaaaagabbaaaahaaaaaa
baaaaaaiicaabaaaaaaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaabkaaaaaa
baaaaaaibcaabaaaabaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaabkaaaaaa
aoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaafaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaaakaabaiaebaaaaaa
aeaaaaaaelaaaaafecaabaaaagaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaafaaaaaabkaabaaaafaaaaaadcaaaaakbcaabaaaadaaaaaa
bkaabaaaafaaaaaabkaabaaaafaaaaaaakaabaiaebaaaaaaaeaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakbcaabaaaacaaaaaackaabaaa
afaaaaaackaabaaaafaaaaaaakaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
acaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaaakaabaaa
acaaaaaadbaaaaahccaabaaaadaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaadaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaaabaaaaah
ccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaalhcaabaaa
ahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaa
anaaaaaaaaaaaaaiicaabaaaaiaaaaaaakaabaiaebaaaaaaahaaaaaaabeaaaaa
aaaaaadpdiaaaaahccaabaaaagaaaaaackaabaaaagaaaaaackaabaaaagaaaaaa
aaaaaaahicaabaaaagaaaaaaakaabaaaahaaaaaaabeaaaaaaaaaaadpdgaaaaai
hcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaf
bcaabaaaagaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaaaiaaaaaafgafbaaa
adaaaaaaegaobaaaaiaaaaaaegaobaaaagaaaaaaaoaaaaahccaabaaaadaaaaaa
akaabaaaadaaaaaackaabaaaagaaaaaaaoaaaaalhcaabaaaagaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaaaaaaaaaaanaaaaaaaaaaaaal
hcaabaaaagaaaaaaegacbaiaebaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaaadp
aaaaiadpaaaaaaaadcaaaaajccaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaa
agaaaaaabkaabaaaahaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaaaaiaaaaaaelaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaackaabaaaafaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaa
aaaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaackaabaaaaiaaaaaaaoaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaacaaaaaabkaabaaaagaaaaaadkaabaaaaiaaaaaadeaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaahbdneklodiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaabodakleaddaaaaaibcaabaaaadaaaaaa
akaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpdeaaaaaiecaabaaaadaaaaaa
akaabaiaibaaaaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaaadaaaaaadiaaaaah
bcaabaaaadaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaa
adaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaajbcaabaaaaeaaaaaa
ckaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaa
aeaaaaaackaabaaaadaaaaaaakaabaaaaeaaaaaaabeaaaaaochgdidodcaaaaaj
bcaabaaaaeaaaaaackaabaaaadaaaaaaakaabaaaaeaaaaaaabeaaaaaaebnkjlo
dcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaaakaabaaaaeaaaaaaabeaaaaa
diphhpdpdiaaaaahbcaabaaaaeaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
dbaaaaaiicaabaaaaeaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaaabaaaaaa
dcaaaaajbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapmjdpabaaaaahbcaabaaaaeaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaackaabaaaadaaaaaaakaabaaa
aeaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
dbaaaaaibcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
dhaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaiaebaaaaaaadaaaaaa
akaabaaaadaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
colkgidpabeaaaaakehadndpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpdcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaa
agaaaaaackaabaaaahaaaaaaaaaaaaahbcaabaaaadaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
aaaaaadpaaaaaaaiecaabaaaadaaaaaadkiacaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaialpdiaaaaahbcaabaaaaeaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
ebaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaakbcaabaaaadaaaaaa
akaabaaaadaaaaaackaabaaaadaaaaaaakaabaiaebaaaaaaaeaaaaaadiaaaaai
ecaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaanaaaaaadcaaaaak
ccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaa
aaaaialpebaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaaiccaabaaa
adaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaanaaaaaaebaaaaaficaabaaa
aeaaaaaackaabaaaadaaaaaaaoaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaa
akiacaaaaaaaaaaaanaaaaaabkaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
aaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaaeaaaaaaaoaaaaai
ccaabaaaagaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaanaaaaaaaaaaaaah
ecaabaaaagaaaaaabkaabaaaadaaaaaaakaabaaaacaaaaaaeiaaaaalpcaabaaa
ahaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aoaaaaaibcaabaaaagaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaanaaaaaa
eiaaaaalpcaabaaaaiaaaaaaigaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaaiaaaaaaagaabaaaadaaaaaa
egaobaaaaiaaaaaadcaaaaajpcaabaaaahaaaaaaegaobaaaahaaaaaafgafbaaa
adaaaaaaegaobaaaaiaaaaaaaaaaaaahicaabaaaagaaaaaadkaabaaaaeaaaaaa
akaabaaaacaaaaaaeiaaaaalpcaabaaaaiaaaaaangafbaaaagaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
mgaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaagaaaaaaagaabaaaadaaaaaaegaobaaaagaaaaaadcaaaaaj
pcaabaaaagaaaaaaegaobaaaaiaaaaaafgafbaaaadaaaaaaegaobaaaagaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
diaaaaahpcaabaaaagaaaaaakgakbaaaadaaaaaaegaobaaaagaaaaaadcaaaaaj
pcaabaaaagaaaaaaegaobaaaahaaaaaaagaabaaaabaaaaaaegaobaaaagaaaaaa
bnaaaaahbcaabaaaabaaaaaaakaabaaaafaaaaaabkaabaaaafaaaaaadiaaaaah
hcaabaaaadaaaaaapgapbaaaagaaaaaaegacbaaaagaaaaaadeaaaaahbcaabaaa
acaaaaaaakaabaaaagaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaaagaabaaaacaaaaaaaoaaaaajocaabaaaafaaaaaaagiacaaa
aaaaaaaaajaaaaaaagijcaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaajgahbaaaafaaaaaadiaaaaaljcaabaaaaeaaaaaaagiacaaa
aaaaaaaaahaaaaaaaceaaaaaaaaaiaebaaaaaaaaaaaaaaaaaaaaiaeaaoaaaaak
jcaabaaaaeaaaaaaaceaaaaaaaaaeaeaaaaaaaaaaaaaaaaaaaaamadpagambaaa
aeaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaeaaaaaaakaabaaaacaaaaaaakaabaaa
aeaaaaaadcaaaaamccaabaaaafaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaa
dkiacaaaaaaaaaaaalaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaeaaaaaa
dkaabaaaaeaaaaaabkaabaaaafaaaaaadcaaaaaogcaabaaaafaaaaaapgipcaaa
aaaaaaaaalaaaaaapgipcaaaaaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaeaaaaaaaaaapaaaaaiicaabaaaaaaaaaaapgapbaaaaaaaaaaapgipcaaa
aaaaaaaaalaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkaabaaaafaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaafaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaadaaaaaaegacbaaaagaaaaaaagaabaaaaeaaaaaaegacbaaaadaaaaaa
abaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaaaaaaaaaaapaaaaaadcaaaaak
icaabaaaaaaaaaaaakaabaiaebaaaaaaafaaaaaaakaabaaaafaaaaaadkaabaaa
adaaaaaadcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaaeaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaabnaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
icaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeadkaabaia
ebaaaaaaaaaaaaaaaoaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
abaaaaaadbaaaaahbcaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaea
dkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaadhaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadhaaaaajicaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaialpdjaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaialpbpaaaeadakaabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaa
jgahbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaablaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaf
bcaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaaacaaaaaabbaaaaaj
ccaabaaaacaaaaaaegiocaaaaaaaaaaabpaaaaaaegjojaaaakaabaaaacaaaaaa
bnaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaead
ckaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaa
aaaaaaaabmaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaa
egiocaaaaaaaaaaabnaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajecaabaaa
afaaaaaaegiocaaaaaaaaaaaboaaaaaaegjojaaaakaabaaaacaaaaaaaaaaaaai
ncaabaaaaeaaaaaaagajbaiaebaaaaaaaaaaaaaaagajbaaaafaaaaaabaaaaaah
ecaabaaaacaaaaaaigadbaaaaeaaaaaaigadbaaaaeaaaaaaelaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaaaoaaaaahncaabaaaaeaaaaaaagaobaaaaeaaaaaa
kgakbaaaacaaaaaadiaaaaahhcaabaaaafaaaaaacgajbaaaabaaaaaaogaibaaa
aeaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaabaaaaaadgaobaaaaeaaaaaa
egacbaiaebaaaaaaafaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaa
egacbaaaafaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaddaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
adaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaadcaaaaajbcaabaaaafaaaaaadkaabaaaacaaaaaa
abeaaaaadagojjlmabeaaaaachbgjidndcaaaaajbcaabaaaafaaaaaaakaabaaa
afaaaaaadkaabaaaacaaaaaaabeaaaaaiedefjlodcaaaaajicaabaaaacaaaaaa
akaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaakeanmjdpdcaaaaakicaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaaadaaaaaaabeaaaaanlapmjdp
aoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaaddaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaa
acaaaaaabkaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaadcaaaaakicaabaaaadaaaaaabkaabaiaibaaaaaa
acaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaakicaabaaaadaaaaaa
dkaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaaiedefjlodcaaaaak
icaabaaaadaaaaaadkaabaaaadaaaaaabkaabaiaibaaaaaaacaaaaaaabeaaaaa
keanmjdpdiaaaaahbcaabaaaafaaaaaackaabaaaacaaaaaadkaabaaaadaaaaaa
dcaaaaajbcaabaaaafaaaaaaakaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaa
nlapejeadbaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaaabaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaafaaaaaa
dcaaaaajccaabaaaacaaaaaadkaabaaaadaaaaaackaabaaaacaaaaaabkaabaaa
acaaaaaaaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
nlapmjdpaaaaaaaiccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaadkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaa
aoaaaaajccaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaa
blaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadp
dicaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ecaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaabaaaaaahecaabaaa
acaaaaaaegacbaaaabaaaaaaigadbaaaaeaaaaaadicaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaaabeaaaaaaaaakaeadcaaaaajicaabaaaacaaaaaackaabaaa
acaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaackaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaackaabaaa
acaaaaaadkaabaaaacaaaaaadcaaaaakccaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaabkaabaaaacaaaaaaboaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaabaaaaaabgaaaaabdgaaaaafbcaabaaaacaaaaaadkaabaaa
abaaaaaadgaaaaafccaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
ecaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaeadckaabaaa
acaaaaaabbaaaaajecaabaaaacaaaaaaegiocaaaaaaaaaaacdaaaaaaegjojaaa
bkaabaaaacaaaaaabnaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaa
acaaaaaabpaaaeaddkaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaa
afaaaaaaegiocaaaaaaaaaaacaaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaaj
ccaabaaaafaaaaaaegiocaaaaaaaaaaacbaaaaaaegjojaaabkaabaaaacaaaaaa
bbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaaccaaaaaaegjojaaabkaabaaa
acaaaaaaaaaaaaaincaabaaaaeaaaaaaagajbaiaebaaaaaaaaaaaaaaagajbaaa
afaaaaaabaaaaaahicaabaaaacaaaaaaigadbaaaaeaaaaaaigadbaaaaeaaaaaa
elaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaoaaaaahncaabaaaaeaaaaaa
agaobaaaaeaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaaafaaaaaacgajbaaa
abaaaaaaogaibaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaabaaaaaa
dgaobaaaaeaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaaddaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaafaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadp
elaaaaafbcaabaaaafaaaaaaakaabaaaafaaaaaadcaaaaajccaabaaaafaaaaaa
dkaabaaaadaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaajccaabaaa
afaaaaaabkaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaaiedefjlodcaaaaaj
icaabaaaadaaaaaabkaabaaaafaaaaaadkaabaaaadaaaaaaabeaaaaakeanmjdp
dcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaakaabaaaafaaaaaa
abeaaaaanlapmjdpaoaaaaahecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaa
acaaaaaaddaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaacaaaaaackaabaiambaaaaaaacaaaaaaabeaaaaaaaaaiadp
elaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaakbcaabaaaafaaaaaa
ckaabaiaibaaaaaaacaaaaaaabeaaaaadagojjlmabeaaaaachbgjidndcaaaaak
bcaabaaaafaaaaaaakaabaaaafaaaaaackaabaiaibaaaaaaacaaaaaaabeaaaaa
iedefjlodcaaaaakbcaabaaaafaaaaaaakaabaaaafaaaaaackaabaiaibaaaaaa
acaaaaaaabeaaaaakeanmjdpdiaaaaahccaabaaaafaaaaaadkaabaaaacaaaaaa
akaabaaaafaaaaaadcaaaaajccaabaaaafaaaaaabkaabaaaafaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapejeadbaaaaaiecaabaaaacaaaaaackaabaaaacaaaaaa
ckaabaiaebaaaaaaacaaaaaaabaaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaaaafaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaafaaaaaadkaabaaa
acaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaaabeaaaaanlapmjdpaaaaaaaiecaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaadkaabaaaadaaaaaadiaaaaahecaabaaaacaaaaaadkaabaaaaaaaaaaa
ckaabaaaacaaaaaaaoaaaaajecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaa
dkiacaaaaaaaaaaablaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
abeaaaaaaaaaiadpdicaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
aaaaaadpdcaaaaajicaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaama
abeaaaaaaaaaeaeadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaackaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaabaaaaaaigadbaaaaeaaaaaadicaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaakaeadcaaaaajicaabaaa
adaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahicaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaadcaaaaakecaabaaaacaaaaaa
ckaabaiaebaaaaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaacaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaboaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaabbcaaaaabdgaaaaaf
bcaabaaaacaaaaaaabeaaaaaaaaaiadpbfaaaaabdiaaaaahhcaabaaaaaaaaaaa
agaabaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaaaaaaaaafgafbaaa
aeaaaaaaegacbaaaaaaaaaaadbaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaa
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
abaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaa
egacbaaaacaaaaaapgipcaaaaaaaaaaaapaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
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