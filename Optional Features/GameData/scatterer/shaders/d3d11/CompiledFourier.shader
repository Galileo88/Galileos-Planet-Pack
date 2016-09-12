// Compiled shader for all platforms, uncompressed size: 97.0KB

Shader "Math/Fourier" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 35 math, 3 texture
 //      opengl : 30 math, 3 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_13;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 30 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MUL R0.xyz, R1, c[1].y;
MOV R0.w, c[1].z;
ADD R1.x, -R0.w, c[0];
RCP R1.y, R1.x;
MUL R2.xy, R0, R1.y;
RCP R0.w, c[0].x;
MUL R1.x, R0.z, R0.w;
MUL R1.x, R1, c[2];
SIN R1.y, R1.x;
COS R1.x, R1.x;
ADD R1.z, R1.w, -c[1].w;
CMP R1.zw, -R1.z, -R1.xyxy, R1.xyxy;
MOV R0.y, fragment.texcoord[0];
MOV R0.x, R2.y;
TEX R0, R0, texture[1], 2D;
MUL R1.x, R1.w, R0.y;
MUL R0.y, R1.z, R0;
MAD R1.y, R1.w, R0.x, R0;
MAD R1.x, R1.z, R0, -R1;
MUL R0.x, R1.w, R0.w;
MUL R0.y, R1.z, R0.w;
MAD R1.z, R1, R0, -R0.x;
MAD R1.w, R1, R0.z, R0.y;
MOV R0.y, fragment.texcoord[0];
MOV R0.x, R2;
TEX R0, R0, texture[1], 2D;
ADD result.color, R0, R1;
END
# 30 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 35 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r0.y, c1.x
mov r0.x, v0
texld r2, r0, s0
mul r0.xyz, r2, c1.y
rcp r0.w, c0.x
mul r0.z, r0, r0.w
mad r0.w, r0.z, c2.x, c2.y
mov r0.z, c0.x
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r1.xy, r0.w
add r0.z, c1, r0
rcp r0.z, r0.z
mul r2.xy, r0, r0.z
add r1.z, r2.w, c1.w
cmp r1.zw, -r1.z, r1.xyxy, -r1.xyxy
mov r0.y, v0
mov r0.x, r2.y
texld r0, r0, s1
mul r1.x, r1.w, r0.y
mul r0.y, r1.z, r0
mad r1.y, r1.w, r0.x, r0
mad r1.x, r1.z, r0, -r1
mul r0.x, r1.w, r0.w
mul r0.y, r1.z, r0.w
mad r1.z, r1, r0, -r0.x
mad r1.w, r1, r0.z, r0.y
mov r0.y, v0
mov r0.x, r2
texld r0, r0, s1
add oC0, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_ButterFlyLookUp] 2D 1
SetTexture 1 [_ReadBuffer0] 2D 0
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfbnbnokanfleolonilmefjdmonphjgffabaaaaaagmadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmacaaaa
eaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaacaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 35 math, 3 texture
 //      opengl : 30 math, 3 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_13;
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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  highp vec4 tmpvar_13;
  tmpvar_13 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_13;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 30 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
