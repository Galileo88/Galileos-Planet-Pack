// Compiled shader for all platforms, uncompressed size: 273.3KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 // Stats for Fragment shader:
 //       d3d11 : 211 avg math (152..270), 9 avg branch (4..14)
 //        d3d9 : 493 avg math (263..724), 2 texture, 11 avg branch (3..20)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL
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
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float r_3;
  vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      extinction_4 = texture2DLod (_Transmittance, tmpvar_42.xy, 0.0).xyz;
    };
    float tmpvar_43;
    tmpvar_43 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    vec3 tmpvar_44;
    tmpvar_44.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    tmpvar_44.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    tmpvar_44.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    vec3 tmpvar_45;
    tmpvar_45 = (extinctionMultiplier * tmpvar_44);
    extinction_4 = tmpvar_45;
    float tmpvar_46;
    tmpvar_46 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_47;
    tmpvar_47 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    float tmpvar_48;
    tmpvar_48 = ((tmpvar_47 * tmpvar_47) - ((4.0 * tmpvar_46) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    float tmpvar_49;
    if ((tmpvar_48 < 0.0)) {
      tmpvar_49 = -1.0;
    } else {
      tmpvar_49 = ((-(tmpvar_47) - sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    };
    bool tmpvar_50;
    tmpvar_50 = (tmpvar_49 > 0.0);
    if (!(tmpvar_50)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_45));
    };
    vec4 tmpvar_51;
    tmpvar_51.w = 1.0;
    tmpvar_51.xyz = extinction_4;
    tmpvar_1 = tmpvar_51;
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
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
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
Keywords { "ECLIPSES_OFF" }
"!!GLES


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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_42;
      x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
      tmpvar_43.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = texture2DLodEXT (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_40 = tmpvar_44.xyz;
      extinction_4 = tmpvar_40;
    };
    highp float tmpvar_45;
    tmpvar_45 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_46;
    tmpvar_46.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    highp vec3 tmpvar_47;
    tmpvar_47 = (extinctionMultiplier * tmpvar_46);
    extinction_4 = tmpvar_47;
    highp float tmpvar_48;
    tmpvar_48 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_49;
    tmpvar_49 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_50;
    tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = -1.0;
    } else {
      tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    };
    bool tmpvar_52;
    tmpvar_52 = (tmpvar_51 > 0.0);
    if (!(tmpvar_52)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_47));
    };
    highp vec4 tmpvar_53;
    tmpvar_53.w = 1.0;
    tmpvar_53.xyz = extinction_4;
    tmpvar_1 = tmpvar_53;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_OFF" }
