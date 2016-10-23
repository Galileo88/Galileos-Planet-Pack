// Compiled shader for custom platforms, uncompressed size: 304.2KB

Shader "Proland/Ocean/OceanWhiteCaps" {
SubShader { 
 Tags { "QUEUE"="Geometry+100" "RenderType"="" }


 // Stats for Vertex shader:
 //       d3d11 : 167 math, 2 branch
 //        d3d9 : 252 math, 16 texture, 2 branch
 //      opengl : 337 avg math (243..431), 13 avg texture (11..15), 8 avg branch (6..10)
 // Stats for Fragment shader:
 //       d3d11 : 249 avg math (191..308), 9 texture
 //        d3d9 : 313 avg math (239..388), 17 avg texture (13..21)
 Pass {
  Tags { "QUEUE"="Geometry+100" "RenderType"="" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 22813
Program "vp" {
SubProgram "opengl " {
// Stats: 243 math, 11 textures, 6 branches
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLSL#version 120

#ifdef VERTEX
uniform float _Ocean_Radius;
uniform float _Ocean_HeightOffset;
uniform vec3 _Ocean_CameraPos;
uniform mat4 _Ocean_OceanToCamera;
uniform mat4 _Ocean_CameraToOcean;
uniform vec3 sphereDir;
uniform float cosTheta;
uniform float sinTheta;
uniform mat4 _Globals_ScreenToCamera;
uniform mat4 _Globals_CameraToScreen;
uniform vec2 _Ocean_MapSize;
uniform vec4 _Ocean_Choppyness;
uniform vec4 _Ocean_GridSizes;
uniform vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 dP_1;
  vec4 vert_2;
  vert_2.zw = gl_Vertex.zw;
  vert_2.xy = (gl_Vertex.xy * 1.25);
  vec2 tmpvar_3;
  vec3 oceanDir_4;
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = vert_2.xy;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((_Globals_ScreenToCamera * tmpvar_5).xyz);
  vec3 tmpvar_7;
  tmpvar_7 = ((sphereDir.yzx * tmpvar_6.zxy) - (sphereDir.zxy * tmpvar_6.yzx));
  vec3 tmpvar_8;
  tmpvar_8 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_7.yzx * sphereDir.zxy) - (tmpvar_7.zxy * sphereDir.yzx))
  )));
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, ((tmpvar_8.yzx * tmpvar_6.zxy) - (tmpvar_8.zxy * tmpvar_6.yzx)));
  vec3 tmpvar_10;
  if (((tmpvar_9 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_10 = tmpvar_8;
  } else {
    tmpvar_10 = tmpvar_6;
  };
  vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10;
  oceanDir_4 = (_Ocean_CameraToOcean * tmpvar_11).xyz;
  float tmpvar_12;
  tmpvar_12 = (oceanDir_4.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (2.0 * _Ocean_Radius);
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (
    ((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_14)))
  , 0.0)));
  float tmpvar_15;
  tmpvar_15 = ((-(_Ocean_CameraPos.z) / oceanDir_4.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_14)
   * 
    (1.0 - (oceanDir_4.z * oceanDir_4.z))
  )));
  float tmpvar_16;
  tmpvar_16 = abs(((tmpvar_15 - tmpvar_13) * oceanDir_4.z));
  float tmpvar_17;
  if ((tmpvar_16 < 1.0)) {
    tmpvar_17 = tmpvar_15;
  } else {
    tmpvar_17 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_17 * oceanDir_4.xy));
  vec4 tmpvar_18;
  tmpvar_18.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_18.x = _Ocean_ScreenGridSize.x;
  vec3 oceanDir_19;
  vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 1.0);
  tmpvar_20.xy = (vert_2 + tmpvar_18).xy;
  vec3 tmpvar_21;
  tmpvar_21 = normalize((_Globals_ScreenToCamera * tmpvar_20).xyz);
  vec3 tmpvar_22;
  tmpvar_22 = ((sphereDir.yzx * tmpvar_21.zxy) - (sphereDir.zxy * tmpvar_21.yzx));
  vec3 tmpvar_23;
  tmpvar_23 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_22.yzx * sphereDir.zxy) - (tmpvar_22.zxy * sphereDir.yzx))
  )));
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_22, ((tmpvar_23.yzx * tmpvar_21.zxy) - (tmpvar_23.zxy * tmpvar_21.yzx)));
  vec3 tmpvar_25;
  if (((tmpvar_24 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_25 = tmpvar_23;
  } else {
    tmpvar_25 = tmpvar_21;
  };
  vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = tmpvar_25;
  oceanDir_19 = (_Ocean_CameraToOcean * tmpvar_26).xyz;
  float tmpvar_27;
  tmpvar_27 = (oceanDir_19.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (2.0 * _Ocean_Radius);
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (
    ((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_29)))
  , 0.0)));
  float tmpvar_30;
  tmpvar_30 = ((-(_Ocean_CameraPos.z) / oceanDir_19.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_29)
   * 
    (1.0 - (oceanDir_19.z * oceanDir_19.z))
  )));
  float tmpvar_31;
  tmpvar_31 = abs(((tmpvar_30 - tmpvar_28) * oceanDir_19.z));
  float tmpvar_32;
  if ((tmpvar_31 < 1.0)) {
    tmpvar_32 = tmpvar_30;
  } else {
    tmpvar_32 = tmpvar_28;
  };
  vec2 tmpvar_33;
  tmpvar_33 = ((_Ocean_CameraPos.xy + (tmpvar_32 * oceanDir_19.xy)) - tmpvar_3);
  vec4 tmpvar_34;
  tmpvar_34.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_34.y = _Ocean_ScreenGridSize.y;
  vec3 oceanDir_35;
  vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 1.0);
  tmpvar_36.xy = (vert_2 + tmpvar_34).xy;
  vec3 tmpvar_37;
  tmpvar_37 = normalize((_Globals_ScreenToCamera * tmpvar_36).xyz);
  vec3 tmpvar_38;
  tmpvar_38 = ((sphereDir.yzx * tmpvar_37.zxy) - (sphereDir.zxy * tmpvar_37.yzx));
  vec3 tmpvar_39;
  tmpvar_39 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_38.yzx * sphereDir.zxy) - (tmpvar_38.zxy * sphereDir.yzx))
  )));
  float tmpvar_40;
  tmpvar_40 = dot (tmpvar_38, ((tmpvar_39.yzx * tmpvar_37.zxy) - (tmpvar_39.zxy * tmpvar_37.yzx)));
  vec3 tmpvar_41;
  if (((tmpvar_40 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_41 = tmpvar_39;
  } else {
    tmpvar_41 = tmpvar_37;
  };
  vec4 tmpvar_42;
  tmpvar_42.w = 0.0;
  tmpvar_42.xyz = tmpvar_41;
  oceanDir_35 = (_Ocean_CameraToOcean * tmpvar_42).xyz;
  float tmpvar_43;
  tmpvar_43 = (oceanDir_35.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_44;
  float tmpvar_45;
  tmpvar_45 = (2.0 * _Ocean_Radius);
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (
    ((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_45)))
  , 0.0)));
  float tmpvar_46;
  tmpvar_46 = ((-(_Ocean_CameraPos.z) / oceanDir_35.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_45)
   * 
    (1.0 - (oceanDir_35.z * oceanDir_35.z))
  )));
  float tmpvar_47;
  tmpvar_47 = abs(((tmpvar_46 - tmpvar_44) * oceanDir_35.z));
  float tmpvar_48;
  if ((tmpvar_47 < 1.0)) {
    tmpvar_48 = tmpvar_46;
  } else {
    tmpvar_48 = tmpvar_44;
  };
  vec2 tmpvar_49;
  tmpvar_49 = ((_Ocean_CameraPos.xy + (tmpvar_48 * oceanDir_35.xy)) - tmpvar_3);
  vec3 tmpvar_50;
  tmpvar_50.xy = vec2(0.0, 0.0);
  tmpvar_50.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_50;
  if (((tmpvar_49.x != 0.0) || (tmpvar_49.y != 0.0))) {
    vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.x));
    vec2 tmpvar_52;
    tmpvar_52 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.x));
    vec4 tmpvar_53;
    tmpvar_53.z = 0.0;
    tmpvar_53.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_53.w = (0.5 * log2(max (
      dot (tmpvar_51, tmpvar_51)
    , 
      dot (tmpvar_52, tmpvar_52)
    )));
    dP_1.z = (_Ocean_HeightOffset + texture2DLod (_Ocean_Map0, tmpvar_53.xy, tmpvar_53.w).x);
    vec2 tmpvar_54;
    tmpvar_54 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.y));
    vec2 tmpvar_55;
    tmpvar_55 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.y));
    vec4 tmpvar_56;
    tmpvar_56.z = 0.0;
    tmpvar_56.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_56.w = (0.5 * log2(max (
      dot (tmpvar_54, tmpvar_54)
    , 
      dot (tmpvar_55, tmpvar_55)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_56.xy, tmpvar_56.w).y);
    vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.z));
    vec2 tmpvar_58;
    tmpvar_58 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.z));
    vec4 tmpvar_59;
    tmpvar_59.z = 0.0;
    tmpvar_59.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_59.w = (0.5 * log2(max (
      dot (tmpvar_57, tmpvar_57)
    , 
      dot (tmpvar_58, tmpvar_58)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_59.xy, tmpvar_59.w).z);
    vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.w));
    vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.w));
    vec4 tmpvar_62;
    tmpvar_62.z = 0.0;
    tmpvar_62.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_62.w = (0.5 * log2(max (
      dot (tmpvar_60, tmpvar_60)
    , 
      dot (tmpvar_61, tmpvar_61)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_62.xy, tmpvar_62.w).w);
    vec2 tmpvar_63;
    tmpvar_63 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.x));
    vec2 tmpvar_64;
    tmpvar_64 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.x));
    vec4 tmpvar_65;
    tmpvar_65.z = 0.0;
    tmpvar_65.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_65.w = (0.5 * log2(max (
      dot (tmpvar_63, tmpvar_63)
    , 
      dot (tmpvar_64, tmpvar_64)
    )));
    dP_1.xy = (_Ocean_Choppyness.x * texture2DLod (_Ocean_Map3, tmpvar_65.xy, tmpvar_65.w).xy);
    vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.y));
    vec2 tmpvar_67;
    tmpvar_67 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.y));
    vec4 tmpvar_68;
    tmpvar_68.z = 0.0;
    tmpvar_68.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_68.w = (0.5 * log2(max (
      dot (tmpvar_66, tmpvar_66)
    , 
      dot (tmpvar_67, tmpvar_67)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * texture2DLod (_Ocean_Map3, tmpvar_68.xy, tmpvar_68.w).zw));
    vec2 tmpvar_69;
    tmpvar_69 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.z));
    vec2 tmpvar_70;
    tmpvar_70 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.z));
    vec4 tmpvar_71;
    tmpvar_71.z = 0.0;
    tmpvar_71.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_71.w = (0.5 * log2(max (
      dot (tmpvar_69, tmpvar_69)
    , 
      dot (tmpvar_70, tmpvar_70)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * texture2DLod (_Ocean_Map4, tmpvar_71.xy, tmpvar_71.w).xy));
    vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.w));
    vec2 tmpvar_73;
    tmpvar_73 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.w));
    vec4 tmpvar_74;
    tmpvar_74.z = 0.0;
    tmpvar_74.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_74.w = (0.5 * log2(max (
      dot (tmpvar_72, tmpvar_72)
    , 
      dot (tmpvar_73, tmpvar_73)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * texture2DLod (_Ocean_Map4, tmpvar_74.xy, tmpvar_74.w).zw));
  };
  mat3 tmpvar_75;
  tmpvar_75[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_75[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_75[2] = _Ocean_OceanToCamera[2].xyz;
  vec4 tmpvar_76;
  tmpvar_76.w = 1.0;
  tmpvar_76.xyz = ((tmpvar_17 * tmpvar_10) + (tmpvar_75 * dP_1));
  vec3 tmpvar_77;
  tmpvar_77.xy = vec2(0.0, 0.0);
  tmpvar_77.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_76);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_17 * oceanDir_4) + dP_1) + tmpvar_77);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _Transmittance;
uniform sampler2D _Irradiance;
uniform float _Exposure;
uniform float Rg;
uniform float Rt;
uniform float _Sun_Intensity;
uniform float _Ocean_Radius;
uniform vec3 _Ocean_CameraPos;
uniform vec3 _Ocean_SunDir;
uniform vec3 _Ocean_Color;
uniform vec4 _Ocean_GridSizes;
uniform float _Ocean_WhiteCapStr;
uniform float farWhiteCapStr;
uniform sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform float _OceanAlpha;
uniform float _GlobalOceanAlpha;
uniform float alphaRadius;
uniform vec2 _VarianceMax;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 Lsky_1;
  vec2 slopes_2;
  vec3 tmpvar_3;
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_3.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  vec3 tmpvar_4;
  tmpvar_4.xy = vec2(0.0, 0.0);
  tmpvar_4.z = _Ocean_Radius;
  vec3 tmpvar_5;
  tmpvar_5 = (normalize((xlv_TEXCOORD1 + tmpvar_4)) * (_Ocean_Radius + 10.0));
  vec3 x_6;
  x_6 = (tmpvar_5 - tmpvar_3);
  float tmpvar_7;
  tmpvar_7 = clamp ((sqrt(
    dot (x_6, x_6)
  ) / alphaRadius), 0.0, 1.0);
  float tmpvar_8;
  tmpvar_8 = mix (_OceanAlpha, 1.0, tmpvar_7);
  float tmpvar_9;
  tmpvar_9 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_7);
  vec3 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.z = _Ocean_CameraPos.z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 - xlv_TEXCOORD1));
  slopes_2 = texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.x)).xy;
  slopes_2 = (slopes_2 + texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.y)).zw);
  slopes_2 = (slopes_2 + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.z)).xy);
  slopes_2 = (slopes_2 + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.w)).zw);
  slopes_2 = (slopes_2 - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  vec3 tmpvar_12;
  tmpvar_12.z = 1.0;
  tmpvar_12.xy = -(slopes_2);
  vec3 tmpvar_13;
  tmpvar_13 = normalize(tmpvar_12);
  float tmpvar_14;
  tmpvar_14 = dFdx(xlv_TEXCOORD0.x);
  float tmpvar_15;
  tmpvar_15 = dFdy(xlv_TEXCOORD0.x);
  float tmpvar_16;
  tmpvar_16 = dFdx(xlv_TEXCOORD0.y);
  float tmpvar_17;
  tmpvar_17 = dFdy(xlv_TEXCOORD0.y);
  float tmpvar_18;
  tmpvar_18 = ((tmpvar_14 * tmpvar_14) + (tmpvar_16 * tmpvar_16));
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_15 * tmpvar_15) + (tmpvar_17 * tmpvar_17));
  vec3 tmpvar_20;
  tmpvar_20.x = pow ((tmpvar_18 / 10.0), 0.25);
  tmpvar_20.y = (0.5 + ((0.5 * 
    ((tmpvar_14 * tmpvar_15) + (tmpvar_16 * tmpvar_17))
  ) / sqrt(
    (tmpvar_18 * tmpvar_19)
  )));
  tmpvar_20.z = pow ((tmpvar_19 / 10.0), 0.25);
  vec2 tmpvar_21;
  tmpvar_21 = max ((texture3D (_Ocean_Variance, tmpvar_20).xy * _VarianceMax), vec2(2e-05, 2e-05));
  vec3 worldP_22;
  worldP_22 = tmpvar_5;
  vec3 sunL_23;
  vec3 skyE_24;
  float r_25;
  float tmpvar_26;
  tmpvar_26 = sqrt(dot (tmpvar_5, tmpvar_5));
  r_25 = tmpvar_26;
  if ((tmpvar_26 < (0.9 * Rg))) {
    worldP_22.z = (tmpvar_5.z + Rg);
    r_25 = sqrt(dot (worldP_22, worldP_22));
  };
  vec3 tmpvar_27;
  tmpvar_27 = (worldP_22 / r_25);
  float tmpvar_28;
  tmpvar_28 = dot (tmpvar_27, _Ocean_SunDir);
  float tmpvar_29;
  tmpvar_29 = sqrt((1.0 - (
    (Rg / r_25)
   * 
    (Rg / r_25)
  )));
  vec3 tmpvar_30;
  if ((tmpvar_28 < -(tmpvar_29))) {
    tmpvar_30 = vec3(0.0, 0.0, 0.0);
  } else {
    float y_over_x_31;
    y_over_x_31 = (((tmpvar_28 + 0.15) / 1.15) * 14.10142);
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
    vec4 tmpvar_34;
    tmpvar_34.zw = vec2(0.0, 0.0);
    tmpvar_34.x = ((tmpvar_33 * sign(y_over_x_31)) / 1.5);
    tmpvar_34.y = sqrt(((r_25 - Rg) / (Rt - Rg)));
    tmpvar_30 = texture2DLod (_Transmittance, tmpvar_34.xy, 0.0).xyz;
  };
  sunL_23 = (tmpvar_30 * _Sun_Intensity);
  vec2 tmpvar_35;
  tmpvar_35.x = ((tmpvar_28 + 0.2) / 1.2);
  tmpvar_35.y = ((r_25 - Rg) / (Rt - Rg));
  skyE_24 = ((2.0 * (texture2DLod (_Irradiance, tmpvar_35, 0.0).xyz * _Sun_Intensity)) * ((1.0 + 
    dot (tmpvar_27, tmpvar_13)
  ) * 0.5));
  float tmpvar_36;
  tmpvar_36 = sqrt(tmpvar_21.x);
  Lsky_1 = (((
    pow ((1.0 - dot (tmpvar_11, tmpvar_13)), (5.0 * exp((-2.69 * tmpvar_36))))
   / 
    (1.0 + (22.7 * pow (tmpvar_36, 1.5)))
  ) * skyE_24) / 3.141593);
  vec3 tmpvar_37;
  tmpvar_37 = normalize((_Ocean_SunDir + tmpvar_11));
  float tmpvar_38;
  tmpvar_38 = dot (tmpvar_37, tmpvar_13);
  float tmpvar_39;
  tmpvar_39 = (exp((
    (-2.0 * ((1.0 - (tmpvar_38 * tmpvar_38)) / tmpvar_21.x))
   / 
    (1.0 + tmpvar_38)
  )) / (12.56637 * tmpvar_21.x));
  float tmpvar_40;
  tmpvar_40 = (1.0 - dot (tmpvar_11, tmpvar_37));
  float tmpvar_41;
  tmpvar_41 = (tmpvar_40 * tmpvar_40);
  float tmpvar_42;
  tmpvar_42 = (0.02 + ((0.98 * tmpvar_41) * (tmpvar_41 * tmpvar_40)));
  float tmpvar_43;
  tmpvar_43 = max (dot (_Ocean_SunDir, tmpvar_13), 0.01);
  float tmpvar_44;
  tmpvar_44 = max (dot (tmpvar_11, tmpvar_13), 0.01);
  float tmpvar_45;
  if ((tmpvar_43 <= 0.0)) {
    tmpvar_45 = 0.0;
  } else {
    tmpvar_45 = max (((tmpvar_42 * tmpvar_39) * sqrt(
      abs((tmpvar_43 / tmpvar_44))
    )), 0.0);
  };
  float tmpvar_46;
  tmpvar_46 = sqrt(tmpvar_21.x);
  vec4 tmpvar_47;
  tmpvar_47 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.x));
  vec4 tmpvar_48;
  tmpvar_48 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.y));
  vec4 tmpvar_49;
  tmpvar_49 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.z));
  vec4 tmpvar_50;
  tmpvar_50 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.w));
  vec2 tmpvar_51;
  tmpvar_51 = ((tmpvar_47.xy + tmpvar_48.zw) + (tmpvar_49.xy + tmpvar_50.zw));
  float x_52;
  x_52 = ((0.7071068 * (tmpvar_9 - tmpvar_51.x)) * inversesqrt(max (
    (tmpvar_51.y - (((
      (tmpvar_47.x * tmpvar_47.x)
     + 
      (tmpvar_48.z * tmpvar_48.z)
    ) + (tmpvar_49.x * tmpvar_49.x)) + (tmpvar_50.z * tmpvar_50.z)))
  , 0.0)));
  float tmpvar_53;
  tmpvar_53 = (x_52 * x_52);
  float tmpvar_54;
  tmpvar_54 = (0.140012 * tmpvar_53);
  vec3 L_55;
  L_55 = (((
    ((tmpvar_45 * sunL_23) + Lsky_1)
   + 
    ((((0.98 * 
      (1.0 - (pow ((1.0 - 
        dot (tmpvar_11, tmpvar_13)
      ), (5.0 * 
        exp((-2.69 * tmpvar_46))
      )) / (1.0 + (22.7 * 
        pow (tmpvar_46, 1.5)
      ))))
    ) * _Ocean_Color) * skyE_24) / 3.141593)
  ) + (
    (((0.5 * (
      sign(x_52)
     * 
      sqrt((1.0 - exp((
        (-(tmpvar_53) * (1.273239 + tmpvar_54))
       / 
        (1.0 + tmpvar_54)
      ))))
    )) + 0.5) * (((sunL_23 * 
      max (dot (tmpvar_13, _Ocean_SunDir), 0.0)
    ) + skyE_24) / 3.141593))
   * 0.4)) * _Exposure);
  float tmpvar_56;
  if ((L_55.x < 1.413)) {
    tmpvar_56 = pow ((L_55.x * 0.38317), 0.4545454);
  } else {
    tmpvar_56 = (1.0 - exp(-(L_55.x)));
  };
  L_55.x = tmpvar_56;
  float tmpvar_57;
  if ((L_55.y < 1.413)) {
    tmpvar_57 = pow ((L_55.y * 0.38317), 0.4545454);
  } else {
    tmpvar_57 = (1.0 - exp(-(L_55.y)));
  };
  L_55.y = tmpvar_57;
  float tmpvar_58;
  if ((L_55.z < 1.413)) {
    tmpvar_58 = pow ((L_55.z * 0.38317), 0.4545454);
  } else {
    tmpvar_58 = (1.0 - exp(-(L_55.z)));
  };
  L_55.z = tmpvar_58;
  vec4 tmpvar_59;
  tmpvar_59.xyz = L_55;
  tmpvar_59.w = (tmpvar_8 * _GlobalOceanAlpha);
  gl_FragData[0] = tmpvar_59;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 252 math, 16 textures, 2 branches
Keywords { "SKY_REFLECTIONS_OFF" }
Bind "vertex" Vertex
Matrix 0 [_Globals_CameraToScreen]
Matrix 10 [_Globals_ScreenToCamera] 3
Matrix 7 [_Ocean_CameraToOcean] 3
Matrix 4 [_Ocean_OceanToCamera] 3
Vector 15 [_Ocean_CameraPos]
Vector 20 [_Ocean_Choppyness]
Vector 21 [_Ocean_GridSizes]
Float 14 [_Ocean_HeightOffset]
Vector 19 [_Ocean_MapSize]
Float 13 [_Ocean_Radius]
Vector 22 [_Ocean_ScreenGridSize]
Float 17 [cosTheta]
Float 18 [sinTheta]
Vector 16 [sphereDir]
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
"vs_3_0
def c23, 1.25, 0, 1, 2
def c24, 0.5, 0, 0, 0
dcl_position v0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
mul r0.xy, c23.x, v0
mad r1.xyz, v0.xyxw, c23.xxyw, c23.yyzw
dp3 r2.x, c10.xyww, r1
dp3 r2.y, c11.xyww, r1
dp3 r2.z, c12.xyww, r1
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r1.xyz, r0.w, r2
mul r3.xyz, r1.yzxw, c16.zxyw
mad r3.xyz, c16.yzxw, r1.zxyw, -r3
mul r4.xyz, r3.zxyw, c16.yzxw
mad r4.xyz, r3.yzxw, c16.zxyw, -r4
nrm r5.xyz, r4
mov r4.xyz, c16
mul r4.xyz, r4, c17.x
mad r5.xyz, c18.x, r5, r4
mul r6.xyz, r1.yzxw, r5.zxyw
mad r6.xyz, r5.yzxw, r1.zxyw, -r6
dp3 r1.w, r3, r6
slt r1.w, c23.y, r1.w
mov r3, c23
slt r2.w, r3.y, c15.z
mul r1.w, r1.w, r2.w
mad r2.xyz, r2, -r0.w, r5
mad r1.xyz, r1.w, r2, r1
dp3 r2.x, c7, r1
dp3 r2.y, c8, r1
dp3 r2.z, c9, r1
mov r5.z, c15.z
add r0.w, r5.z, c13.x
mul r1.w, r0.w, r2.z
add r4.w, c13.x, c13.x
mad r3.w, c13.x, r3.w, r5.z
mul r3.w, r3.w, c15.z
mad r1.w, r1.w, r1.w, -r3.w
max r1.w, r1.w, c23.y
rsq r1.w, r1.w
rcp r1.w, r1.w
mad r1.w, r2.z, -r0.w, -r1.w
rcp r5.x, r2.z
mul r5.x, r5.x, -c15.z
rcp r4.w, r4.w
mul r4.w, r4.w, c15.z
mad r5.y, r2.z, -r2.z, c23.z
mad r5.y, r4.w, r5.y, c23.z
mad r5.x, r5.x, r5.y, -r1.w
mul r5.y, r2.z, r5.x
slt r5.y, r5_abs.y, c23.z
mad r1.w, r5.y, r5.x, r1.w
mad r5.xy, r1.w, r2, c15
mov r6.x, r0.x
mad r6.y, v0.y, r3.x, c22.y
mad r6.zw, v0.x, c23.xyxy, c23.xyyz
dp3 r7.x, c10.yxww, r6.yzww
dp3 r7.y, c11.xyww, r6.xyww
dp3 r7.z, c12.xyww, r6.xyww
dp3 r5.z, r7, r7
rsq r5.z, r5.z
mul r6.xyz, r5.z, r7
mul r8.xyz, r6.yzxw, c16.zxyw
mad r8.xyz, c16.yzxw, r6.zxyw, -r8
mul r9.xyz, r8.zxyw, c16.yzxw
mad r9.xyz, r8.yzxw, c16.zxyw, -r9
nrm r10.xyz, r9
mad r9.xyz, c18.x, r10, r4
mul r10.xyz, r6.yzxw, r9.zxyw
mad r10.xyz, r9.yzxw, r6.zxyw, -r10
dp3 r5.w, r8, r10
slt r5.w, c23.y, r5.w
mul r5.w, r2.w, r5.w
mad r7.xyz, r7, -r5.z, r9
mad r6.xyz, r5.w, r7, r6
dp3 r7.x, c7, r6
dp3 r7.y, c8, r6
dp3 r5.z, c9, r6
mul r5.w, r0.w, r5.z
mad r5.w, r5.w, r5.w, -r3.w
max r5.w, r5.w, c23.y
rsq r5.w, r5.w
rcp r5.w, r5.w
mad r5.w, r5.z, -r0.w, -r5.w
rcp r6.x, r5.z
mul r6.x, r6.x, -c15.z
mad r6.y, r5.z, -r5.z, c23.z
mad r6.y, r4.w, r6.y, c23.z
mad r6.x, r6.x, r6.y, -r5.w
mul r5.z, r5.z, r6.x
slt r5.z, r5_abs.z, c23.z
mad r5.z, r5.z, r6.x, r5.w
mad r5.zw, r5.z, r7.xyxy, c15.xyxy
add r5.zw, -r5.xyxy, r5
slt r6.xy, -r5_abs.zwzw, r5_abs.zwzw
add r6.x, r6.y, r6.x
if_lt -r6.x, r6.x
mad r0.x, v0.x, r3.x, c22.x
mov r0.z, c23.z
dp3 r6.x, c10.xyww, r0
dp3 r6.y, c11.xyww, r0
dp3 r6.z, c12.xyww, r0
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
mul r8.xyz, r7.yzxw, c16.zxyw
mad r8.xyz, c16.yzxw, r7.zxyw, -r8
mul r9.xyz, r8.zxyw, c16.yzxw
mad r9.xyz, r8.yzxw, c16.zxyw, -r9
nrm r10.xyz, r9
mad r4.xyz, c18.x, r10, r4
mul r9.xyz, r7.yzxw, r4.zxyw
mad r9.xyz, r4.yzxw, r7.zxyw, -r9
dp3 r0.y, r8, r9
slt r0.y, c23.y, r0.y
mul r0.y, r2.w, r0.y
mad r4.xyz, r6, -r0.x, r4
mad r0.xyz, r0.y, r4, r7
dp3 r4.x, c7, r0
dp3 r4.y, c8, r0
dp3 r0.x, c9, r0
mul r0.y, r0.w, r0.x
mad r0.y, r0.y, r0.y, -r3.w
max r0.y, r0.y, c23.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.y, r0.x, -r0.w, -r0.y
rcp r0.z, r0.x
mul r0.z, r0.z, -c15.z
mad r0.w, r0.x, -r0.x, c23.z
mad r0.w, r4.w, r0.w, c23.z
mad r0.z, r0.z, r0.w, -r0.y
mul r0.x, r0.x, r0.z
slt r0.x, r0_abs.x, c23.z
mad r0.x, r0.x, r0.z, r0.y
mad r0.xy, r0.x, r4, c15
add r0.xy, -r5, r0
rcp r0.z, c21.x
mul r4.xy, r0.z, r5
mul r3.xw, r0.z, r0.xyzy
mul r0.zw, r0.z, r5
mul r3.xw, r3, c19.x
mul r0.zw, r0, c19.y
mul r3.xw, r3, r3
add r2.w, r3.w, r3.x
mul r0.zw, r0, r0
add r0.z, r0.w, r0.z
max r0.z, r0.z, r2.w
log r0.z, r0.z
mul r4.w, r0.z, c24.x
mov r4.z, c23.y
texldl r6, r4, s0
add r0.z, r6.x, c14.x
rcp r0.w, c21.y
mul r6.xy, r0.w, r5
mul r3.xw, r0.w, r0.xyzy
mul r7.xy, r0.w, r5.zwzw
mul r3.xw, r3, c19.x
mul r7.xy, r7, c19.y
mul r3.xw, r3, r3
add r0.w, r3.w, r3.x
mul r3.xw, r7.xyzy, r7.xyzy
add r2.w, r3.w, r3.x
max r0.w, r0.w, r2.w
log r0.w, r0.w
mul r6.w, r0.w, c24.x
mov r6.z, c23.y
texldl r7, r6, s0
add r0.z, r0.z, r7.y
rcp r0.w, c21.z
mul r7.xy, r0.w, r5
mul r3.xw, r0.w, r0.xyzy
mul r8.xy, r0.w, r5.zwzw
mul r3.xw, r3, c19.x
mul r8.xy, r8, c19.y
mul r3.xw, r3, r3
add r0.w, r3.w, r3.x
mul r3.xw, r8.xyzy, r8.xyzy
add r2.w, r3.w, r3.x
max r0.w, r0.w, r2.w
log r0.w, r0.w
mul r7.w, r0.w, c24.x
mov r7.z, c23.y
texldl r8, r7, s0
add r0.z, r0.z, r8.z
rcp r0.w, c21.w
mul r8.xy, r0.w, r5
mul r0.xy, r0.w, r0
mul r3.xw, r0.w, r5.zyzw
mul r0.xy, r0, c19.x
mul r3.xw, r3, c19.y
mul r0.xy, r0, r0
add r0.x, r0.y, r0.x
mul r0.yw, r3.xxzw, r3.xxzw
add r0.y, r0.w, r0.y
max r0.x, r0.y, r0.x
log r0.x, r0.x
mul r8.w, r0.x, c24.x
mov r8.z, c23.y
texldl r9, r8, s0
add r0.z, r0.z, r9.w
texldl r4, r4, s1
texldl r6, r6, s1
mul r3.xw, r6.zyzw, c20.y
mad r3.xw, c20.x, r4.xyzy, r3
texldl r4, r7, s2
mad r3.xw, c20.z, r4.xyzy, r3
texldl r4, r8, s2
mad r0.xy, c20.w, r4.zwzw, r3.xwzw
else
mul r0.xyz, r3.yyzw, c14.x
endif
dp3 r4.x, c4, r0
dp3 r4.y, c5, r0
dp3 r4.z, c6, r0
mad r4.xyz, r1.w, r1, r4
mad r0.xyz, r1.w, r2, r0
mad o2.xyz, c15.z, r3.yyzw, r0
mov r4.w, c23.z
dp4 o0.x, c0, r4
dp4 o0.y, c1, r4
dp4 o0.z, c2, r4
dp4 o0.w, c3, r4
mov o1.xy, r5