"3.0-!!ARBfp1.0
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.z, c[1];
ADD R0.w, -R0.z, c[0].x;
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0].y;
TEX R1, R0, texture[0], 2D;
MUL R0.xyz, R1, c[1].y;
RCP R1.x, R0.w;
MUL R2.xy, R0, R1.x;
RCP R0.w, c[0].x;
MUL R1.x, R0.z, R0.w;
MUL R1.x, R1, c[2];
SIN R1.y, R1.x;
COS R1.x, R1.x;
ADD R1.z, R1.w, -c[1].w;
CMP R1.zw, -R1.z, -R1.xyxy, R1.xyxy;
MOV R0.y, R2;
MOV R0.x, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
MUL R1.x, R1.w, R0.y;
MUL R0.y, R1.z, R0;
MAD R1.y, R1.w, R0.x, R0;
MAD R1.x, R1.z, R0, -R1;
MUL R0.x, R1.w, R0.w;
MUL R0.y, R1.z, R0.w;
MAD R1.z, R1, R0, -R0.x;
MAD R1.w, R1, R0.z, R0.y;
MOV R0.y, R2.x;
MOV R0.x, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
ADD result.color, R0, R1;
END
# 30 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 35 math, 3 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r0.y, c1.x
mov r0.x, v0.y
texld r2, r0, s0
mul r0.xyz, r2, c1.y
rcp r0.w, c0.x
mul r0.w, r0.z, r0
mov r0.z, c0.x
mad r0.w, r0, c2.x, c2.y
add r0.z, c1, r0
rcp r0.z, r0.z
mul r2.xy, r0, r0.z
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r1.xy, r0.w
add r1.z, r2.w, c1.w
cmp r1.zw, -r1.z, r1.xyxy, -r1.xyxy
mov r0.y, r2
mov r0.x, v0
texld r0, r0, s1
mul r1.x, r1.w, r0.y
mul r0.y, r1.z, r0
mad r1.y, r1.w, r0.x, r0
mad r1.x, r1.z, r0, -r1
mul r0.x, r1.w, r0.w
mul r0.y, r1.z, r0.w
mad r1.z, r1, r0, -r0.x
mad r1.w, r1, r0.z, r0.y
mov r0.y, r2.x
mov r0.x, v0
texld r0, r0, s1
add oC0, r0, r1
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_ButterFlyLookUp] 2D 1
SetTexture 1 [_ReadBuffer0] 2D 0
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefiecedohihephlbampmgllinmegpnoijkomngmabaaaaaagmadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmacaaaa
eaaaaaaaklaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaacgakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaacaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaadoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 15 math, 5 texture
 //        d3d9 : 43 math, 5 texture
 //      opengl : 40 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  _glesFragData[1] = tmpvar_19;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 40 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_draw_buffers;
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MUL R0.xyz, R1, c[1].y;
MOV R0.w, c[1].z;
ADD R1.x, -R0.w, c[0];
RCP R0.w, c[0].x;
RCP R1.x, R1.x;
MUL R3.xy, R0, R1.x;
MOV R1.x, R3.y;
MUL R1.z, R0, R0.w;
MOV R1.y, fragment.texcoord[0];
TEX R0, R1, texture[2], 2D;
ADD R2.x, R1.w, -c[1].w;
MUL R1.z, R1, c[2].x;
SIN R1.w, R1.z;
COS R1.z, R1.z;
CMP R3.zw, -R2.x, -R1, R1;
MUL R1.z, R3.w, R0.y;
MAD R2.x, R3.z, R0, -R1.z;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
TEX R1, R1, texture[1], 2D;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
MOV R3.y, fragment.texcoord[0];
TEX R0, R3, texture[2], 2D;
ADD result.color[1], R0, R2;
MUL R0.x, R3.w, R1.y;
MUL R0.y, R3.z, R1;
MUL R0.z, R3.w, R1.w;
MUL R0.w, R3.z, R1;
MAD R0.x, R3.z, R1, -R0;
MAD R0.y, R3.w, R1.x, R0;
MAD R0.z, R3, R1, -R0;
MAD R0.w, R3, R1.z, R0;
TEX R1, R3, texture[1], 2D;
ADD result.color, R1, R0;
END
# 40 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 43 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r0.y, c1.x
mov r0.x, v0
texld r1, r0, s0
mul r0.xyz, r1, c1.y
rcp r0.w, c0.x
mul r0.z, r0, r0.w
mad r0.w, r0.z, c2.x, c2.y
mov r0.z, c0.x
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r2.xy, r0.w
add r0.z, c1, r0
rcp r0.z, r0.z
mul r3.xy, r0, r0.z
mov r1.x, r3.y
mov r1.y, v0
texld r0, r1, s1
add r1.z, r1.w, c1.w
cmp r3.zw, -r1.z, r2.xyxy, -r2.xyxy
mul r1.z, r3.w, r0.y
mad r2.x, r3.z, r0, -r1.z
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
texld r1, r1, s2
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
mov r3.y, v0
texld r0, r3, s1
add oC0, r0, r2
mul r0.x, r3.w, r1.y
mul r0.y, r3.z, r1
mul r0.z, r3.w, r1.w
mul r0.w, r3.z, r1
mad r0.x, r3.z, r1, -r0
mad r0.y, r3.w, r1.x, r0
mad r0.z, r3, r1, -r0
mad r0.w, r3, r1.z, r0
texld r1, r3, s2
add oC1, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 5 textures
SetTexture 0 [_ButterFlyLookUp] 2D 2
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjboniffbkibicfphpemfahkalglppidhabaaaaaaimaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 15 math, 5 texture
 //        d3d9 : 44 math, 5 texture
 //      opengl : 41 math, 5 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
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

uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  gl_FragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  gl_FragData[1] = tmpvar_19;
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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  highp vec4 tmpvar_18;
  tmpvar_18 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (input1_15 + tmpvar_17);
  _glesFragData[1] = tmpvar_19;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 41 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
