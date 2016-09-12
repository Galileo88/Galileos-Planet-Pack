// Compiled shader for all platforms, uncompressed size: 18.3KB

Shader "Proland/Ocean/WhiteCapsPrecompute0" {
SubShader { 


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //        d3d9 : 5 math
 //      opengl : 5 math
 // Stats for Fragment shader:
 //       d3d11 : 10 math, 3 texture
 //        d3d9 : 11 math, 3 texture
 //      opengl : 14 math, 3 texture
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

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  gl_FragData[0] = tmpvar_9;
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

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  gl_FragData[0] = tmpvar_9;
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
uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.x;
  tmpvar_9.y = tmpvar_8.x;
  tmpvar_9.z = tmpvar_7.y;
  tmpvar_9.w = tmpvar_8.y;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 14 math, 3 textures
Vector 0 [_Choppyness]
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
"3.0-!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.25 } };
TEMP R0;
TEMP R1;
TEX R1.xy, fragment.texcoord[0], texture[0], 2D;
TEX R0.xy, fragment.texcoord[0], texture[1], 2D;
MUL R0.xy, R0, c[0];
MUL R0.zw, R1.xyxy, c[0].xyxy;
ADD R1.xy, R0.zwzw, R0;
MUL R0.zw, R0, c[0].xyxy;
MAD R1.xy, R0.zwzw, R0, R1;
TEX R0.xy, fragment.texcoord[0], texture[2], 2D;
MUL R0.zw, c[0].xyxy, c[0].xyxy;
MUL R0.xy, R0.zwzw, R0;
MAD R0.xy, -R0, R0, R1;
ADD R0.xy, R0, c[1].x;
MOV result.color.xz, R0.xyyw;
MUL result.color.yw, R0.xxzy, R0.xxzy;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math, 3 textures
Vector 0 [_Choppyness]
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.25000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r1.xy, v0, s0
texld r0.xy, v0, s1
mul r0.xy, r0, c0
mul r0.zw, r1.xyxy, c0.xyxy
add r1.xy, r0.zwzw, r0
mul r0.zw, r0, c0.xyxy
mad r1.xy, r0.zwzw, r0, r1
texld r0.xy, v0, s2
mul r0.zw, c0.xyxy, c0.xyxy
mul r0.xy, r0.zwzw, r0
mad r0.xy, -r0, r0, r1
add r0.xy, r0, c1.x
mov oC0.xz, r0.xyyw
mul oC0.yw, r0.xxzy, r0.xxzy
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
ConstBuffer "$Globals" 32
Vector 16 [_Choppyness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjgfbembmckoinleimdpecdpofheinanoabaaaaaaciadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiacaaaa
eaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakmcaabaaaaaaaaaaa
agiecaaaaaaaaaaaabaaaaaaagaebaaaabaaaaaaagaebaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaabaaaaaaegaabaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaaaaaaaaak
mcaabaaaaaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiado
aaaaiadodcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
ogakbaaaaaaaaaaadiaaaaajmcaabaaaaaaaaaaaagiecaaaaaaaaaaaabaaaaaa
agiecaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagaebaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaogakbaiaebaaaaaa
aaaaaaaaogakbaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaahkccabaaaaaaaaaaa
agaebaaaaaaaaaaaagaebaaaaaaaaaaadgaaaaaffccabaaaaaaaaaaaagabbaaa
aaaaaaaadoaaaaab"
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
 //        d3d9 : 11 math, 3 texture
 //      opengl : 14 math, 3 texture
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

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.z;
  tmpvar_9.y = tmpvar_8.z;
  tmpvar_9.z = tmpvar_7.w;
  tmpvar_9.w = tmpvar_8.w;
  gl_FragData[0] = tmpvar_9;
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

uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.z;
  tmpvar_9.y = tmpvar_8.z;
  tmpvar_9.z = tmpvar_7.w;
  tmpvar_9.w = tmpvar_8.w;
  gl_FragData[0] = tmpvar_9;
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
uniform sampler2D _Map5;
uniform sampler2D _Map6;
uniform sampler2D _Map7;
uniform highp vec4 _Choppyness;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Map5, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Choppyness * tmpvar_1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Map6, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (_Choppyness * tmpvar_3);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Map7, xlv_TEXCOORD0);
  highp vec4 tmpvar_6;
  tmpvar_6 = ((_Choppyness * _Choppyness) * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = ((((0.25 + tmpvar_2) + tmpvar_4) + ((_Choppyness * tmpvar_2) * tmpvar_4)) - (tmpvar_6 * tmpvar_6));
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_7);
  highp vec4 tmpvar_9;
  tmpvar_9.x = tmpvar_7.z;
  tmpvar_9.y = tmpvar_8.z;
  tmpvar_9.z = tmpvar_7.w;
  tmpvar_9.w = tmpvar_8.w;
  _glesFragData[0] = tmpvar_9;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 14 math, 3 textures
Vector 0 [_Choppyness]
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
"3.0-!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.25 } };
TEMP R0;
TEMP R1;
TEX R1.zw, fragment.texcoord[0], texture[1], 2D;
TEX R0.zw, fragment.texcoord[0], texture[0], 2D;
MUL R0.xy, R1.zwzw, c[0].zwzw;
MUL R0.zw, R0, c[0];
ADD R1.xy, R0.zwzw, R0;
MUL R0.zw, R0, c[0];
MAD R1.xy, R0.zwzw, R0, R1;
TEX R0.zw, fragment.texcoord[0], texture[2], 2D;
MUL R0.xy, c[0].zwzw, c[0].zwzw;
MUL R0.xy, R0, R0.zwzw;
MAD R0.xy, -R0, R0, R1;
ADD R0.xy, R0, c[1].x;
MOV result.color.xz, R0.xyyw;
MUL result.color.yw, R0.xxzy, R0.xxzy;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 11 math, 3 textures
Vector 0 [_Choppyness]
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 0.25000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r1.zw, v0, s1
texld r0.zw, v0, s0
mul r0.xy, r1.zwzw, c0.zwzw
mul r0.zw, r0, c0
add r1.xy, r0.zwzw, r0
mul r0.zw, r0, c0
mad r1.xy, r0.zwzw, r0, r1
texld r0.zw, v0, s2
mul r0.xy, c0.zwzw, c0.zwzw
mul r0.xy, r0, r0.zwzw
mad r0.xy, -r0, r0, r1
add r0.xy, r0, c1.x
mov oC0.xz, r0.xyyw
mul oC0.yw, r0.xxzy, r0.xxzy
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 3 textures
SetTexture 0 [_Map5] 2D 0
SetTexture 1 [_Map6] 2D 1
SetTexture 2 [_Map7] 2D 2
ConstBuffer "$Globals" 32
Vector 16 [_Choppyness]
BindCB  "$Globals" 0
"ps_4_0
eefiecedblakjdhbkjeljogabnpihfkgdklfmbgkabaaaaaaciadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiacaaaa
eaaaaaaajkaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaogakbaaa
aaaaaaaaogikcaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakmcaabaaaaaaaaaaa
kgiocaaaaaaaaaaaabaaaaaakgaobaaaabaaaaaaagaebaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaogikcaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaabaaaaaaogakbaaaabaaaaaaogikcaaaaaaaaaaaabaaaaaaaaaaaaak
mcaabaaaaaaaaaaakgaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiado
aaaaiadodcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
ogakbaaaaaaaaaaadiaaaaajmcaabaaaaaaaaaaakgiocaaaaaaaaaaaabaaaaaa
kgiocaaaaaaaaaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahmcaabaaaaaaaaaaakgaobaaa
aaaaaaaakgaobaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaogakbaiaebaaaaaa
aaaaaaaaogakbaaaaaaaaaaaegaabaaaaaaaaaaadiaaaaahkccabaaaaaaaaaaa
agaebaaaaaaaaaaaagaebaaaaaaaaaaadgaaaaaffccabaaaaaaaaaaaagabbaaa
aaaaaaaadoaaaaab"
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