"
}
SubProgram "d3d11 " {
// Stats: 167 math, 2 branches
Keywords { "SKY_REFLECTIONS_OFF" }
Bind "vertex" Vertex
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
ConstBuffer "$Globals" 992
Matrix 272 [_Ocean_OceanToCamera]
Matrix 336 [_Ocean_CameraToOcean]
Matrix 432 [_Globals_ScreenToCamera]
Matrix 624 [_Globals_CameraToScreen]
Float 252 [_Ocean_Radius]
Float 256 [_Ocean_HeightOffset]
Vector 260 [_Ocean_CameraPos] 3
Vector 400 [sphereDir] 3
Float 412 [cosTheta]
Float 416 [sinTheta]
Vector 864 [_Ocean_MapSize] 2
Vector 880 [_Ocean_Choppyness]
Vector 928 [_Ocean_GridSizes]
Vector 944 [_Ocean_ScreenGridSize] 2
BindCB  "$Globals" 0
"vs_4_0
root12:adabadaa
eefiecedjodgeeeplfijhcehdmbfifnkpieijehcabaaaaaamebjaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefckmbiaaaaeaaaabaaclagaaaa
fjaaaaaeegiocaaaaaaaaaaadmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafpaaaaaddcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacajaaaaaa
diaaaaakdcaabaaaaaaaaaaaegbabaaaaaaaaaaaaceaaaaaaaaakadpaaaakadp
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabmaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaablaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaajgaebaaaabaaaaaacgijcaaaaaaaaaaabjaaaaaadcaaaaal
hcaabaaaacaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaacgajbaaaacaaaaaajgiecaaa
aaaaaaaabjaaaaaadcaaaaalhcaabaaaadaaaaaajgaebaaaacaaaaaacgijcaaa
aaaaaaaabjaaaaaaegacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaajhcaabaaaaeaaaaaaegiccaaaaaaaaaaabjaaaaaapgipcaaaaaaaaaaa
bjaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaabkaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaajgaebaaaabaaaaaa
cgajbaaaadaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaadaaaaaacgajbaaa
abaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaafaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkiacaaa
aaaaaaaabaaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
aaaaaaaabgaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaabhaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajecaabaaa
aaaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaabaaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaaapaaaaaadcaaaaal
bcaabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaaabeaaaaaaaaaaaeadkiacaaa
aaaaaaaabaaaaaaadiaaaaaibcaabaaaadaaaaaaakaabaaaadaaaaaadkiacaaa
aaaaaaaabaaaaaaadcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalicaabaaaabaaaaaackaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaaaoaaaaajccaabaaaadaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaackaabaaaacaaaaaaaoaaaaaiicaabaaaacaaaaaadkiacaaa
aaaaaaaabaaaaaaadkaabaaaacaaaaaadcaaaaakecaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaahccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadbaaaaai
ccaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdhaaaaaj
icaabaaaabaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaa
dcaaaaakgcaabaaaadaaaaaapgapbaaaabaaaaaaagabbaaaacaaaaaafgigcaaa
aaaaaaaabaaaaaaadcaaaaakicaabaaaadaaaaaabkbabaaaaaaaaaaaabeaaaaa
aaaakadpbkiacaaaaaaaaaaadlaaaaaadiaaaaaihcaabaaaafaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaabmaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaa
aaaaaaaablaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaaihcaabaaaagaaaaaajgaebaaaafaaaaaacgijcaaaaaaaaaaa
bjaaaaaadcaaaaalhcaabaaaagaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaaihcaabaaaahaaaaaacgajbaaa
agaaaaaajgiecaaaaaaaaaaabjaaaaaadcaaaaalhcaabaaaahaaaaaajgaebaaa
agaaaaaacgijcaaaaaaaaaaabjaaaaaaegacbaiaebaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaaagaabaaaaaaaaaaa
egacbaaaahaaaaaadcaaaaakhcaabaaaahaaaaaaagiacaaaaaaaaaaabkaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
afaaaaaacgajbaaaahaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaahaaaaaa
cgajbaaaafaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaagaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaafaaaaaa
egiccaaaaaaaaaaabgaaaaaadcaaaaaklcaabaaaafaaaaaaegiicaaaaaaaaaaa
bfaaaaaaagaabaaaafaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaafaaaaaa
egiccaaaaaaaaaaabhaaaaaakgakbaaaafaaaaaaegadbaaaafaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaia
ebaaaaaaafaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaaj
icaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaackaabaaaafaaaaaa
dcaaaaakicaabaaaaeaaaaaackaabaiaebaaaaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaaeaaaaaadcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaadaaaaaackaabaaa
afaaaaaadkaabaaaadaaaaaadbaaaaaiicaabaaaadaaaaaadkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpdhaaaaajbcaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaafaaaaaaakaabaaaaaaaaaaadcaaaaakpcaabaaaafaaaaaaagaabaaa
aaaaaaaaegaebaaaafaaaaaajgijcaaaaaaaaaaabaaaaaaaaaaaaaaipcaabaaa
afaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaafaaaaaadjaaaaakdcaabaaa
agaaaaaaogakbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dmaaaaahbcaabaaaaaaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaabpaaaead
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaa
aaaakadpakiacaaaaaaaaaaadlaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabmaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaa
aaaaaaaablaaaaaaagaabaaaaaaaaaaaegacbaaaagaaaaaaaaaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
agaaaaaadiaaaaaihcaabaaaahaaaaaajgaebaaaagaaaaaacgijcaaaaaaaaaaa
bjaaaaaadcaaaaalhcaabaaaahaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaaihcaabaaaaiaaaaaacgajbaaa
ahaaaaaajgiecaaaaaaaaaaabjaaaaaadcaaaaalhcaabaaaaiaaaaaajgaebaaa
ahaaaaaacgijcaaaaaaaaaaabjaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaagaabaaaaaaaaaaa
egacbaaaaiaaaaaadcaaaaakhcaabaaaaeaaaaaaagiacaaaaaaaaaaabkaaaaaa
egacbaaaaiaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
agaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaaeaaaaaa
cgajbaaaagaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaahaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaa
aeaaaaaaegaibaaaagaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabgaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
bfaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaaaaaaaaabhaaaaaapgapbaaaaaaaaaaaegaibaaaaeaaaaaadiaaaaah
icaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakbcaabaaa
adaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaalecaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaaaoaaaaaj
bcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadkaabaaaaaaaaaaa
dcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaadcaaaaakicaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaebaaaaaaaaaaajgijcaaaaaaaaaaabaaaaaaaaaaaaaaipcaabaaa
aaaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaaaaaaaaaaoaaaaaipcaabaaa
aeaaaaaajgajbaaaadaaaaaaagifcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaa
agaaaaaaogaobaaaaaaaaaaaagifcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaa
ahaaaaaaogaobaaaafaaaaaaagifcaaaaaaaaaaadkaaaaaadiaaaaaipcaabaaa
agaaaaaaegaobaaaagaaaaaaagiacaaaaaaaaaaadgaaaaaadiaaaaaipcaabaaa
ahaaaaaaegaobaaaahaaaaaafgifcaaaaaaaaaaadgaaaaaaapaaaaahicaabaaa
acaaaaaaegaabaaaagaaaaaaegaabaaaagaaaaaaapaaaaahbcaabaaaadaaaaaa
egaabaaaahaaaaaaegaabaaaahaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaacpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpeiaaaaal
pcaabaaaaiaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaadaaaaaaakaabaaaaiaaaaaaakiacaaa
aaaaaaaabaaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaaagaaaaaaogakbaaa
agaaaaaaapaaaaahbcaabaaaagaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaa
deaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaacpaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaaagaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaa
jgajbaaaadaaaaaakgipcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaakgipcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaakgipcaaaaaaaaaaadkaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagiacaaaaaaaaaaadgaaaaaadiaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaafgifcaaaaaaaaaaadgaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaaegaabaaa
afaaaaaaegaabaaaafaaaaaadeaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaa
ahaaaaaaegaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaadaaaaaackaabaaaahaaaaaa
apaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaogakbaaaafaaaaaaogakbaaaafaaaaaadeaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaacpaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaadpeiaaaaalpcaabaaaafaaaaaaogakbaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaafaaaaaabkaabaaa
aaaaaaaadkaabaaaafaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadkaabaaaacaaaaaaeiaaaaalpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadkaabaaa
adaaaaaadiaaaaaikcaabaaaaaaaaaaakgaobaaaaeaaaaaafgifcaaaaaaaaaaa
dhaaaaaadcaaaaakkcaabaaaaaaaaaaaagiacaaaaaaaaaaadhaaaaaaagaebaaa
ahaaaaaafganbaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaagaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaakgikcaaaaaaaaaaadhaaaaaaegaabaaaaeaaaaaangafbaaaaaaaaaaa
eiaaaaalpcaabaaaaeaaaaaaogakbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaackaabaaaaaaaaaaadcaaaaakdcaabaaaafaaaaaapgipcaaaaaaaaaaa
dhaaaaaaogakbaaaaeaaaaaaegaabaaaaaaaaaaabcaaaaabdgaaaaafbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaaakiacaaaaaaaaaaa
baaaaaaadgaaaaafhcaabaaaafaaaaaaagacbaaaaaaaaaaabfaaaaabdiaaaaai
hcaabaaaaaaaaaaafgafbaaaafaaaaaaegiccaaaaaaaaaaabcaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaaagaabaaaafaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabdaaaaaakgakbaaa
afaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaacaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaaaaaaaaaabaaaaaaa
aaaaaaahhccabaaaacaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaciaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaachaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaacjaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaackaaaaaadgaaaaafdccabaaaabaaaaaajgafbaaaadaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES
#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_NO_LINEAR_COLORSPACE
    #define UNITY_NO_LINEAR_COLORSPACE 1
#endif
#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 524
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 273
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 439
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 433
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 32
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
#line 40
uniform highp vec4 _ZBufferParams;
#line 46
uniform highp vec4 unity_OrthoParams;
#line 51
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 56
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
#line 69
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 74
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
#line 79
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 87
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 91
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 95
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 101
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 108
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 112
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 127
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 134
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 144
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 154
uniform highp mat4 glstate_matrix_projection;
uniform lowp vec4 glstate_lightmodel_ambient;
#line 160
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 165
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 175
uniform lowp vec4 unity_FogColor;
#line 180
uniform highp vec4 unity_FogParams;
#line 188
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 193
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 198
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 206
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 210
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 215
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 8
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 unity_ColorSpaceDouble;
uniform mediump vec4 unity_ColorSpaceDielectricSpec;
uniform mediump vec4 unity_ColorSpaceLuminance;
#line 61
#line 67
#line 73
#line 80
#line 95
#line 102
#line 117
#line 124
#line 131
#line 149
#line 182
#line 207
#line 213
#line 235
#line 252
#line 279
#line 290
#line 300
#line 330
#line 347
#line 352
#line 359
#line 372
#line 387
#line 392
uniform mediump vec4 unity_Lightmap_HDR;
#line 403
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 416
#line 445
#line 451
#line 461
#line 470
#line 477
#line 486
#line 494
#line 503
#line 522
#line 528
#line 536
#line 547
#line 552
#line 574
#line 599
#line 622
#line 631
#line 641
#line 676
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
#line 33
#line 37
#line 42
#line 70
#line 88
#line 92
#line 100
#line 104
#line 29
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
#line 43
#line 74
#line 82
#line 95
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 99
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp mat4 _Globals_WorldToOcean;
uniform highp mat4 _Globals_OceanToWorld;
#line 104
uniform highp vec3 _Globals_Origin;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec2 _Ocean_MapSize;
#line 108
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
#line 112
uniform highp vec2 _Ocean_ScreenGridSize;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
#line 116
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
#line 120
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 125
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
#line 129
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 141
#line 43
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc, out highp float t, out highp vec3 cameraDir, out highp vec3 oceanDir ) {
    highp float h = _Ocean_CameraPos.z;
    #line 47
    highp vec4 v = vec4( vert.x, vert.y, 0.0, 1.0);
    cameraDir = normalize((stoc * v).xyz);
    highp vec3 n1 = cross( sphereDir, cameraDir);
    #line 51
    highp vec3 n2 = normalize(cross( n1, sphereDir));
    highp vec3 hor = ((cosTheta * sphereDir) + (sinTheta * n2));
    #line 55
    cameraDir = (( ((dot( n1, cross( hor, cameraDir)) > 0.0) && (h > 0.0)) ) ? ( hor ) : ( cameraDir ));
    #line 59
    oceanDir = (_Ocean_CameraToOcean * vec4( cameraDir, 0.0)).xyz;
    highp float cz = _Ocean_CameraPos.z;
    highp float dz = oceanDir.z;
    highp float radius = _Ocean_Radius;
    #line 65
    highp float b = (dz * (cz + radius));
    highp float c = (cz * (cz + (2.0 * radius)));
    highp float tSphere = ((-b) - sqrt(max( ((b * b) - c), 0.0)));
    highp float tApprox = (((-cz) / dz) * (1.0 + ((cz / (2.0 * radius)) * (1.0 - (dz * dz)))));
    #line 69
    t = (( (abs(((tApprox - tSphere) * dz)) < 1.0) ) ? ( tApprox ) : ( tSphere ));
    return (_Ocean_CameraPos.xy + (t * oceanDir.xy));
}
#line 74
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc ) {
    highp float t;
    highp vec3 cameraDir;
    #line 78
    highp vec3 oceanDir;
    return OceanPos( vert, stoc, t, cameraDir, oceanDir);
}
#line 82
highp vec4 Tex2DGrad( in sampler2D tex, in highp vec2 uv, in highp vec2 dx, in highp vec2 dy, in highp vec2 texSize ) {
    #line 86
    highp vec2 px = (texSize.x * dx);
    highp vec2 py = (texSize.y * dy);
    highp float lod = (0.5 * log2(max( dot( px, px), dot( py, py))));
    return xll_tex2Dlod( tex, vec4( uv, 0.0, lod));
}
#line 141
v2f vert( in appdata_base v ) {
    highp float t;
    highp vec3 cameraDir;
    highp vec3 oceanDir;
    #line 146
    highp vec4 vert = v.vertex;
    vert.xy *= 1.25;
    highp vec2 u = OceanPos( vert, _Globals_ScreenToCamera, t, cameraDir, oceanDir);
    #line 150
    highp vec2 dux = (OceanPos( (vert + vec4( _Ocean_ScreenGridSize.x, 0.0, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec2 duy = (OceanPos( (vert + vec4( 0.0, _Ocean_ScreenGridSize.y, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    #line 154
    highp vec3 dP = vec3( 0.0, 0.0, _Ocean_HeightOffset);
    if (((duy.x != 0.0) || (duy.y != 0.0))){
        #line 158
        highp vec4 GRID_SIZES = _Ocean_GridSizes;
        highp vec4 CHOPPYNESS = _Ocean_Choppyness;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).x;
        #line 162
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).y;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).z;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).w;
        #line 171
        dP.xy += (CHOPPYNESS.x * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.y * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).zw);
        dP.xy += (CHOPPYNESS.z * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.w * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).zw);
    }
    #line 183
    v2f OUT;
    highp mat3 otoc = xll_constructMat3_mf4x4( _Ocean_OceanToCamera);
    highp vec4 screenP = vec4( ((t * cameraDir) + (otoc * dP)), 1.0);
    #line 187
    highp vec3 oceanP = (((t * oceanDir) + dP) + vec3( 0.0, 0.0, _Ocean_CameraPos.z));
    OUT.pos = (_Globals_CameraToScreen * screenP);
    #line 191
    OUT.oceanU = u;
    OUT.oceanP = oceanP;
    #line 199
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.oceanU);
    xlv_TEXCOORD1 = vec3(xl_retval.oceanP);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(117,1): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_NO_LINEAR_COLORSPACE
    #define UNITY_NO_LINEAR_COLORSPACE 1
#endif
#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 524
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#extension GL_EXT_shader_texture_lod : require
#extension GL_OES_standard_derivatives : require
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
#line 273
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 439
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 433
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 32
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
#line 40
uniform highp vec4 _ZBufferParams;
#line 46
uniform highp vec4 unity_OrthoParams;
#line 51
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 56
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
#line 69
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 74
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
#line 79
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 87
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 91
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 95
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 101
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 108
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 112
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 127
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 134
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 144
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 154
uniform highp mat4 glstate_matrix_projection;
uniform lowp vec4 glstate_lightmodel_ambient;
#line 160
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 165
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 175
uniform lowp vec4 unity_FogColor;
#line 180
uniform highp vec4 unity_FogParams;
#line 188
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 193
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 198
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 206
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 210
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 215
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 8
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 unity_ColorSpaceDouble;
uniform mediump vec4 unity_ColorSpaceDielectricSpec;
uniform mediump vec4 unity_ColorSpaceLuminance;
#line 61
#line 67
#line 73
#line 80
#line 95
#line 102
#line 117
#line 124
#line 131
#line 149
#line 182
#line 207
#line 213
#line 235
#line 252
#line 279
#line 290
#line 300
#line 330
#line 347
#line 352
#line 359
#line 372
#line 387
#line 392
uniform mediump vec4 unity_Lightmap_HDR;
#line 403
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 416
#line 445
#line 451
#line 461
#line 470
#line 477
#line 486
#line 494
#line 503
#line 522
#line 528
#line 536
#line 547
#line 552
#line 574
#line 599
#line 622
#line 631
#line 641
#line 676
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
#line 33
#line 37
#line 42
#line 70
#line 88
#line 92
#line 100
#line 104
#line 29
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
#line 43
#line 74
#line 82
#line 95
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 99
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp mat4 _Globals_WorldToOcean;
uniform highp mat4 _Globals_OceanToWorld;
#line 104
uniform highp vec3 _Globals_Origin;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec2 _Ocean_MapSize;
#line 108
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
#line 112
uniform highp vec2 _Ocean_ScreenGridSize;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
#line 116
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
#line 120
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 125
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
#line 129
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 141
highp float xlat_mutableRt;
#line 42
highp float ReflectedSunRadiance( in highp vec3 L, in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    highp vec3 H = normalize((L + V));
    #line 46
    highp float hn = dot( H, N);
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.56637 * sigmaSq));
    highp float c = (1.0 - dot( V, H));
    #line 50
    highp float c2 = (c * c);
    highp float fresnel = (0.02 + (((0.98 * c2) * c2) * c));
    highp float zL = dot( L, N);
    #line 54
    highp float zV = dot( V, N);
    zL = max( zL, 0.01);
    zV = max( zV, 0.01);
    #line 59
    return (( (zL <= 0.0) ) ? ( 0.0 ) : ( max( ((fresnel * p) * sqrt(abs((zL / zV)))), 0.0) ));
}
#line 33
highp float MeanFresnel( in highp float cosThetaV, in highp float sigmaV ) {
    return (pow( (1.0 - cosThetaV), (5.0 * exp((-2.69 * sigmaV)))) / (1.0 + (22.7 * pow( sigmaV, 1.5))));
}
#line 37
highp float MeanFresnel( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return MeanFresnel( dot( V, N), sqrt(sigmaSq));
}
#line 88
highp float RefractedSeaRadiance( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return (0.98 * (1.0 - MeanFresnel( V, N, sigmaSq)));
}
#line 472
highp vec2 GetIrradianceUV( in highp float r, in highp float muS ) {
    #line 474
    highp float uR = ((r - Rg) / (xlat_mutableRt - Rg));
    highp float uMuS = ((muS + 0.2) / 1.2);
    return vec2( uMuS, uR);
}
#line 479
highp vec3 Irradiance( in sampler2D samp, in highp float r, in highp float muS ) {
    highp vec2 uv = GetIrradianceUV( r, muS);
    return xll_tex2Dlod( samp, vec4( uv, 0.0, 0.0)).xyz;
}
#line 488
highp vec3 SkyIrradiance( in highp float r, in highp float muS ) {
    return (Irradiance( _Irradiance, r, muS) * _Sun_Intensity);
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
#line 496
highp vec3 TransmittanceWithShadow( in highp float r, in highp float mu ) {
    return (( (mu < (-sqrt((1.0 - ((Rg / r) * (Rg / r)))))) ) ? ( vec3( 0.0, 0.0, 0.0) ) : ( Transmittance( r, mu) ));
}
#line 504
highp vec3 SunRadiance( in highp float r, in highp float muS ) {
    return (TransmittanceWithShadow( r, muS) * _Sun_Intensity);
}
#line 509
void SunRadianceAndSkyIrradiance( in highp vec3 worldP, in highp vec3 worldN, in highp vec3 worldS, out highp vec3 sunL, out highp vec3 skyE ) {
    highp float r = length(worldP);
    #line 513
    if ((r < (0.9 * Rg))){
        worldP.z += Rg;
        r = length(worldP);
    }
    #line 517
    highp vec3 worldV = (worldP / r);
    highp float muS = dot( worldV, worldS);
    highp float sunOcclusion = 1.0;
    #line 521
    sunL = (SunRadiance( r, muS) * sunOcclusion);
    highp float skyOcclusion = ((1.0 + dot( worldV, worldN)) * 0.5);
    #line 527
    skyE = ((2.0 * SkyIrradiance( r, muS)) * skyOcclusion);
}
#line 92
highp float erf( in highp float x ) {
    highp float a = 0.140012;
    highp float x2 = (x * x);
    #line 96
    highp float ax2 = (a * x2);
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.273239 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.z))) ));
    return L;
}
#line 234
highp vec4 frag( in v2f IN ) {
    #line 237
    highp vec3 L = _Ocean_SunDir;
    highp float radius = _Ocean_Radius;
    highp vec2 u = IN.oceanU;
    highp vec3 oceanP = IN.oceanP;
    #line 243
    highp vec3 earthCamera = vec3( 0.0, 0.0, (_Ocean_CameraPos.z + radius));
    highp vec3 earthP = (normalize((oceanP + vec3( 0.0, 0.0, radius))) * (radius + 10.0));
    #line 247
    highp float dist = length((earthP - earthCamera));
    highp float clampFactor = clamp( (dist / alphaRadius), 0.0, 1.0);
    #line 251
    highp float outAlpha = mix( _OceanAlpha, 1.0, clampFactor);
    highp float outWhiteCapStr = mix( _Ocean_WhiteCapStr, farWhiteCapStr, clampFactor);
    highp vec3 oceanCamera = vec3( 0.0, 0.0, _Ocean_CameraPos.z);
    #line 255
    highp vec3 V = normalize((oceanCamera - oceanP));
    highp vec2 slopes = vec2( 0.0, 0.0);
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.x)).xy;
    #line 259
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.y)).zw;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.z)).xy;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.w)).zw;
    #line 265
    slopes -= (oceanP.xy / (radius + oceanP.z));
    highp vec3 N = normalize(vec3( (-slopes.x), (-slopes.y), 1.0));
    #line 274
    highp float Jxx = xll_dFdx_f(u.x);
    highp float Jxy = xll_dFdy_f(u.x);
    highp float Jyx = xll_dFdx_f(u.y);
    highp float Jyy = xll_dFdy_f(u.y);
    #line 278
    highp float A = ((Jxx * Jxx) + (Jyx * Jyx));
    highp float B = ((Jxx * Jxy) + (Jyx * Jyy));
    highp float C = ((Jxy * Jxy) + (Jyy * Jyy));
    const highp float SCALE = 10.0;
    #line 282
    highp float ua = pow( (A / 10.0), 0.25);
    highp float ub = (0.5 + ((0.5 * B) / sqrt((A * C))));
    highp float uc = pow( (C / 10.0), 0.25);
    #line 286
    highp vec2 sigmaSq = (texture3D( _Ocean_Variance, vec3( ua, ub, uc)).xy * _VarianceMax);
    sigmaSq = max( sigmaSq, vec2( 2e-05));
    #line 290
    highp vec3 sunL;
    highp vec3 skyE;
    SunRadianceAndSkyIrradiance( earthP, N, L, sunL, skyE);
    #line 294
    highp vec3 Lsky;
    #line 302
    Lsky = ((MeanFresnel( V, N, float( sigmaSq)) * skyE) / 3.141593);
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    #line 306
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.141593);
    highp vec2 jm1 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.x)).xy;
    #line 310
    highp vec2 jm2 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.y)).zw;
    highp vec2 jm3 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.z)).xy;
    highp vec2 jm4 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.w)).zw;
    highp vec2 jm = (((jm1 + jm2) + jm3) + jm4);
    #line 314
    highp float jSigma2 = max( (jm.y - ((((jm1.x * jm1.x) + (jm2.x * jm2.x)) + (jm3.x * jm3.x)) + (jm4.x * jm4.x))), 0.0);
    highp float W = WhitecapCoverage( outWhiteCapStr, jm.x, jSigma2);
    #line 320
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.141593);
    highp vec3 R_ftot = ((W * l) * 0.4);
    highp vec3 surfaceColor = (((Lsun + Lsky) + Lsea) + R_ftot);
    #line 328
    highp vec3 finalColor = surfaceColor;
    return vec4( hdr( finalColor), (outAlpha * _GlobalOceanAlpha));
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    xlat_mutableRt = Rt;
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.oceanU = vec2(xlv_TEXCOORD0);
    xlt_IN.oceanP = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(117,1): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
(287,35): error: `_Ocean_Variance' undeclared
(287,24): error: no matching function for call to `texture3D(error, vec3)'; candidates are:
(287,24): error: type mismatch
(287,24): error: operands to arithmetic operators must be numeric
*/