"3.0-!!ARBfp1.0
OPTION ARB_draw_buffers;
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.z, c[1];
ADD R0.w, -R0.z, c[0].x;
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0].y;
TEX R1, R0, texture[0], 2D;
MUL R0.xyz, R1, c[1].y;
RCP R1.x, R0.w;
MUL R3.xy, R0, R1.x;
MOV R1.y, R3;
MOV R3.y, R3.x;
RCP R0.w, c[0].x;
MUL R1.z, R0, R0.w;
MOV R1.x, fragment.texcoord[0];
TEX R0, R1, texture[2], 2D;
ADD R2.x, R1.w, -c[1].w;
MUL R1.z, R1, c[2].x;
SIN R1.w, R1.z;
COS R1.z, R1.z;
CMP R3.zw, -R2.x, -R1, R1;
MUL R1.z, R3.w, R0.y;
MAD R2.x, R3.z, R0, -R1.z;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
TEX R1, R1, texture[1], 2D;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
MOV R3.x, fragment.texcoord[0];
TEX R0, R3, texture[2], 2D;
ADD result.color[1], R0, R2;
MUL R0.x, R3.w, R1.y;
MUL R0.y, R3.z, R1;
MUL R0.z, R3.w, R1.w;
MUL R0.w, R3.z, R1;
MAD R0.x, R3.z, R1, -R0;
MAD R0.y, R3.w, R1.x, R0;
MAD R0.z, R3, R1, -R0;
MAD R0.w, R3, R1.z, R0;
TEX R1, R3, texture[1], 2D;
ADD result.color, R1, R0;
END
# 41 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 44 math, 5 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r0.y, c1.x
mov r0.x, v0.y
texld r1, r0, s0
mul r0.xyz, r1, c1.y
rcp r0.w, c0.x
mul r0.w, r0.z, r0
mov r0.z, c0.x
mad r0.w, r0, c2.x, c2.y
add r0.z, c1, r0
rcp r0.z, r0.z
mul r3.xy, r0, r0.z
mov r1.y, r3
mov r3.y, r3.x
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r2.xy, r0.w
mov r1.x, v0
texld r0, r1, s1
add r1.z, r1.w, c1.w
cmp r3.zw, -r1.z, r2.xyxy, -r2.xyxy
mul r1.z, r3.w, r0.y
mad r2.x, r3.z, r0, -r1.z
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
texld r1, r1, s2
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
mov r3.x, v0
texld r0, r3, s1
add oC0, r0, r2
mul r0.x, r3.w, r1.y
mul r0.y, r3.z, r1
mul r0.z, r3.w, r1.w
mul r0.w, r3.z, r1
mad r0.x, r3.z, r1, -r0
mad r0.y, r3.w, r1.x, r0
mad r0.z, r3, r1, -r0
mad r0.w, r3, r1.z, r0
texld r1, r3, s2
add oC1, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 5 textures
SetTexture 0 [_ButterFlyLookUp] 2D 2
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefiecedljpfpfgfllpecfcclgegblkdecbgmadjabaaaaaaimaeaaaaadaaaaaa
cmaaaaaaieaaaaaanaaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheoeeaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaadiaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleadaaaaeaaaaaaaonaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaad
pccabaaaabaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 7 texture
 //        d3d9 : 53 math, 7 texture
 //      opengl : 52 math, 7 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
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
#line 13
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 19
struct f2a_1 {
    highp vec4 col0;
};
#line 24
struct f2a_2 {
    highp vec4 col0;
    highp vec4 col1;
};
#line 30
struct f2a_3 {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
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
#line 9
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
#line 37
#line 46
#line 56
#line 78
#line 100
#line 123
#line 146
#line 46
highp vec4 FFT( in highp vec2 w, in highp vec4 input1, in highp vec4 input2 ) {
    highp float rx = ((w.x * input2.x) - (w.y * input2.y));
    highp float ry = ((w.y * input2.x) + (w.x * input2.y));
    #line 50
    highp float rz = ((w.x * input2.z) - (w.y * input2.w));
    highp float rw = ((w.y * input2.z) + (w.x * input2.w));
    return (input1 + vec4( rx, ry, rz, rw));
}
#line 146
f2a_3 fragX_3( in v2f IN ) {
    highp vec4 lookUp = texture2D( _ButterFlyLookUp, vec2( IN.uv.x, 0.0));
    #line 150
    lookUp.xyz *= 255.0;
    lookUp.xy /= (_Size - 1.0);
    highp float PI = 3.14159;
    #line 154
    highp vec2 w = vec2( cos((((2.0 * PI) * lookUp.z) / _Size)), sin((((2.0 * PI) * lookUp.z) / _Size)));
    if ((lookUp.w > 0.5)){
        w *= -1.0;
    }
    #line 158
    f2a_3 OUT;
    highp vec2 uv1 = vec2( lookUp.x, IN.uv.y);
    highp vec2 uv2 = vec2( lookUp.y, IN.uv.y);
    #line 163
    OUT.col0 = FFT( w, texture2D( _ReadBuffer0, uv1), texture2D( _ReadBuffer0, uv2));
    OUT.col1 = FFT( w, texture2D( _ReadBuffer1, uv1), texture2D( _ReadBuffer1, uv2));
    OUT.col2 = FFT( w, texture2D( _ReadBuffer2, uv1), texture2D( _ReadBuffer2, uv2));
    #line 167
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a_3 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = fragX_3( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:17(2): warning: empty declaration
0:65(2): warning: empty declaration
0:22(2): warning: empty declaration
0:28(2): warning: empty declaration
0:35(2): warning: empty declaration
0:179(15): error: array index must be < 2
*/


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

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
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
#line 13
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 19
struct f2a_1 {
    highp vec4 col0;
};
#line 24
struct f2a_2 {
    highp vec4 col0;
    highp vec4 col1;
};
#line 30
struct f2a_3 {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
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
#line 9
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
#line 37
#line 46
#line 56
#line 78
#line 100
#line 123
#line 146
#line 46
highp vec4 FFT( in highp vec2 w, in highp vec4 input1, in highp vec4 input2 ) {
    highp float rx = ((w.x * input2.x) - (w.y * input2.y));
    highp float ry = ((w.y * input2.x) + (w.x * input2.y));
    #line 50
    highp float rz = ((w.x * input2.z) - (w.y * input2.w));
    highp float rw = ((w.y * input2.z) + (w.x * input2.w));
    return (input1 + vec4( rx, ry, rz, rw));
}
#line 146
f2a_3 fragX_3( in v2f IN ) {
    highp vec4 lookUp = texture2D( _ButterFlyLookUp, vec2( IN.uv.x, 0.0));
    #line 150
    lookUp.xyz *= 255.0;
    lookUp.xy /= (_Size - 1.0);
    highp float PI = 3.14159;
    #line 154
    highp vec2 w = vec2( cos((((2.0 * PI) * lookUp.z) / _Size)), sin((((2.0 * PI) * lookUp.z) / _Size)));
    if ((lookUp.w > 0.5)){
        w *= -1.0;
    }
    #line 158
    f2a_3 OUT;
    highp vec2 uv1 = vec2( lookUp.x, IN.uv.y);
    highp vec2 uv2 = vec2( lookUp.y, IN.uv.y);
    #line 163
    OUT.col0 = FFT( w, texture2D( _ReadBuffer0, uv1), texture2D( _ReadBuffer0, uv2));
    OUT.col1 = FFT( w, texture2D( _ReadBuffer1, uv1), texture2D( _ReadBuffer1, uv2));
    OUT.col2 = FFT( w, texture2D( _ReadBuffer2, uv1), texture2D( _ReadBuffer2, uv2));
    #line 167
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a_3 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = fragX_3( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:17(2): warning: empty declaration
0:65(2): warning: empty declaration
0:22(2): warning: empty declaration
0:28(2): warning: empty declaration
0:35(2): warning: empty declaration
0:179(15): error: array index must be < 2
*/


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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.x;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = lookUp_2.x;
  tmpvar_6.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = lookUp_2.y;
  tmpvar_7.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_ReadBuffer2, tmpvar_6);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture (_ReadBuffer2, tmpvar_7);
  highp vec4 input1_20;
  input1_20 = tmpvar_18;
  highp vec4 input2_21;
  input2_21 = tmpvar_19;
  highp vec4 tmpvar_22;
  tmpvar_22.x = ((w_1.x * input2_21.x) - (w_1.y * input2_21.y));
  tmpvar_22.y = ((w_1.y * input2_21.x) + (w_1.x * input2_21.y));
  tmpvar_22.z = ((w_1.x * input2_21.z) - (w_1.y * input2_21.w));
  tmpvar_22.w = ((w_1.y * input2_21.z) + (w_1.x * input2_21.w));
  highp vec4 tmpvar_23;
  tmpvar_23 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (input1_15 + tmpvar_17);
  _glesFragData[1] = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (input1_20 + tmpvar_22);
  _glesFragData[2] = tmpvar_25;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 52 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
SetTexture 3 [_ReadBuffer2] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_draw_buffers;
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R4.y, fragment.texcoord[0];
MOV R3.y, fragment.texcoord[0];
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, c[1].z;
ADD R0.y, -R0.x, c[0].x;
MUL R1.xyz, R1, c[1].y;
RCP R0.x, c[0].x;
MUL R1.z, R1, R0.x;
RCP R0.y, R0.y;
MUL R1.xy, R1, R0.y;
MOV R4.x, R1.y;
TEX R0, R4, texture[3], 2D;
MOV R3.x, R1;
ADD R1.y, R1.w, -c[1].w;
MUL R1.z, R1, c[2].x;
SIN R1.w, R1.z;
COS R1.z, R1.z;
CMP R3.zw, -R1.y, -R1, R1;
MUL R1.y, R3.w, R0;
MAD R2.x, R3.z, R0, -R1.y;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
TEX R1, R3, texture[3], 2D;
TEX R0, R4, texture[2], 2D;
ADD result.color[2], R1, R2;
MUL R1.x, R3.w, R0.y;
MAD R2.x, R3.z, R0, -R1;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
TEX R1, R4, texture[1], 2D;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
TEX R0, R3, texture[2], 2D;
ADD result.color[1], R0, R2;
MUL R0.x, R3.w, R1.y;
MUL R0.y, R3.z, R1;
MUL R0.z, R3.w, R1.w;
MUL R0.w, R3.z, R1;
MAD R0.x, R3.z, R1, -R0;
MAD R0.y, R3.w, R1.x, R0;
MAD R0.z, R3, R1, -R0;
MAD R0.w, R3, R1.z, R0;
TEX R1, R3, texture[1], 2D;
ADD result.color, R1, R0;
END
# 52 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 53 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
SetTexture 3 [_ReadBuffer2] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r4.y, v0
mov r3.y, v0
mov r0.y, c1.x
mov r0.x, v0
texld r1, r0, s0
mul r0.xyz, r1, c1.y
rcp r0.w, c0.x
mul r0.z, r0, r0.w
mad r0.w, r0.z, c2.x, c2.y
mov r0.z, c0.x
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r2.xy, r0.w
add r0.z, c1, r0
rcp r0.z, r0.z
mul r1.xy, r0, r0.z
mov r4.x, r1.y
texld r0, r4, s1
add r1.y, r1.w, c1.w
cmp r3.zw, -r1.y, r2.xyxy, -r2.xyxy
mul r1.y, r3.w, r0
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mad r2.x, r3.z, r0, -r1.y
mov r3.x, r1
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
texld r1, r3, s1
texld r0, r4, s2
add oC0, r1, r2
mul r1.x, r3.w, r0.y
mad r2.x, r3.z, r0, -r1
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
texld r1, r4, s3
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
texld r0, r3, s2
add oC1, r0, r2
mul r0.x, r3.w, r1.y
mul r0.y, r3.z, r1
mul r0.z, r3.w, r1.w
mul r0.w, r3.z, r1
mad r0.x, r3.z, r1, -r0
mad r0.y, r3.w, r1.x, r0
mad r0.z, r3, r1, -r0
mad r0.w, r3, r1.z, r0
texld r1, r3, s3
add oC2, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 20 math, 7 textures
SetTexture 0 [_ButterFlyLookUp] 2D 3
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
SetTexture 3 [_ReadBuffer2] 2D 2
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefieceddiobmgmiljdidnehkooekjgebnejpbfhabaaaaaakmafaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmaeaaaaeaaaaaaacpabaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaajgafbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaadaaaaaadcaaaaakfcaabaaaaeaaaaaapgapbaaaaaaaaaaa
agacbaaaadaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaaeaaaaaa
ogakbaaaaaaaaaaaegaabaaaadaaaaaaapaaaaahicaabaaaaeaaaaaaogakbaaa
aaaaaaaaogakbaaaadaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
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


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 20 math, 7 texture
 //        d3d9 : 53 math, 7 texture
 //      opengl : 52 math, 7 texture
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
// Stats: 5 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"3.0-!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
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

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
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
#line 13
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 19
struct f2a_1 {
    highp vec4 col0;
};
#line 24
struct f2a_2 {
    highp vec4 col0;
    highp vec4 col1;
};
#line 30
struct f2a_3 {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
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
#line 9
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
#line 37
#line 46
#line 56
#line 78
#line 100
#line 123
#line 146
#line 46
highp vec4 FFT( in highp vec2 w, in highp vec4 input1, in highp vec4 input2 ) {
    highp float rx = ((w.x * input2.x) - (w.y * input2.y));
    highp float ry = ((w.y * input2.x) + (w.x * input2.y));
    #line 50
    highp float rz = ((w.x * input2.z) - (w.y * input2.w));
    highp float rw = ((w.y * input2.z) + (w.x * input2.w));
    return (input1 + vec4( rx, ry, rz, rw));
}
#line 170
f2a_3 fragY_3( in v2f IN ) {
    #line 172
    highp vec4 lookUp = texture2D( _ButterFlyLookUp, vec2( IN.uv.y, 0.0));
    lookUp.xyz *= 255.0;
    lookUp.xy /= (_Size - 1.0);
    #line 177
    highp float PI = 3.14159;
    highp vec2 w = vec2( cos((((2.0 * PI) * lookUp.z) / _Size)), sin((((2.0 * PI) * lookUp.z) / _Size)));
    if ((lookUp.w > 0.5)){
        w *= -1.0;
    }
    #line 182
    f2a_3 OUT;
    highp vec2 uv1 = vec2( IN.uv.x, lookUp.x);
    highp vec2 uv2 = vec2( IN.uv.x, lookUp.y);
    #line 187
    OUT.col0 = FFT( w, texture2D( _ReadBuffer0, uv1), texture2D( _ReadBuffer0, uv2));
    OUT.col1 = FFT( w, texture2D( _ReadBuffer1, uv1), texture2D( _ReadBuffer1, uv2));
    OUT.col2 = FFT( w, texture2D( _ReadBuffer2, uv1), texture2D( _ReadBuffer2, uv2));
    #line 191
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a_3 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = fragY_3( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:17(2): warning: empty declaration
0:65(2): warning: empty declaration
0:22(2): warning: empty declaration
0:28(2): warning: empty declaration
0:35(2): warning: empty declaration
0:203(15): error: array index must be < 2
*/


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

#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_DESKTOP
    #define SHADER_API_DESKTOP 1
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
#line 13
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 60
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
};
#line 19
struct f2a_1 {
    highp vec4 col0;
};
#line 24
struct f2a_2 {
    highp vec4 col0;
    highp vec4 col1;
};
#line 30
struct f2a_3 {
    highp vec4 col0;
    highp vec4 col1;
    highp vec4 col2;
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
#line 9
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
#line 37
#line 46
#line 56
#line 78
#line 100
#line 123
#line 146
#line 46
highp vec4 FFT( in highp vec2 w, in highp vec4 input1, in highp vec4 input2 ) {
    highp float rx = ((w.x * input2.x) - (w.y * input2.y));
    highp float ry = ((w.y * input2.x) + (w.x * input2.y));
    #line 50
    highp float rz = ((w.x * input2.z) - (w.y * input2.w));
    highp float rw = ((w.y * input2.z) + (w.x * input2.w));
    return (input1 + vec4( rx, ry, rz, rw));
}
#line 170
f2a_3 fragY_3( in v2f IN ) {
    #line 172
    highp vec4 lookUp = texture2D( _ButterFlyLookUp, vec2( IN.uv.y, 0.0));
    lookUp.xyz *= 255.0;
    lookUp.xy /= (_Size - 1.0);
    #line 177
    highp float PI = 3.14159;
    highp vec2 w = vec2( cos((((2.0 * PI) * lookUp.z) / _Size)), sin((((2.0 * PI) * lookUp.z) / _Size)));
    if ((lookUp.w > 0.5)){
        w *= -1.0;
    }
    #line 182
    f2a_3 OUT;
    highp vec2 uv1 = vec2( IN.uv.x, lookUp.x);
    highp vec2 uv2 = vec2( IN.uv.x, lookUp.y);
    #line 187
    OUT.col0 = FFT( w, texture2D( _ReadBuffer0, uv1), texture2D( _ReadBuffer0, uv2));
    OUT.col1 = FFT( w, texture2D( _ReadBuffer1, uv1), texture2D( _ReadBuffer1, uv2));
    OUT.col2 = FFT( w, texture2D( _ReadBuffer2, uv1), texture2D( _ReadBuffer2, uv2));
    #line 191
    return OUT;
}
varying highp vec2 xlv_TEXCOORD0;
void main() {
    f2a_3 xl_retval;
    v2f xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.uv = vec2(xlv_TEXCOORD0);
    xl_retval = fragY_3( xlt_IN);
    gl_FragData[0] = vec4(xl_retval.col0);
    gl_FragData[1] = vec4(xl_retval.col1);
    gl_FragData[2] = vec4(xl_retval.col2);
}
/* NOTE: GLSL optimization failed
0:226(2): warning: empty declaration
0:279(2): warning: empty declaration
0:275(2): warning: empty declaration
0:17(2): warning: empty declaration
0:65(2): warning: empty declaration
0:22(2): warning: empty declaration
0:28(2): warning: empty declaration
0:35(2): warning: empty declaration
0:203(15): error: array index must be < 2
*/


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
uniform sampler2D _ReadBuffer0;
uniform sampler2D _ReadBuffer1;
uniform sampler2D _ReadBuffer2;
uniform sampler2D _ButterFlyLookUp;
uniform highp float _Size;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 w_1;
  highp vec4 lookUp_2;
  highp vec2 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ButterFlyLookUp, tmpvar_3);
  lookUp_2 = tmpvar_4;
  lookUp_2.xyz = (lookUp_2.xyz * 255.0);
  lookUp_2.xy = (lookUp_2.xy / (_Size - 1.0));
  highp vec2 tmpvar_5;
  tmpvar_5.x = cos(((6.28318 * lookUp_2.z) / _Size));
  tmpvar_5.y = sin(((6.28318 * lookUp_2.z) / _Size));
  w_1 = tmpvar_5;
  if ((lookUp_2.w > 0.5)) {
    w_1 = (tmpvar_5 * -1.0);
  };
  highp vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = lookUp_2.x;
  highp vec2 tmpvar_7;
  tmpvar_7.x = xlv_TEXCOORD0.x;
  tmpvar_7.y = lookUp_2.y;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_ReadBuffer0, tmpvar_6);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_ReadBuffer0, tmpvar_7);
  highp vec4 input1_10;
  input1_10 = tmpvar_8;
  highp vec4 input2_11;
  input2_11 = tmpvar_9;
  highp vec4 tmpvar_12;
  tmpvar_12.x = ((w_1.x * input2_11.x) - (w_1.y * input2_11.y));
  tmpvar_12.y = ((w_1.y * input2_11.x) + (w_1.x * input2_11.y));
  tmpvar_12.z = ((w_1.x * input2_11.z) - (w_1.y * input2_11.w));
  tmpvar_12.w = ((w_1.y * input2_11.z) + (w_1.x * input2_11.w));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_ReadBuffer1, tmpvar_6);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_ReadBuffer1, tmpvar_7);
  highp vec4 input1_15;
  input1_15 = tmpvar_13;
  highp vec4 input2_16;
  input2_16 = tmpvar_14;
  highp vec4 tmpvar_17;
  tmpvar_17.x = ((w_1.x * input2_16.x) - (w_1.y * input2_16.y));
  tmpvar_17.y = ((w_1.y * input2_16.x) + (w_1.x * input2_16.y));
  tmpvar_17.z = ((w_1.x * input2_16.z) - (w_1.y * input2_16.w));
  tmpvar_17.w = ((w_1.y * input2_16.z) + (w_1.x * input2_16.w));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture (_ReadBuffer2, tmpvar_6);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture (_ReadBuffer2, tmpvar_7);
  highp vec4 input1_20;
  input1_20 = tmpvar_18;
  highp vec4 input2_21;
  input2_21 = tmpvar_19;
  highp vec4 tmpvar_22;
  tmpvar_22.x = ((w_1.x * input2_21.x) - (w_1.y * input2_21.y));
  tmpvar_22.y = ((w_1.y * input2_21.x) + (w_1.x * input2_21.y));
  tmpvar_22.z = ((w_1.x * input2_21.z) - (w_1.y * input2_21.w));
  tmpvar_22.w = ((w_1.y * input2_21.z) + (w_1.x * input2_21.w));
  highp vec4 tmpvar_23;
  tmpvar_23 = (input1_10 + tmpvar_12);
  _glesFragData[0] = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (input1_15 + tmpvar_17);
  _glesFragData[1] = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (input1_20 + tmpvar_22);
  _glesFragData[2] = tmpvar_25;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 52 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
SetTexture 3 [_ReadBuffer2] 2D 3
"3.0-!!ARBfp1.0
OPTION ARB_draw_buffers;
PARAM c[3] = { program.local[0],
		{ 0, 255, 1, 0.5 },
		{ 6.283185 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.z, c[1];
ADD R0.w, -R0.z, c[0].x;
MOV R4.x, fragment.texcoord[0];
MOV R3.x, fragment.texcoord[0];
MOV R0.y, c[1].x;
MOV R0.x, fragment.texcoord[0].y;
TEX R1, R0, texture[0], 2D;
MUL R0.xyz, R1, c[1].y;
RCP R1.x, R0.w;
MUL R1.xy, R0, R1.x;
MOV R4.y, R1;
RCP R0.w, c[0].x;
MUL R1.z, R0, R0.w;
TEX R0, R4, texture[3], 2D;
MOV R3.y, R1.x;
ADD R1.y, R1.w, -c[1].w;
MUL R1.z, R1, c[2].x;
SIN R1.w, R1.z;
COS R1.z, R1.z;
CMP R3.zw, -R1.y, -R1, R1;
MUL R1.y, R3.w, R0;
MAD R2.x, R3.z, R0, -R1.y;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
TEX R1, R3, texture[3], 2D;
TEX R0, R4, texture[2], 2D;
ADD result.color[2], R1, R2;
MUL R1.x, R3.w, R0.y;
MAD R2.x, R3.z, R0, -R1;
MUL R0.y, R3.z, R0;
MAD R2.y, R3.w, R0.x, R0;
MUL R0.x, R3.w, R0.w;
MUL R0.y, R3.z, R0.w;
TEX R1, R4, texture[1], 2D;
MAD R2.z, R3, R0, -R0.x;
MAD R2.w, R3, R0.z, R0.y;
TEX R0, R3, texture[2], 2D;
ADD result.color[1], R0, R2;
MUL R0.x, R3.w, R1.y;
MUL R0.y, R3.z, R1;
MUL R0.z, R3.w, R1.w;
MUL R0.w, R3.z, R1;
MAD R0.x, R3.z, R1, -R0;
MAD R0.y, R3.w, R1.x, R0;
MAD R0.z, R3, R1, -R0;
MAD R0.w, R3, R1.z, R0;
TEX R1, R3, texture[1], 2D;
ADD result.color, R1, R0;
END
# 52 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 53 math, 7 textures
Float 0 [_Size]
SetTexture 0 [_ButterFlyLookUp] 2D 0
SetTexture 1 [_ReadBuffer0] 2D 1
SetTexture 2 [_ReadBuffer1] 2D 2
SetTexture 3 [_ReadBuffer2] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c1, 0.00000000, 255.00000000, -1.00000000, -0.50000000
def c2, 0.99999970, 0.50000000, 6.28318501, -3.14159298
dcl_texcoord0 v0.xy
mov r4.x, v0
mov r0.y, c1.x
mov r0.x, v0.y
texld r2, r0, s0
mul r0.xyz, r2, c1.y
rcp r0.w, c0.x
mul r0.w, r0.z, r0
mov r0.z, c0.x
mad r0.w, r0, c2.x, c2.y
add r0.z, c1, r0
rcp r0.z, r0.z
mul r3.xy, r0, r0.z
mov r4.y, r3
mov r3.y, r3.x
frc r0.w, r0
mad r0.w, r0, c2.z, c2
sincos r1.xy, r0.w
add r1.z, r2.w, c1.w
cmp r3.zw, -r1.z, r1.xyxy, -r1.xyxy
texld r0, r4, s1
mul r1.x, r3.w, r0.y
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mad r2.x, r3.z, r0, -r1
mov r3.x, v0
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
texld r1, r3, s1
texld r0, r4, s2
add oC0, r1, r2
mul r1.x, r3.w, r0.y
mad r2.x, r3.z, r0, -r1
mul r0.y, r3.z, r0
mad r2.y, r3.w, r0.x, r0
mul r0.x, r3.w, r0.w
mul r0.y, r3.z, r0.w
texld r1, r4, s3
mad r2.z, r3, r0, -r0.x
mad r2.w, r3, r0.z, r0.y
texld r0, r3, s2
add oC1, r0, r2
mul r0.x, r3.w, r1.y
mul r0.y, r3.z, r1
mul r0.z, r3.w, r1.w
mul r0.w, r3.z, r1
mad r0.x, r3.z, r1, -r0
mad r0.y, r3.w, r1.x, r0
mad r0.z, r3, r1, -r0
mad r0.w, r3, r1.z, r0
texld r1, r3, s3
add oC2, r1, r0
"
}
SubProgram "d3d11 " {
// Stats: 20 math, 7 textures
SetTexture 0 [_ButterFlyLookUp] 2D 3
SetTexture 1 [_ReadBuffer0] 2D 0
SetTexture 2 [_ReadBuffer1] 2D 1
SetTexture 3 [_ReadBuffer2] 2D 2
ConstBuffer "$Globals" 32
Float 16 [_Size]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpoffakkidokibemejlineglplkfobookabaaaaaakmafaaaaadaaaaaa
cmaaaaaaieaaaaaaoiaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheofmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafaaaaaaaabaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaafaaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefclmaeaaaaeaaaaaaacpabaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacafaaaaaadgaaaaafbcaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaadaaaaaadbaaaaah
icaabaaaaaaaaaaaabeaaaaaaaaaaadpdkaabaaaaaaaaaaadiaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaahpedaaaahpedmkegmieeaaaaaaaa
aoaaaaaiecaabaaaaaaaaaaackaabaaaaaaaaaaaakiacaaaaaaaaaaaabaaaaaa
enaaaaahbcaabaaaabaaaaaabcaabaaaacaaaaaackaabaaaaaaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaakmcaabaaaaaaaaaaapgapbaaa
aaaaaaaaagaebaiaebaaaaaaabaaaaaaagaebaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaialpaoaaaaahdcaabaaa
abaaaaaaegaabaaaaaaaaaaaagaabaaaabaaaaaadgaaaaafecaabaaaabaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaggakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaaaaaaaaaa
ngafbaaaacaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaaagacbaaa
acaaaaaaagabbaiaebaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaacaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaacaaaaaaaaaaaaahpccabaaaaaaaaaaaegaobaaaadaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaadaaaaaadcaaaaakfcaabaaaaeaaaaaapgapbaaaaaaaaaaa
agacbaaaadaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaaeaaaaaa
ogakbaaaaaaaaaaaegaabaaaadaaaaaaapaaaaahicaabaaaaeaaaaaaogakbaaa
aaaaaaaaogakbaaaadaaaaaaaaaaaaahpccabaaaabaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaadiaaaaahdcaabaaaaaaaaaaakgakbaaa
aaaaaaaangafbaaaabaaaaaadcaaaaakfcaabaaaadaaaaaapgapbaaaaaaaaaaa
agacbaaaabaaaaaaagabbaiaebaaaaaaaaaaaaaaapaaaaahccaabaaaadaaaaaa
ogakbaaaaaaaaaaaegaabaaaabaaaaaaapaaaaahicaabaaaadaaaaaaogakbaaa
aaaaaaaaogakbaaaabaaaaaaaaaaaaahpccabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaadoaaaaab"
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