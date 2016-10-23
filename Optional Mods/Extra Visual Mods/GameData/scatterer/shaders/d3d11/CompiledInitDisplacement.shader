// Compiled shader for all platforms, uncompressed size: 14.9KB

Shader "Proland/Ocean/InitDisplacement" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 2 texture
 //        d3d9 : 36 math, 2 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

varying vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform vec4 _InverseGridSizes;
varying vec2 xlv_TEXCOORD0;
void main ()
{
  vec2 st_1;
  float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_12;
  tmpvar_16.z = tmpvar_13;
  tmpvar_16.w = tmpvar_13;
  vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_14;
  tmpvar_17.y = tmpvar_14;
  tmpvar_17.z = tmpvar_15;
  tmpvar_17.w = tmpvar_15;
  gl_FragData[0] = (texture2D (_Buffer1, xlv_TEXCOORD0) * tmpvar_16);
  gl_FragData[1] = (texture2D (_Buffer2, xlv_TEXCOORD0) * tmpvar_17);
}


#endif
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefieceddolmmcahcgjmjpiinclfhjokihhgamkaabaaaaaaaeacaaaaadaaaaaa
cmaaaaaakaaaaaaapiaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahaaaaaagaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaafaepfdejfeejepeoaaeoepfcenebemaafeeffiedepepfceeaaklklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaacaaaaaa
doaaaaab"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform highp vec4 _InverseGridSizes;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 st_1;
  highp float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  highp float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  highp vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  highp vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  highp vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  highp float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  highp float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  highp float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Buffer1, xlv_TEXCOORD0);
  highp vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_12;
  tmpvar_17.y = tmpvar_12;
  tmpvar_17.z = tmpvar_13;
  tmpvar_17.w = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Buffer2, xlv_TEXCOORD0);
  highp vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_14;
  tmpvar_19.y = tmpvar_14;
  tmpvar_19.z = tmpvar_15;
  tmpvar_19.w = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_16 * tmpvar_17);
  gl_FragData[0] = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_18 * tmpvar_19);
  gl_FragData[1] = tmpvar_21;
}



#endif"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform highp vec4 _InverseGridSizes;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 st_1;
  highp float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  highp float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  highp vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  highp vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  highp vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  highp float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  highp float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  highp float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Buffer1, xlv_TEXCOORD0);
  highp vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_12;
  tmpvar_17.y = tmpvar_12;
  tmpvar_17.z = tmpvar_13;
  tmpvar_17.w = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_Buffer2, xlv_TEXCOORD0);
  highp vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_14;
  tmpvar_19.y = tmpvar_14;
  tmpvar_19.z = tmpvar_15;
  tmpvar_19.w = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_16 * tmpvar_17);
  gl_FragData[0] = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_18 * tmpvar_19);
  gl_FragData[1] = tmpvar_21;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _Buffer1;
uniform sampler2D _Buffer2;
uniform highp vec4 _InverseGridSizes;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 st_1;
  highp float tmpvar_2;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_2 = (xlv_TEXCOORD0.x - 1.0);
  } else {
    tmpvar_2 = xlv_TEXCOORD0.x;
  };
  st_1.x = tmpvar_2;
  highp float tmpvar_3;
  if ((xlv_TEXCOORD0.y > 0.5)) {
    tmpvar_3 = (xlv_TEXCOORD0.y - 1.0);
  } else {
    tmpvar_3 = xlv_TEXCOORD0.y;
  };
  st_1.y = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (st_1 * _InverseGridSizes.x);
  highp vec2 tmpvar_5;
  tmpvar_5 = (st_1 * _InverseGridSizes.y);
  highp vec2 tmpvar_6;
  tmpvar_6 = (st_1 * _InverseGridSizes.z);
  highp vec2 tmpvar_7;
  tmpvar_7 = (st_1 * _InverseGridSizes.w);
  highp float tmpvar_8;
  tmpvar_8 = sqrt(dot (tmpvar_4, tmpvar_4));
  highp float tmpvar_9;
  tmpvar_9 = sqrt(dot (tmpvar_5, tmpvar_5));
  highp float tmpvar_10;
  tmpvar_10 = sqrt(dot (tmpvar_6, tmpvar_6));
  highp float tmpvar_11;
  tmpvar_11 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_12;
  if ((tmpvar_8 == 0.0)) {
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = (1.0/(tmpvar_8));
  };
  highp float tmpvar_13;
  if ((tmpvar_9 == 0.0)) {
    tmpvar_13 = 0.0;
  } else {
    tmpvar_13 = (1.0/(tmpvar_9));
  };
  highp float tmpvar_14;
  if ((tmpvar_10 == 0.0)) {
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = (1.0/(tmpvar_10));
  };
  highp float tmpvar_15;
  if ((tmpvar_11 == 0.0)) {
    tmpvar_15 = 0.0;
  } else {
    tmpvar_15 = (1.0/(tmpvar_11));
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture (_Buffer1, xlv_TEXCOORD0);
  highp vec4 tmpvar_17;
  tmpvar_17.x = tmpvar_12;
  tmpvar_17.y = tmpvar_12;
  tmpvar_17.z = tmpvar_13;
  tmpvar_17.w = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_Buffer2, xlv_TEXCOORD0);
  highp vec4 tmpvar_19;
  tmpvar_19.x = tmpvar_14;
  tmpvar_19.y = tmpvar_14;
  tmpvar_19.z = tmpvar_15;
  tmpvar_19.w = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (tmpvar_16 * tmpvar_17);
  _glesFragData[0] = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_18 * tmpvar_19);
  _glesFragData[1] = tmpvar_21;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