"!!GLES


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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_42;
      x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
      tmpvar_43.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = texture2DLodEXT (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_40 = tmpvar_44.xyz;
      extinction_4 = tmpvar_40;
    };
    highp float tmpvar_45;
    tmpvar_45 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_46;
    tmpvar_46.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    highp vec3 tmpvar_47;
    tmpvar_47 = (extinctionMultiplier * tmpvar_46);
    extinction_4 = tmpvar_47;
    highp float tmpvar_48;
    tmpvar_48 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_49;
    tmpvar_49 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_50;
    tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = -1.0;
    } else {
      tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    };
    bool tmpvar_52;
    tmpvar_52 = (tmpvar_51 > 0.0);
    if (!(tmpvar_52)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_47));
    };
    highp vec4 tmpvar_53;
    tmpvar_53.w = 1.0;
    tmpvar_53.xyz = extinction_4;
    tmpvar_1 = tmpvar_53;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
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
in highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_42;
      x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
      tmpvar_43.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = textureLod (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_40 = tmpvar_44.xyz;
      extinction_4 = tmpvar_40;
    };
    highp float tmpvar_45;
    tmpvar_45 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_46;
    tmpvar_46.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    highp vec3 tmpvar_47;
    tmpvar_47 = (extinctionMultiplier * tmpvar_46);
    extinction_4 = tmpvar_47;
    highp float tmpvar_48;
    tmpvar_48 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_49;
    tmpvar_49 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_50;
    tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = -1.0;
    } else {
      tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    };
    bool tmpvar_52;
    tmpvar_52 = (tmpvar_51 > 0.0);
    if (!(tmpvar_52)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_47));
    };
    highp vec4 tmpvar_53;
    tmpvar_53.w = 1.0;
    tmpvar_53.xyz = extinction_4;
    tmpvar_1 = tmpvar_53;
  };
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL
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
varying vec3 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  float mu_2;
  float r_3;
  vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      extinction_4 = texture2DLod (_Transmittance, tmpvar_42.xy, 0.0).xyz;
    };
    float tmpvar_43;
    tmpvar_43 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    vec3 tmpvar_44;
    tmpvar_44.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    tmpvar_44.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    tmpvar_44.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_43));
    vec3 tmpvar_45;
    tmpvar_45 = (extinctionMultiplier * tmpvar_44);
    extinction_4 = tmpvar_45;
    float tmpvar_46;
    tmpvar_46 = dot (tmpvar_6, tmpvar_6);
    float tmpvar_47;
    tmpvar_47 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    float tmpvar_48;
    tmpvar_48 = ((tmpvar_47 * tmpvar_47) - ((4.0 * tmpvar_46) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    float tmpvar_49;
    if ((tmpvar_48 < 0.0)) {
      tmpvar_49 = -1.0;
    } else {
      tmpvar_49 = ((-(tmpvar_47) - sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    };
    bool tmpvar_50;
    tmpvar_50 = (tmpvar_49 > 0.0);
    if (!(tmpvar_50)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_45));
    } else {
      float eclipseShadow_51;
      eclipseShadow_51 = 1.0;
      float tmpvar_52;
      float tmpvar_53;
      tmpvar_53 = dot (tmpvar_6, tmpvar_6);
      float tmpvar_54;
      tmpvar_54 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      float tmpvar_55;
      tmpvar_55 = ((tmpvar_54 * tmpvar_54) - ((4.0 * tmpvar_53) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
      if ((tmpvar_55 < 0.0)) {
        tmpvar_52 = -1.0;
      } else {
        float tmpvar_56;
        tmpvar_56 = ((-(tmpvar_54) - sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
        float tmpvar_57;
        if ((tmpvar_56 < 0.0)) {
          tmpvar_57 = ((-(tmpvar_54) + sqrt(tmpvar_55)) / (2.0 * tmpvar_53));
        } else {
          tmpvar_57 = tmpvar_56;
        };
        tmpvar_52 = tmpvar_57;
      };
      if ((tmpvar_52 != -1.0)) {
        int j_58;
        int i_59;
        vec3 worldPos_60;
        worldPos_60 = (tmpvar_5 + (tmpvar_6 * tmpvar_52));
        i_59 = 0;
        for (int i_59 = 0; i_59 < 4; ) {
          if ((lightOccluders1[3][i_59] <= 0.0)) {
            break;
          };
          vec4 v_61;
          v_61.x = lightOccluders1[0][i_59];
          v_61.y = lightOccluders1[1][i_59];
          v_61.z = lightOccluders1[2][i_59];
          v_61.w = lightOccluders1[3][i_59];
          vec3 tmpvar_62;
          tmpvar_62 = (sunPosAndRadius.xyz - worldPos_60);
          float tmpvar_63;
          tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
          vec3 tmpvar_64;
          tmpvar_64 = (tmpvar_62 / vec3(tmpvar_63));
          vec3 tmpvar_65;
          tmpvar_65 = (v_61.xyz - worldPos_60);
          float tmpvar_66;
          tmpvar_66 = sqrt(dot (tmpvar_65, tmpvar_65));
          vec3 tmpvar_67;
          tmpvar_67 = (tmpvar_65 / tmpvar_66);
          vec3 tmpvar_68;
          tmpvar_68 = ((tmpvar_64.yzx * tmpvar_67.zxy) - (tmpvar_64.zxy * tmpvar_67.yzx));
          float tmpvar_69;
          tmpvar_69 = min (1.0, sqrt(dot (tmpvar_68, tmpvar_68)));
          float tmpvar_70;
          tmpvar_70 = min (1.0, (vec3(lightOccluders1[3][i_59]) / tmpvar_66).x);
          float t_71;
          t_71 = max (min ((((-((vec3(tmpvar_63) * ((sign(tmpvar_69) * (1.5708 - (sqrt((1.0 - abs(tmpvar_69))) * (1.5708 + (abs(tmpvar_69) * (-0.214602 + (abs(tmpvar_69) * (0.0865667 + (abs(tmpvar_69) * -0.0310296))))))))) - (sign(tmpvar_70) * (1.5708 - (sqrt((1.0 - abs(tmpvar_70))) * (1.5708 + (abs(tmpvar_70) * (-0.214602 + (abs(tmpvar_70) * (0.0865667 + (abs(tmpvar_70) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          float t_72;
          t_72 = max (min ((dot (tmpvar_64, tmpvar_67) / 0.2), 1.0), 0.0);
          eclipseShadow_51 = (eclipseShadow_51 * (1.0 - ((t_71 * (t_71 * (3.0 - (2.0 * t_71)))) * (t_72 * (t_72 * (3.0 - (2.0 * t_72)))))));
          i_59 = (i_59 + 1);
        };
        j_58 = 0;
        for (int j_58 = 0; j_58 < 4; ) {
          if ((lightOccluders2[3][j_58] <= 0.0)) {
            break;
          };
          vec4 v_73;
          v_73.x = lightOccluders2[0][j_58];
          v_73.y = lightOccluders2[1][j_58];
          v_73.z = lightOccluders2[2][j_58];
          v_73.w = lightOccluders2[3][j_58];
          vec3 tmpvar_74;
          tmpvar_74 = (sunPosAndRadius.xyz - worldPos_60);
          float tmpvar_75;
          tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
          vec3 tmpvar_76;
          tmpvar_76 = (tmpvar_74 / vec3(tmpvar_75));
          vec3 tmpvar_77;
          tmpvar_77 = (v_73.xyz - worldPos_60);
          float tmpvar_78;
          tmpvar_78 = sqrt(dot (tmpvar_77, tmpvar_77));
          vec3 tmpvar_79;
          tmpvar_79 = (tmpvar_77 / tmpvar_78);
          vec3 tmpvar_80;
          tmpvar_80 = ((tmpvar_76.yzx * tmpvar_79.zxy) - (tmpvar_76.zxy * tmpvar_79.yzx));
          float tmpvar_81;
          tmpvar_81 = min (1.0, sqrt(dot (tmpvar_80, tmpvar_80)));
          float tmpvar_82;
          tmpvar_82 = min (1.0, (vec3(lightOccluders2[3][j_58]) / tmpvar_78).x);
          float t_83;
          t_83 = max (min ((((-((vec3(tmpvar_75) * ((sign(tmpvar_81) * (1.5708 - (sqrt((1.0 - abs(tmpvar_81))) * (1.5708 + (abs(tmpvar_81) * (-0.214602 + (abs(tmpvar_81) * (0.0865667 + (abs(tmpvar_81) * -0.0310296))))))))) - (sign(tmpvar_82) * (1.5708 - (sqrt((1.0 - abs(tmpvar_82))) * (1.5708 + (abs(tmpvar_82) * (-0.214602 + (abs(tmpvar_82) * (0.0865667 + (abs(tmpvar_82) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          float t_84;
          t_84 = max (min ((dot (tmpvar_76, tmpvar_79) / 0.2), 1.0), 0.0);
          eclipseShadow_51 = (eclipseShadow_51 * (1.0 - ((t_83 * (t_83 * (3.0 - (2.0 * t_83)))) * (t_84 * (t_84 * (3.0 - (2.0 * t_84)))))));
          j_58 = (j_58 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_51)));
    };
    vec4 tmpvar_85;
    tmpvar_85.w = 1.0;
    tmpvar_85.xyz = extinction_4;
    tmpvar_1 = tmpvar_85;
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
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
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
Keywords { "ECLIPSES_ON" }
"!!GLES


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
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_42;
      x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
      tmpvar_43.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = texture2DLodEXT (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_40 = tmpvar_44.xyz;
      extinction_4 = tmpvar_40;
    };
    highp float tmpvar_45;
    tmpvar_45 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_46;
    tmpvar_46.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    highp vec3 tmpvar_47;
    tmpvar_47 = (extinctionMultiplier * tmpvar_46);
    extinction_4 = tmpvar_47;
    highp float tmpvar_48;
    tmpvar_48 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_49;
    tmpvar_49 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_50;
    tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = -1.0;
    } else {
      tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    };
    bool tmpvar_52;
    tmpvar_52 = (tmpvar_51 > 0.0);
    if (!(tmpvar_52)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_47));
    } else {
      highp float eclipseShadow_53;
      eclipseShadow_53 = 1.0;
      highp float tmpvar_54;
      highp float tmpvar_55;
      tmpvar_55 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_56;
      tmpvar_56 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_57;
      tmpvar_57 = ((tmpvar_56 * tmpvar_56) - ((4.0 * tmpvar_55) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
      if ((tmpvar_57 < 0.0)) {
        tmpvar_54 = -1.0;
      } else {
        highp float tmpvar_58;
        tmpvar_58 = ((-(tmpvar_56) - sqrt(tmpvar_57)) / (2.0 * tmpvar_55));
        highp float tmpvar_59;
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
        highp vec3 worldPos_62;
        worldPos_62 = (tmpvar_5 + (tmpvar_6 * tmpvar_54));
        i_61 = 0;
        for (int i_61 = 0; i_61 < 4; ) {
          if ((lightOccluders1[3][i_61] <= 0.0)) {
            break;
          };
          highp vec4 v_63;
          v_63.x = lightOccluders1[0][i_61];
          v_63.y = lightOccluders1[1][i_61];
          v_63.z = lightOccluders1[2][i_61];
          v_63.w = lightOccluders1[3][i_61];
          highp vec3 tmpvar_64;
          tmpvar_64 = (sunPosAndRadius.xyz - worldPos_62);
          highp float tmpvar_65;
          tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
          highp vec3 tmpvar_66;
          tmpvar_66 = (tmpvar_64 / vec3(tmpvar_65));
          highp vec3 tmpvar_67;
          tmpvar_67 = (v_63.xyz - worldPos_62);
          highp float tmpvar_68;
          tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
          highp vec3 tmpvar_69;
          tmpvar_69 = (tmpvar_67 / tmpvar_68);
          highp vec3 tmpvar_70;
          tmpvar_70 = ((tmpvar_66.yzx * tmpvar_69.zxy) - (tmpvar_66.zxy * tmpvar_69.yzx));
          highp float tmpvar_71;
          tmpvar_71 = min (1.0, sqrt(dot (tmpvar_70, tmpvar_70)));
          highp float tmpvar_72;
          tmpvar_72 = min (1.0, (vec3(lightOccluders1[3][i_61]) / tmpvar_68).x);
          highp float t_73;
          t_73 = max (min ((((-((vec3(tmpvar_65) * ((sign(tmpvar_71) * (1.5708 - (sqrt((1.0 - abs(tmpvar_71))) * (1.5708 + (abs(tmpvar_71) * (-0.214602 + (abs(tmpvar_71) * (0.0865667 + (abs(tmpvar_71) * -0.0310296))))))))) - (sign(tmpvar_72) * (1.5708 - (sqrt((1.0 - abs(tmpvar_72))) * (1.5708 + (abs(tmpvar_72) * (-0.214602 + (abs(tmpvar_72) * (0.0865667 + (abs(tmpvar_72) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_74;
          t_74 = max (min ((dot (tmpvar_66, tmpvar_69) / 0.2), 1.0), 0.0);
          eclipseShadow_53 = (eclipseShadow_53 * (1.0 - ((t_73 * (t_73 * (3.0 - (2.0 * t_73)))) * (t_74 * (t_74 * (3.0 - (2.0 * t_74)))))));
          i_61 = (i_61 + 1);
        };
        j_60 = 0;
        for (int j_60 = 0; j_60 < 4; ) {
          if ((lightOccluders2[3][j_60] <= 0.0)) {
            break;
          };
          highp vec4 v_75;
          v_75.x = lightOccluders2[0][j_60];
          v_75.y = lightOccluders2[1][j_60];
          v_75.z = lightOccluders2[2][j_60];
          v_75.w = lightOccluders2[3][j_60];
          highp vec3 tmpvar_76;
          tmpvar_76 = (sunPosAndRadius.xyz - worldPos_62);
          highp float tmpvar_77;
          tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
          highp vec3 tmpvar_78;
          tmpvar_78 = (tmpvar_76 / vec3(tmpvar_77));
          highp vec3 tmpvar_79;
          tmpvar_79 = (v_75.xyz - worldPos_62);
          highp float tmpvar_80;
          tmpvar_80 = sqrt(dot (tmpvar_79, tmpvar_79));
          highp vec3 tmpvar_81;
          tmpvar_81 = (tmpvar_79 / tmpvar_80);
          highp vec3 tmpvar_82;
          tmpvar_82 = ((tmpvar_78.yzx * tmpvar_81.zxy) - (tmpvar_78.zxy * tmpvar_81.yzx));
          highp float tmpvar_83;
          tmpvar_83 = min (1.0, sqrt(dot (tmpvar_82, tmpvar_82)));
          highp float tmpvar_84;
          tmpvar_84 = min (1.0, (vec3(lightOccluders2[3][j_60]) / tmpvar_80).x);
          highp float t_85;
          t_85 = max (min ((((-((vec3(tmpvar_77) * ((sign(tmpvar_83) * (1.5708 - (sqrt((1.0 - abs(tmpvar_83))) * (1.5708 + (abs(tmpvar_83) * (-0.214602 + (abs(tmpvar_83) * (0.0865667 + (abs(tmpvar_83) * -0.0310296))))))))) - (sign(tmpvar_84) * (1.5708 - (sqrt((1.0 - abs(tmpvar_84))) * (1.5708 + (abs(tmpvar_84) * (-0.214602 + (abs(tmpvar_84) * (0.0865667 + (abs(tmpvar_84) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_86;
          t_86 = max (min ((dot (tmpvar_78, tmpvar_81) / 0.2), 1.0), 0.0);
          eclipseShadow_53 = (eclipseShadow_53 * (1.0 - ((t_85 * (t_85 * (3.0 - (2.0 * t_85)))) * (t_86 * (t_86 * (3.0 - (2.0 * t_86)))))));
          j_60 = (j_60 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_53)));
    };
    highp vec4 tmpvar_87;
    tmpvar_87.w = 1.0;
    tmpvar_87.xyz = extinction_4;
    tmpvar_1 = tmpvar_87;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_ON" }
"!!GLES


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

#ifndef ECLIPSES_ON
    #define ECLIPSES_ON 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#extension GL_EXT_shader_texture_lod : require
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#if defined(SHADER_API_GLES) && defined(SHADER_API_DESKTOP)
vec2 xll_matrixindexdynamic_mf2x2_i (mat2 m, int i) {
 mat2 m2 = xll_transpose(m);
 return i==0?m2[0]:m2[1];
}
vec3 xll_matrixindexdynamic_mf3x3_i (mat3 m, int i) {
 mat3 m2 = xll_transpose(m);
 return i < 2?(i==0?m2[0]:m2[1]):(m2[2]);
}
vec4 xll_matrixindexdynamic_mf4x4_i (mat4 m, int i) {
 mat4 m2 = xll_transpose(m);
 return i < 2?(i==0?m2[0]:m2[1]):(i==3?m2[3]:m2[2]);
}
#else
vec2 xll_matrixindexdynamic_mf2x2_i (mat2 m, int i) { return xll_matrixindex_mf2x2_i (m, i); }
vec3 xll_matrixindexdynamic_mf3x3_i (mat3 m, int i) { return xll_matrixindex_mf3x3_i (m, i); }
vec4 xll_matrixindexdynamic_mf4x4_i (mat4 m, int i) { return xll_matrixindex_mf4x4_i (m, i); }
#endif
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 58
struct v2f {
    highp vec4 pos;
    highp vec3 worldPos;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 38
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform highp float TRANSMITTANCE_W;
#line 42
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
uniform highp float SKY_H;
uniform highp float M_PI;
#line 46
uniform highp vec3 EARTH_POS;
uniform highp float SCALE;
#line 50
uniform highp float HR;
uniform highp vec3 betaR;
#line 54
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 59
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 63
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 67
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
#line 71
uniform highp float _Sun_Intensity;
uniform highp float _experimentalAtmoScale;
#line 75
uniform highp float _viewdirOffset;
#line 85
#line 112
#line 145
#line 161
#line 173
#line 196
#line 218
#line 251
#line 269
#line 284
#line 299
#line 306
#line 366
#line 401
#line 407
#line 479
#line 488
#line 496
#line 504
#line 509
#line 534
#line 38
uniform highp float _Alpha_Global;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp vec3 _Globals_WorldCameraPos;
#line 42
uniform highp vec3 _Globals_Origin;
uniform highp float _Extinction_Tint;
uniform highp float extinctionMultiplier;
uniform highp float extinctionRimFade;
#line 46
uniform highp float extinctionGroundFade;
#line 51
uniform highp vec4 sunPosAndRadius;
uniform highp mat4 lightOccluders1;
uniform highp mat4 lightOccluders2;
#line 65
#line 73
highp float xlat_mutableRt;
#line 284
highp float OpticalDepth( in highp float H, in highp float r, in highp float mu, in highp float d ) {
    highp float a = sqrt(((0.5 / H) * r));
    highp vec2 a01 = (a * vec2( mu, (mu + (d / r))));
    #line 288
    highp vec2 a01s = sign(a01);
    highp vec2 a01sq = (a01 * a01);
    highp float x = (( (a01s.y > a01s.x) ) ? ( exp(a01sq.x) ) : ( 0.0 ));
    highp vec2 y = ((a01s / ((2.3193 * abs(a01)) + sqrt(((1.52 * a01sq) + 4.0)))) * vec2( 1.0, exp((((-d) / H) * ((d / (2.0 * r)) + mu)))));
    #line 292
    return ((sqrt(((6.2831 * H) * r)) * exp(((Rg - r) / H))) * (x + dot( y, vec2( 1.0, -1.0))));
}
#line 299
highp vec3 AnalyticTransmittance( in highp float r, in highp float mu, in highp float d ) {
    return exp((((-betaR) * OpticalDepth( (HR * _experimentalAtmoScale), r, mu, d)) - (betaMEx * OpticalDepth( (HM * _experimentalAtmoScale), r, mu, d))));
}
#line 161
highp float SQRT( in highp float f, in highp float err ) {
    return sqrt(f);
}
#line 131
highp vec3 Transmittance( in highp float r, in highp float mu ) {
    #line 135
    highp float uR;
    highp float uMu;
    uR = sqrt(((r - Rg) / (xlat_mutableRt - Rg)));
    uMu = (atan((((mu + 0.15) / 1.15) * tan(1.5))) / 1.5);
    #line 139
    return xll_tex2Dlod( _Transmittance, vec4( uMu, uR, 0.0, 0.0)).xyz;
}
#line 173
highp float getEclipseShadow( in highp vec3 worldPos, in highp vec3 worldLightPos, in highp vec3 occluderSpherePosition, in highp vec3 occluderSphereRadius, in highp vec3 lightSourceRadius ) {
    highp vec3 lightDirection = (worldLightPos - worldPos);
    highp vec3 lightDistance = vec3( length(lightDirection));
    #line 177
    lightDirection = (lightDirection / lightDistance);
    highp vec3 sphereDirection = (occluderSpherePosition - worldPos);
    #line 181
    highp float sphereDistance = length(sphereDirection);
    sphereDirection = (sphereDirection / sphereDistance);
    highp float dd = float( (lightDistance * (asin(min( 1.0, length(cross( lightDirection, sphereDirection)))) - asin(min( 1.0, float( (occluderSphereRadius / sphereDistance)))))));
    #line 187
    highp float w = smoothstep( -1.0, 1.0, float( ((-dd) / lightSourceRadius)));
    w = (w * smoothstep( 0.0, 0.2, dot( lightDirection, sphereDirection)));
    return (1.0 - w);
}
#line 196
highp float intersectSphere2( in highp vec3 p1, in highp vec3 d, in highp vec3 p3, in highp float r ) {
    #line 200
    highp float a = dot( d, d);
    highp float b = (2.0 * dot( d, (p1 - p3)));
    highp float c = (((dot( p3, p3) + dot( p1, p1)) - (2.0 * dot( p3, p1))) - (r * r));
    highp float test = ((b * b) - ((4.0 * a) * c));
    #line 209
    highp float u = (( (test < 0.0) ) ? ( -1.0 ) : ( (((-b) - sqrt(test)) / (2.0 * a)) ));
    return u;
}
#line 218
highp float intersectSphere4( in highp vec3 p1, in highp vec3 d, in highp vec3 p3, in highp float r ) {
    #line 224
    highp float a = dot( d, d);
    highp float b = (2.0 * dot( d, (p1 - p3)));
    highp float c = (((dot( p3, p3) + dot( p1, p1)) - (2.0 * dot( p3, p1))) - (r * r));
    #line 228
    highp float test = ((b * b) - ((4.0 * a) * c));
    if ((test < 0.0)){
        #line 232
        return -1.0;
    }
    highp float u = (((-b) - sqrt(test)) / (2.0 * a));
    #line 243
    u = (( (u < 0.0) ) ? ( (((-b) + sqrt(test)) / (2.0 * a)) ) : ( u ));
    return u;
}
#line 73
highp vec4 frag( in v2f IN ) {
    highp vec3 extinction = vec3( 1.0, 1.0, 1.0);
    #line 81
    highp vec3 WCP = (_WorldSpaceCameraPos * 6000.0);
    highp vec3 d = normalize((IN.worldPos - _WorldSpaceCameraPos));
    #line 86
    xlat_mutableRt = (Rg + ((xlat_mutableRt - Rg) * _experimentalAtmoScale));
    #line 91
    highp vec3 viewdir = normalize(d);
    highp vec3 camera = (WCP - _Globals_Origin);
    #line 95
    highp float r = length(camera);
    highp float rMu = dot( camera, viewdir);
    highp float mu = (rMu / r);
    highp float r0 = r;
    #line 99
    highp float mu0 = mu;
    highp float deltaSq = SQRT( (((rMu * rMu) - (r * r)) + (xlat_mutableRt * xlat_mutableRt)), 1e-06);
    #line 103
    highp float din = max( ((-rMu) - deltaSq), 0.0);
    if ((din > 0.0)){
        #line 107
        camera += (din * viewdir);
        rMu += din;
        mu = (rMu / xlat_mutableRt);
        r = xlat_mutableRt;
    }
    #line 113
    if ((r > xlat_mutableRt)){
        return vec4( 1.0, 1.0, 1.0, 1.0);
    }
    #line 121
    if ((intersectSphere2( WCP, d, _Globals_Origin, Rg) > 0.0)){
        highp float distInAtmo = (intersectSphere2( WCP, d, _Globals_Origin, Rg) - intersectSphere2( WCP, d, _Globals_Origin, xlat_mutableRt));
        extinction = AnalyticTransmittance( r, mu, distInAtmo);
    }
    else{
        extinction = Transmittance( r, mu);
    }
    #line 135
    highp float average = (((extinction.x + extinction.y) + extinction.z) / 3.0);
    extinction = (extinctionMultiplier * vec3( ((_Extinction_Tint * extinction.x) + ((1.0 - _Extinction_Tint) * average)), ((_Extinction_Tint * extinction.y) + ((1.0 - _Extinction_Tint) * average)), ((_Extinction_Tint * extinction.z) + ((1.0 - _Extinction_Tint) * average))));
    #line 147
    highp float interSectPt = intersectSphere2( WCP, d, _Globals_Origin, Rg);
    bool rightDir = (interSectPt > 0.0);
    if ((!rightDir)){
        #line 152
        extinction = ((vec3( 1.0, 1.0, 1.0) * extinctionRimFade) + ((1.0 - extinctionRimFade) * extinction));
    }
    else{
        #line 159
        highp float eclipseShadow = 1.0;
        highp float eclipseCeiling = xlat_mutableRt;
        #line 163
        highp float height = length((WCP - _Globals_Origin));
        #line 167
        interSectPt = intersectSphere4( WCP, d, _Globals_Origin, eclipseCeiling);
        #line 175
        if ((interSectPt != -1.0)){
            highp vec3 worldPos = (WCP + (d * interSectPt));
            #line 179
            highp int i = 0;
            for ( ; (i < 4); (++i)) {
                if ((lightOccluders1[3][i] <= 0.0)){
                    break;
                }
                eclipseShadow *= getEclipseShadow( worldPos, sunPosAndRadius.xyz, xll_matrixindexdynamic_mf4x4_i (lightOccluders1, i).xyz, vec3( lightOccluders1[3][i]), vec3( sunPosAndRadius.w));
            }
            #line 186
            highp int j = 0;
            for ( ; (j < 4); (++j)) {
                if ((lightOccluders2[3][j] <= 0.0)){
                    break;
                }
                eclipseShadow *= getEclipseShadow( worldPos, sunPosAndRadius.xyz, xll_matrixindexdynamic_mf4x4_i (lightOccluders2, j).xyz, vec3( lightOccluders2[3][j]), vec3( sunPosAndRadius.w));
            }
        }
        #line 194
        extinction *= eclipseShadow;
        extinction = ((vec3( 1.0, 1.0, 1.0) * extinctionGroundFade) + ((1.0 - extinctionGroundFade) * extinction));
    }
    #line 199
    return vec4( extinction, 1.0);
}
varying highp vec3 xlv_TEXCOORD0;
void main() {
    xlat_mutableRt = Rt;
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:0(0): error: no matching function for call to `xll_transpose(mat2)'
0:0(0): error: no matching function for call to `xll_transpose(mat3)'
0:0(0): error: no matching function for call to `xll_transpose(mat4)'
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:62(2): warning: empty declaration
0:65(2): warning: empty declaration
*/


#endif"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
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
in highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float mu_2;
  highp float r_3;
  highp vec3 extinction_4;
  extinction_4 = vec3(1.0, 1.0, 1.0);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos * 6000.0);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_7;
  tmpvar_7 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_5 - _Globals_Origin);
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_8, tmpvar_8));
  r_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (tmpvar_8, normalize(tmpvar_6));
  mu_2 = (tmpvar_10 / tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = max ((-(tmpvar_10) - sqrt((((tmpvar_10 * tmpvar_10) - (tmpvar_9 * tmpvar_9)) + (tmpvar_7 * tmpvar_7)))), 0.0);
  if ((tmpvar_11 > 0.0)) {
    mu_2 = ((tmpvar_10 + tmpvar_11) / tmpvar_7);
    r_3 = tmpvar_7;
  };
  if ((r_3 > tmpvar_7)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_12;
    tmpvar_12 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_13;
    tmpvar_13 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_14;
    tmpvar_14 = ((tmpvar_13 * tmpvar_13) - ((4.0 * tmpvar_12) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_15;
    if ((tmpvar_14 < 0.0)) {
      tmpvar_15 = -1.0;
    } else {
      tmpvar_15 = ((-(tmpvar_13) - sqrt(tmpvar_14)) / (2.0 * tmpvar_12));
    };
    if ((tmpvar_15 > 0.0)) {
      highp float tmpvar_16;
      tmpvar_16 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_17;
      tmpvar_17 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_18;
      tmpvar_18 = ((tmpvar_17 * tmpvar_17) - ((4.0 * tmpvar_16) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
      highp float tmpvar_19;
      if ((tmpvar_18 < 0.0)) {
        tmpvar_19 = -1.0;
      } else {
        tmpvar_19 = ((-(tmpvar_17) - sqrt(tmpvar_18)) / (2.0 * tmpvar_16));
      };
      highp float tmpvar_20;
      tmpvar_20 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_21;
      tmpvar_21 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_22;
      tmpvar_22 = ((tmpvar_21 * tmpvar_21) - ((4.0 * tmpvar_20) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
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
      tmpvar_27.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_28;
      tmpvar_28 = (sqrt(((0.5 / H_26) * r_3)) * tmpvar_27);
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
      tmpvar_32.y = exp(((-(tmpvar_24) / H_26) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      tmpvar_25 = ((sqrt(((6.2831 * H_26) * r_3)) * exp(((Rg - r_3) / H_26))) * (tmpvar_31 + dot (((tmpvar_29 / ((2.3193 * abs(tmpvar_28)) + sqrt(((1.52 * tmpvar_30) + 4.0)))) * tmpvar_32), vec2(1.0, -1.0))));
      highp float H_33;
      H_33 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_34;
      tmpvar_34.x = mu_2;
      tmpvar_34.y = (mu_2 + (tmpvar_24 / r_3));
      highp vec2 tmpvar_35;
      tmpvar_35 = (sqrt(((0.5 / H_33) * r_3)) * tmpvar_34);
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
      tmpvar_39.y = exp(((-(tmpvar_24) / H_33) * ((tmpvar_24 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_25) - (betaMEx * ((sqrt(((6.2831 * H_33) * r_3)) * exp(((Rg - r_3) / H_33))) * (tmpvar_38 + dot (((tmpvar_36 / ((2.3193 * abs(tmpvar_35)) + sqrt(((1.52 * tmpvar_37) + 4.0)))) * tmpvar_39), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_40;
      highp float y_over_x_41;
      y_over_x_41 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_42;
      x_42 = (y_over_x_41 * inversesqrt(((y_over_x_41 * y_over_x_41) + 1.0)));
      highp vec4 tmpvar_43;
      tmpvar_43.zw = vec2(0.0, 0.0);
      tmpvar_43.x = ((sign(x_42) * (1.5708 - (sqrt((1.0 - abs(x_42))) * (1.5708 + (abs(x_42) * (-0.214602 + (abs(x_42) * (0.0865667 + (abs(x_42) * -0.0310296))))))))) / 1.5);
      tmpvar_43.y = sqrt(((r_3 - Rg) / (tmpvar_7 - Rg)));
      lowp vec4 tmpvar_44;
      tmpvar_44 = textureLod (_Transmittance, tmpvar_43.xy, 0.0);
      tmpvar_40 = tmpvar_44.xyz;
      extinction_4 = tmpvar_40;
    };
    highp float tmpvar_45;
    tmpvar_45 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_46;
    tmpvar_46.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    tmpvar_46.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_45));
    highp vec3 tmpvar_47;
    tmpvar_47 = (extinctionMultiplier * tmpvar_46);
    extinction_4 = tmpvar_47;
    highp float tmpvar_48;
    tmpvar_48 = dot (tmpvar_6, tmpvar_6);
    highp float tmpvar_49;
    tmpvar_49 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
    highp float tmpvar_50;
    tmpvar_50 = ((tmpvar_49 * tmpvar_49) - ((4.0 * tmpvar_48) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (Rg * Rg))));
    highp float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = -1.0;
    } else {
      tmpvar_51 = ((-(tmpvar_49) - sqrt(tmpvar_50)) / (2.0 * tmpvar_48));
    };
    bool tmpvar_52;
    tmpvar_52 = (tmpvar_51 > 0.0);
    if (!(tmpvar_52)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_47));
    } else {
      highp float eclipseShadow_53;
      eclipseShadow_53 = 1.0;
      highp float tmpvar_54;
      highp float tmpvar_55;
      tmpvar_55 = dot (tmpvar_6, tmpvar_6);
      highp float tmpvar_56;
      tmpvar_56 = (2.0 * dot (tmpvar_6, (tmpvar_5 - _Globals_Origin)));
      highp float tmpvar_57;
      tmpvar_57 = ((tmpvar_56 * tmpvar_56) - ((4.0 * tmpvar_55) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_5, tmpvar_5)) - (2.0 * dot (_Globals_Origin, tmpvar_5))) - (tmpvar_7 * tmpvar_7))));
      if ((tmpvar_57 < 0.0)) {
        tmpvar_54 = -1.0;
      } else {
        highp float tmpvar_58;
        tmpvar_58 = ((-(tmpvar_56) - sqrt(tmpvar_57)) / (2.0 * tmpvar_55));
        highp float tmpvar_59;
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
        highp vec3 worldPos_62;
        worldPos_62 = (tmpvar_5 + (tmpvar_6 * tmpvar_54));
        i_61 = 0;
        for (int i_61 = 0; i_61 < 4; ) {
          if ((lightOccluders1[3][i_61] <= 0.0)) {
            break;
          };
          highp vec4 v_63;
          v_63.x = lightOccluders1[0][i_61];
          v_63.y = lightOccluders1[1][i_61];
          v_63.z = lightOccluders1[2][i_61];
          v_63.w = lightOccluders1[3][i_61];
          highp vec3 tmpvar_64;
          tmpvar_64 = (sunPosAndRadius.xyz - worldPos_62);
          highp float tmpvar_65;
          tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
          highp vec3 tmpvar_66;
          tmpvar_66 = (tmpvar_64 / vec3(tmpvar_65));
          highp vec3 tmpvar_67;
          tmpvar_67 = (v_63.xyz - worldPos_62);
          highp float tmpvar_68;
          tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
          highp vec3 tmpvar_69;
          tmpvar_69 = (tmpvar_67 / tmpvar_68);
          highp vec3 tmpvar_70;
          tmpvar_70 = ((tmpvar_66.yzx * tmpvar_69.zxy) - (tmpvar_66.zxy * tmpvar_69.yzx));
          highp float tmpvar_71;
          tmpvar_71 = min (1.0, sqrt(dot (tmpvar_70, tmpvar_70)));
          highp float tmpvar_72;
          tmpvar_72 = min (1.0, (vec3(lightOccluders1[3][i_61]) / tmpvar_68).x);
          highp float t_73;
          t_73 = max (min ((((-((vec3(tmpvar_65) * ((sign(tmpvar_71) * (1.5708 - (sqrt((1.0 - abs(tmpvar_71))) * (1.5708 + (abs(tmpvar_71) * (-0.214602 + (abs(tmpvar_71) * (0.0865667 + (abs(tmpvar_71) * -0.0310296))))))))) - (sign(tmpvar_72) * (1.5708 - (sqrt((1.0 - abs(tmpvar_72))) * (1.5708 + (abs(tmpvar_72) * (-0.214602 + (abs(tmpvar_72) * (0.0865667 + (abs(tmpvar_72) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_74;
          t_74 = max (min ((dot (tmpvar_66, tmpvar_69) / 0.2), 1.0), 0.0);
          eclipseShadow_53 = (eclipseShadow_53 * (1.0 - ((t_73 * (t_73 * (3.0 - (2.0 * t_73)))) * (t_74 * (t_74 * (3.0 - (2.0 * t_74)))))));
          i_61 = (i_61 + 1);
        };
        j_60 = 0;
        for (int j_60 = 0; j_60 < 4; ) {
          if ((lightOccluders2[3][j_60] <= 0.0)) {
            break;
          };
          highp vec4 v_75;
          v_75.x = lightOccluders2[0][j_60];
          v_75.y = lightOccluders2[1][j_60];
          v_75.z = lightOccluders2[2][j_60];
          v_75.w = lightOccluders2[3][j_60];
          highp vec3 tmpvar_76;
          tmpvar_76 = (sunPosAndRadius.xyz - worldPos_62);
          highp float tmpvar_77;
          tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
          highp vec3 tmpvar_78;
          tmpvar_78 = (tmpvar_76 / vec3(tmpvar_77));
          highp vec3 tmpvar_79;
          tmpvar_79 = (v_75.xyz - worldPos_62);
          highp float tmpvar_80;
          tmpvar_80 = sqrt(dot (tmpvar_79, tmpvar_79));
          highp vec3 tmpvar_81;
          tmpvar_81 = (tmpvar_79 / tmpvar_80);
          highp vec3 tmpvar_82;
          tmpvar_82 = ((tmpvar_78.yzx * tmpvar_81.zxy) - (tmpvar_78.zxy * tmpvar_81.yzx));
          highp float tmpvar_83;
          tmpvar_83 = min (1.0, sqrt(dot (tmpvar_82, tmpvar_82)));
          highp float tmpvar_84;
          tmpvar_84 = min (1.0, (vec3(lightOccluders2[3][j_60]) / tmpvar_80).x);
          highp float t_85;
          t_85 = max (min ((((-((vec3(tmpvar_77) * ((sign(tmpvar_83) * (1.5708 - (sqrt((1.0 - abs(tmpvar_83))) * (1.5708 + (abs(tmpvar_83) * (-0.214602 + (abs(tmpvar_83) * (0.0865667 + (abs(tmpvar_83) * -0.0310296))))))))) - (sign(tmpvar_84) * (1.5708 - (sqrt((1.0 - abs(tmpvar_84))) * (1.5708 + (abs(tmpvar_84) * (-0.214602 + (abs(tmpvar_84) * (0.0865667 + (abs(tmpvar_84) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_86;
          t_86 = max (min ((dot (tmpvar_78, tmpvar_81) / 0.2), 1.0), 0.0);
          eclipseShadow_53 = (eclipseShadow_53 * (1.0 - ((t_85 * (t_85 * (3.0 - (2.0 * t_85)))) * (t_86 * (t_86 * (3.0 - (2.0 * t_86)))))));
          j_60 = (j_60 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_53)));
    };
    highp vec4 tmpvar_87;
    tmpvar_87.w = 1.0;
    tmpvar_87.xyz = extinction_4;
    tmpvar_1 = tmpvar_87;
  };
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 263 math, 2 textures, 3 branches
Keywords { "ECLIPSES_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Float 1 [HR]
Vector 2 [betaR]
Float 3 [HM]
Vector 4 [betaMEx]
Float 5 [Rg]
Float 6 [Rt]
Float 7 [_experimentalAtmoScale]
Vector 8 [_Globals_Origin]
Float 9 [_Extinction_Tint]
Float 10 [extinctionMultiplier]
Float 11 [extinctionRimFade]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
dcl_2d s0
def c12, 6000.00000000, 0.00000100, 0.00000000, 1.00000000
def c13, 2.00000000, 4.00000000, -1.00000000, 6.28310013
def c14, 2.71828198, 0.50000000, 1.51999998, 4.00000000
def c15, 2.31929994, 1.00000000, -1.00000000, 0.15000001
def c16, 12.26193905, -0.01348047, 0.05747731, -0.12123910
def c17, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c18, 0.66666669, 0.33333334, 0, 0
dcl_texcoord0 v0.xyz
add r2.xyz, v0, -c0
dp3 r1.x, r2, r2
rsq r1.x, r1.x
mul r2.xyz, r1.x, r2
mov r1.xyz, c0
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r1.xyz, c12.x, r1
add r3.xyz, r1, -c8
mul r4.xyz, r1.w, r2
dp3 r1.w, r3, r3
dp3 r3.x, r3, r4
rsq r3.y, r1.w
mov r2.w, c6.x
add r3.z, -c5.x, r2.w
rcp r1.w, r3.y
mul r2.w, r1, r1
mul r3.w, r3.z, c7.x
mad r3.z, r3.x, r3.x, -r2.w
add r2.w, r3, c5.x
mad r3.w, r2, r2, r3.z
rsq r3.z, r3.w
rcp r3.z, r3.z
cmp r3.z, r3.w, r3, c12.y
add r3.z, -r3.x, -r3
max r4.y, r3.z, c12.z
add r4.x, r4.y, r3
cmp r1.w, -r4.y, r1, r2
add r3.z, -r2.w, r1.w
mul r3.x, r3.y, r3
rcp r3.w, r2.w
mul r3.w, r4.x, r3
cmp_pp r3.y, -r3.z, c12.w, c12.z
cmp oC0, -r3.z, r0, c12.w
cmp r3.x, -r4.y, r3, r3.w
if_gt r3.y, c12.z
dp3 r0.y, c8, c8
dp3 r0.x, r1, r1
add r0.x, r0.y, r0
dp3 r0.y, r1, c8
mad r0.x, -r0.y, c13, r0
mad r0.w, -c5.x, c5.x, r0.x
add r0.xyz, r1, -c8
dp3 r3.y, r2, r2
dp3 r0.y, r2, r0
mul r0.w, r3.y, r0
mul r0.x, r0.w, c13.y
mul r0.w, r0.y, c13.x
mad r0.z, r0.w, r0.w, -r0.x
rsq r0.y, r0.z
mul r0.x, r3.y, c13
rcp r0.y, r0.y
rcp r0.x, r0.x
add r0.y, -r0.w, -r0
mul r0.x, r0.y, r0
cmp r0.x, r0.z, r0, c13.z
if_gt r0.x, c12.z
dp3 r0.w, r2, r2
dp3 r0.y, c8, c8
dp3 r0.x, r1, r1
add r0.x, r0.y, r0
dp3 r0.y, r1, c8
mad r3.w, -r0.y, c13.x, r0.x
add r0.xyz, r1, -c8
dp3 r0.x, r2, r0
mad r3.y, -c5.x, c5.x, r3.w
mul r3.y, r0.w, r3
mul r0.x, r0, c13
mul r0.y, r3, c13
mad r3.z, r0.x, r0.x, -r0.y
rsq r0.y, r3.z
rcp r0.z, r0.y
mad r0.y, -r2.w, r2.w, r3.w
add r2.w, -r0.x, -r0.z
mul r0.z, r0.w, c13.x
rcp r3.y, r0.z
mul r0.z, r2.w, r3.y
mul r0.y, r0.w, r0
mul r0.y, r0, c13
mad r0.w, r0.x, r0.x, -r0.y
rsq r0.y, r0.w
cmp r2.w, r3.z, r0.z, c13.z
rcp r0.z, r0.y
add r0.x, -r0, -r0.z
mov r0.y, c3.x
mul r4.y, c7.x, r0
mul r0.x, r3.y, r0
cmp r0.y, r0.w, r0.x, c13.z
add r2.w, r2, -r0.y
rcp r5.x, r4.y
mul r0.x, r1.w, r5
rcp r0.y, r1.w
mul r0.x, r0, c14.y
rsq r0.x, r0.x
rcp r0.z, r0.x
mad r0.y, r2.w, r0, r3.x
mov r0.x, r3
mul r3.zw, r0.xyxy, r0.z
mul r4.zw, r3, r3
cmp r5.zw, -r3, c12.z, c12.w
cmp r0.zw, r3, c12.z, c12.w
add r0.zw, r5, -r0
mad r5.zw, r4, c14.z, c14.w
rsq r4.x, r5.z
rsq r3.y, r5.w
rcp r5.w, r3.y
abs r3.zw, r3
rcp r5.z, r4.x
mad r5.zw, r3, c15.x, r5
mul r3.y, r1.w, c13.x
rcp r3.z, r3.y
mad r4.x, r2.w, r3.z, r3
mul r3.y, -r2.w, r5.x
mul r4.w, r4.x, r3.y
pow r3, c14.x, r4.w
rcp r5.z, r5.z
rcp r5.w, r5.w
mul r3.zw, r0, r5
mov r3.x, c12.w
mul r3.xy, r3.zwzw, r3
mul r5.zw, r3.xyxy, c15.xyyz
pow r3, c14.x, r4.z
add r3.y, r5.z, r5.w
add r3.z, r0.w, -r0
add r0.w, -r1, c5.x
mov r0.z, r3.x
cmp r0.z, -r3, c12, r0
mul r4.z, r0.w, r5.x
add r0.z, r0, r3.y
pow r3, c14.x, r4.z
mov r3.y, c1.x
mul r3.z, c7.x, r3.y
rcp r3.w, r3.z
mul r3.y, r1.w, r4
mul r4.y, r1.w, r3.w
mul r2.w, r3, -r2
mul r3.y, r3, c13.w
mul r4.y, r4, c14
rsq r3.y, r3.y
rcp r3.y, r3.y
mul r3.x, r3.y, r3
rsq r4.y, r4.y
rcp r3.y, r4.y
mul r4.zw, r3.y, r0.xyxy
mul r0.z, r3.x, r0
mul r2.w, r2, r4.x
mul r0.w, r0, r3
cmp r5.xy, -r4.zwzw, c12.z, c12.w
cmp r3.xy, r4.zwzw, c12.z, c12.w
add r3.xy, r5, -r3
mul r5.xy, r4.zwzw, r4.zwzw
mad r5.zw, r5.xyxy, c14.z, c14.w
rsq r4.y, r5.w
rsq r5.y, r5.z
mul r1.w, r3.z, r1
abs r4.zw, r4
rcp r5.w, r4.y
rcp r5.z, r5.y
mad r5.zw, r4, c15.x, r5
pow r4, c14.x, r2.w
rcp r5.z, r5.z
rcp r5.w, r5.w
mul r4.zw, r3.xyxy, r5
mov r4.x, c12.w
mul r5.zw, r4, r4.xyxy
pow r4, c14.x, r5.x
mul r4.zw, r5, c15.xyyz
add r3.x, r3.y, -r3
cmp r3.x, -r3, c12.z, r4
add r2.w, r4.z, r4
add r2.w, r3.x, r2
pow r3, c14.x, r0.w
mul r0.w, r1, c13
rsq r1.w, r0.w
mov r0.w, r3.x
rcp r1.w, r1.w
mul r0.w, r1, r0
mul r0.xyz, r0.z, c4
mul r0.w, r0, r2
mad r0.xyz, r0.w, -c2, -r0
pow r3, c14.x, r0.x
pow r4, c14.x, r0.z
mov r0.x, r3
pow r3, c14.x, r0.y
mov r0.y, r3
mov r0.z, r4
else
add r0.x, r3, c15.w
mul r0.x, r0, c16
abs r3.x, r0
max r0.y, r3.x, c12.w
min r0.z, r3.x, c12.w
rcp r0.y, r0.y
mul r0.w, r0.z, r0.y
mul r0.z, r0.w, r0.w
mad r0.y, r0.z, c16, c16.z
mad r0.y, r0, r0.z, c16.w
mad r0.y, r0, r0.z, c17.x
mad r0.y, r0, r0.z, c17
mad r0.y, r0, r0.z, c17.z
mul r0.z, r0.y, r0.w
add r0.y, -r0.z, c17.w
add r0.w, r3.x, c13.z
cmp r0.z, -r0.w, r0, r0.y
cmp r0.z, r0.x, r0, -r0
add r0.y, r2.w, -c5.x
rcp r0.x, r0.y
add r0.y, r1.w, -c5.x
mul r0.x, r0.y, r0
rsq r0.x, r0.x
mul r3.x, r0.z, c18
mov r3.z, c12
rcp r3.y, r0.x
texldl r0.xyz, r3.xyzz, s0
endif
dp3 r0.w, r1, r1
dp3 r1.w, c8, c8
add r0.w, r1, r0
dp3 r1.w, r1, c8
mad r0.w, -r1, c13.x, r0
add r1.xyz, r1, -c8
dp3 r1.x, r2, r1
mul r1.z, r1.x, c13.x
dp3 r1.w, r2, r2
mad r0.w, -c5.x, c5.x, r0
mul r0.w, r1, r0
mul r0.w, r0, c13.y
mad r1.y, r1.z, r1.z, -r0.w
rsq r1.x, r1.y
mul r0.w, r1, c13.x
rcp r1.x, r1.x
rcp r0.w, r0.w
add r1.x, -r1.z, -r1
mul r1.x, r1, r0.w
cmp r1.y, r1, r1.x, c13.z
add r0.w, r0.x, r0.y
add r0.w, r0.z, r0
mov r1.x, c9
add r1.x, c12.w, -r1
mul r0.w, r0, c18.y
mul r0.w, r1.x, r0
mad r0.xyz, r0, c9.x, r0.w
cmp r1.w, -r1.y, c12.z, c12
mul r1.xyz, r0, c10.x
mov r0.w, c11.x
add r0.x, c12.w, -r0.w
mad r0.xyz, r0.x, r1, c11.x
abs_pp r0.w, r1
cmp oC0.xyz, -r0.w, r0, r1
mov oC0.w, c12
endif
"
}
SubProgram "d3d11 " {
// Stats: 152 math, 4 branches
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 352
Float 52 [HR]
Vector 64 [betaR] 3
Float 76 [HM]
Vector 96 [betaMEx] 3
Float 116 [Rg]
Float 120 [Rt]
Float 164 [_experimentalAtmoScale]
Vector 320 [_Globals_Origin] 3
Float 332 [_Extinction_Tint]
Float 336 [extinctionMultiplier]
Float 340 [extinctionRimFade]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpcblgcmflhfjakchphalgjkpbphgbmmkabaaaaaacebfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgebeaaaa
eaaaaaaabjafaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaaabaaaaaaegbcbaaa
abaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
aaaaaaakicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaa
aaaaaaaaahaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaa
aaaaaaaaakaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaaphcaabaaaadaaaaaa
egiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaa
egiccaiaebaaaaaaaaaaaaaabeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
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
abaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaabeaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaabaaaaaaibcaabaaaaaaaaaaa
egiccaaaaaaaaaaabeaaaaaaegacbaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
akaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaeabkaabaaaabaaaaaadcaaaaam
ccaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaaakaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaaakaabaaaabaaaaaa
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
aaaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaakaaaaaaaoaaaaah
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
adaaaaaabkiacaaaaaaaaaaaahaaaaaaaoaaaaahecaabaaaaaaaaaaabkaabaaa
acaaaaaackaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
abeaaaaadlkklidpbjaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaaapaaaaakbcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadiaaaaah
ecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadiaaaaajicaabaaa
aaaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaaaaaaaaaaakaaaaaaaoaaaaah
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
aaaaaaaaagaaaaaadcaaaaamncaabaaaaaaaaaaaagijcaiaebaaaaaaaaaaaaaa
aeaaaaaakgakbaaaaaaaaaaaagajbaiaebaaaaaaabaaaaaadiaaaaakncaabaaa
aaaaaaaaagaobaaaaaaaaaaaaceaaaaadlkklidpaaaaaaaadlkklidpdlkklidp
bjaaaaafhcaabaaaacaaaaaaigadbaaaaaaaaaaabcaaaaabaaaaaaajbcaabaaa
aaaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaaaoaaaaah
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
aaaaaaaadkiacaiaebaaaaaaaaaaaaaabeaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaakncaabaaa
aaaaaaaapgipcaaaaaaaaaaabeaaaaaaagajbaaaacaaaaaaagaabaaaaaaaaaaa
diaaaaaincaabaaaaaaaaaaaagaobaaaaaaaaaaaagiacaaaaaaaaaaabfaaaaaa
bnaaaaahccaabaaaaaaaaaaaabeaaaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabfaaaaaaabeaaaaaaaaaiadp
dcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaaigadbaaaaaaaaaaafgifcaaa
aaaaaaaabfaaaaaadhaaaaajhccabaaaaaaaaaaafgafbaaaaaaaaaaaegacbaaa
abaaaaaaigadbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 724 math, 2 textures, 20 branches
Keywords { "ECLIPSES_ON" }
Matrix 0 [lightOccluders1]
Matrix 4 [lightOccluders2]
Vector 8 [_WorldSpaceCameraPos]
Float 9 [HR]
Vector 10 [betaR]
Float 11 [HM]
Vector 12 [betaMEx]
Float 13 [Rg]
Float 14 [Rt]
Float 15 [_experimentalAtmoScale]
Vector 16 [_Globals_Origin]
Float 17 [_Extinction_Tint]
Float 18 [extinctionMultiplier]
Float 19 [extinctionRimFade]
Float 20 [extinctionGroundFade]
Vector 21 [sunPosAndRadius]
SetTexture 0 [_Transmittance] 2D 0
"ps_3_0
dcl_2d s0
def c22, 6000.00000000, 0.00000100, 0.00000000, 1.00000000
def c23, 2.00000000, 4.00000000, -1.00000000, 6.28310013
def c24, 2.71828198, 0.50000000, 1.51999998, 4.00000000
def c25, 2.31929994, 1.00000000, -1.00000000, 0.15000001
def c26, 12.26193905, -0.01348047, 0.05747731, -0.12123910
def c27, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c28, 0.66666669, 0.33333334, -1.00000000, 0.00000000
def c29, 0.00000000, 2.00000000, -0.01872930, 0.07426100
def c30, -0.21211439, 1.57072902, 2.00000000, 3.00000000
def c31, 5.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
add r1.xyz, v0, -c8
dp3 r2.x, r1, r1
rsq r2.x, r2.x
mul r2.xyz, r2.x, r1
mov r1.xyz, c8
dp3 r2.w, r2, r2
rsq r2.w, r2.w
mul r1.xyz, c22.x, r1
mul r4.xyz, r2.w, r2
add r3.xyz, r1, -c16
dp3 r2.w, r3, r3
dp3 r3.x, r3, r4
rsq r3.y, r2.w
rcp r3.z, r3.y
mul r3.w, r3.z, r3.z
mov r2.w, c14.x
add r2.w, -c13.x, r2
mul r2.w, r2, c15.x
add r2.w, r2, c13.x
mad r3.w, r3.x, r3.x, -r3
mad r3.w, r2, r2, r3
rsq r4.x, r3.w
rcp r4.x, r4.x
cmp r3.w, r3, r4.x, c22.y
add r3.w, -r3.x, -r3
max r4.x, r3.w, c22.z
cmp r3.w, -r4.x, r3.z, r2
add r4.z, -r2.w, r3.w
add r3.z, r4.x, r3.x
rcp r4.y, r2.w
mul r3.x, r3.y, r3
mul r3.z, r3, r4.y
cmp r6.x, -r4, r3, r3.z
cmp_pp r3.x, -r4.z, c22.w, c22.z
cmp oC0, -r4.z, r0, c22.w
if_gt r3.x, c22.z
dp3 r0.x, c16, c16
dp3 r0.y, r1, r1
add r0.y, r0.x, r0
dp3 r0.x, r1, c16
mad r0.x, -r0, c23, r0.y
mad r3.x, -c13, c13, r0
add r0.xyz, r1, -c16
dp3 r0.x, r2, r0
dp3 r0.w, r2, r2
mul r3.x, r0.w, r3
mul r0.w, r0, c23.x
mul r0.x, r0, c23
mul r0.y, r3.x, c23
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
rcp r0.w, r0.w
add r0.x, -r0, -r0.z
mul r0.x, r0, r0.w
cmp r0.x, r0.y, r0, c23.z
if_gt r0.x, c22.z
dp3 r0.w, r2, r2
dp3 r0.x, c16, c16
dp3 r0.y, r1, r1
add r0.y, r0.x, r0
dp3 r0.x, r1, c16
mad r3.x, -r0, c23, r0.y
mad r3.y, -c13.x, c13.x, r3.x
add r0.xyz, r1, -c16
dp3 r0.x, r2, r0
mul r3.y, r0.w, r3
mad r3.x, -r2.w, r2.w, r3
mul r3.x, r0.w, r3
mul r0.w, r0, c23.x
mul r0.x, r0, c23
mul r0.y, r3, c23
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
mul r3.x, r3, c23.y
mad r3.x, r0, r0, -r3
rcp r0.w, r0.w
add r0.z, -r0.x, -r0
mul r0.z, r0, r0.w
cmp r0.y, r0, r0.z, c23.z
rsq r3.y, r3.x
rcp r0.z, r3.y
add r0.x, -r0, -r0.z
mov r3.y, c11.x
mul r3.z, c15.x, r3.y
rcp r5.y, r3.z
mul r0.x, r0.w, r0
cmp r0.x, r3, r0, c23.z
add r5.x, r0.y, -r0
mul r0.z, r3.w, r5.y
rcp r0.x, r3.w
mul r0.y, r0.z, c24
mad r3.y, r5.x, r0.x, r6.x
rsq r0.y, r0.y
mov r3.x, r6
rcp r0.x, r0.y
mul r0.xy, r3, r0.x
mul r5.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c22.z, c22.w
cmp r4.xy, r0, c22.z, c22.w
add r4.xy, r0.zwzw, -r4
mad r0.zw, r5, c24.z, c24.w
rsq r0.z, r0.z
rsq r0.w, r0.w
abs r0.xy, r0
mul r5.w, r3, c23.x
rcp r0.z, r0.z
rcp r0.w, r0.w
mad r4.zw, r0.xyxy, c25.x, r0
rcp r0.x, r5.w
mad r6.y, r5.x, r0.x, r6.x
mul r0.y, -r5.x, r5
mul r5.w, r6.y, r0.y
pow r0, c24.x, r5.w
rcp r4.z, r4.z
rcp r4.w, r4.w
mul r0.zw, r4.xyxy, r4
mov r0.x, c22.w
mul r0.xy, r0.zwzw, r0
mul r4.zw, r0.xyxy, c25.xyyz
pow r0, c24.x, r5.z
add r0.z, r4, r4.w
add r0.y, r4, -r4.x
add r5.z, -r3.w, c13.x
cmp r0.x, -r0.y, c22.z, r0
mul r4.y, r5.z, r5
add r4.x, r0, r0.z
pow r0, c24.x, r4.y
mov r0.y, c9.x
mul r5.w, c15.x, r0.y
rcp r6.x, r5.w
mul r0.z, r3.w, r3
mul r0.y, r3.w, r6.x
mul r0.z, r0, c23.w
mul r0.y, r0, c24
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.xy, r0.x, r3
mul r0.z, r0, r4.x
mul r3.xyz, r0.z, c12
mul r4.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c22.z, c22.w
cmp r4.xy, r0, c22.z, c22.w
add r4.xy, r0.zwzw, -r4
mad r0.zw, r4, c24.z, c24.w
mul r6.z, r6.x, -r5.x
rsq r0.w, r0.w
rsq r0.z, r0.z
abs r0.xy, r0
rcp r0.w, r0.w
rcp r0.z, r0.z
mad r5.xy, r0, c25.x, r0.zwzw
mul r4.w, r6.z, r6.y
pow r0, c24.x, r4.w
rcp r5.x, r5.x
rcp r5.y, r5.y
mul r0.zw, r4.xyxy, r5.xyxy
mov r0.x, c22.w
mul r5.xy, r0.zwzw, r0
pow r0, c24.x, r4.z
mul r0.zw, r5.xyxy, c25.xyyz
mov r0.y, r0.x
add r0.x, r4.y, -r4
add r0.z, r0, r0.w
cmp r0.x, -r0, c22.z, r0.y
add r4.x, r0, r0.z
mul r4.y, r5.z, r6.x
pow r0, c24.x, r4.y
mul r3.w, r5, r3
mul r0.y, r3.w, c23.w
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r0.x, r0, r4
mad r3.xyz, r0.x, -c10, -r3
pow r0, c24.x, r3.x
pow r4, c24.x, r3.z
mov r3.x, r0
pow r0, c24.x, r3.y
mov r3.y, r0
mov r3.z, r4
else
add r0.x, r6, c25.w
mul r0.x, r0, c26
abs r0.y, r0.x
max r0.z, r0.y, c22.w
rcp r0.w, r0.z
min r0.z, r0.y, c22.w
mul r0.z, r0, r0.w
mul r0.w, r0.z, r0.z
mad r3.x, r0.w, c26.y, c26.z
mad r3.x, r3, r0.w, c26.w
mad r3.x, r3, r0.w, c27
mad r3.x, r3, r0.w, c27.y
mad r0.w, r3.x, r0, c27.z
mul r0.z, r0.w, r0
add r0.w, -r0.z, c27
add r0.y, r0, c23.z
cmp r0.y, -r0, r0.z, r0.w
cmp r0.x, r0, r0.y, -r0.y
add r0.z, r2.w, -c13.x
rcp r0.z, r0.z
add r0.y, r3.w, -c13.x
mul r0.y, r0, r0.z
rsq r0.y, r0.y
mul r0.x, r0, c28
mov r0.z, c22
rcp r0.y, r0.y
texldl r3.xyz, r0.xyzz, s0
endif
dp3 r0.x, c16, c16
dp3 r0.y, r1, r1
add r0.y, r0.x, r0
dp3 r0.x, r1, c16
mad r0.x, -r0, c23, r0.y
mad r3.w, -c13.x, c13.x, r0.x
add r0.xyz, r1, -c16
dp3 r0.x, r2, r0
dp3 r0.w, r2, r2
mul r3.w, r0, r3
mul r0.w, r0, c23.x
mul r0.y, r0.x, c23.x
mul r0.z, r3.w, c23.y
mad r0.x, r0.y, r0.y, -r0.z
rsq r0.z, r0.x
rcp r0.z, r0.z
add r0.z, -r0.y, -r0
rcp r0.w, r0.w
mul r0.w, r0.z, r0
add r0.y, r3.x, r3
add r0.z, r3, r0.y
cmp r0.w, r0.x, r0, c23.z
mov r0.y, c17.x
mul r0.z, r0, c28.y
add r0.y, c22.w, -r0
mul r0.y, r0, r0.z
mad r0.xyz, r3, c17.x, r0.y
cmp r0.w, -r0, c22.z, c22
mul r3.xyz, r0, c18.x
if_eq r0.w, c22.z
mov r0.x, c19
add r0.x, c22.w, -r0
mad r3.xyz, r0.x, r3, c19.x
else
dp3 r0.x, c16, c16
dp3 r0.y, r1, r1
add r0.y, r0.x, r0
dp3 r0.x, r1, c16
mad r0.x, -r0, c23, r0.y
mad r2.w, -r2, r2, r0.x
add r0.xyz, r1, -c16
dp3 r0.x, r2, r0
dp3 r0.w, r2, r2
mul r2.w, r0, r2
mul r0.x, r0, c23
mul r0.y, r2.w, c23
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
add r2.w, -r0.x, -r0.z
mul r0.w, r0, c23.x
add r0.z, -r0.x, r0
rcp r0.x, r0.w
mul r0.z, r0.x, r0
mul r0.x, r2.w, r0
cmp r0.w, r0.x, r0.x, r0.z
cmp_pp r0.x, r0.y, c22.w, c22.z
cmp r0.z, r0.y, r1.w, c23
cmp r1.w, -r0.x, r0.z, r0
mov r0.w, c22
if_ne r1.w, c23.z
mov_pp r0.x, c0.w
cmp_pp r2.w, -r0.x, c28.z, c28
mad r1.xyz, r2, r1.w, r1
if_eq r2.w, c22.z
add r2.xyz, -r1, c0
add r0.xyz, -r1, c21
dp3 r1.w, r2, r2
dp3 r0.w, r0, r0
rsq r1.w, r1.w
mul r2.xyz, r1.w, r2
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r3.w, r4, r4
dp3 r0.y, r0, r2
rsq r3.w, r3.w
rcp r3.w, r3.w
min r3.w, r3, c22
abs r4.x, r3.w
mad r4.y, r4.x, c29.z, c29.w
mad r4.z, r4.x, r4.y, c30.x
mul r1.w, r1, c0
add r4.y, -r4.x, c22.w
mad r4.z, r4.x, r4, c30.y
rsq r4.x, r4.y
min r1.w, r1, c22
abs r4.y, r1.w
mad r4.w, r4.y, c29.z, c29
mad r4.w, r4.y, r4, c30.x
rcp r4.x, r4.x
mad r4.x, -r4, r4.z, c27.w
add r4.z, -r4.y, c22.w
mul_sat r0.z, r0.y, c31.x
cmp r3.w, r3, c29.x, c29.y
mad r4.w, r4.y, r4, c30.y
rsq r4.z, r4.z
rcp r4.y, r4.z
cmp r1.w, r1, c29.x, c29.y
mad r4.y, -r4, r4.w, c27.w
mad r4.y, -r1.w, r4, r4
mad r1.w, -r3, r4.x, r4.x
add r1.w, r1, -r4.y
rcp r0.w, r0.w
rcp r3.w, c21.w
mul r0.w, r0, r1
mad r0.w, -r0, r3, c22
mul_sat r0.w, r0, c24.y
mul r0.x, r0.w, r0.w
mad r0.y, -r0.w, c30.z, c30.w
mad r0.w, -r0.z, c30.z, c30
mul r0.z, r0, r0
mul r0.z, r0, r0.w
mul r0.x, r0, r0.y
mad r0.w, -r0.x, r0.z, c22
endif
if_ge r2.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r2.w, -c1, r0.x, r2
if_eq r2.w, c22.z
add r2.xyz, -r1, c1
add r0.xyz, -r1, c21
dp3 r3.w, r2, r2
dp3 r1.w, r0, r0
rsq r3.w, r3.w
mul r2.xyz, r3.w, r2
rsq r1.w, r1.w
mul r0.xyz, r1.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.y, r0, r2
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.w
abs r4.y, r4.x
mad r4.z, r4.y, c29, c29.w
mad r4.w, r4.y, r4.z, c30.x
mul r3.w, r3, c1
add r4.z, -r4.y, c22.w
mad r4.w, r4.y, r4, c30.y
rsq r4.y, r4.z
min r3.w, r3, c22
abs r4.z, r3.w
mad r5.x, r4.z, c29.z, c29.w
mad r5.x, r4.z, r5, c30
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.w
add r4.w, -r4.z, c22
mul_sat r0.z, r0.y, c31.x
cmp r4.x, r4, c29, c29.y
mad r5.x, r4.z, r5, c30.y
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c29.x, c29.y
mad r4.z, -r4, r5.x, c27.w
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r1.w, r1.w
rcp r4.x, c21.w
mul r1.w, r1, r3
mad r1.w, -r1, r4.x, c22
mul_sat r1.w, r1, c24.y
mul r0.x, r1.w, r1.w
mad r0.y, -r1.w, c30.z, c30.w
mad r1.w, -r0.z, c30.z, c30
mul r0.z, r0, r0
mul r0.z, r0, r1.w
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
if_ge r2.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r2.w, -c2, r0.x, r2
if_eq r2.w, c22.z
add r2.xyz, -r1, c2
add r0.xyz, -r1, c21
dp3 r3.w, r2, r2
dp3 r1.w, r0, r0
rsq r3.w, r3.w
mul r2.xyz, r3.w, r2
rsq r1.w, r1.w
mul r0.xyz, r1.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.y, r0, r2
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.w
abs r4.y, r4.x
mad r4.z, r4.y, c29, c29.w
mad r4.w, r4.y, r4.z, c30.x
mul r3.w, r3, c2
add r4.z, -r4.y, c22.w
mad r4.w, r4.y, r4, c30.y
rsq r4.y, r4.z
min r3.w, r3, c22
abs r4.z, r3.w
mad r5.x, r4.z, c29.z, c29.w
mad r5.x, r4.z, r5, c30
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.w
add r4.w, -r4.z, c22
mul_sat r0.z, r0.y, c31.x
cmp r4.x, r4, c29, c29.y
mad r5.x, r4.z, r5, c30.y
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c29.x, c29.y
mad r4.z, -r4, r5.x, c27.w
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r1.w, r1.w
rcp r4.x, c21.w
mul r1.w, r1, r3
mad r1.w, -r1, r4.x, c22
mul_sat r1.w, r1, c24.y
mul r0.x, r1.w, r1.w
mad r0.y, -r1.w, c30.z, c30.w
mad r1.w, -r0.z, c30.z, c30
mul r0.z, r0, r0
mul r0.z, r0, r1.w
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
if_ge r2.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r0.x, -c3.w, r0, r2.w
if_eq r0.x, c22.z
add r2.xyz, -r1, c3
add r0.xyz, -r1, c21
dp3 r2.w, r2, r2
dp3 r1.w, r0, r0
rsq r2.w, r2.w
mul r2.xyz, r2.w, r2
rsq r1.w, r1.w
mul r0.xyz, r1.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r3.w, r4, r4
dp3 r0.y, r0, r2
rsq r3.w, r3.w
rcp r3.w, r3.w
min r3.w, r3, c22
abs r4.x, r3.w
mad r4.y, r4.x, c29.z, c29.w
mad r4.z, r4.x, r4.y, c30.x
mul r2.w, r2, c3
add r4.y, -r4.x, c22.w
mad r4.z, r4.x, r4, c30.y
rsq r4.x, r4.y
min r2.w, r2, c22
abs r4.y, r2.w
mad r4.w, r4.y, c29.z, c29
mad r4.w, r4.y, r4, c30.x
rcp r4.x, r4.x
mad r4.x, -r4, r4.z, c27.w
add r4.z, -r4.y, c22.w
mul_sat r0.z, r0.y, c31.x
cmp r3.w, r3, c29.x, c29.y
mad r4.w, r4.y, r4, c30.y
rsq r4.z, r4.z
rcp r4.y, r4.z
cmp r2.w, r2, c29.x, c29.y
mad r4.y, -r4, r4.w, c27.w
mad r4.y, -r2.w, r4, r4
mad r2.w, -r3, r4.x, r4.x
add r2.w, r2, -r4.y
rcp r1.w, r1.w
rcp r3.w, c21.w
mul r1.w, r1, r2
mad r1.w, -r1, r3, c22
mul_sat r1.w, r1, c24.y
mul r0.x, r1.w, r1.w
mad r0.y, -r1.w, c30.z, c30.w
mad r1.w, -r0.z, c30.z, c30
mul r0.z, r0, r0
mul r0.z, r0, r1.w
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
endif
endif
endif
mov_pp r0.x, c4.w
cmp_pp r1.w, -r0.x, c28.z, c28
if_eq r1.w, c22.z
add r2.xyz, -r1, c4
add r0.xyz, -r1, c21
dp3 r3.w, r2, r2
dp3 r2.w, r0, r0
rsq r3.w, r3.w
mul r2.xyz, r3.w, r2
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.y, r0, r2
mul_sat r0.z, r0.y, c31.x
mad r2.x, -r0.z, c30.z, c30.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.w
abs r4.y, r4.x
mad r4.z, r4.y, c29, c29.w
mad r4.w, r4.y, r4.z, c30.x
mul r3.w, r3, c4
mul r0.z, r0, r0
add r4.z, -r4.y, c22.w
mad r4.w, r4.y, r4, c30.y
rsq r4.y, r4.z
min r3.w, r3, c22
abs r4.z, r3.w
mad r5.x, r4.z, c29.z, c29.w
mad r5.x, r4.z, r5, c30
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.w
add r4.w, -r4.z, c22
cmp r4.x, r4, c29, c29.y
mad r5.x, r4.z, r5, c30.y
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c29.x, c29.y
mad r4.z, -r4, r5.x, c27.w
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22
mul_sat r2.w, r2, c24.y
mul r0.x, r2.w, r2.w
mad r0.y, -r2.w, c30.z, c30.w
mul r0.z, r0, r2.x
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
if_ge r1.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r1.w, -c5, r0.x, r1
if_eq r1.w, c22.z
add r2.xyz, -r1, c5
add r0.xyz, -r1, c21
dp3 r3.w, r2, r2
dp3 r2.w, r0, r0
rsq r3.w, r3.w
mul r2.xyz, r3.w, r2
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.y, r0, r2
mul_sat r0.z, r0.y, c31.x
mad r2.x, -r0.z, c30.z, c30.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.w
abs r4.y, r4.x
mad r4.z, r4.y, c29, c29.w
mad r4.w, r4.y, r4.z, c30.x
mul r3.w, r3, c5
mul r0.z, r0, r0
add r4.z, -r4.y, c22.w
mad r4.w, r4.y, r4, c30.y
rsq r4.y, r4.z
min r3.w, r3, c22
abs r4.z, r3.w
mad r5.x, r4.z, c29.z, c29.w
mad r5.x, r4.z, r5, c30
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.w
add r4.w, -r4.z, c22
cmp r4.x, r4, c29, c29.y
mad r5.x, r4.z, r5, c30.y
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c29.x, c29.y
mad r4.z, -r4, r5.x, c27.w
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22
mul_sat r2.w, r2, c24.y
mul r0.x, r2.w, r2.w
mad r0.y, -r2.w, c30.z, c30.w
mul r0.z, r0, r2.x
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
if_ge r1.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r1.w, -c6, r0.x, r1
if_eq r1.w, c22.z
add r2.xyz, -r1, c6
add r0.xyz, -r1, c21
dp3 r3.w, r2, r2
dp3 r2.w, r0, r0
rsq r3.w, r3.w
mul r2.xyz, r3.w, r2
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mul r4.xyz, r0.zxyw, r2.yzxw
mad r4.xyz, r0.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.y, r0, r2
mul_sat r0.z, r0.y, c31.x
mad r2.x, -r0.z, c30.z, c30.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.w
abs r4.y, r4.x
mad r4.z, r4.y, c29, c29.w
mad r4.w, r4.y, r4.z, c30.x
mul r3.w, r3, c6
mul r0.z, r0, r0
add r4.z, -r4.y, c22.w
mad r4.w, r4.y, r4, c30.y
rsq r4.y, r4.z
min r3.w, r3, c22
abs r4.z, r3.w
mad r5.x, r4.z, c29.z, c29.w
mad r5.x, r4.z, r5, c30
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.w
add r4.w, -r4.z, c22
cmp r4.x, r4, c29, c29.y
mad r5.x, r4.z, r5, c30.y
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c29.x, c29.y
mad r4.z, -r4, r5.x, c27.w
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22
mul_sat r2.w, r2, c24.y
mul r0.x, r2.w, r2.w
mad r0.y, -r2.w, c30.z, c30.w
mul r0.z, r0, r2.x
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
if_ge r1.w, c22.z
mov_pp r0.x, c23.z
cmp_pp r0.x, -c7.w, r0, r1.w
if_eq r0.x, c22.z
add r0.xyz, -r1, c7
dp3 r2.x, r0, r0
rsq r2.w, r2.x
mul r0.xyz, r2.w, r0
add r1.xyz, -r1, c21
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
mul r2.xyz, r1.zxyw, r0.yzxw
mad r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3 r2.x, r2, r2
dp3 r0.y, r1, r0
mul_sat r0.z, r0.y, c31.x
mad r1.x, -r0.z, c30.z, c30.w
rsq r2.x, r2.x
rcp r2.x, r2.x
min r2.z, r2.x, c22.w
abs r2.x, r2.z
mad r2.y, r2.x, c29.z, c29.w
mad r3.w, r2.x, r2.y, c30.x
mul r0.z, r0, r0
add r2.y, -r2.x, c22.w
mad r3.w, r2.x, r3, c30.y
rsq r2.x, r2.y
rcp r2.y, r2.x
mul r2.w, r2, c7
min r2.x, r2.w, c22.w
abs r2.w, r2.x
mad r2.y, -r2, r3.w, c27.w
mad r4.x, r2.w, c29.z, c29.w
add r3.w, -r2, c22
mad r4.x, r2.w, r4, c30
mad r4.x, r2.w, r4, c30.y
rsq r3.w, r3.w
rcp r2.w, r3.w
cmp r2.x, r2, c29, c29.y
mad r2.w, -r2, r4.x, c27
mad r2.w, -r2.x, r2, r2
cmp r2.z, r2, c29.x, c29.y
mad r2.x, -r2.z, r2.y, r2.y
add r2.x, r2, -r2.w
rcp r1.w, r1.w
rcp r2.y, c21.w
mul r1.w, r1, r2.x
mad r1.w, -r1, r2.y, c22
mul_sat r1.w, r1, c24.y
mul r0.x, r1.w, r1.w
mad r0.y, -r1.w, c30.z, c30.w
mul r0.z, r0, r1.x
mul r0.x, r0, r0.y
mad r0.x, -r0, r0.z, c22.w
mul r0.w, r0, r0.x
endif
endif
endif
endif
endif
mov r0.x, c20
mul r1.xyz, r3, r0.w
add r0.x, c22.w, -r0
mad r3.xyz, r0.x, r1, c20.x
endif
mov oC0.xyz, r3
mov oC0.w, c22
endif
"
}
SubProgram "d3d11 " {
// Stats: 270 math, 14 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Transmittance] 2D 0
ConstBuffer "$Globals" 496
Matrix 368 [lightOccluders1]
Matrix 432 [lightOccluders2]
Float 52 [HR]
Vector 64 [betaR] 3
Float 76 [HM]
Vector 96 [betaMEx] 3
Float 116 [Rg]
Float 120 [Rt]
Float 164 [_experimentalAtmoScale]
Vector 320 [_Globals_Origin] 3
Float 332 [_Extinction_Tint]
Float 336 [extinctionMultiplier]
Float 340 [extinctionRimFade]
Float 344 [extinctionGroundFade]
Vector 352 [sunPosAndRadius]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedfimfgoebdnenmjefgmnnamgjhnmjnbnfabaaaaaapaceaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaceaaaa
eaaaaaaaamajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaabpaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacajaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaakicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaa
ahaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaakaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaap
hcaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallef
aaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabeaaaaaabaaaaaahicaabaaa
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
baaaaaajicaabaaaacaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaa
beaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaabaaaaaai
icaabaaaadaaaaaaegiccaaaaaaaaaaabeaaaaaaegacbaaaaaaaaaaadcaaaaak
icaabaaaacaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaaeadkaabaaa
acaaaaaadcaaaaamicaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaa
bkiacaaaaaaaaaaaahaaaaaadkaabaaaacaaaaaadiaaaaahccaabaaaacaaaaaa
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
diaaaaajecaabaaaaeaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaa
akaaaaaaaoaaaaahicaabaaaaeaaaaaaabeaaaaaaaaaaadpckaabaaaaeaaaaaa
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
akaabaiaebaaaaaaadaaaaaabkiacaaaaaaaaaaaahaaaaaaaoaaaaahecaabaaa
aeaaaaaaakaabaaaagaaaaaackaabaaaaeaaaaaadiaaaaahecaabaaaaeaaaaaa
ckaabaaaaeaaaaaaabeaaaaadlkklidpbjaaaaafecaabaaaaeaaaaaackaabaaa
aeaaaaaadiaaaaahecaabaaaaeaaaaaackaabaaaaeaaaaaackaabaaaafaaaaaa
apaaaaakbcaabaaaafaaaaaaegaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaialp
aaaaaaaaaaaaaaaaaaaaaaahicaabaaaaeaaaaaadkaabaaaaeaaaaaaakaabaaa
afaaaaaadiaaaaahecaabaaaaeaaaaaadkaabaaaaeaaaaaackaabaaaaeaaaaaa
diaaaaajicaabaaaaeaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaaaaaaaaaa
akaaaaaaaoaaaaahbcaabaaaafaaaaaaabeaaaaaaaaaaadpdkaabaaaaeaaaaaa
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
adaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaamocaabaaaaeaaaaaaagijcaia
ebaaaaaaaaaaaaaaaeaaaaaakgakbaaaaeaaaaaaagajbaiaebaaaaaaafaaaaaa
diaaaaakocaabaaaaeaaaaaafgaobaaaaeaaaaaaaceaaaaaaaaaaaaadlkklidp
dlkklidpdlkklidpbjaaaaafhcaabaaaafaaaaaajgahbaaaaeaaaaaabcaaaaab
aaaaaaajbcaabaaaadaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaaaaaaaaaa
ahaaaaaaaoaaaaahicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaaabaaaaaa
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
aaaaaaajbcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabeaaaaaaabeaaaaa
aaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaabeaaaaaaegacbaaaafaaaaaa
pgapbaaaabaaaaaadiaaaaaihcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaa
aaaaaaaabfaaaaaabnaaaaahicaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaa
adaaaaaabpaaaeaddkaabaaaabaaaaaaaaaaaaajicaabaaaabaaaaaabkiacaia
ebaaaaaaaaaaaaaabfaaaaaaabeaaaaaaaaaiadpdcaaaaakocaabaaaaeaaaaaa
pgapbaaaabaaaaaaagajbaaaadaaaaaafgifcaaaaaaaaaaabfaaaaaabcaaaaab
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
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaabgaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
dgaaaaafbcaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaaacaaaaaa
bbaaaaajccaabaaaacaaaaaaegiocaaaaaaaaaaabkaaaaaaegjojaaaakaabaaa
acaaaaaabnaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaa
bpaaaeadckaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaa
egiocaaaaaaaaaaabhaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajccaabaaa
afaaaaaaegiocaaaaaaaaaaabiaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaaj
ecaabaaaafaaaaaaegiocaaaaaaaaaaabjaaaaaaegjojaaaakaabaaaacaaaaaa
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
aaaaaaaabgaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaa
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
ckaabaaaacaaaaaabbaaaaajecaabaaaacaaaaaaegiocaaaaaaaaaaaboaaaaaa
egjojaaabkaabaaaacaaaaaabnaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaa
ckaabaaaacaaaaaabpaaaeaddkaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaaj
bcaabaaaafaaaaaaegiocaaaaaaaaaaablaaaaaaegjojaaabkaabaaaacaaaaaa
bbaaaaajccaabaaaafaaaaaaegiocaaaaaaaaaaabmaaaaaaegjojaaabkaabaaa
acaaaaaabbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaabnaaaaaaegjojaaa
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
acaaaaaadkiacaaaaaaaaaaabgaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaa
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
ckiacaiaebaaaaaaaaaaaaaabfaaaaaaabeaaaaaaaaaiadpdcaaaaakocaabaaa
aeaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaakgikcaaaaaaaaaaabfaaaaaa
bfaaaaabdgaaaaafhccabaaaaaaaaaaajgahbaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 // Stats for Fragment shader:
 //       d3d11 : 216 avg math (158..275), 4 avg branch (0..8)
 //        d3d9 : 458 avg math (234..682), 8 texture, 7 avg branch (0..15)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL
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
float xlat_mutable_Exposure;
varying vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1))) - (Rg * Rg))));
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
  float tmpvar_13;
  tmpvar_13 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_9);
  viewdir_9 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = dot (camera_8, tmpvar_14);
  rMu_10 = tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_16) - sqrt((((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (tmpvar_13 * tmpvar_13)))), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_17 * tmpvar_14));
    rMu_10 = (tmpvar_16 + tmpvar_17);
    r_11 = tmpvar_13;
  };
  float tmpvar_18;
  tmpvar_18 = dot (tmpvar_14, _Sun_WorldSunDir);
  float tmpvar_19;
  tmpvar_19 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  vec4 tmpvar_20;
  float uMu_21;
  float uR_22;
  float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_13 * tmpvar_13) - (Rg * Rg)));
  float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
  vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_40.y = ((uMu_21 / RES_R) + tmpvar_36);
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_37);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_42.y = ((uMu_21 / RES_R) + tmpvar_37);
  tmpvar_20 = ((((texture2DLod (_Inscatter, tmpvar_39.xy, 0.0) * (1.0 - tmpvar_35)) + (texture2DLod (_Inscatter, tmpvar_40.xy, 0.0) * tmpvar_35)) * (1.0 - tmpvar_38)) + (((texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * (1.0 - tmpvar_35)) + (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * tmpvar_35)) * tmpvar_38));
  if ((r_11 <= tmpvar_13)) {
    result_12 = ((tmpvar_20.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  vec3 L_43;
  vec3 tmpvar_44;
  tmpvar_44 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_43 = tmpvar_44;
  float tmpvar_45;
  if ((tmpvar_44.x < 1.413)) {
    tmpvar_45 = pow ((tmpvar_44.x * 0.38317), 0.454545);
  } else {
    tmpvar_45 = (1.0 - exp(-(tmpvar_44.x)));
  };
  L_43.x = tmpvar_45;
  float tmpvar_46;
  if ((tmpvar_44.y < 1.413)) {
    tmpvar_46 = pow ((tmpvar_44.y * 0.38317), 0.454545);
  } else {
    tmpvar_46 = (1.0 - exp(-(tmpvar_44.y)));
  };
  L_43.y = tmpvar_46;
  float tmpvar_47;
  if ((tmpvar_44.z < 1.413)) {
    tmpvar_47 = pow ((tmpvar_44.z * 0.38317), 0.454545);
  } else {
    tmpvar_47 = (1.0 - exp(-(tmpvar_44.z)));
  };
  L_43.z = tmpvar_47;
  vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = (_Alpha_Global * L_43);
  gl_FragData[0] = tmpvar_48;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_OFF" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
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
Keywords { "ECLIPSES_OFF" }
"!!GLES


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
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1))) - (Rg * Rg))));
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
  highp float tmpvar_13;
  tmpvar_13 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_9);
  viewdir_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (camera_8, tmpvar_14);
  rMu_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_16) - sqrt((((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (tmpvar_13 * tmpvar_13)))), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_17 * tmpvar_14));
    rMu_10 = (tmpvar_16 + tmpvar_17);
    r_11 = tmpvar_13;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_14, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_13 * tmpvar_13) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DLodEXT (_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2DLodEXT (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  if ((r_11 <= tmpvar_13)) {
    result_12 = ((tmpvar_20.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_47 = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_48.x < 1.413)) {
    tmpvar_49 = pow ((tmpvar_48.x * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_48.x)));
  };
  L_47.x = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_48.y < 1.413)) {
    tmpvar_50 = pow ((tmpvar_48.y * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_48.y)));
  };
  L_47.y = tmpvar_50;
  highp float tmpvar_51;
  if ((tmpvar_48.z < 1.413)) {
    tmpvar_51 = pow ((tmpvar_48.z * 0.38317), 0.454545);
  } else {
    tmpvar_51 = (1.0 - exp(-(tmpvar_48.z)));
  };
  L_47.z = tmpvar_51;
  highp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = (_Alpha_Global * L_47);
  gl_FragData[0] = tmpvar_52;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_OFF" }
"!!GLES


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
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1))) - (Rg * Rg))));
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
  highp float tmpvar_13;
  tmpvar_13 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_9);
  viewdir_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (camera_8, tmpvar_14);
  rMu_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_16) - sqrt((((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (tmpvar_13 * tmpvar_13)))), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_17 * tmpvar_14));
    rMu_10 = (tmpvar_16 + tmpvar_17);
    r_11 = tmpvar_13;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_14, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_13 * tmpvar_13) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2DLodEXT (_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2DLodEXT (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  if ((r_11 <= tmpvar_13)) {
    result_12 = ((tmpvar_20.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_47 = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_48.x < 1.413)) {
    tmpvar_49 = pow ((tmpvar_48.x * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_48.x)));
  };
  L_47.x = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_48.y < 1.413)) {
    tmpvar_50 = pow ((tmpvar_48.y * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_48.y)));
  };
  L_47.y = tmpvar_50;
  highp float tmpvar_51;
  if ((tmpvar_48.z < 1.413)) {
    tmpvar_51 = pow ((tmpvar_48.z * 0.38317), 0.454545);
  } else {
    tmpvar_51 = (1.0 - exp(-(tmpvar_48.z)));
  };
  L_47.z = tmpvar_51;
  highp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = (_Alpha_Global * L_47);
  gl_FragData[0] = tmpvar_52;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
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
highp float xlat_mutable_Exposure;
in highp vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_5 = ((tmpvar_4 * tmpvar_4) - ((4.0 * tmpvar_3) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_1, tmpvar_1)) - (2.0 * dot (_Globals_Origin, tmpvar_1))) - (Rg * Rg))));
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
  highp float tmpvar_13;
  tmpvar_13 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_9.x = (tmpvar_2.x + _viewdirOffset);
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(viewdir_9);
  viewdir_9 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = sqrt(dot (camera_8, camera_8));
  r_11 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (camera_8, tmpvar_14);
  rMu_10 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max ((-(tmpvar_16) - sqrt((((tmpvar_16 * tmpvar_16) - (tmpvar_15 * tmpvar_15)) + (tmpvar_13 * tmpvar_13)))), 0.0);
  if ((tmpvar_17 > 0.0)) {
    camera_8 = (camera_8 + (tmpvar_17 * tmpvar_14));
    rMu_10 = (tmpvar_16 + tmpvar_17);
    r_11 = tmpvar_13;
  };
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_14, _Sun_WorldSunDir);
  highp float tmpvar_19;
  tmpvar_19 = (dot (camera_8, _Sun_WorldSunDir) / r_11);
  highp vec4 tmpvar_20;
  highp float uMu_21;
  highp float uR_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_13 * tmpvar_13) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_11 * r_11) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_11 * (rMu_10 / r_11));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_11 * r_11)) + (Rg * Rg));
  highp vec4 tmpvar_27;
  if (((tmpvar_25 < 0.0) && (tmpvar_26 > 0.0))) {
    highp vec4 tmpvar_28;
    tmpvar_28.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_28.w = (0.5 - (0.5 / RES_MU));
    tmpvar_27 = tmpvar_28;
  } else {
    highp vec4 tmpvar_29;
    tmpvar_29.x = -1.0;
    tmpvar_29.y = (tmpvar_23 * tmpvar_23);
    tmpvar_29.z = tmpvar_23;
    tmpvar_29.w = (0.5 + (0.5 / RES_MU));
    tmpvar_27 = tmpvar_29;
  };
  uR_22 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  uMu_21 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_30;
  y_over_x_30 = (max (tmpvar_19, -0.1975) * 5.34962);
  highp float x_31;
  x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
  highp float tmpvar_32;
  tmpvar_32 = ((0.5 / RES_MU_S) + (((((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_33;
  tmpvar_33 = (((tmpvar_18 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_34;
  tmpvar_34 = floor(tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_33 - tmpvar_34);
  highp float tmpvar_36;
  tmpvar_36 = (floor(((uR_22 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = (floor((uR_22 * RES_R)) / RES_R);
  highp float tmpvar_38;
  tmpvar_38 = fract((uR_22 * RES_R));
  highp vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_39.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_40;
  tmpvar_40 = textureLod (_Inscatter, tmpvar_39.xy, 0.0);
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_21 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_42;
  tmpvar_42 = textureLod (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_34 + tmpvar_32) / RES_NU);
  tmpvar_43.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_44;
  tmpvar_44 = textureLod (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_34 + tmpvar_32) + 1.0) / RES_NU);
  tmpvar_45.y = ((uMu_21 / RES_R) + tmpvar_37);
  lowp vec4 tmpvar_46;
  tmpvar_46 = textureLod (_Inscatter, tmpvar_45.xy, 0.0);
  tmpvar_20 = ((((tmpvar_40 * (1.0 - tmpvar_35)) + (tmpvar_42 * tmpvar_35)) * (1.0 - tmpvar_38)) + (((tmpvar_44 * (1.0 - tmpvar_35)) + (tmpvar_46 * tmpvar_35)) * tmpvar_38));
  if ((r_11 <= tmpvar_13)) {
    result_12 = ((tmpvar_20.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_18 * tmpvar_18)))) + ((((tmpvar_20.xyz * tmpvar_20.w) / max (tmpvar_20.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_18)), -1.5)) * (1.0 + (tmpvar_18 * tmpvar_18))) / (2.0 + (mieG * mieG)))));
  } else {
    result_12 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_47;
  highp vec3 tmpvar_48;
  tmpvar_48 = ((result_12 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_47 = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_48.x < 1.413)) {
    tmpvar_49 = pow ((tmpvar_48.x * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_48.x)));
  };
  L_47.x = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_48.y < 1.413)) {
    tmpvar_50 = pow ((tmpvar_48.y * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_48.y)));
  };
  L_47.y = tmpvar_50;
  highp float tmpvar_51;
  if ((tmpvar_48.z < 1.413)) {
    tmpvar_51 = pow ((tmpvar_48.z * 0.38317), 0.454545);
  } else {
    tmpvar_51 = (1.0 - exp(-(tmpvar_48.z)));
  };
  L_47.z = tmpvar_51;
  highp vec4 tmpvar_52;
  tmpvar_52.w = 1.0;
  tmpvar_52.xyz = (_Alpha_Global * L_47);
  _glesFragData[0] = tmpvar_52;
}



#endif"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL
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
float xlat_mutable_Exposure;
varying vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (Rg * Rg))));
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
  float tmpvar_16;
  tmpvar_16 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _viewdirOffset);
  vec3 tmpvar_17;
  tmpvar_17 = normalize(viewdir_12);
  viewdir_12 = tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_18;
  float tmpvar_19;
  tmpvar_19 = dot (camera_11, tmpvar_17);
  rMu_13 = tmpvar_19;
  float tmpvar_20;
  tmpvar_20 = max ((-(tmpvar_19) - sqrt((((tmpvar_19 * tmpvar_19) - (tmpvar_18 * tmpvar_18)) + (tmpvar_16 * tmpvar_16)))), 0.0);
  if ((tmpvar_20 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_20 * tmpvar_17));
    rMu_13 = (tmpvar_19 + tmpvar_20);
    r_14 = tmpvar_16;
  };
  float tmpvar_21;
  tmpvar_21 = dot (tmpvar_17, _Sun_WorldSunDir);
  float tmpvar_22;
  tmpvar_22 = (dot (camera_11, _Sun_WorldSunDir) / r_14);
  vec4 tmpvar_23;
  float tmpvar_24;
  tmpvar_24 = sqrt(((tmpvar_16 * tmpvar_16) - (Rg * Rg)));
  float tmpvar_25;
  tmpvar_25 = sqrt(((r_14 * r_14) - (Rg * Rg)));
  float tmpvar_26;
  tmpvar_26 = (r_14 * (rMu_13 / r_14));
  float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 * tmpvar_26) - (r_14 * r_14)) + (Rg * Rg));
  vec4 tmpvar_28;
  if (((tmpvar_26 < 0.0) && (tmpvar_27 > 0.0))) {
    vec4 tmpvar_29;
    tmpvar_29.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_29.w = (0.5 - (0.5 / RES_MU));
    tmpvar_28 = tmpvar_29;
  } else {
    vec4 tmpvar_30;
    tmpvar_30.x = -1.0;
    tmpvar_30.y = (tmpvar_24 * tmpvar_24);
    tmpvar_30.z = tmpvar_24;
    tmpvar_30.w = (0.5 + (0.5 / RES_MU));
    tmpvar_28 = tmpvar_30;
  };
  float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_R) + ((tmpvar_25 / tmpvar_24) * (1.0 - (1.0/(RES_R)))));
  float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w + ((((tmpvar_26 * tmpvar_28.x) + sqrt((tmpvar_27 + tmpvar_28.y))) / (tmpvar_25 + tmpvar_28.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_33;
  y_over_x_33 = (max (tmpvar_22, -0.1975) * 5.34962);
  float x_34;
  x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
  float tmpvar_35;
  tmpvar_35 = ((0.5 / RES_MU_S) + (((((sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_36;
  tmpvar_36 = (((tmpvar_21 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_37;
  tmpvar_37 = floor(tmpvar_36);
  float tmpvar_38;
  tmpvar_38 = (tmpvar_36 - tmpvar_37);
  float tmpvar_39;
  tmpvar_39 = (floor(((tmpvar_31 * RES_R) - 1.0)) / RES_R);
  float tmpvar_40;
  tmpvar_40 = (floor((tmpvar_31 * RES_R)) / RES_R);
  float tmpvar_41;
  tmpvar_41 = fract((tmpvar_31 * RES_R));
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_42.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_44.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_45.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  tmpvar_23 = ((((texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * (1.0 - tmpvar_38)) + (texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * tmpvar_38)) * (1.0 - tmpvar_41)) + (((texture2DLod (_Inscatter, tmpvar_44.xy, 0.0) * (1.0 - tmpvar_38)) + (texture2DLod (_Inscatter, tmpvar_45.xy, 0.0) * tmpvar_38)) * tmpvar_41));
  if ((r_14 <= tmpvar_16)) {
    result_15 = ((tmpvar_23.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_21 * tmpvar_21)))) + ((((tmpvar_23.xyz * tmpvar_23.w) / max (tmpvar_23.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_21)), -1.5)) * (1.0 + (tmpvar_21 * tmpvar_21))) / (2.0 + (mieG * mieG)))));
  } else {
    result_15 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_15 * _Sun_Intensity);
  float tmpvar_46;
  float tmpvar_47;
  tmpvar_47 = dot (tmpvar_5, tmpvar_5);
  float tmpvar_48;
  tmpvar_48 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  float tmpvar_49;
  tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (tmpvar_16 * tmpvar_16))));
  if ((tmpvar_49 < 0.0)) {
    tmpvar_46 = -1.0;
  } else {
    float tmpvar_50;
    tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    float tmpvar_51;
    if ((tmpvar_50 < 0.0)) {
      tmpvar_51 = ((-(tmpvar_48) + sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    } else {
      tmpvar_51 = tmpvar_50;
    };
    tmpvar_46 = tmpvar_51;
  };
  if ((tmpvar_46 != -1.0)) {
    worldPos_2 = (tmpvar_4 + (tmpvar_5 * tmpvar_46));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_46 != -1.0)) {
    int j_52;
    int i_53;
    i_53 = 0;
    for (int i_53 = 0; i_53 < 4; ) {
      if ((lightOccluders1[3][i_53] <= 0.0)) {
        break;
      };
      vec4 v_54;
      v_54.x = lightOccluders1[0][i_53];
      v_54.y = lightOccluders1[1][i_53];
      v_54.z = lightOccluders1[2][i_53];
      v_54.w = lightOccluders1[3][i_53];
      vec3 tmpvar_55;
      tmpvar_55 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_56;
      tmpvar_56 = sqrt(dot (tmpvar_55, tmpvar_55));
      vec3 tmpvar_57;
      tmpvar_57 = (tmpvar_55 / vec3(tmpvar_56));
      vec3 tmpvar_58;
      tmpvar_58 = (v_54.xyz - worldPos_2);
      float tmpvar_59;
      tmpvar_59 = sqrt(dot (tmpvar_58, tmpvar_58));
      vec3 tmpvar_60;
      tmpvar_60 = (tmpvar_58 / tmpvar_59);
      vec3 tmpvar_61;
      tmpvar_61 = ((tmpvar_57.yzx * tmpvar_60.zxy) - (tmpvar_57.zxy * tmpvar_60.yzx));
      float tmpvar_62;
      tmpvar_62 = min (1.0, sqrt(dot (tmpvar_61, tmpvar_61)));
      float tmpvar_63;
      tmpvar_63 = min (1.0, (vec3(lightOccluders1[3][i_53]) / tmpvar_59).x);
      float t_64;
      t_64 = max (min ((((-((vec3(tmpvar_56) * ((sign(tmpvar_62) * (1.5708 - (sqrt((1.0 - abs(tmpvar_62))) * (1.5708 + (abs(tmpvar_62) * (-0.214602 + (abs(tmpvar_62) * (0.0865667 + (abs(tmpvar_62) * -0.0310296))))))))) - (sign(tmpvar_63) * (1.5708 - (sqrt((1.0 - abs(tmpvar_63))) * (1.5708 + (abs(tmpvar_63) * (-0.214602 + (abs(tmpvar_63) * (0.0865667 + (abs(tmpvar_63) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      float t_65;
      t_65 = max (min ((dot (tmpvar_57, tmpvar_60) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_64 * (t_64 * (3.0 - (2.0 * t_64)))) * (t_65 * (t_65 * (3.0 - (2.0 * t_65)))))));
      i_53 = (i_53 + 1);
    };
    j_52 = 0;
    for (int j_52 = 0; j_52 < 4; ) {
      if ((lightOccluders2[3][j_52] <= 0.0)) {
        break;
      };
      vec4 v_66;
      v_66.x = lightOccluders2[0][j_52];
      v_66.y = lightOccluders2[1][j_52];
      v_66.z = lightOccluders2[2][j_52];
      v_66.w = lightOccluders2[3][j_52];
      vec3 tmpvar_67;
      tmpvar_67 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_68;
      tmpvar_68 = sqrt(dot (tmpvar_67, tmpvar_67));
      vec3 tmpvar_69;
      tmpvar_69 = (tmpvar_67 / vec3(tmpvar_68));
      vec3 tmpvar_70;
      tmpvar_70 = (v_66.xyz - worldPos_2);
      float tmpvar_71;
      tmpvar_71 = sqrt(dot (tmpvar_70, tmpvar_70));
      vec3 tmpvar_72;
      tmpvar_72 = (tmpvar_70 / tmpvar_71);
      vec3 tmpvar_73;
      tmpvar_73 = ((tmpvar_69.yzx * tmpvar_72.zxy) - (tmpvar_69.zxy * tmpvar_72.yzx));
      float tmpvar_74;
      tmpvar_74 = min (1.0, sqrt(dot (tmpvar_73, tmpvar_73)));
      float tmpvar_75;
      tmpvar_75 = min (1.0, (vec3(lightOccluders2[3][j_52]) / tmpvar_71).x);
      float t_76;
      t_76 = max (min ((((-((vec3(tmpvar_68) * ((sign(tmpvar_74) * (1.5708 - (sqrt((1.0 - abs(tmpvar_74))) * (1.5708 + (abs(tmpvar_74) * (-0.214602 + (abs(tmpvar_74) * (0.0865667 + (abs(tmpvar_74) * -0.0310296))))))))) - (sign(tmpvar_75) * (1.5708 - (sqrt((1.0 - abs(tmpvar_75))) * (1.5708 + (abs(tmpvar_75) * (-0.214602 + (abs(tmpvar_75) * (0.0865667 + (abs(tmpvar_75) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      float t_77;
      t_77 = max (min ((dot (tmpvar_69, tmpvar_72) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_76 * (t_76 * (3.0 - (2.0 * t_76)))) * (t_77 * (t_77 * (3.0 - (2.0 * t_77)))))));
      j_52 = (j_52 + 1);
    };
  };
  vec3 L_78;
  vec3 tmpvar_79;
  tmpvar_79 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_78 = tmpvar_79;
  float tmpvar_80;
  if ((tmpvar_79.x < 1.413)) {
    tmpvar_80 = pow ((tmpvar_79.x * 0.38317), 0.454545);
  } else {
    tmpvar_80 = (1.0 - exp(-(tmpvar_79.x)));
  };
  L_78.x = tmpvar_80;
  float tmpvar_81;
  if ((tmpvar_79.y < 1.413)) {
    tmpvar_81 = pow ((tmpvar_79.y * 0.38317), 0.454545);
  } else {
    tmpvar_81 = (1.0 - exp(-(tmpvar_79.y)));
  };
  L_78.y = tmpvar_81;
  float tmpvar_82;
  if ((tmpvar_79.z < 1.413)) {
    tmpvar_82 = pow ((tmpvar_79.z * 0.38317), 0.454545);
  } else {
    tmpvar_82 = (1.0 - exp(-(tmpvar_79.z)));
  };
  L_78.z = tmpvar_82;
  vec4 tmpvar_83;
  tmpvar_83.w = 1.0;
  tmpvar_83.xyz = (_Alpha_Global * L_78);
  gl_FragData[0] = tmpvar_83;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 7 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
dp4 o1.z, v0, c6
dp4 o1.y, v0, c5
dp4 o1.x, v0, c4
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "ECLIPSES_ON" }
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
BindCB  "UnityPerDraw" 0
"vs_4_0
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
Keywords { "ECLIPSES_ON" }
"!!GLES


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
highp float xlat_mutable_Exposure;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (Rg * Rg))));
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
  highp float tmpvar_16;
  tmpvar_16 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _viewdirOffset);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(viewdir_12);
  viewdir_12 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (camera_11, tmpvar_17);
  rMu_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max ((-(tmpvar_19) - sqrt((((tmpvar_19 * tmpvar_19) - (tmpvar_18 * tmpvar_18)) + (tmpvar_16 * tmpvar_16)))), 0.0);
  if ((tmpvar_20 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_20 * tmpvar_17));
    rMu_13 = (tmpvar_19 + tmpvar_20);
    r_14 = tmpvar_16;
  };
  highp float tmpvar_21;
  tmpvar_21 = dot (tmpvar_17, _Sun_WorldSunDir);
  highp float tmpvar_22;
  tmpvar_22 = (dot (camera_11, _Sun_WorldSunDir) / r_14);
  highp vec4 tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((tmpvar_16 * tmpvar_16) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = sqrt(((r_14 * r_14) - (Rg * Rg)));
  highp float tmpvar_26;
  tmpvar_26 = (r_14 * (rMu_13 / r_14));
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 * tmpvar_26) - (r_14 * r_14)) + (Rg * Rg));
  highp vec4 tmpvar_28;
  if (((tmpvar_26 < 0.0) && (tmpvar_27 > 0.0))) {
    highp vec4 tmpvar_29;
    tmpvar_29.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_29.w = (0.5 - (0.5 / RES_MU));
    tmpvar_28 = tmpvar_29;
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.x = -1.0;
    tmpvar_30.y = (tmpvar_24 * tmpvar_24);
    tmpvar_30.z = tmpvar_24;
    tmpvar_30.w = (0.5 + (0.5 / RES_MU));
    tmpvar_28 = tmpvar_30;
  };
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_R) + ((tmpvar_25 / tmpvar_24) * (1.0 - (1.0/(RES_R)))));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w + ((((tmpvar_26 * tmpvar_28.x) + sqrt((tmpvar_27 + tmpvar_28.y))) / (tmpvar_25 + tmpvar_28.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_33;
  y_over_x_33 = (max (tmpvar_22, -0.1975) * 5.34962);
  highp float x_34;
  x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
  highp float tmpvar_35;
  tmpvar_35 = ((0.5 / RES_MU_S) + (((((sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_36;
  tmpvar_36 = (((tmpvar_21 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_37;
  tmpvar_37 = floor(tmpvar_36);
  highp float tmpvar_38;
  tmpvar_38 = (tmpvar_36 - tmpvar_37);
  highp float tmpvar_39;
  tmpvar_39 = (floor(((tmpvar_31 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = (floor((tmpvar_31 * RES_R)) / RES_R);
  highp float tmpvar_41;
  tmpvar_41 = fract((tmpvar_31 * RES_R));
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_42.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2DLodEXT (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DLodEXT (_Inscatter, tmpvar_44.xy, 0.0);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_46.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2DLodEXT (_Inscatter, tmpvar_46.xy, 0.0);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_48.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2DLodEXT (_Inscatter, tmpvar_48.xy, 0.0);
  tmpvar_23 = ((((tmpvar_43 * (1.0 - tmpvar_38)) + (tmpvar_45 * tmpvar_38)) * (1.0 - tmpvar_41)) + (((tmpvar_47 * (1.0 - tmpvar_38)) + (tmpvar_49 * tmpvar_38)) * tmpvar_41));
  if ((r_14 <= tmpvar_16)) {
    result_15 = ((tmpvar_23.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_21 * tmpvar_21)))) + ((((tmpvar_23.xyz * tmpvar_23.w) / max (tmpvar_23.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_21)), -1.5)) * (1.0 + (tmpvar_21 * tmpvar_21))) / (2.0 + (mieG * mieG)))));
  } else {
    result_15 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_15 * _Sun_Intensity);
  highp float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = dot (tmpvar_5, tmpvar_5);
  highp float tmpvar_52;
  tmpvar_52 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  highp float tmpvar_53;
  tmpvar_53 = ((tmpvar_52 * tmpvar_52) - ((4.0 * tmpvar_51) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (tmpvar_16 * tmpvar_16))));
  if ((tmpvar_53 < 0.0)) {
    tmpvar_50 = -1.0;
  } else {
    highp float tmpvar_54;
    tmpvar_54 = ((-(tmpvar_52) - sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
    highp float tmpvar_55;
    if ((tmpvar_54 < 0.0)) {
      tmpvar_55 = ((-(tmpvar_52) + sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
    } else {
      tmpvar_55 = tmpvar_54;
    };
    tmpvar_50 = tmpvar_55;
  };
  if ((tmpvar_50 != -1.0)) {
    worldPos_2 = (tmpvar_4 + (tmpvar_5 * tmpvar_50));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_50 != -1.0)) {
    int j_56;
    int i_57;
    i_57 = 0;
    for (int i_57 = 0; i_57 < 4; ) {
      if ((lightOccluders1[3][i_57] <= 0.0)) {
        break;
      };
      highp vec4 v_58;
      v_58.x = lightOccluders1[0][i_57];
      v_58.y = lightOccluders1[1][i_57];
      v_58.z = lightOccluders1[2][i_57];
      v_58.w = lightOccluders1[3][i_57];
      highp vec3 tmpvar_59;
      tmpvar_59 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_60;
      tmpvar_60 = sqrt(dot (tmpvar_59, tmpvar_59));
      highp vec3 tmpvar_61;
      tmpvar_61 = (tmpvar_59 / vec3(tmpvar_60));
      highp vec3 tmpvar_62;
      tmpvar_62 = (v_58.xyz - worldPos_2);
      highp float tmpvar_63;
      tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
      highp vec3 tmpvar_64;
      tmpvar_64 = (tmpvar_62 / tmpvar_63);
      highp vec3 tmpvar_65;
      tmpvar_65 = ((tmpvar_61.yzx * tmpvar_64.zxy) - (tmpvar_61.zxy * tmpvar_64.yzx));
      highp float tmpvar_66;
      tmpvar_66 = min (1.0, sqrt(dot (tmpvar_65, tmpvar_65)));
      highp float tmpvar_67;
      tmpvar_67 = min (1.0, (vec3(lightOccluders1[3][i_57]) / tmpvar_63).x);
      highp float t_68;
      t_68 = max (min ((((-((vec3(tmpvar_60) * ((sign(tmpvar_66) * (1.5708 - (sqrt((1.0 - abs(tmpvar_66))) * (1.5708 + (abs(tmpvar_66) * (-0.214602 + (abs(tmpvar_66) * (0.0865667 + (abs(tmpvar_66) * -0.0310296))))))))) - (sign(tmpvar_67) * (1.5708 - (sqrt((1.0 - abs(tmpvar_67))) * (1.5708 + (abs(tmpvar_67) * (-0.214602 + (abs(tmpvar_67) * (0.0865667 + (abs(tmpvar_67) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_69;
      t_69 = max (min ((dot (tmpvar_61, tmpvar_64) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_68 * (t_68 * (3.0 - (2.0 * t_68)))) * (t_69 * (t_69 * (3.0 - (2.0 * t_69)))))));
      i_57 = (i_57 + 1);
    };
    j_56 = 0;
    for (int j_56 = 0; j_56 < 4; ) {
      if ((lightOccluders2[3][j_56] <= 0.0)) {
        break;
      };
      highp vec4 v_70;
      v_70.x = lightOccluders2[0][j_56];
      v_70.y = lightOccluders2[1][j_56];
      v_70.z = lightOccluders2[2][j_56];
      v_70.w = lightOccluders2[3][j_56];
      highp vec3 tmpvar_71;
      tmpvar_71 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_72;
      tmpvar_72 = sqrt(dot (tmpvar_71, tmpvar_71));
      highp vec3 tmpvar_73;
      tmpvar_73 = (tmpvar_71 / vec3(tmpvar_72));
      highp vec3 tmpvar_74;
      tmpvar_74 = (v_70.xyz - worldPos_2);
      highp float tmpvar_75;
      tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
      highp vec3 tmpvar_76;
      tmpvar_76 = (tmpvar_74 / tmpvar_75);
      highp vec3 tmpvar_77;
      tmpvar_77 = ((tmpvar_73.yzx * tmpvar_76.zxy) - (tmpvar_73.zxy * tmpvar_76.yzx));
      highp float tmpvar_78;
      tmpvar_78 = min (1.0, sqrt(dot (tmpvar_77, tmpvar_77)));
      highp float tmpvar_79;
      tmpvar_79 = min (1.0, (vec3(lightOccluders2[3][j_56]) / tmpvar_75).x);
      highp float t_80;
      t_80 = max (min ((((-((vec3(tmpvar_72) * ((sign(tmpvar_78) * (1.5708 - (sqrt((1.0 - abs(tmpvar_78))) * (1.5708 + (abs(tmpvar_78) * (-0.214602 + (abs(tmpvar_78) * (0.0865667 + (abs(tmpvar_78) * -0.0310296))))))))) - (sign(tmpvar_79) * (1.5708 - (sqrt((1.0 - abs(tmpvar_79))) * (1.5708 + (abs(tmpvar_79) * (-0.214602 + (abs(tmpvar_79) * (0.0865667 + (abs(tmpvar_79) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_81;
      t_81 = max (min ((dot (tmpvar_73, tmpvar_76) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_80 * (t_80 * (3.0 - (2.0 * t_80)))) * (t_81 * (t_81 * (3.0 - (2.0 * t_81)))))));
      j_56 = (j_56 + 1);
    };
  };
  highp vec3 L_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_82 = tmpvar_83;
  highp float tmpvar_84;
  if ((tmpvar_83.x < 1.413)) {
    tmpvar_84 = pow ((tmpvar_83.x * 0.38317), 0.454545);
  } else {
    tmpvar_84 = (1.0 - exp(-(tmpvar_83.x)));
  };
  L_82.x = tmpvar_84;
  highp float tmpvar_85;
  if ((tmpvar_83.y < 1.413)) {
    tmpvar_85 = pow ((tmpvar_83.y * 0.38317), 0.454545);
  } else {
    tmpvar_85 = (1.0 - exp(-(tmpvar_83.y)));
  };
  L_82.y = tmpvar_85;
  highp float tmpvar_86;
  if ((tmpvar_83.z < 1.413)) {
    tmpvar_86 = pow ((tmpvar_83.z * 0.38317), 0.454545);
  } else {
    tmpvar_86 = (1.0 - exp(-(tmpvar_83.z)));
  };
  L_82.z = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87.w = 1.0;
  tmpvar_87.xyz = (_Alpha_Global * L_82);
  gl_FragData[0] = tmpvar_87;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_ON" }
"!!GLES


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

#ifndef ECLIPSES_ON
    #define ECLIPSES_ON 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#extension GL_EXT_shader_texture_lod : require
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
#if defined(SHADER_API_GLES) && defined(SHADER_API_DESKTOP)
vec2 xll_matrixindexdynamic_mf2x2_i (mat2 m, int i) {
 mat2 m2 = xll_transpose(m);
 return i==0?m2[0]:m2[1];
}
vec3 xll_matrixindexdynamic_mf3x3_i (mat3 m, int i) {
 mat3 m2 = xll_transpose(m);
 return i < 2?(i==0?m2[0]:m2[1]):(m2[2]);
}
vec4 xll_matrixindexdynamic_mf4x4_i (mat4 m, int i) {
 mat4 m2 = xll_transpose(m);
 return i < 2?(i==0?m2[0]:m2[1]):(i==3?m2[3]:m2[2]);
}
#else
vec2 xll_matrixindexdynamic_mf2x2_i (mat2 m, int i) { return xll_matrixindex_mf2x2_i (m, i); }
vec3 xll_matrixindexdynamic_mf3x3_i (mat3 m, int i) { return xll_matrixindex_mf3x3_i (m, i); }
vec4 xll_matrixindexdynamic_mf4x4_i (mat4 m, int i) { return xll_matrixindex_mf4x4_i (m, i); }
#endif
#line 221
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 275
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 271
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 264
struct v2f {
    highp vec4 pos;
    highp vec3 worldPos;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 16
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
#line 21
uniform highp vec3 _WorldSpaceCameraPos;
#line 27
uniform highp vec4 _ProjectionParams;
#line 33
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
#line 40
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 53
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 58
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
#line 63
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 69
uniform highp vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 73
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 77
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 83
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 90
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 94
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 110
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 122
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
#line 133
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 149
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 173
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
#line 182
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 48
uniform lowp vec4 unity_ColorSpaceGrey;
#line 89
#line 104
#line 119
#line 125
#line 143
#line 175
#line 192
#line 227
#line 238
#line 248
#line 256
#line 280
#line 286
#line 296
#line 305
#line 312
#line 321
#line 329
#line 338
#line 357
#line 363
#line 376
#line 387
#line 392
#line 418
#line 434
#line 447
#line 38
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
uniform highp float TRANSMITTANCE_W;
#line 42
uniform highp float TRANSMITTANCE_H;
uniform highp float SKY_W;
uniform highp float SKY_H;
uniform highp float M_PI;
#line 46
uniform highp vec3 EARTH_POS;
uniform highp float SCALE;
#line 50
uniform highp float HR;
uniform highp vec3 betaR;
#line 54
uniform highp float HM;
uniform highp vec3 betaMSca;
uniform highp vec3 betaMEx;
uniform highp float mieG;
#line 59
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float RL;
#line 63
uniform highp float RES_R;
uniform highp float RES_MU;
uniform highp float RES_MU_S;
uniform highp float RES_NU;
#line 67
uniform highp vec3 SUN_DIR;
uniform highp float SUN_INTENSITY;
#line 71
uniform highp float _Sun_Intensity;
uniform highp float _experimentalAtmoScale;
#line 75
uniform highp float _viewdirOffset;
#line 85
#line 112
#line 145
#line 161
#line 173
#line 196
#line 218
#line 251
#line 269
#line 284
#line 299
#line 306
#line 366
#line 401
#line 407
#line 479
#line 488
#line 496
#line 504
#line 509
#line 534
#line 238
uniform highp float _Alpha_Global;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp vec3 _Globals_WorldCameraPos;
#line 242
uniform highp vec3 _Globals_Origin;
uniform highp float _RimExposure;
#line 247
uniform highp vec3 _Sun_WorldSunDir;
#line 252
uniform highp vec4 sunPosAndRadius;
uniform highp mat4 lightOccluders1;
uniform highp mat4 lightOccluders2;
#line 272
#line 282
highp float xlat_mutableRt;
highp float xlat_mutable_Exposure;
#line 112
highp vec3 GetMie( in highp vec4 rayMie ) {
    #line 116
    return (((rayMie.xyz * rayMie.w) / max( rayMie.x, 0.0001)) * (betaR.x / betaR));
}
#line 125
highp float PhaseFunctionM( in highp float mu ) {
    #line 128
    return (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow( ((1.0 + (mieG * mieG)) - ((2.0 * mieG) * mu)), -1.5)) * (1.0 + (mu * mu))) / (2.0 + (mieG * mieG)));
}
#line 119
highp float PhaseFunctionR( in highp float mu ) {
    #line 122
    return ((3.0 / (16.0 * M_PI)) * (1.0 + (mu * mu)));
}
#line 161
highp float SQRT( in highp float f, in highp float err ) {
    return sqrt(f);
}
#line 85
highp vec4 Texture4D( in sampler2D table, in highp float r, in highp float mu, in highp float muS, in highp float nu ) {
    highp float H = sqrt(((xlat_mutableRt * xlat_mutableRt) - (Rg * Rg)));
    highp float rho = sqrt(((r * r) - (Rg * Rg)));
    #line 89
    highp float rmu = (r * mu);
    highp float delta = (((rmu * rmu) - (r * r)) + (Rg * Rg));
    highp vec4 cst = (( ((rmu < 0.0) && (delta > 0.0)) ) ? ( vec4( 1.0, 0.0, 0.0, (0.5 - (0.5 / RES_MU))) ) : ( vec4( -1.0, (H * H), H, (0.5 + (0.5 / RES_MU))) ));
    highp float uR = ((0.5 / RES_R) + ((rho / H) * (1.0 - (1.0 / RES_R))));
    #line 93
    highp float uMu = (cst.w + ((((rmu * cst.x) + sqrt((delta + cst.y))) / (rho + cst.z)) * (0.5 - (1.0 / RES_MU))));
    #line 97
    highp float uMuS = ((0.5 / RES_MU_S) + ((((atan((max( muS, -0.1975) * tan(1.386))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0 / RES_MU_S))));
    highp float _lerp = (((nu + 1.0) / 2.0) * (RES_NU - 1.0));
    highp float uNu = floor(_lerp);
    _lerp = (_lerp - uNu);
    #line 104
    highp float u_0 = (floor(((uR * RES_R) - 1.0)) / RES_R);
    highp float u_1 = (floor((uR * RES_R)) / RES_R);
    highp float u_frac = fract((uR * RES_R));
    highp vec4 A = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_0), 0.0, 0.0)) * _lerp));
    #line 108
    highp vec4 B = ((xll_tex2Dlod( table, vec4( ((uNu + uMuS) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * (1.0 - _lerp)) + (xll_tex2Dlod( table, vec4( (((uNu + uMuS) + 1.0) / RES_NU), ((uMu / RES_R) + u_1), 0.0, 0.0)) * _lerp));
    return ((A * (1.0 - u_frac)) + (B * u_frac));
}
#line 131
highp vec3 Transmittance( in highp float r, in highp float mu ) {
    #line 135
    highp float uR;
    highp float uMu;
    uR = sqrt(((r - Rg) / (xlat_mutableRt - Rg)));
    uMu = (atan((((mu + 0.15) / 1.15) * tan(1.5))) / 1.5);
    #line 139
    return xll_tex2Dlod( _Transmittance, vec4( uMu, uR, 0.0, 0.0)).xyz;
}
#line 407
highp vec3 SkyRadiance2( in highp vec3 camera, in highp vec3 viewdir, in highp vec3 sundir, out highp vec3 extinction ) {
    extinction = vec3( 1.0, 1.0, 1.0);
    highp vec3 result = vec3( 0.0, 0.0, 0.0);
    #line 412
    highp float Rt2 = xlat_mutableRt;
    xlat_mutableRt = (Rg + ((xlat_mutableRt - Rg) * _experimentalAtmoScale));
    #line 416
    viewdir.x += _viewdirOffset;
    viewdir = normalize(viewdir);
    #line 421
    highp float r = length(camera);
    highp float rMu = dot( camera, viewdir);
    highp float mu = (rMu / r);
    highp float r0 = r;
    #line 425
    highp float mu0 = mu;
    highp float deltaSq = SQRT( (((rMu * rMu) - (r * r)) + (xlat_mutableRt * xlat_mutableRt)), 1e-06);
    #line 429
    highp float din = max( ((-rMu) - deltaSq), 0.0);
    if ((din > 0.0)){
        camera += (din * viewdir);
        #line 433
        rMu += din;
        mu = (rMu / xlat_mutableRt);
        r = xlat_mutableRt;
    }
    #line 438
    highp float nu = dot( viewdir, sundir);
    highp float muS = (dot( camera, sundir) / r);
    #line 442
    highp vec4 inScatter = Texture4D( _Inscatter, r, (rMu / r), muS, nu);
    extinction = Transmittance( r, mu);
    #line 446
    if ((r <= xlat_mutableRt)){
        #line 458
        highp vec3 inScatterM = GetMie( inScatter);
        highp float phase = PhaseFunctionR( nu);
        highp float phaseM = PhaseFunctionM( nu);
        result = ((inScatter.xyz * phase) + (inScatterM * phaseM));
    }
    else{
        #line 465
        result = vec3( 0.0, 0.0, 0.0);
        extinction = vec3( 1.0, 1.0, 1.0);
    }
    #line 469
    return (result * _Sun_Intensity);
}
#line 173
highp float getEclipseShadow( in highp vec3 worldPos, in highp vec3 worldLightPos, in highp vec3 occluderSpherePosition, in highp vec3 occluderSphereRadius, in highp vec3 lightSourceRadius ) {
    highp vec3 lightDirection = (worldLightPos - worldPos);
    highp vec3 lightDistance = vec3( length(lightDirection));
    #line 177
    lightDirection = (lightDirection / lightDistance);
    highp vec3 sphereDirection = (occluderSpherePosition - worldPos);
    #line 181
    highp float sphereDistance = length(sphereDirection);
    sphereDirection = (sphereDirection / sphereDistance);
    highp float dd = float( (lightDistance * (asin(min( 1.0, length(cross( lightDirection, sphereDirection)))) - asin(min( 1.0, float( (occluderSphereRadius / sphereDistance)))))));
    #line 187
    highp float w = smoothstep( -1.0, 1.0, float( ((-dd) / lightSourceRadius)));
    w = (w * smoothstep( 0.0, 0.2, dot( lightDirection, sphereDirection)));
    return (1.0 - w);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * xlat_mutable_Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
    return L;
}
#line 196
highp float intersectSphere2( in highp vec3 p1, in highp vec3 d, in highp vec3 p3, in highp float r ) {
    #line 200
    highp float a = dot( d, d);
    highp float b = (2.0 * dot( d, (p1 - p3)));
    highp float c = (((dot( p3, p3) + dot( p1, p1)) - (2.0 * dot( p3, p1))) - (r * r));
    highp float test = ((b * b) - ((4.0 * a) * c));
    #line 209
    highp float u = (( (test < 0.0) ) ? ( -1.0 ) : ( (((-b) - sqrt(test)) / (2.0 * a)) ));
    return u;
}
#line 218
highp float intersectSphere4( in highp vec3 p1, in highp vec3 d, in highp vec3 p3, in highp float r ) {
    #line 224
    highp float a = dot( d, d);
    highp float b = (2.0 * dot( d, (p1 - p3)));
    highp float c = (((dot( p3, p3) + dot( p1, p1)) - (2.0 * dot( p3, p1))) - (r * r));
    #line 228
    highp float test = ((b * b) - ((4.0 * a) * c));
    if ((test < 0.0)){
        #line 232
        return -1.0;
    }
    highp float u = (((-b) - sqrt(test)) / (2.0 * a));
    #line 243
    u = (( (u < 0.0) ) ? ( (((-b) + sqrt(test)) / (2.0 * a)) ) : ( u ));
    return u;
}
#line 282
highp vec4 frag( in v2f IN ) {
    #line 286
    highp vec3 WSD = _Sun_WorldSunDir;
    #line 291
    highp vec3 WCP = (_WorldSpaceCameraPos * 6000.0);
    #line 297
    highp vec3 d = normalize((IN.worldPos - _WorldSpaceCameraPos));
    highp float interSectPt = intersectSphere2( WCP, d, _Globals_Origin, Rg);
    #line 301
    bool rightDir = (interSectPt > 0.0);
    if ((!rightDir)){
        xlat_mutable_Exposure = _RimExposure;
    }
    #line 307
    highp vec3 extinction;
    highp vec3 inscatter = SkyRadiance2( (WCP - _Globals_Origin), d, WSD, extinction);
    highp vec3 worldPos;
    #line 313
    interSectPt = intersectSphere4( WCP, d, _Globals_Origin, xlat_mutableRt);
    if ((interSectPt != -1.0)){
        #line 317
        worldPos = (WCP + (d * interSectPt));
    }
    #line 347
    highp float eclipseShadow = 1.0;
    #line 364
    if ((interSectPt != -1.0)){
        #line 368
        highp int i = 0;
        for ( ; (i < 4); (++i)) {
            if ((lightOccluders1[3][i] <= 0.0)){
                break;
            }
            eclipseShadow *= getEclipseShadow( worldPos, sunPosAndRadius.xyz, xll_matrixindexdynamic_mf4x4_i (lightOccluders1, i).xyz, vec3( lightOccluders1[3][i]), vec3( sunPosAndRadius.w));
        }
        #line 375
        highp int j = 0;
        for ( ; (j < 4); (++j)) {
            if ((lightOccluders2[3][j] <= 0.0)){
                break;
            }
            eclipseShadow *= getEclipseShadow( worldPos, sunPosAndRadius.xyz, xll_matrixindexdynamic_mf4x4_i (lightOccluders2, j).xyz, vec3( lightOccluders2[3][j]), vec3( sunPosAndRadius.w));
        }
    }
    #line 388
    highp vec3 finalColor = (inscatter * eclipseShadow);
    #line 398
    return vec4( (_Alpha_Global * hdr( finalColor)), 1.0);
}
varying highp vec3 xlv_TEXCOORD0;
void main() {
    xlat_mutableRt = Rt;
    xlat_mutable_Exposure = _Exposure;
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.worldPos = vec3(xlv_TEXCOORD0);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* NOTE: GLSL optimization failed
0:0(0): error: no matching function for call to `xll_transpose(mat2)'
0:0(0): error: no matching function for call to `xll_transpose(mat3)'
0:0(0): error: no matching function for call to `xll_transpose(mat4)'
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:268(2): warning: empty declaration
0:65(2): warning: empty declaration
*/


#endif"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
out highp vec3 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
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
highp float xlat_mutable_Exposure;
in highp vec3 xlv_TEXCOORD0;
void main ()
{
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
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) - ((4.0 * tmpvar_6) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (Rg * Rg))));
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
  highp float tmpvar_16;
  tmpvar_16 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_12.x = (tmpvar_5.x + _viewdirOffset);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(viewdir_12);
  viewdir_12 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = sqrt(dot (camera_11, camera_11));
  r_14 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (camera_11, tmpvar_17);
  rMu_13 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = max ((-(tmpvar_19) - sqrt((((tmpvar_19 * tmpvar_19) - (tmpvar_18 * tmpvar_18)) + (tmpvar_16 * tmpvar_16)))), 0.0);
  if ((tmpvar_20 > 0.0)) {
    camera_11 = (camera_11 + (tmpvar_20 * tmpvar_17));
    rMu_13 = (tmpvar_19 + tmpvar_20);
    r_14 = tmpvar_16;
  };
  highp float tmpvar_21;
  tmpvar_21 = dot (tmpvar_17, _Sun_WorldSunDir);
  highp float tmpvar_22;
  tmpvar_22 = (dot (camera_11, _Sun_WorldSunDir) / r_14);
  highp vec4 tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((tmpvar_16 * tmpvar_16) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = sqrt(((r_14 * r_14) - (Rg * Rg)));
  highp float tmpvar_26;
  tmpvar_26 = (r_14 * (rMu_13 / r_14));
  highp float tmpvar_27;
  tmpvar_27 = (((tmpvar_26 * tmpvar_26) - (r_14 * r_14)) + (Rg * Rg));
  highp vec4 tmpvar_28;
  if (((tmpvar_26 < 0.0) && (tmpvar_27 > 0.0))) {
    highp vec4 tmpvar_29;
    tmpvar_29.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_29.w = (0.5 - (0.5 / RES_MU));
    tmpvar_28 = tmpvar_29;
  } else {
    highp vec4 tmpvar_30;
    tmpvar_30.x = -1.0;
    tmpvar_30.y = (tmpvar_24 * tmpvar_24);
    tmpvar_30.z = tmpvar_24;
    tmpvar_30.w = (0.5 + (0.5 / RES_MU));
    tmpvar_28 = tmpvar_30;
  };
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_R) + ((tmpvar_25 / tmpvar_24) * (1.0 - (1.0/(RES_R)))));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28.w + ((((tmpvar_26 * tmpvar_28.x) + sqrt((tmpvar_27 + tmpvar_28.y))) / (tmpvar_25 + tmpvar_28.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_33;
  y_over_x_33 = (max (tmpvar_22, -0.1975) * 5.34962);
  highp float x_34;
  x_34 = (y_over_x_33 * inversesqrt(((y_over_x_33 * y_over_x_33) + 1.0)));
  highp float tmpvar_35;
  tmpvar_35 = ((0.5 / RES_MU_S) + (((((sign(x_34) * (1.5708 - (sqrt((1.0 - abs(x_34))) * (1.5708 + (abs(x_34) * (-0.214602 + (abs(x_34) * (0.0865667 + (abs(x_34) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_36;
  tmpvar_36 = (((tmpvar_21 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_37;
  tmpvar_37 = floor(tmpvar_36);
  highp float tmpvar_38;
  tmpvar_38 = (tmpvar_36 - tmpvar_37);
  highp float tmpvar_39;
  tmpvar_39 = (floor(((tmpvar_31 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = (floor((tmpvar_31 * RES_R)) / RES_R);
  highp float tmpvar_41;
  tmpvar_41 = fract((tmpvar_31 * RES_R));
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_42.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_43;
  tmpvar_43 = textureLod (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_32 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureLod (_Inscatter, tmpvar_44.xy, 0.0);
  highp vec4 tmpvar_46;
  tmpvar_46.zw = vec2(0.0, 0.0);
  tmpvar_46.x = ((tmpvar_37 + tmpvar_35) / RES_NU);
  tmpvar_46.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_47;
  tmpvar_47 = textureLod (_Inscatter, tmpvar_46.xy, 0.0);
  highp vec4 tmpvar_48;
  tmpvar_48.zw = vec2(0.0, 0.0);
  tmpvar_48.x = (((tmpvar_37 + tmpvar_35) + 1.0) / RES_NU);
  tmpvar_48.y = ((tmpvar_32 / RES_R) + tmpvar_40);
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureLod (_Inscatter, tmpvar_48.xy, 0.0);
  tmpvar_23 = ((((tmpvar_43 * (1.0 - tmpvar_38)) + (tmpvar_45 * tmpvar_38)) * (1.0 - tmpvar_41)) + (((tmpvar_47 * (1.0 - tmpvar_38)) + (tmpvar_49 * tmpvar_38)) * tmpvar_41));
  if ((r_14 <= tmpvar_16)) {
    result_15 = ((tmpvar_23.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_21 * tmpvar_21)))) + ((((tmpvar_23.xyz * tmpvar_23.w) / max (tmpvar_23.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_21)), -1.5)) * (1.0 + (tmpvar_21 * tmpvar_21))) / (2.0 + (mieG * mieG)))));
  } else {
    result_15 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_15 * _Sun_Intensity);
  highp float tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = dot (tmpvar_5, tmpvar_5);
  highp float tmpvar_52;
  tmpvar_52 = (2.0 * dot (tmpvar_5, (tmpvar_4 - _Globals_Origin)));
  highp float tmpvar_53;
  tmpvar_53 = ((tmpvar_52 * tmpvar_52) - ((4.0 * tmpvar_51) * (((dot (_Globals_Origin, _Globals_Origin) + dot (tmpvar_4, tmpvar_4)) - (2.0 * dot (_Globals_Origin, tmpvar_4))) - (tmpvar_16 * tmpvar_16))));
  if ((tmpvar_53 < 0.0)) {
    tmpvar_50 = -1.0;
  } else {
    highp float tmpvar_54;
    tmpvar_54 = ((-(tmpvar_52) - sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
    highp float tmpvar_55;
    if ((tmpvar_54 < 0.0)) {
      tmpvar_55 = ((-(tmpvar_52) + sqrt(tmpvar_53)) / (2.0 * tmpvar_51));
    } else {
      tmpvar_55 = tmpvar_54;
    };
    tmpvar_50 = tmpvar_55;
  };
  if ((tmpvar_50 != -1.0)) {
    worldPos_2 = (tmpvar_4 + (tmpvar_5 * tmpvar_50));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_50 != -1.0)) {
    int j_56;
    int i_57;
    i_57 = 0;
    for (int i_57 = 0; i_57 < 4; ) {
      if ((lightOccluders1[3][i_57] <= 0.0)) {
        break;
      };
      highp vec4 v_58;
      v_58.x = lightOccluders1[0][i_57];
      v_58.y = lightOccluders1[1][i_57];
      v_58.z = lightOccluders1[2][i_57];
      v_58.w = lightOccluders1[3][i_57];
      highp vec3 tmpvar_59;
      tmpvar_59 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_60;
      tmpvar_60 = sqrt(dot (tmpvar_59, tmpvar_59));
      highp vec3 tmpvar_61;
      tmpvar_61 = (tmpvar_59 / vec3(tmpvar_60));
      highp vec3 tmpvar_62;
      tmpvar_62 = (v_58.xyz - worldPos_2);
      highp float tmpvar_63;
      tmpvar_63 = sqrt(dot (tmpvar_62, tmpvar_62));
      highp vec3 tmpvar_64;
      tmpvar_64 = (tmpvar_62 / tmpvar_63);
      highp vec3 tmpvar_65;
      tmpvar_65 = ((tmpvar_61.yzx * tmpvar_64.zxy) - (tmpvar_61.zxy * tmpvar_64.yzx));
      highp float tmpvar_66;
      tmpvar_66 = min (1.0, sqrt(dot (tmpvar_65, tmpvar_65)));
      highp float tmpvar_67;
      tmpvar_67 = min (1.0, (vec3(lightOccluders1[3][i_57]) / tmpvar_63).x);
      highp float t_68;
      t_68 = max (min ((((-((vec3(tmpvar_60) * ((sign(tmpvar_66) * (1.5708 - (sqrt((1.0 - abs(tmpvar_66))) * (1.5708 + (abs(tmpvar_66) * (-0.214602 + (abs(tmpvar_66) * (0.0865667 + (abs(tmpvar_66) * -0.0310296))))))))) - (sign(tmpvar_67) * (1.5708 - (sqrt((1.0 - abs(tmpvar_67))) * (1.5708 + (abs(tmpvar_67) * (-0.214602 + (abs(tmpvar_67) * (0.0865667 + (abs(tmpvar_67) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_69;
      t_69 = max (min ((dot (tmpvar_61, tmpvar_64) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_68 * (t_68 * (3.0 - (2.0 * t_68)))) * (t_69 * (t_69 * (3.0 - (2.0 * t_69)))))));
      i_57 = (i_57 + 1);
    };
    j_56 = 0;
    for (int j_56 = 0; j_56 < 4; ) {
      if ((lightOccluders2[3][j_56] <= 0.0)) {
        break;
      };
      highp vec4 v_70;
      v_70.x = lightOccluders2[0][j_56];
      v_70.y = lightOccluders2[1][j_56];
      v_70.z = lightOccluders2[2][j_56];
      v_70.w = lightOccluders2[3][j_56];
      highp vec3 tmpvar_71;
      tmpvar_71 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_72;
      tmpvar_72 = sqrt(dot (tmpvar_71, tmpvar_71));
      highp vec3 tmpvar_73;
      tmpvar_73 = (tmpvar_71 / vec3(tmpvar_72));
      highp vec3 tmpvar_74;
      tmpvar_74 = (v_70.xyz - worldPos_2);
      highp float tmpvar_75;
      tmpvar_75 = sqrt(dot (tmpvar_74, tmpvar_74));
      highp vec3 tmpvar_76;
      tmpvar_76 = (tmpvar_74 / tmpvar_75);
      highp vec3 tmpvar_77;
      tmpvar_77 = ((tmpvar_73.yzx * tmpvar_76.zxy) - (tmpvar_73.zxy * tmpvar_76.yzx));
      highp float tmpvar_78;
      tmpvar_78 = min (1.0, sqrt(dot (tmpvar_77, tmpvar_77)));
      highp float tmpvar_79;
      tmpvar_79 = min (1.0, (vec3(lightOccluders2[3][j_56]) / tmpvar_75).x);
      highp float t_80;
      t_80 = max (min ((((-((vec3(tmpvar_72) * ((sign(tmpvar_78) * (1.5708 - (sqrt((1.0 - abs(tmpvar_78))) * (1.5708 + (abs(tmpvar_78) * (-0.214602 + (abs(tmpvar_78) * (0.0865667 + (abs(tmpvar_78) * -0.0310296))))))))) - (sign(tmpvar_79) * (1.5708 - (sqrt((1.0 - abs(tmpvar_79))) * (1.5708 + (abs(tmpvar_79) * (-0.214602 + (abs(tmpvar_79) * (0.0865667 + (abs(tmpvar_79) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_81;
      t_81 = max (min ((dot (tmpvar_73, tmpvar_76) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_80 * (t_80 * (3.0 - (2.0 * t_80)))) * (t_81 * (t_81 * (3.0 - (2.0 * t_81)))))));
      j_56 = (j_56 + 1);
    };
  };
  highp vec3 L_82;
  highp vec3 tmpvar_83;
  tmpvar_83 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_82 = tmpvar_83;
  highp float tmpvar_84;
  if ((tmpvar_83.x < 1.413)) {
    tmpvar_84 = pow ((tmpvar_83.x * 0.38317), 0.454545);
  } else {
    tmpvar_84 = (1.0 - exp(-(tmpvar_83.x)));
  };
  L_82.x = tmpvar_84;
  highp float tmpvar_85;
  if ((tmpvar_83.y < 1.413)) {
    tmpvar_85 = pow ((tmpvar_83.y * 0.38317), 0.454545);
  } else {
    tmpvar_85 = (1.0 - exp(-(tmpvar_83.y)));
  };
  L_82.y = tmpvar_85;
  highp float tmpvar_86;
  if ((tmpvar_83.z < 1.413)) {
    tmpvar_86 = pow ((tmpvar_83.z * 0.38317), 0.454545);
  } else {
    tmpvar_86 = (1.0 - exp(-(tmpvar_83.z)));
  };
  L_82.z = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87.w = 1.0;
  tmpvar_87.xyz = (_Alpha_Global * L_82);
  _glesFragData[0] = tmpvar_87;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "ECLIPSES_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 234 math, 8 textures
Keywords { "ECLIPSES_OFF" }
Vector 0 [_WorldSpaceCameraPos]
Float 1 [M_PI]
Vector 2 [betaR]
Float 3 [mieG]
Float 4 [_Exposure]
Float 5 [Rg]
Float 6 [Rt]
Float 7 [RES_R]
Float 8 [RES_MU]
Float 9 [RES_MU_S]
Float 10 [RES_NU]
Float 11 [_Sun_Intensity]
Float 12 [_experimentalAtmoScale]
Float 13 [_viewdirOffset]
Float 14 [_Alpha_Global]
Vector 15 [_Globals_Origin]
Float 16 [_RimExposure]
Vector 17 [_Sun_WorldSunDir]
SetTexture 0 [_Inscatter] 2D 0
"ps_3_0
dcl_2d s0
def c18, 6000.00000000, 0.00000100, 0.00000000, 1.00000000
def c19, 16.00000000, -0.19750001, 5.34960032, -1.00000000
def c20, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c21, -0.33299461, 0.99999559, 1.57079601, 0.50000000
def c22, 0.90909088, 0.74000001, 3.00000000, 4.00000000
def c23, 2.00000000, -1.50000000, 0.00010000, 1.50000000
def c24, -1.41299999, 2.71828198, 0.38317001, 0.45454544
dcl_texcoord0 v0.xyz
add r0.xyz, v0, -c0
dp3 r0.w, r0, r0
mov r1.xyz, c0
mul r3.xyz, c18.x, r1
add r4.xyz, r3, -c15
rcp r6.w, c8.x
rsq r0.w, r0.w
mul r5.xyz, r0.w, r0
dp3 r1.x, r4, r4
rsq r1.y, r1.x
rcp r1.w, r1.y
mov r1.x, c6
add r1.x, -c5, r1
mul r1.x, r1, c12
add r3.w, r1.x, c5.x
mul r6.y, c5.x, c5.x
mad r2.w, r6, c21, c21
add r0.x, r5, c13
mov r0.yz, r5
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.w, r4, r0
mul r1.y, r1.w, r1.w
mad r1.y, r0.w, r0.w, -r1
mad r1.x, r3.w, r3.w, r1.y
rsq r1.y, r1.x
rcp r1.y, r1.y
cmp r1.x, r1, r1.y, c18.y
add r1.x, -r0.w, -r1
max r2.x, r1, c18.z
cmp r4.w, -r2.x, r1, r3
mad r1.xyz, r2.x, r0, r4
cmp r1.xyz, -r2.x, r4, r1
dp3 r5.w, r0, c17
dp3 r1.x, r1, c17
rcp r1.w, r4.w
mul r1.x, r1, r1.w
max r1.x, r1, c19.y
mul r1.x, r1, c19.z
abs r1.y, r1.x
max r1.z, r1.y, c18.w
rcp r1.w, r1.z
min r1.z, r1.y, c18.w
mul r1.z, r1, r1.w
mul r1.w, r1.z, r1.z
mad r2.y, r1.w, c20.x, c20
mad r2.y, r2, r1.w, c20.z
mad r2.y, r2, r1.w, c20.w
mad r2.y, r2, r1.w, c21.x
mad r1.w, r2.y, r1, c21.y
mul r1.z, r1.w, r1
add r1.w, -r1.z, c21.z
add r1.y, r1, c19.w
cmp r1.y, -r1, r1.z, r1.w
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c10.x
add r0.y, c19.w, r1
add r0.x, r5.w, c18.w
mul r0.y, r0.x, r0
mad r0.x, r1, c22, c22.y
mul r1.x, r0.y, c21.w
frc r7.w, r1.x
rcp r0.y, c9.x
add r0.z, -r0.y, c18.w
mad r0.x, r0, r0.z, r0.y
mad r0.z, r3.w, r3.w, -r6.y
add r1.x, r1, -r7.w
mad r1.w, r0.x, c21, r1.x
add r0.x, r2, r0.w
cmp r1.y, -r2.x, r0.w, r0.x
rsq r6.z, r0.z
rcp r0.w, r6.z
add r0.y, r1.w, c18.w
rcp r6.x, c10.x
mul r1.x, r6, r0.y
mul r0.y, r4.w, r4.w
mad r0.y, r1, r1, -r0
mad r1.z, c5.x, c5.x, r0.y
mul r6.x, r1.w, r6
cmp r0.x, r1.y, c18.z, c18.w
cmp r0.y, -r1.z, c18.z, c18.w
mul_pp r7.x, r0, r0.y
mul r2.y, r0.w, r0.w
mov r2.z, r0.w
mov r2.x, c19.w
mad r0.w, -r6, c21, c21
mov r0.xyz, c18.wzzw
cmp r0, -r7.x, r2, r0
add r0.y, r0, r1.z
rsq r1.z, r0.y
mad r2.x, r4.w, r4.w, -r6.y
rsq r0.y, r2.x
rcp r2.x, c7.x
rcp r0.y, r0.y
mul r2.y, r6.z, r0
add r2.z, -r2.x, c18.w
mul r2.y, r2, r2.z
rcp r1.z, r1.z
add r0.y, r0.z, r0
mad r1.y, r1, r0.x, r1.z
mad r2.y, r2.x, c21.w, r2
mul r0.x, r2.y, c7
add r0.z, r0.x, c19.w
rcp r0.y, r0.y
frc r1.z, r0
mul r0.y, r1, r0
add r1.y, r0.z, -r1.z
add r0.z, -r6.w, c21.w
mul r1.z, r1.y, r2.x
mad r1.y, r0, r0.z, r0.w
mad r7.y, r1, r2.x, r1.z
frc r6.w, r0.x
add r1.z, r0.x, -r6.w
mul r2.y, r2.x, r1.z
mad r1.y, r1, r2.x, r2
mov r1.z, c18
texldl r2, r1.xyzz, s0
mov r6.y, r1
mov r7.x, r1
mov r6.z, c18
texldl r1, r6.xyzz, s0
mov r7.z, c18
texldl r0, r7.xyzz, s0
add r6.y, -r7.w, c18.w
mul r2, r7.w, r2
mad r1, r6.y, r1, r2
mul r2, r7.w, r0
mov r0.x, r6
mov r0.z, c18
mov r0.y, r7
texldl r0, r0.xyzz, s0
mad r0, r0, r6.y, r2
add r2.x, -r6.w, c18.w
mul r1, r6.w, r1
mad r1, r0, r2.x, r1
mul r0.xyz, r1, r1.w
max r1.w, r1.x, c23.z
rcp r2.x, r1.w
mul r0.w, r5, c3.x
mul r0.w, r0, c23.x
mad r0.w, c3.x, c3.x, -r0
add r1.w, r0, c18
mul r2.xyz, r0, r2.x
pow r0, r1.w, c23.y
mov r0.w, r0.x
mul r0.y, -c3.x, c3.x
add r0.z, r0.y, c18.w
mov r0.x, c1
mul r0.x, c22.w, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.z
add r0.y, -r0, c23.x
mul r0.x, r0, r0.w
mad r1.w, r5, r5, c18
mul r0.z, r1.w, r0.x
mov r0.x, c1
mul r0.x, c19, r0
rcp r0.w, r0.x
mul r0.w, r0, r1
mul r1.xyz, r0.w, r1
rcp r0.y, r0.y
dp3 r1.w, r3, r3
dp3 r0.w, c15, c15
add r1.w, r0, r1
dp3 r0.w, r3, c15
mad r0.w, -r0, c23.x, r1
mad r0.w, -c5.x, c5.x, r0
rcp r6.x, c2.x
rcp r6.z, c2.z
rcp r6.y, c2.y
mul r6.xyz, r6, c2.x
mul r2.xyz, r2, r6
mul r0.y, r0.z, r0
mul r0.xyz, r0.y, r2
mul r0.xyz, r0, c23.w
mad r0.xyz, r1, c22.z, r0
dp3 r1.y, r5, r5
mul r1.x, r1.y, r0.w
mul r2.x, r1.y, c23
dp3 r0.w, r4, r5
mul r1.z, r1.x, c22.w
mul r1.x, r0.w, c23
mad r1.z, r1.x, r1.x, -r1
rsq r1.w, r1.z
rcp r1.y, r1.w
add r0.w, -r4, r3
cmp r0.w, r0, c18, c18.z
abs_pp r0.w, r0
cmp r0.xyz, -r0.w, c18.z, r0
rcp r1.w, r2.x
add r1.x, -r1, -r1.y
mul r1.x, r1, r1.w
cmp r1.x, r1.z, r1, c19.w
cmp r0.w, -r1.x, c18.z, c18
mov r1.x, c4
abs_pp r0.w, r0
cmp r0.w, -r0, c16.x, r1.x
mul r0.xyz, r0, c11.x
mul r2.xyz, r0, r0.w
mul r3.x, r2.z, c24.z
pow r0, r3.x, c24.w
pow r1, c24.y, -r2.z
add r2.w, r2.z, c24.x
mov r0.y, r1.x
mov r0.z, r0.x
mul r3.x, r2, c24.z
pow r1, r3.x, c24.w
add r0.x, -r0.y, c18.w
cmp r2.z, r2.w, r0.x, r0
pow r0, c24.y, -r2.x
add r2.w, r2.x, c24.x
mov r0.y, r1.x
add r0.x, -r0, c18.w
cmp r2.x, r2.w, r0, r0.y
pow r0, c24.y, -r2.y
mul r3.x, r2.y, c24.z
pow r1, r3.x, c24.w
add r2.w, r2.y, c24.x
mov r0.y, r1.x
add r0.x, -r0, c18.w
cmp r2.y, r2.w, r0.x, r0
mul oC0.xyz, r2, c14.x
mov oC0.w, c18
"
}
SubProgram "d3d11 " {
// Stats: 158 math
Keywords { "ECLIPSES_OFF" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 352
Float 32 [M_PI]
Vector 64 [betaR] 3
Float 108 [mieG]
Float 112 [_Exposure]
Float 116 [Rg]
Float 120 [Rt]
Float 128 [RES_R]
Float 132 [RES_MU]
Float 136 [RES_MU_S]
Float 140 [RES_NU]
Float 160 [_Sun_Intensity]
Float 164 [_experimentalAtmoScale]
Float 168 [_viewdirOffset]
Float 172 [_Alpha_Global]
Vector 320 [_Globals_Origin] 3
Float 332 [_RimExposure]
Vector 336 [_Sun_WorldSunDir] 3
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedmommagojpbfchdbpeoeimiaiidhglcipabaaaaaajabgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnabfaaaa
eaaaaaaaheafaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aiaaaaaadgaaaaaihcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaafbcaabaaaabaaaaaaabeaaaaaaaaaialpaaaaaaajhcaabaaa
acaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaa
acaaaaaadkaabaaaacaaaaaadcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaackiacaaaaaaaaaaaakaaaaaadiaaaaahocaabaaaadaaaaaa
pgapbaaaacaaaaaaagajbaaaacaaaaaabaaaaaahbcaabaaaacaaaaaaigadbaaa
adaaaaaaigadbaaaadaaaaaaeeaaaaafbcaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaaigadbaaaadaaaaaadcaaaaap
hcaabaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaaaaiallefaaiallef
aaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabeaaaaaabaaaaaahccaabaaa
afaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaakbcaabaaaadaaaaaabkaabaaa
afaaaaaabkaabaaaafaaaaaadkaabaiaebaaaaaaacaaaaaaelaaaaafbcaabaaa
afaaaaaadkaabaaaacaaaaaaaaaaaaakicaabaaaacaaaaaabkiacaiaebaaaaaa
aaaaaaaaahaaaaaackiacaaaaaaaaaaaahaaaaaadcaaaaalbcaabaaaagaaaaaa
dkaabaaaacaaaaaabkiacaaaaaaaaaaaakaaaaaabkiacaaaaaaaaaaaahaaaaaa
dcaaaaajicaabaaaacaaaaaaakaabaaaagaaaaaaakaabaaaagaaaaaaakaabaaa
adaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaabkaabaiaebaaaaaaafaaaaaadeaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahccaabaaa
agaaaaaadkaabaaaacaaaaaabkaabaaaafaaaaaadbaaaaahbcaabaaaadaaaaaa
abeaaaaaaaaaaaaadkaabaaaacaaaaaadcaaaaajhcaabaaaahaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaabaaaaaaibcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaadhaaaaajocaabaaaacaaaaaa
agaabaaaadaaaaaaagajbaaaahaaaaaaagajbaaaaeaaaaaabaaaaaahbcaabaaa
aeaaaaaajgahbaaaadaaaaaaegacbaaaaeaaaaaabaaaaaahccaabaaaadaaaaaa
jgahbaaaadaaaaaajgahbaaaadaaaaaadhaaaaajfcaabaaaadaaaaaaagaabaaa
adaaaaaaagabbaaaagaaaaaaagabbaaaafaaaaaabaaaaaaiccaabaaaacaaaaaa
jgahbaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaaaoaaaaahccaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaadeaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaahbdneklodiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
abeaaaaabodakleadiaaaaahecaabaaaacaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaadcaaaaakecaabaaaacaaaaaackaabaaaadaaaaaackaabaaaadaaaaaa
ckaabaiaebaaaaaaacaaaaaadcaaaaalecaabaaaacaaaaaabkiacaaaaaaaaaaa
ahaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaacaaaaaadbaaaaahicaabaaa
acaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaadbaaaaahicaabaaaadaaaaaa
ckaabaaaadaaaaaaabeaaaaaaaaaaaaaabaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaadkaabaaaadaaaaaadiaaaaajicaabaaaadaaaaaabkiacaaaaaaaaaaa
ahaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaakccaabaaaaeaaaaaaakaabaaa
agaaaaaaakaabaaaagaaaaaadkaabaiaebaaaaaaadaaaaaabnaaaaahecaabaaa
aeaaaaaaakaabaaaagaaaaaaakaabaaaadaaaaaadcaaaaakbcaabaaaadaaaaaa
akaabaaaadaaaaaaakaabaaaadaaaaaadkaabaiaebaaaaaaadaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaaelaaaaafecaabaaaabaaaaaabkaabaaa
aeaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
aoaaaaalhcaabaaaafaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
bgigcaaaaaaaaaaaaiaaaaaaaaaaaaaiicaabaaaaaaaaaaaakaabaiaebaaaaaa
afaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaaabaaaaaaakaabaaaafaaaaaa
abeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaapgapbaaaacaaaaaaegaobaaa
aaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaadaaaaaa
ckaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
adaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaackaabaaaacaaaaaa
elaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaalocaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaaaiaaaaaa
aaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaiadpaaaaaadpaaaaiadpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaafaaaaaadcaaaaakecaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaebaaaaaf
ecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaaifcaabaaaaaaaaaaaagacbaaa
aaaaaaaaagiacaaaaaaaaaaaaiaaaaaaaaaaaaahecaabaaaagaaaaaackaabaaa
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
bcaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaah
ccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaaiccaabaaaagaaaaaackaabaaaaaaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaaoaaaaaibcaabaaaagaaaaaaakaabaaaabaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaaagaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaa
afaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
aaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
dcaaaaajpcaabaaaabaaaaaaegaobaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaaaaaaaaaabkaaaaafccaabaaa
aaaaaaaabkaabaaaaaaaaaaaaoaaaaaiccaabaaaacaaaaaabkaabaaaacaaaaaa
akiacaaaaaaaaaaaaiaaaaaaaaaaaaahicaabaaaagaaaaaaakaabaaaaaaaaaaa
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
agiacaaaaaaaaaaaaeaaaaaaagijcaaaaaaaaaaaaeaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaajgahbaaaacaaaaaaapaaaaaiicaabaaaaaaaaaaa
agaabaaaacaaaaaapgipcaaaaaaaaaaaagaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaa
acaaaaaapgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaa
aaaaiadpaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaaakaabaaaacaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalp
bjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaambcaabaaaacaaaaaa
dkiacaiaebaaaaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaa
aaaaiadpdiaaaaalmcaabaaaacaaaaaaagiacaaaaaaaaaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiaebaaaaiaeaaoaaaaakmcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaeaeaaaaamadpkgaobaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahecaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaa
acaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaakgakbaaaacaaaaaaegacbaaa
abaaaaaaabaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaakgakbaaaaeaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaa
baaaaaajicaabaaaaaaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaa
beaaaaaadiaaaaalhcaabaaaabaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaibcaabaaaabaaaaaaegiccaaaaaaaaaaa
beaaaaaaegacbaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaaeadkaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaia
ebaaaaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadkaabaaaaaaaaaaa
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
aaaaaaaabeaaaaaaakiacaaaaaaaaaaaahaaaaaadiaaaaahhcaabaaaaaaaaaaa
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
aaaaaaaaegacbaaaaaaaaaaapgipcaaaaaaaaaaaakaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "ECLIPSES_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 682 math, 8 textures, 15 branches
Keywords { "ECLIPSES_ON" }
Matrix 0 [lightOccluders1]
Matrix 4 [lightOccluders2]
Vector 8 [_WorldSpaceCameraPos]
Float 9 [M_PI]
Vector 10 [betaR]
Float 11 [mieG]
Float 12 [_Exposure]
Float 13 [Rg]
Float 14 [Rt]
Float 15 [RES_R]
Float 16 [RES_MU]
Float 17 [RES_MU_S]
Float 18 [RES_NU]
Float 19 [_Sun_Intensity]
Float 20 [_experimentalAtmoScale]
Float 21 [_viewdirOffset]
Float 22 [_Alpha_Global]
Vector 23 [_Globals_Origin]
Float 24 [_RimExposure]
Vector 25 [_Sun_WorldSunDir]
Vector 26 [sunPosAndRadius]
SetTexture 0 [_Inscatter] 2D 0
"ps_3_0
dcl_2d s0
def c27, 6000.00000000, 2.00000000, 4.00000000, -1.00000000
def c28, 0.00000000, 1.00000000, 0.00000100, 16.00000000
def c29, -0.19750001, 5.34960032, -0.01348047, 0.05747731
def c30, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c31, 1.57079601, 0.90909088, 0.74000001, 0.50000000
def c32, 3.00000000, -1.50000000, 0.00010000, 1.50000000
def c33, -1.00000000, 0.00000000, 2.00000000, -0.21211439
def c34, -0.01872930, 0.07426100, 1.57072902, 5.00000000
def c35, 2.00000000, 3.00000000, 0.38317001, 0.45454544
def c36, 2.71828198, -1.41299999, 0, 0
dcl_texcoord0 v0.xyz
rcp r7.x, c16.x
add r2.xyz, v0, -c8
dp3 r0.x, r2, r2
rsq r0.x, r0.x
mul r2.xyz, r0.x, r2
mov r0.xyz, c8
mul r0.xyz, c27.x, r0
mov r1.w, c14.x
add r1.w, -c13.x, r1
add r3.xyz, r0, -c23
add r4.x, r2, c21
mov r4.yz, r2
dp3 r0.w, r4, r4
rsq r0.w, r0.w
mul r4.xyz, r0.w, r4
dp3 r0.w, r3, r3
rsq r0.w, r0.w
rcp r3.w, r0.w
dp3 r6.x, r3, r4
mul r0.w, r3, r3
mul r2.w, r1, c20.x
mad r1.w, r6.x, r6.x, -r0
add r0.w, r2, c13.x
mad r2.w, r0, r0, r1
rsq r1.w, r2.w
rcp r1.w, r1.w
cmp r1.w, r2, r1, c28.z
add r1.w, -r6.x, -r1
max r4.w, r1, c28.x
mad r5.xyz, r4.w, r4, r3
cmp r5.xyz, -r4.w, r3, r5
cmp r1.w, -r4, r3, r0
dp3 r3.w, r5, c25
rcp r2.w, r1.w
mul r2.w, r3, r2
max r2.w, r2, c29.x
mul r5.z, r2.w, c29.y
abs r5.y, r5.z
max r2.w, r5.y, c28.y
dp3 r3.y, r2, r3
min r3.w, r5.y, c28.y
rcp r2.w, r2.w
mul r5.x, r3.w, r2.w
mul r3.w, r5.x, r5.x
mad r2.w, r3, c29.z, c29
mad r2.w, r2, r3, c30.x
mad r2.w, r2, r3, c30.y
mad r2.w, r2, r3, c30.z
mad r2.w, r2, r3, c30
mul r3.w, r2, r5.x
add r5.x, r5.y, c27.w
add r2.w, -r3, c31.x
cmp r2.w, -r5.x, r3, r2
cmp r5.x, r5.z, r2.w, -r2.w
dp3 r2.w, r4, c25
rcp r4.z, c17.x
mov r3.w, c18.x
add r4.x, r2.w, c28.y
add r3.w, c27, r3
mul r3.w, r4.x, r3
mul r4.x, r3.w, c31.w
frc r3.w, r4.x
add r4.x, r4, -r3.w
rcp r5.w, c18.x
mul r7.y, c13.x, c13.x
mad r6.w, r7.x, c31, c31
mad r5.x, r5, c31.y, c31.z
add r4.y, -r4.z, c28
mad r4.y, r5.x, r4, r4.z
mad r8.x, r4.y, c31.w, r4
add r4.x, r8, c28.y
mul r5.x, r5.w, r4
add r4.y, r4.w, r6.x
cmp r5.y, -r4.w, r6.x, r4
mul r4.x, r1.w, r1.w
mad r4.x, r5.y, r5.y, -r4
mad r7.z, c13.x, c13.x, r4.x
mad r4.x, r0.w, r0.w, -r7.y
rsq r5.z, r4.x
rcp r4.w, r5.z
cmp r4.z, r5.y, c28.x, c28.y
cmp r4.y, -r7.z, c28.x, c28
mul_pp r7.w, r4.z, r4.y
mul r6.y, r4.w, r4.w
mov r6.z, r4.w
mul r8.x, r8, r5.w
mov r6.x, c27.w
mad r4.w, -r7.x, c31, c31
mov r4.xyz, c28.yxxw
cmp r4, -r7.w, r6, r4
add r6.y, r4, r7.z
mad r4.y, r1.w, r1.w, -r7
rsq r4.y, r4.y
rcp r4.y, r4.y
mul r5.z, r5, r4.y
rcp r6.w, c15.x
rsq r6.z, r6.y
add r6.y, -r6.w, c28
mul r5.z, r5, r6.y
rcp r6.y, r6.z
mad r6.y, r5, r4.x, r6
mad r5.z, r6.w, c31.w, r5
mul r4.x, r5.z, c15
add r4.y, r4.z, r4
rcp r5.y, r4.y
add r4.z, r4.x, c27.w
frc r4.y, r4.z
add r4.y, r4.z, -r4
mul r4.y, r4, r6.w
frc r8.w, r4.x
add_pp r1.w, r1, -r0
mov r6.x, r5
mul r5.y, r6, r5
add r4.z, -r7.x, c31.w
mad r7.x, r5.y, r4.z, r4.w
add r5.y, r4.x, -r8.w
mul r5.y, r6.w, r5
mad r5.y, r7.x, r6.w, r5
mad r6.y, r7.x, r6.w, r4
mov r6.z, c28.x
texldl r4, r6.xyzz, s0
mov r5.z, c28.x
texldl r7, r5.xyzz, s0
mul r7, r3.w, r7
mov r8.y, r5
mov r8.z, c28.x
texldl r5, r8.xyzz, s0
add r8.y, -r3.w, c28
mad r5, r8.y, r5, r7
mul r4, r3.w, r4
mul r5, r8.w, r5
add r3.w, -r8, c28.y
mov r6.x, r8
mov r6.z, c28.x
texldl r6, r6.xyzz, s0
mad r4, r6, r8.y, r4
mad r4, r4, r3.w, r5
mul r3.w, r2, c11.x
mul r5.xyz, r4, r4.w
mul r4.w, r3, c27.y
max r3.w, r4.x, c32.z
rcp r3.w, r3.w
mad r4.w, c11.x, c11.x, -r4
add r4.w, r4, c28.y
pow r6, r4.w, c32.y
mul r5.xyz, r5, r3.w
mul r5.w, -c11.x, c11.x
mov r3.w, r6.x
mov r4.w, c9.x
mul r6.x, c27.z, r4.w
add r4.w, r5, c28.y
rcp r6.x, r6.x
mul r4.w, r6.x, r4
mul r3.w, r4, r3
mad r4.w, r2, r2, c28.y
add r2.w, -r5, c27.y
mov r5.w, c9.x
mul r3.w, r4, r3
rcp r2.w, r2.w
mul r2.w, r3, r2
mul r5.w, c28, r5
rcp r3.w, r5.w
rcp r7.x, c10.x
rcp r7.z, c10.z
rcp r7.y, c10.y
mul r7.xyz, r7, c10.x
mul r5.xyz, r5, r7
mul r5.xyz, r2.w, r5
mul r2.w, r3, r4
mul r4.xyz, r2.w, r4
mul r5.xyz, r5, c32.w
mad r4.xyz, r4, c32.x, r5
dp3 r4.w, r2, r2
dp3 r2.w, r0, r0
dp3 r3.w, c23, c23
add r2.w, r3, r2
dp3 r3.w, r0, c23
mad r2.w, -r3, c27.y, r2
mad r3.w, -r0, r0, r2
mul r3.w, r4, r3
mul r3.x, r3.w, c27.z
mul r3.w, r3.y, c27.y
mad r5.x, r3.w, r3.w, -r3
cmp r3.xyz, -r1.w, r4, c28.x
rsq r0.w, r5.x
rcp r4.x, r0.w
mul r1.w, r4, c27.y
mad r2.w, -c13.x, c13.x, r2
mul r2.w, r4, r2
mul r2.w, r2, c27.z
mad r4.z, r3.w, r3.w, -r2.w
rcp r4.y, r1.w
add r0.w, -r3, -r4.x
mul r1.w, r4.y, r0
add r0.w, -r3, r4.x
mul r0.w, r4.y, r0
cmp r0.w, r1, r1, r0
cmp_pp r2.w, r5.x, c28.y, c28.x
cmp r1.w, r5.x, r1.x, c27
cmp r1.w, -r2, r1, r0
rsq r4.x, r4.z
rcp r2.w, r4.x
add r0.w, r1, c28.y
add r2.w, -r3, -r2
mad r0.xyz, r2, r1.w, r0
abs r0.w, r0
cmp r1.xyz, -r0.w, r1, r0
mul r2.w, r2, r4.y
cmp r2.x, r4.z, r2.w, c27.w
cmp r0.y, -r2.x, c28.x, c28
mov r0.x, c12
abs_pp r0.y, r0
cmp r0.w, -r0.y, c24.x, r0.x
mul r3.xyz, r3, c19.x
mov r2.w, c28.y
if_ne r1.w, c27.w
mov_pp r0.x, c0.w
cmp_pp r1.w, -r0.x, c33.x, c33.y
if_eq r1.w, c28.x
add r0.xyz, -r1, c0
dp3 r2.w, r0, r0
rsq r3.w, r2.w
mul r0.xyz, r3.w, r0
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r2.w, r4.x
mul r2.xyz, r2.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.x, r4, c28.y
abs r4.z, r5.x
mad r4.x, r4.z, c34, c34.y
mad r4.x, r4.z, r4, c33.w
add r4.y, -r4.z, c28
rsq r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mul r3.w, r3, c0
rcp r4.y, r4.y
min r4.z, r3.w, c28.y
mad r4.w, -r4.y, r4.x, c31.x
abs r4.y, r4.z
mad r3.w, r4.y, c34.x, c34.y
add r4.x, -r4.y, c28.y
mad r3.w, r4.y, r3, c33
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r3.w, r4.y, r3, c34.z
mad r3.w, -r4.x, r3, c31.x
cmp r4.x, r4.z, c33.y, c33.z
mad r3.w, -r4.x, r3, r3
cmp r5.x, r5, c33.y, c33.z
mad r4.x, -r5, r4.w, r4.w
add r3.w, r4.x, -r3
rcp r4.x, r2.w
mul r0.x, r0.y, r0
rcp r2.w, c26.w
mul r3.w, r4.x, r3
mad r2.w, -r3, r2, c28.y
mul_sat r2.w, r2, c31
mul r2.x, r2.w, r2.w
mad r0.z, -r2.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r2.w, -r0.y, r0.x, c28.y
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r1.w, -c1, r0.x, r1
if_eq r1.w, c28.x
add r0.xyz, -r1, c1
dp3 r3.w, r0, r0
rsq r4.w, r3.w
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r3.w, r4.x
mul r0.xyz, r4.w, r0
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.y, r4.x, c28
abs r4.y, r5
mad r4.x, r4.y, c34, c34.y
add r4.z, -r4.y, c28.y
mad r4.x, r4.y, r4, c33.w
mad r4.y, r4, r4.x, c34.z
mul r4.x, r4.w, c1.w
rsq r4.z, r4.z
rcp r4.z, r4.z
min r4.w, r4.x, c28.y
mad r5.x, -r4.z, r4.y, c31
abs r4.z, r4.w
mad r4.x, r4.z, c34, c34.y
add r4.y, -r4.z, c28
mad r4.x, r4.z, r4, c33.w
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mad r4.x, -r4.y, r4, c31
cmp r4.y, r4.w, c33, c33.z
mad r4.x, -r4.y, r4, r4
cmp r5.y, r5, c33, c33.z
mad r4.y, -r5, r5.x, r5.x
add r4.x, r4.y, -r4
rcp r4.y, r3.w
mul r0.x, r0.y, r0
rcp r3.w, c26.w
mul r4.x, r4.y, r4
mad r3.w, -r4.x, r3, c28.y
mul_sat r3.w, r3, c31
mul r2.x, r3.w, r3.w
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r1.w, -c2, r0.x, r1
if_eq r1.w, c28.x
add r0.xyz, -r1, c2
dp3 r3.w, r0, r0
rsq r4.w, r3.w
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r3.w, r4.x
mul r0.xyz, r4.w, r0
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.y, r4.x, c28
abs r4.y, r5
mad r4.x, r4.y, c34, c34.y
add r4.z, -r4.y, c28.y
mad r4.x, r4.y, r4, c33.w
mad r4.y, r4, r4.x, c34.z
mul r4.x, r4.w, c2.w
rsq r4.z, r4.z
rcp r4.z, r4.z
min r4.w, r4.x, c28.y
mad r5.x, -r4.z, r4.y, c31
abs r4.z, r4.w
mad r4.x, r4.z, c34, c34.y
add r4.y, -r4.z, c28
mad r4.x, r4.z, r4, c33.w
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mad r4.x, -r4.y, r4, c31
cmp r4.y, r4.w, c33, c33.z
mad r4.x, -r4.y, r4, r4
cmp r5.y, r5, c33, c33.z
mad r4.y, -r5, r5.x, r5.x
add r4.x, r4.y, -r4
rcp r4.y, r3.w
mul r0.x, r0.y, r0
rcp r3.w, c26.w
mul r4.x, r4.y, r4
mad r3.w, -r4.x, r3, c28.y
mul_sat r3.w, r3, c31
mul r2.x, r3.w, r3.w
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r0.x, -c3.w, r0, r1.w
if_eq r0.x, c28.x
add r0.xyz, -r1, c3
dp3 r1.w, r0, r0
rsq r3.w, r1.w
mul r0.xyz, r3.w, r0
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r1.w, r4.x
mul r2.xyz, r1.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.x, r4, c28.y
abs r4.z, r5.x
mad r4.x, r4.z, c34, c34.y
mad r4.x, r4.z, r4, c33.w
add r4.y, -r4.z, c28
rsq r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mul r3.w, r3, c3
rcp r4.y, r4.y
min r4.z, r3.w, c28.y
mad r4.w, -r4.y, r4.x, c31.x
abs r4.y, r4.z
mad r3.w, r4.y, c34.x, c34.y
add r4.x, -r4.y, c28.y
mad r3.w, r4.y, r3, c33
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r3.w, r4.y, r3, c34.z
mad r3.w, -r4.x, r3, c31.x
cmp r4.x, r4.z, c33.y, c33.z
mad r3.w, -r4.x, r3, r3
cmp r5.x, r5, c33.y, c33.z
mad r4.x, -r5, r4.w, r4.w
add r3.w, r4.x, -r3
rcp r4.x, r1.w
mul r3.w, r4.x, r3
rcp r1.w, c26.w
mad r1.w, -r3, r1, c28.y
mul_sat r3.w, r1, c31
mul r0.x, r0.y, r0
mul r1.w, r3, r3
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r1.w, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
endif
endif
endif
mov_pp r0.x, c4.w
cmp_pp r1.w, -r0.x, c33.x, c33.y
if_eq r1.w, c28.x
add r0.xyz, -r1, c4
dp3 r3.w, r0, r0
rsq r4.w, r3.w
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r3.w, r4.x
mul r0.xyz, r4.w, r0
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.y, r4.x, c28
abs r4.y, r5
mad r4.x, r4.y, c34, c34.y
add r4.z, -r4.y, c28.y
mad r4.x, r4.y, r4, c33.w
mad r4.y, r4, r4.x, c34.z
mul r4.x, r4.w, c4.w
rsq r4.z, r4.z
rcp r4.z, r4.z
min r4.w, r4.x, c28.y
mad r5.x, -r4.z, r4.y, c31
abs r4.z, r4.w
mad r4.x, r4.z, c34, c34.y
add r4.y, -r4.z, c28
mad r4.x, r4.z, r4, c33.w
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mad r4.x, -r4.y, r4, c31
cmp r4.y, r4.w, c33, c33.z
mad r4.x, -r4.y, r4, r4
cmp r5.y, r5, c33, c33.z
mad r4.y, -r5, r5.x, r5.x
add r4.x, r4.y, -r4
rcp r4.y, r3.w
mul r0.x, r0.y, r0
rcp r3.w, c26.w
mul r4.x, r4.y, r4
mad r3.w, -r4.x, r3, c28.y
mul_sat r3.w, r3, c31
mul r2.x, r3.w, r3.w
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r1.w, -c5, r0.x, r1
if_eq r1.w, c28.x
add r0.xyz, -r1, c5
dp3 r3.w, r0, r0
rsq r4.w, r3.w
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r3.w, r4.x
mul r0.xyz, r4.w, r0
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.y, r4.x, c28
abs r4.y, r5
mad r4.x, r4.y, c34, c34.y
add r4.z, -r4.y, c28.y
mad r4.x, r4.y, r4, c33.w
mad r4.y, r4, r4.x, c34.z
mul r4.x, r4.w, c5.w
rsq r4.z, r4.z
rcp r4.z, r4.z
min r4.w, r4.x, c28.y
mad r5.x, -r4.z, r4.y, c31
abs r4.z, r4.w
mad r4.x, r4.z, c34, c34.y
add r4.y, -r4.z, c28
mad r4.x, r4.z, r4, c33.w
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mad r4.x, -r4.y, r4, c31
cmp r4.y, r4.w, c33, c33.z
mad r4.x, -r4.y, r4, r4
cmp r5.y, r5, c33, c33.z
mad r4.y, -r5, r5.x, r5.x
add r4.x, r4.y, -r4
rcp r4.y, r3.w
mul r0.x, r0.y, r0
rcp r3.w, c26.w
mul r4.x, r4.y, r4
mad r3.w, -r4.x, r3, c28.y
mul_sat r3.w, r3, c31
mul r2.x, r3.w, r3.w
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r1.w, -c6, r0.x, r1
if_eq r1.w, c28.x
add r0.xyz, -r1, c6
dp3 r3.w, r0, r0
rsq r4.w, r3.w
add r2.xyz, -r1, c26
dp3 r4.x, r2, r2
rsq r3.w, r4.x
mul r0.xyz, r4.w, r0
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r0.yzxw
mad r4.xyz, r2.yzxw, r0.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r0.x, r2, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r4.x, r4.x
rcp r4.x, r4.x
min r5.y, r4.x, c28
abs r4.y, r5
mad r4.x, r4.y, c34, c34.y
add r4.z, -r4.y, c28.y
mad r4.x, r4.y, r4, c33.w
mad r4.y, r4, r4.x, c34.z
mul r4.x, r4.w, c6.w
rsq r4.z, r4.z
rcp r4.z, r4.z
min r4.w, r4.x, c28.y
mad r5.x, -r4.z, r4.y, c31
abs r4.z, r4.w
mad r4.x, r4.z, c34, c34.y
add r4.y, -r4.z, c28
mad r4.x, r4.z, r4, c33.w
rsq r4.y, r4.y
rcp r4.y, r4.y
mad r4.x, r4.z, r4, c34.z
mad r4.x, -r4.y, r4, c31
cmp r4.y, r4.w, c33, c33.z
mad r4.x, -r4.y, r4, r4
cmp r5.y, r5, c33, c33.z
mad r4.y, -r5, r5.x, r5.x
add r4.x, r4.y, -r4
rcp r4.y, r3.w
mul r0.x, r0.y, r0
rcp r3.w, c26.w
mul r4.x, r4.y, r4
mad r3.w, -r4.x, r3, c28.y
mul_sat r3.w, r3, c31
mul r2.x, r3.w, r3.w
mad r0.z, -r3.w, c35.x, c35.y
mul r0.y, r2.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
if_ge r1.w, c28.x
mov_pp r0.x, c27.w
cmp_pp r0.x, -c7.w, r0, r1.w
if_eq r0.x, c28.x
add r0.xyz, -r1, c7
dp3 r1.w, r0, r0
rsq r3.w, r1.w
add r1.xyz, -r1, c26
dp3 r2.x, r1, r1
rsq r1.w, r2.x
mul r0.xyz, r3.w, r0
mul r1.xyz, r1.w, r1
mul r2.xyz, r1.zxyw, r0.yzxw
mad r2.xyz, r1.yzxw, r0.zxyw, -r2
dp3 r2.x, r2, r2
dp3 r0.x, r1, r0
mul_sat r0.y, r0.x, c34.w
mad r0.x, -r0.y, c35, c35.y
mul r0.y, r0, r0
rsq r2.x, r2.x
rcp r2.x, r2.x
min r4.y, r2.x, c28
abs r2.y, r4
mad r2.x, r2.y, c34, c34.y
add r2.z, -r2.y, c28.y
mad r2.x, r2.y, r2, c33.w
mad r2.y, r2, r2.x, c34.z
mul r2.x, r3.w, c7.w
rsq r2.z, r2.z
rcp r2.z, r2.z
min r3.w, r2.x, c28.y
mad r4.x, -r2.z, r2.y, c31
abs r2.z, r3.w
mad r2.x, r2.z, c34, c34.y
add r2.y, -r2.z, c28
mad r2.x, r2.z, r2, c33.w
rsq r2.y, r2.y
rcp r2.y, r2.y
mad r2.x, r2.z, r2, c34.z
mad r2.x, -r2.y, r2, c31
cmp r2.y, r3.w, c33, c33.z
mad r2.x, -r2.y, r2, r2
cmp r4.y, r4, c33, c33.z
mad r2.y, -r4, r4.x, r4.x
add r2.x, r2.y, -r2
rcp r2.y, r1.w
mul r0.x, r0.y, r0
rcp r1.w, c26.w
mul r2.x, r2.y, r2
mad r1.w, -r2.x, r1, c28.y
mul_sat r1.w, r1, c31
mul r1.x, r1.w, r1.w
mad r0.z, -r1.w, c35.x, c35.y
mul r0.y, r1.x, r0.z
mad r0.x, -r0.y, r0, c28.y
mul r2.w, r2, r0.x
endif
endif
endif
endif
endif
mul r0.xyz, r3, r2.w
mul r2.xyz, r0, r0.w
mul r2.w, r2.z, c35.z
pow r0, r2.w, c35.w
pow r1, c36.x, -r2.z
add r3.x, r2.z, c36.y
mov r0.y, r1.x
pow r1, c36.x, -r2.x
add r0.y, -r0, c28
cmp r2.z, r3.x, r0.y, r0.x
mul r2.w, r2.x, c35.z
pow r0, r2.w, c35.w
add r3.x, r2, c36.y
mov r0.y, r1.x
add r0.y, -r0, c28
cmp r2.x, r3, r0.y, r0
pow r0, c36.x, -r2.y
mul r2.w, r2.y, c35.z
mov r0.y, r0.x
pow r1, r2.w, c35.w
add r3.x, r2.y, c36.y
mov r0.x, r1
add r0.y, -r0, c28
cmp r2.y, r3.x, r0, r0.x
mul oC0.xyz, r2, c22.x
mov oC0.w, c28.y
"
}
SubProgram "d3d11 " {
// Stats: 275 math, 8 branches
Keywords { "ECLIPSES_ON" }
SetTexture 0 [_Inscatter] 2D 0
ConstBuffer "$Globals" 496
Matrix 368 [lightOccluders1]
Matrix 432 [lightOccluders2]
Float 32 [M_PI]
Vector 64 [betaR] 3
Float 108 [mieG]
Float 112 [_Exposure]
Float 116 [Rg]
Float 120 [Rt]
Float 128 [RES_R]
Float 132 [RES_MU]
Float 136 [RES_MU_S]
Float 140 [RES_NU]
Float 160 [_Sun_Intensity]
Float 164 [_experimentalAtmoScale]
Float 168 [_viewdirOffset]
Float 172 [_Alpha_Global]
Vector 320 [_Globals_Origin] 3
Float 332 [_RimExposure]
Vector 336 [_Sun_WorldSunDir] 3
Vector 352 [sunPosAndRadius]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedgicgamnafgpjkbdbkfnnabmnhjjdkfljabaaaaaacmcgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmcfaaaa
eaaaaaaaflajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaabpaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacajaaaaaadiaaaaalhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aeaaaaaaaceaaaaaaaiallefaaiallefaaiallefaaaaaaaaaaaaaaajhcaabaaa
abaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahocaabaaaacaaaaaapgapbaaaaaaaaaaa
agajbaaaabaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaacaaaaaajgahbaaa
acaaaaaadcaaaaaphcaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaaceaaaaa
aaiallefaaiallefaaiallefaaaaaaaaegiccaiaebaaaaaaaaaaaaaabeaaaaaa
baaaaaahecaabaaaabaaaaaajgahbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaah
icaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaabaaaaaajicaabaaa
adaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaabeaaaaaabaaaaaah
bcaabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahicaabaaa
adaaaaaadkaabaaaadaaaaaaakaabaaaaeaaaaaabaaaaaaibcaabaaaaeaaaaaa
egiccaaaaaaaaaaabeaaaaaaegacbaaaaaaaaaaadcaaaaakicaabaaaadaaaaaa
akaabaiaebaaaaaaaeaaaaaaabeaaaaaaaaaaaeadkaabaaaadaaaaaadiaaaaaj
bcaabaaaaeaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaa
dcaaaaamccaabaaaaeaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaabkiacaaa
aaaaaaaaahaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahecaabaaaaeaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaiaeadcaaaaakccaabaaaaeaaaaaackaabaiaebaaaaaaaeaaaaaa
bkaabaaaaeaaaaaadkaabaaaabaaaaaadbaaaaahicaabaaaaeaaaaaabkaabaaa
aeaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaalccaabaaaaeaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaea
bkaabaiaebaaaaaaaeaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaaaoaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaabkaabaaa
abaaaaaabnaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaabkaabaaaaeaaaaaa
dmaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaadkaabaaaaeaaaaaadhaaaaal
ccaabaaaaeaaaaaabkaabaaaaeaaaaaadkiacaaaaaaaaaaabeaaaaaaakiacaaa
aaaaaaaaahaaaaaaaaaaaaakicaabaaaaeaaaaaabkiacaiaebaaaaaaaaaaaaaa
ahaaaaaackiacaaaaaaaaaaaahaaaaaadcaaaaalbcaabaaaafaaaaaadkaabaaa
aeaaaaaabkiacaaaaaaaaaaaakaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
akaaaaaabaaaaaahicaabaaaaaaaaaaaigadbaaaacaaaaaaigadbaaaacaaaaaa
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
baaaaaaiicaabaaaaaaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaabfaaaaaa
baaaaaaibcaabaaaabaaaaaaegacbaaaadaaaaaaegiccaaaaaaaaaaabfaaaaaa
aoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaafaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaaakaabaiaebaaaaaa
aeaaaaaaelaaaaafecaabaaaagaaaaaaakaabaaaacaaaaaadiaaaaahbcaabaaa
acaaaaaabkaabaaaafaaaaaabkaabaaaafaaaaaadcaaaaakbcaabaaaadaaaaaa
bkaabaaaafaaaaaabkaabaaaafaaaaaaakaabaiaebaaaaaaaeaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakbcaabaaaacaaaaaackaabaaa
afaaaaaackaabaaaafaaaaaaakaabaiaebaaaaaaacaaaaaadcaaaaalbcaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaaakaabaaa
acaaaaaadbaaaaahccaabaaaadaaaaaackaabaaaafaaaaaaabeaaaaaaaaaaaaa
dbaaaaahecaabaaaadaaaaaaabeaaaaaaaaaaaaaakaabaaaacaaaaaaabaaaaah
ccaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaalhcaabaaa
ahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaa
aiaaaaaaaaaaaaaiicaabaaaaiaaaaaaakaabaiaebaaaaaaahaaaaaaabeaaaaa
aaaaaadpdiaaaaahccaabaaaagaaaaaackaabaaaagaaaaaackaabaaaagaaaaaa
aaaaaaahicaabaaaagaaaaaaakaabaaaahaaaaaaabeaaaaaaaaaaadpdgaaaaai
hcaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaf
bcaabaaaagaaaaaaabeaaaaaaaaaialpdhaaaaajpcaabaaaaiaaaaaafgafbaaa
adaaaaaaegaobaaaaiaaaaaaegaobaaaagaaaaaaaoaaaaahccaabaaaadaaaaaa
akaabaaaadaaaaaackaabaaaagaaaaaaaoaaaaalhcaabaaaagaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaaaaaaaaaaaiaaaaaaaaaaaaal
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
aaaaaadpaaaaaaaiecaabaaaadaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaialpdiaaaaahbcaabaaaaeaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
ebaaaaafbcaabaaaaeaaaaaaakaabaaaaeaaaaaadcaaaaakbcaabaaaadaaaaaa
akaabaaaadaaaaaackaabaaaadaaaaaaakaabaiaebaaaaaaaeaaaaaadiaaaaai
ecaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaaiaaaaaadcaaaaak
ccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaa
aaaaialpebaaaaafccaabaaaadaaaaaabkaabaaaadaaaaaaaoaaaaaiccaabaaa
adaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaaaiaaaaaaebaaaaaficaabaaa
aeaaaaaackaabaaaadaaaaaaaoaaaaaiicaabaaaaeaaaaaadkaabaaaaeaaaaaa
akiacaaaaaaaaaaaaiaaaaaabkaaaaafecaabaaaadaaaaaackaabaaaadaaaaaa
aaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaaeaaaaaaaoaaaaai
ccaabaaaagaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaai
bcaabaaaacaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaaiaaaaaaaaaaaaah
ecaabaaaagaaaaaabkaabaaaadaaaaaaakaabaaaacaaaaaaeiaaaaalpcaabaaa
ahaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaaabeaaaaa
aaaaiadpaaaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aoaaaaaibcaabaaaagaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaa
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
aaaaaaaaaeaaaaaaagijcaaaaaaaaaaaaeaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaadaaaaaajgahbaaaafaaaaaadiaaaaaljcaabaaaaeaaaaaaagiacaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaiaebaaaaaaaaaaaaaaaaaaaaiaeaaoaaaaak
jcaabaaaaeaaaaaaaceaaaaaaaaaeaeaaaaaaaaaaaaaaaaaaaaamadpagambaaa
aeaaaaaadcaaaaajbcaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaeaaaaaaakaabaaaacaaaaaaakaabaaa
aeaaaaaadcaaaaamccaabaaaafaaaaaadkiacaiaebaaaaaaaaaaaaaaagaaaaaa
dkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaaeaaaaaa
dkaabaaaaeaaaaaabkaabaaaafaaaaaadcaaaaaogcaabaaaafaaaaaapgipcaaa
aaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaeaaaaaaaaaapaaaaaiicaabaaaaaaaaaaapgapbaaaaaaaaaaapgipcaaa
aaaaaaaaagaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
bkaabaaaafaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaafaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaaj
hcaabaaaadaaaaaaegacbaaaagaaaaaaagaabaaaaeaaaaaaegacbaaaadaaaaaa
abaaaaahhcaabaaaadaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadiaaaaai
hcaabaaaadaaaaaaegacbaaaadaaaaaaagiacaaaaaaaaaaaakaaaaaadcaaaaak
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
abaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaaaaaaaaabgaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaaaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaaf
bcaabaaaacaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaaacaaaaaabbaaaaaj
ccaabaaaacaaaaaaegiocaaaaaaaaaaabkaaaaaaegjojaaaakaabaaaacaaaaaa
bnaaaaahecaabaaaacaaaaaaabeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaead
ckaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaa
aaaaaaaabhaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaa
egiocaaaaaaaaaaabiaaaaaaegjojaaaakaabaaaacaaaaaabbaaaaajecaabaaa
afaaaaaaegiocaaaaaaaaaaabjaaaaaaegjojaaaakaabaaaacaaaaaaaaaaaaai
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
bgaaaaaaaaaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaiadp
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
acaaaaaabbaaaaajecaabaaaacaaaaaaegiocaaaaaaaaaaaboaaaaaaegjojaaa
bkaabaaaacaaaaaabnaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaa
acaaaaaabpaaaeaddkaabaaaacaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaa
afaaaaaaegiocaaaaaaaaaaablaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaaj
ccaabaaaafaaaaaaegiocaaaaaaaaaaabmaaaaaaegjojaaabkaabaaaacaaaaaa
bbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaabnaaaaaaegjojaaabkaabaaa
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
dkiacaaaaaaaaaaabgaaaaaaaaaaaaahecaabaaaacaaaaaackaabaaaacaaaaaa
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
egacbaaaacaaaaaapgipcaaaaaaaaaaaakaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "gles " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "ECLIPSES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "ECLIPSES_ON" }
"!!GLES3"
}
}
 }
}
}