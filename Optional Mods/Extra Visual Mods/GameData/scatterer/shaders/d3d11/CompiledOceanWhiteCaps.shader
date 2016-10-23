// Compiled shader for all platforms, uncompressed size: 289.6KB

Shader "Proland/Ocean/OceanWhiteCaps" {
SubShader { 
 Tags { "QUEUE"="Geometry+100" "RenderType"="" }


 // Stats for Vertex shader:
 //       d3d11 : 167 math, 2 branch
 //        d3d9 : 296 math, 16 texture, 1 branch
 // Stats for Fragment shader:
 //       d3d11 : 249 avg math (191..308), 9 texture
 //        d3d9 : 354 avg math (272..436), 17 avg texture (13..21)
 Pass {
  Tags { "QUEUE"="Geometry+100" "RenderType"="" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLSL
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
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.x = vert_2.x;
  tmpvar_4.y = vert_2.y;
  vec3 tmpvar_5;
  tmpvar_5 = normalize((_Globals_ScreenToCamera * tmpvar_4).xyz);
  vec3 tmpvar_6;
  tmpvar_6 = ((sphereDir.yzx * tmpvar_5.zxy) - (sphereDir.zxy * tmpvar_5.yzx));
  vec3 tmpvar_7;
  tmpvar_7 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_6.yzx * sphereDir.zxy) - (tmpvar_6.zxy * sphereDir.yzx)))));
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, ((tmpvar_7.yzx * tmpvar_5.zxy) - (tmpvar_7.zxy * tmpvar_5.yzx)));
  vec3 tmpvar_9;
  if (((tmpvar_8 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_9 = tmpvar_7;
  } else {
    tmpvar_9 = tmpvar_5;
  };
  vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 tmpvar_11;
  tmpvar_11 = (_Ocean_CameraToOcean * tmpvar_10).xyz;
  float tmpvar_12;
  tmpvar_12 = (tmpvar_11.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_13;
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_14;
  tmpvar_14 = ((-(_Ocean_CameraPos.z) / tmpvar_11.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_11.z * tmpvar_11.z)))));
  float tmpvar_15;
  tmpvar_15 = abs(((tmpvar_14 - tmpvar_13) * tmpvar_11.z));
  float tmpvar_16;
  if ((tmpvar_15 < 1.0)) {
    tmpvar_16 = tmpvar_14;
  } else {
    tmpvar_16 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_16 * tmpvar_11.xy));
  vec4 tmpvar_17;
  tmpvar_17.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_17.x = _Ocean_ScreenGridSize.x;
  vec4 vert_18;
  vert_18 = (vert_2 + tmpvar_17);
  vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = vert_18.x;
  tmpvar_19.y = vert_18.y;
  vec3 tmpvar_20;
  tmpvar_20 = normalize((_Globals_ScreenToCamera * tmpvar_19).xyz);
  vec3 tmpvar_21;
  tmpvar_21 = ((sphereDir.yzx * tmpvar_20.zxy) - (sphereDir.zxy * tmpvar_20.yzx));
  vec3 tmpvar_22;
  tmpvar_22 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_21.yzx * sphereDir.zxy) - (tmpvar_21.zxy * sphereDir.yzx)))));
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_21, ((tmpvar_22.yzx * tmpvar_20.zxy) - (tmpvar_22.zxy * tmpvar_20.yzx)));
  vec3 tmpvar_24;
  if (((tmpvar_23 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_24 = tmpvar_22;
  } else {
    tmpvar_24 = tmpvar_20;
  };
  vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = tmpvar_24;
  vec3 tmpvar_26;
  tmpvar_26 = (_Ocean_CameraToOcean * tmpvar_25).xyz;
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_28;
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_29;
  tmpvar_29 = ((-(_Ocean_CameraPos.z) / tmpvar_26.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_26.z * tmpvar_26.z)))));
  float tmpvar_30;
  tmpvar_30 = abs(((tmpvar_29 - tmpvar_28) * tmpvar_26.z));
  float tmpvar_31;
  if ((tmpvar_30 < 1.0)) {
    tmpvar_31 = tmpvar_29;
  } else {
    tmpvar_31 = tmpvar_28;
  };
  vec2 tmpvar_32;
  tmpvar_32 = ((_Ocean_CameraPos.xy + (tmpvar_31 * tmpvar_26.xy)) - tmpvar_3);
  vec4 tmpvar_33;
  tmpvar_33.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_33.y = _Ocean_ScreenGridSize.y;
  vec4 vert_34;
  vert_34 = (vert_2 + tmpvar_33);
  vec4 tmpvar_35;
  tmpvar_35.zw = vec2(0.0, 1.0);
  tmpvar_35.x = vert_34.x;
  tmpvar_35.y = vert_34.y;
  vec3 tmpvar_36;
  tmpvar_36 = normalize((_Globals_ScreenToCamera * tmpvar_35).xyz);
  vec3 tmpvar_37;
  tmpvar_37 = ((sphereDir.yzx * tmpvar_36.zxy) - (sphereDir.zxy * tmpvar_36.yzx));
  vec3 tmpvar_38;
  tmpvar_38 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_37.yzx * sphereDir.zxy) - (tmpvar_37.zxy * sphereDir.yzx)))));
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_37, ((tmpvar_38.yzx * tmpvar_36.zxy) - (tmpvar_38.zxy * tmpvar_36.yzx)));
  vec3 tmpvar_40;
  if (((tmpvar_39 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_40 = tmpvar_38;
  } else {
    tmpvar_40 = tmpvar_36;
  };
  vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_40;
  vec3 tmpvar_42;
  tmpvar_42 = (_Ocean_CameraToOcean * tmpvar_41).xyz;
  float tmpvar_43;
  tmpvar_43 = (tmpvar_42.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_44;
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_45;
  tmpvar_45 = ((-(_Ocean_CameraPos.z) / tmpvar_42.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_42.z * tmpvar_42.z)))));
  float tmpvar_46;
  tmpvar_46 = abs(((tmpvar_45 - tmpvar_44) * tmpvar_42.z));
  float tmpvar_47;
  if ((tmpvar_46 < 1.0)) {
    tmpvar_47 = tmpvar_45;
  } else {
    tmpvar_47 = tmpvar_44;
  };
  vec2 tmpvar_48;
  tmpvar_48 = ((_Ocean_CameraPos.xy + (tmpvar_47 * tmpvar_42.xy)) - tmpvar_3);
  vec3 tmpvar_49;
  tmpvar_49.xy = vec2(0.0, 0.0);
  tmpvar_49.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_49;
  if (((tmpvar_48.x != 0.0) || (tmpvar_48.y != 0.0))) {
    vec2 tmpvar_50;
    tmpvar_50 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    vec4 tmpvar_52;
    tmpvar_52.z = 0.0;
    tmpvar_52.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_52.w = (0.5 * log2(max (dot (tmpvar_50, tmpvar_50), dot (tmpvar_51, tmpvar_51))));
    dP_1.z = (_Ocean_HeightOffset + texture2DLod (_Ocean_Map0, tmpvar_52.xy, tmpvar_52.w).x);
    vec2 tmpvar_53;
    tmpvar_53 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    vec2 tmpvar_54;
    tmpvar_54 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    vec4 tmpvar_55;
    tmpvar_55.z = 0.0;
    tmpvar_55.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_55.w = (0.5 * log2(max (dot (tmpvar_53, tmpvar_53), dot (tmpvar_54, tmpvar_54))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_55.xy, tmpvar_55.w).y);
    vec2 tmpvar_56;
    tmpvar_56 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    vec4 tmpvar_58;
    tmpvar_58.z = 0.0;
    tmpvar_58.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_58.w = (0.5 * log2(max (dot (tmpvar_56, tmpvar_56), dot (tmpvar_57, tmpvar_57))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_58.xy, tmpvar_58.w).z);
    vec2 tmpvar_59;
    tmpvar_59 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    vec4 tmpvar_61;
    tmpvar_61.z = 0.0;
    tmpvar_61.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_61.w = (0.5 * log2(max (dot (tmpvar_59, tmpvar_59), dot (tmpvar_60, tmpvar_60))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_61.xy, tmpvar_61.w).w);
    vec2 tmpvar_62;
    tmpvar_62 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    vec2 tmpvar_63;
    tmpvar_63 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    vec4 tmpvar_64;
    tmpvar_64.z = 0.0;
    tmpvar_64.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_64.w = (0.5 * log2(max (dot (tmpvar_62, tmpvar_62), dot (tmpvar_63, tmpvar_63))));
    dP_1.xy = (_Ocean_Choppyness.x * texture2DLod (_Ocean_Map3, tmpvar_64.xy, tmpvar_64.w).xy);
    vec2 tmpvar_65;
    tmpvar_65 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    vec4 tmpvar_67;
    tmpvar_67.z = 0.0;
    tmpvar_67.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_67.w = (0.5 * log2(max (dot (tmpvar_65, tmpvar_65), dot (tmpvar_66, tmpvar_66))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * texture2DLod (_Ocean_Map3, tmpvar_67.xy, tmpvar_67.w).zw));
    vec2 tmpvar_68;
    tmpvar_68 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    vec2 tmpvar_69;
    tmpvar_69 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    vec4 tmpvar_70;
    tmpvar_70.z = 0.0;
    tmpvar_70.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_70.w = (0.5 * log2(max (dot (tmpvar_68, tmpvar_68), dot (tmpvar_69, tmpvar_69))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * texture2DLod (_Ocean_Map4, tmpvar_70.xy, tmpvar_70.w).xy));
    vec2 tmpvar_71;
    tmpvar_71 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    vec4 tmpvar_73;
    tmpvar_73.z = 0.0;
    tmpvar_73.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_73.w = (0.5 * log2(max (dot (tmpvar_71, tmpvar_71), dot (tmpvar_72, tmpvar_72))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * texture2DLod (_Ocean_Map4, tmpvar_73.xy, tmpvar_73.w).zw));
  };
  mat3 tmpvar_74;
  tmpvar_74[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_74[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_74[2] = _Ocean_OceanToCamera[2].xyz;
  vec4 tmpvar_75;
  tmpvar_75.w = 1.0;
  tmpvar_75.xyz = ((tmpvar_16 * tmpvar_9) + (tmpvar_74 * dP_1));
  vec3 tmpvar_76;
  tmpvar_76.xy = vec2(0.0, 0.0);
  tmpvar_76.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_75);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_16 * tmpvar_11) + dP_1) + tmpvar_76);
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
  vec2 sigmaSq_1;
  vec3 V_2;
  float outWhiteCapStr_3;
  float outAlpha_4;
  vec3 tmpvar_5;
  tmpvar_5.xy = vec2(0.0, 0.0);
  tmpvar_5.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  vec3 tmpvar_6;
  tmpvar_6.xy = vec2(0.0, 0.0);
  tmpvar_6.z = _Ocean_Radius;
  vec3 tmpvar_7;
  tmpvar_7 = (normalize((xlv_TEXCOORD1 + tmpvar_6)) * (_Ocean_Radius + 10.0));
  vec3 arg0_8;
  arg0_8 = (tmpvar_7 - tmpvar_5);
  float tmpvar_9;
  tmpvar_9 = clamp ((sqrt(dot (arg0_8, arg0_8)) / alphaRadius), 0.0, 1.0);
  outAlpha_4 = mix (_OceanAlpha, 1.0, tmpvar_9);
  outWhiteCapStr_3 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_9);
  vec3 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.z = _Ocean_CameraPos.z;
  V_2 = normalize((tmpvar_10 - xlv_TEXCOORD1));
  vec2 tmpvar_11;
  tmpvar_11 = ((((texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.x)).xy + texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.y)).zw) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.z)).xy) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.w)).zw) - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  vec3 tmpvar_12;
  tmpvar_12.z = 1.0;
  tmpvar_12.x = -(tmpvar_11.x);
  tmpvar_12.y = -(tmpvar_11.y);
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
  tmpvar_20.y = (0.5 + ((0.5 * ((tmpvar_14 * tmpvar_15) + (tmpvar_16 * tmpvar_17))) / sqrt((tmpvar_18 * tmpvar_19))));
  tmpvar_20.z = pow ((tmpvar_19 / 10.0), 0.25);
  sigmaSq_1 = max ((texture3D (_Ocean_Variance, tmpvar_20).xy * _VarianceMax), vec2(2e-05, 2e-05));
  vec3 worldP_21;
  worldP_21 = tmpvar_7;
  float r_22;
  float tmpvar_23;
  tmpvar_23 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_22 = tmpvar_23;
  if ((tmpvar_23 < (0.9 * Rg))) {
    worldP_21.z = (tmpvar_7.z + Rg);
    r_22 = sqrt(dot (worldP_21, worldP_21));
  };
  vec3 tmpvar_24;
  tmpvar_24 = (worldP_21 / r_22);
  float tmpvar_25;
  tmpvar_25 = dot (tmpvar_24, _Ocean_SunDir);
  float tmpvar_26;
  tmpvar_26 = sqrt((1.0 - ((Rg / r_22) * (Rg / r_22))));
  vec3 tmpvar_27;
  if ((tmpvar_25 < -(tmpvar_26))) {
    tmpvar_27 = vec3(0.0, 0.0, 0.0);
  } else {
    float y_over_x_28;
    y_over_x_28 = (((tmpvar_25 + 0.15) / 1.15) * 14.1014);
    float x_29;
    x_29 = (y_over_x_28 * inversesqrt(((y_over_x_28 * y_over_x_28) + 1.0)));
    vec4 tmpvar_30;
    tmpvar_30.zw = vec2(0.0, 0.0);
    tmpvar_30.x = ((sign(x_29) * (1.5708 - (sqrt((1.0 - abs(x_29))) * (1.5708 + (abs(x_29) * (-0.214602 + (abs(x_29) * (0.0865667 + (abs(x_29) * -0.0310296))))))))) / 1.5);
    tmpvar_30.y = sqrt(((r_22 - Rg) / (Rt - Rg)));
    tmpvar_27 = texture2DLod (_Transmittance, tmpvar_30.xy, 0.0).xyz;
  };
  vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_27 * _Sun_Intensity);
  vec2 tmpvar_32;
  tmpvar_32.x = ((tmpvar_25 + 0.2) / 1.2);
  tmpvar_32.y = ((r_22 - Rg) / (Rt - Rg));
  vec3 tmpvar_33;
  tmpvar_33 = ((2.0 * (texture2DLod (_Irradiance, tmpvar_32, 0.0).xyz * _Sun_Intensity)) * ((1.0 + dot (tmpvar_24, tmpvar_13)) * 0.5));
  float tmpvar_34;
  tmpvar_34 = sqrt(sigmaSq_1.x);
  vec3 tmpvar_35;
  tmpvar_35 = (((pow ((1.0 - dot (V_2, tmpvar_13)), (5.0 * exp((-2.69 * tmpvar_34)))) / (1.0 + (22.7 * pow (tmpvar_34, 1.5)))) * tmpvar_33) / 3.14159);
  vec3 tmpvar_36;
  tmpvar_36 = normalize((_Ocean_SunDir + V_2));
  float tmpvar_37;
  tmpvar_37 = dot (tmpvar_36, tmpvar_13);
  float tmpvar_38;
  tmpvar_38 = (exp(((-2.0 * ((1.0 - (tmpvar_37 * tmpvar_37)) / sigmaSq_1.x)) / (1.0 + tmpvar_37))) / (12.5664 * sigmaSq_1.x));
  float tmpvar_39;
  tmpvar_39 = (1.0 - dot (V_2, tmpvar_36));
  float tmpvar_40;
  tmpvar_40 = (tmpvar_39 * tmpvar_39);
  float tmpvar_41;
  tmpvar_41 = (0.02 + (((0.98 * tmpvar_40) * tmpvar_40) * tmpvar_39));
  float tmpvar_42;
  tmpvar_42 = max (dot (_Ocean_SunDir, tmpvar_13), 0.01);
  float tmpvar_43;
  tmpvar_43 = max (dot (V_2, tmpvar_13), 0.01);
  float tmpvar_44;
  if ((tmpvar_42 <= 0.0)) {
    tmpvar_44 = 0.0;
  } else {
    tmpvar_44 = max (((tmpvar_41 * tmpvar_38) * sqrt(abs((tmpvar_42 / tmpvar_43)))), 0.0);
  };
  float tmpvar_45;
  tmpvar_45 = sqrt(sigmaSq_1.x);
  vec4 tmpvar_46;
  tmpvar_46 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.x));
  vec4 tmpvar_47;
  tmpvar_47 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.y));
  vec4 tmpvar_48;
  tmpvar_48 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.z));
  vec4 tmpvar_49;
  tmpvar_49 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.w));
  vec2 tmpvar_50;
  tmpvar_50 = (((tmpvar_46.xy + tmpvar_47.zw) + tmpvar_48.xy) + tmpvar_49.zw);
  float x_51;
  x_51 = ((0.707107 * (outWhiteCapStr_3 - tmpvar_50.x)) * inversesqrt(max ((tmpvar_50.y - ((((tmpvar_46.x * tmpvar_46.x) + (tmpvar_47.z * tmpvar_47.z)) + (tmpvar_48.x * tmpvar_48.x)) + (tmpvar_49.z * tmpvar_49.z))), 0.0)));
  float tmpvar_52;
  tmpvar_52 = (x_51 * x_51);
  float tmpvar_53;
  tmpvar_53 = (0.140012 * tmpvar_52);
  vec3 L_54;
  vec3 tmpvar_55;
  tmpvar_55 = (((((tmpvar_44 * tmpvar_31) + tmpvar_35) + ((((0.98 * (1.0 - (pow ((1.0 - dot (V_2, tmpvar_13)), (5.0 * exp((-2.69 * tmpvar_45)))) / (1.0 + (22.7 * pow (tmpvar_45, 1.5)))))) * _Ocean_Color) * tmpvar_33) / 3.14159)) + ((((0.5 * (sign(x_51) * sqrt((1.0 - exp(((-(tmpvar_52) * (1.27324 + tmpvar_53)) / (1.0 + tmpvar_53))))))) + 0.5) * (((tmpvar_31 * max (dot (tmpvar_13, _Ocean_SunDir), 0.0)) + tmpvar_33) / 3.14159)) * 0.4)) * _Exposure);
  L_54 = tmpvar_55;
  float tmpvar_56;
  if ((tmpvar_55.x < 1.413)) {
    tmpvar_56 = pow ((tmpvar_55.x * 0.38317), 0.454545);
  } else {
    tmpvar_56 = (1.0 - exp(-(tmpvar_55.x)));
  };
  L_54.x = tmpvar_56;
  float tmpvar_57;
  if ((tmpvar_55.y < 1.413)) {
    tmpvar_57 = pow ((tmpvar_55.y * 0.38317), 0.454545);
  } else {
    tmpvar_57 = (1.0 - exp(-(tmpvar_55.y)));
  };
  L_54.y = tmpvar_57;
  float tmpvar_58;
  if ((tmpvar_55.z < 1.413)) {
    tmpvar_58 = pow ((tmpvar_55.z * 0.38317), 0.454545);
  } else {
    tmpvar_58 = (1.0 - exp(-(tmpvar_55.z)));
  };
  L_54.z = tmpvar_58;
  vec4 tmpvar_59;
  tmpvar_59.xyz = L_54;
  tmpvar_59.w = (outAlpha_4 * _GlobalOceanAlpha);
  gl_FragData[0] = tmpvar_59;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 296 math, 16 textures, 1 branches