// Stats: 36 math, 2 textures
Vector 0 [_InverseGridSizes]
SetTexture 0 [_Buffer1] 2D 0
SetTexture 1 [_Buffer2] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c1, -1.00000000, -0.50000000, 0.00000000, 0
dcl_texcoord0 v0.xy
texld r0, v0, s0
add r1.y, v0.x, c1.x
add r1.x, v0, c1.y
cmp r2.x, -r1, v0, r1.y
add r1.y, v0, c1.x
add r1.x, v0.y, c1.y
cmp r2.y, -r1.x, v0, r1
mul r1.zw, r2.xyxy, c0.y
mul r1.zw, r1, r1
mul r1.xy, r2, c0.x
mul r1.xy, r1, r1
add r1.x, r1, r1.y
add r1.z, r1, r1.w
rsq r1.y, r1.z
rsq r1.x, r1.x
rcp r1.z, r1.x
rcp r1.w, r1.y
abs r2.z, r1
abs r1.w, r1
cmp r1.zw, -r1.w, c1.z, r1.y
cmp r1.xy, -r2.z, c1.z, r1.x
mul oC0, r0, r1
mul r1.xy, r2, c0.w
mul r1.xy, r1, r1
mul r1.zw, r2.xyxy, c0.z
mul r1.zw, r1, r1
add r1.y, r1.x, r1
add r1.x, r1.z, r1.w
rsq r1.z, r1.y
rsq r1.x, r1.x
rcp r1.w, r1.z
rcp r1.y, r1.x
abs r1.w, r1
abs r1.y, r1
texld r0, v0, s1
cmp r1.zw, -r1.w, c1.z, r1.z
cmp r1.xy, -r1.y, c1.z, r1.x
mul oC1, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 20 math, 2 textures
SetTexture 0 [_Buffer1] 2D 0
SetTexture 1 [_Buffer2] 2D 1
ConstBuffer "$Globals" 32
Vector 16 [_InverseGridSizes]
BindCB  "$Globals" 0
"ps_4_0
eefiecedilbdjdgpgnmfmdhnkeilaloonpdlilhaabaaaaaapeaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmaeaaaaeaaaaaaaahabaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
gfaaaaadpccabaaaabaaaaaagiaaaaacadaaaaaadbaaaaakpcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaadpegbebaaaabaaaaaaaaaaaaak
pcaabaaaabaaaaaaegbebaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaialpdhaaaaajpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
egbebaaaabaaaaaadiaaaaaipcaabaaaabaaaaaaogaobaaaaaaaaaaaagifcaaa
aaaaaaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaakgipcaaa
aaaaaaaaabaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaapaaaaahccaabaaaabaaaaaaogakbaaaabaaaaaaogakbaaaabaaaaaa
elaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaabiaaaaahecaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaoaaaaakbcaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpakaabaaaabaaaaaadhaaaaamdcaabaaa
acaaaaaakgakbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
agaabaaaabaaaaaabiaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaa
aaaaaaaaaoaaaaakccaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpbkaabaaaabaaaaaadhaaaaammcaabaaaacaaaaaaagaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafgafbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpccabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaabaaaaaaapaaaaah
bcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaapaaaaahccaabaaa
aaaaaaaaogakbaaaaaaaaaaaogakbaaaaaaaaaaaelaaaaafdcaabaaaaaaaaaaa
egaabaaaaaaaaaaabiaaaaahecaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaaoaaaaakbcaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpakaabaaaaaaaaaaadhaaaaamdcaabaaaabaaaaaakgakbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaagaabaaaaaaaaaaabiaaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaaoaaaaakccaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaaaaaaaaa
dhaaaaammcaabaaaabaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahpccabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
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