#endif
"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_OFF" }
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform lowp sampler2D _Ocean_Map0;
uniform lowp sampler2D _Ocean_Map3;
uniform lowp sampler2D _Ocean_Map4;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
highp vec4 t0;
highp int ti0;
bool tb0;
highp vec4 t1;
highp vec3 t2;
highp vec4 t3;
highp vec4 t4;
highp vec4 t5;
highp vec4 t6;
highp ivec2 ti6;
highp vec4 t7;
highp vec3 t8;
highp vec3 t9;
highp vec2 t12;
bool tb12;
highp vec2 t18;
highp int ti18;
bool tb18;
highp float t21;
highp float t27;
bool tb27;
highp float t28;
highp float t29;
highp float t30;
bool tb30;
highp float t31;
highp float t32;
void main()
{
    t0.xy = in_POSITION0.xy * vec2(1.25, 1.25);
    t1.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
    t1.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t1.xyz;
    t1.xyz = t1.xyz + _Globals_ScreenToCamera[3].xyz;
    t18.x = dot(t1.xyz, t1.xyz);
    t18.x = inversesqrt(t18.x);
    t1.xyz = t18.xxx * t1.xyz;
    t2.xyz = t1.yzx * sphereDir.xyzx.zxy;
    t2.xyz = sphereDir.xyzx.yzx * t1.zxy + (-t2.xyz);
    t3.xyz = t2.zxy * sphereDir.xyzx.yzx;
    t3.xyz = t2.yzx * sphereDir.xyzx.zxy + (-t3.xyz);
    t18.x = dot(t3.xyz, t3.xyz);
    t18.x = inversesqrt(t18.x);
    t3.xyz = t18.xxx * t3.xyz;
    t4.xyz = sphereDir.xyzx.xyz * vec3(vec3(cosTheta, cosTheta, cosTheta));
    t3.xyz = vec3(sinTheta) * t3.xyz + t4.xyz;
    t5.xyz = t1.yzx * t3.zxy;
    t5.xyz = t3.yzx * t1.zxy + (-t5.xyz);
    t18.x = dot(t2.xyz, t5.xyz);
    tb18 = 0.0<t18.x;
    tb27 = 0.0<_Ocean_CameraPos.xxyz.w;
    ti18 = int(uint(tb27) * 0xffffffffu & uint(tb18) * 0xffffffffu);
    t1.xyz = (int(ti18) != 0) ? t3.xyz : t1.xyz;
    t2.xyz = t1.yyy * _Ocean_CameraToOcean[1].xyz;
    t2.xyz = _Ocean_CameraToOcean[0].xyz * t1.xxx + t2.xyz;
    t2.xyz = _Ocean_CameraToOcean[2].xyz * t1.zzz + t2.xyz;
    t18.x = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t28 = t18.x * t2.z;
    t29 = _Ocean_Radius + _Ocean_Radius;
    t3.x = _Ocean_Radius * 2.0 + _Ocean_CameraPos.xxyz.w;
    t3.x = t3.x * _Ocean_CameraPos.xxyz.w;
    t28 = t28 * t28 + (-t3.x);
    t28 = max(t28, 0.0);
    t28 = sqrt(t28);
    t28 = (-t2.z) * t18.x + (-t28);
    t12.x = (-_Ocean_CameraPos.xxyz.w) / t2.z;
    t29 = _Ocean_CameraPos.xxyz.w / t29;
    t21 = (-t2.z) * t2.z + 1.0;
    t21 = t29 * t21 + 1.0;
    t30 = t21 * t12.x;
    t12.x = t12.x * t21 + (-t28);
    t12.x = t2.z * t12.x;
    tb12 = abs(t12.x)<1.0;
    t28 = (tb12) ? t30 : t28;
    t12.xy = vec2(t28) * t2.xy + _Ocean_CameraPos.xxyz.yz;
    t30 = in_POSITION0.y * 1.25 + _Ocean_ScreenGridSize.xyxx.y;
    t5.xyz = vec3(t30) * _Globals_ScreenToCamera[1].xyz;
    t5.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t5.xyz;
    t5.xyz = t5.xyz + _Globals_ScreenToCamera[3].xyz;
    t0.x = dot(t5.xyz, t5.xyz);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t5.xyz;
    t6.xyz = t5.yzx * sphereDir.xyzx.zxy;
    t6.xyz = sphereDir.xyzx.yzx * t5.zxy + (-t6.xyz);
    t7.xyz = t6.zxy * sphereDir.xyzx.yzx;
    t7.xyz = t6.yzx * sphereDir.xyzx.zxy + (-t7.xyz);
    t0.x = dot(t7.xyz, t7.xyz);
    t0.x = inversesqrt(t0.x);
    t7.xyz = t0.xxx * t7.xyz;
    t7.xyz = vec3(sinTheta) * t7.xyz + t4.xyz;
    t8.xyz = t5.yzx * t7.zxy;
    t8.xyz = t7.yzx * t5.zxy + (-t8.xyz);
    t0.x = dot(t6.xyz, t8.xyz);
    tb0 = 0.0<t0.x;
    ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
    t5.xyz = (int(ti0) != 0) ? t7.xyz : t5.xyz;
    t6.xyz = t5.yyy * _Ocean_CameraToOcean[1].xyz;
    t5.xyw = _Ocean_CameraToOcean[0].xyz * t5.xxx + t6.xyz;
    t5.xyz = _Ocean_CameraToOcean[2].xyz * t5.zzz + t5.xyw;
    t0.x = t18.x * t5.z;
    t0.x = t0.x * t0.x + (-t3.x);
    t0.x = max(t0.x, 0.0);
    t0.x = sqrt(t0.x);
    t0.x = (-t5.z) * t18.x + (-t0.x);
    t30 = (-_Ocean_CameraPos.xxyz.w) / t5.z;
    t31 = (-t5.z) * t5.z + 1.0;
    t31 = t29 * t31 + 1.0;
    t32 = t30 * t31;
    t30 = t30 * t31 + (-t0.x);
    t30 = t5.z * t30;
    tb30 = abs(t30)<1.0;
    t0.x = (tb30) ? t32 : t0.x;
    t5 = t0.xxxx * t5.xyxy + _Ocean_CameraPos.xxyz.yzyz;
    t5 = (-t12.xyxy) + t5;
    ti6.xy = ivec2(uvec2(notEqual(t5.zwzz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    ti0 = int(uint(ti6.y) | uint(ti6.x));
    if((uint(ti0))!=uint(0u)){
        t0.x = in_POSITION0.x * 1.25 + _Ocean_ScreenGridSize.xyxx.x;
        t6.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
        t6.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t6.xyz;
        t6.xyz = t6.xyz + _Globals_ScreenToCamera[3].xyz;
        t0.x = dot(t6.xyz, t6.xyz);
        t0.x = inversesqrt(t0.x);
        t6.xyz = t0.xxx * t6.xyz;
        t7.xyz = t6.yzx * sphereDir.xyzx.zxy;
        t7.xyz = sphereDir.xyzx.yzx * t6.zxy + (-t7.xyz);
        t8.xyz = t7.zxy * sphereDir.xyzx.yzx;
        t8.xyz = t7.yzx * sphereDir.xyzx.zxy + (-t8.xyz);
        t0.x = dot(t8.xyz, t8.xyz);
        t0.x = inversesqrt(t0.x);
        t8.xyz = t0.xxx * t8.xyz;
        t4.xyz = vec3(sinTheta) * t8.xyz + t4.xyz;
        t8.xyz = t6.yzx * t4.zxy;
        t8.xyz = t4.yzx * t6.zxy + (-t8.xyz);
        t0.x = dot(t7.xyz, t8.xyz);
        tb0 = 0.0<t0.x;
        ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
        t0.xyw = (int(ti0) != 0) ? t4.xyz : t6.xyz;
        t4.xyz = t0.yyy * _Ocean_CameraToOcean[1].xyz;
        t4.xyz = _Ocean_CameraToOcean[0].xyz * t0.xxx + t4.xyz;
        t0.xyw = _Ocean_CameraToOcean[2].xyz * t0.www + t4.xyz;
        t30 = t18.x * t0.w;
        t3.x = t30 * t30 + (-t3.x);
        t3.x = max(t3.x, 0.0);
        t3.x = sqrt(t3.x);
        t18.x = (-t0.w) * t18.x + (-t3.x);
        t3.x = (-_Ocean_CameraPos.xxyz.w) / t0.w;
        t30 = (-t0.w) * t0.w + 1.0;
        t29 = t29 * t30 + 1.0;
        t30 = t29 * t3.x;
        t29 = t3.x * t29 + (-t18.x);
        t27 = t0.w * t29;
        tb27 = abs(t27)<1.0;
        t18.x = (tb27) ? t30 : t18.x;
        t0 = t18.xxxx * t0.xyxy + _Ocean_CameraPos.xxyz.yzyz;
        t0 = (-t12.xyxy) + t0;
        t4 = t12.xyxy / _Ocean_GridSizes.xxyy;
        t6 = vec4(t0.z / _Ocean_GridSizes.x, t0.w / _Ocean_GridSizes.x, t0.z / _Ocean_GridSizes.y, t0.w / _Ocean_GridSizes.y);
        t7 = vec4(t5.z / _Ocean_GridSizes.x, t5.w / _Ocean_GridSizes.x, t5.z / _Ocean_GridSizes.y, t5.w / _Ocean_GridSizes.y);
        t6 = t6 * _Ocean_MapSize.xyxx.xxxx;
        t7 = t7 * _Ocean_MapSize.xyxx.yyyy;
        t29 = dot(t6.xy, t6.xy);
        t3.x = dot(t7.xy, t7.xy);
        t29 = max(t29, t3.x);
        t29 = log2(t29);
        t29 = t29 * 0.5;
        t3.x = textureLod(_Ocean_Map0, t4.xy, t29).x;
        t3.x = t3.x + _Ocean_HeightOffset;
        t30 = dot(t6.zw, t6.zw);
        t6.x = dot(t7.zw, t7.zw);
        t30 = max(t30, t6.x);
        t30 = log2(t30);
        t30 = t30 * 0.5;
        t6.x = textureLod(_Ocean_Map0, t4.zw, t30).y;
        t3.x = t3.x + t6.x;
        t6 = vec4(t12.x / _Ocean_GridSizes.z, t12.y / _Ocean_GridSizes.z, t12.x / _Ocean_GridSizes.w, t12.y / _Ocean_GridSizes.w);
        t0 = vec4(t0.x / _Ocean_GridSizes.z, t0.y / _Ocean_GridSizes.z, t0.z / _Ocean_GridSizes.w, t0.w / _Ocean_GridSizes.w);
        t5 = vec4(t5.x / _Ocean_GridSizes.z, t5.y / _Ocean_GridSizes.z, t5.z / _Ocean_GridSizes.w, t5.w / _Ocean_GridSizes.w);
        t0 = t0 * _Ocean_MapSize.xyxx.xxxx;
        t5 = t5 * _Ocean_MapSize.xyxx.yyyy;
        t0.x = dot(t0.xy, t0.xy);
        t9.x = dot(t5.xy, t5.xy);
        t0.x = max(t9.x, t0.x);
        t0.x = log2(t0.x);
        t0.x = t0.x * 0.5;
        t9.x = textureLod(_Ocean_Map0, t6.xy, t0.x).z;
        t9.x = t9.x + t3.x;
        t18.x = dot(t0.zw, t0.zw);
        t27 = dot(t5.zw, t5.zw);
        t18.x = max(t27, t18.x);
        t18.x = log2(t18.x);
        t18.x = t18.x * 0.5;
        t27 = textureLod(_Ocean_Map0, t6.zw, t18.x).w;
        t5.z = t27 + t9.x;
        t9.xz = textureLod(_Ocean_Map3, t4.xy, t29).xy;
        t3.xw = textureLod(_Ocean_Map3, t4.zw, t30).zw;
        t3.xw = t3.xw * _Ocean_Choppyness.yy;
        t9.xz = _Ocean_Choppyness.xx * t9.xz + t3.xw;
        t3.xw = textureLod(_Ocean_Map4, t6.xy, t0.x).xy;
        t0.xy = _Ocean_Choppyness.zz * t3.xw + t9.xz;
        t18.xy = textureLod(_Ocean_Map4, t6.zw, t18.x).zw;
        t5.xy = _Ocean_Choppyness.ww * t18.xy + t0.xy;
    } else {
        t0.x = 0.0;
        t0.z = _Ocean_HeightOffset;
        t5.xyz = t0.xxz;
    //ENDIF
    }
    t0.xyz = t5.yyy * _Ocean_OceanToCamera[1].xyz;
    t0.xyz = _Ocean_OceanToCamera[0].xyz * t5.xxx + t0.xyz;
    t0.xyz = _Ocean_OceanToCamera[2].xyz * t5.zzz + t0.xyz;
    t0.xyz = vec3(t28) * t1.xyz + t0.xyz;
    t1.xyz = vec3(t28) * t2.xyz + t5.xyz;
    t2.x = 0.0;
    t2.z = _Ocean_CameraPos.xxyz.w;
    vs_TEXCOORD1.xyz = t1.xyz + t2.xxz;
    t1 = t0.yyyy * _Globals_CameraToScreen[1];
    t1 = _Globals_CameraToScreen[0] * t0.xxxx + t1;
    t0 = _Globals_CameraToScreen[2] * t0.zzzz + t1;
    gl_Position = t0 + _Globals_CameraToScreen[3];
    vs_TEXCOORD0.xy = t12.xy;
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform lowp sampler2D _Ocean_Map1;
uniform lowp sampler2D _Ocean_Map2;
uniform lowp sampler3D _Ocean_Variance;
uniform lowp sampler2D _Transmittance;
uniform lowp sampler2D _Irradiance;
uniform lowp sampler2D _Ocean_Foam0;
uniform lowp sampler2D _Ocean_Foam1;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
highp vec4 t0;
highp vec4 t1;
mediump vec2 t16_1;
lowp vec2 t10_1;
highp vec3 t2;
lowp vec3 t10_2;
bvec3 tb2;
highp vec4 t3;
lowp vec2 t10_3;
highp vec4 t4;
lowp vec2 t10_4;
highp vec3 t5;
lowp vec2 t10_5;
highp vec4 t6;
lowp vec3 t10_6;
bool tb6;
highp vec4 t7;
highp float t8;
highp vec3 t9;
mediump float t16_9;
highp int ti9;
highp vec3 t10;
mediump vec2 t16_10;
lowp vec2 t10_10;
highp float t16;
highp vec2 t17;
mediump float t16_17;
lowp vec2 t10_17;
highp int ti17;
highp vec2 t18;
lowp vec2 t10_19;
highp float t24;
bool tb24;
highp float t25;
lowp float t10_25;
highp float t26;
mediump float t16_26;
highp float t29;
void main()
{
    t0.x = 0.0;
    t0.z = _Ocean_CameraPos.xxyz.w;
    t0.xyz = t0.xxz + (-vs_TEXCOORD1.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t1.xyz = t0.xyz * vec3(t24) + _Ocean_SunDir.xyzx.xyz;
    t0.xyz = vec3(t24) * t0.xyz;
    t24 = dot(t1.xyz, t1.xyz);
    t24 = inversesqrt(t24);
    t1.xyz = vec3(t24) * t1.xyz;
    t24 = dot(t0.xyz, t1.xyz);
    t24 = (-t24) + 1.0;
    t25 = t24 * t24;
    t25 = t25 * t25;
    t24 = t24 * t25;
    t24 = t24 * 0.980000019 + 0.0199999996;
    t2.xy = dFdx(vs_TEXCOORD0.xy);
    t18.xy = dFdy(vs_TEXCOORD0.xy);
    t3.xy = t18.xy * t2.xy;
    t2.xy = t2.xy * t2.xy;
    t25 = t2.y + t2.x;
    t2.xy = t18.xy * t18.xy;
    t2.x = t2.y + t2.x;
    t10.x = t3.y + t3.x;
    t10.x = t10.x * 0.5;
    t18.x = t25 * t2.x;
    t25 = t25 * 0.100000001;
    t25 = log2(t25);
    t25 = t25 * 0.25;
    t3.x = exp2(t25);
    t25 = t2.x * 0.100000001;
    t25 = log2(t25);
    t25 = t25 * 0.25;
    t3.z = exp2(t25);
    t25 = sqrt(t18.x);
    t25 = t10.x / t25;
    t3.y = t25 + 0.5;
    t10_25 = texture(_Ocean_Variance, t3.xyz).x;
    t25 = t10_25 * _VarianceMax.xyxx.x;
    t25 = max(t25, 1.99999995e-005);
    t2.x = t25 * 12.566371;
    t3 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.xxyy;
    t10_10.xy = texture(_Ocean_Map1, t3.xy).xy;
    t10_4.xy = texture(_Ocean_Map1, t3.zw).zw;
    t16_10.xy = t10_10.xy + t10_4.xy;
    t4 = vec4(vs_TEXCOORD0.x / _Ocean_GridSizes.z, vs_TEXCOORD0.y / _Ocean_GridSizes.z, vs_TEXCOORD0.x / _Ocean_GridSizes.w, vs_TEXCOORD0.y / _Ocean_GridSizes.w);
    t10_5.xy = texture(_Ocean_Map2, t4.xy).xy;
    t16_10.xy = t16_10.xy + t10_5.xy;
    t10_5.xy = texture(_Ocean_Map2, t4.zw).zw;
    t16_10.xy = t16_10.xy + t10_5.xy;
    t5.x = 0.0;
    t5.z = _Ocean_Radius;
    t5.xyz = t5.xxz + vs_TEXCOORD1.xyz;
    t6.xy = vs_TEXCOORD1.xy / t5.zz;
    t10.xy = t16_10.xy + (-t6.xy);
    t6.xy = (-t10.xy);
    t6.z = 1.0;
    t10.x = dot(t6.xyz, t6.xyz);
    t10.x = inversesqrt(t10.x);
    t10.xyz = t10.xxx * t6.xyz;
    t1.x = dot(t1.xyz, t10.xyz);
    t9.x = (-t1.x) * t1.x + 1.0;
    t1.x = t1.x + 1.0;
    t9.x = t9.x / t25;
    t17.x = sqrt(t25);
    t9.x = t9.x * -2.0;
    t1.x = t9.x / t1.x;
    t1.x = t1.x * 1.44269502;
    t1.x = exp2(t1.x);
    t1.x = t1.x / t2.x;
    t24 = t24 * t1.x;
    t0.x = dot(t0.xyz, t10.xyz);
    t8 = max(t0.x, 0.00999999978);
    t0.x = (-t0.x) + 1.0;
    t0.x = log2(t0.x);
    t16 = dot(_Ocean_SunDir.xyzx.xyz, t10.xyz);
    t1.xy = max(vec2(t16), vec2(0.00999999978, 0.0));
    t8 = t1.x / t8;
    t8 = sqrt(t8);
    t8 = t8 * t24;
    t8 = max(t8, 0.0);
    t16 = dot(t5.xyz, t5.xyz);
    t16 = inversesqrt(t16);
    t5.xyz = vec3(t16) * t5.xyz;
    t16 = _Ocean_Radius + 10.0;
    t6.y = t5.z * t16 + Rg;
    t6.xzw = vec3(t16) * t5.zxy;
    t24 = dot(t6.yzw, t6.yzw);
    t7.xz = t6.yx;
    t7.y = sqrt(t24);
    t24 = dot(t6.xzw, t6.xzw);
    t7.w = sqrt(t24);
    t24 = Rg * 0.899999976;
    tb24 = t7.w<t24;
    t6.xy = (bool(tb24)) ? t7.xy : t7.zw;
    t6.xzw = t6.zwx / t6.yyy;
    t24 = dot(t6.xzw, _Ocean_SunDir.xyzx.xyz);
    t1.x = dot(t6.xzw, t10.xyz);
    t1.x = t1.x + 1.0;
    t1.x = t1.x * 0.5;
    t2.xy = vec2(t24) + vec2(0.150000006, 0.200000003);
    t2.xy = t2.xy * vec2(12.262105, 0.833333313);
    t25 = max(abs(t2.x), 1.0);
    t25 = float(1.0) / t25;
    t26 = min(abs(t2.x), 1.0);
    t25 = t25 * t26;
    t26 = t25 * t25;
    t29 = t26 * 0.0208350997 + -0.0851330012;
    t29 = t26 * t29 + 0.180141002;
    t29 = t26 * t29 + -0.330299497;
    t26 = t26 * t29 + 0.999866009;
    t29 = t25 * t26;
    t29 = t29 * -2.0 + 1.57079637;
    tb6 = 1.0<abs(t2.x);
    t29 = tb6 ? t29 : float(0.0);
    t25 = t25 * t26 + t29;
    t2.x = min(t2.x, 1.0);
    tb2.x = t2.x<(-t2.x);
    t25 = (tb2.x) ? (-t25) : t25;
    t7.x = t25 * 0.666666687;
    t25 = t6.y + (-Rg);
    t2.x = Rg / t6.y;
    t2.x = (-t2.x) * t2.x + 1.0;
    t2.x = sqrt(t2.x);
    tb24 = t24<(-t2.x);
    t2.x = (-Rg) + Rt;
    t2.z = t25 / t2.x;
    t7.y = sqrt(t2.z);
    t10_2.xyz = textureLod(_Irradiance, t2.yz, 0.0).xyz;
    t2.xyz = t10_2.xyz * vec3(_Sun_Intensity);
    t2.xyz = t1.xxx * t2.xyz;
    t2.xyz = t2.xyz + t2.xyz;
    t10_6.xyz = textureLod(_Transmittance, t7.xy, 0.0).xyz;
    t6.xyz = t10_6.xyz * vec3(_Sun_Intensity);
    t6.xyz = (bool(tb24)) ? vec3(0.0, 0.0, 0.0) : t6.xyz;
    t24 = log2(t17.x);
    t1.x = t17.x * -3.88084984;
    t1.x = exp2(t1.x);
    t1.x = t1.x * 5.0;
    t0.x = t0.x * t1.x;
    t0.x = exp2(t0.x);
    t24 = t24 * 1.5;
    t24 = exp2(t24);
    t24 = t24 * 22.7000008 + 1.0;
    t0.x = t0.x / t24;
    t1.xzw = t2.xyz * t0.xxx;
    t0.x = (-t0.x) + 1.0;
    t0.x = t0.x * 0.980000019;
    t7.xyz = t0.xxx * _Ocean_Color.xyzx.xyz;
    t7.xyz = t2.xyz * t7.xyz;
    t2.xyz = t6.xyz * t1.yyy + t2.xyz;
    t1.xyz = t1.xzw * vec3(0.318309873, 0.318309873, 0.318309873);
    t0.xyw = vec3(t8) * t6.xyz + t1.xyz;
    t0.xyw = t7.xyz * vec3(0.318309873, 0.318309873, 0.318309873) + t0.xyw;
    t10_1.xy = texture(_Ocean_Foam0, t3.zw).zw;
    t10_17.xy = texture(_Ocean_Foam0, t3.xy).xy;
    t16_26 = t10_1.x * t10_1.x;
    t16_1.xy = t10_1.xy + t10_17.xy;
    t16_17 = t10_17.x * t10_17.x + t16_26;
    t10_3.xy = texture(_Ocean_Foam1, t4.xy).xy;
    t10_19.xy = texture(_Ocean_Foam1, t4.zw).zw;
    t16_17 = t10_3.x * t10_3.x + t16_17;
    t16_1.xy = t16_1.xy + t10_3.xy;
    t16_1.xy = t10_19.xy + t16_1.xy;
    t16_17 = t10_19.x * t10_19.x + t16_17;
    t16_9 = (-t16_17) + t16_1.y;
    t16_9 = max(t16_9, 0.0);
    t16_9 = sqrt(t16_9);
    t16_9 = float(1.0) / t16_9;
    t3.z = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t3.xy = vec2(0.0, 0.0);
    t3.xyz = t5.xyz * vec3(t16) + (-t3.xyz);
    t16 = dot(t3.xyz, t3.xyz);
    t16 = sqrt(t16);
    t16 = t16 / alphaRadius;
    t16 = clamp(t16, 0.0, 1.0);
    t17.x = (-_Ocean_WhiteCapStr) + farWhiteCapStr;
    t17.x = t16 * t17.x + _Ocean_WhiteCapStr;
    t1.x = (-t16_1.x) + t17.x;
    t1.x = t1.x * 0.707106769;
    t1.x = t16_9 * t1.x;
    ti9 = int((0.0<t1.x) ? 0xFFFFFFFFu : uint(0u));
    ti17 = int((t1.x<0.0) ? 0xFFFFFFFFu : uint(0u));
    t1.x = t1.x * t1.x;
    ti9 = (-ti9) + ti17;
    t9.x = float(ti9);
    t17.xy = t1.xx * vec2(0.140011996, 0.140011996) + vec2(1.27323949, 1.0);
    t1.x = t17.x * (-t1.x);
    t1.x = t1.x / t17.y;
    t1.x = t1.x * 1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t1.x = sqrt(t1.x);
    t1.x = t1.x * t9.x;
    t1.x = t1.x * 0.5 + 0.5;
    t1.xyz = t1.xxx * t2.xyz;
    t0.xyw = t1.xyz * vec3(0.127323955, 0.127323955, 0.127323955) + t0.xyw;
    t0.xyw = t0.xyw * vec3(_Exposure);
    t1 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t1.xz);
    t9.xz = exp2(t1.yw);
    t9.xz = (-t9.xz) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb2.xyz = lessThan(t0.xywx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t0.xy = t0.ww * vec2(0.383170009, -1.44269502);
    SV_Target0.x = (tb2.x) ? t1.x : t9.x;
    SV_Target0.y = (tb2.y) ? t1.z : t9.z;
    t0.x = log2(t0.x);
    t8 = exp2(t0.y);
    t8 = (-t8) + 1.0;
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    SV_Target0.z = (tb2.z) ? t0.x : t8;
    t0.x = (-_OceanAlpha) + 1.0;
    t0.x = t16 * t0.x + _OceanAlpha;
    SV_Target0.w = t0.x * _GlobalOceanAlpha;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "SKY_REFLECTIONS_OFF" }
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform  sampler2D _Ocean_Map0;
uniform  sampler2D _Ocean_Map3;
uniform  sampler2D _Ocean_Map4;
in  vec4 in_POSITION0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 t0;
int ti0;
bool tb0;
vec4 t1;
vec3 t2;
vec3 t3;
vec4 t4;
vec4 t5;
vec4 t6;
ivec2 ti6;
vec4 t7;
vec4 t8;
vec3 t9;
vec2 t12;
bool tb12;
float t18;
int ti18;
bool tb18;
float t21;
float t27;
bool tb27;
float t28;
float t29;
float t30;
bool tb30;
float t31;
float t32;
void main()
{
    t0.xy = in_POSITION0.xy * vec2(1.25, 1.25);
    t1.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
    t1.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t1.xyz;
    t1.xyz = t1.xyz + _Globals_ScreenToCamera[3].xyz;
    t18 = dot(t1.xyz, t1.xyz);
    t18 = inversesqrt(t18);
    t1.xyz = vec3(t18) * t1.xyz;
    t2.xyz = t1.yzx * sphereDir.xyzx.zxy;
    t2.xyz = sphereDir.xyzx.yzx * t1.zxy + (-t2.xyz);
    t3.xyz = t2.zxy * sphereDir.xyzx.yzx;
    t3.xyz = t2.yzx * sphereDir.xyzx.zxy + (-t3.xyz);
    t18 = dot(t3.xyz, t3.xyz);
    t18 = inversesqrt(t18);
    t3.xyz = vec3(t18) * t3.xyz;
    t4.xyz = sphereDir.xyzx.xyz * vec3(vec3(cosTheta, cosTheta, cosTheta));
    t3.xyz = vec3(sinTheta) * t3.xyz + t4.xyz;
    t5.xyz = t1.yzx * t3.zxy;
    t5.xyz = t3.yzx * t1.zxy + (-t5.xyz);
    t18 = dot(t2.xyz, t5.xyz);
    tb18 = 0.0<t18;
    tb27 = 0.0<_Ocean_CameraPos.xxyz.w;
    ti18 = int(uint(tb27) * 0xffffffffu & uint(tb18) * 0xffffffffu);
    t1.xyz = (int(ti18) != 0) ? t3.xyz : t1.xyz;
    t2.xyz = t1.yyy * _Ocean_CameraToOcean[1].xyz;
    t2.xyz = _Ocean_CameraToOcean[0].xyz * t1.xxx + t2.xyz;
    t2.xyz = _Ocean_CameraToOcean[2].xyz * t1.zzz + t2.xyz;
    t18 = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t28 = t18 * t2.z;
    t29 = _Ocean_Radius + _Ocean_Radius;
    t3.x = _Ocean_Radius * 2.0 + _Ocean_CameraPos.xxyz.w;
    t3.x = t3.x * _Ocean_CameraPos.xxyz.w;
    t28 = t28 * t28 + (-t3.x);
    t28 = max(t28, 0.0);
    t28 = sqrt(t28);
    t28 = (-t2.z) * t18 + (-t28);
    t12.x = (-_Ocean_CameraPos.xxyz.w) / t2.z;
    t29 = _Ocean_CameraPos.xxyz.w / t29;
    t21 = (-t2.z) * t2.z + 1.0;
    t21 = t29 * t21 + 1.0;
    t30 = t21 * t12.x;
    t12.x = t12.x * t21 + (-t28);
    t12.x = t2.z * t12.x;
    tb12 = abs(t12.x)<1.0;
    t28 = (tb12) ? t30 : t28;
    t12.xy = vec2(t28) * t2.xy + _Ocean_CameraPos.xxyz.yz;
    t30 = in_POSITION0.y * 1.25 + _Ocean_ScreenGridSize.xyxx.y;
    t5.xyz = vec3(t30) * _Globals_ScreenToCamera[1].xyz;
    t5.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t5.xyz;
    t5.xyz = t5.xyz + _Globals_ScreenToCamera[3].xyz;
    t0.x = dot(t5.xyz, t5.xyz);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t5.xyz;
    t6.xyz = t5.yzx * sphereDir.xyzx.zxy;
    t6.xyz = sphereDir.xyzx.yzx * t5.zxy + (-t6.xyz);
    t7.xyz = t6.zxy * sphereDir.xyzx.yzx;
    t7.xyz = t6.yzx * sphereDir.xyzx.zxy + (-t7.xyz);
    t0.x = dot(t7.xyz, t7.xyz);
    t0.x = inversesqrt(t0.x);
    t7.xyz = t0.xxx * t7.xyz;
    t7.xyz = vec3(sinTheta) * t7.xyz + t4.xyz;
    t8.xyz = t5.yzx * t7.zxy;
    t8.xyz = t7.yzx * t5.zxy + (-t8.xyz);
    t0.x = dot(t6.xyz, t8.xyz);
    tb0 = 0.0<t0.x;
    ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
    t5.xyz = (int(ti0) != 0) ? t7.xyz : t5.xyz;
    t6.xyz = t5.yyy * _Ocean_CameraToOcean[1].xyz;
    t5.xyw = _Ocean_CameraToOcean[0].xyz * t5.xxx + t6.xyz;
    t5.xyz = _Ocean_CameraToOcean[2].xyz * t5.zzz + t5.xyw;
    t0.x = t18 * t5.z;
    t0.x = t0.x * t0.x + (-t3.x);
    t0.x = max(t0.x, 0.0);
    t0.x = sqrt(t0.x);
    t0.x = (-t5.z) * t18 + (-t0.x);
    t30 = (-_Ocean_CameraPos.xxyz.w) / t5.z;
    t31 = (-t5.z) * t5.z + 1.0;
    t31 = t29 * t31 + 1.0;
    t32 = t30 * t31;
    t30 = t30 * t31 + (-t0.x);
    t30 = t5.z * t30;
    tb30 = abs(t30)<1.0;
    t0.x = (tb30) ? t32 : t0.x;
    t5 = t0.xxxx * t5.xyxy + _Ocean_CameraPos.xxyz.yzyz;
    t5 = (-t12.xyxy) + t5;
    ti6.xy = ivec2(uvec2(notEqual(t5.zwzz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    ti0 = int(uint(ti6.y) | uint(ti6.x));
    if((uint(ti0))!=uint(0u)){
        t0.x = in_POSITION0.x * 1.25 + _Ocean_ScreenGridSize.xyxx.x;
        t6.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
        t6.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t6.xyz;
        t6.xyz = t6.xyz + _Globals_ScreenToCamera[3].xyz;
        t0.x = dot(t6.xyz, t6.xyz);
        t0.x = inversesqrt(t0.x);
        t6.xyz = t0.xxx * t6.xyz;
        t7.xyz = t6.yzx * sphereDir.xyzx.zxy;
        t7.xyz = sphereDir.xyzx.yzx * t6.zxy + (-t7.xyz);
        t8.xyz = t7.zxy * sphereDir.xyzx.yzx;
        t8.xyz = t7.yzx * sphereDir.xyzx.zxy + (-t8.xyz);
        t0.x = dot(t8.xyz, t8.xyz);
        t0.x = inversesqrt(t0.x);
        t8.xyz = t0.xxx * t8.xyz;
        t4.xyz = vec3(sinTheta) * t8.xyz + t4.xyz;
        t8.xyz = t6.yzx * t4.zxy;
        t8.xyz = t4.yzx * t6.zxy + (-t8.xyz);
        t0.x = dot(t7.xyz, t8.xyz);
        tb0 = 0.0<t0.x;
        ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
        t0.xyw = (int(ti0) != 0) ? t4.xyz : t6.xyz;
        t4.xyz = t0.yyy * _Ocean_CameraToOcean[1].xyz;
        t4.xyz = _Ocean_CameraToOcean[0].xyz * t0.xxx + t4.xyz;
        t0.xyw = _Ocean_CameraToOcean[2].xyz * t0.www + t4.xyz;
        t30 = t18 * t0.w;
        t3.x = t30 * t30 + (-t3.x);
        t3.x = max(t3.x, 0.0);
        t3.x = sqrt(t3.x);
        t18 = (-t0.w) * t18 + (-t3.x);
        t3.x = (-_Ocean_CameraPos.xxyz.w) / t0.w;
        t30 = (-t0.w) * t0.w + 1.0;
        t29 = t29 * t30 + 1.0;
        t30 = t29 * t3.x;
        t29 = t3.x * t29 + (-t18);
        t27 = t0.w * t29;
        tb27 = abs(t27)<1.0;
        t18 = (tb27) ? t30 : t18;
        t0 = vec4(t18) * t0.xyxy + _Ocean_CameraPos.xxyz.yzyz;
        t0 = (-t12.xyxy) + t0;
        t4 = t12.xyxy / _Ocean_GridSizes.xxyy;
        t6 = t0.zwzw / _Ocean_GridSizes.xxyy;
        t7 = t5.zwzw / _Ocean_GridSizes.xxyy;
        t6 = t6 * _Ocean_MapSize.xyxx.xxxx;
        t7 = t7 * _Ocean_MapSize.xyxx.yyyy;
        t29 = dot(t6.xy, t6.xy);
        t3.x = dot(t7.xy, t7.xy);
        t29 = max(t29, t3.x);
        t29 = log2(t29);
        t29 = t29 * 0.5;
        t8 = textureLod(_Ocean_Map0, t4.xy, t29);
        t3.x = t8.x + _Ocean_HeightOffset;
        t30 = dot(t6.zw, t6.zw);
        t6.x = dot(t7.zw, t7.zw);
        t30 = max(t30, t6.x);
        t30 = log2(t30);
        t30 = t30 * 0.5;
        t6 = textureLod(_Ocean_Map0, t4.zw, t30);
        t3.x = t3.x + t6.y;
        t6 = t12.xyxy / _Ocean_GridSizes.zzww;
        t0 = t0 / _Ocean_GridSizes.zzww;
        t5 = t5 / _Ocean_GridSizes.zzww;
        t0 = t0 * _Ocean_MapSize.xyxx.xxxx;
        t5 = t5 * _Ocean_MapSize.xyxx.yyyy;
        t0.x = dot(t0.xy, t0.xy);
        t9.x = dot(t5.xy, t5.xy);
        t0.x = max(t9.x, t0.x);
        t0.x = log2(t0.x);
        t0.x = t0.x * 0.5;
        t7 = textureLod(_Ocean_Map0, t6.xy, t0.x);
        t9.x = t3.x + t7.z;
        t18 = dot(t0.zw, t0.zw);
        t27 = dot(t5.zw, t5.zw);
        t18 = max(t27, t18);
        t18 = log2(t18);
        t18 = t18 * 0.5;
        t5 = textureLod(_Ocean_Map0, t6.zw, t18);
        t5.z = t9.x + t5.w;
        t7 = textureLod(_Ocean_Map3, t4.xy, t29);
        t4 = textureLod(_Ocean_Map3, t4.zw, t30);
        t9.xz = t4.zw * _Ocean_Choppyness.yy;
        t9.xz = _Ocean_Choppyness.xx * t7.xy + t9.xz;
        t4 = textureLod(_Ocean_Map4, t6.xy, t0.x);
        t0.xy = _Ocean_Choppyness.zz * t4.xy + t9.xz;
        t4 = textureLod(_Ocean_Map4, t6.zw, t18);
        t5.xy = _Ocean_Choppyness.ww * t4.zw + t0.xy;
    } else {
        t0.x = 0.0;
        t0.z = _Ocean_HeightOffset;
        t5.xyz = t0.xxz;
    //ENDIF
    }
    t0.xyz = t5.yyy * _Ocean_OceanToCamera[1].xyz;
    t0.xyz = _Ocean_OceanToCamera[0].xyz * t5.xxx + t0.xyz;
    t0.xyz = _Ocean_OceanToCamera[2].xyz * t5.zzz + t0.xyz;
    t0.xyz = vec3(t28) * t1.xyz + t0.xyz;
    t1.xyz = vec3(t28) * t2.xyz + t5.xyz;
    t2.x = 0.0;
    t2.z = _Ocean_CameraPos.xxyz.w;
    vs_TEXCOORD1.xyz = t1.xyz + t2.xxz;
    t1 = t0.yyyy * _Globals_CameraToScreen[1];
    t1 = _Globals_CameraToScreen[0] * t0.xxxx + t1;
    t0 = _Globals_CameraToScreen[2] * t0.zzzz + t1;
    gl_Position = t0 + _Globals_CameraToScreen[3];
    vs_TEXCOORD0.xy = t12.xy;
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform  sampler2D _Ocean_Map1;
uniform  sampler2D _Ocean_Map2;
uniform  sampler3D _Ocean_Variance;
uniform  sampler2D _Transmittance;
uniform  sampler2D _Irradiance;
uniform  sampler2D _Ocean_Foam0;
uniform  sampler2D _Ocean_Foam1;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
out vec4 SV_Target0;
vec4 t0;
vec4 t1;
mediump float t16_1;
lowp vec4 t10_1;
vec3 t2;
lowp vec4 t10_2;
bvec3 tb2;
vec4 t3;
lowp vec4 t10_3;
vec4 t4;
lowp vec4 t10_4;
vec3 t5;
lowp vec4 t10_5;
vec4 t6;
lowp vec4 t10_6;
bool tb6;
vec4 t7;
float t8;
vec3 t9;
mediump vec2 t16_9;
int ti9;
vec3 t10;
mediump vec2 t16_10;
float t16;
vec2 t17;
int ti17;
vec2 t18;
float t24;
bool tb24;
float t25;
float t26;
float t29;
void main()
{
    t0.x = 0.0;
    t0.z = _Ocean_CameraPos.xxyz.w;
    t0.xyz = t0.xxz + (-vs_TEXCOORD1.xyz);
    t24 = dot(t0.xyz, t0.xyz);
    t24 = inversesqrt(t24);
    t1.xyz = t0.xyz * vec3(t24) + _Ocean_SunDir.xyzx.xyz;
    t0.xyz = vec3(t24) * t0.xyz;
    t24 = dot(t1.xyz, t1.xyz);
    t24 = inversesqrt(t24);
    t1.xyz = vec3(t24) * t1.xyz;
    t24 = dot(t0.xyz, t1.xyz);
    t24 = (-t24) + 1.0;
    t25 = t24 * t24;
    t25 = t25 * t25;
    t24 = t24 * t25;
    t24 = t24 * 0.980000019 + 0.0199999996;
    t2.xy = dFdx(vs_TEXCOORD0.xy);
    t18.xy = dFdy(vs_TEXCOORD0.xy);
    t3.xy = t18.xy * t2.xy;
    t2.xy = t2.xy * t2.xy;
    t25 = t2.y + t2.x;
    t2.xy = t18.xy * t18.xy;
    t2.x = t2.y + t2.x;
    t10.x = t3.y + t3.x;
    t10.x = t10.x * 0.5;
    t18.x = t25 * t2.x;
    t25 = t25 * 0.100000001;
    t25 = log2(t25);
    t25 = t25 * 0.25;
    t3.x = exp2(t25);
    t25 = t2.x * 0.100000001;
    t25 = log2(t25);
    t25 = t25 * 0.25;
    t3.z = exp2(t25);
    t25 = sqrt(t18.x);
    t25 = t10.x / t25;
    t3.y = t25 + 0.5;
    t10_2 = texture(_Ocean_Variance, t3.xyz);
    t25 = t10_2.x * _VarianceMax.xyxx.x;
    t25 = max(t25, 1.99999995e-005);
    t2.x = t25 * 12.566371;
    t3 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.xxyy;
    t10_4 = texture(_Ocean_Map1, t3.xy);
    t10_5 = texture(_Ocean_Map1, t3.zw);
    t16_10.xy = t10_4.xy + t10_5.zw;
    t4 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.zzww;
    t10_5 = texture(_Ocean_Map2, t4.xy);
    t16_10.xy = t16_10.xy + t10_5.xy;
    t10_5 = texture(_Ocean_Map2, t4.zw);
    t16_10.xy = t16_10.xy + t10_5.zw;
    t5.x = 0.0;
    t5.z = _Ocean_Radius;
    t5.xyz = t5.xxz + vs_TEXCOORD1.xyz;
    t6.xy = vs_TEXCOORD1.xy / t5.zz;
    t10.xy = t16_10.xy + (-t6.xy);
    t6.xy = (-t10.xy);
    t6.z = 1.0;
    t10.x = dot(t6.xyz, t6.xyz);
    t10.x = inversesqrt(t10.x);
    t10.xyz = t10.xxx * t6.xyz;
    t1.x = dot(t1.xyz, t10.xyz);
    t9.x = (-t1.x) * t1.x + 1.0;
    t1.x = t1.x + 1.0;
    t9.x = t9.x / t25;
    t17.x = sqrt(t25);
    t9.x = t9.x * -2.0;
    t1.x = t9.x / t1.x;
    t1.x = t1.x * 1.44269502;
    t1.x = exp2(t1.x);
    t1.x = t1.x / t2.x;
    t24 = t24 * t1.x;
    t0.x = dot(t0.xyz, t10.xyz);
    t8 = max(t0.x, 0.00999999978);
    t0.x = (-t0.x) + 1.0;
    t0.x = log2(t0.x);
    t16 = dot(_Ocean_SunDir.xyzx.xyz, t10.xyz);
    t1.xy = max(vec2(t16), vec2(0.00999999978, 0.0));
    t8 = t1.x / t8;
    t8 = sqrt(t8);
    t8 = t8 * t24;
    t8 = max(t8, 0.0);
    t16 = dot(t5.xyz, t5.xyz);
    t16 = inversesqrt(t16);
    t5.xyz = vec3(t16) * t5.xyz;
    t16 = _Ocean_Radius + 10.0;
    t6.y = t5.z * t16 + Rg;
    t6.xzw = vec3(t16) * t5.zxy;
    t24 = dot(t6.yzw, t6.yzw);
    t7.xz = t6.yx;
    t7.y = sqrt(t24);
    t24 = dot(t6.xzw, t6.xzw);
    t7.w = sqrt(t24);
    t24 = Rg * 0.899999976;
    tb24 = t7.w<t24;
    t6.xy = (bool(tb24)) ? t7.xy : t7.zw;
    t6.xzw = t6.zwx / t6.yyy;
    t24 = dot(t6.xzw, _Ocean_SunDir.xyzx.xyz);
    t1.x = dot(t6.xzw, t10.xyz);
    t1.x = t1.x + 1.0;
    t1.x = t1.x * 0.5;
    t2.xy = vec2(t24) + vec2(0.150000006, 0.200000003);
    t2.xy = t2.xy * vec2(12.262105, 0.833333313);
    t25 = max(abs(t2.x), 1.0);
    t25 = float(1.0) / t25;
    t26 = min(abs(t2.x), 1.0);
    t25 = t25 * t26;
    t26 = t25 * t25;
    t29 = t26 * 0.0208350997 + -0.0851330012;
    t29 = t26 * t29 + 0.180141002;
    t29 = t26 * t29 + -0.330299497;
    t26 = t26 * t29 + 0.999866009;
    t29 = t25 * t26;
    t29 = t29 * -2.0 + 1.57079637;
    tb6 = 1.0<abs(t2.x);
    t29 = tb6 ? t29 : float(0.0);
    t25 = t25 * t26 + t29;
    t2.x = min(t2.x, 1.0);
    tb2.x = t2.x<(-t2.x);
    t25 = (tb2.x) ? (-t25) : t25;
    t7.x = t25 * 0.666666687;
    t25 = t6.y + (-Rg);
    t2.x = Rg / t6.y;
    t2.x = (-t2.x) * t2.x + 1.0;
    t2.x = sqrt(t2.x);
    tb24 = t24<(-t2.x);
    t2.x = (-Rg) + Rt;
    t2.z = t25 / t2.x;
    t7.y = sqrt(t2.z);
    t10_2 = textureLod(_Irradiance, t2.yz, 0.0);
    t2.xyz = t10_2.xyz * vec3(_Sun_Intensity);
    t2.xyz = t1.xxx * t2.xyz;
    t2.xyz = t2.xyz + t2.xyz;
    t10_6 = textureLod(_Transmittance, t7.xy, 0.0);
    t6.xyz = t10_6.xyz * vec3(_Sun_Intensity);
    t6.xyz = (bool(tb24)) ? vec3(0.0, 0.0, 0.0) : t6.xyz;
    t24 = log2(t17.x);
    t1.x = t17.x * -3.88084984;
    t1.x = exp2(t1.x);
    t1.x = t1.x * 5.0;
    t0.x = t0.x * t1.x;
    t0.x = exp2(t0.x);
    t24 = t24 * 1.5;
    t24 = exp2(t24);
    t24 = t24 * 22.7000008 + 1.0;
    t0.x = t0.x / t24;
    t1.xzw = t2.xyz * t0.xxx;
    t0.x = (-t0.x) + 1.0;
    t0.x = t0.x * 0.980000019;
    t7.xyz = t0.xxx * _Ocean_Color.xyzx.xyz;
    t7.xyz = t2.xyz * t7.xyz;
    t2.xyz = t6.xyz * t1.yyy + t2.xyz;
    t1.xyz = t1.xzw * vec3(0.318309873, 0.318309873, 0.318309873);
    t0.xyw = vec3(t8) * t6.xyz + t1.xyz;
    t0.xyw = t7.xyz * vec3(0.318309873, 0.318309873, 0.318309873) + t0.xyw;
    t10_1 = texture(_Ocean_Foam0, t3.zw);
    t10_3 = texture(_Ocean_Foam0, t3.xy);
    t16_1 = t10_1.z * t10_1.z;
    t16_9.xy = t10_1.zw + t10_3.xy;
    t16_1 = t10_3.x * t10_3.x + t16_1;
    t10_3 = texture(_Ocean_Foam1, t4.xy);
    t10_4 = texture(_Ocean_Foam1, t4.zw);
    t16_1 = t10_3.x * t10_3.x + t16_1;
    t16_9.xy = t16_9.xy + t10_3.xy;
    t16_9.xy = t10_4.zw + t16_9.xy;
    t16_1 = t10_4.z * t10_4.z + t16_1;
    t16_1 = (-t16_1) + t16_9.y;
    t16_1 = max(t16_1, 0.0);
    t16_1 = sqrt(t16_1);
    t16_1 = float(1.0) / t16_1;
    t3.z = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t3.xy = vec2(0.0, 0.0);
    t3.xyz = t5.xyz * vec3(t16) + (-t3.xyz);
    t16 = dot(t3.xyz, t3.xyz);
    t16 = sqrt(t16);
    t16 = t16 / alphaRadius;
    t16 = clamp(t16, 0.0, 1.0);
    t17.x = (-_Ocean_WhiteCapStr) + farWhiteCapStr;
    t17.x = t16 * t17.x + _Ocean_WhiteCapStr;
    t9.x = (-t16_9.x) + t17.x;
    t9.x = t9.x * 0.707106769;
    t1.x = t16_1 * t9.x;
    ti9 = int((0.0<t1.x) ? 0xFFFFFFFFu : uint(0u));
    ti17 = int((t1.x<0.0) ? 0xFFFFFFFFu : uint(0u));
    t1.x = t1.x * t1.x;
    ti9 = (-ti9) + ti17;
    t9.x = float(ti9);
    t17.xy = t1.xx * vec2(0.140011996, 0.140011996) + vec2(1.27323949, 1.0);
    t1.x = t17.x * (-t1.x);
    t1.x = t1.x / t17.y;
    t1.x = t1.x * 1.44269502;
    t1.x = exp2(t1.x);
    t1.x = (-t1.x) + 1.0;
    t1.x = sqrt(t1.x);
    t1.x = t1.x * t9.x;
    t1.x = t1.x * 0.5 + 0.5;
    t1.xyz = t1.xxx * t2.xyz;
    t0.xyw = t1.xyz * vec3(0.127323955, 0.127323955, 0.127323955) + t0.xyw;
    t0.xyw = t0.xyw * vec3(_Exposure);
    t1 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t1.xz);
    t9.xz = exp2(t1.yw);
    t9.xz = (-t9.xz) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb2.xyz = lessThan(t0.xywx, vec4(1.41299999, 1.41299999, 1.41299999, 0.0)).xyz;
    t0.xy = t0.ww * vec2(0.383170009, -1.44269502);
    SV_Target0.x = (tb2.x) ? t1.x : t9.x;
    SV_Target0.y = (tb2.y) ? t1.z : t9.z;
    t0.x = log2(t0.x);
    t8 = exp2(t0.y);
    t8 = (-t8) + 1.0;
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    SV_Target0.z = (tb2.z) ? t0.x : t8;
    t0.x = (-_OceanAlpha) + 1.0;
    t0.x = t16 * t0.x + _OceanAlpha;
    SV_Target0.w = t0.x * _GlobalOceanAlpha;
    return;
}

#endif
"
}
SubProgram "opengl " {
// Stats: 431 math, 15 textures, 10 branches
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLSL#version 120

#ifdef VERTEX
uniform float _Ocean_Radius;
uniform float _Ocean_HeightOffset;
uniform vec3 _Ocean_CameraPos;
uniform mat4 _Ocean_OceanToCamera;
uniform mat4 _Ocean_CameraToOcean;
uniform vec3 sphereDir;
uniform float cosTheta;
uniform float sinTheta;
uniform mat4 _Globals_ScreenToCamera;
uniform mat4 _Globals_CameraToScreen;
uniform vec2 _Ocean_MapSize;
uniform vec4 _Ocean_Choppyness;
uniform vec4 _Ocean_GridSizes;
uniform vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 dP_1;
  vec4 vert_2;
  vert_2.zw = gl_Vertex.zw;
  vert_2.xy = (gl_Vertex.xy * 1.25);
  vec2 tmpvar_3;
  vec3 oceanDir_4;
  vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 1.0);
  tmpvar_5.xy = vert_2.xy;
  vec3 tmpvar_6;
  tmpvar_6 = normalize((_Globals_ScreenToCamera * tmpvar_5).xyz);
  vec3 tmpvar_7;
  tmpvar_7 = ((sphereDir.yzx * tmpvar_6.zxy) - (sphereDir.zxy * tmpvar_6.yzx));
  vec3 tmpvar_8;
  tmpvar_8 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_7.yzx * sphereDir.zxy) - (tmpvar_7.zxy * sphereDir.yzx))
  )));
  float tmpvar_9;
  tmpvar_9 = dot (tmpvar_7, ((tmpvar_8.yzx * tmpvar_6.zxy) - (tmpvar_8.zxy * tmpvar_6.yzx)));
  vec3 tmpvar_10;
  if (((tmpvar_9 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_10 = tmpvar_8;
  } else {
    tmpvar_10 = tmpvar_6;
  };
  vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_10;
  oceanDir_4 = (_Ocean_CameraToOcean * tmpvar_11).xyz;
  float tmpvar_12;
  tmpvar_12 = (oceanDir_4.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_13;
  float tmpvar_14;
  tmpvar_14 = (2.0 * _Ocean_Radius);
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (
    ((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_14)))
  , 0.0)));
  float tmpvar_15;
  tmpvar_15 = ((-(_Ocean_CameraPos.z) / oceanDir_4.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_14)
   * 
    (1.0 - (oceanDir_4.z * oceanDir_4.z))
  )));
  float tmpvar_16;
  tmpvar_16 = abs(((tmpvar_15 - tmpvar_13) * oceanDir_4.z));
  float tmpvar_17;
  if ((tmpvar_16 < 1.0)) {
    tmpvar_17 = tmpvar_15;
  } else {
    tmpvar_17 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_17 * oceanDir_4.xy));
  vec4 tmpvar_18;
  tmpvar_18.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_18.x = _Ocean_ScreenGridSize.x;
  vec3 oceanDir_19;
  vec4 tmpvar_20;
  tmpvar_20.zw = vec2(0.0, 1.0);
  tmpvar_20.xy = (vert_2 + tmpvar_18).xy;
  vec3 tmpvar_21;
  tmpvar_21 = normalize((_Globals_ScreenToCamera * tmpvar_20).xyz);
  vec3 tmpvar_22;
  tmpvar_22 = ((sphereDir.yzx * tmpvar_21.zxy) - (sphereDir.zxy * tmpvar_21.yzx));
  vec3 tmpvar_23;
  tmpvar_23 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_22.yzx * sphereDir.zxy) - (tmpvar_22.zxy * sphereDir.yzx))
  )));
  float tmpvar_24;
  tmpvar_24 = dot (tmpvar_22, ((tmpvar_23.yzx * tmpvar_21.zxy) - (tmpvar_23.zxy * tmpvar_21.yzx)));
  vec3 tmpvar_25;
  if (((tmpvar_24 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_25 = tmpvar_23;
  } else {
    tmpvar_25 = tmpvar_21;
  };
  vec4 tmpvar_26;
  tmpvar_26.w = 0.0;
  tmpvar_26.xyz = tmpvar_25;
  oceanDir_19 = (_Ocean_CameraToOcean * tmpvar_26).xyz;
  float tmpvar_27;
  tmpvar_27 = (oceanDir_19.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_28;
  float tmpvar_29;
  tmpvar_29 = (2.0 * _Ocean_Radius);
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (
    ((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_29)))
  , 0.0)));
  float tmpvar_30;
  tmpvar_30 = ((-(_Ocean_CameraPos.z) / oceanDir_19.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_29)
   * 
    (1.0 - (oceanDir_19.z * oceanDir_19.z))
  )));
  float tmpvar_31;
  tmpvar_31 = abs(((tmpvar_30 - tmpvar_28) * oceanDir_19.z));
  float tmpvar_32;
  if ((tmpvar_31 < 1.0)) {
    tmpvar_32 = tmpvar_30;
  } else {
    tmpvar_32 = tmpvar_28;
  };
  vec2 tmpvar_33;
  tmpvar_33 = ((_Ocean_CameraPos.xy + (tmpvar_32 * oceanDir_19.xy)) - tmpvar_3);
  vec4 tmpvar_34;
  tmpvar_34.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_34.y = _Ocean_ScreenGridSize.y;
  vec3 oceanDir_35;
  vec4 tmpvar_36;
  tmpvar_36.zw = vec2(0.0, 1.0);
  tmpvar_36.xy = (vert_2 + tmpvar_34).xy;
  vec3 tmpvar_37;
  tmpvar_37 = normalize((_Globals_ScreenToCamera * tmpvar_36).xyz);
  vec3 tmpvar_38;
  tmpvar_38 = ((sphereDir.yzx * tmpvar_37.zxy) - (sphereDir.zxy * tmpvar_37.yzx));
  vec3 tmpvar_39;
  tmpvar_39 = ((cosTheta * sphereDir) + (sinTheta * normalize(
    ((tmpvar_38.yzx * sphereDir.zxy) - (tmpvar_38.zxy * sphereDir.yzx))
  )));
  float tmpvar_40;
  tmpvar_40 = dot (tmpvar_38, ((tmpvar_39.yzx * tmpvar_37.zxy) - (tmpvar_39.zxy * tmpvar_37.yzx)));
  vec3 tmpvar_41;
  if (((tmpvar_40 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_41 = tmpvar_39;
  } else {
    tmpvar_41 = tmpvar_37;
  };
  vec4 tmpvar_42;
  tmpvar_42.w = 0.0;
  tmpvar_42.xyz = tmpvar_41;
  oceanDir_35 = (_Ocean_CameraToOcean * tmpvar_42).xyz;
  float tmpvar_43;
  tmpvar_43 = (oceanDir_35.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_44;
  float tmpvar_45;
  tmpvar_45 = (2.0 * _Ocean_Radius);
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (
    ((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + tmpvar_45)))
  , 0.0)));
  float tmpvar_46;
  tmpvar_46 = ((-(_Ocean_CameraPos.z) / oceanDir_35.z) * (1.0 + (
    (_Ocean_CameraPos.z / tmpvar_45)
   * 
    (1.0 - (oceanDir_35.z * oceanDir_35.z))
  )));
  float tmpvar_47;
  tmpvar_47 = abs(((tmpvar_46 - tmpvar_44) * oceanDir_35.z));
  float tmpvar_48;
  if ((tmpvar_47 < 1.0)) {
    tmpvar_48 = tmpvar_46;
  } else {
    tmpvar_48 = tmpvar_44;
  };
  vec2 tmpvar_49;
  tmpvar_49 = ((_Ocean_CameraPos.xy + (tmpvar_48 * oceanDir_35.xy)) - tmpvar_3);
  vec3 tmpvar_50;
  tmpvar_50.xy = vec2(0.0, 0.0);
  tmpvar_50.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_50;
  if (((tmpvar_49.x != 0.0) || (tmpvar_49.y != 0.0))) {
    vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.x));
    vec2 tmpvar_52;
    tmpvar_52 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.x));
    vec4 tmpvar_53;
    tmpvar_53.z = 0.0;
    tmpvar_53.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_53.w = (0.5 * log2(max (
      dot (tmpvar_51, tmpvar_51)
    , 
      dot (tmpvar_52, tmpvar_52)
    )));
    dP_1.z = (_Ocean_HeightOffset + texture2DLod (_Ocean_Map0, tmpvar_53.xy, tmpvar_53.w).x);
    vec2 tmpvar_54;
    tmpvar_54 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.y));
    vec2 tmpvar_55;
    tmpvar_55 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.y));
    vec4 tmpvar_56;
    tmpvar_56.z = 0.0;
    tmpvar_56.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_56.w = (0.5 * log2(max (
      dot (tmpvar_54, tmpvar_54)
    , 
      dot (tmpvar_55, tmpvar_55)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_56.xy, tmpvar_56.w).y);
    vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.z));
    vec2 tmpvar_58;
    tmpvar_58 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.z));
    vec4 tmpvar_59;
    tmpvar_59.z = 0.0;
    tmpvar_59.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_59.w = (0.5 * log2(max (
      dot (tmpvar_57, tmpvar_57)
    , 
      dot (tmpvar_58, tmpvar_58)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_59.xy, tmpvar_59.w).z);
    vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.w));
    vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.w));
    vec4 tmpvar_62;
    tmpvar_62.z = 0.0;
    tmpvar_62.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_62.w = (0.5 * log2(max (
      dot (tmpvar_60, tmpvar_60)
    , 
      dot (tmpvar_61, tmpvar_61)
    )));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_62.xy, tmpvar_62.w).w);
    vec2 tmpvar_63;
    tmpvar_63 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.x));
    vec2 tmpvar_64;
    tmpvar_64 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.x));
    vec4 tmpvar_65;
    tmpvar_65.z = 0.0;
    tmpvar_65.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_65.w = (0.5 * log2(max (
      dot (tmpvar_63, tmpvar_63)
    , 
      dot (tmpvar_64, tmpvar_64)
    )));
    dP_1.xy = (_Ocean_Choppyness.x * texture2DLod (_Ocean_Map3, tmpvar_65.xy, tmpvar_65.w).xy);
    vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.y));
    vec2 tmpvar_67;
    tmpvar_67 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.y));
    vec4 tmpvar_68;
    tmpvar_68.z = 0.0;
    tmpvar_68.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_68.w = (0.5 * log2(max (
      dot (tmpvar_66, tmpvar_66)
    , 
      dot (tmpvar_67, tmpvar_67)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * texture2DLod (_Ocean_Map3, tmpvar_68.xy, tmpvar_68.w).zw));
    vec2 tmpvar_69;
    tmpvar_69 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.z));
    vec2 tmpvar_70;
    tmpvar_70 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.z));
    vec4 tmpvar_71;
    tmpvar_71.z = 0.0;
    tmpvar_71.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_71.w = (0.5 * log2(max (
      dot (tmpvar_69, tmpvar_69)
    , 
      dot (tmpvar_70, tmpvar_70)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * texture2DLod (_Ocean_Map4, tmpvar_71.xy, tmpvar_71.w).xy));
    vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.x * (tmpvar_33 / _Ocean_GridSizes.w));
    vec2 tmpvar_73;
    tmpvar_73 = (_Ocean_MapSize.y * (tmpvar_49 / _Ocean_GridSizes.w));
    vec4 tmpvar_74;
    tmpvar_74.z = 0.0;
    tmpvar_74.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_74.w = (0.5 * log2(max (
      dot (tmpvar_72, tmpvar_72)
    , 
      dot (tmpvar_73, tmpvar_73)
    )));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * texture2DLod (_Ocean_Map4, tmpvar_74.xy, tmpvar_74.w).zw));
  };
  mat3 tmpvar_75;
  tmpvar_75[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_75[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_75[2] = _Ocean_OceanToCamera[2].xyz;
  vec4 tmpvar_76;
  tmpvar_76.w = 1.0;
  tmpvar_76.xyz = ((tmpvar_17 * tmpvar_10) + (tmpvar_75 * dP_1));
  vec3 tmpvar_77;
  tmpvar_77.xy = vec2(0.0, 0.0);
  tmpvar_77.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_76);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_17 * oceanDir_4) + dP_1) + tmpvar_77);
}


