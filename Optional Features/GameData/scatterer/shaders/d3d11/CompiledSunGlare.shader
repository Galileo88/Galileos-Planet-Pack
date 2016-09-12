// Compiled shader for all platforms, uncompressed size: 74.4KB

Shader "Scatterer/sunFlare" {
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //        d3d9 : 3 math
 // Stats for Fragment shader:
 //       d3d11 : 151 math, 28 texture, 2 branch
 //        d3d9 : 274 math, 28 texture, 1 branch
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest False
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcColor
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = gl_Vertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform vec3 _Globals_WorldCameraPos;
uniform float sunGlareScale;
uniform float sunGlareFade;
uniform sampler2D sunSpikes;
uniform sampler2D sunFlare;
uniform sampler2D sunGhost1;
uniform sampler2D sunGhost2;
uniform sampler2D sunGhost3;
uniform sampler2D _customDepthTexture;
uniform vec3 flareSettings;
uniform vec3 spikesSettings;
uniform mat4 ghost1Settings1;
uniform mat4 ghost1Settings2;
uniform mat4 ghost2Settings1;
uniform mat4 ghost2Settings2;
uniform mat4 ghost3Settings1;
uniform mat4 ghost3Settings2;
uniform float Rg;
uniform float Rt;
uniform sampler2D _Sky_Transmittance;
uniform float useTransmittance;
uniform vec3 _Sun_WorldSunDir;
uniform vec3 sunViewPortPos;
uniform float aspectRatio;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec4 tmpvar_1;
  vec3 ghosts_2;
  vec3 sunColor_3;
  vec2 tmpvar_4;
  tmpvar_4.y = 1.0;
  tmpvar_4.x = (aspectRatio * flareSettings.y);
  vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = (aspectRatio * spikesSettings.y);
  vec2 tmpvar_6;
  tmpvar_6 = (sunViewPortPos.xy - 0.5);
  vec2 tmpvar_7;
  tmpvar_7.y = 1.0;
  tmpvar_7.x = (aspectRatio * ghost1Settings1[1].x);
  vec2 tmpvar_8;
  tmpvar_8.y = 1.0;
  tmpvar_8.x = (aspectRatio * ghost1Settings2[1].x);
  ghosts_2 = ((ghost1Settings1[0].x * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings1[3].x)) * tmpvar_7) * ghost1Settings1[2].x) + 0.5)).xyz) + (ghost1Settings2[0].x * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings2[3].x)) * tmpvar_8) * ghost1Settings2[2].x) + 0.5)).xyz));
  vec2 tmpvar_9;
  tmpvar_9.y = 1.0;
  tmpvar_9.x = (aspectRatio * ghost1Settings1[1].y);
  vec2 tmpvar_10;
  tmpvar_10.y = 1.0;
  tmpvar_10.x = (aspectRatio * ghost1Settings2[1].y);
  ghosts_2 = ((ghosts_2 + (ghost1Settings1[0].y * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings1[3].y)) * tmpvar_9) * ghost1Settings1[2].y) + 0.5)).xyz)) + (ghost1Settings2[0].y * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings2[3].y)) * tmpvar_10) * ghost1Settings2[2].y) + 0.5)).xyz));
  vec2 tmpvar_11;
  tmpvar_11.y = 1.0;
  tmpvar_11.x = (aspectRatio * ghost1Settings1[1].z);
  vec2 tmpvar_12;
  tmpvar_12.y = 1.0;
  tmpvar_12.x = (aspectRatio * ghost1Settings2[1].z);
  ghosts_2 = ((ghosts_2 + (ghost1Settings1[0].z * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings1[3].z)) * tmpvar_11) * ghost1Settings1[2].z) + 0.5)).xyz)) + (ghost1Settings2[0].z * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings2[3].z)) * tmpvar_12) * ghost1Settings2[2].z) + 0.5)).xyz));
  vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  tmpvar_13.x = (aspectRatio * ghost1Settings1[1].w);
  vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = (aspectRatio * ghost1Settings2[1].w);
  ghosts_2 = ((ghosts_2 + (ghost1Settings1[0].w * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings1[3].w)) * tmpvar_13) * ghost1Settings1[2].w) + 0.5)).xyz)) + (ghost1Settings2[0].w * texture2D (sunGhost1, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost1Settings2[3].w)) * tmpvar_14) * ghost1Settings2[2].w) + 0.5)).xyz));
  vec2 tmpvar_15;
  tmpvar_15.y = 1.0;
  tmpvar_15.x = (aspectRatio * ghost2Settings1[1].x);
  vec2 tmpvar_16;
  tmpvar_16.y = 1.0;
  tmpvar_16.x = (aspectRatio * ghost2Settings2[1].x);
  ghosts_2 = ((ghosts_2 + (ghost2Settings1[0].x * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings1[3].x)) * tmpvar_15) * ghost2Settings1[2].x) + 0.5)).xyz)) + (ghost2Settings2[0].x * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings2[3].x)) * tmpvar_16) * ghost2Settings2[2].x) + 0.5)).xyz));
  vec2 tmpvar_17;
  tmpvar_17.y = 1.0;
  tmpvar_17.x = (aspectRatio * ghost2Settings1[1].y);
  vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = (aspectRatio * ghost2Settings2[1].y);
  ghosts_2 = ((ghosts_2 + (ghost2Settings1[0].y * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings1[3].y)) * tmpvar_17) * ghost2Settings1[2].y) + 0.5)).xyz)) + (ghost2Settings2[0].y * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings2[3].y)) * tmpvar_18) * ghost2Settings2[2].y) + 0.5)).xyz));
  vec2 tmpvar_19;
  tmpvar_19.y = 1.0;
  tmpvar_19.x = (aspectRatio * ghost2Settings1[1].z);
  vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = (aspectRatio * ghost2Settings2[1].z);
  ghosts_2 = ((ghosts_2 + (ghost2Settings1[0].z * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings1[3].z)) * tmpvar_19) * ghost2Settings1[2].z) + 0.5)).xyz)) + (ghost2Settings2[0].z * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings2[3].z)) * tmpvar_20) * ghost2Settings2[2].z) + 0.5)).xyz));
  vec2 tmpvar_21;
  tmpvar_21.y = 1.0;
  tmpvar_21.x = (aspectRatio * ghost2Settings1[1].w);
  vec2 tmpvar_22;
  tmpvar_22.y = 1.0;
  tmpvar_22.x = (aspectRatio * ghost2Settings2[1].w);
  ghosts_2 = ((ghosts_2 + (ghost2Settings1[0].w * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings1[3].w)) * tmpvar_21) * ghost2Settings1[2].w) + 0.5)).xyz)) + (ghost2Settings2[0].w * texture2D (sunGhost2, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost2Settings2[3].w)) * tmpvar_22) * ghost2Settings2[2].w) + 0.5)).xyz));
  vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = (aspectRatio * ghost3Settings1[1].x);
  vec2 tmpvar_24;
  tmpvar_24.y = 1.0;
  tmpvar_24.x = (aspectRatio * ghost3Settings2[1].x);
  ghosts_2 = ((ghosts_2 + (ghost3Settings1[0].x * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings1[3].x)) * tmpvar_23) * ghost3Settings1[2].x) + 0.5)).xyz)) + (ghost3Settings2[0].x * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings2[3].x)) * tmpvar_24) * ghost3Settings2[2].x) + 0.5)).xyz));
  vec2 tmpvar_25;
  tmpvar_25.y = 1.0;
  tmpvar_25.x = (aspectRatio * ghost3Settings1[1].y);
  vec2 tmpvar_26;
  tmpvar_26.y = 1.0;
  tmpvar_26.x = (aspectRatio * ghost3Settings2[1].y);
  ghosts_2 = ((ghosts_2 + (ghost3Settings1[0].y * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings1[3].y)) * tmpvar_25) * ghost3Settings1[2].y) + 0.5)).xyz)) + (ghost3Settings2[0].y * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings2[3].y)) * tmpvar_26) * ghost3Settings2[2].y) + 0.5)).xyz));
  vec2 tmpvar_27;
  tmpvar_27.y = 1.0;
  tmpvar_27.x = (aspectRatio * ghost3Settings1[1].z);
  vec2 tmpvar_28;
  tmpvar_28.y = 1.0;
  tmpvar_28.x = (aspectRatio * ghost3Settings2[1].z);
  ghosts_2 = ((ghosts_2 + (ghost3Settings1[0].z * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings1[3].z)) * tmpvar_27) * ghost3Settings1[2].z) + 0.5)).xyz)) + (ghost3Settings2[0].z * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings2[3].z)) * tmpvar_28) * ghost3Settings2[2].z) + 0.5)).xyz));
  vec2 tmpvar_29;
  tmpvar_29.y = 1.0;
  tmpvar_29.x = (aspectRatio * ghost3Settings1[1].w);
  vec2 tmpvar_30;
  tmpvar_30.y = 1.0;
  tmpvar_30.x = (aspectRatio * ghost3Settings2[1].w);
  ghosts_2 = ((ghosts_2 + (ghost3Settings1[0].w * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings1[3].w)) * tmpvar_29) * ghost3Settings1[2].w) + 0.5)).xyz)) + (ghost3Settings2[0].w * texture2D (sunGhost3, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_6 * ghost3Settings2[3].w)) * tmpvar_30) * ghost3Settings2[2].w) + 0.5)).xyz));
  float t_31;
  t_31 = max (min ((1.0 - sqrt(dot (tmpvar_6, tmpvar_6))), 1.0), 0.0);
  vec3 tmpvar_32;
  tmpvar_32 = (ghosts_2 * (t_31 * (t_31 * (3.0 - (2.0 * t_31)))));
  ghosts_2 = tmpvar_32;
  sunColor_3 = (((flareSettings.x * texture2D (sunFlare, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_4) * flareSettings.z) * sunGlareScale) + 0.5)).xyz) + (spikesSettings.x * texture2D (sunSpikes, (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_5) * spikesSettings.z) * sunGlareScale) + 0.5)).xyz)) + tmpvar_32);
  vec4 tmpvar_33;
  tmpvar_33 = texture2D (_customDepthTexture, sunViewPortPos.xy);
  if ((tmpvar_33.x < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    float mu_34;
    float r_35;
    float tmpvar_36;
    tmpvar_36 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_35 = tmpvar_36;
    float tmpvar_37;
    tmpvar_37 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    mu_34 = (tmpvar_37 / tmpvar_36);
    float f_38;
    f_38 = (((tmpvar_37 * tmpvar_37) - (tmpvar_36 * tmpvar_36)) + (Rt * Rt));
    float tmpvar_39;
    if ((f_38 >= 0.0)) {
      tmpvar_39 = sqrt(f_38);
    } else {
      tmpvar_39 = 1e-06;
    };
    float tmpvar_40;
    tmpvar_40 = max ((-(tmpvar_37) - tmpvar_39), 0.0);
    if ((tmpvar_40 > 0.0)) {
      mu_34 = ((tmpvar_37 + tmpvar_40) / Rt);
      r_35 = Rt;
    };
    vec3 tmpvar_41;
    if ((r_35 > Rt)) {
      tmpvar_41 = vec3(1.0, 1.0, 1.0);
    } else {
      float y_over_x_42;
      y_over_x_42 = (((mu_34 + 0.15) / 1.15) * 14.1014);
      float x_43;
      x_43 = (y_over_x_42 * inversesqrt(((y_over_x_42 * y_over_x_42) + 1.0)));
      vec2 tmpvar_44;
      tmpvar_44.x = ((sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296))))))))) / 1.5);
      tmpvar_44.y = sqrt(((r_35 - Rg) / (Rt - Rg)));
      tmpvar_41 = texture2D (_Sky_Transmittance, tmpvar_44).xyz;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_3 = (sunColor_3 * tmpvar_41);
    };
    vec3 tmpvar_45;
    tmpvar_45 = (sunColor_3 * sunGlareFade);
    sunColor_3 = tmpvar_45;
    vec4 tmpvar_46;
    tmpvar_46.w = 1.0;
    tmpvar_46.xyz = tmpvar_45;
    tmpvar_1 = tmpvar_46;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 3 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