Keywords { "SKY_REFLECTIONS_OFF" }
Bind "vertex" Vertex
Matrix 0 [_Ocean_OceanToCamera]
Matrix 4 [_Ocean_CameraToOcean]
Matrix 8 [_Globals_ScreenToCamera]
Matrix 12 [_Globals_CameraToScreen]
Float 16 [_Ocean_Radius]
Float 17 [_Ocean_HeightOffset]
Vector 18 [_Ocean_CameraPos]
Vector 19 [sphereDir]
Float 20 [cosTheta]
Float 21 [sinTheta]
Vector 22 [_Ocean_MapSize]
Vector 23 [_Ocean_Choppyness]
Vector 24 [_Ocean_GridSizes]
Vector 25 [_Ocean_ScreenGridSize]
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c26, 1.25000000, 0.00000000, 1.00000000, 2.00000000
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r1.w, c18.z
mul r8.xy, v0, c26.x
mov r8.zw, c26.xyyz
slt r1.w, c26.y, r1
mov r2.w, c26.y
dp4 r0.z, r8, c10
dp4 r0.x, r8, c8
dp4 r0.y, r8, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r1.xyz, r0.yzxw, c19.zxyw
mad r2.xyz, r0.zxyw, c19.yzxw, -r1
mul r1.xyz, r2.zxyw, c19.yzxw
mad r1.xyz, r2.yzxw, c19.zxyw, -r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov r0.w, c20.x
mul r1.xyz, r1, c21.x
mad r1.xyz, c19, r0.w, r1
mul r3.xyz, r0.yzxw, r1.zxyw
mad r3.xyz, r0.zxyw, r1.yzxw, -r3
dp3 r0.w, r2, r3
slt r0.w, c26.y, r0
mul r0.w, r0, r1
max r0.w, -r0, r0
slt r0.w, c26.y, r0
add r2.x, -r0.w, c26.z
mul r0.xyz, r0, r2.x
mad r1.xyz, r0.w, r1, r0
mov r2.xyz, r1
dp4 r3.w, r2, c6
rcp r0.x, r3.w
mul r0.y, r0.x, -c18.z
mov r0.z, c16.x
mul r3.x, c26.w, r0.z
rcp r0.z, r3.x
add r4.x, r3, c18.z
mov r0.x, c18.z
add r5.w, c16.x, r0.x
mul r6.z, r4.x, c18
mul r4.w, r0.z, c18.z
mad r0.w, -r3, r3, c26.z
mad r0.z, r4.w, r0.w, c26
mul r6.x, r0.y, r0.z
mov r0.zw, c26.xyyz
mul r5.x, r3.w, r5.w
mov r0.y, c25
mov r0.x, c26.y
add r0.xy, r8, r0
dp4 r3.z, r0, c10
dp4 r3.y, r0, c9
dp4 r3.x, r0, c8
mad r0.x, r5, r5, -r6.z
dp3 r0.y, r3, r3
rsq r0.y, r0.y
max r0.x, r0, c26.y
rsq r0.w, r0.x
mul r3.xyz, r0.y, r3
mul r0.xyz, r3.yzxw, c19.zxyw
mad r4.xyz, r3.zxyw, c19.yzxw, -r0
mul r0.xyz, r4.zxyw, c19.yzxw
mad r0.xyz, r4.yzxw, c19.zxyw, -r0
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
rcp r0.w, r0.w
add r0.w, -r5.x, -r0
add r5.x, r6, -r0.w
mul r5.x, r3.w, r5
abs r5.x, r5
slt r5.x, r5, c26.z
max r5.y, -r5.x, r5.x
slt r6.y, c26, r5
add r6.w, -r6.y, c26.z
mul r0.w, r0, r6
mad r6.w, r6.y, r6.x, r0
dp4 r6.y, r2, c5
dp4 r6.x, r2, c4
mov r2.zw, c26.xyyz
mad r7.xy, r6, r6.w, c18
mov r5.x, c20
mul r0.xyz, r0, c21.x
mad r0.xyz, c19, r5.x, r0
mul r5.xyz, r3.yzxw, r0.zxyw
mad r5.xyz, r3.zxyw, r0.yzxw, -r5
dp3 r4.x, r4, r5
slt r0.w, c26.y, r4.x
mul r0.w, r1, r0
max r0.w, -r0, r0
slt r0.w, c26.y, r0
mov r2.y, c26
mov r2.x, c25
add r2.xy, r8, r2
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
add r2.y, -r0.w, c26.z
mul r3.xyz, r3, r2.y
mad r0.xyz, r0.w, r0, r3
mov r0.w, c26.y
dp4 r2.w, r0, c6
rcp r5.x, r2.w
mul r7.w, r5, r2
dp3 r2.x, r4, r4
mad r5.z, -r2.w, r2.w, c26
mad r8.x, r7.w, r7.w, -r6.z
rsq r2.x, r2.x
mul r2.xyz, r2.x, r4
mul r3.xyz, r2.yzxw, c19.zxyw
mad r3.xyz, r2.zxyw, c19.yzxw, -r3
mul r4.xyz, r3.zxyw, c19.yzxw
mad r4.xyz, r3.yzxw, c19.zxyw, -r4
mul r5.y, r5.x, -c18.z
dp3 r5.x, r4, r4
rsq r5.x, r5.x
mul r4.xyz, r5.x, r4
mad r5.z, r4.w, r5, c26
mul r7.z, r5.y, r5
mov r5.x, c20
mul r4.xyz, r4, c21.x
mad r4.xyz, c19, r5.x, r4
mul r5.xyz, r2.yzxw, r4.zxyw
mad r5.xyz, r2.zxyw, r4.yzxw, -r5
dp3 r3.x, r3, r5
max r8.x, r8, c26.y
rsq r3.y, r8.x
slt r3.x, c26.y, r3
mul r3.x, r1.w, r3
rcp r3.y, r3.y
add r1.w, -r7, -r3.y
add r3.y, r7.z, -r1.w
mul r3.y, r3, r2.w
max r3.x, -r3, r3
slt r3.x, c26.y, r3
add r2.w, -r3.x, c26.z
mul r2.xyz, r2, r2.w
abs r3.y, r3
mad r2.xyz, r3.x, r4, r2
mov r2.w, c26.y
dp4 r3.z, r2, c6
slt r3.y, r3, c26.z
max r4.x, -r3.y, r3.y
mul r3.x, r5.w, r3.z
mad r3.y, r3.x, r3.x, -r6.z
slt r4.x, c26.y, r4
add r4.y, -r4.x, c26.z
mul r4.y, r1.w, r4
max r3.y, r3, c26
rsq r3.y, r3.y
rcp r1.w, r3.y
add r1.w, -r3.x, -r1
mad r3.y, -r3.z, r3.z, c26.z
rcp r3.x, r3.z
mad r4.z, r4.x, r7, r4.y
mad r3.y, r4.w, r3, c26.z
mul r3.x, r3, -c18.z
mul r4.x, r3, r3.y
dp4 r3.x, r0, c4
dp4 r3.y, r0, c5
mad r0.xy, r4.z, r3, c18
add r4.y, r4.x, -r1.w
mul r0.z, r4.y, r3
add r3.xy, -r7, r0
abs r0.z, r0
slt r3.z, c26.y, r3.x
slt r0.w, r0.x, r7.x
slt r0.z, r0, c26
max r0.x, -r0.z, r0.z
slt r0.x, c26.y, r0
add r0.w, r0, r3.z
add r0.z, -r0.x, c26
slt r3.z, r0.y, r7.y
mul r0.y, r1.w, r0.z
mad r0.z, r0.x, r4.x, r0.y
slt r4.y, c26, r3
dp4 r0.x, r2, c4
dp4 r0.y, r2, c5
mad r0.xy, r0.z, r0, c18
add r1.w, r3.z, r4.y
add_sat r0.z, r0.w, r1.w
add r4.xy, -r7, r0
mov r6.z, r3.w
mov r2.xy, c26.y
mov r2.z, c17.x
if_gt r0.z, c26.y
rcp r1.w, c24.x
mul r0.zw, r3.xyxy, r1.w
mul r0.xy, r4, r1.w
mul r0.zw, r0, c22.y
mul r0.zw, r0, r0
mul r0.xy, r0, c22.x
mul r0.xy, r0, r0
rcp r2.w, c24.y
add r0.x, r0, r0.y
add r0.z, r0, r0.w
max r0.x, r0, r0.z
log r3.z, r0.x
mul r0.zw, r3.xyxy, r2.w
mul r0.xy, r4, r2.w
mul r0.zw, r0, c22.y
mul r0.zw, r0, r0
mul r0.xy, r0, c22.x
mul r0.xy, r0, r0
add r0.z, r0, r0.w
add r0.x, r0, r0.y
max r0.w, r0.x, r0.z
mul r0.xy, r7, r1.w
mul r0.z, r3, c27.x
texldl r5.xy, r0.xyzz, s1
texldl r0.x, r0.xyzz, s0
log r0.w, r0.w
mul r5.z, r0.w, c27.x
rcp r0.w, c24.z
mul r4.zw, r3.xyxy, r0.w
rcp r1.w, c24.w
mad r2.xy, r5, c23.x, r2
mul r5.xy, r7, r2.w
texldl r3.zw, r5.xyzz, s1
mad r2.xy, r3.zwzw, c23.y, r2
mul r3.zw, r4.xyxy, r0.w
mul r3.zw, r3, c22.x
mul r3.zw, r3, r3
mul r4.zw, r4, c22.y
mul r3.xy, r3, r1.w
mul r3.xy, r3, c22.y
mul r3.xy, r3, r3
add r2.w, r3.z, r3
mul r4.zw, r4, r4
add r3.z, r4, r4.w
max r2.w, r2, r3.z
mul r3.zw, r4.xyxy, r1.w
mul r3.zw, r3, c22.x
log r2.w, r2.w
add r3.y, r3.x, r3
mul r3.zw, r3, r3
add r3.x, r3.z, r3.w
max r3.x, r3, r3.y
log r3.z, r3.x
mul r4.xy, r7, r0.w
mul r4.z, r2.w, c27.x
texldl r3.xy, r4.xyzz, s2
mad r2.xy, r3, c23.z, r2
mul r3.z, r3, c27.x
mul r3.xy, r7, r1.w
texldl r7.zw, r3.xyzz, s2
add r0.x, r2.z, r0
texldl r0.y, r5.xyzz, s0
add r0.x, r0, r0.y
texldl r0.z, r4.xyzz, s0
texldl r0.w, r3.xyzz, s0
add r0.x, r0, r0.z
mad r2.xy, r7.zwzw, c23.w, r2
add r2.z, r0.x, r0.w
endif
mov r0.w, c26.z
dp3 r0.z, r2, c2
dp3 r0.y, r2, c1
dp3 r0.x, r2, c0
mad r0.xyz, r6.w, r1, r0
dp4 o0.w, r0, c15
dp4 o0.z, r0, c14
dp4 o0.y, r0, c13
dp4 o0.x, r0, c12
mad r1.xyz, r6.w, r6, r2
mov r0.z, c18
mov r0.xy, c26.y
add o2.xyz, r1, r0
mov o1.xy, r7
"
}
SubProgram "d3d11 " {
// Stats: 167 math, 2 branches
Keywords { "SKY_REFLECTIONS_OFF" }
Bind "vertex" Vertex
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
ConstBuffer "$Globals" 912
Matrix 192 [_Ocean_OceanToCamera]
Matrix 256 [_Ocean_CameraToOcean]
Matrix 352 [_Globals_ScreenToCamera]
Matrix 544 [_Globals_CameraToScreen]
Float 172 [_Ocean_Radius]
Float 176 [_Ocean_HeightOffset]
Vector 180 [_Ocean_CameraPos] 3
Vector 320 [sphereDir] 3
Float 332 [cosTheta]
Float 336 [sinTheta]
Vector 784 [_Ocean_MapSize] 2
Vector 800 [_Ocean_Choppyness]
Vector 848 [_Ocean_GridSizes]
Vector 864 [_Ocean_ScreenGridSize] 2
BindCB  "$Globals" 0
"vs_4_0
eefiecedmfcnalifagfhjngpdmmpamlinjdagkidabaaaaaamebjaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefckmbiaaaaeaaaabaaclagaaaa
fjaaaaaeegiocaaaaaaaaaaadhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafpaaaaaddcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacajaaaaaa
diaaaaakdcaabaaaaaaaaaaaegbabaaaaaaaaaaaaceaaaaaaaaakadpaaaakadp
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabhaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaajgaebaaaabaaaaaacgijcaaaaaaaaaaabeaaaaaadcaaaaal
hcaabaaaacaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaacgajbaaaacaaaaaajgiecaaa
aaaaaaaabeaaaaaadcaaaaalhcaabaaaadaaaaaajgaebaaaacaaaaaacgijcaaa
aaaaaaaabeaaaaaaegacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaajhcaabaaaaeaaaaaaegiccaaaaaaaaaaabeaaaaaapgipcaaaaaaaaaaa
beaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaabfaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaajgaebaaaabaaaaaa
cgajbaaaadaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaadaaaaaacgajbaaa
abaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaafaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkiacaaa
aaaaaaaaalaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajecaabaaa
aaaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaakaaaaaadcaaaaal
bcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaeadkiacaaa
aaaaaaaaalaaaaaadiaaaaaibcaabaaaadaaaaaaakaabaaaadaaaaaadkiacaaa
aaaaaaaaalaaaaaadcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalicaabaaaabaaaaaackaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaaaoaaaaajccaabaaaadaaaaaadkiacaiaebaaaaaa
aaaaaaaaalaaaaaackaabaaaacaaaaaaaoaaaaaiicaabaaaacaaaaaadkiacaaa
aaaaaaaaalaaaaaadkaabaaaacaaaaaadcaaaaakecaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaahccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadbaaaaai
ccaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdhaaaaaj
icaabaaaabaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaa
dcaaaaakgcaabaaaadaaaaaapgapbaaaabaaaaaaagabbaaaacaaaaaafgigcaaa
aaaaaaaaalaaaaaadcaaaaakicaabaaaadaaaaaabkbabaaaaaaaaaaaabeaaaaa
aaaakadpbkiacaaaaaaaaaaadgaaaaaadiaaaaaihcaabaaaafaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaabhaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaa
aaaaaaaabgaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaaihcaabaaaagaaaaaajgaebaaaafaaaaaacgijcaaaaaaaaaaa
beaaaaaadcaaaaalhcaabaaaagaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaaihcaabaaaahaaaaaacgajbaaa
agaaaaaajgiecaaaaaaaaaaabeaaaaaadcaaaaalhcaabaaaahaaaaaajgaebaaa
agaaaaaacgijcaaaaaaaaaaabeaaaaaaegacbaiaebaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaaagaabaaaaaaaaaaa
egacbaaaahaaaaaadcaaaaakhcaabaaaahaaaaaaagiacaaaaaaaaaaabfaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
afaaaaaacgajbaaaahaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaahaaaaaa
cgajbaaaafaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaagaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaafaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaaklcaabaaaafaaaaaaegiicaaaaaaaaaaa
baaaaaaaagaabaaaafaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaafaaaaaa
egiccaaaaaaaaaaabcaaaaaakgakbaaaafaaaaaaegadbaaaafaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaia
ebaaaaaaafaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaaj
icaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaackaabaaaafaaaaaa
dcaaaaakicaabaaaaeaaaaaackaabaiaebaaaaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaaeaaaaaadcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaadaaaaaackaabaaa
afaaaaaadkaabaaaadaaaaaadbaaaaaiicaabaaaadaaaaaadkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpdhaaaaajbcaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaafaaaaaaakaabaaaaaaaaaaadcaaaaakpcaabaaaafaaaaaaagaabaaa
aaaaaaaaegaebaaaafaaaaaajgijcaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaa
afaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaafaaaaaadjaaaaakdcaabaaa
agaaaaaaogakbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dmaaaaahbcaabaaaaaaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaabpaaaead
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaa
aaaakadpakiacaaaaaaaaaaadgaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabhaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaa
aaaaaaaabgaaaaaaagaabaaaaaaaaaaaegacbaaaagaaaaaaaaaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
agaaaaaadiaaaaaihcaabaaaahaaaaaajgaebaaaagaaaaaacgijcaaaaaaaaaaa
beaaaaaadcaaaaalhcaabaaaahaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaaihcaabaaaaiaaaaaacgajbaaa
ahaaaaaajgiecaaaaaaaaaaabeaaaaaadcaaaaalhcaabaaaaiaaaaaajgaebaaa
ahaaaaaacgijcaaaaaaaaaaabeaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaagaabaaaaaaaaaaa
egacbaaaaiaaaaaadcaaaaakhcaabaaaaeaaaaaaagiacaaaaaaaaaaabfaaaaaa
egacbaaaaiaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
agaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaaeaaaaaa
cgajbaaaagaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaahaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaa
aeaaaaaaegaibaaaagaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
baaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaaaaaaaaabcaaaaaapgapbaaaaaaaaaaaegaibaaaaeaaaaaadiaaaaah
icaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakbcaabaaa
adaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaalecaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaaaoaaaaaj
bcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadkaabaaaaaaaaaaa
dcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaadcaaaaakicaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaebaaaaaaaaaaajgijcaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaa
aaaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaaaaaaaaaaoaaaaaipcaabaaa
aeaaaaaajgajbaaaadaaaaaaagifcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaa
agaaaaaaogaobaaaaaaaaaaaagifcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaa
ahaaaaaaogaobaaaafaaaaaaagifcaaaaaaaaaaadfaaaaaadiaaaaaipcaabaaa
agaaaaaaegaobaaaagaaaaaaagiacaaaaaaaaaaadbaaaaaadiaaaaaipcaabaaa
ahaaaaaaegaobaaaahaaaaaafgifcaaaaaaaaaaadbaaaaaaapaaaaahicaabaaa
acaaaaaaegaabaaaagaaaaaaegaabaaaagaaaaaaapaaaaahbcaabaaaadaaaaaa
egaabaaaahaaaaaaegaabaaaahaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaacpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpeiaaaaal
pcaabaaaaiaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaadaaaaaaakaabaaaaiaaaaaaakiacaaa
aaaaaaaaalaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaaagaaaaaaogakbaaa
agaaaaaaapaaaaahbcaabaaaagaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaa
deaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaacpaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaaagaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaa
jgajbaaaadaaaaaakgipcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaakgipcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaakgipcaaaaaaaaaaadfaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagiacaaaaaaaaaaadbaaaaaadiaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaafgifcaaaaaaaaaaadbaaaaaaapaaaaahbcaabaaaaaaaaaaa
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
dcaaaaaadcaaaaakkcaabaaaaaaaaaaaagiacaaaaaaaaaaadcaaaaaaagaebaaa
ahaaaaaafganbaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaagaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaakgikcaaaaaaaaaaadcaaaaaaegaabaaaaeaaaaaangafbaaaaaaaaaaa
eiaaaaalpcaabaaaaeaaaaaaogakbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaackaabaaaaaaaaaaadcaaaaakdcaabaaaafaaaaaapgipcaaaaaaaaaaa
dcaaaaaaogakbaaaaeaaaaaaegaabaaaaaaaaaaabcaaaaabdgaaaaafbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadgaaaaafhcaabaaaafaaaaaaagacbaaaaaaaaaaabfaaaaabdiaaaaai
hcaabaaaaaaaaaaafgafbaaaafaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaaafaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaa
afaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaacaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
aaaaaaahhccabaaaacaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaacdaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaccaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaceaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaacfaaaaaadgaaaaafdccabaaaabaaaaaajgafbaaaadaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES


#ifdef VERTEX

#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
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
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
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
    Lsky = ((MeanFresnel( V, N, float( sigmaSq)) * skyE) / 3.14159);
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    #line 306
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
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
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:287(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:287(74): error: type mismatch
0:287(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "glesdesktop " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES


#ifdef VERTEX

#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SKY_REFLECTIONS_OFF
    #define SKY_REFLECTIONS_OFF 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
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
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
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
    Lsky = ((MeanFresnel( V, N, float( sigmaSq)) * skyE) / 3.14159);
    highp vec3 Lsun = (ReflectedSunRadiance( L, V, N, float( sigmaSq)) * sunL);
    #line 306
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
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
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:287(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:287(74): error: type mismatch
0:287(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToScreen;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 dP_1;
  highp vec4 vert_2;
  vert_2.zw = _glesVertex.zw;
  vert_2.xy = (_glesVertex.xy * 1.25);
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.x = vert_2.x;
  tmpvar_4.y = vert_2.y;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Globals_ScreenToCamera * tmpvar_4).xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = ((sphereDir.yzx * tmpvar_5.zxy) - (sphereDir.zxy * tmpvar_5.yzx));
  highp vec3 tmpvar_7;
  tmpvar_7 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_6.yzx * sphereDir.zxy) - (tmpvar_6.zxy * sphereDir.yzx)))));
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, ((tmpvar_7.yzx * tmpvar_5.zxy) - (tmpvar_7.zxy * tmpvar_5.yzx)));
  highp vec3 tmpvar_9;
  if (((tmpvar_8 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_9 = tmpvar_7;
  } else {
    tmpvar_9 = tmpvar_5;
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_9;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_Ocean_CameraToOcean * tmpvar_10).xyz;
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_13;
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_14;
  tmpvar_14 = ((-(_Ocean_CameraPos.z) / tmpvar_11.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_11.z * tmpvar_11.z)))));
  highp float tmpvar_15;
  tmpvar_15 = abs(((tmpvar_14 - tmpvar_13) * tmpvar_11.z));
  highp float tmpvar_16;
  if ((tmpvar_15 < 1.0)) {
    tmpvar_16 = tmpvar_14;
  } else {
    tmpvar_16 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_16 * tmpvar_11.xy));
  highp vec4 tmpvar_17;
  tmpvar_17.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_17.x = _Ocean_ScreenGridSize.x;
  highp vec4 vert_18;
  vert_18 = (vert_2 + tmpvar_17);
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = vert_18.x;
  tmpvar_19.y = vert_18.y;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_Globals_ScreenToCamera * tmpvar_19).xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = ((sphereDir.yzx * tmpvar_20.zxy) - (sphereDir.zxy * tmpvar_20.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_21.yzx * sphereDir.zxy) - (tmpvar_21.zxy * sphereDir.yzx)))));
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_21, ((tmpvar_22.yzx * tmpvar_20.zxy) - (tmpvar_22.zxy * tmpvar_20.yzx)));
  highp vec3 tmpvar_24;
  if (((tmpvar_23 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_24 = tmpvar_22;
  } else {
    tmpvar_24 = tmpvar_20;
  };
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = tmpvar_24;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_Ocean_CameraToOcean * tmpvar_25).xyz;
  highp float tmpvar_27;
  tmpvar_27 = (tmpvar_26.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_28;
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_29;
  tmpvar_29 = ((-(_Ocean_CameraPos.z) / tmpvar_26.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_26.z * tmpvar_26.z)))));
  highp float tmpvar_30;
  tmpvar_30 = abs(((tmpvar_29 - tmpvar_28) * tmpvar_26.z));
  highp float tmpvar_31;
  if ((tmpvar_30 < 1.0)) {
    tmpvar_31 = tmpvar_29;
  } else {
    tmpvar_31 = tmpvar_28;
  };
  highp vec2 tmpvar_32;
  tmpvar_32 = ((_Ocean_CameraPos.xy + (tmpvar_31 * tmpvar_26.xy)) - tmpvar_3);
  highp vec4 tmpvar_33;
  tmpvar_33.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_33.y = _Ocean_ScreenGridSize.y;
  highp vec4 vert_34;
  vert_34 = (vert_2 + tmpvar_33);
  highp vec4 tmpvar_35;
  tmpvar_35.zw = vec2(0.0, 1.0);
  tmpvar_35.x = vert_34.x;
  tmpvar_35.y = vert_34.y;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_Globals_ScreenToCamera * tmpvar_35).xyz);
  highp vec3 tmpvar_37;
  tmpvar_37 = ((sphereDir.yzx * tmpvar_36.zxy) - (sphereDir.zxy * tmpvar_36.yzx));
  highp vec3 tmpvar_38;
  tmpvar_38 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_37.yzx * sphereDir.zxy) - (tmpvar_37.zxy * sphereDir.yzx)))));
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_37, ((tmpvar_38.yzx * tmpvar_36.zxy) - (tmpvar_38.zxy * tmpvar_36.yzx)));
  highp vec3 tmpvar_40;
  if (((tmpvar_39 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_40 = tmpvar_38;
  } else {
    tmpvar_40 = tmpvar_36;
  };
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = (_Ocean_CameraToOcean * tmpvar_41).xyz;
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_44;
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_45;
  tmpvar_45 = ((-(_Ocean_CameraPos.z) / tmpvar_42.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_42.z * tmpvar_42.z)))));
  highp float tmpvar_46;
  tmpvar_46 = abs(((tmpvar_45 - tmpvar_44) * tmpvar_42.z));
  highp float tmpvar_47;
  if ((tmpvar_46 < 1.0)) {
    tmpvar_47 = tmpvar_45;
  } else {
    tmpvar_47 = tmpvar_44;
  };
  highp vec2 tmpvar_48;
  tmpvar_48 = ((_Ocean_CameraPos.xy + (tmpvar_47 * tmpvar_42.xy)) - tmpvar_3);
  highp vec3 tmpvar_49;
  tmpvar_49.xy = vec2(0.0, 0.0);
  tmpvar_49.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_49;
  if (((tmpvar_48.x != 0.0) || (tmpvar_48.y != 0.0))) {
    highp vec4 tmpvar_50;
    highp vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_52;
    tmpvar_52 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_53;
    tmpvar_53.z = 0.0;
    tmpvar_53.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_53.w = (0.5 * log2(max (dot (tmpvar_51, tmpvar_51), dot (tmpvar_52, tmpvar_52))));
    lowp vec4 tmpvar_54;
    tmpvar_54 = textureLod (_Ocean_Map0, tmpvar_53.xy, tmpvar_53.w);
    tmpvar_50 = tmpvar_54;
    dP_1.z = (_Ocean_HeightOffset + tmpvar_50.x);
    highp vec4 tmpvar_55;
    highp vec2 tmpvar_56;
    tmpvar_56 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_58;
    tmpvar_58.z = 0.0;
    tmpvar_58.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_58.w = (0.5 * log2(max (dot (tmpvar_56, tmpvar_56), dot (tmpvar_57, tmpvar_57))));
    lowp vec4 tmpvar_59;
    tmpvar_59 = textureLod (_Ocean_Map0, tmpvar_58.xy, tmpvar_58.w);
    tmpvar_55 = tmpvar_59;
    dP_1.z = (dP_1.z + tmpvar_55.y);
    highp vec4 tmpvar_60;
    highp vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_62;
    tmpvar_62 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_63;
    tmpvar_63.z = 0.0;
    tmpvar_63.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_63.w = (0.5 * log2(max (dot (tmpvar_61, tmpvar_61), dot (tmpvar_62, tmpvar_62))));
    lowp vec4 tmpvar_64;
    tmpvar_64 = textureLod (_Ocean_Map0, tmpvar_63.xy, tmpvar_63.w);
    tmpvar_60 = tmpvar_64;
    dP_1.z = (dP_1.z + tmpvar_60.z);
    highp vec4 tmpvar_65;
    highp vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_67;
    tmpvar_67 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_68;
    tmpvar_68.z = 0.0;
    tmpvar_68.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_68.w = (0.5 * log2(max (dot (tmpvar_66, tmpvar_66), dot (tmpvar_67, tmpvar_67))));
    lowp vec4 tmpvar_69;
    tmpvar_69 = textureLod (_Ocean_Map0, tmpvar_68.xy, tmpvar_68.w);
    tmpvar_65 = tmpvar_69;
    dP_1.z = (dP_1.z + tmpvar_65.w);
    highp vec4 tmpvar_70;
    highp vec2 tmpvar_71;
    tmpvar_71 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_73;
    tmpvar_73.z = 0.0;
    tmpvar_73.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_73.w = (0.5 * log2(max (dot (tmpvar_71, tmpvar_71), dot (tmpvar_72, tmpvar_72))));
    lowp vec4 tmpvar_74;
    tmpvar_74 = textureLod (_Ocean_Map3, tmpvar_73.xy, tmpvar_73.w);
    tmpvar_70 = tmpvar_74;
    dP_1.xy = (_Ocean_Choppyness.x * tmpvar_70.xy);
    highp vec4 tmpvar_75;
    highp vec2 tmpvar_76;
    tmpvar_76 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_77;
    tmpvar_77 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_78;
    tmpvar_78.z = 0.0;
    tmpvar_78.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_78.w = (0.5 * log2(max (dot (tmpvar_76, tmpvar_76), dot (tmpvar_77, tmpvar_77))));
    lowp vec4 tmpvar_79;
    tmpvar_79 = textureLod (_Ocean_Map3, tmpvar_78.xy, tmpvar_78.w);
    tmpvar_75 = tmpvar_79;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * tmpvar_75.zw));
    highp vec4 tmpvar_80;
    highp vec2 tmpvar_81;
    tmpvar_81 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_82;
    tmpvar_82 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_83;
    tmpvar_83.z = 0.0;
    tmpvar_83.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_83.w = (0.5 * log2(max (dot (tmpvar_81, tmpvar_81), dot (tmpvar_82, tmpvar_82))));
    lowp vec4 tmpvar_84;
    tmpvar_84 = textureLod (_Ocean_Map4, tmpvar_83.xy, tmpvar_83.w);
    tmpvar_80 = tmpvar_84;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * tmpvar_80.xy));
    highp vec4 tmpvar_85;
    highp vec2 tmpvar_86;
    tmpvar_86 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_87;
    tmpvar_87 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_88;
    tmpvar_88.z = 0.0;
    tmpvar_88.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_88.w = (0.5 * log2(max (dot (tmpvar_86, tmpvar_86), dot (tmpvar_87, tmpvar_87))));
    lowp vec4 tmpvar_89;
    tmpvar_89 = textureLod (_Ocean_Map4, tmpvar_88.xy, tmpvar_88.w);
    tmpvar_85 = tmpvar_89;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * tmpvar_85.zw));
  };
  mat3 tmpvar_90;
  tmpvar_90[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_90[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_90[2] = _Ocean_OceanToCamera[2].xyz;
  highp vec4 tmpvar_91;
  tmpvar_91.w = 1.0;
  tmpvar_91.xyz = ((tmpvar_16 * tmpvar_9) + (tmpvar_90 * dP_1));
  highp vec3 tmpvar_92;
  tmpvar_92.xy = vec2(0.0, 0.0);
  tmpvar_92.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_91);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_16 * tmpvar_11) + dP_1) + tmpvar_92);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Transmittance;