#endif
#ifdef FRAGMENT
#extension GL_ARB_shader_texture_lod : enable
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
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
uniform float _Ocean_Radius;
uniform vec3 _Ocean_CameraPos;
uniform vec3 _Ocean_SunDir;
uniform vec3 _Ocean_Color;
uniform vec4 _Ocean_GridSizes;
uniform float _Ocean_WhiteCapStr;
uniform float farWhiteCapStr;
uniform sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform float _OceanAlpha;
uniform float _GlobalOceanAlpha;
uniform float alphaRadius;
uniform vec2 _VarianceMax;
float xlat_mutableRt;
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  xlat_mutableRt = Rt;
  vec2 slopes_1;
  vec3 tmpvar_2;
  tmpvar_2.xy = vec2(0.0, 0.0);
  tmpvar_2.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  vec3 tmpvar_3;
  tmpvar_3.xy = vec2(0.0, 0.0);
  tmpvar_3.z = _Ocean_Radius;
  vec3 tmpvar_4;
  tmpvar_4 = (normalize((xlv_TEXCOORD1 + tmpvar_3)) * (_Ocean_Radius + 10.0));
  vec3 x_5;
  x_5 = (tmpvar_4 - tmpvar_2);
  float tmpvar_6;
  tmpvar_6 = clamp ((sqrt(
    dot (x_5, x_5)
  ) / alphaRadius), 0.0, 1.0);
  float tmpvar_7;
  tmpvar_7 = mix (_OceanAlpha, 1.0, tmpvar_6);
  float tmpvar_8;
  tmpvar_8 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_6);
  vec3 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.z = _Ocean_CameraPos.z;
  vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 - xlv_TEXCOORD1));
  slopes_1 = texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.x)).xy;
  slopes_1 = (slopes_1 + texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.y)).zw);
  slopes_1 = (slopes_1 + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.z)).xy);
  slopes_1 = (slopes_1 + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.w)).zw);
  slopes_1 = (slopes_1 - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  vec3 tmpvar_11;
  tmpvar_11.z = 1.0;
  tmpvar_11.xy = -(slopes_1);
  vec3 tmpvar_12;
  tmpvar_12 = normalize(tmpvar_11);
  float tmpvar_13;
  tmpvar_13 = dFdx(xlv_TEXCOORD0.x);
  float tmpvar_14;
  tmpvar_14 = dFdy(xlv_TEXCOORD0.x);
  float tmpvar_15;
  tmpvar_15 = dFdx(xlv_TEXCOORD0.y);
  float tmpvar_16;
  tmpvar_16 = dFdy(xlv_TEXCOORD0.y);
  float tmpvar_17;
  tmpvar_17 = ((tmpvar_13 * tmpvar_13) + (tmpvar_15 * tmpvar_15));
  float tmpvar_18;
  tmpvar_18 = ((tmpvar_14 * tmpvar_14) + (tmpvar_16 * tmpvar_16));
  vec3 tmpvar_19;
  tmpvar_19.x = pow ((tmpvar_17 / 10.0), 0.25);
  tmpvar_19.y = (0.5 + ((0.5 * 
    ((tmpvar_13 * tmpvar_14) + (tmpvar_15 * tmpvar_16))
  ) / sqrt(
    (tmpvar_17 * tmpvar_18)
  )));
  tmpvar_19.z = pow ((tmpvar_18 / 10.0), 0.25);
  vec2 tmpvar_20;
  tmpvar_20 = max ((texture3D (_Ocean_Variance, tmpvar_19).xy * _VarianceMax), vec2(2e-05, 2e-05));
  vec3 worldP_21;
  worldP_21 = tmpvar_4;
  vec3 sunL_22;
  vec3 skyE_23;
  float r_24;
  float tmpvar_25;
  tmpvar_25 = sqrt(dot (tmpvar_4, tmpvar_4));
  r_24 = tmpvar_25;
  if ((tmpvar_25 < (0.9 * Rg))) {
    worldP_21.z = (tmpvar_4.z + Rg);
    r_24 = sqrt(dot (worldP_21, worldP_21));
  };
  vec3 tmpvar_26;
  tmpvar_26 = (worldP_21 / r_24);
  float tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, _Ocean_SunDir);
  float tmpvar_28;
  tmpvar_28 = sqrt((1.0 - (
    (Rg / r_24)
   * 
    (Rg / r_24)
  )));
  vec3 tmpvar_29;
  if ((tmpvar_27 < -(tmpvar_28))) {
    tmpvar_29 = vec3(0.0, 0.0, 0.0);
  } else {
    float y_over_x_30;
    y_over_x_30 = (((tmpvar_27 + 0.15) / 1.15) * 14.10142);
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
    vec4 tmpvar_33;
    tmpvar_33.zw = vec2(0.0, 0.0);
    tmpvar_33.x = ((tmpvar_32 * sign(y_over_x_30)) / 1.5);
    tmpvar_33.y = sqrt(((r_24 - Rg) / (Rt - Rg)));
    tmpvar_29 = texture2DLod (_Transmittance, tmpvar_33.xy, 0.0).xyz;
  };
  sunL_22 = (tmpvar_29 * _Sun_Intensity);
  vec2 tmpvar_34;
  tmpvar_34.x = ((tmpvar_27 + 0.2) / 1.2);
  float tmpvar_35;
  tmpvar_35 = (Rt - Rg);
  tmpvar_34.y = ((r_24 - Rg) / tmpvar_35);
  skyE_23 = ((2.0 * (texture2DLod (_Irradiance, tmpvar_34, 0.0).xyz * _Sun_Intensity)) * ((1.0 + 
    dot (tmpvar_26, tmpvar_12)
  ) * 0.5));
  vec3 result_36;
  result_36 = vec3(0.0, 0.0, 0.0);
  vec3 tmpvar_37;
  vec3 I_38;
  I_38 = -(tmpvar_10);
  tmpvar_37 = (I_38 - (2.0 * (
    dot (tmpvar_12, I_38)
   * tmpvar_12)));
  vec3 tmpvar_39;
  tmpvar_39.xy = tmpvar_37.xy;
  tmpvar_39.z = max (tmpvar_37.z, 0.0);
  vec3 camera_40;
  camera_40 = tmpvar_4;
  vec3 viewdir_41;
  viewdir_41.yz = tmpvar_39.yz;
  float rMu_42;
  float r_43;
  vec3 result_44;
  result_44 = vec3(0.0, 0.0, 0.0);
  xlat_mutableRt = (Rg + (tmpvar_35 * _experimentalAtmoScale));
  viewdir_41.x = (tmpvar_37.x + _viewdirOffset);
  vec3 tmpvar_45;
  tmpvar_45 = normalize(viewdir_41);
  viewdir_41 = tmpvar_45;
  float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_4, tmpvar_4));
  r_43 = tmpvar_46;
  float tmpvar_47;
  tmpvar_47 = dot (tmpvar_4, tmpvar_45);
  rMu_42 = tmpvar_47;
  float f_48;
  f_48 = (((tmpvar_47 * tmpvar_47) - (tmpvar_46 * tmpvar_46)) + (xlat_mutableRt * xlat_mutableRt));
  float tmpvar_49;
  if ((f_48 >= 0.0)) {
    tmpvar_49 = sqrt(f_48);
  } else {
    tmpvar_49 = 1e-06;
  };
  float tmpvar_50;
  tmpvar_50 = max ((-(tmpvar_47) - tmpvar_49), 0.0);
  if ((tmpvar_50 > 0.0)) {
    camera_40 = (tmpvar_4 + (tmpvar_50 * tmpvar_45));
    rMu_42 = (tmpvar_47 + tmpvar_50);
    r_43 = xlat_mutableRt;
  };
  float tmpvar_51;
  tmpvar_51 = dot (tmpvar_45, _Ocean_SunDir);
  float tmpvar_52;
  tmpvar_52 = (dot (camera_40, _Ocean_SunDir) / r_43);
  vec4 tmpvar_53;
  float _lerp_54;
  float tmpvar_55;
  float tmpvar_56;
  tmpvar_56 = (Rg * Rg);
  tmpvar_55 = sqrt(((xlat_mutableRt * xlat_mutableRt) - tmpvar_56));
  float tmpvar_57;
  tmpvar_57 = sqrt(((r_43 * r_43) - tmpvar_56));
  float tmpvar_58;
  tmpvar_58 = (r_43 * (rMu_42 / r_43));
  float tmpvar_59;
  tmpvar_59 = (((tmpvar_58 * tmpvar_58) - (r_43 * r_43)) + tmpvar_56);
  vec4 tmpvar_60;
  if (((tmpvar_58 < 0.0) && (tmpvar_59 > 0.0))) {
    vec4 tmpvar_61;
    tmpvar_61.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_61.w = (0.5 - (0.5 / RES_MU));
    tmpvar_60 = tmpvar_61;
  } else {
    vec4 tmpvar_62;
    tmpvar_62.x = -1.0;
    tmpvar_62.y = (tmpvar_55 * tmpvar_55);
    tmpvar_62.z = tmpvar_55;
    tmpvar_62.w = (0.5 + (0.5 / RES_MU));
    tmpvar_60 = tmpvar_62;
  };
  float tmpvar_63;
  tmpvar_63 = ((0.5 / RES_R) + ((tmpvar_57 / tmpvar_55) * (1.0 - 
    (1.0/(RES_R))
  )));
  float tmpvar_64;
  tmpvar_64 = (tmpvar_60.w + ((
    ((tmpvar_58 * tmpvar_60.x) + sqrt((tmpvar_59 + tmpvar_60.y)))
   / 
    (tmpvar_57 + tmpvar_60.z)
  ) * (0.5 - 
    (1.0/(RES_MU))
  )));
  float y_over_x_65;
  y_over_x_65 = (max (tmpvar_52, -0.1975) * 5.349625);
  float tmpvar_66;
  tmpvar_66 = (min (abs(y_over_x_65), 1.0) / max (abs(y_over_x_65), 1.0));
  float tmpvar_67;
  tmpvar_67 = (tmpvar_66 * tmpvar_66);
  tmpvar_67 = (((
    ((((
      ((((-0.01213232 * tmpvar_67) + 0.05368138) * tmpvar_67) - 0.1173503)
     * tmpvar_67) + 0.1938925) * tmpvar_67) - 0.3326756)
   * tmpvar_67) + 0.9999793) * tmpvar_66);
  tmpvar_67 = (tmpvar_67 + (float(
    (abs(y_over_x_65) > 1.0)
  ) * (
    (tmpvar_67 * -2.0)
   + 1.570796)));
  float tmpvar_68;
  tmpvar_68 = ((0.5 / RES_MU_S) + ((
    (((tmpvar_67 * sign(y_over_x_65)) / 1.1) + 0.74)
   * 0.5) * (1.0 - 
    (1.0/(RES_MU_S))
  )));
  float tmpvar_69;
  tmpvar_69 = (((tmpvar_51 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_70;
  tmpvar_70 = floor(tmpvar_69);
  _lerp_54 = (tmpvar_69 - tmpvar_70);
  float tmpvar_71;
  tmpvar_71 = (floor((
    (tmpvar_63 * RES_R)
   - 1.0)) / RES_R);
  float tmpvar_72;
  tmpvar_72 = (floor((tmpvar_63 * RES_R)) / RES_R);
  float tmpvar_73;
  tmpvar_73 = fract((tmpvar_63 * RES_R));
  vec4 tmpvar_74;
  tmpvar_74.zw = vec2(0.0, 0.0);
  tmpvar_74.x = ((tmpvar_70 + tmpvar_68) / RES_NU);
  tmpvar_74.y = ((tmpvar_64 / RES_R) + tmpvar_71);
  vec4 tmpvar_75;
  tmpvar_75.zw = vec2(0.0, 0.0);
  tmpvar_75.x = (((tmpvar_70 + tmpvar_68) + 1.0) / RES_NU);
  tmpvar_75.y = ((tmpvar_64 / RES_R) + tmpvar_71);
  vec4 tmpvar_76;
  tmpvar_76.zw = vec2(0.0, 0.0);
  tmpvar_76.x = ((tmpvar_70 + tmpvar_68) / RES_NU);
  tmpvar_76.y = ((tmpvar_64 / RES_R) + tmpvar_72);
  vec4 tmpvar_77;
  tmpvar_77.zw = vec2(0.0, 0.0);
  tmpvar_77.x = (((tmpvar_70 + tmpvar_68) + 1.0) / RES_NU);
  tmpvar_77.y = ((tmpvar_64 / RES_R) + tmpvar_72);
  tmpvar_53 = (((
    (texture2DLod (_Inscatter, tmpvar_74.xy, 0.0) * (1.0 - _lerp_54))
   + 
    (texture2DLod (_Inscatter, tmpvar_75.xy, 0.0) * _lerp_54)
  ) * (1.0 - tmpvar_73)) + ((
    (texture2DLod (_Inscatter, tmpvar_76.xy, 0.0) * (1.0 - _lerp_54))
   + 
    (texture2DLod (_Inscatter, tmpvar_77.xy, 0.0) * _lerp_54)
  ) * tmpvar_73));
  if ((r_43 <= xlat_mutableRt)) {
    float tmpvar_78;
    tmpvar_78 = (mieG * mieG);
    result_44 = ((tmpvar_53.xyz * (
      (3.0 / (16.0 * M_PI))
     * 
      (1.0 + (tmpvar_51 * tmpvar_51))
    )) + ((
      ((tmpvar_53.xyz * tmpvar_53.w) / max (tmpvar_53.x, 0.0001))
     * 
      (betaR.x / betaR)
    ) * (
      ((((1.5 / 
        (4.0 * M_PI)
      ) * (1.0 - tmpvar_78)) * pow ((
        (1.0 + tmpvar_78)
       - 
        ((2.0 * mieG) * tmpvar_51)
      ), -1.5)) * (1.0 + (tmpvar_51 * tmpvar_51)))
     / 
      (2.0 + tmpvar_78)
    )));
  } else {
    result_44 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_79;
  tmpvar_79 = sqrt(tmpvar_20.x);
  result_36 = ((result_44 * _Sun_Intensity) * (pow (
    (1.0 - dot (tmpvar_10, tmpvar_12))
  , 
    (5.0 * exp((-2.69 * tmpvar_79)))
  ) / (1.0 + 
    (22.7 * pow (tmpvar_79, 1.5))
  )));
  vec3 tmpvar_80;
  tmpvar_80 = normalize((_Ocean_SunDir + tmpvar_10));
  float tmpvar_81;
  tmpvar_81 = dot (tmpvar_80, tmpvar_12);
  float tmpvar_82;
  tmpvar_82 = (exp((
    (-2.0 * ((1.0 - (tmpvar_81 * tmpvar_81)) / tmpvar_20.x))
   / 
    (1.0 + tmpvar_81)
  )) / (12.56637 * tmpvar_20.x));
  float tmpvar_83;
  tmpvar_83 = (1.0 - dot (tmpvar_10, tmpvar_80));
  float tmpvar_84;
  tmpvar_84 = (tmpvar_83 * tmpvar_83);
  float tmpvar_85;
  tmpvar_85 = (0.02 + ((0.98 * tmpvar_84) * (tmpvar_84 * tmpvar_83)));
  float tmpvar_86;
  tmpvar_86 = max (dot (_Ocean_SunDir, tmpvar_12), 0.01);
  float tmpvar_87;
  tmpvar_87 = max (dot (tmpvar_10, tmpvar_12), 0.01);
  float tmpvar_88;
  if ((tmpvar_86 <= 0.0)) {
    tmpvar_88 = 0.0;
  } else {
    tmpvar_88 = max (((tmpvar_85 * tmpvar_82) * sqrt(
      abs((tmpvar_86 / tmpvar_87))
    )), 0.0);
  };
  float tmpvar_89;
  tmpvar_89 = sqrt(tmpvar_20.x);
  vec4 tmpvar_90;
  tmpvar_90 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.x));
  vec4 tmpvar_91;
  tmpvar_91 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.y));
  vec4 tmpvar_92;
  tmpvar_92 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.z));
  vec4 tmpvar_93;
  tmpvar_93 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.w));
  vec2 tmpvar_94;
  tmpvar_94 = ((tmpvar_90.xy + tmpvar_91.zw) + (tmpvar_92.xy + tmpvar_93.zw));
  float x_95;
  x_95 = ((0.7071068 * (tmpvar_8 - tmpvar_94.x)) * inversesqrt(max (
    (tmpvar_94.y - (((
      (tmpvar_90.x * tmpvar_90.x)
     + 
      (tmpvar_91.z * tmpvar_91.z)
    ) + (tmpvar_92.x * tmpvar_92.x)) + (tmpvar_93.z * tmpvar_93.z)))
  , 0.0)));
  float tmpvar_96;
  tmpvar_96 = (x_95 * x_95);
  float tmpvar_97;
  tmpvar_97 = (0.140012 * tmpvar_96);
  vec3 L_98;
  L_98 = (((
    ((tmpvar_88 * sunL_22) + result_36)
   + 
    ((((0.98 * 
      (1.0 - (pow ((1.0 - 
        dot (tmpvar_10, tmpvar_12)
      ), (5.0 * 
        exp((-2.69 * tmpvar_89))
      )) / (1.0 + (22.7 * 
        pow (tmpvar_89, 1.5)
      ))))
    ) * _Ocean_Color) * skyE_23) / 3.141593)
  ) + (
    (((0.5 * (
      sign(x_95)
     * 
      sqrt((1.0 - exp((
        (-(tmpvar_96) * (1.273239 + tmpvar_97))
       / 
        (1.0 + tmpvar_97)
      ))))
    )) + 0.5) * (((sunL_22 * 
      max (dot (tmpvar_12, _Ocean_SunDir), 0.0)
    ) + skyE_23) / 3.141593))
   * 0.4)) * _Exposure);
  float tmpvar_99;
  if ((L_98.x < 1.413)) {
    tmpvar_99 = pow ((L_98.x * 0.38317), 0.4545454);
  } else {
    tmpvar_99 = (1.0 - exp(-(L_98.x)));
  };
  L_98.x = tmpvar_99;
  float tmpvar_100;
  if ((L_98.y < 1.413)) {
    tmpvar_100 = pow ((L_98.y * 0.38317), 0.4545454);
  } else {
    tmpvar_100 = (1.0 - exp(-(L_98.y)));
  };
  L_98.y = tmpvar_100;
  float tmpvar_101;
  if ((L_98.z < 1.413)) {
    tmpvar_101 = pow ((L_98.z * 0.38317), 0.4545454);
  } else {
    tmpvar_101 = (1.0 - exp(-(L_98.z)));
  };
  L_98.z = tmpvar_101;
  vec4 tmpvar_102;
  tmpvar_102.xyz = L_98;
  tmpvar_102.w = (tmpvar_7 * _GlobalOceanAlpha);
  gl_FragData[0] = tmpvar_102;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 252 math, 16 textures, 2 branches
Keywords { "SKY_REFLECTIONS_ON" }
Bind "vertex" Vertex
Matrix 0 [_Globals_CameraToScreen]
Matrix 10 [_Globals_ScreenToCamera] 3
Matrix 7 [_Ocean_CameraToOcean] 3
Matrix 4 [_Ocean_OceanToCamera] 3
Vector 15 [_Ocean_CameraPos]
Vector 20 [_Ocean_Choppyness]
Vector 21 [_Ocean_GridSizes]
Float 14 [_Ocean_HeightOffset]
Vector 19 [_Ocean_MapSize]
Float 13 [_Ocean_Radius]
Vector 22 [_Ocean_ScreenGridSize]
Float 17 [cosTheta]
Float 18 [sinTheta]
Vector 16 [sphereDir]
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
"vs_3_0
def c23, 1.25, 0, 1, 2
def c24, 0.5, 0, 0, 0
dcl_position v0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
mul r0.xy, c23.x, v0
mad r1.xyz, v0.xyxw, c23.xxyw, c23.yyzw
dp3 r2.x, c10.xyww, r1
dp3 r2.y, c11.xyww, r1
dp3 r2.z, c12.xyww, r1
dp3 r0.w, r2, r2
rsq r0.w, r0.w
mul r1.xyz, r0.w, r2
mul r3.xyz, r1.yzxw, c16.zxyw
mad r3.xyz, c16.yzxw, r1.zxyw, -r3
mul r4.xyz, r3.zxyw, c16.yzxw
mad r4.xyz, r3.yzxw, c16.zxyw, -r4
nrm r5.xyz, r4
mov r4.xyz, c16
mul r4.xyz, r4, c17.x
mad r5.xyz, c18.x, r5, r4
mul r6.xyz, r1.yzxw, r5.zxyw
mad r6.xyz, r5.yzxw, r1.zxyw, -r6
dp3 r1.w, r3, r6
slt r1.w, c23.y, r1.w
mov r3, c23
slt r2.w, r3.y, c15.z
mul r1.w, r1.w, r2.w
mad r2.xyz, r2, -r0.w, r5
mad r1.xyz, r1.w, r2, r1
dp3 r2.x, c7, r1
dp3 r2.y, c8, r1
dp3 r2.z, c9, r1
mov r5.z, c15.z
add r0.w, r5.z, c13.x
mul r1.w, r0.w, r2.z
add r4.w, c13.x, c13.x
mad r3.w, c13.x, r3.w, r5.z
mul r3.w, r3.w, c15.z
mad r1.w, r1.w, r1.w, -r3.w
max r1.w, r1.w, c23.y
rsq r1.w, r1.w
rcp r1.w, r1.w
mad r1.w, r2.z, -r0.w, -r1.w
rcp r5.x, r2.z
mul r5.x, r5.x, -c15.z
rcp r4.w, r4.w
mul r4.w, r4.w, c15.z
mad r5.y, r2.z, -r2.z, c23.z
mad r5.y, r4.w, r5.y, c23.z
mad r5.x, r5.x, r5.y, -r1.w
mul r5.y, r2.z, r5.x
slt r5.y, r5_abs.y, c23.z
mad r1.w, r5.y, r5.x, r1.w
mad r5.xy, r1.w, r2, c15
mov r6.x, r0.x
mad r6.y, v0.y, r3.x, c22.y
mad r6.zw, v0.x, c23.xyxy, c23.xyyz
dp3 r7.x, c10.yxww, r6.yzww
dp3 r7.y, c11.xyww, r6.xyww
dp3 r7.z, c12.xyww, r6.xyww
dp3 r5.z, r7, r7
rsq r5.z, r5.z
mul r6.xyz, r5.z, r7
mul r8.xyz, r6.yzxw, c16.zxyw
mad r8.xyz, c16.yzxw, r6.zxyw, -r8
mul r9.xyz, r8.zxyw, c16.yzxw
mad r9.xyz, r8.yzxw, c16.zxyw, -r9
nrm r10.xyz, r9
mad r9.xyz, c18.x, r10, r4
mul r10.xyz, r6.yzxw, r9.zxyw
mad r10.xyz, r9.yzxw, r6.zxyw, -r10
dp3 r5.w, r8, r10
slt r5.w, c23.y, r5.w
mul r5.w, r2.w, r5.w
mad r7.xyz, r7, -r5.z, r9
mad r6.xyz, r5.w, r7, r6
dp3 r7.x, c7, r6
dp3 r7.y, c8, r6
dp3 r5.z, c9, r6
mul r5.w, r0.w, r5.z
mad r5.w, r5.w, r5.w, -r3.w
max r5.w, r5.w, c23.y
rsq r5.w, r5.w
rcp r5.w, r5.w
mad r5.w, r5.z, -r0.w, -r5.w
rcp r6.x, r5.z
mul r6.x, r6.x, -c15.z
mad r6.y, r5.z, -r5.z, c23.z
mad r6.y, r4.w, r6.y, c23.z
mad r6.x, r6.x, r6.y, -r5.w
mul r5.z, r5.z, r6.x
slt r5.z, r5_abs.z, c23.z
mad r5.z, r5.z, r6.x, r5.w
mad r5.zw, r5.z, r7.xyxy, c15.xyxy
add r5.zw, -r5.xyxy, r5
slt r6.xy, -r5_abs.zwzw, r5_abs.zwzw
add r6.x, r6.y, r6.x
if_lt -r6.x, r6.x
mad r0.x, v0.x, r3.x, c22.x
mov r0.z, c23.z
dp3 r6.x, c10.xyww, r0
dp3 r6.y, c11.xyww, r0
dp3 r6.z, c12.xyww, r0
dp3 r0.x, r6, r6
rsq r0.x, r0.x
mul r7.xyz, r0.x, r6
mul r8.xyz, r7.yzxw, c16.zxyw
mad r8.xyz, c16.yzxw, r7.zxyw, -r8
mul r9.xyz, r8.zxyw, c16.yzxw
mad r9.xyz, r8.yzxw, c16.zxyw, -r9
nrm r10.xyz, r9
mad r4.xyz, c18.x, r10, r4
mul r9.xyz, r7.yzxw, r4.zxyw
mad r9.xyz, r4.yzxw, r7.zxyw, -r9
dp3 r0.y, r8, r9
slt r0.y, c23.y, r0.y
mul r0.y, r2.w, r0.y
mad r4.xyz, r6, -r0.x, r4
mad r0.xyz, r0.y, r4, r7
dp3 r4.x, c7, r0
dp3 r4.y, c8, r0
dp3 r0.x, c9, r0
mul r0.y, r0.w, r0.x
mad r0.y, r0.y, r0.y, -r3.w
max r0.y, r0.y, c23.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.y, r0.x, -r0.w, -r0.y
rcp r0.z, r0.x
mul r0.z, r0.z, -c15.z
mad r0.w, r0.x, -r0.x, c23.z
mad r0.w, r4.w, r0.w, c23.z
mad r0.z, r0.z, r0.w, -r0.y
mul r0.x, r0.x, r0.z
slt r0.x, r0_abs.x, c23.z
mad r0.x, r0.x, r0.z, r0.y
mad r0.xy, r0.x, r4, c15
add r0.xy, -r5, r0
rcp r0.z, c21.x
mul r4.xy, r0.z, r5
mul r3.xw, r0.z, r0.xyzy
mul r0.zw, r0.z, r5
mul r3.xw, r3, c19.x
mul r0.zw, r0, c19.y
mul r3.xw, r3, r3
add r2.w, r3.w, r3.x
mul r0.zw, r0, r0
add r0.z, r0.w, r0.z
max r0.z, r0.z, r2.w
log r0.z, r0.z
mul r4.w, r0.z, c24.x
mov r4.z, c23.y
texldl r6, r4, s0
add r0.z, r6.x, c14.x
rcp r0.w, c21.y
mul r6.xy, r0.w, r5
mul r3.xw, r0.w, r0.xyzy
mul r7.xy, r0.w, r5.zwzw
mul r3.xw, r3, c19.x
mul r7.xy, r7, c19.y
mul r3.xw, r3, r3
add r0.w, r3.w, r3.x
mul r3.xw, r7.xyzy, r7.xyzy
add r2.w, r3.w, r3.x
max r0.w, r0.w, r2.w
log r0.w, r0.w
mul r6.w, r0.w, c24.x
mov r6.z, c23.y
texldl r7, r6, s0
add r0.z, r0.z, r7.y
rcp r0.w, c21.z
mul r7.xy, r0.w, r5
mul r3.xw, r0.w, r0.xyzy
mul r8.xy, r0.w, r5.zwzw
mul r3.xw, r3, c19.x
mul r8.xy, r8, c19.y
mul r3.xw, r3, r3
add r0.w, r3.w, r3.x
mul r3.xw, r8.xyzy, r8.xyzy
add r2.w, r3.w, r3.x
max r0.w, r0.w, r2.w
log r0.w, r0.w
mul r7.w, r0.w, c24.x
mov r7.z, c23.y
texldl r8, r7, s0
add r0.z, r0.z, r8.z
rcp r0.w, c21.w
mul r8.xy, r0.w, r5
mul r0.xy, r0.w, r0
mul r3.xw, r0.w, r5.zyzw
mul r0.xy, r0, c19.x
mul r3.xw, r3, c19.y
mul r0.xy, r0, r0
add r0.x, r0.y, r0.x
mul r0.yw, r3.xxzw, r3.xxzw
add r0.y, r0.w, r0.y
max r0.x, r0.y, r0.x
log r0.x, r0.x
mul r8.w, r0.x, c24.x
mov r8.z, c23.y
texldl r9, r8, s0
add r0.z, r0.z, r9.w
texldl r4, r4, s1
texldl r6, r6, s1
mul r3.xw, r6.zyzw, c20.y
mad r3.xw, c20.x, r4.xyzy, r3
texldl r4, r7, s2
mad r3.xw, c20.z, r4.xyzy, r3
texldl r4, r8, s2
mad r0.xy, c20.w, r4.zwzw, r3.xwzw
else
mul r0.xyz, r3.yyzw, c14.x
endif
dp3 r4.x, c4, r0
dp3 r4.y, c5, r0
dp3 r4.z, c6, r0
mad r4.xyz, r1.w, r1, r4
mad r0.xyz, r1.w, r2, r0
mad o2.xyz, c15.z, r3.yyzw, r0
mov r4.w, c23.z
dp4 o0.x, c0, r4
dp4 o0.y, c1, r4
dp4 o0.z, c2, r4
dp4 o0.w, c3, r4
mov o1.xy, r5