def c0, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov o0.xy, v0
mov o0.zw, c0.x
mov o1.xy, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"vs_4_0
eefiecedjnkhkmklcdfgipmgpafnhncaemfkpffgabaaaaaaiiabaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiaaaaaa
eaaaabaaccaaaaaafpaaaaaddcbabaaaaaaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaadgaaaaaf
dccabaaaaaaaaaaaegbabaaaaaaaaaaadgaaaaaimccabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaiadpaaaaiadpdgaaaaafdccabaaaabaaaaaaegbabaaa
acaaaaaadoaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _Globals_WorldCameraPos;
uniform highp float sunGlareScale;
uniform highp float sunGlareFade;
uniform sampler2D sunSpikes;
uniform sampler2D sunFlare;
uniform sampler2D sunGhost1;
uniform sampler2D sunGhost2;
uniform sampler2D sunGhost3;
uniform sampler2D _customDepthTexture;
uniform highp vec3 flareSettings;
uniform highp vec3 spikesSettings;
uniform highp mat4 ghost1Settings1;
uniform highp mat4 ghost1Settings2;
uniform highp mat4 ghost2Settings1;
uniform highp mat4 ghost2Settings2;
uniform highp mat4 ghost3Settings1;
uniform highp mat4 ghost3Settings2;
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float useTransmittance;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec3 sunViewPortPos;
uniform highp float aspectRatio;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 ghosts_3;
  highp vec3 sunColor_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = (aspectRatio * flareSettings.y);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_5) * flareSettings.z) * sunGlareScale) + 0.5);
  tmpvar_6 = texture2D (sunFlare, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 1.0;
  tmpvar_8.x = (aspectRatio * spikesSettings.y);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_8) * spikesSettings.z) * sunGlareScale) + 0.5);
  tmpvar_9 = texture2D (sunSpikes, P_10);
  highp vec2 tmpvar_11;
  tmpvar_11 = (sunViewPortPos.xy - 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.y = 1.0;
  tmpvar_12.x = (aspectRatio * ghost1Settings1[1].x);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].x)) * tmpvar_12) * ghost1Settings1[2].x) + 0.5);
  tmpvar_13 = texture2D (sunGhost1, P_14);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 1.0;
  tmpvar_15.x = (aspectRatio * ghost1Settings2[1].x);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].x)) * tmpvar_15) * ghost1Settings2[2].x) + 0.5);
  tmpvar_16 = texture2D (sunGhost1, P_17);
  ghosts_3 = ((ghost1Settings1[0].x * tmpvar_13.xyz) + (ghost1Settings2[0].x * tmpvar_16.xyz));
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = (aspectRatio * ghost1Settings1[1].y);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].y)) * tmpvar_18) * ghost1Settings1[2].y) + 0.5);
  tmpvar_19 = texture2D (sunGhost1, P_20);
  highp vec2 tmpvar_21;
  tmpvar_21.y = 1.0;
  tmpvar_21.x = (aspectRatio * ghost1Settings2[1].y);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].y)) * tmpvar_21) * ghost1Settings2[2].y) + 0.5);
  tmpvar_22 = texture2D (sunGhost1, P_23);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].y * tmpvar_19.xyz)) + (ghost1Settings2[0].y * tmpvar_22.xyz));
  highp vec2 tmpvar_24;
  tmpvar_24.y = 1.0;
  tmpvar_24.x = (aspectRatio * ghost1Settings1[1].z);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].z)) * tmpvar_24) * ghost1Settings1[2].z) + 0.5);
  tmpvar_25 = texture2D (sunGhost1, P_26);
  highp vec2 tmpvar_27;
  tmpvar_27.y = 1.0;
  tmpvar_27.x = (aspectRatio * ghost1Settings2[1].z);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].z)) * tmpvar_27) * ghost1Settings2[2].z) + 0.5);
  tmpvar_28 = texture2D (sunGhost1, P_29);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].z * tmpvar_25.xyz)) + (ghost1Settings2[0].z * tmpvar_28.xyz));
  highp vec2 tmpvar_30;
  tmpvar_30.y = 1.0;
  tmpvar_30.x = (aspectRatio * ghost1Settings1[1].w);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].w)) * tmpvar_30) * ghost1Settings1[2].w) + 0.5);
  tmpvar_31 = texture2D (sunGhost1, P_32);
  highp vec2 tmpvar_33;
  tmpvar_33.y = 1.0;
  tmpvar_33.x = (aspectRatio * ghost1Settings2[1].w);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].w)) * tmpvar_33) * ghost1Settings2[2].w) + 0.5);
  tmpvar_34 = texture2D (sunGhost1, P_35);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].w * tmpvar_31.xyz)) + (ghost1Settings2[0].w * tmpvar_34.xyz));
  highp vec2 tmpvar_36;
  tmpvar_36.y = 1.0;
  tmpvar_36.x = (aspectRatio * ghost2Settings1[1].x);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].x)) * tmpvar_36) * ghost2Settings1[2].x) + 0.5);
  tmpvar_37 = texture2D (sunGhost2, P_38);
  highp vec2 tmpvar_39;
  tmpvar_39.y = 1.0;
  tmpvar_39.x = (aspectRatio * ghost2Settings2[1].x);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].x)) * tmpvar_39) * ghost2Settings2[2].x) + 0.5);
  tmpvar_40 = texture2D (sunGhost2, P_41);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].x * tmpvar_37.xyz)) + (ghost2Settings2[0].x * tmpvar_40.xyz));
  highp vec2 tmpvar_42;
  tmpvar_42.y = 1.0;
  tmpvar_42.x = (aspectRatio * ghost2Settings1[1].y);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].y)) * tmpvar_42) * ghost2Settings1[2].y) + 0.5);
  tmpvar_43 = texture2D (sunGhost2, P_44);
  highp vec2 tmpvar_45;
  tmpvar_45.y = 1.0;
  tmpvar_45.x = (aspectRatio * ghost2Settings2[1].y);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].y)) * tmpvar_45) * ghost2Settings2[2].y) + 0.5);
  tmpvar_46 = texture2D (sunGhost2, P_47);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].y * tmpvar_43.xyz)) + (ghost2Settings2[0].y * tmpvar_46.xyz));
  highp vec2 tmpvar_48;
  tmpvar_48.y = 1.0;
  tmpvar_48.x = (aspectRatio * ghost2Settings1[1].z);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].z)) * tmpvar_48) * ghost2Settings1[2].z) + 0.5);
  tmpvar_49 = texture2D (sunGhost2, P_50);
  highp vec2 tmpvar_51;
  tmpvar_51.y = 1.0;
  tmpvar_51.x = (aspectRatio * ghost2Settings2[1].z);
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].z)) * tmpvar_51) * ghost2Settings2[2].z) + 0.5);
  tmpvar_52 = texture2D (sunGhost2, P_53);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].z * tmpvar_49.xyz)) + (ghost2Settings2[0].z * tmpvar_52.xyz));
  highp vec2 tmpvar_54;
  tmpvar_54.y = 1.0;
  tmpvar_54.x = (aspectRatio * ghost2Settings1[1].w);
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].w)) * tmpvar_54) * ghost2Settings1[2].w) + 0.5);
  tmpvar_55 = texture2D (sunGhost2, P_56);
  highp vec2 tmpvar_57;
  tmpvar_57.y = 1.0;
  tmpvar_57.x = (aspectRatio * ghost2Settings2[1].w);
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].w)) * tmpvar_57) * ghost2Settings2[2].w) + 0.5);
  tmpvar_58 = texture2D (sunGhost2, P_59);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].w * tmpvar_55.xyz)) + (ghost2Settings2[0].w * tmpvar_58.xyz));
  highp vec2 tmpvar_60;
  tmpvar_60.y = 1.0;
  tmpvar_60.x = (aspectRatio * ghost3Settings1[1].x);
  lowp vec4 tmpvar_61;
  highp vec2 P_62;
  P_62 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].x)) * tmpvar_60) * ghost3Settings1[2].x) + 0.5);
  tmpvar_61 = texture2D (sunGhost3, P_62);
  highp vec2 tmpvar_63;
  tmpvar_63.y = 1.0;
  tmpvar_63.x = (aspectRatio * ghost3Settings2[1].x);
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].x)) * tmpvar_63) * ghost3Settings2[2].x) + 0.5);
  tmpvar_64 = texture2D (sunGhost3, P_65);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].x * tmpvar_61.xyz)) + (ghost3Settings2[0].x * tmpvar_64.xyz));
  highp vec2 tmpvar_66;
  tmpvar_66.y = 1.0;
  tmpvar_66.x = (aspectRatio * ghost3Settings1[1].y);
  lowp vec4 tmpvar_67;
  highp vec2 P_68;
  P_68 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].y)) * tmpvar_66) * ghost3Settings1[2].y) + 0.5);
  tmpvar_67 = texture2D (sunGhost3, P_68);
  highp vec2 tmpvar_69;
  tmpvar_69.y = 1.0;
  tmpvar_69.x = (aspectRatio * ghost3Settings2[1].y);
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].y)) * tmpvar_69) * ghost3Settings2[2].y) + 0.5);
  tmpvar_70 = texture2D (sunGhost3, P_71);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].y * tmpvar_67.xyz)) + (ghost3Settings2[0].y * tmpvar_70.xyz));
  highp vec2 tmpvar_72;
  tmpvar_72.y = 1.0;
  tmpvar_72.x = (aspectRatio * ghost3Settings1[1].z);
  lowp vec4 tmpvar_73;
  highp vec2 P_74;
  P_74 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].z)) * tmpvar_72) * ghost3Settings1[2].z) + 0.5);
  tmpvar_73 = texture2D (sunGhost3, P_74);
  highp vec2 tmpvar_75;
  tmpvar_75.y = 1.0;
  tmpvar_75.x = (aspectRatio * ghost3Settings2[1].z);
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].z)) * tmpvar_75) * ghost3Settings2[2].z) + 0.5);
  tmpvar_76 = texture2D (sunGhost3, P_77);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].z * tmpvar_73.xyz)) + (ghost3Settings2[0].z * tmpvar_76.xyz));
  highp vec2 tmpvar_78;
  tmpvar_78.y = 1.0;
  tmpvar_78.x = (aspectRatio * ghost3Settings1[1].w);
  lowp vec4 tmpvar_79;
  highp vec2 P_80;
  P_80 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].w)) * tmpvar_78) * ghost3Settings1[2].w) + 0.5);
  tmpvar_79 = texture2D (sunGhost3, P_80);
  highp vec2 tmpvar_81;
  tmpvar_81.y = 1.0;
  tmpvar_81.x = (aspectRatio * ghost3Settings2[1].w);
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].w)) * tmpvar_81) * ghost3Settings2[2].w) + 0.5);
  tmpvar_82 = texture2D (sunGhost3, P_83);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].w * tmpvar_79.xyz)) + (ghost3Settings2[0].w * tmpvar_82.xyz));
  highp float t_84;
  t_84 = max (min ((1.0 - sqrt(dot (tmpvar_11, tmpvar_11))), 1.0), 0.0);
  highp vec3 tmpvar_85;
  tmpvar_85 = (ghosts_3 * (t_84 * (t_84 * (3.0 - (2.0 * t_84)))));
  ghosts_3 = tmpvar_85;
  sunColor_4 = (((flareSettings.x * tmpvar_6.xyz) + (spikesSettings.x * tmpvar_9.xyz)) + tmpvar_85);
  lowp float tmpvar_86;
  tmpvar_86 = texture2D (_customDepthTexture, sunViewPortPos.xy).x;
  depth_2 = tmpvar_86;
  if ((depth_2 < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp float mu_87;
    highp float r_88;
    highp float tmpvar_89;
    tmpvar_89 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_88 = tmpvar_89;
    highp float tmpvar_90;
    tmpvar_90 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    mu_87 = (tmpvar_90 / tmpvar_89);
    highp float f_91;
    f_91 = (((tmpvar_90 * tmpvar_90) - (tmpvar_89 * tmpvar_89)) + (Rt * Rt));
    highp float tmpvar_92;
    if ((f_91 >= 0.0)) {
      tmpvar_92 = sqrt(f_91);
    } else {
      tmpvar_92 = 1e-06;
    };
    highp float tmpvar_93;
    tmpvar_93 = max ((-(tmpvar_90) - tmpvar_92), 0.0);
    if ((tmpvar_93 > 0.0)) {
      mu_87 = ((tmpvar_90 + tmpvar_93) / Rt);
      r_88 = Rt;
    };
    highp vec3 tmpvar_94;
    if ((r_88 > Rt)) {
      tmpvar_94 = vec3(1.0, 1.0, 1.0);
    } else {
      highp vec3 tmpvar_95;
      highp float y_over_x_96;
      y_over_x_96 = (((mu_87 + 0.15) / 1.15) * 14.1014);
      highp float x_97;
      x_97 = (y_over_x_96 * inversesqrt(((y_over_x_96 * y_over_x_96) + 1.0)));
      highp vec2 tmpvar_98;
      tmpvar_98.x = ((sign(x_97) * (1.5708 - (sqrt((1.0 - abs(x_97))) * (1.5708 + (abs(x_97) * (-0.214602 + (abs(x_97) * (0.0865667 + (abs(x_97) * -0.0310296))))))))) / 1.5);
      tmpvar_98.y = sqrt(((r_88 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_99;
      tmpvar_99 = texture2D (_Sky_Transmittance, tmpvar_98);
      tmpvar_95 = tmpvar_99.xyz;
      tmpvar_94 = tmpvar_95;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_4 = (sunColor_4 * tmpvar_94);
    };
    highp vec3 tmpvar_100;
    tmpvar_100 = (sunColor_4 * sunGlareFade);
    sunColor_4 = tmpvar_100;
    highp vec4 tmpvar_101;
    tmpvar_101.w = 1.0;
    tmpvar_101.xyz = tmpvar_100;
    tmpvar_1 = tmpvar_101;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _Globals_WorldCameraPos;
uniform highp float sunGlareScale;
uniform highp float sunGlareFade;
uniform sampler2D sunSpikes;
uniform sampler2D sunFlare;
uniform sampler2D sunGhost1;
uniform sampler2D sunGhost2;
uniform sampler2D sunGhost3;
uniform sampler2D _customDepthTexture;
uniform highp vec3 flareSettings;
uniform highp vec3 spikesSettings;
uniform highp mat4 ghost1Settings1;
uniform highp mat4 ghost1Settings2;
uniform highp mat4 ghost2Settings1;
uniform highp mat4 ghost2Settings2;
uniform highp mat4 ghost3Settings1;
uniform highp mat4 ghost3Settings2;
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float useTransmittance;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec3 sunViewPortPos;
uniform highp float aspectRatio;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 ghosts_3;
  highp vec3 sunColor_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = (aspectRatio * flareSettings.y);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_5) * flareSettings.z) * sunGlareScale) + 0.5);
  tmpvar_6 = texture2D (sunFlare, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 1.0;
  tmpvar_8.x = (aspectRatio * spikesSettings.y);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_8) * spikesSettings.z) * sunGlareScale) + 0.5);
  tmpvar_9 = texture2D (sunSpikes, P_10);
  highp vec2 tmpvar_11;
  tmpvar_11 = (sunViewPortPos.xy - 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.y = 1.0;
  tmpvar_12.x = (aspectRatio * ghost1Settings1[1].x);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].x)) * tmpvar_12) * ghost1Settings1[2].x) + 0.5);
  tmpvar_13 = texture2D (sunGhost1, P_14);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 1.0;
  tmpvar_15.x = (aspectRatio * ghost1Settings2[1].x);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].x)) * tmpvar_15) * ghost1Settings2[2].x) + 0.5);
  tmpvar_16 = texture2D (sunGhost1, P_17);
  ghosts_3 = ((ghost1Settings1[0].x * tmpvar_13.xyz) + (ghost1Settings2[0].x * tmpvar_16.xyz));
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = (aspectRatio * ghost1Settings1[1].y);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].y)) * tmpvar_18) * ghost1Settings1[2].y) + 0.5);
  tmpvar_19 = texture2D (sunGhost1, P_20);
  highp vec2 tmpvar_21;
  tmpvar_21.y = 1.0;
  tmpvar_21.x = (aspectRatio * ghost1Settings2[1].y);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].y)) * tmpvar_21) * ghost1Settings2[2].y) + 0.5);
  tmpvar_22 = texture2D (sunGhost1, P_23);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].y * tmpvar_19.xyz)) + (ghost1Settings2[0].y * tmpvar_22.xyz));
  highp vec2 tmpvar_24;
  tmpvar_24.y = 1.0;
  tmpvar_24.x = (aspectRatio * ghost1Settings1[1].z);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].z)) * tmpvar_24) * ghost1Settings1[2].z) + 0.5);
  tmpvar_25 = texture2D (sunGhost1, P_26);
  highp vec2 tmpvar_27;
  tmpvar_27.y = 1.0;
  tmpvar_27.x = (aspectRatio * ghost1Settings2[1].z);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].z)) * tmpvar_27) * ghost1Settings2[2].z) + 0.5);
  tmpvar_28 = texture2D (sunGhost1, P_29);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].z * tmpvar_25.xyz)) + (ghost1Settings2[0].z * tmpvar_28.xyz));
  highp vec2 tmpvar_30;
  tmpvar_30.y = 1.0;
  tmpvar_30.x = (aspectRatio * ghost1Settings1[1].w);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].w)) * tmpvar_30) * ghost1Settings1[2].w) + 0.5);
  tmpvar_31 = texture2D (sunGhost1, P_32);
  highp vec2 tmpvar_33;
  tmpvar_33.y = 1.0;
  tmpvar_33.x = (aspectRatio * ghost1Settings2[1].w);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].w)) * tmpvar_33) * ghost1Settings2[2].w) + 0.5);
  tmpvar_34 = texture2D (sunGhost1, P_35);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].w * tmpvar_31.xyz)) + (ghost1Settings2[0].w * tmpvar_34.xyz));
  highp vec2 tmpvar_36;
  tmpvar_36.y = 1.0;
  tmpvar_36.x = (aspectRatio * ghost2Settings1[1].x);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].x)) * tmpvar_36) * ghost2Settings1[2].x) + 0.5);
  tmpvar_37 = texture2D (sunGhost2, P_38);
  highp vec2 tmpvar_39;
  tmpvar_39.y = 1.0;
  tmpvar_39.x = (aspectRatio * ghost2Settings2[1].x);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].x)) * tmpvar_39) * ghost2Settings2[2].x) + 0.5);
  tmpvar_40 = texture2D (sunGhost2, P_41);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].x * tmpvar_37.xyz)) + (ghost2Settings2[0].x * tmpvar_40.xyz));
  highp vec2 tmpvar_42;
  tmpvar_42.y = 1.0;
  tmpvar_42.x = (aspectRatio * ghost2Settings1[1].y);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].y)) * tmpvar_42) * ghost2Settings1[2].y) + 0.5);
  tmpvar_43 = texture2D (sunGhost2, P_44);
  highp vec2 tmpvar_45;
  tmpvar_45.y = 1.0;
  tmpvar_45.x = (aspectRatio * ghost2Settings2[1].y);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].y)) * tmpvar_45) * ghost2Settings2[2].y) + 0.5);
  tmpvar_46 = texture2D (sunGhost2, P_47);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].y * tmpvar_43.xyz)) + (ghost2Settings2[0].y * tmpvar_46.xyz));
  highp vec2 tmpvar_48;
  tmpvar_48.y = 1.0;
  tmpvar_48.x = (aspectRatio * ghost2Settings1[1].z);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].z)) * tmpvar_48) * ghost2Settings1[2].z) + 0.5);
  tmpvar_49 = texture2D (sunGhost2, P_50);
  highp vec2 tmpvar_51;
  tmpvar_51.y = 1.0;
  tmpvar_51.x = (aspectRatio * ghost2Settings2[1].z);
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].z)) * tmpvar_51) * ghost2Settings2[2].z) + 0.5);
  tmpvar_52 = texture2D (sunGhost2, P_53);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].z * tmpvar_49.xyz)) + (ghost2Settings2[0].z * tmpvar_52.xyz));
  highp vec2 tmpvar_54;
  tmpvar_54.y = 1.0;
  tmpvar_54.x = (aspectRatio * ghost2Settings1[1].w);
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].w)) * tmpvar_54) * ghost2Settings1[2].w) + 0.5);
  tmpvar_55 = texture2D (sunGhost2, P_56);
  highp vec2 tmpvar_57;
  tmpvar_57.y = 1.0;
  tmpvar_57.x = (aspectRatio * ghost2Settings2[1].w);
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].w)) * tmpvar_57) * ghost2Settings2[2].w) + 0.5);
  tmpvar_58 = texture2D (sunGhost2, P_59);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].w * tmpvar_55.xyz)) + (ghost2Settings2[0].w * tmpvar_58.xyz));
  highp vec2 tmpvar_60;
  tmpvar_60.y = 1.0;
  tmpvar_60.x = (aspectRatio * ghost3Settings1[1].x);
  lowp vec4 tmpvar_61;
  highp vec2 P_62;
  P_62 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].x)) * tmpvar_60) * ghost3Settings1[2].x) + 0.5);
  tmpvar_61 = texture2D (sunGhost3, P_62);
  highp vec2 tmpvar_63;
  tmpvar_63.y = 1.0;
  tmpvar_63.x = (aspectRatio * ghost3Settings2[1].x);
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].x)) * tmpvar_63) * ghost3Settings2[2].x) + 0.5);
  tmpvar_64 = texture2D (sunGhost3, P_65);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].x * tmpvar_61.xyz)) + (ghost3Settings2[0].x * tmpvar_64.xyz));
  highp vec2 tmpvar_66;
  tmpvar_66.y = 1.0;
  tmpvar_66.x = (aspectRatio * ghost3Settings1[1].y);
  lowp vec4 tmpvar_67;
  highp vec2 P_68;
  P_68 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].y)) * tmpvar_66) * ghost3Settings1[2].y) + 0.5);
  tmpvar_67 = texture2D (sunGhost3, P_68);
  highp vec2 tmpvar_69;
  tmpvar_69.y = 1.0;
  tmpvar_69.x = (aspectRatio * ghost3Settings2[1].y);
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].y)) * tmpvar_69) * ghost3Settings2[2].y) + 0.5);
  tmpvar_70 = texture2D (sunGhost3, P_71);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].y * tmpvar_67.xyz)) + (ghost3Settings2[0].y * tmpvar_70.xyz));
  highp vec2 tmpvar_72;
  tmpvar_72.y = 1.0;
  tmpvar_72.x = (aspectRatio * ghost3Settings1[1].z);
  lowp vec4 tmpvar_73;
  highp vec2 P_74;
  P_74 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].z)) * tmpvar_72) * ghost3Settings1[2].z) + 0.5);
  tmpvar_73 = texture2D (sunGhost3, P_74);
  highp vec2 tmpvar_75;
  tmpvar_75.y = 1.0;
  tmpvar_75.x = (aspectRatio * ghost3Settings2[1].z);
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].z)) * tmpvar_75) * ghost3Settings2[2].z) + 0.5);
  tmpvar_76 = texture2D (sunGhost3, P_77);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].z * tmpvar_73.xyz)) + (ghost3Settings2[0].z * tmpvar_76.xyz));
  highp vec2 tmpvar_78;
  tmpvar_78.y = 1.0;
  tmpvar_78.x = (aspectRatio * ghost3Settings1[1].w);
  lowp vec4 tmpvar_79;
  highp vec2 P_80;
  P_80 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].w)) * tmpvar_78) * ghost3Settings1[2].w) + 0.5);
  tmpvar_79 = texture2D (sunGhost3, P_80);
  highp vec2 tmpvar_81;
  tmpvar_81.y = 1.0;
  tmpvar_81.x = (aspectRatio * ghost3Settings2[1].w);
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].w)) * tmpvar_81) * ghost3Settings2[2].w) + 0.5);
  tmpvar_82 = texture2D (sunGhost3, P_83);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].w * tmpvar_79.xyz)) + (ghost3Settings2[0].w * tmpvar_82.xyz));
  highp float t_84;
  t_84 = max (min ((1.0 - sqrt(dot (tmpvar_11, tmpvar_11))), 1.0), 0.0);
  highp vec3 tmpvar_85;
  tmpvar_85 = (ghosts_3 * (t_84 * (t_84 * (3.0 - (2.0 * t_84)))));
  ghosts_3 = tmpvar_85;
  sunColor_4 = (((flareSettings.x * tmpvar_6.xyz) + (spikesSettings.x * tmpvar_9.xyz)) + tmpvar_85);
  lowp float tmpvar_86;
  tmpvar_86 = texture2D (_customDepthTexture, sunViewPortPos.xy).x;
  depth_2 = tmpvar_86;
  if ((depth_2 < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp float mu_87;
    highp float r_88;
    highp float tmpvar_89;
    tmpvar_89 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_88 = tmpvar_89;
    highp float tmpvar_90;
    tmpvar_90 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    mu_87 = (tmpvar_90 / tmpvar_89);
    highp float f_91;
    f_91 = (((tmpvar_90 * tmpvar_90) - (tmpvar_89 * tmpvar_89)) + (Rt * Rt));
    highp float tmpvar_92;
    if ((f_91 >= 0.0)) {
      tmpvar_92 = sqrt(f_91);
    } else {
      tmpvar_92 = 1e-06;
    };
    highp float tmpvar_93;
    tmpvar_93 = max ((-(tmpvar_90) - tmpvar_92), 0.0);
    if ((tmpvar_93 > 0.0)) {
      mu_87 = ((tmpvar_90 + tmpvar_93) / Rt);
      r_88 = Rt;
    };
    highp vec3 tmpvar_94;
    if ((r_88 > Rt)) {
      tmpvar_94 = vec3(1.0, 1.0, 1.0);
    } else {
      highp vec3 tmpvar_95;
      highp float y_over_x_96;
      y_over_x_96 = (((mu_87 + 0.15) / 1.15) * 14.1014);
      highp float x_97;
      x_97 = (y_over_x_96 * inversesqrt(((y_over_x_96 * y_over_x_96) + 1.0)));
      highp vec2 tmpvar_98;
      tmpvar_98.x = ((sign(x_97) * (1.5708 - (sqrt((1.0 - abs(x_97))) * (1.5708 + (abs(x_97) * (-0.214602 + (abs(x_97) * (0.0865667 + (abs(x_97) * -0.0310296))))))))) / 1.5);
      tmpvar_98.y = sqrt(((r_88 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_99;
      tmpvar_99 = texture2D (_Sky_Transmittance, tmpvar_98);
      tmpvar_95 = tmpvar_99.xyz;
      tmpvar_94 = tmpvar_95;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_4 = (sunColor_4 * tmpvar_94);
    };
    highp vec3 tmpvar_100;
    tmpvar_100 = (sunColor_4 * sunGlareFade);
    sunColor_4 = tmpvar_100;
    highp vec4 tmpvar_101;
    tmpvar_101.w = 1.0;
    tmpvar_101.xyz = tmpvar_100;
    tmpvar_1 = tmpvar_101;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(1.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp float sunGlareScale;
uniform highp float sunGlareFade;
uniform sampler2D sunSpikes;
uniform sampler2D sunFlare;
uniform sampler2D sunGhost1;
uniform sampler2D sunGhost2;
uniform sampler2D sunGhost3;
uniform sampler2D _customDepthTexture;
uniform highp vec3 flareSettings;
uniform highp vec3 spikesSettings;
uniform highp mat4 ghost1Settings1;
uniform highp mat4 ghost1Settings2;
uniform highp mat4 ghost2Settings1;
uniform highp mat4 ghost2Settings2;
uniform highp mat4 ghost3Settings1;
uniform highp mat4 ghost3Settings2;
uniform highp float Rg;
uniform highp float Rt;
uniform sampler2D _Sky_Transmittance;
uniform highp float useTransmittance;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec3 sunViewPortPos;
uniform highp float aspectRatio;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp float depth_2;
  highp vec3 ghosts_3;
  highp vec3 sunColor_4;
  highp vec2 tmpvar_5;
  tmpvar_5.y = 1.0;
  tmpvar_5.x = (aspectRatio * flareSettings.y);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_5) * flareSettings.z) * sunGlareScale) + 0.5);
  tmpvar_6 = texture (sunFlare, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 1.0;
  tmpvar_8.x = (aspectRatio * spikesSettings.y);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) * tmpvar_8) * spikesSettings.z) * sunGlareScale) + 0.5);
  tmpvar_9 = texture (sunSpikes, P_10);
  highp vec2 tmpvar_11;
  tmpvar_11 = (sunViewPortPos.xy - 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.y = 1.0;
  tmpvar_12.x = (aspectRatio * ghost1Settings1[1].x);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].x)) * tmpvar_12) * ghost1Settings1[2].x) + 0.5);
  tmpvar_13 = texture (sunGhost1, P_14);
  highp vec2 tmpvar_15;
  tmpvar_15.y = 1.0;
  tmpvar_15.x = (aspectRatio * ghost1Settings2[1].x);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].x)) * tmpvar_15) * ghost1Settings2[2].x) + 0.5);
  tmpvar_16 = texture (sunGhost1, P_17);
  ghosts_3 = ((ghost1Settings1[0].x * tmpvar_13.xyz) + (ghost1Settings2[0].x * tmpvar_16.xyz));
  highp vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = (aspectRatio * ghost1Settings1[1].y);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].y)) * tmpvar_18) * ghost1Settings1[2].y) + 0.5);
  tmpvar_19 = texture (sunGhost1, P_20);
  highp vec2 tmpvar_21;
  tmpvar_21.y = 1.0;
  tmpvar_21.x = (aspectRatio * ghost1Settings2[1].y);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].y)) * tmpvar_21) * ghost1Settings2[2].y) + 0.5);
  tmpvar_22 = texture (sunGhost1, P_23);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].y * tmpvar_19.xyz)) + (ghost1Settings2[0].y * tmpvar_22.xyz));
  highp vec2 tmpvar_24;
  tmpvar_24.y = 1.0;
  tmpvar_24.x = (aspectRatio * ghost1Settings1[1].z);
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].z)) * tmpvar_24) * ghost1Settings1[2].z) + 0.5);
  tmpvar_25 = texture (sunGhost1, P_26);
  highp vec2 tmpvar_27;
  tmpvar_27.y = 1.0;
  tmpvar_27.x = (aspectRatio * ghost1Settings2[1].z);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].z)) * tmpvar_27) * ghost1Settings2[2].z) + 0.5);
  tmpvar_28 = texture (sunGhost1, P_29);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].z * tmpvar_25.xyz)) + (ghost1Settings2[0].z * tmpvar_28.xyz));
  highp vec2 tmpvar_30;
  tmpvar_30.y = 1.0;
  tmpvar_30.x = (aspectRatio * ghost1Settings1[1].w);
  lowp vec4 tmpvar_31;
  highp vec2 P_32;
  P_32 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings1[3].w)) * tmpvar_30) * ghost1Settings1[2].w) + 0.5);
  tmpvar_31 = texture (sunGhost1, P_32);
  highp vec2 tmpvar_33;
  tmpvar_33.y = 1.0;
  tmpvar_33.x = (aspectRatio * ghost1Settings2[1].w);
  lowp vec4 tmpvar_34;
  highp vec2 P_35;
  P_35 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost1Settings2[3].w)) * tmpvar_33) * ghost1Settings2[2].w) + 0.5);
  tmpvar_34 = texture (sunGhost1, P_35);
  ghosts_3 = ((ghosts_3 + (ghost1Settings1[0].w * tmpvar_31.xyz)) + (ghost1Settings2[0].w * tmpvar_34.xyz));
  highp vec2 tmpvar_36;
  tmpvar_36.y = 1.0;
  tmpvar_36.x = (aspectRatio * ghost2Settings1[1].x);
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].x)) * tmpvar_36) * ghost2Settings1[2].x) + 0.5);
  tmpvar_37 = texture (sunGhost2, P_38);
  highp vec2 tmpvar_39;
  tmpvar_39.y = 1.0;
  tmpvar_39.x = (aspectRatio * ghost2Settings2[1].x);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].x)) * tmpvar_39) * ghost2Settings2[2].x) + 0.5);
  tmpvar_40 = texture (sunGhost2, P_41);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].x * tmpvar_37.xyz)) + (ghost2Settings2[0].x * tmpvar_40.xyz));
  highp vec2 tmpvar_42;
  tmpvar_42.y = 1.0;
  tmpvar_42.x = (aspectRatio * ghost2Settings1[1].y);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].y)) * tmpvar_42) * ghost2Settings1[2].y) + 0.5);
  tmpvar_43 = texture (sunGhost2, P_44);
  highp vec2 tmpvar_45;
  tmpvar_45.y = 1.0;
  tmpvar_45.x = (aspectRatio * ghost2Settings2[1].y);
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].y)) * tmpvar_45) * ghost2Settings2[2].y) + 0.5);
  tmpvar_46 = texture (sunGhost2, P_47);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].y * tmpvar_43.xyz)) + (ghost2Settings2[0].y * tmpvar_46.xyz));
  highp vec2 tmpvar_48;
  tmpvar_48.y = 1.0;
  tmpvar_48.x = (aspectRatio * ghost2Settings1[1].z);
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].z)) * tmpvar_48) * ghost2Settings1[2].z) + 0.5);
  tmpvar_49 = texture (sunGhost2, P_50);
  highp vec2 tmpvar_51;
  tmpvar_51.y = 1.0;
  tmpvar_51.x = (aspectRatio * ghost2Settings2[1].z);
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].z)) * tmpvar_51) * ghost2Settings2[2].z) + 0.5);
  tmpvar_52 = texture (sunGhost2, P_53);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].z * tmpvar_49.xyz)) + (ghost2Settings2[0].z * tmpvar_52.xyz));
  highp vec2 tmpvar_54;
  tmpvar_54.y = 1.0;
  tmpvar_54.x = (aspectRatio * ghost2Settings1[1].w);
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings1[3].w)) * tmpvar_54) * ghost2Settings1[2].w) + 0.5);
  tmpvar_55 = texture (sunGhost2, P_56);
  highp vec2 tmpvar_57;
  tmpvar_57.y = 1.0;
  tmpvar_57.x = (aspectRatio * ghost2Settings2[1].w);
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost2Settings2[3].w)) * tmpvar_57) * ghost2Settings2[2].w) + 0.5);
  tmpvar_58 = texture (sunGhost2, P_59);
  ghosts_3 = ((ghosts_3 + (ghost2Settings1[0].w * tmpvar_55.xyz)) + (ghost2Settings2[0].w * tmpvar_58.xyz));
  highp vec2 tmpvar_60;
  tmpvar_60.y = 1.0;
  tmpvar_60.x = (aspectRatio * ghost3Settings1[1].x);
  lowp vec4 tmpvar_61;
  highp vec2 P_62;
  P_62 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].x)) * tmpvar_60) * ghost3Settings1[2].x) + 0.5);
  tmpvar_61 = texture (sunGhost3, P_62);
  highp vec2 tmpvar_63;
  tmpvar_63.y = 1.0;
  tmpvar_63.x = (aspectRatio * ghost3Settings2[1].x);
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].x)) * tmpvar_63) * ghost3Settings2[2].x) + 0.5);
  tmpvar_64 = texture (sunGhost3, P_65);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].x * tmpvar_61.xyz)) + (ghost3Settings2[0].x * tmpvar_64.xyz));
  highp vec2 tmpvar_66;
  tmpvar_66.y = 1.0;
  tmpvar_66.x = (aspectRatio * ghost3Settings1[1].y);
  lowp vec4 tmpvar_67;
  highp vec2 P_68;
  P_68 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].y)) * tmpvar_66) * ghost3Settings1[2].y) + 0.5);
  tmpvar_67 = texture (sunGhost3, P_68);
  highp vec2 tmpvar_69;
  tmpvar_69.y = 1.0;
  tmpvar_69.x = (aspectRatio * ghost3Settings2[1].y);
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].y)) * tmpvar_69) * ghost3Settings2[2].y) + 0.5);
  tmpvar_70 = texture (sunGhost3, P_71);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].y * tmpvar_67.xyz)) + (ghost3Settings2[0].y * tmpvar_70.xyz));
  highp vec2 tmpvar_72;
  tmpvar_72.y = 1.0;
  tmpvar_72.x = (aspectRatio * ghost3Settings1[1].z);
  lowp vec4 tmpvar_73;
  highp vec2 P_74;
  P_74 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].z)) * tmpvar_72) * ghost3Settings1[2].z) + 0.5);
  tmpvar_73 = texture (sunGhost3, P_74);
  highp vec2 tmpvar_75;
  tmpvar_75.y = 1.0;
  tmpvar_75.x = (aspectRatio * ghost3Settings2[1].z);
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].z)) * tmpvar_75) * ghost3Settings2[2].z) + 0.5);
  tmpvar_76 = texture (sunGhost3, P_77);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].z * tmpvar_73.xyz)) + (ghost3Settings2[0].z * tmpvar_76.xyz));
  highp vec2 tmpvar_78;
  tmpvar_78.y = 1.0;
  tmpvar_78.x = (aspectRatio * ghost3Settings1[1].w);
  lowp vec4 tmpvar_79;
  highp vec2 P_80;
  P_80 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings1[3].w)) * tmpvar_78) * ghost3Settings1[2].w) + 0.5);
  tmpvar_79 = texture (sunGhost3, P_80);
  highp vec2 tmpvar_81;
  tmpvar_81.y = 1.0;
  tmpvar_81.x = (aspectRatio * ghost3Settings2[1].w);
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (((((xlv_TEXCOORD0 - sunViewPortPos.xy) + (tmpvar_11 * ghost3Settings2[3].w)) * tmpvar_81) * ghost3Settings2[2].w) + 0.5);
  tmpvar_82 = texture (sunGhost3, P_83);
  ghosts_3 = ((ghosts_3 + (ghost3Settings1[0].w * tmpvar_79.xyz)) + (ghost3Settings2[0].w * tmpvar_82.xyz));
  highp float t_84;
  t_84 = max (min ((1.0 - sqrt(dot (tmpvar_11, tmpvar_11))), 1.0), 0.0);
  highp vec3 tmpvar_85;
  tmpvar_85 = (ghosts_3 * (t_84 * (t_84 * (3.0 - (2.0 * t_84)))));
  ghosts_3 = tmpvar_85;
  sunColor_4 = (((flareSettings.x * tmpvar_6.xyz) + (spikesSettings.x * tmpvar_9.xyz)) + tmpvar_85);
  lowp float tmpvar_86;
  tmpvar_86 = texture (_customDepthTexture, sunViewPortPos.xy).x;
  depth_2 = tmpvar_86;
  if ((depth_2 < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp float mu_87;
    highp float r_88;
    highp float tmpvar_89;
    tmpvar_89 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_88 = tmpvar_89;
    highp float tmpvar_90;
    tmpvar_90 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    mu_87 = (tmpvar_90 / tmpvar_89);
    highp float f_91;
    f_91 = (((tmpvar_90 * tmpvar_90) - (tmpvar_89 * tmpvar_89)) + (Rt * Rt));
    highp float tmpvar_92;
    if ((f_91 >= 0.0)) {
      tmpvar_92 = sqrt(f_91);
    } else {
      tmpvar_92 = 1e-06;
    };
    highp float tmpvar_93;
    tmpvar_93 = max ((-(tmpvar_90) - tmpvar_92), 0.0);
    if ((tmpvar_93 > 0.0)) {
      mu_87 = ((tmpvar_90 + tmpvar_93) / Rt);
      r_88 = Rt;
    };
    highp vec3 tmpvar_94;
    if ((r_88 > Rt)) {
      tmpvar_94 = vec3(1.0, 1.0, 1.0);
    } else {
      highp vec3 tmpvar_95;
      highp float y_over_x_96;
      y_over_x_96 = (((mu_87 + 0.15) / 1.15) * 14.1014);
      highp float x_97;
      x_97 = (y_over_x_96 * inversesqrt(((y_over_x_96 * y_over_x_96) + 1.0)));
      highp vec2 tmpvar_98;
      tmpvar_98.x = ((sign(x_97) * (1.5708 - (sqrt((1.0 - abs(x_97))) * (1.5708 + (abs(x_97) * (-0.214602 + (abs(x_97) * (0.0865667 + (abs(x_97) * -0.0310296))))))))) / 1.5);
      tmpvar_98.y = sqrt(((r_88 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_99;
      tmpvar_99 = texture (_Sky_Transmittance, tmpvar_98);
      tmpvar_95 = tmpvar_99.xyz;
      tmpvar_94 = tmpvar_95;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_4 = (sunColor_4 * tmpvar_94);
    };
    highp vec3 tmpvar_100;
    tmpvar_100 = (sunColor_4 * sunGlareFade);
    sunColor_4 = tmpvar_100;
    highp vec4 tmpvar_101;
    tmpvar_101.w = 1.0;
    tmpvar_101.xyz = tmpvar_100;
    tmpvar_1 = tmpvar_101;
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
// Stats: 274 math, 28 textures, 1 branches
Matrix 0 [ghost1Settings1]
Matrix 4 [ghost1Settings2]
Matrix 8 [ghost2Settings1]
Matrix 12 [ghost2Settings2]
Matrix 16 [ghost3Settings1]
Matrix 20 [ghost3Settings2]
Vector 24 [_Globals_WorldCameraPos]
Float 25 [sunGlareScale]
Float 26 [sunGlareFade]
Vector 27 [flareSettings]
Vector 28 [spikesSettings]
Float 29 [Rg]
Float 30 [Rt]
Float 31 [useTransmittance]
Vector 32 [_Sun_WorldSunDir]
Vector 33 [sunViewPortPos]
Float 34 [aspectRatio]
SetTexture 0 [sunFlare] 2D 0
SetTexture 1 [sunSpikes] 2D 1
SetTexture 2 [sunGhost1] 2D 2
SetTexture 3 [sunGhost2] 2D 3
SetTexture 4 [sunGhost3] 2D 4
SetTexture 5 [_customDepthTexture] 2D 5
SetTexture 6 [_Sky_Transmittance] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c35, -1.00000000, 1.00000000, 0.00000000, 0.50000000
def c36, -0.50000000, 2.00000000, 3.00000000, 0.00000100
def c37, 0.15000001, 12.26193905, -0.01348047, 0.05747731
def c38, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c39, 1.57079601, 0.66666669, 0, 0
dcl_texcoord0 v0.xy
mov r1.xy, c33
mov r1.z, c34.x
mov r3.x, c34
mov r3.z, c34.x
add r2.zw, v0.xyxy, -c33.xyxy
add r2.xy, c36.x, r1
mad r1.xy, r2, c1.w, r2.zwzw
mov r1.w, c35.y
mul r1.z, c1.y, r1
mul r1.xy, r1, r1.zwzw
mul r1.xy, r1, c1.z
mad r1.zw, r2.xyxy, c4.w, r2
mov r3.y, c35
mul r3.x, c4.y, r3
mul r1.zw, r1, r3.xyxy
mad r3.xy, r2, c0.w, r2.zwzw
mul r1.zw, r1, c4.z
add r1.xy, r1, c35.w
mov r3.w, c35.y
mul r3.z, c0.y, r3
mul r3.zw, r3.xyxy, r3
add r3.xy, r1.zwzw, c35.w
mul r1.zw, r3, c0.z
add r4.xy, r1.zwzw, c35.w
texld r3.xyz, r3, s2
texld r4.xyz, r4, s2
mul r3.xyz, r3, c4.x
mad r3.xyz, r4, c0.x, r3
texld r1.xyz, r1, s2
mad r1.xyz, r1, c1.x, r3
mov r1.w, c34.x
mul r3.z, c5.y, r1.w
mov r1.w, c34.x
mul r4.x, c2.y, r1.w
mad r3.xy, r2, c5.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c5.z
mad r3.zw, r2.xyxy, c2.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c2.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s2
mad r1.xyz, r3, c5.x, r1
texld r3.xyz, r4, s2
mad r1.xyz, r3, c2.x, r1
mov r1.w, c34.x
mul r3.z, c6.y, r1.w
mov r1.w, c34.x
mul r4.x, c3.y, r1.w
mad r3.xy, r2, c6.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c6.z
mad r3.zw, r2.xyxy, c3.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c3.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s2
mad r1.xyz, r3, c6.x, r1
texld r3.xyz, r4, s2
mad r1.xyz, r3, c3.x, r1
mov r1.w, c34.x
mul r3.z, c7.y, r1.w
mov r1.w, c34.x
mul r4.x, c8.y, r1.w
mad r3.xy, r2, c7.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c7.z
mad r3.zw, r2.xyxy, c8.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c8.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s2
mad r1.xyz, r3, c7.x, r1
texld r3.xyz, r4, s3
mad r1.xyz, r3, c8.x, r1
mov r1.w, c34.x
mul r3.z, c12.y, r1.w
mov r1.w, c34.x
mul r4.x, c9.y, r1.w
mad r3.xy, r2, c12.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c12.z
mad r3.zw, r2.xyxy, c9.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c9.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s3
mad r1.xyz, r3, c12.x, r1
texld r3.xyz, r4, s3
mad r1.xyz, r3, c9.x, r1
mov r1.w, c34.x
mul r3.z, c13.y, r1.w
mov r1.w, c34.x
mul r4.x, c10.y, r1.w
mad r3.xy, r2, c13.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c13.z
mad r3.zw, r2.xyxy, c10.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c10.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s3
mad r1.xyz, r3, c13.x, r1
texld r3.xyz, r4, s3
mad r1.xyz, r3, c10.x, r1
mov r1.w, c34.x
mul r3.z, c14.y, r1.w
mov r1.w, c34.x
mul r4.x, c11.y, r1.w
mad r3.xy, r2, c14.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c14.z
mad r3.zw, r2.xyxy, c11.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c11.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s3
mad r1.xyz, r3, c14.x, r1
texld r3.xyz, r4, s3
mad r1.xyz, r3, c11.x, r1
mov r1.w, c34.x
mul r3.z, c15.y, r1.w
mov r1.w, c34.x
mul r4.x, c16.y, r1.w
mad r3.xy, r2, c15.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c15.z
mad r3.zw, r2.xyxy, c16.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c16.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s3
mad r1.xyz, r3, c15.x, r1
texld r3.xyz, r4, s4
mad r1.xyz, r3, c16.x, r1
mov r1.w, c34.x
mul r3.z, c20.y, r1.w
mov r1.w, c34.x
mul r4.x, c17.y, r1.w
mad r3.xy, r2, c20.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c20.z
mad r3.zw, r2.xyxy, c17.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c17.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s4
mad r1.xyz, r3, c20.x, r1
texld r3.xyz, r4, s4
mad r1.xyz, r3, c17.x, r1
mov r1.w, c34.x
mul r3.z, c21.y, r1.w
mov r1.w, c34.x
mul r4.x, c18.y, r1.w
mad r3.xy, r2, c21.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c21.z
mad r3.zw, r2.xyxy, c18.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c18.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s4
mad r1.xyz, r3, c21.x, r1
texld r3.xyz, r4, s4
mad r1.xyz, r3, c18.x, r1
mov r1.w, c34.x
mul r3.z, c22.y, r1.w
mov r1.w, c34.x
mul r4.x, c19.y, r1.w
mad r3.xy, r2, c22.w, r2.zwzw
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mul r3.xy, r3, c22.z
mad r3.zw, r2.xyxy, c19.w, r2
mov r4.y, c35
mul r3.zw, r3, r4.xyxy
mul r3.zw, r3, c19.z
add r4.xy, r3.zwzw, c35.w
add r3.xy, r3, c35.w
texld r3.xyz, r3, s4
mad r1.xyz, r3, c22.x, r1
texld r3.xyz, r4, s4
mad r1.xyz, r3, c19.x, r1
mad r3.xy, r2, c23.w, r2.zwzw
mov r1.w, c34.x
mul r3.z, c23.y, r1.w
mov r3.w, c35.y
mul r3.xy, r3, r3.zwzw
mov r1.w, c34.x
mul r3.z, c27.y, r1.w
mov r3.w, c35.y
mul r3.zw, r2, r3
mul r3.zw, r3, c27.z
mul r4.xy, r3.zwzw, c25.x
mul r3.xy, r3, c23.z
add r3.xy, r3, c35.w
texld r3.xyz, r3, s4
mad r1.xyz, r3, c23.x, r1
mov r1.w, c34.x
mul r3.z, c28.y, r1.w
mul r2.xy, r2, r2
add r1.w, r2.x, r2.y
mov r3.w, c35.y
mul r2.zw, r2, r3
add r3.xy, r4, c35.w
mul r2.zw, r2, c28.z
mul r2.zw, r2, c25.x
add r2.xy, r2.zwzw, c35.w
rsq r1.w, r1.w
texld r2.xyz, r2, s1
rcp r1.w, r1.w
add_sat r1.w, -r1, c35.y
mul r2.w, r1, r1
mad r1.w, -r1, c36.y, c36.z
mul r1.w, r2, r1
texld r3.xyz, r3, s0
mul r2.xyz, r2, c28.x
mad r2.xyz, r3, c27.x, r2
texld r3.x, c33, s5
add r2.w, r3.x, c35.x
mad r1.xyz, r1, r1.w, r2
cmp_pp r1.w, r2, c35.y, c35.z
cmp oC0, r2.w, r0, c35.z
if_gt r1.w, c35.z
mov r2.xyz, c24
dp3 r0.x, c24, c24
rsq r1.w, r0.x
rcp r0.y, r1.w
dp3 r2.x, c32, r2
mul r0.x, r0.y, r0.y
mad r0.x, r2, r2, -r0
mad r0.z, c30.x, c30.x, r0.x
rsq r0.x, r0.z
rcp r0.x, r0.x
cmp r0.x, r0.z, r0, c36.w
add r0.x, -r2, -r0
max r0.z, r0.x, c35
add r0.w, r0.z, r2.x
rcp r0.x, c30.x
mul r0.x, r0.w, r0
mul r0.w, r1, r2.x
cmp r0.x, -r0.z, r0.w, r0
cmp r2.z, -r0, r0.y, c30.x
add r0.x, r0, c37
mul r0.x, r0, c37.y
abs r2.y, r0.x
max r0.w, r2.y, c35.y
min r1.w, r2.y, c35.y
rcp r0.w, r0.w
mul r2.x, r1.w, r0.w
mul r1.w, r2.x, r2.x
mad r0.w, r1, c37.z, c37
mad r0.w, r0, r1, c38.x
mad r0.w, r0, r1, c38.y
mad r0.w, r0, r1, c38.z
mad r0.w, r0, r1, c38
mul r2.x, r0.w, r2
mov r0.w, c30.x
add r0.w, -c29.x, r0
rcp r0.y, r0.w
add r0.z, r2, -c29.x
mul r0.y, r0.z, r0
rsq r0.y, r0.y
add r1.w, -r2.x, c39.x
add r2.y, r2, c35.x
cmp r0.z, -r2.y, r2.x, r1.w
cmp r0.x, r0, r0.z, -r0.z
rcp r0.y, r0.y
mul r0.x, r0, c39.y
texld r0.xyz, r0, s6
add r0.w, r2.z, -c30.x
cmp r0.xyz, -r0.w, r0, c35.y
mul r0.xyz, r1, r0
cmp r0.xyz, -c31.x, r1, r0
mul oC0.xyz, r0, c26.x
mov oC0.w, c35.y
endif
"
}
SubProgram "d3d11 " {
// Stats: 151 math, 28 textures, 2 branches
SetTexture 0 [sunFlare] 2D 1
SetTexture 1 [sunSpikes] 2D 0
SetTexture 2 [sunGhost1] 2D 2
SetTexture 3 [sunGhost2] 2D 3
SetTexture 4 [sunGhost3] 2D 4
SetTexture 5 [_customDepthTexture] 2D 5
SetTexture 6 [_Sky_Transmittance] 2D 6
ConstBuffer "$Globals" 512
Matrix 80 [ghost1Settings1]
Matrix 144 [ghost1Settings2]
Matrix 208 [ghost2Settings1]
Matrix 272 [ghost2Settings2]
Matrix 336 [ghost3Settings1]
Matrix 400 [ghost3Settings2]
Vector 16 [_Globals_WorldCameraPos] 3
Float 44 [sunGlareScale]
Float 48 [sunGlareFade]
Vector 52 [flareSettings] 3
Vector 64 [spikesSettings] 3
Float 464 [Rg]
Float 468 [Rt]
Float 472 [useTransmittance]
Vector 480 [_Sun_WorldSunDir] 3
Vector 496 [sunViewPortPos] 3
Float 508 [aspectRatio]
BindCB  "$Globals" 0
"ps_4_0
eefiecedilcfkpnpdecimgdommjeialcjfjlocioabaaaaaamabpaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaabpaaaa
eaaaaaaamaahaaaafjaaaaaeegiocaaaaaaaaaaacaaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacajaaaaaaefaaaaak
pcaabaaaaaaaaaaaegiacaaaaaaaaaaabpaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
bpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabaaaaaaajpcaabaaaaaaaaaaa
egbebaaaabaaaaaaegiecaiaebaaaaaaaaaaaaaabpaaaaaadiaaaaajbcaabaaa
abaaaaaackiacaaaaaaaaaaaadaaaaaadkiacaaaaaaaaaaabpaaaaaadgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaaidcaabaaa
abaaaaaaegaabaaaabaaaaaapgipcaaaaaaaaaaaadaaaaaadcaaaaandcaabaaa
abaaaaaaegaabaaaabaaaaaapgipcaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaajecaabaaaabaaaaaabkiacaaa
aaaaaaaaaeaaaaaadkiacaaaaaaaaaaabpaaaaaadiaaaaahdcaabaaaabaaaaaa
ogakbaaaaaaaaaaaogakbaaaabaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaa
abaaaaaakgikcaaaaaaaaaaaaeaaaaaadcaaaaandcaabaaaabaaaaaaegaabaaa
abaaaaaapgipcaaaaaaaaaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaafgifcaaaaaaaaaaaadaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaldcaabaaaacaaaaaaegiacaaa
aaaaaaaabpaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaadcaaaaak
pcaabaaaadaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaaaiaaaaaaogaobaaa
aaaaaaaadiaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaaagaaaaaapgipcaaa
aaaaaaaabpaaaaaadgaaaaafbcaabaaaafaaaaaaakaabaaaaeaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaadaaaaaaagaebaaaafaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaa
acaaaaaaagifcaaaaaaaaaaaamaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaa
aiaaaaaaegilcaaaaaaaaaaaakaaaaaapgipcaaaaaaaaaaabpaaaaaadgaaaaaf
ecaabaaaafaaaaaaakaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaa
afaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
agiacaaaaaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaafaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaaagiacaaaaaaaaaaa
ajaaaaaadcaaaaakhcaabaaaafaaaaaaagiacaaaaaaaaaaaafaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaagaaaaaabkaabaaaaeaaaaaa
dgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadp
diaaaaahmcaabaaaacaaaaaakgaobaaaadaaaaaaagaebaaaagaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaadaaaaaaogakbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
fgifcaaaaaaaaaaaafaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadgaaaaaf
ecaabaaaagaaaaaabkaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaa
agaaaaaakgaobaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
fgifcaaaaaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaafaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaafaaaaaaegaebaaaacaaaaaa
kgipcaaaaaaaaaaaaiaaaaaaogaobaaaaaaaaaaadgaaaaafbcaabaaaagaaaaaa
ckaabaaaaeaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaaafaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
ahaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaakgikcaaaaaaaaaaaafaaaaaaegacbaaaahaaaaaaegacbaaa
adaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaa
amaaaaaaogaobaaaaaaaaaaadgaaaaafecaabaaaagaaaaaadkaabaaaaiaaaaaa
diaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaaalaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
kgikcaaaaaaaaaaaajaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaaf
bcaabaaaaiaaaaaadkaabaaaaeaaaaaadgaaaaaikcaabaaaaiaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaa
afaaaaaaagaebaaaaiaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
pgipcaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaaafaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaahaaaaaa
kgaobaaaaiaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaa
aaaaaaaaalaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaaj
pcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaaajaaaaaaegacbaaaaeaaaaaa
egacbaaaadaaaaaadcaaaaakpcaabaaaaeaaaaaaegaebaaaacaaaaaaagifcaaa
aaaaaaaabaaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaaafaaaaaaegiocaaa
aaaaaaaaaoaaaaaapgipcaaaaaaaaaaabpaaaaaadgaaaaafbcaabaaaagaaaaaa
akaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaa
apaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
ahaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaak
hcaabaaaadaaaaaaagiacaaaaaaaaaaaanaaaaaaegacbaaaahaaaaaaegacbaaa
adaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaa
beaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaaaiaaaaaaegilcaaaaaaaaaaa
bcaaaaaapgipcaaaaaaaaaaabpaaaaaadgaaaaafecaabaaaagaaaaaaakaabaaa
aiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaabdaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaagiacaaaaaaaaaaabbaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaa
dgaaaaafbcaabaaaagaaaaaabkaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaa
kgaobaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaa
acaaaaaafgifcaaaaaaaaaaaapaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaaanaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaadgaaaaafecaabaaaagaaaaaabkaabaaa
aiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaakgaobaaaahaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaabdaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaafgifcaaaaaaaaaaabbaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
dcaaaaakpcaabaaaaeaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaabaaaaaaa
ogaobaaaaaaaaaaadgaaaaafbcaabaaaagaaaaaackaabaaaafaaaaaadgaaaaai
kcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaaapaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaa
aaaaaaaaanaaaaaaegacbaaaahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaa
ahaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaabeaaaaaaogaobaaaaaaaaaaa
dgaaaaafecaabaaaagaaaaaadkaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaa
kgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaa
acaaaaaakgikcaaaaaaaaaaabdaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaaaaaaaaaabbaaaaaa
egacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaaiaaaaaadkaabaaa
afaaaaaadgaaaaaikcaabaaaaiaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaaaeaaaaaaagaebaaaaiaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaaaaaaaaaaapaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaapgipcaaaaaaaaaaaanaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
diaaaaahmcaabaaaacaaaaaakgaobaaaahaaaaaakgaobaaaaiaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaaaaaaaaaabdaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
pgipcaaaaaaaaaaabbaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadcaaaaak
pcaabaaaaeaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaabiaaaaaaogaobaaa
aaaaaaaadiaaaaajpcaabaaaafaaaaaaegiocaaaaaaaaaaabgaaaaaapgipcaaa
aaaaaaaabpaaaaaadgaaaaafbcaabaaaagaaaaaaakaabaaaafaaaaaadgaaaaai
kcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaabhaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaa
aaaaaaaabfaaaaaaegacbaaaahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaa
ahaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaabmaaaaaaogaobaaaaaaaaaaa
diaaaaajpcaabaaaaiaaaaaaegilcaaaaaaaaaaabkaaaaaapgipcaaaaaaaaaaa
bpaaaaaadgaaaaafecaabaaaagaaaaaaakaabaaaaiaaaaaadiaaaaahmcaabaaa
acaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaa
kgaobaaaacaaaaaaagiacaaaaaaaaaaablaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaa
bjaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaagaaaaaa
bkaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaaaeaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaa
bhaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
aeaaaaaaogakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaak
hcaabaaaadaaaaaafgifcaaaaaaaaaaabfaaaaaaegacbaaaaeaaaaaaegacbaaa
adaaaaaadgaaaaafecaabaaaagaaaaaabkaabaaaaiaaaaaadiaaaaahmcaabaaa
acaaaaaakgaobaaaagaaaaaakgaobaaaahaaaaaadcaaaaanmcaabaaaacaaaaaa
kgaobaaaacaaaaaafgifcaaaaaaaaaaablaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaa
bjaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaaeaaaaaa
egaebaaaacaaaaaakgipcaaaaaaaaaaabiaaaaaaogaobaaaaaaaaaaadgaaaaaf
bcaabaaaagaaaaaackaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaa
aeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
kgikcaaaaaaaaaaabhaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaaaaaaaaaabfaaaaaaegacbaaa
ahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaebaaaacaaaaaa
kgipcaaaaaaaaaaabmaaaaaaegaobaaaaaaaaaaadgaaaaafecaabaaaagaaaaaa
dkaabaaaaiaaaaaadiaaaaahdcaabaaaaaaaaaaaogakbaaaagaaaaaaegaabaaa
aaaaaaaadcaaaaandcaabaaaaaaaaaaaegaabaaaaaaaaaaakgikcaaaaaaaaaaa
blaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaak
hcaabaaaadaaaaaakgikcaaaaaaaaaaabjaaaaaaegacbaaaagaaaaaaegacbaaa
adaaaaaadgaaaaafbcaabaaaaiaaaaaadkaabaaaafaaaaaadgaaaaaikcaabaaa
aiaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahdcaabaaa
aaaaaaaaogakbaaaaeaaaaaaegaabaaaaiaaaaaadcaaaaandcaabaaaaaaaaaaa
egaabaaaaaaaaaaapgipcaaaaaaaaaaabhaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaa
bfaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadiaaaaahdcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaogakbaaaaiaaaaaadcaaaaandcaabaaaaaaaaaaaegaabaaa
aaaaaaaapgipcaaaaaaaaaaablaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaabjaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
elaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaajecaabaaaabaaaaaa
egiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaboaaaaaaaoaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
ckaabaaaabaaaaaackaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaal
icaabaaaaaaaaaaabkiacaaaaaaaaaaabnaaaaaabkiacaaaaaaaaaaabnaaaaaa
dkaabaaaaaaaaaaabnaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaakicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaalndhiglf
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaah
icaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaaoaaaaaiccaabaaaacaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaabnaaaaaadgaaaaagbcaabaaaacaaaaaa
bkiacaaaaaaaaaaabnaaaaaadhaaaaajdcaabaaaabaaaaaapgapbaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaabkiacaaa
aaaaaaaabnaaaaaaakaabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaiaebaaaaaaaaaaaaaabnaaaaaaaaaaaaakecaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaabnaaaaaabkiacaaaaaaaaaaabnaaaaaaaoaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaaelaaaaafccaabaaa
acaaaaaaakaabaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaajkjjbjdodiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
jfdbeeebddaaaaaiccaabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaa
aaaaiadpdeaaaaaiecaabaaaabaaaaaaakaabaiaibaaaaaaabaaaaaaabeaaaaa
aaaaiadpaoaaaaakecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpckaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaackaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaabkaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaafpkokkdm
abeaaaaadgfkkolndcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaochgdidodcaaaaajicaabaaaabaaaaaackaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajecaabaaaabaaaaaackaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaabaaaaaa
ckaabaaaabaaaaaabkaabaaaabaaaaaadbaaaaaiecaabaaaacaaaaaaabeaaaaa
aaaaiadpakaabaiaibaaaaaaabaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpabaaaaahicaabaaaabaaaaaa
ckaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaa
abaaaaaackaabaaaabaaaaaadkaabaaaabaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaadhaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaabkaabaaaabaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaabaaaaaaabeaaaaaklkkckdpefaaaaajpcaabaaaabaaaaaa
egaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadhaaaaamhcaabaaa
abaaaaaapgapbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaackiacaaa
aaaaaaaabnaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaadaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
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