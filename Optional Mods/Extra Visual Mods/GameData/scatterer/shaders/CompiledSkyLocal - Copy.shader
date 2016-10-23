// Compiled shader for all platforms, uncompressed size: 372.5KB

// Skipping shader variants that would not be included into build of current scene.

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 //        gles : 347 avg math (250..445), 1 texture, 15 avg branch (11..20)
 //       metal : 2 math
 //      opengl : 347 avg math (250..445), 1 texture, 15 avg branch (11..20)
 // Stats for Fragment shader:
 //       d3d11 : 213 avg math (154..273), 9 avg branch (4..14)
 //        d3d9 : 259 avg math (191..327), 2 texture, 12 avg branch (4..20)
 //       metal : 347 avg math (250..445), 1 texture, 15 avg branch (11..20)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend DstColor Zero
  GpuProgramID 40623
Program "vp" {
SubProgram "opengl " {
// Stats: 250 math, 1 textures, 11 branches
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
uniform float _viewdirOffset;
uniform vec3 _Globals_Origin;
uniform float _Extinction_Tint;
uniform float extinctionMultiplier;
uniform float extinctionRimFade;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  vec3 viewdir_5;
  vec3 extinction_6;
  extinction_6 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _viewdirOffset);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (Rt * Rt));
  float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / Rt);
    r_4 = Rt;
  };
  if ((r_4 > Rt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
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
    if ((tmpvar_18 > 0.0)) {
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      float tmpvar_28;
      float H_29;
      H_29 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      vec2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      vec2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      vec2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      vec2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , vec2(1.0, -1.0))));
      float H_36;
      H_36 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      vec2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
      vec2 tmpvar_39;
      tmpvar_39 = sign(tmpvar_38);
      vec2 tmpvar_40;
      tmpvar_40 = (tmpvar_38 * tmpvar_38);
      float tmpvar_41;
      if ((tmpvar_39.y > tmpvar_39.x)) {
        tmpvar_41 = exp(tmpvar_40.x);
      } else {
        tmpvar_41 = 0.0;
      };
      vec2 tmpvar_42;
      tmpvar_42.x = 1.0;
      tmpvar_42.y = exp(((
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(betaR)
       * tmpvar_28) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_43;
      y_over_x_43 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_44;
      tmpvar_44 = (min (abs(y_over_x_43), 1.0) / max (abs(y_over_x_43), 1.0));
      float tmpvar_45;
      tmpvar_45 = (tmpvar_44 * tmpvar_44);
      tmpvar_45 = (((
        ((((
          ((((-0.01213232 * tmpvar_45) + 0.05368138) * tmpvar_45) - 0.1173503)
         * tmpvar_45) + 0.1938925) * tmpvar_45) - 0.3326756)
       * tmpvar_45) + 0.9999793) * tmpvar_44);
      tmpvar_45 = (tmpvar_45 + (float(
        (abs(y_over_x_43) > 1.0)
      ) * (
        (tmpvar_45 * -2.0)
       + 1.570796)));
      vec4 tmpvar_46;
      tmpvar_46.zw = vec2(0.0, 0.0);
      tmpvar_46.x = ((tmpvar_45 * sign(y_over_x_43)) / 1.5);
      tmpvar_46.y = sqrt(((r_4 - Rg) / (Rt - Rg)));
      extinction_6 = texture2DLod (_Transmittance, tmpvar_46.xy, 0.0).xyz;
    };
    extinction_6 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_6) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    float tmpvar_47;
    tmpvar_47 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_6 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_6));
    };
    vec4 tmpvar_52;
    tmpvar_52.w = 1.0;
    tmpvar_52.xyz = extinction_6;
    tmpvar_1 = tmpvar_52;
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
// Stats: 250 math, 1 textures, 11 branches
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
uniform highp float _viewdirOffset;
uniform highp vec3 _Globals_Origin;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float rMu_3;
  highp float r_4;
  highp vec3 viewdir_5;
  highp vec3 extinction_6;
  extinction_6 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _viewdirOffset);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  highp float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (Rt * Rt));
  highp float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  highp float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / Rt);
    r_4 = Rt;
  };
  if ((r_4 > Rt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
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
    if ((tmpvar_18 > 0.0)) {
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      highp float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      highp float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      highp float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      highp float tmpvar_28;
      highp float H_29;
      H_29 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      highp vec2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      highp vec2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      highp vec2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      highp float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      highp vec2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , vec2(1.0, -1.0))));
      highp float H_36;
      H_36 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      highp vec2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
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
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(betaR)
       * tmpvar_28) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_43;
      highp float y_over_x_44;
      y_over_x_44 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_45;
      tmpvar_45 = (min (abs(y_over_x_44), 1.0) / max (abs(y_over_x_44), 1.0));
      highp float tmpvar_46;
      tmpvar_46 = (tmpvar_45 * tmpvar_45);
      tmpvar_46 = (((
        ((((
          ((((-0.01213232 * tmpvar_46) + 0.05368138) * tmpvar_46) - 0.1173503)
         * tmpvar_46) + 0.1938925) * tmpvar_46) - 0.3326756)
       * tmpvar_46) + 0.9999793) * tmpvar_45);
      tmpvar_46 = (tmpvar_46 + (float(
        (abs(y_over_x_44) > 1.0)
      ) * (
        (tmpvar_46 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_47;
      tmpvar_47.zw = vec2(0.0, 0.0);
      tmpvar_47.x = ((tmpvar_46 * sign(y_over_x_44)) / 1.5);
      tmpvar_47.y = sqrt(((r_4 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_48;
      tmpvar_48 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_47.xy, 0.0);
      tmpvar_43 = tmpvar_48.xyz;
      extinction_6 = tmpvar_43;
    };
    extinction_6 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_6) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    highp float tmpvar_49;
    tmpvar_49 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_50;
    tmpvar_50 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_51;
    tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_52;
    if ((tmpvar_51 < 0.0)) {
      tmpvar_52 = -1.0;
    } else {
      tmpvar_52 = ((-(tmpvar_50) - sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    };
    bool tmpvar_53;
    tmpvar_53 = (tmpvar_52 > 0.0);
    if (!(tmpvar_53)) {
      extinction_6 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_6));
    };
    highp vec4 tmpvar_54;
    tmpvar_54.w = 1.0;
    tmpvar_54.xyz = extinction_6;
    tmpvar_1 = tmpvar_54;
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
bool tb0;
highp vec4 t1;
highp vec3 t2;
highp ivec2 ti2;
highp vec4 t3;
highp ivec2 ti3;
highp vec3 t4;
highp ivec2 ti4;
highp float t5;
highp vec2 t6;
highp float t7;
bool tb7;
highp float t10;
bool tb10;
highp float t11;
bool tb11;
highp float t12;
highp ivec2 ti12;
bool tb12;
highp float t15;
bool tb15;
highp float t16;
highp float t17;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t1.yzw = vec3(t15) * t0.xyz;
    t1.x = t0.x * t15 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * t1.xzw;
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t15);
    t0.x = dot(t2.xyz, t0.xyz);
    t3.y = t0.x / t3.x;
    t5 = t0.x * t0.x + (-t15);
    t5 = Rt * Rt + t5;
    tb10 = t5>=0.0;
    t5 = sqrt(t5);
    t5 = (tb10) ? (-t5) : -9.99999997e-007;
    t5 = t5 + (-t0.x);
    t5 = max(t5, 0.0);
    tb10 = 0.0<t5;
    t0.x = t5 + t0.x;
    t0.y = t0.x / Rt;
    t0.x = Rt;
    t0.xy = (bool(tb10)) ? t0.xy : t3.xy;
    tb15 = Rt<t0.x;
    if(tb15){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t15 = dot(t1.yzw, t1.yzw);
    t1.x = dot(t1.yzw, t2.xyz);
    t1.z = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t1.w = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t6.xy = t1.xw + t1.xz;
    t16 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t11 = (-t16) * 2.0 + t6.y;
    t16 = (-Rg) * Rg + t11;
    t6.x = t6.x * t6.x;
    t2.x = t15 * 4.0;
    t16 = (-t2.x) * t16 + t6.x;
    tb7 = t16<0.0;
    t16 = sqrt(t16);
    t16 = (-t1.x) * 2.0 + (-t16);
    t15 = t15 + t15;
    t16 = t16 / t15;
    t16 = (tb7) ? -1.0 : t16;
    tb7 = 0.0<t16;
    if(tb7){
        t11 = (-Rt) * Rt + t11;
        t6.x = (-t2.x) * t11 + t6.x;
        tb11 = t6.x<0.0;
        t6.x = sqrt(t6.x);
        t1.x = (-t1.x) * 2.0 + (-t6.x);
        t15 = t1.x / t15;
        t15 = (tb11) ? 1.0 : (-t15);
        t15 = t15 + t16;
        t1.x = HR * _experimentalAtmoScale;
        t6.x = 0.5 / t1.x;
        t6.x = t0.x * t6.x;
        t6.x = sqrt(t6.x);
        t11 = t15 / t0.x;
        t0.z = t0.y + t11;
        t6.xy = vec2(t0.y * t6.x, t0.z * t6.x);
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t6.xyxx).xy) * 0xFFFFFFFFu);
        ti12.xy = ivec2(uvec2(lessThan(t6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti12.xy;
        t2.xy = vec2(ti2.xy);
        t3.xyz = t6.xxy * t6.xxy;
        tb12 = t2.x<t2.y;
        t17 = t3.x * 1.44269502;
        t17 = exp2(t17);
        t12 = tb12 ? t17 : float(0.0);
        t3.xy = t3.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t3.xy = sqrt(t3.xy);
        t6.xy = abs(t6.xy) * vec2(2.31929994, 2.31929994) + t3.xy;
        t6.xy = t2.xy / t6.xy;
        t2.x = (-t15) / t1.x;
        t7 = t0.x + t0.x;
        t7 = t15 / t7;
        t7 = t0.y + t7;
        t2.x = t7 * t2.x;
        t2.x = t2.x * 1.44269502;
        t3.y = exp2(t2.x);
        t3.xz = vec2(1.0, 1.0);
        t6.xy = t6.xy * t3.xy;
        t2.x = t0.x * t1.x;
        t2.x = t2.x * 6.28310013;
        t2.x = sqrt(t2.x);
        t17 = (-t0.x) + Rg;
        t1.x = t17 / t1.x;
        t1.x = t1.x * 1.44269502;
        t1.x = exp2(t1.x);
        t1.x = t1.x * t2.x;
        t6.x = dot(t6.xy, vec2(1.0, -1.0));
        t6.x = t6.x + t12;
        t1.x = t6.x * t1.x;
        t6.x = HM * _experimentalAtmoScale;
        t11 = 0.5 / t6.x;
        t11 = t0.x * t11;
        t11 = sqrt(t11);
        t2.xz = vec2(t0.y * float(t11), t0.z * float(t11));
        ti3.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t2.xzxx).xy) * 0xFFFFFFFFu);
        ti4.xy = ivec2(uvec2(lessThan(t2.xzxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti3.xy = (-ti3.xy) + ti4.xy;
        t3.xy = vec2(ti3.xy);
        t4.xyz = t2.xxz * t2.xxz;
        tb10 = t3.x<t3.y;
        t11 = t4.x * 1.44269502;
        t11 = exp2(t11);
        t10 = tb10 ? t11 : float(0.0);
        t4.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xy = sqrt(t4.xy);
        t2.xz = abs(t2.xz) * vec2(2.31929994, 2.31929994) + t4.xy;
        t2.xz = t3.xy / t2.xz;
        t15 = (-t15) / t6.x;
        t15 = t7 * t15;
        t15 = t15 * 1.44269502;
        t3.w = exp2(t15);
        t2.xy = vec2(t2.x * t3.z, t2.z * t3.w);
        t15 = t0.x * t6.x;
        t15 = t15 * 6.28310013;
        t15 = sqrt(t15);
        t6.x = t17 / t6.x;
        t6.x = t6.x * 1.44269502;
        t6.x = exp2(t6.x);
        t15 = t15 * t6.x;
        t6.x = dot(t2.xy, vec2(1.0, -1.0));
        t10 = t10 + t6.x;
        t10 = t10 * t15;
        t2.xyz = vec3(t10) * betaMEx.xyzx.xyz;
        t1.xyz = (-betaR.xyzx.xyz) * t1.xxx + (-t2.xyz);
        t1.xyz = t1.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t1.xyz = exp2(t1.xyz);
    } else {
        t0.x = t0.x + (-Rg);
        t10 = (-Rg) + Rt;
        t0.x = t0.x / t10;
        t2.y = sqrt(t0.x);
        t0.x = t0.y + 0.150000006;
        t0.x = t0.x * 12.262105;
        t5 = min(abs(t0.x), 1.0);
        t10 = max(abs(t0.x), 1.0);
        t10 = float(1.0) / t10;
        t5 = t10 * t5;
        t10 = t5 * t5;
        t15 = t10 * 0.0208350997 + -0.0851330012;
        t15 = t10 * t15 + 0.180141002;
        t15 = t10 * t15 + -0.330299497;
        t10 = t10 * t15 + 0.999866009;
        t15 = t10 * t5;
        tb12 = 1.0<abs(t0.x);
        t15 = t15 * -2.0 + 1.57079637;
        t15 = tb12 ? t15 : float(0.0);
        t5 = t5 * t10 + t15;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t5) : t5;
        t2.x = t0.x * 0.666666687;
        t1.xyz = textureLod(_Transmittance, t2.xy, 0.0).xyz;
    //ENDIF
    }
    t0.x = t1.y + t1.x;
    t0.x = t1.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t5 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t5;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t1.xyz + t0.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb15 = 0.0>=t16;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb15)) ? t1.xyz : t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

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
bool tb0;
vec4 t1;
vec4 t2;
ivec2 ti2;
vec4 t3;
ivec2 ti3;
vec3 t4;
ivec2 ti4;
float t5;
vec2 t6;
float t7;
bool tb7;
float t10;
bool tb10;
float t11;
bool tb11;
float t12;
ivec2 ti12;
bool tb12;
float t15;
bool tb15;
float t16;
float t17;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t15 = dot(t0.xyz, t0.xyz);
    t15 = inversesqrt(t15);
    t1.yzw = vec3(t15) * t0.xyz;
    t1.x = t0.x * t15 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * t1.xzw;
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t15 = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t15);
    t0.x = dot(t2.xyz, t0.xyz);
    t3.y = t0.x / t3.x;
    t5 = t0.x * t0.x + (-t15);
    t5 = Rt * Rt + t5;
    tb10 = t5>=0.0;
    t5 = sqrt(t5);
    t5 = (tb10) ? (-t5) : -9.99999997e-007;
    t5 = t5 + (-t0.x);
    t5 = max(t5, 0.0);
    tb10 = 0.0<t5;
    t0.x = t5 + t0.x;
    t0.y = t0.x / Rt;
    t0.x = Rt;
    t0.xy = (bool(tb10)) ? t0.xy : t3.xy;
    tb15 = Rt<t0.x;
    if(tb15){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t15 = dot(t1.yzw, t1.yzw);
    t1.x = dot(t1.yzw, t2.xyz);
    t1.z = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t1.w = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t6.xy = t1.xw + t1.xz;
    t16 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t11 = (-t16) * 2.0 + t6.y;
    t16 = (-Rg) * Rg + t11;
    t6.x = t6.x * t6.x;
    t2.x = t15 * 4.0;
    t16 = (-t2.x) * t16 + t6.x;
    tb7 = t16<0.0;
    t16 = sqrt(t16);
    t16 = (-t1.x) * 2.0 + (-t16);
    t15 = t15 + t15;
    t16 = t16 / t15;
    t16 = (tb7) ? -1.0 : t16;
    tb7 = 0.0<t16;
    if(tb7){
        t11 = (-Rt) * Rt + t11;
        t6.x = (-t2.x) * t11 + t6.x;
        tb11 = t6.x<0.0;
        t6.x = sqrt(t6.x);
        t1.x = (-t1.x) * 2.0 + (-t6.x);
        t15 = t1.x / t15;
        t15 = (tb11) ? 1.0 : (-t15);
        t15 = t15 + t16;
        t1.x = HR * _experimentalAtmoScale;
        t6.x = 0.5 / t1.x;
        t6.x = t0.x * t6.x;
        t6.x = sqrt(t6.x);
        t11 = t15 / t0.x;
        t0.z = t0.y + t11;
        t6.xy = t0.yz * t6.xx;
        ti2.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t6.xyxx).xy) * 0xFFFFFFFFu);
        ti12.xy = ivec2(uvec2(lessThan(t6.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti2.xy = (-ti2.xy) + ti12.xy;
        t2.xy = vec2(ti2.xy);
        t3.xyz = t6.xxy * t6.xxy;
        tb12 = t2.x<t2.y;
        t17 = t3.x * 1.44269502;
        t17 = exp2(t17);
        t12 = tb12 ? t17 : float(0.0);
        t3.xy = t3.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t3.xy = sqrt(t3.xy);
        t6.xy = abs(t6.xy) * vec2(2.31929994, 2.31929994) + t3.xy;
        t6.xy = t2.xy / t6.xy;
        t2.x = (-t15) / t1.x;
        t7 = t0.x + t0.x;
        t7 = t15 / t7;
        t7 = t0.y + t7;
        t2.x = t7 * t2.x;
        t2.x = t2.x * 1.44269502;
        t3.y = exp2(t2.x);
        t3.xz = vec2(1.0, 1.0);
        t6.xy = t6.xy * t3.xy;
        t2.x = t0.x * t1.x;
        t2.x = t2.x * 6.28310013;
        t2.x = sqrt(t2.x);
        t17 = (-t0.x) + Rg;
        t1.x = t17 / t1.x;
        t1.x = t1.x * 1.44269502;
        t1.x = exp2(t1.x);
        t1.x = t1.x * t2.x;
        t6.x = dot(t6.xy, vec2(1.0, -1.0));
        t6.x = t6.x + t12;
        t1.x = t6.x * t1.x;
        t6.x = HM * _experimentalAtmoScale;
        t11 = 0.5 / t6.x;
        t11 = t0.x * t11;
        t11 = sqrt(t11);
        t2.xz = t0.yz * vec2(t11);
        ti3.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t2.xzxx).xy) * 0xFFFFFFFFu);
        ti4.xy = ivec2(uvec2(lessThan(t2.xzxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti3.xy = (-ti3.xy) + ti4.xy;
        t3.xy = vec2(ti3.xy);
        t4.xyz = t2.xxz * t2.xxz;
        tb10 = t3.x<t3.y;
        t11 = t4.x * 1.44269502;
        t11 = exp2(t11);
        t10 = tb10 ? t11 : float(0.0);
        t4.xy = t4.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t4.xy = sqrt(t4.xy);
        t2.xz = abs(t2.xz) * vec2(2.31929994, 2.31929994) + t4.xy;
        t2.xz = t3.xy / t2.xz;
        t15 = (-t15) / t6.x;
        t15 = t7 * t15;
        t15 = t15 * 1.44269502;
        t3.w = exp2(t15);
        t2.xy = t2.xz * t3.zw;
        t15 = t0.x * t6.x;
        t15 = t15 * 6.28310013;
        t15 = sqrt(t15);
        t6.x = t17 / t6.x;
        t6.x = t6.x * 1.44269502;
        t6.x = exp2(t6.x);
        t15 = t15 * t6.x;
        t6.x = dot(t2.xy, vec2(1.0, -1.0));
        t10 = t10 + t6.x;
        t10 = t10 * t15;
        t2.xyz = vec3(t10) * betaMEx.xyzx.xyz;
        t1.xyz = (-betaR.xyzx.xyz) * t1.xxx + (-t2.xyz);
        t1.xyz = t1.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t2.xyz = exp2(t1.xyz);
    } else {
        t0.x = t0.x + (-Rg);
        t10 = (-Rg) + Rt;
        t0.x = t0.x / t10;
        t1.y = sqrt(t0.x);
        t0.x = t0.y + 0.150000006;
        t0.x = t0.x * 12.262105;
        t5 = min(abs(t0.x), 1.0);
        t10 = max(abs(t0.x), 1.0);
        t10 = float(1.0) / t10;
        t5 = t10 * t5;
        t10 = t5 * t5;
        t15 = t10 * 0.0208350997 + -0.0851330012;
        t15 = t10 * t15 + 0.180141002;
        t15 = t10 * t15 + -0.330299497;
        t10 = t10 * t15 + 0.999866009;
        t15 = t10 * t5;
        tb11 = 1.0<abs(t0.x);
        t15 = t15 * -2.0 + 1.57079637;
        t15 = tb11 ? t15 : float(0.0);
        t5 = t5 * t10 + t15;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t5) : t5;
        t1.x = t0.x * 0.666666687;
        t2 = textureLod(_Transmittance, t1.xy, 0.0);
    //ENDIF
    }
    t0.x = t2.y + t2.x;
    t0.x = t2.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t5 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t5;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t2.xyz + t0.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb15 = 0.0>=t16;
    t1.x = (-extinctionRimFade) + 1.0;
    t1.xyz = t1.xxx * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    SV_Target0.xyz = (bool(tb15)) ? t1.xyz : t0.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 445 math, 1 textures, 20 branches
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
uniform float _viewdirOffset;
uniform vec3 _Globals_Origin;
uniform float _Extinction_Tint;
uniform float extinctionMultiplier;
uniform float extinctionRimFade;
uniform float extinctionGroundFade;
uniform vec4 sunPosAndRadius;
uniform mat4 lightOccluders1;
uniform mat4 lightOccluders2;
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  vec3 viewdir_5;
  vec3 extinction_6;
  extinction_6 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _viewdirOffset);
  vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (Rt * Rt));
  float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / Rt);
    r_4 = Rt;
  };
  if ((r_4 > Rt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
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
    if ((tmpvar_18 > 0.0)) {
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      float tmpvar_28;
      float H_29;
      H_29 = (HR * _experimentalAtmoScale);
      vec2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      vec2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      vec2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      vec2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      vec2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , vec2(1.0, -1.0))));
      float H_36;
      H_36 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      vec2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
      vec2 tmpvar_39;
      tmpvar_39 = sign(tmpvar_38);
      vec2 tmpvar_40;
      tmpvar_40 = (tmpvar_38 * tmpvar_38);
      float tmpvar_41;
      if ((tmpvar_39.y > tmpvar_39.x)) {
        tmpvar_41 = exp(tmpvar_40.x);
      } else {
        tmpvar_41 = 0.0;
      };
      vec2 tmpvar_42;
      tmpvar_42.x = 1.0;
      tmpvar_42.y = exp(((
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(betaR)
       * tmpvar_28) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), vec2(1.0, -1.0))))
      )));
    } else {
      float y_over_x_43;
      y_over_x_43 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_44;
      tmpvar_44 = (min (abs(y_over_x_43), 1.0) / max (abs(y_over_x_43), 1.0));
      float tmpvar_45;
      tmpvar_45 = (tmpvar_44 * tmpvar_44);
      tmpvar_45 = (((
        ((((
          ((((-0.01213232 * tmpvar_45) + 0.05368138) * tmpvar_45) - 0.1173503)
         * tmpvar_45) + 0.1938925) * tmpvar_45) - 0.3326756)
       * tmpvar_45) + 0.9999793) * tmpvar_44);
      tmpvar_45 = (tmpvar_45 + (float(
        (abs(y_over_x_43) > 1.0)
      ) * (
        (tmpvar_45 * -2.0)
       + 1.570796)));
      vec4 tmpvar_46;
      tmpvar_46.zw = vec2(0.0, 0.0);
      tmpvar_46.x = ((tmpvar_45 * sign(y_over_x_43)) / 1.5);
      tmpvar_46.y = sqrt(((r_4 - Rg) / (Rt - Rg)));
      extinction_6 = texture2DLod (_Transmittance, tmpvar_46.xy, 0.0).xyz;
    };
    extinction_6 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_6) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    float tmpvar_47;
    tmpvar_47 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_6 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_6));
    } else {
      float eclipseShadow_52;
      eclipseShadow_52 = 1.0;
      float tmpvar_53;
      float tmpvar_54;
      tmpvar_54 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_55;
      tmpvar_55 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_56;
      tmpvar_56 = ((tmpvar_55 * tmpvar_55) - ((4.0 * tmpvar_54) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      if ((tmpvar_56 < 0.0)) {
        tmpvar_53 = -1.0;
      } else {
        float tmpvar_57;
        tmpvar_57 = ((-(tmpvar_55) - sqrt(tmpvar_56)) / (2.0 * tmpvar_54));
        float tmpvar_58;
        if ((tmpvar_57 < 0.0)) {
          tmpvar_58 = ((-(tmpvar_55) + sqrt(tmpvar_56)) / (2.0 * tmpvar_54));
        } else {
          tmpvar_58 = tmpvar_57;
        };
        tmpvar_53 = tmpvar_58;
      };
      if ((tmpvar_53 != -1.0)) {
        int j_59;
        int i_60;
        vec3 worldPos_61;
        worldPos_61 = (_WorldSpaceCameraPos + (tmpvar_7 * tmpvar_53));
        i_60 = 0;
        while (true) {
          if ((i_60 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_60] <= 0.0)) {
            break;
          };
          vec4 v_62;
          v_62.x = lightOccluders1[0][i_60];
          v_62.y = lightOccluders1[1][i_60];
          v_62.z = lightOccluders1[2][i_60];
          v_62.w = lightOccluders1[3][i_60];
          vec3 sphereDirection_63;
          vec3 lightDirection_64;
          vec3 tmpvar_65;
          tmpvar_65 = (sunPosAndRadius.xyz - worldPos_61);
          float tmpvar_66;
          tmpvar_66 = sqrt(dot (tmpvar_65, tmpvar_65));
          lightDirection_64 = (tmpvar_65 / vec3(tmpvar_66));
          vec3 tmpvar_67;
          tmpvar_67 = (v_62.xyz - worldPos_61);
          float tmpvar_68;
          tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
          sphereDirection_63 = (tmpvar_67 / tmpvar_68);
          vec3 tmpvar_69;
          tmpvar_69 = ((lightDirection_64.yzx * sphereDirection_63.zxy) - (lightDirection_64.zxy * sphereDirection_63.yzx));
          float tmpvar_70;
          tmpvar_70 = min (1.0, sqrt(dot (tmpvar_69, tmpvar_69)));
          float tmpvar_71;
          tmpvar_71 = min (1.0, (vec3(lightOccluders1[3][i_60]) / tmpvar_68).x);
          float tmpvar_72;
          tmpvar_72 = clamp (((
            (-((vec3(tmpvar_66) * (
              (sign(tmpvar_70) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_70))
              ) * (1.570796 + 
                (abs(tmpvar_70) * (-0.2146018 + (abs(tmpvar_70) * (0.08656672 + 
                  (abs(tmpvar_70) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_71) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_71))
              ) * (1.570796 + 
                (abs(tmpvar_71) * (-0.2146018 + (abs(tmpvar_71) * (0.08656672 + 
                  (abs(tmpvar_71) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_73;
          tmpvar_73 = clamp ((dot (lightDirection_64, sphereDirection_63) / 0.2), 0.0, 1.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - (
            (tmpvar_72 * (tmpvar_72 * (3.0 - (2.0 * tmpvar_72))))
           * 
            (tmpvar_73 * (tmpvar_73 * (3.0 - (2.0 * tmpvar_73))))
          )));
          i_60++;
        };
        j_59 = 0;
        while (true) {
          if ((j_59 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_59] <= 0.0)) {
            break;
          };
          vec4 v_74;
          v_74.x = lightOccluders2[0][j_59];
          v_74.y = lightOccluders2[1][j_59];
          v_74.z = lightOccluders2[2][j_59];
          v_74.w = lightOccluders2[3][j_59];
          vec3 sphereDirection_75;
          vec3 lightDirection_76;
          vec3 tmpvar_77;
          tmpvar_77 = (sunPosAndRadius.xyz - worldPos_61);
          float tmpvar_78;
          tmpvar_78 = sqrt(dot (tmpvar_77, tmpvar_77));
          lightDirection_76 = (tmpvar_77 / vec3(tmpvar_78));
          vec3 tmpvar_79;
          tmpvar_79 = (v_74.xyz - worldPos_61);
          float tmpvar_80;
          tmpvar_80 = sqrt(dot (tmpvar_79, tmpvar_79));
          sphereDirection_75 = (tmpvar_79 / tmpvar_80);
          vec3 tmpvar_81;
          tmpvar_81 = ((lightDirection_76.yzx * sphereDirection_75.zxy) - (lightDirection_76.zxy * sphereDirection_75.yzx));
          float tmpvar_82;
          tmpvar_82 = min (1.0, sqrt(dot (tmpvar_81, tmpvar_81)));
          float tmpvar_83;
          tmpvar_83 = min (1.0, (vec3(lightOccluders2[3][j_59]) / tmpvar_80).x);
          float tmpvar_84;
          tmpvar_84 = clamp (((
            (-((vec3(tmpvar_78) * (
              (sign(tmpvar_82) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_82))
              ) * (1.570796 + 
                (abs(tmpvar_82) * (-0.2146018 + (abs(tmpvar_82) * (0.08656672 + 
                  (abs(tmpvar_82) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_83) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_83))
              ) * (1.570796 + 
                (abs(tmpvar_83) * (-0.2146018 + (abs(tmpvar_83) * (0.08656672 + 
                  (abs(tmpvar_83) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_85;
          tmpvar_85 = clamp ((dot (lightDirection_76, sphereDirection_75) / 0.2), 0.0, 1.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - (
            (tmpvar_84 * (tmpvar_84 * (3.0 - (2.0 * tmpvar_84))))
           * 
            (tmpvar_85 * (tmpvar_85 * (3.0 - (2.0 * tmpvar_85))))
          )));
          j_59++;
        };
      };
      extinction_6 = (extinction_6 * eclipseShadow_52);
      extinction_6 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_6));
    };
    vec4 tmpvar_86;
    tmpvar_86.w = 1.0;
    tmpvar_86.xyz = extinction_6;
    tmpvar_1 = tmpvar_86;
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
// Stats: 445 math, 1 textures, 20 branches
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
uniform highp float _viewdirOffset;
uniform highp vec3 _Globals_Origin;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
uniform highp float extinctionGroundFade;
uniform highp vec4 sunPosAndRadius;
uniform highp mat4 lightOccluders1;
uniform highp mat4 lightOccluders2;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float rMu_3;
  highp float r_4;
  highp vec3 viewdir_5;
  highp vec3 extinction_6;
  extinction_6 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _viewdirOffset);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  highp float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (Rt * Rt));
  highp float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  highp float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / Rt);
    r_4 = Rt;
  };
  if ((r_4 > Rt)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
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
    if ((tmpvar_18 > 0.0)) {
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rg * Rg)
      )));
      highp float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      highp float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      highp float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      highp float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      highp float tmpvar_28;
      highp float H_29;
      H_29 = (HR * _experimentalAtmoScale);
      highp vec2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      highp vec2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      highp vec2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      highp vec2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      highp float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      highp vec2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , vec2(1.0, -1.0))));
      highp float H_36;
      H_36 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      highp vec2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
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
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(betaR)
       * tmpvar_28) - (betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), vec2(1.0, -1.0))))
      )));
    } else {
      highp vec3 tmpvar_43;
      highp float y_over_x_44;
      y_over_x_44 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_45;
      tmpvar_45 = (min (abs(y_over_x_44), 1.0) / max (abs(y_over_x_44), 1.0));
      highp float tmpvar_46;
      tmpvar_46 = (tmpvar_45 * tmpvar_45);
      tmpvar_46 = (((
        ((((
          ((((-0.01213232 * tmpvar_46) + 0.05368138) * tmpvar_46) - 0.1173503)
         * tmpvar_46) + 0.1938925) * tmpvar_46) - 0.3326756)
       * tmpvar_46) + 0.9999793) * tmpvar_45);
      tmpvar_46 = (tmpvar_46 + (float(
        (abs(y_over_x_44) > 1.0)
      ) * (
        (tmpvar_46 * -2.0)
       + 1.570796)));
      highp vec4 tmpvar_47;
      tmpvar_47.zw = vec2(0.0, 0.0);
      tmpvar_47.x = ((tmpvar_46 * sign(y_over_x_44)) / 1.5);
      tmpvar_47.y = sqrt(((r_4 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_48;
      tmpvar_48 = impl_low_texture2DLodEXT (_Transmittance, tmpvar_47.xy, 0.0);
      tmpvar_43 = tmpvar_48.xyz;
      extinction_6 = tmpvar_43;
    };
    extinction_6 = (extinctionMultiplier * ((vec3(_Extinction_Tint) * extinction_6) + (vec3(
      (1.0 - _Extinction_Tint)
    ) * vec3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    highp float tmpvar_49;
    tmpvar_49 = dot (tmpvar_7, tmpvar_7);
    highp float tmpvar_50;
    tmpvar_50 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_51;
    tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
      ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
     - 
      (Rg * Rg)
    )));
    highp float tmpvar_52;
    if ((tmpvar_51 < 0.0)) {
      tmpvar_52 = -1.0;
    } else {
      tmpvar_52 = ((-(tmpvar_50) - sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    };
    bool tmpvar_53;
    tmpvar_53 = (tmpvar_52 > 0.0);
    if (!(tmpvar_53)) {
      extinction_6 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction_6));
    } else {
      highp float eclipseShadow_54;
      eclipseShadow_54 = 1.0;
      highp float tmpvar_55;
      highp float tmpvar_56;
      tmpvar_56 = dot (tmpvar_7, tmpvar_7);
      highp float tmpvar_57;
      tmpvar_57 = (2.0 * dot (tmpvar_7, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_58;
      tmpvar_58 = ((tmpvar_57 * tmpvar_57) - ((4.0 * tmpvar_56) * (
        ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
       - 
        (Rt * Rt)
      )));
      if ((tmpvar_58 < 0.0)) {
        tmpvar_55 = -1.0;
      } else {
        highp float tmpvar_59;
        tmpvar_59 = ((-(tmpvar_57) - sqrt(tmpvar_58)) / (2.0 * tmpvar_56));
        highp float tmpvar_60;
        if ((tmpvar_59 < 0.0)) {
          tmpvar_60 = ((-(tmpvar_57) + sqrt(tmpvar_58)) / (2.0 * tmpvar_56));
        } else {
          tmpvar_60 = tmpvar_59;
        };
        tmpvar_55 = tmpvar_60;
      };
      if ((tmpvar_55 != -1.0)) {
        highp int j_61;
        highp int i_62;
        highp vec3 worldPos_63;
        worldPos_63 = (_WorldSpaceCameraPos + (tmpvar_7 * tmpvar_55));
        i_62 = 0;
        while (true) {
          if ((i_62 >= 4)) {
            break;
          };
          if ((lightOccluders1[3][i_62] <= 0.0)) {
            break;
          };
          highp vec4 v_64;
          v_64.x = lightOccluders1[0][i_62];
          v_64.y = lightOccluders1[1][i_62];
          v_64.z = lightOccluders1[2][i_62];
          v_64.w = lightOccluders1[3][i_62];
          highp vec3 sphereDirection_65;
          highp vec3 lightDirection_66;
          highp vec3 tmpvar_67;
          tmpvar_67 = (sunPosAndRadius.xyz - worldPos_63);
          highp float tmpvar_68;
          tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
          lightDirection_66 = (tmpvar_67 / vec3(tmpvar_68));
          highp vec3 tmpvar_69;
          tmpvar_69 = (v_64.xyz - worldPos_63);
          highp float tmpvar_70;
          tmpvar_70 = sqrt(dot (tmpvar_69, tmpvar_69));
          sphereDirection_65 = (tmpvar_69 / tmpvar_70);
          highp vec3 tmpvar_71;
          tmpvar_71 = ((lightDirection_66.yzx * sphereDirection_65.zxy) - (lightDirection_66.zxy * sphereDirection_65.yzx));
          highp float tmpvar_72;
          tmpvar_72 = min (1.0, sqrt(dot (tmpvar_71, tmpvar_71)));
          highp float tmpvar_73;
          tmpvar_73 = min (1.0, (vec3(lightOccluders1[3][i_62]) / tmpvar_70).x);
          highp float tmpvar_74;
          tmpvar_74 = clamp (((
            (-((vec3(tmpvar_68) * (
              (sign(tmpvar_72) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_72))
              ) * (1.570796 + 
                (abs(tmpvar_72) * (-0.2146018 + (abs(tmpvar_72) * (0.08656672 + 
                  (abs(tmpvar_72) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_73) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_73))
              ) * (1.570796 + 
                (abs(tmpvar_73) * (-0.2146018 + (abs(tmpvar_73) * (0.08656672 + 
                  (abs(tmpvar_73) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_75;
          tmpvar_75 = clamp ((dot (lightDirection_66, sphereDirection_65) / 0.2), 0.0, 1.0);
          eclipseShadow_54 = (eclipseShadow_54 * (1.0 - (
            (tmpvar_74 * (tmpvar_74 * (3.0 - (2.0 * tmpvar_74))))
           * 
            (tmpvar_75 * (tmpvar_75 * (3.0 - (2.0 * tmpvar_75))))
          )));
          i_62++;
        };
        j_61 = 0;
        while (true) {
          if ((j_61 >= 4)) {
            break;
          };
          if ((lightOccluders2[3][j_61] <= 0.0)) {
            break;
          };
          highp vec4 v_76;
          v_76.x = lightOccluders2[0][j_61];
          v_76.y = lightOccluders2[1][j_61];
          v_76.z = lightOccluders2[2][j_61];
          v_76.w = lightOccluders2[3][j_61];
          highp vec3 sphereDirection_77;
          highp vec3 lightDirection_78;
          highp vec3 tmpvar_79;
          tmpvar_79 = (sunPosAndRadius.xyz - worldPos_63);
          highp float tmpvar_80;
          tmpvar_80 = sqrt(dot (tmpvar_79, tmpvar_79));
          lightDirection_78 = (tmpvar_79 / vec3(tmpvar_80));
          highp vec3 tmpvar_81;
          tmpvar_81 = (v_76.xyz - worldPos_63);
          highp float tmpvar_82;
          tmpvar_82 = sqrt(dot (tmpvar_81, tmpvar_81));
          sphereDirection_77 = (tmpvar_81 / tmpvar_82);
          highp vec3 tmpvar_83;
          tmpvar_83 = ((lightDirection_78.yzx * sphereDirection_77.zxy) - (lightDirection_78.zxy * sphereDirection_77.yzx));
          highp float tmpvar_84;
          tmpvar_84 = min (1.0, sqrt(dot (tmpvar_83, tmpvar_83)));
          highp float tmpvar_85;
          tmpvar_85 = min (1.0, (vec3(lightOccluders2[3][j_61]) / tmpvar_82).x);
          highp float tmpvar_86;
          tmpvar_86 = clamp (((
            (-((vec3(tmpvar_80) * (
              (sign(tmpvar_84) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_84))
              ) * (1.570796 + 
                (abs(tmpvar_84) * (-0.2146018 + (abs(tmpvar_84) * (0.08656672 + 
                  (abs(tmpvar_84) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_85) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_85))
              ) * (1.570796 + 
                (abs(tmpvar_85) * (-0.2146018 + (abs(tmpvar_85) * (0.08656672 + 
                  (abs(tmpvar_85) * -0.03102955)
                ))))
              ))))
            )).x) / sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          highp float tmpvar_87;
          tmpvar_87 = clamp ((dot (lightDirection_78, sphereDirection_77) / 0.2), 0.0, 1.0);
          eclipseShadow_54 = (eclipseShadow_54 * (1.0 - (
            (tmpvar_86 * (tmpvar_86 * (3.0 - (2.0 * tmpvar_86))))
           * 
            (tmpvar_87 * (tmpvar_87 * (3.0 - (2.0 * tmpvar_87))))
          )));
          j_61++;
        };
      };
      extinction_6 = (extinction_6 * eclipseShadow_54);
      extinction_6 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction_6));
    };
    highp vec4 tmpvar_88;
    tmpvar_88.w = 1.0;
    tmpvar_88.xyz = extinction_6;
    tmpvar_1 = tmpvar_88;
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
bool tb0;
highp vec4 t1;
bool tb1;
highp vec3 t2;
highp vec4 t3;
bool tb3;
highp vec3 t4;
highp ivec2 ti4;
bool tb4;
highp vec4 t5;
highp ivec2 ti5;
highp vec3 t6;
highp ivec2 ti6;
highp float t7;
highp float t9;
bool tb9;
highp float t10;
bool tb10;
highp vec3 t11;
bool tb11;
highp vec3 t12;
highp float t14;
bool tb14;
highp float t16;
bool tb16;
highp vec2 t17;
highp float t18;
highp ivec2 ti18;
bool tb18;
highp float t19;
highp float t21;
bool tb21;
highp float t22;
highp float t23;
highp int ti23;
bool tb23;
highp float t24;
highp int ti24;
bool tb24;
highp float t25;
highp float t26;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t21 = dot(t0.xyz, t0.xyz);
    t21 = inversesqrt(t21);
    t1.yzw = vec3(t21) * t0.xyz;
    t1.x = t0.x * t21 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * t1.xzw;
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t21 = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t21);
    t0.x = dot(t2.xyz, t0.xyz);
    t3.y = t0.x / t3.x;
    t7 = t0.x * t0.x + (-t21);
    t7 = Rt * Rt + t7;
    tb14 = t7>=0.0;
    t7 = sqrt(t7);
    t7 = (tb14) ? (-t7) : -9.99999997e-007;
    t7 = t7 + (-t0.x);
    t7 = max(t7, 0.0);
    tb14 = 0.0<t7;
    t0.x = t7 + t0.x;
    t0.y = t0.x / Rt;
    t0.x = Rt;
    t0.xy = (bool(tb14)) ? t0.xy : t3.xy;
    tb21 = Rt<t0.x;
    if(tb21){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t21 = dot(t1.yzw, t1.yzw);
    t1.x = dot(t1.yzw, t2.xyz);
    t2.x = t1.x + t1.x;
    t9 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t16 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t9 = t16 + t9;
    t16 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t9 = (-t16) * 2.0 + t9;
    t16 = (-Rg) * Rg + t9;
    t2.x = t2.x * t2.x;
    t23 = t21 * 4.0;
    t16 = (-t23) * t16 + t2.x;
    tb3 = t16<0.0;
    t16 = sqrt(t16);
    t16 = (-t1.x) * 2.0 + (-t16);
    t21 = t21 + t21;
    t16 = t16 / t21;
    t16 = (tb3) ? -1.0 : t16;
    tb3 = 0.0<t16;
    if(tb3){
        t3.x = (-Rt) * Rt + t9;
        t3.x = (-t23) * t3.x + t2.x;
        tb10 = t3.x<0.0;
        t3.x = sqrt(t3.x);
        t3.x = (-t1.x) * 2.0 + (-t3.x);
        t3.x = t3.x / t21;
        t3.x = (tb10) ? 1.0 : (-t3.x);
        t3.x = t16 + t3.x;
        t10 = HR * _experimentalAtmoScale;
        t17.x = 0.5 / t10;
        t17.x = t0.x * t17.x;
        t17.x = sqrt(t17.x);
        t24 = t3.x / t0.x;
        t0.z = t0.y + t24;
        t17.xy = vec2(t0.y * t17.x, t0.z * t17.x);
        ti4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t17.xyxx).xy) * 0xFFFFFFFFu);
        ti18.xy = ivec2(uvec2(lessThan(t17.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xy = (-ti4.xy) + ti18.xy;
        t4.xy = vec2(ti4.xy);
        t5.xyz = t17.xxy * t17.xxy;
        tb18 = t4.x<t4.y;
        t25 = t5.x * 1.44269502;
        t25 = exp2(t25);
        t18 = tb18 ? t25 : float(0.0);
        t5.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t17.xy = abs(t17.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t17.xy = t4.xy / t17.xy;
        t4.x = (-t3.x) / t10;
        t11.x = t0.x + t0.x;
        t11.x = t3.x / t11.x;
        t11.x = t0.y + t11.x;
        t4.x = t11.x * t4.x;
        t4.x = t4.x * 1.44269502;
        t5.y = exp2(t4.x);
        t5.xz = vec2(1.0, 1.0);
        t17.xy = t17.xy * t5.xy;
        t4.x = t0.x * t10;
        t4.x = t4.x * 6.28310013;
        t4.x = sqrt(t4.x);
        t25 = (-t0.x) + Rg;
        t10 = t25 / t10;
        t10 = t10 * 1.44269502;
        t10 = exp2(t10);
        t10 = t10 * t4.x;
        t17.x = dot(t17.xy, vec2(1.0, -1.0));
        t17.x = t17.x + t18;
        t10 = t17.x * t10;
        t17.x = HM * _experimentalAtmoScale;
        t24 = 0.5 / t17.x;
        t24 = t0.x * t24;
        t24 = sqrt(t24);
        t4.xz = vec2(t0.y * float(t24), t0.z * float(t24));
        ti5.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t4.xzxx).xy) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t4.xzxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti5.xy = (-ti5.xy) + ti6.xy;
        t5.xy = vec2(ti5.xy);
        t6.xyz = t4.xxz * t4.xxz;
        tb14 = t5.x<t5.y;
        t24 = t6.x * 1.44269502;
        t24 = exp2(t24);
        t14 = tb14 ? t24 : float(0.0);
        t6.xy = t6.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t4.xz = abs(t4.xz) * vec2(2.31929994, 2.31929994) + t6.xy;
        t4.xz = t5.xy / t4.xz;
        t3.x = (-t3.x) / t17.x;
        t3.x = t11.x * t3.x;
        t3.x = t3.x * 1.44269502;
        t5.w = exp2(t3.x);
        t3.xw = vec2(t4.x * t5.z, t4.z * t5.w);
        t4.x = t0.x * t17.x;
        t4.x = t4.x * 6.28310013;
        t4.x = sqrt(t4.x);
        t17.x = t25 / t17.x;
        t17.x = t17.x * 1.44269502;
        t17.x = exp2(t17.x);
        t17.x = t17.x * t4.x;
        t3.x = dot(t3.xw, vec2(1.0, -1.0));
        t14 = t14 + t3.x;
        t14 = t14 * t17.x;
        t3.xzw = vec3(t14) * betaMEx.xyzx.xyz;
        t3.xyz = (-betaR.xyzx.xyz) * vec3(t10) + (-t3.xzw);
        t3.xyz = t3.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t3.xyz = exp2(t3.xyz);
    } else {
        t0.x = t0.x + (-Rg);
        t14 = (-Rg) + Rt;
        t0.x = t0.x / t14;
        t4.y = sqrt(t0.x);
        t0.x = t0.y + 0.150000006;
        t0.x = t0.x * 12.262105;
        t7 = min(abs(t0.x), 1.0);
        t14 = max(abs(t0.x), 1.0);
        t14 = float(1.0) / t14;
        t7 = t14 * t7;
        t14 = t7 * t7;
        t24 = t14 * 0.0208350997 + -0.0851330012;
        t24 = t14 * t24 + 0.180141002;
        t24 = t14 * t24 + -0.330299497;
        t14 = t14 * t24 + 0.999866009;
        t24 = t14 * t7;
        tb18 = 1.0<abs(t0.x);
        t24 = t24 * -2.0 + 1.57079637;
        t24 = tb18 ? t24 : float(0.0);
        t7 = t7 * t14 + t24;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t7) : t7;
        t4.x = t0.x * 0.666666687;
        t3.xyz = textureLod(_Transmittance, t4.xy, 0.0).xyz;
    //ENDIF
    }
    t0.x = t3.y + t3.x;
    t0.x = t3.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t7 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t7;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t3.xyz + t0.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb16 = 0.0>=t16;
    if(tb16){
        t16 = (-extinctionRimFade) + 1.0;
        t3.xyz = vec3(t16) * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t9 = (-Rt) * Rt + t9;
        t2.x = (-t23) * t9 + t2.x;
        tb9 = t2.x>=0.0;
        t2.x = sqrt(t2.x);
        t16 = (-t1.x) * 2.0 + (-t2.x);
        t16 = t16 / t21;
        tb23 = t16<0.0;
        t1.x = (-t1.x) * 2.0 + t2.x;
        t21 = t1.x / t21;
        t21 = (tb23) ? t21 : t16;
        t21 = (tb9) ? t21 : -1.0;
        tb1 = t21!=-1.0;
        if(tb1){
            t1.xyz = t1.yzw * vec3(t21) + _WorldSpaceCameraPos.xyzx.xyz;
            t2.xyz = (-t1.xyz) + sunPosAndRadius.xyz;
            t21 = dot(t2.xyz, t2.xyz);
            t21 = sqrt(t21);
            t2.xyz = t2.xyz / vec3(t21);
            t22 = 1.0;
            ti23 = 0x0;
            while(true){
                tb24 = ti23>=0x4;
                if(tb24){break;}
                t24 = dot(lightOccluders1[3], immediateConstBufferF[ti23]);
                tb4 = 0.0>=t24;
                if(tb4){
                    break;
                //ENDIF
                }
                t4.x = dot(lightOccluders1[0], immediateConstBufferF[ti23]);
                t4.y = dot(lightOccluders1[1], immediateConstBufferF[ti23]);
                t4.z = dot(lightOccluders1[2], immediateConstBufferF[ti23]);
                t4.xyz = (-t1.xyz) + t4.xyz;
                t25 = dot(t4.xyz, t4.xyz);
                t25 = sqrt(t25);
                t4.xyz = t4.xyz / vec3(t25);
                t5.xyz = t2.zxy * t4.yzx;
                t5.xyz = t2.yzx * t4.zxy + (-t5.xyz);
                t5.x = dot(t5.xyz, t5.xyz);
                t5.x = sqrt(t5.x);
                t5.x = min(t5.x, 1.0);
                t12.x = (-t5.x) + 1.0;
                t12.x = sqrt(t12.x);
                t19 = t5.x * -0.0187292993 + 0.0742610022;
                t19 = t19 * t5.x + -0.212114394;
                t5.x = t19 * t5.x + 1.57072878;
                t5.x = (-t5.x) * t12.x + 1.57079637;
                t24 = t24 / t25;
                t24 = min(t24, 1.0);
                t25 = -abs(t24) + 1.0;
                t25 = sqrt(t25);
                t12.x = abs(t24) * -0.0187292993 + 0.0742610022;
                t12.x = t12.x * abs(t24) + -0.212114394;
                t12.x = t12.x * abs(t24) + 1.57072878;
                t19 = t25 * t12.x;
                t19 = t19 * -2.0 + 3.14159274;
                tb24 = t24<(-t24);
                t24 = tb24 ? t19 : float(0.0);
                t24 = t12.x * t25 + t24;
                t24 = (-t24) + 1.57079637;
                t24 = (-t24) + t5.x;
                t24 = t21 * t24;
                t24 = (-t24) / sunPosAndRadius.w;
                t24 = t24 + 1.0;
                t24 = t24 * 0.5;
                t24 = clamp(t24, 0.0, 1.0);
                t25 = t24 * -2.0 + 3.0;
                t24 = t24 * t24;
                t24 = t24 * t25;
                t4.x = dot(t2.xyz, t4.xyz);
                t4.x = t4.x * 5.0;
                t4.x = clamp(t4.x, 0.0, 1.0);
                t11.x = t4.x * -2.0 + 3.0;
                t4.x = t4.x * t4.x;
                t4.x = t4.x * t11.x;
                t24 = (-t24) * t4.x + 1.0;
                t22 = t22 * t24;
                ti23 = ti23 + 0x1;
            }
            t23 = t22;
            ti24 = 0x0;
            while(true){
                tb4 = ti24>=0x4;
                if(tb4){break;}
                t4.x = dot(lightOccluders2[3], immediateConstBufferF[ti24]);
                tb11 = 0.0>=t4.x;
                if(tb11){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti24]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti24]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti24]);
                t11.xyz = (-t1.xyz) + t5.xyz;
                t5.x = dot(t11.xyz, t11.xyz);
                t5.x = sqrt(t5.x);
                t11.xyz = t11.xyz / t5.xxx;
                t12.xyz = t2.zxy * t11.yzx;
                t12.xyz = t2.yzx * t11.zxy + (-t12.xyz);
                t12.x = dot(t12.xyz, t12.xyz);
                t12.x = sqrt(t12.x);
                t12.x = min(t12.x, 1.0);
                t19 = (-t12.x) + 1.0;
                t19 = sqrt(t19);
                t26 = t12.x * -0.0187292993 + 0.0742610022;
                t26 = t26 * t12.x + -0.212114394;
                t12.x = t26 * t12.x + 1.57072878;
                t12.x = (-t12.x) * t19 + 1.57079637;
                t4.x = t4.x / t5.x;
                t4.x = min(t4.x, 1.0);
                t5.x = -abs(t4.x) + 1.0;
                t5.x = sqrt(t5.x);
                t19 = abs(t4.x) * -0.0187292993 + 0.0742610022;
                t19 = t19 * abs(t4.x) + -0.212114394;
                t19 = t19 * abs(t4.x) + 1.57072878;
                t26 = t5.x * t19;
                t26 = t26 * -2.0 + 3.14159274;
                tb4 = t4.x<(-t4.x);
                t4.x = tb4 ? t26 : float(0.0);
                t4.x = t19 * t5.x + t4.x;
                t4.x = (-t4.x) + 1.57079637;
                t4.x = (-t4.x) + t12.x;
                t4.x = t21 * t4.x;
                t4.x = (-t4.x) / sunPosAndRadius.w;
                t4.x = t4.x + 1.0;
                t4.x = t4.x * 0.5;
                t4.x = clamp(t4.x, 0.0, 1.0);
                t5.x = t4.x * -2.0 + 3.0;
                t4.x = t4.x * t4.x;
                t4.x = t4.x * t5.x;
                t11.x = dot(t2.xyz, t11.xyz);
                t11.x = t11.x * 5.0;
                t11.x = clamp(t11.x, 0.0, 1.0);
                t18 = t11.x * -2.0 + 3.0;
                t11.x = t11.x * t11.x;
                t11.x = t11.x * t18;
                t4.x = (-t4.x) * t11.x + 1.0;
                t23 = t23 * t4.x;
                ti24 = ti24 + 0x1;
            }
        } else {
            t23 = 1.0;
        //ENDIF
        }
        t0.xyz = t0.xyz * vec3(t23);
        t21 = (-extinctionGroundFade) + 1.0;
        t3.xyz = vec3(t21) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "metal " {
// Stats: 2 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

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
bool tb0;
vec4 t1;
bool tb1;
vec3 t2;
vec4 t3;
bool tb3;
vec3 t4;
ivec2 ti4;
bool tb4;
vec4 t5;
ivec2 ti5;
vec3 t6;
ivec2 ti6;
float t7;
float t9;
bool tb9;
float t10;
bool tb10;
vec3 t11;
bool tb11;
vec3 t12;
float t14;
bool tb14;
float t16;
bool tb16;
vec2 t17;
float t18;
ivec2 ti18;
bool tb18;
float t19;
float t21;
bool tb21;
float t22;
float t23;
int ti23;
bool tb23;
float t24;
int ti24;
bool tb24;
float t25;
bool tb25;
float t26;
void main()
{
    t0.xyz = vs_TEXCOORD0.xyz + (-_WorldSpaceCameraPos.xyzx.xyz);
    t21 = dot(t0.xyz, t0.xyz);
    t21 = inversesqrt(t21);
    t1.yzw = vec3(t21) * t0.xyz;
    t1.x = t0.x * t21 + _viewdirOffset;
    t0.x = dot(t1.xzw, t1.xzw);
    t0.x = inversesqrt(t0.x);
    t0.xyz = t0.xxx * t1.xzw;
    t2.xyz = _WorldSpaceCameraPos.xyzx.xyz + (-_Globals_Origin.xyzx.xyz);
    t21 = dot(t2.xyz, t2.xyz);
    t3.x = sqrt(t21);
    t0.x = dot(t2.xyz, t0.xyz);
    t3.y = t0.x / t3.x;
    t7 = t0.x * t0.x + (-t21);
    t7 = Rt * Rt + t7;
    tb14 = t7>=0.0;
    t7 = sqrt(t7);
    t7 = (tb14) ? (-t7) : -9.99999997e-007;
    t7 = t7 + (-t0.x);
    t7 = max(t7, 0.0);
    tb14 = 0.0<t7;
    t0.x = t7 + t0.x;
    t0.y = t0.x / Rt;
    t0.x = Rt;
    t0.xy = (bool(tb14)) ? t0.xy : t3.xy;
    tb21 = Rt<t0.x;
    if(tb21){
        SV_Target0 = vec4(1.0, 1.0, 1.0, 1.0);
        return;
    //ENDIF
    }
    t21 = dot(t1.yzw, t1.yzw);
    t1.x = dot(t1.yzw, t2.xyz);
    t2.x = t1.x + t1.x;
    t9 = dot(_Globals_Origin.xyzx.xyz, _Globals_Origin.xyzx.xyz);
    t16 = dot(_WorldSpaceCameraPos.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t9 = t16 + t9;
    t16 = dot(_Globals_Origin.xyzx.xyz, _WorldSpaceCameraPos.xyzx.xyz);
    t9 = (-t16) * 2.0 + t9;
    t16 = (-Rg) * Rg + t9;
    t2.x = t2.x * t2.x;
    t23 = t21 * 4.0;
    t16 = (-t23) * t16 + t2.x;
    tb3 = t16<0.0;
    t16 = sqrt(t16);
    t16 = (-t1.x) * 2.0 + (-t16);
    t21 = t21 + t21;
    t16 = t16 / t21;
    t16 = (tb3) ? -1.0 : t16;
    tb3 = 0.0<t16;
    if(tb3){
        t3.x = (-Rt) * Rt + t9;
        t3.x = (-t23) * t3.x + t2.x;
        tb10 = t3.x<0.0;
        t3.x = sqrt(t3.x);
        t3.x = (-t1.x) * 2.0 + (-t3.x);
        t3.x = t3.x / t21;
        t3.x = (tb10) ? 1.0 : (-t3.x);
        t3.x = t16 + t3.x;
        t10 = HR * _experimentalAtmoScale;
        t17.x = 0.5 / t10;
        t17.x = t0.x * t17.x;
        t17.x = sqrt(t17.x);
        t24 = t3.x / t0.x;
        t0.z = t0.y + t24;
        t17.xy = t0.yz * t17.xx;
        ti4.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t17.xyxx).xy) * 0xFFFFFFFFu);
        ti18.xy = ivec2(uvec2(lessThan(t17.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti4.xy = (-ti4.xy) + ti18.xy;
        t4.xy = vec2(ti4.xy);
        t5.xyz = t17.xxy * t17.xxy;
        tb18 = t4.x<t4.y;
        t25 = t5.x * 1.44269502;
        t25 = exp2(t25);
        t18 = tb18 ? t25 : float(0.0);
        t5.xy = t5.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t5.xy = sqrt(t5.xy);
        t17.xy = abs(t17.xy) * vec2(2.31929994, 2.31929994) + t5.xy;
        t17.xy = t4.xy / t17.xy;
        t4.x = (-t3.x) / t10;
        t11.x = t0.x + t0.x;
        t11.x = t3.x / t11.x;
        t11.x = t0.y + t11.x;
        t4.x = t11.x * t4.x;
        t4.x = t4.x * 1.44269502;
        t5.y = exp2(t4.x);
        t5.xz = vec2(1.0, 1.0);
        t17.xy = t17.xy * t5.xy;
        t4.x = t0.x * t10;
        t4.x = t4.x * 6.28310013;
        t4.x = sqrt(t4.x);
        t25 = (-t0.x) + Rg;
        t10 = t25 / t10;
        t10 = t10 * 1.44269502;
        t10 = exp2(t10);
        t10 = t10 * t4.x;
        t17.x = dot(t17.xy, vec2(1.0, -1.0));
        t17.x = t17.x + t18;
        t10 = t17.x * t10;
        t17.x = HM * _experimentalAtmoScale;
        t24 = 0.5 / t17.x;
        t24 = t0.x * t24;
        t24 = sqrt(t24);
        t4.xz = t0.yz * vec2(t24);
        ti5.xy = ivec2(uvec2(lessThan(vec4(0.0, 0.0, 0.0, 0.0), t4.xzxx).xy) * 0xFFFFFFFFu);
        ti6.xy = ivec2(uvec2(lessThan(t4.xzxx, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
        ti5.xy = (-ti5.xy) + ti6.xy;
        t5.xy = vec2(ti5.xy);
        t6.xyz = t4.xxz * t4.xxz;
        tb14 = t5.x<t5.y;
        t24 = t6.x * 1.44269502;
        t24 = exp2(t24);
        t14 = tb14 ? t24 : float(0.0);
        t6.xy = t6.yz * vec2(1.51999998, 1.51999998) + vec2(4.0, 4.0);
        t6.xy = sqrt(t6.xy);
        t4.xz = abs(t4.xz) * vec2(2.31929994, 2.31929994) + t6.xy;
        t4.xz = t5.xy / t4.xz;
        t3.x = (-t3.x) / t17.x;
        t3.x = t11.x * t3.x;
        t3.x = t3.x * 1.44269502;
        t5.w = exp2(t3.x);
        t3.xw = t4.xz * t5.zw;
        t4.x = t0.x * t17.x;
        t4.x = t4.x * 6.28310013;
        t4.x = sqrt(t4.x);
        t17.x = t25 / t17.x;
        t17.x = t17.x * 1.44269502;
        t17.x = exp2(t17.x);
        t17.x = t17.x * t4.x;
        t3.x = dot(t3.xw, vec2(1.0, -1.0));
        t14 = t14 + t3.x;
        t14 = t14 * t17.x;
        t3.xzw = vec3(t14) * betaMEx.xyzx.xyz;
        t3.xyz = (-betaR.xyzx.xyz) * vec3(t10) + (-t3.xzw);
        t3.xyz = t3.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        t3.xyz = exp2(t3.xyz);
    } else {
        t0.x = t0.x + (-Rg);
        t14 = (-Rg) + Rt;
        t0.x = t0.x / t14;
        t4.y = sqrt(t0.x);
        t0.x = t0.y + 0.150000006;
        t0.x = t0.x * 12.262105;
        t7 = min(abs(t0.x), 1.0);
        t14 = max(abs(t0.x), 1.0);
        t14 = float(1.0) / t14;
        t7 = t14 * t7;
        t14 = t7 * t7;
        t18 = t14 * 0.0208350997 + -0.0851330012;
        t18 = t14 * t18 + 0.180141002;
        t18 = t14 * t18 + -0.330299497;
        t14 = t14 * t18 + 0.999866009;
        t18 = t14 * t7;
        tb25 = 1.0<abs(t0.x);
        t18 = t18 * -2.0 + 1.57079637;
        t18 = tb25 ? t18 : float(0.0);
        t7 = t7 * t14 + t18;
        t0.x = min(t0.x, 1.0);
        tb0 = t0.x<(-t0.x);
        t0.x = (tb0) ? (-t7) : t7;
        t4.x = t0.x * 0.666666687;
        t3 = textureLod(_Transmittance, t4.xy, 0.0);
    //ENDIF
    }
    t0.x = t3.y + t3.x;
    t0.x = t3.z + t0.x;
    t0.x = t0.x * 0.333333343;
    t7 = (-_Extinction_Tint) + 1.0;
    t0.x = t0.x * t7;
    t0.xyz = vec3(vec3(_Extinction_Tint, _Extinction_Tint, _Extinction_Tint)) * t3.xyz + t0.xxx;
    t0.xyz = t0.xyz * vec3(extinctionMultiplier);
    tb16 = 0.0>=t16;
    if(tb16){
        t16 = (-extinctionRimFade) + 1.0;
        t3.xyz = vec3(t16) * t0.xyz + vec3(vec3(extinctionRimFade, extinctionRimFade, extinctionRimFade));
    } else {
        t9 = (-Rt) * Rt + t9;
        t2.x = (-t23) * t9 + t2.x;
        tb9 = t2.x>=0.0;
        t2.x = sqrt(t2.x);
        t16 = (-t1.x) * 2.0 + (-t2.x);
        t16 = t16 / t21;
        tb23 = t16<0.0;
        t1.x = (-t1.x) * 2.0 + t2.x;
        t21 = t1.x / t21;
        t21 = (tb23) ? t21 : t16;
        t21 = (tb9) ? t21 : -1.0;
        tb1 = t21!=-1.0;
        if(tb1){
            t1.xyz = t1.yzw * vec3(t21) + _WorldSpaceCameraPos.xyzx.xyz;
            t2.xyz = (-t1.xyz) + sunPosAndRadius.xyz;
            t21 = dot(t2.xyz, t2.xyz);
            t21 = sqrt(t21);
            t2.xyz = t2.xyz / vec3(t21);
            t22 = 1.0;
            ti23 = 0x0;
            while(true){
                tb24 = ti23>=0x4;
                if(tb24){break;}
                t24 = dot(lightOccluders1[3], immediateConstBufferF[ti23]);
                tb4 = 0.0>=t24;
                if(tb4){
                    break;
                //ENDIF
                }
                t4.x = dot(lightOccluders1[0], immediateConstBufferF[ti23]);
                t4.y = dot(lightOccluders1[1], immediateConstBufferF[ti23]);
                t4.z = dot(lightOccluders1[2], immediateConstBufferF[ti23]);
                t4.xyz = (-t1.xyz) + t4.xyz;
                t25 = dot(t4.xyz, t4.xyz);
                t25 = sqrt(t25);
                t4.xyz = t4.xyz / vec3(t25);
                t5.xyz = t2.zxy * t4.yzx;
                t5.xyz = t2.yzx * t4.zxy + (-t5.xyz);
                t5.x = dot(t5.xyz, t5.xyz);
                t5.x = sqrt(t5.x);
                t5.x = min(t5.x, 1.0);
                t12.x = (-t5.x) + 1.0;
                t12.x = sqrt(t12.x);
                t19 = t5.x * -0.0187292993 + 0.0742610022;
                t19 = t19 * t5.x + -0.212114394;
                t5.x = t19 * t5.x + 1.57072878;
                t5.x = (-t5.x) * t12.x + 1.57079637;
                t24 = t24 / t25;
                t24 = min(t24, 1.0);
                t25 = -abs(t24) + 1.0;
                t25 = sqrt(t25);
                t12.x = abs(t24) * -0.0187292993 + 0.0742610022;
                t12.x = t12.x * abs(t24) + -0.212114394;
                t12.x = t12.x * abs(t24) + 1.57072878;
                t19 = t25 * t12.x;
                t19 = t19 * -2.0 + 3.14159274;
                tb24 = t24<(-t24);
                t24 = tb24 ? t19 : float(0.0);
                t24 = t12.x * t25 + t24;
                t24 = (-t24) + 1.57079637;
                t24 = (-t24) + t5.x;
                t24 = t21 * t24;
                t24 = (-t24) / sunPosAndRadius.w;
                t24 = t24 + 1.0;
                t24 = t24 * 0.5;
                t24 = clamp(t24, 0.0, 1.0);
                t25 = t24 * -2.0 + 3.0;
                t24 = t24 * t24;
                t24 = t24 * t25;
                t4.x = dot(t2.xyz, t4.xyz);
                t4.x = t4.x * 5.0;
                t4.x = clamp(t4.x, 0.0, 1.0);
                t11.x = t4.x * -2.0 + 3.0;
                t4.x = t4.x * t4.x;
                t4.x = t4.x * t11.x;
                t24 = (-t24) * t4.x + 1.0;
                t22 = t22 * t24;
                ti23 = ti23 + 0x1;
            }
            t23 = t22;
            ti24 = 0x0;
            while(true){
                tb4 = ti24>=0x4;
                if(tb4){break;}
                t4.x = dot(lightOccluders2[3], immediateConstBufferF[ti24]);
                tb11 = 0.0>=t4.x;
                if(tb11){
                    break;
                //ENDIF
                }
                t5.x = dot(lightOccluders2[0], immediateConstBufferF[ti24]);
                t5.y = dot(lightOccluders2[1], immediateConstBufferF[ti24]);
                t5.z = dot(lightOccluders2[2], immediateConstBufferF[ti24]);
                t11.xyz = (-t1.xyz) + t5.xyz;
                t5.x = dot(t11.xyz, t11.xyz);
                t5.x = sqrt(t5.x);
                t11.xyz = t11.xyz / t5.xxx;
                t12.xyz = t2.zxy * t11.yzx;
                t12.xyz = t2.yzx * t11.zxy + (-t12.xyz);
                t12.x = dot(t12.xyz, t12.xyz);
                t12.x = sqrt(t12.x);
                t12.x = min(t12.x, 1.0);
                t19 = (-t12.x) + 1.0;
                t19 = sqrt(t19);
                t26 = t12.x * -0.0187292993 + 0.0742610022;
                t26 = t26 * t12.x + -0.212114394;
                t12.x = t26 * t12.x + 1.57072878;
                t12.x = (-t12.x) * t19 + 1.57079637;
                t4.x = t4.x / t5.x;
                t4.x = min(t4.x, 1.0);
                t5.x = -abs(t4.x) + 1.0;
                t5.x = sqrt(t5.x);
                t19 = abs(t4.x) * -0.0187292993 + 0.0742610022;
                t19 = t19 * abs(t4.x) + -0.212114394;
                t19 = t19 * abs(t4.x) + 1.57072878;
                t26 = t5.x * t19;
                t26 = t26 * -2.0 + 3.14159274;
                tb4 = t4.x<(-t4.x);
                t4.x = tb4 ? t26 : float(0.0);
                t4.x = t19 * t5.x + t4.x;
                t4.x = (-t4.x) + 1.57079637;
                t4.x = (-t4.x) + t12.x;
                t4.x = t21 * t4.x;
                t4.x = (-t4.x) / sunPosAndRadius.w;
                t4.x = t4.x + 1.0;
                t4.x = t4.x * 0.5;
                t4.x = clamp(t4.x, 0.0, 1.0);
                t5.x = t4.x * -2.0 + 3.0;
                t4.x = t4.x * t4.x;
                t4.x = t4.x * t5.x;
                t11.x = dot(t2.xyz, t11.xyz);
                t11.x = t11.x * 5.0;
                t11.x = clamp(t11.x, 0.0, 1.0);
                t18 = t11.x * -2.0 + 3.0;
                t11.x = t11.x * t11.x;
                t11.x = t11.x * t18;
                t4.x = (-t4.x) * t11.x + 1.0;
                t23 = t23 * t4.x;
                ti24 = ti24 + 0x1;
            }
        } else {
            t23 = 1.0;
        //ENDIF
        }
        t0.xyz = t0.xyz * vec3(t23);
        t21 = (-extinctionGroundFade) + 1.0;
        t3.xyz = vec3(t21) * t0.xyz + vec3(vec3(extinctionGroundFade, extinctionGroundFade, extinctionGroundFade));
    //ENDIF
    }
    SV_Target0.xyz = t3.xyz;
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
// Stats: 191 math, 2 textures, 4 branches
Keywords { "ECLIPSES_OFF" }
Float 3 [HM]
Float 1 [HR]
Float 5 [Rg]
Float 6 [Rt]
Float 10 [_Extinction_Tint]
Vector 9 [_Globals_Origin]
Vector 0 [_WorldSpaceCameraPos]
Float 7 [_experimentalAtmoScale]
Float 8 [_viewdirOffset]
Vector 4 [betaMEx]
Vector 2 [betaR]
Float 11 [extinctionMultiplier]
Float 12 [extinctionRimFade]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
def c13, -1, 1, 0.5, 0
def c14, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c15, 1.44269502, 1.51999998, 4, 2.31929994
def c16, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c17, -2, 1.57079637, 0.666666687, 0.333333343
def c18, -9.99999997e-007, 0, 2, 4
dcl_texcoord v0.xyz
dcl_2d s0
add r0.xyz, -c0, v0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.yzw, r0.w, r0.xxyz
mad r1.x, r0.x, r0.w, c8.x
nrm r0.xyz, r1.xzww
mov r2.xyz, c0
add r3.xyz, r2, -c9
dp3 r0.w, r3, r3
rsq r0.w, r0.w
rcp r4.x, r0.w
dp3 r0.x, r3, r0
mul r4.y, r0.w, r0.x
mul r0.y, r4.x, r4.x
mad r0.y, r0.x, r0.x, -r0.y
mad r0.y, c6.x, c6.x, r0.y
rsq r0.z, r0.y
rcp r0.z, r0.z
cmp r0.y, r0.y, -r0.z, c18.x
add r0.y, r0.y, -r0.x
max r1.x, r0.y, c18.y
add r0.x, r0.x, r1.x
rcp r0.y, c6.x
mul r0.y, r0.y, r0.x
mov r0.x, c6.x
cmp r0.xy, -r1.x, r4, r0
if_lt c6.x, r0.x
mov r4.xyz, c13.y
else
dp3 r0.w, r1.yzww, r1.yzww
dp3 r1.x, r1.yzww, r3
dp3 r1.z, c9, c9
dp3 r1.w, c0, c0
add r1.yz, r1.xxww, r1.xxzw
dp3 r1.w, c9, r2
mad r1.z, r1.w, -c18.z, r1.z
mad r1.w, c5.x, -c5.x, r1.z
mul r1.y, r1.y, r1.y
mul r2.x, r0.w, c18.w
mad r1.w, r2.x, -r1.w, r1.y
rsq r2.y, r1.w
rcp r2.y, r2.y
mad r2.y, r1.x, -c18.z, -r2.y
add r0.w, r0.w, r0.w
rcp r0.w, r0.w
mul r2.y, r0.w, r2.y
cmp r1.w, r1.w, r2.y, c13.x
if_lt -r1.w, c18.y
mad r1.z, c6.x, -c6.x, r1.z
mad r1.y, r2.x, -r1.z, r1.y
rsq r1.z, r1.y
rcp r1.z, r1.z
mad r1.x, r1.x, -c18.z, -r1.z
mul r0.w, r0.w, r1.x
cmp r0.w, r1.y, -r0.w, c13.y
add r0.w, r0.w, r1.w
mov r1.x, c7.x
mul r1.y, r1.x, c1.x
rcp r1.z, r1.y
mul r2.x, r0.x, r1.z
mul r2.x, r2.x, c13.z
rsq r2.x, r2.x
rcp r2.x, r2.x
rcp r2.y, r0.x
mad r0.z, r0.w, r2.y, r0.y
mul r2.xy, r0.yzzw, r2.x
cmp r2.zw, -r2.xyxy, c13.w, c13.y
cmp r3.xy, r2, -c13.w, -c13.y
add r2.zw, r2, r3.xyxy
mul r3.xyz, r2.xxyw, r2.xxyw
add r3.w, -r2.w, r2.z
mul r3.x, r3.x, c15.x
exp r3.x, r3.x
cmp r3.x, r3.w, c18.y, r3.x
mad r3.yz, r3, c15.y, c15.z
rsq r3.y, r3.y
rsq r3.z, r3.z
rcp r5.x, r3.y
rcp r5.y, r3.z
mad r2.xy, r2_abs, c15.w, r5
rcp r5.x, r2.x
rcp r5.y, r2.y
mul r2.xy, r2.zwzw, r5
mul r2.z, -r0.w, r1.z
add r2.w, r0.x, r0.x
rcp r2.w, r2.w
mad r2.w, r0.w, r2.w, r0.y
mul r2.z, r2.w, r2.z
mul r2.z, r2.z, c15.x
exp r5.y, r2.z
mov r5.xz, c13.y
mul r2.xy, r2, r5
mul r1.y, r0.x, r1.y
mul r1.y, r1.y, c14.x
rsq r1.y, r1.y
rcp r1.y, r1.y
add r2.z, -r0.x, c5.x
mul r1.z, r1.z, r2.z
mul r1.z, r1.z, c15.x
exp r1.z, r1.z
mul r1.y, r1.z, r1.y
dp2add r1.z, r2, c13.yxzw, r3.x
mul r1.y, r1.z, r1.y
mul r1.x, r1.x, c3.x
rcp r1.z, r1.x
mul r2.x, r0.x, r1.z
mul r2.x, r2.x, c13.z
rsq r2.x, r2.x
rcp r2.x, r2.x
mul r2.xy, r0.yzzw, r2.x
cmp r3.xy, -r2, c13.w, c13.y
cmp r3.zw, r2.xyxy, -c13.w, -c13.y
add r3.xy, r3.zwzw, r3
mul r6.xyz, r2.xxyw, r2.xxyw
add r0.z, -r3.y, r3.x
mul r3.z, r6.x, c15.x
exp r3.z, r3.z
cmp r0.z, r0.z, c18.y, r3.z
mad r3.zw, r6.xyyz, c15.y, c15.z
rsq r3.z, r3.z
rsq r3.w, r3.w
rcp r5.x, r3.z
rcp r5.y, r3.w
mad r2.xy, r2_abs, c15.w, r5
rcp r5.x, r2.x
rcp r5.y, r2.y
mul r2.xy, r3, r5
mul r0.w, -r0.w, r1.z
mul r0.w, r2.w, r0.w
mul r0.w, r0.w, c15.x
exp r5.w, r0.w
mul r2.xy, r2, r5.zwzw
mul r0.w, r0.x, r1.x
mul r0.w, r0.w, c14.x
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r1.x, r1.z, r2.z
mul r1.x, r1.x, c15.x
exp r1.x, r1.x
mul r0.w, r0.w, r1.x
dp2add r0.z, r2, c13.yxzw, r0.z
mul r0.z, r0.z, r0.w
mul r2.xyz, r0.z, c4
mad r1.xyz, -c2, r1.y, -r2
mul r1.xyz, r1, c15.x
exp r2.x, r1.x
exp r2.y, r1.y
exp r2.z, r1.z
else
add r0.x, r0.x, -c5.x
mov r1.x, c6.x
add r0.z, r1.x, -c5.x
rcp r0.z, r0.z
mul r0.x, r0.z, r0.x
rsq r0.x, r0.x
rcp r3.y, r0.x
add r0.x, r0.y, c14.y
mul r0.x, r0.x, c14.z
mov_sat r0.y, r0_abs.x
add r0.z, r0_abs.x, c13.x
rcp r0.w, r0_abs.x
cmp r0.z, r0.z, r0.w, c13.y
mul r0.y, r0.z, r0.y
mul r0.z, r0.y, r0.y
mad r0.w, r0.z, c16.x, c16.y
mad r0.w, r0.z, r0.w, c14.w
mad r0.w, r0.z, r0.w, c16.z
mad r0.z, r0.z, r0.w, c16.w
mul r0.y, r0.z, r0.y
add r0.z, -r0_abs.x, c13.y
cmp r0.z, r0.z, c13.w, c13.y
mad r0.w, r0.y, c17.x, c17.y
mad r0.y, r0.w, r0.z, r0.y
min r1.x, r0.x, c13.y
cmp r0.x, r1.x, c13.w, c13.y
add r0.z, r0.y, r0.y
mad r0.x, r0.x, -r0.z, r0.y
mul r3.x, r0.x, c17.z
mov r3.zw, c18.y
texldl r2, r3, s0
endif
add r0.x, r2.y, r2.x
add r0.x, r2.z, r0.x
mul r0.x, r0.x, c17.w
lrp r1.xyz, c10.x, r2, r0.x
mul r0.xyz, r1, c11.x
mov r1.y, c13.y
lrp r2.xyz, r0, r1.y, c12.x
cmp r4.xyz, -r1.w, r2, r0
endif
mov oC0.xyz, r4
mov oC0.w, c13.y

"
}
SubProgram "d3d11 " {
// Stats: 154 math, 4 branches
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
Float 248 [_viewdirOffset]
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
eefiecedodecgpiofdenojopjhigidolfieeilplabaaaaaaiibfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmibeaaaa
eaaaaaaadcafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
afaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaaapaaaaaabaaaaaah
bcaabaaaaaaaaaaaigadbaaaabaaaaaaigadbaaaabaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
igadbaaaabaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaiaebaaaaaaaaaaaaaa
bjaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaaadaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaaaoaaaaah
ccaabaaaadaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaadcaaaaakccaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
dcaaaaalccaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaabkaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadhaaaaak
ccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
lndhiglfaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaaiccaabaaa
aaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaadgaaaaagbcaabaaa
aaaaaaaackiacaaaaaaaaaaaamaaaaaadhaaaaajdcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaaegaabaaaadaaaaaadbaaaaaiicaabaaaaaaaaaaa
ckiacaaaaaaaaaaaamaaaaaaakaabaaaaaaaaaaabpaaaeaddkaabaaaaaaaaaaa
dgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
doaaaaabbfaaaaabbaaaaaahicaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaajecaabaaaabaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaaaaaaaaaa
bjaaaaaabaaaaaajicaabaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaahgcaabaaaabaaaaaaagadbaaaabaaaaaaagacbaaa
abaaaaaabaaaaaajicaabaaaabaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaa
abaaaaaaaeaaaaaadcaaaaakecaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeackaabaaaabaaaaaadcaaaaamicaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaackaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
bcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaakicaabaaa
abaaaaaaakaabaiaebaaaaaaacaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaa
dbaaaaahccaabaaaacaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaaf
icaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaalicaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaaeadkaabaiaebaaaaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadhaaaaajicaabaaaabaaaaaa
bkaabaaaacaaaaaaabeaaaaaaaaaialpdkaabaaaabaaaaaadbaaaaahccaabaaa
acaaaaaaabeaaaaaaaaaaaaadkaabaaaabaaaaaabpaaaeadbkaabaaaacaaaaaa
dcaaaaamecaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaa
aaaaaaaaamaaaaaackaabaaaabaaaaaadcaaaaakccaabaaaabaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaadbaaaaahecaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaalbcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeabkaabaiaebaaaaaaabaaaaaaaoaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadhaaaaakicaabaaaaaaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaiadpdkaabaiaebaaaaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaajbcaabaaaabaaaaaa
bkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahccaabaaa
abaaaaaaabeaaaaaaaaaaadpakaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaa
akaabaaaaaaaaaaabkaabaaaabaaaaaaelaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaaaoaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aaaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaah
gcaabaaaabaaaaaafgagbaaaaaaaaaaafgafbaaaabaaaaaadbaaaaakdcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaajgafbaaaabaaaaaa
dbaaaaakmcaabaaaacaaaaaafgajbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaboaaaaaidcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaa
ogakbaaaacaaaaaaclaaaaafdcaabaaaacaaaaaaegaabaaaacaaaaaadiaaaaah
hcaabaaaadaaaaaafgagbaaaabaaaaaafgagbaaaabaaaaaadbaaaaahecaabaaa
acaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahicaabaaaacaaaaaa
akaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaaabaaaaahecaabaaaacaaaaaadkaabaaaacaaaaaackaabaaaacaaaaaa
dcaaaaapdcaabaaaadaaaaaajgafbaaaadaaaaaaaceaaaaafmipmcdpfmipmcdp
aaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaaelaaaaaf
dcaabaaaadaaaaaaegaabaaaadaaaaaadcaaaaangcaabaaaabaaaaaafgagbaia
ibaaaaaaabaaaaaaaceaaaaaaaaaaaaagjgpbeeagjgpbeeaaaaaaaaaagabbaaa
adaaaaaaaoaaaaahgcaabaaaabaaaaaaagabbaaaacaaaaaafgagbaaaabaaaaaa
aoaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaa
aaaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaaoaaaaah
ccaabaaaacaaaaaadkaabaaaaaaaaaaabkaabaaaacaaaaaaaaaaaaahccaabaaa
acaaaaaabkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaadaaaaaaakaabaaaacaaaaaa
dgaaaaaifcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadpaaaaaaaa
diaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaaagabbaaaadaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaajicaabaaaacaaaaaaakaabaiaebaaaaaaaaaaaaaa
bkiacaaaaaaaaaaaamaaaaaaaoaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
dlkklidpbjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaaapaaaaakccaabaaaabaaaaaa
jgafbaaaabaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaajccaabaaaabaaaaaa
dkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaahecaabaaa
abaaaaaaabeaaaaaaaaaaadpbkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
akaabaaaaaaaaaaackaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahfcaabaaaacaaaaaafgagbaaaaaaaaaaakgakbaaaabaaaaaa
dbaaaaakdcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
igaabaaaacaaaaaadbaaaaakdcaabaaaaeaaaaaaigaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaadaaaaaaegaabaia
ebaaaaaaadaaaaaaegaabaaaaeaaaaaaclaaaaafdcaabaaaadaaaaaaegaabaaa
adaaaaaadiaaaaahhcaabaaaaeaaaaaaagacbaaaacaaaaaaagacbaaaacaaaaaa
dbaaaaahecaabaaaaaaaaaaaakaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
ecaabaaaabaaaaaaakaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaa
abaaaaaackaabaaaabaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaabaaaaaadcaaaaapdcaabaaaaeaaaaaajgafbaaaaeaaaaaaaceaaaaa
fmipmcdpfmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaa
aaaaaaaaelaaaaafdcaabaaaaeaaaaaaegaabaaaaeaaaaaadcaaaaanfcaabaaa
acaaaaaaagacbaiaibaaaaaaacaaaaaaaceaaaaagjgpbeeaaaaaaaaagjgpbeea
aaaaaaaaagabbaaaaeaaaaaaaoaaaaahfcaabaaaacaaaaaaagabbaaaadaaaaaa
agacbaaaacaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidp
bjaaaaaficaabaaaadaaaaaadkaabaaaaaaaaaaadiaaaaahdcaabaaaacaaaaaa
igaabaaaacaaaaaaogakbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaciapmjeaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
ccaabaaaabaaaaaadkaabaaaacaaaaaabkaabaaaabaaaaaadiaaaaahccaabaaa
abaaaaaabkaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
abaaaaaaapaaaaakccaabaaaabaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaaihcaabaaaacaaaaaakgakbaaaaaaaaaaaegiccaaaaaaaaaaa
alaaaaaadcaaaaamhcaabaaaabaaaaaaegiccaiaebaaaaaaaaaaaaaaajaaaaaa
agaabaaaabaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaabjaaaaaf
hcaabaaaacaaaaaaegacbaaaabaaaaaabcaaaaabaaaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaaaaaaaakecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaa
aoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaelaaaaaf
ccaabaaaabaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaajkjjbjdodiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaajfdbeeebddaaaaaiccaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdeaaaaaiecaabaaaaaaaaaaaakaabaiaibaaaaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajicaabaaaaaaaaaaackaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaaiecaabaaaabaaaaaa
abeaaaaaaaaaiadpakaabaiaibaaaaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaa
aaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
bkaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadhaaaaakbcaabaaaaaaaaaaa
akaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaalpcaabaaa
acaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaabfaaaaabaaaaaaahbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkkkdoaaaaaaaj
ccaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabjaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaapgipcaaaaaaaaaaabjaaaaaaegacbaaaacaaaaaaagaabaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaa
bkaaaaaabnaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaajbcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabkaaaaaaabeaaaaa
aaaaiadpdcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaaaaaaaaaa
fgifcaaaaaaaaaaabkaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 250 math, 1 textures, 11 branches
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 124
Vector 0 [_WorldSpaceCameraPos] 3
Float 16 [HR]
Vector 32 [betaR] 3
Float 48 [HM]
Vector 64 [betaMEx] 3
Float 80 [Rg]
Float 84 [Rt]
Float 88 [_experimentalAtmoScale]
Float 92 [_viewdirOffset]
Vector 96 [_Globals_Origin] 3
Float 112 [_Extinction_Tint]
Float 116 [extinctionMultiplier]
Float 120 [extinctionRimFade]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float HR;
  float3 betaR;
  float HM;
  float3 betaMEx;
  float Rg;
  float Rt;
  float _experimentalAtmoScale;
  float _viewdirOffset;
  float3 _Globals_Origin;
  float _Extinction_Tint;
  float extinctionMultiplier;
  float extinctionRimFade;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _Transmittance [[texture(0)]], sampler _mtlsmp__Transmittance [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  float3 viewdir_5;
  float3 extinction_6;
  extinction_6 = float3(1.0, 1.0, 1.0);
  float3 tmpvar_7;
  tmpvar_7 = normalize((_mtl_i.xlv_TEXCOORD0 - _mtl_u._WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _mtl_u._viewdirOffset);
  float3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (_mtl_u.Rt * _mtl_u.Rt));
  float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / _mtl_u.Rt);
    r_4 = _mtl_u.Rt;
  };
  if ((r_4 > _mtl_u.Rt)) {
    tmpvar_1 = float4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
    float tmpvar_17;
    tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
      ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
     - 
      (_mtl_u.Rg * _mtl_u.Rg)
    )));
    float tmpvar_18;
    if ((tmpvar_17 < 0.0)) {
      tmpvar_18 = -1.0;
    } else {
      tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
    };
    if ((tmpvar_18 > 0.0)) {
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
       - 
        (_mtl_u.Rg * _mtl_u.Rg)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
      float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
       - 
        (_mtl_u.Rt * _mtl_u.Rt)
      )));
      float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      float tmpvar_28;
      float H_29;
      H_29 = (_mtl_u.HR * _mtl_u._experimentalAtmoScale);
      float2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      float2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      float2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      float2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      float2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((_mtl_u.Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , float2(1.0, -1.0))));
      float H_36;
      H_36 = (_mtl_u.HM * _mtl_u._experimentalAtmoScale);
      float2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      float2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
      float2 tmpvar_39;
      tmpvar_39 = sign(tmpvar_38);
      float2 tmpvar_40;
      tmpvar_40 = (tmpvar_38 * tmpvar_38);
      float tmpvar_41;
      if ((tmpvar_39.y > tmpvar_39.x)) {
        tmpvar_41 = exp(tmpvar_40.x);
      } else {
        tmpvar_41 = 0.0;
      };
      float2 tmpvar_42;
      tmpvar_42.x = 1.0;
      tmpvar_42.y = exp(((
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(_mtl_u.betaR)
       * tmpvar_28) - (_mtl_u.betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (_mtl_u.Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), float2(1.0, -1.0))))
      )));
    } else {
      float3 tmpvar_43;
      float y_over_x_44;
      y_over_x_44 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_45;
      tmpvar_45 = (min (abs(y_over_x_44), 1.0) / max (abs(y_over_x_44), 1.0));
      float tmpvar_46;
      tmpvar_46 = (tmpvar_45 * tmpvar_45);
      tmpvar_46 = (((
        ((((
          ((((-0.01213232 * tmpvar_46) + 0.05368138) * tmpvar_46) - 0.1173503)
         * tmpvar_46) + 0.1938925) * tmpvar_46) - 0.3326756)
       * tmpvar_46) + 0.9999793) * tmpvar_45);
      tmpvar_46 = (tmpvar_46 + (float(
        (abs(y_over_x_44) > 1.0)
      ) * (
        (tmpvar_46 * -2.0)
       + 1.570796)));
      float4 tmpvar_47;
      tmpvar_47.zw = float2(0.0, 0.0);
      tmpvar_47.x = ((tmpvar_46 * sign(y_over_x_44)) / 1.5);
      tmpvar_47.y = sqrt(((r_4 - _mtl_u.Rg) / (_mtl_u.Rt - _mtl_u.Rg)));
      half4 tmpvar_48;
      tmpvar_48 = _Transmittance.sample(_mtlsmp__Transmittance, (float2)(tmpvar_47.xy), level(0.0));
      tmpvar_43 = float3(tmpvar_48.xyz);
      extinction_6 = tmpvar_43;
    };
    extinction_6 = (_mtl_u.extinctionMultiplier * ((float3(_mtl_u._Extinction_Tint) * extinction_6) + (float3(
      (1.0 - _mtl_u._Extinction_Tint)
    ) * float3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    float tmpvar_49;
    tmpvar_49 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_50;
    tmpvar_50 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
    float tmpvar_51;
    tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
      ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
     - 
      (_mtl_u.Rg * _mtl_u.Rg)
    )));
    float tmpvar_52;
    if ((tmpvar_51 < 0.0)) {
      tmpvar_52 = -1.0;
    } else {
      tmpvar_52 = ((-(tmpvar_50) - sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    };
    bool tmpvar_53;
    tmpvar_53 = (tmpvar_52 > 0.0);
    if (!(tmpvar_53)) {
      extinction_6 = (float3(_mtl_u.extinctionRimFade) + ((1.0 - _mtl_u.extinctionRimFade) * extinction_6));
    };
    float4 tmpvar_54;
    tmpvar_54.w = 1.0;
    tmpvar_54.xyz = extinction_6;
    tmpvar_1 = tmpvar_54;
  };
  _mtl_o._glesFragData_0 = half4(tmpvar_1);
  return _mtl_o;
}

"
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
// Stats: 327 math, 2 textures, 20 branches
Keywords { "ECLIPSES_ON" }
Matrix 0 [lightOccluders1]
Matrix 4 [lightOccluders2]
Float 11 [HM]
Float 9 [HR]
Float 13 [Rg]
Float 14 [Rt]
Float 18 [_Extinction_Tint]
Vector 17 [_Globals_Origin]
Vector 8 [_WorldSpaceCameraPos]
Float 15 [_experimentalAtmoScale]
Float 16 [_viewdirOffset]
Vector 12 [betaMEx]
Vector 10 [betaR]
Float 21 [extinctionGroundFade]
Float 19 [extinctionMultiplier]
Float 20 [extinctionRimFade]
Vector 22 [sunPosAndRadius]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
def c23, -9.99999997e-007, 0, 2, 4
def c24, 6.28310013, 0.150000006, 12.262105, 0.180141002
def c25, 1.44269502, 1.51999998, 4, 2.31929994
def c26, 0.0208350997, -0.0851330012, -0.330299497, 0.999866009
def c27, -2, 1.57079637, 0.666666687, 0.333333343
def c28, -0.0187292993, 0.0742610022, -0.212114394, 1.57072878
def c29, -2, 3.14159274, 3, 5
def c30, -1, 1, 0.5, 0
def c31, -0, -1, -2, -3
defi i0, 4, 0, 0, 0
dcl_texcoord v0.xyz
dcl_2d s0
add r0.xyz, -c8, v0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r1.yzw, r0.w, r0.xxyz
mad r1.x, r0.x, r0.w, c16.x
nrm r0.xyz, r1.xzww
mov r2.xyz, c8
add r3.xyz, r2, -c17
dp3 r0.w, r3, r3
rsq r0.w, r0.w
rcp r4.x, r0.w
dp3 r0.x, r3, r0
mul r4.y, r0.w, r0.x
mul r0.y, r4.x, r4.x
mad r0.y, r0.x, r0.x, -r0.y
mad r0.y, c14.x, c14.x, r0.y
rsq r0.z, r0.y
rcp r0.z, r0.z
cmp r0.y, r0.y, -r0.z, c23.x
add r0.y, r0.y, -r0.x
max r1.x, r0.y, c23.y
add r0.x, r0.x, r1.x
rcp r0.y, c14.x
mul r0.y, r0.y, r0.x
mov r0.x, c14.x
cmp r0.xy, -r1.x, r4, r0
if_lt c14.x, r0.x
mov r4.xyz, c30.y
else
dp3 r0.w, r1.yzww, r1.yzww
dp3 r1.x, r1.yzww, r3
add r2.w, r1.x, r1.x
dp3 r3.x, c17, c17
dp3 r3.y, c8, c8
add r3.x, r3.y, r3.x
dp3 r2.x, c17, r2
mad r2.x, r2.x, -c23.z, r3.x
mad r2.y, c13.x, -c13.x, r2.x
mul r2.z, r2.w, r2.w
mul r2.w, r0.w, c23.w
mad r2.y, r2.w, -r2.y, r2.z
rsq r3.x, r2.y
rcp r3.x, r3.x
mad r3.x, r1.x, -c23.z, -r3.x
add r0.w, r0.w, r0.w
rcp r0.w, r0.w
mul r3.x, r0.w, r3.x
cmp r2.y, r2.y, r3.x, c30.x
if_lt -r2.y, c23.y
mad r3.x, c14.x, -c14.x, r2.x
mad r3.x, r2.w, -r3.x, r2.z
rsq r3.y, r3.x
rcp r3.y, r3.y
mad r3.y, r1.x, -c23.z, -r3.y
mul r3.y, r0.w, r3.y
cmp r3.x, r3.x, -r3.y, c30.y
add r3.x, r2.y, r3.x
mov r5.x, c15.x
mul r3.y, r5.x, c9.x
rcp r3.z, r3.y
mul r3.yw, r0.x, r3.xyzz
mul r3.w, r3.w, c30.z
rsq r3.w, r3.w
rcp r3.w, r3.w
rcp r4.w, r0.x
mad r0.z, r3.x, r4.w, r0.y
mul r5.yz, r0, r3.w
cmp r6.xy, -r5.yzzw, c30.w, c30.y
cmp r6.zw, r5.xyyz, -c30.w, -c30.y
add r6.xy, r6.zwzw, r6
mul r7.xyz, r5.yyzw, r5.yyzw
add r3.w, -r6.y, r6.x
mul r4.w, r7.x, c25.x
exp r4.w, r4.w
cmp r3.w, r3.w, c23.y, r4.w
mad r6.zw, r7.xyyz, c25.y, c25.z
rsq r4.w, r6.z
rsq r5.w, r6.w
rcp r7.x, r4.w
rcp r7.y, r5.w
mad r5.yz, r5_abs, c25.w, r7.xxyw
rcp r7.x, r5.y
rcp r7.y, r5.z
mul r5.yz, r6.xxyw, r7.xxyw
mul r4.w, r3.z, -r3.x
add r5.w, r0.x, r0.x
rcp r5.w, r5.w
mad r5.w, r3.x, r5.w, r0.y
mul r4.w, r4.w, r5.w
mul r4.w, r4.w, c25.x
exp r6.y, r4.w
mov r6.xz, c30.y
mul r5.yz, r5, r6.xxyw
mul r3.y, r3.y, c24.x
rsq r3.y, r3.y
rcp r3.y, r3.y
add r4.w, -r0.x, c13.x
mul r3.z, r3.z, r4.w
mul r3.z, r3.z, c25.x
exp r3.z, r3.z
mul r3.y, r3.z, r3.y
dp2add r3.z, r5.yzzw, c30.yxzw, r3.w
mul r3.y, r3.z, r3.y
mul r3.z, r5.x, c11.x
rcp r3.w, r3.z
mul r5.x, r0.x, r3.w
mul r5.x, r5.x, c30.z
rsq r5.x, r5.x
rcp r5.x, r5.x
mul r5.xy, r0.yzzw, r5.x
cmp r6.xy, -r5, c30.w, c30.y
cmp r7.xy, r5, -c30.w, -c30.y
add r6.xy, r6, r7
mul r7.xyz, r5.xxyw, r5.xxyw
add r0.z, -r6.y, r6.x
mul r5.z, r7.x, c25.x
exp r5.z, r5.z
cmp r0.z, r0.z, c23.y, r5.z
mad r7.xy, r7.yzzw, c25.y, c25.z
rsq r5.z, r7.x
rsq r7.x, r7.y
rcp r8.x, r5.z
rcp r8.y, r7.x
mad r5.xy, r5_abs, c25.w, r8
rcp r7.x, r5.x
rcp r7.y, r5.y
mul r5.xy, r6, r7
mul r3.x, r3.w, -r3.x
mul r3.x, r5.w, r3.x
mul r3.x, r3.x, c25.x
exp r6.w, r3.x
mul r5.xy, r5, r6.zwzw
mul r3.x, r0.x, r3.z
mul r3.x, r3.x, c24.x
rsq r3.x, r3.x
rcp r3.x, r3.x
mul r3.z, r3.w, r4.w
mul r3.z, r3.z, c25.x
exp r3.z, r3.z
mul r3.x, r3.z, r3.x
dp2add r0.z, r5, c30.yxzw, r0.z
mul r0.z, r0.z, r3.x
mul r3.xzw, r0.z, c12.xyyz
mad r3.xyz, -c10, r3.y, -r3.xzww
mul r3.xyz, r3, c25.x
exp r5.x, r3.x
exp r5.y, r3.y
exp r5.z, r3.z
else
add r0.x, r0.x, -c13.x
mov r3.x, c14.x
add r0.z, r3.x, -c13.x
rcp r0.z, r0.z
mul r0.x, r0.z, r0.x
rsq r0.x, r0.x
rcp r3.y, r0.x
add r0.x, r0.y, c24.y
mul r0.x, r0.x, c24.z
mov_sat r0.y, r0_abs.x
add r0.z, r0_abs.x, c30.x
rcp r4.w, r0_abs.x
cmp r0.z, r0.z, r4.w, c30.y
mul r0.y, r0.z, r0.y
mul r0.z, r0.y, r0.y
mad r4.w, r0.z, c26.x, c26.y
mad r4.w, r0.z, r4.w, c24.w
mad r4.w, r0.z, r4.w, c26.z
mad r0.z, r0.z, r4.w, c26.w
mul r0.y, r0.z, r0.y
add r0.z, -r0_abs.x, c30.y
cmp r0.z, r0.z, c30.w, c30.y
mad r4.w, r0.y, c27.x, c27.y
mad r0.y, r4.w, r0.z, r0.y
min r4.w, r0.x, c30.y
cmp r0.x, r4.w, c30.w, c30.y
add r0.z, r0.y, r0.y
mad r0.x, r0.x, -r0.z, r0.y
mul r3.x, r0.x, c27.z
mov r3.zw, c23.y
texldl r5, r3, s0
endif
add r0.x, r5.y, r5.x
add r0.x, r5.z, r0.x
mul r0.x, r0.x, c27.w
lrp r3.xyz, c18.x, r5, r0.x
mul r0.xyz, r3, c19.x
if_lt -r2.y, c23.y
mad r2.x, c14.x, -c14.x, r2.x
mad r2.x, r2.w, -r2.x, r2.z
rsq r2.y, r2.x
rcp r2.y, r2.y
mad r2.z, r1.x, -c23.z, -r2.y
mul r2.z, r0.w, r2.z
mad r1.x, r1.x, -c23.z, r2.y
mul r0.w, r0.w, r1.x
cmp r0.w, r2.z, r2.z, r0.w
cmp r0.w, r2.x, r0.w, c30.x
add r1.x, r0.w, c30.y
if_ne r1.x, -r1.x
mad r1.xyz, r1.yzww, r0.w, c8
add r2.xyz, -r1, c22
dp3 r0.w, r2, r2
rsq r0.w, r0.w
rcp r1.w, r0.w
mul r2.xyz, r0.w, r2
rcp r0.w, c22.w
mov r2.w, c30.y
mov r3.x, c23.y
rep i0
add r5, r3.x, c31
mov r3.y, c23.y
cmp r3.z, -r5_abs.x, c0.w, r3.y
cmp r3.z, -r5_abs.y, c1.w, r3.z
cmp r3.z, -r5_abs.z, c2.w, r3.z
cmp r3.z, -r5_abs.w, c3.w, r3.z
if_ge -r3.z, c23.y
break_ne c30.y, -c30.y
endif
cmp r6.xyz, -r5_abs.x, c0, r3.y
cmp r6.xyz, -r5_abs.y, c1, r6
cmp r5.xyz, -r5_abs.z, c2, r6
cmp r5.xyz, -r5_abs.w, c3, r5
add r5.xyz, -r1, r5
dp3 r3.y, r5, r5
rsq r3.y, r3.y
mul r5.xyz, r3.y, r5
mul r6.xyz, r2.zxyw, r5.yzxw
mad r6.xyz, r2.yzxw, r5.zxyw, -r6
dp3 r3.w, r6, r6
rsq r3.w, r3.w
rcp r3.w, r3.w
min r4.w, r3.w, c30.y
add r3.w, -r4.w, c30.y
rsq r3.w, r3.w
rcp r3.w, r3.w
mad r5.w, r4.w, c28.x, c28.y
mad r5.w, r5.w, r4.w, c28.z
mad r4.w, r5.w, r4.w, c28.w
mad r3.w, r4.w, -r3.w, c27.y
mul r3.y, r3.y, r3.z
min r4.w, r3.y, c30.y
add r3.y, -r4_abs.w, c30.y
rsq r3.y, r3.y
rcp r3.y, r3.y
mad r3.z, r4_abs.w, c28.x, c28.y
mad r3.z, r3.z, r4_abs.w, c28.z
mad r3.z, r3.z, r4_abs.w, c28.w
mul r3.y, r3.y, r3.z
mad r3.z, r3.y, c29.x, c29.y
cmp r4.w, r4.w, c30.w, c30.y
mad r3.y, r3.z, r4.w, r3.y
add r3.y, -r3.y, c27.y
add r3.y, -r3.y, r3.w
mul r3.y, r1.w, r3.y
mad r3.y, -r3.y, r0.w, c30.y
mul_sat r3.y, r3.y, c30.z
mad r3.z, r3.y, c29.x, c29.z
mul r3.y, r3.y, r3.y
mul r3.y, r3.y, r3.z
dp3 r3.z, r2, r5
mul_sat r3.z, r3.z, c29.w
mad r3.w, r3.z, c29.x, c29.z
mul r3.z, r3.z, r3.z
mul r3.z, r3.z, r3.w
mad r3.y, r3.y, -r3.z, c30.y
mul r2.w, r2.w, r3.y
add r3.x, r3.x, c30.y
endrep
mov r3.x, r2.w
mov r3.y, c23.y
rep i0
add r5, r3.y, c31
mov r6.y, c23.y
cmp r3.z, -r5_abs.x, c4.w, r6.y
cmp r3.z, -r5_abs.y, c5.w, r3.z
cmp r3.z, -r5_abs.z, c6.w, r3.z
cmp r3.z, -r5_abs.w, c7.w, r3.z
if_ge -r3.z, c23.y
break_ne c30.y, -c30.y
endif
cmp r6.xyz, -r5_abs.x, c4, r6.y
cmp r6.xyz, -r5_abs.y, c5, r6
cmp r5.xyz, -r5_abs.z, c6, r6
cmp r5.xyz, -r5_abs.w, c7, r5
add r5.xyz, -r1, r5
dp3 r3.w, r5, r5
rsq r3.w, r3.w
mul r5.xyz, r3.w, r5
mul r6.xyz, r2.zxyw, r5.yzxw
mad r6.xyz, r2.yzxw, r5.zxyw, -r6
dp3 r4.w, r6, r6
rsq r4.w, r4.w
rcp r4.w, r4.w
min r5.w, r4.w, c30.y
add r4.w, -r5.w, c30.y
rsq r4.w, r4.w
rcp r4.w, r4.w
mad r6.x, r5.w, c28.x, c28.y
mad r6.x, r6.x, r5.w, c28.z
mad r5.w, r6.x, r5.w, c28.w
mad r4.w, r5.w, -r4.w, c27.y
mul r3.z, r3.w, r3.z
min r5.w, r3.z, c30.y
add r3.z, -r5_abs.w, c30.y
rsq r3.z, r3.z
rcp r3.z, r3.z
mad r3.w, r5_abs.w, c28.x, c28.y
mad r3.w, r3.w, r5_abs.w, c28.z
mad r3.w, r3.w, r5_abs.w, c28.w
mul r3.z, r3.z, r3.w
mad r3.w, r3.z, c29.x, c29.y
cmp r5.w, r5.w, c30.w, c30.y
mad r3.z, r3.w, r5.w, r3.z
add r3.z, -r3.z, c27.y
add r3.z, -r3.z, r4.w
mul r3.z, r1.w, r3.z
mad r3.z, -r3.z, r0.w, c30.y
mul_sat r3.z, r3.z, c30.z
mad r3.w, r3.z, c29.x, c29.z
mul r3.z, r3.z, r3.z
mul r3.z, r3.z, r3.w
dp3 r3.w, r2, r5
mul_sat r3.w, r3.w, c29.w
mad r4.w, r3.w, c29.x, c29.z
mul r3.w, r3.w, r3.w
mul r3.w, r3.w, r4.w
mad r3.z, r3.z, -r3.w, c30.y
mul r3.x, r3.z, r3.x
add r3.y, r3.y, c30.y
endrep
else
mov r3.x, c30.y
endif
mul r1.xyz, r0, r3.x
mov r2.y, c30.y
lrp r4.xyz, r1, r2.y, c21.x
else
mov r1.y, c30.y
lrp r4.xyz, r0, r1.y, c20.x
endif
endif
mov oC0.xyz, r4
mov oC0.w, c30.y

"
}
SubProgram "d3d11 " {
// Stats: 273 math, 14 branches
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
Float 248 [_viewdirOffset]
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
eefieceddoicpfcolgildgnogpehdkgmhajkfihhabaaaaaahmcfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmceaaaa
eaaaaaaacpajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaaceaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacahaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaadcaaaaak
bcaabaaaabaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
apaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaaabaaaaaaigadbaaaabaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaigadbaaaabaaaaaaaaaaaaakhcaabaaaacaaaaaaegiccaia
ebaaaaaaaaaaaaaabjaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaelaaaaafbcaabaaaadaaaaaa
dkaabaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaaaoaaaaahccaabaaaadaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaa
dcaaaaakccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaalccaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaa
ckiacaaaaaaaaaaaamaaaaaabkaabaaaaaaaaaaabnaaaaahecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadhaaaaakccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaalndhiglfaaaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
aoaaaaaiccaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaa
dgaaaaagbcaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaadhaaaaajdcaabaaa
aaaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaadaaaaaadbaaaaai
icaabaaaaaaaaaaackiacaaaaaaaaaaaamaaaaaaakaabaaaaaaaaaaabpaaaead
dkaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdoaaaaabbfaaaaabbaaaaaahicaabaaaaaaaaaaajgahbaaa
abaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaajgahbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaabaaaaaajccaabaaaacaaaaaaegiccaaaaaaaaaaabjaaaaaaegiccaaa
aaaaaaaabjaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaa
egiccaaaabaaaaaaaeaaaaaaaaaaaaahccaabaaaacaaaaaackaabaaaacaaaaaa
bkaabaaaacaaaaaabaaaaaajecaabaaaacaaaaaaegiccaaaaaaaaaaabjaaaaaa
egiccaaaabaaaaaaaeaaaaaadcaaaaakccaabaaaacaaaaaackaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaaeabkaabaaaacaaaaaadcaaaaamecaabaaaacaaaaaa
bkiacaiaebaaaaaaaaaaaaaaamaaaaaabkiacaaaaaaaaaaaamaaaaaabkaabaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiaeadcaaaaak
ecaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaadbaaaaahbcaabaaaadaaaaaackaabaaaacaaaaaaabeaaaaaaaaaaaaa
elaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadcaaaaalecaabaaaacaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeackaabaiaebaaaaaaacaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajecaabaaa
acaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaialpckaabaaaacaaaaaadbaaaaah
bcaabaaaadaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaabpaaaeadakaabaaa
adaaaaaadcaaaaambcaabaaaadaaaaaackiacaiaebaaaaaaaaaaaaaaamaaaaaa
ckiacaaaaaaaaaaaamaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaaakaabaaaacaaaaaadbaaaaah
ccaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaa
adaaaaaaakaabaaaadaaaaaadcaaaaalbcaabaaaadaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaaaeaakaabaiaebaaaaaaadaaaaaaaoaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaadkaabaaaaaaaaaaadhaaaaakbcaabaaaadaaaaaa
bkaabaaaadaaaaaaabeaaaaaaaaaiadpakaabaiaebaaaaaaadaaaaaaaaaaaaah
bcaabaaaadaaaaaackaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaajccaabaaa
adaaaaaabkiacaaaaaaaaaaaaiaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaah
ecaabaaaadaaaaaaabeaaaaaaaaaaadpbkaabaaaadaaaaaadiaaaaahecaabaaa
adaaaaaaakaabaaaaaaaaaaackaabaaaadaaaaaaelaaaaafecaabaaaadaaaaaa
ckaabaaaadaaaaaaaoaaaaahicaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaa
aaaaaaaaaaaaaaahecaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaadaaaaaa
diaaaaahmcaabaaaadaaaaaafgajbaaaaaaaaaaakgakbaaaadaaaaaadbaaaaak
dcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaogakbaaa
adaaaaaadbaaaaakmcaabaaaaeaaaaaakgaobaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaaeaaaaaaegaabaiaebaaaaaa
aeaaaaaaogakbaaaaeaaaaaaclaaaaafdcaabaaaaeaaaaaaegaabaaaaeaaaaaa
diaaaaahhcaabaaaafaaaaaakgalbaaaadaaaaaakgalbaaaadaaaaaadbaaaaah
ecaabaaaaeaaaaaaakaabaaaaeaaaaaabkaabaaaaeaaaaaadiaaaaahicaabaaa
aeaaaaaaakaabaaaafaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaaaeaaaaaa
dkaabaaaaeaaaaaaabaaaaahecaabaaaaeaaaaaadkaabaaaaeaaaaaackaabaaa
aeaaaaaadcaaaaapdcaabaaaafaaaaaajgafbaaaafaaaaaaaceaaaaafmipmcdp
fmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaeaaaaaaaaaaaaaaaaa
elaaaaafdcaabaaaafaaaaaaegaabaaaafaaaaaadcaaaaanmcaabaaaadaaaaaa
kgaobaiaibaaaaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaagjgpbeeagjgpbeea
agaebaaaafaaaaaaaoaaaaahmcaabaaaadaaaaaaagaebaaaaeaaaaaakgaobaaa
adaaaaaaaoaaaaaibcaabaaaaeaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaa
adaaaaaaaaaaaaahccaabaaaaeaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
aoaaaaahccaabaaaaeaaaaaaakaabaaaadaaaaaabkaabaaaaeaaaaaaaaaaaaah
ccaabaaaaeaaaaaabkaabaaaaaaaaaaabkaabaaaaeaaaaaadiaaaaahbcaabaaa
aeaaaaaabkaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaafaaaaaaakaabaaa
aeaaaaaadgaaaaaifcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaiadp
aaaaaaaadiaaaaahmcaabaaaadaaaaaakgaobaaaadaaaaaaagaebaaaafaaaaaa
diaaaaahbcaabaaaaeaaaaaaakaabaaaaaaaaaaabkaabaaaadaaaaaadiaaaaah
bcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaa
aeaaaaaaakaabaaaaeaaaaaaaaaaaaajicaabaaaaeaaaaaaakaabaiaebaaaaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaaaoaaaaahccaabaaaadaaaaaadkaabaaa
aeaaaaaabkaabaaaadaaaaaadiaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaa
abeaaaaadlkklidpbjaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaah
ccaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaaeaaaaaaapaaaaakecaabaaa
adaaaaaaogakbaaaadaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
aaaaaaahecaabaaaadaaaaaackaabaaaadaaaaaackaabaaaaeaaaaaadiaaaaah
ccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadiaaaaajecaabaaa
adaaaaaadkiacaaaaaaaaaaaajaaaaaabkiacaaaaaaaaaaaapaaaaaaaoaaaaah
icaabaaaadaaaaaaabeaaaaaaaaaaadpckaabaaaadaaaaaadiaaaaahicaabaaa
adaaaaaaakaabaaaaaaaaaaadkaabaaaadaaaaaaelaaaaaficaabaaaadaaaaaa
dkaabaaaadaaaaaadiaaaaahfcaabaaaaeaaaaaafgagbaaaaaaaaaaapgapbaaa
adaaaaaadbaaaaakdcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaigaabaaaaeaaaaaadbaaaaakdcaabaaaagaaaaaaigaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaboaaaaaidcaabaaaafaaaaaa
egaabaiaebaaaaaaafaaaaaaegaabaaaagaaaaaaclaaaaafdcaabaaaafaaaaaa
egaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaagacbaaaaeaaaaaaagacbaaa
aeaaaaaadbaaaaahecaabaaaaaaaaaaaakaabaaaafaaaaaabkaabaaaafaaaaaa
diaaaaahicaabaaaadaaaaaaakaabaaaagaaaaaaabeaaaaadlkklidpbjaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaaabaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaadaaaaaadcaaaaapdcaabaaaagaaaaaajgafbaaaagaaaaaa
aceaaaaafmipmcdpfmipmcdpaaaaaaaaaaaaaaaaaceaaaaaaaaaiaeaaaaaiaea
aaaaaaaaaaaaaaaaelaaaaafdcaabaaaagaaaaaaegaabaaaagaaaaaadcaaaaan
fcaabaaaaeaaaaaaagacbaiaibaaaaaaaeaaaaaaaceaaaaagjgpbeeaaaaaaaaa
gjgpbeeaaaaaaaaaagabbaaaagaaaaaaaoaaaaahfcaabaaaaeaaaaaaagabbaaa
afaaaaaaagacbaaaaeaaaaaaaoaaaaaibcaabaaaadaaaaaaakaabaiaebaaaaaa
adaaaaaackaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaabkaabaaaaeaaaaaa
akaabaaaadaaaaaadiaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaafaaaaaaakaabaaaadaaaaaadiaaaaahjcaabaaa
adaaaaaaagaibaaaaeaaaaaakgaobaaaafaaaaaadiaaaaahbcaabaaaaeaaaaaa
akaabaaaaaaaaaaackaabaaaadaaaaaadiaaaaahbcaabaaaaeaaaaaaakaabaaa
aeaaaaaaabeaaaaaciapmjeaelaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaa
aoaaaaahecaabaaaadaaaaaadkaabaaaaeaaaaaackaabaaaadaaaaaadiaaaaah
ecaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaa
adaaaaaackaabaaaadaaaaaadiaaaaahecaabaaaadaaaaaackaabaaaadaaaaaa
akaabaaaaeaaaaaaapaaaaakbcaabaaaadaaaaaamgaabaaaadaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaakaabaaaadaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaadaaaaaadiaaaaaincaabaaaadaaaaaakgakbaaaaaaaaaaaagijcaaa
aaaaaaaaalaaaaaadcaaaaamhcaabaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaa
ajaaaaaafgafbaaaadaaaaaaigadbaiaebaaaaaaadaaaaaadiaaaaakhcaabaaa
adaaaaaaegacbaaaadaaaaaaaceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaa
bjaaaaafhcaabaaaadaaaaaaegacbaaaadaaaaaabcaaaaabaaaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaaaaaaaak
ecaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
elaaaaafccaabaaaaeaaaaaaakaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
bkaabaaaaaaaaaaaabeaaaaajkjjbjdodiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaajfdbeeebddaaaaaiccaabaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdeaaaaaiecaabaaaaaaaaaaaakaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpckaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaajecaabaaaaeaaaaaackaabaaaaaaaaaaa
abeaaaaafpkokkdmabeaaaaadgfkkolndcaaaaajecaabaaaaeaaaaaackaabaaa
aaaaaaaackaabaaaaeaaaaaaabeaaaaaochgdidodcaaaaajecaabaaaaeaaaaaa
ckaabaaaaaaaaaaackaabaaaaeaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaa
aaaaaaaackaabaaaaaaaaaaackaabaaaaeaaaaaaabeaaaaadiphhpdpdiaaaaah
ecaabaaaaeaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaaiicaabaaa
aeaaaaaaabeaaaaaaaaaiadpakaabaiaibaaaaaaaaaaaaaadcaaaaajecaabaaa
aeaaaaaackaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaah
ecaabaaaaeaaaaaadkaabaaaaeaaaaaackaabaaaaeaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaaeaaaaaaddaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadhaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahbcaabaaaaeaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkckdpeiaaaaal
pcaabaaaadaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaabfaaaaabaaaaaaahbcaabaaaaaaaaaaabkaabaaaadaaaaaa
akaabaaaadaaaaaaaaaaaaahbcaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaklkkkkdo
aaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabjaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaabjaaaaaaegacbaaaadaaaaaa
agaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaabkaaaaaabnaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaa
acaaaaaabpaaaeadckaabaaaacaaaaaaaaaaaaajecaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaabkaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaadaaaaaa
kgakbaaaacaaaaaaegacbaaaaaaaaaaafgifcaaaaaaaaaaabkaaaaaabcaaaaab
dcaaaaamccaabaaaacaaaaaackiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaa
aaaaaaaaamaaaaaabkaabaaaacaaaaaadcaaaaakbcaabaaaacaaaaaadkaabaia
ebaaaaaaacaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaabnaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaalecaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeaakaabaiaebaaaaaaacaaaaaaaoaaaaahecaabaaaacaaaaaa
ckaabaaaacaaaaaadkaabaaaaaaaaaaadbaaaaahicaabaaaacaaaaaackaabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaaaeaakaabaaaacaaaaaaaoaaaaahicaabaaaaaaaaaaa
akaabaaaabaaaaaadkaabaaaaaaaaaaadhaaaaajicaabaaaaaaaaaaadkaabaaa
acaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaadhaaaaajicaabaaaaaaaaaaa
bkaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaialpdjaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaialpbpaaaeadakaabaaaabaaaaaa
dcaaaaakhcaabaaaabaaaaaajgahbaaaabaaaaaapgapbaaaaaaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaajhcaabaaaacaaaaaaegacbaiaebaaaaaaabaaaaaa
egiccaaaaaaaaaaablaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaeaaaaaa
adaaaeaddkaabaaaadaaaaaabbaaaaajicaabaaaadaaaaaaegiocaaaaaaaaaaa
bpaaaaaaegjojaaadkaabaaaacaaaaaabnaaaaahbcaabaaaaeaaaaaaabeaaaaa
aaaaaaaadkaabaaaadaaaaaabpaaaeadakaabaaaaeaaaaaaacaaaaabbfaaaaab
bbaaaaajbcaabaaaaeaaaaaaegiocaaaaaaaaaaabmaaaaaaegjojaaadkaabaaa
acaaaaaabbaaaaajccaabaaaaeaaaaaaegiocaaaaaaaaaaabnaaaaaaegjojaaa
dkaabaaaacaaaaaabbaaaaajecaabaaaaeaaaaaaegiocaaaaaaaaaaaboaaaaaa
egjojaaadkaabaaaacaaaaaaaaaaaaaihcaabaaaaeaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaaeaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaelaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaaaoaaaaah
hcaabaaaaeaaaaaaegacbaaaaeaaaaaapgapbaaaaeaaaaaadiaaaaahhcaabaaa
afaaaaaacgajbaaaacaaaaaajgaebaaaaeaaaaaadcaaaaakhcaabaaaafaaaaaa
jgaebaaaacaaaaaacgajbaaaaeaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaah
bcaabaaaafaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaelaaaaafbcaabaaa
afaaaaaaakaabaaaafaaaaaaddaaaaahbcaabaaaafaaaaaaakaabaaaafaaaaaa
abeaaaaaaaaaiadpaaaaaaaiccaabaaaafaaaaaaakaabaiaebaaaaaaafaaaaaa
abeaaaaaaaaaiadpelaaaaafccaabaaaafaaaaaabkaabaaaafaaaaaadcaaaaaj
ecaabaaaafaaaaaaakaabaaaafaaaaaaabeaaaaadagojjlmabeaaaaachbgjidn
dcaaaaajecaabaaaafaaaaaackaabaaaafaaaaaaakaabaaaafaaaaaaabeaaaaa
iedefjlodcaaaaajbcaabaaaafaaaaaackaabaaaafaaaaaaakaabaaaafaaaaaa
abeaaaaakeanmjdpdcaaaaakbcaabaaaafaaaaaaakaabaiaebaaaaaaafaaaaaa
bkaabaaaafaaaaaaabeaaaaanlapmjdpaoaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaadkaabaaaaeaaaaaaddaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaaeaaaaaadkaabaiambaaaaaaadaaaaaa
abeaaaaaaaaaiadpelaaaaaficaabaaaaeaaaaaadkaabaaaaeaaaaaadcaaaaak
ccaabaaaafaaaaaadkaabaiaibaaaaaaadaaaaaaabeaaaaadagojjlmabeaaaaa
chbgjidndcaaaaakccaabaaaafaaaaaabkaabaaaafaaaaaadkaabaiaibaaaaaa
adaaaaaaabeaaaaaiedefjlodcaaaaakccaabaaaafaaaaaabkaabaaaafaaaaaa
dkaabaiaibaaaaaaadaaaaaaabeaaaaakeanmjdpdiaaaaahecaabaaaafaaaaaa
dkaabaaaaeaaaaaabkaabaaaafaaaaaadcaaaaajecaabaaaafaaaaaackaabaaa
afaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaaiicaabaaaadaaaaaa
dkaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaabaaaaahicaabaaaadaaaaaa
dkaabaaaadaaaaaackaabaaaafaaaaaadcaaaaajicaabaaaadaaaaaabkaabaaa
afaaaaaadkaabaaaaeaaaaaadkaabaaaadaaaaaaaaaaaaaiicaabaaaadaaaaaa
dkaabaiaebaaaaaaadaaaaaaabeaaaaanlapmjdpaaaaaaaiicaabaaaadaaaaaa
dkaabaiaebaaaaaaadaaaaaaakaabaaaafaaaaaadiaaaaahicaabaaaadaaaaaa
dkaabaaaaaaaaaaadkaabaaaadaaaaaaaoaaaaajicaabaaaadaaaaaadkaabaia
ebaaaaaaadaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaahicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaiadpdicaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpdcaaaaajicaabaaaaeaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaa
dkaabaaaaeaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadicaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaakaea
dcaaaaajccaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaa
aaaaeaeadiaaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaaakaabaaaaeaaaaaa
diaaaaahbcaabaaaaeaaaaaaakaabaaaaeaaaaaabkaabaaaaeaaaaaadcaaaaak
icaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaadaaaaaa
boaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaab
dgaaaaaficaabaaaacaaaaaadkaabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaaeaaaaaadkaabaaaadaaaaaa
abeaaaaaaeaaaaaaadaaaeadakaabaaaaeaaaaaabbaaaaajbcaabaaaaeaaaaaa
egiocaaaaaaaaaaacdaaaaaaegjojaaadkaabaaaadaaaaaabnaaaaahccaabaaa
aeaaaaaaabeaaaaaaaaaaaaaakaabaaaaeaaaaaabpaaaeadbkaabaaaaeaaaaaa
acaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaaaaaaaaaacaaaaaaa
egjojaaadkaabaaaadaaaaaabbaaaaajccaabaaaafaaaaaaegiocaaaaaaaaaaa
cbaaaaaaegjojaaadkaabaaaadaaaaaabbaaaaajecaabaaaafaaaaaaegiocaaa
aaaaaaaaccaaaaaaegjojaaadkaabaaaadaaaaaaaaaaaaaiocaabaaaaeaaaaaa
agajbaiaebaaaaaaabaaaaaaagajbaaaafaaaaaabaaaaaahbcaabaaaafaaaaaa
jgahbaaaaeaaaaaajgahbaaaaeaaaaaaelaaaaafbcaabaaaafaaaaaaakaabaaa
afaaaaaaaoaaaaahocaabaaaaeaaaaaafgaobaaaaeaaaaaaagaabaaaafaaaaaa
diaaaaahocaabaaaafaaaaaakgaebaaaacaaaaaakgahbaaaaeaaaaaadcaaaaak
ocaabaaaafaaaaaafgacbaaaacaaaaaapgajbaaaaeaaaaaafgaobaiaebaaaaaa
afaaaaaabaaaaaahccaabaaaafaaaaaajgahbaaaafaaaaaajgahbaaaafaaaaaa
elaaaaafccaabaaaafaaaaaabkaabaaaafaaaaaaddaaaaahccaabaaaafaaaaaa
bkaabaaaafaaaaaaabeaaaaaaaaaiadpaaaaaaaiecaabaaaafaaaaaabkaabaia
ebaaaaaaafaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaafaaaaaackaabaaa
afaaaaaadcaaaaajicaabaaaafaaaaaabkaabaaaafaaaaaaabeaaaaadagojjlm
abeaaaaachbgjidndcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaabkaabaaa
afaaaaaaabeaaaaaiedefjlodcaaaaajccaabaaaafaaaaaadkaabaaaafaaaaaa
bkaabaaaafaaaaaaabeaaaaakeanmjdpdcaaaaakccaabaaaafaaaaaabkaabaia
ebaaaaaaafaaaaaackaabaaaafaaaaaaabeaaaaanlapmjdpaoaaaaahbcaabaaa
aeaaaaaaakaabaaaaeaaaaaaakaabaaaafaaaaaaddaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaafaaaaaaakaabaia
mbaaaaaaaeaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaafaaaaaaakaabaaa
afaaaaaadcaaaaakecaabaaaafaaaaaaakaabaiaibaaaaaaaeaaaaaaabeaaaaa
dagojjlmabeaaaaachbgjidndcaaaaakecaabaaaafaaaaaackaabaaaafaaaaaa
akaabaiaibaaaaaaaeaaaaaaabeaaaaaiedefjlodcaaaaakecaabaaaafaaaaaa
ckaabaaaafaaaaaaakaabaiaibaaaaaaaeaaaaaaabeaaaaakeanmjdpdiaaaaah
icaabaaaafaaaaaaakaabaaaafaaaaaackaabaaaafaaaaaadcaaaaajicaabaaa
afaaaaaadkaabaaaafaaaaaaabeaaaaaaaaaaamaabeaaaaanlapejeadbaaaaai
bcaabaaaaeaaaaaaakaabaaaaeaaaaaaakaabaiaebaaaaaaaeaaaaaaabaaaaah
bcaabaaaaeaaaaaaakaabaaaaeaaaaaadkaabaaaafaaaaaadcaaaaajbcaabaaa
aeaaaaaackaabaaaafaaaaaaakaabaaaafaaaaaaakaabaaaaeaaaaaaaaaaaaai
bcaabaaaaeaaaaaaakaabaiaebaaaaaaaeaaaaaaabeaaaaanlapmjdpaaaaaaai
bcaabaaaaeaaaaaaakaabaiaebaaaaaaaeaaaaaabkaabaaaafaaaaaadiaaaaah
bcaabaaaaeaaaaaadkaabaaaaaaaaaaaakaabaaaaeaaaaaaaoaaaaajbcaabaaa
aeaaaaaaakaabaiaebaaaaaaaeaaaaaadkiacaaaaaaaaaaablaaaaaaaaaaaaah
bcaabaaaaeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaiadpdicaaaahbcaabaaa
aeaaaaaaakaabaaaaeaaaaaaabeaaaaaaaaaaadpdcaaaaajbcaabaaaafaaaaaa
akaabaaaaeaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaeadiaaaaahbcaabaaa
aeaaaaaaakaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaakaabaaaafaaaaaabaaaaaahccaabaaaaeaaaaaaegacbaaa
acaaaaaajgahbaaaaeaaaaaadicaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaa
abeaaaaaaaaakaeadcaaaaajecaabaaaaeaaaaaabkaabaaaaeaaaaaaabeaaaaa
aaaaaamaabeaaaaaaaaaeaeadiaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaa
bkaabaaaaeaaaaaadiaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaackaabaaa
aeaaaaaadcaaaaakbcaabaaaaeaaaaaaakaabaiaebaaaaaaaeaaaaaabkaabaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
akaabaaaaeaaaaaaboaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaa
abaaaaaabgaaaaabbcaaaaabdgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadp
bfaaaaabdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaacaaaaaa
aaaaaaajicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaabkaaaaaaabeaaaaa
aaaaiadpdcaaaaakhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
kgikcaaaaaaaaaaabkaaaaaabfaaaaabdgaaaaafhccabaaaaaaaaaaaegacbaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3"
}
SubProgram "metal " {
// Stats: 445 math, 1 textures, 20 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 272
Matrix 144 [lightOccluders1]
Matrix 208 [lightOccluders2]
Vector 0 [_WorldSpaceCameraPos] 3
Float 16 [HR]
Vector 32 [betaR] 3
Float 48 [HM]
Vector 64 [betaMEx] 3
Float 80 [Rg]
Float 84 [Rt]
Float 88 [_experimentalAtmoScale]
Float 92 [_viewdirOffset]
Vector 96 [_Globals_Origin] 3
Float 112 [_Extinction_Tint]
Float 116 [extinctionMultiplier]
Float 120 [extinctionRimFade]
Float 124 [extinctionGroundFade]
Vector 128 [sunPosAndRadius]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float HR;
  float3 betaR;
  float HM;
  float3 betaMEx;
  float Rg;
  float Rt;
  float _experimentalAtmoScale;
  float _viewdirOffset;
  float3 _Globals_Origin;
  float _Extinction_Tint;
  float extinctionMultiplier;
  float extinctionRimFade;
  float extinctionGroundFade;
  float4 sunPosAndRadius;
  float4x4 lightOccluders1;
  float4x4 lightOccluders2;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _Transmittance [[texture(0)]], sampler _mtlsmp__Transmittance [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  float4 tmpvar_1;
  float mu_2;
  float rMu_3;
  float r_4;
  float3 viewdir_5;
  float3 extinction_6;
  extinction_6 = float3(1.0, 1.0, 1.0);
  float3 tmpvar_7;
  tmpvar_7 = normalize((_mtl_i.xlv_TEXCOORD0 - _mtl_u._WorldSpaceCameraPos));
  viewdir_5.yz = tmpvar_7.yz;
  viewdir_5.x = (tmpvar_7.x + _mtl_u._viewdirOffset);
  float3 tmpvar_8;
  tmpvar_8 = normalize(viewdir_5);
  viewdir_5 = tmpvar_8;
  float3 tmpvar_9;
  tmpvar_9 = (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin);
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_9, tmpvar_9));
  r_4 = tmpvar_10;
  float tmpvar_11;
  tmpvar_11 = dot (tmpvar_9, tmpvar_8);
  rMu_3 = tmpvar_11;
  mu_2 = (tmpvar_11 / tmpvar_10);
  float f_12;
  f_12 = (((tmpvar_11 * tmpvar_11) - (tmpvar_10 * tmpvar_10)) + (_mtl_u.Rt * _mtl_u.Rt));
  float tmpvar_13;
  if ((f_12 >= 0.0)) {
    tmpvar_13 = sqrt(f_12);
  } else {
    tmpvar_13 = 1e-06;
  };
  float tmpvar_14;
  tmpvar_14 = max ((-(tmpvar_11) - tmpvar_13), 0.0);
  if ((tmpvar_14 > 0.0)) {
    rMu_3 = (tmpvar_11 + tmpvar_14);
    mu_2 = (rMu_3 / _mtl_u.Rt);
    r_4 = _mtl_u.Rt;
  };
  if ((r_4 > _mtl_u.Rt)) {
    tmpvar_1 = float4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_15;
    tmpvar_15 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_16;
    tmpvar_16 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
    float tmpvar_17;
    tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (
      ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
     - 
      (_mtl_u.Rg * _mtl_u.Rg)
    )));
    float tmpvar_18;
    if ((tmpvar_17 < 0.0)) {
      tmpvar_18 = -1.0;
    } else {
      tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
    };
    if ((tmpvar_18 > 0.0)) {
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (
        ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
       - 
        (_mtl_u.Rg * _mtl_u.Rg)
      )));
      float tmpvar_22;
      if ((tmpvar_21 < 0.0)) {
        tmpvar_22 = -1.0;
      } else {
        tmpvar_22 = ((-(tmpvar_20) - sqrt(tmpvar_21)) / (2.0 * tmpvar_19));
      };
      float tmpvar_23;
      tmpvar_23 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_24;
      tmpvar_24 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
      float tmpvar_25;
      tmpvar_25 = ((tmpvar_24 * tmpvar_24) - ((4.0 * tmpvar_23) * (
        ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
       - 
        (_mtl_u.Rt * _mtl_u.Rt)
      )));
      float tmpvar_26;
      if ((tmpvar_25 < 0.0)) {
        tmpvar_26 = -1.0;
      } else {
        tmpvar_26 = ((-(tmpvar_24) - sqrt(tmpvar_25)) / (2.0 * tmpvar_23));
      };
      float tmpvar_27;
      tmpvar_27 = (tmpvar_22 - tmpvar_26);
      float tmpvar_28;
      float H_29;
      H_29 = (_mtl_u.HR * _mtl_u._experimentalAtmoScale);
      float2 tmpvar_30;
      tmpvar_30.x = mu_2;
      tmpvar_30.y = (mu_2 + (tmpvar_27 / r_4));
      float2 tmpvar_31;
      tmpvar_31 = (sqrt((
        (0.5 / H_29)
       * r_4)) * tmpvar_30);
      float2 tmpvar_32;
      tmpvar_32 = sign(tmpvar_31);
      float2 tmpvar_33;
      tmpvar_33 = (tmpvar_31 * tmpvar_31);
      float tmpvar_34;
      if ((tmpvar_32.y > tmpvar_32.x)) {
        tmpvar_34 = exp(tmpvar_33.x);
      } else {
        tmpvar_34 = 0.0;
      };
      float2 tmpvar_35;
      tmpvar_35.x = 1.0;
      tmpvar_35.y = exp(((
        -(tmpvar_27)
       / H_29) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      tmpvar_28 = ((sqrt(
        ((6.2831 * H_29) * r_4)
      ) * exp(
        ((_mtl_u.Rg - r_4) / H_29)
      )) * (tmpvar_34 + dot (
        ((tmpvar_32 / ((2.3193 * 
          abs(tmpvar_31)
        ) + sqrt(
          ((1.52 * tmpvar_33) + 4.0)
        ))) * tmpvar_35)
      , float2(1.0, -1.0))));
      float H_36;
      H_36 = (_mtl_u.HM * _mtl_u._experimentalAtmoScale);
      float2 tmpvar_37;
      tmpvar_37.x = mu_2;
      tmpvar_37.y = (mu_2 + (tmpvar_27 / r_4));
      float2 tmpvar_38;
      tmpvar_38 = (sqrt((
        (0.5 / H_36)
       * r_4)) * tmpvar_37);
      float2 tmpvar_39;
      tmpvar_39 = sign(tmpvar_38);
      float2 tmpvar_40;
      tmpvar_40 = (tmpvar_38 * tmpvar_38);
      float tmpvar_41;
      if ((tmpvar_39.y > tmpvar_39.x)) {
        tmpvar_41 = exp(tmpvar_40.x);
      } else {
        tmpvar_41 = 0.0;
      };
      float2 tmpvar_42;
      tmpvar_42.x = 1.0;
      tmpvar_42.y = exp(((
        -(tmpvar_27)
       / H_36) * (
        (tmpvar_27 / (2.0 * r_4))
       + mu_2)));
      extinction_6 = exp(((
        -(_mtl_u.betaR)
       * tmpvar_28) - (_mtl_u.betaMEx * 
        ((sqrt((
          (6.2831 * H_36)
         * r_4)) * exp((
          (_mtl_u.Rg - r_4)
         / H_36))) * (tmpvar_41 + dot ((
          (tmpvar_39 / ((2.3193 * abs(tmpvar_38)) + sqrt((
            (1.52 * tmpvar_40)
           + 4.0))))
         * tmpvar_42), float2(1.0, -1.0))))
      )));
    } else {
      float3 tmpvar_43;
      float y_over_x_44;
      y_over_x_44 = (((mu_2 + 0.15) / 1.15) * 14.10142);
      float tmpvar_45;
      tmpvar_45 = (min (abs(y_over_x_44), 1.0) / max (abs(y_over_x_44), 1.0));
      float tmpvar_46;
      tmpvar_46 = (tmpvar_45 * tmpvar_45);
      tmpvar_46 = (((
        ((((
          ((((-0.01213232 * tmpvar_46) + 0.05368138) * tmpvar_46) - 0.1173503)
         * tmpvar_46) + 0.1938925) * tmpvar_46) - 0.3326756)
       * tmpvar_46) + 0.9999793) * tmpvar_45);
      tmpvar_46 = (tmpvar_46 + (float(
        (abs(y_over_x_44) > 1.0)
      ) * (
        (tmpvar_46 * -2.0)
       + 1.570796)));
      float4 tmpvar_47;
      tmpvar_47.zw = float2(0.0, 0.0);
      tmpvar_47.x = ((tmpvar_46 * sign(y_over_x_44)) / 1.5);
      tmpvar_47.y = sqrt(((r_4 - _mtl_u.Rg) / (_mtl_u.Rt - _mtl_u.Rg)));
      half4 tmpvar_48;
      tmpvar_48 = _Transmittance.sample(_mtlsmp__Transmittance, (float2)(tmpvar_47.xy), level(0.0));
      tmpvar_43 = float3(tmpvar_48.xyz);
      extinction_6 = tmpvar_43;
    };
    extinction_6 = (_mtl_u.extinctionMultiplier * ((float3(_mtl_u._Extinction_Tint) * extinction_6) + (float3(
      (1.0 - _mtl_u._Extinction_Tint)
    ) * float3(
      (((extinction_6.x + extinction_6.y) + extinction_6.z) / 3.0)
    ))));
    float tmpvar_49;
    tmpvar_49 = dot (tmpvar_7, tmpvar_7);
    float tmpvar_50;
    tmpvar_50 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
    float tmpvar_51;
    tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
      ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
     - 
      (_mtl_u.Rg * _mtl_u.Rg)
    )));
    float tmpvar_52;
    if ((tmpvar_51 < 0.0)) {
      tmpvar_52 = -1.0;
    } else {
      tmpvar_52 = ((-(tmpvar_50) - sqrt(tmpvar_51)) / (2.0 * tmpvar_49));
    };
    bool tmpvar_53;
    tmpvar_53 = (tmpvar_52 > 0.0);
    if (!(tmpvar_53)) {
      extinction_6 = (float3(_mtl_u.extinctionRimFade) + ((1.0 - _mtl_u.extinctionRimFade) * extinction_6));
    } else {
      float eclipseShadow_54;
      eclipseShadow_54 = 1.0;
      float tmpvar_55;
      float tmpvar_56;
      tmpvar_56 = dot (tmpvar_7, tmpvar_7);
      float tmpvar_57;
      tmpvar_57 = (2.0 * dot (tmpvar_7, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
      float tmpvar_58;
      tmpvar_58 = ((tmpvar_57 * tmpvar_57) - ((4.0 * tmpvar_56) * (
        ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
       - 
        (_mtl_u.Rt * _mtl_u.Rt)
      )));
      if ((tmpvar_58 < 0.0)) {
        tmpvar_55 = -1.0;
      } else {
        float tmpvar_59;
        tmpvar_59 = ((-(tmpvar_57) - sqrt(tmpvar_58)) / (2.0 * tmpvar_56));
        float tmpvar_60;
        if ((tmpvar_59 < 0.0)) {
          tmpvar_60 = ((-(tmpvar_57) + sqrt(tmpvar_58)) / (2.0 * tmpvar_56));
        } else {
          tmpvar_60 = tmpvar_59;
        };
        tmpvar_55 = tmpvar_60;
      };
      if ((tmpvar_55 != -1.0)) {
        int j_61;
        int i_62;
        float3 worldPos_63;
        worldPos_63 = (_mtl_u._WorldSpaceCameraPos + (tmpvar_7 * tmpvar_55));
        i_62 = 0;
        while (true) {
          if ((i_62 >= 4)) {
            break;
          };
          if ((_mtl_u.lightOccluders1[3][i_62] <= 0.0)) {
            break;
          };
          float4 v_64;
          v_64.x = _mtl_u.lightOccluders1[0][i_62];
          v_64.y = _mtl_u.lightOccluders1[1][i_62];
          v_64.z = _mtl_u.lightOccluders1[2][i_62];
          v_64.w = _mtl_u.lightOccluders1[3][i_62];
          float3 sphereDirection_65;
          float3 lightDirection_66;
          float3 tmpvar_67;
          tmpvar_67 = (_mtl_u.sunPosAndRadius.xyz - worldPos_63);
          float tmpvar_68;
          tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
          lightDirection_66 = (tmpvar_67 / float3(tmpvar_68));
          float3 tmpvar_69;
          tmpvar_69 = (v_64.xyz - worldPos_63);
          float tmpvar_70;
          tmpvar_70 = sqrt(dot (tmpvar_69, tmpvar_69));
          sphereDirection_65 = (tmpvar_69 / tmpvar_70);
          float3 tmpvar_71;
          tmpvar_71 = ((lightDirection_66.yzx * sphereDirection_65.zxy) - (lightDirection_66.zxy * sphereDirection_65.yzx));
          float tmpvar_72;
          tmpvar_72 = min (1.0, sqrt(dot (tmpvar_71, tmpvar_71)));
          float tmpvar_73;
          tmpvar_73 = min (1.0, (float3(_mtl_u.lightOccluders1[3][i_62]) / tmpvar_70).x);
          float tmpvar_74;
          tmpvar_74 = clamp (((
            (-((float3(tmpvar_68) * (
              (sign(tmpvar_72) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_72))
              ) * (1.570796 + 
                (abs(tmpvar_72) * (-0.2146018 + (abs(tmpvar_72) * (0.08656672 + 
                  (abs(tmpvar_72) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_73) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_73))
              ) * (1.570796 + 
                (abs(tmpvar_73) * (-0.2146018 + (abs(tmpvar_73) * (0.08656672 + 
                  (abs(tmpvar_73) * -0.03102955)
                ))))
              ))))
            )).x) / _mtl_u.sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_75;
          tmpvar_75 = clamp ((dot (lightDirection_66, sphereDirection_65) / 0.2), 0.0, 1.0);
          eclipseShadow_54 = (eclipseShadow_54 * (1.0 - (
            (tmpvar_74 * (tmpvar_74 * (3.0 - (2.0 * tmpvar_74))))
           * 
            (tmpvar_75 * (tmpvar_75 * (3.0 - (2.0 * tmpvar_75))))
          )));
          i_62++;
        };
        j_61 = 0;
        while (true) {
          if ((j_61 >= 4)) {
            break;
          };
          if ((_mtl_u.lightOccluders2[3][j_61] <= 0.0)) {
            break;
          };
          float4 v_76;
          v_76.x = _mtl_u.lightOccluders2[0][j_61];
          v_76.y = _mtl_u.lightOccluders2[1][j_61];
          v_76.z = _mtl_u.lightOccluders2[2][j_61];
          v_76.w = _mtl_u.lightOccluders2[3][j_61];
          float3 sphereDirection_77;
          float3 lightDirection_78;
          float3 tmpvar_79;
          tmpvar_79 = (_mtl_u.sunPosAndRadius.xyz - worldPos_63);
          float tmpvar_80;
          tmpvar_80 = sqrt(dot (tmpvar_79, tmpvar_79));
          lightDirection_78 = (tmpvar_79 / float3(tmpvar_80));
          float3 tmpvar_81;
          tmpvar_81 = (v_76.xyz - worldPos_63);
          float tmpvar_82;
          tmpvar_82 = sqrt(dot (tmpvar_81, tmpvar_81));
          sphereDirection_77 = (tmpvar_81 / tmpvar_82);
          float3 tmpvar_83;
          tmpvar_83 = ((lightDirection_78.yzx * sphereDirection_77.zxy) - (lightDirection_78.zxy * sphereDirection_77.yzx));
          float tmpvar_84;
          tmpvar_84 = min (1.0, sqrt(dot (tmpvar_83, tmpvar_83)));
          float tmpvar_85;
          tmpvar_85 = min (1.0, (float3(_mtl_u.lightOccluders2[3][j_61]) / tmpvar_82).x);
          float tmpvar_86;
          tmpvar_86 = clamp (((
            (-((float3(tmpvar_80) * (
              (sign(tmpvar_84) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_84))
              ) * (1.570796 + 
                (abs(tmpvar_84) * (-0.2146018 + (abs(tmpvar_84) * (0.08656672 + 
                  (abs(tmpvar_84) * -0.03102955)
                ))))
              ))))
             - 
              (sign(tmpvar_85) * (1.570796 - (sqrt(
                (1.0 - abs(tmpvar_85))
              ) * (1.570796 + 
                (abs(tmpvar_85) * (-0.2146018 + (abs(tmpvar_85) * (0.08656672 + 
                  (abs(tmpvar_85) * -0.03102955)
                ))))
              ))))
            )).x) / _mtl_u.sunPosAndRadius.www)
          .x - -1.0) / 2.0), 0.0, 1.0);
          float tmpvar_87;
          tmpvar_87 = clamp ((dot (lightDirection_78, sphereDirection_77) / 0.2), 0.0, 1.0);
          eclipseShadow_54 = (eclipseShadow_54 * (1.0 - (
            (tmpvar_86 * (tmpvar_86 * (3.0 - (2.0 * tmpvar_86))))
           * 
            (tmpvar_87 * (tmpvar_87 * (3.0 - (2.0 * tmpvar_87))))
          )));
          j_61++;
        };
      };
      extinction_6 = (extinction_6 * eclipseShadow_54);
      extinction_6 = (float3(_mtl_u.extinctionGroundFade) + ((1.0 - _mtl_u.extinctionGroundFade) * extinction_6));
    };
    float4 tmpvar_88;
    tmpvar_88.w = 1.0;
    tmpvar_88.xyz = extinction_6;
    tmpvar_1 = tmpvar_88;
  };
  _mtl_o._glesFragData_0 = half4(tmpvar_1);
  return _mtl_o;
}

"
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
 //        gles : 328 avg math (232..424), 4 texture, 13 avg branch (9..18)
 //       metal : 2 math
 //      opengl : 328 avg math (232..424), 4 texture, 13 avg branch (9..18)
 // Stats for Fragment shader:
 //       d3d11 : 216 avg math (158..275), 4 avg branch (0..8)
 //        d3d9 : 270 avg math (202..338), 8 texture, 7 avg branch (0..14)
 //       metal : 328 avg math (232..424), 4 texture, 13 avg branch (9..18)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IgnoreProjector"="True" }
  ZTest False
  ZWrite Off
  Cull Front
  Blend One One
  GpuProgramID 110280
Program "vp" {
SubProgram "opengl " {
// Stats: 232 math, 4 textures, 9 branches
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
  float f_15;
  f_15 = (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (xlat_mutableRt * xlat_mutableRt));
  float tmpvar_16;
  if ((f_15 >= 0.0)) {
    tmpvar_16 = sqrt(f_15);
  } else {
    tmpvar_16 = 1e-06;
  };
  float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_14) - tmpvar_16), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_17 * tmpvar_12));
    rMu_9 = (tmpvar_14 + tmpvar_17);
    r_10 = xlat_mutableRt;
  };
  float tmpvar_18;
  tmpvar_18 = dot (tmpvar_12, _Sun_WorldSunDir);
  float tmpvar_19;
  tmpvar_19 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  vec4 tmpvar_20;
  float _lerp_21;
  float tmpvar_22;
  float tmpvar_23;
  tmpvar_23 = (Rg * Rg);
  tmpvar_22 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_23));
  float tmpvar_24;
  tmpvar_24 = sqrt(((r_10 * r_10) - tmpvar_23));
  float tmpvar_25;
  tmpvar_25 = (r_10 * (rMu_9 / r_10));
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_10 * r_10)) + tmpvar_23);
  vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_22 * tmpvar_22);
    tmpvar_29.z = tmpvar_22;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_22) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_31;
  tmpvar_31 = (tmpvar_27.w + ((
    ((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y)))
   / 
    (tmpvar_24 + tmpvar_27.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_32;
  y_over_x_32 = (max (tmpvar_19, -0.1975) * 5.349625);
  float tmpvar_33;
  tmpvar_33 = (min (abs(y_over_x_32), 1.0) / max (abs(y_over_x_32), 1.0));
  float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  tmpvar_34 = (((
    ((((
      ((((-0.01213232 * tmpvar_34) + 0.05368138) * tmpvar_34) - 0.1173503)
     * tmpvar_34) + 0.1938925) * tmpvar_34) - 0.3326756)
   * tmpvar_34) + 0.9999793) * tmpvar_33);
  tmpvar_34 = (tmpvar_34 + (float(
    (abs(y_over_x_32) > 1.0)
  ) * (
    (tmpvar_34 * -2.0)
   + 1.570796)));
  float tmpvar_35;
  tmpvar_35 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_34 * sign(y_over_x_32)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_36;
  tmpvar_36 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_37;
  tmpvar_37 = floor(tmpvar_36);
  _lerp_21 = (tmpvar_36 - tmpvar_37);
  float tmpvar_38;
  tmpvar_38 = (floor((
    (tmpvar_30 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_39;
  tmpvar_39 = (floor((tmpvar_30 * RES_R)) / RES_R);
  float tmpvar_40;
  tmpvar_40 = fract((tmpvar_30 * RES_R));
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_41.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_42.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_43.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  tmpvar_20 = (((
    (texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * (1.0 - _lerp_21))
   + 
    (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * _lerp_21)
  ) * (1.0 - tmpvar_40)) + ((
    (texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * (1.0 - _lerp_21))
   + 
    (texture2DLod (_Inscatter, tmpvar_44.xy, 0.0) * _lerp_21)
  ) * tmpvar_40));
  if ((r_10 <= xlat_mutableRt)) {
    float tmpvar_45;
    tmpvar_45 = (mieG * mieG);
    result_11 = ((tmpvar_20.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_18 * tmpvar_18))
    )) + ((
      ((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_45)) * pow ((
        (1.0 + tmpvar_45)
       - 
        ((2.0 * mieG) * tmpvar_18)
      ), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18)))
     / 
      (2.0 + tmpvar_45)
    )));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  vec3 L_46;
  L_46 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  float tmpvar_47;
  if ((L_46.x < 1.413)) {
    tmpvar_47 = pow ((L_46.x * 0.38317), 0.4545454);
  } else {
    tmpvar_47 = (1.0 - exp(-(L_46.x)));
  };
  L_46.x = tmpvar_47;
  float tmpvar_48;
  if ((L_46.y < 1.413)) {
    tmpvar_48 = pow ((L_46.y * 0.38317), 0.4545454);
  } else {
    tmpvar_48 = (1.0 - exp(-(L_46.y)));
  };
  L_46.y = tmpvar_48;
  float tmpvar_49;
  if ((L_46.z < 1.413)) {
    tmpvar_49 = pow ((L_46.z * 0.38317), 0.4545454);
  } else {
    tmpvar_49 = (1.0 - exp(-(L_46.z)));
  };
  L_46.z = tmpvar_49;
  vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = (_Alpha_Global * L_46);
  gl_FragData[0] = tmpvar_50;
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
// Stats: 232 math, 4 textures, 9 branches
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
  highp float f_15;
  f_15 = (((tmpvar_14 * tmpvar_14) - (tmpvar_13 * tmpvar_13)) + (xlat_mutableRt * xlat_mutableRt));
  highp float tmpvar_16;
  if ((f_15 >= 0.0)) {
    tmpvar_16 = sqrt(f_15);
  } else {
    tmpvar_16 = 1e-06;
  };
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_14) - tmpvar_16), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_17 * tmpvar_12));
    rMu_9 = (tmpvar_14 + tmpvar_17);
    r_10 = xlat_mutableRt;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_12, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_20;
  highp float _lerp_21;
  highp float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (Rg * Rg);
  tmpvar_22 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_23));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_10 * r_10) - tmpvar_23));
  highp float tmpvar_25;
  tmpvar_25 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_10 * r_10)) + tmpvar_23);
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_22 * tmpvar_22);
    tmpvar_29.z = tmpvar_22;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  highp float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_22) * (1.0 - 
    (1.0/(RES_R))
  )));
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_27.w + ((
    ((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y)))
   / 
    (tmpvar_24 + tmpvar_27.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  highp float y_over_x_32;
  y_over_x_32 = (max (tmpvar_19, -0.1975) * 5.349625);
  highp float tmpvar_33;
  tmpvar_33 = (min (abs(y_over_x_32), 1.0) / max (abs(y_over_x_32), 1.0));
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_33 * tmpvar_33);
  tmpvar_34 = (((
    ((((
      ((((-0.01213232 * tmpvar_34) + 0.05368138) * tmpvar_34) - 0.1173503)
     * tmpvar_34) + 0.1938925) * tmpvar_34) - 0.3326756)
   * tmpvar_34) + 0.9999793) * tmpvar_33);
  tmpvar_34 = (tmpvar_34 + (float(
    (abs(y_over_x_32) > 1.0)
  ) * (
    (tmpvar_34 * -2.0)
   + 1.570796)));
  highp float tmpvar_35;
  tmpvar_35 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_34 * sign(y_over_x_32)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  highp float tmpvar_36;
  tmpvar_36 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_37;
  tmpvar_37 = floor(tmpvar_36);
  _lerp_21 = (tmpvar_36 - tmpvar_37);
  highp float tmpvar_38;
  tmpvar_38 = (floor((
    (tmpvar_30 * RES_R)
   - 1.0)) / RES_R);
  highp float tmpvar_39;
  tmpvar_39 = (floor((tmpvar_30 * RES_R)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = fract((tmpvar_30 * RES_R));
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_41.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_42;
  tmpvar_42 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_44;
  tmpvar_44 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_45.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_46;
  tmpvar_46 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_47.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_48;
  tmpvar_48 = impl_low_texture2DLodEXT (_Inscatter, tmpvar_47.xy, 0.0);
  tmpvar_20 = (((
    (tmpvar_42 * (1.0 - _lerp_21))
   + 
    (tmpvar_44 * _lerp_21)
  ) * (1.0 - tmpvar_40)) + ((
    (tmpvar_46 * (1.0 - _lerp_21))
   + 
    (tmpvar_48 * _lerp_21)
  ) * tmpvar_40));
  if ((r_10 <= xlat_mutableRt)) {
    highp float tmpvar_49;
    tmpvar_49 = (mieG * mieG);
    result_11 = ((tmpvar_20.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_18 * tmpvar_18))
    )) + ((
      ((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_49)) * pow ((
        (1.0 + tmpvar_49)
       - 
        ((2.0 * mieG) * tmpvar_18)
      ), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18)))
     / 
      (2.0 + tmpvar_49)
    )));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_50;
  L_50 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  highp float tmpvar_51;
  if ((L_50.x < 1.413)) {
    tmpvar_51 = pow ((L_50.x * 0.38317), 0.4545454);
  } else {
    tmpvar_51 = (1.0 - exp(-(L_50.x)));
  };
  L_50.x = tmpvar_51;
  highp float tmpvar_52;
  if ((L_50.y < 1.413)) {
    tmpvar_52 = pow ((L_50.y * 0.38317), 0.4545454);
  } else {
    tmpvar_52 = (1.0 - exp(-(L_50.y)));
  };
  L_50.y = tmpvar_52;
  highp float tmpvar_53;
  if ((L_50.z < 1.413)) {
    tmpvar_53 = pow ((L_50.z * 0.38317), 0.4545454);
  } else {
    tmpvar_53 = (1.0 - exp(-(L_50.z)));
  };
  L_50.z = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.w = 1.0;
  tmpvar_54.xyz = (_Alpha_Global * L_50);
  gl_FragData[0] = tmpvar_54;
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
    tb3 = t26>=0.0;
    t26 = sqrt(t26);
    t26 = (tb3) ? (-t26) : -9.99999997e-007;
    t26 = t26 + (-t5.y);
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
SubProgram "metal " {
// Stats: 2 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

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
    tb3 = t26>=0.0;
    t26 = sqrt(t26);
    t26 = (tb3) ? (-t26) : -9.99999997e-007;
    t26 = t26 + (-t5.y);
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
  vec3 inscatter_2;
  vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = (2.0 * dot (tmpvar_3, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * tmpvar_5) - ((4.0 * tmpvar_4) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  float tmpvar_7;
  if ((tmpvar_6 < 0.0)) {
    tmpvar_7 = -1.0;
  } else {
    tmpvar_7 = ((-(tmpvar_5) - sqrt(tmpvar_6)) / (2.0 * tmpvar_4));
  };
  bool tmpvar_8;
  tmpvar_8 = (tmpvar_7 > 0.0);
  if (!(tmpvar_8)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  vec3 camera_9;
  camera_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  vec3 viewdir_10;
  viewdir_10.yz = tmpvar_3.yz;
  float rMu_11;
  float r_12;
  vec3 result_13;
  result_13 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_10.x = (tmpvar_3.x + _viewdirOffset);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_10);
  viewdir_10 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_9, camera_9));
  r_12 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = dot (camera_9, tmpvar_14);
  rMu_11 = tmpvar_16;
  float f_17;
  f_17 = (((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (xlat_mutableRt * xlat_mutableRt));
  float tmpvar_18;
  if ((f_17 >= 0.0)) {
    tmpvar_18 = sqrt(f_17);
  } else {
    tmpvar_18 = 1e-06;
  };
  float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_16) - tmpvar_18), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_9 = (camera_9 + (tmpvar_19 * tmpvar_14));
    rMu_11 = (tmpvar_16 + tmpvar_19);
    r_12 = xlat_mutableRt;
  };
  float tmpvar_20;
  tmpvar_20 = dot (tmpvar_14, _Sun_WorldSunDir);
  float tmpvar_21;
  tmpvar_21 = (dot (camera_9, _Sun_WorldSunDir) / r_12);
  vec4 tmpvar_22;
  float _lerp_23;
  float tmpvar_24;
  float tmpvar_25;
  tmpvar_25 = (Rg * Rg);
  tmpvar_24 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_25));
  float tmpvar_26;
  tmpvar_26 = sqrt(((r_12 * r_12) - tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = (r_12 * (rMu_11 / r_12));
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_27 * tmpvar_27) - (r_12 * r_12)) + tmpvar_25);
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
  if ((r_12 <= xlat_mutableRt)) {
    float tmpvar_47;
    tmpvar_47 = (mieG * mieG);
    result_13 = ((tmpvar_22.xyz * (
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
    result_13 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_2 = (result_13 * _Sun_Intensity);
  eclipseShadow_1 = 1.0;
  float tmpvar_48;
  float tmpvar_49;
  tmpvar_49 = dot (tmpvar_3, tmpvar_3);
  float tmpvar_50;
  tmpvar_50 = (2.0 * dot (tmpvar_3, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_51;
  tmpvar_51 = ((tmpvar_50 * tmpvar_50) - ((4.0 * tmpvar_49) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
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
    int j_54;
    int i_55;
    vec3 worldPos_56;
    worldPos_56 = (_WorldSpaceCameraPos + (tmpvar_3 * tmpvar_48));
    i_55 = 0;
    while (true) {
      if ((i_55 >= 4)) {
        break;
      };
      if ((lightOccluders1[3][i_55] <= 0.0)) {
        break;
      };
      vec4 v_57;
      v_57.x = lightOccluders1[0][i_55];
      v_57.y = lightOccluders1[1][i_55];
      v_57.z = lightOccluders1[2][i_55];
      v_57.w = lightOccluders1[3][i_55];
      vec3 sphereDirection_58;
      vec3 lightDirection_59;
      vec3 tmpvar_60;
      tmpvar_60 = (sunPosAndRadius.xyz - worldPos_56);
      float tmpvar_61;
      tmpvar_61 = sqrt(dot (tmpvar_60, tmpvar_60));
      lightDirection_59 = (tmpvar_60 / vec3(tmpvar_61));
      vec3 tmpvar_62;
      tmpvar_62 = (v_57.xyz - worldPos_56);
      float tmpvar_63;
      tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
      sphereDirection_58 = (tmpvar_62 / tmpvar_63);
      vec3 tmpvar_64;
      tmpvar_64 = ((lightDirection_59.yzx * sphereDirection_58.zxy) - (lightDirection_59.zxy * sphereDirection_58.yzx));
      float tmpvar_65;
      tmpvar_65 = min (1.0, sqrt(dot (tmpvar_64, tmpvar_64)));
      float tmpvar_66;
      tmpvar_66 = min (1.0, (vec3(lightOccluders1[3][i_55]) / tmpvar_63).x);
      float tmpvar_67;
      tmpvar_67 = clamp (((
        (-((vec3(tmpvar_61) * (
          (sign(tmpvar_65) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_65))
          ) * (1.570796 + 
            (abs(tmpvar_65) * (-0.2146018 + (abs(tmpvar_65) * (0.08656672 + 
              (abs(tmpvar_65) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_66) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_66))
          ) * (1.570796 + 
            (abs(tmpvar_66) * (-0.2146018 + (abs(tmpvar_66) * (0.08656672 + 
              (abs(tmpvar_66) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_68;
      tmpvar_68 = clamp ((dot (lightDirection_59, sphereDirection_58) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_67 * (tmpvar_67 * (3.0 - (2.0 * tmpvar_67))))
       * 
        (tmpvar_68 * (tmpvar_68 * (3.0 - (2.0 * tmpvar_68))))
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
      vec4 v_69;
      v_69.x = lightOccluders2[0][j_54];
      v_69.y = lightOccluders2[1][j_54];
      v_69.z = lightOccluders2[2][j_54];
      v_69.w = lightOccluders2[3][j_54];
      vec3 sphereDirection_70;
      vec3 lightDirection_71;
      vec3 tmpvar_72;
      tmpvar_72 = (sunPosAndRadius.xyz - worldPos_56);
      float tmpvar_73;
      tmpvar_73 = sqrt(dot (tmpvar_72, tmpvar_72));
      lightDirection_71 = (tmpvar_72 / vec3(tmpvar_73));
      vec3 tmpvar_74;
      tmpvar_74 = (v_69.xyz - worldPos_56);
      float tmpvar_75;
      tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
      sphereDirection_70 = (tmpvar_74 / tmpvar_75);
      vec3 tmpvar_76;
      tmpvar_76 = ((lightDirection_71.yzx * sphereDirection_70.zxy) - (lightDirection_71.zxy * sphereDirection_70.yzx));
      float tmpvar_77;
      tmpvar_77 = min (1.0, sqrt(dot (tmpvar_76, tmpvar_76)));
      float tmpvar_78;
      tmpvar_78 = min (1.0, (vec3(lightOccluders2[3][j_54]) / tmpvar_75).x);
      float tmpvar_79;
      tmpvar_79 = clamp (((
        (-((vec3(tmpvar_73) * (
          (sign(tmpvar_77) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_77))
          ) * (1.570796 + 
            (abs(tmpvar_77) * (-0.2146018 + (abs(tmpvar_77) * (0.08656672 + 
              (abs(tmpvar_77) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_78) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_78))
          ) * (1.570796 + 
            (abs(tmpvar_78) * (-0.2146018 + (abs(tmpvar_78) * (0.08656672 + 
              (abs(tmpvar_78) * -0.03102955)
            ))))
          ))))
        )).x) / sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_80;
      tmpvar_80 = clamp ((dot (lightDirection_71, sphereDirection_70) / 0.2), 0.0, 1.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_79 * (tmpvar_79 * (3.0 - (2.0 * tmpvar_79))))
       * 
        (tmpvar_80 * (tmpvar_80 * (3.0 - (2.0 * tmpvar_80))))
      )));
      j_54++;
    };
  };
  vec3 L_81;
  L_81 = ((inscatter_2 * eclipseShadow_1) * xlat_mutable_Exposure);
  float tmpvar_82;
  if ((L_81.x < 1.413)) {
    tmpvar_82 = pow ((L_81.x * 0.38317), 0.4545454);
  } else {
    tmpvar_82 = (1.0 - exp(-(L_81.x)));
  };
  L_81.x = tmpvar_82;
  float tmpvar_83;
  if ((L_81.y < 1.413)) {
    tmpvar_83 = pow ((L_81.y * 0.38317), 0.4545454);
  } else {
    tmpvar_83 = (1.0 - exp(-(L_81.y)));
  };
  L_81.y = tmpvar_83;
  float tmpvar_84;
  if ((L_81.z < 1.413)) {
    tmpvar_84 = pow ((L_81.z * 0.38317), 0.4545454);
  } else {
    tmpvar_84 = (1.0 - exp(-(L_81.z)));
  };
  L_81.z = tmpvar_84;
  vec4 tmpvar_85;
  tmpvar_85.w = 1.0;
  tmpvar_85.xyz = (_Alpha_Global * L_81);
  gl_FragData[0] = tmpvar_85;
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
  highp vec3 inscatter_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = (2.0 * dot (tmpvar_3, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * tmpvar_5) - ((4.0 * tmpvar_4) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
   - 
    (Rg * Rg)
  )));
  highp float tmpvar_7;
  if ((tmpvar_6 < 0.0)) {
    tmpvar_7 = -1.0;
  } else {
    tmpvar_7 = ((-(tmpvar_5) - sqrt(tmpvar_6)) / (2.0 * tmpvar_4));
  };
  bool tmpvar_8;
  tmpvar_8 = (tmpvar_7 > 0.0);
  if (!(tmpvar_8)) {
    xlat_mutable_Exposure = _RimExposure;
  };
  highp vec3 camera_9;
  camera_9 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp vec3 viewdir_10;
  viewdir_10.yz = tmpvar_3.yz;
  highp float rMu_11;
  highp float r_12;
  highp vec3 result_13;
  result_13 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_10.x = (tmpvar_3.x + _viewdirOffset);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_10);
  viewdir_10 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_9, camera_9));
  r_12 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (camera_9, tmpvar_14);
  rMu_11 = tmpvar_16;
  highp float f_17;
  f_17 = (((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (xlat_mutableRt * xlat_mutableRt));
  highp float tmpvar_18;
  if ((f_17 >= 0.0)) {
    tmpvar_18 = sqrt(f_17);
  } else {
    tmpvar_18 = 1e-06;
  };
  highp float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_16) - tmpvar_18), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_9 = (camera_9 + (tmpvar_19 * tmpvar_14));
    rMu_11 = (tmpvar_16 + tmpvar_19);
    r_12 = xlat_mutableRt;
  };
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_14, _Sun_WorldSunDir);
  highp float tmpvar_21;
  tmpvar_21 = (dot (camera_9, _Sun_WorldSunDir) / r_12);
  highp vec4 tmpvar_22;
  highp float _lerp_23;
  highp float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (Rg * Rg);
  tmpvar_24 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_25));
  highp float tmpvar_26;
  tmpvar_26 = sqrt(((r_12 * r_12) - tmpvar_25));
  highp float tmpvar_27;
  tmpvar_27 = (r_12 * (rMu_11 / r_12));
  highp float tmpvar_28;
  tmpvar_28 = (((tmpvar_27 * tmpvar_27) - (r_12 * r_12)) + tmpvar_25);
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
  if ((r_12 <= xlat_mutableRt)) {
    highp float tmpvar_51;
    tmpvar_51 = (mieG * mieG);
    result_13 = ((tmpvar_22.xyz * (
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
    result_13 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_2 = (result_13 * _Sun_Intensity);
  eclipseShadow_1 = 1.0;
  highp float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = dot (tmpvar_3, tmpvar_3);
  highp float tmpvar_54;
  tmpvar_54 = (2.0 * dot (tmpvar_3, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_55;
  tmpvar_55 = ((tmpvar_54 * tmpvar_54) - ((4.0 * tmpvar_53) * (
    ((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos)))
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
    worldPos_60 = (_WorldSpaceCameraPos + (tmpvar_3 * tmpvar_52));
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
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
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
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - (
        (tmpvar_83 * (tmpvar_83 * (3.0 - (2.0 * tmpvar_83))))
       * 
        (tmpvar_84 * (tmpvar_84 * (3.0 - (2.0 * tmpvar_84))))
      )));
      j_58++;
    };
  };
  highp vec3 L_85;
  L_85 = ((inscatter_2 * eclipseShadow_1) * xlat_mutable_Exposure);
  highp float tmpvar_86;
  if ((L_85.x < 1.413)) {
    tmpvar_86 = pow ((L_85.x * 0.38317), 0.4545454);
  } else {
    tmpvar_86 = (1.0 - exp(-(L_85.x)));
  };
  L_85.x = tmpvar_86;
  highp float tmpvar_87;
  if ((L_85.y < 1.413)) {
    tmpvar_87 = pow ((L_85.y * 0.38317), 0.4545454);
  } else {
    tmpvar_87 = (1.0 - exp(-(L_85.y)));
  };
  L_85.y = tmpvar_87;
  highp float tmpvar_88;
  if ((L_85.z < 1.413)) {
    tmpvar_88 = pow ((L_85.z * 0.38317), 0.4545454);
  } else {
    tmpvar_88 = (1.0 - exp(-(L_85.z)));
  };
  L_85.z = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89.w = 1.0;
  tmpvar_89.xyz = (_Alpha_Global * L_85);
  gl_FragData[0] = tmpvar_89;
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
    tb24 = t0.x>=0.0;
    t0.x = sqrt(t0.x);
    t0.x = (tb24) ? (-t0.x) : -9.99999997e-007;
    t0.x = t0.x + (-t6.y);
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
SubProgram "metal " {
// Stats: 2 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" ATTR0
ConstBuffer "$Globals" 128
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [_Object2World]
"metal_vs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float4 _glesVertex [[attribute(0)]];
};
struct xlatMtlShaderOutput {
  float4 gl_Position [[position]];
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderUniform {
  float4x4 glstate_matrix_mvp;
  float4x4 _Object2World;
};
vertex xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]])
{
  xlatMtlShaderOutput _mtl_o;
  _mtl_o.gl_Position = (_mtl_u.glstate_matrix_mvp * _mtl_i._glesVertex);
  _mtl_o.xlv_TEXCOORD0 = (_mtl_u._Object2World * _mtl_i._glesVertex).xyz;
  return _mtl_o;
}

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
    tb24 = t0.x>=0.0;
    t0.x = sqrt(t0.x);
    t0.x = (tb24) ? (-t0.x) : -9.99999997e-007;
    t0.x = t0.x + (-t6.y);
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
eefiecedphbhgbmhljcneikkhgmkhibdjlhddbmeabaaaaaajmbgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmbfaaaa
eaaaaaaahhafaaaafjaaaaaeegiocaaaaaaaaaaablaaaaaafjaaaaaeegiocaaa
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
akaabaaaagaaaaaaakaabaaaadaaaaaabnaaaaahbcaabaaaadaaaaaadkaabaaa
acaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
dhaaaaakicaabaaaacaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
abeaaaaalndhiglfaaaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaabkaabaia
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
SubProgram "metal " {
// Stats: 232 math, 4 textures, 9 branches
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 144
Vector 0 [_WorldSpaceCameraPos] 3
Float 16 [M_PI]
Vector 32 [betaR] 3
Float 48 [mieG]
Float 52 [_Exposure]
Float 56 [Rg]
Float 60 [Rt]
Float 64 [RES_R]
Float 68 [RES_MU]
Float 72 [RES_MU_S]
Float 76 [RES_NU]
Float 80 [_Sun_Intensity]
Float 84 [_experimentalAtmoScale]
Float 88 [_viewdirOffset]
Float 92 [_Alpha_Global]
Vector 96 [_Globals_Origin] 3
Float 112 [_RimExposure]
Vector 128 [_Sun_WorldSunDir] 3
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float M_PI;
  float3 betaR;
  float mieG;
  float _Exposure;
  float Rg;
  float Rt;
  float RES_R;
  float RES_MU;
  float RES_MU_S;
  float RES_NU;
  float _Sun_Intensity;
  float _experimentalAtmoScale;
  float _viewdirOffset;
  float _Alpha_Global;
  float3 _Globals_Origin;
  float _RimExposure;
  float3 _Sun_WorldSunDir;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _Inscatter [[texture(0)]], sampler _mtlsmp__Inscatter [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
float xlat_mutableRt_1;
float xlat_mutable_Exposure_2;
  xlat_mutableRt_1 = _mtl_u.Rt;
  xlat_mutable_Exposure_2 = _mtl_u._Exposure;
  float3 tmpvar_3;
  tmpvar_3 = normalize((_mtl_i.xlv_TEXCOORD0 - _mtl_u._WorldSpaceCameraPos));
  float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, tmpvar_3);
  float tmpvar_5;
  tmpvar_5 = (2.0 * dot (tmpvar_3, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
  float tmpvar_6;
  tmpvar_6 = ((tmpvar_5 * tmpvar_5) - ((4.0 * tmpvar_4) * (
    ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
   - 
    (_mtl_u.Rg * _mtl_u.Rg)
  )));
  float tmpvar_7;
  if ((tmpvar_6 < 0.0)) {
    tmpvar_7 = -1.0;
  } else {
    tmpvar_7 = ((-(tmpvar_5) - sqrt(tmpvar_6)) / (2.0 * tmpvar_4));
  };
  bool tmpvar_8;
  tmpvar_8 = (tmpvar_7 > 0.0);
  if (!(tmpvar_8)) {
    xlat_mutable_Exposure_2 = _mtl_u._RimExposure;
  };
  float3 camera_9;
  camera_9 = (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin);
  float3 viewdir_10;
  viewdir_10.yz = tmpvar_3.yz;
  float rMu_11;
  float r_12;
  float3 result_13;
  result_13 = float3(0.0, 0.0, 0.0);
  xlat_mutableRt_1 = (_mtl_u.Rg + ((_mtl_u.Rt - _mtl_u.Rg) * _mtl_u._experimentalAtmoScale));
  viewdir_10.x = (tmpvar_3.x + _mtl_u._viewdirOffset);
  float3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_10);
  viewdir_10 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_9, camera_9));
  r_12 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = dot (camera_9, tmpvar_14);
  rMu_11 = tmpvar_16;
  float f_17;
  f_17 = (((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (xlat_mutableRt_1 * xlat_mutableRt_1));
  float tmpvar_18;
  if ((f_17 >= 0.0)) {
    tmpvar_18 = sqrt(f_17);
  } else {
    tmpvar_18 = 1e-06;
  };
  float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_16) - tmpvar_18), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_9 = (camera_9 + (tmpvar_19 * tmpvar_14));
    rMu_11 = (tmpvar_16 + tmpvar_19);
    r_12 = xlat_mutableRt_1;
  };
  float tmpvar_20;
  tmpvar_20 = dot (tmpvar_14, _mtl_u._Sun_WorldSunDir);
  float tmpvar_21;
  tmpvar_21 = (dot (camera_9, _mtl_u._Sun_WorldSunDir) / r_12);
  float4 tmpvar_22;
  float _lerp_23;
  float tmpvar_24;
  float tmpvar_25;
  tmpvar_25 = (_mtl_u.Rg * _mtl_u.Rg);
  tmpvar_24 = sqrt(((xlat_mutableRt_1 * xlat_mutableRt_1) - tmpvar_25));
  float tmpvar_26;
  tmpvar_26 = sqrt(((r_12 * r_12) - tmpvar_25));
  float tmpvar_27;
  tmpvar_27 = (r_12 * (rMu_11 / r_12));
  float tmpvar_28;
  tmpvar_28 = (((tmpvar_27 * tmpvar_27) - (r_12 * r_12)) + tmpvar_25);
  float4 tmpvar_29;
  if (((tmpvar_27 < 0.0) && (tmpvar_28 > 0.0))) {
    float4 tmpvar_30;
    tmpvar_30.xyz = float3(1.0, 0.0, 0.0);
    tmpvar_30.w = (0.5 - (0.5 / _mtl_u.RES_MU));
    tmpvar_29 = tmpvar_30;
  } else {
    float4 tmpvar_31;
    tmpvar_31.x = -1.0;
    tmpvar_31.y = (tmpvar_24 * tmpvar_24);
    tmpvar_31.z = tmpvar_24;
    tmpvar_31.w = (0.5 + (0.5 / _mtl_u.RES_MU));
    tmpvar_29 = tmpvar_31;
  };
  float tmpvar_32;
  tmpvar_32 = ((0.5 / _mtl_u.RES_R) + ((tmpvar_26 / tmpvar_24) * (1.0 - 
    (1.0/(_mtl_u.RES_R))
  )));
  float tmpvar_33;
  tmpvar_33 = (tmpvar_29.w + ((
    ((tmpvar_27 * tmpvar_29.x) + sqrt((tmpvar_28 + tmpvar_29.y)))
   / 
    (tmpvar_26 + tmpvar_29.z)
  ) * (0.5 - 
    (1.0/(_mtl_u.RES_MU))
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
  tmpvar_37 = ((0.5 / _mtl_u.RES_MU_S) + ((
    (((tmpvar_36 * sign(y_over_x_34)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(_mtl_u.RES_MU_S))
  )));
  float tmpvar_38;
  tmpvar_38 = (((tmpvar_20 + 1.0) / 2.0) * (_mtl_u.RES_NU - 1.0));
  float tmpvar_39;
  tmpvar_39 = floor(tmpvar_38);
  _lerp_23 = (tmpvar_38 - tmpvar_39);
  float tmpvar_40;
  tmpvar_40 = (floor((
    (tmpvar_32 * _mtl_u.RES_R)
   - 1.0)) / _mtl_u.RES_R);
  float tmpvar_41;
  tmpvar_41 = (floor((tmpvar_32 * _mtl_u.RES_R)) / _mtl_u.RES_R);
  float tmpvar_42;
  tmpvar_42 = fract((tmpvar_32 * _mtl_u.RES_R));
  float4 tmpvar_43;
  tmpvar_43.zw = float2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_39 + tmpvar_37) / _mtl_u.RES_NU);
  tmpvar_43.y = ((tmpvar_33 / _mtl_u.RES_R) + tmpvar_40);
  half4 tmpvar_44;
  tmpvar_44 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_43.xy), level(0.0));
  float4 tmpvar_45;
  tmpvar_45.zw = float2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_39 + tmpvar_37) + 1.0) / _mtl_u.RES_NU);
  tmpvar_45.y = ((tmpvar_33 / _mtl_u.RES_R) + tmpvar_40);
  half4 tmpvar_46;
  tmpvar_46 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_45.xy), level(0.0));
  float4 tmpvar_47;
  tmpvar_47.zw = float2(0.0, 0.0);
  tmpvar_47.x = ((tmpvar_39 + tmpvar_37) / _mtl_u.RES_NU);
  tmpvar_47.y = ((tmpvar_33 / _mtl_u.RES_R) + tmpvar_41);
  half4 tmpvar_48;
  tmpvar_48 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_47.xy), level(0.0));
  float4 tmpvar_49;
  tmpvar_49.zw = float2(0.0, 0.0);
  tmpvar_49.x = (((tmpvar_39 + tmpvar_37) + 1.0) / _mtl_u.RES_NU);
  tmpvar_49.y = ((tmpvar_33 / _mtl_u.RES_R) + tmpvar_41);
  half4 tmpvar_50;
  tmpvar_50 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_49.xy), level(0.0));
  tmpvar_22 = (((
    ((float4)tmpvar_44 * (1.0 - _lerp_23))
   + 
    ((float4)tmpvar_46 * _lerp_23)
  ) * (1.0 - tmpvar_42)) + ((
    ((float4)tmpvar_48 * (1.0 - _lerp_23))
   + 
    ((float4)tmpvar_50 * _lerp_23)
  ) * tmpvar_42));
  if ((r_12 <= xlat_mutableRt_1)) {
    float tmpvar_51;
    tmpvar_51 = (_mtl_u.mieG * _mtl_u.mieG);
    result_13 = ((tmpvar_22.xyz * (
      (3.0 / (16.0 * _mtl_u.M_PI))
     * 
      (1.0 + (tmpvar_20 * tmpvar_20))
    )) + ((
      ((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001))
     * 
      (_mtl_u.betaR.x / _mtl_u.betaR)
    ) * (
      ((((1.5 / 
        (4.0 * _mtl_u.M_PI)
      ) * (1.0 - tmpvar_51)) * pow ((
        (1.0 + tmpvar_51)
       - 
        ((2.0 * _mtl_u.mieG) * tmpvar_20)
      ), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20)))
     / 
      (2.0 + tmpvar_51)
    )));
  } else {
    result_13 = float3(0.0, 0.0, 0.0);
  };
  float3 L_52;
  L_52 = ((result_13 * _mtl_u._Sun_Intensity) * xlat_mutable_Exposure_2);
  float tmpvar_53;
  if ((L_52.x < 1.413)) {
    tmpvar_53 = pow ((L_52.x * 0.38317), 0.4545454);
  } else {
    tmpvar_53 = (1.0 - exp(-(L_52.x)));
  };
  L_52.x = tmpvar_53;
  float tmpvar_54;
  if ((L_52.y < 1.413)) {
    tmpvar_54 = pow ((L_52.y * 0.38317), 0.4545454);
  } else {
    tmpvar_54 = (1.0 - exp(-(L_52.y)));
  };
  L_52.y = tmpvar_54;
  float tmpvar_55;
  if ((L_52.z < 1.413)) {
    tmpvar_55 = pow ((L_52.z * 0.38317), 0.4545454);
  } else {
    tmpvar_55 = (1.0 - exp(-(L_52.z)));
  };
  L_52.z = tmpvar_55;
  float4 tmpvar_56;
  tmpvar_56.w = 1.0;
  tmpvar_56.xyz = (_mtl_u._Alpha_Global * L_52);
  _mtl_o._glesFragData_0 = half4(tmpvar_56);
  return _mtl_o;
}

"
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
eefiecedefdhifceldglmohfccofimkpjhmbbdgpabaaaaaadmcgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmcfaaaa
eaaaaaaafpajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
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
aeaaaaaaakaabaaaaeaaaaaaakaabaaaaaaaaaaabnaaaaahicaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadhaaaaakbcaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaiaebaaaaaa
aaaaaaaaabeaaaaalndhiglfaaaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaa
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
SubProgram "metal " {
// Stats: 424 math, 4 textures, 18 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 288
Matrix 160 [lightOccluders1]
Matrix 224 [lightOccluders2]
Vector 0 [_WorldSpaceCameraPos] 3
Float 16 [M_PI]
Vector 32 [betaR] 3
Float 48 [mieG]
Float 52 [_Exposure]
Float 56 [Rg]
Float 60 [Rt]
Float 64 [RES_R]
Float 68 [RES_MU]
Float 72 [RES_MU_S]
Float 76 [RES_NU]
Float 80 [_Sun_Intensity]
Float 84 [_experimentalAtmoScale]
Float 88 [_viewdirOffset]
Float 92 [_Alpha_Global]
Vector 96 [_Globals_Origin] 3
Float 112 [_RimExposure]
Vector 128 [_Sun_WorldSunDir] 3
Vector 144 [sunPosAndRadius]
"metal_fs
#include <metal_stdlib>
using namespace metal;
struct xlatMtlShaderInput {
  float3 xlv_TEXCOORD0;
};
struct xlatMtlShaderOutput {
  half4 _glesFragData_0 [[color(0)]];
};
struct xlatMtlShaderUniform {
  float3 _WorldSpaceCameraPos;
  float M_PI;
  float3 betaR;
  float mieG;
  float _Exposure;
  float Rg;
  float Rt;
  float RES_R;
  float RES_MU;
  float RES_MU_S;
  float RES_NU;
  float _Sun_Intensity;
  float _experimentalAtmoScale;
  float _viewdirOffset;
  float _Alpha_Global;
  float3 _Globals_Origin;
  float _RimExposure;
  float3 _Sun_WorldSunDir;
  float4 sunPosAndRadius;
  float4x4 lightOccluders1;
  float4x4 lightOccluders2;
};
fragment xlatMtlShaderOutput xlatMtlMain (xlatMtlShaderInput _mtl_i [[stage_in]], constant xlatMtlShaderUniform& _mtl_u [[buffer(0)]]
  ,   texture2d<half> _Inscatter [[texture(0)]], sampler _mtlsmp__Inscatter [[sampler(0)]])
{
  xlatMtlShaderOutput _mtl_o;
float xlat_mutableRt_1;
float xlat_mutable_Exposure_2;
  xlat_mutableRt_1 = _mtl_u.Rt;
  xlat_mutable_Exposure_2 = _mtl_u._Exposure;
  float eclipseShadow_3;
  float3 inscatter_4;
  float3 tmpvar_5;
  tmpvar_5 = normalize((_mtl_i.xlv_TEXCOORD0 - _mtl_u._WorldSpaceCameraPos));
  float tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, tmpvar_5);
  float tmpvar_7;
  tmpvar_7 = (2.0 * dot (tmpvar_5, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
  float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (
    ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
   - 
    (_mtl_u.Rg * _mtl_u.Rg)
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
    xlat_mutable_Exposure_2 = _mtl_u._RimExposure;
  };
  float3 camera_11;
  camera_11 = (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin);
  float3 viewdir_12;
  viewdir_12.yz = tmpvar_5.yz;
  float rMu_13;
  float r_14;
  float3 result_15;
  result_15 = float3(0.0, 0.0, 0.0);
  xlat_mutableRt_1 = (_mtl_u.Rg + ((_mtl_u.Rt - _mtl_u.Rg) * _mtl_u._experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _mtl_u._viewdirOffset);
  float3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_12);
  viewdir_12 = tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = dot (camera_11, tmpvar_16);
  rMu_13 = tmpvar_18;
  float f_19;
  f_19 = (((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (xlat_mutableRt_1 * xlat_mutableRt_1));
  float tmpvar_20;
  if ((f_19 >= 0.0)) {
    tmpvar_20 = sqrt(f_19);
  } else {
    tmpvar_20 = 1e-06;
  };
  float tmpvar_21;
  tmpvar_21 = max ((-(tmpvar_18) - tmpvar_20), 0.0);
  if ((tmpvar_21 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_21 * tmpvar_16));
    rMu_13 = (tmpvar_18 + tmpvar_21);
    r_14 = xlat_mutableRt_1;
  };
  float tmpvar_22;
  tmpvar_22 = dot (tmpvar_16, _mtl_u._Sun_WorldSunDir);
  float tmpvar_23;
  tmpvar_23 = (dot (camera_11, _mtl_u._Sun_WorldSunDir) / r_14);
  float4 tmpvar_24;
  float _lerp_25;
  float tmpvar_26;
  float tmpvar_27;
  tmpvar_27 = (_mtl_u.Rg * _mtl_u.Rg);
  tmpvar_26 = sqrt(((xlat_mutableRt_1 * xlat_mutableRt_1) - tmpvar_27));
  float tmpvar_28;
  tmpvar_28 = sqrt(((r_14 * r_14) - tmpvar_27));
  float tmpvar_29;
  tmpvar_29 = (r_14 * (rMu_13 / r_14));
  float tmpvar_30;
  tmpvar_30 = (((tmpvar_29 * tmpvar_29) - (r_14 * r_14)) + tmpvar_27);
  float4 tmpvar_31;
  if (((tmpvar_29 < 0.0) && (tmpvar_30 > 0.0))) {
    float4 tmpvar_32;
    tmpvar_32.xyz = float3(1.0, 0.0, 0.0);
    tmpvar_32.w = (0.5 - (0.5 / _mtl_u.RES_MU));
    tmpvar_31 = tmpvar_32;
  } else {
    float4 tmpvar_33;
    tmpvar_33.x = -1.0;
    tmpvar_33.y = (tmpvar_26 * tmpvar_26);
    tmpvar_33.z = tmpvar_26;
    tmpvar_33.w = (0.5 + (0.5 / _mtl_u.RES_MU));
    tmpvar_31 = tmpvar_33;
  };
  float tmpvar_34;
  tmpvar_34 = ((0.5 / _mtl_u.RES_R) + ((tmpvar_28 / tmpvar_26) * (1.0 - 
    (1.0/(_mtl_u.RES_R))
  )));
  float tmpvar_35;
  tmpvar_35 = (tmpvar_31.w + ((
    ((tmpvar_29 * tmpvar_31.x) + sqrt((tmpvar_30 + tmpvar_31.y)))
   / 
    (tmpvar_28 + tmpvar_31.z)
  ) * (0.5 - 
    (1.0/(_mtl_u.RES_MU))
  )));
  float y_over_x_36;
  y_over_x_36 = (max (tmpvar_23, -0.1975) * 5.349625);
  float tmpvar_37;
  tmpvar_37 = (min (abs(y_over_x_36), 1.0) / max (abs(y_over_x_36), 1.0));
  float tmpvar_38;
  tmpvar_38 = (tmpvar_37 * tmpvar_37);
  tmpvar_38 = (((
    ((((
      ((((-0.01213232 * tmpvar_38) + 0.05368138) * tmpvar_38) - 0.1173503)
     * tmpvar_38) + 0.1938925) * tmpvar_38) - 0.3326756)
   * tmpvar_38) + 0.9999793) * tmpvar_37);
  tmpvar_38 = (tmpvar_38 + (float(
    (abs(y_over_x_36) > 1.0)
  ) * (
    (tmpvar_38 * -2.0)
   + 1.570796)));
  float tmpvar_39;
  tmpvar_39 = ((0.5 / _mtl_u.RES_MU_S) + ((
    (((tmpvar_38 * sign(y_over_x_36)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(_mtl_u.RES_MU_S))
  )));
  float tmpvar_40;
  tmpvar_40 = (((tmpvar_22 + 1.0) / 2.0) * (_mtl_u.RES_NU - 1.0));
  float tmpvar_41;
  tmpvar_41 = floor(tmpvar_40);
  _lerp_25 = (tmpvar_40 - tmpvar_41);
  float tmpvar_42;
  tmpvar_42 = (floor((
    (tmpvar_34 * _mtl_u.RES_R)
   - 1.0)) / _mtl_u.RES_R);
  float tmpvar_43;
  tmpvar_43 = (floor((tmpvar_34 * _mtl_u.RES_R)) / _mtl_u.RES_R);
  float tmpvar_44;
  tmpvar_44 = fract((tmpvar_34 * _mtl_u.RES_R));
  float4 tmpvar_45;
  tmpvar_45.zw = float2(0.0, 0.0);
  tmpvar_45.x = ((tmpvar_41 + tmpvar_39) / _mtl_u.RES_NU);
  tmpvar_45.y = ((tmpvar_35 / _mtl_u.RES_R) + tmpvar_42);
  half4 tmpvar_46;
  tmpvar_46 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_45.xy), level(0.0));
  float4 tmpvar_47;
  tmpvar_47.zw = float2(0.0, 0.0);
  tmpvar_47.x = (((tmpvar_41 + tmpvar_39) + 1.0) / _mtl_u.RES_NU);
  tmpvar_47.y = ((tmpvar_35 / _mtl_u.RES_R) + tmpvar_42);
  half4 tmpvar_48;
  tmpvar_48 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_47.xy), level(0.0));
  float4 tmpvar_49;
  tmpvar_49.zw = float2(0.0, 0.0);
  tmpvar_49.x = ((tmpvar_41 + tmpvar_39) / _mtl_u.RES_NU);
  tmpvar_49.y = ((tmpvar_35 / _mtl_u.RES_R) + tmpvar_43);
  half4 tmpvar_50;
  tmpvar_50 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_49.xy), level(0.0));
  float4 tmpvar_51;
  tmpvar_51.zw = float2(0.0, 0.0);
  tmpvar_51.x = (((tmpvar_41 + tmpvar_39) + 1.0) / _mtl_u.RES_NU);
  tmpvar_51.y = ((tmpvar_35 / _mtl_u.RES_R) + tmpvar_43);
  half4 tmpvar_52;
  tmpvar_52 = _Inscatter.sample(_mtlsmp__Inscatter, (float2)(tmpvar_51.xy), level(0.0));
  tmpvar_24 = (((
    ((float4)tmpvar_46 * (1.0 - _lerp_25))
   + 
    ((float4)tmpvar_48 * _lerp_25)
  ) * (1.0 - tmpvar_44)) + ((
    ((float4)tmpvar_50 * (1.0 - _lerp_25))
   + 
    ((float4)tmpvar_52 * _lerp_25)
  ) * tmpvar_44));
  if ((r_14 <= xlat_mutableRt_1)) {
    float tmpvar_53;
    tmpvar_53 = (_mtl_u.mieG * _mtl_u.mieG);
    result_15 = ((tmpvar_24.xyz * (
      (3.0 / (16.0 * _mtl_u.M_PI))
     * 
      (1.0 + (tmpvar_22 * tmpvar_22))
    )) + ((
      ((tmpvar_24.xyz * tmpvar_24.w) / max (tmpvar_24.x, 0.0001))
     * 
      (_mtl_u.betaR.x / _mtl_u.betaR)
    ) * (
      ((((1.5 / 
        (4.0 * _mtl_u.M_PI)
      ) * (1.0 - tmpvar_53)) * pow ((
        (1.0 + tmpvar_53)
       - 
        ((2.0 * _mtl_u.mieG) * tmpvar_22)
      ), -1.5)) * (1.0 + (tmpvar_22 * tmpvar_22)))
     / 
      (2.0 + tmpvar_53)
    )));
  } else {
    result_15 = float3(0.0, 0.0, 0.0);
  };
  inscatter_4 = (result_15 * _mtl_u._Sun_Intensity);
  eclipseShadow_3 = 1.0;
  float tmpvar_54;
  float tmpvar_55;
  tmpvar_55 = dot (tmpvar_5, tmpvar_5);
  float tmpvar_56;
  tmpvar_56 = (2.0 * dot (tmpvar_5, (_mtl_u._WorldSpaceCameraPos - _mtl_u._Globals_Origin)));
  float tmpvar_57;
  tmpvar_57 = ((tmpvar_56 * tmpvar_56) - ((4.0 * tmpvar_55) * (
    ((dot (_mtl_u._Globals_Origin, _mtl_u._Globals_Origin) + dot (_mtl_u._WorldSpaceCameraPos, _mtl_u._WorldSpaceCameraPos)) - (2.0 * dot (_mtl_u._Globals_Origin, _mtl_u._WorldSpaceCameraPos)))
   - 
    (xlat_mutableRt_1 * xlat_mutableRt_1)
  )));
  if ((tmpvar_57 < 0.0)) {
    tmpvar_54 = -1.0;
  } else {
    float tmpvar_58;
    tmpvar_58 = ((-(tmpvar_56) - sqrt(tmpvar_57)) / (2.0 * tmpvar_55));
    float tmpvar_59;
    if ((tmpvar_58 < 0.0)) {
      tmpvar_59 = ((-(tmpvar_56) + sqrt(tmpvar_57)) / (2.0 * tmpvar_55));
    } else {
      tmpvar_59 = tmpvar_58;
    };
    tmpvar_54 = tmpvar_59;
  };
  if ((tmpvar_54 != -1.0)) {
    int j_60;
    int i_61;
    float3 worldPos_62;
    worldPos_62 = (_mtl_u._WorldSpaceCameraPos + (tmpvar_5 * tmpvar_54));
    i_61 = 0;
    while (true) {
      if ((i_61 >= 4)) {
        break;
      };
      if ((_mtl_u.lightOccluders1[3][i_61] <= 0.0)) {
        break;
      };
      float4 v_63;
      v_63.x = _mtl_u.lightOccluders1[0][i_61];
      v_63.y = _mtl_u.lightOccluders1[1][i_61];
      v_63.z = _mtl_u.lightOccluders1[2][i_61];
      v_63.w = _mtl_u.lightOccluders1[3][i_61];
      float3 sphereDirection_64;
      float3 lightDirection_65;
      float3 tmpvar_66;
      tmpvar_66 = (_mtl_u.sunPosAndRadius.xyz - worldPos_62);
      float tmpvar_67;
      tmpvar_67 = sqrt(dot (tmpvar_66, tmpvar_66));
      lightDirection_65 = (tmpvar_66 / float3(tmpvar_67));
      float3 tmpvar_68;
      tmpvar_68 = (v_63.xyz - worldPos_62);
      float tmpvar_69;
      tmpvar_69 = sqrt(dot (tmpvar_68, tmpvar_68));
      sphereDirection_64 = (tmpvar_68 / tmpvar_69);
      float3 tmpvar_70;
      tmpvar_70 = ((lightDirection_65.yzx * sphereDirection_64.zxy) - (lightDirection_65.zxy * sphereDirection_64.yzx));
      float tmpvar_71;
      tmpvar_71 = min (1.0, sqrt(dot (tmpvar_70, tmpvar_70)));
      float tmpvar_72;
      tmpvar_72 = min (1.0, (float3(_mtl_u.lightOccluders1[3][i_61]) / tmpvar_69).x);
      float tmpvar_73;
      tmpvar_73 = clamp (((
        (-((float3(tmpvar_67) * (
          (sign(tmpvar_71) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_71))
          ) * (1.570796 + 
            (abs(tmpvar_71) * (-0.2146018 + (abs(tmpvar_71) * (0.08656672 + 
              (abs(tmpvar_71) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_72) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_72))
          ) * (1.570796 + 
            (abs(tmpvar_72) * (-0.2146018 + (abs(tmpvar_72) * (0.08656672 + 
              (abs(tmpvar_72) * -0.03102955)
            ))))
          ))))
        )).x) / _mtl_u.sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_74;
      tmpvar_74 = clamp ((dot (lightDirection_65, sphereDirection_64) / 0.2), 0.0, 1.0);
      eclipseShadow_3 = (eclipseShadow_3 * (1.0 - (
        (tmpvar_73 * (tmpvar_73 * (3.0 - (2.0 * tmpvar_73))))
       * 
        (tmpvar_74 * (tmpvar_74 * (3.0 - (2.0 * tmpvar_74))))
      )));
      i_61++;
    };
    j_60 = 0;
    while (true) {
      if ((j_60 >= 4)) {
        break;
      };
      if ((_mtl_u.lightOccluders2[3][j_60] <= 0.0)) {
        break;
      };
      float4 v_75;
      v_75.x = _mtl_u.lightOccluders2[0][j_60];
      v_75.y = _mtl_u.lightOccluders2[1][j_60];
      v_75.z = _mtl_u.lightOccluders2[2][j_60];
      v_75.w = _mtl_u.lightOccluders2[3][j_60];
      float3 sphereDirection_76;
      float3 lightDirection_77;
      float3 tmpvar_78;
      tmpvar_78 = (_mtl_u.sunPosAndRadius.xyz - worldPos_62);
      float tmpvar_79;
      tmpvar_79 = sqrt(dot (tmpvar_78, tmpvar_78));
      lightDirection_77 = (tmpvar_78 / float3(tmpvar_79));
      float3 tmpvar_80;
      tmpvar_80 = (v_75.xyz - worldPos_62);
      float tmpvar_81;
      tmpvar_81 = sqrt(dot (tmpvar_80, tmpvar_80));
      sphereDirection_76 = (tmpvar_80 / tmpvar_81);
      float3 tmpvar_82;
      tmpvar_82 = ((lightDirection_77.yzx * sphereDirection_76.zxy) - (lightDirection_77.zxy * sphereDirection_76.yzx));
      float tmpvar_83;
      tmpvar_83 = min (1.0, sqrt(dot (tmpvar_82, tmpvar_82)));
      float tmpvar_84;
      tmpvar_84 = min (1.0, (float3(_mtl_u.lightOccluders2[3][j_60]) / tmpvar_81).x);
      float tmpvar_85;
      tmpvar_85 = clamp (((
        (-((float3(tmpvar_79) * (
          (sign(tmpvar_83) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_83))
          ) * (1.570796 + 
            (abs(tmpvar_83) * (-0.2146018 + (abs(tmpvar_83) * (0.08656672 + 
              (abs(tmpvar_83) * -0.03102955)
            ))))
          ))))
         - 
          (sign(tmpvar_84) * (1.570796 - (sqrt(
            (1.0 - abs(tmpvar_84))
          ) * (1.570796 + 
            (abs(tmpvar_84) * (-0.2146018 + (abs(tmpvar_84) * (0.08656672 + 
              (abs(tmpvar_84) * -0.03102955)
            ))))
          ))))
        )).x) / _mtl_u.sunPosAndRadius.www)
      .x - -1.0) / 2.0), 0.0, 1.0);
      float tmpvar_86;
      tmpvar_86 = clamp ((dot (lightDirection_77, sphereDirection_76) / 0.2), 0.0, 1.0);
      eclipseShadow_3 = (eclipseShadow_3 * (1.0 - (
        (tmpvar_85 * (tmpvar_85 * (3.0 - (2.0 * tmpvar_85))))
       * 
        (tmpvar_86 * (tmpvar_86 * (3.0 - (2.0 * tmpvar_86))))
      )));
      j_60++;
    };
  };
  float3 L_87;
  L_87 = ((inscatter_4 * eclipseShadow_3) * xlat_mutable_Exposure_2);
  float tmpvar_88;
  if ((L_87.x < 1.413)) {
    tmpvar_88 = pow ((L_87.x * 0.38317), 0.4545454);
  } else {
    tmpvar_88 = (1.0 - exp(-(L_87.x)));
  };
  L_87.x = tmpvar_88;
  float tmpvar_89;
  if ((L_87.y < 1.413)) {
    tmpvar_89 = pow ((L_87.y * 0.38317), 0.4545454);
  } else {
    tmpvar_89 = (1.0 - exp(-(L_87.y)));
  };
  L_87.y = tmpvar_89;
  float tmpvar_90;
  if ((L_87.z < 1.413)) {
    tmpvar_90 = pow ((L_87.z * 0.38317), 0.4545454);
  } else {
    tmpvar_90 = (1.0 - exp(-(L_87.z)));
  };
  L_87.z = tmpvar_90;
  float4 tmpvar_91;
  tmpvar_91.w = 1.0;
  tmpvar_91.xyz = (_mtl_u._Alpha_Global * L_87);
  _mtl_o._glesFragData_0 = half4(tmpvar_91);
  return _mtl_o;
}

"
}
SubProgram "glcore " {
Keywords { "ECLIPSES_ON" }
"!!GL3x"
}
}
 }
}
}