"
}
SubProgram "d3d11 " {
// Stats: 167 math, 2 branches
Keywords { "SKY_REFLECTIONS_ON" }
Bind "vertex" Vertex
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
ConstBuffer "$Globals" 992
Matrix 272 [_Ocean_OceanToCamera]
Matrix 336 [_Ocean_CameraToOcean]
Matrix 432 [_Globals_ScreenToCamera]
Matrix 624 [_Globals_CameraToScreen]
Float 252 [_Ocean_Radius]
Float 256 [_Ocean_HeightOffset]
Vector 260 [_Ocean_CameraPos] 3
Vector 400 [sphereDir] 3
Float 412 [cosTheta]
Float 416 [sinTheta]
Vector 864 [_Ocean_MapSize] 2
Vector 880 [_Ocean_Choppyness]
Vector 928 [_Ocean_GridSizes]
Vector 944 [_Ocean_ScreenGridSize] 2
BindCB  "$Globals" 0
"vs_4_0
root12:adabadaa
eefiecedjodgeeeplfijhcehdmbfifnkpieijehcabaaaaaamebjaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefckmbiaaaaeaaaabaaclagaaaa
fjaaaaaeegiocaaaaaaaaaaadmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafpaaaaaddcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacajaaaaaa
diaaaaakdcaabaaaaaaaaaaaegbabaaaaaaaaaaaaceaaaaaaaaakadpaaaakadp
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabmaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaablaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaajgaebaaaabaaaaaacgijcaaaaaaaaaaabjaaaaaadcaaaaal
hcaabaaaacaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaacgajbaaaacaaaaaajgiecaaa
aaaaaaaabjaaaaaadcaaaaalhcaabaaaadaaaaaajgaebaaaacaaaaaacgijcaaa
aaaaaaaabjaaaaaaegacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaajhcaabaaaaeaaaaaaegiccaaaaaaaaaaabjaaaaaapgipcaaaaaaaaaaa
bjaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaabkaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaajgaebaaaabaaaaaa
cgajbaaaadaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaadaaaaaacgajbaaa
abaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaafaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkiacaaa
aaaaaaaabaaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
aaaaaaaabgaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaabfaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaabhaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajecaabaaa
aaaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaabaaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaaapaaaaaadcaaaaal
bcaabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaaabeaaaaaaaaaaaeadkiacaaa
aaaaaaaabaaaaaaadiaaaaaibcaabaaaadaaaaaaakaabaaaadaaaaaadkiacaaa
aaaaaaaabaaaaaaadcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalicaabaaaabaaaaaackaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaaaoaaaaajccaabaaaadaaaaaadkiacaiaebaaaaaa
aaaaaaaabaaaaaaackaabaaaacaaaaaaaoaaaaaiicaabaaaacaaaaaadkiacaaa
aaaaaaaabaaaaaaadkaabaaaacaaaaaadcaaaaakecaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaahccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadbaaaaai
ccaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdhaaaaaj
icaabaaaabaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaa
dcaaaaakgcaabaaaadaaaaaapgapbaaaabaaaaaaagabbaaaacaaaaaafgigcaaa
aaaaaaaabaaaaaaadcaaaaakicaabaaaadaaaaaabkbabaaaaaaaaaaaabeaaaaa
aaaakadpbkiacaaaaaaaaaaadlaaaaaadiaaaaaihcaabaaaafaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaabmaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaa
aaaaaaaablaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaaihcaabaaaagaaaaaajgaebaaaafaaaaaacgijcaaaaaaaaaaa
bjaaaaaadcaaaaalhcaabaaaagaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaaihcaabaaaahaaaaaacgajbaaa
agaaaaaajgiecaaaaaaaaaaabjaaaaaadcaaaaalhcaabaaaahaaaaaajgaebaaa
agaaaaaacgijcaaaaaaaaaaabjaaaaaaegacbaiaebaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaaagaabaaaaaaaaaaa
egacbaaaahaaaaaadcaaaaakhcaabaaaahaaaaaaagiacaaaaaaaaaaabkaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
afaaaaaacgajbaaaahaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaahaaaaaa
cgajbaaaafaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaagaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaafaaaaaa
egiccaaaaaaaaaaabgaaaaaadcaaaaaklcaabaaaafaaaaaaegiicaaaaaaaaaaa
bfaaaaaaagaabaaaafaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaafaaaaaa
egiccaaaaaaaaaaabhaaaaaakgakbaaaafaaaaaaegadbaaaafaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaia
ebaaaaaaafaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaaj
icaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaackaabaaaafaaaaaa
dcaaaaakicaabaaaaeaaaaaackaabaiaebaaaaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaaeaaaaaadcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaadaaaaaackaabaaa
afaaaaaadkaabaaaadaaaaaadbaaaaaiicaabaaaadaaaaaadkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpdhaaaaajbcaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaafaaaaaaakaabaaaaaaaaaaadcaaaaakpcaabaaaafaaaaaaagaabaaa
aaaaaaaaegaebaaaafaaaaaajgijcaaaaaaaaaaabaaaaaaaaaaaaaaipcaabaaa
afaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaafaaaaaadjaaaaakdcaabaaa
agaaaaaaogakbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dmaaaaahbcaabaaaaaaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaabpaaaead
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaa
aaaakadpakiacaaaaaaaaaaadlaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabmaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaa
aaaaaaaablaaaaaaagaabaaaaaaaaaaaegacbaaaagaaaaaaaaaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaaboaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
agaaaaaadiaaaaaihcaabaaaahaaaaaajgaebaaaagaaaaaacgijcaaaaaaaaaaa
bjaaaaaadcaaaaalhcaabaaaahaaaaaajgiecaaaaaaaaaaabjaaaaaacgajbaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaaihcaabaaaaiaaaaaacgajbaaa
ahaaaaaajgiecaaaaaaaaaaabjaaaaaadcaaaaalhcaabaaaaiaaaaaajgaebaaa
ahaaaaaacgijcaaaaaaaaaaabjaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaagaabaaaaaaaaaaa
egacbaaaaiaaaaaadcaaaaakhcaabaaaaeaaaaaaagiacaaaaaaaaaaabkaaaaaa
egacbaaaaiaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
agaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaaeaaaaaa
cgajbaaaagaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaahaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaa
aeaaaaaaegaibaaaagaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabgaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
bfaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaaaaaaaaabhaaaaaapgapbaaaaaaaaaaaegaibaaaaeaaaaaadiaaaaah
icaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakbcaabaaa
adaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaalecaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaaaoaaaaaj
bcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaabaaaaaaadkaabaaaaaaaaaaa
dcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaadcaaaaakicaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaebaaaaaaaaaaajgijcaaaaaaaaaaabaaaaaaaaaaaaaaipcaabaaa
aaaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaaaaaaaaaaoaaaaaipcaabaaa
aeaaaaaajgajbaaaadaaaaaaagifcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaa
agaaaaaaogaobaaaaaaaaaaaagifcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaa
ahaaaaaaogaobaaaafaaaaaaagifcaaaaaaaaaaadkaaaaaadiaaaaaipcaabaaa
agaaaaaaegaobaaaagaaaaaaagiacaaaaaaaaaaadgaaaaaadiaaaaaipcaabaaa
ahaaaaaaegaobaaaahaaaaaafgifcaaaaaaaaaaadgaaaaaaapaaaaahicaabaaa
acaaaaaaegaabaaaagaaaaaaegaabaaaagaaaaaaapaaaaahbcaabaaaadaaaaaa
egaabaaaahaaaaaaegaabaaaahaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaacpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpeiaaaaal
pcaabaaaaiaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaadaaaaaaakaabaaaaiaaaaaaakiacaaa
aaaaaaaabaaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaaagaaaaaaogakbaaa
agaaaaaaapaaaaahbcaabaaaagaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaa
deaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaacpaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaaagaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaa
jgajbaaaadaaaaaakgipcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaakgipcaaaaaaaaaaadkaaaaaaaoaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaakgipcaaaaaaaaaaadkaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagiacaaaaaaaaaaadgaaaaaadiaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaafgifcaaaaaaaaaaadgaaaaaaapaaaaahbcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahccaabaaaaaaaaaaaegaabaaa
afaaaaaaegaabaaaafaaaaaadeaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaa
akaabaaaaaaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaa
ahaaaaaaegaabaaaagaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaadaaaaaackaabaaaahaaaaaa
apaaaaahecaabaaaaaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaogakbaaaafaaaaaaogakbaaaafaaaaaadeaaaaahecaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaacpaaaaafecaabaaaaaaaaaaa
ckaabaaaaaaaaaaadiaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaa
aaaaaadpeiaaaaalpcaabaaaafaaaaaaogakbaaaagaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaackaabaaaaaaaaaaaaaaaaaahecaabaaaafaaaaaabkaabaaa
aaaaaaaadkaabaaaafaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadkaabaaaacaaaaaaeiaaaaalpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadkaabaaa
adaaaaaadiaaaaaikcaabaaaaaaaaaaakgaobaaaaeaaaaaafgifcaaaaaaaaaaa
dhaaaaaadcaaaaakkcaabaaaaaaaaaaaagiacaaaaaaaaaaadhaaaaaaagaebaaa
ahaaaaaafganbaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaagaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaakgikcaaaaaaaaaaadhaaaaaaegaabaaaaeaaaaaangafbaaaaaaaaaaa
eiaaaaalpcaabaaaaeaaaaaaogakbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaackaabaaaaaaaaaaadcaaaaakdcaabaaaafaaaaaapgipcaaaaaaaaaaa
dhaaaaaaogakbaaaaeaaaaaaegaabaaaaaaaaaaabcaaaaabdgaaaaafbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaaakiacaaaaaaaaaaa
baaaaaaadgaaaaafhcaabaaaafaaaaaaagacbaaaaaaaaaaabfaaaaabdiaaaaai
hcaabaaaaaaaaaaafgafbaaaafaaaaaaegiccaaaaaaaaaaabcaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaabbaaaaaaagaabaaaafaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaabdaaaaaakgakbaaa
afaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaacaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaaaaaaaaaabaaaaaaa
aaaaaaahhccabaaaacaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaciaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaachaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaacjaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaackaaaaaadgaaaaafdccabaaaabaaaaaajgafbaaaadaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES
#version 100

#ifdef VERTEX
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_NO_LINEAR_COLORSPACE
    #define UNITY_NO_LINEAR_COLORSPACE 1
#endif
#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 524
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal _glesNormal
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
#line 273
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 439
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 433
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 32
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
#line 40
uniform highp vec4 _ZBufferParams;
#line 46
uniform highp vec4 unity_OrthoParams;
#line 51
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 56
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
#line 69
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 74
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
#line 79
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 87
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 91
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 95
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 101
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 108
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 112
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 127
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 134
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 144
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 154
uniform highp mat4 glstate_matrix_projection;
uniform lowp vec4 glstate_lightmodel_ambient;
#line 160
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 165
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 175
uniform lowp vec4 unity_FogColor;
#line 180
uniform highp vec4 unity_FogParams;
#line 188
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 193
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 198
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 206
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 210
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 215
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 8
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 unity_ColorSpaceDouble;
uniform mediump vec4 unity_ColorSpaceDielectricSpec;
uniform mediump vec4 unity_ColorSpaceLuminance;
#line 61
#line 67
#line 73
#line 80
#line 95
#line 102
#line 117
#line 124
#line 131
#line 149
#line 182
#line 207
#line 213
#line 235
#line 252
#line 279
#line 290
#line 300
#line 330
#line 347
#line 352
#line 359
#line 372
#line 387
#line 392
uniform mediump vec4 unity_Lightmap_HDR;
#line 403
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 416
#line 445
#line 451
#line 461
#line 470
#line 477
#line 486
#line 494
#line 503
#line 522
#line 528
#line 536
#line 547
#line 552
#line 574
#line 599
#line 622
#line 631
#line 641
#line 676
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
#line 33
#line 37
#line 42
#line 70
#line 88
#line 92
#line 100
#line 104
#line 29
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
#line 43
#line 74
#line 82
#line 95
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 99
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp mat4 _Globals_WorldToOcean;
uniform highp mat4 _Globals_OceanToWorld;
#line 104
uniform highp vec3 _Globals_Origin;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec2 _Ocean_MapSize;
#line 108
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
#line 112
uniform highp vec2 _Ocean_ScreenGridSize;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
#line 116
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
#line 120
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 125
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
#line 129
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 141
#line 43
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc, out highp float t, out highp vec3 cameraDir, out highp vec3 oceanDir ) {
    highp float h = _Ocean_CameraPos.z;
    #line 47
    highp vec4 v = vec4( vert.x, vert.y, 0.0, 1.0);
    cameraDir = normalize((stoc * v).xyz);
    highp vec3 n1 = cross( sphereDir, cameraDir);
    #line 51
    highp vec3 n2 = normalize(cross( n1, sphereDir));
    highp vec3 hor = ((cosTheta * sphereDir) + (sinTheta * n2));
    #line 55
    cameraDir = (( ((dot( n1, cross( hor, cameraDir)) > 0.0) && (h > 0.0)) ) ? ( hor ) : ( cameraDir ));
    #line 59
    oceanDir = (_Ocean_CameraToOcean * vec4( cameraDir, 0.0)).xyz;
    highp float cz = _Ocean_CameraPos.z;
    highp float dz = oceanDir.z;
    highp float radius = _Ocean_Radius;
    #line 65
    highp float b = (dz * (cz + radius));
    highp float c = (cz * (cz + (2.0 * radius)));
    highp float tSphere = ((-b) - sqrt(max( ((b * b) - c), 0.0)));
    highp float tApprox = (((-cz) / dz) * (1.0 + ((cz / (2.0 * radius)) * (1.0 - (dz * dz)))));
    #line 69
    t = (( (abs(((tApprox - tSphere) * dz)) < 1.0) ) ? ( tApprox ) : ( tSphere ));
    return (_Ocean_CameraPos.xy + (t * oceanDir.xy));
}
#line 74
highp vec2 OceanPos( in highp vec4 vert, in highp mat4 stoc ) {
    highp float t;
    highp vec3 cameraDir;
    #line 78
    highp vec3 oceanDir;
    return OceanPos( vert, stoc, t, cameraDir, oceanDir);
}
#line 82
highp vec4 Tex2DGrad( in sampler2D tex, in highp vec2 uv, in highp vec2 dx, in highp vec2 dy, in highp vec2 texSize ) {
    #line 86
    highp vec2 px = (texSize.x * dx);
    highp vec2 py = (texSize.y * dy);
    highp float lod = (0.5 * log2(max( dot( px, px), dot( py, py))));
    return xll_tex2Dlod( tex, vec4( uv, 0.0, lod));
}
#line 141
v2f vert( in appdata_base v ) {
    highp float t;
    highp vec3 cameraDir;
    highp vec3 oceanDir;
    #line 146
    highp vec4 vert = v.vertex;
    vert.xy *= 1.25;
    highp vec2 u = OceanPos( vert, _Globals_ScreenToCamera, t, cameraDir, oceanDir);
    #line 150
    highp vec2 dux = (OceanPos( (vert + vec4( _Ocean_ScreenGridSize.x, 0.0, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    highp vec2 duy = (OceanPos( (vert + vec4( 0.0, _Ocean_ScreenGridSize.y, 0.0, 0.0)), _Globals_ScreenToCamera) - u);
    #line 154
    highp vec3 dP = vec3( 0.0, 0.0, _Ocean_HeightOffset);
    if (((duy.x != 0.0) || (duy.y != 0.0))){
        #line 158
        highp vec4 GRID_SIZES = _Ocean_GridSizes;
        highp vec4 CHOPPYNESS = _Ocean_Choppyness;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).x;
        #line 162
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).y;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).z;
        dP.z += Tex2DGrad( _Ocean_Map0, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).w;
        #line 171
        dP.xy += (CHOPPYNESS.x * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.x), (dux / GRID_SIZES.x), (duy / GRID_SIZES.x), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.y * Tex2DGrad( _Ocean_Map3, (u / GRID_SIZES.y), (dux / GRID_SIZES.y), (duy / GRID_SIZES.y), _Ocean_MapSize).zw);
        dP.xy += (CHOPPYNESS.z * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.z), (dux / GRID_SIZES.z), (duy / GRID_SIZES.z), _Ocean_MapSize).xy);
        dP.xy += (CHOPPYNESS.w * Tex2DGrad( _Ocean_Map4, (u / GRID_SIZES.w), (dux / GRID_SIZES.w), (duy / GRID_SIZES.w), _Ocean_MapSize).zw);
    }
    #line 183
    v2f OUT;
    highp mat3 otoc = xll_constructMat3_mf4x4( _Ocean_OceanToCamera);
    highp vec4 screenP = vec4( ((t * cameraDir) + (otoc * dP)), 1.0);
    #line 187
    highp vec3 oceanP = (((t * oceanDir) + dP) + vec3( 0.0, 0.0, _Ocean_CameraPos.z));
    OUT.pos = (_Globals_CameraToScreen * screenP);
    #line 191
    OUT.oceanU = u;
    OUT.oceanP = oceanP;
    #line 199
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.oceanU);
    xlv_TEXCOORD1 = vec3(xl_retval.oceanP);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(117,1): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/

#endif
#ifdef FRAGMENT
#ifndef SHADER_TARGET
    #define SHADER_TARGET 30
#endif
#ifndef UNITY_NO_DXT5nm
    #define UNITY_NO_DXT5nm 1
#endif
#ifndef UNITY_NO_RGBM
    #define UNITY_NO_RGBM 1
#endif
#ifndef UNITY_NO_SCREENSPACE_SHADOWS
    #define UNITY_NO_SCREENSPACE_SHADOWS 1
#endif
#ifndef UNITY_NO_LINEAR_COLORSPACE
    #define UNITY_NO_LINEAR_COLORSPACE 1
#endif
#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
#endif
#ifndef UNITY_VERSION
    #define UNITY_VERSION 524
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#extension GL_EXT_shader_texture_lod : require
#extension GL_OES_standard_derivatives : require
float xll_dFdx_f(float f) {
  return dFdx(f);
}
vec2 xll_dFdx_vf2(vec2 v) {
  return dFdx(v);
}
vec3 xll_dFdx_vf3(vec3 v) {
  return dFdx(v);
}
vec4 xll_dFdx_vf4(vec4 v) {
  return dFdx(v);
}
mat2 xll_dFdx_mf2x2(mat2 m) {
  return mat2( dFdx(m[0]), dFdx(m[1]));
}
mat3 xll_dFdx_mf3x3(mat3 m) {
  return mat3( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]));
}
mat4 xll_dFdx_mf4x4(mat4 m) {
  return mat4( dFdx(m[0]), dFdx(m[1]), dFdx(m[2]), dFdx(m[3]));
}
float xll_dFdy_f(float f) {
  return dFdy(f);
}
vec2 xll_dFdy_vf2(vec2 v) {
  return dFdy(v);
}
vec3 xll_dFdy_vf3(vec3 v) {
  return dFdy(v);
}
vec4 xll_dFdy_vf4(vec4 v) {
  return dFdy(v);
}
mat2 xll_dFdy_mf2x2(mat2 m) {
  return mat2( dFdy(m[0]), dFdy(m[1]));
}
mat3 xll_dFdy_mf3x3(mat3 m) {
  return mat3( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]));
}
mat4 xll_dFdy_mf4x4(mat4 m) {
  return mat4( dFdy(m[0]), dFdy(m[1]), dFdy(m[2]), dFdy(m[3]));
}
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLodEXT( s, coord.xy, coord.w);
}
#line 273
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 439
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 433
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
};
#line 32
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
#line 40
uniform highp vec4 _ZBufferParams;
#line 46
uniform highp vec4 unity_OrthoParams;
#line 51
uniform highp vec4 unity_CameraWorldClipPlanes[6];
#line 56
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_CameraInvProjection;
#line 69
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightPositionRange;
#line 74
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
#line 79
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
#line 87
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
#line 91
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
#line 95
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
#line 101
uniform mediump vec3 unity_LightColor0;
uniform mediump vec3 unity_LightColor1;
uniform mediump vec3 unity_LightColor2;
uniform mediump vec3 unity_LightColor3;
#line 108
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 112
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform mediump vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 127
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 134
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_LODFade;
uniform highp vec4 unity_WorldTransformParams;
#line 144
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 154
uniform highp mat4 glstate_matrix_projection;
uniform lowp vec4 glstate_lightmodel_ambient;
#line 160
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 165
uniform lowp vec4 unity_AmbientSky;
uniform lowp vec4 unity_AmbientEquator;
uniform lowp vec4 unity_AmbientGround;
#line 175
uniform lowp vec4 unity_FogColor;
#line 180
uniform highp vec4 unity_FogParams;
#line 188
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 193
uniform sampler2D unity_DynamicLightmap;
uniform sampler2D unity_DynamicDirectionality;
uniform sampler2D unity_DynamicNormal;
#line 198
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
#line 206
uniform samplerCube unity_SpecCube0;
uniform samplerCube unity_SpecCube1;
#line 210
uniform highp vec4 unity_SpecCube0_BoxMax;
uniform highp vec4 unity_SpecCube0_BoxMin;
uniform highp vec4 unity_SpecCube0_ProbePosition;
uniform mediump vec4 unity_SpecCube0_HDR;
#line 215
uniform highp vec4 unity_SpecCube1_BoxMax;
uniform highp vec4 unity_SpecCube1_BoxMin;
uniform highp vec4 unity_SpecCube1_ProbePosition;
uniform mediump vec4 unity_SpecCube1_HDR;
#line 8
uniform lowp vec4 unity_ColorSpaceGrey;
uniform lowp vec4 unity_ColorSpaceDouble;
uniform mediump vec4 unity_ColorSpaceDielectricSpec;
uniform mediump vec4 unity_ColorSpaceLuminance;
#line 61
#line 67
#line 73
#line 80
#line 95
#line 102
#line 117
#line 124
#line 131
#line 149
#line 182
#line 207
#line 213
#line 235
#line 252
#line 279
#line 290
#line 300
#line 330
#line 347
#line 352
#line 359
#line 372
#line 387
#line 392
uniform mediump vec4 unity_Lightmap_HDR;
#line 403
uniform mediump vec4 unity_DynamicLightmap_HDR;
#line 416
#line 445
#line 451
#line 461
#line 470
#line 477
#line 486
#line 494
#line 503
#line 522
#line 528
#line 536
#line 547
#line 552
#line 574
#line 599
#line 622
#line 631
#line 641
#line 676
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
#line 33
#line 37
#line 42
#line 70
#line 88
#line 92
#line 100
#line 104
#line 29
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
#line 33
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
#line 37
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
#line 43
#line 74
#line 82
#line 95
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToWorld;
uniform highp mat4 _Globals_WorldToScreen;
uniform highp mat4 _Globals_CameraToScreen;
#line 99
uniform highp vec3 _Globals_WorldCameraPos;
uniform highp mat4 _Globals_WorldToOcean;
uniform highp mat4 _Globals_OceanToWorld;
#line 104
uniform highp vec3 _Globals_Origin;
uniform highp vec3 _Sun_WorldSunDir;
uniform highp vec2 _Ocean_MapSize;
#line 108
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
#line 112
uniform highp vec2 _Ocean_ScreenGridSize;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
#line 116
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
#line 120
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
#line 125
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
#line 129
uniform highp vec2 _VarianceMax;
uniform sampler2D _Sky_Map;
#line 141
highp float xlat_mutableRt;
#line 33
highp float MeanFresnel( in highp float cosThetaV, in highp float sigmaV ) {
    return (pow( (1.0 - cosThetaV), (5.0 * exp((-2.69 * sigmaV)))) / (1.0 + (22.7 * pow( sigmaV, 1.5))));
}
#line 37
highp float MeanFresnel( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return MeanFresnel( dot( V, N), sqrt(sigmaSq));
}
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
    #line 165
    return (( (f >= 0.0) ) ? ( sqrt(f) ) : ( err ));
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
#line 207
highp vec3 ReflectedSky( in highp vec3 V, in highp vec3 N, in highp float sigmaSq, in highp vec3 sunDir, in highp vec3 earthP ) {
    #line 209
    highp vec3 result = vec3( 0.0, 0.0, 0.0);
    #line 220
    highp vec3 extinction = vec3( 0.0, 0.0, 0.0);
    highp vec3 reflectedAngle = reflect( (-V), N);
    reflectedAngle = vec3( reflectedAngle.x, reflectedAngle.y, max( reflectedAngle.z, 0.0));
    #line 224
    result = SkyRadiance2( earthP, reflectedAngle, sunDir, extinction);
    result *= MeanFresnel( V, N, sigmaSq);
    #line 231
    return result;
}
#line 42
highp float ReflectedSunRadiance( in highp vec3 L, in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    highp vec3 H = normalize((L + V));
    #line 46
    highp float hn = dot( H, N);
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.56637 * sigmaSq));
    highp float c = (1.0 - dot( V, H));
    #line 50
    highp float c2 = (c * c);
    highp float fresnel = (0.02 + (((0.98 * c2) * c2) * c));
    highp float zL = dot( L, N);
    #line 54
    highp float zV = dot( V, N);
    zL = max( zL, 0.01);
    zV = max( zV, 0.01);
    #line 59
    return (( (zL <= 0.0) ) ? ( 0.0 ) : ( max( ((fresnel * p) * sqrt(abs((zL / zV)))), 0.0) ));
}
#line 88
highp float RefractedSeaRadiance( in highp vec3 V, in highp vec3 N, in highp float sigmaSq ) {
    return (0.98 * (1.0 - MeanFresnel( V, N, sigmaSq)));
}
#line 472
highp vec2 GetIrradianceUV( in highp float r, in highp float muS ) {
    #line 474
    highp float uR = ((r - Rg) / (xlat_mutableRt - Rg));
    highp float uMuS = ((muS + 0.2) / 1.2);
    return vec2( uMuS, uR);
}
#line 479
highp vec3 Irradiance( in sampler2D samp, in highp float r, in highp float muS ) {
    highp vec2 uv = GetIrradianceUV( r, muS);
    return xll_tex2Dlod( samp, vec4( uv, 0.0, 0.0)).xyz;
}
#line 488
highp vec3 SkyIrradiance( in highp float r, in highp float muS ) {
    return (Irradiance( _Irradiance, r, muS) * _Sun_Intensity);
}
#line 496
highp vec3 TransmittanceWithShadow( in highp float r, in highp float mu ) {
    return (( (mu < (-sqrt((1.0 - ((Rg / r) * (Rg / r)))))) ) ? ( vec3( 0.0, 0.0, 0.0) ) : ( Transmittance( r, mu) ));
}
#line 504
highp vec3 SunRadiance( in highp float r, in highp float muS ) {
    return (TransmittanceWithShadow( r, muS) * _Sun_Intensity);
}
#line 509
void SunRadianceAndSkyIrradiance( in highp vec3 worldP, in highp vec3 worldN, in highp vec3 worldS, out highp vec3 sunL, out highp vec3 skyE ) {
    highp float r = length(worldP);
    #line 513
    if ((r < (0.9 * Rg))){
        worldP.z += Rg;
        r = length(worldP);
    }
    #line 517
    highp vec3 worldV = (worldP / r);
    highp float muS = dot( worldV, worldS);
    highp float sunOcclusion = 1.0;
    #line 521
    sunL = (SunRadiance( r, muS) * sunOcclusion);
    highp float skyOcclusion = ((1.0 + dot( worldV, worldN)) * 0.5);
    #line 527
    skyE = ((2.0 * SkyIrradiance( r, muS)) * skyOcclusion);
}
#line 92
highp float erf( in highp float x ) {
    highp float a = 0.140012;
    highp float x2 = (x * x);
    #line 96
    highp float ax2 = (a * x2);
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.273239 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.4545454) ) : ( (1.0 - exp((-L.z))) ));
    return L;
}
#line 234
highp vec4 frag( in v2f IN ) {
    #line 237
    highp vec3 L = _Ocean_SunDir;
    highp float radius = _Ocean_Radius;
    highp vec2 u = IN.oceanU;
    highp vec3 oceanP = IN.oceanP;
    #line 243
    highp vec3 earthCamera = vec3( 0.0, 0.0, (_Ocean_CameraPos.z + radius));
    highp vec3 earthP = (normalize((oceanP + vec3( 0.0, 0.0, radius))) * (radius + 10.0));
    #line 247
    highp float dist = length((earthP - earthCamera));
    highp float clampFactor = clamp( (dist / alphaRadius), 0.0, 1.0);
    #line 251
    highp float outAlpha = mix( _OceanAlpha, 1.0, clampFactor);
    highp float outWhiteCapStr = mix( _Ocean_WhiteCapStr, farWhiteCapStr, clampFactor);
    highp vec3 oceanCamera = vec3( 0.0, 0.0, _Ocean_CameraPos.z);
    #line 255
    highp vec3 V = normalize((oceanCamera - oceanP));
    highp vec2 slopes = vec2( 0.0, 0.0);
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.x)).xy;
    #line 259
    slopes += texture2D( _Ocean_Map1, (u / _Ocean_GridSizes.y)).zw;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.z)).xy;
    slopes += texture2D( _Ocean_Map2, (u / _Ocean_GridSizes.w)).zw;
    #line 265
    slopes -= (oceanP.xy / (radius + oceanP.z));
    highp vec3 N = normalize(vec3( (-slopes.x), (-slopes.y), 1.0));
    #line 274
    highp float Jxx = xll_dFdx_f(u.x);
    highp float Jxy = xll_dFdy_f(u.x);
    highp float Jyx = xll_dFdx_f(u.y);
    highp float Jyy = xll_dFdy_f(u.y);
    #line 278
    highp float A = ((Jxx * Jxx) + (Jyx * Jyx));
    highp float B = ((Jxx * Jxy) + (Jyx * Jyy));
    highp float C = ((Jxy * Jxy) + (Jyy * Jyy));
    const highp float SCALE = 10.0;
    #line 282
    highp float ua = pow( (A / 10.0), 0.25);
    highp float ub = (0.5 + ((0.5 * B) / sqrt((A * C))));
    highp float uc = pow( (C / 10.0), 0.25);
    #line 286
    highp vec2 sigmaSq = (texture3D( _Ocean_Variance, vec3( ua, ub, uc)).xy * _VarianceMax);
    sigmaSq = max( sigmaSq, vec2( 2e-05));
    #line 290
    highp vec3 sunL;
    highp vec3 skyE;
    SunRadianceAndSkyIrradiance( earthP, N, L, sunL, skyE);
    #line 294
    highp vec3 Lsky;
    #line 300
    Lsky = ReflectedSky( V, N, float( sigmaSq), L, earthP);
    #line 305
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.141593);
    #line 309
    highp vec2 jm1 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.x)).xy;
    highp vec2 jm2 = texture2D( _Ocean_Foam0, (u / _Ocean_GridSizes.y)).zw;
    highp vec2 jm3 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.z)).xy;
    highp vec2 jm4 = texture2D( _Ocean_Foam1, (u / _Ocean_GridSizes.w)).zw;
    #line 313
    highp vec2 jm = (((jm1 + jm2) + jm3) + jm4);
    highp float jSigma2 = max( (jm.y - ((((jm1.x * jm1.x) + (jm2.x * jm2.x)) + (jm3.x * jm3.x)) + (jm4.x * jm4.x))), 0.0);
    #line 317
    highp float W = WhitecapCoverage( outWhiteCapStr, jm.x, jSigma2);
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.141593);
    #line 321
    highp vec3 R_ftot = ((W * l) * 0.4);
    highp vec3 surfaceColor = (((Lsun + Lsky) + Lsea) + R_ftot);
    #line 328
    highp vec3 finalColor = surfaceColor;
    return vec4( hdr( finalColor), (outAlpha * _GlobalOceanAlpha));
}
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main() {
    xlat_mutableRt = Rt;
    highp vec4 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.oceanU = vec2(xlv_TEXCOORD0);
    xlt_IN.oceanP = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}
/* HLSL2GLSL - NOTE: GLSL optimization failed
(117,1): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
(287,35): error: `_Ocean_Variance' undeclared
(287,24): error: no matching function for call to `texture3D(error, vec3)'; candidates are:
(287,24): error: type mismatch
(287,24): error: operands to arithmetic operators must be numeric
*/