uniform sampler2D _Irradiance;
uniform highp float _Exposure;
uniform highp float Rg;
uniform highp float Rt;
uniform highp float _Sun_Intensity;
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_CameraPos;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
uniform highp vec2 _VarianceMax;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec2 jm4_1;
  highp vec2 jm3_2;
  highp vec2 jm2_3;
  highp vec2 jm1_4;
  highp vec2 sigmaSq_5;
  highp vec3 V_6;
  highp float outWhiteCapStr_7;
  highp float outAlpha_8;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  highp vec3 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.z = _Ocean_Radius;
  highp vec3 tmpvar_11;
  tmpvar_11 = (normalize((xlv_TEXCOORD1 + tmpvar_10)) * (_Ocean_Radius + 10.0));
  highp vec3 arg0_12;
  arg0_12 = (tmpvar_11 - tmpvar_9);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((sqrt(dot (arg0_12, arg0_12)) / alphaRadius), 0.0, 1.0);
  outAlpha_8 = mix (_OceanAlpha, 1.0, tmpvar_13);
  outWhiteCapStr_7 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_13);
  highp vec3 tmpvar_14;
  tmpvar_14.xy = vec2(0.0, 0.0);
  tmpvar_14.z = _Ocean_CameraPos.z;
  V_6 = normalize((tmpvar_14 - xlv_TEXCOORD1));
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  tmpvar_15 = texture (_Ocean_Map1, P_16);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  tmpvar_17 = texture (_Ocean_Map1, P_18);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  tmpvar_19 = texture (_Ocean_Map2, P_20);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  tmpvar_21 = texture (_Ocean_Map2, P_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = ((((tmpvar_15.xy + tmpvar_17.zw) + tmpvar_19.xy) + tmpvar_21.zw) - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  highp vec3 tmpvar_24;
  tmpvar_24.z = 1.0;
  tmpvar_24.x = -(tmpvar_23.x);
  tmpvar_24.y = -(tmpvar_23.y);
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize(tmpvar_24);
  highp float tmpvar_26;
  tmpvar_26 = dFdx(xlv_TEXCOORD0.x);
  highp float tmpvar_27;
  tmpvar_27 = dFdy(xlv_TEXCOORD0.x);
  highp float tmpvar_28;
  tmpvar_28 = dFdx(xlv_TEXCOORD0.y);
  highp float tmpvar_29;
  tmpvar_29 = dFdy(xlv_TEXCOORD0.y);
  highp float tmpvar_30;
  tmpvar_30 = ((tmpvar_26 * tmpvar_26) + (tmpvar_28 * tmpvar_28));
  highp float tmpvar_31;
  tmpvar_31 = ((tmpvar_27 * tmpvar_27) + (tmpvar_29 * tmpvar_29));
  highp vec3 tmpvar_32;
  tmpvar_32.x = pow ((tmpvar_30 / 10.0), 0.25);
  tmpvar_32.y = (0.5 + ((0.5 * ((tmpvar_26 * tmpvar_27) + (tmpvar_28 * tmpvar_29))) / sqrt((tmpvar_30 * tmpvar_31))));
  tmpvar_32.z = pow ((tmpvar_31 / 10.0), 0.25);
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture (_Ocean_Variance, tmpvar_32);
  sigmaSq_5 = max ((tmpvar_33.xy * _VarianceMax), vec2(2e-05, 2e-05));
  highp vec3 worldP_34;
  worldP_34 = tmpvar_11;
  highp float r_35;
  highp float tmpvar_36;
  tmpvar_36 = sqrt(dot (tmpvar_11, tmpvar_11));
  r_35 = tmpvar_36;
  if ((tmpvar_36 < (0.9 * Rg))) {
    worldP_34.z = (tmpvar_11.z + Rg);
    r_35 = sqrt(dot (worldP_34, worldP_34));
  };
  highp vec3 tmpvar_37;
  tmpvar_37 = (worldP_34 / r_35);
  highp float tmpvar_38;
  tmpvar_38 = dot (tmpvar_37, _Ocean_SunDir);
  highp float tmpvar_39;
  tmpvar_39 = sqrt((1.0 - ((Rg / r_35) * (Rg / r_35))));
  highp vec3 tmpvar_40;
  if ((tmpvar_38 < -(tmpvar_39))) {
    tmpvar_40 = vec3(0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_41;
    highp float y_over_x_42;
    y_over_x_42 = (((tmpvar_38 + 0.15) / 1.15) * 14.1014);
    highp float x_43;
    x_43 = (y_over_x_42 * inversesqrt(((y_over_x_42 * y_over_x_42) + 1.0)));
    highp vec4 tmpvar_44;
    tmpvar_44.zw = vec2(0.0, 0.0);
    tmpvar_44.x = ((sign(x_43) * (1.5708 - (sqrt((1.0 - abs(x_43))) * (1.5708 + (abs(x_43) * (-0.214602 + (abs(x_43) * (0.0865667 + (abs(x_43) * -0.0310296))))))))) / 1.5);
    tmpvar_44.y = sqrt(((r_35 - Rg) / (Rt - Rg)));
    lowp vec4 tmpvar_45;
    tmpvar_45 = textureLod (_Transmittance, tmpvar_44.xy, 0.0);
    tmpvar_41 = tmpvar_45.xyz;
    tmpvar_40 = tmpvar_41;
  };
  highp vec3 tmpvar_46;
  tmpvar_46 = (tmpvar_40 * _Sun_Intensity);
  highp vec3 tmpvar_47;
  highp vec2 tmpvar_48;
  tmpvar_48.x = ((tmpvar_38 + 0.2) / 1.2);
  tmpvar_48.y = ((r_35 - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_49;
  tmpvar_49 = textureLod (_Irradiance, tmpvar_48, 0.0);
  tmpvar_47 = tmpvar_49.xyz;
  highp vec3 tmpvar_50;
  tmpvar_50 = ((2.0 * (tmpvar_47 * _Sun_Intensity)) * ((1.0 + dot (tmpvar_37, tmpvar_25)) * 0.5));
  highp float tmpvar_51;
  tmpvar_51 = sqrt(sigmaSq_5.x);
  highp vec3 tmpvar_52;
  tmpvar_52 = (((pow ((1.0 - dot (V_6, tmpvar_25)), (5.0 * exp((-2.69 * tmpvar_51)))) / (1.0 + (22.7 * pow (tmpvar_51, 1.5)))) * tmpvar_50) / 3.14159);
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize((_Ocean_SunDir + V_6));
  highp float tmpvar_54;
  tmpvar_54 = dot (tmpvar_53, tmpvar_25);
  highp float tmpvar_55;
  tmpvar_55 = (exp(((-2.0 * ((1.0 - (tmpvar_54 * tmpvar_54)) / sigmaSq_5.x)) / (1.0 + tmpvar_54))) / (12.5664 * sigmaSq_5.x));
  highp float tmpvar_56;
  tmpvar_56 = (1.0 - dot (V_6, tmpvar_53));
  highp float tmpvar_57;
  tmpvar_57 = (tmpvar_56 * tmpvar_56);
  highp float tmpvar_58;
  tmpvar_58 = (0.02 + (((0.98 * tmpvar_57) * tmpvar_57) * tmpvar_56));
  highp float tmpvar_59;
  tmpvar_59 = max (dot (_Ocean_SunDir, tmpvar_25), 0.01);
  highp float tmpvar_60;
  tmpvar_60 = max (dot (V_6, tmpvar_25), 0.01);
  highp float tmpvar_61;
  if ((tmpvar_59 <= 0.0)) {
    tmpvar_61 = 0.0;
  } else {
    tmpvar_61 = max (((tmpvar_58 * tmpvar_55) * sqrt(abs((tmpvar_59 / tmpvar_60)))), 0.0);
  };
  highp float tmpvar_62;
  tmpvar_62 = sqrt(sigmaSq_5.x);
  highp vec2 P_63;
  P_63 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  lowp vec2 tmpvar_64;
  tmpvar_64 = texture (_Ocean_Foam0, P_63).xy;
  jm1_4 = tmpvar_64;
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  lowp vec2 tmpvar_66;
  tmpvar_66 = texture (_Ocean_Foam0, P_65).zw;
  jm2_3 = tmpvar_66;
  highp vec2 P_67;
  P_67 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  lowp vec2 tmpvar_68;
  tmpvar_68 = texture (_Ocean_Foam1, P_67).xy;
  jm3_2 = tmpvar_68;
  highp vec2 P_69;
  P_69 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  lowp vec2 tmpvar_70;
  tmpvar_70 = texture (_Ocean_Foam1, P_69).zw;
  jm4_1 = tmpvar_70;
  highp vec2 tmpvar_71;
  tmpvar_71 = (((jm1_4 + jm2_3) + jm3_2) + jm4_1);
  highp float x_72;
  x_72 = ((0.707107 * (outWhiteCapStr_7 - tmpvar_71.x)) * inversesqrt(max ((tmpvar_71.y - ((((jm1_4.x * jm1_4.x) + (jm2_3.x * jm2_3.x)) + (jm3_2.x * jm3_2.x)) + (jm4_1.x * jm4_1.x))), 0.0)));
  highp float tmpvar_73;
  tmpvar_73 = (x_72 * x_72);
  highp float tmpvar_74;
  tmpvar_74 = (0.140012 * tmpvar_73);
  highp vec3 L_75;
  highp vec3 tmpvar_76;
  tmpvar_76 = (((((tmpvar_61 * tmpvar_46) + tmpvar_52) + ((((0.98 * (1.0 - (pow ((1.0 - dot (V_6, tmpvar_25)), (5.0 * exp((-2.69 * tmpvar_62)))) / (1.0 + (22.7 * pow (tmpvar_62, 1.5)))))) * _Ocean_Color) * tmpvar_50) / 3.14159)) + ((((0.5 * (sign(x_72) * sqrt((1.0 - exp(((-(tmpvar_73) * (1.27324 + tmpvar_74)) / (1.0 + tmpvar_74))))))) + 0.5) * (((tmpvar_46 * max (dot (tmpvar_25, _Ocean_SunDir), 0.0)) + tmpvar_50) / 3.14159)) * 0.4)) * _Exposure);
  L_75 = tmpvar_76;
  highp float tmpvar_77;
  if ((tmpvar_76.x < 1.413)) {
    tmpvar_77 = pow ((tmpvar_76.x * 0.38317), 0.454545);
  } else {
    tmpvar_77 = (1.0 - exp(-(tmpvar_76.x)));
  };
  L_75.x = tmpvar_77;
  highp float tmpvar_78;
  if ((tmpvar_76.y < 1.413)) {
    tmpvar_78 = pow ((tmpvar_76.y * 0.38317), 0.454545);
  } else {
    tmpvar_78 = (1.0 - exp(-(tmpvar_76.y)));
  };
  L_75.y = tmpvar_78;
  highp float tmpvar_79;
  if ((tmpvar_76.z < 1.413)) {
    tmpvar_79 = pow ((tmpvar_76.z * 0.38317), 0.454545);
  } else {
    tmpvar_79 = (1.0 - exp(-(tmpvar_76.z)));
  };
  L_75.z = tmpvar_79;
  highp vec4 tmpvar_80;
  tmpvar_80.xyz = L_75;
  tmpvar_80.w = (outAlpha_8 * _GlobalOceanAlpha);
  _glesFragData[0] = tmpvar_80;
}



#endif"
}
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLSL
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
  vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.x = vert_2.x;
  tmpvar_4.y = vert_2.y;
  vec3 tmpvar_5;
  tmpvar_5 = normalize((_Globals_ScreenToCamera * tmpvar_4).xyz);
  vec3 tmpvar_6;
  tmpvar_6 = ((sphereDir.yzx * tmpvar_5.zxy) - (sphereDir.zxy * tmpvar_5.yzx));
  vec3 tmpvar_7;
  tmpvar_7 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_6.yzx * sphereDir.zxy) - (tmpvar_6.zxy * sphereDir.yzx)))));
  float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, ((tmpvar_7.yzx * tmpvar_5.zxy) - (tmpvar_7.zxy * tmpvar_5.yzx)));
  vec3 tmpvar_9;
  if (((tmpvar_8 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_9 = tmpvar_7;
  } else {
    tmpvar_9 = tmpvar_5;
  };
  vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_9;
  vec3 tmpvar_11;
  tmpvar_11 = (_Ocean_CameraToOcean * tmpvar_10).xyz;
  float tmpvar_12;
  tmpvar_12 = (tmpvar_11.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_13;
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_14;
  tmpvar_14 = ((-(_Ocean_CameraPos.z) / tmpvar_11.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_11.z * tmpvar_11.z)))));
  float tmpvar_15;
  tmpvar_15 = abs(((tmpvar_14 - tmpvar_13) * tmpvar_11.z));
  float tmpvar_16;
  if ((tmpvar_15 < 1.0)) {
    tmpvar_16 = tmpvar_14;
  } else {
    tmpvar_16 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_16 * tmpvar_11.xy));
  vec4 tmpvar_17;
  tmpvar_17.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_17.x = _Ocean_ScreenGridSize.x;
  vec4 vert_18;
  vert_18 = (vert_2 + tmpvar_17);
  vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = vert_18.x;
  tmpvar_19.y = vert_18.y;
  vec3 tmpvar_20;
  tmpvar_20 = normalize((_Globals_ScreenToCamera * tmpvar_19).xyz);
  vec3 tmpvar_21;
  tmpvar_21 = ((sphereDir.yzx * tmpvar_20.zxy) - (sphereDir.zxy * tmpvar_20.yzx));
  vec3 tmpvar_22;
  tmpvar_22 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_21.yzx * sphereDir.zxy) - (tmpvar_21.zxy * sphereDir.yzx)))));
  float tmpvar_23;
  tmpvar_23 = dot (tmpvar_21, ((tmpvar_22.yzx * tmpvar_20.zxy) - (tmpvar_22.zxy * tmpvar_20.yzx)));
  vec3 tmpvar_24;
  if (((tmpvar_23 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_24 = tmpvar_22;
  } else {
    tmpvar_24 = tmpvar_20;
  };
  vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = tmpvar_24;
  vec3 tmpvar_26;
  tmpvar_26 = (_Ocean_CameraToOcean * tmpvar_25).xyz;
  float tmpvar_27;
  tmpvar_27 = (tmpvar_26.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_28;
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_29;
  tmpvar_29 = ((-(_Ocean_CameraPos.z) / tmpvar_26.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_26.z * tmpvar_26.z)))));
  float tmpvar_30;
  tmpvar_30 = abs(((tmpvar_29 - tmpvar_28) * tmpvar_26.z));
  float tmpvar_31;
  if ((tmpvar_30 < 1.0)) {
    tmpvar_31 = tmpvar_29;
  } else {
    tmpvar_31 = tmpvar_28;
  };
  vec2 tmpvar_32;
  tmpvar_32 = ((_Ocean_CameraPos.xy + (tmpvar_31 * tmpvar_26.xy)) - tmpvar_3);
  vec4 tmpvar_33;
  tmpvar_33.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_33.y = _Ocean_ScreenGridSize.y;
  vec4 vert_34;
  vert_34 = (vert_2 + tmpvar_33);
  vec4 tmpvar_35;
  tmpvar_35.zw = vec2(0.0, 1.0);
  tmpvar_35.x = vert_34.x;
  tmpvar_35.y = vert_34.y;
  vec3 tmpvar_36;
  tmpvar_36 = normalize((_Globals_ScreenToCamera * tmpvar_35).xyz);
  vec3 tmpvar_37;
  tmpvar_37 = ((sphereDir.yzx * tmpvar_36.zxy) - (sphereDir.zxy * tmpvar_36.yzx));
  vec3 tmpvar_38;
  tmpvar_38 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_37.yzx * sphereDir.zxy) - (tmpvar_37.zxy * sphereDir.yzx)))));
  float tmpvar_39;
  tmpvar_39 = dot (tmpvar_37, ((tmpvar_38.yzx * tmpvar_36.zxy) - (tmpvar_38.zxy * tmpvar_36.yzx)));
  vec3 tmpvar_40;
  if (((tmpvar_39 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_40 = tmpvar_38;
  } else {
    tmpvar_40 = tmpvar_36;
  };
  vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_40;
  vec3 tmpvar_42;
  tmpvar_42 = (_Ocean_CameraToOcean * tmpvar_41).xyz;
  float tmpvar_43;
  tmpvar_43 = (tmpvar_42.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  float tmpvar_44;
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  float tmpvar_45;
  tmpvar_45 = ((-(_Ocean_CameraPos.z) / tmpvar_42.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_42.z * tmpvar_42.z)))));
  float tmpvar_46;
  tmpvar_46 = abs(((tmpvar_45 - tmpvar_44) * tmpvar_42.z));
  float tmpvar_47;
  if ((tmpvar_46 < 1.0)) {
    tmpvar_47 = tmpvar_45;
  } else {
    tmpvar_47 = tmpvar_44;
  };
  vec2 tmpvar_48;
  tmpvar_48 = ((_Ocean_CameraPos.xy + (tmpvar_47 * tmpvar_42.xy)) - tmpvar_3);
  vec3 tmpvar_49;
  tmpvar_49.xy = vec2(0.0, 0.0);
  tmpvar_49.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_49;
  if (((tmpvar_48.x != 0.0) || (tmpvar_48.y != 0.0))) {
    vec2 tmpvar_50;
    tmpvar_50 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    vec4 tmpvar_52;
    tmpvar_52.z = 0.0;
    tmpvar_52.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_52.w = (0.5 * log2(max (dot (tmpvar_50, tmpvar_50), dot (tmpvar_51, tmpvar_51))));
    dP_1.z = (_Ocean_HeightOffset + texture2DLod (_Ocean_Map0, tmpvar_52.xy, tmpvar_52.w).x);
    vec2 tmpvar_53;
    tmpvar_53 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    vec2 tmpvar_54;
    tmpvar_54 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    vec4 tmpvar_55;
    tmpvar_55.z = 0.0;
    tmpvar_55.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_55.w = (0.5 * log2(max (dot (tmpvar_53, tmpvar_53), dot (tmpvar_54, tmpvar_54))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_55.xy, tmpvar_55.w).y);
    vec2 tmpvar_56;
    tmpvar_56 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    vec4 tmpvar_58;
    tmpvar_58.z = 0.0;
    tmpvar_58.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_58.w = (0.5 * log2(max (dot (tmpvar_56, tmpvar_56), dot (tmpvar_57, tmpvar_57))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_58.xy, tmpvar_58.w).z);
    vec2 tmpvar_59;
    tmpvar_59 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    vec2 tmpvar_60;
    tmpvar_60 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    vec4 tmpvar_61;
    tmpvar_61.z = 0.0;
    tmpvar_61.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_61.w = (0.5 * log2(max (dot (tmpvar_59, tmpvar_59), dot (tmpvar_60, tmpvar_60))));
    dP_1.z = (dP_1.z + texture2DLod (_Ocean_Map0, tmpvar_61.xy, tmpvar_61.w).w);
    vec2 tmpvar_62;
    tmpvar_62 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    vec2 tmpvar_63;
    tmpvar_63 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    vec4 tmpvar_64;
    tmpvar_64.z = 0.0;
    tmpvar_64.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_64.w = (0.5 * log2(max (dot (tmpvar_62, tmpvar_62), dot (tmpvar_63, tmpvar_63))));
    dP_1.xy = (_Ocean_Choppyness.x * texture2DLod (_Ocean_Map3, tmpvar_64.xy, tmpvar_64.w).xy);
    vec2 tmpvar_65;
    tmpvar_65 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    vec4 tmpvar_67;
    tmpvar_67.z = 0.0;
    tmpvar_67.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_67.w = (0.5 * log2(max (dot (tmpvar_65, tmpvar_65), dot (tmpvar_66, tmpvar_66))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * texture2DLod (_Ocean_Map3, tmpvar_67.xy, tmpvar_67.w).zw));
    vec2 tmpvar_68;
    tmpvar_68 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    vec2 tmpvar_69;
    tmpvar_69 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    vec4 tmpvar_70;
    tmpvar_70.z = 0.0;
    tmpvar_70.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_70.w = (0.5 * log2(max (dot (tmpvar_68, tmpvar_68), dot (tmpvar_69, tmpvar_69))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * texture2DLod (_Ocean_Map4, tmpvar_70.xy, tmpvar_70.w).xy));
    vec2 tmpvar_71;
    tmpvar_71 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    vec4 tmpvar_73;
    tmpvar_73.z = 0.0;
    tmpvar_73.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_73.w = (0.5 * log2(max (dot (tmpvar_71, tmpvar_71), dot (tmpvar_72, tmpvar_72))));
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * texture2DLod (_Ocean_Map4, tmpvar_73.xy, tmpvar_73.w).zw));
  };
  mat3 tmpvar_74;
  tmpvar_74[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_74[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_74[2] = _Ocean_OceanToCamera[2].xyz;
  vec4 tmpvar_75;
  tmpvar_75.w = 1.0;
  tmpvar_75.xyz = ((tmpvar_16 * tmpvar_9) + (tmpvar_74 * dP_1));
  vec3 tmpvar_76;
  tmpvar_76.xy = vec2(0.0, 0.0);
  tmpvar_76.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_75);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_16 * tmpvar_11) + dP_1) + tmpvar_76);
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
varying vec2 xlv_TEXCOORD0;
varying vec3 xlv_TEXCOORD1;
void main ()
{
  vec3 skyE_1;
  vec3 sunL_2;
  float outWhiteCapStr_3;
  float outAlpha_4;
  vec3 tmpvar_5;
  tmpvar_5.xy = vec2(0.0, 0.0);
  tmpvar_5.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  vec3 tmpvar_6;
  tmpvar_6.xy = vec2(0.0, 0.0);
  tmpvar_6.z = _Ocean_Radius;
  vec3 tmpvar_7;
  tmpvar_7 = (normalize((xlv_TEXCOORD1 + tmpvar_6)) * (_Ocean_Radius + 10.0));
  vec3 arg0_8;
  arg0_8 = (tmpvar_7 - tmpvar_5);
  float tmpvar_9;
  tmpvar_9 = clamp ((sqrt(dot (arg0_8, arg0_8)) / alphaRadius), 0.0, 1.0);
  outAlpha_4 = mix (_OceanAlpha, 1.0, tmpvar_9);
  outWhiteCapStr_3 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_9);
  vec3 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.z = _Ocean_CameraPos.z;
  vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 - xlv_TEXCOORD1));
  vec2 tmpvar_12;
  tmpvar_12 = ((((texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.x)).xy + texture2D (_Ocean_Map1, (xlv_TEXCOORD0 / _Ocean_GridSizes.y)).zw) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.z)).xy) + texture2D (_Ocean_Map2, (xlv_TEXCOORD0 / _Ocean_GridSizes.w)).zw) - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  vec3 tmpvar_13;
  tmpvar_13.z = 1.0;
  tmpvar_13.x = -(tmpvar_12.x);
  tmpvar_13.y = -(tmpvar_12.y);
  vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_13);
  float tmpvar_15;
  tmpvar_15 = dFdx(xlv_TEXCOORD0.x);
  float tmpvar_16;
  tmpvar_16 = dFdy(xlv_TEXCOORD0.x);
  float tmpvar_17;
  tmpvar_17 = dFdx(xlv_TEXCOORD0.y);
  float tmpvar_18;
  tmpvar_18 = dFdy(xlv_TEXCOORD0.y);
  float tmpvar_19;
  tmpvar_19 = ((tmpvar_15 * tmpvar_15) + (tmpvar_17 * tmpvar_17));
  float tmpvar_20;
  tmpvar_20 = ((tmpvar_16 * tmpvar_16) + (tmpvar_18 * tmpvar_18));
  vec3 tmpvar_21;
  tmpvar_21.x = pow ((tmpvar_19 / 10.0), 0.25);
  tmpvar_21.y = (0.5 + ((0.5 * ((tmpvar_15 * tmpvar_16) + (tmpvar_17 * tmpvar_18))) / sqrt((tmpvar_19 * tmpvar_20))));
  tmpvar_21.z = pow ((tmpvar_20 / 10.0), 0.25);
  vec2 tmpvar_22;
  tmpvar_22 = max ((texture3D (_Ocean_Variance, tmpvar_21).xy * _VarianceMax), vec2(2e-05, 2e-05));
  vec3 worldP_23;
  worldP_23 = tmpvar_7;
  float r_24;
  float tmpvar_25;
  tmpvar_25 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_24 = tmpvar_25;
  if ((tmpvar_25 < (0.9 * Rg))) {
    worldP_23.z = (tmpvar_7.z + Rg);
    r_24 = sqrt(dot (worldP_23, worldP_23));
  };
  vec3 tmpvar_26;
  tmpvar_26 = (worldP_23 / r_24);
  float tmpvar_27;
  tmpvar_27 = dot (tmpvar_26, _Ocean_SunDir);
  float tmpvar_28;
  tmpvar_28 = sqrt((1.0 - ((Rg / r_24) * (Rg / r_24))));
  vec3 tmpvar_29;
  if ((tmpvar_27 < -(tmpvar_28))) {
    tmpvar_29 = vec3(0.0, 0.0, 0.0);
  } else {
    float y_over_x_30;
    y_over_x_30 = (((tmpvar_27 + 0.15) / 1.15) * 14.1014);
    float x_31;
    x_31 = (y_over_x_30 * inversesqrt(((y_over_x_30 * y_over_x_30) + 1.0)));
    vec4 tmpvar_32;
    tmpvar_32.zw = vec2(0.0, 0.0);
    tmpvar_32.x = ((sign(x_31) * (1.5708 - (sqrt((1.0 - abs(x_31))) * (1.5708 + (abs(x_31) * (-0.214602 + (abs(x_31) * (0.0865667 + (abs(x_31) * -0.0310296))))))))) / 1.5);
    tmpvar_32.y = sqrt(((r_24 - Rg) / (Rt - Rg)));
    tmpvar_29 = texture2DLod (_Transmittance, tmpvar_32.xy, 0.0).xyz;
  };
  vec2 tmpvar_33;
  tmpvar_33.x = ((tmpvar_27 + 0.2) / 1.2);
  tmpvar_33.y = ((r_24 - Rg) / (Rt - Rg));
  sunL_2 = (tmpvar_29 * _Sun_Intensity);
  skyE_1 = ((2.0 * (texture2DLod (_Irradiance, tmpvar_33, 0.0).xyz * _Sun_Intensity)) * ((1.0 + dot (tmpvar_26, tmpvar_14)) * 0.5));
  vec3 tmpvar_34;
  vec3 i_35;
  i_35 = -(tmpvar_11);
  tmpvar_34 = (i_35 - (2.0 * (dot (tmpvar_14, i_35) * tmpvar_14)));
  vec3 tmpvar_36;
  tmpvar_36.x = tmpvar_34.x;
  tmpvar_36.y = tmpvar_34.y;
  tmpvar_36.z = max (tmpvar_34.z, 0.0);
  vec3 camera_37;
  camera_37 = tmpvar_7;
  vec3 viewdir_38;
  viewdir_38.yz = tmpvar_36.yz;
  float rMu_39;
  float r_40;
  vec3 result_41;
  result_41 = vec3(0.0, 0.0, 0.0);
  float tmpvar_42;
  tmpvar_42 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_38.x = (tmpvar_34.x + _viewdirOffset);
  vec3 tmpvar_43;
  tmpvar_43 = normalize(viewdir_38);
  viewdir_38 = tmpvar_43;
  float tmpvar_44;
  tmpvar_44 = sqrt(dot (tmpvar_7, tmpvar_7));
  r_40 = tmpvar_44;
  float tmpvar_45;
  tmpvar_45 = dot (tmpvar_7, tmpvar_43);
  rMu_39 = tmpvar_45;
  float f_46;
  f_46 = (((tmpvar_45 * tmpvar_45) - (tmpvar_44 * tmpvar_44)) + (tmpvar_42 * tmpvar_42));
  float tmpvar_47;
  if ((f_46 >= 0.0)) {
    tmpvar_47 = sqrt(f_46);
  } else {
    tmpvar_47 = 1e-06;
  };
  float tmpvar_48;
  tmpvar_48 = max ((-(tmpvar_45) - tmpvar_47), 0.0);
  if ((tmpvar_48 > 0.0)) {
    camera_37 = (tmpvar_7 + (tmpvar_48 * tmpvar_43));
    rMu_39 = (tmpvar_45 + tmpvar_48);
    r_40 = tmpvar_42;
  };
  float tmpvar_49;
  tmpvar_49 = dot (tmpvar_43, _Ocean_SunDir);
  float tmpvar_50;
  tmpvar_50 = (dot (camera_37, _Ocean_SunDir) / r_40);
  vec4 tmpvar_51;
  float uMu_52;
  float uR_53;
  float tmpvar_54;
  tmpvar_54 = sqrt(((tmpvar_42 * tmpvar_42) - (Rg * Rg)));
  float tmpvar_55;
  tmpvar_55 = sqrt(((r_40 * r_40) - (Rg * Rg)));
  float tmpvar_56;
  tmpvar_56 = (r_40 * (rMu_39 / r_40));
  float tmpvar_57;
  tmpvar_57 = (((tmpvar_56 * tmpvar_56) - (r_40 * r_40)) + (Rg * Rg));
  vec4 tmpvar_58;
  if (((tmpvar_56 < 0.0) && (tmpvar_57 > 0.0))) {
    vec4 tmpvar_59;
    tmpvar_59.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_59.w = (0.5 - (0.5 / RES_MU));
    tmpvar_58 = tmpvar_59;
  } else {
    vec4 tmpvar_60;
    tmpvar_60.x = -1.0;
    tmpvar_60.y = (tmpvar_54 * tmpvar_54);
    tmpvar_60.z = tmpvar_54;
    tmpvar_60.w = (0.5 + (0.5 / RES_MU));
    tmpvar_58 = tmpvar_60;
  };
  uR_53 = ((0.5 / RES_R) + ((tmpvar_55 / tmpvar_54) * (1.0 - (1.0/(RES_R)))));
  uMu_52 = (tmpvar_58.w + ((((tmpvar_56 * tmpvar_58.x) + sqrt((tmpvar_57 + tmpvar_58.y))) / (tmpvar_55 + tmpvar_58.z)) * (0.5 - (1.0/(RES_MU)))));
  float y_over_x_61;
  y_over_x_61 = (max (tmpvar_50, -0.1975) * 5.34962);
  float x_62;
  x_62 = (y_over_x_61 * inversesqrt(((y_over_x_61 * y_over_x_61) + 1.0)));
  float tmpvar_63;
  tmpvar_63 = ((0.5 / RES_MU_S) + (((((sign(x_62) * (1.5708 - (sqrt((1.0 - abs(x_62))) * (1.5708 + (abs(x_62) * (-0.214602 + (abs(x_62) * (0.0865667 + (abs(x_62) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  float tmpvar_64;
  tmpvar_64 = (((tmpvar_49 + 1.0) / 2.0) * (RES_NU - 1.0));
  float tmpvar_65;
  tmpvar_65 = floor(tmpvar_64);
  float tmpvar_66;
  tmpvar_66 = (tmpvar_64 - tmpvar_65);
  float tmpvar_67;
  tmpvar_67 = (floor(((uR_53 * RES_R) - 1.0)) / RES_R);
  float tmpvar_68;
  tmpvar_68 = (floor((uR_53 * RES_R)) / RES_R);
  float tmpvar_69;
  tmpvar_69 = fract((uR_53 * RES_R));
  vec4 tmpvar_70;
  tmpvar_70.zw = vec2(0.0, 0.0);
  tmpvar_70.x = ((tmpvar_65 + tmpvar_63) / RES_NU);
  tmpvar_70.y = ((uMu_52 / RES_R) + tmpvar_67);
  vec4 tmpvar_71;
  tmpvar_71.zw = vec2(0.0, 0.0);
  tmpvar_71.x = (((tmpvar_65 + tmpvar_63) + 1.0) / RES_NU);
  tmpvar_71.y = ((uMu_52 / RES_R) + tmpvar_67);
  vec4 tmpvar_72;
  tmpvar_72.zw = vec2(0.0, 0.0);
  tmpvar_72.x = ((tmpvar_65 + tmpvar_63) / RES_NU);
  tmpvar_72.y = ((uMu_52 / RES_R) + tmpvar_68);
  vec4 tmpvar_73;
  tmpvar_73.zw = vec2(0.0, 0.0);
  tmpvar_73.x = (((tmpvar_65 + tmpvar_63) + 1.0) / RES_NU);
  tmpvar_73.y = ((uMu_52 / RES_R) + tmpvar_68);
  tmpvar_51 = ((((texture2DLod (_Inscatter, tmpvar_70.xy, 0.0) * (1.0 - tmpvar_66)) + (texture2DLod (_Inscatter, tmpvar_71.xy, 0.0) * tmpvar_66)) * (1.0 - tmpvar_69)) + (((texture2DLod (_Inscatter, tmpvar_72.xy, 0.0) * (1.0 - tmpvar_66)) + (texture2DLod (_Inscatter, tmpvar_73.xy, 0.0) * tmpvar_66)) * tmpvar_69));
  if ((r_40 <= tmpvar_42)) {
    result_41 = ((tmpvar_51.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_49 * tmpvar_49)))) + ((((tmpvar_51.xyz * tmpvar_51.w) / max (tmpvar_51.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_49)), -1.5)) * (1.0 + (tmpvar_49 * tmpvar_49))) / (2.0 + (mieG * mieG)))));
  } else {
    result_41 = vec3(0.0, 0.0, 0.0);
  };
  float tmpvar_74;
  tmpvar_74 = sqrt(tmpvar_22.x);
  vec3 tmpvar_75;
  tmpvar_75 = ((result_41 * _Sun_Intensity) * (pow ((1.0 - dot (tmpvar_11, tmpvar_14)), (5.0 * exp((-2.69 * tmpvar_74)))) / (1.0 + (22.7 * pow (tmpvar_74, 1.5)))));
  vec3 tmpvar_76;
  tmpvar_76 = normalize((_Ocean_SunDir + tmpvar_11));
  float tmpvar_77;
  tmpvar_77 = dot (tmpvar_76, tmpvar_14);
  float tmpvar_78;
  tmpvar_78 = (exp(((-2.0 * ((1.0 - (tmpvar_77 * tmpvar_77)) / tmpvar_22.x)) / (1.0 + tmpvar_77))) / (12.5664 * tmpvar_22.x));
  float tmpvar_79;
  tmpvar_79 = (1.0 - dot (tmpvar_11, tmpvar_76));
  float tmpvar_80;
  tmpvar_80 = (tmpvar_79 * tmpvar_79);
  float tmpvar_81;
  tmpvar_81 = (0.02 + (((0.98 * tmpvar_80) * tmpvar_80) * tmpvar_79));
  float tmpvar_82;
  tmpvar_82 = max (dot (_Ocean_SunDir, tmpvar_14), 0.01);
  float tmpvar_83;
  tmpvar_83 = max (dot (tmpvar_11, tmpvar_14), 0.01);
  float tmpvar_84;
  if ((tmpvar_82 <= 0.0)) {
    tmpvar_84 = 0.0;
  } else {
    tmpvar_84 = max (((tmpvar_81 * tmpvar_78) * sqrt(abs((tmpvar_82 / tmpvar_83)))), 0.0);
  };
  float tmpvar_85;
  tmpvar_85 = sqrt(tmpvar_22.x);
  vec4 tmpvar_86;
  tmpvar_86 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.x));
  vec4 tmpvar_87;
  tmpvar_87 = texture2D (_Ocean_Foam0, (xlv_TEXCOORD0 / _Ocean_GridSizes.y));
  vec4 tmpvar_88;
  tmpvar_88 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.z));
  vec4 tmpvar_89;
  tmpvar_89 = texture2D (_Ocean_Foam1, (xlv_TEXCOORD0 / _Ocean_GridSizes.w));
  vec2 tmpvar_90;
  tmpvar_90 = (((tmpvar_86.xy + tmpvar_87.zw) + tmpvar_88.xy) + tmpvar_89.zw);
  float x_91;
  x_91 = ((0.707107 * (outWhiteCapStr_3 - tmpvar_90.x)) * inversesqrt(max ((tmpvar_90.y - ((((tmpvar_86.x * tmpvar_86.x) + (tmpvar_87.z * tmpvar_87.z)) + (tmpvar_88.x * tmpvar_88.x)) + (tmpvar_89.z * tmpvar_89.z))), 0.0)));
  float tmpvar_92;
  tmpvar_92 = (x_91 * x_91);
  float tmpvar_93;
  tmpvar_93 = (0.140012 * tmpvar_92);
  vec3 L_94;
  vec3 tmpvar_95;
  tmpvar_95 = (((((tmpvar_84 * sunL_2) + tmpvar_75) + ((((0.98 * (1.0 - (pow ((1.0 - dot (tmpvar_11, tmpvar_14)), (5.0 * exp((-2.69 * tmpvar_85)))) / (1.0 + (22.7 * pow (tmpvar_85, 1.5)))))) * _Ocean_Color) * skyE_1) / 3.14159)) + ((((0.5 * (sign(x_91) * sqrt((1.0 - exp(((-(tmpvar_92) * (1.27324 + tmpvar_93)) / (1.0 + tmpvar_93))))))) + 0.5) * (((sunL_2 * max (dot (tmpvar_14, _Ocean_SunDir), 0.0)) + skyE_1) / 3.14159)) * 0.4)) * _Exposure);
  L_94 = tmpvar_95;
  float tmpvar_96;
  if ((tmpvar_95.x < 1.413)) {
    tmpvar_96 = pow ((tmpvar_95.x * 0.38317), 0.454545);
  } else {
    tmpvar_96 = (1.0 - exp(-(tmpvar_95.x)));
  };
  L_94.x = tmpvar_96;
  float tmpvar_97;
  if ((tmpvar_95.y < 1.413)) {
    tmpvar_97 = pow ((tmpvar_95.y * 0.38317), 0.454545);
  } else {
    tmpvar_97 = (1.0 - exp(-(tmpvar_95.y)));
  };
  L_94.y = tmpvar_97;
  float tmpvar_98;
  if ((tmpvar_95.z < 1.413)) {
    tmpvar_98 = pow ((tmpvar_95.z * 0.38317), 0.454545);
  } else {
    tmpvar_98 = (1.0 - exp(-(tmpvar_95.z)));
  };
  L_94.z = tmpvar_98;
  vec4 tmpvar_99;
  tmpvar_99.xyz = L_94;
  tmpvar_99.w = (outAlpha_4 * _GlobalOceanAlpha);
  gl_FragData[0] = tmpvar_99;
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 296 math, 16 textures, 1 branches
Keywords { "SKY_REFLECTIONS_ON" }
Bind "vertex" Vertex
Matrix 0 [_Ocean_OceanToCamera]
Matrix 4 [_Ocean_CameraToOcean]
Matrix 8 [_Globals_ScreenToCamera]
Matrix 12 [_Globals_CameraToScreen]
Float 16 [_Ocean_Radius]
Float 17 [_Ocean_HeightOffset]
Vector 18 [_Ocean_CameraPos]
Vector 19 [sphereDir]
Float 20 [cosTheta]
Float 21 [sinTheta]
Vector 22 [_Ocean_MapSize]
Vector 23 [_Ocean_Choppyness]
Vector 24 [_Ocean_GridSizes]
Vector 25 [_Ocean_ScreenGridSize]
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c26, 1.25000000, 0.00000000, 1.00000000, 2.00000000
def c27, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_2d s0
dcl_2d s1
dcl_2d s2
mov r1.w, c18.z
mul r8.xy, v0, c26.x
mov r8.zw, c26.xyyz
slt r1.w, c26.y, r1
mov r2.w, c26.y
dp4 r0.z, r8, c10
dp4 r0.x, r8, c8
dp4 r0.y, r8, c9
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r1.xyz, r0.yzxw, c19.zxyw
mad r2.xyz, r0.zxyw, c19.yzxw, -r1
mul r1.xyz, r2.zxyw, c19.yzxw
mad r1.xyz, r2.yzxw, c19.zxyw, -r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mov r0.w, c20.x
mul r1.xyz, r1, c21.x
mad r1.xyz, c19, r0.w, r1
mul r3.xyz, r0.yzxw, r1.zxyw
mad r3.xyz, r0.zxyw, r1.yzxw, -r3
dp3 r0.w, r2, r3
slt r0.w, c26.y, r0
mul r0.w, r0, r1
max r0.w, -r0, r0
slt r0.w, c26.y, r0
add r2.x, -r0.w, c26.z
mul r0.xyz, r0, r2.x
mad r1.xyz, r0.w, r1, r0
mov r2.xyz, r1
dp4 r3.w, r2, c6
rcp r0.x, r3.w
mul r0.y, r0.x, -c18.z
mov r0.z, c16.x
mul r3.x, c26.w, r0.z
rcp r0.z, r3.x
add r4.x, r3, c18.z
mov r0.x, c18.z
add r5.w, c16.x, r0.x
mul r6.z, r4.x, c18
mul r4.w, r0.z, c18.z
mad r0.w, -r3, r3, c26.z
mad r0.z, r4.w, r0.w, c26
mul r6.x, r0.y, r0.z
mov r0.zw, c26.xyyz
mul r5.x, r3.w, r5.w
mov r0.y, c25
mov r0.x, c26.y
add r0.xy, r8, r0
dp4 r3.z, r0, c10
dp4 r3.y, r0, c9
dp4 r3.x, r0, c8
mad r0.x, r5, r5, -r6.z
dp3 r0.y, r3, r3
rsq r0.y, r0.y
max r0.x, r0, c26.y
rsq r0.w, r0.x
mul r3.xyz, r0.y, r3
mul r0.xyz, r3.yzxw, c19.zxyw
mad r4.xyz, r3.zxyw, c19.yzxw, -r0
mul r0.xyz, r4.zxyw, c19.yzxw
mad r0.xyz, r4.yzxw, c19.zxyw, -r0
dp3 r5.y, r0, r0
rsq r5.y, r5.y
mul r0.xyz, r5.y, r0
rcp r0.w, r0.w
add r0.w, -r5.x, -r0
add r5.x, r6, -r0.w
mul r5.x, r3.w, r5
abs r5.x, r5
slt r5.x, r5, c26.z
max r5.y, -r5.x, r5.x
slt r6.y, c26, r5
add r6.w, -r6.y, c26.z
mul r0.w, r0, r6
mad r6.w, r6.y, r6.x, r0
dp4 r6.y, r2, c5
dp4 r6.x, r2, c4
mov r2.zw, c26.xyyz
mad r7.xy, r6, r6.w, c18
mov r5.x, c20
mul r0.xyz, r0, c21.x
mad r0.xyz, c19, r5.x, r0
mul r5.xyz, r3.yzxw, r0.zxyw
mad r5.xyz, r3.zxyw, r0.yzxw, -r5
dp3 r4.x, r4, r5
slt r0.w, c26.y, r4.x
mul r0.w, r1, r0
max r0.w, -r0, r0
slt r0.w, c26.y, r0
mov r2.y, c26
mov r2.x, c25
add r2.xy, r8, r2
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
add r2.y, -r0.w, c26.z
mul r3.xyz, r3, r2.y
mad r0.xyz, r0.w, r0, r3
mov r0.w, c26.y
dp4 r2.w, r0, c6
rcp r5.x, r2.w
mul r7.w, r5, r2
dp3 r2.x, r4, r4
mad r5.z, -r2.w, r2.w, c26
mad r8.x, r7.w, r7.w, -r6.z
rsq r2.x, r2.x
mul r2.xyz, r2.x, r4
mul r3.xyz, r2.yzxw, c19.zxyw
mad r3.xyz, r2.zxyw, c19.yzxw, -r3
mul r4.xyz, r3.zxyw, c19.yzxw
mad r4.xyz, r3.yzxw, c19.zxyw, -r4
mul r5.y, r5.x, -c18.z
dp3 r5.x, r4, r4
rsq r5.x, r5.x
mul r4.xyz, r5.x, r4
mad r5.z, r4.w, r5, c26
mul r7.z, r5.y, r5
mov r5.x, c20
mul r4.xyz, r4, c21.x
mad r4.xyz, c19, r5.x, r4
mul r5.xyz, r2.yzxw, r4.zxyw
mad r5.xyz, r2.zxyw, r4.yzxw, -r5
dp3 r3.x, r3, r5
max r8.x, r8, c26.y
rsq r3.y, r8.x
slt r3.x, c26.y, r3
mul r3.x, r1.w, r3
rcp r3.y, r3.y
add r1.w, -r7, -r3.y
add r3.y, r7.z, -r1.w
mul r3.y, r3, r2.w
max r3.x, -r3, r3
slt r3.x, c26.y, r3
add r2.w, -r3.x, c26.z
mul r2.xyz, r2, r2.w
abs r3.y, r3
mad r2.xyz, r3.x, r4, r2
mov r2.w, c26.y
dp4 r3.z, r2, c6
slt r3.y, r3, c26.z
max r4.x, -r3.y, r3.y
mul r3.x, r5.w, r3.z
mad r3.y, r3.x, r3.x, -r6.z
slt r4.x, c26.y, r4
add r4.y, -r4.x, c26.z
mul r4.y, r1.w, r4
max r3.y, r3, c26
rsq r3.y, r3.y
rcp r1.w, r3.y
add r1.w, -r3.x, -r1
mad r3.y, -r3.z, r3.z, c26.z
rcp r3.x, r3.z
mad r4.z, r4.x, r7, r4.y
mad r3.y, r4.w, r3, c26.z
mul r3.x, r3, -c18.z
mul r4.x, r3, r3.y
dp4 r3.x, r0, c4
dp4 r3.y, r0, c5
mad r0.xy, r4.z, r3, c18
add r4.y, r4.x, -r1.w
mul r0.z, r4.y, r3
add r3.xy, -r7, r0
abs r0.z, r0
slt r3.z, c26.y, r3.x
slt r0.w, r0.x, r7.x
slt r0.z, r0, c26
max r0.x, -r0.z, r0.z
slt r0.x, c26.y, r0
add r0.w, r0, r3.z
add r0.z, -r0.x, c26
slt r3.z, r0.y, r7.y
mul r0.y, r1.w, r0.z
mad r0.z, r0.x, r4.x, r0.y
slt r4.y, c26, r3
dp4 r0.x, r2, c4
dp4 r0.y, r2, c5
mad r0.xy, r0.z, r0, c18
add r1.w, r3.z, r4.y
add_sat r0.z, r0.w, r1.w
add r4.xy, -r7, r0
mov r6.z, r3.w
mov r2.xy, c26.y
mov r2.z, c17.x
if_gt r0.z, c26.y
rcp r1.w, c24.x
mul r0.zw, r3.xyxy, r1.w
mul r0.xy, r4, r1.w
mul r0.zw, r0, c22.y
mul r0.zw, r0, r0
mul r0.xy, r0, c22.x
mul r0.xy, r0, r0
rcp r2.w, c24.y
add r0.x, r0, r0.y
add r0.z, r0, r0.w
max r0.x, r0, r0.z
log r3.z, r0.x
mul r0.zw, r3.xyxy, r2.w
mul r0.xy, r4, r2.w
mul r0.zw, r0, c22.y
mul r0.zw, r0, r0
mul r0.xy, r0, c22.x
mul r0.xy, r0, r0
add r0.z, r0, r0.w
add r0.x, r0, r0.y
max r0.w, r0.x, r0.z
mul r0.xy, r7, r1.w
mul r0.z, r3, c27.x
texldl r5.xy, r0.xyzz, s1
texldl r0.x, r0.xyzz, s0
log r0.w, r0.w
mul r5.z, r0.w, c27.x
rcp r0.w, c24.z
mul r4.zw, r3.xyxy, r0.w
rcp r1.w, c24.w
mad r2.xy, r5, c23.x, r2
mul r5.xy, r7, r2.w
texldl r3.zw, r5.xyzz, s1
mad r2.xy, r3.zwzw, c23.y, r2
mul r3.zw, r4.xyxy, r0.w
mul r3.zw, r3, c22.x
mul r3.zw, r3, r3
mul r4.zw, r4, c22.y
mul r3.xy, r3, r1.w
mul r3.xy, r3, c22.y
mul r3.xy, r3, r3
add r2.w, r3.z, r3
mul r4.zw, r4, r4
add r3.z, r4, r4.w
max r2.w, r2, r3.z
mul r3.zw, r4.xyxy, r1.w
mul r3.zw, r3, c22.x
log r2.w, r2.w
add r3.y, r3.x, r3
mul r3.zw, r3, r3
add r3.x, r3.z, r3.w
max r3.x, r3, r3.y
log r3.z, r3.x
mul r4.xy, r7, r0.w
mul r4.z, r2.w, c27.x
texldl r3.xy, r4.xyzz, s2
mad r2.xy, r3, c23.z, r2
mul r3.z, r3, c27.x
mul r3.xy, r7, r1.w
texldl r7.zw, r3.xyzz, s2
add r0.x, r2.z, r0
texldl r0.y, r5.xyzz, s0
add r0.x, r0, r0.y
texldl r0.z, r4.xyzz, s0
texldl r0.w, r3.xyzz, s0
add r0.x, r0, r0.z
mad r2.xy, r7.zwzw, c23.w, r2
add r2.z, r0.x, r0.w
endif
mov r0.w, c26.z
dp3 r0.z, r2, c2
dp3 r0.y, r2, c1
dp3 r0.x, r2, c0
mad r0.xyz, r6.w, r1, r0
dp4 o0.w, r0, c15
dp4 o0.z, r0, c14
dp4 o0.y, r0, c13
dp4 o0.x, r0, c12
mad r1.xyz, r6.w, r6, r2
mov r0.z, c18
mov r0.xy, c26.y
add o2.xyz, r1, r0
mov o1.xy, r7
"
}
SubProgram "d3d11 " {
// Stats: 167 math, 2 branches
Keywords { "SKY_REFLECTIONS_ON" }
Bind "vertex" Vertex
SetTexture 0 [_Ocean_Map0] 2D 0
SetTexture 1 [_Ocean_Map3] 2D 1
SetTexture 2 [_Ocean_Map4] 2D 2
ConstBuffer "$Globals" 912
Matrix 192 [_Ocean_OceanToCamera]
Matrix 256 [_Ocean_CameraToOcean]
Matrix 352 [_Globals_ScreenToCamera]
Matrix 544 [_Globals_CameraToScreen]
Float 172 [_Ocean_Radius]
Float 176 [_Ocean_HeightOffset]
Vector 180 [_Ocean_CameraPos] 3
Vector 320 [sphereDir] 3
Float 332 [cosTheta]
Float 336 [sinTheta]
Vector 784 [_Ocean_MapSize] 2
Vector 800 [_Ocean_Choppyness]
Vector 848 [_Ocean_GridSizes]
Vector 864 [_Ocean_ScreenGridSize] 2
BindCB  "$Globals" 0
"vs_4_0
eefiecedmfcnalifagfhjngpdmmpamlinjdagkidabaaaaaamebjaaaaadaaaaaa
cmaaaaaakaaaaaaabaabaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapadaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefckmbiaaaaeaaaabaaclagaaaa
fjaaaaaeegiocaaaaaaaaaaadhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaafpaaaaaddcbabaaaaaaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacajaaaaaa
diaaaaakdcaabaaaaaaaaaaaegbabaaaaaaaaaaaaceaaaaaaaaakadpaaaakadp
aaaaaaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaabhaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabgaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaa
diaaaaahhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaajgaebaaaabaaaaaacgijcaaaaaaaaaaabeaaaaaadcaaaaal
hcaabaaaacaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaaihcaabaaaadaaaaaacgajbaaaacaaaaaajgiecaaa
aaaaaaaabeaaaaaadcaaaaalhcaabaaaadaaaaaajgaebaaaacaaaaaacgijcaaa
aaaaaaaabeaaaaaaegacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaafecaabaaaaaaaaaaackaabaaa
aaaaaaaadiaaaaahhcaabaaaadaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
diaaaaajhcaabaaaaeaaaaaaegiccaaaaaaaaaaabeaaaaaapgipcaaaaaaaaaaa
beaaaaaadcaaaaakhcaabaaaadaaaaaaagiacaaaaaaaaaaabfaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaafaaaaaajgaebaaaabaaaaaa
cgajbaaaadaaaaaadcaaaaakhcaabaaaafaaaaaajgaebaaaadaaaaaacgajbaaa
abaaaaaaegacbaiaebaaaaaaafaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaafaaaaaadbaaaaahecaabaaaaaaaaaaaabeaaaaaaaaaaaaa
ckaabaaaaaaaaaaadbaaaaaiicaabaaaaaaaaaaaabeaaaaaaaaaaaaadkiacaaa
aaaaaaaaalaaaaaaabaaaaahecaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
aaaaaaaadhaaaaajhcaabaaaabaaaaaakgakbaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
aaaaaaaabbaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaabaaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaabcaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaaaaaaaaajecaabaaa
aaaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaalaaaaaadiaaaaah
icaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaacaaaaaaaaaaaaajicaabaaa
acaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaakaaaaaadcaaaaal
bcaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaaabeaaaaaaaaaaaeadkiacaaa
aaaaaaaaalaaaaaadiaaaaaibcaabaaaadaaaaaaakaabaaaadaaaaaadkiacaaa
aaaaaaaaalaaaaaadcaaaaakicaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaa
abaaaaaaakaabaiaebaaaaaaadaaaaaadeaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
dcaaaaalicaabaaaabaaaaaackaabaiaebaaaaaaacaaaaaackaabaaaaaaaaaaa
dkaabaiaebaaaaaaabaaaaaaaoaaaaajccaabaaaadaaaaaadkiacaiaebaaaaaa
aaaaaaaaalaaaaaackaabaaaacaaaaaaaoaaaaaiicaabaaaacaaaaaadkiacaaa
aaaaaaaaalaaaaaadkaabaaaacaaaaaadcaaaaakecaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaaabeaaaaaaaaaiadpdcaaaaajecaabaaa
adaaaaaadkaabaaaacaaaaaackaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaah
icaabaaaadaaaaaackaabaaaadaaaaaabkaabaaaadaaaaaadcaaaaakccaabaaa
adaaaaaabkaabaaaadaaaaaackaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaa
diaaaaahccaabaaaadaaaaaackaabaaaacaaaaaabkaabaaaadaaaaaadbaaaaai
ccaabaaaadaaaaaabkaabaiaibaaaaaaadaaaaaaabeaaaaaaaaaiadpdhaaaaaj
icaabaaaabaaaaaabkaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaa
dcaaaaakgcaabaaaadaaaaaapgapbaaaabaaaaaaagabbaaaacaaaaaafgigcaaa
aaaaaaaaalaaaaaadcaaaaakicaabaaaadaaaaaabkbabaaaaaaaaaaaabeaaaaa
aaaakadpbkiacaaaaaaaaaaadgaaaaaadiaaaaaihcaabaaaafaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaabhaaaaaadcaaaaakhcaabaaaafaaaaaaegiccaaa
aaaaaaaabgaaaaaaagaabaaaaaaaaaaaegacbaaaafaaaaaaaaaaaaaihcaabaaa
afaaaaaaegacbaaaafaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
afaaaaaadiaaaaaihcaabaaaagaaaaaajgaebaaaafaaaaaacgijcaaaaaaaaaaa
beaaaaaadcaaaaalhcaabaaaagaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaaihcaabaaaahaaaaaacgajbaaa
agaaaaaajgiecaaaaaaaaaaabeaaaaaadcaaaaalhcaabaaaahaaaaaajgaebaaa
agaaaaaacgijcaaaaaaaaaaabeaaaaaaegacbaiaebaaaaaaahaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaaagaabaaaaaaaaaaa
egacbaaaahaaaaaadcaaaaakhcaabaaaahaaaaaaagiacaaaaaaaaaaabfaaaaaa
egacbaaaahaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
afaaaaaacgajbaaaahaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaahaaaaaa
cgajbaaaafaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaagaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhcaabaaaafaaaaaaagaabaaaaaaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaaafaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaaklcaabaaaafaaaaaaegiicaaaaaaaaaaa
baaaaaaaagaabaaaafaaaaaaegaibaaaagaaaaaadcaaaaakhcaabaaaafaaaaaa
egiccaaaaaaaaaaabcaaaaaakgakbaaaafaaaaaaegadbaaaafaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaackaabaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaalbcaabaaaaaaaaaaackaabaia
ebaaaaaaafaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaaaoaaaaaj
icaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaackaabaaaafaaaaaa
dcaaaaakicaabaaaaeaaaaaackaabaiaebaaaaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaa
aeaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaafaaaaaadkaabaaaadaaaaaa
dkaabaaaaeaaaaaadcaaaaakicaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
aeaaaaaaakaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaadaaaaaackaabaaa
afaaaaaadkaabaaaadaaaaaadbaaaaaiicaabaaaadaaaaaadkaabaiaibaaaaaa
adaaaaaaabeaaaaaaaaaiadpdhaaaaajbcaabaaaaaaaaaaadkaabaaaadaaaaaa
dkaabaaaafaaaaaaakaabaaaaaaaaaaadcaaaaakpcaabaaaafaaaaaaagaabaaa
aaaaaaaaegaebaaaafaaaaaajgijcaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaa
afaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaafaaaaaadjaaaaakdcaabaaa
agaaaaaaogakbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dmaaaaahbcaabaaaaaaaaaaabkaabaaaagaaaaaaakaabaaaagaaaaaabpaaaead
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakbabaaaaaaaaaaaabeaaaaa
aaaakadpakiacaaaaaaaaaaadgaaaaaadiaaaaaihcaabaaaagaaaaaafgafbaaa
aaaaaaaaegiccaaaaaaaaaaabhaaaaaadcaaaaakhcaabaaaagaaaaaaegiccaaa
aaaaaaaabgaaaaaaagaabaaaaaaaaaaaegacbaaaagaaaaaaaaaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaegiccaaaaaaaaaaabjaaaaaabaaaaaahbcaabaaa
aaaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
agaaaaaadiaaaaaihcaabaaaahaaaaaajgaebaaaagaaaaaacgijcaaaaaaaaaaa
beaaaaaadcaaaaalhcaabaaaahaaaaaajgiecaaaaaaaaaaabeaaaaaacgajbaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaaihcaabaaaaiaaaaaacgajbaaa
ahaaaaaajgiecaaaaaaaaaaabeaaaaaadcaaaaalhcaabaaaaiaaaaaajgaebaaa
ahaaaaaacgijcaaaaaaaaaaabeaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaah
bcaabaaaaaaaaaaaegacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaagaabaaaaaaaaaaa
egacbaaaaiaaaaaadcaaaaakhcaabaaaaeaaaaaaagiacaaaaaaaaaaabfaaaaaa
egacbaaaaiaaaaaaegacbaaaaeaaaaaadiaaaaahhcaabaaaaiaaaaaajgaebaaa
agaaaaaacgajbaaaaeaaaaaadcaaaaakhcaabaaaaiaaaaaajgaebaaaaeaaaaaa
cgajbaaaagaaaaaaegacbaiaebaaaaaaaiaaaaaabaaaaaahbcaabaaaaaaaaaaa
egacbaaaahaaaaaaegacbaaaaiaaaaaadbaaaaahbcaabaaaaaaaaaaaabeaaaaa
aaaaaaaaakaabaaaaaaaaaaaabaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajlcaabaaaaaaaaaaaagaabaaaaaaaaaaaegaibaaa
aeaaaaaaegaibaaaagaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaabbaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaaaaaaaaa
baaaaaaaagaabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaaaaaaaaabcaaaaaapgapbaaaaaaaaaaaegaibaaaaeaaaaaadiaaaaah
icaabaaaadaaaaaackaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaakbcaabaaa
adaaaaaadkaabaaaadaaaaaadkaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
deaaaaahbcaabaaaadaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaaaaaelaaaaaf
bcaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaalecaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaackaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaaaoaaaaaj
bcaabaaaadaaaaaadkiacaiaebaaaaaaaaaaaaaaalaaaaaadkaabaaaaaaaaaaa
dcaaaaakicaabaaaadaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdcaaaaajicaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaadaaaaaadkaabaaaacaaaaaa
akaabaaaadaaaaaadcaaaaakicaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaa
acaaaaaackaabaiaebaaaaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaiaibaaaaaa
aaaaaaaaabeaaaaaaaaaiadpdhaaaaajecaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaadaaaaaackaabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaakgakbaaa
aaaaaaaaegaebaaaaaaaaaaajgijcaaaaaaaaaaaalaaaaaaaaaaaaaipcaabaaa
aaaaaaaajgajbaiaebaaaaaaadaaaaaaegaobaaaaaaaaaaaaoaaaaaipcaabaaa
aeaaaaaajgajbaaaadaaaaaaagifcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaa
agaaaaaaogaobaaaaaaaaaaaagifcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaa
ahaaaaaaogaobaaaafaaaaaaagifcaaaaaaaaaaadfaaaaaadiaaaaaipcaabaaa
agaaaaaaegaobaaaagaaaaaaagiacaaaaaaaaaaadbaaaaaadiaaaaaipcaabaaa
ahaaaaaaegaobaaaahaaaaaafgifcaaaaaaaaaaadbaaaaaaapaaaaahicaabaaa
acaaaaaaegaabaaaagaaaaaaegaabaaaagaaaaaaapaaaaahbcaabaaaadaaaaaa
egaabaaaahaaaaaaegaabaaaahaaaaaadeaaaaahicaabaaaacaaaaaadkaabaaa
acaaaaaaakaabaaaadaaaaaacpaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaadpeiaaaaal
pcaabaaaaiaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaadaaaaaaakaabaaaaiaaaaaaakiacaaa
aaaaaaaaalaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaaagaaaaaaogakbaaa
agaaaaaaapaaaaahbcaabaaaagaaaaaaogakbaaaahaaaaaaogakbaaaahaaaaaa
deaaaaahicaabaaaadaaaaaadkaabaaaadaaaaaaakaabaaaagaaaaaacpaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaadpeiaaaaalpcaabaaaagaaaaaaogakbaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaabkaabaaaagaaaaaaaoaaaaaipcaabaaaagaaaaaa
jgajbaaaadaaaaaakgipcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaakgipcaaaaaaaaaaadfaaaaaaaoaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaakgipcaaaaaaaaaaadfaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaagiacaaaaaaaaaaadbaaaaaadiaaaaaipcaabaaaafaaaaaa
egaobaaaafaaaaaafgifcaaaaaaaaaaadbaaaaaaapaaaaahbcaabaaaaaaaaaaa
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
dcaaaaaadcaaaaakkcaabaaaaaaaaaaaagiacaaaaaaaaaaadcaaaaaaagaebaaa
ahaaaaaafganbaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaagaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaakaabaaaaaaaaaaadcaaaaakdcaabaaa
aaaaaaaakgikcaaaaaaaaaaadcaaaaaaegaabaaaaeaaaaaangafbaaaaaaaaaaa
eiaaaaalpcaabaaaaeaaaaaaogakbaaaagaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaackaabaaaaaaaaaaadcaaaaakdcaabaaaafaaaaaapgipcaaaaaaaaaaa
dcaaaaaaogakbaaaaeaaaaaaegaabaaaaaaaaaaabcaaaaabdgaaaaafbcaabaaa
aaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaaakiacaaaaaaaaaaa
alaaaaaadgaaaaafhcaabaaaafaaaaaaagacbaaaaaaaaaaabfaaaaabdiaaaaai
hcaabaaaaaaaaaaafgafbaaaafaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagaabaaaafaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgakbaaa
afaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaajhcaabaaaabaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaafaaaaaadgaaaaafbcaabaaaacaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaacaaaaaadkiacaaaaaaaaaaaalaaaaaa
aaaaaaahhccabaaaacaaaaaaegacbaaaabaaaaaaagacbaaaacaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaacdaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaccaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaceaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaaaaaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaacfaaaaaadgaaaaafdccabaaaabaaaaaajgafbaaaadaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES


#ifdef VERTEX

#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
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
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
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
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
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
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:287(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:287(74): error: type mismatch
0:287(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "glesdesktop " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES


#ifdef VERTEX

#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
#endif
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
attribute vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;
vec4 xll_tex2Dlod(sampler2D s, vec4 coord) {
   return texture2DLod( s, coord.xy, coord.w);
}
mat3 xll_constructMat3_mf4x4( mat4 m) {
  return mat3( vec3( m[0]), vec3( m[1]), vec3( m[2]));
}
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
*/


#endif
#ifdef FRAGMENT

#ifndef SKY_REFLECTIONS_ON
    #define SKY_REFLECTIONS_ON 1
#endif
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
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
#line 133
struct v2f {
    highp vec4 pos;
    highp vec2 oceanU;
    highp vec3 oceanP;
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
    highp float p = (exp(((-2.0 * ((1.0 - (hn * hn)) / sigmaSq)) / (1.0 + hn))) / (12.5664 * sigmaSq));
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
    return (sign(x) * sqrt((1.0 - exp((((-x2) * (1.27324 + ax2)) / (1.0 + ax2))))));
}
#line 100
highp float WhitecapCoverage( in highp float epsilon, in highp float mu, in highp float sigma2 ) {
    return ((0.5 * erf( (((0.5 * sqrt(2.0)) * (epsilon - mu)) * (1.0 / sqrt(sigma2))))) + 0.5);
}
#line 77
highp vec3 hdr( in highp vec3 L ) {
    L = (L * _Exposure);
    #line 79
    L.x = (( (L.x < 1.413) ) ? ( pow( (L.x * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.x))) ));
    L.y = (( (L.y < 1.413) ) ? ( pow( (L.y * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.y))) ));
    L.z = (( (L.z < 1.413) ) ? ( pow( (L.z * 0.38317), 0.454545) ) : ( (1.0 - exp((-L.z))) ));
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
    highp vec3 Lsea = (((RefractedSeaRadiance( V, N, float( sigmaSq)) * _Ocean_Color) * skyE) / 3.14159);
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
    highp vec3 l = (((sunL * max( dot( N, L), 0.0)) + skyE) / 3.14159);
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
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:138(2): warning: empty declaration
0:65(2): warning: empty declaration
0:117(39): error: invalid type `sampler3D' in declaration of `_Ocean_Variance'
0:287(50): error: `_Ocean_Variance' undeclared
0:0(0): error: no matching function for call to `texture3D(error, vec3)'
0:287(74): error: type mismatch
0:287(88): error: operands to arithmetic operators must be numeric
*/


#endif"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
uniform highp float _Ocean_Radius;
uniform highp float _Ocean_HeightOffset;
uniform highp vec3 _Ocean_CameraPos;
uniform highp mat4 _Ocean_OceanToCamera;
uniform highp mat4 _Ocean_CameraToOcean;
uniform highp vec3 sphereDir;
uniform highp float cosTheta;
uniform highp float sinTheta;
uniform highp mat4 _Globals_ScreenToCamera;
uniform highp mat4 _Globals_CameraToScreen;
uniform highp vec2 _Ocean_MapSize;
uniform highp vec4 _Ocean_Choppyness;
uniform highp vec4 _Ocean_GridSizes;
uniform highp vec2 _Ocean_ScreenGridSize;
uniform sampler2D _Ocean_Map0;
uniform sampler2D _Ocean_Map3;
uniform sampler2D _Ocean_Map4;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec3 dP_1;
  highp vec4 vert_2;
  vert_2.zw = _glesVertex.zw;
  vert_2.xy = (_glesVertex.xy * 1.25);
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 1.0);
  tmpvar_4.x = vert_2.x;
  tmpvar_4.y = vert_2.y;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize((_Globals_ScreenToCamera * tmpvar_4).xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = ((sphereDir.yzx * tmpvar_5.zxy) - (sphereDir.zxy * tmpvar_5.yzx));
  highp vec3 tmpvar_7;
  tmpvar_7 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_6.yzx * sphereDir.zxy) - (tmpvar_6.zxy * sphereDir.yzx)))));
  highp float tmpvar_8;
  tmpvar_8 = dot (tmpvar_6, ((tmpvar_7.yzx * tmpvar_5.zxy) - (tmpvar_7.zxy * tmpvar_5.yzx)));
  highp vec3 tmpvar_9;
  if (((tmpvar_8 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_9 = tmpvar_7;
  } else {
    tmpvar_9 = tmpvar_5;
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_9;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_Ocean_CameraToOcean * tmpvar_10).xyz;
  highp float tmpvar_12;
  tmpvar_12 = (tmpvar_11.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_13;
  tmpvar_13 = (-(tmpvar_12) - sqrt(max (((tmpvar_12 * tmpvar_12) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_14;
  tmpvar_14 = ((-(_Ocean_CameraPos.z) / tmpvar_11.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_11.z * tmpvar_11.z)))));
  highp float tmpvar_15;
  tmpvar_15 = abs(((tmpvar_14 - tmpvar_13) * tmpvar_11.z));
  highp float tmpvar_16;
  if ((tmpvar_15 < 1.0)) {
    tmpvar_16 = tmpvar_14;
  } else {
    tmpvar_16 = tmpvar_13;
  };
  tmpvar_3 = (_Ocean_CameraPos.xy + (tmpvar_16 * tmpvar_11.xy));
  highp vec4 tmpvar_17;
  tmpvar_17.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_17.x = _Ocean_ScreenGridSize.x;
  highp vec4 vert_18;
  vert_18 = (vert_2 + tmpvar_17);
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = vert_18.x;
  tmpvar_19.y = vert_18.y;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((_Globals_ScreenToCamera * tmpvar_19).xyz);
  highp vec3 tmpvar_21;
  tmpvar_21 = ((sphereDir.yzx * tmpvar_20.zxy) - (sphereDir.zxy * tmpvar_20.yzx));
  highp vec3 tmpvar_22;
  tmpvar_22 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_21.yzx * sphereDir.zxy) - (tmpvar_21.zxy * sphereDir.yzx)))));
  highp float tmpvar_23;
  tmpvar_23 = dot (tmpvar_21, ((tmpvar_22.yzx * tmpvar_20.zxy) - (tmpvar_22.zxy * tmpvar_20.yzx)));
  highp vec3 tmpvar_24;
  if (((tmpvar_23 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_24 = tmpvar_22;
  } else {
    tmpvar_24 = tmpvar_20;
  };
  highp vec4 tmpvar_25;
  tmpvar_25.w = 0.0;
  tmpvar_25.xyz = tmpvar_24;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_Ocean_CameraToOcean * tmpvar_25).xyz;
  highp float tmpvar_27;
  tmpvar_27 = (tmpvar_26.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_28;
  tmpvar_28 = (-(tmpvar_27) - sqrt(max (((tmpvar_27 * tmpvar_27) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_29;
  tmpvar_29 = ((-(_Ocean_CameraPos.z) / tmpvar_26.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_26.z * tmpvar_26.z)))));
  highp float tmpvar_30;
  tmpvar_30 = abs(((tmpvar_29 - tmpvar_28) * tmpvar_26.z));
  highp float tmpvar_31;
  if ((tmpvar_30 < 1.0)) {
    tmpvar_31 = tmpvar_29;
  } else {
    tmpvar_31 = tmpvar_28;
  };
  highp vec2 tmpvar_32;
  tmpvar_32 = ((_Ocean_CameraPos.xy + (tmpvar_31 * tmpvar_26.xy)) - tmpvar_3);
  highp vec4 tmpvar_33;
  tmpvar_33.xzw = vec3(0.0, 0.0, 0.0);
  tmpvar_33.y = _Ocean_ScreenGridSize.y;
  highp vec4 vert_34;
  vert_34 = (vert_2 + tmpvar_33);
  highp vec4 tmpvar_35;
  tmpvar_35.zw = vec2(0.0, 1.0);
  tmpvar_35.x = vert_34.x;
  tmpvar_35.y = vert_34.y;
  highp vec3 tmpvar_36;
  tmpvar_36 = normalize((_Globals_ScreenToCamera * tmpvar_35).xyz);
  highp vec3 tmpvar_37;
  tmpvar_37 = ((sphereDir.yzx * tmpvar_36.zxy) - (sphereDir.zxy * tmpvar_36.yzx));
  highp vec3 tmpvar_38;
  tmpvar_38 = ((cosTheta * sphereDir) + (sinTheta * normalize(((tmpvar_37.yzx * sphereDir.zxy) - (tmpvar_37.zxy * sphereDir.yzx)))));
  highp float tmpvar_39;
  tmpvar_39 = dot (tmpvar_37, ((tmpvar_38.yzx * tmpvar_36.zxy) - (tmpvar_38.zxy * tmpvar_36.yzx)));
  highp vec3 tmpvar_40;
  if (((tmpvar_39 > 0.0) && (_Ocean_CameraPos.z > 0.0))) {
    tmpvar_40 = tmpvar_38;
  } else {
    tmpvar_40 = tmpvar_36;
  };
  highp vec4 tmpvar_41;
  tmpvar_41.w = 0.0;
  tmpvar_41.xyz = tmpvar_40;
  highp vec3 tmpvar_42;
  tmpvar_42 = (_Ocean_CameraToOcean * tmpvar_41).xyz;
  highp float tmpvar_43;
  tmpvar_43 = (tmpvar_42.z * (_Ocean_CameraPos.z + _Ocean_Radius));
  highp float tmpvar_44;
  tmpvar_44 = (-(tmpvar_43) - sqrt(max (((tmpvar_43 * tmpvar_43) - (_Ocean_CameraPos.z * (_Ocean_CameraPos.z + (2.0 * _Ocean_Radius)))), 0.0)));
  highp float tmpvar_45;
  tmpvar_45 = ((-(_Ocean_CameraPos.z) / tmpvar_42.z) * (1.0 + ((_Ocean_CameraPos.z / (2.0 * _Ocean_Radius)) * (1.0 - (tmpvar_42.z * tmpvar_42.z)))));
  highp float tmpvar_46;
  tmpvar_46 = abs(((tmpvar_45 - tmpvar_44) * tmpvar_42.z));
  highp float tmpvar_47;
  if ((tmpvar_46 < 1.0)) {
    tmpvar_47 = tmpvar_45;
  } else {
    tmpvar_47 = tmpvar_44;
  };
  highp vec2 tmpvar_48;
  tmpvar_48 = ((_Ocean_CameraPos.xy + (tmpvar_47 * tmpvar_42.xy)) - tmpvar_3);
  highp vec3 tmpvar_49;
  tmpvar_49.xy = vec2(0.0, 0.0);
  tmpvar_49.z = _Ocean_HeightOffset;
  dP_1 = tmpvar_49;
  if (((tmpvar_48.x != 0.0) || (tmpvar_48.y != 0.0))) {
    highp vec4 tmpvar_50;
    highp vec2 tmpvar_51;
    tmpvar_51 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_52;
    tmpvar_52 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_53;
    tmpvar_53.z = 0.0;
    tmpvar_53.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_53.w = (0.5 * log2(max (dot (tmpvar_51, tmpvar_51), dot (tmpvar_52, tmpvar_52))));
    lowp vec4 tmpvar_54;
    tmpvar_54 = textureLod (_Ocean_Map0, tmpvar_53.xy, tmpvar_53.w);
    tmpvar_50 = tmpvar_54;
    dP_1.z = (_Ocean_HeightOffset + tmpvar_50.x);
    highp vec4 tmpvar_55;
    highp vec2 tmpvar_56;
    tmpvar_56 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_57;
    tmpvar_57 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_58;
    tmpvar_58.z = 0.0;
    tmpvar_58.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_58.w = (0.5 * log2(max (dot (tmpvar_56, tmpvar_56), dot (tmpvar_57, tmpvar_57))));
    lowp vec4 tmpvar_59;
    tmpvar_59 = textureLod (_Ocean_Map0, tmpvar_58.xy, tmpvar_58.w);
    tmpvar_55 = tmpvar_59;
    dP_1.z = (dP_1.z + tmpvar_55.y);
    highp vec4 tmpvar_60;
    highp vec2 tmpvar_61;
    tmpvar_61 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_62;
    tmpvar_62 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_63;
    tmpvar_63.z = 0.0;
    tmpvar_63.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_63.w = (0.5 * log2(max (dot (tmpvar_61, tmpvar_61), dot (tmpvar_62, tmpvar_62))));
    lowp vec4 tmpvar_64;
    tmpvar_64 = textureLod (_Ocean_Map0, tmpvar_63.xy, tmpvar_63.w);
    tmpvar_60 = tmpvar_64;
    dP_1.z = (dP_1.z + tmpvar_60.z);
    highp vec4 tmpvar_65;
    highp vec2 tmpvar_66;
    tmpvar_66 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_67;
    tmpvar_67 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_68;
    tmpvar_68.z = 0.0;
    tmpvar_68.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_68.w = (0.5 * log2(max (dot (tmpvar_66, tmpvar_66), dot (tmpvar_67, tmpvar_67))));
    lowp vec4 tmpvar_69;
    tmpvar_69 = textureLod (_Ocean_Map0, tmpvar_68.xy, tmpvar_68.w);
    tmpvar_65 = tmpvar_69;
    dP_1.z = (dP_1.z + tmpvar_65.w);
    highp vec4 tmpvar_70;
    highp vec2 tmpvar_71;
    tmpvar_71 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.x));
    highp vec2 tmpvar_72;
    tmpvar_72 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.x));
    highp vec4 tmpvar_73;
    tmpvar_73.z = 0.0;
    tmpvar_73.xy = (tmpvar_3 / _Ocean_GridSizes.x);
    tmpvar_73.w = (0.5 * log2(max (dot (tmpvar_71, tmpvar_71), dot (tmpvar_72, tmpvar_72))));
    lowp vec4 tmpvar_74;
    tmpvar_74 = textureLod (_Ocean_Map3, tmpvar_73.xy, tmpvar_73.w);
    tmpvar_70 = tmpvar_74;
    dP_1.xy = (_Ocean_Choppyness.x * tmpvar_70.xy);
    highp vec4 tmpvar_75;
    highp vec2 tmpvar_76;
    tmpvar_76 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.y));
    highp vec2 tmpvar_77;
    tmpvar_77 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.y));
    highp vec4 tmpvar_78;
    tmpvar_78.z = 0.0;
    tmpvar_78.xy = (tmpvar_3 / _Ocean_GridSizes.y);
    tmpvar_78.w = (0.5 * log2(max (dot (tmpvar_76, tmpvar_76), dot (tmpvar_77, tmpvar_77))));
    lowp vec4 tmpvar_79;
    tmpvar_79 = textureLod (_Ocean_Map3, tmpvar_78.xy, tmpvar_78.w);
    tmpvar_75 = tmpvar_79;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.y * tmpvar_75.zw));
    highp vec4 tmpvar_80;
    highp vec2 tmpvar_81;
    tmpvar_81 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.z));
    highp vec2 tmpvar_82;
    tmpvar_82 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.z));
    highp vec4 tmpvar_83;
    tmpvar_83.z = 0.0;
    tmpvar_83.xy = (tmpvar_3 / _Ocean_GridSizes.z);
    tmpvar_83.w = (0.5 * log2(max (dot (tmpvar_81, tmpvar_81), dot (tmpvar_82, tmpvar_82))));
    lowp vec4 tmpvar_84;
    tmpvar_84 = textureLod (_Ocean_Map4, tmpvar_83.xy, tmpvar_83.w);
    tmpvar_80 = tmpvar_84;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.z * tmpvar_80.xy));
    highp vec4 tmpvar_85;
    highp vec2 tmpvar_86;
    tmpvar_86 = (_Ocean_MapSize.x * (tmpvar_32 / _Ocean_GridSizes.w));
    highp vec2 tmpvar_87;
    tmpvar_87 = (_Ocean_MapSize.y * (tmpvar_48 / _Ocean_GridSizes.w));
    highp vec4 tmpvar_88;
    tmpvar_88.z = 0.0;
    tmpvar_88.xy = (tmpvar_3 / _Ocean_GridSizes.w);
    tmpvar_88.w = (0.5 * log2(max (dot (tmpvar_86, tmpvar_86), dot (tmpvar_87, tmpvar_87))));
    lowp vec4 tmpvar_89;
    tmpvar_89 = textureLod (_Ocean_Map4, tmpvar_88.xy, tmpvar_88.w);
    tmpvar_85 = tmpvar_89;
    dP_1.xy = (dP_1.xy + (_Ocean_Choppyness.w * tmpvar_85.zw));
  };
  mat3 tmpvar_90;
  tmpvar_90[0] = _Ocean_OceanToCamera[0].xyz;
  tmpvar_90[1] = _Ocean_OceanToCamera[1].xyz;
  tmpvar_90[2] = _Ocean_OceanToCamera[2].xyz;
  highp vec4 tmpvar_91;
  tmpvar_91.w = 1.0;
  tmpvar_91.xyz = ((tmpvar_16 * tmpvar_9) + (tmpvar_90 * dP_1));
  highp vec3 tmpvar_92;
  tmpvar_92.xy = vec2(0.0, 0.0);
  tmpvar_92.z = _Ocean_CameraPos.z;
  gl_Position = (_Globals_CameraToScreen * tmpvar_91);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = (((tmpvar_16 * tmpvar_11) + dP_1) + tmpvar_92);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Transmittance;
