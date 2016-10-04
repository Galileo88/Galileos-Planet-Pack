// Compiled shader for custom platforms, uncompressed size: 75.4KB

Shader "Scatterer/sunFlare" {
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //        d3d9 : 2 math
 //        gles : 302 math, 28 texture, 5 branch
 //      opengl : 302 math, 28 texture, 5 branch
 // Stats for Fragment shader:
 //       d3d11 : 151 math, 28 texture, 2 branch
 //        d3d9 : 213 math, 28 texture
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZTest False
  ZWrite Off
  Cull Off
  Blend One OneMinusSrcColor
  GpuProgramID 7520
Program "vp" {
SubProgram "opengl " {
// Stats: 302 math, 28 textures, 5 branches
"!!GLSL#version 120

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
  tmpvar_5 = (xlv_TEXCOORD0 - sunViewPortPos.xy);
  sunColor_3 = (flareSettings.x * texture2D (sunFlare, ((
    (tmpvar_5 * tmpvar_4)
   * 
    (flareSettings.z * sunGlareScale)
  ) + 0.5)).xyz);
  vec2 tmpvar_6;
  tmpvar_6.y = 1.0;
  tmpvar_6.x = (aspectRatio * spikesSettings.y);
  sunColor_3 = (sunColor_3 + (spikesSettings.x * texture2D (sunSpikes, (
    ((tmpvar_5 * tmpvar_6) * (spikesSettings.z * sunGlareScale))
   + 0.5)).xyz));
  vec2 tmpvar_7;
  tmpvar_7 = (sunViewPortPos.xy - 0.5);
  vec2 tmpvar_8;
  tmpvar_8.y = 1.0;
  tmpvar_8.x = (aspectRatio * ghost1Settings1[1].x);
  ghosts_2 = (ghost1Settings1[0].x * texture2D (sunGhost1, ((
    ((tmpvar_5 + (tmpvar_7 * ghost1Settings1[3].x)) * tmpvar_8)
   * ghost1Settings1[2].x) + 0.5)).xyz);
  vec2 tmpvar_9;
  tmpvar_9.y = 1.0;
  tmpvar_9.x = (aspectRatio * ghost1Settings2[1].x);
  ghosts_2 = (ghosts_2 + (ghost1Settings2[0].x * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings2[3].x)) * tmpvar_9) * ghost1Settings2[2].x)
   + 0.5)).xyz));
  vec2 tmpvar_10;
  tmpvar_10.y = 1.0;
  tmpvar_10.x = (aspectRatio * ghost1Settings1[1].y);
  ghosts_2 = (ghosts_2 + (ghost1Settings1[0].y * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings1[3].y)) * tmpvar_10) * ghost1Settings1[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_11;
  tmpvar_11.y = 1.0;
  tmpvar_11.x = (aspectRatio * ghost1Settings2[1].y);
  ghosts_2 = (ghosts_2 + (ghost1Settings2[0].y * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings2[3].y)) * tmpvar_11) * ghost1Settings2[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_12;
  tmpvar_12.y = 1.0;
  tmpvar_12.x = (aspectRatio * ghost1Settings1[1].z);
  ghosts_2 = (ghosts_2 + (ghost1Settings1[0].z * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings1[3].z)) * tmpvar_12) * ghost1Settings1[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  tmpvar_13.x = (aspectRatio * ghost1Settings2[1].z);
  ghosts_2 = (ghosts_2 + (ghost1Settings2[0].z * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings2[3].z)) * tmpvar_13) * ghost1Settings2[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = (aspectRatio * ghost1Settings1[1].w);
  ghosts_2 = (ghosts_2 + (ghost1Settings1[0].w * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings1[3].w)) * tmpvar_14) * ghost1Settings1[2].w)
   + 0.5)).xyz));
  vec2 tmpvar_15;
  tmpvar_15.y = 1.0;
  tmpvar_15.x = (aspectRatio * ghost1Settings2[1].w);
  ghosts_2 = (ghosts_2 + (ghost1Settings2[0].w * texture2D (sunGhost1, (
    (((tmpvar_5 + (tmpvar_7 * ghost1Settings2[3].w)) * tmpvar_15) * ghost1Settings2[2].w)
   + 0.5)).xyz));
  vec2 tmpvar_16;
  tmpvar_16.y = 1.0;
  tmpvar_16.x = (aspectRatio * ghost2Settings1[1].x);
  ghosts_2 = (ghosts_2 + (ghost2Settings1[0].x * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings1[3].x)) * tmpvar_16) * ghost2Settings1[2].x)
   + 0.5)).xyz));
  vec2 tmpvar_17;
  tmpvar_17.y = 1.0;
  tmpvar_17.x = (aspectRatio * ghost2Settings2[1].x);
  ghosts_2 = (ghosts_2 + (ghost2Settings2[0].x * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings2[3].x)) * tmpvar_17) * ghost2Settings2[2].x)
   + 0.5)).xyz));
  vec2 tmpvar_18;
  tmpvar_18.y = 1.0;
  tmpvar_18.x = (aspectRatio * ghost2Settings1[1].y);
  ghosts_2 = (ghosts_2 + (ghost2Settings1[0].y * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings1[3].y)) * tmpvar_18) * ghost2Settings1[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_19;
  tmpvar_19.y = 1.0;
  tmpvar_19.x = (aspectRatio * ghost2Settings2[1].y);
  ghosts_2 = (ghosts_2 + (ghost2Settings2[0].y * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings2[3].y)) * tmpvar_19) * ghost2Settings2[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = (aspectRatio * ghost2Settings1[1].z);
  ghosts_2 = (ghosts_2 + (ghost2Settings1[0].z * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings1[3].z)) * tmpvar_20) * ghost2Settings1[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_21;
  tmpvar_21.y = 1.0;
  tmpvar_21.x = (aspectRatio * ghost2Settings2[1].z);
  ghosts_2 = (ghosts_2 + (ghost2Settings2[0].z * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings2[3].z)) * tmpvar_21) * ghost2Settings2[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_22;
  tmpvar_22.y = 1.0;
  tmpvar_22.x = (aspectRatio * ghost2Settings1[1].w);
  ghosts_2 = (ghosts_2 + (ghost2Settings1[0].w * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings1[3].w)) * tmpvar_22) * ghost2Settings1[2].w)
   + 0.5)).xyz));
  vec2 tmpvar_23;
  tmpvar_23.y = 1.0;
  tmpvar_23.x = (aspectRatio * ghost2Settings2[1].w);
  ghosts_2 = (ghosts_2 + (ghost2Settings2[0].w * texture2D (sunGhost2, (
    (((tmpvar_5 + (tmpvar_7 * ghost2Settings2[3].w)) * tmpvar_23) * ghost2Settings2[2].w)
   + 0.5)).xyz));
  vec2 tmpvar_24;
  tmpvar_24.y = 1.0;
  tmpvar_24.x = (aspectRatio * ghost3Settings1[1].x);
  ghosts_2 = (ghosts_2 + (ghost3Settings1[0].x * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings1[3].x)) * tmpvar_24) * ghost3Settings1[2].x)
   + 0.5)).xyz));
  vec2 tmpvar_25;
  tmpvar_25.y = 1.0;
  tmpvar_25.x = (aspectRatio * ghost3Settings2[1].x);
  ghosts_2 = (ghosts_2 + (ghost3Settings2[0].x * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings2[3].x)) * tmpvar_25) * ghost3Settings2[2].x)
   + 0.5)).xyz));
  vec2 tmpvar_26;
  tmpvar_26.y = 1.0;
  tmpvar_26.x = (aspectRatio * ghost3Settings1[1].y);
  ghosts_2 = (ghosts_2 + (ghost3Settings1[0].y * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings1[3].y)) * tmpvar_26) * ghost3Settings1[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_27;
  tmpvar_27.y = 1.0;
  tmpvar_27.x = (aspectRatio * ghost3Settings2[1].y);
  ghosts_2 = (ghosts_2 + (ghost3Settings2[0].y * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings2[3].y)) * tmpvar_27) * ghost3Settings2[2].y)
   + 0.5)).xyz));
  vec2 tmpvar_28;
  tmpvar_28.y = 1.0;
  tmpvar_28.x = (aspectRatio * ghost3Settings1[1].z);
  ghosts_2 = (ghosts_2 + (ghost3Settings1[0].z * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings1[3].z)) * tmpvar_28) * ghost3Settings1[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_29;
  tmpvar_29.y = 1.0;
  tmpvar_29.x = (aspectRatio * ghost3Settings2[1].z);
  ghosts_2 = (ghosts_2 + (ghost3Settings2[0].z * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings2[3].z)) * tmpvar_29) * ghost3Settings2[2].z)
   + 0.5)).xyz));
  vec2 tmpvar_30;
  tmpvar_30.y = 1.0;
  tmpvar_30.x = (aspectRatio * ghost3Settings1[1].w);
  ghosts_2 = (ghosts_2 + (ghost3Settings1[0].w * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings1[3].w)) * tmpvar_30) * ghost3Settings1[2].w)
   + 0.5)).xyz));
  vec2 tmpvar_31;
  tmpvar_31.y = 1.0;
  tmpvar_31.x = (aspectRatio * ghost3Settings2[1].w);
  ghosts_2 = (ghosts_2 + (ghost3Settings2[0].w * texture2D (sunGhost3, (
    (((tmpvar_5 + (tmpvar_7 * ghost3Settings2[3].w)) * tmpvar_31) * ghost3Settings2[2].w)
   + 0.5)).xyz));
  float tmpvar_32;
  tmpvar_32 = clamp ((1.0 - sqrt(
    dot (tmpvar_7, tmpvar_7)
  )), 0.0, 1.0);
  ghosts_2 = (ghosts_2 * (tmpvar_32 * (tmpvar_32 * 
    (3.0 - (2.0 * tmpvar_32))
  )));
  sunColor_3 = (sunColor_3 + ghosts_2);
  vec4 tmpvar_33;
  tmpvar_33 = texture2D (_customDepthTexture, sunViewPortPos.xy);
  if ((tmpvar_33.x < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    float mu_34;
    float rMu_35;
    float r_36;
    float tmpvar_37;
    tmpvar_37 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_36 = tmpvar_37;
    float tmpvar_38;
    tmpvar_38 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    rMu_35 = tmpvar_38;
    mu_34 = (tmpvar_38 / tmpvar_37);
    float f_39;
    f_39 = (((tmpvar_38 * tmpvar_38) - (tmpvar_37 * tmpvar_37)) + (Rt * Rt));
    float tmpvar_40;
    if ((f_39 >= 0.0)) {
      tmpvar_40 = sqrt(f_39);
    } else {
      tmpvar_40 = 1e-06;
    };
    float tmpvar_41;
    tmpvar_41 = max ((-(tmpvar_38) - tmpvar_40), 0.0);
    if ((tmpvar_41 > 0.0)) {
      rMu_35 = (tmpvar_38 + tmpvar_41);
      mu_34 = (rMu_35 / Rt);
      r_36 = Rt;
    };
    vec3 tmpvar_42;
    if ((r_36 > Rt)) {
      tmpvar_42 = vec3(1.0, 1.0, 1.0);
    } else {
      float y_over_x_43;
      y_over_x_43 = (((mu_34 + 0.15) / 1.15) * 14.10142);
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
      vec2 tmpvar_46;
      tmpvar_46.x = ((tmpvar_45 * sign(y_over_x_43)) / 1.5);
      tmpvar_46.y = sqrt(((r_36 - Rg) / (Rt - Rg)));
      tmpvar_42 = texture2D (_Sky_Transmittance, tmpvar_46).xyz;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_3 = (sunColor_3 * tmpvar_42);
    };
    sunColor_3 = (sunColor_3 * sunGlareFade);
    vec4 tmpvar_47;
    tmpvar_47.w = 1.0;
    tmpvar_47.xyz = sunColor_3;
    tmpvar_1 = tmpvar_47;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 2 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"vs_3_0
def c0, 1, 0, 0, 0
dcl_position v0
dcl_texcoord v1
dcl_position o0
dcl_texcoord o1.xy
mad o0, v0.xyxx, c0.xxyy, c0.yyxx
mov o1.xy, v1

"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"vs_4_0
root12:aaaaaaaa
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
// Stats: 302 math, 28 textures, 5 branches
"!!GLES
#version 100

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
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0 - sunViewPortPos.xy);
  P_7 = (((tmpvar_8 * tmpvar_5) * (flareSettings.z * sunGlareScale)) + 0.5);
  tmpvar_6 = texture2D (sunFlare, P_7);
  sunColor_4 = (flareSettings.x * tmpvar_6.xyz);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 1.0;
  tmpvar_9.x = (aspectRatio * spikesSettings.y);
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (((tmpvar_8 * tmpvar_9) * (spikesSettings.z * sunGlareScale)) + 0.5);
  tmpvar_10 = texture2D (sunSpikes, P_11);
  sunColor_4 = (sunColor_4 + (spikesSettings.x * tmpvar_10.xyz));
  highp vec2 tmpvar_12;
  tmpvar_12 = (sunViewPortPos.xy - 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.y = 1.0;
  tmpvar_13.x = (aspectRatio * ghost1Settings1[1].x);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings1[3].x))
   * tmpvar_13) * ghost1Settings1[2].x) + 0.5);
  tmpvar_14 = texture2D (sunGhost1, P_15);
  ghosts_3 = (ghost1Settings1[0].x * tmpvar_14.xyz);
  highp vec2 tmpvar_16;
  tmpvar_16.y = 1.0;
  tmpvar_16.x = (aspectRatio * ghost1Settings2[1].x);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings2[3].x))
   * tmpvar_16) * ghost1Settings2[2].x) + 0.5);
  tmpvar_17 = texture2D (sunGhost1, P_18);
  ghosts_3 = (ghosts_3 + (ghost1Settings2[0].x * tmpvar_17.xyz));
  highp vec2 tmpvar_19;
  tmpvar_19.y = 1.0;
  tmpvar_19.x = (aspectRatio * ghost1Settings1[1].y);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings1[3].y))
   * tmpvar_19) * ghost1Settings1[2].y) + 0.5);
  tmpvar_20 = texture2D (sunGhost1, P_21);
  ghosts_3 = (ghosts_3 + (ghost1Settings1[0].y * tmpvar_20.xyz));
  highp vec2 tmpvar_22;
  tmpvar_22.y = 1.0;
  tmpvar_22.x = (aspectRatio * ghost1Settings2[1].y);
  lowp vec4 tmpvar_23;
  highp vec2 P_24;
  P_24 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings2[3].y))
   * tmpvar_22) * ghost1Settings2[2].y) + 0.5);
  tmpvar_23 = texture2D (sunGhost1, P_24);
  ghosts_3 = (ghosts_3 + (ghost1Settings2[0].y * tmpvar_23.xyz));
  highp vec2 tmpvar_25;
  tmpvar_25.y = 1.0;
  tmpvar_25.x = (aspectRatio * ghost1Settings1[1].z);
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings1[3].z))
   * tmpvar_25) * ghost1Settings1[2].z) + 0.5);
  tmpvar_26 = texture2D (sunGhost1, P_27);
  ghosts_3 = (ghosts_3 + (ghost1Settings1[0].z * tmpvar_26.xyz));
  highp vec2 tmpvar_28;
  tmpvar_28.y = 1.0;
  tmpvar_28.x = (aspectRatio * ghost1Settings2[1].z);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings2[3].z))
   * tmpvar_28) * ghost1Settings2[2].z) + 0.5);
  tmpvar_29 = texture2D (sunGhost1, P_30);
  ghosts_3 = (ghosts_3 + (ghost1Settings2[0].z * tmpvar_29.xyz));
  highp vec2 tmpvar_31;
  tmpvar_31.y = 1.0;
  tmpvar_31.x = (aspectRatio * ghost1Settings1[1].w);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings1[3].w))
   * tmpvar_31) * ghost1Settings1[2].w) + 0.5);
  tmpvar_32 = texture2D (sunGhost1, P_33);
  ghosts_3 = (ghosts_3 + (ghost1Settings1[0].w * tmpvar_32.xyz));
  highp vec2 tmpvar_34;
  tmpvar_34.y = 1.0;
  tmpvar_34.x = (aspectRatio * ghost1Settings2[1].w);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (((
    (tmpvar_8 + (tmpvar_12 * ghost1Settings2[3].w))
   * tmpvar_34) * ghost1Settings2[2].w) + 0.5);
  tmpvar_35 = texture2D (sunGhost1, P_36);
  ghosts_3 = (ghosts_3 + (ghost1Settings2[0].w * tmpvar_35.xyz));
  highp vec2 tmpvar_37;
  tmpvar_37.y = 1.0;
  tmpvar_37.x = (aspectRatio * ghost2Settings1[1].x);
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  P_39 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings1[3].x))
   * tmpvar_37) * ghost2Settings1[2].x) + 0.5);
  tmpvar_38 = texture2D (sunGhost2, P_39);
  ghosts_3 = (ghosts_3 + (ghost2Settings1[0].x * tmpvar_38.xyz));
  highp vec2 tmpvar_40;
  tmpvar_40.y = 1.0;
  tmpvar_40.x = (aspectRatio * ghost2Settings2[1].x);
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings2[3].x))
   * tmpvar_40) * ghost2Settings2[2].x) + 0.5);
  tmpvar_41 = texture2D (sunGhost2, P_42);
  ghosts_3 = (ghosts_3 + (ghost2Settings2[0].x * tmpvar_41.xyz));
  highp vec2 tmpvar_43;
  tmpvar_43.y = 1.0;
  tmpvar_43.x = (aspectRatio * ghost2Settings1[1].y);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings1[3].y))
   * tmpvar_43) * ghost2Settings1[2].y) + 0.5);
  tmpvar_44 = texture2D (sunGhost2, P_45);
  ghosts_3 = (ghosts_3 + (ghost2Settings1[0].y * tmpvar_44.xyz));
  highp vec2 tmpvar_46;
  tmpvar_46.y = 1.0;
  tmpvar_46.x = (aspectRatio * ghost2Settings2[1].y);
  lowp vec4 tmpvar_47;
  highp vec2 P_48;
  P_48 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings2[3].y))
   * tmpvar_46) * ghost2Settings2[2].y) + 0.5);
  tmpvar_47 = texture2D (sunGhost2, P_48);
  ghosts_3 = (ghosts_3 + (ghost2Settings2[0].y * tmpvar_47.xyz));
  highp vec2 tmpvar_49;
  tmpvar_49.y = 1.0;
  tmpvar_49.x = (aspectRatio * ghost2Settings1[1].z);
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings1[3].z))
   * tmpvar_49) * ghost2Settings1[2].z) + 0.5);
  tmpvar_50 = texture2D (sunGhost2, P_51);
  ghosts_3 = (ghosts_3 + (ghost2Settings1[0].z * tmpvar_50.xyz));
  highp vec2 tmpvar_52;
  tmpvar_52.y = 1.0;
  tmpvar_52.x = (aspectRatio * ghost2Settings2[1].z);
  lowp vec4 tmpvar_53;
  highp vec2 P_54;
  P_54 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings2[3].z))
   * tmpvar_52) * ghost2Settings2[2].z) + 0.5);
  tmpvar_53 = texture2D (sunGhost2, P_54);
  ghosts_3 = (ghosts_3 + (ghost2Settings2[0].z * tmpvar_53.xyz));
  highp vec2 tmpvar_55;
  tmpvar_55.y = 1.0;
  tmpvar_55.x = (aspectRatio * ghost2Settings1[1].w);
  lowp vec4 tmpvar_56;
  highp vec2 P_57;
  P_57 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings1[3].w))
   * tmpvar_55) * ghost2Settings1[2].w) + 0.5);
  tmpvar_56 = texture2D (sunGhost2, P_57);
  ghosts_3 = (ghosts_3 + (ghost2Settings1[0].w * tmpvar_56.xyz));
  highp vec2 tmpvar_58;
  tmpvar_58.y = 1.0;
  tmpvar_58.x = (aspectRatio * ghost2Settings2[1].w);
  lowp vec4 tmpvar_59;
  highp vec2 P_60;
  P_60 = (((
    (tmpvar_8 + (tmpvar_12 * ghost2Settings2[3].w))
   * tmpvar_58) * ghost2Settings2[2].w) + 0.5);
  tmpvar_59 = texture2D (sunGhost2, P_60);
  ghosts_3 = (ghosts_3 + (ghost2Settings2[0].w * tmpvar_59.xyz));
  highp vec2 tmpvar_61;
  tmpvar_61.y = 1.0;
  tmpvar_61.x = (aspectRatio * ghost3Settings1[1].x);
  lowp vec4 tmpvar_62;
  highp vec2 P_63;
  P_63 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings1[3].x))
   * tmpvar_61) * ghost3Settings1[2].x) + 0.5);
  tmpvar_62 = texture2D (sunGhost3, P_63);
  ghosts_3 = (ghosts_3 + (ghost3Settings1[0].x * tmpvar_62.xyz));
  highp vec2 tmpvar_64;
  tmpvar_64.y = 1.0;
  tmpvar_64.x = (aspectRatio * ghost3Settings2[1].x);
  lowp vec4 tmpvar_65;
  highp vec2 P_66;
  P_66 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings2[3].x))
   * tmpvar_64) * ghost3Settings2[2].x) + 0.5);
  tmpvar_65 = texture2D (sunGhost3, P_66);
  ghosts_3 = (ghosts_3 + (ghost3Settings2[0].x * tmpvar_65.xyz));
  highp vec2 tmpvar_67;
  tmpvar_67.y = 1.0;
  tmpvar_67.x = (aspectRatio * ghost3Settings1[1].y);
  lowp vec4 tmpvar_68;
  highp vec2 P_69;
  P_69 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings1[3].y))
   * tmpvar_67) * ghost3Settings1[2].y) + 0.5);
  tmpvar_68 = texture2D (sunGhost3, P_69);
  ghosts_3 = (ghosts_3 + (ghost3Settings1[0].y * tmpvar_68.xyz));
  highp vec2 tmpvar_70;
  tmpvar_70.y = 1.0;
  tmpvar_70.x = (aspectRatio * ghost3Settings2[1].y);
  lowp vec4 tmpvar_71;
  highp vec2 P_72;
  P_72 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings2[3].y))
   * tmpvar_70) * ghost3Settings2[2].y) + 0.5);
  tmpvar_71 = texture2D (sunGhost3, P_72);
  ghosts_3 = (ghosts_3 + (ghost3Settings2[0].y * tmpvar_71.xyz));
  highp vec2 tmpvar_73;
  tmpvar_73.y = 1.0;
  tmpvar_73.x = (aspectRatio * ghost3Settings1[1].z);
  lowp vec4 tmpvar_74;
  highp vec2 P_75;
  P_75 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings1[3].z))
   * tmpvar_73) * ghost3Settings1[2].z) + 0.5);
  tmpvar_74 = texture2D (sunGhost3, P_75);
  ghosts_3 = (ghosts_3 + (ghost3Settings1[0].z * tmpvar_74.xyz));
  highp vec2 tmpvar_76;
  tmpvar_76.y = 1.0;
  tmpvar_76.x = (aspectRatio * ghost3Settings2[1].z);
  lowp vec4 tmpvar_77;
  highp vec2 P_78;
  P_78 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings2[3].z))
   * tmpvar_76) * ghost3Settings2[2].z) + 0.5);
  tmpvar_77 = texture2D (sunGhost3, P_78);
  ghosts_3 = (ghosts_3 + (ghost3Settings2[0].z * tmpvar_77.xyz));
  highp vec2 tmpvar_79;
  tmpvar_79.y = 1.0;
  tmpvar_79.x = (aspectRatio * ghost3Settings1[1].w);
  lowp vec4 tmpvar_80;
  highp vec2 P_81;
  P_81 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings1[3].w))
   * tmpvar_79) * ghost3Settings1[2].w) + 0.5);
  tmpvar_80 = texture2D (sunGhost3, P_81);
  ghosts_3 = (ghosts_3 + (ghost3Settings1[0].w * tmpvar_80.xyz));
  highp vec2 tmpvar_82;
  tmpvar_82.y = 1.0;
  tmpvar_82.x = (aspectRatio * ghost3Settings2[1].w);
  lowp vec4 tmpvar_83;
  highp vec2 P_84;
  P_84 = (((
    (tmpvar_8 + (tmpvar_12 * ghost3Settings2[3].w))
   * tmpvar_82) * ghost3Settings2[2].w) + 0.5);
  tmpvar_83 = texture2D (sunGhost3, P_84);
  ghosts_3 = (ghosts_3 + (ghost3Settings2[0].w * tmpvar_83.xyz));
  highp float tmpvar_85;
  tmpvar_85 = clamp ((1.0 - sqrt(
    dot (tmpvar_12, tmpvar_12)
  )), 0.0, 1.0);
  ghosts_3 = (ghosts_3 * (tmpvar_85 * (tmpvar_85 * 
    (3.0 - (2.0 * tmpvar_85))
  )));
  sunColor_4 = (sunColor_4 + ghosts_3);
  lowp float tmpvar_86;
  tmpvar_86 = texture2D (_customDepthTexture, sunViewPortPos.xy).x;
  depth_2 = tmpvar_86;
  if ((depth_2 < 1.0)) {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 0.0);
  } else {
    highp float mu_87;
    highp float rMu_88;
    highp float r_89;
    highp float tmpvar_90;
    tmpvar_90 = sqrt(dot (_Globals_WorldCameraPos, _Globals_WorldCameraPos));
    r_89 = tmpvar_90;
    highp float tmpvar_91;
    tmpvar_91 = dot (_Globals_WorldCameraPos, _Sun_WorldSunDir);
    rMu_88 = tmpvar_91;
    mu_87 = (tmpvar_91 / tmpvar_90);
    highp float f_92;
    f_92 = (((tmpvar_91 * tmpvar_91) - (tmpvar_90 * tmpvar_90)) + (Rt * Rt));
    highp float tmpvar_93;
    if ((f_92 >= 0.0)) {
      tmpvar_93 = sqrt(f_92);
    } else {
      tmpvar_93 = 1e-06;
    };
    highp float tmpvar_94;
    tmpvar_94 = max ((-(tmpvar_91) - tmpvar_93), 0.0);
    if ((tmpvar_94 > 0.0)) {
      rMu_88 = (tmpvar_91 + tmpvar_94);
      mu_87 = (rMu_88 / Rt);
      r_89 = Rt;
    };
    highp vec3 tmpvar_95;
    if ((r_89 > Rt)) {
      tmpvar_95 = vec3(1.0, 1.0, 1.0);
    } else {
      highp vec3 tmpvar_96;
      highp float y_over_x_97;
      y_over_x_97 = (((mu_87 + 0.15) / 1.15) * 14.10142);
      highp float tmpvar_98;
      tmpvar_98 = (min (abs(y_over_x_97), 1.0) / max (abs(y_over_x_97), 1.0));
      highp float tmpvar_99;
      tmpvar_99 = (tmpvar_98 * tmpvar_98);
      tmpvar_99 = (((
        ((((
          ((((-0.01213232 * tmpvar_99) + 0.05368138) * tmpvar_99) - 0.1173503)
         * tmpvar_99) + 0.1938925) * tmpvar_99) - 0.3326756)
       * tmpvar_99) + 0.9999793) * tmpvar_98);
      tmpvar_99 = (tmpvar_99 + (float(
        (abs(y_over_x_97) > 1.0)
      ) * (
        (tmpvar_99 * -2.0)
       + 1.570796)));
      highp vec2 tmpvar_100;
      tmpvar_100.x = ((tmpvar_99 * sign(y_over_x_97)) / 1.5);
      tmpvar_100.y = sqrt(((r_89 - Rg) / (Rt - Rg)));
      lowp vec4 tmpvar_101;
      tmpvar_101 = texture2D (_Sky_Transmittance, tmpvar_100);
      tmpvar_96 = tmpvar_101.xyz;
      tmpvar_95 = tmpvar_96;
    };
    if ((useTransmittance > 0.0)) {
      sunColor_4 = (sunColor_4 * tmpvar_95);
    };
    sunColor_4 = (sunColor_4 * sunGlareFade);
    highp vec4 tmpvar_102;
    tmpvar_102.w = 1.0;
    tmpvar_102.xyz = sunColor_4;
    tmpvar_1 = tmpvar_102;
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
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float sunGlareScale;
uniform 	float sunGlareFade;
uniform 	vec3 flareSettings;
uniform 	vec3 spikesSettings;
uniform 	mat4 ghost1Settings1;
uniform 	mat4 ghost1Settings2;
uniform 	mat4 ghost2Settings1;
uniform 	mat4 ghost2Settings2;
uniform 	mat4 ghost3Settings1;
uniform 	mat4 ghost3Settings2;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float useTransmittance;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec3 sunViewPortPos;
uniform 	float aspectRatio;
uniform lowp sampler2D sunFlare;
uniform lowp sampler2D sunSpikes;
uniform lowp sampler2D sunGhost1;
uniform lowp sampler2D sunGhost2;
uniform lowp sampler2D sunGhost3;
uniform lowp sampler2D _customDepthTexture;
uniform lowp sampler2D _Sky_Transmittance;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
highp vec4 t0;
lowp vec3 t10_0;
bool tb0;
highp vec4 t1;
lowp vec3 t10_1;
bool tb1;
highp vec2 t2;
lowp vec3 t10_2;
highp vec4 t3;
lowp vec3 t10_3;
highp vec4 t4;
lowp vec3 t10_4;
highp vec4 t5;
lowp vec3 t10_5;
highp vec4 t6;
lowp vec3 t10_6;
highp vec4 t7;
lowp vec3 t10_7;
highp vec4 t8;
highp float t10;
highp float t19;
highp vec2 t20;
bool tb20;
highp float t27;
bool tb27;
highp float t28;
bool tb28;
void main()
{
    t10_0.x = texture(_customDepthTexture, sunViewPortPos.xyzx.xy).x;
    tb0 = t10_0.x<1.0;
    if(tb0){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t0 = vs_TEXCOORD0.xyxy + (-sunViewPortPos.xyzx.xyxy);
    t1.x = flareSettings.xxyz.z * aspectRatio;
    t1.yw = vec2(1.0, 1.0);
    t1.xy = vec2(t0.z * t1.x, t0.w * t1.y);
    t1.xy = t1.xy * vec2(flareSettings.z, flareSettings.z);
    t1.xy = t1.xy * vec2(vec2(sunGlareScale, sunGlareScale)) + vec2(0.5, 0.5);
    t10_2.xyz = texture(sunFlare, t1.xy).xyz;
    t1.z = spikesSettings.xyzx.y * aspectRatio;
    t1.xy = vec2(t0.z * t1.z, t0.w * t1.w);
    t1.xy = t1.xy * spikesSettings.xyzx.zz;
    t1.xy = t1.xy * vec2(vec2(sunGlareScale, sunGlareScale)) + vec2(0.5, 0.5);
    t10_1.xyz = texture(sunSpikes, t1.xy).xyz;
    t1.xyz = t10_1.xyz * spikesSettings.xyzx.xxx;
    t1.xyz = flareSettings.xxyz.yyy * t10_2.xyz + t1.xyz;
    t2.xy = sunViewPortPos.xyzx.xy + vec2(-0.5, -0.5);
    t3 = t2.xyxy * ghost1Settings1[3].xxyy + t0.zwzw;
    t4 = ghost1Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t5.x = t4.x;
    t5.yw = vec2(1.0, 1.0);
    t20.xy = t3.xy * t5.xy;
    t20.xy = t20.xy * ghost1Settings1[2].xx + vec2(0.5, 0.5);
    t10_6.xyz = texture(sunGhost1, t20.xy).xyz;
    t7 = t2.xyxy * ghost1Settings2[3].xxyy + t0.zwzw;
    t8 = ghost1Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t5.z = t8.x;
    t20.xy = vec2(t5.z * t7.x, t5.w * t7.y);
    t20.xy = t20.xy * ghost1Settings2[2].xx + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost1, t20.xy).xyz;
    t5.xyz = t10_5.xyz * ghost1Settings2[0].xxx;
    t5.xyz = ghost1Settings1[0].xxx * t10_6.xyz + t5.xyz;
    t6.x = t4.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = vec2(t3.z * t6.x, t3.w * t6.y);
    t20.xy = t20.xy * ghost1Settings1[2].yy + vec2(0.5, 0.5);
    t10_3.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings1[0].yyy * t10_3.xyz + t5.xyz;
    t6.z = t8.y;
    t20.xy = vec2(t6.z * t7.z, t6.w * t7.w);
    t20.xy = t20.xy * ghost1Settings2[2].yy + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings2[0].yyy * t10_5.xyz + t3.xyz;
    t5 = t2.xyxy * ghost1Settings1[3].zzww + t0.zwzw;
    t6.x = t4.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t5.xy * t6.xy;
    t20.xy = t20.xy * ghost1Settings1[2].zz + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings1[0].zzz * t10_4.xyz + t3.xyz;
    t7 = t2.xyxy * ghost1Settings2[3].zzww + t0.zwzw;
    t6.z = t8.w;
    t20.xy = vec2(t6.z * t7.x, t6.w * t7.y);
    t20.xy = t20.xy * ghost1Settings2[2].zz + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings2[0].zzz * t10_4.xyz + t3.xyz;
    t8.x = t4.w;
    t8.yw = vec2(1.0, 1.0);
    t20.xy = vec2(t5.z * t8.x, t5.w * t8.y);
    t20.xy = t20.xy * ghost1Settings1[2].ww + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings1[0].www * t10_4.xyz + t3.xyz;
    t20.xy = vec2(t7.z * t8.z, t7.w * t8.w);
    t20.xy = t20.xy * ghost1Settings2[2].ww + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost1, t20.xy).xyz;
    t3.xyz = ghost1Settings2[0].www * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost2Settings1[3].xxyy + t0.zwzw;
    t5 = ghost2Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.x = t5.x;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost2Settings1[2].xx + vec2(0.5, 0.5);
    t10_7.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings1[0].xxx * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost2Settings2[3].xxyy + t0.zwzw;
    t8 = ghost2Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.z = t8.x;
    t20.xy = vec2(t6.z * t7.x, t6.w * t7.y);
    t20.xy = t20.xy * ghost2Settings2[2].xx + vec2(0.5, 0.5);
    t10_6.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings2[0].xxx * t10_6.xyz + t3.xyz;
    t6.x = t5.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = vec2(t4.z * t6.x, t4.w * t6.y);
    t20.xy = t20.xy * ghost2Settings1[2].yy + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings1[0].yyy * t10_4.xyz + t3.xyz;
    t6.z = t8.y;
    t20.xy = vec2(t6.z * t7.z, t6.w * t7.w);
    t20.xy = t20.xy * ghost2Settings2[2].yy + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings2[0].yyy * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost2Settings1[3].zzww + t0.zwzw;
    t6.x = t5.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost2Settings1[2].zz + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings1[0].zzz * t10_5.xyz + t3.xyz;
    t7 = t2.xyxy * ghost2Settings2[3].zzww + t0.zwzw;
    t6.z = t8.w;
    t20.xy = vec2(t6.z * t7.x, t6.w * t7.y);
    t20.xy = t20.xy * ghost2Settings2[2].zz + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings2[0].zzz * t10_5.xyz + t3.xyz;
    t8.x = t5.w;
    t8.yw = vec2(1.0, 1.0);
    t20.xy = vec2(t4.z * t8.x, t4.w * t8.y);
    t20.xy = t20.xy * ghost2Settings1[2].ww + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings1[0].www * t10_4.xyz + t3.xyz;
    t20.xy = vec2(t7.z * t8.z, t7.w * t8.w);
    t20.xy = t20.xy * ghost2Settings2[2].ww + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost2, t20.xy).xyz;
    t3.xyz = ghost2Settings2[0].www * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost3Settings1[3].xxyy + t0.zwzw;
    t5 = ghost3Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.x = t5.x;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost3Settings1[2].xx + vec2(0.5, 0.5);
    t10_7.xyz = texture(sunGhost3, t20.xy).xyz;
    t3.xyz = ghost3Settings1[0].xxx * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost3Settings2[3].xxyy + t0.zwzw;
    t8 = ghost3Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.z = t8.x;
    t20.xy = vec2(t6.z * t7.x, t6.w * t7.y);
    t20.xy = t20.xy * ghost3Settings2[2].xx + vec2(0.5, 0.5);
    t10_6.xyz = texture(sunGhost3, t20.xy).xyz;
    t3.xyz = ghost3Settings2[0].xxx * t10_6.xyz + t3.xyz;
    t6.x = t5.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = vec2(t4.z * t6.x, t4.w * t6.y);
    t20.xy = t20.xy * ghost3Settings1[2].yy + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost3, t20.xy).xyz;
    t3.xyz = ghost3Settings1[0].yyy * t10_4.xyz + t3.xyz;
    t6.z = t8.y;
    t20.xy = vec2(t6.z * t7.z, t6.w * t7.w);
    t20.xy = t20.xy * ghost3Settings2[2].yy + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost3, t20.xy).xyz;
    t3.xyz = ghost3Settings2[0].yyy * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost3Settings1[3].zzww + t0.zwzw;
    t6.x = t5.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost3Settings1[2].zz + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost3, t20.xy).xyz;
    t3.xyz = ghost3Settings1[0].zzz * t10_5.xyz + t3.xyz;
    t0 = t2.xyxy * ghost3Settings2[3].zzww + t0;
    t6.z = t8.w;
    t0.xy = vec2(t6.z * t0.x, t6.w * t0.y);
    t0.xy = t0.xy * ghost3Settings2[2].zz + vec2(0.5, 0.5);
    t10_5.xyz = texture(sunGhost3, t0.xy).xyz;
    t3.xyz = ghost3Settings2[0].zzz * t10_5.xyz + t3.xyz;
    t8.x = t5.w;
    t8.yw = vec2(1.0, 1.0);
    t0.xy = vec2(t4.z * t8.x, t4.w * t8.y);
    t0.xy = t0.xy * ghost3Settings1[2].ww + vec2(0.5, 0.5);
    t10_4.xyz = texture(sunGhost3, t0.xy).xyz;
    t3.xyz = ghost3Settings1[0].www * t10_4.xyz + t3.xyz;
    t0.xy = vec2(t0.z * t8.z, t0.w * t8.w);
    t0.xy = t0.xy * ghost3Settings2[2].ww + vec2(0.5, 0.5);
    t10_0.xyz = texture(sunGhost3, t0.xy).xyz;
    t0.xyz = ghost3Settings2[0].www * t10_0.xyz + t3.xyz;
    t27 = dot(t2.xy, t2.xy);
    t27 = sqrt(t27);
    t27 = (-t27) + 1.0;
    t27 = max(t27, 0.0);
    t28 = t27 * -2.0 + 3.0;
    t27 = t27 * t27;
    t27 = t27 * t28;
    t0.xyz = t0.xyz * vec3(t27) + t1.xyz;
    t27 = dot(_Globals_WorldCameraPos.xyzx.xyz, _Globals_WorldCameraPos.xyzx.xyz);
    t1.x = sqrt(t27);
    t19 = dot(_Globals_WorldCameraPos.xyzx.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.y = t19 / t1.x;
    t27 = t19 * t19 + (-t27);
    t27 = Rt * Rt + t27;
    tb28 = t27>=0.0;
    t27 = sqrt(t27);
    t27 = (tb28) ? (-t27) : -9.99999997e-007;
    t27 = t27 + (-t19);
    t27 = max(t27, 0.0);
    tb28 = 0.0<t27;
    t27 = t27 + t19;
    t2.y = t27 / Rt;
    t2.x = Rt;
    t1.xy = (bool(tb28)) ? t2.xy : t1.xy;
    tb27 = Rt<t1.x;
    t1.x = t1.x + (-Rg);
    t19 = (-Rg) + Rt;
    t1.x = t1.x / t19;
    t2.y = sqrt(t1.x);
    t1.x = t1.y + 0.150000006;
    t1.x = t1.x * 12.262105;
    t10 = min(abs(t1.x), 1.0);
    t19 = max(abs(t1.x), 1.0);
    t19 = float(1.0) / t19;
    t10 = t19 * t10;
    t19 = t10 * t10;
    t28 = t19 * 0.0208350997 + -0.0851330012;
    t28 = t19 * t28 + 0.180141002;
    t28 = t19 * t28 + -0.330299497;
    t19 = t19 * t28 + 0.999866009;
    t28 = t19 * t10;
    tb20 = 1.0<abs(t1.x);
    t28 = t28 * -2.0 + 1.57079637;
    t28 = tb20 ? t28 : float(0.0);
    t10 = t10 * t19 + t28;
    t1.x = min(t1.x, 1.0);
    tb1 = t1.x<(-t1.x);
    t1.x = (tb1) ? (-t10) : t10;
    t2.x = t1.x * 0.666666687;
    t10_1.xyz = texture(_Sky_Transmittance, t2.xy).xyz;
    t1.xyz = (bool(tb27)) ? vec3(1.0, 1.0, 1.0) : t10_1.xyz;
    tb27 = 0.0<useTransmittance;
    t1.xyz = t0.xyz * t1.xyz;
    t0.xyz = (bool(tb27)) ? t1.xyz : t0.xyz;
    SV_Target0.xyz = t0.xyz * vec3(sunGlareFade);
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
in  vec4 in_POSITION0;
in  vec4 in_TEXCOORD0;
out vec2 vs_TEXCOORD0;
void main()
{
    gl_Position.xy = in_POSITION0.xy;
    gl_Position.zw = vec2(1.0, 1.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	vec3 _Globals_Origin;
uniform 	float sunGlareScale;
uniform 	float sunGlareFade;
uniform 	vec3 flareSettings;
uniform 	vec3 spikesSettings;
uniform 	mat4 ghost1Settings1;
uniform 	mat4 ghost1Settings2;
uniform 	mat4 ghost2Settings1;
uniform 	mat4 ghost2Settings2;
uniform 	mat4 ghost3Settings1;
uniform 	mat4 ghost3Settings2;
uniform 	float Rg;
uniform 	float Rt;
uniform 	float useTransmittance;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec3 sunViewPortPos;
uniform 	float aspectRatio;
uniform  sampler2D sunFlare;
uniform  sampler2D sunSpikes;
uniform  sampler2D sunGhost1;
uniform  sampler2D sunGhost2;
uniform  sampler2D sunGhost3;
uniform  sampler2D _customDepthTexture;
uniform  sampler2D _Sky_Transmittance;
in  vec2 vs_TEXCOORD0;
out vec4 SV_Target0;
vec4 t0;
lowp vec4 t10_0;
bool tb0;
vec4 t1;
lowp vec4 t10_1;
bool tb1;
vec2 t2;
lowp vec4 t10_2;
vec4 t3;
lowp vec4 t10_3;
vec4 t4;
lowp vec4 t10_4;
vec4 t5;
lowp vec4 t10_5;
vec4 t6;
lowp vec4 t10_6;
vec4 t7;
lowp vec4 t10_7;
vec4 t8;
float t10;
float t19;
vec2 t20;
bool tb20;
float t27;
bool tb27;
float t28;
bool tb28;
void main()
{
    t10_0 = texture(_customDepthTexture, sunViewPortPos.xyzx.xy);
    tb0 = t10_0.x<1.0;
    if(tb0){
        SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    //ENDIF
    }
    t0 = vs_TEXCOORD0.xyxy + (-sunViewPortPos.xyzx.xyxy);
    t1.x = flareSettings.xxyz.z * aspectRatio;
    t1.yw = vec2(1.0, 1.0);
    t1.xy = t0.zw * t1.xy;
    t1.xy = t1.xy * vec2(flareSettings.z, flareSettings.z);
    t1.xy = t1.xy * vec2(vec2(sunGlareScale, sunGlareScale)) + vec2(0.5, 0.5);
    t10_2 = texture(sunFlare, t1.xy);
    t1.z = spikesSettings.xyzx.y * aspectRatio;
    t1.xy = t0.zw * t1.zw;
    t1.xy = t1.xy * spikesSettings.xyzx.zz;
    t1.xy = t1.xy * vec2(vec2(sunGlareScale, sunGlareScale)) + vec2(0.5, 0.5);
    t10_1 = texture(sunSpikes, t1.xy);
    t1.xyz = t10_1.xyz * spikesSettings.xyzx.xxx;
    t1.xyz = flareSettings.xxyz.yyy * t10_2.xyz + t1.xyz;
    t2.xy = sunViewPortPos.xyzx.xy + vec2(-0.5, -0.5);
    t3 = t2.xyxy * ghost1Settings1[3].xxyy + t0.zwzw;
    t4 = ghost1Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t5.x = t4.x;
    t5.yw = vec2(1.0, 1.0);
    t20.xy = t3.xy * t5.xy;
    t20.xy = t20.xy * ghost1Settings1[2].xx + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost1, t20.xy);
    t7 = t2.xyxy * ghost1Settings2[3].xxyy + t0.zwzw;
    t8 = ghost1Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t5.z = t8.x;
    t20.xy = t5.zw * t7.xy;
    t20.xy = t20.xy * ghost1Settings2[2].xx + vec2(0.5, 0.5);
    t10_5 = texture(sunGhost1, t20.xy);
    t5.xyz = t10_5.xyz * ghost1Settings2[0].xxx;
    t5.xyz = ghost1Settings1[0].xxx * t10_6.xyz + t5.xyz;
    t6.x = t4.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t3.zw * t6.xy;
    t20.xy = t20.xy * ghost1Settings1[2].yy + vec2(0.5, 0.5);
    t10_3 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings1[0].yyy * t10_3.xyz + t5.xyz;
    t6.z = t8.y;
    t20.xy = t6.zw * t7.zw;
    t20.xy = t20.xy * ghost1Settings2[2].yy + vec2(0.5, 0.5);
    t10_5 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings2[0].yyy * t10_5.xyz + t3.xyz;
    t5 = t2.xyxy * ghost1Settings1[3].zzww + t0.zwzw;
    t6.x = t4.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t5.xy * t6.xy;
    t20.xy = t20.xy * ghost1Settings1[2].zz + vec2(0.5, 0.5);
    t10_7 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings1[0].zzz * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost1Settings2[3].zzww + t0.zwzw;
    t6.z = t8.w;
    t20.xy = t6.zw * t7.xy;
    t20.xy = t20.xy * ghost1Settings2[2].zz + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings2[0].zzz * t10_6.xyz + t3.xyz;
    t8.x = t4.w;
    t8.yw = vec2(1.0, 1.0);
    t20.xy = t5.zw * t8.xy;
    t20.xy = t20.xy * ghost1Settings1[2].ww + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings1[0].www * t10_4.xyz + t3.xyz;
    t20.xy = t7.zw * t8.zw;
    t20.xy = t20.xy * ghost1Settings2[2].ww + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost1, t20.xy);
    t3.xyz = ghost1Settings2[0].www * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost2Settings1[3].xxyy + t0.zwzw;
    t5 = ghost2Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.x = t5.x;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost2Settings1[2].xx + vec2(0.5, 0.5);
    t10_7 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings1[0].xxx * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost2Settings2[3].xxyy + t0.zwzw;
    t8 = ghost2Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.z = t8.x;
    t20.xy = t6.zw * t7.xy;
    t20.xy = t20.xy * ghost2Settings2[2].xx + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings2[0].xxx * t10_6.xyz + t3.xyz;
    t6.x = t5.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.zw * t6.xy;
    t20.xy = t20.xy * ghost2Settings1[2].yy + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings1[0].yyy * t10_4.xyz + t3.xyz;
    t6.z = t8.y;
    t20.xy = t6.zw * t7.zw;
    t20.xy = t20.xy * ghost2Settings2[2].yy + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings2[0].yyy * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost2Settings1[3].zzww + t0.zwzw;
    t6.x = t5.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost2Settings1[2].zz + vec2(0.5, 0.5);
    t10_7 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings1[0].zzz * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost2Settings2[3].zzww + t0.zwzw;
    t6.z = t8.w;
    t20.xy = t6.zw * t7.xy;
    t20.xy = t20.xy * ghost2Settings2[2].zz + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings2[0].zzz * t10_6.xyz + t3.xyz;
    t8.x = t5.w;
    t8.yw = vec2(1.0, 1.0);
    t20.xy = t4.zw * t8.xy;
    t20.xy = t20.xy * ghost2Settings1[2].ww + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings1[0].www * t10_4.xyz + t3.xyz;
    t20.xy = t7.zw * t8.zw;
    t20.xy = t20.xy * ghost2Settings2[2].ww + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost2, t20.xy);
    t3.xyz = ghost2Settings2[0].www * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost3Settings1[3].xxyy + t0.zwzw;
    t5 = ghost3Settings1[1] * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.x = t5.x;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost3Settings1[2].xx + vec2(0.5, 0.5);
    t10_7 = texture(sunGhost3, t20.xy);
    t3.xyz = ghost3Settings1[0].xxx * t10_7.xyz + t3.xyz;
    t7 = t2.xyxy * ghost3Settings2[3].xxyy + t0.zwzw;
    t8 = ghost3Settings2[1].xywz * vec4(vec4(aspectRatio, aspectRatio, aspectRatio, aspectRatio));
    t6.z = t8.x;
    t20.xy = t6.zw * t7.xy;
    t20.xy = t20.xy * ghost3Settings2[2].xx + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost3, t20.xy);
    t3.xyz = ghost3Settings2[0].xxx * t10_6.xyz + t3.xyz;
    t6.x = t5.y;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.zw * t6.xy;
    t20.xy = t20.xy * ghost3Settings1[2].yy + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost3, t20.xy);
    t3.xyz = ghost3Settings1[0].yyy * t10_4.xyz + t3.xyz;
    t6.z = t8.y;
    t20.xy = t6.zw * t7.zw;
    t20.xy = t20.xy * ghost3Settings2[2].yy + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost3, t20.xy);
    t3.xyz = ghost3Settings2[0].yyy * t10_4.xyz + t3.xyz;
    t4 = t2.xyxy * ghost3Settings1[3].zzww + t0.zwzw;
    t6.x = t5.z;
    t6.yw = vec2(1.0, 1.0);
    t20.xy = t4.xy * t6.xy;
    t20.xy = t20.xy * ghost3Settings1[2].zz + vec2(0.5, 0.5);
    t10_7 = texture(sunGhost3, t20.xy);
    t3.xyz = ghost3Settings1[0].zzz * t10_7.xyz + t3.xyz;
    t0 = t2.xyxy * ghost3Settings2[3].zzww + t0;
    t6.z = t8.w;
    t0.xy = t6.zw * t0.xy;
    t0.xy = t0.xy * ghost3Settings2[2].zz + vec2(0.5, 0.5);
    t10_6 = texture(sunGhost3, t0.xy);
    t3.xyz = ghost3Settings2[0].zzz * t10_6.xyz + t3.xyz;
    t8.x = t5.w;
    t8.yw = vec2(1.0, 1.0);
    t0.xy = t4.zw * t8.xy;
    t0.xy = t0.xy * ghost3Settings1[2].ww + vec2(0.5, 0.5);
    t10_4 = texture(sunGhost3, t0.xy);
    t3.xyz = ghost3Settings1[0].www * t10_4.xyz + t3.xyz;
    t0.xy = t0.zw * t8.zw;
    t0.xy = t0.xy * ghost3Settings2[2].ww + vec2(0.5, 0.5);
    t10_0 = texture(sunGhost3, t0.xy);
    t0.xyz = ghost3Settings2[0].www * t10_0.xyz + t3.xyz;
    t27 = dot(t2.xy, t2.xy);
    t27 = sqrt(t27);
    t27 = (-t27) + 1.0;
    t27 = max(t27, 0.0);
    t28 = t27 * -2.0 + 3.0;
    t27 = t27 * t27;
    t27 = t27 * t28;
    t0.xyz = t0.xyz * vec3(t27) + t1.xyz;
    t27 = dot(_Globals_WorldCameraPos.xyzx.xyz, _Globals_WorldCameraPos.xyzx.xyz);
    t1.x = sqrt(t27);
    t19 = dot(_Globals_WorldCameraPos.xyzx.xyz, _Sun_WorldSunDir.xyzx.xyz);
    t1.y = t19 / t1.x;
    t27 = t19 * t19 + (-t27);
    t27 = Rt * Rt + t27;
    tb28 = t27>=0.0;
    t27 = sqrt(t27);
    t27 = (tb28) ? (-t27) : -9.99999997e-007;
    t27 = t27 + (-t19);
    t27 = max(t27, 0.0);
    tb28 = 0.0<t27;
    t27 = t27 + t19;
    t2.y = t27 / Rt;
    t2.x = Rt;
    t1.xy = (bool(tb28)) ? t2.xy : t1.xy;
    tb27 = Rt<t1.x;
    t1.x = t1.x + (-Rg);
    t19 = (-Rg) + Rt;
    t1.x = t1.x / t19;
    t2.y = sqrt(t1.x);
    t1.x = t1.y + 0.150000006;
    t1.x = t1.x * 12.262105;
    t10 = min(abs(t1.x), 1.0);
    t19 = max(abs(t1.x), 1.0);
    t19 = float(1.0) / t19;
    t10 = t19 * t10;
    t19 = t10 * t10;
    t28 = t19 * 0.0208350997 + -0.0851330012;
    t28 = t19 * t28 + 0.180141002;
    t28 = t19 * t28 + -0.330299497;
    t19 = t19 * t28 + 0.999866009;
    t28 = t19 * t10;
    tb20 = 1.0<abs(t1.x);
    t28 = t28 * -2.0 + 1.57079637;
    t28 = tb20 ? t28 : float(0.0);
    t10 = t10 * t19 + t28;
    t1.x = min(t1.x, 1.0);
    tb1 = t1.x<(-t1.x);
    t1.x = (tb1) ? (-t10) : t10;
    t2.x = t1.x * 0.666666687;
    t10_1 = texture(_Sky_Transmittance, t2.xy);
    t1.xyz = (bool(tb27)) ? vec3(1.0, 1.0, 1.0) : t10_1.xyz;
    tb27 = 0.0<useTransmittance;
    t1.xyz = t0.xyz * t1.xyz;
    t0.xyz = (bool(tb27)) ? t1.xyz : t0.xyz;
    SV_Target0.xyz = t0.xyz * vec3(sunGlareFade);
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
// Stats: 213 math, 28 textures
Matrix 0 [ghost1Settings1]
Matrix 4 [ghost1Settings2]
Matrix 8 [ghost2Settings1]
Matrix 12 [ghost2Settings2]
Matrix 16 [ghost3Settings1]
Matrix 20 [ghost3Settings2]
Float 29 [Rg]
Float 30 [Rt]
Vector 24 [_Globals_WorldCameraPos]
Vector 32 [_Sun_WorldSunDir]
Float 34 [aspectRatio]
Vector 27 [flareSettings]
Vector 28 [spikesSettings]
Float 26 [sunGlareFade]
Float 25 [sunGlareScale]
Vector 33 [sunViewPortPos]
Float 31 [useTransmittance]
SetTexture 0 [sunSpikes] 2D 0
SetTexture 1 [sunFlare] 2D 1
SetTexture 2 [sunGhost1] 2D 2
SetTexture 3 [sunGhost2] 2D 3
SetTexture 4 [sunGhost3] 2D 4
SetTexture 5 [_customDepthTexture] 2D 5
SetTexture 6 [_Sky_Transmittance] 2D 6
"ps_3_0
def c35, 1, 0.5, -0.5, 0
def c36, -2, 3, -9.99999997e-007, 0.150000006
def c37, 12.262105, 0.0208350997, -0.0851330012, 0.180141002
def c38, -0.330299497, 0.999866009, -2, 1.57079637
def c39, 0.666666687, 0, 0, 0
dcl_texcoord v0.xy
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
texld r0, c33, s5
add r0.x, r0.x, -c35.x
cmp oC0.w, r0.x, c35.x, c35.w
mov r1.x, c34.x
mul r2.z, r1.x, c4.y
mov r2.yw, c35.x
mov r0.yz, c35
add r0.zw, r0.z, c33.xyxy
add r1.yz, -c33.xxyw, v0.xxyw
mad r3.xy, r0.zwzw, c4.w, r1.yzzw
mul r2.zw, r2, r3.xyxy
mad r2.zw, r2, c4.z, r0.y
texld r3, r2.zwzw, s2
mul r3.xyz, r3, c4.x
mul r2.x, r1.x, c0.y
mad r2.zw, r0, c0.w, r1.xyyz
mul r2.xy, r2, r2.zwzw
mad r2.xy, r2, c0.z, r0.y
texld r2, r2, s2
mad r2.xyz, c0.x, r2, r3
mul r3.x, r1.x, c1.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c1.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c1.z, r0.y
texld r4, r3, s2
mad r2.xyz, c1.x, r4, r2
mul r3.z, r1.x, c5.y
mad r3.xy, r0.zwzw, c5.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c5.z, r0.y
texld r3, r3, s2
mad r2.xyz, c5.x, r3, r2
mul r3.x, r1.x, c2.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c2.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c2.z, r0.y
texld r4, r3, s2
mad r2.xyz, c2.x, r4, r2
mul r3.z, r1.x, c6.y
mad r3.xy, r0.zwzw, c6.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c6.z, r0.y
texld r3, r3, s2
mad r2.xyz, c6.x, r3, r2
mul r3.x, r1.x, c3.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c3.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c3.z, r0.y
texld r4, r3, s2
mad r2.xyz, c3.x, r4, r2
mul r3.z, r1.x, c7.y
mad r3.xy, r0.zwzw, c7.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c7.z, r0.y
texld r3, r3, s2
mad r2.xyz, c7.x, r3, r2
mul r3.x, r1.x, c8.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c8.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c8.z, r0.y
texld r4, r3, s3
mad r2.xyz, c8.x, r4, r2
mul r3.z, r1.x, c12.y
mad r3.xy, r0.zwzw, c12.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c12.z, r0.y
texld r3, r3, s3
mad r2.xyz, c12.x, r3, r2
mul r3.x, r1.x, c9.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c9.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c9.z, r0.y
texld r4, r3, s3
mad r2.xyz, c9.x, r4, r2
mul r3.z, r1.x, c13.y
mad r3.xy, r0.zwzw, c13.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c13.z, r0.y
texld r3, r3, s3
mad r2.xyz, c13.x, r3, r2
mul r3.x, r1.x, c10.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c10.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c10.z, r0.y
texld r4, r3, s3
mad r2.xyz, c10.x, r4, r2
mul r3.z, r1.x, c14.y
mad r3.xy, r0.zwzw, c14.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c14.z, r0.y
texld r3, r3, s3
mad r2.xyz, c14.x, r3, r2
mul r3.x, r1.x, c11.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c11.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c11.z, r0.y
texld r4, r3, s3
mad r2.xyz, c11.x, r4, r2
mul r3.z, r1.x, c15.y
mad r3.xy, r0.zwzw, c15.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c15.z, r0.y
texld r3, r3, s3
mad r2.xyz, c15.x, r3, r2
mul r3.x, r1.x, c16.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c16.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c16.z, r0.y
texld r4, r3, s4
mad r2.xyz, c16.x, r4, r2
mul r3.z, r1.x, c20.y
mad r3.xy, r0.zwzw, c20.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c20.z, r0.y
texld r3, r3, s4
mad r2.xyz, c20.x, r3, r2
mul r3.x, r1.x, c17.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c17.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c17.z, r0.y
texld r4, r3, s4
mad r2.xyz, c17.x, r4, r2
mul r3.z, r1.x, c21.y
mad r3.xy, r0.zwzw, c21.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c21.z, r0.y
texld r3, r3, s4
mad r2.xyz, c21.x, r3, r2
mul r3.x, r1.x, c18.y
mov r3.yw, c35.x
mad r4.xy, r0.zwzw, c18.w, r1.yzzw
mul r3.xy, r3, r4
mad r3.xy, r3, c18.z, r0.y
texld r4, r3, s4
mad r2.xyz, c18.x, r4, r2
mul r3.z, r1.x, c22.y
mad r3.xy, r0.zwzw, c22.w, r1.yzzw
mul r3.xy, r3.zwzw, r3
mad r3.xy, r3, c22.z, r0.y
texld r3, r3, s4
mad r2.xyz, c22.x, r3, r2
mul r3.x, r1.x, c19.y
mad r4.xy, r0.zwzw, c19.w, r1.yzzw
mov r3.yw, c35.x
mul r3.xy, r3, r4
mad r3.xy, r3, c19.z, r0.y
texld r4, r3, s4
mad r2.xyz, c19.x, r4, r2
mad r3.xy, r0.zwzw, c23.w, r1.yzzw
dp2add r0.z, r0.zwzw, r0.zwzw, c35.w
rsq r0.z, r0.z
rcp r0.z, r0.z
add r0.z, -r0.z, c35.x
max r1.w, r0.z, c35.w
mul r3.z, r1.x, c23.y
mul r0.zw, r3, r3.xyxy
mad r0.zw, r0, c23.z, r0.y
texld r3, r0.zwzw, s4
mad r2.xyz, c23.x, r3, r2
mul r3.z, r1.x, c28.y
mov r3.yw, c35.x
mul r0.zw, r1.xyyz, r3
mul r0.zw, r0, c28.z
mad r0.zw, r0, c25.x, r0.y
texld r4, r0.zwzw, s0
mul r4.xyz, r4, c28.x
mul r3.x, r1.x, c27.y
mul r0.zw, r1.xyyz, r3.xyxy
mul r0.zw, r0, c27.z
mad r0.yz, r0.xzww, c25.x, r0.y
texld r3, r0.yzzw, s1
mad r0.yzw, c27.x, r3.xxyz, r4.xxyz
mad r1.x, r1.w, c36.x, c36.y
mul r1.y, r1.w, r1.w
mul r1.x, r1.y, r1.x
mad r0.yzw, r2.xxyz, r1.x, r0
dp3 r1.x, c24, c24
rsq r1.x, r1.x
rcp r2.x, r1.x
mul r1.y, r2.x, r2.x
mov r3.xyz, c24
dp3 r1.z, r3, c32
mad r1.y, r1.z, r1.z, -r1.y
mad r1.y, c30.x, c30.x, r1.y
rsq r1.w, r1.y
rcp r1.w, r1.w
cmp r1.y, r1.y, -r1.w, c36.z
add r1.y, r1.y, -r1.z
max r2.z, r1.y, c35.w
add r1.y, r1.z, r2.z
mul r2.y, r1.x, r1.z
rcp r1.x, c30.x
mul r1.y, r1.x, r1.y
mov r1.x, c30.x
cmp r1.xy, -r2.z, r2, r1
add r1.y, r1.y, c36.w
mul r1.y, r1.y, c37.x
add r1.z, r1_abs.y, -c35.x
rcp r1.w, r1_abs.y
cmp r1.z, r1.z, r1.w, c35.x
mov_sat r1.w, r1_abs.y
mul r1.z, r1.z, r1.w
mul r1.w, r1.z, r1.z
mad r2.x, r1.w, c37.y, c37.z
mad r2.x, r1.w, r2.x, c37.w
mad r2.x, r1.w, r2.x, c38.x
mad r1.w, r1.w, r2.x, c38.y
mul r1.z, r1.w, r1.z
mad r1.w, r1.z, c38.z, c38.w
add r2.x, -r1_abs.y, c35.x
min r2.y, r1.y, c35.x
cmp r1.y, r2.y, c35.w, c35.x
cmp r2.x, r2.x, c35.w, c35.x
mad r1.z, r1.w, r2.x, r1.z
add r1.w, r1.z, r1.z
mad r1.y, r1.y, -r1.w, r1.z
mul r2.x, r1.y, c39.x
add r1.y, r1.x, -c29.x
add r1.x, -r1.x, c30.x
mov r3.x, c30.x
add r1.z, r3.x, -c29.x
rcp r1.z, r1.z
mul r1.y, r1.z, r1.y
rsq r1.y, r1.y
rcp r2.y, r1.y
texld r2, r2, s6
cmp r1.xyz, r1.x, r2, c35.x
mul r1.xyz, r0.yzww, r1
cmp r0.yzw, -c31.x, r0, r1.xxyz
mul r0.yzw, r0, c26.x
cmp oC0.xyz, r0.x, r0.yzww, c35.w

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
ConstBuffer "$Globals" 592
Matrix 160 [ghost1Settings1]
Matrix 224 [ghost1Settings2]
Matrix 288 [ghost2Settings1]
Matrix 352 [ghost2Settings2]
Matrix 416 [ghost3Settings1]
Matrix 480 [ghost3Settings2]
Vector 96 [_Globals_WorldCameraPos] 3
Float 124 [sunGlareScale]
Float 128 [sunGlareFade]
Vector 132 [flareSettings] 3
Vector 144 [spikesSettings] 3
Float 544 [Rg]
Float 548 [Rt]
Float 552 [useTransmittance]
Vector 560 [_Sun_WorldSunDir] 3
Vector 576 [sunViewPortPos] 3
Float 588 [aspectRatio]
BindCB  "$Globals" 0
"ps_4_0
root12:ahabahaa
eefiecedengohelalghmcgmngjoikmhjebgfehbnabaaaaaamabpaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaabpaaaa
eaaaaaaamaahaaaafjaaaaaeegiocaaaaaaaaaaacfaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fkaaaaadaagabaaaagaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaae
aahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacajaaaaaaefaaaaak
pcaabaaaaaaaaaaaegiacaaaaaaaaaaaceaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadp
bpaaaeadakaabaaaaaaaaaaadgaaaaaipccabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaabbfaaaaabaaaaaaajpcaabaaaaaaaaaaa
egbebaaaabaaaaaaegiecaiaebaaaaaaaaaaaaaaceaaaaaadiaaaaajbcaabaaa
abaaaaaackiacaaaaaaaaaaaaiaaaaaadkiacaaaaaaaaaaaceaaaaaadgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaaaaaaaaaegaabaaaabaaaaaadiaaaaaidcaabaaa
abaaaaaaegaabaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaadcaaaaandcaabaaa
abaaaaaaegaabaaaabaaaaaapgipcaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadiaaaaajecaabaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaadkiacaaaaaaaaaaaceaaaaaadiaaaaahdcaabaaaabaaaaaa
ogakbaaaaaaaaaaaogakbaaaabaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaa
abaaaaaakgikcaaaaaaaaaaaajaaaaaadcaaaaandcaabaaaabaaaaaaegaabaaa
abaaaaaapgipcaaaaaaaaaaaahaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaadcaaaaakhcaabaaaabaaaaaafgifcaaaaaaaaaaaaiaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaaldcaabaaaacaaaaaaegiacaaa
aaaaaaaaceaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaaaaaaaaaaaadcaaaaak
pcaabaaaadaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaaanaaaaaaogaobaaa
aaaaaaaadiaaaaajpcaabaaaaeaaaaaaegiocaaaaaaaaaaaalaaaaaapgipcaaa
aaaaaaaaceaaaaaadgaaaaafbcaabaaaafaaaaaaakaabaaaaeaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaadaaaaaaagaebaaaafaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaaamaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaa
acaaaaaaagifcaaaaaaaaaaabbaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaa
aiaaaaaaegilcaaaaaaaaaaaapaaaaaapgipcaaaaaaaaaaaceaaaaaadgaaaaaf
ecaabaaaafaaaaaaakaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaa
afaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
agiacaaaaaaaaaaabaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaafaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaafaaaaaaagiacaaaaaaaaaaa
aoaaaaaadcaaaaakhcaabaaaafaaaaaaagiacaaaaaaaaaaaakaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaagaaaaaabkaabaaaaeaaaaaa
dgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadp
diaaaaahmcaabaaaacaaaaaakgaobaaaadaaaaaaagaebaaaagaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaaamaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaadaaaaaaogakbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
fgifcaaaaaaaaaaaakaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadgaaaaaf
ecaabaaaagaaaaaabkaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaa
agaaaaaakgaobaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
fgifcaaaaaaaaaaabaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaafaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaaaoaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaafaaaaaaegaebaaaacaaaaaa
kgipcaaaaaaaaaaaanaaaaaaogaobaaaaaaaaaaadgaaaaafbcaabaaaagaaaaaa
ckaabaaaaeaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaaafaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaa
amaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
ahaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaak
hcaabaaaadaaaaaakgikcaaaaaaaaaaaakaaaaaaegacbaaaahaaaaaaegacbaaa
adaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaa
bbaaaaaaogaobaaaaaaaaaaadgaaaaafecaabaaaagaaaaaadkaabaaaaiaaaaaa
diaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaabaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaakhcaabaaaadaaaaaa
kgikcaaaaaaaaaaaaoaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaaf
bcaabaaaaiaaaaaadkaabaaaaeaaaaaadgaaaaaikcaabaaaaiaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaa
afaaaaaaagaebaaaaiaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
pgipcaaaaaaaaaaaamaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaaakaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaahaaaaaa
kgaobaaaaiaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaa
aaaaaaaabaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaaj
pcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaaaoaaaaaaegacbaaaaeaaaaaa
egacbaaaadaaaaaadcaaaaakpcaabaaaaeaaaaaaegaebaaaacaaaaaaagifcaaa
aaaaaaaabfaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaaafaaaaaaegiocaaa
aaaaaaaabdaaaaaapgipcaaaaaaaaaaaceaaaaaadgaaaaafbcaabaaaagaaaaaa
akaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaa
beaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
ahaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaak
hcaabaaaadaaaaaaagiacaaaaaaaaaaabcaaaaaaegacbaaaahaaaaaaegacbaaa
adaaaaaadcaaaaakpcaabaaaahaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaa
bjaaaaaaogaobaaaaaaaaaaadiaaaaajpcaabaaaaiaaaaaaegilcaaaaaaaaaaa
bhaaaaaapgipcaaaaaaaaaaaceaaaaaadgaaaaafecaabaaaagaaaaaaakaabaaa
aiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaabiaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaagiacaaaaaaaaaaabgaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaa
dgaaaaafbcaabaaaagaaaaaabkaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaa
kgaobaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaa
acaaaaaafgifcaaaaaaaaaaabeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaabcaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaadgaaaaafecaabaaaagaaaaaabkaabaaa
aiaaaaaadiaaaaahmcaabaaaacaaaaaakgaobaaaagaaaaaakgaobaaaahaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaabiaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaafgifcaaaaaaaaaaabgaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
dcaaaaakpcaabaaaaeaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaabfaaaaaa
ogaobaaaaaaaaaaadgaaaaafbcaabaaaagaaaaaackaabaaaafaaaaaadgaaaaai
kcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaakgikcaaaaaaaaaaabeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaa
eghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaa
aaaaaaaabcaaaaaaegacbaaaahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaa
ahaaaaaaegaebaaaacaaaaaakgipcaaaaaaaaaaabjaaaaaaogaobaaaaaaaaaaa
dgaaaaafecaabaaaagaaaaaadkaabaaaaiaaaaaadiaaaaahmcaabaaaacaaaaaa
kgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaa
acaaaaaakgikcaaaaaaaaaaabiaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaaaaaaaaaabgaaaaaa
egacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaaiaaaaaadkaabaaa
afaaaaaadgaaaaaikcaabaaaaiaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaaaeaaaaaaagaebaaaaiaaaaaa
dcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaaaaaaaaaabeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaapgipcaaaaaaaaaaabcaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
diaaaaahmcaabaaaacaaaaaakgaobaaaahaaaaaakgaobaaaaiaaaaaadcaaaaan
mcaabaaaacaaaaaakgaobaaaacaaaaaapgipcaaaaaaaaaaabiaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
pgipcaaaaaaaaaaabgaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadcaaaaak
pcaabaaaaeaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaabnaaaaaaogaobaaa
aaaaaaaadiaaaaajpcaabaaaafaaaaaaegiocaaaaaaaaaaablaaaaaapgipcaaa
aaaaaaaaceaaaaaadgaaaaafbcaabaaaagaaaaaaakaabaaaafaaaaaadgaaaaai
kcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaah
mcaabaaaacaaaaaaagaebaaaaeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaa
acaaaaaakgaobaaaacaaaaaaagiacaaaaaaaaaaabmaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaa
eghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaa
aaaaaaaabkaaaaaaegacbaaaahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaa
ahaaaaaaegaebaaaacaaaaaaagifcaaaaaaaaaaacbaaaaaaogaobaaaaaaaaaaa
diaaaaajpcaabaaaaiaaaaaaegilcaaaaaaaaaaabpaaaaaapgipcaaaaaaaaaaa
ceaaaaaadgaaaaafecaabaaaagaaaaaaakaabaaaaiaaaaaadiaaaaahmcaabaaa
acaaaaaakgaobaaaagaaaaaaagaebaaaahaaaaaadcaaaaanmcaabaaaacaaaaaa
kgaobaaaacaaaaaaagiacaaaaaaaaaaacaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpefaaaaajpcaabaaaagaaaaaaogakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaa
boaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaagaaaaaa
bkaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaakgaobaaaaeaaaaaaagaebaaa
agaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaafgifcaaaaaaaaaaa
bmaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpefaaaaajpcaabaaa
aeaaaaaaogakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaak
hcaabaaaadaaaaaafgifcaaaaaaaaaaabkaaaaaaegacbaaaaeaaaaaaegacbaaa
adaaaaaadgaaaaafecaabaaaagaaaaaabkaabaaaaiaaaaaadiaaaaahmcaabaaa
acaaaaaakgaobaaaagaaaaaakgaobaaaahaaaaaadcaaaaanmcaabaaaacaaaaaa
kgaobaaaacaaaaaafgifcaaaaaaaaaaacaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpefaaaaajpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaafgifcaaaaaaaaaaa
boaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaaeaaaaaa
egaebaaaacaaaaaakgipcaaaaaaaaaaabnaaaaaaogaobaaaaaaaaaaadgaaaaaf
bcaabaaaagaaaaaackaabaaaafaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahmcaabaaaacaaaaaaagaebaaa
aeaaaaaaagaebaaaagaaaaaadcaaaaanmcaabaaaacaaaaaakgaobaaaacaaaaaa
kgikcaaaaaaaaaaabmaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadp
efaaaaajpcaabaaaahaaaaaaogakbaaaacaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadcaaaaakhcaabaaaadaaaaaakgikcaaaaaaaaaaabkaaaaaaegacbaaa
ahaaaaaaegacbaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaebaaaacaaaaaa
kgipcaaaaaaaaaaacbaaaaaaegaobaaaaaaaaaaadgaaaaafecaabaaaagaaaaaa
dkaabaaaaiaaaaaadiaaaaahdcaabaaaaaaaaaaaogakbaaaagaaaaaaegaabaaa
aaaaaaaadcaaaaandcaabaaaaaaaaaaaegaabaaaaaaaaaaakgikcaaaaaaaaaaa
caaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadcaaaaak
hcaabaaaadaaaaaakgikcaaaaaaaaaaaboaaaaaaegacbaaaagaaaaaaegacbaaa
adaaaaaadgaaaaafbcaabaaaaiaaaaaadkaabaaaafaaaaaadgaaaaaikcaabaaa
aiaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaahdcaabaaa
aaaaaaaaogakbaaaaeaaaaaaegaabaaaaiaaaaaadcaaaaandcaabaaaaaaaaaaa
egaabaaaaaaaaaaapgipcaaaaaaaaaaabmaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaaaaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadcaaaaakhcaabaaaadaaaaaapgipcaaaaaaaaaaa
bkaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaadiaaaaahdcaabaaaaaaaaaaa
ogakbaaaaaaaaaaaogakbaaaaiaaaaaadcaaaaandcaabaaaaaaaaaaaegaabaaa
aaaaaaaapgipcaaaaaaaaaaacaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadcaaaaakhcaabaaaaaaaaaaapgipcaaaaaaaaaaaboaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaaapaaaaahicaabaaaaaaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadcaaaaaj
icaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaamaabeaaaaaaaaaeaea
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaaj
icaabaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaaagaaaaaa
elaaaaafbcaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaajecaabaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaaegiccaaaaaaaaaaacdaaaaaaaoaaaaahccaabaaa
abaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
ckaabaaaabaaaaaackaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaal
icaabaaaaaaaaaaabkiacaaaaaaaaaaaccaaaaaabkiacaaaaaaaaaaaccaaaaaa
dkaabaaaaaaaaaaabnaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaakicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaalndhiglf
aaaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaiaebaaaaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadbaaaaah
icaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaaaoaaaaaiccaabaaaacaaaaaa
dkaabaaaaaaaaaaabkiacaaaaaaaaaaaccaaaaaadgaaaaagbcaabaaaacaaaaaa
bkiacaaaaaaaaaaaccaaaaaadhaaaaajdcaabaaaabaaaaaapgapbaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaabaaaaaadbaaaaaiicaabaaaaaaaaaaabkiacaaa
aaaaaaaaccaaaaaaakaabaaaabaaaaaaaaaaaaajbcaabaaaabaaaaaaakaabaaa
abaaaaaaakiacaiaebaaaaaaaaaaaaaaccaaaaaaaaaaaaakecaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaccaaaaaabkiacaaaaaaaaaaaccaaaaaaaoaaaaah
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
aaaaaaaaccaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadhaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaa
aaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
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