#endif
"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_ON" }
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform lowp sampler2D _Ocean_Map0;
uniform lowp sampler2D _Ocean_Map3;
uniform lowp sampler2D _Ocean_Map4;
in highp vec4 in_POSITION0;
out highp vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
highp vec4 t0;
highp int ti0;
bool tb0;
highp vec4 t1;
highp vec3 t2;
highp vec4 t3;
highp vec4 t4;
highp vec4 t5;
highp vec4 t6;
highp ivec2 ti6;
highp vec4 t7;
highp vec3 t8;
highp vec3 t9;
highp vec2 t12;
bool tb12;
highp vec2 t18;
highp int ti18;
bool tb18;
highp float t21;
highp float t27;
bool tb27;
highp float t28;
highp float t29;
highp float t30;
bool tb30;
highp float t31;
highp float t32;
void main()
{
    t0.xy = in_POSITION0.xy * vec2(1.25, 1.25);
    t1.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
    t1.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t1.xyz;
    t1.xyz = t1.xyz + _Globals_ScreenToCamera[3].xyz;
    t18.x = dot(t1.xyz, t1.xyz);
    t18.x = inversesqrt(t18.x);
    t1.xyz = t18.xxx * t1.xyz;
    t2.xyz = t1.yzx * sphereDir.xyzx.zxy;
    t2.xyz = sphereDir.xyzx.yzx * t1.zxy + (-t2.xyz);
    t3.xyz = t2.zxy * sphereDir.xyzx.yzx;
    t3.xyz = t2.yzx * sphereDir.xyzx.zxy + (-t3.xyz);
    t18.x = dot(t3.xyz, t3.xyz);
    t18.x = inversesqrt(t18.x);
    t3.xyz = t18.xxx * t3.xyz;
    t4.xyz = sphereDir.xyzx.xyz * vec3(vec3(cosTheta, cosTheta, cosTheta));
    t3.xyz = vec3(sinTheta) * t3.xyz + t4.xyz;
    t5.xyz = t1.yzx * t3.zxy;
    t5.xyz = t3.yzx * t1.zxy + (-t5.xyz);
    t18.x = dot(t2.xyz, t5.xyz);
    tb18 = 0.0<t18.x;
    tb27 = 0.0<_Ocean_CameraPos.xxyz.w;
    ti18 = int(uint(tb27) * 0xffffffffu & uint(tb18) * 0xffffffffu);
    t1.xyz = (int(ti18) != 0) ? t3.xyz : t1.xyz;
    t2.xyz = t1.yyy * _Ocean_CameraToOcean[1].xyz;
    t2.xyz = _Ocean_CameraToOcean[0].xyz * t1.xxx + t2.xyz;
    t2.xyz = _Ocean_CameraToOcean[2].xyz * t1.zzz + t2.xyz;
    t18.x = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t28 = t18.x * t2.z;
    t29 = _Ocean_Radius + _Ocean_Radius;
    t3.x = _Ocean_Radius * 2.0 + _Ocean_CameraPos.xxyz.w;
    t3.x = t3.x * _Ocean_CameraPos.xxyz.w;
    t28 = t28 * t28 + (-t3.x);
    t28 = max(t28, 0.0);
    t28 = sqrt(t28);
    t28 = (-t2.z) * t18.x + (-t28);
    t12.x = (-_Ocean_CameraPos.xxyz.w) / t2.z;
    t29 = _Ocean_CameraPos.xxyz.w / t29;
    t21 = (-t2.z) * t2.z + 1.0;
    t21 = t29 * t21 + 1.0;
    t30 = t21 * t12.x;
    t12.x = t12.x * t21 + (-t28);
    t12.x = t2.z * t12.x;
    tb12 = abs(t12.x)<1.0;
    t28 = (tb12) ? t30 : t28;
    t12.xy = vec2(t28) * t2.xy + _Ocean_CameraPos.xxyz.yz;
    t30 = in_POSITION0.y * 1.25 + _Ocean_ScreenGridSize.xyxx.y;
    t5.xyz = vec3(t30) * _Globals_ScreenToCamera[1].xyz;
    t5.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t5.xyz;
    t5.xyz = t5.xyz + _Globals_ScreenToCamera[3].xyz;
    t0.x = dot(t5.xyz, t5.xyz);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t5.xyz;
    t6.xyz = t5.yzx * sphereDir.xyzx.zxy;
    t6.xyz = sphereDir.xyzx.yzx * t5.zxy + (-t6.xyz);
    t7.xyz = t6.zxy * sphereDir.xyzx.yzx;
    t7.xyz = t6.yzx * sphereDir.xyzx.zxy + (-t7.xyz);
    t0.x = dot(t7.xyz, t7.xyz);
    t0.x = inversesqrt(t0.x);
    t7.xyz = t0.xxx * t7.xyz;
    t7.xyz = vec3(sinTheta) * t7.xyz + t4.xyz;
    t8.xyz = t5.yzx * t7.zxy;
    t8.xyz = t7.yzx * t5.zxy + (-t8.xyz);
    t0.x = dot(t6.xyz, t8.xyz);
    tb0 = 0.0<t0.x;
    ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
    t5.xyz = (int(ti0) != 0) ? t7.xyz : t5.xyz;
    t6.xyz = t5.yyy * _Ocean_CameraToOcean[1].xyz;
    t5.xyw = _Ocean_CameraToOcean[0].xyz * t5.xxx + t6.xyz;
    t5.xyz = _Ocean_CameraToOcean[2].xyz * t5.zzz + t5.xyw;
    t0.x = t18.x * t5.z;
    t0.x = t0.x * t0.x + (-t3.x);
    t0.x = max(t0.x, 0.0);
    t0.x = sqrt(t0.x);
    t0.x = (-t5.z) * t18.x + (-t0.x);
    t30 = (-_Ocean_CameraPos.xxyz.w) / t5.z;
    t31 = (-t5.z) * t5.z + 1.0;
    t31 = t29 * t31 + 1.0;
    t32 = t30 * t31;
    t30 = t30 * t31 + (-t0.x);
    t30 = t5.z * t30;
    tb30 = abs(t30)<1.0;
    t0.x = (tb30) ? t32 : t0.x;
    t5 = t0.xxxx * t5.xyxy + _Ocean_CameraPos.xxyz.yzyz;
    t5 = (-t12.xyxy) + t5;
    ti6.xy = ivec2(uvec2(notEqual(t5.zwzz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    ti0 = int(uint(ti6.y) | uint(ti6.x));
    if((uint(ti0))!=uint(0u)){
        t0.x = in_POSITION0.x * 1.25 + _Ocean_ScreenGridSize.xyxx.x;
        t6.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
        t6.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t6.xyz;
        t6.xyz = t6.xyz + _Globals_ScreenToCamera[3].xyz;
        t0.x = dot(t6.xyz, t6.xyz);
        t0.x = inversesqrt(t0.x);
        t6.xyz = t0.xxx * t6.xyz;
        t7.xyz = t6.yzx * sphereDir.xyzx.zxy;
        t7.xyz = sphereDir.xyzx.yzx * t6.zxy + (-t7.xyz);
        t8.xyz = t7.zxy * sphereDir.xyzx.yzx;
        t8.xyz = t7.yzx * sphereDir.xyzx.zxy + (-t8.xyz);
        t0.x = dot(t8.xyz, t8.xyz);
        t0.x = inversesqrt(t0.x);
        t8.xyz = t0.xxx * t8.xyz;
        t4.xyz = vec3(sinTheta) * t8.xyz + t4.xyz;
        t8.xyz = t6.yzx * t4.zxy;
        t8.xyz = t4.yzx * t6.zxy + (-t8.xyz);
        t0.x = dot(t7.xyz, t8.xyz);
        tb0 = 0.0<t0.x;
        ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
        t0.xyw = (int(ti0) != 0) ? t4.xyz : t6.xyz;
        t4.xyz = t0.yyy * _Ocean_CameraToOcean[1].xyz;
        t4.xyz = _Ocean_CameraToOcean[0].xyz * t0.xxx + t4.xyz;
        t0.xyw = _Ocean_CameraToOcean[2].xyz * t0.www + t4.xyz;
        t30 = t18.x * t0.w;
        t3.x = t30 * t30 + (-t3.x);
        t3.x = max(t3.x, 0.0);
        t3.x = sqrt(t3.x);
        t18.x = (-t0.w) * t18.x + (-t3.x);
        t3.x = (-_Ocean_CameraPos.xxyz.w) / t0.w;
        t30 = (-t0.w) * t0.w + 1.0;
        t29 = t29 * t30 + 1.0;
        t30 = t29 * t3.x;
        t29 = t3.x * t29 + (-t18.x);
        t27 = t0.w * t29;
        tb27 = abs(t27)<1.0;
        t18.x = (tb27) ? t30 : t18.x;
        t0 = t18.xxxx * t0.xyxy + _Ocean_CameraPos.xxyz.yzyz;
        t0 = (-t12.xyxy) + t0;
        t4 = t12.xyxy / _Ocean_GridSizes.xxyy;
        t6 = vec4(t0.z / _Ocean_GridSizes.x, t0.w / _Ocean_GridSizes.x, t0.z / _Ocean_GridSizes.y, t0.w / _Ocean_GridSizes.y);
        t7 = vec4(t5.z / _Ocean_GridSizes.x, t5.w / _Ocean_GridSizes.x, t5.z / _Ocean_GridSizes.y, t5.w / _Ocean_GridSizes.y);
        t6 = t6 * _Ocean_MapSize.xyxx.xxxx;
        t7 = t7 * _Ocean_MapSize.xyxx.yyyy;
        t29 = dot(t6.xy, t6.xy);
        t3.x = dot(t7.xy, t7.xy);
        t29 = max(t29, t3.x);
        t29 = log2(t29);
        t29 = t29 * 0.5;
        t3.x = textureLod(_Ocean_Map0, t4.xy, t29).x;
        t3.x = t3.x + _Ocean_HeightOffset;
        t30 = dot(t6.zw, t6.zw);
        t6.x = dot(t7.zw, t7.zw);
        t30 = max(t30, t6.x);
        t30 = log2(t30);
        t30 = t30 * 0.5;
        t6.x = textureLod(_Ocean_Map0, t4.zw, t30).y;
        t3.x = t3.x + t6.x;
        t6 = vec4(t12.x / _Ocean_GridSizes.z, t12.y / _Ocean_GridSizes.z, t12.x / _Ocean_GridSizes.w, t12.y / _Ocean_GridSizes.w);
        t0 = vec4(t0.x / _Ocean_GridSizes.z, t0.y / _Ocean_GridSizes.z, t0.z / _Ocean_GridSizes.w, t0.w / _Ocean_GridSizes.w);
        t5 = vec4(t5.x / _Ocean_GridSizes.z, t5.y / _Ocean_GridSizes.z, t5.z / _Ocean_GridSizes.w, t5.w / _Ocean_GridSizes.w);
        t0 = t0 * _Ocean_MapSize.xyxx.xxxx;
        t5 = t5 * _Ocean_MapSize.xyxx.yyyy;
        t0.x = dot(t0.xy, t0.xy);
        t9.x = dot(t5.xy, t5.xy);
        t0.x = max(t9.x, t0.x);
        t0.x = log2(t0.x);
        t0.x = t0.x * 0.5;
        t9.x = textureLod(_Ocean_Map0, t6.xy, t0.x).z;
        t9.x = t9.x + t3.x;
        t18.x = dot(t0.zw, t0.zw);
        t27 = dot(t5.zw, t5.zw);
        t18.x = max(t27, t18.x);
        t18.x = log2(t18.x);
        t18.x = t18.x * 0.5;
        t27 = textureLod(_Ocean_Map0, t6.zw, t18.x).w;
        t5.z = t27 + t9.x;
        t9.xz = textureLod(_Ocean_Map3, t4.xy, t29).xy;
        t3.xw = textureLod(_Ocean_Map3, t4.zw, t30).zw;
        t3.xw = t3.xw * _Ocean_Choppyness.yy;
        t9.xz = _Ocean_Choppyness.xx * t9.xz + t3.xw;
        t3.xw = textureLod(_Ocean_Map4, t6.xy, t0.x).xy;
        t0.xy = _Ocean_Choppyness.zz * t3.xw + t9.xz;
        t18.xy = textureLod(_Ocean_Map4, t6.zw, t18.x).zw;
        t5.xy = _Ocean_Choppyness.ww * t18.xy + t0.xy;
    } else {
        t0.x = 0.0;
        t0.z = _Ocean_HeightOffset;
        t5.xyz = t0.xxz;
    //ENDIF
    }
    t0.xyz = t5.yyy * _Ocean_OceanToCamera[1].xyz;
    t0.xyz = _Ocean_OceanToCamera[0].xyz * t5.xxx + t0.xyz;
    t0.xyz = _Ocean_OceanToCamera[2].xyz * t5.zzz + t0.xyz;
    t0.xyz = vec3(t28) * t1.xyz + t0.xyz;
    t1.xyz = vec3(t28) * t2.xyz + t5.xyz;
    t2.x = 0.0;
    t2.z = _Ocean_CameraPos.xxyz.w;
    vs_TEXCOORD1.xyz = t1.xyz + t2.xxz;
    t1 = t0.yyyy * _Globals_CameraToScreen[1];
    t1 = _Globals_CameraToScreen[0] * t0.xxxx + t1;
    t0 = _Globals_CameraToScreen[2] * t0.zzzz + t1;
    gl_Position = t0 + _Globals_CameraToScreen[3];
    vs_TEXCOORD0.xy = t12.xy;
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform lowp sampler2D _Ocean_Map1;
uniform lowp sampler2D _Ocean_Map2;
uniform lowp sampler3D _Ocean_Variance;
uniform lowp sampler2D _Transmittance;
uniform lowp sampler2D _Irradiance;
uniform lowp sampler2D _Inscatter;
uniform lowp sampler2D _Ocean_Foam0;
uniform lowp sampler2D _Ocean_Foam1;
in highp vec2 vs_TEXCOORD0;
in highp vec3 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
highp vec4 t0;
bvec4 tb0;
highp vec4 t1;
mediump vec2 t16_1;
lowp vec4 t10_1;
highp int ti1;
highp vec4 t2;
lowp vec2 t10_2;
highp vec3 t3;
mediump vec2 t16_3;
lowp vec2 t10_3;
bool tb3;
highp vec4 t4;
highp vec3 t5;
highp vec4 t6;
lowp vec4 t10_6;
bool tb6;
highp vec3 t7;
lowp vec3 t10_7;
highp vec4 t8;
lowp vec4 t10_8;
highp vec4 t9;
highp vec3 t10;
highp vec2 t11;
bool tb11;
highp vec4 t12;
lowp vec4 t10_12;
highp vec2 t13;
highp vec3 t14;
bool tb14;
highp float t16;
bool tb16;
highp float t19;
highp int ti21;
bool tb21;
highp vec3 t24;
highp float t26;
highp vec2 t27;
lowp vec2 t10_27;
highp int ti27;
bool tb27;
highp vec2 t28;
highp vec2 t29;
lowp vec2 t10_29;
highp float t32;
highp float t34;
bool tb34;
highp vec2 t36;
highp float t39;
mediump float t16_39;
lowp float t10_39;
highp float t40;
highp float t42;
highp float t44;
highp float t45;
highp float t46;
bool tb46;
highp float t47;
void main()
{
    t0.xyz = vec3(1.0, 0.0, 0.0);
    t1.x = -1.0;
    t2 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.xxyy;
    t10_3.xy = texture(_Ocean_Map1, t2.xy).xy;
    t10_29.xy = texture(_Ocean_Map1, t2.zw).zw;
    t16_3.xy = t10_29.xy + t10_3.xy;
    t4 = vec4(vs_TEXCOORD0.x / _Ocean_GridSizes.z, vs_TEXCOORD0.y / _Ocean_GridSizes.z, vs_TEXCOORD0.x / _Ocean_GridSizes.w, vs_TEXCOORD0.y / _Ocean_GridSizes.w);
    t10_29.xy = texture(_Ocean_Map2, t4.xy).xy;
    t16_3.xy = t10_29.xy + t16_3.xy;
    t10_29.xy = texture(_Ocean_Map2, t4.zw).zw;
    t16_3.xy = t10_29.xy + t16_3.xy;
    t5.x = 0.0;
    t5.z = _Ocean_Radius;
    t5.xyz = t5.xxz + vs_TEXCOORD1.xyz;
    t29.xy = vs_TEXCOORD1.xy / t5.zz;
    t3.xy = (-t29.xy) + t16_3.xy;
    t3.xy = (-t3.xy);
    t3.z = 1.0;
    t42 = dot(t3.xyz, t3.xyz);
    t42 = inversesqrt(t42);
    t3.xyz = vec3(t42) * t3.xyz;
    t6.x = 0.0;
    t6.z = _Ocean_CameraPos.xxyz.w;
    t6.xyz = t6.xxz + (-vs_TEXCOORD1.xyz);
    t42 = dot(t6.xyz, t6.xyz);
    t42 = inversesqrt(t42);
    t7.xyz = vec3(t42) * t6.xyz;
    t6.xyz = t6.xyz * vec3(t42) + _Ocean_SunDir.xyzx.xyz;
    t42 = dot((-t7.xyz), t3.xyz);
    t42 = t42 + t42;
    t8.xyz = t3.xyz * (-vec3(t42)) + (-t7.xyz);
    t8.z = max(t8.z, 0.0);
    t8.x = t8.x + _viewdirOffset;
    t42 = dot(t8.xyz, t8.xyz);
    t42 = inversesqrt(t42);
    t8.xyz = vec3(t42) * t8.xyz;
    t42 = dot(t5.xyz, t5.xyz);
    t42 = inversesqrt(t42);
    t5.xyz = vec3(t42) * t5.xyz;
    t42 = _Ocean_Radius + 10.0;
    t9.xzw = vec3(t42) * t5.zxy;
    t10.z = dot(t9.zwx, t8.xyz);
    t44 = dot(t9.xzw, t9.xzw);
    t45 = t10.z * t10.z + (-t44);
    t10.x = sqrt(t44);
    t44 = (-Rg) + Rt;
    t11.x = t44 * _experimentalAtmoScale + Rg;
    t45 = t11.x * t11.x + t45;
    tb46 = t45>=0.0;
    t45 = sqrt(t45);
    t45 = (tb46) ? (-t45) : -9.99999997e-007;
    t45 = t45 + (-t10.z);
    t45 = max(t45, 0.0);
    t11.y = t45 + t10.z;
    tb46 = 0.0<t45;
    t12.xyz = vec3(t45) * t8.xyz + t9.zwx;
    t45 = dot(t8.xyz, _Ocean_SunDir.xyzx.xyz);
    t8.xyz = (bool(tb46)) ? t12.xyz : t9.zwx;
    t36.xy = (bool(tb46)) ? t11.xy : t10.xz;
    t46 = dot(t8.xyz, _Ocean_SunDir.xyzx.xyz);
    t46 = t46 / t36.x;
    t46 = max(t46, -0.197500005);
    t46 = t46 * 5.34962368;
    t8.x = t36.x * t36.x;
    t8.x = t36.y * t36.y + (-t8.x);
    t8.x = Rg * Rg + t8.x;
    tb21 = 0.0<t8.x;
    tb34 = t36.y<0.0;
    ti21 = int(uint(tb21) * 0xffffffffu & uint(tb34) * 0xffffffffu);
    t34 = Rg * Rg;
    t47 = t11.x * t11.x + (-t34);
    tb11 = t11.x>=t36.x;
    t34 = t36.x * t36.x + (-t34);
    t8.z = sqrt(t34);
    t1.z = sqrt(t47);
    t1.y = t1.z * t1.z;
    t24.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t0.w = (-t24.x) + 0.5;
    t1.w = t24.x + 0.5;
    t0 = (int(ti21) != 0) ? t0 : t1;
    t1.x = t8.z / t1.z;
    t13.xy = vec2(t0.y + t8.x, t0.z + t8.z);
    t13.x = sqrt(t13.x);
    t0.x = t36.y * t0.x + t13.x;
    t0.x = t0.x / t13.y;
    t14.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t14.xyz = (-t14.xyz) + vec3(1.0, 0.5, 1.0);
    t0.x = t0.x * t14.y + t0.w;
    t13.x = t1.x * t14.x + t24.y;
    t26 = t13.x * RES_R + -1.0;
    t13.x = t13.x * RES_R;
    t0.z = floor(t26);
    t0.xz = t0.xz / vec2(RES_R);
    t8.z = t0.z + t0.x;
    t26 = max(abs(t46), 1.0);
    t26 = float(1.0) / t26;
    t39 = min(abs(t46), 1.0);
    t26 = t26 * t39;
    t39 = t26 * t26;
    t1.x = t39 * 0.0208350997 + -0.0851330012;
    t1.x = t39 * t1.x + 0.180141002;
    t1.x = t39 * t1.x + -0.330299497;
    t39 = t39 * t1.x + 0.999866009;
    t1.x = t39 * t26;
    t1.x = t1.x * -2.0 + 1.57079637;
    tb14 = 1.0<abs(t46);
    t27.x = min(t46, 1.0);
    tb27 = t27.x<(-t27.x);
    t1.x = tb14 ? t1.x : float(0.0);
    t26 = t26 * t39 + t1.x;
    t26 = (tb27) ? (-t26) : t26;
    t26 = t26 * 0.909090877 + 0.74000001;
    t26 = t26 * 0.5;
    t26 = t26 * t14.z + t24.z;
    t39 = t45 + 1.0;
    t39 = t39 * 0.5;
    t1.x = RES_NU + -1.0;
    t14.x = t39 * t1.x;
    t14.x = floor(t14.x);
    t26 = t26 + t14.x;
    t39 = t39 * t1.x + (-t14.x);
    t1.x = t26 + 1.0;
    t8.y = t26 / RES_NU;
    t8.x = t1.x / RES_NU;
    t10_1 = textureLod(_Inscatter, t8.xz, 0.0);
    t10_12 = textureLod(_Inscatter, t8.yz, 0.0);
    t1 = vec4(t39) * t10_1;
    t26 = (-t39) + 1.0;
    t1 = t10_12 * vec4(t26) + t1;
    t46 = floor(t13.x);
    t13.x = fract(t13.x);
    t46 = t46 / RES_R;
    t8.w = t0.x + t46;
    t10_12 = textureLod(_Inscatter, t8.xw, 0.0);
    t10_8 = textureLod(_Inscatter, t8.yw, 0.0);
    t12 = vec4(t39) * t10_12;
    t8 = t10_8 * vec4(t26) + t12;
    t8 = t13.xxxx * t8;
    t0.x = (-t13.x) + 1.0;
    t0 = t1 * t0.xxxx + t8;
    t1.xyz = t0.www * t0.xyz;
    t39 = max(t0.x, 9.99999975e-005);
    t1.xyz = t1.xyz / vec3(t39);
    t8.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t1.xyz = t1.xyz * t8.xyz;
    t39 = dot(vec2(t45), vec2(vec2(mieG, mieG)));
    t40 = t45 * t45 + 1.0;
    t8.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t39 = (-t39) + t8.x;
    t39 = log2(t39);
    t39 = t39 * -1.5;
    t39 = exp2(t39);
    t45 = (-mieG) * mieG + 1.0;
    t8.xz = vec2(M_PI) * vec2(16.0, 4.0);
    t8.xz = vec2(3.0, 1.5) / t8.xz;
    t45 = t45 * t8.z;
    t46 = t40 * t8.x;
    t39 = t39 * t45;
    t39 = t40 * t39;
    t39 = t39 / t8.y;
    t1.xyz = vec3(t39) * t1.xyz;
    t0.xyz = t0.xyz * vec3(t46) + t1.xyz;
    t0.xyz = mix(vec3(0.0, 0.0, 0.0), t0.xyz, vec3(bvec3(tb11)));
    t0.xyz = t0.xyz * vec3(_Sun_Intensity);
    t1.xy = dFdx(vs_TEXCOORD0.xy);
    t27.xy = dFdy(vs_TEXCOORD0.xy);
    t8.xy = t27.xy * t1.xy;
    t1.xy = t1.xy * t1.xy;
    t39 = t1.y + t1.x;
    t1.xy = t27.xy * t27.xy;
    t1.x = t1.y + t1.x;
    t14.x = t8.y + t8.x;
    t14.x = t14.x * 0.5;
    t27.x = t39 * t1.x;
    t39 = t39 * 0.100000001;
    t39 = log2(t39);
    t39 = t39 * 0.25;
    t8.x = exp2(t39);
    t39 = t1.x * 0.100000001;
    t39 = log2(t39);
    t39 = t39 * 0.25;
    t8.z = exp2(t39);
    t39 = sqrt(t27.x);
    t39 = t14.x / t39;
    t8.y = t39 + 0.5;
    t10_39 = texture(_Ocean_Variance, t8.xyz).x;
    t39 = t10_39 * _VarianceMax.xyxx.x;
    t39 = max(t39, 1.99999995e-005);
    t1.x = sqrt(t39);
    t1.y = log2(t1.x);
    t1.x = t1.x * -3.88084984;
    t1.x = exp2(t1.x);
    t1.xy = t1.xy * vec2(5.0, 1.5);
    t14.x = exp2(t1.y);
    t14.x = t14.x * 22.7000008 + 1.0;
    t27.x = dot(t7.xyz, t3.xyz);
    t40 = (-t27.x) + 1.0;
    t27.x = max(t27.x, 0.00999999978);
    t40 = log2(t40);
    t1.x = t40 * t1.x;
    t1.x = exp2(t1.x);
    t1.x = t1.x / t14.x;
    t0.xyz = t0.xyz * t1.xxx;
    t1.x = (-t1.x) + 1.0;
    t1.x = t1.x * 0.980000019;
    t1.xyw = t1.xxx * _Ocean_Color.xyzx.xyz;
    t45 = dot(t6.xyz, t6.xyz);
    t45 = inversesqrt(t45);
    t6.xyz = vec3(t45) * t6.xyz;
    t45 = dot(t7.xyz, t6.xyz);
    t6.x = dot(t6.xyz, t3.xyz);
    t19 = (-t45) + 1.0;
    t32 = t19 * t19;
    t32 = t32 * t32;
    t19 = t19 * t32;
    t19 = t19 * 0.980000019 + 0.0199999996;
    t32 = t39 * 12.566371;
    t45 = (-t6.x) * t6.x + 1.0;
    t6.x = t6.x + 1.0;
    t39 = t45 / t39;
    t39 = t39 * -2.0;
    t39 = t39 / t6.x;
    t39 = t39 * 1.44269502;
    t39 = exp2(t39);
    t39 = t39 / t32;
    t39 = t39 * t19;
    t6.x = dot(_Ocean_SunDir.xyzx.xyz, t3.xyz);
    t6.xy = max(t6.xx, vec2(0.00999999978, 0.0));
    t27.x = t6.x / t27.x;
    t27.x = sqrt(t27.x);
    t39 = t39 * t27.x;
    t39 = max(t39, 0.0);
    t9.y = t5.z * t42 + Rg;
    t7.x = t9.y;
    t27.x = dot(t9.yzw, t9.yzw);
    t7.y = sqrt(t27.x);
    t10.y = t9.x;
    t27.x = Rg * 0.899999976;
    tb27 = t10.x<t27.x;
    t9.xy = (bool(tb27)) ? t7.xy : t10.yx;
    t6.xzw = t9.zwx / t9.yyy;
    t27.x = dot(t6.xzw, _Ocean_SunDir.xyzx.xyz);
    t3.x = dot(t6.xzw, t3.xyz);
    t3.x = t3.x + 1.0;
    t3.x = t3.x * 0.5;
    t16 = Rg / t9.y;
    t29.x = t9.y + (-Rg);
    t7.z = t29.x / t44;
    t16 = (-t16) * t16 + 1.0;
    t16 = sqrt(t16);
    tb16 = t27.x<(-t16);
    t6.xz = t27.xx + vec2(0.150000006, 0.200000003);
    t7.xy = t6.xz * vec2(12.262105, 0.833333313);
    t27.x = max(abs(t7.x), 1.0);
    t27.x = float(1.0) / t27.x;
    t29.x = min(abs(t7.x), 1.0);
    t27.x = t27.x * t29.x;
    t29.x = t27.x * t27.x;
    t44 = t29.x * 0.0208350997 + -0.0851330012;
    t44 = t29.x * t44 + 0.180141002;
    t44 = t29.x * t44 + -0.330299497;
    t29.x = t29.x * t44 + 0.999866009;
    t44 = t27.x * t29.x;
    t44 = t44 * -2.0 + 1.57079637;
    tb6 = 1.0<abs(t7.x);
    t44 = tb6 ? t44 : float(0.0);
    t27.x = t27.x * t29.x + t44;
    t29.x = min(t7.x, 1.0);
    t10_6.xzw = textureLod(_Irradiance, t7.yz, 0.0).xyz;
    t7.y = sqrt(t7.z);
    t6.xzw = t10_6.xzw * vec3(_Sun_Intensity);
    t6.xzw = t3.xxx * t6.xzw;
    t6.xzw = t6.xzw + t6.xzw;
    tb3 = t29.x<(-t29.x);
    t27.x = (tb3) ? (-t27.x) : t27.x;
    t7.x = t27.x * 0.666666687;
    t10_7.xyz = textureLod(_Transmittance, t7.xy, 0.0).xyz;
    t7.xyz = t10_7.xyz * vec3(_Sun_Intensity);
    t3.xyz = (bool(tb16)) ? vec3(0.0, 0.0, 0.0) : t7.xyz;
    t0.xyz = vec3(t39) * t3.xyz + t0.xyz;
    t3.xyz = t3.xyz * t6.yyy + t6.xzw;
    t1.xyz = t1.xyw * t6.xzw;
    t0.xyz = t1.xyz * vec3(0.318309873, 0.318309873, 0.318309873) + t0.xyz;
    t10_1.xy = texture(_Ocean_Foam0, t2.zw).zw;
    t10_27.xy = texture(_Ocean_Foam0, t2.xy).xy;
    t16_39 = t10_1.x * t10_1.x;
    t16_1.xy = t10_1.xy + t10_27.xy;
    t16_39 = t10_27.x * t10_27.x + t16_39;
    t10_27.xy = texture(_Ocean_Foam1, t4.xy).xy;
    t10_2.xy = texture(_Ocean_Foam1, t4.zw).zw;
    t16_39 = t10_27.x * t10_27.x + t16_39;
    t16_1.xy = t10_27.xy + t16_1.xy;
    t16_1.xy = t10_2.xy + t16_1.xy;
    t16_39 = t10_2.x * t10_2.x + t16_39;
    t16_39 = (-t16_39) + t16_1.y;
    t16_39 = max(t16_39, 0.0);
    t16_39 = sqrt(t16_39);
    t16_39 = float(1.0) / t16_39;
    t2.z = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t2.xy = vec2(0.0, 0.0);
    t14.xyz = t5.xyz * vec3(t42) + (-t2.xyz);
    t14.x = dot(t14.xyz, t14.xyz);
    t14.x = sqrt(t14.x);
    t14.x = t14.x / alphaRadius;
    t14.x = clamp(t14.x, 0.0, 1.0);
    t27.x = (-_Ocean_WhiteCapStr) + farWhiteCapStr;
    t27.x = t14.x * t27.x + _Ocean_WhiteCapStr;
    t1.x = (-t16_1.x) + t27.x;
    t1.x = t1.x * 0.707106769;
    t39 = t16_39 * t1.x;
    ti1 = int((0.0<t39) ? 0xFFFFFFFFu : uint(0u));
    ti27 = int((t39<0.0) ? 0xFFFFFFFFu : uint(0u));
    t39 = t39 * t39;
    ti1 = (-ti1) + ti27;
    t1.x = float(ti1);
    t27.xy = vec2(t39) * vec2(0.140011996, 0.140011996) + vec2(1.27323949, 1.0);
    t39 = (-t39) * t27.x;
    t39 = t39 / t27.y;
    t39 = t39 * 1.44269502;
    t39 = exp2(t39);
    t39 = (-t39) + 1.0;
    t39 = sqrt(t39);
    t39 = t39 * t1.x;
    t39 = t39 * 0.5 + 0.5;
    t1.xzw = vec3(t39) * t3.xyz;
    t0.xyz = t1.xzw * vec3(0.127323955, 0.127323955, 0.127323955) + t0.xyz;
    t0.xyz = t0.xyz * vec3(_Exposure);
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t2.xz);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb0.xyw = lessThan(t0.xyxz, vec4(1.41299999, 1.41299999, 0.0, 1.41299999)).xyw;
    t28.xy = t0.zz * vec2(0.383170009, -1.44269502);
    SV_Target0.x = (tb0.x) ? t1.x : t2.x;
    SV_Target0.y = (tb0.y) ? t1.z : t2.y;
    t0.x = log2(t28.x);
    t13.x = exp2(t28.y);
    t13.x = (-t13.x) + 1.0;
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    SV_Target0.z = (tb0.w) ? t0.x : t13.x;
    t0.x = (-_OceanAlpha) + 1.0;
    t0.x = t14.x * t0.x + _OceanAlpha;
    SV_Target0.w = t0.x * _GlobalOceanAlpha;
    return;
}

#endif
"
}
SubProgram "glcore " {
Keywords { "SKY_REFLECTIONS_ON" }
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform  sampler2D _Ocean_Map0;
uniform  sampler2D _Ocean_Map3;
uniform  sampler2D _Ocean_Map4;
in  vec4 in_POSITION0;
out vec2 vs_TEXCOORD0;
out vec3 vs_TEXCOORD1;
vec4 t0;
int ti0;
bool tb0;
vec4 t1;
vec3 t2;
vec3 t3;
vec4 t4;
vec4 t5;
vec4 t6;
ivec2 ti6;
vec4 t7;
vec4 t8;
vec3 t9;
vec2 t12;
bool tb12;
float t18;
int ti18;
bool tb18;
float t21;
float t27;
bool tb27;
float t28;
float t29;
float t30;
bool tb30;
float t31;
float t32;
void main()
{
    t0.xy = in_POSITION0.xy * vec2(1.25, 1.25);
    t1.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
    t1.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t1.xyz;
    t1.xyz = t1.xyz + _Globals_ScreenToCamera[3].xyz;
    t18 = dot(t1.xyz, t1.xyz);
    t18 = inversesqrt(t18);
    t1.xyz = vec3(t18) * t1.xyz;
    t2.xyz = t1.yzx * sphereDir.xyzx.zxy;
    t2.xyz = sphereDir.xyzx.yzx * t1.zxy + (-t2.xyz);
    t3.xyz = t2.zxy * sphereDir.xyzx.yzx;
    t3.xyz = t2.yzx * sphereDir.xyzx.zxy + (-t3.xyz);
    t18 = dot(t3.xyz, t3.xyz);
    t18 = inversesqrt(t18);
    t3.xyz = vec3(t18) * t3.xyz;
    t4.xyz = sphereDir.xyzx.xyz * vec3(vec3(cosTheta, cosTheta, cosTheta));
    t3.xyz = vec3(sinTheta) * t3.xyz + t4.xyz;
    t5.xyz = t1.yzx * t3.zxy;
    t5.xyz = t3.yzx * t1.zxy + (-t5.xyz);
    t18 = dot(t2.xyz, t5.xyz);
    tb18 = 0.0<t18;
    tb27 = 0.0<_Ocean_CameraPos.xxyz.w;
    ti18 = int(uint(tb27) * 0xffffffffu & uint(tb18) * 0xffffffffu);
    t1.xyz = (int(ti18) != 0) ? t3.xyz : t1.xyz;
    t2.xyz = t1.yyy * _Ocean_CameraToOcean[1].xyz;
    t2.xyz = _Ocean_CameraToOcean[0].xyz * t1.xxx + t2.xyz;
    t2.xyz = _Ocean_CameraToOcean[2].xyz * t1.zzz + t2.xyz;
    t18 = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t28 = t18 * t2.z;
    t29 = _Ocean_Radius + _Ocean_Radius;
    t3.x = _Ocean_Radius * 2.0 + _Ocean_CameraPos.xxyz.w;
    t3.x = t3.x * _Ocean_CameraPos.xxyz.w;
    t28 = t28 * t28 + (-t3.x);
    t28 = max(t28, 0.0);
    t28 = sqrt(t28);
    t28 = (-t2.z) * t18 + (-t28);
    t12.x = (-_Ocean_CameraPos.xxyz.w) / t2.z;
    t29 = _Ocean_CameraPos.xxyz.w / t29;
    t21 = (-t2.z) * t2.z + 1.0;
    t21 = t29 * t21 + 1.0;
    t30 = t21 * t12.x;
    t12.x = t12.x * t21 + (-t28);
    t12.x = t2.z * t12.x;
    tb12 = abs(t12.x)<1.0;
    t28 = (tb12) ? t30 : t28;
    t12.xy = vec2(t28) * t2.xy + _Ocean_CameraPos.xxyz.yz;
    t30 = in_POSITION0.y * 1.25 + _Ocean_ScreenGridSize.xyxx.y;
    t5.xyz = vec3(t30) * _Globals_ScreenToCamera[1].xyz;
    t5.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t5.xyz;
    t5.xyz = t5.xyz + _Globals_ScreenToCamera[3].xyz;
    t0.x = dot(t5.xyz, t5.xyz);
    t0.x = inversesqrt(t0.x);
    t5.xyz = t0.xxx * t5.xyz;
    t6.xyz = t5.yzx * sphereDir.xyzx.zxy;
    t6.xyz = sphereDir.xyzx.yzx * t5.zxy + (-t6.xyz);
    t7.xyz = t6.zxy * sphereDir.xyzx.yzx;
    t7.xyz = t6.yzx * sphereDir.xyzx.zxy + (-t7.xyz);
    t0.x = dot(t7.xyz, t7.xyz);
    t0.x = inversesqrt(t0.x);
    t7.xyz = t0.xxx * t7.xyz;
    t7.xyz = vec3(sinTheta) * t7.xyz + t4.xyz;
    t8.xyz = t5.yzx * t7.zxy;
    t8.xyz = t7.yzx * t5.zxy + (-t8.xyz);
    t0.x = dot(t6.xyz, t8.xyz);
    tb0 = 0.0<t0.x;
    ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
    t5.xyz = (int(ti0) != 0) ? t7.xyz : t5.xyz;
    t6.xyz = t5.yyy * _Ocean_CameraToOcean[1].xyz;
    t5.xyw = _Ocean_CameraToOcean[0].xyz * t5.xxx + t6.xyz;
    t5.xyz = _Ocean_CameraToOcean[2].xyz * t5.zzz + t5.xyw;
    t0.x = t18 * t5.z;
    t0.x = t0.x * t0.x + (-t3.x);
    t0.x = max(t0.x, 0.0);
    t0.x = sqrt(t0.x);
    t0.x = (-t5.z) * t18 + (-t0.x);
    t30 = (-_Ocean_CameraPos.xxyz.w) / t5.z;
    t31 = (-t5.z) * t5.z + 1.0;
    t31 = t29 * t31 + 1.0;
    t32 = t30 * t31;
    t30 = t30 * t31 + (-t0.x);
    t30 = t5.z * t30;
    tb30 = abs(t30)<1.0;
    t0.x = (tb30) ? t32 : t0.x;
    t5 = t0.xxxx * t5.xyxy + _Ocean_CameraPos.xxyz.yzyz;
    t5 = (-t12.xyxy) + t5;
    ti6.xy = ivec2(uvec2(notEqual(t5.zwzz, vec4(0.0, 0.0, 0.0, 0.0)).xy) * 0xFFFFFFFFu);
    ti0 = int(uint(ti6.y) | uint(ti6.x));
    if((uint(ti0))!=uint(0u)){
        t0.x = in_POSITION0.x * 1.25 + _Ocean_ScreenGridSize.xyxx.x;
        t6.xyz = t0.yyy * _Globals_ScreenToCamera[1].xyz;
        t6.xyz = _Globals_ScreenToCamera[0].xyz * t0.xxx + t6.xyz;
        t6.xyz = t6.xyz + _Globals_ScreenToCamera[3].xyz;
        t0.x = dot(t6.xyz, t6.xyz);
        t0.x = inversesqrt(t0.x);
        t6.xyz = t0.xxx * t6.xyz;
        t7.xyz = t6.yzx * sphereDir.xyzx.zxy;
        t7.xyz = sphereDir.xyzx.yzx * t6.zxy + (-t7.xyz);
        t8.xyz = t7.zxy * sphereDir.xyzx.yzx;
        t8.xyz = t7.yzx * sphereDir.xyzx.zxy + (-t8.xyz);
        t0.x = dot(t8.xyz, t8.xyz);
        t0.x = inversesqrt(t0.x);
        t8.xyz = t0.xxx * t8.xyz;
        t4.xyz = vec3(sinTheta) * t8.xyz + t4.xyz;
        t8.xyz = t6.yzx * t4.zxy;
        t8.xyz = t4.yzx * t6.zxy + (-t8.xyz);
        t0.x = dot(t7.xyz, t8.xyz);
        tb0 = 0.0<t0.x;
        ti0 = int(uint(tb27) * 0xffffffffu & uint(tb0) * 0xffffffffu);
        t0.xyw = (int(ti0) != 0) ? t4.xyz : t6.xyz;
        t4.xyz = t0.yyy * _Ocean_CameraToOcean[1].xyz;
        t4.xyz = _Ocean_CameraToOcean[0].xyz * t0.xxx + t4.xyz;
        t0.xyw = _Ocean_CameraToOcean[2].xyz * t0.www + t4.xyz;
        t30 = t18 * t0.w;
        t3.x = t30 * t30 + (-t3.x);
        t3.x = max(t3.x, 0.0);
        t3.x = sqrt(t3.x);
        t18 = (-t0.w) * t18 + (-t3.x);
        t3.x = (-_Ocean_CameraPos.xxyz.w) / t0.w;
        t30 = (-t0.w) * t0.w + 1.0;
        t29 = t29 * t30 + 1.0;
        t30 = t29 * t3.x;
        t29 = t3.x * t29 + (-t18);
        t27 = t0.w * t29;
        tb27 = abs(t27)<1.0;
        t18 = (tb27) ? t30 : t18;
        t0 = vec4(t18) * t0.xyxy + _Ocean_CameraPos.xxyz.yzyz;
        t0 = (-t12.xyxy) + t0;
        t4 = t12.xyxy / _Ocean_GridSizes.xxyy;
        t6 = t0.zwzw / _Ocean_GridSizes.xxyy;
        t7 = t5.zwzw / _Ocean_GridSizes.xxyy;
        t6 = t6 * _Ocean_MapSize.xyxx.xxxx;
        t7 = t7 * _Ocean_MapSize.xyxx.yyyy;
        t29 = dot(t6.xy, t6.xy);
        t3.x = dot(t7.xy, t7.xy);
        t29 = max(t29, t3.x);
        t29 = log2(t29);
        t29 = t29 * 0.5;
        t8 = textureLod(_Ocean_Map0, t4.xy, t29);
        t3.x = t8.x + _Ocean_HeightOffset;
        t30 = dot(t6.zw, t6.zw);
        t6.x = dot(t7.zw, t7.zw);
        t30 = max(t30, t6.x);
        t30 = log2(t30);
        t30 = t30 * 0.5;
        t6 = textureLod(_Ocean_Map0, t4.zw, t30);
        t3.x = t3.x + t6.y;
        t6 = t12.xyxy / _Ocean_GridSizes.zzww;
        t0 = t0 / _Ocean_GridSizes.zzww;
        t5 = t5 / _Ocean_GridSizes.zzww;
        t0 = t0 * _Ocean_MapSize.xyxx.xxxx;
        t5 = t5 * _Ocean_MapSize.xyxx.yyyy;
        t0.x = dot(t0.xy, t0.xy);
        t9.x = dot(t5.xy, t5.xy);
        t0.x = max(t9.x, t0.x);
        t0.x = log2(t0.x);
        t0.x = t0.x * 0.5;
        t7 = textureLod(_Ocean_Map0, t6.xy, t0.x);
        t9.x = t3.x + t7.z;
        t18 = dot(t0.zw, t0.zw);
        t27 = dot(t5.zw, t5.zw);
        t18 = max(t27, t18);
        t18 = log2(t18);
        t18 = t18 * 0.5;
        t5 = textureLod(_Ocean_Map0, t6.zw, t18);
        t5.z = t9.x + t5.w;
        t7 = textureLod(_Ocean_Map3, t4.xy, t29);
        t4 = textureLod(_Ocean_Map3, t4.zw, t30);
        t9.xz = t4.zw * _Ocean_Choppyness.yy;
        t9.xz = _Ocean_Choppyness.xx * t7.xy + t9.xz;
        t4 = textureLod(_Ocean_Map4, t6.xy, t0.x);
        t0.xy = _Ocean_Choppyness.zz * t4.xy + t9.xz;
        t4 = textureLod(_Ocean_Map4, t6.zw, t18);
        t5.xy = _Ocean_Choppyness.ww * t4.zw + t0.xy;
    } else {
        t0.x = 0.0;
        t0.z = _Ocean_HeightOffset;
        t5.xyz = t0.xxz;
    //ENDIF
    }
    t0.xyz = t5.yyy * _Ocean_OceanToCamera[1].xyz;
    t0.xyz = _Ocean_OceanToCamera[0].xyz * t5.xxx + t0.xyz;
    t0.xyz = _Ocean_OceanToCamera[2].xyz * t5.zzz + t0.xyz;
    t0.xyz = vec3(t28) * t1.xyz + t0.xyz;
    t1.xyz = vec3(t28) * t2.xyz + t5.xyz;
    t2.x = 0.0;
    t2.z = _Ocean_CameraPos.xxyz.w;
    vs_TEXCOORD1.xyz = t1.xyz + t2.xxz;
    t1 = t0.yyyy * _Globals_CameraToScreen[1];
    t1 = _Globals_CameraToScreen[0] * t0.xxxx + t1;
    t0 = _Globals_CameraToScreen[2] * t0.zzzz + t1;
    gl_Position = t0 + _Globals_CameraToScreen[3];
    vs_TEXCOORD0.xy = t12.xy;
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
uniform 	float _Ocean_Radius;
uniform 	float _Ocean_HeightOffset;
uniform 	vec3 _Ocean_CameraPos;
uniform 	mat4 _Ocean_OceanToCamera;
uniform 	mat4 _Ocean_CameraToOcean;
uniform 	vec3 sphereDir;
uniform 	float cosTheta;
uniform 	float sinTheta;
uniform 	mat4 _Globals_ScreenToCamera;
uniform 	mat4 _Globals_CameraToWorld;
uniform 	mat4 _Globals_WorldToScreen;
uniform 	mat4 _Globals_CameraToScreen;
uniform 	vec3 _Globals_WorldCameraPos;
uniform 	mat4 _Globals_WorldToOcean;
uniform 	mat4 _Globals_OceanToWorld;
uniform 	vec3 _Globals_Origin;
uniform 	vec3 _Sun_WorldSunDir;
uniform 	vec2 _Ocean_MapSize;
uniform 	vec4 _Ocean_Choppyness;
uniform 	vec3 _Ocean_SunDir;
uniform 	vec3 _Ocean_Color;
uniform 	vec4 _Ocean_GridSizes;
uniform 	vec2 _Ocean_ScreenGridSize;
uniform 	float _Ocean_WhiteCapStr;
uniform 	float farWhiteCapStr;
uniform 	float _OceanAlpha;
uniform 	float _GlobalOceanAlpha;
uniform 	float alphaRadius;
uniform 	vec2 _VarianceMax;
uniform  sampler2D _Ocean_Map1;
uniform  sampler2D _Ocean_Map2;
uniform  sampler3D _Ocean_Variance;
uniform  sampler2D _Transmittance;
uniform  sampler2D _Irradiance;
uniform  sampler2D _Inscatter;
uniform  sampler2D _Ocean_Foam0;
uniform  sampler2D _Ocean_Foam1;
in  vec2 vs_TEXCOORD0;
in  vec3 vs_TEXCOORD1;
out vec4 SV_Target0;
vec4 t0;
bvec4 tb0;
vec4 t1;
mediump vec2 t16_1;
lowp vec4 t10_1;
int ti1;
vec4 t2;
lowp vec4 t10_2;
vec3 t3;
mediump vec2 t16_3;
lowp vec4 t10_3;
bool tb3;
vec4 t4;
lowp vec4 t10_4;
vec3 t5;
lowp vec4 t10_5;
vec4 t6;
bool tb6;
vec3 t7;
lowp vec4 t10_7;
vec4 t8;
lowp vec4 t10_8;
vec4 t9;
vec3 t10;
vec2 t11;
bool tb11;
vec4 t12;
lowp vec4 t10_12;
vec2 t13;
vec3 t14;
bool tb14;
float t16;
bool tb16;
float t19;
int ti21;
bool tb21;
vec3 t24;
float t26;
vec2 t27;
int ti27;
bool tb27;
vec2 t28;
vec2 t29;
float t32;
float t34;
bool tb34;
vec2 t36;
float t39;
mediump float t16_39;
float t40;
float t42;
float t44;
float t45;
float t46;
bool tb46;
float t47;
void main()
{
    t0.xyz = vec3(1.0, 0.0, 0.0);
    t1.x = -1.0;
    t2 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.xxyy;
    t10_3 = texture(_Ocean_Map1, t2.xy);
    t10_4 = texture(_Ocean_Map1, t2.zw);
    t16_3.xy = t10_3.xy + t10_4.zw;
    t4 = vs_TEXCOORD0.xyxy / _Ocean_GridSizes.zzww;
    t10_5 = texture(_Ocean_Map2, t4.xy);
    t16_3.xy = t16_3.xy + t10_5.xy;
    t10_5 = texture(_Ocean_Map2, t4.zw);
    t16_3.xy = t16_3.xy + t10_5.zw;
    t5.x = 0.0;
    t5.z = _Ocean_Radius;
    t5.xyz = t5.xxz + vs_TEXCOORD1.xyz;
    t29.xy = vs_TEXCOORD1.xy / t5.zz;
    t3.xy = (-t29.xy) + t16_3.xy;
    t3.xy = (-t3.xy);
    t3.z = 1.0;
    t42 = dot(t3.xyz, t3.xyz);
    t42 = inversesqrt(t42);
    t3.xyz = vec3(t42) * t3.xyz;
    t6.x = 0.0;
    t6.z = _Ocean_CameraPos.xxyz.w;
    t6.xyz = t6.xxz + (-vs_TEXCOORD1.xyz);
    t42 = dot(t6.xyz, t6.xyz);
    t42 = inversesqrt(t42);
    t7.xyz = vec3(t42) * t6.xyz;
    t6.xyz = t6.xyz * vec3(t42) + _Ocean_SunDir.xyzx.xyz;
    t42 = dot((-t7.xyz), t3.xyz);
    t42 = t42 + t42;
    t8.xyz = t3.xyz * (-vec3(t42)) + (-t7.xyz);
    t8.z = max(t8.z, 0.0);
    t8.x = t8.x + _viewdirOffset;
    t42 = dot(t8.xyz, t8.xyz);
    t42 = inversesqrt(t42);
    t8.xyz = vec3(t42) * t8.xyz;
    t42 = dot(t5.xyz, t5.xyz);
    t42 = inversesqrt(t42);
    t5.xyz = vec3(t42) * t5.xyz;
    t42 = _Ocean_Radius + 10.0;
    t9.xzw = vec3(t42) * t5.zxy;
    t10.z = dot(t9.zwx, t8.xyz);
    t44 = dot(t9.xzw, t9.xzw);
    t45 = t10.z * t10.z + (-t44);
    t10.x = sqrt(t44);
    t44 = (-Rg) + Rt;
    t11.x = t44 * _experimentalAtmoScale + Rg;
    t45 = t11.x * t11.x + t45;
    tb46 = t45>=0.0;
    t45 = sqrt(t45);
    t45 = (tb46) ? (-t45) : -9.99999997e-007;
    t45 = t45 + (-t10.z);
    t45 = max(t45, 0.0);
    t11.y = t45 + t10.z;
    tb46 = 0.0<t45;
    t12.xyz = vec3(t45) * t8.xyz + t9.zwx;
    t45 = dot(t8.xyz, _Ocean_SunDir.xyzx.xyz);
    t8.xyz = (bool(tb46)) ? t12.xyz : t9.zwx;
    t36.xy = (bool(tb46)) ? t11.xy : t10.xz;
    t46 = dot(t8.xyz, _Ocean_SunDir.xyzx.xyz);
    t46 = t46 / t36.x;
    t46 = max(t46, -0.197500005);
    t46 = t46 * 5.34962368;
    t8.x = t36.x * t36.x;
    t8.x = t36.y * t36.y + (-t8.x);
    t8.x = Rg * Rg + t8.x;
    tb21 = 0.0<t8.x;
    tb34 = t36.y<0.0;
    ti21 = int(uint(tb21) * 0xffffffffu & uint(tb34) * 0xffffffffu);
    t34 = Rg * Rg;
    t47 = t11.x * t11.x + (-t34);
    tb11 = t11.x>=t36.x;
    t34 = t36.x * t36.x + (-t34);
    t8.z = sqrt(t34);
    t1.z = sqrt(t47);
    t1.y = t1.z * t1.z;
    t24.xyz = vec3(0.5, 0.5, 0.5) / vec3(RES_MU, RES_R, RES_MU_S);
    t0.w = (-t24.x) + 0.5;
    t1.w = t24.x + 0.5;
    t0 = (int(ti21) != 0) ? t0 : t1;
    t1.x = t8.z / t1.z;
    t13.xy = t0.yz + t8.xz;
    t13.x = sqrt(t13.x);
    t0.x = t36.y * t0.x + t13.x;
    t0.x = t0.x / t13.y;
    t14.xyz = vec3(1.0, 1.0, 1.0) / vec3(RES_R, RES_MU, RES_MU_S);
    t14.xyz = (-t14.xyz) + vec3(1.0, 0.5, 1.0);
    t0.x = t0.x * t14.y + t0.w;
    t13.x = t1.x * t14.x + t24.y;
    t26 = t13.x * RES_R + -1.0;
    t13.x = t13.x * RES_R;
    t0.z = floor(t26);
    t0.xz = t0.xz / vec2(RES_R);
    t8.z = t0.z + t0.x;
    t26 = max(abs(t46), 1.0);
    t26 = float(1.0) / t26;
    t39 = min(abs(t46), 1.0);
    t26 = t26 * t39;
    t39 = t26 * t26;
    t1.x = t39 * 0.0208350997 + -0.0851330012;
    t1.x = t39 * t1.x + 0.180141002;
    t1.x = t39 * t1.x + -0.330299497;
    t39 = t39 * t1.x + 0.999866009;
    t1.x = t39 * t26;
    t1.x = t1.x * -2.0 + 1.57079637;
    tb14 = 1.0<abs(t46);
    t27.x = min(t46, 1.0);
    tb27 = t27.x<(-t27.x);
    t1.x = tb14 ? t1.x : float(0.0);
    t26 = t26 * t39 + t1.x;
    t26 = (tb27) ? (-t26) : t26;
    t26 = t26 * 0.909090877 + 0.74000001;
    t26 = t26 * 0.5;
    t26 = t26 * t14.z + t24.z;
    t39 = t45 + 1.0;
    t39 = t39 * 0.5;
    t1.x = RES_NU + -1.0;
    t14.x = t39 * t1.x;
    t14.x = floor(t14.x);
    t26 = t26 + t14.x;
    t39 = t39 * t1.x + (-t14.x);
    t1.x = t26 + 1.0;
    t8.y = t26 / RES_NU;
    t8.x = t1.x / RES_NU;
    t10_1 = textureLod(_Inscatter, t8.xz, 0.0);
    t10_12 = textureLod(_Inscatter, t8.yz, 0.0);
    t1 = vec4(t39) * t10_1;
    t26 = (-t39) + 1.0;
    t1 = t10_12 * vec4(t26) + t1;
    t46 = floor(t13.x);
    t13.x = fract(t13.x);
    t46 = t46 / RES_R;
    t8.w = t0.x + t46;
    t10_12 = textureLod(_Inscatter, t8.xw, 0.0);
    t10_8 = textureLod(_Inscatter, t8.yw, 0.0);
    t12 = vec4(t39) * t10_12;
    t8 = t10_8 * vec4(t26) + t12;
    t8 = t13.xxxx * t8;
    t0.x = (-t13.x) + 1.0;
    t0 = t1 * t0.xxxx + t8;
    t1.xyz = t0.www * t0.xyz;
    t39 = max(t0.x, 9.99999975e-005);
    t1.xyz = t1.xyz / vec3(t39);
    t8.xyz = betaR.xyzx.xxx / betaR.xyzx.xyz;
    t1.xyz = t1.xyz * t8.xyz;
    t39 = dot(vec2(t45), vec2(vec2(mieG, mieG)));
    t40 = t45 * t45 + 1.0;
    t8.xy = vec2(vec2(mieG, mieG)) * vec2(vec2(mieG, mieG)) + vec2(1.0, 2.0);
    t39 = (-t39) + t8.x;
    t39 = log2(t39);
    t39 = t39 * -1.5;
    t39 = exp2(t39);
    t45 = (-mieG) * mieG + 1.0;
    t8.xz = vec2(M_PI) * vec2(16.0, 4.0);
    t8.xz = vec2(3.0, 1.5) / t8.xz;
    t45 = t45 * t8.z;
    t46 = t40 * t8.x;
    t39 = t39 * t45;
    t39 = t40 * t39;
    t39 = t39 / t8.y;
    t1.xyz = vec3(t39) * t1.xyz;
    t0.xyz = t0.xyz * vec3(t46) + t1.xyz;
    t0.xyz = mix(vec3(0.0, 0.0, 0.0), t0.xyz, vec3(bvec3(tb11)));
    t0.xyz = t0.xyz * vec3(_Sun_Intensity);
    t1.xy = dFdx(vs_TEXCOORD0.xy);
    t27.xy = dFdy(vs_TEXCOORD0.xy);
    t8.xy = t27.xy * t1.xy;
    t1.xy = t1.xy * t1.xy;
    t39 = t1.y + t1.x;
    t1.xy = t27.xy * t27.xy;
    t1.x = t1.y + t1.x;
    t14.x = t8.y + t8.x;
    t14.x = t14.x * 0.5;
    t27.x = t39 * t1.x;
    t39 = t39 * 0.100000001;
    t39 = log2(t39);
    t39 = t39 * 0.25;
    t8.x = exp2(t39);
    t39 = t1.x * 0.100000001;
    t39 = log2(t39);
    t39 = t39 * 0.25;
    t8.z = exp2(t39);
    t39 = sqrt(t27.x);
    t39 = t14.x / t39;
    t8.y = t39 + 0.5;
    t10_1 = texture(_Ocean_Variance, t8.xyz);
    t39 = t10_1.x * _VarianceMax.xyxx.x;
    t39 = max(t39, 1.99999995e-005);
    t1.x = sqrt(t39);
    t1.y = log2(t1.x);
    t1.x = t1.x * -3.88084984;
    t1.x = exp2(t1.x);
    t1.xy = t1.xy * vec2(5.0, 1.5);
    t14.x = exp2(t1.y);
    t14.x = t14.x * 22.7000008 + 1.0;
    t27.x = dot(t7.xyz, t3.xyz);
    t40 = (-t27.x) + 1.0;
    t27.x = max(t27.x, 0.00999999978);
    t40 = log2(t40);
    t1.x = t40 * t1.x;
    t1.x = exp2(t1.x);
    t1.x = t1.x / t14.x;
    t0.xyz = t0.xyz * t1.xxx;
    t1.x = (-t1.x) + 1.0;
    t1.x = t1.x * 0.980000019;
    t1.xyw = t1.xxx * _Ocean_Color.xyzx.xyz;
    t45 = dot(t6.xyz, t6.xyz);
    t45 = inversesqrt(t45);
    t6.xyz = vec3(t45) * t6.xyz;
    t45 = dot(t7.xyz, t6.xyz);
    t6.x = dot(t6.xyz, t3.xyz);
    t19 = (-t45) + 1.0;
    t32 = t19 * t19;
    t32 = t32 * t32;
    t19 = t19 * t32;
    t19 = t19 * 0.980000019 + 0.0199999996;
    t32 = t39 * 12.566371;
    t45 = (-t6.x) * t6.x + 1.0;
    t6.x = t6.x + 1.0;
    t39 = t45 / t39;
    t39 = t39 * -2.0;
    t39 = t39 / t6.x;
    t39 = t39 * 1.44269502;
    t39 = exp2(t39);
    t39 = t39 / t32;
    t39 = t39 * t19;
    t6.x = dot(_Ocean_SunDir.xyzx.xyz, t3.xyz);
    t6.xy = max(t6.xx, vec2(0.00999999978, 0.0));
    t27.x = t6.x / t27.x;
    t27.x = sqrt(t27.x);
    t39 = t39 * t27.x;
    t39 = max(t39, 0.0);
    t9.y = t5.z * t42 + Rg;
    t7.x = t9.y;
    t27.x = dot(t9.yzw, t9.yzw);
    t7.y = sqrt(t27.x);
    t10.y = t9.x;
    t27.x = Rg * 0.899999976;
    tb27 = t10.x<t27.x;
    t9.xy = (bool(tb27)) ? t7.xy : t10.yx;
    t6.xzw = t9.zwx / t9.yyy;
    t27.x = dot(t6.xzw, _Ocean_SunDir.xyzx.xyz);
    t3.x = dot(t6.xzw, t3.xyz);
    t3.x = t3.x + 1.0;
    t3.x = t3.x * 0.5;
    t16 = Rg / t9.y;
    t29.x = t9.y + (-Rg);
    t7.z = t29.x / t44;
    t16 = (-t16) * t16 + 1.0;
    t16 = sqrt(t16);
    tb16 = t27.x<(-t16);
    t6.xz = t27.xx + vec2(0.150000006, 0.200000003);
    t7.xy = t6.xz * vec2(12.262105, 0.833333313);
    t27.x = max(abs(t7.x), 1.0);
    t27.x = float(1.0) / t27.x;
    t29.x = min(abs(t7.x), 1.0);
    t27.x = t27.x * t29.x;
    t29.x = t27.x * t27.x;
    t44 = t29.x * 0.0208350997 + -0.0851330012;
    t44 = t29.x * t44 + 0.180141002;
    t44 = t29.x * t44 + -0.330299497;
    t29.x = t29.x * t44 + 0.999866009;
    t44 = t27.x * t29.x;
    t44 = t44 * -2.0 + 1.57079637;
    tb6 = 1.0<abs(t7.x);
    t44 = tb6 ? t44 : float(0.0);
    t27.x = t27.x * t29.x + t44;
    t29.x = min(t7.x, 1.0);
    t10_8 = textureLod(_Irradiance, t7.yz, 0.0);
    t7.y = sqrt(t7.z);
    t6.xzw = t10_8.xyz * vec3(_Sun_Intensity);
    t6.xzw = t3.xxx * t6.xzw;
    t6.xzw = t6.xzw + t6.xzw;
    tb3 = t29.x<(-t29.x);
    t27.x = (tb3) ? (-t27.x) : t27.x;
    t7.x = t27.x * 0.666666687;
    t10_7 = textureLod(_Transmittance, t7.xy, 0.0);
    t7.xyz = t10_7.xyz * vec3(_Sun_Intensity);
    t3.xyz = (bool(tb16)) ? vec3(0.0, 0.0, 0.0) : t7.xyz;
    t0.xyz = vec3(t39) * t3.xyz + t0.xyz;
    t3.xyz = t3.xyz * t6.yyy + t6.xzw;
    t1.xyz = t1.xyw * t6.xzw;
    t0.xyz = t1.xyz * vec3(0.318309873, 0.318309873, 0.318309873) + t0.xyz;
    t10_1 = texture(_Ocean_Foam0, t2.zw);
    t10_2 = texture(_Ocean_Foam0, t2.xy);
    t16_39 = t10_1.z * t10_1.z;
    t16_1.xy = t10_1.zw + t10_2.xy;
    t16_39 = t10_2.x * t10_2.x + t16_39;
    t10_2 = texture(_Ocean_Foam1, t4.xy);
    t10_4 = texture(_Ocean_Foam1, t4.zw);
    t16_39 = t10_2.x * t10_2.x + t16_39;
    t16_1.xy = t16_1.xy + t10_2.xy;
    t16_1.xy = t10_4.zw + t16_1.xy;
    t16_39 = t10_4.z * t10_4.z + t16_39;
    t16_39 = (-t16_39) + t16_1.y;
    t16_39 = max(t16_39, 0.0);
    t16_39 = sqrt(t16_39);
    t16_39 = float(1.0) / t16_39;
    t2.z = _Ocean_Radius + _Ocean_CameraPos.xxyz.w;
    t2.xy = vec2(0.0, 0.0);
    t14.xyz = t5.xyz * vec3(t42) + (-t2.xyz);
    t14.x = dot(t14.xyz, t14.xyz);
    t14.x = sqrt(t14.x);
    t14.x = t14.x / alphaRadius;
    t14.x = clamp(t14.x, 0.0, 1.0);
    t27.x = (-_Ocean_WhiteCapStr) + farWhiteCapStr;
    t27.x = t14.x * t27.x + _Ocean_WhiteCapStr;
    t1.x = (-t16_1.x) + t27.x;
    t1.x = t1.x * 0.707106769;
    t39 = t16_39 * t1.x;
    ti1 = int((0.0<t39) ? 0xFFFFFFFFu : uint(0u));
    ti27 = int((t39<0.0) ? 0xFFFFFFFFu : uint(0u));
    t39 = t39 * t39;
    ti1 = (-ti1) + ti27;
    t1.x = float(ti1);
    t27.xy = vec2(t39) * vec2(0.140011996, 0.140011996) + vec2(1.27323949, 1.0);
    t39 = (-t39) * t27.x;
    t39 = t39 / t27.y;
    t39 = t39 * 1.44269502;
    t39 = exp2(t39);
    t39 = (-t39) + 1.0;
    t39 = sqrt(t39);
    t39 = t39 * t1.x;
    t39 = t39 * 0.5 + 0.5;
    t1.xzw = vec3(t39) * t3.xyz;
    t0.xyz = t1.xzw * vec3(0.127323955, 0.127323955, 0.127323955) + t0.xyz;
    t0.xyz = t0.xyz * vec3(_Exposure);
    t2 = t0.xxyy * vec4(0.383170009, -1.44269502, 0.383170009, -1.44269502);
    t1.xz = log2(t2.xz);
    t2.xy = exp2(t2.yw);
    t2.xy = (-t2.xy) + vec2(1.0, 1.0);
    t1.xz = t1.xz * vec2(0.454545468, 0.454545468);
    t1.xz = exp2(t1.xz);
    tb0.xyw = lessThan(t0.xyxz, vec4(1.41299999, 1.41299999, 0.0, 1.41299999)).xyw;
    t28.xy = t0.zz * vec2(0.383170009, -1.44269502);
    SV_Target0.x = (tb0.x) ? t1.x : t2.x;
    SV_Target0.y = (tb0.y) ? t1.z : t2.y;
    t0.x = log2(t28.x);
    t13.x = exp2(t28.y);
    t13.x = (-t13.x) + 1.0;
    t0.x = t0.x * 0.454545468;
    t0.x = exp2(t0.x);
    SV_Target0.z = (tb0.w) ? t0.x : t13.x;
    t0.x = (-_OceanAlpha) + 1.0;
    t0.x = t14.x * t0.x + _OceanAlpha;
    SV_Target0.w = t0.x * _GlobalOceanAlpha;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 239 math, 13 textures
Keywords { "SKY_REFLECTIONS_OFF" }
Float 1 [Rg]
Float 2 [Rt]
Float 0 [_Exposure]
Float 12 [_GlobalOceanAlpha]
Float 11 [_OceanAlpha]
Vector 5 [_Ocean_CameraPos]
Vector 7 [_Ocean_Color]
Vector 8 [_Ocean_GridSizes]
Float 4 [_Ocean_Radius]
Vector 6 [_Ocean_SunDir]
Float 9 [_Ocean_WhiteCapStr]
Float 3 [_Sun_Intensity]
Vector 14 [_VarianceMax]
Float 13 [alphaRadius]
Float 10 [farWhiteCapStr]
SetTexture 0 [_Transmittance] 2D 0
SetTexture 1 [_Irradiance] 2D 1
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Ocean_Map1] 2D 3
SetTexture 4 [_Ocean_Map2] 2D 4
SetTexture 5 [_Ocean_Foam0] 2D 5
SetTexture 6 [_Ocean_Foam1] 2D 6
"ps_3_0
def c15, 0, 1, 10, 0.100000001
def c16, 0.25, 0.5, 1.99999995e-005, 0.899999976
def c17, 0.150000006, 0.200000003, 12.262105, 0.833333313
def c18, 0.0208350997, -0.0851330012, 0.180141002, -0.330299497
def c19, 0.999866009, -2, 1.57079637, 0.666666687
def c20, 22.7000008, 1, 1.44269502, 12.566371
def c21, -3.88084984, 5, 1.5, 0.318309873
def c22, 0.980000019, 0.0199999996, 0.00999999978, -0.00999999978
def c23, 0.140011996, 1.27323949, 1, 0.454545468
def c24, 0.383170009, -1.44269502, 0, 0
def c25, 100, 0.707106769, 0.127323955, -1.41299999
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_2d s0
dcl_2d s1
dcl_volume s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
mov r0.xyz, c15
mad r1.xyz, c4.x, r0.xxyw, v1
nrm r2.xyz, r1
rcp r0.w, r1.z
add r0.z, r0.z, c4.x
mad r1.y, r2.z, r0.z, c1.x
mul r1.xzw, r0.z, r2.zyxy
dp3 r2.w, r1.yzww, r1.yzww
mov r3.xz, r1.xyyw
rsq r2.w, r2.w
rcp r3.w, r2.w
dp3 r2.w, r1.xzww, r1.xzww
rsq r2.w, r2.w
rcp r3.y, r2.w
mov r2.w, c16.w
mad r2.w, c1.x, -r2.w, r3.y
cmp r1.xy, r2.w, r3, r3.zwzw
rcp r2.w, r1.y
mul r1.xzw, r1.zywx, r2.w
add r1.y, r1.y, -c1.x
mul r2.w, r2.w, c1.x
mad r2.w, r2.w, -r2.w, c15.y
rsq r2.w, r2.w
rcp r2.w, r2.w
dp3 r3.x, r1.xzww, c6
add r3.yz, r3.x, c17.xxyw
add r2.w, r2.w, r3.x
mul r3.xy, r3.yzzw, c17.zwzw
add r4.x, r3_abs.x, -c15.y
rcp r4.y, r3_abs.x
cmp r4.x, r4.x, r4.y, c15.y
mov_sat r4.y, r3_abs.x
mul r4.x, r4.x, r4.y
mul r4.y, r4.x, r4.x
mad r4.z, r4.y, c18.x, c18.y
mad r4.z, r4.y, r4.z, c18.z
mad r4.z, r4.y, r4.z, c18.w
mad r4.y, r4.y, r4.z, c19.x
mul r4.x, r4.y, r4.x
mad r4.y, r4.x, c19.y, c19.z
add r4.z, -r3_abs.x, c15.y
cmp r4.z, r4.z, c15.x, c15.y
mad r4.x, r4.y, r4.z, r4.x
add r4.y, r4.x, r4.x
min r4.z, r3.x, c15.y
cmp r3.x, r4.z, c15.x, c15.y
mad r3.x, r3.x, -r4.y, r4.x
mul r4.x, r3.x, c19.w
mov r3.x, c1.x
add r3.x, -r3.x, c2.x
rcp r3.x, r3.x
mul r3.z, r1.y, r3.x
rsq r1.y, r3.z
rcp r4.y, r1.y
mov r4.zw, c15.x
texldl r4, r4, s0
mul r4.xyz, r4, c3.x
cmp r4.xyz, r2.w, r4, c15.x
mov r3.w, c15.x
texldl r3, r3.yzww, s1
mul r3.xyz, r3, c3.x
rcp r1.y, c8.x
mul r5.xy, r1.y, v0
texld r6, r5, s3
texld r5, r5, s5
rcp r1.y, c8.y
mul r5.zw, r1.y, v0.xyxy
texld r7, r5.zwzw, s3
texld r8, r5.zwzw, s5
add r5.zw, r6.xyxy, r7
rcp r1.y, c8.z
mul r6.xy, r1.y, v0
texld r7, r6, s4
texld r6, r6, s6
add r5.zw, r5, r7.xyxy
rcp r1.y, c8.w
mul r6.zw, r1.y, v0.xyxy
texld r7, r6.zwzw, s4
texld r9, r6.zwzw, s6
add r5.zw, r5, r7
mad r5.zw, v1.xyxy, -r0.w, r5
mov r7.xy, -r5.zwzw
mov r7.z, c15.y
nrm r10.xyz, r7
dp3 r0.w, r1.xzww, r10
add r0.w, r0.w, c15.y
mul r0.w, r0.w, c16.y
mul r1.xyz, r3, r0.w
add r1.xyz, r1, r1
dp3 r0.w, c6, r10
max r1.w, r0.w, c15.x
max r2.w, r0.w, c22.z
mad r3.xyz, r4, r1.w, r1
mul r0.w, r8.z, r8.z
add r5.yz, r5.xxyw, r8.xzww
mad r0.w, r5.x, r5.x, r0.w
mad r0.w, r6.x, r6.x, r0.w
add r5.xy, r6, r5.yzzw
add r5.xy, r9.zwzw, r5
mad r0.w, r9.z, r9.z, r0.w
add r0.w, -r0.w, r5.y
max r1.w, r0.w, c15.x
rsq r0.w, r1.w
mov r6.x, c4.x
add r6.z, r6.x, c5.z
mov r6.xy, c15.x
mad r2.xyz, r2, r0.z, -r6
dp3 r0.z, r2, r2
rsq r0.z, r0.z
rcp r0.z, r0.z
rcp r1.w, c13.x
mul_sat r0.z, r0.z, r1.w
mov r2.x, c9.x
add r1.w, -r2.x, c10.x
mad r1.w, r0.z, r1.w, c9.x
add r1.w, -r5.x, r1.w
mul r1.w, r1.w, c25.y
mul r0.w, r0.w, r1.w
cmp r1.w, -r0.w, c15.x, c15.y
cmp r2.x, r0.w, -c15.x, -c15.y
mul r0.w, r0.w, r0.w
add r1.w, r1.w, r2.x
mad r2.xy, r0.w, c23.x, c23.yzzw
mul r0.w, -r0.w, r2.x
rcp r2.x, r2.y
mul r0.w, r0.w, r2.x
mul r0.w, r0.w, c20.z
exp r0.w, r0.w
add r0.w, -r0.w, c15.y
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.w, r0.w, r1.w
mad r0.w, r0.w, c16.y, c16.y
mul r2.xyz, r0.w, r3
dsx r3.xy, v0
dsy r3.zw, v0.xyxy
mul r5.xy, r3.zwzw, r3
mul r3.xy, r3, r3
add r0.w, r3.y, r3.x
mul r3.xy, r3.zwzw, r3.zwzw
add r1.w, r3.y, r3.x
add r3.x, r5.y, r5.x
mul r3.x, r3.x, c16.y
mul r3.y, r0.w, r1.w
mul r0.w, r0.w, c15.w
pow r5.x, r0.w, c16.x
mul r0.w, r1.w, c15.w
pow r5.z, r0.w, c16.x
rsq r0.w, r3.y
mad r5.y, r3.x, r0.w, c16.y
texld r3, r5, s2
mul r0.w, r3.x, c14.x
max r1.w, r0.w, c16.z
rcp r0.w, r1.w
mad r3.xyz, c5.z, r0.xxyw, -v1
dp3 r0.x, r3, r3
rsq r0.x, r0.x
mad r5.xyz, r3, r0.x, c6
mul r3.xyz, r0.x, r3
nrm r6.xyz, r5
dp3 r0.x, r6, r10
dp3 r3.w, r3, r10
dp3 r3.x, r3, r6
add r3.x, -r3.x, c15.y
mad r3.y, r0.x, -r0.x, c15.y
add r0.x, r0.x, c15.y
rcp r0.x, r0.x
mul r0.w, r0.w, r3.y
mul r0.w, r0.w, c19.y
mul r0.x, r0.x, r0.w
mul r0.x, r0.x, c20.z
exp r0.x, r0.x
mul r0.w, r1.w, c20.w
rsq r1.w, r1.w
rcp r1.w, r1.w
rcp r0.w, r0.w
mul r0.x, r0.w, r0.x
mul r0.w, r3.x, r3.x
mul r0.w, r0.w, r0.w
mul r0.w, r3.x, r0.w
mad r0.w, r0.w, c22.x, c22.y
mul r0.x, r0.x, r0.w
add r0.w, r3.w, c22.w
rcp r3.x, r3.w
add r3.y, -r3.w, c15.y
cmp r0.w, r0.w, r3.x, c25.x
mul r0.w, r0.w, r2.w
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.x, r0.w, r0.x
max r2.w, r0.x, c15.x
mul r0.x, r1.w, c21.x
pow r0.w, r1.w, c21.z
mad r0.w, r0.w, c20.x, c20.y
rcp r0.w, r0.w
exp r0.x, r0.x
mul r0.x, r0.x, c21.y
pow r1.w, r3.y, r0.x
mul r0.x, r0.w, r1.w
mad r0.w, r1.w, -r0.w, c15.y
mul r0.w, r0.w, c22.x
mul r3.xyz, r0.w, c7
mul r3.xyz, r1, r3
mul r1.xyz, r1, r0.x
mul r1.xyz, r1, c21.w
mad r1.xyz, r2.w, r4, r1
mad r1.xyz, r3, c21.w, r1
mad r1.xyz, r2, c25.z, r1
mov r0.w, c25.w
mad r2.xyz, r1, c0.x, r0.w
mul r1.xyz, r1, c0.x
mul r3, r1.xxyy, c24.xyxy
mul r0.xw, r1.z, c24.xyzy
exp r1.x, r3.y
add r1.x, -r1.x, c15.y
pow r1.y, r3.x, c23.w
cmp oC0.x, r2.x, r1.x, r1.y
exp r1.x, r3.w
pow r1.y, r3.z, c23.w
add r1.x, -r1.x, c15.y
cmp oC0.y, r2.y, r1.x, r1.y
exp r0.w, r0.w
pow r1.x, r0.x, c23.w
add r0.x, -r0.w, c15.y
cmp oC0.z, r2.z, r0.x, r1.x
lrp r1.x, r0.z, r0.y, c11.x
mul oC0.w, r1.x, c12.x

"
}
SubProgram "d3d11 " {
// Stats: 191 math, 9 textures
Keywords { "SKY_REFLECTIONS_OFF" }
SetTexture 0 [_Ocean_Map1] 2D 3
SetTexture 1 [_Ocean_Map2] 2D 4
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Transmittance] 2D 0
SetTexture 4 [_Irradiance] 2D 1
SetTexture 5 [_Ocean_Foam0] 2D 5
SetTexture 6 [_Ocean_Foam1] 2D 6
ConstBuffer "$Globals" 992
Float 192 [_Exposure]
Float 196 [Rg]
Float 200 [Rt]
Float 240 [_Sun_Intensity]
Float 252 [_Ocean_Radius]
Vector 260 [_Ocean_CameraPos] 3
Vector 896 [_Ocean_SunDir] 3
Vector 912 [_Ocean_Color] 3
Vector 928 [_Ocean_GridSizes]
Float 952 [_Ocean_WhiteCapStr]
Float 956 [farWhiteCapStr]
Float 960 [_OceanAlpha]
Float 964 [_GlobalOceanAlpha]
Float 968 [alphaRadius]
Vector 976 [_VarianceMax] 2
BindCB  "$Globals" 0
"ps_4_0
root12:ahabahaa
eefiecedlpjelelbbgikehcipegmomkaajdhceiiabaaaaaaamblaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdebkaaaaeaaaaaaainagaaaa
fjaaaaaeegiocaaaaaaaaaaadoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaaficiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaiaaaaaa
dgaaaaafbcaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaaaaaaaaabaaaaaaaaaaaaaaihcaabaaaaaaaaaaaagacbaaaaaaaaaaa
egbcbaiaebaaaaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
diaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaeiobhkdpabeaaaaaaknhkddm
alaaaaafdcaabaaaacaaaaaaegbabaaaabaaaaaaamaaaaafmcaabaaaacaaaaaa
agbebaaaabaaaaaadiaaaaahdcaabaaaadaaaaaaogakbaaaacaaaaaaegaabaaa
acaaaaaadiaaaaahdcaabaaaacaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaa
aaaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
dcaabaaaacaaaaaaogakbaaaacaaaaaaogakbaaaacaaaaaaaaaaaaahbcaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaahccaabaaaacaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaa
acaaaaaaabeaaaaaaaaaaadpdiaaaaahecaabaaaacaaaaaadkaabaaaabaaaaaa
akaabaaaacaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaa
mnmmmmdncpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadobjaaaaafbcaabaaaadaaaaaa
dkaabaaaabaaaaaadiaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaabeaaaaa
mnmmmmdncpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadobjaaaaafecaabaaaadaaaaaa
dkaabaaaabaaaaaaelaaaaaficaabaaaabaaaaaackaabaaaacaaaaaaaoaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaahccaabaaa
adaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaadpefaaaaajpcaabaaaacaaaaaa
egacbaaaadaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaaiicaabaaa
abaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaadnaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaakmmfkhdhdiaaaaahbcaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaanlapejebaoaaaaaipcaabaaaadaaaaaaegbebaaa
abaaaaaaagifcaaaaaaaaaaadkaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaaaaaaaahgcaabaaa
acaaaaaaagabbaaaaeaaaaaakgalbaaaafaaaaaaaoaaaaaipcaabaaaaeaaaaaa
egbebaaaabaaaaaakgipcaaaaaaaaaaadkaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahgcaabaaa
acaaaaaafgagbaaaacaaaaaaagabbaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahgcaabaaa
acaaaaaafgagbaaaacaaaaaakgalbaaaafaaaaaadgaaaaafbcaabaaaafaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaafaaaaaadkiacaaaaaaaaaaaapaaaaaa
aaaaaaahhcaabaaaafaaaaaaagacbaaaafaaaaaaegbcbaaaacaaaaaaaoaaaaah
dcaabaaaagaaaaaaegbabaaaacaaaaaakgakbaaaafaaaaaaaaaaaaaigcaabaaa
acaaaaaafgagbaaaacaaaaaaagabbaiaebaaaaaaagaaaaaadgaaaaagdcaabaaa
agaaaaaajgafbaiaebaaaaaaacaaaaaadgaaaaafecaabaaaagaaaaaaabeaaaaa
aaaaiadpbaaaaaahccaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
eeaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahocaabaaaacaaaaaa
fgafbaaaacaaaaaaagajbaaaagaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
abaaaaaajgahbaaaacaaaaaadcaaaaakccaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaoaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaadkaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaamaaoaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaadlkklidpbjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
acaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
baaaaaahbcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaacaaaaaadeaaaaah
ccaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaknhcddmaaaaaaaibcaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpcpaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaabaaaaaaiecaabaaaaaaaaaaaegiccaaaaaaaaaaa
diaaaaaajgahbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaakgakbaaaaaaaaaaa
aceaaaaaaknhcddmaaaaaaaaaaaaaaaaaaaaaaaaaoaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaadkiacaaaaaaaaaaaapaaaaaa
abeaaaaaaaaacaebdcaaaaakccaabaaaagaaaaaackaabaaaafaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaamaaaaaadiaaaaahncaabaaaagaaaaaakgakbaaa
aaaaaaaakgaebaaaafaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaaagaaaaaa
jgahbaaaagaaaaaadgaaaaaffcaabaaaahaaaaaafgaebaaaagaaaaaaelaaaaaf
ccaabaaaahaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaigadbaaa
agaaaaaaigadbaaaagaaaaaaelaaaaaficaabaaaahaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaaamaaaaaaabeaaaaaggggggdp
dbaaaaahicaabaaaaaaaaaaadkaabaaaahaaaaaadkaabaaaaaaaaaaadhaaaaaj
dcaabaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaahaaaaaaogakbaaaahaaaaaa
aoaaaaahncaabaaaagaaaaaakgadbaaaagaaaaaafgafbaaaagaaaaaabaaaaaai
icaabaaaaaaaaaaaigadbaaaagaaaaaaegiccaaaaaaaaaaadiaaaaaabaaaaaah
bcaabaaaabaaaaaaigadbaaaagaaaaaajgahbaaaacaaaaaaaaaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpaaaaaaakdcaabaaaacaaaaaapgapbaaa
aaaaaaaaaceaaaaajkjjbjdomnmmemdoaaaaaaaaaaaaaaaadiaaaaakdcaabaaa
acaaaaaaegaabaaaacaaaaaaaceaaaaajfdbeeebffffffdpaaaaaaaaaaaaaaaa
deaaaaaiicaabaaaabaaaaaaakaabaiaibaaaaaaacaaaaaaabeaaaaaaaaaiadp
aoaaaaakicaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
dkaabaaaabaaaaaaddaaaaaiicaabaaaacaaaaaaakaabaiaibaaaaaaacaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
acaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaafaaaaaadkaabaaaacaaaaaaabeaaaaafpkokkdmabeaaaaa
dgfkkolndcaaaaajicaabaaaafaaaaaadkaabaaaacaaaaaadkaabaaaafaaaaaa
abeaaaaaochgdidodcaaaaajicaabaaaafaaaaaadkaabaaaacaaaaaadkaabaaa
afaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaa
dkaabaaaafaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaafaaaaaadkaabaaa
abaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaa
abeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaibcaabaaaagaaaaaaabeaaaaa
aaaaiadpakaabaiaibaaaaaaacaaaaaaabaaaaahicaabaaaafaaaaaadkaabaaa
afaaaaaaakaabaaaagaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaaabaaaaaa
dkaabaaaacaaaaaadkaabaaaafaaaaaaddaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaiadpdbaaaaaibcaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaadhaaaaakicaabaaaabaaaaaaakaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaahaaaaaa
dkaabaaaabaaaaaaabeaaaaaklkkckdpaaaaaaajicaabaaaabaaaaaabkaabaaa
agaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaaoaaaaaibcaabaaaacaaaaaa
bkiacaaaaaaaaaaaamaaaaaabkaabaaaagaaaaaadcaaaaakbcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaacaaaaaaaaaaaaakbcaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaaamaaaaaaaoaaaaahecaabaaa
acaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaelaaaaafccaabaaaahaaaaaa
ckaabaaaacaaaaaaeiaaaaalpcaabaaaacaaaaaajgafbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaagiacaaaaaaaaaaaapaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaaahaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaagiacaaaaaaaaaaaapaaaaaadhaaaaamhcaabaaa
agaaaaaapgapbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaagaaaaaacpaaaaaficaabaaaaaaaaaaackaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaanifphimabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaakaeadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamadpbjaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadcaaaaajicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
jkjjlfebabeaaaaaaaaaiadpaoaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahncaabaaaabaaaaaaagajbaaaacaaaaaaagaabaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaeiobhkdp
diaaaaaihcaabaaaahaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaadjaaaaaa
diaaaaahhcaabaaaahaaaaaaegacbaaaacaaaaaaegacbaaaahaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaagaaaaaafgafbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaakhcaabaaaabaaaaaaigadbaaaabaaaaaaaceaaaaaidpjkcdoidpjkcdo
idpjkcdoaaaaaaaadcaaaaajlcaabaaaaaaaaaaafgafbaaaaaaaaaaaegaibaaa
agaaaaaaegaibaaaabaaaaaadcaaaaamlcaabaaaaaaaaaaaegaibaaaahaaaaaa
aceaaaaaidpjkcdoidpjkcdoaaaaaaaaidpjkcdoegambaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogakbaaaadaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaadaaaaaaeghobaaaafaaaaaaaagabaaa
afaaaaaadiaaaaahbcaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaa
aaaaaaahgcaabaaaabaaaaaakgalbaaaabaaaaaaagabbaaaadaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaadaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaaeaaaaaaeghobaaaagaaaaaaaagabaaa
agaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaagaaaaaa
aagabaaaagaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaa
adaaaaaaakaabaaaabaaaaaaaaaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaa
agabbaaaadaaaaaaaaaaaaahgcaabaaaabaaaaaakgalbaaaaeaaaaaafgagbaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaeaaaaaackaabaaaaeaaaaaa
akaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaakbcaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaa
aaaaaaajecaabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaa
baaaaaaadgaaaaaidcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaafaaaaaakgakbaaaaaaaaaaa
egacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaocaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaadmaaaaaaaaaaaaak
ecaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaadlaaaaaadkiacaaaaaaaaaaa
dlaaaaaadcaaaaakecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaadlaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaapdaedfdpdiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadbaaaaahccaabaaaabaaaaaaabeaaaaaaaaaaaaaakaabaaaabaaaaaa
dbaaaaahecaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaaboaaaaaiccaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadcaaaaapmcaabaaaabaaaaaaagaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaeofpapdoeofpapdoaceaaaaaaaaaaaaaaaaaaaaa
idpjkcdpaaaaiadpdiaaaaaibcaabaaaabaaaaaackaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaadlkklidp
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaaadpdiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaamlcaabaaaaaaaaaaaegaibaaaabaaaaaaaceaaaaadggbacdo
dggbacdoaaaaaaaadggbacdoegambaaaaaaaaaaadiaaaaailcaabaaaaaaaaaaa
egambaaaaaaaaaaaagiacaaaaaaaaaaaamaaaaaadiaaaaakpcaabaaaabaaaaaa
agafbaaaaaaaaaaaaceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaf
fcaabaaaabaaaaaaagacbaaaabaaaaaabjaaaaafkcaabaaaabaaaaaafganbaaa
abaaaaaaaaaaaaalkcaabaaaabaaaaaafganbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaaaaaaaaaiadpdiaaaaakfcaabaaaabaaaaaaagacbaaa
abaaaaaaaceaaaaacplkoidoaaaaaaaacplkoidoaaaaaaaabjaaaaaffcaabaaa
abaaaaaaagacbaaaabaaaaaadbaaaaakhcaabaaaacaaaaaaegadbaaaaaaaaaaa
aceaaaaacpnnledpcpnnledpcpnnledpaaaaaaaadiaaaaakdcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaaceaaaaanmcomedodlkklilpaaaaaaaaaaaaaaaadhaaaaaj
dccabaaaaaaaaaaaegaabaaaacaaaaaaigaabaaaabaaaaaangafbaaaabaaaaaa
cpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaabjaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
cplkoidobjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajeccabaaa
aaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaaj
bcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaadmaaaaaaabeaaaaaaaaaiadp
dcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaadmaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaadmaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GL3x"
}
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 388 math, 21 textures
Keywords { "SKY_REFLECTIONS_ON" }
Float 0 [M_PI]
Float 7 [RES_MU]
Float 8 [RES_MU_S]
Float 9 [RES_NU]
Float 6 [RES_R]
Float 4 [Rg]
Float 5 [Rt]
Float 3 [_Exposure]
Float 21 [_GlobalOceanAlpha]
Float 20 [_OceanAlpha]
Vector 14 [_Ocean_CameraPos]
Vector 16 [_Ocean_Color]
Vector 17 [_Ocean_GridSizes]
Float 13 [_Ocean_Radius]
Vector 15 [_Ocean_SunDir]
Float 18 [_Ocean_WhiteCapStr]
Float 10 [_Sun_Intensity]
Vector 23 [_VarianceMax]
Float 11 [_experimentalAtmoScale]
Float 12 [_viewdirOffset]
Float 22 [alphaRadius]
Vector 1 [betaR]
Float 19 [farWhiteCapStr]
Float 2 [mieG]
SetTexture 0 [_Transmittance] 2D 0
SetTexture 1 [_Inscatter] 2D 1
SetTexture 2 [_Irradiance] 2D 2
SetTexture 3 [_Ocean_Variance] 3D 3
SetTexture 4 [_Ocean_Map1] 2D 4
SetTexture 5 [_Ocean_Map2] 2D 5
SetTexture 6 [_Ocean_Foam0] 2D 6
SetTexture 7 [_Ocean_Foam1] 2D 7
"ps_3_0
def c24, 0, 1, 10, 0.100000001
def c25, 0.25, 0.5, 1.99999995e-005, 0.899999976
def c26, 0.150000006, 0.200000003, 12.262105, 0.833333313
def c27, 0.0208350997, -0.0851330012, 0.180141002, -0.330299497
def c28, 0.999866009, -2, 1.57079637, 0.666666687
def c29, -9.99999997e-007, 0.197500005, 5.34962368, -1.05655074
def c30, 0.909090877, 0.74000001, -9.99999975e-005, 10000
def c31, 1, 2, -3.88084984, 5
def c32, 0.980000019, 0.0199999996, 0.00999999978, -0.00999999978
def c33, 0.140011996, 1.27323949, 1, -1.41299999
def c34, 100, 0.707106769, 0.318309873, 0.127323955
def c35, 0.383170009, -1.44269502, 0.454545468, 0
def c36, 22.7000008, 1, 1.44269502, 12.566371
def c37, 16, 4, 3, 1.5
dcl_texcoord v0.xy
dcl_texcoord1 v1.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_volume s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
mov r0.x, -c24.y
mov r1.xyz, c24.yxxw
rcp r2.x, c17.x
mul r2.xy, r2.x, v0
texld r3, r2, s4
texld r2, r2, s6
rcp r2.z, c17.y
mul r2.zw, r2.z, v0.xyxy
texld r4, r2.zwzw, s4
texld r5, r2.zwzw, s6
add r2.zw, r3.xyxy, r4
rcp r3.x, c17.z
mul r3.xy, r3.x, v0
texld r4, r3, s5
texld r3, r3, s7
add r2.zw, r2, r4.xyxy
rcp r3.z, c17.w
mul r3.zw, r3.z, v0.xyxy
texld r4, r3.zwzw, s5
texld r6, r3.zwzw, s7
add r2.zw, r2, r4
mov r4.xyz, c24
mad r7.xyz, c13.x, r4.xxyw, v1
rcp r3.z, r7.z
nrm r8.xyz, r7
mad r2.zw, v1.xyxy, -r3.z, r2
mov r7.xy, -r2.zwzw
mov r7.z, c24.y
nrm r9.xyz, r7
mad r7.xyz, c14.z, r4.xxyw, -v1
dp3 r2.z, r7, r7
rsq r2.z, r2.z
mul r10.xyz, r2.z, r7
mad r7.xyz, r7, r2.z, c15
nrm r11.xyz, r7
dp3 r2.z, -r10, r9
add r2.z, r2.z, r2.z
mad r7.xyz, r9, -r2.z, -r10
max r12.z, r7.z, c24.x
add r12.x, r7.x, c12.x
mov r12.y, r7.y
nrm r7.xyz, r12
add r2.z, r4.z, c13.x
mul r12.xzw, r2.z, r8.zyxy
dp3 r13.z, r12.zwxw, r7
dp3 r2.w, r12.xzww, r12.xzww
rsq r2.w, r2.w
rcp r13.x, r2.w
mul r2.w, r13.x, r13.x
mad r2.w, r13.z, r13.z, -r2.w
mov r4.x, c4.x
add r3.z, -r4.x, c5.x
mad r5.x, r3.z, c11.x, r4.x
rcp r3.z, r3.z
mad r2.w, r5.x, r5.x, r2.w
rsq r3.w, r2.w
rcp r3.w, r3.w
cmp r2.w, r2.w, -r3.w, c29.x
add r2.w, r2.w, -r13.z
max r3.w, r2.w, c24.x
add r5.y, r3.w, r13.z
cmp r4.zw, -r3.w, r13.xyxz, r5.xyxy
mul r2.w, r4.z, r4.z
rcp r5.y, r4.z
mul r4.w, r4.w, r5.y
mul r4.w, r4.w, r4.z
mad r2.w, r4.w, r4.w, -r2.w
mad r2.w, c4.x, c4.x, r2.w
cmp r6.x, -r2.w, -c24.x, -c24.y
cmp r6.x, r4.w, c24.x, r6.x
rcp r6.y, c7.x
mad r1.w, r6.y, -c25.y, c25.y
mul r7.w, c4.x, c4.x
mad r8.w, r5.x, r5.x, -r7.w
add r5.x, -r4.z, r5.x
mad r4.z, r4.z, r4.z, -r7.w
rsq r4.z, r4.z
rcp r4.z, r4.z
rsq r7.w, r8.w
rcp r0.z, r7.w
mul r7.w, r4.z, r7.w
mul r0.y, r0.z, r0.z
mad r0.w, r6.y, c25.y, c25.y
add r6.y, -r6.y, c25.y
cmp r0, r6.x, r0, r1
add r0.y, r0.y, r2.w
rsq r0.y, r0.y
rcp r0.y, r0.y
mad r0.x, r4.w, r0.x, r0.y
add r0.y, r0.z, r4.z
rcp r0.y, r0.y
mul r0.x, r0.y, r0.x
mad r0.x, r0.x, r6.y, r0.w
rcp r0.y, c6.x
mul r0.x, r0.y, r0.x
lrp r1.x, r0.y, c25.y, r7.w
mul r0.z, r1.x, c6.x
mad r0.w, r1.x, c6.x, -r4.y
frc r1.x, r0.z
add r0.zw, r0, -r1.x
mad r14.y, r0.z, r0.y, r0.x
mad r1.yzw, r3.w, r7.xxyz, r12.xzwx
dp3 r0.z, r7, c15
cmp r1.yzw, -r3.w, r12.xzwx, r1
dp3 r1.y, r1.yzww, c15
mul r1.z, r5.y, r1.y
mad r1.y, r1.y, r5.y, c29.y
mul r1.z, r1.z, c29.z
cmp r1.y, r1.y, r1.z, c29.w
add r1.z, r1_abs.y, -c24.y
rcp r1.w, r1_abs.y
cmp r1.z, r1.z, r1.w, c24.y
mov_sat r1.w, r1_abs.y
mul r1.z, r1.z, r1.w
mul r1.w, r1.z, r1.z
mad r2.w, r1.w, c27.x, c27.y
mad r2.w, r1.w, r2.w, c27.z
mad r2.w, r1.w, r2.w, c27.w
mad r1.w, r1.w, r2.w, c28.x
mul r1.z, r1.w, r1.z
mad r1.w, r1.z, c28.y, c28.z
add r2.w, -r1_abs.y, c24.y
min r3.w, r1.y, c24.y
cmp r1.y, r3.w, c24.x, c24.y
cmp r2.w, r2.w, c24.x, c24.y
mad r1.z, r1.w, r2.w, r1.z
add r1.w, r1.z, r1.z
mad r1.y, r1.y, -r1.w, r1.z
mad r1.y, r1.y, c30.x, c30.y
mul r1.y, r1.y, c25.y
rcp r1.z, c8.x
lrp r2.w, r1.z, c25.y, r1.y
add r1.y, r0.z, c24.y
mul r1.y, r1.y, c25.y
add r1.z, -r4.y, c9.x
mul r1.w, r1.z, r1.y
frc r3.w, r1.w
add r1.w, r1.w, -r3.w
add r2.w, r2.w, r1.w
mad r1.y, r1.y, r1.z, -r1.w
add r1.z, r2.w, c24.y
rcp r1.w, c9.x
mul r7.x, r1.w, r1.z
mul r7.y, r1.w, r2.w
mov r7.w, c24.x
mov r14.xzw, r7.xyww
texldl r15, r14, s1
mov r14.xzw, r7.yyww
texldl r14, r14, s1
lrp r16, r1.y, r15, r14
mad r7.z, r0.w, r0.y, r0.x
texldl r14, r7.xzww, s1
texldl r7, r7.yzww, s1
lrp r15, r1.y, r14, r7
lrp r7, r1.x, r16, r15
add r0.x, r7.x, c30.z
rcp r0.y, r7.x
cmp r0.x, r0.x, r0.y, c30.w
mul r1.xyz, r7.w, r7
mul r0.xyw, r0.x, r1.xyzz
rcp r1.x, c1.x
rcp r1.y, c1.y
rcp r1.z, c1.z
mul r1.xyz, r1, c1.x
mul r0.xyw, r0, r1.xyzz
mov r1.x, c2.x
mad r1.xy, r1.x, r1.x, c31
dp2add r1.x, r0.z, -c2.x, r1.x
mad r0.z, r0.z, r0.z, c24.y
rcp r1.y, r1.y
pow r2.w, r1.x, -c37.w
mov r6.xy, c37
mul r1.xz, r6.xyyw, c0.x
rcp r1.z, r1.z
rcp r1.x, r1.x
mul r1.xz, r1, c37.zyww
mul r1.x, r0.z, r1.x
mad r1.w, c2.x, -c2.x, r4.y
mul r1.z, r1.w, r1.z
mul r1.z, r2.w, r1.z
mul r0.z, r0.z, r1.z
mul r0.z, r1.y, r0.z
mul r0.xyz, r0.z, r0.xyww
mad r0.xyz, r7, r1.x, r0
mul r0.xyz, r0, c10.x
cmp r0.xyz, r5.x, r0, c24.x
dsx r1.xy, v0
dsy r1.zw, v0.xyxy
mul r4.zw, r1, r1.xyxy
mul r1.xy, r1, r1
add r0.w, r1.y, r1.x
mul r1.xy, r1.zwzw, r1.zwzw
add r1.x, r1.y, r1.x
add r1.y, r4.w, r4.z
mul r1.y, r1.y, c25.y
mul r1.z, r0.w, r1.x
mul r0.w, r0.w, c24.w
pow r7.x, r0.w, c25.x
mul r0.w, r1.x, c24.w
pow r7.z, r0.w, c25.x
rsq r0.w, r1.z
mad r7.y, r1.y, r0.w, c25.y
texld r1, r7, s3
mul r0.w, r1.x, c23.x
max r1.x, r0.w, c25.z
rsq r0.w, r1.x
rcp r0.w, r0.w
mul r1.y, r0.w, c31.z
pow r1.z, r0.w, c37.w
mad r0.w, r1.z, c36.x, c36.y
rcp r0.w, r0.w
exp r1.y, r1.y
mul r1.y, r1.y, c31.w
dp3 r1.z, r10, r9
dp3 r1.w, r10, r11
dp3 r2.w, r11, r9
add r1.w, -r1.w, c24.y
add r3.w, -r1.z, c24.y
pow r4.z, r3.w, r1.y
mul r1.y, r0.w, r4.z
mad r0.w, r4.z, -r0.w, c24.y
mul r0.w, r0.w, c32.x
mul r7.xyz, r0.w, c16
mul r0.w, r1.w, r1.w
mul r0.w, r0.w, r0.w
mul r0, r0, r1.yyyw
mad r0.w, r0.w, c32.x, c32.y
rcp r1.y, r1.x
mul r1.x, r1.x, c36.w
rcp r1.x, r1.x
mad r1.w, r2.w, -r2.w, c24.y
add r2.w, r2.w, c24.y
rcp r2.w, r2.w
mul r1.y, r1.y, r1.w
mul r1.y, r1.y, c28.y
mul r1.y, r2.w, r1.y
mul r1.y, r1.y, c36.z
exp r1.y, r1.y
mul r1.x, r1.x, r1.y
mul r0.w, r0.w, r1.x
add r1.x, r1.z, c32.w
rcp r1.y, r1.z
cmp r1.x, r1.x, r1.y, c34.x
dp3 r1.y, c15, r9
max r2.w, r1.y, c32.z
max r3.w, r1.y, c24.x
mul r1.x, r1.x, r2.w
rsq r1.x, r1.x
rcp r1.x, r1.x
mul r0.w, r0.w, r1.x
max r1.x, r0.w, c24.x
mad r12.y, r8.z, r2.z, c4.x
dp3 r0.w, r12.yzww, r12.yzww
mov r5.x, r12.y
rsq r0.w, r0.w
rcp r5.y, r0.w
mad r0.w, r4.x, -c25.w, r13.x
mov r13.y, r12.x
cmp r12.xy, r0.w, r13.yxzw, r5
rcp r0.w, r12.y
mul r1.yzw, r0.w, r12.xzwx
add r2.w, r12.y, -c4.x
mul r10.z, r3.z, r2.w
mul r0.w, r0.w, c4.x
mad r0.w, r0.w, -r0.w, c24.y
rsq r0.w, r0.w
rcp r0.w, r0.w
dp3 r2.w, r1.yzww, c15
dp3 r1.y, r1.yzww, r9
add r1.y, r1.y, c24.y
mul r1.y, r1.y, c25.y
add r0.w, r0.w, r2.w
add r1.zw, r2.w, c26.xyxy
mul r10.xy, r1.zwzw, c26.zwzw
add r1.z, r10_abs.x, -c24.y
rcp r1.w, r10_abs.x
cmp r1.z, r1.z, r1.w, c24.y
mov_sat r1.w, r10_abs.x
mul r1.z, r1.z, r1.w
mul r1.w, r1.z, r1.z
mad r2.w, r1.w, c27.x, c27.y
mad r2.w, r1.w, r2.w, c27.z
mad r2.w, r1.w, r2.w, c27.w
mad r1.w, r1.w, r2.w, c28.x
mul r1.z, r1.w, r1.z
mad r1.w, r1.z, c28.y, c28.z
add r2.w, -r10_abs.x, c24.y
cmp r2.w, r2.w, c24.x, c24.y
mad r1.z, r1.w, r2.w, r1.z
add r1.w, r1.z, r1.z
min r2.w, r10.x, c24.y
cmp r2.w, r2.w, c24.x, c24.y
mad r1.z, r2.w, -r1.w, r1.z
mul r9.x, r1.z, c28.w
rsq r1.z, r10.z
rcp r9.y, r1.z
mov r9.zw, c24.x
texldl r9, r9, s0
mul r4.xzw, r9.xyyz, c10.x
cmp r4.xzw, r0.w, r4, c24.x
mad r0.xyz, r1.x, r4.xzww, r0
mov r10.w, c24.x
texldl r9, r10.yzww, s2
mul r1.xzw, r9.xyyz, c10.x
mul r1.xyz, r1.xzww, r1.y
add r1.xyz, r1, r1
mul r7.xyz, r1, r7
mad r1.xyz, r4.xzww, r3.w, r1
mad r0.xyz, r7, c34.z, r0
mul r0.w, r5.z, r5.z
add r2.yw, r2.xxzy, r5.xzzw
mad r0.w, r2.x, r2.x, r0.w
mad r0.w, r3.x, r3.x, r0.w
add r2.xy, r3, r2.ywzw
add r2.xy, r6.zwzw, r2
mad r0.w, r6.z, r6.z, r0.w
add r0.w, -r0.w, r2.y
max r1.w, r0.w, c24.x
rsq r0.w, r1.w
mov r3.x, c13.x
add r3.z, r3.x, c14.z
mov r3.xy, c24.x
mad r2.yzw, r8.xxyz, r2.z, -r3.xxyz
dp3 r1.w, r2.yzww, r2.yzww
rsq r1.w, r1.w
rcp r1.w, r1.w
rcp r2.y, c22.x
mul_sat r1.w, r1.w, r2.y
mov r3.x, c18.x
add r2.y, -r3.x, c19.x
mad r2.y, r1.w, r2.y, c18.x
add r2.x, -r2.x, r2.y
mul r2.x, r2.x, c34.y
mul r0.w, r0.w, r2.x
cmp r2.x, -r0.w, c24.x, c24.y
cmp r2.y, r0.w, -c24.x, -c24.y
mul r0.w, r0.w, r0.w
add r2.x, r2.y, r2.x
mad r2.yz, r0.w, c33.x, c33
mul r0.w, -r0.w, r2.y
rcp r2.y, r2.z
mul r0.w, r0.w, r2.y
mul r0.w, r0.w, c36.z
exp r0.w, r0.w
add r0.w, -r0.w, c24.y
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.w, r0.w, r2.x
mad r0.w, r0.w, c25.y, c25.y
mul r1.xyz, r0.w, r1
mad r0.xyz, r1, c34.w, r0
mov r0.w, c33.w
mad r1.xyz, r0, c3.x, r0.w
mul r0.xyz, r0, c3.x
mul r2, r0.xxyy, c35.xyxy
mul r0.xy, r0.z, c35
exp r0.z, r2.y
add r0.z, -r0.z, c24.y
pow r0.w, r2.x, c35.z
cmp oC0.x, r1.x, r0.z, r0.w
exp r0.z, r2.w
pow r0.w, r2.z, c35.z
add r0.z, -r0.z, c24.y
cmp oC0.y, r1.y, r0.z, r0.w
exp r0.y, r0.y
pow r1.x, r0.x, c35.z
add r0.x, -r0.y, c24.y
cmp oC0.z, r1.z, r0.x, r1.x
lrp r0.x, r1.w, r4.y, c20.x
mul oC0.w, r0.x, c21.x

"
}
SubProgram "d3d11 " {
// Stats: 308 math, 9 textures
Keywords { "SKY_REFLECTIONS_ON" }
SetTexture 0 [_Ocean_Map1] 2D 4
SetTexture 1 [_Ocean_Map2] 2D 5
SetTexture 2 [_Ocean_Variance] 3D 3
SetTexture 3 [_Transmittance] 2D 0
SetTexture 4 [_Irradiance] 2D 2
SetTexture 5 [_Inscatter] 2D 1
SetTexture 6 [_Ocean_Foam0] 2D 6
SetTexture 7 [_Ocean_Foam1] 2D 7
ConstBuffer "$Globals" 992
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
Float 252 [_Ocean_Radius]
Vector 260 [_Ocean_CameraPos] 3
Vector 896 [_Ocean_SunDir] 3
Vector 912 [_Ocean_Color] 3
Vector 928 [_Ocean_GridSizes]
Float 952 [_Ocean_WhiteCapStr]
Float 956 [farWhiteCapStr]
Float 960 [_OceanAlpha]
Float 964 [_GlobalOceanAlpha]
Float 968 [alphaRadius]
Vector 976 [_VarianceMax] 2
BindCB  "$Globals" 0
"ps_4_0
root12:aiabaiaa
eefiecedmeocopfnacbjilkejmdnbgojcfoemlcgabaaaaaaeeclaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmckaaaaeaaaaaaajlakaaaa
fjaaaaaeegiocaaaaaaaaaaadoaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafkaaaaadaagabaaaahaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaaficiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
fibiaaaeaahabaaaafaaaaaaffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaa
fibiaaaeaahabaaaahaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacanaaaaaadgaaaaai
hcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaf
bcaabaaaabaaaaaaabeaaaaaaaaaialpaoaaaaaipcaabaaaacaaaaaaegbebaaa
abaaaaaaagifcaaaaaaaaaaadkaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaogakbaaaaeaaaaaaaoaaaaaipcaabaaaaeaaaaaa
egbebaaaabaaaaaakgipcaaaaaaaaaaadkaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaegaabaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaogakbaaaafaaaaaadgaaaaafbcaabaaaafaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaafaaaaaadkiacaaaaaaaaaaaapaaaaaa
aaaaaaahhcaabaaaafaaaaaaagacbaaaafaaaaaaegbcbaaaacaaaaaaaoaaaaah
mcaabaaaadaaaaaaagbebaaaacaaaaaakgakbaaaafaaaaaaaaaaaaaidcaabaaa
adaaaaaaogakbaiaebaaaaaaadaaaaaaegaabaaaadaaaaaadgaaaaagdcaabaaa
adaaaaaaegaabaiaebaaaaaaadaaaaaadgaaaaafecaabaaaadaaaaaaabeaaaaa
aaaaiadpbaaaaaahicaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaadaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaagaaaaaaabeaaaaa
aaaaaaaadgaaaaagecaabaaaagaaaaaadkiacaaaaaaaaaaabaaaaaaaaaaaaaai
hcaabaaaagaaaaaaagacbaaaagaaaaaaegbcbaiaebaaaaaaacaaaaaabaaaaaah
icaabaaaadaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaadaaaaaa
egacbaaaagaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaadiaaaaaabaaaaaaiicaabaaaadaaaaaaegacbaia
ebaaaaaaahaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaadkaabaaaadaaaaaadcaaaaalhcaabaaaaiaaaaaaegacbaaaadaaaaaa
pgapbaiaebaaaaaaadaaaaaaegacbaiaebaaaaaaahaaaaaadeaaaaahecaabaaa
aiaaaaaackaabaaaaiaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaiaaaaaa
akaabaaaaiaaaaaackiacaaaaaaaaaaaapaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaadiaaaaahhcaabaaaaiaaaaaapgapbaaaadaaaaaaegacbaaaaiaaaaaa
baaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaafaaaaaapgapbaaa
adaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaadaaaaaadkiacaaaaaaaaaaa
apaaaaaaabeaaaaaaaaacaebdiaaaaahncaabaaaajaaaaaapgapbaaaadaaaaaa
kgaebaaaafaaaaaabaaaaaahecaabaaaakaaaaaaogaibaaaajaaaaaaegacbaaa
aiaaaaaabaaaaaahicaabaaaafaaaaaaigadbaaaajaaaaaaigadbaaaajaaaaaa
dcaaaaakicaabaaaagaaaaaackaabaaaakaaaaaackaabaaaakaaaaaadkaabaia
ebaaaaaaafaaaaaaelaaaaafbcaabaaaakaaaaaadkaabaaaafaaaaaaaaaaaaak
icaabaaaafaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaackiacaaaaaaaaaaa
amaaaaaadcaaaaalbcaabaaaalaaaaaadkaabaaaafaaaaaabkiacaaaaaaaaaaa
apaaaaaabkiacaaaaaaaaaaaamaaaaaadcaaaaajicaabaaaagaaaaaaakaabaaa
alaaaaaaakaabaaaalaaaaaadkaabaaaagaaaaaabnaaaaahicaabaaaahaaaaaa
dkaabaaaagaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaagaaaaaadkaabaaa
agaaaaaadhaaaaakicaabaaaagaaaaaadkaabaaaahaaaaaadkaabaiaebaaaaaa
agaaaaaaabeaaaaalndhiglfaaaaaaaiicaabaaaagaaaaaadkaabaaaagaaaaaa
ckaabaiaebaaaaaaakaaaaaadeaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaalaaaaaadkaabaaaagaaaaaackaabaaa
akaaaaaadbaaaaahicaabaaaahaaaaaaabeaaaaaaaaaaaaadkaabaaaagaaaaaa
dcaaaaajhcaabaaaamaaaaaapgapbaaaagaaaaaaegacbaaaaiaaaaaaogaibaaa
ajaaaaaabaaaaaaiicaabaaaagaaaaaaegacbaaaaiaaaaaaegiccaaaaaaaaaaa
diaaaaaadhaaaaajhcaabaaaaiaaaaaapgapbaaaahaaaaaaegacbaaaamaaaaaa
ogaibaaaajaaaaaadhaaaaajmcaabaaaakaaaaaapgapbaaaahaaaaaaagaebaaa
alaaaaaaagaibaaaakaaaaaabaaaaaaiicaabaaaahaaaaaaegacbaaaaiaaaaaa
egiccaaaaaaaaaaadiaaaaaaaoaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaa
ckaabaaaakaaaaaadeaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaaabeaaaaa
hbdneklodiaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaaabeaaaaabodaklea
diaaaaahbcaabaaaaiaaaaaackaabaaaakaaaaaackaabaaaakaaaaaadcaaaaak
bcaabaaaaiaaaaaadkaabaaaakaaaaaadkaabaaaakaaaaaaakaabaiaebaaaaaa
aiaaaaaadcaaaaalbcaabaaaaiaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaaakaabaaaaiaaaaaadbaaaaahccaabaaaaiaaaaaaabeaaaaa
aaaaaaaaakaabaaaaiaaaaaadbaaaaahecaabaaaaiaaaaaadkaabaaaakaaaaaa
abeaaaaaaaaaaaaaabaaaaahccaabaaaaiaaaaaabkaabaaaaiaaaaaackaabaaa
aiaaaaaadiaaaaajecaabaaaaiaaaaaabkiacaaaaaaaaaaaamaaaaaabkiacaaa
aaaaaaaaamaaaaaadcaaaaakicaabaaaaiaaaaaaakaabaaaalaaaaaaakaabaaa
alaaaaaackaabaiaebaaaaaaaiaaaaaabnaaaaahbcaabaaaalaaaaaaakaabaaa
alaaaaaackaabaaaakaaaaaadcaaaaakecaabaaaaiaaaaaackaabaaaakaaaaaa
ckaabaaaakaaaaaackaabaiaebaaaaaaaiaaaaaaelaaaaafecaabaaaaiaaaaaa
ckaabaaaaiaaaaaaelaaaaafecaabaaaabaaaaaadkaabaaaaiaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaalocaabaaa
alaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgiicaaaaaaaaaaa
anaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaalaaaaaaabeaaaaa
aaaaaadpaaaaaaahicaabaaaabaaaaaabkaabaaaalaaaaaaabeaaaaaaaaaaadp
dhaaaaajpcaabaaaaaaaaaaafgafbaaaaiaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaiaaaaaackaabaaaabaaaaaa
aaaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagacbaaaaiaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
akaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaalocaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaaanaaaaaaaaaaaaal
ocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaadpaaaaiadpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaalaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaanaaaaaaebaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaanaaaaaaaaaaaaahecaabaaaaiaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaadeaaaaaiecaabaaaaaaaaaaadkaabaiaibaaaaaaahaaaaaa
abeaaaaaaaaaiadpaoaaaaakecaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpckaabaaaaaaaaaaaddaaaaaiicaabaaaaaaaaaaadkaabaia
ibaaaaaaahaaaaaaabeaaaaaaaaaiadpdiaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
fpkokkdmabeaaaaadgfkkolndcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaochgdidodcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaaebnkjlodcaaaaajicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaadiphhpdpdiaaaaahbcaabaaa
abaaaaaadkaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaamaabeaaaaanlapmjdpdbaaaaaiccaabaaa
abaaaaaaabeaaaaaaaaaiadpdkaabaiaibaaaaaaahaaaaaaddaaaaahecaabaaa
abaaaaaadkaabaaaahaaaaaaabeaaaaaaaaaiadpdbaaaaaiecaabaaaabaaaaaa
ckaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadhaaaaakecaabaaaaaaaaaaa
ckaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaacolkgidpabeaaaaakehadndp
diaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaaj
ecaabaaaaaaaaaaackaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaalaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpaaaaaaaibcaabaaa
abaaaaaadkiacaaaaaaaaaaaanaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaaiccaabaaaaiaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaanaaaaaaaoaaaaaibcaabaaaaiaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaanaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaaaiaaaaaaeghobaaa
afaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaamaaaaaa
jgafbaaaaiaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaai
ecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaj
pcaabaaaabaaaaaaegaobaaaamaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
ebaaaaaficaabaaaahaaaaaabkaabaaaaaaaaaaabkaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaoaaaaaiicaabaaaahaaaaaadkaabaaaahaaaaaaakiacaaa
aaaaaaaaanaaaaaaaaaaaaahicaabaaaaiaaaaaaakaabaaaaaaaaaaadkaabaaa
ahaaaaaaeiaaaaalpcaabaaaamaaaaaamgaabaaaaiaaaaaaeghobaaaafaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaaiaaaaaangafbaaa
aiaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaah
pcaabaaaamaaaaaapgapbaaaaaaaaaaaegaobaaaamaaaaaadcaaaaajpcaabaaa
aiaaaaaaegaobaaaaiaaaaaakgakbaaaaaaaaaaaegaobaaaamaaaaaadiaaaaah
pcaabaaaaiaaaaaafgafbaaaaaaaaaaaegaobaaaaiaaaaaaaaaaaaaibcaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaajpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagaabaaaaaaaaaaaegaobaaaaiaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaahicaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaabhlhnbdiaoaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaapgapbaaaaaaaaaaaaoaaaaajhcaabaaaaiaaaaaaagiacaaa
aaaaaaaaajaaaaaaegiccaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaiaaaaaaapaaaaaiicaabaaaaaaaaaaapgapbaaa
agaaaaaapgipcaaaaaaaaaaaalaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
agaaaaaadkaabaaaagaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaaaiaaaaaa
pgipcaaaaaaaaaaaalaaaaaapgipcaaaaaaaaaaaalaaaaaaaceaaaaaaaaaiadp
aaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaamicaabaaaagaaaaaadkiacaia
ebaaaaaaaaaaaaaaalaaaaaadkiacaaaaaaaaaaaalaaaaaaabeaaaaaaaaaiadp
diaaaaalfcaabaaaaiaaaaaaagiacaaaaaaaaaaaahaaaaaaaceaaaaaaaaaiaeb
aaaaaaaaaaaaiaeaaaaaaaaaaoaaaaakfcaabaaaaiaaaaaaaceaaaaaaaaaeaea
aaaaaaaaaaaamadpaaaaaaaaagacbaaaaiaaaaaadiaaaaahicaabaaaagaaaaaa
dkaabaaaagaaaaaackaabaaaaiaaaaaadiaaaaahicaabaaaahaaaaaadkaabaaa
abaaaaaaakaabaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaiaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaahaaaaaaegacbaaaabaaaaaa
abaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaapaaaaaaalaaaaaf
dcaabaaaabaaaaaaegbabaaaabaaaaaaamaaaaafmcaabaaaabaaaaaaagbebaaa
abaaaaaadiaaaaahdcaabaaaaiaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaa
diaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaaaaaaaah
icaabaaaaaaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahdcaabaaa
abaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaa
bkaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaahccaabaaaabaaaaaabkaabaaa
aiaaaaaaakaabaaaaiaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
abeaaaaaaaaaaadpdiaaaaahecaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaamnmmmmdn
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadobjaaaaafbcaabaaaaiaaaaaadkaabaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaamnmmmmdn
cpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadobjaaaaafecaabaaaaiaaaaaadkaabaaa
aaaaaaaaelaaaaaficaabaaaaaaaaaaackaabaaaabaaaaaaaoaaaaahicaabaaa
aaaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaahccaabaaaaiaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaaadpefaaaaajpcaabaaaabaaaaaaegacbaaa
aiaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadiaaaaaiicaabaaaaaaaaaaa
akaabaaaabaaaaaaakiacaaaaaaaaaaadnaaaaaadeaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaakmmfkhdhelaaaaafbcaabaaaabaaaaaadkaabaaa
aaaaaaaacpaaaaafccaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaanifphimabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaakaeaaaaamadpaaaaaaaaaaaaaaaabjaaaaafccaabaaaabaaaaaabkaabaaa
abaaaaaadcaaaaajccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaajkjjlfeb
abeaaaaaaaaaiadpbaaaaaahecaabaaaabaaaaaaegacbaaaahaaaaaaegacbaaa
adaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaiadpdeaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaknhcddm
cpaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaaaoaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaeiobhkdpdiaaaaailcaabaaa
abaaaaaaagaabaaaabaaaaaaegiicaaaaaaaaaaadjaaaaaabaaaaaahicaabaaa
agaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaaagaaaaaa
dkaabaaaagaaaaaadiaaaaahhcaabaaaagaaaaaapgapbaaaagaaaaaaegacbaaa
agaaaaaabaaaaaahicaabaaaagaaaaaaegacbaaaahaaaaaaegacbaaaagaaaaaa
baaaaaahbcaabaaaagaaaaaaegacbaaaagaaaaaaegacbaaaadaaaaaaaaaaaaai
ccaabaaaagaaaaaadkaabaiaebaaaaaaagaaaaaaabeaaaaaaaaaiadpdiaaaaah
ecaabaaaagaaaaaabkaabaaaagaaaaaabkaabaaaagaaaaaadiaaaaahecaabaaa
agaaaaaackaabaaaagaaaaaackaabaaaagaaaaaadiaaaaahccaabaaaagaaaaaa
bkaabaaaagaaaaaackaabaaaagaaaaaadcaaaaajccaabaaaagaaaaaabkaabaaa
agaaaaaaabeaaaaaeiobhkdpabeaaaaaaknhkddmdiaaaaahecaabaaaagaaaaaa
dkaabaaaaaaaaaaaabeaaaaanlapejebdcaaaaakicaabaaaagaaaaaaakaabaia
ebaaaaaaagaaaaaaakaabaaaagaaaaaaabeaaaaaaaaaiadpaaaaaaahbcaabaaa
agaaaaaaakaabaaaagaaaaaaabeaaaaaaaaaiadpaoaaaaahicaabaaaaaaaaaaa
dkaabaaaagaaaaaadkaabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaamaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
dlkklidpbjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaackaabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaagaaaaaabaaaaaaibcaabaaaagaaaaaaegiccaaa
aaaaaaaadiaaaaaaegacbaaaadaaaaaadeaaaaakdcaabaaaagaaaaaaagaabaaa
agaaaaaaaceaaaaaaknhcddmaaaaaaaaaaaaaaaaaaaaaaaaaoaaaaahecaabaaa
abaaaaaaakaabaaaagaaaaaackaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakccaabaaaajaaaaaackaabaaaafaaaaaadkaabaaaadaaaaaabkiacaaa
aaaaaaaaamaaaaaadgaaaaafbcaabaaaahaaaaaabkaabaaaajaaaaaabaaaaaah
ecaabaaaabaaaaaajgahbaaaajaaaaaajgahbaaaajaaaaaaelaaaaafccaabaaa
ahaaaaaackaabaaaabaaaaaadgaaaaafccaabaaaakaaaaaaakaabaaaajaaaaaa
diaaaaaiecaabaaaabaaaaaabkiacaaaaaaaaaaaamaaaaaaabeaaaaaggggggdp
dbaaaaahecaabaaaabaaaaaaakaabaaaakaaaaaackaabaaaabaaaaaadhaaaaaj
dcaabaaaajaaaaaakgakbaaaabaaaaaaegaabaaaahaaaaaabgafbaaaakaaaaaa
aoaaaaahncaabaaaagaaaaaakgadbaaaajaaaaaafgafbaaaajaaaaaabaaaaaai
ecaabaaaabaaaaaaigadbaaaagaaaaaaegiccaaaaaaaaaaadiaaaaaabaaaaaah
bcaabaaaadaaaaaaigadbaaaagaaaaaaegacbaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaaadpaoaaaaaiccaabaaaadaaaaaabkiacaaa
aaaaaaaaamaaaaaabkaabaaaajaaaaaaaaaaaaajecaabaaaadaaaaaabkaabaaa
ajaaaaaabkiacaiaebaaaaaaaaaaaaaaamaaaaaaaoaaaaahecaabaaaahaaaaaa
ckaabaaaadaaaaaadkaabaaaafaaaaaadcaaaaakccaabaaaadaaaaaabkaabaia
ebaaaaaaadaaaaaabkaabaaaadaaaaaaabeaaaaaaaaaiadpelaaaaafccaabaaa
adaaaaaabkaabaaaadaaaaaadbaaaaaiccaabaaaadaaaaaackaabaaaabaaaaaa
bkaabaiaebaaaaaaadaaaaaaaaaaaaakfcaabaaaagaaaaaakgakbaaaabaaaaaa
aceaaaaajkjjbjdoaaaaaaaamnmmemdoaaaaaaaadiaaaaakdcaabaaaahaaaaaa
igaabaaaagaaaaaaaceaaaaajfdbeeebffffffdpaaaaaaaaaaaaaaaadeaaaaai
ecaabaaaabaaaaaaakaabaiaibaaaaaaahaaaaaaabeaaaaaaaaaiadpaoaaaaak
ecaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpckaabaaa
abaaaaaaddaaaaaiecaabaaaadaaaaaaakaabaiaibaaaaaaahaaaaaaabeaaaaa
aaaaiadpdiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaackaabaaaadaaaaaa
diaaaaahecaabaaaadaaaaaackaabaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
icaabaaaafaaaaaackaabaaaadaaaaaaabeaaaaafpkokkdmabeaaaaadgfkkoln
dcaaaaajicaabaaaafaaaaaackaabaaaadaaaaaadkaabaaaafaaaaaaabeaaaaa
ochgdidodcaaaaajicaabaaaafaaaaaackaabaaaadaaaaaadkaabaaaafaaaaaa
abeaaaaaaebnkjlodcaaaaajecaabaaaadaaaaaackaabaaaadaaaaaadkaabaaa
afaaaaaaabeaaaaadiphhpdpdiaaaaahicaabaaaafaaaaaackaabaaaabaaaaaa
ckaabaaaadaaaaaadcaaaaajicaabaaaafaaaaaadkaabaaaafaaaaaaabeaaaaa
aaaaaamaabeaaaaanlapmjdpdbaaaaaibcaabaaaagaaaaaaabeaaaaaaaaaiadp
akaabaiaibaaaaaaahaaaaaaabaaaaahicaabaaaafaaaaaadkaabaaaafaaaaaa
akaabaaaagaaaaaadcaaaaajecaabaaaabaaaaaackaabaaaabaaaaaackaabaaa
adaaaaaadkaabaaaafaaaaaaddaaaaahecaabaaaadaaaaaaakaabaaaahaaaaaa
abeaaaaaaaaaiadpeiaaaaalpcaabaaaaiaaaaaajgafbaaaahaaaaaaeghobaaa
aeaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaaelaaaaafccaabaaaahaaaaaa
ckaabaaaahaaaaaadiaaaaaincaabaaaagaaaaaaagajbaaaaiaaaaaaagiacaaa
aaaaaaaaapaaaaaadiaaaaahncaabaaaagaaaaaaagaabaaaadaaaaaaagaobaaa
agaaaaaaaaaaaaahncaabaaaagaaaaaaagaobaaaagaaaaaaagaobaaaagaaaaaa
dbaaaaaibcaabaaaadaaaaaackaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaa
dhaaaaakecaabaaaabaaaaaaakaabaaaadaaaaaackaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahbcaabaaaahaaaaaackaabaaaabaaaaaaabeaaaaa
klkkckdpeiaaaaalpcaabaaaahaaaaaaegaabaaaahaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaahaaaaaaegacbaaa
ahaaaaaaagiacaaaaaaaaaaaapaaaaaadhaaaaamhcaabaaaadaaaaaafgafbaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaahaaaaaa
dcaaaaajhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaadcaaaaajhcaabaaaadaaaaaaegacbaaaadaaaaaafgafbaaaagaaaaaa
igadbaaaagaaaaaadiaaaaahhcaabaaaabaaaaaaegadbaaaabaaaaaaigadbaaa
agaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaidpjkcdo
idpjkcdoidpjkcdoaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaagaaaaaaaagabaaaagaaaaaadiaaaaah
icaabaaaaaaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaaaaaaaahdcaabaaa
abaaaaaaogakbaaaabaaaaaaegaabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaaeaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaaefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaahaaaaaaaagabaaaahaaaaaa
dcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaaaaaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaacaaaaaa
aaaaaaahdcaabaaaabaaaaaaogakbaaaaeaaaaaaegaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaackaabaaaaeaaaaaackaabaaaaeaaaaaadkaabaaaaaaaaaaa
aaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaabkaabaaaabaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaakicaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaaaaaaaaaaaaaaaajecaabaaa
acaaaaaadkiacaaaaaaaaaaaapaaaaaadkiacaaaaaaaaaaabaaaaaaadgaaaaai
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaak
ocaabaaaabaaaaaaagajbaaaafaaaaaapgapbaaaadaaaaaaagajbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaackiacaaaaaaaaaaadmaaaaaaaaaaaaakecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaadlaaaaaadkiacaaaaaaaaaaadlaaaaaadcaaaaak
ecaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaa
dlaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaapdaedfdp
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaabeaaaaaaaaaaaaadkaabaaaaaaaaaaadbaaaaahecaabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaaaaaaaaaboaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaaclaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaapmcaabaaaabaaaaaapgapbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaeofpapdoeofpapdoaceaaaaaaaaaaaaaaaaaaaaaidpjkcdpaaaaiadp
diaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaackaabaaaabaaaaaa
aoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaadlkklidpbjaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaadp
diaaaaahncaabaaaabaaaaaapgapbaaaaaaaaaaaagajbaaaadaaaaaadcaaaaam
hcaabaaaaaaaaaaaigadbaaaabaaaaaaaceaaaaadggbacdodggbacdodggbacdo
aaaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
agiacaaaaaaaaaaaamaaaaaadiaaaaakpcaabaaaacaaaaaaagafbaaaaaaaaaaa
aceaaaaanmcomedodlkklilpnmcomedodlkklilpcpaaaaaffcaabaaaabaaaaaa
agacbaaaacaaaaaabjaaaaafdcaabaaaacaaaaaangafbaaaacaaaaaaaaaaaaal
dcaabaaaacaaaaaaegaabaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaakfcaabaaaabaaaaaaagacbaaaabaaaaaaaceaaaaa
cplkoidoaaaaaaaacplkoidoaaaaaaaabjaaaaaffcaabaaaabaaaaaaagacbaaa
abaaaaaadbaaaaaklcaabaaaaaaaaaaaegaibaaaaaaaaaaaaceaaaaacpnnledp
cpnnledpaaaaaaaacpnnledpdiaaaaakmcaabaaaacaaaaaakgakbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaanmcomedodlkklilpdhaaaaajdccabaaaaaaaaaaa
egaabaaaaaaaaaaaigaabaaaabaaaaaaegaabaaaacaaaaaacpaaaaafbcaabaaa
aaaaaaaackaabaaaacaaaaaabjaaaaafccaabaaaaaaaaaaadkaabaaaacaaaaaa
aaaaaaaiccaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadp
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaacplkoidobjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajeccabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaajbcaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaadmaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaabkaabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaadmaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaadmaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES3"
}
SubProgram "glcore " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GL3x"
}
}
 }
}
}