uniform sampler2D _Inscatter;
uniform sampler2D _Irradiance;
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
uniform highp float _Ocean_Radius;
uniform highp vec3 _Ocean_CameraPos;
uniform highp vec3 _Ocean_SunDir;
uniform highp vec3 _Ocean_Color;
uniform highp vec4 _Ocean_GridSizes;
uniform highp float _Ocean_WhiteCapStr;
uniform highp float farWhiteCapStr;
uniform lowp sampler3D _Ocean_Variance;
uniform sampler2D _Ocean_Map1;
uniform sampler2D _Ocean_Map2;
uniform sampler2D _Ocean_Foam0;
uniform sampler2D _Ocean_Foam1;
uniform highp float _OceanAlpha;
uniform highp float _GlobalOceanAlpha;
uniform highp float alphaRadius;
uniform highp vec2 _VarianceMax;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec2 jm4_1;
  highp vec2 jm3_2;
  highp vec2 jm2_3;
  highp vec2 jm1_4;
  highp vec3 skyE_5;
  highp vec3 sunL_6;
  highp float outWhiteCapStr_7;
  highp float outAlpha_8;
  highp vec3 tmpvar_9;
  tmpvar_9.xy = vec2(0.0, 0.0);
  tmpvar_9.z = (_Ocean_CameraPos.z + _Ocean_Radius);
  highp vec3 tmpvar_10;
  tmpvar_10.xy = vec2(0.0, 0.0);
  tmpvar_10.z = _Ocean_Radius;
  highp vec3 tmpvar_11;
  tmpvar_11 = (normalize((xlv_TEXCOORD1 + tmpvar_10)) * (_Ocean_Radius + 10.0));
  highp vec3 arg0_12;
  arg0_12 = (tmpvar_11 - tmpvar_9);
  highp float tmpvar_13;
  tmpvar_13 = clamp ((sqrt(dot (arg0_12, arg0_12)) / alphaRadius), 0.0, 1.0);
  outAlpha_8 = mix (_OceanAlpha, 1.0, tmpvar_13);
  outWhiteCapStr_7 = mix (_Ocean_WhiteCapStr, farWhiteCapStr, tmpvar_13);
  highp vec3 tmpvar_14;
  tmpvar_14.xy = vec2(0.0, 0.0);
  tmpvar_14.z = _Ocean_CameraPos.z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 - xlv_TEXCOORD1));
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  tmpvar_16 = texture (_Ocean_Map1, P_17);
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  tmpvar_18 = texture (_Ocean_Map1, P_19);
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  tmpvar_20 = texture (_Ocean_Map2, P_21);
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  tmpvar_22 = texture (_Ocean_Map2, P_23);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((((tmpvar_16.xy + tmpvar_18.zw) + tmpvar_20.xy) + tmpvar_22.zw) - (xlv_TEXCOORD1.xy / (_Ocean_Radius + xlv_TEXCOORD1.z)));
  highp vec3 tmpvar_25;
  tmpvar_25.z = 1.0;
  tmpvar_25.x = -(tmpvar_24.x);
  tmpvar_25.y = -(tmpvar_24.y);
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = dFdx(xlv_TEXCOORD0.x);
  highp float tmpvar_28;
  tmpvar_28 = dFdy(xlv_TEXCOORD0.x);
  highp float tmpvar_29;
  tmpvar_29 = dFdx(xlv_TEXCOORD0.y);
  highp float tmpvar_30;
  tmpvar_30 = dFdy(xlv_TEXCOORD0.y);
  highp float tmpvar_31;
  tmpvar_31 = ((tmpvar_27 * tmpvar_27) + (tmpvar_29 * tmpvar_29));
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_28 * tmpvar_28) + (tmpvar_30 * tmpvar_30));
  highp vec3 tmpvar_33;
  tmpvar_33.x = pow ((tmpvar_31 / 10.0), 0.25);
  tmpvar_33.y = (0.5 + ((0.5 * ((tmpvar_27 * tmpvar_28) + (tmpvar_29 * tmpvar_30))) / sqrt((tmpvar_31 * tmpvar_32))));
  tmpvar_33.z = pow ((tmpvar_32 / 10.0), 0.25);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture (_Ocean_Variance, tmpvar_33);
  highp vec2 tmpvar_35;
  tmpvar_35 = max ((tmpvar_34.xy * _VarianceMax), vec2(2e-05, 2e-05));
  highp vec3 worldP_36;
  worldP_36 = tmpvar_11;
  highp float r_37;
  highp float tmpvar_38;
  tmpvar_38 = sqrt(dot (tmpvar_11, tmpvar_11));
  r_37 = tmpvar_38;
  if ((tmpvar_38 < (0.9 * Rg))) {
    worldP_36.z = (tmpvar_11.z + Rg);
    r_37 = sqrt(dot (worldP_36, worldP_36));
  };
  highp vec3 tmpvar_39;
  tmpvar_39 = (worldP_36 / r_37);
  highp float tmpvar_40;
  tmpvar_40 = dot (tmpvar_39, _Ocean_SunDir);
  highp float tmpvar_41;
  tmpvar_41 = sqrt((1.0 - ((Rg / r_37) * (Rg / r_37))));
  highp vec3 tmpvar_42;
  if ((tmpvar_40 < -(tmpvar_41))) {
    tmpvar_42 = vec3(0.0, 0.0, 0.0);
  } else {
    highp vec3 tmpvar_43;
    highp float y_over_x_44;
    y_over_x_44 = (((tmpvar_40 + 0.15) / 1.15) * 14.1014);
    highp float x_45;
    x_45 = (y_over_x_44 * inversesqrt(((y_over_x_44 * y_over_x_44) + 1.0)));
    highp vec4 tmpvar_46;
    tmpvar_46.zw = vec2(0.0, 0.0);
    tmpvar_46.x = ((sign(x_45) * (1.5708 - (sqrt((1.0 - abs(x_45))) * (1.5708 + (abs(x_45) * (-0.214602 + (abs(x_45) * (0.0865667 + (abs(x_45) * -0.0310296))))))))) / 1.5);
    tmpvar_46.y = sqrt(((r_37 - Rg) / (Rt - Rg)));
    lowp vec4 tmpvar_47;
    tmpvar_47 = textureLod (_Transmittance, tmpvar_46.xy, 0.0);
    tmpvar_43 = tmpvar_47.xyz;
    tmpvar_42 = tmpvar_43;
  };
  highp vec3 tmpvar_48;
  highp vec2 tmpvar_49;
  tmpvar_49.x = ((tmpvar_40 + 0.2) / 1.2);
  tmpvar_49.y = ((r_37 - Rg) / (Rt - Rg));
  lowp vec4 tmpvar_50;
  tmpvar_50 = textureLod (_Irradiance, tmpvar_49, 0.0);
  tmpvar_48 = tmpvar_50.xyz;
  sunL_6 = (tmpvar_42 * _Sun_Intensity);
  skyE_5 = ((2.0 * (tmpvar_48 * _Sun_Intensity)) * ((1.0 + dot (tmpvar_39, tmpvar_26)) * 0.5));
  highp vec3 tmpvar_51;
  highp vec3 i_52;
  i_52 = -(tmpvar_15);
  tmpvar_51 = (i_52 - (2.0 * (dot (tmpvar_26, i_52) * tmpvar_26)));
  highp vec3 tmpvar_53;
  tmpvar_53.x = tmpvar_51.x;
  tmpvar_53.y = tmpvar_51.y;
  tmpvar_53.z = max (tmpvar_51.z, 0.0);
  highp vec3 camera_54;
  camera_54 = tmpvar_11;
  highp vec3 viewdir_55;
  viewdir_55.yz = tmpvar_53.yz;
  highp float rMu_56;
  highp float r_57;
  highp vec3 result_58;
  result_58 = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_59;
  tmpvar_59 = (Rg + ((Rt - Rg) * _experimentalAtmoScale));
  viewdir_55.x = (tmpvar_51.x + _viewdirOffset);
  highp vec3 tmpvar_60;
  tmpvar_60 = normalize(viewdir_55);
  viewdir_55 = tmpvar_60;
  highp float tmpvar_61;
  tmpvar_61 = sqrt(dot (tmpvar_11, tmpvar_11));
  r_57 = tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = dot (tmpvar_11, tmpvar_60);
  rMu_56 = tmpvar_62;
  highp float f_63;
  f_63 = (((tmpvar_62 * tmpvar_62) - (tmpvar_61 * tmpvar_61)) + (tmpvar_59 * tmpvar_59));
  highp float tmpvar_64;
  if ((f_63 >= 0.0)) {
    tmpvar_64 = sqrt(f_63);
  } else {
    tmpvar_64 = 1e-06;
  };
  highp float tmpvar_65;
  tmpvar_65 = max ((-(tmpvar_62) - tmpvar_64), 0.0);
  if ((tmpvar_65 > 0.0)) {
    camera_54 = (tmpvar_11 + (tmpvar_65 * tmpvar_60));
    rMu_56 = (tmpvar_62 + tmpvar_65);
    r_57 = tmpvar_59;
  };
  highp float tmpvar_66;
  tmpvar_66 = dot (tmpvar_60, _Ocean_SunDir);
  highp float tmpvar_67;
  tmpvar_67 = (dot (camera_54, _Ocean_SunDir) / r_57);
  highp vec4 tmpvar_68;
  highp float uMu_69;
  highp float uR_70;
  highp float tmpvar_71;
  tmpvar_71 = sqrt(((tmpvar_59 * tmpvar_59) - (Rg * Rg)));
  highp float tmpvar_72;
  tmpvar_72 = sqrt(((r_57 * r_57) - (Rg * Rg)));
  highp float tmpvar_73;
  tmpvar_73 = (r_57 * (rMu_56 / r_57));
  highp float tmpvar_74;
  tmpvar_74 = (((tmpvar_73 * tmpvar_73) - (r_57 * r_57)) + (Rg * Rg));
  highp vec4 tmpvar_75;
  if (((tmpvar_73 < 0.0) && (tmpvar_74 > 0.0))) {
    highp vec4 tmpvar_76;
    tmpvar_76.xyz = vec3(1.0, 0.0, 0.0);
    tmpvar_76.w = (0.5 - (0.5 / RES_MU));
    tmpvar_75 = tmpvar_76;
  } else {
    highp vec4 tmpvar_77;
    tmpvar_77.x = -1.0;
    tmpvar_77.y = (tmpvar_71 * tmpvar_71);
    tmpvar_77.z = tmpvar_71;
    tmpvar_77.w = (0.5 + (0.5 / RES_MU));
    tmpvar_75 = tmpvar_77;
  };
  uR_70 = ((0.5 / RES_R) + ((tmpvar_72 / tmpvar_71) * (1.0 - (1.0/(RES_R)))));
  uMu_69 = (tmpvar_75.w + ((((tmpvar_73 * tmpvar_75.x) + sqrt((tmpvar_74 + tmpvar_75.y))) / (tmpvar_72 + tmpvar_75.z)) * (0.5 - (1.0/(RES_MU)))));
  highp float y_over_x_78;
  y_over_x_78 = (max (tmpvar_67, -0.1975) * 5.34962);
  highp float x_79;
  x_79 = (y_over_x_78 * inversesqrt(((y_over_x_78 * y_over_x_78) + 1.0)));
  highp float tmpvar_80;
  tmpvar_80 = ((0.5 / RES_MU_S) + (((((sign(x_79) * (1.5708 - (sqrt((1.0 - abs(x_79))) * (1.5708 + (abs(x_79) * (-0.214602 + (abs(x_79) * (0.0865667 + (abs(x_79) * -0.0310296))))))))) / 1.1) + 0.74) * 0.5) * (1.0 - (1.0/(RES_MU_S)))));
  highp float tmpvar_81;
  tmpvar_81 = (((tmpvar_66 + 1.0) / 2.0) * (RES_NU - 1.0));
  highp float tmpvar_82;
  tmpvar_82 = floor(tmpvar_81);
  highp float tmpvar_83;
  tmpvar_83 = (tmpvar_81 - tmpvar_82);
  highp float tmpvar_84;
  tmpvar_84 = (floor(((uR_70 * RES_R) - 1.0)) / RES_R);
  highp float tmpvar_85;
  tmpvar_85 = (floor((uR_70 * RES_R)) / RES_R);
  highp float tmpvar_86;
  tmpvar_86 = fract((uR_70 * RES_R));
  highp vec4 tmpvar_87;
  tmpvar_87.zw = vec2(0.0, 0.0);
  tmpvar_87.x = ((tmpvar_82 + tmpvar_80) / RES_NU);
  tmpvar_87.y = ((uMu_69 / RES_R) + tmpvar_84);
  lowp vec4 tmpvar_88;
  tmpvar_88 = textureLod (_Inscatter, tmpvar_87.xy, 0.0);
  highp vec4 tmpvar_89;
  tmpvar_89.zw = vec2(0.0, 0.0);
  tmpvar_89.x = (((tmpvar_82 + tmpvar_80) + 1.0) / RES_NU);
  tmpvar_89.y = ((uMu_69 / RES_R) + tmpvar_84);
  lowp vec4 tmpvar_90;
  tmpvar_90 = textureLod (_Inscatter, tmpvar_89.xy, 0.0);
  highp vec4 tmpvar_91;
  tmpvar_91.zw = vec2(0.0, 0.0);
  tmpvar_91.x = ((tmpvar_82 + tmpvar_80) / RES_NU);
  tmpvar_91.y = ((uMu_69 / RES_R) + tmpvar_85);
  lowp vec4 tmpvar_92;
  tmpvar_92 = textureLod (_Inscatter, tmpvar_91.xy, 0.0);
  highp vec4 tmpvar_93;
  tmpvar_93.zw = vec2(0.0, 0.0);
  tmpvar_93.x = (((tmpvar_82 + tmpvar_80) + 1.0) / RES_NU);
  tmpvar_93.y = ((uMu_69 / RES_R) + tmpvar_85);
  lowp vec4 tmpvar_94;
  tmpvar_94 = textureLod (_Inscatter, tmpvar_93.xy, 0.0);
  tmpvar_68 = ((((tmpvar_88 * (1.0 - tmpvar_83)) + (tmpvar_90 * tmpvar_83)) * (1.0 - tmpvar_86)) + (((tmpvar_92 * (1.0 - tmpvar_83)) + (tmpvar_94 * tmpvar_83)) * tmpvar_86));
  if ((r_57 <= tmpvar_59)) {
    result_58 = ((tmpvar_68.xyz * ((3.0 / (16.0 * M_PI)) * (1.0 + (tmpvar_66 * tmpvar_66)))) + ((((tmpvar_68.xyz * tmpvar_68.w) / max (tmpvar_68.x, 0.0001)) * (betaR.x / betaR)) * (((((1.5 / (4.0 * M_PI)) * (1.0 - (mieG * mieG))) * pow (((1.0 + (mieG * mieG)) - ((2.0 * mieG) * tmpvar_66)), -1.5)) * (1.0 + (tmpvar_66 * tmpvar_66))) / (2.0 + (mieG * mieG)))));
  } else {
    result_58 = vec3(0.0, 0.0, 0.0);
  };
  highp float tmpvar_95;
  tmpvar_95 = sqrt(tmpvar_35.x);
  highp vec3 tmpvar_96;
  tmpvar_96 = ((result_58 * _Sun_Intensity) * (pow ((1.0 - dot (tmpvar_15, tmpvar_26)), (5.0 * exp((-2.69 * tmpvar_95)))) / (1.0 + (22.7 * pow (tmpvar_95, 1.5)))));
  highp vec3 tmpvar_97;
  tmpvar_97 = normalize((_Ocean_SunDir + tmpvar_15));
  highp float tmpvar_98;
  tmpvar_98 = dot (tmpvar_97, tmpvar_26);
  highp float tmpvar_99;
  tmpvar_99 = (exp(((-2.0 * ((1.0 - (tmpvar_98 * tmpvar_98)) / tmpvar_35.x)) / (1.0 + tmpvar_98))) / (12.5664 * tmpvar_35.x));
  highp float tmpvar_100;
  tmpvar_100 = (1.0 - dot (tmpvar_15, tmpvar_97));
  highp float tmpvar_101;
  tmpvar_101 = (tmpvar_100 * tmpvar_100);
  highp float tmpvar_102;
  tmpvar_102 = (0.02 + (((0.98 * tmpvar_101) * tmpvar_101) * tmpvar_100));
  highp float tmpvar_103;
  tmpvar_103 = max (dot (_Ocean_SunDir, tmpvar_26), 0.01);
  highp float tmpvar_104;
  tmpvar_104 = max (dot (tmpvar_15, tmpvar_26), 0.01);
  highp float tmpvar_105;
  if ((tmpvar_103 <= 0.0)) {
    tmpvar_105 = 0.0;
  } else {
    tmpvar_105 = max (((tmpvar_102 * tmpvar_99) * sqrt(abs((tmpvar_103 / tmpvar_104)))), 0.0);
  };
  highp float tmpvar_106;
  tmpvar_106 = sqrt(tmpvar_35.x);
  highp vec2 P_107;
  P_107 = (xlv_TEXCOORD0 / _Ocean_GridSizes.x);
  lowp vec2 tmpvar_108;
  tmpvar_108 = texture (_Ocean_Foam0, P_107).xy;
  jm1_4 = tmpvar_108;
  highp vec2 P_109;
  P_109 = (xlv_TEXCOORD0 / _Ocean_GridSizes.y);
  lowp vec2 tmpvar_110;
  tmpvar_110 = texture (_Ocean_Foam0, P_109).zw;
  jm2_3 = tmpvar_110;
  highp vec2 P_111;
  P_111 = (xlv_TEXCOORD0 / _Ocean_GridSizes.z);
  lowp vec2 tmpvar_112;
  tmpvar_112 = texture (_Ocean_Foam1, P_111).xy;
  jm3_2 = tmpvar_112;
  highp vec2 P_113;
  P_113 = (xlv_TEXCOORD0 / _Ocean_GridSizes.w);
  lowp vec2 tmpvar_114;
  tmpvar_114 = texture (_Ocean_Foam1, P_113).zw;
  jm4_1 = tmpvar_114;
  highp vec2 tmpvar_115;
  tmpvar_115 = (((jm1_4 + jm2_3) + jm3_2) + jm4_1);
  highp float x_116;
  x_116 = ((0.707107 * (outWhiteCapStr_7 - tmpvar_115.x)) * inversesqrt(max ((tmpvar_115.y - ((((jm1_4.x * jm1_4.x) + (jm2_3.x * jm2_3.x)) + (jm3_2.x * jm3_2.x)) + (jm4_1.x * jm4_1.x))), 0.0)));
  highp float tmpvar_117;
  tmpvar_117 = (x_116 * x_116);
  highp float tmpvar_118;
  tmpvar_118 = (0.140012 * tmpvar_117);
  highp vec3 L_119;
  highp vec3 tmpvar_120;
  tmpvar_120 = (((((tmpvar_105 * sunL_6) + tmpvar_96) + ((((0.98 * (1.0 - (pow ((1.0 - dot (tmpvar_15, tmpvar_26)), (5.0 * exp((-2.69 * tmpvar_106)))) / (1.0 + (22.7 * pow (tmpvar_106, 1.5)))))) * _Ocean_Color) * skyE_5) / 3.14159)) + ((((0.5 * (sign(x_116) * sqrt((1.0 - exp(((-(tmpvar_117) * (1.27324 + tmpvar_118)) / (1.0 + tmpvar_118))))))) + 0.5) * (((sunL_6 * max (dot (tmpvar_26, _Ocean_SunDir), 0.0)) + skyE_5) / 3.14159)) * 0.4)) * _Exposure);
  L_119 = tmpvar_120;
  highp float tmpvar_121;
  if ((tmpvar_120.x < 1.413)) {
    tmpvar_121 = pow ((tmpvar_120.x * 0.38317), 0.454545);
  } else {
    tmpvar_121 = (1.0 - exp(-(tmpvar_120.x)));
  };
  L_119.x = tmpvar_121;
  highp float tmpvar_122;
  if ((tmpvar_120.y < 1.413)) {
    tmpvar_122 = pow ((tmpvar_120.y * 0.38317), 0.454545);
  } else {
    tmpvar_122 = (1.0 - exp(-(tmpvar_120.y)));
  };
  L_119.y = tmpvar_122;
  highp float tmpvar_123;
  if ((tmpvar_120.z < 1.413)) {
    tmpvar_123 = pow ((tmpvar_120.z * 0.38317), 0.454545);
  } else {
    tmpvar_123 = (1.0 - exp(-(tmpvar_120.z)));
  };
  L_119.z = tmpvar_123;
  highp vec4 tmpvar_124;
  tmpvar_124.xyz = L_119;
  tmpvar_124.w = (outAlpha_8 * _GlobalOceanAlpha);
  _glesFragData[0] = tmpvar_124;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 272 math, 13 textures
