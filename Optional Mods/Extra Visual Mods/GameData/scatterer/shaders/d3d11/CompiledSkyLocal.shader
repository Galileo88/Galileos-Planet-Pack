// Compiled shader for all platforms, uncompressed size: 274.3KB

Shader "Proland/Atmo/Sky" {
SubShader { 
 Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }


 // Stats for Vertex shader:
 //       d3d11 : 8 math
 //        d3d9 : 7 math
 // Stats for Fragment shader:
 //       d3d11 : 210 avg math (151..269), 9 avg branch (4..14)
 //        d3d9 : 500 avg math (268..732), 2 texture, 11 avg branch (3..20)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZTest False
  ZWrite Off
  Cull Front
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      float y_over_x_39;
      y_over_x_39 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      float x_40;
      x_40 = (y_over_x_39 * inversesqrt(((y_over_x_39 * y_over_x_39) + 1.0)));
      vec4 tmpvar_41;
      tmpvar_41.zw = vec2(0.0, 0.0);
      tmpvar_41.x = ((sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296))))))))) / 1.5);
      tmpvar_41.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      extinction_4 = texture2DLod (_Transmittance, tmpvar_41.xy, 0.0).xyz;
    };
    float tmpvar_42;
    tmpvar_42 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    vec3 tmpvar_43;
    tmpvar_43.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    tmpvar_43.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    tmpvar_43.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    vec3 tmpvar_44;
    tmpvar_44 = (extinctionMultiplier * tmpvar_43);
    extinction_4 = tmpvar_44;
    float tmpvar_45;
    tmpvar_45 = dot (tmpvar_5, tmpvar_5);
    float tmpvar_46;
    tmpvar_46 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_47;
    tmpvar_47 = ((tmpvar_46 * tmpvar_46) - ((4.0 * tmpvar_45) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    float tmpvar_48;
    if ((tmpvar_47 < 0.0)) {
      tmpvar_48 = -1.0;
    } else {
      tmpvar_48 = ((-(tmpvar_46) - sqrt(tmpvar_47)) / (2.0 * tmpvar_45));
    };
    bool tmpvar_49;
    tmpvar_49 = (tmpvar_48 > 0.0);
    if (!(tmpvar_49)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_44));
    };
    vec4 tmpvar_50;
    tmpvar_50.w = 1.0;
    tmpvar_50.xyz = extinction_4;
    tmpvar_1 = tmpvar_50;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      highp vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      lowp vec4 tmpvar_43;
      tmpvar_43 = texture2DLodEXT (_Transmittance, tmpvar_42.xy, 0.0);
      tmpvar_39 = tmpvar_43.xyz;
      extinction_4 = tmpvar_39;
    };
    highp float tmpvar_44;
    tmpvar_44 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_45;
    tmpvar_45.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    highp vec3 tmpvar_46;
    tmpvar_46 = (extinctionMultiplier * tmpvar_45);
    extinction_4 = tmpvar_46;
    highp float tmpvar_47;
    tmpvar_47 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_46));
    };
    highp vec4 tmpvar_52;
    tmpvar_52.w = 1.0;
    tmpvar_52.xyz = extinction_4;
    tmpvar_1 = tmpvar_52;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      highp vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      lowp vec4 tmpvar_43;
      tmpvar_43 = texture2DLodEXT (_Transmittance, tmpvar_42.xy, 0.0);
      tmpvar_39 = tmpvar_43.xyz;
      extinction_4 = tmpvar_39;
    };
    highp float tmpvar_44;
    tmpvar_44 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_45;
    tmpvar_45.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    highp vec3 tmpvar_46;
    tmpvar_46 = (extinctionMultiplier * tmpvar_45);
    extinction_4 = tmpvar_46;
    highp float tmpvar_47;
    tmpvar_47 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_46));
    };
    highp vec4 tmpvar_52;
    tmpvar_52.w = 1.0;
    tmpvar_52.xyz = extinction_4;
    tmpvar_1 = tmpvar_52;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      highp vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      lowp vec4 tmpvar_43;
      tmpvar_43 = textureLod (_Transmittance, tmpvar_42.xy, 0.0);
      tmpvar_39 = tmpvar_43.xyz;
      extinction_4 = tmpvar_39;
    };
    highp float tmpvar_44;
    tmpvar_44 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_45;
    tmpvar_45.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    highp vec3 tmpvar_46;
    tmpvar_46 = (extinctionMultiplier * tmpvar_45);
    extinction_4 = tmpvar_46;
    highp float tmpvar_47;
    tmpvar_47 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_46));
    };
    highp vec4 tmpvar_52;
    tmpvar_52.w = 1.0;
    tmpvar_52.xyz = extinction_4;
    tmpvar_1 = tmpvar_52;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      float y_over_x_39;
      y_over_x_39 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      float x_40;
      x_40 = (y_over_x_39 * inversesqrt(((y_over_x_39 * y_over_x_39) + 1.0)));
      vec4 tmpvar_41;
      tmpvar_41.zw = vec2(0.0, 0.0);
      tmpvar_41.x = ((sign(x_40) * (1.5708 - (sqrt((1.0 - abs(x_40))) * (1.5708 + (abs(x_40) * (-0.214602 + (abs(x_40) * (0.0865667 + (abs(x_40) * -0.0310296))))))))) / 1.5);
      tmpvar_41.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      extinction_4 = texture2DLod (_Transmittance, tmpvar_41.xy, 0.0).xyz;
    };
    float tmpvar_42;
    tmpvar_42 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    vec3 tmpvar_43;
    tmpvar_43.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    tmpvar_43.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    tmpvar_43.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_42));
    vec3 tmpvar_44;
    tmpvar_44 = (extinctionMultiplier * tmpvar_43);
    extinction_4 = tmpvar_44;
    float tmpvar_45;
    tmpvar_45 = dot (tmpvar_5, tmpvar_5);
    float tmpvar_46;
    tmpvar_46 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    float tmpvar_47;
    tmpvar_47 = ((tmpvar_46 * tmpvar_46) - ((4.0 * tmpvar_45) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    float tmpvar_48;
    if ((tmpvar_47 < 0.0)) {
      tmpvar_48 = -1.0;
    } else {
      tmpvar_48 = ((-(tmpvar_46) - sqrt(tmpvar_47)) / (2.0 * tmpvar_45));
    };
    bool tmpvar_49;
    tmpvar_49 = (tmpvar_48 > 0.0);
    if (!(tmpvar_49)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_44));
    } else {
      float eclipseShadow_50;
      eclipseShadow_50 = 1.0;
      float tmpvar_51;
      float tmpvar_52;
      tmpvar_52 = dot (tmpvar_5, tmpvar_5);
      float tmpvar_53;
      tmpvar_53 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      float tmpvar_54;
      tmpvar_54 = ((tmpvar_53 * tmpvar_53) - ((4.0 * tmpvar_52) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
      if ((tmpvar_54 < 0.0)) {
        tmpvar_51 = -1.0;
      } else {
        float tmpvar_55;
        tmpvar_55 = ((-(tmpvar_53) - sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
        float tmpvar_56;
        if ((tmpvar_55 < 0.0)) {
          tmpvar_56 = ((-(tmpvar_53) + sqrt(tmpvar_54)) / (2.0 * tmpvar_52));
        } else {
          tmpvar_56 = tmpvar_55;
        };
        tmpvar_51 = tmpvar_56;
      };
      if ((tmpvar_51 != -1.0)) {
        int j_57;
        int i_58;
        vec3 worldPos_59;
        worldPos_59 = (_WorldSpaceCameraPos + (tmpvar_5 * tmpvar_51));
        i_58 = 0;
        for (int i_58 = 0; i_58 < 4; ) {
          if ((lightOccluders1[3][i_58] <= 0.0)) {
            break;
          };
          vec4 v_60;
          v_60.x = lightOccluders1[0][i_58];
          v_60.y = lightOccluders1[1][i_58];
          v_60.z = lightOccluders1[2][i_58];
          v_60.w = lightOccluders1[3][i_58];
          vec3 tmpvar_61;
          tmpvar_61 = (sunPosAndRadius.xyz - worldPos_59);
          float tmpvar_62;
          tmpvar_62 = sqrt(dot (tmpvar_61, tmpvar_61));
          vec3 tmpvar_63;
          tmpvar_63 = (tmpvar_61 / vec3(tmpvar_62));
          vec3 tmpvar_64;
          tmpvar_64 = (v_60.xyz - worldPos_59);
          float tmpvar_65;
          tmpvar_65 = sqrt(dot (tmpvar_64, tmpvar_64));
          vec3 tmpvar_66;
          tmpvar_66 = (tmpvar_64 / tmpvar_65);
          vec3 tmpvar_67;
          tmpvar_67 = ((tmpvar_63.yzx * tmpvar_66.zxy) - (tmpvar_63.zxy * tmpvar_66.yzx));
          float tmpvar_68;
          tmpvar_68 = min (1.0, sqrt(dot (tmpvar_67, tmpvar_67)));
          float tmpvar_69;
          tmpvar_69 = min (1.0, (vec3(lightOccluders1[3][i_58]) / tmpvar_65).x);
          float t_70;
          t_70 = max (min ((((-((vec3(tmpvar_62) * ((sign(tmpvar_68) * (1.5708 - (sqrt((1.0 - abs(tmpvar_68))) * (1.5708 + (abs(tmpvar_68) * (-0.214602 + (abs(tmpvar_68) * (0.0865667 + (abs(tmpvar_68) * -0.0310296))))))))) - (sign(tmpvar_69) * (1.5708 - (sqrt((1.0 - abs(tmpvar_69))) * (1.5708 + (abs(tmpvar_69) * (-0.214602 + (abs(tmpvar_69) * (0.0865667 + (abs(tmpvar_69) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          float t_71;
          t_71 = max (min ((dot (tmpvar_63, tmpvar_66) / 0.2), 1.0), 0.0);
          eclipseShadow_50 = (eclipseShadow_50 * (1.0 - ((t_70 * (t_70 * (3.0 - (2.0 * t_70)))) * (t_71 * (t_71 * (3.0 - (2.0 * t_71)))))));
          i_58 = (i_58 + 1);
        };
        j_57 = 0;
        for (int j_57 = 0; j_57 < 4; ) {
          if ((lightOccluders2[3][j_57] <= 0.0)) {
            break;
          };
          vec4 v_72;
          v_72.x = lightOccluders2[0][j_57];
          v_72.y = lightOccluders2[1][j_57];
          v_72.z = lightOccluders2[2][j_57];
          v_72.w = lightOccluders2[3][j_57];
          vec3 tmpvar_73;
          tmpvar_73 = (sunPosAndRadius.xyz - worldPos_59);
          float tmpvar_74;
          tmpvar_74 = sqrt(dot (tmpvar_73, tmpvar_73));
          vec3 tmpvar_75;
          tmpvar_75 = (tmpvar_73 / vec3(tmpvar_74));
          vec3 tmpvar_76;
          tmpvar_76 = (v_72.xyz - worldPos_59);
          float tmpvar_77;
          tmpvar_77 = sqrt(dot (tmpvar_76, tmpvar_76));
          vec3 tmpvar_78;
          tmpvar_78 = (tmpvar_76 / tmpvar_77);
          vec3 tmpvar_79;
          tmpvar_79 = ((tmpvar_75.yzx * tmpvar_78.zxy) - (tmpvar_75.zxy * tmpvar_78.yzx));
          float tmpvar_80;
          tmpvar_80 = min (1.0, sqrt(dot (tmpvar_79, tmpvar_79)));
          float tmpvar_81;
          tmpvar_81 = min (1.0, (vec3(lightOccluders2[3][j_57]) / tmpvar_77).x);
          float t_82;
          t_82 = max (min ((((-((vec3(tmpvar_74) * ((sign(tmpvar_80) * (1.5708 - (sqrt((1.0 - abs(tmpvar_80))) * (1.5708 + (abs(tmpvar_80) * (-0.214602 + (abs(tmpvar_80) * (0.0865667 + (abs(tmpvar_80) * -0.0310296))))))))) - (sign(tmpvar_81) * (1.5708 - (sqrt((1.0 - abs(tmpvar_81))) * (1.5708 + (abs(tmpvar_81) * (-0.214602 + (abs(tmpvar_81) * (0.0865667 + (abs(tmpvar_81) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          float t_83;
          t_83 = max (min ((dot (tmpvar_75, tmpvar_78) / 0.2), 1.0), 0.0);
          eclipseShadow_50 = (eclipseShadow_50 * (1.0 - ((t_82 * (t_82 * (3.0 - (2.0 * t_82)))) * (t_83 * (t_83 * (3.0 - (2.0 * t_83)))))));
          j_57 = (j_57 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_50)));
    };
    vec4 tmpvar_84;
    tmpvar_84.w = 1.0;
    tmpvar_84.xyz = extinction_4;
    tmpvar_1 = tmpvar_84;
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      highp vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      lowp vec4 tmpvar_43;
      tmpvar_43 = texture2DLodEXT (_Transmittance, tmpvar_42.xy, 0.0);
      tmpvar_39 = tmpvar_43.xyz;
      extinction_4 = tmpvar_39;
    };
    highp float tmpvar_44;
    tmpvar_44 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_45;
    tmpvar_45.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    highp vec3 tmpvar_46;
    tmpvar_46 = (extinctionMultiplier * tmpvar_45);
    extinction_4 = tmpvar_46;
    highp float tmpvar_47;
    tmpvar_47 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_46));
    } else {
      highp float eclipseShadow_52;
      eclipseShadow_52 = 1.0;
      highp float tmpvar_53;
      highp float tmpvar_54;
      tmpvar_54 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_55;
      tmpvar_55 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_56;
      tmpvar_56 = ((tmpvar_55 * tmpvar_55) - ((4.0 * tmpvar_54) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
      if ((tmpvar_56 < 0.0)) {
        tmpvar_53 = -1.0;
      } else {
        highp float tmpvar_57;
        tmpvar_57 = ((-(tmpvar_55) - sqrt(tmpvar_56)) / (2.0 * tmpvar_54));
        highp float tmpvar_58;
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
        highp vec3 worldPos_61;
        worldPos_61 = (_WorldSpaceCameraPos + (tmpvar_5 * tmpvar_53));
        i_60 = 0;
        for (int i_60 = 0; i_60 < 4; ) {
          if ((lightOccluders1[3][i_60] <= 0.0)) {
            break;
          };
          highp vec4 v_62;
          v_62.x = lightOccluders1[0][i_60];
          v_62.y = lightOccluders1[1][i_60];
          v_62.z = lightOccluders1[2][i_60];
          v_62.w = lightOccluders1[3][i_60];
          highp vec3 tmpvar_63;
          tmpvar_63 = (sunPosAndRadius.xyz - worldPos_61);
          highp float tmpvar_64;
          tmpvar_64 = sqrt(dot (tmpvar_63, tmpvar_63));
          highp vec3 tmpvar_65;
          tmpvar_65 = (tmpvar_63 / vec3(tmpvar_64));
          highp vec3 tmpvar_66;
          tmpvar_66 = (v_62.xyz - worldPos_61);
          highp float tmpvar_67;
          tmpvar_67 = sqrt(dot (tmpvar_66, tmpvar_66));
          highp vec3 tmpvar_68;
          tmpvar_68 = (tmpvar_66 / tmpvar_67);
          highp vec3 tmpvar_69;
          tmpvar_69 = ((tmpvar_65.yzx * tmpvar_68.zxy) - (tmpvar_65.zxy * tmpvar_68.yzx));
          highp float tmpvar_70;
          tmpvar_70 = min (1.0, sqrt(dot (tmpvar_69, tmpvar_69)));
          highp float tmpvar_71;
          tmpvar_71 = min (1.0, (vec3(lightOccluders1[3][i_60]) / tmpvar_67).x);
          highp float t_72;
          t_72 = max (min ((((-((vec3(tmpvar_64) * ((sign(tmpvar_70) * (1.5708 - (sqrt((1.0 - abs(tmpvar_70))) * (1.5708 + (abs(tmpvar_70) * (-0.214602 + (abs(tmpvar_70) * (0.0865667 + (abs(tmpvar_70) * -0.0310296))))))))) - (sign(tmpvar_71) * (1.5708 - (sqrt((1.0 - abs(tmpvar_71))) * (1.5708 + (abs(tmpvar_71) * (-0.214602 + (abs(tmpvar_71) * (0.0865667 + (abs(tmpvar_71) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_73;
          t_73 = max (min ((dot (tmpvar_65, tmpvar_68) / 0.2), 1.0), 0.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - ((t_72 * (t_72 * (3.0 - (2.0 * t_72)))) * (t_73 * (t_73 * (3.0 - (2.0 * t_73)))))));
          i_60 = (i_60 + 1);
        };
        j_59 = 0;
        for (int j_59 = 0; j_59 < 4; ) {
          if ((lightOccluders2[3][j_59] <= 0.0)) {
            break;
          };
          highp vec4 v_74;
          v_74.x = lightOccluders2[0][j_59];
          v_74.y = lightOccluders2[1][j_59];
          v_74.z = lightOccluders2[2][j_59];
          v_74.w = lightOccluders2[3][j_59];
          highp vec3 tmpvar_75;
          tmpvar_75 = (sunPosAndRadius.xyz - worldPos_61);
          highp float tmpvar_76;
          tmpvar_76 = sqrt(dot (tmpvar_75, tmpvar_75));
          highp vec3 tmpvar_77;
          tmpvar_77 = (tmpvar_75 / vec3(tmpvar_76));
          highp vec3 tmpvar_78;
          tmpvar_78 = (v_74.xyz - worldPos_61);
          highp float tmpvar_79;
          tmpvar_79 = sqrt(dot (tmpvar_78, tmpvar_78));
          highp vec3 tmpvar_80;
          tmpvar_80 = (tmpvar_78 / tmpvar_79);
          highp vec3 tmpvar_81;
          tmpvar_81 = ((tmpvar_77.yzx * tmpvar_80.zxy) - (tmpvar_77.zxy * tmpvar_80.yzx));
          highp float tmpvar_82;
          tmpvar_82 = min (1.0, sqrt(dot (tmpvar_81, tmpvar_81)));
          highp float tmpvar_83;
          tmpvar_83 = min (1.0, (vec3(lightOccluders2[3][j_59]) / tmpvar_79).x);
          highp float t_84;
          t_84 = max (min ((((-((vec3(tmpvar_76) * ((sign(tmpvar_82) * (1.5708 - (sqrt((1.0 - abs(tmpvar_82))) * (1.5708 + (abs(tmpvar_82) * (-0.214602 + (abs(tmpvar_82) * (0.0865667 + (abs(tmpvar_82) * -0.0310296))))))))) - (sign(tmpvar_83) * (1.5708 - (sqrt((1.0 - abs(tmpvar_83))) * (1.5708 + (abs(tmpvar_83) * (-0.214602 + (abs(tmpvar_83) * (0.0865667 + (abs(tmpvar_83) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_85;
          t_85 = max (min ((dot (tmpvar_77, tmpvar_80) / 0.2), 1.0), 0.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - ((t_84 * (t_84 * (3.0 - (2.0 * t_84)))) * (t_85 * (t_85 * (3.0 - (2.0 * t_85)))))));
          j_59 = (j_59 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_52)));
    };
    highp vec4 tmpvar_86;
    tmpvar_86.w = 1.0;
    tmpvar_86.xyz = extinction_4;
    tmpvar_1 = tmpvar_86;
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
    #line 79
    highp vec3 WCP = _WorldSpaceCameraPos;
    #line 84
    highp vec3 d = normalize((IN.worldPos - _WorldSpaceCameraPos));
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
  tmpvar_5 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_6;
  tmpvar_6 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceCameraPos - _Globals_Origin);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, normalize(tmpvar_5));
  mu_2 = (tmpvar_9 / tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = max ((-(tmpvar_9) - sqrt((((tmpvar_9 * tmpvar_9) - (tmpvar_8 * tmpvar_8)) + (tmpvar_6 * tmpvar_6)))), 0.0);
  if ((tmpvar_10 > 0.0)) {
    mu_2 = ((tmpvar_9 + tmpvar_10) / tmpvar_6);
    r_3 = tmpvar_6;
  };
  if ((r_3 > tmpvar_6)) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    highp float tmpvar_11;
    tmpvar_11 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_12;
    tmpvar_12 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_13;
    tmpvar_13 = ((tmpvar_12 * tmpvar_12) - ((4.0 * tmpvar_11) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_14;
    if ((tmpvar_13 < 0.0)) {
      tmpvar_14 = -1.0;
    } else {
      tmpvar_14 = ((-(tmpvar_12) - sqrt(tmpvar_13)) / (2.0 * tmpvar_11));
    };
    if ((tmpvar_14 > 0.0)) {
      highp float tmpvar_15;
      tmpvar_15 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_16;
      tmpvar_16 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_17;
      tmpvar_17 = ((tmpvar_16 * tmpvar_16) - ((4.0 * tmpvar_15) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
      highp float tmpvar_18;
      if ((tmpvar_17 < 0.0)) {
        tmpvar_18 = -1.0;
      } else {
        tmpvar_18 = ((-(tmpvar_16) - sqrt(tmpvar_17)) / (2.0 * tmpvar_15));
      };
      highp float tmpvar_19;
      tmpvar_19 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_20;
      tmpvar_20 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_21;
      tmpvar_21 = ((tmpvar_20 * tmpvar_20) - ((4.0 * tmpvar_19) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
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
      tmpvar_26.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_27;
      tmpvar_27 = (sqrt(((0.5 / H_25) * r_3)) * tmpvar_26);
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
      tmpvar_31.y = exp(((-(tmpvar_23) / H_25) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      tmpvar_24 = ((sqrt(((6.2831 * H_25) * r_3)) * exp(((Rg - r_3) / H_25))) * (tmpvar_30 + dot (((tmpvar_28 / ((2.3193 * abs(tmpvar_27)) + sqrt(((1.52 * tmpvar_29) + 4.0)))) * tmpvar_31), vec2(1.0, -1.0))));
      highp float H_32;
      H_32 = (HM * _experimentalAtmoScale);
      highp vec2 tmpvar_33;
      tmpvar_33.x = mu_2;
      tmpvar_33.y = (mu_2 + (tmpvar_23 / r_3));
      highp vec2 tmpvar_34;
      tmpvar_34 = (sqrt(((0.5 / H_32) * r_3)) * tmpvar_33);
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
      tmpvar_38.y = exp(((-(tmpvar_23) / H_32) * ((tmpvar_23 / (2.0 * r_3)) + mu_2)));
      extinction_4 = exp(((-(betaR) * tmpvar_24) - (betaMEx * ((sqrt(((6.2831 * H_32) * r_3)) * exp(((Rg - r_3) / H_32))) * (tmpvar_37 + dot (((tmpvar_35 / ((2.3193 * abs(tmpvar_34)) + sqrt(((1.52 * tmpvar_36) + 4.0)))) * tmpvar_38), vec2(1.0, -1.0)))))));
    } else {
      highp vec3 tmpvar_39;
      highp float y_over_x_40;
      y_over_x_40 = (((mu_2 + 0.15) / 1.15) * 14.1014);
      highp float x_41;
      x_41 = (y_over_x_40 * inversesqrt(((y_over_x_40 * y_over_x_40) + 1.0)));
      highp vec4 tmpvar_42;
      tmpvar_42.zw = vec2(0.0, 0.0);
      tmpvar_42.x = ((sign(x_41) * (1.5708 - (sqrt((1.0 - abs(x_41))) * (1.5708 + (abs(x_41) * (-0.214602 + (abs(x_41) * (0.0865667 + (abs(x_41) * -0.0310296))))))))) / 1.5);
      tmpvar_42.y = sqrt(((r_3 - Rg) / (tmpvar_6 - Rg)));
      lowp vec4 tmpvar_43;
      tmpvar_43 = textureLod (_Transmittance, tmpvar_42.xy, 0.0);
      tmpvar_39 = tmpvar_43.xyz;
      extinction_4 = tmpvar_39;
    };
    highp float tmpvar_44;
    tmpvar_44 = (((extinction_4.x + extinction_4.y) + extinction_4.z) / 3.0);
    highp vec3 tmpvar_45;
    tmpvar_45.x = ((_Extinction_Tint * extinction_4.x) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.y = ((_Extinction_Tint * extinction_4.y) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    tmpvar_45.z = ((_Extinction_Tint * extinction_4.z) + ((1.0 - _Extinction_Tint) * tmpvar_44));
    highp vec3 tmpvar_46;
    tmpvar_46 = (extinctionMultiplier * tmpvar_45);
    extinction_4 = tmpvar_46;
    highp float tmpvar_47;
    tmpvar_47 = dot (tmpvar_5, tmpvar_5);
    highp float tmpvar_48;
    tmpvar_48 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
    highp float tmpvar_49;
    tmpvar_49 = ((tmpvar_48 * tmpvar_48) - ((4.0 * tmpvar_47) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
    highp float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = -1.0;
    } else {
      tmpvar_50 = ((-(tmpvar_48) - sqrt(tmpvar_49)) / (2.0 * tmpvar_47));
    };
    bool tmpvar_51;
    tmpvar_51 = (tmpvar_50 > 0.0);
    if (!(tmpvar_51)) {
      extinction_4 = (vec3(extinctionRimFade) + ((1.0 - extinctionRimFade) * tmpvar_46));
    } else {
      highp float eclipseShadow_52;
      eclipseShadow_52 = 1.0;
      highp float tmpvar_53;
      highp float tmpvar_54;
      tmpvar_54 = dot (tmpvar_5, tmpvar_5);
      highp float tmpvar_55;
      tmpvar_55 = (2.0 * dot (tmpvar_5, (_WorldSpaceCameraPos - _Globals_Origin)));
      highp float tmpvar_56;
      tmpvar_56 = ((tmpvar_55 * tmpvar_55) - ((4.0 * tmpvar_54) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_6 * tmpvar_6))));
      if ((tmpvar_56 < 0.0)) {
        tmpvar_53 = -1.0;
      } else {
        highp float tmpvar_57;
        tmpvar_57 = ((-(tmpvar_55) - sqrt(tmpvar_56)) / (2.0 * tmpvar_54));
        highp float tmpvar_58;
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
        highp vec3 worldPos_61;
        worldPos_61 = (_WorldSpaceCameraPos + (tmpvar_5 * tmpvar_53));
        i_60 = 0;
        for (int i_60 = 0; i_60 < 4; ) {
          if ((lightOccluders1[3][i_60] <= 0.0)) {
            break;
          };
          highp vec4 v_62;
          v_62.x = lightOccluders1[0][i_60];
          v_62.y = lightOccluders1[1][i_60];
          v_62.z = lightOccluders1[2][i_60];
          v_62.w = lightOccluders1[3][i_60];
          highp vec3 tmpvar_63;
          tmpvar_63 = (sunPosAndRadius.xyz - worldPos_61);
          highp float tmpvar_64;
          tmpvar_64 = sqrt(dot (tmpvar_63, tmpvar_63));
          highp vec3 tmpvar_65;
          tmpvar_65 = (tmpvar_63 / vec3(tmpvar_64));
          highp vec3 tmpvar_66;
          tmpvar_66 = (v_62.xyz - worldPos_61);
          highp float tmpvar_67;
          tmpvar_67 = sqrt(dot (tmpvar_66, tmpvar_66));
          highp vec3 tmpvar_68;
          tmpvar_68 = (tmpvar_66 / tmpvar_67);
          highp vec3 tmpvar_69;
          tmpvar_69 = ((tmpvar_65.yzx * tmpvar_68.zxy) - (tmpvar_65.zxy * tmpvar_68.yzx));
          highp float tmpvar_70;
          tmpvar_70 = min (1.0, sqrt(dot (tmpvar_69, tmpvar_69)));
          highp float tmpvar_71;
          tmpvar_71 = min (1.0, (vec3(lightOccluders1[3][i_60]) / tmpvar_67).x);
          highp float t_72;
          t_72 = max (min ((((-((vec3(tmpvar_64) * ((sign(tmpvar_70) * (1.5708 - (sqrt((1.0 - abs(tmpvar_70))) * (1.5708 + (abs(tmpvar_70) * (-0.214602 + (abs(tmpvar_70) * (0.0865667 + (abs(tmpvar_70) * -0.0310296))))))))) - (sign(tmpvar_71) * (1.5708 - (sqrt((1.0 - abs(tmpvar_71))) * (1.5708 + (abs(tmpvar_71) * (-0.214602 + (abs(tmpvar_71) * (0.0865667 + (abs(tmpvar_71) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_73;
          t_73 = max (min ((dot (tmpvar_65, tmpvar_68) / 0.2), 1.0), 0.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - ((t_72 * (t_72 * (3.0 - (2.0 * t_72)))) * (t_73 * (t_73 * (3.0 - (2.0 * t_73)))))));
          i_60 = (i_60 + 1);
        };
        j_59 = 0;
        for (int j_59 = 0; j_59 < 4; ) {
          if ((lightOccluders2[3][j_59] <= 0.0)) {
            break;
          };
          highp vec4 v_74;
          v_74.x = lightOccluders2[0][j_59];
          v_74.y = lightOccluders2[1][j_59];
          v_74.z = lightOccluders2[2][j_59];
          v_74.w = lightOccluders2[3][j_59];
          highp vec3 tmpvar_75;
          tmpvar_75 = (sunPosAndRadius.xyz - worldPos_61);
          highp float tmpvar_76;
          tmpvar_76 = sqrt(dot (tmpvar_75, tmpvar_75));
          highp vec3 tmpvar_77;
          tmpvar_77 = (tmpvar_75 / vec3(tmpvar_76));
          highp vec3 tmpvar_78;
          tmpvar_78 = (v_74.xyz - worldPos_61);
          highp float tmpvar_79;
          tmpvar_79 = sqrt(dot (tmpvar_78, tmpvar_78));
          highp vec3 tmpvar_80;
          tmpvar_80 = (tmpvar_78 / tmpvar_79);
          highp vec3 tmpvar_81;
          tmpvar_81 = ((tmpvar_77.yzx * tmpvar_80.zxy) - (tmpvar_77.zxy * tmpvar_80.yzx));
          highp float tmpvar_82;
          tmpvar_82 = min (1.0, sqrt(dot (tmpvar_81, tmpvar_81)));
          highp float tmpvar_83;
          tmpvar_83 = min (1.0, (vec3(lightOccluders2[3][j_59]) / tmpvar_79).x);
          highp float t_84;
          t_84 = max (min ((((-((vec3(tmpvar_76) * ((sign(tmpvar_82) * (1.5708 - (sqrt((1.0 - abs(tmpvar_82))) * (1.5708 + (abs(tmpvar_82) * (-0.214602 + (abs(tmpvar_82) * (0.0865667 + (abs(tmpvar_82) * -0.0310296))))))))) - (sign(tmpvar_83) * (1.5708 - (sqrt((1.0 - abs(tmpvar_83))) * (1.5708 + (abs(tmpvar_83) * (-0.214602 + (abs(tmpvar_83) * (0.0865667 + (abs(tmpvar_83) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
          highp float t_85;
          t_85 = max (min ((dot (tmpvar_77, tmpvar_80) / 0.2), 1.0), 0.0);
          eclipseShadow_52 = (eclipseShadow_52 * (1.0 - ((t_84 * (t_84 * (3.0 - (2.0 * t_84)))) * (t_85 * (t_85 * (3.0 - (2.0 * t_85)))))));
          j_59 = (j_59 + 1);
        };
      };
      extinction_4 = (vec3(extinctionGroundFade) + ((1.0 - extinctionGroundFade) * (extinction_4 * eclipseShadow_52)));
    };
    highp vec4 tmpvar_86;
    tmpvar_86.w = 1.0;
    tmpvar_86.xyz = extinction_4;
    tmpvar_1 = tmpvar_86;
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
// Stats: 268 math, 2 textures, 3 branches
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
def c12, 0.00000100, 0.00000000, 1.00000000, 2.00000000
def c13, 4.00000000, -1.00000000, 6.28310013, 2.71828198
def c14, 0.50000000, 1.51999998, 4.00000000, 2.31929994
def c15, 1.00000000, -1.00000000, 0.15000001, 12.26193905
def c16, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c17, -0.33299461, 0.99999559, 1.57079601, 0.66666669
def c18, 0.33333334, 0, 0, 0
dcl_texcoord0 v0.xyz
add r1.xyz, v0, -c0
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mov r2.xyz, c0
add r2.xyz, -c8, r2
mul r3.xyz, r1.w, r1
dp3 r1.w, r2, r2
dp3 r2.x, r2, r3
rsq r2.y, r1.w
rcp r1.w, r2.y
mul r2.w, r1, r1
mov r2.z, c6.x
add r2.z, -c5.x, r2
mad r3.x, r2, r2, -r2.w
mul r2.z, r2, c7.x
add r2.w, r2.z, c5.x
mad r2.z, r2.w, r2.w, r3.x
rsq r3.x, r2.z
rcp r3.x, r3.x
cmp r2.z, r2, r3.x, c12.x
add r2.z, -r2.x, -r2
max r2.z, r2, c12.y
add r3.x, r2.z, r2
cmp r1.w, -r2.z, r1, r2
add r3.z, -r2.w, r1.w
rcp r3.y, r2.w
mul r2.x, r2.y, r2
mul r3.x, r3, r3.y
cmp r4.z, -r2, r2.x, r3.x
cmp_pp r2.x, -r3.z, c12.z, c12.y
cmp oC0, -r3.z, r0, c12.z
if_gt r2.x, c12.y
mov r0.xyz, c0
add r0.xyz, -c8, r0
dp3 r0.x, r1, r0
mov r2.xyz, c8
dp3 r0.w, c8, c8
dp3 r3.x, c0, c0
add r3.x, r0.w, r3
dp3 r0.w, c0, r2
mad r0.w, -r0, c12, r3.x
mad r2.x, -c5, c5, r0.w
dp3 r0.w, r1, r1
mul r2.x, r0.w, r2
mul r0.w, r0, c12
mul r0.x, r0, c12.w
mul r0.y, r2.x, c13.x
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
rcp r0.w, r0.w
add r0.x, -r0, -r0.z
mul r0.x, r0, r0.w
cmp r0.x, r0.y, r0, c13.y
if_gt r0.x, c12.y
mov r0.xyz, c8
mov r2.xyz, c0
dp3 r3.x, c0, c0
dp3 r0.w, c8, c8
add r0.w, r0, r3.x
dp3 r0.x, c0, r0
mad r0.w, -r0.x, c12, r0
add r0.xyz, -c8, r2
dp3 r0.x, r1, r0
mad r2.y, -c5.x, c5.x, r0.w
dp3 r2.x, r1, r1
mul r2.y, r2.x, r2
mul r0.x, r0, c12.w
mul r0.y, r2, c13.x
mad r0.y, r0.x, r0.x, -r0
mad r0.w, -r2, r2, r0
mul r2.y, r2.x, r0.w
mul r0.w, r2.x, c12
rsq r0.z, r0.y
mul r2.x, r2.y, c13
mad r2.x, r0, r0, -r2
rcp r0.z, r0.z
rcp r0.w, r0.w
add r0.z, -r0.x, -r0
mul r0.z, r0, r0.w
cmp r0.y, r0, r0.z, c13
rsq r2.y, r2.x
rcp r0.z, r2.y
add r0.x, -r0, -r0.z
mov r2.y, c3.x
mul r4.y, c7.x, r2
rcp r4.w, r4.y
mul r0.x, r0.w, r0
cmp r0.x, r2, r0, c13.y
add r4.x, r0.y, -r0
mul r0.z, r1.w, r4.w
rcp r0.x, r1.w
mul r0.y, r0.z, c14.x
mad r2.y, r4.x, r0.x, r4.z
rsq r0.y, r0.y
mov r2.x, r4.z
rcp r0.x, r0.y
mul r0.xy, r2, r0.x
mul r3.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c12.y, c12.z
cmp r2.zw, r0.xyxy, c12.y, c12.z
add r2.zw, r0, -r2
mad r0.zw, r3, c14.y, c14.z
rsq r0.z, r0.z
rsq r0.w, r0.w
abs r0.xy, r0
mul r3.w, r1, c12
rcp r0.z, r0.z
rcp r0.w, r0.w
mad r3.xy, r0, c14.w, r0.zwzw
rcp r0.x, r3.w
mad r5.x, r4, r0, r4.z
mul r0.y, -r4.x, r4.w
mul r3.w, r5.x, r0.y
pow r0, c13.w, r3.w
add r4.z, -r1.w, c5.x
rcp r3.x, r3.x
rcp r3.y, r3.y
mul r0.zw, r2, r3.xyxy
mov r0.x, c12.z
mul r0.xy, r0.zwzw, r0
mul r3.xy, r0, c15
pow r0, c13.w, r3.z
add r0.z, r3.x, r3.y
add r0.y, r2.w, -r2.z
cmp r0.x, -r0.y, c12.y, r0
mul r2.w, r4.z, r4
add r2.z, r0.x, r0
pow r0, c13.w, r2.w
mov r0.y, c1.x
mul r2.w, c7.x, r0.y
rcp r4.w, r2.w
mul r0.z, r1.w, r4.y
mul r0.y, r1.w, r4.w
mul r0.z, r0, c13
mul r0.y, r0, c14.x
rsq r0.z, r0.z
rcp r0.z, r0.z
mul r0.z, r0, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.xy, r0.x, r2
mul r0.z, r0, r2
mul r2.xyz, r0.z, c4
mul r3.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c12.y, c12.z
cmp r3.xy, r0, c12.y, c12.z
add r3.xy, r0.zwzw, -r3
mad r0.zw, r3, c14.y, c14.z
mul r5.y, r4.w, -r4.x
rsq r0.w, r0.w
rsq r0.z, r0.z
abs r0.xy, r0
rcp r0.w, r0.w
rcp r0.z, r0.z
mad r4.xy, r0, c14.w, r0.zwzw
mul r3.w, r5.y, r5.x
pow r0, c13.w, r3.w
rcp r4.x, r4.x
rcp r4.y, r4.y
mul r0.zw, r3.xyxy, r4.xyxy
mov r0.x, c12.z
mul r4.xy, r0.zwzw, r0
pow r0, c13.w, r3.z
mul r0.zw, r4.xyxy, c15.xyxy
mov r0.y, r0.x
add r0.x, r3.y, -r3
add r0.z, r0, r0.w
cmp r0.x, -r0, c12.y, r0.y
add r3.x, r0, r0.z
mul r3.y, r4.z, r4.w
pow r0, c13.w, r3.y
mul r1.w, r2, r1
mul r0.y, r1.w, c13.z
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r0.x, r0, r3
mad r2.xyz, r0.x, -c2, -r2
pow r0, c13.w, r2.x
pow r3, c13.w, r2.z
mov r2.x, r0
pow r0, c13.w, r2.y
mov r2.y, r0
mov r2.z, r3
else
add r0.x, r4.z, c15.z
mul r0.x, r0, c15.w
abs r0.y, r0.x
max r0.z, r0.y, c12
rcp r0.w, r0.z
min r0.z, r0.y, c12
mul r0.z, r0, r0.w
mul r0.w, r0.z, r0.z
mad r2.x, r0.w, c16, c16.y
mad r2.x, r2, r0.w, c16.z
mad r2.x, r2, r0.w, c16.w
mad r2.x, r2, r0.w, c17
mad r0.w, r2.x, r0, c17.y
mul r0.z, r0.w, r0
add r0.w, -r0.z, c17.z
add r0.y, r0, c13
cmp r0.y, -r0, r0.z, r0.w
cmp r0.x, r0, r0.y, -r0.y
add r0.z, r2.w, -c5.x
rcp r0.z, r0.z
add r0.y, r1.w, -c5.x
mul r0.y, r0, r0.z
rsq r0.y, r0.y
mul r0.x, r0, c17.w
mov r0.z, c12.y
rcp r0.y, r0.y
texldl r2.xyz, r0.xyzz, s0
endif
mov r0.xyz, c8
dp3 r1.w, c0, c0
dp3 r0.w, c8, c8
add r0.w, r0, r1
dp3 r0.x, c0, r0
mad r0.w, -r0.x, c12, r0
mad r1.w, -c5.x, c5.x, r0
dp3 r0.w, r1, r1
mul r1.w, r0, r1
mov r3.xyz, c0
add r0.xyz, -c8, r3
dp3 r0.x, r1, r0
mul r0.w, r0, c12
mov r1.x, c11
mul r0.x, r0, c12.w
mul r0.y, r1.w, c13.x
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
add r0.x, -r0, -r0.z
rcp r0.w, r0.w
mul r0.x, r0, r0.w
cmp r0.x, r0.y, r0, c13.y
cmp r0.w, -r0.x, c12.y, c12.z
add r0.z, r2.x, r2.y
add r0.z, r2, r0
mov r0.y, c9.x
mul r0.z, r0, c18.x
add r0.y, c12.z, -r0
mul r0.y, r0, r0.z
mad r0.xyz, r2, c9.x, r0.y
mul r0.xyz, r0, c10.x
add r1.x, c12.z, -r1
mad r1.xyz, r1.x, r0, c11.x
abs_pp r0.w, r0
cmp oC0.xyz, -r0.w, r1, r0
mov oC0.w, c12.z
endif
"
}
SubProgram "d3d11 " {
// Stats: 151 math, 4 branches
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
eefiecedmkjijocncfehhakoadpgiedeandeagedabaaaaaapabeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdabeaaaa
eaaaaaaaamafaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
abaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaaegiccaiaebaaaaaa
abaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakicaabaaaaaaaaaaa
bkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaaahaaaaaadiaaaaai
bcaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaadcaaaaal
bcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaakaaaaaabkiacaaa
aaaaaaaaahaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaiaebaaaaaaaaaaaaaa
beaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaa
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
aaaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaabeaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaabaaaaaaaeaaaaaa
dcaaaaakecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaaea
ckaabaaaaaaaaaaadcaaaaamicaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaa
ahaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaaaaaaaaaadiaaaaahccaabaaa
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
aaaaaaaadiaaaaajccaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaakaaaaaaaoaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaadpbkaabaaa
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
acaaaaaaakaabaiaebaaaaaaadaaaaaabkiacaaaaaaaaaaaahaaaaaaaoaaaaah
ccaabaaaaaaaaaaabkaabaaaacaaaaaabkaabaaaaaaaaaaadiaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaa
abaaaaaaapaaaaakccaabaaaabaaaaaajgafbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaa
bkaabaaaabaaaaaadiaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaajecaabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaabkiacaaa
aaaaaaaaakaaaaaaaoaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaadpckaabaaa
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
agaabaaaaaaaaaaaagijcaaaaaaaaaaaagaaaaaadcaaaaamhcaabaaaaaaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaafgafbaaaaaaaaaaajgahbaiaebaaaaaa
abaaaaaadiaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaadlkklidp
dlkklidpdlkklidpaaaaaaaabjaaaaafhcaabaaaacaaaaaaegacbaaaaaaaaaaa
bcaaaaabaaaaaaajbcaabaaaaaaaaaaaakaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaahaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
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
klkkkkdoaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaaaaaaaaabeaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaabeaaaaaaegacbaaa
acaaaaaaagaabaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaabfaaaaaabnaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dkaabaaaaaaaaaaaaaaaaaajbcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaa
bfaaaaaaabeaaaaaaaaaiadpdcaaaaakhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaaaaaaaaafgifcaaaaaaaaaaabfaaaaaadhaaaaajhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
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
// Stats: 732 math, 2 textures, 20 branches
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
def c22, 0.00000100, 0.00000000, 1.00000000, 2.00000000
def c23, 4.00000000, -1.00000000, 6.28310013, 2.71828198
def c24, 0.50000000, 1.51999998, 4.00000000, 2.31929994
def c25, 1.00000000, -1.00000000, 0.15000001, 12.26193905
def c26, -0.01348047, 0.05747731, -0.12123910, 0.19563590
def c27, -0.33299461, 0.99999559, 1.57079601, 0.66666669
def c28, 0.33333334, -1.00000000, 0.00000000, -0.21211439
def c29, -0.01872930, 0.07426100, 1.57072902, 5.00000000
def c30, 2.00000000, 3.00000000, 0, 0
dcl_texcoord0 v0.xyz
add r1.xyz, v0, -c8
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mov r2.xyz, c8
add r2.xyz, -c16, r2
mul r3.xyz, r1.w, r1
dp3 r1.w, r2, r2
dp3 r2.x, r2, r3
rsq r2.y, r1.w
rcp r2.z, r2.y
mul r2.w, r2.z, r2.z
mov r1.w, c14.x
add r1.w, -c13.x, r1
mul r1.w, r1, c15.x
add r1.w, r1, c13.x
mad r2.w, r2.x, r2.x, -r2
mad r2.w, r1, r1, r2
rsq r3.x, r2.w
rcp r3.x, r3.x
cmp r2.w, r2, r3.x, c22.x
add r2.w, -r2.x, -r2
max r3.x, r2.w, c22.y
cmp r2.w, -r3.x, r2.z, r1
add r3.z, -r1.w, r2.w
add r2.z, r3.x, r2.x
rcp r3.y, r1.w
mul r2.x, r2.y, r2
mul r2.z, r2, r3.y
cmp r4.y, -r3.x, r2.x, r2.z
cmp_pp r2.x, -r3.z, c22.z, c22.y
cmp oC0, -r3.z, r0, c22.z
if_gt r2.x, c22.y
mov r0.xyz, c8
add r0.xyz, -c16, r0
dp3 r0.x, r1, r0
mov r2.xyz, c16
dp3 r0.w, c16, c16
dp3 r3.x, c8, c8
add r3.x, r0.w, r3
dp3 r0.w, c8, r2
mad r0.w, -r0, c22, r3.x
mad r2.x, -c13, c13, r0.w
dp3 r0.w, r1, r1
mul r2.x, r0.w, r2
mul r0.w, r0, c22
mul r0.x, r0, c22.w
mul r0.y, r2.x, c23.x
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
rcp r0.z, r0.z
rcp r0.w, r0.w
add r0.x, -r0, -r0.z
mul r0.x, r0, r0.w
cmp r0.x, r0.y, r0, c23.y
if_gt r0.x, c22.y
mov r0.xyz, c16
mov r2.xyz, c8
dp3 r3.x, c8, c8
dp3 r0.w, c16, c16
add r0.w, r0, r3.x
dp3 r0.x, c8, r0
mad r3.x, -r0, c22.w, r0.w
add r0.xyz, -c16, r2
dp3 r0.x, r1, r0
mul r0.x, r0, c22.w
dp3 r0.w, r1, r1
mad r2.x, -c13, c13, r3
mul r2.x, r0.w, r2
mul r0.y, r2.x, c23.x
mad r0.y, r0.x, r0.x, -r0
rsq r0.z, r0.y
mad r2.x, -r1.w, r1.w, r3
mul r2.x, r0.w, r2
rcp r0.z, r0.z
mul r0.w, r0, c22
mul r2.x, r2, c23
mad r2.x, r0, r0, -r2
rcp r0.w, r0.w
add r0.z, -r0.x, -r0
mul r0.z, r0, r0.w
cmp r0.y, r0, r0.z, c23
rsq r2.y, r2.x
rcp r0.z, r2.y
add r0.x, -r0, -r0.z
mov r2.y, c11.x
mul r2.z, c15.x, r2.y
rcp r4.w, r2.z
mul r0.x, r0.w, r0
cmp r0.x, r2, r0, c23.y
add r4.z, r0.y, -r0.x
mul r0.z, r2.w, r4.w
rcp r0.x, r2.w
mul r0.y, r0.z, c24.x
mad r2.y, r4.z, r0.x, r4
rsq r0.y, r0.y
mov r2.x, r4.y
rcp r0.x, r0.y
mul r0.xy, r2, r0.x
mul r5.xy, r0, r0
cmp r0.zw, -r0.xyxy, c22.y, c22.z
cmp r3.xy, r0, c22.y, c22.z
add r3.xy, r0.zwzw, -r3
mad r0.zw, r5.xyxy, c24.y, c24.z
rsq r0.z, r0.z
rsq r0.w, r0.w
abs r0.xy, r0
mul r5.y, r2.w, c22.w
rcp r0.z, r0.z
rcp r0.w, r0.w
mad r3.zw, r0.xyxy, c24.w, r0
rcp r0.x, r5.y
mad r5.z, r4, r0.x, r4.y
mul r0.y, -r4.z, r4.w
mul r4.y, r5.z, r0
pow r0, c23.w, r4.y
add r4.y, -r2.w, c13.x
rcp r3.z, r3.z
rcp r3.w, r3.w
mul r0.zw, r3.xyxy, r3
mov r0.x, c22.z
mul r0.xy, r0.zwzw, r0
mul r3.zw, r0.xyxy, c25.xyxy
pow r0, c23.w, r5.x
add r0.z, r3, r3.w
add r0.y, r3, -r3.x
cmp r0.x, -r0.y, c22.y, r0
mul r3.y, r4, r4.w
add r3.x, r0, r0.z
pow r0, c23.w, r3.y
mov r0.y, c9.x
mul r5.x, c15, r0.y
rcp r5.y, r5.x
mov r0.z, r0.x
mul r0.y, r2.w, r2.z
mul r0.x, r2.w, r5.y
mul r0.y, r0, c23.z
mul r0.x, r0, c24
rsq r0.y, r0.y
rsq r0.x, r0.x
rcp r0.y, r0.y
mul r0.y, r0, r0.z
mul r0.z, r0.y, r3.x
rcp r0.x, r0.x
mul r0.xy, r0.x, r2
mul r2.xyz, r0.z, c12
mul r3.zw, r0.xyxy, r0.xyxy
cmp r0.zw, -r0.xyxy, c22.y, c22.z
cmp r3.xy, r0, c22.y, c22.z
add r3.xy, r0.zwzw, -r3
mad r0.zw, r3, c24.y, c24.z
mul r5.w, r5.y, -r4.z
rsq r0.w, r0.w
rsq r0.z, r0.z
abs r0.xy, r0
rcp r0.w, r0.w
rcp r0.z, r0.z
mad r4.zw, r0.xyxy, c24.w, r0
mul r3.w, r5, r5.z
pow r0, c23.w, r3.w
rcp r4.z, r4.z
rcp r4.w, r4.w
mul r0.zw, r3.xyxy, r4
mov r0.x, c22.z
mul r4.zw, r0, r0.xyxy
pow r0, c23.w, r3.z
mul r0.zw, r4, c25.xyxy
mov r0.y, r0.x
add r0.x, r3.y, -r3
add r0.z, r0, r0.w
cmp r0.x, -r0, c22.y, r0.y
add r3.y, r0.x, r0.z
mul r3.x, r4.y, r5.y
pow r0, c23.w, r3.x
mul r2.w, r5.x, r2
mul r0.y, r2.w, c23.z
mov r0.z, r0.x
rsq r0.y, r0.y
rcp r0.x, r0.y
mul r0.x, r0, r0.z
mul r0.x, r0, r3.y
mad r0.xyz, r0.x, -c10, -r2
pow r2, c23.w, r0.x
pow r3, c23.w, r0.y
mov r0.x, r2
pow r2, c23.w, r0.z
mov r0.y, r3
mov r0.z, r2
else
add r0.x, r4.y, c25.z
mul r0.x, r0, c25.w
abs r0.y, r0.x
max r0.z, r0.y, c22
rcp r0.w, r0.z
min r0.z, r0.y, c22
mul r0.z, r0, r0.w
mul r0.w, r0.z, r0.z
mad r2.x, r0.w, c26, c26.y
mad r2.x, r2, r0.w, c26.z
mad r2.x, r2, r0.w, c26.w
mad r2.x, r2, r0.w, c27
mad r0.w, r2.x, r0, c27.y
mul r0.z, r0.w, r0
add r0.w, -r0.z, c27.z
add r0.y, r0, c23
cmp r0.y, -r0, r0.z, r0.w
cmp r0.x, r0, r0.y, -r0.y
add r0.z, r1.w, -c13.x
rcp r0.z, r0.z
add r0.y, r2.w, -c13.x
mul r0.y, r0, r0.z
rsq r0.y, r0.y
mul r0.x, r0, c27.w
mov r0.z, c22.y
rcp r0.y, r0.y
texldl r0.xyz, r0.xyzz, s0
endif
mov r2.xyz, c8
add r2.xyz, -c16, r2
mov r3.xyz, c16
dp3 r0.w, c16, c16
dp3 r2.w, c8, c8
add r2.w, r0, r2
dp3 r0.w, c8, r3
mad r0.w, -r0, c22, r2
mad r0.w, -c13.x, c13.x, r0
dp3 r2.w, r1, r1
mul r3.x, r2.w, r0.w
dp3 r0.w, r1, r2
mul r2.z, r2.w, c22.w
mul r0.w, r0, c22
mul r2.x, r3, c23
mad r2.y, r0.w, r0.w, -r2.x
rsq r2.x, r2.y
rcp r2.x, r2.x
add r2.x, -r0.w, -r2
rcp r2.z, r2.z
add r0.w, r0.x, r0.y
mul r2.z, r2.x, r2
add r2.x, r0.z, r0.w
mov r0.w, c17.x
mul r2.x, r2, c28
add r0.w, c22.z, -r0
mul r0.w, r0, r2.x
mad r0.xyz, r0, c17.x, r0.w
cmp r2.x, r2.y, r2.z, c23.y
cmp r0.w, -r2.x, c22.y, c22.z
mul r0.xyz, r0, c18.x
if_eq r0.w, c22.y
mov r0.w, c19.x
add r0.w, c22.z, -r0
mad r0.xyz, r0.w, r0, c19.x
else
mov r2.xyz, c16
dp3 r0.w, c16, c16
dp3 r2.w, c8, c8
add r2.w, r0, r2
dp3 r0.w, c8, r2
mad r0.w, -r0, c22, r2
mad r0.w, -r1, r1, r0
dp3 r1.w, r1, r1
mul r2.w, r1, r0
mov r3.xyz, c8
add r2.xyz, -c16, r3
dp3 r0.w, r1, r2
mul r0.w, r0, c22
mul r2.x, r2.w, c23
mad r2.x, r0.w, r0.w, -r2
rsq r2.y, r2.x
rcp r2.y, r2.y
add r2.z, -r0.w, -r2.y
add r2.y, -r0.w, r2
mul r1.w, r1, c22
rcp r0.w, r1.w
mul r1.w, r0, r2.y
mul r0.w, r2.z, r0
cmp r2.y, r0.w, r0.w, r1.w
cmp_pp r0.w, r2.x, c22.z, c22.y
cmp r1.w, r2.x, r4.x, c23.y
cmp r4.x, -r0.w, r1.w, r2.y
mov r0.w, c22.z
if_ne r4.x, c23.y
mov_pp r1.w, c0
cmp_pp r1.w, -r1, c28.y, c28.z
mad r2.xyz, r1, r4.x, c8
if_eq r1.w, c22.y
add r3.xyz, -r2, c0
add r1.xyz, -r2, c21
dp3 r2.w, r3, r3
dp3 r0.w, r1, r1
rsq r2.w, r2.w
mul r3.xyz, r2.w, r3
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r3.w, r4, r4
dp3 r1.y, r1, r3
mul_sat r1.y, r1, c29.w
mad r1.z, -r1.y, c30.x, c30.y
rsq r3.w, r3.w
rcp r3.w, r3.w
min r3.w, r3, c22.z
abs r4.x, r3.w
mad r4.y, r4.x, c29.x, c29
mad r4.z, r4.x, r4.y, c28.w
mul r2.w, r2, c0
mul r1.y, r1, r1
add r4.y, -r4.x, c22.z
mad r4.z, r4.x, r4, c29
rsq r4.x, r4.y
min r2.w, r2, c22.z
abs r4.y, r2.w
mad r4.w, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4, c28
rcp r4.x, r4.x
mad r4.x, -r4, r4.z, c27.z
add r4.z, -r4.y, c22
cmp r3.w, r3, c22.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.z, r4.z
rcp r4.y, r4.z
cmp r2.w, r2, c22.y, c22
mad r4.y, -r4, r4.w, c27.z
mad r4.y, -r2.w, r4, r4
mad r2.w, -r3, r4.x, r4.x
add r2.w, r2, -r4.y
rcp r0.w, r0.w
rcp r3.w, c21.w
mul r0.w, r0, r2
mad r0.w, -r0, r3, c22.z
mul_sat r0.w, r0, c24.x
mul r1.x, r0.w, r0.w
mad r0.w, -r0, c30.x, c30.y
mul r1.y, r1, r1.z
mul r0.w, r1.x, r0
mad r0.w, -r0, r1.y, c22.z
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.w, -c1, r1.x, r1
if_eq r1.w, c22.y
add r3.xyz, -r2, c1
add r1.xyz, -r2, c21
dp3 r3.w, r3, r3
dp3 r2.w, r1, r1
rsq r3.w, r3.w
mul r3.xyz, r3.w, r3
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r3
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.z
abs r4.y, r4.x
mad r4.z, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4.z, c28
mul r3.w, r3, c1
add r4.z, -r4.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.y, r4.z
min r3.w, r3, c22.z
abs r4.z, r3.w
mad r5.x, r4.z, c29, c29.y
mad r5.x, r4.z, r5, c28.w
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.z
add r4.w, -r4.z, c22.z
mul_sat r1.z, r1.y, c29.w
cmp r4.x, r4, c22.y, c22.w
mad r5.x, r4.z, r5, c29.z
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c22.y, c22
mad r4.z, -r4, r5.x, c27
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22.z
mul_sat r2.w, r2, c24.x
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c30.x, c30
mad r2.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r2.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.w, -c2, r1.x, r1
if_eq r1.w, c22.y
add r3.xyz, -r2, c2
add r1.xyz, -r2, c21
dp3 r3.w, r3, r3
dp3 r2.w, r1, r1
rsq r3.w, r3.w
mul r3.xyz, r3.w, r3
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r3
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.z
abs r4.y, r4.x
mad r4.z, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4.z, c28
mul r3.w, r3, c2
add r4.z, -r4.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.y, r4.z
min r3.w, r3, c22.z
abs r4.z, r3.w
mad r5.x, r4.z, c29, c29.y
mad r5.x, r4.z, r5, c28.w
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.z
add r4.w, -r4.z, c22.z
mul_sat r1.z, r1.y, c29.w
cmp r4.x, r4, c22.y, c22.w
mad r5.x, r4.z, r5, c29.z
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c22.y, c22
mad r4.z, -r4, r5.x, c27
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22.z
mul_sat r2.w, r2, c24.x
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c30.x, c30
mad r2.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r2.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.x, -c3.w, r1, r1.w
if_eq r1.x, c22.y
add r3.xyz, -r2, c3
add r1.xyz, -r2, c21
dp3 r2.w, r3, r3
dp3 r1.w, r1, r1
rsq r2.w, r2.w
mul r3.xyz, r2.w, r3
rsq r1.w, r1.w
mul r1.xyz, r1.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r3.w, r4, r4
dp3 r1.y, r1, r3
rsq r3.w, r3.w
rcp r3.w, r3.w
min r3.w, r3, c22.z
abs r4.x, r3.w
mad r4.y, r4.x, c29.x, c29
mad r4.z, r4.x, r4.y, c28.w
mul r2.w, r2, c3
add r4.y, -r4.x, c22.z
mad r4.z, r4.x, r4, c29
rsq r4.x, r4.y
min r2.w, r2, c22.z
abs r4.y, r2.w
mad r4.w, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4, c28
rcp r4.x, r4.x
mad r4.x, -r4, r4.z, c27.z
add r4.z, -r4.y, c22
mul_sat r1.z, r1.y, c29.w
cmp r3.w, r3, c22.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.z, r4.z
rcp r4.y, r4.z
cmp r2.w, r2, c22.y, c22
mad r4.y, -r4, r4.w, c27.z
mad r4.y, -r2.w, r4, r4
mad r2.w, -r3, r4.x, r4.x
add r2.w, r2, -r4.y
rcp r1.w, r1.w
rcp r3.w, c21.w
mul r1.w, r1, r2
mad r1.w, -r1, r3, c22.z
mul_sat r1.w, r1, c24.x
mul r1.x, r1.w, r1.w
mad r1.y, -r1.w, c30.x, c30
mad r1.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r1.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
endif
endif
endif
mov_pp r1.x, c4.w
cmp_pp r1.w, -r1.x, c28.y, c28.z
if_eq r1.w, c22.y
add r3.xyz, -r2, c4
add r1.xyz, -r2, c21
dp3 r3.w, r3, r3
dp3 r2.w, r1, r1
rsq r3.w, r3.w
mul r3.xyz, r3.w, r3
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r3
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.z
abs r4.y, r4.x
mad r4.z, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4.z, c28
mul r3.w, r3, c4
add r4.z, -r4.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.y, r4.z
min r3.w, r3, c22.z
abs r4.z, r3.w
mad r5.x, r4.z, c29, c29.y
mad r5.x, r4.z, r5, c28.w
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.z
add r4.w, -r4.z, c22.z
mul_sat r1.z, r1.y, c29.w
cmp r4.x, r4, c22.y, c22.w
mad r5.x, r4.z, r5, c29.z
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c22.y, c22
mad r4.z, -r4, r5.x, c27
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22.z
mul_sat r2.w, r2, c24.x
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c30.x, c30
mad r2.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r2.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.w, -c5, r1.x, r1
if_eq r1.w, c22.y
add r3.xyz, -r2, c5
add r1.xyz, -r2, c21
dp3 r3.w, r3, r3
dp3 r2.w, r1, r1
rsq r3.w, r3.w
mul r3.xyz, r3.w, r3
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r3
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.z
abs r4.y, r4.x
mad r4.z, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4.z, c28
mul r3.w, r3, c5
add r4.z, -r4.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.y, r4.z
min r3.w, r3, c22.z
abs r4.z, r3.w
mad r5.x, r4.z, c29, c29.y
mad r5.x, r4.z, r5, c28.w
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.z
add r4.w, -r4.z, c22.z
mul_sat r1.z, r1.y, c29.w
cmp r4.x, r4, c22.y, c22.w
mad r5.x, r4.z, r5, c29.z
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c22.y, c22
mad r4.z, -r4, r5.x, c27
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22.z
mul_sat r2.w, r2, c24.x
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c30.x, c30
mad r2.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r2.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.w, -c6, r1.x, r1
if_eq r1.w, c22.y
add r3.xyz, -r2, c6
add r1.xyz, -r2, c21
dp3 r3.w, r3, r3
dp3 r2.w, r1, r1
rsq r3.w, r3.w
mul r3.xyz, r3.w, r3
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
mul r4.xyz, r1.zxyw, r3.yzxw
mad r4.xyz, r1.yzxw, r3.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r3
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c22.z
abs r4.y, r4.x
mad r4.z, r4.y, c29.x, c29.y
mad r4.w, r4.y, r4.z, c28
mul r3.w, r3, c6
add r4.z, -r4.y, c22
mad r4.w, r4.y, r4, c29.z
rsq r4.y, r4.z
min r3.w, r3, c22.z
abs r4.z, r3.w
mad r5.x, r4.z, c29, c29.y
mad r5.x, r4.z, r5, c28.w
rcp r4.y, r4.y
mad r4.y, -r4, r4.w, c27.z
add r4.w, -r4.z, c22.z
mul_sat r1.z, r1.y, c29.w
cmp r4.x, r4, c22.y, c22.w
mad r5.x, r4.z, r5, c29.z
rsq r4.w, r4.w
rcp r4.z, r4.w
cmp r3.w, r3, c22.y, c22
mad r4.z, -r4, r5.x, c27
mad r4.z, -r3.w, r4, r4
mad r3.w, -r4.x, r4.y, r4.y
add r3.w, r3, -r4.z
rcp r2.w, r2.w
rcp r4.x, c21.w
mul r2.w, r2, r3
mad r2.w, -r2, r4.x, c22.z
mul_sat r2.w, r2, c24.x
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c30.x, c30
mad r2.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r2.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
if_ge r1.w, c22.y
mov_pp r1.x, c23.y
cmp_pp r1.x, -c7.w, r1, r1.w
if_eq r1.x, c22.y
add r1.xyz, -r2, c7
add r2.xyz, -r2, c21
dp3 r2.w, r1, r1
dp3 r1.w, r2, r2
rsq r2.w, r2.w
mul r1.xyz, r2.w, r1
rsq r1.w, r1.w
mul r2.xyz, r1.w, r2
mul r3.xyz, r2.zxyw, r1.yzxw
mad r3.xyz, r2.yzxw, r1.zxyw, -r3
dp3 r3.x, r3, r3
dp3 r1.y, r2, r1
rsq r3.x, r3.x
rcp r3.x, r3.x
min r3.y, r3.x, c22.z
abs r3.x, r3.y
mad r3.z, r3.x, c29.x, c29.y
mad r3.w, r3.x, r3.z, c28
mul r2.w, r2, c7
add r3.z, -r3.x, c22
mad r3.w, r3.x, r3, c29.z
rsq r3.x, r3.z
min r2.w, r2, c22.z
abs r3.z, r2.w
mad r4.x, r3.z, c29, c29.y
mad r4.x, r3.z, r4, c28.w
rcp r3.x, r3.x
mad r3.x, -r3, r3.w, c27.z
add r3.w, -r3.z, c22.z
mul_sat r1.z, r1.y, c29.w
mad r4.x, r3.z, r4, c29.z
rsq r3.w, r3.w
rcp r3.z, r3.w
cmp r2.w, r2, c22.y, c22
mad r3.z, -r3, r4.x, c27
mad r3.z, -r2.w, r3, r3
cmp r3.y, r3, c22, c22.w
mad r2.w, -r3.y, r3.x, r3.x
add r2.w, r2, -r3.z
rcp r1.w, r1.w
rcp r3.x, c21.w
mul r1.w, r1, r2
mad r1.w, -r1, r3.x, c22.z
mul_sat r1.w, r1, c24.x
mul r1.x, r1.w, r1.w
mad r1.y, -r1.w, c30.x, c30
mad r1.w, -r1.z, c30.x, c30.y
mul r1.z, r1, r1
mul r1.z, r1, r1.w
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c22.z
mul r0.w, r0, r1.x
endif
endif
endif
endif
endif
mul r0.xyz, r0, r0.w
mov r1.x, c20
add r0.w, c22.z, -r1.x
mad r0.xyz, r0.w, r0, c20.x
endif
mov oC0.xyz, r0
mov oC0.w, c22.z
endif
"
}
SubProgram "d3d11 " {
// Stats: 269 math, 14 branches
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
eefiecedpfodannmmdhnafencoejboaadfdnnmgaabaaaaaamaceaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaceaaaa
eaaaaaaaaaajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaabpaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaiaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
icaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaa
ahaaaaaadiaaaaaibcaabaaaabaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
akaaaaaadcaaaaalbcaabaaaacaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
akaaaaaabkiacaaaaaaaaaaaahaaaaaaaaaaaaakocaabaaaabaaaaaaagijcaia
ebaaaaaaaaaaaaaabeaaaaaaagijcaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
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
baaaaaajicaabaaaabaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaa
beaaaaaabaaaaaajccaabaaaacaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaa
abaaaaaaaeaaaaaaaaaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaa
acaaaaaabaaaaaajccaabaaaacaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaa
abaaaaaaaeaaaaaadcaaaaakicaabaaaabaaaaaabkaabaiaebaaaaaaacaaaaaa
abeaaaaaaaaaaaeadkaabaaaabaaaaaadcaaaaamccaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadkaabaaaabaaaaaa
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
adaaaaaabkiacaaaaaaaaaaaakaaaaaaaoaaaaahbcaabaaaaeaaaaaaabeaaaaa
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
ahaaaaaaaoaaaaahicaabaaaadaaaaaabkaabaaaafaaaaaadkaabaaaadaaaaaa
diaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaabeaaaaadlkklidpbjaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaackaabaaaaeaaaaaaapaaaaakbcaabaaaaeaaaaaaegaabaaaaeaaaaaa
aceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaaaaaaaaahbcaabaaaaeaaaaaa
akaabaaaaeaaaaaaakaabaaaafaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaakaabaaaaeaaaaaadiaaaaajbcaabaaaaeaaaaaadkiacaaaaaaaaaaa
aeaaaaaabkiacaaaaaaaaaaaakaaaaaaaoaaaaahccaabaaaaeaaaaaaabeaaaaa
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
hcaabaaaaeaaaaaapgapbaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaadcaaaaam
hcaabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaaaeaaaaaapgapbaaaadaaaaaa
egacbaiaebaaaaaaaeaaaaaadiaaaaakhcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaadlkklidpdlkklidpdlkklidpaaaaaaaabjaaaaafhcaabaaaaeaaaaaa
egacbaaaaeaaaaaabcaaaaabaaaaaaajicaabaaaacaaaaaaakaabaaaadaaaaaa
bkiacaiaebaaaaaaaaaaaaaaahaaaaaaaoaaaaahbcaabaaaabaaaaaadkaabaaa
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
aaaaaaaabeaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaa
beaaaaaaegacbaaaaeaaaaaaagaabaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
egacbaaaadaaaaaaagiacaaaaaaaaaaabfaaaaaabnaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaeadakaabaaaabaaaaaaaaaaaaaj
bcaabaaaabaaaaaabkiacaiaebaaaaaaaaaaaaaabfaaaaaaabeaaaaaaaaaiadp
dcaaaaakhcaabaaaaeaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaafgifcaaa
aaaaaaaabfaaaaaabcaaaaabdcaaaaakbcaabaaaabaaaaaaakaabaiaebaaaaaa
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
aaaaaaaaegiccaaaaaaaaaaabgaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadgaaaaaf
icaabaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaafbcaabaaaacaaaaaaabeaaaaa
aaaaaaaadaaaaaabcbaaaaahccaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aeaaaaaaadaaaeadbkaabaaaacaaaaaabbaaaaajccaabaaaacaaaaaaegiocaaa
aaaaaaaabkaaaaaaegjojaaaakaabaaaacaaaaaabnaaaaahecaabaaaacaaaaaa
abeaaaaaaaaaaaaabkaabaaaacaaaaaabpaaaeadckaabaaaacaaaaaaacaaaaab
bfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaaaaaaaaaabhaaaaaaegjojaaa
akaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaaegiocaaaaaaaaaaabiaaaaaa
egjojaaaakaabaaaacaaaaaabbaaaaajecaabaaaafaaaaaaegiocaaaaaaaaaaa
bjaaaaaaegjojaaaakaabaaaacaaaaaaaaaaaaaihcaabaaaafaaaaaaegacbaia
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
bkaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaabgaaaaaaaaaaaaahccaabaaa
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
acaaaaaaegiocaaaaaaaaaaaboaaaaaaegjojaaabkaabaaaacaaaaaabnaaaaah
icaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaabpaaaeaddkaabaaa
acaaaaaaacaaaaabbfaaaaabbbaaaaajbcaabaaaafaaaaaaegiocaaaaaaaaaaa
blaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaajccaabaaaafaaaaaaegiocaaa
aaaaaaaabmaaaaaaegjojaaabkaabaaaacaaaaaabbaaaaajecaabaaaafaaaaaa
egiocaaaaaaaaaaabnaaaaaaegjojaaabkaabaaaacaaaaaaaaaaaaaihcaabaaa
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
ecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaadkiacaaaaaaaaaaabgaaaaaa
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
adaaaaaaaaaaaaajicaabaaaaaaaaaaackiacaiaebaaaaaaaaaaaaaabfaaaaaa
abeaaaaaaaaaiadpdcaaaaakhcaabaaaaeaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaakgikcaaaaaaaaaaabfaaaaaabfaaaaabdgaaaaafhccabaaaaaaaaaaa
egacbaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
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
 //       d3d11 : 215 avg math (157..274), 4 avg branch (0..8)
 //        d3d9 : 458 avg math (234..683), 8 texture, 7 avg branch (0..15)
 Pass {
  Tags { "QUEUE"="Geometry+1" "IGNOREPROJECTOR"="true" }
  ZTest False
  ZWrite Off
  Cull Front
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
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  float tmpvar_12;
  tmpvar_12 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_8);
  viewdir_8 = tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_14;
  float tmpvar_15;
  tmpvar_15 = dot (camera_7, tmpvar_13);
  rMu_9 = tmpvar_15;
  float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt((((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (tmpvar_12 * tmpvar_12)))), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_16 * tmpvar_13));
    rMu_9 = (tmpvar_15 + tmpvar_16);
    r_10 = tmpvar_12;
  };
  float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  float tmpvar_18;
  tmpvar_18 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  vec4 tmpvar_19;
  float uMu_20;
  float uR_21;
  float tmpvar_22;
  tmpvar_22 = sqrt(((tmpvar_12 * tmpvar_12) - (Rg * Rg)));
  float tmpvar_23;
  tmpvar_23 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  float tmpvar_24;
  tmpvar_24 = (r_10 * (rMu_9 / r_10));
  float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_10 * r_10)) + (Rg * Rg));
  vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_22 * tmpvar_22);
    tmpvar_28.z = tmpvar_22;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  uR_21 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_22) * (1.0 - (1.0/(RES_R)))));
  uMu_20 = (tmpvar_26.w + ((((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y))) / (tmpvar_23 + tmpvar_26.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_29;
  y_over_x_29 = (max (tmpvar_18, -0.1975) * 5.34962);
  float x_30;
  x_30 = (y_over_x_29 * inversesqrt(((y_over_x_29 * y_over_x_29) + 1.0)));
  float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_MU_S) + (((((sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_32;
  tmpvar_32 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_33;
  tmpvar_33 = floor(tmpvar_32);
  float tmpvar_34;
  tmpvar_34 = (tmpvar_32 - tmpvar_33);
  float tmpvar_35;
  tmpvar_35 = (floor(((uR_21 * RES_R) - 1.0)) / RES_R);
  float tmpvar_36;
  tmpvar_36 = (floor((uR_21 * RES_R)) / RES_R);
  float tmpvar_37;
  tmpvar_37 = fract((uR_21 * RES_R));
  vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 0.0);
  tmpvar_38.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_38.y = ((uMu_20 / RES_R) + tmpvar_35);
  vec4 tmpvar_39;
  tmpvar_39.zw = vec2(0.0, 0.0);
  tmpvar_39.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_39.y = ((uMu_20 / RES_R) + tmpvar_35);
  vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_40.y = ((uMu_20 / RES_R) + tmpvar_36);
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_41.y = ((uMu_20 / RES_R) + tmpvar_36);
  tmpvar_19 = ((((texture2DLod (_Inscatter, tmpvar_38.xy, 0.0) * (1.0 - tmpvar_34)) + (texture2DLod (_Inscatter, tmpvar_39.xy, 0.0) * tmpvar_34)) * (1.0 - tmpvar_37)) + (((texture2DLod (_Inscatter, tmpvar_40.xy, 0.0) * (1.0 - tmpvar_34)) + (texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * tmpvar_34)) * tmpvar_37));
  if ((r_10 <= tmpvar_12)) {
    result_11 = ((tmpvar_19.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_17 * tmpvar_17)))) + ((((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_17)), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  vec3 L_42;
  vec3 tmpvar_43;
  tmpvar_43 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_42 = tmpvar_43;
  float tmpvar_44;
  if ((tmpvar_43.x < 1.413)) {
    tmpvar_44 = pow ((tmpvar_43.x * 0.38317), 0.454545);
  } else {
    tmpvar_44 = (1.0 - exp(-(tmpvar_43.x)));
  };
  L_42.x = tmpvar_44;
  float tmpvar_45;
  if ((tmpvar_43.y < 1.413)) {
    tmpvar_45 = pow ((tmpvar_43.y * 0.38317), 0.454545);
  } else {
    tmpvar_45 = (1.0 - exp(-(tmpvar_43.y)));
  };
  L_42.y = tmpvar_45;
  float tmpvar_46;
  if ((tmpvar_43.z < 1.413)) {
    tmpvar_46 = pow ((tmpvar_43.z * 0.38317), 0.454545);
  } else {
    tmpvar_46 = (1.0 - exp(-(tmpvar_43.z)));
  };
  L_42.z = tmpvar_46;
  vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = (_Alpha_Global * L_42);
  gl_FragData[0] = tmpvar_47;
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
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  highp float tmpvar_12;
  tmpvar_12 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_8);
  viewdir_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (camera_7, tmpvar_13);
  rMu_9 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt((((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (tmpvar_12 * tmpvar_12)))), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_16 * tmpvar_13));
    rMu_9 = (tmpvar_15 + tmpvar_16);
    r_10 = tmpvar_12;
  };
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  highp float tmpvar_18;
  tmpvar_18 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_19;
  highp float uMu_20;
  highp float uR_21;
  highp float tmpvar_22;
  tmpvar_22 = sqrt(((tmpvar_12 * tmpvar_12) - (Rg * Rg)));
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    highp vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    highp vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_22 * tmpvar_22);
    tmpvar_28.z = tmpvar_22;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  uR_21 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_22) * (1.0 - (1.0/(RES_R)))));
  uMu_20 = (tmpvar_26.w + ((((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y))) / (tmpvar_23 + tmpvar_26.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_29;
  y_over_x_29 = (max (tmpvar_18, -0.1975) * 5.34962);
  highp float x_30;
  x_30 = (y_over_x_29 * inversesqrt(((y_over_x_29 * y_over_x_29) + 1.0)));
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_MU_S) + (((((sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_32;
  tmpvar_32 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_33;
  tmpvar_33 = floor(tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_32 - tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (floor(((uR_21 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_36;
  tmpvar_36 = (floor((uR_21 * RES_R)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = fract((uR_21 * RES_R));
  highp vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 0.0);
  tmpvar_38.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_38.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLodEXT (_Inscatter, tmpvar_38.xy, 0.0);
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_40.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DLodEXT (_Inscatter, tmpvar_40.xy, 0.0);
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_42.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2DLodEXT (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_44.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DLodEXT (_Inscatter, tmpvar_44.xy, 0.0);
  tmpvar_19 = ((((tmpvar_39 * (1.0 - tmpvar_34)) + (tmpvar_41 * tmpvar_34)) * (1.0 - tmpvar_37)) + (((tmpvar_43 * (1.0 - tmpvar_34)) + (tmpvar_45 * tmpvar_34)) * tmpvar_37));
  if ((r_10 <= tmpvar_12)) {
    result_11 = ((tmpvar_19.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_17 * tmpvar_17)))) + ((((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_17)), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_46 = tmpvar_47;
  highp float tmpvar_48;
  if ((tmpvar_47.x < 1.413)) {
    tmpvar_48 = pow ((tmpvar_47.x * 0.38317), 0.454545);
  } else {
    tmpvar_48 = (1.0 - exp(-(tmpvar_47.x)));
  };
  L_46.x = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_47.y < 1.413)) {
    tmpvar_49 = pow ((tmpvar_47.y * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_47.y)));
  };
  L_46.y = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_47.z < 1.413)) {
    tmpvar_50 = pow ((tmpvar_47.z * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_47.z)));
  };
  L_46.z = tmpvar_50;
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = (_Alpha_Global * L_46);
  gl_FragData[0] = tmpvar_51;
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
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  highp float tmpvar_12;
  tmpvar_12 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_8);
  viewdir_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (camera_7, tmpvar_13);
  rMu_9 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt((((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (tmpvar_12 * tmpvar_12)))), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_16 * tmpvar_13));
    rMu_9 = (tmpvar_15 + tmpvar_16);
    r_10 = tmpvar_12;
  };
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  highp float tmpvar_18;
  tmpvar_18 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_19;
  highp float uMu_20;
  highp float uR_21;
  highp float tmpvar_22;
  tmpvar_22 = sqrt(((tmpvar_12 * tmpvar_12) - (Rg * Rg)));
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    highp vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    highp vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_22 * tmpvar_22);
    tmpvar_28.z = tmpvar_22;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  uR_21 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_22) * (1.0 - (1.0/(RES_R)))));
  uMu_20 = (tmpvar_26.w + ((((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y))) / (tmpvar_23 + tmpvar_26.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_29;
  y_over_x_29 = (max (tmpvar_18, -0.1975) * 5.34962);
  highp float x_30;
  x_30 = (y_over_x_29 * inversesqrt(((y_over_x_29 * y_over_x_29) + 1.0)));
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_MU_S) + (((((sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_32;
  tmpvar_32 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_33;
  tmpvar_33 = floor(tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_32 - tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (floor(((uR_21 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_36;
  tmpvar_36 = (floor((uR_21 * RES_R)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = fract((uR_21 * RES_R));
  highp vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 0.0);
  tmpvar_38.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_38.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2DLodEXT (_Inscatter, tmpvar_38.xy, 0.0);
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_40.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2DLodEXT (_Inscatter, tmpvar_40.xy, 0.0);
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_42.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2DLodEXT (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_44.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2DLodEXT (_Inscatter, tmpvar_44.xy, 0.0);
  tmpvar_19 = ((((tmpvar_39 * (1.0 - tmpvar_34)) + (tmpvar_41 * tmpvar_34)) * (1.0 - tmpvar_37)) + (((tmpvar_43 * (1.0 - tmpvar_34)) + (tmpvar_45 * tmpvar_34)) * tmpvar_37));
  if ((r_10 <= tmpvar_12)) {
    result_11 = ((tmpvar_19.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_17 * tmpvar_17)))) + ((((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_17)), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_46 = tmpvar_47;
  highp float tmpvar_48;
  if ((tmpvar_47.x < 1.413)) {
    tmpvar_48 = pow ((tmpvar_47.x * 0.38317), 0.454545);
  } else {
    tmpvar_48 = (1.0 - exp(-(tmpvar_47.x)));
  };
  L_46.x = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_47.y < 1.413)) {
    tmpvar_49 = pow ((tmpvar_47.y * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_47.y)));
  };
  L_46.y = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_47.z < 1.413)) {
    tmpvar_50 = pow ((tmpvar_47.z * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_47.z)));
  };
  L_46.z = tmpvar_50;
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = (_Alpha_Global * L_46);
  gl_FragData[0] = tmpvar_51;
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
  tmpvar_1 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_2;
  tmpvar_2 = dot (tmpvar_1, tmpvar_1);
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * dot (tmpvar_1, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * tmpvar_3) - ((4.0 * tmpvar_2) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  highp float tmpvar_12;
  tmpvar_12 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_8.x = (tmpvar_1.x + _viewdirOffset);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(viewdir_8);
  viewdir_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = sqrt(dot (camera_7, camera_7));
  r_10 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (camera_7, tmpvar_13);
  rMu_9 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = max ((-(tmpvar_15) - sqrt((((tmpvar_15 * tmpvar_15) - (tmpvar_14 * tmpvar_14)) + (tmpvar_12 * tmpvar_12)))), 0.0);
  if ((tmpvar_16 > 0.0)) {
    camera_7 = (camera_7 + (tmpvar_16 * tmpvar_13));
    rMu_9 = (tmpvar_15 + tmpvar_16);
    r_10 = tmpvar_12;
  };
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_13, _Sun_WorldSunDir);
  highp float tmpvar_18;
  tmpvar_18 = (dot (camera_7, _Sun_WorldSunDir) / r_10);
  highp vec4 tmpvar_19;
  highp float uMu_20;
  highp float uR_21;
  highp float tmpvar_22;
  tmpvar_22 = sqrt(((tmpvar_12 * tmpvar_12) - (Rg * Rg)));
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((r_10 * r_10) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = (r_10 * (rMu_9 / r_10));
  highp float tmpvar_25;
  tmpvar_25 = (((tmpvar_24 * tmpvar_24) - (r_10 * r_10)) + (Rg * Rg));
  highp vec4 tmpvar_26;
  if (((tmpvar_24 < 0.0) && (tmpvar_25 > 0.0))) {
    highp vec4 tmpvar_27;
    tmpvar_27.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_27.w = (0.5 - (0.5 / RES_MU));
    tmpvar_26 = tmpvar_27;
  } else {
    highp vec4 tmpvar_28;
    tmpvar_28.x = -1.0;
    tmpvar_28.y = (tmpvar_22 * tmpvar_22);
    tmpvar_28.z = tmpvar_22;
    tmpvar_28.w = (0.5 + (0.5 / RES_MU));
    tmpvar_26 = tmpvar_28;
  };
  uR_21 = ((0.5 / RES_R) + ((tmpvar_23 / tmpvar_22) * (1.0 - (1.0/(RES_R)))));
  uMu_20 = (tmpvar_26.w + ((((tmpvar_24 * tmpvar_26.x) + sqrt((tmpvar_25 + tmpvar_26.y))) / (tmpvar_23 + tmpvar_26.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_29;
  y_over_x_29 = (max (tmpvar_18, -0.1975) * 5.34962);
  highp float x_30;
  x_30 = (y_over_x_29 * inversesqrt(((y_over_x_29 * y_over_x_29) + 1.0)));
  highp float tmpvar_31;
  tmpvar_31 = ((0.5 / RES_MU_S) + (((((sign(x_30) * (1.5708 - (sqrt((1.0 - abs(x_30))) * (1.5708 + (abs(x_30) * (-0.214602 + (abs(x_30) * (0.0865667 + (abs(x_30) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_32;
  tmpvar_32 = (((tmpvar_17 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_33;
  tmpvar_33 = floor(tmpvar_32);
  highp float tmpvar_34;
  tmpvar_34 = (tmpvar_32 - tmpvar_33);
  highp float tmpvar_35;
  tmpvar_35 = (floor(((uR_21 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_36;
  tmpvar_36 = (floor((uR_21 * RES_R)) / RES_R);
  highp float tmpvar_37;
  tmpvar_37 = fract((uR_21 * RES_R));
  highp vec4 tmpvar_38;
  tmpvar_38.zw = vec2(0.0, 0.0);
  tmpvar_38.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_38.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_39;
  tmpvar_39 = textureLod (_Inscatter, tmpvar_38.xy, 0.0);
  highp vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_40.y = ((uMu_20 / RES_R) + tmpvar_35);
  lowp vec4 tmpvar_41;
  tmpvar_41 = textureLod (_Inscatter, tmpvar_40.xy, 0.0);
  highp vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = ((tmpvar_33 + tmpvar_31) / RES_NU);
  tmpvar_42.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_43;
  tmpvar_43 = textureLod (_Inscatter, tmpvar_42.xy, 0.0);
  highp vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_33 + tmpvar_31) + 1.0) / RES_NU);
  tmpvar_44.y = ((uMu_20 / RES_R) + tmpvar_36);
  lowp vec4 tmpvar_45;
  tmpvar_45 = textureLod (_Inscatter, tmpvar_44.xy, 0.0);
  tmpvar_19 = ((((tmpvar_39 * (1.0 - tmpvar_34)) + (tmpvar_41 * tmpvar_34)) * (1.0 - tmpvar_37)) + (((tmpvar_43 * (1.0 - tmpvar_34)) + (tmpvar_45 * tmpvar_34)) * tmpvar_37));
  if ((r_10 <= tmpvar_12)) {
    result_11 = ((tmpvar_19.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_17 * tmpvar_17)))) + ((((tmpvar_19.xyz * tmpvar_19.w) / max (tmpvar_19.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_17)), -1.5)) * (1.0 + (tmpvar_17 * tmpvar_17))) / (2.0 + (mieG * mieG)))));
  } else {
    result_11 = vec3(0.0, 0.0, 0.0);
  };
  highp vec3 L_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = ((result_11 * _Sun_Intensity) * xlat_mutable_Exposure);
  L_46 = tmpvar_47;
  highp float tmpvar_48;
  if ((tmpvar_47.x < 1.413)) {
    tmpvar_48 = pow ((tmpvar_47.x * 0.38317), 0.454545);
  } else {
    tmpvar_48 = (1.0 - exp(-(tmpvar_47.x)));
  };
  L_46.x = tmpvar_48;
  highp float tmpvar_49;
  if ((tmpvar_47.y < 1.413)) {
    tmpvar_49 = pow ((tmpvar_47.y * 0.38317), 0.454545);
  } else {
    tmpvar_49 = (1.0 - exp(-(tmpvar_47.y)));
  };
  L_46.y = tmpvar_49;
  highp float tmpvar_50;
  if ((tmpvar_47.z < 1.413)) {
    tmpvar_50 = pow ((tmpvar_47.z * 0.38317), 0.454545);
  } else {
    tmpvar_50 = (1.0 - exp(-(tmpvar_47.z)));
  };
  L_46.z = tmpvar_50;
  highp vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = (_Alpha_Global * L_46);
  _glesFragData[0] = tmpvar_51;
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
  tmpvar_4 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, tmpvar_4);
  float tmpvar_6;
  tmpvar_6 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * tmpvar_6) - ((4.0 * tmpvar_5) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  float tmpvar_15;
  tmpvar_15 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_11.x = (tmpvar_4.x + _viewdirOffset);
  vec3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_11);
  viewdir_11 = tmpvar_16;
  float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_10, camera_10));
  r_13 = tmpvar_17;
  float tmpvar_18;
  tmpvar_18 = dot (camera_10, tmpvar_16);
  rMu_12 = tmpvar_18;
  float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_18) - sqrt((((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (tmpvar_15 * tmpvar_15)))), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_10 = (camera_10 + (tmpvar_19 * tmpvar_16));
    rMu_12 = (tmpvar_18 + tmpvar_19);
    r_13 = tmpvar_15;
  };
  float tmpvar_20;
  tmpvar_20 = dot (tmpvar_16, _Sun_WorldSunDir);
  float tmpvar_21;
  tmpvar_21 = (dot (camera_10, _Sun_WorldSunDir) / r_13);
  vec4 tmpvar_22;
  float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_15 * tmpvar_15) - (Rg * Rg)));
  float tmpvar_24;
  tmpvar_24 = sqrt(((r_13 * r_13) - (Rg * Rg)));
  float tmpvar_25;
  tmpvar_25 = (r_13 * (rMu_12 / r_13));
  float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_13 * r_13)) + (Rg * Rg));
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
  float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  float tmpvar_31;
  tmpvar_31 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_32;
  y_over_x_32 = (max (tmpvar_21, -0.1975) * 5.34962);
  float x_33;
  x_33 = (y_over_x_32 * inversesqrt(((y_over_x_32 * y_over_x_32) + 1.0)));
  float tmpvar_34;
  tmpvar_34 = ((0.5 / RES_MU_S) + (((((sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_35;
  tmpvar_35 = (((tmpvar_20 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_36;
  tmpvar_36 = floor(tmpvar_35);
  float tmpvar_37;
  tmpvar_37 = (tmpvar_35 - tmpvar_36);
  float tmpvar_38;
  tmpvar_38 = (floor(((tmpvar_30 * RES_R) - 1.0)) / RES_R);
  float tmpvar_39;
  tmpvar_39 = (floor((tmpvar_30 * RES_R)) / RES_R);
  float tmpvar_40;
  tmpvar_40 = fract((tmpvar_30 * RES_R));
  vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_41.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  vec4 tmpvar_42;
  tmpvar_42.zw = vec2(0.0, 0.0);
  tmpvar_42.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_42.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_43.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  vec4 tmpvar_44;
  tmpvar_44.zw = vec2(0.0, 0.0);
  tmpvar_44.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_44.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  tmpvar_22 = ((((texture2DLod (_Inscatter, tmpvar_41.xy, 0.0) * (1.0 - tmpvar_37)) + (texture2DLod (_Inscatter, tmpvar_42.xy, 0.0) * tmpvar_37)) * (1.0 - tmpvar_40)) + (((texture2DLod (_Inscatter, tmpvar_43.xy, 0.0) * (1.0 - tmpvar_37)) + (texture2DLod (_Inscatter, tmpvar_44.xy, 0.0) * tmpvar_37)) * tmpvar_40));
  if ((r_13 <= tmpvar_15)) {
    result_14 = ((tmpvar_22.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_20 * tmpvar_20)))) + ((((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_20)), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20))) / (2.0 + (mieG * mieG)))));
  } else {
    result_14 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_14 * _Sun_Intensity);
  float tmpvar_45;
  float tmpvar_46;
  tmpvar_46 = dot (tmpvar_4, tmpvar_4);
  float tmpvar_47;
  tmpvar_47 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  float tmpvar_48;
  tmpvar_48 = ((tmpvar_47 * tmpvar_47) - ((4.0 * tmpvar_46) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_15 * tmpvar_15))));
  if ((tmpvar_48 < 0.0)) {
    tmpvar_45 = -1.0;
  } else {
    float tmpvar_49;
    tmpvar_49 = ((-(tmpvar_47) - sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    float tmpvar_50;
    if ((tmpvar_49 < 0.0)) {
      tmpvar_50 = ((-(tmpvar_47) + sqrt(tmpvar_48)) / (2.0 * tmpvar_46));
    } else {
      tmpvar_50 = tmpvar_49;
    };
    tmpvar_45 = tmpvar_50;
  };
  if ((tmpvar_45 != -1.0)) {
    worldPos_2 = (_WorldSpaceCameraPos + (tmpvar_4 * tmpvar_45));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_45 != -1.0)) {
    int j_51;
    int i_52;
    i_52 = 0;
    for (int i_52 = 0; i_52 < 4; ) {
      if ((lightOccluders1[3][i_52] <= 0.0)) {
        break;
      };
      vec4 v_53;
      v_53.x = lightOccluders1[0][i_52];
      v_53.y = lightOccluders1[1][i_52];
      v_53.z = lightOccluders1[2][i_52];
      v_53.w = lightOccluders1[3][i_52];
      vec3 tmpvar_54;
      tmpvar_54 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_55;
      tmpvar_55 = sqrt(dot (tmpvar_54, tmpvar_54));
      vec3 tmpvar_56;
      tmpvar_56 = (tmpvar_54 / vec3(tmpvar_55));
      vec3 tmpvar_57;
      tmpvar_57 = (v_53.xyz - worldPos_2);
      float tmpvar_58;
      tmpvar_58 = sqrt(dot (tmpvar_57, tmpvar_57));
      vec3 tmpvar_59;
      tmpvar_59 = (tmpvar_57 / tmpvar_58);
      vec3 tmpvar_60;
      tmpvar_60 = ((tmpvar_56.yzx * tmpvar_59.zxy) - (tmpvar_56.zxy * tmpvar_59.yzx));
      float tmpvar_61;
      tmpvar_61 = min (1.0, sqrt(dot (tmpvar_60, tmpvar_60)));
      float tmpvar_62;
      tmpvar_62 = min (1.0, (vec3(lightOccluders1[3][i_52]) / tmpvar_58).x);
      float t_63;
      t_63 = max (min ((((-((vec3(tmpvar_55) * ((sign(tmpvar_61) * (1.5708 - (sqrt((1.0 - abs(tmpvar_61))) * (1.5708 + (abs(tmpvar_61) * (-0.214602 + (abs(tmpvar_61) * (0.0865667 + (abs(tmpvar_61) * -0.0310296))))))))) - (sign(tmpvar_62) * (1.5708 - (sqrt((1.0 - abs(tmpvar_62))) * (1.5708 + (abs(tmpvar_62) * (-0.214602 + (abs(tmpvar_62) * (0.0865667 + (abs(tmpvar_62) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      float t_64;
      t_64 = max (min ((dot (tmpvar_56, tmpvar_59) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_63 * (t_63 * (3.0 - (2.0 * t_63)))) * (t_64 * (t_64 * (3.0 - (2.0 * t_64)))))));
      i_52 = (i_52 + 1);
    };
    j_51 = 0;
    for (int j_51 = 0; j_51 < 4; ) {
      if ((lightOccluders2[3][j_51] <= 0.0)) {
        break;
      };
      vec4 v_65;
      v_65.x = lightOccluders2[0][j_51];
      v_65.y = lightOccluders2[1][j_51];
      v_65.z = lightOccluders2[2][j_51];
      v_65.w = lightOccluders2[3][j_51];
      vec3 tmpvar_66;
      tmpvar_66 = (sunPosAndRadius.xyz - worldPos_2);
      float tmpvar_67;
      tmpvar_67 = sqrt(dot (tmpvar_66, tmpvar_66));
      vec3 tmpvar_68;
      tmpvar_68 = (tmpvar_66 / vec3(tmpvar_67));
      vec3 tmpvar_69;
      tmpvar_69 = (v_65.xyz - worldPos_2);
      float tmpvar_70;
      tmpvar_70 = sqrt(dot (tmpvar_69, tmpvar_69));
      vec3 tmpvar_71;
      tmpvar_71 = (tmpvar_69 / tmpvar_70);
      vec3 tmpvar_72;
      tmpvar_72 = ((tmpvar_68.yzx * tmpvar_71.zxy) - (tmpvar_68.zxy * tmpvar_71.yzx));
      float tmpvar_73;
      tmpvar_73 = min (1.0, sqrt(dot (tmpvar_72, tmpvar_72)));
      float tmpvar_74;
      tmpvar_74 = min (1.0, (vec3(lightOccluders2[3][j_51]) / tmpvar_70).x);
      float t_75;
      t_75 = max (min ((((-((vec3(tmpvar_67) * ((sign(tmpvar_73) * (1.5708 - (sqrt((1.0 - abs(tmpvar_73))) * (1.5708 + (abs(tmpvar_73) * (-0.214602 + (abs(tmpvar_73) * (0.0865667 + (abs(tmpvar_73) * -0.0310296))))))))) - (sign(tmpvar_74) * (1.5708 - (sqrt((1.0 - abs(tmpvar_74))) * (1.5708 + (abs(tmpvar_74) * (-0.214602 + (abs(tmpvar_74) * (0.0865667 + (abs(tmpvar_74) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      float t_76;
      t_76 = max (min ((dot (tmpvar_68, tmpvar_71) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_75 * (t_75 * (3.0 - (2.0 * t_75)))) * (t_76 * (t_76 * (3.0 - (2.0 * t_76)))))));
      j_51 = (j_51 + 1);
    };
  };
  vec3 L_77;
  vec3 tmpvar_78;
  tmpvar_78 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_77 = tmpvar_78;
  float tmpvar_79;
  if ((tmpvar_78.x < 1.413)) {
    tmpvar_79 = pow ((tmpvar_78.x * 0.38317), 0.454545);
  } else {
    tmpvar_79 = (1.0 - exp(-(tmpvar_78.x)));
  };
  L_77.x = tmpvar_79;
  float tmpvar_80;
  if ((tmpvar_78.y < 1.413)) {
    tmpvar_80 = pow ((tmpvar_78.y * 0.38317), 0.454545);
  } else {
    tmpvar_80 = (1.0 - exp(-(tmpvar_78.y)));
  };
  L_77.y = tmpvar_80;
  float tmpvar_81;
  if ((tmpvar_78.z < 1.413)) {
    tmpvar_81 = pow ((tmpvar_78.z * 0.38317), 0.454545);
  } else {
    tmpvar_81 = (1.0 - exp(-(tmpvar_78.z)));
  };
  L_77.z = tmpvar_81;
  vec4 tmpvar_82;
  tmpvar_82.w = 1.0;
  tmpvar_82.xyz = (_Alpha_Global * L_77);
  gl_FragData[0] = tmpvar_82;
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
  tmpvar_4 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_6;
  tmpvar_6 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * tmpvar_6) - ((4.0 * tmpvar_5) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  highp float tmpvar_15;
  tmpvar_15 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_11.x = (tmpvar_4.x + _viewdirOffset);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_11);
  viewdir_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_10, camera_10));
  r_13 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (camera_10, tmpvar_16);
  rMu_12 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_18) - sqrt((((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (tmpvar_15 * tmpvar_15)))), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_10 = (camera_10 + (tmpvar_19 * tmpvar_16));
    rMu_12 = (tmpvar_18 + tmpvar_19);
    r_13 = tmpvar_15;
  };
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_16, _Sun_WorldSunDir);
  highp float tmpvar_21;
  tmpvar_21 = (dot (camera_10, _Sun_WorldSunDir) / r_13);
  highp vec4 tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_15 * tmpvar_15) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_13 * r_13) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_13 * (rMu_12 / r_13));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_13 * r_13)) + (Rg * Rg));
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
  highp float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_32;
  y_over_x_32 = (max (tmpvar_21, -0.1975) * 5.34962);
  highp float x_33;
  x_33 = (y_over_x_32 * inversesqrt(((y_over_x_32 * y_over_x_32) + 1.0)));
  highp float tmpvar_34;
  tmpvar_34 = ((0.5 / RES_MU_S) + (((((sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_20 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_36;
  tmpvar_36 = floor(tmpvar_35);
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_35 - tmpvar_36);
  highp float tmpvar_38;
  tmpvar_38 = (floor(((tmpvar_30 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_39;
  tmpvar_39 = (floor((tmpvar_30 * RES_R)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = fract((tmpvar_30 * RES_R));
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_41.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_42;
  tmpvar_42 = texture2DLodEXT (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_44;
  tmpvar_44 = texture2DLodEXT (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_45.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2DLodEXT (_Inscatter, tmpvar_45.xy, 0.0);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_47.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_48;
  tmpvar_48 = texture2DLodEXT (_Inscatter, tmpvar_47.xy, 0.0);
  tmpvar_22 = ((((tmpvar_42 * (1.0 - tmpvar_37)) + (tmpvar_44 * tmpvar_37)) * (1.0 - tmpvar_40)) + (((tmpvar_46 * (1.0 - tmpvar_37)) + (tmpvar_48 * tmpvar_37)) * tmpvar_40));
  if ((r_13 <= tmpvar_15)) {
    result_14 = ((tmpvar_22.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_20 * tmpvar_20)))) + ((((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_20)), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20))) / (2.0 + (mieG * mieG)))));
  } else {
    result_14 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_14 * _Sun_Intensity);
  highp float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_51;
  tmpvar_51 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) - ((4.0 * tmpvar_50) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_15 * tmpvar_15))));
  if ((tmpvar_52 < 0.0)) {
    tmpvar_49 = -1.0;
  } else {
    highp float tmpvar_53;
    tmpvar_53 = ((-(tmpvar_51) - sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
    highp float tmpvar_54;
    if ((tmpvar_53 < 0.0)) {
      tmpvar_54 = ((-(tmpvar_51) + sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
    } else {
      tmpvar_54 = tmpvar_53;
    };
    tmpvar_49 = tmpvar_54;
  };
  if ((tmpvar_49 != -1.0)) {
    worldPos_2 = (_WorldSpaceCameraPos + (tmpvar_4 * tmpvar_49));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_49 != -1.0)) {
    int j_55;
    int i_56;
    i_56 = 0;
    for (int i_56 = 0; i_56 < 4; ) {
      if ((lightOccluders1[3][i_56] <= 0.0)) {
        break;
      };
      highp vec4 v_57;
      v_57.x = lightOccluders1[0][i_56];
      v_57.y = lightOccluders1[1][i_56];
      v_57.z = lightOccluders1[2][i_56];
      v_57.w = lightOccluders1[3][i_56];
      highp vec3 tmpvar_58;
      tmpvar_58 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_59;
      tmpvar_59 = sqrt(dot (tmpvar_58, tmpvar_58));
      highp vec3 tmpvar_60;
      tmpvar_60 = (tmpvar_58 / vec3(tmpvar_59));
      highp vec3 tmpvar_61;
      tmpvar_61 = (v_57.xyz - worldPos_2);
      highp float tmpvar_62;
      tmpvar_62 = sqrt(dot (tmpvar_61, tmpvar_61));
      highp vec3 tmpvar_63;
      tmpvar_63 = (tmpvar_61 / tmpvar_62);
      highp vec3 tmpvar_64;
      tmpvar_64 = ((tmpvar_60.yzx * tmpvar_63.zxy) - (tmpvar_60.zxy * tmpvar_63.yzx));
      highp float tmpvar_65;
      tmpvar_65 = min (1.0, sqrt(dot (tmpvar_64, tmpvar_64)));
      highp float tmpvar_66;
      tmpvar_66 = min (1.0, (vec3(lightOccluders1[3][i_56]) / tmpvar_62).x);
      highp float t_67;
      t_67 = max (min ((((-((vec3(tmpvar_59) * ((sign(tmpvar_65) * (1.5708 - (sqrt((1.0 - abs(tmpvar_65))) * (1.5708 + (abs(tmpvar_65) * (-0.214602 + (abs(tmpvar_65) * (0.0865667 + (abs(tmpvar_65) * -0.0310296))))))))) - (sign(tmpvar_66) * (1.5708 - (sqrt((1.0 - abs(tmpvar_66))) * (1.5708 + (abs(tmpvar_66) * (-0.214602 + (abs(tmpvar_66) * (0.0865667 + (abs(tmpvar_66) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_68;
      t_68 = max (min ((dot (tmpvar_60, tmpvar_63) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_67 * (t_67 * (3.0 - (2.0 * t_67)))) * (t_68 * (t_68 * (3.0 - (2.0 * t_68)))))));
      i_56 = (i_56 + 1);
    };
    j_55 = 0;
    for (int j_55 = 0; j_55 < 4; ) {
      if ((lightOccluders2[3][j_55] <= 0.0)) {
        break;
      };
      highp vec4 v_69;
      v_69.x = lightOccluders2[0][j_55];
      v_69.y = lightOccluders2[1][j_55];
      v_69.z = lightOccluders2[2][j_55];
      v_69.w = lightOccluders2[3][j_55];
      highp vec3 tmpvar_70;
      tmpvar_70 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_71;
      tmpvar_71 = sqrt(dot (tmpvar_70, tmpvar_70));
      highp vec3 tmpvar_72;
      tmpvar_72 = (tmpvar_70 / vec3(tmpvar_71));
      highp vec3 tmpvar_73;
      tmpvar_73 = (v_69.xyz - worldPos_2);
      highp float tmpvar_74;
      tmpvar_74 = sqrt(dot (tmpvar_73, tmpvar_73));
      highp vec3 tmpvar_75;
      tmpvar_75 = (tmpvar_73 / tmpvar_74);
      highp vec3 tmpvar_76;
      tmpvar_76 = ((tmpvar_72.yzx * tmpvar_75.zxy) - (tmpvar_72.zxy * tmpvar_75.yzx));
      highp float tmpvar_77;
      tmpvar_77 = min (1.0, sqrt(dot (tmpvar_76, tmpvar_76)));
      highp float tmpvar_78;
      tmpvar_78 = min (1.0, (vec3(lightOccluders2[3][j_55]) / tmpvar_74).x);
      highp float t_79;
      t_79 = max (min ((((-((vec3(tmpvar_71) * ((sign(tmpvar_77) * (1.5708 - (sqrt((1.0 - abs(tmpvar_77))) * (1.5708 + (abs(tmpvar_77) * (-0.214602 + (abs(tmpvar_77) * (0.0865667 + (abs(tmpvar_77) * -0.0310296))))))))) - (sign(tmpvar_78) * (1.5708 - (sqrt((1.0 - abs(tmpvar_78))) * (1.5708 + (abs(tmpvar_78) * (-0.214602 + (abs(tmpvar_78) * (0.0865667 + (abs(tmpvar_78) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_80;
      t_80 = max (min ((dot (tmpvar_72, tmpvar_75) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_79 * (t_79 * (3.0 - (2.0 * t_79)))) * (t_80 * (t_80 * (3.0 - (2.0 * t_80)))))));
      j_55 = (j_55 + 1);
    };
  };
  highp vec3 L_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_81 = tmpvar_82;
  highp float tmpvar_83;
  if ((tmpvar_82.x < 1.413)) {
    tmpvar_83 = pow ((tmpvar_82.x * 0.38317), 0.454545);
  } else {
    tmpvar_83 = (1.0 - exp(-(tmpvar_82.x)));
  };
  L_81.x = tmpvar_83;
  highp float tmpvar_84;
  if ((tmpvar_82.y < 1.413)) {
    tmpvar_84 = pow ((tmpvar_82.y * 0.38317), 0.454545);
  } else {
    tmpvar_84 = (1.0 - exp(-(tmpvar_82.y)));
  };
  L_81.y = tmpvar_84;
  highp float tmpvar_85;
  if ((tmpvar_82.z < 1.413)) {
    tmpvar_85 = pow ((tmpvar_82.z * 0.38317), 0.454545);
  } else {
    tmpvar_85 = (1.0 - exp(-(tmpvar_82.z)));
  };
  L_81.z = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = (_Alpha_Global * L_81);
  gl_FragData[0] = tmpvar_86;
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
    highp vec3 WCP = _WorldSpaceCameraPos;
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
  tmpvar_4 = normalize((xlv_TEXCOORD0 - _WorldSpaceCameraPos));
  highp float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_6;
  tmpvar_6 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * tmpvar_6) - ((4.0 * tmpvar_5) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (Rg * Rg))));
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
  highp float tmpvar_15;
  tmpvar_15 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_11.x = (tmpvar_4.x + _viewdirOffset);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(viewdir_11);
  viewdir_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = sqrt(dot (camera_10, camera_10));
  r_13 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (camera_10, tmpvar_16);
  rMu_12 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = max ((-(tmpvar_18) - sqrt((((tmpvar_18 * tmpvar_18) - (tmpvar_17 * tmpvar_17)) + (tmpvar_15 * tmpvar_15)))), 0.0);
  if ((tmpvar_19 > 0.0)) {
    camera_10 = (camera_10 + (tmpvar_19 * tmpvar_16));
    rMu_12 = (tmpvar_18 + tmpvar_19);
    r_13 = tmpvar_15;
  };
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_16, _Sun_WorldSunDir);
  highp float tmpvar_21;
  tmpvar_21 = (dot (camera_10, _Sun_WorldSunDir) / r_13);
  highp vec4 tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = sqrt(((tmpvar_15 * tmpvar_15) - (Rg * Rg)));
  highp float tmpvar_24;
  tmpvar_24 = sqrt(((r_13 * r_13) - (Rg * Rg)));
  highp float tmpvar_25;
  tmpvar_25 = (r_13 * (rMu_12 / r_13));
  highp float tmpvar_26;
  tmpvar_26 = (((tmpvar_25 * tmpvar_25) - (r_13 * r_13)) + (Rg * Rg));
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
  highp float tmpvar_30;
  tmpvar_30 = ((0.5 / RES_R) + ((tmpvar_24 / tmpvar_23) * (1.0 - (1.0/(RES_R)))));
  highp float tmpvar_31;
  tmpvar_31 = (tmpvar_27.w + ((((tmpvar_25 * tmpvar_27.x) + sqrt((tmpvar_26 + tmpvar_27.y))) / (tmpvar_24 + tmpvar_27.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_32;
  y_over_x_32 = (max (tmpvar_21, -0.1975) * 5.34962);
  highp float x_33;
  x_33 = (y_over_x_32 * inversesqrt(((y_over_x_32 * y_over_x_32) + 1.0)));
  highp float tmpvar_34;
  tmpvar_34 = ((0.5 / RES_MU_S) + (((((sign(x_33) * (1.5708 - (sqrt((1.0 - abs(x_33))) * (1.5708 + (abs(x_33) * (-0.214602 + (abs(x_33) * (0.0865667 + (abs(x_33) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_35;
  tmpvar_35 = (((tmpvar_20 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_36;
  tmpvar_36 = floor(tmpvar_35);
  highp float tmpvar_37;
  tmpvar_37 = (tmpvar_35 - tmpvar_36);
  highp float tmpvar_38;
  tmpvar_38 = (floor(((tmpvar_30 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_39;
  tmpvar_39 = (floor((tmpvar_30 * RES_R)) / RES_R);
  highp float tmpvar_40;
  tmpvar_40 = fract((tmpvar_30 * RES_R));
  highp vec4 tmpvar_41;
  tmpvar_41.zw = vec2(0.0, 0.0);
  tmpvar_41.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_41.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_42;
  tmpvar_42 = textureLod (_Inscatter, tmpvar_41.xy, 0.0);
  highp vec4 tmpvar_43;
  tmpvar_43.zw = vec2(0.0, 0.0);
  tmpvar_43.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_43.y = ((tmpvar_31 / RES_R) + tmpvar_38);
  lowp vec4 tmpvar_44;
  tmpvar_44 = textureLod (_Inscatter, tmpvar_43.xy, 0.0);
  highp vec4 tmpvar_45;
  tmpvar_45.zw = vec2(0.0, 0.0);
  tmpvar_45.x = ((tmpvar_36 + tmpvar_34) / RES_NU);
  tmpvar_45.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_46;
  tmpvar_46 = textureLod (_Inscatter, tmpvar_45.xy, 0.0);
  highp vec4 tmpvar_47;
  tmpvar_47.zw = vec2(0.0, 0.0);
  tmpvar_47.x = (((tmpvar_36 + tmpvar_34) + 1.0) / RES_NU);
  tmpvar_47.y = ((tmpvar_31 / RES_R) + tmpvar_39);
  lowp vec4 tmpvar_48;
  tmpvar_48 = textureLod (_Inscatter, tmpvar_47.xy, 0.0);
  tmpvar_22 = ((((tmpvar_42 * (1.0 - tmpvar_37)) + (tmpvar_44 * tmpvar_37)) * (1.0 - tmpvar_40)) + (((tmpvar_46 * (1.0 - tmpvar_37)) + (tmpvar_48 * tmpvar_37)) * tmpvar_40));
  if ((r_13 <= tmpvar_15)) {
    result_14 = ((tmpvar_22.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_20 * tmpvar_20)))) + ((((tmpvar_22.xyz * tmpvar_22.w) / max (tmpvar_22.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_20)), -1.5)) * (1.0 + (tmpvar_20 * tmpvar_20))) / (2.0 + (mieG * mieG)))));
  } else {
    result_14 = vec3(0.0, 0.0, 0.0);
  };
  inscatter_3 = (result_14 * _Sun_Intensity);
  highp float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = dot (tmpvar_4, tmpvar_4);
  highp float tmpvar_51;
  tmpvar_51 = (2.0 * dot (tmpvar_4, (_WorldSpaceCameraPos - _Globals_Origin)));
  highp float tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) - ((4.0 * tmpvar_50) * (((dot (_Globals_Origin, _Globals_Origin) + dot (_WorldSpaceCameraPos, _WorldSpaceCameraPos)) - (2.0 * dot (_Globals_Origin, _WorldSpaceCameraPos))) - (tmpvar_15 * tmpvar_15))));
  if ((tmpvar_52 < 0.0)) {
    tmpvar_49 = -1.0;
  } else {
    highp float tmpvar_53;
    tmpvar_53 = ((-(tmpvar_51) - sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
    highp float tmpvar_54;
    if ((tmpvar_53 < 0.0)) {
      tmpvar_54 = ((-(tmpvar_51) + sqrt(tmpvar_52)) / (2.0 * tmpvar_50));
    } else {
      tmpvar_54 = tmpvar_53;
    };
    tmpvar_49 = tmpvar_54;
  };
  if ((tmpvar_49 != -1.0)) {
    worldPos_2 = (_WorldSpaceCameraPos + (tmpvar_4 * tmpvar_49));
  };
  eclipseShadow_1 = 1.0;
  if ((tmpvar_49 != -1.0)) {
    int j_55;
    int i_56;
    i_56 = 0;
    for (int i_56 = 0; i_56 < 4; ) {
      if ((lightOccluders1[3][i_56] <= 0.0)) {
        break;
      };
      highp vec4 v_57;
      v_57.x = lightOccluders1[0][i_56];
      v_57.y = lightOccluders1[1][i_56];
      v_57.z = lightOccluders1[2][i_56];
      v_57.w = lightOccluders1[3][i_56];
      highp vec3 tmpvar_58;
      tmpvar_58 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_59;
      tmpvar_59 = sqrt(dot (tmpvar_58, tmpvar_58));
      highp vec3 tmpvar_60;
      tmpvar_60 = (tmpvar_58 / vec3(tmpvar_59));
      highp vec3 tmpvar_61;
      tmpvar_61 = (v_57.xyz - worldPos_2);
      highp float tmpvar_62;
      tmpvar_62 = sqrt(dot (tmpvar_61, tmpvar_61));
      highp vec3 tmpvar_63;
      tmpvar_63 = (tmpvar_61 / tmpvar_62);
      highp vec3 tmpvar_64;
      tmpvar_64 = ((tmpvar_60.yzx * tmpvar_63.zxy) - (tmpvar_60.zxy * tmpvar_63.yzx));
      highp float tmpvar_65;
      tmpvar_65 = min (1.0, sqrt(dot (tmpvar_64, tmpvar_64)));
      highp float tmpvar_66;
      tmpvar_66 = min (1.0, (vec3(lightOccluders1[3][i_56]) / tmpvar_62).x);
      highp float t_67;
      t_67 = max (min ((((-((vec3(tmpvar_59) * ((sign(tmpvar_65) * (1.5708 - (sqrt((1.0 - abs(tmpvar_65))) * (1.5708 + (abs(tmpvar_65) * (-0.214602 + (abs(tmpvar_65) * (0.0865667 + (abs(tmpvar_65) * -0.0310296))))))))) - (sign(tmpvar_66) * (1.5708 - (sqrt((1.0 - abs(tmpvar_66))) * (1.5708 + (abs(tmpvar_66) * (-0.214602 + (abs(tmpvar_66) * (0.0865667 + (abs(tmpvar_66) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_68;
      t_68 = max (min ((dot (tmpvar_60, tmpvar_63) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_67 * (t_67 * (3.0 - (2.0 * t_67)))) * (t_68 * (t_68 * (3.0 - (2.0 * t_68)))))));
      i_56 = (i_56 + 1);
    };
    j_55 = 0;
    for (int j_55 = 0; j_55 < 4; ) {
      if ((lightOccluders2[3][j_55] <= 0.0)) {
        break;
      };
      highp vec4 v_69;
      v_69.x = lightOccluders2[0][j_55];
      v_69.y = lightOccluders2[1][j_55];
      v_69.z = lightOccluders2[2][j_55];
      v_69.w = lightOccluders2[3][j_55];
      highp vec3 tmpvar_70;
      tmpvar_70 = (sunPosAndRadius.xyz - worldPos_2);
      highp float tmpvar_71;
      tmpvar_71 = sqrt(dot (tmpvar_70, tmpvar_70));
      highp vec3 tmpvar_72;
      tmpvar_72 = (tmpvar_70 / vec3(tmpvar_71));
      highp vec3 tmpvar_73;
      tmpvar_73 = (v_69.xyz - worldPos_2);
      highp float tmpvar_74;
      tmpvar_74 = sqrt(dot (tmpvar_73, tmpvar_73));
      highp vec3 tmpvar_75;
      tmpvar_75 = (tmpvar_73 / tmpvar_74);
      highp vec3 tmpvar_76;
      tmpvar_76 = ((tmpvar_72.yzx * tmpvar_75.zxy) - (tmpvar_72.zxy * tmpvar_75.yzx));
      highp float tmpvar_77;
      tmpvar_77 = min (1.0, sqrt(dot (tmpvar_76, tmpvar_76)));
      highp float tmpvar_78;
      tmpvar_78 = min (1.0, (vec3(lightOccluders2[3][j_55]) / tmpvar_74).x);
      highp float t_79;
      t_79 = max (min ((((-((vec3(tmpvar_71) * ((sign(tmpvar_77) * (1.5708 - (sqrt((1.0 - abs(tmpvar_77))) * (1.5708 + (abs(tmpvar_77) * (-0.214602 + (abs(tmpvar_77) * (0.0865667 + (abs(tmpvar_77) * -0.0310296))))))))) - (sign(tmpvar_78) * (1.5708 - (sqrt((1.0 - abs(tmpvar_78))) * (1.5708 + (abs(tmpvar_78) * (-0.214602 + (abs(tmpvar_78) * (0.0865667 + (abs(tmpvar_78) * -0.0310296))))))))))).x) / sunPosAndRadius.www).x - -1.0) / 2.0), 1.0), 0.0);
      highp float t_80;
      t_80 = max (min ((dot (tmpvar_72, tmpvar_75) / 0.2), 1.0), 0.0);
      eclipseShadow_1 = (eclipseShadow_1 * (1.0 - ((t_79 * (t_79 * (3.0 - (2.0 * t_79)))) * (t_80 * (t_80 * (3.0 - (2.0 * t_80)))))));
      j_55 = (j_55 + 1);
    };
  };
  highp vec3 L_81;
  highp vec3 tmpvar_82;
  tmpvar_82 = ((inscatter_3 * eclipseShadow_1) * xlat_mutable_Exposure);
  L_81 = tmpvar_82;
  highp float tmpvar_83;
  if ((tmpvar_82.x < 1.413)) {
    tmpvar_83 = pow ((tmpvar_82.x * 0.38317), 0.454545);
  } else {
    tmpvar_83 = (1.0 - exp(-(tmpvar_82.x)));
  };
  L_81.x = tmpvar_83;
  highp float tmpvar_84;
  if ((tmpvar_82.y < 1.413)) {
    tmpvar_84 = pow ((tmpvar_82.y * 0.38317), 0.454545);
  } else {
    tmpvar_84 = (1.0 - exp(-(tmpvar_82.y)));
  };
  L_81.y = tmpvar_84;
  highp float tmpvar_85;
  if ((tmpvar_82.z < 1.413)) {
    tmpvar_85 = pow ((tmpvar_82.z * 0.38317), 0.454545);
  } else {
    tmpvar_85 = (1.0 - exp(-(tmpvar_82.z)));
  };
  L_81.z = tmpvar_85;
  highp vec4 tmpvar_86;
  tmpvar_86.w = 1.0;
  tmpvar_86.xyz = (_Alpha_Global * L_81);
  _glesFragData[0] = tmpvar_86;
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
def c18, 0.00000100, 0.00000000, 1.00000000, 16.00000000
def c19, -0.19750001, 5.34960032, -1.00000000, -0.12123910
def c20, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c21, 0.99999559, 1.57079601, 0.90909088, 0.74000001
def c22, 0.50000000, 3.00000000, 4.00000000, 2.00000000
def c23, -1.50000000, 0.00010000, 1.50000000, -1.41299999
def c24, 2.71828198, 0.38317001, 0.45454544, 0
dcl_texcoord0 v0.xyz
add r1.xyz, v0, -c0
dp3 r0.x, r1, r1
rsq r0.x, r0.x
mul r1.xyz, r0.x, r1
mov r2.xyz, c0
mov r1.w, c6.x
add r1.w, -c5.x, r1
mul r1.w, r1, c12.x
add r2.xyz, -c15, r2
mov r0.yz, r1
add r0.x, r1, c13
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.w, r2, r2
rsq r0.w, r0.w
rcp r3.w, r0.w
dp3 r4.w, r2, r0
mul r0.w, r3, r3
add r1.w, r1, c5.x
mad r0.w, r4, r4, -r0
mad r2.w, r1, r1, r0
rsq r0.w, r2.w
rcp r0.w, r0.w
cmp r0.w, r2, r0, c18.x
add r0.w, -r4, -r0
max r0.w, r0, c18.y
cmp r2.w, -r0, r3, r1
mad r3.xyz, r0.w, r0, r2
cmp r3.xyz, -r0.w, r2, r3
dp3 r3.x, r3, c17
rcp r3.w, r2.w
mul r3.x, r3, r3.w
max r3.x, r3, c19
mul r3.x, r3, c19.y
abs r4.x, r3
max r3.y, r4.x, c18.z
min r3.z, r4.x, c18
rcp r3.y, r3.y
mul r3.w, r3.z, r3.y
mul r3.z, r3.w, r3.w
mad r3.y, r3.z, c20.x, c20
mad r3.y, r3, r3.z, c19.w
mad r3.y, r3, r3.z, c20.z
mad r3.y, r3, r3.z, c20.w
mad r3.y, r3, r3.z, c21.x
mul r3.z, r3.y, r3.w
add r3.w, r4.x, c19.z
dp3 r4.x, r0, c17
add r3.y, -r3.z, c21
cmp r3.y, -r3.w, r3.z, r3
cmp r3.y, r3.x, r3, -r3
mov r3.x, c10
add r0.x, c19.z, r3
add r0.y, r4.x, c18.z
mad r3.x, r3.y, c21.z, c21.w
rcp r3.y, c8.x
mul r0.x, r0.y, r0
rcp r0.z, c9.x
mul r0.x, r0, c22
frc r4.y, r0.x
add r0.y, -r0.z, c18.z
mad r0.y, r3.x, r0, r0.z
add r0.x, r0, -r4.y
mad r4.z, r0.y, c22.x, r0.x
add r0.y, r0.w, r4.w
cmp r3.z, -r0.w, r4.w, r0.y
add r0.x, r4.z, c18.z
rcp r3.w, c10.x
mul r3.x, r3.w, r0
mul r0.x, r2.w, r2.w
mad r0.x, r3.z, r3.z, -r0
mad r6.y, c5.x, c5.x, r0.x
mul r6.x, c5, c5
mad r0.x, r1.w, r1.w, -r6
rsq r4.w, r0.x
rcp r0.w, r4.w
cmp r0.z, r3, c18.y, c18
cmp r0.y, -r6, c18, c18.z
mul_pp r6.z, r0, r0.y
mul r5.y, r0.w, r0.w
mov r5.z, r0.w
mad r5.w, r3.y, c22.x, c22.x
add r1.w, -r2, r1
mov r5.x, c19.z
mad r0.w, -r3.y, c22.x, c22.x
mov r0.xyz, c18.zyyw
cmp r0, -r6.z, r5, r0
add r5.y, r0, r6
mad r0.y, r2.w, r2.w, -r6.x
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r4.w, r4, r0.y
rcp r5.w, c7.x
rsq r5.z, r5.y
add r5.y, -r5.w, c18.z
mul r4.w, r4, r5.y
rcp r5.y, r5.z
mad r5.y, r3.z, r0.x, r5
mad r4.w, r5, c22.x, r4
mul r0.x, r4.w, c7
add r0.y, r0.z, r0
rcp r3.z, r0.y
add r0.z, r0.x, c19
frc r0.y, r0.z
add r0.y, r0.z, -r0
mul r0.y, r0, r5.w
frc r4.w, r0.x
add r0.z, -r3.y, c22.x
mul r3.z, r5.y, r3
mad r6.x, r3.z, r0.z, r0.w
add r3.y, r0.x, -r4.w
mul r3.y, r5.w, r3
mad r5.y, r6.x, r5.w, r0
mad r3.y, r6.x, r5.w, r3
mov r3.z, c18.y
texldl r6, r3.xyzz, s0
mul r6, r4.y, r6
mov r5.x, r3
mov r5.z, c18.y
texldl r0, r5.xyzz, s0
mul r5.x, r4.z, r3.w
add r4.z, -r4.y, c18
mul r0, r4.y, r0
mov r5.z, r3.y
mov r5.w, c18.y
texldl r3, r5.xzzw, s0
mad r3, r4.z, r3, r6
mov r5.z, c18.y
texldl r5, r5.xyzz, s0
mul r3, r4.w, r3
mad r0, r5, r4.z, r0
add r4.y, -r4.w, c18.z
mad r0, r0, r4.y, r3
mul r3.w, r4.x, c3.x
mul r3.xyz, r0, r0.w
max r0.w, r0.x, c23.y
rcp r0.w, r0.w
mul r3.w, r3, c22
mad r3.w, c3.x, c3.x, -r3
add r3.w, r3, c18.z
pow r5, r3.w, c23.x
mov r3.w, c1.x
mul r4.z, c22, r3.w
mul r4.y, -c3.x, c3.x
mul r3.xyz, r3, r0.w
mad r4.x, r4, r4, c18.z
add r3.w, r4.y, c18.z
rcp r4.z, r4.z
mul r3.w, r4.z, r3
mov r0.w, r5.x
mul r0.w, r3, r0
mul r3.w, r4.x, r0
add r0.w, -r4.y, c22
mov r4.y, c1.x
rcp r0.w, r0.w
mul r0.w, r3, r0
mul r4.y, c18.w, r4
rcp r3.w, r4.y
rcp r6.x, c2.x
rcp r6.z, c2.z
rcp r6.y, c2.y
mul r6.xyz, r6, c2.x
mul r3.xyz, r3, r6
mul r3.xyz, r0.w, r3
mul r0.w, r3, r4.x
mul r0.xyz, r0.w, r0
mul r3.xyz, r3, c23.z
mad r0.xyz, r0, c22.y, r3
dp3 r3.x, r1, r1
dp3 r1.x, r2, r1
mul r1.z, r1.x, c22.w
dp3 r3.w, c15, c15
dp3 r0.w, c0, c0
add r0.w, r3, r0
mov r4.xyz, c15
dp3 r3.w, c0, r4
mad r0.w, -r3, c22, r0
mad r0.w, -c5.x, c5.x, r0
mul r0.w, r3.x, r0
mul r0.w, r0, c22.z
mad r1.y, r1.z, r1.z, -r0.w
rsq r1.x, r1.y
mul r0.w, r3.x, c22
rcp r1.x, r1.x
add r1.x, -r1.z, -r1
rcp r0.w, r0.w
mul r0.w, r1.x, r0
cmp r1.x, r1.w, c18.z, c18.y
cmp r0.w, r1.y, r0, c19.z
abs_pp r1.x, r1
cmp r1.xyz, -r1.x, c18.y, r0
cmp r0.y, -r0.w, c18, c18.z
abs_pp r0.y, r0
mov r0.x, c4
cmp r0.x, -r0.y, c16, r0
mul r1.xyz, r1, c11.x
mul r1.xyz, r1, r0.x
pow r0, c24.x, -r1.z
mul r1.w, r1.z, c24.y
pow r2, r1.w, c24.z
add r3.x, r1.z, c23.w
mov r0.y, r0.x
mov r0.x, r2
add r0.y, -r0, c18.z
cmp r3.z, r3.x, r0.y, r0.x
pow r0, c24.x, -r1.x
mul r1.z, r1.x, c24.y
pow r2, r1.z, c24.z
mov r0.y, r0.x
mov r0.x, r2
add r1.w, r1.x, c23
add r0.y, -r0, c18.z
cmp r3.x, r1.w, r0.y, r0
pow r0, c24.x, -r1.y
mov r0.y, r0.x
add r2.y, r1, c23.w
mul r2.x, r1.y, c24.y
pow r1, r2.x, c24.z
mov r0.x, r1
add r0.y, -r0, c18.z
cmp r3.y, r2, r0, r0.x
mul oC0.xyz, r3, c14.x
mov oC0.w, c18.z
"
}
SubProgram "d3d11 " {
// Stats: 157 math
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
eefiecedjdpidmccdnjciddpambcbiggmipoklogabaaaaaafmbgaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmbfaaaa
eaaaaaaaghafaaaafjaaaaaeegiocaaaaaaaaaaabgaaaaaafjaaaaaeegiocaaa
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
diaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaaigadbaaaadaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegiccaiaebaaaaaaaaaaaaaabeaaaaaaegiccaaaabaaaaaa
aeaaaaaabaaaaaahccaabaaaafaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaaeaaaaaadcaaaaak
bcaabaaaadaaaaaabkaabaaaafaaaaaabkaabaaaafaaaaaadkaabaiaebaaaaaa
acaaaaaaelaaaaafbcaabaaaafaaaaaadkaabaaaacaaaaaaaaaaaaakicaabaaa
acaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaaahaaaaaa
dcaaaaalbcaabaaaagaaaaaadkaabaaaacaaaaaabkiacaaaaaaaaaaaakaaaaaa
bkiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaaagaaaaaa
akaabaaaagaaaaaaakaabaaaadaaaaaaelaaaaaficaabaaaacaaaaaadkaabaaa
acaaaaaaaaaaaaajicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaabkaabaia
ebaaaaaaafaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaaaaaaaaaahccaabaaaagaaaaaadkaabaaaacaaaaaabkaabaaaafaaaaaa
dbaaaaahbcaabaaaadaaaaaaabeaaaaaaaaaaaaadkaabaaaacaaaaaadcaaaaaj
hcaabaaaahaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
baaaaaaibcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaa
dhaaaaajocaabaaaacaaaaaaagaabaaaadaaaaaaagajbaaaahaaaaaaagajbaaa
aeaaaaaabaaaaaahbcaabaaaaeaaaaaajgahbaaaadaaaaaaegacbaaaaeaaaaaa
baaaaaahccaabaaaadaaaaaajgahbaaaadaaaaaajgahbaaaadaaaaaadhaaaaaj
fcaabaaaadaaaaaaagaabaaaadaaaaaaagabbaaaagaaaaaaagabbaaaafaaaaaa
baaaaaaiccaabaaaacaaaaaajgahbaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaa
aoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadeaaaaah
ccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaahbdneklodiaaaaahccaabaaa
acaaaaaabkaabaaaacaaaaaaabeaaaaabodakleadiaaaaahecaabaaaacaaaaaa
akaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaakecaabaaaacaaaaaackaabaaa
adaaaaaackaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaadcaaaaalecaabaaa
acaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaackaabaaa
acaaaaaadbaaaaahicaabaaaacaaaaaaabeaaaaaaaaaaaaackaabaaaacaaaaaa
dbaaaaahicaabaaaadaaaaaackaabaaaadaaaaaaabeaaaaaaaaaaaaaabaaaaah
icaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaadiaaaaajicaabaaa
adaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaak
ccaabaaaaeaaaaaaakaabaaaagaaaaaaakaabaaaagaaaaaadkaabaiaebaaaaaa
adaaaaaabnaaaaahecaabaaaaeaaaaaaakaabaaaagaaaaaaakaabaaaadaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaadkaabaia
ebaaaaaaadaaaaaaelaaaaafbcaabaaaadaaaaaaakaabaaaadaaaaaaelaaaaaf
ecaabaaaabaaaaaabkaabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaackaabaaa
abaaaaaackaabaaaabaaaaaaaoaaaaalhcaabaaaafaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaabgigcaaaaaaaaaaaaiaaaaaaaaaaaaaiicaabaaa
aaaaaaaaakaabaiaebaaaaaaafaaaaaaabeaaaaaaaaaaadpaaaaaaahicaabaaa
abaaaaaaakaabaaaafaaaaaaabeaaaaaaaaaaadpdhaaaaajpcaabaaaaaaaaaaa
pgapbaaaacaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaaaoaaaaahbcaabaaa
abaaaaaaakaabaaaadaaaaaackaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaackaabaaaacaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaaaaaaaaaabkaabaaa
aaaaaaaaaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaa
aoaaaaalocaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
agijcaaaaaaaaaaaaiaaaaaaaaaaaaalocaabaaaabaaaaaafgaobaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaadpaaaaiadpdcaaaaajbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaaafaaaaaa
dcaaaaakecaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaialpdiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaaebaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaai
fcaabaaaaaaaaaaaagacbaaaaaaaaaaaagiacaaaaaaaaaaaaiaaaaaaaaaaaaah
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
abeaaaaaaaaaaadpaaaaaaaibcaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaa
abeaaaaaaaaaialpdiaaaaahccaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaaebaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaaaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaaiccaabaaa
agaaaaaackaabaaaaaaaaaaadkiacaaaaaaaaaaaaiaaaaaaaoaaaaaibcaabaaa
agaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaa
abaaaaaaigaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaeiaaaaalpcaabaaaafaaaaaajgafbaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaiecaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaaabaaaaaaegaobaaaafaaaaaa
kgakbaaaaaaaaaaaegaobaaaabaaaaaaebaaaaafccaabaaaacaaaaaabkaabaaa
aaaaaaaabkaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaaiccaabaaa
acaaaaaabkaabaaaacaaaaaaakiacaaaaaaaaaaaaiaaaaaaaaaaaaahicaabaaa
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
aoaaaaajocaabaaaacaaaaaaagiacaaaaaaaaaaaaeaaaaaaagijcaaaaaaaaaaa
aeaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaajgahbaaaacaaaaaa
apaaaaaiicaabaaaaaaaaaaaagaabaaaacaaaaaapgipcaaaaaaaaaaaagaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaiadpdcaaaaaodcaabaaaacaaaaaapgipcaaaaaaaaaaaagaaaaaapgipcaaa
aaaaaaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaai
icaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaaacaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaamalpbjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaambcaabaaaacaaaaaadkiacaiaebaaaaaaaaaaaaaaagaaaaaadkiacaaa
aaaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaalmcaabaaaacaaaaaaagiacaaa
aaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiaebaaaaiaeaaoaaaaak
mcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaeaeaaaaamadpkgaobaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaacaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaoaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaacaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
kgakbaaaacaaaaaaegacbaaaabaaaaaaabaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaakgakbaaaaeaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaakaaaaaabaaaaaajicaabaaaaaaaaaaaegiccaaaaaaaaaaa
beaaaaaaegiccaaaaaaaaaaabeaaaaaabaaaaaajbcaabaaaabaaaaaaegiccaaa
abaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaajbcaabaaaabaaaaaaegiccaaa
aaaaaaaabeaaaaaaegiccaaaabaaaaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaaeadkaabaaaaaaaaaaadcaaaaam
icaabaaaaaaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaabkiacaaaaaaaaaaa
ahaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaadaaaaaa
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
dkaabaaaaaaaaaaadkiacaaaaaaaaaaabeaaaaaaakiacaaaaaaaaaaaahaaaaaa
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
akaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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
// Stats: 683 math, 8 textures, 15 branches
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
def c27, 2.00000000, 4.00000000, -1.00000000, 0.00000100
def c28, 0.00000000, 1.00000000, 16.00000000, -0.19750001
def c29, 5.34960032, -0.01348047, 0.05747731, -0.12123910
def c30, 0.19563590, -0.33299461, 0.99999559, 1.57079601
def c31, 0.90909088, 0.74000001, 0.50000000, 3.00000000
def c32, -1.50000000, 0.00010000, 1.50000000, -0.21211439
def c33, -1.00000000, 0.00000000, 2.00000000, 1.57072902
def c34, -0.01872930, 0.07426100, 2.00000000, 3.00000000
def c35, 5.00000000, 0.38317001, 0.45454544, 2.71828198
def c36, -1.41299999, 0, 0, 0
dcl_texcoord0 v0.xyz
add r0.xyz, v0, -c8
dp3 r0.w, r0, r0
mov r1.xyz, c8
add r5.xyz, -c23, r1
rcp r6.w, c16.x
rsq r0.w, r0.w
mul r4.xyz, r0.w, r0
dp3 r1.x, r5, r5
rsq r1.y, r1.x
rcp r1.w, r1.y
mov r1.x, c14
add r1.x, -c13, r1
mul r1.x, r1, c20
add r3.w, r1.x, c13.x
mul r6.y, c13.x, c13.x
mad r2.w, r6, c31.z, c31.z
mov r0.yz, r4
add r0.x, r4, c21
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
dp3 r0.w, r5, r0
mul r1.y, r1.w, r1.w
mad r1.y, r0.w, r0.w, -r1
mad r1.x, r3.w, r3.w, r1.y
rsq r1.y, r1.x
rcp r1.y, r1.y
cmp r1.x, r1, r1.y, c27.w
add r1.x, -r0.w, -r1
max r2.x, r1, c28
cmp r4.w, -r2.x, r1, r3
mad r1.xyz, r2.x, r0, r5
cmp r1.xyz, -r2.x, r5, r1
dp3 r5.w, r0, c25
dp3 r1.x, r1, c25
rcp r1.w, r4.w
mul r1.x, r1, r1.w
max r1.x, r1, c28.w
mul r1.x, r1, c29
abs r1.y, r1.x
max r1.z, r1.y, c28.y
rcp r1.w, r1.z
min r1.z, r1.y, c28.y
mul r1.z, r1, r1.w
mul r1.w, r1.z, r1.z
mad r2.y, r1.w, c29, c29.z
mad r2.y, r2, r1.w, c29.w
mad r2.y, r2, r1.w, c30.x
mad r2.y, r2, r1.w, c30
mad r1.w, r2.y, r1, c30.z
mul r1.z, r1.w, r1
add r1.w, -r1.z, c30
add r1.y, r1, c27.z
cmp r1.y, -r1, r1.z, r1.w
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c18.x
add r0.y, c27.z, r1
add r0.x, r5.w, c28.y
mul r0.y, r0.x, r0
mad r0.x, r1, c31, c31.y
mul r1.x, r0.y, c31.z
frc r7.w, r1.x
rcp r0.y, c17.x
add r0.z, -r0.y, c28.y
mad r0.x, r0, r0.z, r0.y
mad r0.z, r3.w, r3.w, -r6.y
add r1.x, r1, -r7.w
mad r1.w, r0.x, c31.z, r1.x
add r0.x, r2, r0.w
cmp r1.z, -r2.x, r0.w, r0.x
rsq r6.z, r0.z
rcp r0.w, r6.z
add r0.y, r1.w, c28
rcp r6.x, c18.x
mul r1.x, r6, r0.y
mul r0.y, r4.w, r4.w
mad r0.y, r1.z, r1.z, -r0
mad r1.y, c13.x, c13.x, r0
mul r6.x, r1.w, r6
cmp r0.x, r1.z, c28, c28.y
cmp r0.y, -r1, c28.x, c28
mul_pp r7.x, r0, r0.y
mul r2.y, r0.w, r0.w
mov r2.z, r0.w
mov r2.x, c27.z
mad r0.w, -r6, c31.z, c31.z
mov r0.xyz, c28.yxxw
cmp r0, -r7.x, r2, r0
add r0.y, r0, r1
rsq r2.x, r0.y
mad r1.y, r4.w, r4.w, -r6
rsq r0.y, r1.y
rcp r1.y, c15.x
rcp r0.y, r0.y
mul r2.y, r6.z, r0
add r2.z, -r1.y, c28.y
mul r2.y, r2, r2.z
rcp r2.x, r2.x
add r0.y, r0.z, r0
mad r1.z, r1, r0.x, r2.x
mad r2.y, r1, c31.z, r2
mul r0.x, r2.y, c15
add r0.z, r0.x, c27
rcp r0.y, r0.y
frc r2.x, r0.z
mul r0.y, r1.z, r0
add r1.z, r0, -r2.x
add r0.z, -r6.w, c31
mul r1.z, r1, r1.y
mad r2.x, r0.y, r0.z, r0.w
mad r7.y, r2.x, r1, r1.z
frc r6.w, r0.x
add r1.z, r0.x, -r6.w
mul r2.y, r1, r1.z
mad r1.y, r2.x, r1, r2
mov r1.z, c28.x
texldl r2, r1.xyzz, s0
mov r6.y, r1
mov r7.x, r1
mov r6.z, c28.x
texldl r1, r6.xyzz, s0
mov r7.z, c28.x
texldl r0, r7.xyzz, s0
add r6.y, -r7.w, c28
mul r2, r7.w, r2
mad r1, r6.y, r1, r2
mul r2, r7.w, r0
mov r0.x, r6
mov r0.z, c28.x
mov r0.y, r7
texldl r0, r0.xyzz, s0
mad r0, r0, r6.y, r2
add r2.x, -r6.w, c28.y
mul r1, r6.w, r1
mad r1, r0, r2.x, r1
mul r0.xyz, r1, r1.w
max r1.w, r1.x, c32.y
rcp r2.x, r1.w
mul r0.w, r5, c11.x
mul r0.w, r0, c27.x
mad r0.w, c11.x, c11.x, -r0
add r1.w, r0, c28.y
mul r2.xyz, r0, r2.x
pow r0, r1.w, c32.x
mov r0.w, r0.x
mul r0.y, -c11.x, c11.x
add r0.z, r0.y, c28.y
mov r0.x, c9
mul r0.x, c27.y, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.z
add r0.y, -r0, c27.x
mul r0.x, r0, r0.w
mad r1.w, r5, r5, c28.y
mul r0.z, r1.w, r0.x
mov r0.x, c9
mul r0.x, c28.z, r0
rcp r0.w, r0.x
mul r0.w, r0, r1
mul r1.xyz, r0.w, r1
rcp r0.y, r0.y
dp3 r1.w, c8, c8
dp3 r0.w, c23, c23
add r0.w, r0, r1
rcp r6.x, c10.x
rcp r6.z, c10.z
rcp r6.y, c10.y
mul r6.xyz, r6, c10.x
mul r2.xyz, r2, r6
mul r0.y, r0.z, r0
mul r0.xyz, r0.y, r2
mul r0.xyz, r0, c32.z
mad r1.xyz, r1, c31.w, r0
mov r0.xyz, c23
dp3 r0.x, c8, r0
mad r0.w, -r0.x, c27.x, r0
mad r0.x, -r3.w, r3.w, r0.w
dp3 r2.x, r4, r4
mul r0.z, r2.x, r0.x
dp3 r0.x, r4, r5
mad r0.w, -c13.x, c13.x, r0
mul r0.w, r2.x, r0
mul r1.w, r0.x, c27.x
mul r0.z, r0, c27.y
mul r0.w, r0, c27.y
mad r2.y, r1.w, r1.w, -r0.z
add_pp r0.y, r4.w, -r3.w
cmp r0.xyz, -r0.y, r1, c28.x
rsq r1.x, r2.y
rcp r1.y, r1.x
mul r1.x, r2, c27
add r1.z, -r1.w, -r1.y
rcp r1.x, r1.x
add r1.y, -r1.w, r1
mul r1.z, r1.x, r1
mul r1.y, r1.x, r1
cmp r2.z, r1, r1, r1.y
mad r0.w, r1, r1, -r0
rsq r1.y, r0.w
rcp r1.y, r1.y
add r1.y, -r1.w, -r1
mul r1.w, r1.y, r1.x
cmp r0.w, r0, r1, c27.z
cmp r0.w, -r0, c28.x, c28.y
cmp_pp r1.z, r2.y, c28.y, c28.x
cmp r2.x, r2.y, r3, c27.z
cmp r2.x, -r1.z, r2, r2.z
add r1.z, r2.x, c28.y
abs r2.y, r1.z
mad r1.xyz, r4, r2.x, c8
mul r0.xyz, r0, c19.x
cmp r3.xyz, -r2.y, r3, r1
mov r1.x, c12
abs_pp r0.w, r0
cmp r0.w, -r0, c24.x, r1.x
mov r1.w, c28.y
if_ne r2.x, c27.z
mov_pp r1.x, c0.w
cmp_pp r2.w, -r1.x, c33.x, c33.y
if_eq r2.w, c28.x
add r1.xyz, -r3, c0
add r2.xyz, -r3, c26
dp3 r1.w, r1, r1
rsq r1.w, r1.w
dp3 r3.w, r2, r2
rsq r3.w, r3.w
mul r1.xyz, r1.w, r1
mul r2.xyz, r3.w, r2
mul r4.xyz, r2.zxyw, r1.yzxw
mad r4.xyz, r2.yzxw, r1.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r2, r1
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r4.w, r4.y, r4.z, c32
add r4.z, -r4.y, c28.y
mad r4.w, r4.y, r4, c33
rsq r4.y, r4.z
mul r4.z, r1.w, c0.w
rcp r1.w, r4.y
mad r4.y, -r1.w, r4.w, c30.w
min r4.z, r4, c28.y
abs r4.w, r4.z
cmp r1.w, r4.x, c33.y, c33.z
mad r5.x, r4.w, c34, c34.y
add r4.x, -r4.w, c28.y
mad r5.x, r4.w, r5, c32.w
rsq r4.x, r4.x
mul_sat r1.z, r1.y, c35.x
rcp r4.x, r4.x
mad r4.w, r4, r5.x, c33
mad r4.w, -r4.x, r4, c30
cmp r4.x, r4.z, c33.y, c33.z
mad r1.w, -r1, r4.y, r4.y
mad r4.x, -r4, r4.w, r4.w
add r4.x, r1.w, -r4
rcp r1.w, r3.w
rcp r3.w, c26.w
mul r1.w, r1, r4.x
mad r1.w, -r1, r3, c28.y
mul_sat r1.w, r1, c31.z
mul r1.x, r1.w, r1.w
mad r1.y, -r1.w, c34.z, c34.w
mad r1.w, -r1.z, c34.z, c34
mul r1.z, r1, r1
mul r1.z, r1, r1.w
mul r1.x, r1, r1.y
mad r1.w, -r1.x, r1.z, c28.y
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r2.w, -c1, r1.x, r2
if_eq r2.w, c28.x
add r2.xyz, -r3, c1
add r1.xyz, -r3, c26
dp3 r4.x, r1, r1
rsq r4.w, r4.x
dp3 r3.w, r2, r2
rsq r3.w, r3.w
mul r1.xyz, r4.w, r1
mul r2.xyz, r3.w, r2
mul r4.xyz, r1.zxyw, r2.yzxw
mad r4.xyz, r1.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r2
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r5.x, r4.y, r4.z, c32.w
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r5.x, r4.y, r5, c33.w
rsq r4.y, r4.z
mul r4.z, r3.w, c1.w
rcp r3.w, r4.y
mad r4.y, -r3.w, r5.x, c30.w
min r4.z, r4, c28.y
abs r5.x, r4.z
cmp r3.w, r4.x, c33.y, c33.z
mad r3.w, -r3, r4.y, r4.y
mad r5.y, r5.x, c34.x, c34
add r4.x, -r5, c28.y
mad r5.y, r5.x, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r5.x, r5, r5.y, c33.w
mad r5.x, -r4, r5, c30.w
cmp r4.x, r4.z, c33.y, c33.z
mad r4.x, -r4, r5, r5
add r4.x, r3.w, -r4
rcp r3.w, r4.w
rcp r4.y, c26.w
mul r3.w, r3, r4.x
mad r3.w, -r3, r4.y, c28.y
mul_sat r3.w, r3, c31.z
mul r1.x, r3.w, r3.w
mad r1.y, -r3.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r2.w, -c2, r1.x, r2
if_eq r2.w, c28.x
add r2.xyz, -r3, c2
add r1.xyz, -r3, c26
dp3 r4.x, r1, r1
rsq r4.w, r4.x
dp3 r3.w, r2, r2
rsq r3.w, r3.w
mul r1.xyz, r4.w, r1
mul r2.xyz, r3.w, r2
mul r4.xyz, r1.zxyw, r2.yzxw
mad r4.xyz, r1.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r2
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r5.x, r4.y, r4.z, c32.w
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r5.x, r4.y, r5, c33.w
rsq r4.y, r4.z
mul r4.z, r3.w, c2.w
rcp r3.w, r4.y
mad r4.y, -r3.w, r5.x, c30.w
min r4.z, r4, c28.y
abs r5.x, r4.z
cmp r3.w, r4.x, c33.y, c33.z
mad r3.w, -r3, r4.y, r4.y
mad r5.y, r5.x, c34.x, c34
add r4.x, -r5, c28.y
mad r5.y, r5.x, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r5.x, r5, r5.y, c33.w
mad r5.x, -r4, r5, c30.w
cmp r4.x, r4.z, c33.y, c33.z
mad r4.x, -r4, r5, r5
add r4.x, r3.w, -r4
rcp r3.w, r4.w
rcp r4.y, c26.w
mul r3.w, r3, r4.x
mad r3.w, -r3, r4.y, c28.y
mul_sat r3.w, r3, c31.z
mul r1.x, r3.w, r3.w
mad r1.y, -r3.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r1.x, -c3.w, r1, r2.w
if_eq r1.x, c28.x
add r2.xyz, -r3, c3
add r1.xyz, -r3, c26
dp3 r2.w, r2, r2
rsq r2.w, r2.w
dp3 r3.w, r1, r1
rsq r3.w, r3.w
mul r1.xyz, r3.w, r1
mul r2.xyz, r2.w, r2
mul r4.xyz, r1.zxyw, r2.yzxw
mad r4.xyz, r1.yzxw, r2.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r1, r2
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r4.w, r4.y, r4.z, c32
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r4.w, r4.y, r4, c33
rsq r4.y, r4.z
mul r4.z, r2.w, c3.w
rcp r2.w, r4.y
mad r4.y, -r2.w, r4.w, c30.w
min r4.z, r4, c28.y
abs r4.w, r4.z
cmp r2.w, r4.x, c33.y, c33.z
mad r5.x, r4.w, c34, c34.y
add r4.x, -r4.w, c28.y
mad r5.x, r4.w, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r4.w, r4, r5.x, c33
mad r4.w, -r4.x, r4, c30
cmp r4.x, r4.z, c33.y, c33.z
mad r2.w, -r2, r4.y, r4.y
mad r4.x, -r4, r4.w, r4.w
add r4.x, r2.w, -r4
rcp r2.w, r3.w
rcp r3.w, c26.w
mul r2.w, r2, r4.x
mad r2.w, -r2, r3, c28.y
mul_sat r2.w, r2, c31.z
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
endif
endif
endif
mov_pp r1.x, c4.w
cmp_pp r2.w, -r1.x, c33.x, c33.y
if_eq r2.w, c28.x
add r1.xyz, -r3, c4
add r2.xyz, -r3, c26
dp3 r4.x, r2, r2
rsq r4.w, r4.x
dp3 r3.w, r1, r1
rsq r3.w, r3.w
mul r1.xyz, r3.w, r1
mul r2.xyz, r4.w, r2
mul r4.xyz, r2.zxyw, r1.yzxw
mad r4.xyz, r2.yzxw, r1.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r2, r1
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r5.x, r4.y, r4.z, c32.w
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r5.x, r4.y, r5, c33.w
rsq r4.y, r4.z
mul r4.z, r3.w, c4.w
rcp r3.w, r4.y
mad r4.y, -r3.w, r5.x, c30.w
min r4.z, r4, c28.y
abs r5.x, r4.z
cmp r3.w, r4.x, c33.y, c33.z
mad r3.w, -r3, r4.y, r4.y
mad r5.y, r5.x, c34.x, c34
add r4.x, -r5, c28.y
mad r5.y, r5.x, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r5.x, r5, r5.y, c33.w
mad r5.x, -r4, r5, c30.w
cmp r4.x, r4.z, c33.y, c33.z
mad r4.x, -r4, r5, r5
add r4.x, r3.w, -r4
rcp r3.w, r4.w
rcp r4.y, c26.w
mul r3.w, r3, r4.x
mad r3.w, -r3, r4.y, c28.y
mul_sat r3.w, r3, c31.z
mul r1.x, r3.w, r3.w
mad r1.y, -r3.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r2.w, -c5, r1.x, r2
if_eq r2.w, c28.x
add r1.xyz, -r3, c5
add r2.xyz, -r3, c26
dp3 r4.x, r2, r2
rsq r4.w, r4.x
dp3 r3.w, r1, r1
rsq r3.w, r3.w
mul r1.xyz, r3.w, r1
mul r2.xyz, r4.w, r2
mul r4.xyz, r2.zxyw, r1.yzxw
mad r4.xyz, r2.yzxw, r1.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r2, r1
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r5.x, r4.y, r4.z, c32.w
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r5.x, r4.y, r5, c33.w
rsq r4.y, r4.z
mul r4.z, r3.w, c5.w
rcp r3.w, r4.y
mad r4.y, -r3.w, r5.x, c30.w
min r4.z, r4, c28.y
abs r5.x, r4.z
cmp r3.w, r4.x, c33.y, c33.z
mad r3.w, -r3, r4.y, r4.y
mad r5.y, r5.x, c34.x, c34
add r4.x, -r5, c28.y
mad r5.y, r5.x, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r5.x, r5, r5.y, c33.w
mad r5.x, -r4, r5, c30.w
cmp r4.x, r4.z, c33.y, c33.z
mad r4.x, -r4, r5, r5
add r4.x, r3.w, -r4
rcp r3.w, r4.w
rcp r4.y, c26.w
mul r3.w, r3, r4.x
mad r3.w, -r3, r4.y, c28.y
mul_sat r3.w, r3, c31.z
mul r1.x, r3.w, r3.w
mad r1.y, -r3.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r2.w, -c6, r1.x, r2
if_eq r2.w, c28.x
add r1.xyz, -r3, c6
add r2.xyz, -r3, c26
dp3 r4.x, r2, r2
rsq r4.w, r4.x
dp3 r3.w, r1, r1
rsq r3.w, r3.w
mul r1.xyz, r3.w, r1
mul r2.xyz, r4.w, r2
mul r4.xyz, r2.zxyw, r1.yzxw
mad r4.xyz, r2.yzxw, r1.zxyw, -r4
dp3 r4.x, r4, r4
dp3 r1.y, r2, r1
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r4.x, r4.x
rcp r4.x, r4.x
min r4.x, r4, c28.y
abs r4.y, r4.x
mad r4.z, r4.y, c34.x, c34.y
mad r5.x, r4.y, r4.z, c32.w
mul r1.z, r1, r1
add r4.z, -r4.y, c28.y
mad r5.x, r4.y, r5, c33.w
rsq r4.y, r4.z
mul r4.z, r3.w, c6.w
rcp r3.w, r4.y
mad r4.y, -r3.w, r5.x, c30.w
min r4.z, r4, c28.y
abs r5.x, r4.z
cmp r3.w, r4.x, c33.y, c33.z
mad r3.w, -r3, r4.y, r4.y
mad r5.y, r5.x, c34.x, c34
add r4.x, -r5, c28.y
mad r5.y, r5.x, r5, c32.w
rsq r4.x, r4.x
rcp r4.x, r4.x
mad r5.x, r5, r5.y, c33.w
mad r5.x, -r4, r5, c30.w
cmp r4.x, r4.z, c33.y, c33.z
mad r4.x, -r4, r5, r5
add r4.x, r3.w, -r4
rcp r3.w, r4.w
rcp r4.y, c26.w
mul r3.w, r3, r4.x
mad r3.w, -r3, r4.y, c28.y
mul_sat r3.w, r3, c31.z
mul r1.x, r3.w, r3.w
mad r1.y, -r3.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
if_ge r2.w, c28.x
mov_pp r1.x, c27.z
cmp_pp r1.x, -c7.w, r1, r2.w
if_eq r1.x, c28.x
add r2.xyz, -r3, c26
add r1.xyz, -r3, c7
dp3 r3.x, r1, r1
rsq r3.w, r3.x
dp3 r2.w, r2, r2
rsq r2.w, r2.w
mul r2.xyz, r2.w, r2
mul r1.xyz, r3.w, r1
mul r3.xyz, r2.zxyw, r1.yzxw
mad r3.xyz, r2.yzxw, r1.zxyw, -r3
dp3 r3.x, r3, r3
dp3 r1.y, r2, r1
mul_sat r1.z, r1.y, c35.x
mad r2.x, -r1.z, c34.z, c34.w
rsq r3.x, r3.x
rcp r3.x, r3.x
min r3.x, r3, c28.y
abs r3.y, r3.x
mad r3.z, r3.y, c34.x, c34.y
mad r4.x, r3.y, r3.z, c32.w
mul r1.z, r1, r1
add r3.z, -r3.y, c28.y
mad r4.x, r3.y, r4, c33.w
rsq r3.y, r3.z
mul r3.z, r3.w, c7.w
min r3.z, r3, c28.y
abs r3.w, r3.z
mad r4.y, r3.w, c34.x, c34
mad r4.y, r3.w, r4, c32.w
rcp r3.y, r3.y
mad r3.y, -r3, r4.x, c30.w
add r4.x, -r3.w, c28.y
cmp r3.x, r3, c33.y, c33.z
mad r3.x, -r3, r3.y, r3.y
mad r4.y, r3.w, r4, c33.w
rsq r4.x, r4.x
rcp r3.w, r4.x
mad r3.w, -r3, r4.y, c30
cmp r3.z, r3, c33.y, c33
mad r3.z, -r3, r3.w, r3.w
add r3.x, r3, -r3.z
rcp r2.w, r2.w
rcp r3.y, c26.w
mul r2.w, r2, r3.x
mad r2.w, -r2, r3.y, c28.y
mul_sat r2.w, r2, c31.z
mul r1.x, r2.w, r2.w
mad r1.y, -r2.w, c34.z, c34.w
mul r1.z, r1, r2.x
mul r1.x, r1, r1.y
mad r1.x, -r1, r1.z, c28.y
mul r1.w, r1, r1.x
endif
endif
endif
endif
endif
mul r0.xyz, r0, r1.w
mul r2.xyz, r0, r0.w
mul r3.x, r2.z, c35.y
pow r0, r3.x, c35.z
pow r1, c35.w, -r2.z
add r2.w, r2.z, c36.x
mov r0.y, r1.x
mov r0.z, r0.x
mul r3.x, r2, c35.y
pow r1, r3.x, c35.z
add r0.x, -r0.y, c28.y
cmp r2.z, r2.w, r0.x, r0
pow r0, c35.w, -r2.x
add r2.w, r2.x, c36.x
mov r0.y, r1.x
add r0.x, -r0, c28.y
cmp r2.x, r2.w, r0, r0.y
pow r0, c35.w, -r2.y
mul r3.x, r2.y, c35.y
pow r1, r3.x, c35.z
add r2.w, r2.y, c36.x
mov r0.y, r1.x
add r0.x, -r0, c28.y
cmp r2.y, r2.w, r0.x, r0
mul oC0.xyz, r2, c22.x
mov oC0.w, c28.y
"
}
SubProgram "d3d11 " {
// Stats: 274 math, 8 branches
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
eefiecedcaikhmnpabedjpkdinkemdeajghailbdabaaaaaapmcfaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdmcfaaaa
eaaaaaaaepajaaaadfbiaaaabcaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpfjaaaaaeegiocaaaaaaaaaaabpaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaiaaaaaaaaaaaaajhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaiaebaaaaaaabaaaaaaaeaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahocaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaaaaaaaaakhcaabaaa
acaaaaaaegiccaiaebaaaaaaaaaaaaaabeaaaaaaegiccaaaabaaaaaaaeaaaaaa
baaaaaahecaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaah
icaabaaaacaaaaaackaabaaaaaaaaaaackaabaaaaaaaaaaabaaaaaajbcaabaaa
adaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaaaaaaaaabeaaaaaabaaaaaaj
ccaabaaaadaaaaaaegiccaaaabaaaaaaaeaaaaaaegiccaaaabaaaaaaaeaaaaaa
aaaaaaahbcaabaaaadaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaabaaaaaaj
ccaabaaaadaaaaaaegiccaaaaaaaaaaabeaaaaaaegiccaaaabaaaaaaaeaaaaaa
dcaaaaakbcaabaaaadaaaaaabkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaaaea
akaabaaaadaaaaaadiaaaaajccaabaaaadaaaaaabkiacaaaaaaaaaaaahaaaaaa
bkiacaaaaaaaaaaaahaaaaaadcaaaaamecaabaaaadaaaaaabkiacaiaebaaaaaa
aaaaaaaaahaaaaaabkiacaaaaaaaaaaaahaaaaaaakaabaaaadaaaaaadiaaaaah
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
aaaaaaaabeaaaaaaakiacaaaaaaaaaaaahaaaaaaaaaaaaakbcaabaaaaeaaaaaa
bkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaaahaaaaaadcaaaaal
bcaabaaaaeaaaaaaakaabaaaaeaaaaaabkiacaaaaaaaaaaaakaaaaaabkiacaaa
aaaaaaaaahaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaaaaaaaaadkaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaabaaaaaahbcaabaaaaaaaaaaaigadbaaa
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
egiccaaaaaaaaaaabfaaaaaabaaaaaaibcaabaaaacaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaabfaaaaaaaoaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaadcaaaaakccaabaaaacaaaaaaakaabaaaaeaaaaaaakaabaaa
aeaaaaaabkaabaiaebaaaaaaadaaaaaaelaaaaafecaabaaaafaaaaaabkaabaaa
acaaaaaadiaaaaahccaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakecaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaadaaaaaaelaaaaafecaabaaaacaaaaaackaabaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaiaebaaaaaa
acaaaaaadcaaaaalccaabaaaacaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaacaaaaaadbaaaaahccaabaaaadaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadbaaaaahccaabaaaaeaaaaaaabeaaaaaaaaaaaaa
bkaabaaaacaaaaaaabaaaaahccaabaaaadaaaaaabkaabaaaadaaaaaabkaabaaa
aeaaaaaaaoaaaaalocaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadp
aaaaaadpfgiicaaaaaaaaaaaaiaaaaaaaaaaaaaiicaabaaaagaaaaaabkaabaia
ebaaaaaaaeaaaaaaabeaaaaaaaaaaadpdiaaaaahccaabaaaafaaaaaackaabaaa
afaaaaaackaabaaaafaaaaaaaaaaaaahicaabaaaafaaaaaabkaabaaaaeaaaaaa
abeaaaaaaaaaaadpdgaaaaaihcaabaaaagaaaaaaaceaaaaaaaaaiadpaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaafbcaabaaaafaaaaaaabeaaaaaaaaaialpdhaaaaaj
pcaabaaaagaaaaaafgafbaaaadaaaaaaegaobaaaagaaaaaaegaobaaaafaaaaaa
aoaaaaahccaabaaaadaaaaaackaabaaaacaaaaaackaabaaaafaaaaaaaoaaaaal
hcaabaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegiccaaa
aaaaaaaaaiaaaaaaaaaaaaalhcaabaaaafaaaaaaegacbaiaebaaaaaaafaaaaaa
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
aaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaaaeaaaaaackaabaaa
acaaaaaabkaabaaaacaaaaaaebaaaaafccaabaaaaeaaaaaabkaabaaaaeaaaaaa
dcaaaaakccaabaaaacaaaaaabkaabaaaacaaaaaackaabaaaacaaaaaabkaabaia
ebaaaaaaaeaaaaaadiaaaaaiecaabaaaacaaaaaabkaabaaaadaaaaaaakiacaaa
aaaaaaaaaiaaaaaadcaaaaakccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaa
aaaaaaaaaiaaaaaaabeaaaaaaaaaialpebaaaaafccaabaaaadaaaaaabkaabaaa
adaaaaaaaoaaaaaiccaabaaaadaaaaaabkaabaaaadaaaaaaakiacaaaaaaaaaaa
aiaaaaaaebaaaaafecaabaaaaeaaaaaackaabaaaacaaaaaaaoaaaaaiecaabaaa
aeaaaaaackaabaaaaeaaaaaaakiacaaaaaaaaaaaaiaaaaaabkaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaaaaaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaa
bkaabaaaaeaaaaaaaoaaaaaiccaabaaaafaaaaaaakaabaaaacaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaahecaabaaaafaaaaaabkaabaaaadaaaaaadkaabaaa
aaaaaaaaeiaaaaalpcaabaaaagaaaaaajgafbaaaafaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaaiccaabaaaadaaaaaabkaabaia
ebaaaaaaacaaaaaaabeaaaaaaaaaiadpaaaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpaoaaaaaibcaabaaaafaaaaaaakaabaaaacaaaaaa
dkiacaaaaaaaaaaaaiaaaaaaeiaaaaalpcaabaaaahaaaaaaigaabaaaafaaaaaa
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
ocaabaaaaeaaaaaaagiacaaaaaaaaaaaaeaaaaaaagijcaaaaaaaaaaaaeaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaajgahbaaaaeaaaaaadiaaaaal
gcaabaaaaeaaaaaaagiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaiaeb
aaaaiaeaaaaaaaaaaoaaaaakgcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaeaea
aaaamadpaaaaaaaafgagbaaaaeaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahccaabaaaadaaaaaa
dkaabaaaaaaaaaaabkaabaaaaeaaaaaadcaaaaamccaabaaaaeaaaaaadkiacaia
ebaaaaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadp
diaaaaahccaabaaaaeaaaaaabkaabaaaaeaaaaaackaabaaaaeaaaaaadcaaaaao
mcaabaaaaeaaaaaapgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaeaapaaaaaibcaabaaaabaaaaaa
agaabaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaaeaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaamalpbjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaaeaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaafaaaaaafgafbaaa
adaaaaaaegacbaaaacaaaaaaabaaaaahhcaabaaaacaaaaaaagaabaaaaaaaaaaa
egacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaagiacaaa
aaaaaaaaakaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaiaebaaaaaaaeaaaaaa
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
egiccaaaaaaaaaaabgaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaaabeaaaaaaeaaaaaa
adaaaeadakaabaaaadaaaaaabbaaaaajbcaabaaaadaaaaaaegiocaaaaaaaaaaa
bkaaaaaaegjojaaadkaabaaaacaaaaaabnaaaaahccaabaaaadaaaaaaabeaaaaa
aaaaaaaaakaabaaaadaaaaaabpaaaeadbkaabaaaadaaaaaaacaaaaabbfaaaaab
bbaaaaajbcaabaaaaeaaaaaaegiocaaaaaaaaaaabhaaaaaaegjojaaadkaabaaa
acaaaaaabbaaaaajccaabaaaaeaaaaaaegiocaaaaaaaaaaabiaaaaaaegjojaaa
dkaabaaaacaaaaaabbaaaaajecaabaaaaeaaaaaaegiocaaaaaaaaaaabjaaaaaa
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
ebaaaaaaadaaaaaadkiacaaaaaaaaaaabgaaaaaaaaaaaaahbcaabaaaadaaaaaa
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
egiocaaaaaaaaaaaboaaaaaaegjojaaaakaabaaaadaaaaaabnaaaaahicaabaaa
adaaaaaaabeaaaaaaaaaaaaabkaabaaaadaaaaaabpaaaeaddkaabaaaadaaaaaa
acaaaaabbfaaaaabbbaaaaajbcaabaaaaeaaaaaaegiocaaaaaaaaaaablaaaaaa
egjojaaaakaabaaaadaaaaaabbaaaaajccaabaaaaeaaaaaaegiocaaaaaaaaaaa
bmaaaaaaegjojaaaakaabaaaadaaaaaabbaaaaajecaabaaaaeaaaaaaegiocaaa
aaaaaaaabnaaaaaaegjojaaaakaabaaaadaaaaaaaaaaaaaihcaabaaaaeaaaaaa
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
adaaaaaabkaabaiaebaaaaaaadaaaaaadkiacaaaaaaaaaaabgaaaaaaaaaaaaah
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
akaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
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