Keywords { "SKY_REFLECTIONS_OFF" }
Float 0 [_Exposure]
Float 1 [Rg]
Float 2 [Rt]
Float 3 [_Sun_Intensity]
Float 4 [_Ocean_Radius]
Vector 5 [_Ocean_CameraPos]
Vector 6 [_Ocean_SunDir]
Vector 7 [_Ocean_Color]
Vector 8 [_Ocean_GridSizes]
Float 9 [_Ocean_WhiteCapStr]
Float 10 [farWhiteCapStr]
Float 11 [_OceanAlpha]
Float 12 [_GlobalOceanAlpha]
Float 13 [alphaRadius]
Vector 14 [_VarianceMax]
SetTexture 0 [_Ocean_Map1] 2D 0
SetTexture 1 [_Ocean_Map2] 2D 1
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Transmittance] 2D 3
SetTexture 4 [_Irradiance] 2D 4
SetTexture 5 [_Ocean_Foam0] 2D 5
SetTexture 6 [_Ocean_Foam1] 2D 6
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_volume s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c15, 0.00000000, 10.00000000, 0.89999998, 0.15000001
def c16, 12.26193905, -1.00000000, -0.01348047, 0.05747731
def c17, -0.12123910, 0.19563590, -0.33299461, 0.99999559
def c18, 1.57079601, 0.66666669, 0.20000000, 0.83333331
def c19, 0.50000000, 2.00000000, 0.70710677, 2.71828198
def c20, 0.00000000, 1.00000000, 0.14001200, 1.27323949
def c21, 0.10000000, 0.25000000, 0.00002000, -2.69000006
def c22, 5.00000000, 1.50000000, 22.70000076, 1.00000000
def c23, 0.01000000, 0.98000002, 0.02000000, -2.00000000
def c24, 12.56637096, 0.31830987, 0.31194368, 0.12732396
def c25, -1.41299999, 0.38317001, 0.45454544, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
mov r1.x, c4
dsx r4.z, v0.y
dsx r4.y, v0.x
add r1.x, c15.y, r1
mov r0.z, c4.x
mov r0.xy, c15.x
add r0.xyz, v1, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r0.xyz, r0.w, r0
mul r2.xyz, r0, r1.x
dp3 r0.x, r2, r2
rsq r0.x, r0.x
rcp r0.y, r0.x
mov r0.x, c1
mov r1.xy, r2
mad r0.x, c15.z, -r0, r0.y
add r0.z, r2, c1.x
cmp r1.z, r0.x, r2, r0
dp3 r0.z, r1, r1
rsq r0.z, r0.z
rcp r0.z, r0.z
cmp r0.y, r0.x, r0, r0.z
rcp r3.w, r0.y
mul r3.xyz, r1, r3.w
dp3 r2.w, r3, c6
add r0.x, r2.w, c15.w
mul r0.x, r0, c16
abs r0.z, r0.x
max r0.w, r0.z, c20.y
rcp r1.x, r0.w
min r0.w, r0.z, c20.y
mul r0.w, r0, r1.x
mul r1.x, r0.w, r0.w
mad r1.y, r1.x, c16.z, c16.w
mad r1.y, r1, r1.x, c17.x
mad r1.y, r1, r1.x, c17
mad r1.y, r1, r1.x, c17.z
mad r1.x, r1.y, r1, c17.w
mul r0.w, r1.x, r0
mul r1.y, r4.z, r4.z
mad r4.w, r4.y, r4.y, r1.y
add r1.x, -r0.w, c18
add r0.z, r0, c16.y
cmp r0.z, -r0, r0.w, r1.x
cmp r0.x, r0, r0.z, -r0.z
mul r0.w, r4, c21.x
pow r1, r0.w, c21.y
dsy r0.w, v0.y
mov r4.x, r1
dsy r0.z, v0.x
mul r1.y, r4.z, r0.w
mul r1.x, r0.w, r0.w
mad r1.x, r0.z, r0.z, r1
mul r0.w, r4, r1.x
mad r1.y, r4, r0.z, r1
rsq r0.z, r0.w
mul r0.z, r0, r1.y
mul r0.w, r1.x, c21.x
pow r1, r0.w, c21.y
mov r4.z, r1
mad r4.y, r0.z, c19.x, c19.x
rcp r0.w, c8.y
rcp r1.z, c8.z
mul r9.xy, v0, r1.z
rcp r1.z, c8.w
mul r10.xy, v0, r1.z
texld r1.x, r4, s2
mul r8.xy, v0, r0.w
mul r0.x, r0, c18.y
add r1.z, v1, c4.x
add r0.y, r0, -c1.x
mov r5.z, c5
mov r5.xy, c15.x
add r5.xyz, -v1, r5
dp3 r0.z, r5, r5
rsq r0.z, r0.z
mul r5.xyz, r0.z, r5
add r4.xyz, r5, c6
mul r0.z, r1.x, c14.x
max r1.w, r0.z, c21.z
rcp r0.z, c8.x
mul r7.xy, v0, r0.z
dp3 r4.w, r4, r4
texld r1.xy, r7, s0
texld r0.zw, r8, s0
add r0.zw, r1.xyxy, r0
texld r1.xy, r9, s1
add r1.xy, r0.zwzw, r1
texld r0.zw, r10, s1
add r0.zw, r1.xyxy, r0
rcp r1.x, r1.z
mad r0.zw, -v1.xyxy, r1.x, r0
mov r1.xy, -r0.zwzw
mov r1.z, c20.y
dp3 r0.z, r1, r1
rsq r0.w, r4.w
mul r6.xyz, r0.w, r4
rsq r0.z, r0.z
mul r4.xyz, r0.z, r1
dp3 r0.z, r4, r6
rcp r1.x, r1.w
mad r0.w, -r0.z, r0.z, c20.y
mul r0.w, r0, r1.x
add r1.x, r0.z, c20.y
rcp r1.x, r1.x
mul r0.w, r0, r1.x
mov r0.z, c2.x
add r0.z, -c1.x, r0
rcp r0.z, r0.z
mul r7.zw, r0.y, r0.z
rsq r0.y, r7.z
mul r4.w, r0, c23
mov r0.z, c15.x
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s3
pow r0, c19.w, r4.w
dp3 r0.y, r5, r6
mul r0.w, r1, c24.x
dp3 r4.w, r4, r5
add r0.y, -r0, c20
mov r0.z, r0.x
mul r0.x, r0.y, r0.y
mul r0.x, r0, r0
mul r0.x, r0, r0.y
rcp r0.w, r0.w
mul r0.y, r0.z, r0.w
dp3 r0.w, r4, c6
max r5.x, r0.w, c23
mad r0.x, r0, c23.y, c23.z
mul r0.x, r0, r0.y
max r0.y, r4.w, c23.x
rcp r0.y, r0.y
mul r0.z, r5.x, r0.y
mul r0.y, r3.w, c1.x
abs r0.z, r0
mad r0.y, -r0, r0, c20
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r0.y, r0.y
mul r3.w, r0.x, r0.z
rcp r0.y, r0.y
add r0.x, r2.w, r0.y
cmp r0.xyz, r0.x, r1, c15.x
max r1.x, r3.w, c15
cmp r3.w, -r5.x, c15.x, r1.x
dp3 r1.x, r3, r4
rsq r1.y, r1.w
rcp r4.x, r1.y
add r1.x, r1, c20.y
mul r3.x, r4, c21.w
mul r4.y, r1.x, c19.x
pow r1, c19.w, r3.x
add r1.y, r2.w, c18.z
mul r4.z, r1.x, c22.x
add r2.w, -r4, c20.y
mul r3.x, r1.y, c18.w
pow r1, r2.w, r4.z
mov r2.w, r1.x
pow r1, r4.x, c22.y
mov r1.y, c5.z
add r4.z, c4.x, r1.y
mov r1.y, r1.x
texld r1.zw, r8, s5
mul r0.xyz, r0, c3.x
max r0.w, r0, c15.x
mov r3.z, c15.x
mov r3.y, r7.w
texldl r3.xyz, r3.xyzz, s4
mul r3.xyz, r3, c3.x
mul r3.xyz, r3, r4.y
mov r4.xy, c15.x
add r2.xyz, r2, -r4
dp3 r1.x, r2, r2
mad r2.z, r1.y, c22, c22.w
texld r2.xy, r7, s5
rsq r1.x, r1.x
mul r3.xyz, r3, c19.y
add r4.zw, r2.xyxy, r1
rcp r1.y, c13.x
rcp r1.x, r1.x
mul_sat r4.x, r1, r1.y
texld r1.xy, r9, s6
add r4.zw, r4, r1.xyxy
mul r1.y, r1.z, r1.z
mad r1.y, r2.x, r2.x, r1
texld r1.zw, r10, s6
mad r1.x, r1, r1, r1.y
add r2.xy, r4.zwzw, r1.zwzw
mad r1.x, r1.z, r1.z, r1
add r1.x, r2.y, -r1
mov r1.y, c10.x
add r1.y, -c9.x, r1
mad r1.y, r4.x, r1, c9.x
max r1.x, r1, c15
add r1.y, r1, -r2.x
rsq r1.x, r1.x
mul r1.x, r1, r1.y
mul r4.y, r1.x, c19.z
mul r1.w, r4.y, r4.y
rcp r4.w, r2.z
mul r1.x, r2.w, r4.w
mad r2.y, r1.w, c20.z, c20
mad r2.x, r1.w, c20.z, c20.w
mul r1.w, -r1, r2.x
rcp r2.y, r2.y
mul r1.xyz, r3, r1.x
mul r4.z, r1.w, r2.y
mul r2.xyz, r1, c24.y
mad r2.xyz, r0, r3.w, r2
pow r1, c19.w, r4.z
mov r1.w, r1.x
mad r1.y, -r2.w, r4.w, c20
mul r1.xyz, r1.y, c7
mul r1.xyz, r3, r1
mad r1.xyz, r1, c24.z, r2
add r1.w, -r1, c20.y
rsq r1.w, r1.w
rcp r2.y, r1.w
mad r0.xyz, r0, r0.w, r3
cmp r2.x, r4.y, c20, c20.y
cmp r1.w, -r4.y, c20.x, c20.y
add r1.w, r1, -r2.x
mul r1.w, r1, r2.y
mad r1.w, r1, c19.x, c19.x
mul r0.xyz, r0, r1.w
mad r0.xyz, r0, c24.w, r1
mul r3.xyz, r0, c0.x
pow r0, c19.w, -r3.x
mul r2.y, r3.x, c25
pow r1, r2.y, c25.z
mov r0.y, r1.x
add r2.x, r3, c25
add r0.x, -r0, c20.y
cmp oC0.x, r2, r0, r0.y
pow r0, c19.w, -r3.z
mul r0.z, r3.y, c25.y
pow r1, r0.z, c25.z
mov r0.w, r1.x
pow r2, c19.w, -r3.y
mov r0.z, r2.x
add r0.y, r3, c25.x
add r0.z, -r0, c20.y
add r1.y, -r0.x, c20
cmp oC0.y, r0, r0.z, r0.w
mul r1.z, r3, c25.y
pow r0, r1.z, c25.z
mov r0.y, c11.x
add r1.x, r3.z, c25
add r0.y, c20, -r0
mad r0.y, r4.x, r0, c11.x
cmp oC0.z, r1.x, r1.y, r0.x
mul oC0.w, r0.y, c12.x
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
ConstBuffer "$Globals" 912
Float 112 [_Exposure]
Float 116 [Rg]
Float 120 [Rt]
Float 160 [_Sun_Intensity]
Float 172 [_Ocean_Radius]
Vector 180 [_Ocean_CameraPos] 3
Vector 816 [_Ocean_SunDir] 3
Vector 832 [_Ocean_Color] 3
Vector 848 [_Ocean_GridSizes]
Float 872 [_Ocean_WhiteCapStr]
Float 876 [farWhiteCapStr]
Float 880 [_OceanAlpha]
Float 884 [_GlobalOceanAlpha]
Float 888 [alphaRadius]
Vector 896 [_VarianceMax] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedogddnnabfoobnekojdacnemdpdmiflciabaaaaaaamblaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdebkaaaaeaaaaaaainagaaaa
fjaaaaaeegiocaaaaaaaaaaadjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafkaaaaadaagabaaa
agaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaaficiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaa
ffffaaaafibiaaaeaahabaaaagaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaiaaaaaa
dgaaaaafbcaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaagecaabaaaaaaaaaaa
dkiacaaaaaaaaaaaalaaaaaaaaaaaaaihcaabaaaaaaaaaaaagacbaaaaaaaaaaa
egbcbaiaebaaaaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaak
hcaabaaaabaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaaegiccaaaaaaaaaaa
ddaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
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
abaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaadiaaaaaadeaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaakmmfkhdhdiaaaaahbcaabaaaacaaaaaa
dkaabaaaabaaaaaaabeaaaaanlapejebaoaaaaaipcaabaaaadaaaaaaegbebaaa
abaaaaaaagifcaaaaaaaaaaadfaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaaaaaaaaahgcaabaaa
acaaaaaaagabbaaaaeaaaaaakgalbaaaafaaaaaaaoaaaaaipcaabaaaaeaaaaaa
egbebaaaabaaaaaakgipcaaaaaaaaaaadfaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahgcaabaaa
acaaaaaafgagbaaaacaaaaaaagabbaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaaaaaaaaahgcaabaaa
acaaaaaafgagbaaaacaaaaaakgalbaaaafaaaaaadgaaaaafbcaabaaaafaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaafaaaaaadkiacaaaaaaaaaaaakaaaaaa
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
ddaaaaaajgahbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaakgakbaaaaaaaaaaa
aceaaaaaaknhcddmaaaaaaaaaaaaaaaaaaaaaaaaaoaaaaahccaabaaaaaaaaaaa
akaabaaaabaaaaaabkaabaaaaaaaaaaaelaaaaafccaabaaaaaaaaaaabkaabaaa
aaaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaadkaabaaaaaaaaaaa
deaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaadiaaaaahhcaabaaaafaaaaaakgakbaaaaaaaaaaa
egacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaadkiacaaaaaaaaaaaakaaaaaa
abeaaaaaaaaacaebdcaaaaakccaabaaaagaaaaaackaabaaaafaaaaaackaabaaa
aaaaaaaabkiacaaaaaaaaaaaahaaaaaadiaaaaahncaabaaaagaaaaaakgakbaaa
aaaaaaaakgaebaaaafaaaaaabaaaaaahicaabaaaaaaaaaaajgahbaaaagaaaaaa
jgahbaaaagaaaaaadgaaaaaffcaabaaaahaaaaaafgaebaaaagaaaaaaelaaaaaf
ccaabaaaahaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaigadbaaa
agaaaaaaigadbaaaagaaaaaaelaaaaaficaabaaaahaaaaaadkaabaaaaaaaaaaa
diaaaaaiicaabaaaaaaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaggggggdp
dbaaaaahicaabaaaaaaaaaaadkaabaaaahaaaaaadkaabaaaaaaaaaaadhaaaaaj
dcaabaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaahaaaaaaogakbaaaahaaaaaa
aoaaaaahncaabaaaagaaaaaakgadbaaaagaaaaaafgafbaaaagaaaaaabaaaaaai
icaabaaaaaaaaaaaigadbaaaagaaaaaaegiccaaaaaaaaaaaddaaaaaabaaaaaah
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
agaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaaaoaaaaaibcaabaaaacaaaaaa
bkiacaaaaaaaaaaaahaaaaaabkaabaaaagaaaaaadcaaaaakbcaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaiadpelaaaaaf
bcaabaaaacaaaaaaakaabaaaacaaaaaadbaaaaaiicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaiaebaaaaaaacaaaaaaaaaaaaakbcaabaaaacaaaaaabkiacaia
ebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaaahaaaaaaaoaaaaahecaabaaa
acaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaaelaaaaafccaabaaaahaaaaaa
ckaabaaaacaaaaaaeiaaaaalpcaabaaaacaaaaaajgafbaaaacaaaaaaeghobaaa
aeaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaagiacaaaaaaaaaaaakaaaaaadiaaaaahhcaabaaaacaaaaaa
agaabaaaabaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaaahaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaa
agaaaaaaegacbaaaagaaaaaaagiacaaaaaaaaaaaakaaaaaadhaaaaamhcaabaaa
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
diaaaaaihcaabaaaahaaaaaaagaabaaaaaaaaaaaegiccaaaaaaaaaaadeaaaaaa
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
aaaaaaajecaabaaaadaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaa
alaaaaaadgaaaaaidcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadcaaaaakhcaabaaaadaaaaaaegacbaaaafaaaaaakgakbaaaaaaaaaaa
egacbaiaebaaaaaaadaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaaelaaaaafecaabaaaaaaaaaaackaabaaaaaaaaaaaaocaaaai
ecaabaaaaaaaaaaackaabaaaaaaaaaaackiacaaaaaaaaaaadhaaaaaaaaaaaaak
ecaabaaaabaaaaaackiacaiaebaaaaaaaaaaaaaadgaaaaaadkiacaaaaaaaaaaa
dgaaaaaadcaaaaakecaabaaaabaaaaaackaabaaaaaaaaaaackaabaaaabaaaaaa
ckiacaaaaaaaaaaadgaaaaaaaaaaaaaiccaabaaaabaaaaaabkaabaiaebaaaaaa
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
egambaaaaaaaaaaaagiacaaaaaaaaaaaahaaaaaadiaaaaakpcaabaaaabaaaaaa
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
bcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaadhaaaaaaabeaaaaaaaaaiadp
dcaaaaakbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaakiacaaa
aaaaaaaadhaaaaaadiaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaa
aaaaaaaadhaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 436 math, 21 textures
Keywords { "SKY_REFLECTIONS_ON" }
Float 0 [M_PI]
Vector 1 [betaR]
Float 2 [mieG]
Float 3 [_Exposure]
Float 4 [Rg]
Float 5 [Rt]
Float 6 [RES_R]
Float 7 [RES_MU]
Float 8 [RES_MU_S]
Float 9 [RES_NU]
Float 10 [_Sun_Intensity]
Float 11 [_experimentalAtmoScale]
Float 12 [_viewdirOffset]
Float 13 [_Ocean_Radius]
Vector 14 [_Ocean_CameraPos]
Vector 15 [_Ocean_SunDir]
Vector 16 [_Ocean_Color]
Vector 17 [_Ocean_GridSizes]
Float 18 [_Ocean_WhiteCapStr]
Float 19 [farWhiteCapStr]
Float 20 [_OceanAlpha]
Float 21 [_GlobalOceanAlpha]
Float 22 [alphaRadius]
Vector 23 [_VarianceMax]
SetTexture 0 [_Ocean_Map1] 2D 0
SetTexture 1 [_Ocean_Map2] 2D 1
SetTexture 2 [_Ocean_Variance] 3D 2
SetTexture 3 [_Transmittance] 2D 3
SetTexture 4 [_Irradiance] 2D 4
SetTexture 5 [_Inscatter] 2D 5
SetTexture 6 [_Ocean_Foam0] 2D 6
SetTexture 7 [_Ocean_Foam1] 2D 7
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_volume s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
dcl_2d s7
def c24, 0.89999998, 0.00000000, 10.00000000, 1.00000000
def c25, 0.15000001, 12.26193905, -1.00000000, -0.12123910
def c26, -0.01348047, 0.05747731, 0.19563590, -0.33299461
def c27, 0.99999559, 1.57079601, 0.66666669, 0.20000000
def c28, 0.83333331, 0.50000000, 2.00000000, 0.70710677
def c29, 2.71828198, 0.14001200, 1.27323949, 1.00000000
def c30, 0.12732396, 0.10000000, 0.25000000, 0.00002000
def c31, -2.69000006, 5.00000000, 1.50000000, 0.31194368
def c32, 22.70000076, 1.00000000, 0.01000000, -2.00000000
def c33, 0.98000002, 0.02000000, 12.56637096, 0.00000100
def c34, 16.00000000, -0.19750001, 5.34960032, 3.00000000
def c35, 0.90909088, 0.74000001, 4.00000000, -1.50000000
def c36, 0.00010000, -1.41299999, 0.38317001, 0.45454544
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
rcp r0.x, c17.x
rcp r0.y, c17.y
mul r7.xy, v0, r0.y
mul r6.xy, v0, r0.x
rcp r1.x, c17.z
mul r9.xy, v0, r1.x
rcp r1.x, c17.w
rcp r7.w, c7.x
mul r10.xy, v0, r1.x
rcp r9.w, c9.x
mul r2.w, c4.x, c4.x
dsy r10.w, v0.x
texld r0.xy, r6, s0
texld r0.zw, r7, s0
add r0.zw, r0.xyxy, r0
texld r0.xy, r9, s1
add r1.xy, r0.zwzw, r0
texld r0.zw, r10, s1
add r0.zw, r1.xyxy, r0
add r0.x, v1.z, c13
rcp r0.x, r0.x
mad r0.xy, -v1, r0.x, r0.zwzw
mov r0.xy, -r0
mov r0.z, c24.w
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul r4.xyz, r0.w, r0
mov r11.z, c24.y
mov r8.z, c24.y
mov r1.z, c14
mov r1.xy, c24.y
add r1.xyz, -v1, r1
dp3 r1.w, r1, r1
rsq r1.w, r1.w
mul r5.xyz, r1.w, r1
dp3 r3.w, r4, r5
mul r0.xyz, r4, -r3.w
mad r0.xyz, -r0, c28.z, -r5
mov r1.w, c13.x
add r0.x, r0, c12
max r0.z, r0, c24.y
dp3 r0.w, r0, r0
rsq r2.x, r0.w
mul r0.xyz, r2.x, r0
dp3 r7.z, r0, c15
add r1.w, c24.z, r1
mov r1.z, c13.x
mov r1.xy, c24.y
add r1.xyz, v1, r1
dp3 r0.w, r1, r1
rsq r0.w, r0.w
mul r1.xyz, r0.w, r1
mul r3.xyz, r1, r1.w
dp3 r1.x, r3, r3
rsq r1.x, r1.x
mov r1.y, c5.x
dp3 r0.w, r3, r0
rcp r6.w, r1.x
add r4.w, -c4.x, r1.y
mul r1.x, r4.w, c11
mul r1.y, r6.w, r6.w
add r5.w, r1.x, c4.x
mad r1.y, r0.w, r0.w, -r1
mad r1.x, r5.w, r5.w, r1.y
rsq r1.y, r1.x
rcp r1.y, r1.y
cmp r1.x, r1, r1.y, c33.w
add r1.x, -r0.w, -r1
max r1.w, r1.x, c24.y
mad r1.xyz, r1.w, r0, r3
cmp r1.xyz, -r1.w, r3, r1
cmp r6.z, -r1.w, r6.w, r5.w
rcp r2.x, r6.z
dp3 r1.x, r1, c15
mul r1.x, r1, r2
max r1.x, r1, c34.y
mul r1.x, r1, c34.z
abs r1.y, r1.x
max r1.z, r1.y, c24.w
rcp r2.x, r1.z
min r1.z, r1.y, c24.w
mul r1.z, r1, r2.x
mul r2.x, r1.z, r1.z
mad r2.y, r2.x, c26.x, c26
mad r2.y, r2, r2.x, c25.w
mad r2.y, r2, r2.x, c26.z
mad r2.y, r2, r2.x, c26.w
mad r2.x, r2.y, r2, c27
mul r1.z, r2.x, r1
add r2.x, -r1.z, c27.y
add r1.y, r1, c25.z
cmp r1.y, -r1, r1.z, r2.x
cmp r1.x, r1, r1.y, -r1.y
mov r1.y, c9.x
add r0.x, r7.z, c24.w
add r0.y, c25.z, r1
mul r0.y, r0.x, r0
mad r0.x, r1, c35, c35.y
mul r1.x, r0.y, c28.y
frc r8.w, r1.x
rcp r0.y, c8.x
add r0.z, -r0.y, c24.w
mad r0.x, r0, r0.z, r0.y
add r1.x, r1, -r8.w
mad r9.z, r0.x, c28.y, r1.x
add r0.x, r1.w, r0.w
cmp r2.x, -r1.w, r0.w, r0
mad r0.z, r5.w, r5.w, -r2.w
rsq r2.y, r0.z
rcp r0.w, r2.y
add r0.y, r9.z, c24.w
mul r8.x, r9.w, r0.y
mul r0.y, r6.z, r6.z
mad r0.y, r2.x, r2.x, -r0
mad r2.z, c4.x, c4.x, r0.y
cmp r0.x, r2, c24.y, c24.w
cmp r0.y, -r2.z, c24, c24.w
mul_pp r8.y, r0.x, r0
mul r1.y, r0.w, r0.w
mov r1.z, r0.w
mad r1.w, r7, c28.y, c28.y
mov r11.x, r8
mov r1.x, c25.z
mad r0.w, -r7, c28.y, c28.y
mov r0.xyz, c24.wyyw
cmp r0, -r8.y, r1, r0
mad r1.x, r6.z, r6.z, -r2.w
rsq r1.y, r1.x
rcp r1.y, r1.y
rcp r1.x, c6.x
add r0.y, r0, r2.z
add r0.z, r0, r1.y
rsq r0.y, r0.y
rcp r0.y, r0.y
mul r1.z, r2.y, r1.y
add r1.w, -r1.x, c24
mul r1.z, r1, r1.w
mad r1.z, r1.x, c28.y, r1
mad r0.y, r2.x, r0.x, r0
mul r0.x, r1.z, c6
add r1.y, r0.x, c25.z
frc r1.z, r1.y
add r1.y, r1, -r1.z
rcp r0.z, r0.z
mul r0.y, r0, r0.z
add r0.z, -r7.w, c28.y
mul r1.z, r1.y, r1.x
mad r1.y, r0, r0.z, r0.w
mad r11.y, r1, r1.x, r1.z
frc r7.w, r0.x
add r1.z, r0.x, -r7.w
texldl r0, r11.xyzz, s5
mul r1.z, r1.x, r1
mad r8.y, r1, r1.x, r1.z
texldl r2, r8.xyzz, s5
mul r8.x, r9.z, r9.w
mov r8.z, c24.y
texldl r1, r8.xyzz, s5
add r8.y, -r8.w, c24.w
mul r2, r8.w, r2
mad r1, r8.y, r1, r2
mul r2, r8.w, r0
dsx r9.z, v0.y
dsx r9.w, v0.x
dsy r11.x, v0.y
mov r0.x, r8
mov r0.y, r11
mov r0.z, c24.y
texldl r0, r0.xyzz, s5
mad r0, r0, r8.y, r2
add r2.x, -r7.w, c24.w
mul r1, r7.w, r1
mad r1, r0, r2.x, r1
mul r0.xyz, r1, r1.w
mul r0.w, r7.z, c2.x
max r1.w, r1.x, c36.x
rcp r1.w, r1.w
mul r2.xyz, r0, r1.w
mul r0.w, r0, c28.z
mad r0.w, c2.x, c2.x, -r0
add r1.w, r0, c24
rcp r0.x, c1.x
rcp r0.z, c1.z
rcp r0.y, c1.y
mul r8.xyz, r0, c1.x
pow r0, r1.w, c35.w
mad r0.w, r7.z, r7.z, c24
mov r1.w, r0.x
mul r0.y, -c2.x, c2.x
add r0.z, r0.y, c24.w
mov r0.x, c0
mul r0.x, c35.z, r0
rcp r0.x, r0.x
mul r0.x, r0, r0.z
mul r0.x, r0, r1.w
add r0.y, -r0, c28.z
mov r7.z, c0.x
mul r7.z, c34.x, r7
mul r2.xyz, r2, r8
rcp r0.y, r0.y
mul r0.x, r0.w, r0
rcp r7.z, r7.z
mul r0.w, r7.z, r0
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r2
mul r2.xyz, r0, c31.z
mov r0.x, c4
mul r1.xyz, r0.w, r1
mad r1.w, c24.x, -r0.x, r6
add r0.y, r3.z, c4.x
cmp r0.z, r1.w, r3, r0.y
mov r0.xy, r3
dp3 r2.w, r0, r0
rsq r2.w, r2.w
rcp r2.w, r2.w
cmp r6.w, r1, r6, r2
mad r1.xyz, r1, c34.w, r2
rcp r2.w, r6.w
mul r2.xyz, r0, r2.w
add r0.x, -r6.z, r5.w
cmp r0.y, r0.x, c24.w, c24
dp3 r5.w, r2, c15
add r0.x, r5.w, c25
mul r6.z, r0.x, c25.y
abs r7.w, r6.z
abs_pp r0.y, r0
cmp r0.xyz, -r0.y, c24.y, r1
mul r8.xyz, r0, c10.x
mul r0.x, r9.z, r9.z
mad r10.z, r9.w, r9.w, r0.x
mul r0.x, r10.z, c30.y
mul r0.y, r11.x, r11.x
mad r11.y, r10.w, r10.w, r0
pow r1, r0.x, c30.z
mul r1.y, r11, c30
pow r0, r1.y, c30.z
mov r0.x, r1
mul r0.w, r9.z, r11.x
mul r0.y, r10.z, r11
mad r0.w, r9, r10, r0
rsq r0.y, r0.y
mul r0.y, r0, r0.w
mad r0.y, r0, c28, c28
texld r0.x, r0, s2
max r7.z, r7.w, c24.w
rcp r0.y, r7.z
min r8.w, r7, c24
mul r9.w, r8, r0.y
mul r0.x, r0, c23
max r7.z, r0.x, c30.w
mul r10.z, r9.w, r9.w
rsq r0.y, r7.z
rcp r8.w, r0.y
mul r0.y, r8.w, c31.x
pow r1, c29.x, r0.y
add r1.y, -r3.w, c24.w
mad r0.x, r10.z, c26, c26.y
mad r0.x, r0, r10.z, c25.w
mad r10.w, r0.x, r10.z, c26.z
pow r0, r8.w, c31.z
mov r0.y, r1.x
mul r1.x, r0.y, c31.y
mov r1.z, r0.x
pow r0, r1.y, r1.x
mad r0.y, r1.z, c32.x, c32
mov r9.z, r0.x
rcp r8.w, r0.y
mul r0.y, r9.z, r8.w
mad r0.x, r10.w, r10.z, c26.w
mad r0.w, r0.x, r10.z, c27.x
mul r1.x, r0.w, r9.w
mul r11.xyz, r8, r0.y
add r0.xyz, r5, c15
dp3 r0.w, r0, r0
rsq r1.z, r0.w
mul r8.xyz, r1.z, r0
dp3 r0.y, r4, r8
add r0.z, r0.y, c24.w
add r1.y, -r1.x, c27
add r0.w, r7, c25.z
cmp r0.x, -r0.w, r1, r1.y
rcp r0.w, r0.z
cmp r0.x, r6.z, r0, -r0
mul r0.x, r0, c27.z
rcp r0.z, r7.z
mad r0.y, -r0, r0, c24.w
mul r0.y, r0, r0.z
mul r0.w, r0.y, r0
rcp r0.z, r4.w
add r0.y, r6.w, -c4.x
mul r1.zw, r0.y, r0.z
rsq r0.y, r1.z
mov r0.z, c24.y
rcp r0.y, r0.y
texldl r1.xyz, r0.xyzz, s3
mul r4.w, r0, c32
pow r0, c29.x, r4.w
dp3 r0.y, r5, r8
mul r0.w, r7.z, c33.z
add r0.y, -r0, c24.w
mov r0.z, r0.x
mul r0.x, r0.y, r0.y
mul r0.x, r0, r0
mul r0.x, r0, r0.y
rcp r0.w, r0.w
mul r0.y, r0.z, r0.w
mad r0.x, r0, c33, c33.y
mul r0.y, r0.x, r0
max r0.x, r3.w, c32.z
dp3 r0.w, r4, c15
max r3.w, r0, c32.z
rcp r0.x, r0.x
mul r0.z, r3.w, r0.x
mul r0.x, r2.w, c4
abs r0.z, r0
mad r0.x, -r0, r0, c24.w
rsq r0.z, r0.z
rcp r0.z, r0.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r2.w, r0.y, r0.z
add r0.x, r5.w, r0
cmp r0.xyz, r0.x, r1, c24.y
max r1.x, r2.w, c24.y
dp3 r2.w, r2, r4
cmp r1.x, -r3.w, c24.y, r1
mul r0.xyz, r0, c10.x
mov r3.w, c14.z
mad r1.xyz, r0, r1.x, r11
add r2.z, c13.x, r3.w
add r2.w, r2, c24
mov r2.xy, c24.y
add r2.xyz, r3, -r2
dp3 r2.x, r2, r2
mul r3.w, r2, c28.y
rsq r2.x, r2.x
texld r2.zw, r7, s6
texld r3.xy, r6, s6
add r4.xy, r3, r2.zwzw
rcp r2.y, c22.x
rcp r2.x, r2.x
mul_sat r3.z, r2.x, r2.y
texld r2.xy, r9, s7
add r4.xy, r4, r2
mul r2.y, r2.z, r2.z
mad r2.y, r3.x, r3.x, r2
texld r2.zw, r10, s7
mad r2.x, r2, r2, r2.y
mov r2.y, c19.x
add r2.y, -c18.x, r2
add r3.xy, r4, r2.zwzw
mad r2.x, r2.z, r2.z, r2
add r2.x, r3.y, -r2
mad r2.y, r3.z, r2, c18.x
max r2.x, r2, c24.y
add r2.y, r2, -r3.x
rsq r2.x, r2.x
mul r2.y, r2.x, r2
mul r3.x, r2.y, c28.w
mul r2.w, r3.x, r3.x
mov r2.y, r1.w
mad r3.y, r2.w, c29, c29.w
mad r1.w, r2, c29.y, c29.z
add r2.x, r5.w, c27.w
mul r1.w, -r2, r1
rcp r3.y, r3.y
mul r1.w, r1, r3.y
max r0.w, r0, c24.y
mul r2.x, r2, c28
mov r2.z, c24.y
texldl r2.xyz, r2.xyzz, s4
mul r2.xyz, r2, c10.x
mul r4.xyz, r2, r3.w
pow r2, c29.x, r1.w
mul r4.xyz, r4, c28.z
mov r1.w, r2.x
mad r2.y, -r9.z, r8.w, c24.w
mul r2.xyz, r2.y, c16
mul r2.xyz, r4, r2
mad r1.xyz, r2, c31.w, r1
add r1.w, -r1, c24
rsq r1.w, r1.w
rcp r2.y, r1.w
mad r0.xyz, r0, r0.w, r4
cmp r2.x, r3, c24.y, c24.w
cmp r1.w, -r3.x, c24.y, c24
add r1.w, r1, -r2.x
mul r1.w, r1, r2.y
mad r1.w, r1, c28.y, c28.y
mul r0.xyz, r0, r1.w
mad r0.xyz, r0, c30.x, r1
mul r4.xyz, r0, c3.x
mul r2.y, r4.x, c36.z
pow r0, r2.y, c36.w
pow r1, c29.x, -r4.x
mov r0.y, r1.x
pow r1, c29.x, -r4.z
mov r0.z, r0.x
add r1.y, r4, c36
mul r1.z, r4.y, c36
add r2.x, r4, c36.y
add r0.x, -r0.y, c24.w
cmp oC0.x, r2, r0, r0.z
pow r0, r1.z, c36.w
pow r2, c29.x, -r4.y
mov r0.z, r0.x
mov r0.y, r2.x
add r0.x, -r0.y, c24.w
cmp oC0.y, r1, r0.x, r0.z
mov r0.x, r1
add r1.x, -r0, c24.w
mul r1.z, r4, c36
pow r0, r1.z, c36.w
mov r0.y, c20.x
add r1.y, r4.z, c36
add r0.y, c24.w, -r0
mad r0.y, r3.z, r0, c20.x
cmp oC0.z, r1.y, r1.x, r0.x
mul oC0.w, r0.y, c21.x
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
ConstBuffer "$Globals" 912
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
Float 172 [_Ocean_Radius]
Vector 180 [_Ocean_CameraPos] 3
Vector 816 [_Ocean_SunDir] 3
Vector 832 [_Ocean_Color] 3
Vector 848 [_Ocean_GridSizes]
Float 872 [_Ocean_WhiteCapStr]
Float 876 [farWhiteCapStr]
Float 880 [_OceanAlpha]
Float 884 [_GlobalOceanAlpha]
Float 888 [alphaRadius]
Vector 896 [_VarianceMax] 2
BindCB  "$Globals" 0
"ps_4_0
eefiecedmbflokoflicgjlbflemeimggmadghpclabaaaaaaeeclaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgmckaaaaeaaaaaaajlakaaaa
fjaaaaaeegiocaaaaaaaaaaadjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
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
abaaaaaaagifcaaaaaaaaaaadfaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaeaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaogakbaaaaeaaaaaaaoaaaaaipcaabaaaaeaaaaaa
egbebaaaabaaaaaakgipcaaaaaaaaaaadfaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaegaabaaaafaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaafaaaaaaaaaaaaahdcaabaaa
adaaaaaaegaabaaaadaaaaaaogakbaaaafaaaaaadgaaaaafbcaabaaaafaaaaaa
abeaaaaaaaaaaaaadgaaaaagecaabaaaafaaaaaadkiacaaaaaaaaaaaakaaaaaa
aaaaaaahhcaabaaaafaaaaaaagacbaaaafaaaaaaegbcbaaaacaaaaaaaoaaaaah
mcaabaaaadaaaaaaagbebaaaacaaaaaakgakbaaaafaaaaaaaaaaaaaidcaabaaa
adaaaaaaogakbaiaebaaaaaaadaaaaaaegaabaaaadaaaaaadgaaaaagdcaabaaa
adaaaaaaegaabaiaebaaaaaaadaaaaaadgaaaaafecaabaaaadaaaaaaabeaaaaa
aaaaiadpbaaaaaahicaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaadaaaaaa
pgapbaaaadaaaaaaegacbaaaadaaaaaadgaaaaafbcaabaaaagaaaaaaabeaaaaa
aaaaaaaadgaaaaagecaabaaaagaaaaaadkiacaaaaaaaaaaaalaaaaaaaaaaaaai
hcaabaaaagaaaaaaagacbaaaagaaaaaaegbcbaiaebaaaaaaacaaaaaabaaaaaah
icaabaaaadaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaaeeaaaaaficaabaaa
adaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaahaaaaaapgapbaaaadaaaaaa
egacbaaaagaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaapgapbaaa
adaaaaaaegiccaaaaaaaaaaaddaaaaaabaaaaaaiicaabaaaadaaaaaaegacbaia
ebaaaaaaahaaaaaaegacbaaaadaaaaaaaaaaaaahicaabaaaadaaaaaadkaabaaa
adaaaaaadkaabaaaadaaaaaadcaaaaalhcaabaaaaiaaaaaaegacbaaaadaaaaaa
pgapbaiaebaaaaaaadaaaaaaegacbaiaebaaaaaaahaaaaaadeaaaaahecaabaaa
aiaaaaaackaabaaaaiaaaaaaabeaaaaaaaaaaaaaaaaaaaaibcaabaaaaiaaaaaa
akaabaaaaiaaaaaackiacaaaaaaaaaaaakaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaaiaaaaaaeeaaaaaficaabaaaadaaaaaadkaabaaa
adaaaaaadiaaaaahhcaabaaaaiaaaaaapgapbaaaadaaaaaaegacbaaaaiaaaaaa
baaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaafaaaaaaeeaaaaaf
icaabaaaadaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaafaaaaaapgapbaaa
adaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaadaaaaaadkiacaaaaaaaaaaa
akaaaaaaabeaaaaaaaaacaebdiaaaaahncaabaaaajaaaaaapgapbaaaadaaaaaa
kgaebaaaafaaaaaabaaaaaahecaabaaaakaaaaaaogaibaaaajaaaaaaegacbaaa
aiaaaaaabaaaaaahicaabaaaafaaaaaaigadbaaaajaaaaaaigadbaaaajaaaaaa
dcaaaaakicaabaaaagaaaaaackaabaaaakaaaaaackaabaaaakaaaaaadkaabaia
ebaaaaaaafaaaaaaelaaaaafbcaabaaaakaaaaaadkaabaaaafaaaaaaaaaaaaak
icaabaaaafaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaackiacaaaaaaaaaaa
ahaaaaaadcaaaaalbcaabaaaalaaaaaadkaabaaaafaaaaaabkiacaaaaaaaaaaa
akaaaaaabkiacaaaaaaaaaaaahaaaaaadcaaaaajicaabaaaagaaaaaaakaabaaa
alaaaaaaakaabaaaalaaaaaadkaabaaaagaaaaaabnaaaaahicaabaaaahaaaaaa
dkaabaaaagaaaaaaabeaaaaaaaaaaaaaelaaaaaficaabaaaagaaaaaadkaabaaa
agaaaaaadhaaaaakicaabaaaagaaaaaadkaabaaaahaaaaaadkaabaiaebaaaaaa
agaaaaaaabeaaaaalndhiglfaaaaaaaiicaabaaaagaaaaaadkaabaaaagaaaaaa
ckaabaiaebaaaaaaakaaaaaadeaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaa
abeaaaaaaaaaaaaaaaaaaaahccaabaaaalaaaaaadkaabaaaagaaaaaackaabaaa
akaaaaaadbaaaaahicaabaaaahaaaaaaabeaaaaaaaaaaaaadkaabaaaagaaaaaa
dcaaaaajhcaabaaaamaaaaaapgapbaaaagaaaaaaegacbaaaaiaaaaaaogaibaaa
ajaaaaaabaaaaaaiicaabaaaagaaaaaaegacbaaaaiaaaaaaegiccaaaaaaaaaaa
ddaaaaaadhaaaaajhcaabaaaaiaaaaaapgapbaaaahaaaaaaegacbaaaamaaaaaa
ogaibaaaajaaaaaadhaaaaajmcaabaaaakaaaaaapgapbaaaahaaaaaaagaebaaa
alaaaaaaagaibaaaakaaaaaabaaaaaaiicaabaaaahaaaaaaegacbaaaaiaaaaaa
egiccaaaaaaaaaaaddaaaaaaaoaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaa
ckaabaaaakaaaaaadeaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaaabeaaaaa
hbdneklodiaaaaahicaabaaaahaaaaaadkaabaaaahaaaaaaabeaaaaabodaklea
diaaaaahbcaabaaaaiaaaaaackaabaaaakaaaaaackaabaaaakaaaaaadcaaaaak
bcaabaaaaiaaaaaadkaabaaaakaaaaaadkaabaaaakaaaaaaakaabaiaebaaaaaa
aiaaaaaadcaaaaalbcaabaaaaiaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaa
aaaaaaaaahaaaaaaakaabaaaaiaaaaaadbaaaaahccaabaaaaiaaaaaaabeaaaaa
aaaaaaaaakaabaaaaiaaaaaadbaaaaahecaabaaaaiaaaaaadkaabaaaakaaaaaa
abeaaaaaaaaaaaaaabaaaaahccaabaaaaiaaaaaabkaabaaaaiaaaaaackaabaaa
aiaaaaaadiaaaaajecaabaaaaiaaaaaabkiacaaaaaaaaaaaahaaaaaabkiacaaa
aaaaaaaaahaaaaaadcaaaaakicaabaaaaiaaaaaaakaabaaaalaaaaaaakaabaaa
alaaaaaackaabaiaebaaaaaaaiaaaaaabnaaaaahbcaabaaaalaaaaaaakaabaaa
alaaaaaackaabaaaakaaaaaadcaaaaakecaabaaaaiaaaaaackaabaaaakaaaaaa
ckaabaaaakaaaaaackaabaiaebaaaaaaaiaaaaaaelaaaaafecaabaaaaiaaaaaa
ckaabaaaaiaaaaaaelaaaaafecaabaaaabaaaaaadkaabaaaaiaaaaaadiaaaaah
ccaabaaaabaaaaaackaabaaaabaaaaaackaabaaaabaaaaaaaoaaaaalocaabaaa
alaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgiicaaaaaaaaaaa
aiaaaaaaaaaaaaaiicaabaaaaaaaaaaabkaabaiaebaaaaaaalaaaaaaabeaaaaa
aaaaaadpaaaaaaahicaabaaaabaaaaaabkaabaaaalaaaaaaabeaaaaaaaaaaadp
dhaaaaajpcaabaaaaaaaaaaafgafbaaaaiaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaaoaaaaahbcaabaaaabaaaaaackaabaaaaiaaaaaackaabaaaabaaaaaa
aaaaaaahgcaabaaaaaaaaaaafgagbaaaaaaaaaaaagacbaaaaiaaaaaaelaaaaaf
ccaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
akaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaaaoaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaackaabaaaaaaaaaaaaoaaaaalocaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpagijcaaaaaaaaaaaaiaaaaaaaaaaaaal
ocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaadpaaaaiadpdcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
abaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaackaabaaaalaaaaaadcaaaaakecaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaaiaaaaaaebaaaaafecaabaaa
aaaaaaaackaabaaaaaaaaaaaaoaaaaaifcaabaaaaaaaaaaaagacbaaaaaaaaaaa
agiacaaaaaaaaaaaaiaaaaaaaaaaaaahecaabaaaaiaaaaaackaabaaaaaaaaaaa
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
abaaaaaadkiacaaaaaaaaaaaaiaaaaaaabeaaaaaaaaaialpdiaaaaahccaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaaebaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaaaaaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaa
abaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
bkaabaiaebaaaaaaabaaaaaaaaaaaaahbcaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaaaaiadpaoaaaaaiccaabaaaaiaaaaaackaabaaaaaaaaaaadkiacaaa
aaaaaaaaaiaaaaaaaoaaaaaibcaabaaaaiaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaaiaaaaaaeiaaaaalpcaabaaaabaaaaaaigaabaaaaiaaaaaaeghobaaa
afaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaeiaaaaalpcaabaaaamaaaaaa
jgafbaaaaiaaaaaaeghobaaaafaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaaaaaaaaai
ecaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaiadpdcaaaaaj
pcaabaaaabaaaaaaegaobaaaamaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaa
ebaaaaaficaabaaaahaaaaaabkaabaaaaaaaaaaabkaaaaafccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaoaaaaaiicaabaaaahaaaaaadkaabaaaahaaaaaaakiacaaa
aaaaaaaaaiaaaaaaaaaaaaahicaabaaaaiaaaaaaakaabaaaaaaaaaaadkaabaaa
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
aaaaaaaaaeaaaaaaegiccaaaaaaaaaaaaeaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaaiaaaaaaapaaaaaiicaabaaaaaaaaaaapgapbaaa
agaaaaaapgipcaaaaaaaaaaaagaaaaaadcaaaaajicaabaaaabaaaaaadkaabaaa
agaaaaaadkaabaaaagaaaaaaabeaaaaaaaaaiadpdcaaaaaodcaabaaaaiaaaaaa
pgipcaaaaaaaaaaaagaaaaaapgipcaaaaaaaaaaaagaaaaaaaceaaaaaaaaaiadp
aaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaakaabaaaaiaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaamalpbjaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaamicaabaaaagaaaaaadkiacaia
ebaaaaaaaaaaaaaaagaaaaaadkiacaaaaaaaaaaaagaaaaaaabeaaaaaaaaaiadp
diaaaaalfcaabaaaaiaaaaaaagiacaaaaaaaaaaaacaaaaaaaceaaaaaaaaaiaeb
aaaaaaaaaaaaiaeaaaaaaaaaaoaaaaakfcaabaaaaiaaaaaaaceaaaaaaaaaeaea
aaaaaaaaaaaamadpaaaaaaaaagacbaaaaiaaaaaadiaaaaahicaabaaaagaaaaaa
dkaabaaaagaaaaaackaabaaaaiaaaaaadiaaaaahicaabaaaahaaaaaadkaabaaa
abaaaaaaakaabaaaaiaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaagaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaoaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaaiaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaaahaaaaaaegacbaaaabaaaaaa
abaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaaaalaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaagiacaaaaaaaaaaaakaaaaaaalaaaaaf
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
akaabaaaabaaaaaaakiacaaaaaaaaaaadiaaaaaadeaaaaahicaabaaaaaaaaaaa
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
abaaaaaaagaabaaaabaaaaaaegiicaaaaaaaaaaadeaaaaaabaaaaaahicaabaaa
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
aaaaaaaaddaaaaaaegacbaaaadaaaaaadeaaaaakdcaabaaaagaaaaaaagaabaaa
agaaaaaaaceaaaaaaknhcddmaaaaaaaaaaaaaaaaaaaaaaaaaoaaaaahecaabaaa
abaaaaaaakaabaaaagaaaaaackaabaaaabaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaa
abaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dcaaaaakccaabaaaajaaaaaackaabaaaafaaaaaadkaabaaaadaaaaaabkiacaaa
aaaaaaaaahaaaaaadgaaaaafbcaabaaaahaaaaaabkaabaaaajaaaaaabaaaaaah
ecaabaaaabaaaaaajgahbaaaajaaaaaajgahbaaaajaaaaaaelaaaaafccaabaaa
ahaaaaaackaabaaaabaaaaaadgaaaaafccaabaaaakaaaaaaakaabaaaajaaaaaa
diaaaaaiecaabaaaabaaaaaabkiacaaaaaaaaaaaahaaaaaaabeaaaaaggggggdp
dbaaaaahecaabaaaabaaaaaaakaabaaaakaaaaaackaabaaaabaaaaaadhaaaaaj
dcaabaaaajaaaaaakgakbaaaabaaaaaaegaabaaaahaaaaaabgafbaaaakaaaaaa
aoaaaaahncaabaaaagaaaaaakgadbaaaajaaaaaafgafbaaaajaaaaaabaaaaaai
ecaabaaaabaaaaaaigadbaaaagaaaaaaegiccaaaaaaaaaaaddaaaaaabaaaaaah
bcaabaaaadaaaaaaigadbaaaagaaaaaaegacbaaaadaaaaaaaaaaaaahbcaabaaa
adaaaaaaakaabaaaadaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaaadaaaaaa
akaabaaaadaaaaaaabeaaaaaaaaaaadpaoaaaaaiccaabaaaadaaaaaabkiacaaa
aaaaaaaaahaaaaaabkaabaaaajaaaaaaaaaaaaajecaabaaaadaaaaaabkaabaaa
ajaaaaaabkiacaiaebaaaaaaaaaaaaaaahaaaaaaaoaaaaahecaabaaaahaaaaaa
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
aaaaaaaaakaaaaaadiaaaaahncaabaaaagaaaaaaagaabaaaadaaaaaaagaobaaa
agaaaaaaaaaaaaahncaabaaaagaaaaaaagaobaaaagaaaaaaagaobaaaagaaaaaa
dbaaaaaibcaabaaaadaaaaaackaabaaaadaaaaaackaabaiaebaaaaaaadaaaaaa
dhaaaaakecaabaaaabaaaaaaakaabaaaadaaaaaackaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadiaaaaahbcaabaaaahaaaaaackaabaaaabaaaaaaabeaaaaa
klkkckdpeiaaaaalpcaabaaaahaaaaaaegaabaaaahaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaahaaaaaaegacbaaa
ahaaaaaaagiacaaaaaaaaaaaakaaaaaadhaaaaamhcaabaaaadaaaaaafgafbaaa
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
acaaaaaadkiacaaaaaaaaaaaakaaaaaadkiacaaaaaaaaaaaalaaaaaadgaaaaai
dcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadcaaaaak
ocaabaaaabaaaaaaagajbaaaafaaaaaapgapbaaaadaaaaaaagajbaiaebaaaaaa
acaaaaaabaaaaaahccaabaaaabaaaaaajgahbaaaabaaaaaajgahbaaaabaaaaaa
elaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaaaocaaaaiccaabaaaabaaaaaa
bkaabaaaabaaaaaackiacaaaaaaaaaaadhaaaaaaaaaaaaakecaabaaaabaaaaaa
ckiacaiaebaaaaaaaaaaaaaadgaaaaaadkiacaaaaaaaaaaadgaaaaaadcaaaaak
ecaabaaaabaaaaaabkaabaaaabaaaaaackaabaaaabaaaaaackiacaaaaaaaaaaa
dgaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
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
agiacaaaaaaaaaaaahaaaaaadiaaaaakpcaabaaaacaaaaaaagafbaaaaaaaaaaa
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
akiacaiaebaaaaaaaaaaaaaadhaaaaaaabeaaaaaaaaaiadpdcaaaaakbcaabaaa
aaaaaaaabkaabaaaabaaaaaaakaabaaaaaaaaaaaakiacaaaaaaaaaaadhaaaaaa
diaaaaaiiccabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaadhaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SKY_REFLECTIONS_ON" }
"!!GLES3"
}
}
 }
}
}