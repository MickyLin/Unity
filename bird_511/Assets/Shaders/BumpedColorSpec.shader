Shader "Bumped Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _SpecMap ("Spec map", 2D) = "white" {}
 _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader { 
 LOD 400
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [unity_Scale]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"!!ARBvp1.0
# 44 ALU
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[22].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[17];
DP4 R2.y, R0, c[16];
DP4 R2.x, R0, c[15];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[20];
DP4 R0.y, R1, c[19];
DP4 R0.x, R1, c[18];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[21];
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[22].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[14];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [unity_Scale]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_2_0
; 47 ALU
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c21.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c24.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c16
dp4 r2.y, r0, c15
dp4 r2.x, r0, c14
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c19
dp4 r0.y, r1, c18
dp4 r0.x, r1, c17
mul r1.xyz, r0.w, c20
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c24.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c21.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c13, r0
dp4 r4.x, c13, r1
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c23.xyxy, c23
mad oT0.xy, v3, c22, c22.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedibkgckcahhgchhkmdhcgldpnmmojmjepabaaaaaanaahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcdeagaaaaeaaaabaa
inabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacafaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaaficaabaaa
abaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaa
egakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
aeaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedidahokkjnpcmbmbcpmhhmefibccnknleabaaaaaakialaaaaaeaaaaaa
daaaaaaaaeaeaaaaeaakaaaaaialaaaaebgpgodjmmadaaaammadaaaaaaacpopp
faadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaeaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
acaacgaaahaaafaaaaaaaaaaadaaaaaaaeaaamaaaaaaaaaaadaaamaaadaabaaa
aaaaaaaaadaabaaaafaabdaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbiaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaaeaaoekaafaaaaadabaaahiaaaaaffia
beaaoekaaeaaaaaeabaaahiabdaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bfaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabgaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabeaaoekaaeaaaaaeaaaaaliabdaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabfaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bgaaoekaaeaaaaaeaaaaahiaaaaaoeiabhaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaacaaoejabhaappkaafaaaaadabaaahia
aaaaffiabbaaoekaaeaaaaaeaaaaaliabaaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabcaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabiaaaakaajaaaaad
abaaabiaafaaoekaaaaaoeiaajaaaaadabaaaciaagaaoekaaaaaoeiaajaaaaad
abaaaeiaahaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaaiaaoekaacaaoeiaajaaaaadadaaaciaajaaoekaacaaoeiaajaaaaad
adaaaeiaakaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaciaaaaaffiaaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffib
aeaaaaaeacaaahoaalaaoekaaaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffja
anaaoekaaeaaaaaeaaaaapiaamaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aoaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefcdeagaaaaeaaaabaainabaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaa
cnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaa
aeaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
aeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaah
hcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaa
aaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaaj
hcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
bcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
eccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaabaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaa
abaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaabaaaaaa
egadbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"!!ARBvp1.0
# 7 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 7 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT1.xy, v4, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhdjhpcchglpgnflfphnmhhhhoocoeiljabaaaaaaaiadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcjmabaaaaeaaaabaaghaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaaldccabaaa
acaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedlhakhcnhplcaifgfhhfmhjhghmkdiclbabaaaaaaciaeaaaaaeaaaaaa
daaaaaaaemabaaaapaacaaaaliadaaaaebgpgodjbeabaaaabeabaaaaaaacpopp
neaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaeaa
adaaabaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapja
aeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeeja
adaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaookaafaaaaad
aaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcjmabaaaaeaaaabaaghaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaa
ogikcaaaaaaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"!!ARBvp1.0
# 20 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[13];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[15].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [unity_Scale]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_2_0
; 21 ALU
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c12
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c13.w, -v0
dp3 oT2.y, r0, r1
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedihmjpoedimnmchnllheglfbccgpljnfmabaaaaaanaaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
emadaaaaeaaaabaandaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaa
agaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
aeaaaaaaogikcaaaaaaaaaaaaeaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaa
abaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaa
cgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaacaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaacaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 128
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedbokigkjicmaeifkonogfenccoljdomanabaaaaaapiagaaaaaeaaaaaa
daaaaaaafeacaaaakiafaaaahaagaaaaebgpgodjbmacaaaabmacaaaaaaacpopp
meabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaeaa
adaaabaaaaaaaaaaabaaaeaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
acaabaaaafaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoeka
acaaookaaeaaaaaeaaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoa
aeaaoejaabaaoekaabaaookaabaaaaacaaaaahiaaeaaoekaafaaaaadabaaahia
aaaaffiaakaaoekaaeaaaaaeaaaaaliaajaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiaalaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiaamaaoeka
aeaaaaaeaaaaahiaaaaaoeiaanaappkaaaaaoejbaiaaaaadacaaaboaabaaoeja
aaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancja
aeaaaaaeabaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeia
abaappjaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefcemadaaaaeaaaabaa
ndaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"!!ARBvp1.0
# 49 ALU
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[23].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[21];
DP4 R0.y, R1, c[20];
DP4 R0.x, R1, c[19];
ADD R0.xyz, R2, R0;
MUL R1.xyz, R0.w, c[22];
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[23].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[3].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_2_0
; 52 ALU
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c23.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c26.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c21
dp4 r0.y, r1, c20
dp4 r0.x, r1, c19
mul r1.xyz, r0.w, c22
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c26.x
mov r0.xyz, c12
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c23.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c9
dp4 r4.y, c15, r0
mov r1, c8
dp4 r4.x, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c13.x
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT4.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v3.xyxy, c25.xyxy, c25
mad oT0.xy, v3, c24, c24.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedohbmmckpjeeembnbjpmllcadlcninmknabaaaaaaiaaiaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcmmagaaaaeaaaabaaldabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaa
ajaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaa
dcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaacaaaaaa
egaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaa
kgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaaacaaaaaaabeaaaaa
aaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedodahodpgboljbpeahbgpcaajaehklebaabaaaaaakeamaaaaaeaaaaaa
daaaaaaafaaeaaaacealaaaaomalaaaaebgpgodjbiaeaaaabiaeaaaaaaacpopp
jmadaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaiaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaacgaaahaaagaaaaaaaaaaadaaaaaaaeaaanaaaaaaaaaaadaaamaaadaabbaa
aaaaaaaaadaabaaaafaabeaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbjaaapka
aaaaiadpaaaaaadpaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffia
bfaaoekaaeaaaaaeabaaahiabeaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bgaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabfaaoekaaeaaaaaeaaaaaliabeaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabgaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bhaaoekaaeaaaaaeaaaaahiaaaaaoeiabiaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaacaaoejabiaappkaafaaaaadabaaahia
aaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaabaakeiaaeaaaaae
aaaaahiabdaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabjaaaakaajaaaaad
abaaabiaagaaoekaaaaaoeiaajaaaaadabaaaciaahaaoekaaaaaoeiaajaaaaad
abaaaeiaaiaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaad
adaaabiaajaaoekaacaaoeiaajaaaaadadaaaciaakaaoekaacaaoeiaajaaaaad
adaaaeiaalaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaad
aaaaaciaaaaaffiaaaaaffiaaeaaaaaeaaaaabiaaaaaaaiaaaaaaaiaaaaaffib
aeaaaaaeacaaahoaamaaoekaaaaaaaiaabaaoeiaafaaaaadaaaaapiaaaaaffja
aoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
apaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappjaaaaaoeia
afaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiabjaaffka
afaaaaadabaaafiaaaaapeiabjaaffkaacaaaaadaeaaadoaabaakkiaabaaomia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaeaaamoaaaaaoeiappppaaaafdeieefcmmagaaaaeaaaabaaldabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaa
fjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaac
agaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaa
aaaaaaaaajaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
acaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaadgaaaaaficaabaaaacaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaacaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaa
acaaaaaabbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
aeaaaaaabbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
aeaaaaaabbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
aeaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaa
diaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaak
icaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
adaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaafaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"!!ARBvp1.0
# 12 ALU
PARAM c[18] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_2_0
; 12 ALU
def c17, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v3.xyxy, c16.xyxy, c16
mad oT0.xy, v3, c15, c15.zwzw
mad oT1.xy, v4, c14, c14.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedjfmnghkibocmfkbjahbjdneabpmlnaklabaaaaaamiadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
eeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 192
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedmloanhpmajodlffgppkjdamepdaneaddabaaaaaafiafaaaaaeaaaaaa
daaaaaaalmabaaaaaiaeaaaanaaeaaaaebgpgodjieabaaaaieabaaaaaaacpopp
diabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaiaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaaaaaaaeaaafaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafajaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeia
aeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoa
adaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaooka
afaaaaadaaaaapiaaaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaakaafaaaaad
abaaaiiaabaaaaiaajaaaakaafaaaaadabaaafiaaaaapeiaajaaaakaacaaaaad
acaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeiappppaaaafdeieefc
eeacaaaaeaaaabaajbaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 16 [unity_Scale]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[13];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[16].w, -vertex.position;
DP3 result.texcoord[2].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_2_0
; 26 ALU
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c12
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c15.w, -v0
dp3 oT2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c13.x
dp3 oT2.z, v2, r2
dp3 oT2.x, r2, v1
mad oT3.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v3.xyxy, c18.xyxy, c18
mad oT0.xy, v3, c17, c17.zwzw
mad oT1.xy, v4, c16, c16.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedgjjfbeokeinhohiomogmiemnimklmljhabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
ajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaadcaaaaal
dccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaa
aaaaaaaaaiaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaacaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaaacaaaaaa
bdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
acaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 192
Vector 128 [unity_LightmapST]
Vector 144 [_MainTex_ST]
Vector 160 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedpladealfamnoafoioilpjpjlkjglcolbabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaiaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaaeaaaaaeabaaadoaaeaaoejaabaaoeka
abaaookaabaaaaacaaaaahiaaeaaoekaafaaaaadabaaahiaaaaaffiaalaaoeka
aeaaaaaeaaaaaliaakaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahiaamaaoeka
aaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiaanaaoekaaeaaaaaeaaaaahia
aaaaoeiaaoaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaabaaaaac
abaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaaeabaaahia
acaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappjaaiaaaaad
acaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoeka
aaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaafaaaakaafaaaaadabaaaiia
abaaaaiaapaaaakaafaaaaadabaaafiaaaaapeiaapaaaakaacaaaaadadaaadoa
abaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacadaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaajaaaaaaogikcaaaaaaaaaaaajaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaakaaaaaakgiocaaaaaaaaaaaakaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaabaaaaaa
aeaaaaaaegiccaaaacaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
acaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaacaaaaaaegiccaaa
acaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaa
abaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaaeaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaaeaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [unity_Scale]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"!!ARBvp1.0
# 75 ALU
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[30].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[28];
DP4 R3.y, R0, c[27];
DP4 R3.x, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[29];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[30].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[14];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [unity_Scale]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_2_0
; 78 ALU
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c29.w
dp4 r0.x, v0, c5
add r1, -r0.x, c15
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mad r1.xyz, r0.w, c21, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c27
dp4 r3.y, r0, c26
dp4 r3.x, r0, c25
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c28
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r1.w, c32.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c29.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c13, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c13, r1
dp4 r4.x, c13, r0
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT0.zw, v3.xyxy, c31.xyxy, c31
mad oT0.xy, v3, c30, c30.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedbfjalhmdeeolnjmellgbmmcgfdhciinaabaaaaaacaalaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcieajaaaaeaaaabaa
gbacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacahaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpdiaaaaai
hcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaai
hcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
lcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaaacaaaaaaegaibaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaa
acaaaaaaegadbaaaacaaaaaabbaaaaaibcaabaaaacaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaa
egakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaa
egiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaa
egaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaa
aeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaa
acaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaa
egiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaa
agaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaa
adaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaa
egaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaaf
pcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaa
adaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
adaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaa
egiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
agaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedfifjjggkjfojnebdpgmkbeiibcblgjjmabaaaaaapabaaaaaaeaaaaaa
daaaaaaapmafaaaaiiapaaaafabaaaaaebgpgodjmeafaaaameafaaaaaaacpopp
eiafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaeaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
acaaacaaaiaaafaaaaaaaaaaacaacgaaahaaanaaaaaaaaaaadaaaaaaaeaabeaa
aaaaaaaaadaaamaaajaabiaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafcbaaapka
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaaeaaoekaafaaaaadabaaahiaaaaaffia
bnaaoekaaeaaaaaeabaaahiabmaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
boaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiabpaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiabnaaoekaaeaaaaaeaaaaaliabmaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiaboaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
bpaaoekaaeaaaaaeaaaaahiaaaaaoeiacaaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaaaaaffjabjaaoekaaeaaaaaeaaaaahia
biaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabkaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiablaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkib
ahaaoekaacaaaaadacaaapiaaaaaaaibafaaoekaacaaaaadaaaaapiaaaaaffib
agaaoekaafaaaaadadaaahiaacaaoejacaaappkaafaaaaadaeaaahiaadaaffia
bjaaoekaaeaaaaaeadaaaliabiaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahia
bkaaoekaadaakkiaadaapeiaafaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeia
aeaaaaaeacaaapiaacaaoeiaadaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeia
adaakkiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaac
abaaabiaaaaaaaiaahaaaaacabaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkia
ahaaaaacabaaaiiaaaaappiaabaaaaacaeaaabiacbaaaakaaeaaaaaeaaaaapia
aaaaoeiaaiaaoekaaeaaaaiaafaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaad
abaaapiaabaaoeiacbaaffkaagaaaaacacaaabiaaaaaaaiaagaaaaacacaaacia
aaaaffiaagaaaaacacaaaeiaaaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaad
aaaaapiaabaaoeiaacaaoeiaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaae
abaaahiaajaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiia
cbaaaakaajaaaaadabaaabiaanaaoekaadaaoeiaajaaaaadabaaaciaaoaaoeka
adaaoeiaajaaaaadabaaaeiaapaaoekaadaaoeiaafaaaaadacaaapiaadaacjia
adaakeiaajaaaaadaeaaabiabaaaoekaacaaoeiaajaaaaadaeaaaciabbaaoeka
acaaoeiaajaaaaadaeaaaeiabcaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoeiaafaaaaadaaaaaiiaadaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaia
adaaaaiaaaaappibaeaaaaaeabaaahiabdaaoekaaaaappiaabaaoeiaacaaaaad
acaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabfaaoekaaeaaaaae
aaaaapiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabgaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefc
ieajaaaaeaaaabaagbacaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaac
ahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaa
aaaaiadpdiaaaaaihcaabaaaacaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaadaaaaaafgafbaaaacaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaacaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
acaaaaaaegaibaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaacaaaaaaegadbaaaacaaaaaabbaaaaaibcaabaaaacaaaaaa
egiocaaaacaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaacaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaacaaaaaaciaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
acaaaaaacjaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
acaaaaaackaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
acaaaaaaclaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
fgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaia
ebaaaaaaadaaaaaaegiocaaaacaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaacaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
fgafbaaaabaaaaaaegiccaaaacaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaajaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
laaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaa
feeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ProjectionParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"!!ARBvp1.0
# 80 ALU
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[31].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[30];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[13];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[31].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[14].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 80 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [unity_Scale]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_2_0
; 83 ALU
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c31.w
dp4 r0.x, v0, c5
add r1, -r0.x, c17
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c29
dp4 r3.y, r0, c28
dp4 r3.x, r0, c27
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r3
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r1.w, c34.x
mov r1.xyz, c12
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
mad r3.xyz, r0, c31.w, -v0
mov r1.xyz, v1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r1.yzxw
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c15, r0
mov r0, c8
dp4 r4.x, c15, r0
mov r1, c9
dp4 r4.y, c15, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c13.x
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT4.xy, r1.z, c14.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mad oT0.zw, v3.xyxy, c33.xyxy, c33
mad oT0.xy, v3, c32, c32.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedhbkpjobedjhbfhfmaljlanpmohhpeibjabaaaaaanaalaaaaadaaaaaa
cmaaaaaapeaaaaaakmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcbmakaaaaeaaaabaaihacaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaae
egiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaiaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaa
ajaaaaaadiaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaa
dgaaaaaficaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaadaaaaaa
egbcbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaaeaaaaaa
fgafbaaaadaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaadaaaaaa
egiicaaaadaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaaaeaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaadaaaaaaegadbaaa
adaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaa
acaaaaaadiaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaa
bbaaaaaibcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaa
bbaaaaaiccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaa
bbaaaaaiecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaah
icaabaaaabaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaa
egacbaaaadaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
adaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaa
aeaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaa
aaaaaaajpcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
adaaaaaadiaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaaegaobaaaafaaaaaa
diaaaaahpcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaaaaaaaaj
pcaabaaaahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaa
aaaaaaajpcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaa
aeaaaaaadcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaaagaabaaaacaaaaaa
egaobaaaagaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaakgakbaaa
acaaaaaaegaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaahaaaaaa
egaobaaaahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaafpcaabaaaafaaaaaa
egaobaaaaeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaa
acaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaak
pcaabaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaa
aeaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaafaaaaaa
deaaaaakpcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaa
acaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaa
ahaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaa
acaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaa
aiaaaaaakgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaa
egiccaaaacaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaah
hccabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaa
acaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaa
egacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaabaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaa
egacbaaaacaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaah
bccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaa
aeaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaafaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedflhnogbfmghjppejpgkconlkccbhbaglabaaaaaaombbaaaaaeaaaaaa
daaaaaaaeiagaaaagmbaaaaadebbaaaaebgpgodjbaagaaaabaagaaaaaaacpopp
jeafaaaahmaaaaaaahaaceaaaaaahiaaaaaahiaaaaaaceaaabaahiaaaaaaaiaa
acaaabaaaaaaaaaaabaaaeaaacaaadaaaaaaaaaaacaaaaaaabaaafaaaaaaaaaa
acaaacaaaiaaagaaaaaaaaaaacaacgaaahaaaoaaaaaaaaaaadaaaaaaaeaabfaa
aaaaaaaaadaaamaaajaabjaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafccaaapka
aaaaiadpaaaaaaaaaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapja
aeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoaadaaeeja
acaaeekaacaaoekaabaaaaacaaaaapiaafaaoekaafaaaaadabaaahiaaaaaffia
boaaoekaaeaaaaaeabaaahiabnaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
bpaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiacaaaoekaaaaappiaaaaaoeia
aiaaaaadabaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaacaaoejaafaaaaad
acaaahiaabaanciaabaamjjaaeaaaaaeabaaahiaabaamjiaabaancjaacaaoeib
afaaaaadabaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeia
aiaaaaadabaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaadaaoekaafaaaaad
acaaahiaaaaaffiaboaaoekaaeaaaaaeaaaaaliabnaakekaaaaaaaiaacaakeia
aeaaaaaeaaaaahiabpaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeia
caaaoekaaeaaaaaeaaaaahiaaaaaoeiacbaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaaaaaoeiaaiaaaaadadaaacoaabaaoeiaaaaaoeiaaiaaaaadadaaaeoa
acaaoejaaaaaoeiaafaaaaadaaaaahiaaaaaffjabkaaoekaaeaaaaaeaaaaahia
bjaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiablaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaahiabmaaoekaaaaappjaaaaaoeiaacaaaaadabaaapiaaaaakkib
aiaaoekaacaaaaadacaaapiaaaaaaaibagaaoekaacaaaaadaaaaapiaaaaaffib
ahaaoekaafaaaaadadaaahiaacaaoejacbaappkaafaaaaadaeaaahiaadaaffia
bkaaoekaaeaaaaaeadaaaliabjaakekaadaaaaiaaeaakeiaaeaaaaaeadaaahia
blaaoekaadaakkiaadaapeiaafaaaaadaeaaapiaaaaaoeiaadaaffiaafaaaaad
aaaaapiaaaaaoeiaaaaaoeiaaeaaaaaeaaaaapiaacaaoeiaacaaoeiaaaaaoeia
aeaaaaaeacaaapiaacaaoeiaadaaaaiaaeaaoeiaaeaaaaaeacaaapiaabaaoeia
adaakkiaacaaoeiaaeaaaaaeaaaaapiaabaaoeiaabaaoeiaaaaaoeiaahaaaaac
abaaabiaaaaaaaiaahaaaaacabaaaciaaaaaffiaahaaaaacabaaaeiaaaaakkia
ahaaaaacabaaaiiaaaaappiaabaaaaacaeaaabiaccaaaakaaeaaaaaeaaaaapia
aaaaoeiaajaaoekaaeaaaaiaafaaaaadabaaapiaabaaoeiaacaaoeiaalaaaaad
abaaapiaabaaoeiaccaaffkaagaaaaacacaaabiaaaaaaaiaagaaaaacacaaacia
aaaaffiaagaaaaacacaaaeiaaaaakkiaagaaaaacacaaaiiaaaaappiaafaaaaad
aaaaapiaabaaoeiaacaaoeiaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaae
abaaahiaakaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkia
abaaoeiaaeaaaaaeaaaaahiaanaaoekaaaaappiaaaaaoeiaabaaaaacadaaaiia
ccaaaakaajaaaaadabaaabiaaoaaoekaadaaoeiaajaaaaadabaaaciaapaaoeka
adaaoeiaajaaaaadabaaaeiabaaaoekaadaaoeiaafaaaaadacaaapiaadaacjia
adaakeiaajaaaaadaeaaabiabbaaoekaacaaoeiaajaaaaadaeaaaciabcaaoeka
acaaoeiaajaaaaadaeaaaeiabdaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
aeaaoeiaafaaaaadaaaaaiiaadaaffiaadaaffiaaeaaaaaeaaaaaiiaadaaaaia
adaaaaiaaaaappibaeaaaaaeabaaahiabeaaoekaaaaappiaabaaoeiaacaaaaad
acaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabgaaoekaaeaaaaae
aaaaapiabfaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabhaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabiaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaaeaaaakaafaaaaadabaaaiiaabaaaaiaccaakkkaafaaaaadabaaafia
aaaapeiaccaakkkaacaaaaadaeaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaeaaamoa
aaaaoeiappppaaaafdeieefcbmakaaaaeaaaabaaihacaaaafjaaaaaeegiocaaa
aaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaacnaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagfaaaaadpccabaaaafaaaaaagiaaaaacaiaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaa
diaaaaahhcaabaaaabaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaabaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
acaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaacaaaaaadcaaaaal
hcaabaaaacaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaa
egacbaaaacaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaa
baaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaacaaaaaadgaaaaaf
icaabaaaacaaaaaaabeaaaaaaaaaiadpdiaaaaaihcaabaaaadaaaaaaegbcbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaadiaaaaaihcaabaaaaeaaaaaafgafbaaa
adaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaaklcaabaaaadaaaaaaegiicaaa
adaaaaaaamaaaaaaagaabaaaadaaaaaaegaibaaaaeaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaadaaaaaaaoaaaaaakgakbaaaadaaaaaaegadbaaaadaaaaaa
bbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacgaaaaaaegaobaaaacaaaaaa
bbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaachaaaaaaegaobaaaacaaaaaa
bbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaciaaaaaaegaobaaaacaaaaaa
diaaaaahpcaabaaaaeaaaaaajgacbaaaacaaaaaaegakbaaaacaaaaaabbaaaaai
bcaabaaaafaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaaaeaaaaaabbaaaaai
ccaabaaaafaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaaaeaaaaaabbaaaaai
ecaabaaaafaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaaaeaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaafaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaacaaaaaabkaabaaaacaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaapgapbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaaihcaabaaaaeaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaaeaaaaaa
egiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaeaaaaaaaaaaaaaj
pcaabaaaafaaaaaafgafbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaadaaaaaa
diaaaaahpcaabaaaagaaaaaafgafbaaaacaaaaaaegaobaaaafaaaaaadiaaaaah
pcaabaaaafaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaaaaaaaajpcaabaaa
ahaaaaaaagaabaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaacaaaaaaaaaaaaaj
pcaabaaaaeaaaaaakgakbaiaebaaaaaaaeaaaaaaegiocaaaacaaaaaaaeaaaaaa
dcaaaaajpcaabaaaagaaaaaaegaobaaaahaaaaaaagaabaaaacaaaaaaegaobaaa
agaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaaeaaaaaakgakbaaaacaaaaaa
egaobaaaagaaaaaadcaaaaajpcaabaaaafaaaaaaegaobaaaahaaaaaaegaobaaa
ahaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaaeaaaaaa
egaobaaaaeaaaaaaegaobaaaafaaaaaaeeaaaaafpcaabaaaafaaaaaaegaobaaa
aeaaaaaadcaaaaanpcaabaaaaeaaaaaaegaobaaaaeaaaaaaegiocaaaacaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
aeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaaeaaaaaa
diaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaafaaaaaadeaaaaak
pcaabaaaacaaaaaaegaobaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaa
diaaaaaihcaabaaaaeaaaaaafgafbaaaacaaaaaaegiccaaaacaaaaaaahaaaaaa
dcaaaaakhcaabaaaaeaaaaaaegiccaaaacaaaaaaagaaaaaaagaabaaaacaaaaaa
egacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaacaaaaaaaiaaaaaa
kgakbaaaacaaaaaaegacbaaaaeaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
acaaaaaaajaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaaaaaaaaahhccabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaajhcaabaaaacaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
acaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
acaaaaaadcaaaaalhcaabaaaacaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaa
acaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaacaaaaaaegacbaaa
acaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaaeaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaabaaaaaahbccabaaa
aeaaaaaaegbcbaaaabaaaaaaegacbaaaacaaaaaabaaaaaaheccabaaaaeaaaaaa
egbcbaaaacaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
afaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaafaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheolaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakeaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaakeaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"!!ARBfp1.0
# 36 ALU, 3 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xw, fragment.texcoord[0], texture[1], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R0.w, R0, c[2];
SLT R1.x, R0.w, c[3];
DP3 R1.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.z, R1.z;
MOV R2.xyz, fragment.texcoord[1];
MAD R2.xyz, R1.z, fragment.texcoord[3], R2;
DP3 R2.w, R2, R2;
MUL R0.xyz, R0, c[2];
MOV result.color.w, R0;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
RSQ R1.w, R2.w;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
MUL R2.xyz, R1.w, R2;
RCP R1.z, R1.z;
DP3 R1.w, R1, R2;
MUL_SAT R2.w, R3.x, R3;
MUL R2.x, R2.w, c[4].w;
DP3 R1.x, R1, fragment.texcoord[1];
MAX R2.w, R1.x, c[4].z;
MAX R1.w, R1, c[4].z;
POW R1.w, R1.w, R2.x;
MUL R2.xyz, R0, c[0];
MOV R1.xyz, c[1];
MUL R1.w, R1, R3;
MUL R2.xyz, R2, R2.w;
MUL R1.xyz, R1, c[0];
MAD R1.xyz, R1, R1.w, R2;
MUL R1.xyz, R1, c[4].x;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"ps_2_0
; 41 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
texld r6, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r3.xyz, r3, c2
mov_pp r5.xyz, t1
texkill r1.xyzw
texld r1, r2, s2
mov r1.x, r1.w
mad_pp r4.xy, r1, c4.z, c4.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r5.xyz, r2.x, t3, r5
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r5, r5
rcp_pp r4.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r5
dp3_pp r2.x, r4, r2
mul_pp_sat r1.x, r6, r6.w
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r5.w, r2.x, r1.x
dp3_pp r2.x, r4, t1
mov r1.x, r5.w
mov_pp r4.xyz, c0
mul r1.x, r1, r6.w
max_pp r2.x, r2, c4
mul_pp r5.xyz, r3, c0
mul_pp r2.xyz, r5, r2.x
mul_pp r4.xyz, c1, r4
mad r1.xyz, r4, r1.x, r2
mul r1.xyz, r1, c4.z
mad_pp r1.xyz, r3, t2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmnonhjkmjdcdegpblhbchchihfkgmkiaabaaaaaaliafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclaaeaaaaeaaaaaaacmabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaabaaaaaa
egbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahecaabaaa
abaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkcogefcagdacgnemkfapdcehcaihiegcabaaaaaaneaiaaaaaeaaaaaa
daaaaaaaeiadaaaaaaaiaaaakaaiaaaaebgpgodjbaadaaaabaadaaaaaaacpppp
miacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
acababaaabacacaaaaaaabaaadaaaaaaaaaaaaaaaaaaagaaabaaadaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaia
adaachlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
acaappkaaeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbabaaaaacacaaabia
aaaakklaabaaaaacacaaaciaaaaapplaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaecaaaaadacaacpiaaaaaoelaacaioekaaiaaaaadabaacbia
adaaoelaadaaoelaahaaaaacabaacbiaabaaaaiaabaaaaacadaaahiaadaaoela
aeaaaaaeadaachiaadaaoeiaabaaaaiaabaaoelaceaaaaacaeaachiaadaaoeia
aeaaaaaeadaacbiaabaappiaaeaaaakaaeaaffkaaeaaaaaeadaacciaabaaffia
aeaaaakaaeaaffkafkaaaaaeadaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaad
adaaciiaadaappibaeaappkaahaaaaacadaaciiaadaappiaagaaaaacadaaceia
adaappiaaiaaaaadadaaciiaadaaoeiaaeaaoeiaaiaaaaadabaacbiaadaaoeia
abaaoelaalaaaaadacaacciaabaaaaiaaeaakkkaalaaaaadabaaabiaadaappia
aeaakkkaafaaaaadabaadciaacaappiaacaaaaiaafaaaaadabaaaciaabaaffia
afaaaakacaaaaaadacaaabiaabaaaaiaabaaffiaafaaaaadabaaabiaacaappia
acaaaaiaabaaaaacadaaahiaaaaaoekaafaaaaadabaaaoiaadaabliaabaablka
afaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachiaaaaaoeiaacaaoeka
afaaaaadadaaciiaaaaappiaacaappkaafaaaaadaeaachiaaaaaoeiaaaaaoeka
aeaaaaaeabaaahiaaeaaoeiaacaaffiaabaaoeiaacaaaaadabaachiaabaaoeia
abaaoeiaaeaaaaaeadaachiaaaaaoeiaacaaoelaabaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefclaaeaaaaeaaaaaaacmabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
adaaaaaaakiacaiaebaaaaaaaaaaaaaaagaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaa
agaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
icaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaa
dkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaa
deaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaa
igadbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
"!!ARBfp1.0
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, c[0];
SLT R1.x, R0.w, c[1];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[3], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].x;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 3 [unity_Lightmap] 2D 3
"ps_2_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s3
def c2, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1.xy
texld r3, t0, s0
mul_pp r0.x, r3.w, c0.w
add_pp r1.x, r0, -c1
cmp r1.x, r1, c2, c2.y
mov_pp r2, -r1.x
texld r1, t1, s3
texkill r2.xyzw
mul_pp r1.xyz, r1.w, r1
mul_pp r2.xyz, r3, c0
mul_pp r1.xyz, r1, r2
mul_pp r1.xyz, r1, c2.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbfbljnmhibadnphdfcpgjlgkfhcmjfnhabaaaaaaiaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
ConstBuffer "$Globals" 128
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednmamnfndbijgglpoljhiaejdggfonchhabaaaaaameadaaaaaeaaaaaa
daaaaaaahaabaaaacaadaaaajaadaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
peaaaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaadaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
aaaappkaaeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbebaaaaababaaapia
ecaaaaadabaacpiaabaaoelaabaioekaafaaaaadabaaciiaabaappiaacaaaaka
afaaaaadabaachiaabaaoeiaabaappiaafaaaaadaaaachiaaaaaoeiaaaaaoeka
afaaaaadacaaciiaaaaappiaaaaappkaafaaaaadacaachiaabaaoeiaaaaaoeia
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefckiabaaaaeaaaaaaagkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"!!ARBfp1.0
# 46 ALU, 5 TEX
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[4], 2D;
TEX R4.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R3.xw, fragment.texcoord[0], texture[1], 2D;
MUL R0.w, R0, c[1];
MAD R4.xy, R4.wyzw, c[3].x, -c[3].y;
SLT R1.x, R0.w, c[2];
MUL R2.xyz, R2.w, R2;
MUL R2.xyz, R2, c[3].z;
MUL R5.xyz, R2.y, c[5];
MAD R5.xyz, R2.x, c[6], R5;
MAD R5.xyz, R2.z, c[4], R5;
DP3 R2.w, R5, R5;
RSQ R2.w, R2.w;
MUL R5.xyz, R2.w, R5;
MUL R4.zw, R4.xyxy, R4.xyxy;
ADD_SAT R3.y, R4.z, R4.w;
DP3 R2.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R2.w;
MAD R5.xyz, R2.w, fragment.texcoord[2], R5;
DP3 R2.w, R5, R5;
RSQ R2.w, R2.w;
ADD R3.y, -R3, c[3];
RSQ R3.y, R3.y;
MUL R5.xyz, R2.w, R5;
RCP R4.z, R3.y;
DP3 R2.w, R4, R5;
MAX R2.w, R2, c[3];
DP3_SAT R5.z, R4, c[4];
DP3_SAT R5.x, R4, c[6];
DP3_SAT R5.y, R4, c[5];
DP3 R2.x, R5, R2;
MUL R0.xyz, R0, c[1];
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[3], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, R2.x;
MUL R1.xyz, R1, c[3].z;
MUL_SAT R1.w, R3.x, R3;
MUL R1.w, R1, c[4];
MUL R2.xyz, R1, c[0];
POW R1.w, R2.w, R1.w;
MUL R2.xyz, R2, R3.w;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
END
# 46 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
"ps_2_0
; 49 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
texld r0, t0, s0
texld r4, t0, s1
texld r5, t1, s4
mul_pp r1.x, r0.w, c1.w
mul_pp r5.xyz, r5.w, r5
mul_pp r5.xyz, r5, c4.w
mul r6.xyz, r5.y, c5
mad r6.xyz, r5.x, c6, r6
add_pp r2.x, r1, -c2
cmp r2.x, r2, c3, c3.y
mov_pp r2, -r2.x
mul_pp_sat r4.x, r4, r4.w
mad r6.xyz, r5.z, c4, r6
mul_pp r4.x, r4, c5.w
mov r3.y, t0.w
mov r3.x, t0.z
mul_pp r0.xyz, r0, c1
mov_pp r0.w, r1.x
texld r3, r3, s2
texkill r2.xyzw
texld r2, t1, s3
dp3 r3.x, r6, r6
rsq r3.x, r3.x
mul r6.xyz, r3.x, r6
mov r3.x, r3.w
mad_pp r8.xy, r3, c3.z, c3.w
dp3_pp r3.x, t2, t2
rsq_pp r3.x, r3.x
mad_pp r3.xyz, r3.x, t2, r6
mul_pp r7.xy, r8, r8
add_pp_sat r6.x, r7, r7.y
dp3_pp r7.x, r3, r3
add_pp r6.x, -r6, c3.y
rsq_pp r6.x, r6.x
rcp_pp r8.z, r6.x
rsq_pp r7.x, r7.x
mul_pp r3.xyz, r7.x, r3
dp3_pp r3.x, r8, r3
max_pp r3.x, r3, c3
dp3_pp_sat r6.z, r8, c4
dp3_pp_sat r6.y, r8, c5
dp3_pp_sat r6.x, r8, c6
dp3_pp r5.x, r6, r5
mul_pp r2.xyz, r2.w, r2
mul_pp r2.xyz, r2, r5.x
pow r5.x, r3.x, r4.x
mul_pp r2.xyz, r2, c4.w
mul_pp r3.xyz, r2, c0
mov r4.x, r5.x
mul_pp r3.xyz, r3, r4.w
mul r3.xyz, r3, r4.x
mad_pp r0.xyz, r0, r2, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkmopadbfjpffadllocooojnamocpicanabaaaaaahmahaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcimagaaaaeaaaaaaakdabaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaa
aeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaa
ffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaa
acaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaa
adaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaa
egacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahccaabaaaabaaaaaa
dkaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaapcaaaak
bcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
adaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahccaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahecaabaaaabaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaakgakbaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaa
agajbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaa
abaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagijcaaaaaaaaaaa
acaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaaaeaaaaaafgaobaaaabaaaaaa
dcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedfmfjehjjfmfdnkpjkgopnaaeglkmmfccabaaaaaagealaaaaaeaaaaaa
daaaaaaabeaeaaaakiakaaaadaalaaaaebgpgodjnmadaaaanmadaaaaaaacpppp
imadaaaafaaaaaaaacaadiaaaaaafaaaaaaafaaaafaaceaaaaaafaaaaaaaaaaa
acababaaabacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaahaa
abaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialpaaaaaaaa
aaaaiadpfbaaaaafaeaaapkaomafnblopdaedfdpdkmnbddpaaaaaaedfbaaaaaf
afaaapkaolafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafagaaapkaaaaaaaeb
dkmnbddpaaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaajaaaaiapkabpaaaaac
aaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapka
bpaaaaacaaaaaajaaeaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbabaaaaac
acaaabiaaaaakklaabaaaaacacaaaciaaaaapplaebaaaaababaaapiaecaaaaad
abaacpiaabaaoelaadaioekaecaaaaadacaacpiaacaaoeiaabaioekaecaaaaad
adaacpiaabaaoelaaeaioekaecaaaaadaeaacpiaaaaaoelaacaioekaafaaaaad
aaaachiaaaaaoeiaabaaoekaafaaaaadafaaciiaaaaappiaabaappkaafaaaaad
aaaaciiaabaappiaagaaaakaafaaaaadabaachiaabaaoeiaaaaappiaaeaaaaae
agaacbiaacaappiaadaaaakaadaaffkaaeaaaaaeagaacciaacaaffiaadaaaaka
adaaffkafkaaaaaeaaaadiiaagaaoeiaagaaoeiaadaakkkaacaaaaadaaaaciia
aaaappibadaappkaahaaaaacaaaaciiaaaaappiaagaaaaacagaaceiaaaaappia
aiaaaaadacaadbiaagaablkaagaaoeiaaiaaaaadacaadciaaeaaoekaagaaoeia
aiaaaaadacaadeiaafaaoekaagaaoeiaafaaaaadaaaaciiaadaappiaagaaaaka
afaaaaadadaachiaadaaoeiaaaaappiaaiaaaaadaaaaciiaacaaoeiaadaaoeia
afaaaaadabaachiaaaaappiaabaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoeia
afaaaaadabaachiaabaaoeiaaaaaoekaafaaaaadacaaahiaadaaffiaaeaaoeka
aeaaaaaeacaaahiaadaaaaiaagaablkaacaaoeiaaeaaaaaeacaaahiaadaakkia
afaaoekaacaaoeiaaiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaacaaaaaiia
aaaappiaceaaaaacadaachiaacaaoelaaeaaaaaeacaachiaacaaoeiaaaaappia
adaaoeiaceaaaaacadaachiaacaaoeiaaiaaaaadaaaaciiaagaaoeiaadaaoeia
alaaaaadabaaaiiaaaaappiaadaakkkaafaaaaadaaaadiiaaeaappiaaeaaaaia
afaaaaadabaaahiaaeaappiaabaaoeiaafaaaaadaaaaaiiaaaaappiaaeaappka
caaaaaadacaacbiaabaappiaaaaappiaaeaaaaaeafaachiaabaaoeiaacaaaaia
aaaaoeiaabaaaaacaaaicpiaafaaoeiappppaaaafdeieefcimagaaaaeaaaaaaa
kdabaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaa
adaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaaadaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaak
hcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdp
aaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaa
kgakbaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaa
egacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaa
ddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaaf
ecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dicaaaahccaabaaaabaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaah
ccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddp
aaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaa
omafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaa
aeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaa
diaaaaahecaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaakgakbaaaabaaaaaadiaaaaahocaabaaa
abaaaaaafgafbaaaabaaaaaaagajbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaajgahbaaaabaaaaaadiaaaaaiocaabaaaabaaaaaafgaobaaa
abaaaaaaagijcaaaaaaaaaaaacaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
aeaaaaaafgaobaaaabaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaa
agaabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"!!ARBfp1.0
# 38 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TXP R3.x, fragment.texcoord[4], texture[3], 2D;
MUL R0.w, R0, c[2];
MAD R2.xy, R2.wyzw, c[4].x, -c[4].y;
MUL R2.zw, R2.xyxy, R2.xyxy;
SLT R1.x, R0.w, c[3];
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
ADD_SAT R2.z, R2, R2.w;
RSQ R1.y, R1.y;
MOV R3.yzw, fragment.texcoord[1].xxyz;
MAD R3.yzw, R1.y, fragment.texcoord[3].xxyz, R3;
DP3 R1.y, R3.yzww, R3.yzww;
RSQ R1.z, R1.y;
ADD R1.y, -R2.z, c[4];
RSQ R1.y, R1.y;
RCP R2.z, R1.y;
MUL R3.yzw, R1.z, R3;
DP3 R1.y, R2, R3.yzww;
DP3 R2.x, R2, fragment.texcoord[1];
MAX R2.w, R2.x, c[4].z;
MOV R2.xyz, c[1];
MAX R1.y, R1, c[4].z;
MUL R0.xyz, R0, c[2];
MUL R2.xyz, R2, c[0];
MOV result.color.w, R0;
KIL -R1.x;
TEX R1.xw, fragment.texcoord[0], texture[1], 2D;
MUL_SAT R1.x, R1, R1.w;
MUL R1.x, R1, c[4].w;
POW R1.x, R1.y, R1.x;
MUL R1.w, R1.x, R1;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R1, R2.w;
MUL R2.w, R3.x, c[4].x;
MAD R1.xyz, R2, R1.w, R1;
MUL R1.xyz, R1, R2.w;
MAD result.color.xyz, R0, fragment.texcoord[2], R1;
END
# 38 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
"ps_2_0
; 42 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r5, t0, s1
texld r3, t0, s0
texldp r7, t4, s3
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r3.xyz, r3, c2
mov_pp r6.xyz, t1
texkill r1.xyzw
texld r1, r2, s2
mov r1.x, r1.w
mad_pp r4.xy, r1, c4.z, c4.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t3, t3
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t3, r6
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r6, r6
rcp_pp r4.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r6
mul_pp_sat r1.x, r5, r5.w
dp3_pp r2.x, r4, r2
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r4, t1
mov r1.x, r6.x
max_pp r2.x, r2, c4
mul_pp r4.xyz, r3, c0
mul_pp r5.xyz, r4, r2.x
mov_pp r4.xyz, c0
mul r1.x, r1, r5.w
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r7, c4.z
mad r1.xyz, r4, r1.x, r5
mul r1.xyz, r1, r2.x
mad_pp r1.xyz, r3, t2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedinkkgekifblpffabneefogeglekmkdhcabaaaaaafeagaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeafaaaa
eaaaaaaaenabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaam
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaia
ebaaaaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaaaeaaaaaaagaabaaaabaaaaaa
egbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
ogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaa
acaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaa
egaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadicaaaahecaabaaa
abaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaaj
hcaabaaaabaaaaaaegacbaaaacaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjhhagpmaceoncbngmpeiokmeocilpmogabaaaaaaneajaaaaaeaaaaaa
daaaaaaakmadaaaaoiaiaaaakaajaaaaebgpgodjheadaaaaheadaaaaaaacpppp
bmadaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaadaaaaaa
aaababaaacacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaa
aaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaachlabpaaaaacaaaaaaiaaeaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkaecaaaaadaaaacpiaaaaaoelaabaioeka
abaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappiaadaaaakb
abaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaagaaaaacacaaaeia
aeaapplaafaaaaadadaaadiaacaakkiaaeaaoelaebaaaaababaaapiaecaaaaad
abaacpiaacaaoeiaacaioekaecaaaaadacaacpiaaaaaoelaadaioekaecaaaaad
adaacpiaadaaoeiaaaaioekaaiaaaaadabaacbiaadaaoelaadaaoelaahaaaaac
abaacbiaabaaaaiaabaaaaacaeaaahiaadaaoelaaeaaaaaeaeaachiaaeaaoeia
abaaaaiaabaaoelaceaaaaacafaachiaaeaaoeiaaeaaaaaeaeaacbiaabaappia
aeaaaakaaeaaffkaaeaaaaaeaeaacciaabaaffiaaeaaaakaaeaaffkafkaaaaae
aeaadiiaaeaaoeiaaeaaoeiaaeaakkkaacaaaaadaeaaciiaaeaappibaeaappka
ahaaaaacaeaaciiaaeaappiaagaaaaacaeaaceiaaeaappiaaiaaaaadaeaaciia
aeaaoeiaafaaoeiaaiaaaaadabaacbiaaeaaoeiaabaaoelaalaaaaadacaaccia
abaaaaiaaeaakkkaalaaaaadabaaabiaaeaappiaaeaakkkaafaaaaadabaadcia
acaappiaacaaaaiaafaaaaadabaaaciaabaaffiaafaaaakacaaaaaadacaaabia
abaaaaiaabaaffiaafaaaaadabaaabiaacaappiaacaaaaiaabaaaaacaeaaahia
aaaaoekaafaaaaadabaaaoiaaeaabliaabaablkaafaaaaadabaaahiaabaaaaia
abaabliaafaaaaadaaaachiaaaaaoeiaacaaoekaafaaaaadaeaaciiaaaaappia
acaappkaafaaaaadadaacoiaaaaabliaaaaablkaafaaaaadaaaachiaaaaaoeia
acaaoelaaeaaaaaeabaaahiaadaabliaacaaffiaabaaoeiaacaaaaadaaaaaiia
adaaaaiaadaaaaiaaeaaaaaeaeaachiaabaaoeiaaaaappiaaaaaoeiaabaaaaac
aaaicpiaaeaaoeiappppaaaafdeieefcdeafaaaaeaaaaaaaenabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagcbaaaadlcbabaaaafaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegbcbaaaaeaaaaaaagaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaa
acaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
acaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaa
agaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaa
acaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaafaaaaaapgbpbaaaafaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
acaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
keaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaakeaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaahahaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaa
afaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"!!ARBfp1.0
# 16 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[1], texture[4], 2D;
TXP R3.x, fragment.texcoord[2], texture[3], 2D;
MUL R0.w, R0, c[0];
SLT R1.x, R0.w, c[1];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.xyz, R2.w, R2;
MUL R2.xyz, R2, R3.x;
MUL R1.xyz, R1, c[2].x;
MUL R3.xyz, R1, R3.x;
MUL R2.xyz, R2, c[2].y;
MIN R1.xyz, R1, R2;
MAX R1.xyz, R1, R3;
MUL result.color.xyz, R0, R1;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_2_0
; 15 ALU, 4 TEX
dcl_2d s0
dcl_2d s3
dcl_2d s4
def c2, 0.00000000, 1.00000000, 8.00000000, 2.00000000
dcl t0.xy
dcl t1.xy
dcl t2
texldp r2, t2, s3
texld r3, t0, s0
mul_pp r0.x, r3.w, c0.w
add_pp r1.x, r0, -c1
cmp r1.x, r1, c2, c2.y
mov_pp r1, -r1.x
texkill r1.xyzw
texld r1, t1, s4
mul_pp r4.xyz, r1.w, r1
mul_pp r1.xyz, r1, r2.x
mul_pp r4.xyz, r4, c2.z
mul_pp r1.xyz, r1, c2.w
mul_pp r2.xyz, r4, r2.x
min_pp r1.xyz, r4, r1
max_pp r1.xyz, r1, r2
mul_pp r2.xyz, r3, c0
mul_pp r1.xyz, r2, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 192
Vector 112 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpaikddmomaiehcjdgkaokdadaglffociabaaaaaaimadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_ShadowMapTexture] 2D 0
SetTexture 2 [unity_Lightmap] 2D 2
ConstBuffer "$Globals" 192
Vector 112 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhajhhojfgbhpkboahaffblnmbmjkpcgbabaaaaaagiafaaaaaeaaaaaa
daaaaaaaaiacaaaakmaeaaaadeafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
iiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaahaaabaaaaaaaaaaaaaaaaaaalaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaaaaappka
aeaaaaaeabaacpiaaaaappiaabaappiaabaaaakbagaaaaacacaaaiiaacaappla
afaaaaadacaaadiaacaappiaacaaoelaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaaaaioekaecaaaaadacaacpiaabaaoelaacaioekaacaaaaadabaaccia
abaaaaiaabaaaaiaafaaaaadabaacoiaacaabliaabaaffiaafaaaaadacaaciia
acaappiaacaaaakaafaaaaadacaachiaacaaoeiaacaappiaakaaaaadadaachia
abaabliaacaaoeiaafaaaaadabaachiaabaaaaiaacaaoeiaalaaaaadacaachia
adaaoeiaabaaoeiaafaaaaadaaaachiaaaaaoeiaaaaaoekaafaaaaadabaaciia
aaaappiaaaaappkaafaaaaadabaachiaacaaoeiaaaaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaamaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaalaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaa
acaaaaaaddaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadeaaaaah
hcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"!!ARBfp1.0
# 52 ALU, 6 TEX
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R4, fragment.texcoord[1], texture[5], 2D;
TXP R6.x, fragment.texcoord[3], texture[3], 2D;
TEX R3.xw, fragment.texcoord[0], texture[1], 2D;
TEX R2.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R0.w, R0, c[1];
SLT R1.x, R0.w, c[2];
MUL R4.xyz, R4.w, R4;
MUL R4.xyz, R4, c[3].z;
MUL R5.xyz, R4.y, c[5];
MAD R5.xyz, R4.x, c[6], R5;
MAD R5.xyz, R4.z, c[4], R5;
DP3 R2.x, R5, R5;
RSQ R2.z, R2.x;
MAD R2.xy, R2.wyzw, c[3].x, -c[3].y;
MUL R5.xyz, R2.z, R5;
MUL R2.zw, R2.xyxy, R2.xyxy;
ADD_SAT R2.z, R2, R2.w;
DP3 R3.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.w, R3.y;
MAD R5.xyz, R2.w, fragment.texcoord[2], R5;
ADD R2.w, -R2.z, c[3].y;
DP3 R2.z, R5, R5;
RSQ R3.y, R2.w;
RSQ R2.w, R2.z;
RCP R2.z, R3.y;
DP3_SAT R6.w, R2, c[4];
DP3_SAT R6.y, R2, c[6];
DP3_SAT R6.z, R2, c[5];
MUL R5.xyz, R2.w, R5;
DP3 R2.w, R6.yzww, R4;
DP3 R2.x, R2, R5;
MUL R0.xyz, R0, c[1];
MOV result.color.w, R0;
KIL -R1.x;
TEX R1, fragment.texcoord[1], texture[4], 2D;
MUL R4.xyz, R1.w, R1;
MUL R4.xyz, R4, R2.w;
MUL R1.xyz, R1, R6.x;
MUL_SAT R1.w, R3.x, R3;
MUL R4.xyz, R4, c[3].z;
MUL R6.yzw, R1.xxyz, c[3].x;
MUL R1.xyz, R4, R6.x;
MAX R2.w, R2.x, c[3];
MIN R6.xyz, R4, R6.yzww;
MUL R1.w, R1, c[4];
MUL R2.xyz, R4, c[0];
MAX R1.xyz, R6, R1;
POW R1.w, R2.w, R1.w;
MUL R2.xyz, R2, R3.w;
MUL R2.xyz, R2, R1.w;
MAD result.color.xyz, R0, R1, R2;
END
# 52 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"ps_2_0
; 54 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c3, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1.xy
dcl t2.xyz
dcl t3
texld r5, t0, s1
texld r0, t0, s0
texld r4, t1, s4
texld r6, t1, s5
mul_pp r1.x, r0.w, c1.w
add_pp r2.x, r1, -c2
cmp r2.x, r2, c3, c3.y
mov_pp r2, -r2.x
mul_pp r6.xyz, r6.w, r6
mul_pp r6.xyz, r6, c4.w
mul r7.xyz, r6.y, c5
mad r7.xyz, r6.x, c6, r7
mul_pp_sat r5.x, r5, r5.w
mad r7.xyz, r6.z, c4, r7
dp3_pp r8.x, t2, t2
mul_pp r5.x, r5, c5.w
mov r3.y, t0.w
mov r3.x, t0.z
mul_pp r0.xyz, r0, c1
mov_pp r0.w, r1.x
texld r3, r3, s2
texkill r2.xyzw
texldp r2, t3, s3
dp3 r3.x, r7, r7
rsq r3.x, r3.x
mul r7.xyz, r3.x, r7
mov r3.x, r3.w
mad_pp r9.xy, r3, c3.z, c3.w
rsq_pp r3.x, r8.x
mad_pp r3.xyz, r3.x, t2, r7
mul_pp r7.xy, r9, r9
add_pp_sat r7.x, r7, r7.y
dp3_pp r8.x, r3, r3
rsq_pp r8.x, r8.x
add_pp r7.x, -r7, c3.y
rsq_pp r7.x, r7.x
mul_pp r3.xyz, r8.x, r3
rcp_pp r9.z, r7.x
dp3_pp r3.x, r9, r3
max_pp r3.x, r3, c3
pow r7.x, r3.x, r5.x
dp3_pp_sat r3.z, r9, c4
dp3_pp_sat r3.y, r9, c5
dp3_pp_sat r3.x, r9, c6
mul_pp r5.xyz, r4.w, r4
mul_pp r4.xyz, r4, r2.x
dp3_pp r3.x, r3, r6
mul_pp r3.xyz, r5, r3.x
mul_pp r3.xyz, r3, c4.w
mul_pp r4.xyz, r4, c3.z
min_pp r4.xyz, r3, r4
mul_pp r2.xyz, r3, r2.x
mul_pp r3.xyz, r3, c0
max_pp r2.xyz, r4, r2
mov r4.x, r7.x
mul_pp r3.xyz, r3, r5.w
mul r3.xyz, r3, r4.x
mad_pp r0.xyz, r0, r2, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 192
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfacpbobobdmlleagpchbfchnfdbfdiihabaaaaaaiiaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaahaaaaeaaaaaaaoaabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaa
abaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaabaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaacaaaaaa
aceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaabaaaaaabacaaaak
ccaabaaaacaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaa
abaaaaaabacaaaakecaabaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaa
eghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
adaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
pgapbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaa
diaaaaahhcaabaaaaeaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaaaoaaaaah
dcaabaaaafaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaafaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaabaaaaaaakaabaaaafaaaaaaakaabaaaafaaaaaadiaaaaahhcaabaaa
afaaaaaaegacbaaaaeaaaaaaagaabaaaafaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaabaaaaaaddaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaa
egiccaaaaaaaaaaaacaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaaafaaaaaa
egacbaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaakhcaabaaa
acaaaaaafgafbaaaadaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaa
dcaaaaamhcaabaaaacaaaaaaagaabaaaadaaaaaaaceaaaaaolaffbdpaaaaaaaa
dkmnbddpaaaaaaaaegacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaa
adaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhcaabaaaadaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaaaacpaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadicaaaah
bcaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaa
abaaaaaapgapbaaaabaaaaaaagajbaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaabaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaajhccabaaaaaaaaaaajgahbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_ShadowMapTexture] 2D 0
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 192
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 176 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednbcmhgonpbooomlnjbackhhecokajmfgabaaaaaabeanaaaaaeaaaaaa
daaaaaaaliaeaaaaeaamaaaaoaamaaaaebgpgodjiaaeaaaaiaaeaaaaaaacpppp
caaeaaaagaaaaaaaadaadmaaaaaagaaaaaaagaaaagaaceaaaaaagaaaadaaaaaa
aaababaaacacacaaabadadaaaeaeaeaaafafafaaaaaaacaaabaaaaaaaaaaaaaa
aaaaahaaabaaabaaaaaaaaaaaaaaalaaabaaacaaaaaaaaaaaaacppppfbaaaaaf
adaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafaeaaapkaaaaaaaeb
dkmnbddpaaaaaaaaolaffbdpfbaaaaafafaaapkaomafnblopdaedfdpdkmnbddp
aaaaaaedfbaaaaafagaaapkaolafnblopdaedflpdkmnbddpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaachla
bpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaajaadaiapkabpaaaaac
aaaaaajaaeaiapkabpaaaaacaaaaaajaafaiapkaecaaaaadaaaacpiaaaaaoela
abaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappia
acaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaagaaaaac
acaaaeiaadaapplaafaaaaadadaaadiaacaakkiaadaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaacaioekaecaaaaadacaacpiaabaaoelaafaioeka
ecaaaaadaeaacpiaabaaoelaaeaioekaecaaaaadadaacpiaadaaoeiaaaaioeka
ecaaaaadafaacpiaaaaaoelaadaioekaaeaaaaaeagaacbiaabaappiaadaaaaka
adaaffkaaeaaaaaeagaacciaabaaffiaadaaaakaadaaffkafkaaaaaeagaadiia
agaaoeiaagaaoeiaadaakkkaacaaaaadagaaciiaagaappibadaappkaahaaaaac
agaaciiaagaappiaagaaaaacagaaceiaagaappiaaiaaaaadabaadbiaaeaablka
agaaoeiaaiaaaaadabaadciaafaaoekaagaaoeiaaiaaaaadabaadeiaagaaoeka
agaaoeiaafaaaaadabaaciiaacaappiaaeaaaakaafaaaaadacaachiaacaaoeia
abaappiaaiaaaaadacaaciiaabaaoeiaacaaoeiaafaaaaadaeaaciiaaeaappia
aeaaaakaafaaaaadabaachiaaeaaoeiaaeaappiaafaaaaadabaachiaacaappia
abaaoeiaacaaaaadabaaciiaadaaaaiaadaaaaiaafaaaaadadaachiaadaaaaia
abaaoeiaafaaaaadaeaachiaaeaaoeiaabaappiaakaaaaadahaachiaaeaaoeia
abaaoeiaafaaaaadabaachiaabaaoeiaaaaaoekaalaaaaadaeaachiaahaaoeia
adaaoeiaafaaaaadaaaachiaaaaaoeiaabaaoekaafaaaaadadaaciiaaaaappia
abaappkaafaaaaadaaaachiaaeaaoeiaaaaaoeiaafaaaaadaeaaahiaacaaffia
afaaoekaaeaaaaaeaeaaahiaacaaaaiaaeaablkaaeaaoeiaaeaaaaaeacaaahia
acaakkiaagaaoekaaeaaoeiaaiaaaaadaaaaaiiaacaaoeiaacaaoeiaahaaaaac
aaaaaiiaaaaappiaceaaaaacaeaachiaacaaoelaaeaaaaaeacaachiaacaaoeia
aaaappiaaeaaoeiaceaaaaacaeaachiaacaaoeiaaiaaaaadaaaaciiaagaaoeia
aeaaoeiaalaaaaadabaaaiiaaaaappiaadaakkkaafaaaaadaaaadiiaafaappia
afaaaaiaafaaaaadabaaahiaafaappiaabaaoeiaafaaaaadaaaaaiiaaaaappia
afaappkacaaaaaadacaacbiaabaappiaaaaappiaaeaaaaaeadaachiaabaaoeia
acaaaaiaaaaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefciaahaaaa
eaaaaaaaoaabaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaad
aagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
fibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaadlcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
agaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaalaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaabaaaaaahgapbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaabaaaaaaegaabaaaabaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
abaaaaaadkaabaaaabaaaaaaapcaaaakbcaabaaaacaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaabaaaaaabacaaaakccaabaaaacaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaabaaaaaabacaaaak
ecaabaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
abaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaacaaaaaaeghobaaaafaaaaaa
aagabaaaafaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaadaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaa
diaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaah
hcaabaaaaeaaaaaaegacbaaaacaaaaaapgapbaaaacaaaaaadiaaaaahhcaabaaa
aeaaaaaapgapbaaaabaaaaaaegacbaaaaeaaaaaaaoaaaaahdcaabaaaafaaaaaa
egbabaaaaeaaaaaapgbpbaaaaeaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
afaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaabaaaaaa
akaabaaaafaaaaaaakaabaaaafaaaaaadiaaaaahhcaabaaaafaaaaaaegacbaaa
aeaaaaaaagaabaaaafaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
pgapbaaaabaaaaaaddaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
aeaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaeaaaaaaegiccaaaaaaaaaaa
acaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaacaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaafgafbaaa
adaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaa
acaaaaaaagaabaaaadaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaa
egacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaakgakbaaaadaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaacaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaabaaaaaahicaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaa
adaaaaaapgapbaaaabaaaaaaegbcbaaaadaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaaaaaaaaaegacbaaa
acaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaaacpaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadicaaaahbcaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaapgapbaaa
abaaaaaaagajbaaaaeaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaeddiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaabjaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaa
aaaaaaaajgahbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
; 37 ALU
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlfcaebddpoamihbcaipmgkldbbpbhgmfabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefieceddnmgmgnoadapanamlhapiepomobbcdkbabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"!!ARBvp1.0
# 26 ALU
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[9];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[11].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[10];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_2_0
; 29 ALU
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c13.x
mov r0.xyz, c8
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c9, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c9, r0
dp4 r4.x, c9, r1
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
mad oT0.zw, v3.xyxy, c12.xyxy, c12
mad oT0.xy, v3, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefieceddidoeglnoclniiciglgnbihhmimfilpeabaaaaaakeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaal
mccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaa
aaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
pgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefieceddcebcgggkobfnkmcoihceejelbmpglakabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaamiacaaaapaagaaaaliahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
cmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaaeaa
acaaabaaaaaaaaaaabaaaeaaabaaadaaaaaaaaaaacaaaaaaabaaaeaaaaaaaaaa
adaaaaaaaeaaafaaaaaaaaaaadaabaaaafaaajaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjabpaaaaacafaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoeka
abaaookaaeaaaaaeaaaaamoaadaaeejaacaaeekaacaaoekaabaaaaacaaaaapia
aeaaoekaafaaaaadabaaahiaaaaaffiaakaaoekaaeaaaaaeabaaahiaajaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaalaaoekaaaaakkiaabaaoeiaaeaaaaae
aaaaahiaamaaoekaaaaappiaaaaaoeiaaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaadaaoekaafaaaaadacaaahiaaaaaffiaakaaoekaaeaaaaae
aaaaaliaajaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiaalaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiaamaaoekaaeaaaaaeaaaaahiaaaaaoeia
anaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaagaaoekaaeaaaaaeaaaaapiaafaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaahaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefccaaeaaaaeaaaabaaaiabaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaa
jgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaa
acaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
acaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
cccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
acaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaa
abaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaa
aeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
; 38 ALU
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp4 r0.w, v0, c7
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedmlcimdpimpjjpijagpaageboghcdnlhhabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaa
aaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaa
aeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecediajiinaljilloipobengcdpnahbfnkdaabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[19].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
; 37 ALU
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
mad r0.xyz, r4, c18.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedlfcaebddpoamihbcaipmgkldbbpbhgmfabaaaaaaceahaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefciiafaaaaeaaaabaa
gcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaa
baaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaa
acaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaa
fgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
abaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaa
abaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaah
cccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaa
adaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaa
aeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefieceddnmgmgnoadapanamlhapiepomobbcdkbabaaaaaahiakaaaaaeaaaaaa
daaaaaaaiaadaaaabaajaaaaniajaaaaebgpgodjeiadaaaaeiadaaaaaaacpopp
niacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaeaaaaae
aaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadabaaaboaabaaoejaaaaaoeia
abaaaaacabaaahiaabaaoejaafaaaaadacaaahiaabaamjiaacaancjaaeaaaaae
abaaahiaacaamjjaabaanciaacaaoeibafaaaaadabaaahiaabaaoeiaabaappja
aiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaadabaaaeoaacaaoejaaaaaoeia
abaaaaacaaaaahiaahaaoekaafaaaaadacaaahiaaaaaffiabcaaoekaaeaaaaae
aaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaaeaaaaahiabdaaoekaaaaakkia
aaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoekaaeaaaaaeaaaaahiaaaaaoeia
bfaappkaaaaaoejbaiaaaaadacaaaboaabaaoejaaaaaoeiaaiaaaaadacaaacoa
abaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoejaaaaaoeiaafaaaaadaaaaapia
aaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiabaaaoekaaaaappja
aaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahiaabaaoeka
aaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeiaaeaaaaae
adaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefciiafaaaaeaaaabaagcabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaa
fjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaa
ogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaa
aaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
jgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaa
abaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaa
kgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [unity_Scale]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"!!ARBvp1.0
# 32 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[17];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[19].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[18];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_Scale]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_2_0
; 35 ALU
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
dp4 r4.y, c17, r0
mov r1, c8
dp4 r4.x, c17, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mad oT0.zw, v3.xyxy, c20.xyxy, c20
mad oT0.xy, v3, c19, c19.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefieceddhgbflnooknbjjppbonionfloplljkibabaaaaaapiagaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfmafaaaaeaaaabaa
fhabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaa
afaaaaaafjaaaaaeegiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaa
kgiocaaaaaaaaaaaajaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaa
aaaaaaaaegiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabaaaaaaaagiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaa
pgipcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaa
egiccaaaadaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaa
baaaaaaaagiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaa
abaaaaaaegiccaaaadaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaa
abaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaa
bdaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaa
beaaaaaaegbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
dcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaa
abaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 176
Matrix 48 [_LightMatrix0]
Vector 128 [_MainTex_ST]
Vector 144 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedbahpoongmephpphngidkfhedkfopejgbabaaaaaadiakaaaaaeaaaaaa
daaaaaaagmadaaaanaaiaaaajiajaaaaebgpgodjdeadaaaadeadaaaaaaacpopp
meacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaadaa
aeaaabaaaaaaaaaaaaaaaiaaacaaafaaaaaaaaaaabaaaeaaabaaahaaaaaaaaaa
acaaaaaaabaaaiaaaaaaaaaaadaaaaaaaeaaajaaaaaaaaaaadaaamaaajaaanaa
aaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjaaeaaaaae
aaaaadoaadaaoejaafaaoekaafaaookaaeaaaaaeaaaaamoaadaaeejaagaaeeka
agaaoekaabaaaaacaaaaapiaaiaaoekaafaaaaadabaaahiaaaaaffiabcaaoeka
aeaaaaaeabaaahiabbaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiabdaaoeka
aaaakkiaabaaoeiaaeaaaaaeaaaaahiabeaaoekaaaaappiaaaaaoeiaaiaaaaad
abaaaboaabaaoejaaaaaoeiaabaaaaacabaaahiaabaaoejaafaaaaadacaaahia
abaamjiaacaancjaaeaaaaaeabaaahiaacaamjjaabaanciaacaaoeibafaaaaad
abaaahiaabaaoeiaabaappjaaiaaaaadabaaacoaabaaoeiaaaaaoeiaaiaaaaad
abaaaeoaacaaoejaaaaaoeiaabaaaaacaaaaahiaahaaoekaafaaaaadacaaahia
aaaaffiabcaaoekaaeaaaaaeaaaaaliabbaakekaaaaaaaiaacaakeiaaeaaaaae
aaaaahiabdaaoekaaaaakkiaaaaapeiaacaaaaadaaaaahiaaaaaoeiabeaaoeka
aeaaaaaeaaaaahiaaaaaoeiabfaappkaaaaaoejbaiaaaaadacaaaboaabaaoeja
aaaaoeiaaiaaaaadacaaacoaabaaoeiaaaaaoeiaaiaaaaadacaaaeoaacaaoeja
aaaaoeiaafaaaaadaaaaapiaaaaaffjaaoaaoekaaeaaaaaeaaaaapiaanaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaapaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiabaaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoeka
aeaaaaaeaaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoeka
aaaakkiaaaaaoeiaaeaaaaaeadaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaad
aaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcfmafaaaaeaaaabaafhabaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaae
egiocaaaacaaaaaaabaaaaaafjaaaaaeegiocaaaadaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaa
egiacaaaaaaaaaaaaiaaaaaaogikcaaaaaaaaaaaaiaaaaaadcaaaaalmccabaaa
abaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaajaaaaaakgiocaaaaaaaaaaa
ajaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaacaaaaaaaaaaaaaaegiccaaa
adaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaa
agiacaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaadaaaaaabcaaaaaakgikcaaaacaaaaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabdaaaaaapgipcaaaacaaaaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahcccabaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaadaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaadaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
adaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaadaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaadaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaadaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaadaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaa
egiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaak
dcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaa
aaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"!!ARBfp1.0
# 40 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R4.xw, fragment.texcoord[0], texture[1], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R2.w, R0, c[2];
SLT R1.x, R2.w, c[3];
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.z, R1.z;
MUL R0.xyz, R0, c[2];
MOV result.color.w, R2;
KIL -R1.x;
TEX R0.w, R0.w, texture[3], 2D;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[1];
MAD R3.xyz, R1.z, fragment.texcoord[2], R2;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R3.w, R3, R3;
RSQ R1.w, R3.w;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
MUL R3.xyz, R1.w, R3;
RCP R1.z, R1.z;
DP3 R1.w, R1, R3;
DP3 R1.x, R1, R2;
MAX R2.x, R1, c[4].z;
MUL R1.xyz, R0, c[0];
MUL_SAT R3.w, R4.x, R4;
MOV R0.xyz, c[1];
MUL R3.x, R3.w, c[4].w;
MAX R1.w, R1, c[4].z;
POW R1.w, R1.w, R3.x;
MUL R1.w, R1, R4;
MUL R1.xyz, R1, R2.x;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[4].x;
MAD R0.xyz, R0, R1.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 40 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
; 45 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
texld r7, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r2, -r1.x
dp3 r1.x, t3, t3
mov r1.xy, r1.x
mul_pp r3.xyz, r3, c2
mov r4.y, t0.w
mov r4.x, t0.z
mul_pp r3.xyz, r3, c0
texld r8, r1, s3
texld r1, r4, s2
texkill r2.xyzw
mov r1.x, r1.w
mad_pp r5.xy, r1, c4.z, c4.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r6, r6
rcp_pp r5.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r6
mul_pp_sat r1.x, r7, r7.w
dp3_pp r2.x, r5, r2
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c4
mul_pp r4.xyz, r3, r2.x
mov r1.x, r6.x
mov_pp r3.xyz, c0
mul r1.x, r1, r7.w
mul_pp r3.xyz, c1, r3
mul_pp r2.x, r8, c4.z
mad r1.xyz, r3, r1.x, r4
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedckajeapgonndepeblgnkbhkmnfnhleccabaaaaaafiagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfaafaaaaeaaaaaaafeabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaa
agaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
dcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaah
bcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaa
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaa
deaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaa
abaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaa
acaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaapgapbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaah
icaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaooajoihmligjbjmnfbhmbmhnfkchnfnabaaaaaaliajaaaaaeaaaaaa
daaaaaaaimadaaaaoeaiaaaaieajaaaaebgpgodjfeadaaaafeadaaaaaaacpppp
pmacaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaadaaaaaa
aaababaaacacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaa
aaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaacaappka
aeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbabaaaaacacaaabiaaaaakkla
abaaaaacacaaaciaaaaapplaaiaaaaadadaaaiiaadaaoelaadaaoelaabaaaaac
adaaadiaadaappiaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaacaioeka
ecaaaaadacaacpiaaaaaoelaadaioekaecaaaaadadaacpiaadaaoeiaaaaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
aeaachiaabaaoelaaeaaaaaeafaachiaacaaoelaabaaaaiaaeaaoeiaceaaaaac
agaachiaafaaoeiaaeaaaaaeafaacbiaabaappiaaeaaaakaaeaaffkaaeaaaaae
afaacciaabaaffiaaeaaaakaaeaaffkafkaaaaaeaeaadiiaafaaoeiaafaaoeia
aeaakkkaacaaaaadaeaaciiaaeaappibaeaappkaahaaaaacaeaaciiaaeaappia
agaaaaacafaaceiaaeaappiaaiaaaaadaeaaciiaafaaoeiaagaaoeiaaiaaaaad
abaacbiaafaaoeiaaeaaoeiaalaaaaadacaacciaabaaaaiaaeaakkkaalaaaaad
abaaabiaaeaappiaaeaakkkaafaaaaadabaadciaacaappiaacaaaaiaafaaaaad
abaaaciaabaaffiaafaaaakacaaaaaadacaaabiaabaaaaiaabaaffiaafaaaaad
abaaabiaacaappiaacaaaaiaabaaaaacaeaaahiaaaaaoekaafaaaaadabaaaoia
aeaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachia
aaaaoeiaacaaoekaafaaaaadaeaaciiaaaaappiaacaappkaafaaaaadaaaachia
aaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeiaacaaaaad
aaaaaiiaadaaaaiaadaaaaiaafaaaaadaeaachiaaaaappiaaaaaoeiaabaaaaac
aaaicpiaaeaaoeiappppaaaafdeieefcfaafaaaaeaaaaaaafeabaaaafjaaaaae
egiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaa
agaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaa
igadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaaaaaaaaaaeghobaaaadaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"!!ARBfp1.0
# 35 ALU, 3 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xw, fragment.texcoord[0], texture[1], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R0.w, R0, c[2];
SLT R1.x, R0.w, c[3];
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.z, R1.z;
MOV R2.xyz, fragment.texcoord[1];
MAD R2.xyz, R1.z, fragment.texcoord[2], R2;
DP3 R2.w, R2, R2;
MUL R0.xyz, R0, c[2];
MOV result.color.w, R0;
KIL -R1.x;
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
RSQ R1.w, R2.w;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
MUL R2.xyz, R1.w, R2;
RCP R1.z, R1.z;
DP3 R1.w, R1, R2;
MUL_SAT R2.w, R3.x, R3;
MUL R2.x, R2.w, c[4].w;
MAX R1.w, R1, c[4].z;
POW R1.w, R1.w, R2.x;
DP3 R2.x, R1, fragment.texcoord[1];
MUL R1.xyz, R0, c[0];
MAX R2.x, R2, c[4].z;
MOV R0.xyz, c[1];
MUL R1.w, R1, R3;
MUL R1.xyz, R1, R2.x;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.w, R1;
MUL result.color.xyz, R0, c[4].x;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"ps_2_0
; 40 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
texld r3, t0, s0
texld r6, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r3.xyz, r3, c2
mov_pp r5.xyz, t1
texkill r1.xyzw
texld r1, r2, s2
mov r1.x, r1.w
mad_pp r4.xy, r1, c4.z, c4.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
dp3_pp r2.x, t2, t2
rsq_pp r2.x, r2.x
mad_pp r5.xyz, r2.x, t2, r5
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r5, r5
rcp_pp r4.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r5
dp3_pp r2.x, r4, r2
mul_pp_sat r1.x, r6, r6.w
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r5.x, r2.x, r1.x
dp3_pp r2.x, r4, t1
mul_pp r4.xyz, r3, c0
mov r1.x, r5.x
max_pp r2.x, r2, c4
mov_pp r3.xyz, c0
mul r1.x, r1, r6.w
mul_pp r2.xyz, r4, r2.x
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r2
mul r1.xyz, r1, c4.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgkfbegncjgigolapdbddklmkhbecblmcabaaaaaahaafaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciaaeaaaaeaaaaaaacaabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaagaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahecaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
ncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjobnaiplniedmnmmkkonhgdbifbcndcfabaaaaaagmaiaaaaaeaaaaaa
daaaaaaaciadaaaalaahaaaadiaiaaaaebgpgodjpaacaaaapaacaaaaaaacpppp
kiacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
acababaaabacacaaaaaaabaaadaaaaaaaaaaaaaaaaaaagaaabaaadaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
afaaapkaaaaaaaedaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpia
aaaappiaabaappiaadaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaacia
aaaapplaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaecaaaaad
acaacpiaaaaaoelaacaioekaaiaaaaadabaacbiaacaaoelaacaaoelaahaaaaac
abaacbiaabaaaaiaabaaaaacadaaahiaacaaoelaaeaaaaaeadaachiaadaaoeia
abaaaaiaabaaoelaceaaaaacaeaachiaadaaoeiaaeaaaaaeadaacbiaabaappia
aeaaaakaaeaaffkaaeaaaaaeadaacciaabaaffiaaeaaaakaaeaaffkafkaaaaae
adaadiiaadaaoeiaadaaoeiaaeaakkkaacaaaaadadaaciiaadaappibaeaappka
ahaaaaacadaaciiaadaappiaagaaaaacadaaceiaadaappiaaiaaaaadadaaciia
adaaoeiaaeaaoeiaaiaaaaadabaacbiaadaaoeiaabaaoelaalaaaaadacaaccia
abaaaaiaaeaakkkaalaaaaadabaaabiaadaappiaaeaakkkaafaaaaadabaadcia
acaappiaacaaaaiaafaaaaadabaaaciaabaaffiaafaaaakacaaaaaadacaaabia
abaaaaiaabaaffiaafaaaaadabaaabiaacaappiaacaaaaiaabaaaaacadaaahia
aaaaoekaafaaaaadabaaaoiaadaabliaabaablkaafaaaaadabaaahiaabaaaaia
abaabliaafaaaaadaaaachiaaaaaoeiaacaaoekaafaaaaadadaaciiaaaaappia
acaappkaafaaaaadaaaachiaaaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeia
acaaffiaabaaoeiaacaaaaadadaachiaaaaaoeiaaaaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefciaaeaaaaeaaaaaaacaabaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaagaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahecaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
ncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaaaaaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"!!ARBfp1.0
# 46 ALU, 5 TEX
PARAM c[6] = { program.local[0..3],
		{ 2, 1, 0, 128 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xw, fragment.texcoord[0], texture[1], 2D;
MUL R2.w, R0, c[2];
RCP R0.w, fragment.texcoord[3].w;
MAD R1.xy, fragment.texcoord[3], R0.w, c[5].x;
SLT R1.w, R2, c[3].x;
MUL R0.xyz, R0, c[2];
DP3 R1.z, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[0];
MOV result.color.w, R2;
TEX R0.w, R1, texture[3], 2D;
KIL -R1.w;
TEX R1.w, R1.z, texture[4], 2D;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[1];
MAD R1.xy, R3.wyzw, c[4].x, -c[4].y;
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.z, R1.z;
MAD R3.xyz, R1.z, fragment.texcoord[2], R2;
MUL R4.yz, R1.xxyw, R1.xxyw;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
ADD_SAT R1.z, R4.y, R4;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.x, R1, R3;
DP3 R1.x, R1, R2;
MUL_SAT R3.w, R4.x, R4;
MAX R1.x, R1, c[4].z;
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
SLT R2.x, c[4].z, fragment.texcoord[3].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R3.y, R3.w, c[4].w;
MAX R3.x, R3, c[4].z;
POW R3.x, R3.x, R3.y;
MUL R3.x, R3, R4.w;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[4].x;
MAD R0.xyz, R0, R3.x, R1;
MUL result.color.xyz, R0, R0.w;
END
# 46 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_2_0
; 52 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0.50000000, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3
texld r3, t0, s0
texld r7, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r5, -r1.x
dp3 r2.x, t3, t3
mov r2.xy, r2.x
mul_pp r3.xyz, r3, c2
mov r1.y, t0.w
mov r1.x, t0.z
mov r4.xy, r1
rcp r1.x, t3.w
mad r1.xy, t3, r1.x, c5.y
mul_pp r3.xyz, r3, c0
texld r8, r2, s4
texld r2, r4, s2
texld r1, r1, s3
texkill r5.xyzw
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
mov r1.y, r2
mov r1.x, r2.w
mad_pp r5.xy, r1, c4.z, c4.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r6, r6
rcp_pp r5.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r6
mul_pp_sat r1.x, r7, r7.w
dp3_pp r2.x, r5, r2
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c4
mul_pp r3.xyz, r3, r2.x
mov r1.x, r6.x
mul r1.x, r1, r7.w
mov_pp r4.xyz, c0
cmp r2.x, -t3.z, c4, c4.y
mul_pp r2.x, r2, r1.w
mul_pp r2.x, r2, r8
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r2, c4.z
mad r1.xyz, r4, r1.x, r3
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_SpecMap] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedldophkbmdhehpfpclbhpcgdghmpfcjllabaaaaaadaahaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcciagaaaaeaaaaaaaikabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaa
agbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaaagaabaaa
abaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
abaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadicaaaah
ecaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaaeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaa
dbaaaaahicaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaabaaaaaahbcaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaagaabaaa
abaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaapaaaaahicaabaaaaaaaaaaa
pgapbaaaaaaaaaaaagaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "SPOT" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_SpecMap] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgpkfaanfgmpinnjaddaoamnenhedbdpiabaaaaaapeakaaaaaeaaaaaa
daaaaaaapaadaaaacaakaaaamaakaaaaebgpgodjliadaaaaliadaaaaaaacpppp
fmadaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaadaaaaaa
aeababaaaaacacaaacadadaaabaeaeaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaa
abaaacaaaaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaadpaaaaaaed
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaaplabpaaaaacaaaaaaja
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaadaaaacpiaaaaaoela
acaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappia
adaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaagaaaaac
acaaaeiaadaapplaaeaaaaaeadaaadiaadaaoelaacaakkiaafaaaakaaiaaaaad
aeaaaiiaadaaoelaadaaoelaabaaaaacaeaaadiaaeaappiaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaadaioekaecaaaaadacaacpiaaaaaoelaaeaioeka
ecaaaaadadaacpiaadaaoeiaaaaioekaecaaaaadaeaacpiaaeaaoeiaabaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
adaachiaabaaoelaaeaaaaaeafaachiaacaaoelaabaaaaiaadaaoeiaceaaaaac
agaachiaafaaoeiaaeaaaaaeafaacbiaabaappiaaeaaaakaaeaaffkaaeaaaaae
afaacciaabaaffiaaeaaaakaaeaaffkafkaaaaaeafaadiiaafaaoeiaafaaoeia
aeaakkkaacaaaaadafaaciiaafaappibaeaappkaahaaaaacafaaciiaafaappia
agaaaaacafaaceiaafaappiaaiaaaaadafaaciiaafaaoeiaagaaoeiaaiaaaaad
abaacbiaafaaoeiaadaaoeiaalaaaaadacaacciaabaaaaiaaeaakkkaalaaaaad
abaaabiaafaappiaaeaakkkaafaaaaadabaadciaacaappiaacaaaaiaafaaaaad
abaaaciaabaaffiaafaaffkacaaaaaadacaaabiaabaaaaiaabaaffiaafaaaaad
abaaabiaacaappiaacaaaaiaabaaaaacadaaahiaaaaaoekaafaaaaadabaaaoia
adaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachia
aaaaoeiaacaaoekaafaaaaadafaaciiaaaaappiaacaappkaafaaaaadaaaachia
aaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeiaafaaaaad
aaaaciiaadaappiaaeaaaaiafiaaaaaeaaaaciiaadaakklbaeaakkkaaaaappia
acaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaadafaachiaaaaappiaaaaaoeia
abaaaaacaaaicpiaafaaoeiappppaaaafdeieefcciagaaaaeaaaaaaaikabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaa
ahaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegbcbaaaacaaaaaa
egbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaaacaaaaaadcaaaaajhcaabaaa
acaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaajgahbaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaa
adaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaaeaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
aaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaa
bjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaa
agaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaa
igadbaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaaeaaaaaapgbpbaaa
aeaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaa
eghobaaaadaaaaaaaagabaaaaaaaaaaadbaaaaahicaabaaaaaaaaaaaabeaaaaa
aaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaagaabaaaabaaaaaaeghobaaaaeaaaaaaaagabaaa
abaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaaaaaaaaaaagaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"!!ARBfp1.0
# 42 ALU, 5 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xw, fragment.texcoord[0], texture[1], 2D;
TEX R1.w, fragment.texcoord[3], texture[4], CUBE;
MUL R2.w, R0, c[2];
SLT R1.x, R2.w, c[3];
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
RSQ R1.z, R1.z;
MUL R0.xyz, R0, c[0];
MOV result.color.w, R2;
KIL -R1.x;
TEX R0.w, R0.w, texture[3], 2D;
DP3 R1.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R1.x;
MUL R2.xyz, R1.x, fragment.texcoord[1];
MAD R1.xy, R3.wyzw, c[4].x, -c[4].y;
MAD R3.xyz, R1.z, fragment.texcoord[2], R2;
MUL R4.yz, R1.xxyw, R1.xxyw;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
ADD_SAT R1.z, R4.y, R4;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
RCP R1.z, R1.z;
DP3 R3.x, R1, R3;
DP3 R1.x, R1, R2;
MUL_SAT R3.w, R4.x, R4;
MAX R1.x, R1, c[4].z;
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R0.w, R0, R1;
MUL R3.y, R3.w, c[4].w;
MAX R3.x, R3, c[4].z;
POW R3.x, R3.x, R3.y;
MUL R3.x, R3, R4.w;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[4].x;
MAD R0.xyz, R0, R3.x, R1;
MUL result.color.xyz, R0, R0.w;
END
# 42 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"ps_2_0
; 47 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
texld r7, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r4, -r1.x
dp3 r1.x, t3, t3
mov r1.xy, r1.x
mul_pp r3.xyz, r3, c2
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r3.xyz, r3, c0
texld r8, r1, s3
texld r2, r2, s2
texld r1, t3, s4
texkill r4.xyzw
dp3_pp r2.x, t1, t1
rsq_pp r4.x, r2.x
dp3_pp r2.x, t2, t2
mov r1.y, r2
mov r1.x, r2.w
mad_pp r5.xy, r1, c4.z, c4.w
mul_pp r1.xy, r5, r5
add_pp_sat r1.x, r1, r1.y
mul_pp r4.xyz, r4.x, t1
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r4
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r6, r6
rcp_pp r5.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r6
mul_pp_sat r1.x, r7, r7.w
dp3_pp r2.x, r5, r2
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r5, r4
max_pp r2.x, r2, c4
mov r1.x, r6.x
mul r1.x, r1, r7.w
mov_pp r4.xyz, c0
mul_pp r3.xyz, r3, r2.x
mul r2.x, r8, r1.w
mul_pp r4.xyz, c1, r4
mul_pp r2.x, r2, c4.z
mad r1.xyz, r4, r1.x, r3
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_SpecMap] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecednepjijehloillkhgeoagjojndiineindabaaaaaajiagaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcjaafaaaaeaaaaaaageabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaa
akaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
ahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaa
abaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaa
agbjbaaaacaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaaagaabaaa
abaaaaaajgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
hcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaa
abaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadicaaaah
ecaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaa
abaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaa
diaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaa
diaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
pgapbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaegbcbaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaaapaaaaah
icaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
SetTexture 0 [_MainTex] 2D 2
SetTexture 1 [_SpecMap] 2D 4
SetTexture 2 [_BumpMap] 2D 3
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkmohokgcjcglcglcflfclamkffmhccanabaaaaaaciakaaaaaeaaaaaa
daaaaaaalmadaaaafeajaaaapeajaaaaebgpgodjieadaaaaieadaaaaaaacpppp
ciadaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaaeaaaaaa
adababaaaaacacaaacadadaaabaeaeaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaa
abaaacaaaaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachla
bpaaaaacaaaaaaiaacaachlabpaaaaacaaaaaaiaadaaahlabpaaaaacaaaaaaji
aaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaac
aaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaadaaaacpiaaaaaoela
acaioekaabaaaaacabaaaiiaacaappkaaeaaaaaeabaacpiaaaaappiaabaappia
adaaaakbabaaaaacacaaabiaaaaakklaabaaaaacacaaaciaaaaapplaaiaaaaad
adaaaiiaadaaoelaadaaoelaabaaaaacadaaadiaadaappiaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaadaioekaecaaaaadacaacpiaaaaaoelaaeaioeka
ecaaaaadadaaapiaadaaoeiaabaioekaecaaaaadaeaaapiaadaaoelaaaaioeka
aiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaiaceaaaaac
aeaachiaabaaoelaaeaaaaaeafaachiaacaaoelaabaaaaiaaeaaoeiaceaaaaac
agaachiaafaaoeiaaeaaaaaeafaacbiaabaappiaaeaaaakaaeaaffkaaeaaaaae
afaacciaabaaffiaaeaaaakaaeaaffkafkaaaaaeafaadiiaafaaoeiaafaaoeia
aeaakkkaacaaaaadafaaciiaafaappibaeaappkaahaaaaacafaaciiaafaappia
agaaaaacafaaceiaafaappiaaiaaaaadafaaciiaafaaoeiaagaaoeiaaiaaaaad
abaacbiaafaaoeiaaeaaoeiaalaaaaadacaacciaabaaaaiaaeaakkkaalaaaaad
abaaabiaafaappiaaeaakkkaafaaaaadabaadciaacaappiaacaaaaiaafaaaaad
abaaaciaabaaffiaafaaaakacaaaaaadacaaabiaabaaaaiaabaaffiaafaaaaad
abaaabiaacaappiaacaaaaiaabaaaaacaeaaahiaaaaaoekaafaaaaadabaaaoia
aeaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaadaaaachia
aaaaoeiaacaaoekaafaaaaadafaaciiaaaaappiaacaappkaafaaaaadaaaachia
aaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeiaafaaaaad
aaaaciiaadaaaaiaaeaappiaacaaaaadaaaaaiiaaaaappiaaaaappiaafaaaaad
afaachiaaaaappiaaaaaoeiaabaaaaacaaaicpiaafaaoeiappppaaaafdeieefc
jaafaaaaeaaaaaaageabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaabaaaaaa
bkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaaabaaaaaaagbjbaaa
acaaaaaadcaaaaajhcaabaaaacaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaa
jgahbaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaa
ogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaadcaaaaapdcaabaaa
adaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahbcaabaaaabaaaaaa
egaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaiadpaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaaakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaabaaaaaah
ccaabaaaabaaaaaaegacbaaaadaaaaaajgahbaaaabaaaaaadeaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
cpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaaeaaaaaadicaaaahecaabaaa
abaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
diaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaaj
hcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaapgapbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egbcbaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaaapaaaaahicaabaaa
aaaaaaaaagaabaaaabaaaaaapgapbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"!!ARBfp1.0
# 37 ALU, 4 TEX
PARAM c[5] = { program.local[0..3],
		{ 2, 1, 0, 128 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R3.xw, fragment.texcoord[0], texture[1], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MUL R2.w, R0, c[2];
SLT R0.w, R2, c[3].x;
DP3 R1.z, fragment.texcoord[2], fragment.texcoord[2];
MUL R0.xyz, R0, c[2];
MAD R1.xy, R1.wyzw, c[4].x, -c[4].y;
RSQ R1.z, R1.z;
MOV R2.xyz, fragment.texcoord[1];
MAD R2.xyz, R1.z, fragment.texcoord[2], R2;
MUL R1.zw, R1.xyxy, R1.xyxy;
ADD_SAT R1.z, R1, R1.w;
DP3 R3.y, R2, R2;
RSQ R1.w, R3.y;
ADD R1.z, -R1, c[4].y;
RSQ R1.z, R1.z;
MUL R2.xyz, R1.w, R2;
RCP R1.z, R1.z;
DP3 R1.w, R1, R2;
MUL_SAT R3.x, R3, R3.w;
MUL R2.x, R3, c[4].w;
MAX R1.w, R1, c[4].z;
POW R1.w, R1.w, R2.x;
DP3 R1.x, R1, fragment.texcoord[1];
MAX R2.x, R1, c[4].z;
MUL R0.xyz, R0, c[0];
MOV R1.xyz, c[1];
MUL R1.w, R1, R3;
MUL R0.xyz, R0, R2.x;
MUL R1.xyz, R1, c[0];
MAD R0.xyz, R1, R1.w, R0;
MOV result.color.w, R2;
KIL -R0.w;
TEX R0.w, fragment.texcoord[3], texture[3], 2D;
MUL R0.w, R0, c[4].x;
MUL result.color.xyz, R0, R0.w;
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_2_0
; 42 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c5, 128.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xy
texld r3, t0, s0
texld r5, t0, s1
mul_pp r0.x, r3.w, c2.w
add_pp r1.x, r0, -c3
cmp r1.x, r1, c4, c4.y
mov_pp r1, -r1.x
mul_pp r3.xyz, r3, c2
mul_pp r3.xyz, r3, c0
mov r2.y, t0.w
mov r2.x, t0.z
mov_pp r6.xyz, t1
texld r2, r2, s2
texkill r1.xyzw
texld r1, t3, s3
dp3_pp r2.x, t2, t2
rsq_pp r2.x, r2.x
mad_pp r6.xyz, r2.x, t2, r6
mov r1.y, r2
mov r1.x, r2.w
mad_pp r4.xy, r1, c4.z, c4.w
mul_pp r1.xy, r4, r4
add_pp_sat r1.x, r1, r1.y
add_pp r1.x, -r1, c4.y
rsq_pp r2.x, r1.x
dp3_pp r1.x, r6, r6
rcp_pp r4.z, r2.x
rsq_pp r1.x, r1.x
mul_pp r2.xyz, r1.x, r6
dp3_pp r2.x, r4, r2
mul_pp_sat r1.x, r5, r5.w
mul_pp r1.x, r1, c5
max_pp r2.x, r2, c4
pow r6.x, r2.x, r1.x
dp3_pp r2.x, r4, t1
max_pp r2.x, r2, c4
mul_pp r4.xyz, r3, r2.x
mov r1.x, r6.x
mul r1.x, r1, r5.w
mul_pp r2.x, r1.w, c4.z
mov_pp r3.xyz, c0
mul_pp r3.xyz, c1, r3
mad r1.xyz, r3, r1.x, r4
mul r1.xyz, r1, r2.x
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgdccahlkfibjofpbgnmnhfnngaminpccabaaaaaapaafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcoiaeaaaaeaaaaaaadkabaaaafjaaaaaeegiocaaaaaaaaaaaalaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaaakiacaiaebaaaaaa
aaaaaaaaakaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaahaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
adaaaaaaegbcbaaaadaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajhcaabaaaabaaaaaaegbcbaaaadaaaaaaagaabaaaabaaaaaaegbcbaaa
acaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
eeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadcaaaaapdcaabaaaacaaaaaa
hgapbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaa
acaaaaaaegaabaaaacaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaiadpelaaaaafecaabaaaacaaaaaadkaabaaaabaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaabaaaaaahccaabaaa
abaaaaaaegacbaaaacaaaaaaegbcbaaaacaaaaaadeaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadicaaaahecaabaaaabaaaaaa
dkaabaaaacaaaaaaakaabaaaacaaaaaadiaaaaahecaabaaaabaaaaaackaabaaa
abaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
ckaabaaaabaaaaaabjaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaah
bcaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaabaaaaaadiaaaaajhcaabaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaah
ncaabaaaabaaaaaaagaabaaaabaaaaaaagajbaaaacaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
fgafbaaaabaaaaaaigadbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
aeaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_MainTex] 2D 1
SetTexture 1 [_SpecMap] 2D 3
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 176
Vector 16 [_LightColor0]
Vector 32 [_SpecColor]
Vector 112 [_Color]
Float 160 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhfacghmdbdkgaaknpconcahnjalealbpabaaaaaadeajaaaaaeaaaaaa
daaaaaaahaadaaaagaaiaaaaaaajaaaaebgpgodjdiadaaaadiadaaaaaaacpppp
oaacaaaafiaaaaaaadaadeaaaaaafiaaaaaafiaaaeaaceaaaaaafiaaadaaaaaa
aaababaaacacacaaabadadaaaaaaabaaacaaaaaaaaaaaaaaaaaaahaaabaaacaa
aaaaaaaaaaaaakaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaea
aaaaialpaaaaaaaaaaaaiadpfbaaaaafafaaapkaaaaaaaedaaaaaaaaaaaaaaaa
aaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaachlabpaaaaac
aaaaaaiaacaachlabpaaaaacaaaaaaiaadaaadlabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkabpaaaaacaaaaaaja
adaiapkaecaaaaadaaaacpiaaaaaoelaabaioekaabaaaaacabaaaiiaacaappka
aeaaaaaeabaacpiaaaaappiaabaappiaadaaaakbabaaaaacacaaabiaaaaakkla
abaaaaacacaaaciaaaaapplaebaaaaababaaapiaecaaaaadabaacpiaacaaoeia
acaioekaecaaaaadacaacpiaaaaaoelaadaioekaecaaaaadadaacpiaadaaoela
aaaioekaaiaaaaadabaacbiaacaaoelaacaaoelaahaaaaacabaacbiaabaaaaia
abaaaaacadaaahiaacaaoelaaeaaaaaeadaachiaadaaoeiaabaaaaiaabaaoela
ceaaaaacaeaachiaadaaoeiaaeaaaaaeadaacbiaabaappiaaeaaaakaaeaaffka
aeaaaaaeadaacciaabaaffiaaeaaaakaaeaaffkafkaaaaaeaeaadiiaadaaoeia
adaaoeiaaeaakkkaacaaaaadaeaaciiaaeaappibaeaappkaahaaaaacaeaaciia
aeaappiaagaaaaacadaaceiaaeaappiaaiaaaaadabaacbiaadaaoeiaaeaaoeia
aiaaaaadabaacciaadaaoeiaabaaoelaalaaaaadacaacciaabaaffiaaeaakkka
alaaaaadacaaaeiaabaaaaiaaeaakkkaafaaaaadabaadbiaacaappiaacaaaaia
afaaaaadabaaabiaabaaaaiaafaaaakacaaaaaadadaaabiaacaakkiaabaaaaia
afaaaaadabaaabiaacaappiaadaaaaiaabaaaaacadaaahiaaaaaoekaafaaaaad
abaaaoiaadaabliaabaablkaafaaaaadabaaahiaabaaaaiaabaabliaafaaaaad
aaaachiaaaaaoeiaacaaoekaafaaaaadaeaaciiaaaaappiaacaappkaafaaaaad
aaaachiaaaaaoeiaaaaaoekaaeaaaaaeaaaaahiaaaaaoeiaacaaffiaabaaoeia
acaaaaadaaaaaiiaadaappiaadaappiaafaaaaadaeaachiaaaaappiaaaaaoeia
abaaaaacaaaicpiaaeaaoeiappppaaaafdeieefcoiaeaaaaeaaaaaaadkabaaaa
fjaaaaaeegiocaaaaaaaaaaaalaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaaakiacaiaebaaaaaaaaaaaaaaakaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaahaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaeeaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegbcbaaa
adaaaaaaagaabaaaabaaaaaaegbcbaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaadcaaaaapdcaabaaaacaaaaaahgapbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
apaaaaahicaabaaaabaaaaaaegaabaaaacaaaaaaegaabaaaacaaaaaaddaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaa
acaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegbcbaaa
acaaaaaadeaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadicaaaahecaabaaaabaaaaaadkaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaackaabaaaabaaaaaabjaaaaafbcaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahbcaabaaaabaaaaaadkaabaaaacaaaaaa
akaabaaaabaaaaaadiaaaaajhcaabaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahncaabaaaabaaaaaaagaabaaaabaaaaaa
agajbaaaacaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaaigadbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaaabaaaaaa
diaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_MainTex_ST]
Vector 11 [_BumpMap_ST]
"!!ARBvp1.0
# 22 ALU
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 22 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_MainTex_ST]
Vector 10 [_BumpMap_ST]
"vs_2_0
; 23 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul oT1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c8.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
mad oT0.zw, v3.xyxy, c10.xyxy, c10
mad oT0.xy, v3, c9, c9.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhmabmdnklfghfbgelbedldhgmhkpeiccabaaaaaameafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcciaeaaaaeaaaabaa
akabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaad
hcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaa
cgbjbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaapgbpbaaaabaaaaaadgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaa
amaaaaaadgaaaaagccaabaaaabaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaag
ecaabaaaabaaaaaaakiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaa
egacbaaaabaaaaaadiaaaaaihccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaa
abaaaaaabeaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaa
dgaaaaagccaabaaaabaaaaaabkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaa
abaaaaaabkiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaa
egacbaaaabaaaaaabaaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaa
abaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadgaaaaagbcaabaaaabaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaag
ccaabaaaabaaaaaackiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaa
ckiacaaaabaaaaaaaoaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaahecaabaaaaaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
diaaaaaihccabaaaaeaaaaaaegacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 112
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecednmjcolebflamfjidgnmbhjjkpemddbfkabaaaaaagaaiaaaaaeaaaaaa
daaaaaaamiacaaaapiagaaaamaahaaaaebgpgodjjaacaaaajaacaaaaaaacpopp
diacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaeaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaabaaamaaadaaahaaaaaaaaaa
abaabeaaabaaakaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadia
adaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaaeaaaaamoa
adaaeejaacaaeekaacaaoekaabaaaaacaaaaahiaabaaoejaafaaaaadabaaahia
aaaamjiaacaancjaaeaaaaaeaaaaahiaacaamjjaaaaanciaabaaoeibafaaaaad
aaaaahiaaaaaoeiaabaappjaabaaaaacabaaabiaahaaaakaabaaaaacabaaacia
aiaaaakaabaaaaacabaaaeiaajaaaakaaiaaaaadacaaaciaaaaaoeiaabaaoeia
aiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaadacaaaeiaacaaoejaabaaoeia
afaaaaadabaaahoaacaaoeiaakaappkaabaaaaacabaaabiaahaaffkaabaaaaac
abaaaciaaiaaffkaabaaaaacabaaaeiaajaaffkaaiaaaaadacaaaciaaaaaoeia
abaaoeiaaiaaaaadacaaabiaabaaoejaabaaoeiaaiaaaaadacaaaeiaacaaoeja
abaaoeiaafaaaaadacaaahoaacaaoeiaakaappkaabaaaaacabaaabiaahaakkka
abaaaaacabaaaciaaiaakkkaabaaaaacabaaaeiaajaakkkaaiaaaaadaaaaacia
aaaaoeiaabaaoeiaaiaaaaadaaaaabiaabaaoejaabaaoeiaaiaaaaadaaaaaeia
acaaoejaabaaoeiaafaaaaadadaaahoaaaaaoeiaakaappkaafaaaaadaaaaapia
aaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiappppaaaafdeieefcciaeaaaaeaaaabaaakabaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagfaaaaad
hccabaaaaeaaaaaagiaaaaacadaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaakgiocaaaaaaaaaaaafaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
dgaaaaagbcaabaaaabaaaaaaakiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaa
abaaaaaaakiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaaakiacaaa
abaaaaaaaoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaahecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaai
hccabaaaacaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaag
bcaabaaaabaaaaaabkiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaa
bkiacaaaabaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaabkiacaaaabaaaaaa
aoaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
baaaaaahbcaabaaaacaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
ecaabaaaacaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaa
adaaaaaaegacbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadgaaaaagbcaabaaa
abaaaaaackiacaaaabaaaaaaamaaaaaadgaaaaagccaabaaaabaaaaaackiacaaa
abaaaaaaanaaaaaadgaaaaagecaabaaaabaaaaaackiacaaaabaaaaaaaoaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaabaaaaaahecaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaabaaaaaabeaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"!!ARBfp1.0
# 17 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 2, 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
TEX R1.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
MAD R2.xy, R1.wyzw, c[2].x, -c[2].y;
MUL R1.xy, R2, R2;
ADD_SAT R0.y, R1.x, R1;
MUL R0.x, R0.w, c[0].w;
SLT R0.x, R0, c[1];
ADD R0.y, -R0, c[2];
RSQ R0.y, R0.y;
RCP R2.z, R0.y;
DP3 R1.z, fragment.texcoord[3], R2;
DP3 R1.x, R2, fragment.texcoord[1];
DP3 R1.y, R2, fragment.texcoord[2];
MAD result.color.xyz, R1, c[2].z, c[2].z;
KIL -R0.x;
TEX R0.xw, fragment.texcoord[0], texture[1], 2D;
MUL_SAT result.color.w, R0.x, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Color]
Float 1 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
"ps_2_0
; 19 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c3, 0.50000000, 0, 0, 0
dcl t0
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
mov_pp r0.x, c1
mad_pp r0.x, r0.w, c0.w, -r0
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
mov r1.y, t0.w
mov r1.x, t0.z
texkill r0.xyzw
texld r0, r1, s2
texld r1, t0, s1
mov r0.x, r0.w
mad_pp r2.xy, r0, c2.z, c2.w
mul_pp r0.xy, r2, r2
add_pp_sat r0.x, r0, r0.y
add_pp r0.x, -r0, c2.y
rsq_pp r0.x, r0.x
rcp_pp r2.z, r0.x
dp3 r0.z, t3, r2
dp3 r0.y, r2, t2
dp3 r0.x, r2, t1
mad_pp r0.xyz, r0, c3.x, c3.x
mul_pp_sat r0.w, r1.x, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedipjlpoeleefjchegcjdjonbnkndojfeaabaaaaaaneadaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcmmacaaaaeaaaaaaaldaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
ConstBuffer "$Globals" 112
Vector 48 [_Color]
Float 96 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpghgebchbmbgdnodcbinnkgkfkmalhhlabaaaaaaoiafaaaaaeaaaaaa
daaaaaaaeaacaaaabeafaaaaleafaaaaebgpgodjaiacaaaaaiacaaaaaaacpppp
maabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
acababaaabacacaaaaaaadaaabaaaaaaaaaaaaaaaaaaagaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaiadpfbaaaaaf
adaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaahlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaia
adaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaac
aaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
aaaappkaaeaaaaaeaaaacpiaaaaappiaabaappiaabaaaakbabaaaaacabaaabia
aaaakklaabaaaaacabaaaciaaaaapplaebaaaaabaaaaapiaecaaaaadaaaacpia
abaaoeiaabaioekaecaaaaadabaacpiaaaaaoelaacaioekaaeaaaaaeacaacbia
aaaappiaacaaaakaacaaffkaaeaaaaaeacaacciaaaaaffiaacaaaakaacaaffka
fkaaaaaeacaadiiaacaaoeiaacaaoeiaacaakkkaacaaaaadacaaciiaacaappib
acaappkaahaaaaacacaaciiaacaappiaagaaaaacacaaceiaacaappiaaiaaaaad
aaaacbiaabaaoelaacaaoeiaaiaaaaadaaaacciaacaaoelaacaaoeiaaiaaaaad
aaaaceiaadaaoelaacaaoeiaaeaaaaaeaaaachiaaaaaoeiaadaaaakaadaaaaka
afaaaaadaaaadiiaabaappiaabaaaaiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcmmacaaaaeaaaaaaaldaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaia
ebaaaaaaaaaaaaaaagaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaaaaaaaaaddaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaaaaaaaaadkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaaaaaaaaadkaabaaaaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaabaaaaaah
ccaabaaaabaaaaaaegbcbaaaadaaaaaaegacbaaaaaaaaaaabaaaaaahecaabaaa
abaaaaaaegbcbaaaaeaaaaaaegacbaaaaaaaaaaadcaaaaaphccabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahiccabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
# 29 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_2_0
; 29 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedalnahcdlglpimlmepojdljafglkmdojbabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daaeaaaaeaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedckaokdenaimhnbndnjeemmgfjebhnbmaabaaaaaagaaiaaaaaeaaaaaa
daaaaaaaniacaaaabaahaaaaniahaaaaebgpgodjkaacaaaakaacaaaaaaacpopp
daacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaaeaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabcaappkaafaaaaadacaaahiaabaaffiabaaaoekaaeaaaaae
abaaaliaapaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabbaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabdaaffkaajaaaaadacaaabiaaeaaoekaabaaoeia
ajaaaaadacaaaciaafaaoekaabaaoeiaajaaaaadacaaaeiaagaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaahaaoekaadaaoeia
ajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaadaeaaaeiaajaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaakaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcdaaeaaaa
eaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"vs_2_0
; 21 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednicnaifjcooimicfmkkclmcpodednfhiabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbiaeaaaaeaaaabaa
agabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedndpdmhleknbhdmgonggpjnjoincnbkghabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaaliacaaaaniagaaaakaahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
bmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaaeaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
afaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeiabcaaaaka
acaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeacaaadoaaeaaoejaabaaoeka
abaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaafaaoekb
afaaaaadadaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffjaalaakkka
aeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaamaakkka
aaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaiaabaaaaac
abaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaadadaaaioa
abaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcbiaeaaaa
eaaaabaaagabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
aeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[15] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[3].y, R1, R3;
ADD result.texcoord[1].xy, R2, R2.z;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
; 26 ALU
def c15, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c15.x
mul r2.y, r2, c9.x
dp3 oT3.y, r1, r3
mad oT1.xy, r2.z, c10.zwzw, r2
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mov oPos, r0
mov oT1.zw, r0
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT2.xy, v4, c12, c12.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlekpmnfbbjcgenpeocnblihojifhdcpgabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
acaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedeaodhoejlbfbfghcmahmhgndbmaffijpabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaeaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaapiaaaaaffjaahaaoeka
aeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaaaakaafaaaaad
abaaafiaaaaapeiaapaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaabaaaaacabaaahiaaeaaoekaafaaaaad
acaaahiaabaaffiaalaaoekaaeaaaaaeabaaaliaakaakekaabaaaaiaacaakeia
aeaaaaaeabaaahiaamaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeia
anaaoekaaeaaaaaeabaaahiaabaaoeiaaoaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaabaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjia
acaancjaaeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahia
acaaoeiaabaappjaaiaaaaadadaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoa
acaaoejaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"!!ARBvp1.0
# 29 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
END
# 29 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"vs_2_0
; 29 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c20.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecedalnahcdlglpimlmepojdljafglkmdojbabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
daaeaaaaeaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaae
egiocaaaadaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaa
adaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaa
afaaaaaakgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaa
aaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaa
acaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaa
mgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
adaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
adaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 128
Vector 64 [_MainTex_ST]
Vector 80 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityLighting" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedckaokdenaimhnbndnjeemmgfjebhnbmaabaaaaaagaaiaaaaaeaaaaaa
daaaaaaaniacaaaabaahaaaaniahaaaaebgpgodjkaacaaaakaacaaaaaaacpopp
daacaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaaeaa
acaaabaaaaaaaaaaabaaafaaabaaadaaaaaaaaaaacaacgaaahaaaeaaaaaaaaaa
adaaaaaaaeaaalaaaaaaaaaaadaaamaaadaaapaaaaaaaaaaadaabeaaabaabcaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbdaaapkaaaaaaadpaaaaiadpaaaaaaaa
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjabpaaaaac
afaaadiaadaaapjaaeaaaaaeaaaaadoaadaaoejaabaaoekaabaaookaaeaaaaae
aaaaamoaadaaeejaacaaeekaacaaoekaafaaaaadaaaaapiaaaaaffjaamaaoeka
aeaaaaaeaaaaapiaalaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaoaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaadaaaakaafaaaaadabaaaiiaabaaaaiabdaaaakaafaaaaad
abaaafiaaaaapeiabdaaaakaacaaaaadabaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabcaappkaafaaaaadacaaahiaabaaffiabaaaoekaaeaaaaae
abaaaliaapaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiabbaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabdaaffkaajaaaaadacaaabiaaeaaoekaabaaoeia
ajaaaaadacaaaciaafaaoekaabaaoeiaajaaaaadacaaaeiaagaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaahaaoekaadaaoeia
ajaaaaadaeaaaciaaiaaoekaadaaoeiaajaaaaadaeaaaeiaajaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeacaaahoaakaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcdaaeaaaa
eaaaabaaamabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaacnaaaaaafjaaaaaeegiocaaa
adaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
fpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
giaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaa
egbabaaaadaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaaaaaaaaaaafaaaaaa
kgiocaaaaaaaaaaaafaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaadaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaadaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaadaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaacaaaaaacgaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaacaaaaaachaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaacaaaaaaciaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaacaaaaaacjaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaacaaaaaackaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaacaaaaaaclaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaacmaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..17] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[1].zw, R0;
MUL result.texcoord[3].xyz, R1, c[14].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
Vector 17 [_BumpMap_ST]
"vs_2_0
; 21 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c18.x
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c18, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT1.zw, r0
mul oT3.xyz, r1, c14.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0
eefiecednicnaifjcooimicfmkkclmcpodednfhiabaaaaaaleafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcbiaeaaaaeaaaabaa
agabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaaadaaaaaa
baaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaafpaaaaad
dcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
pccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaaogikcaaa
aaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaaagiecaaa
aaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaaeaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
ConstBuffer "UnityShadows" 416
Vector 400 [unity_ShadowFadeCenterAndType]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 64 [glstate_matrix_modelview0]
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityShadows" 2
BindCB  "UnityPerDraw" 3
"vs_4_0_level_9_1
eefiecedndpdmhleknbhdmgonggpjnjoincnbkghabaaaaaaeaaiaaaaaeaaaaaa
daaaaaaaliacaaaaniagaaaakaahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
bmacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaaeaa
adaaabaaaaaaaaaaabaaafaaabaaaeaaaaaaaaaaacaabjaaabaaafaaaaaaaaaa
adaaaaaaaiaaagaaaaaaaaaaadaaamaaaeaaaoaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbcaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaadiaadaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaae
aaaaadoaadaaoejaacaaoekaacaaookaaeaaaaaeaaaaamoaadaaeejaadaaeeka
adaaoekaafaaaaadaaaaapiaaaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoeka
aaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaae
aaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffiaaeaaaaka
afaaaaadabaaaiiaabaaaaiabcaaaakaafaaaaadabaaafiaaaaapeiabcaaaaka
acaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeacaaadoaaeaaoejaabaaoeka
abaaookaafaaaaadabaaahiaaaaaffjaapaaoekaaeaaaaaeabaaahiaaoaaoeka
aaaaaajaabaaoeiaaeaaaaaeabaaahiabaaaoekaaaaakkjaabaaoeiaaeaaaaae
abaaahiabbaaoekaaaaappjaabaaoeiaacaaaaadabaaahiaabaaoeiaafaaoekb
afaaaaadadaaahoaabaaoeiaafaappkaafaaaaadabaaabiaaaaaffjaalaakkka
aeaaaaaeabaaabiaakaakkkaaaaaaajaabaaaaiaaeaaaaaeabaaabiaamaakkka
aaaakkjaabaaaaiaaeaaaaaeabaaabiaanaakkkaaaaappjaabaaaaiaabaaaaac
abaaaiiaafaappkaacaaaaadabaaaciaabaappibbcaaffkaafaaaaadadaaaioa
abaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcbiaeaaaa
eaaaabaaagabaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaaeegiocaaa
adaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaadaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaafaaaaaa
ogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaaadaaaaaa
agiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaacaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaa
aeaaaaaaegacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaa
aaaaaaaackiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaa
akaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaa
dkbabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaia
ebaaaaaaacaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaaeaaaaaa
bkaabaaaaaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaa
agaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
kbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaa
ljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeo
aafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaakl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[15] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[9];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[7];
DP4 R2.x, R1, c[5];
DP4 R2.y, R1, c[6];
MAD R1.xyz, R2, c[11].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
DP3 result.texcoord[3].y, R1, R3;
ADD result.texcoord[1].xy, R2, R2.z;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[12], c[12].zwzw;
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_LightmapST]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_2_0
; 26 ALU
def c15, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c8
mov r1.w, c15.y
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c15.x
mul r2.y, r2, c9.x
dp3 oT3.y, r1, r3
mad oT1.xy, r2.z, c10.zwzw, r2
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mov oPos, r0
mov oT1.zw, r0
mad oT0.zw, v3.xyxy, c14.xyxy, c14
mad oT0.xy, v3, c13, c13.zwzw
mad oT2.xy, v4, c12, c12.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlekpmnfbbjcgenpeocnblihojifhdcpgabaaaaaaiaafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcoeadaaaaeaaaabaa
pjaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
agaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaa
adaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaa
afaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaaagbebaaa
adaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
acaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaadaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaa
diaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaaabaaaaaa
diaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaaacaaaaaa
bbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaaagiacaaa
abaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
acaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaaegbcbaia
ebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
baaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
ConstBuffer "$Globals" 160
Vector 64 [unity_LightmapST]
Vector 80 [_MainTex_ST]
Vector 96 [_BumpMap_ST]
ConstBuffer "UnityPerCamera" 128
Vector 64 [_WorldSpaceCameraPos] 3
Vector 80 [_ProjectionParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecedeaodhoejlbfbfghcmahmhgndbmaffijpabaaaaaaamaiaaaaaeaaaaaa
daaaaaaaliacaaaakeagaaaagmahaaaaebgpgodjiaacaaaaiaacaaaaaaacpopp
ciacaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaeaa
adaaabaaaaaaaaaaabaaaeaaacaaaeaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaabaaaafaaakaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafapaaapkaaaaaaadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabia
abaaapjabpaaaaacafaaaciaacaaapjabpaaaaacafaaadiaadaaapjabpaaaaac
afaaaeiaaeaaapjaaeaaaaaeaaaaadoaadaaoejaacaaoekaacaaookaaeaaaaae
aaaaamoaadaaeejaadaaeekaadaaoekaafaaaaadaaaaapiaaaaaffjaahaaoeka
aeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaafaaaakaafaaaaadabaaaiiaabaaaaiaapaaaakaafaaaaad
abaaafiaaaaapeiaapaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaae
acaaadoaaeaaoejaabaaoekaabaaookaabaaaaacabaaahiaaeaaoekaafaaaaad
acaaahiaabaaffiaalaaoekaaeaaaaaeabaaaliaakaakekaabaaaaiaacaakeia
aeaaaaaeabaaahiaamaaoekaabaakkiaabaapeiaacaaaaadabaaahiaabaaoeia
anaaoekaaeaaaaaeabaaahiaabaaoeiaaoaappkaaaaaoejbaiaaaaadadaaaboa
abaaoejaabaaoeiaabaaaaacacaaahiaabaaoejaafaaaaadadaaahiaacaamjia
acaancjaaeaaaaaeacaaahiaacaamjjaacaanciaadaaoeibafaaaaadacaaahia
acaaoeiaabaappjaaiaaaaadadaaacoaacaaoeiaabaaoeiaaiaaaaadadaaaeoa
acaaoejaabaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacabaaamoaaaaaoeiappppaaaafdeieefcoeadaaaa
eaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaadhcbabaaaacaaaaaafpaaaaad
dcbabaaaadaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaadaaaaaaegiacaaa
aaaaaaaaafaaaaaaogikcaaaaaaaaaaaafaaaaaadcaaaaalmccabaaaabaaaaaa
agbebaaaadaaaaaaagiecaaaaaaaaaaaagaaaaaakgiocaaaaaaaaaaaagaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaa
aeaaaaaadiaaaaahhcaabaaaaaaaaaaajgbebaaaabaaaaaacgbjbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaajgbebaaaacaaaaaacgbjbaaaabaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgbpbaaa
abaaaaaadiaaaaajhcaabaaaabaaaaaafgifcaaaabaaaaaaaeaaaaaaegiccaaa
acaaaaaabbaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaaacaaaaaabaaaaaaa
agiacaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaadcaaaaalhcaabaaaabaaaaaa
egiccaaaacaaaaaabcaaaaaakgikcaaaabaaaaaaaeaaaaaaegacbaaaabaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegiccaaaacaaaaaabdaaaaaa
dcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaacaaaaaabeaaaaaa
egbcbaiaebaaaaaaaaaaaaaabaaaaaahcccabaaaaeaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaabaaaaaahbccabaaaaeaaaaaaegbcbaaaabaaaaaaegacbaaa
abaaaaaabaaaaaaheccabaaaaeaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"!!ARBfp1.0
# 17 ALU, 3 TEX
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.w, R0, c[1];
SLT R1.x, R0.w, c[2];
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[3], 2D;
LG2 R1.w, R1.w;
MUL R1.w, -R1, R2;
LG2 R1.x, R1.x;
LG2 R1.z, R1.z;
LG2 R1.y, R1.y;
ADD R1.xyz, -R1, fragment.texcoord[2];
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R1, c[0], R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_2_0
; 17 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c3, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r2, t0, s0
texldp r1, t1, s3
mov_pp r0.x, c2
mad_pp r0.x, r2.w, c1.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mul_pp r2.xyz, r2, c1
texkill r0.xyzw
texld r0, t0, s1
log_pp r0.x, r1.x
log_pp r0.z, r1.z
log_pp r0.y, r1.y
add_pp r3.xyz, -r0, t2
log_pp r0.x, r1.w
mul_pp r1.xyz, r3, c0
mul_pp r0.x, -r0, r0.w
mul_pp r4.xyz, r0.x, r1
mul_pp r1.x, r2.w, c1.w
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbafnpjhncappjheofcojfdealphimmagabaaaaaaheadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcieacaaaaeaaaaaaakbaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaacaaaaaa
egaobaaaacaaaaaadiaaaaaibcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaia
ebaaaaaaacaaaaaaaaaaaaaiocaabaaaabaaaaaaagajbaiaebaaaaaaacaaaaaa
agbjbaaaadaaaaaadiaaaaaihcaabaaaacaaaaaajgahbaaaabaaaaaaegiccaaa
aaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
jgahbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhopoodndomboiiagfekbhkknebhndnnpabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapiabaaaaieaeaaaaamafaaaaebgpgodjmaabaaaamaabaaaaaaacpppp
hiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaacaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbagaaaaac
acaaaiiaabaapplaafaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaacaioekaecaaaaadacaacpiaaaaaoelaabaioeka
apaaaaacacaacbiaabaaaaiaapaaaaacacaacciaabaaffiaapaaaaacacaaceia
abaakkiaapaaaaacabaacbiaabaappiaacaaaaadabaacoiaacaablibacaablla
afaaaaadacaachiaabaabliaaaaaoekaafaaaaadacaaciiaacaappiaabaaaaib
afaaaaadacaachiaacaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoeka
aeaaaaaeadaaciiaacaappiaaaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeia
abaabliaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcieacaaaa
eaaaaaaakbaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaahaaaaaadiaaaaaipcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaadiaaaaaibcaabaaa
abaaaaaadkaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaaaaaaaaaiocaabaaa
abaaaaaaagajbaiaebaaaaaaacaaaaaaagbjbaaaadaaaaaadiaaaaaihcaabaaa
acaaaaaajgahbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
akaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"!!ARBfp1.0
# 28 ALU, 5 TEX
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[5], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R4.x, R3.w, c[1].w;
SLT R0.x, R4, c[3];
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[4].x;
DP4 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[4].x, -R1;
MAD_SAT R1.w, R1, c[2].z, c[2];
MAD R1.xyz, R1.w, R2, R1;
MUL R2.xyz, R3, c[1];
KIL -R0.x;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R3.w, fragment.texcoord[0], texture[1], 2D;
LG2 R0.w, R0.w;
MUL R0.w, -R0, R3;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
ADD R0.xyz, -R0, R1;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R2, R0, R1;
MAD result.color.w, R0, c[0], R4.x;
END
# 28 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"ps_2_0
; 26 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c4, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s3
texld r3, t2, s4
texld r4, t0, s1
mov_pp r0.x, c3
mad_pp r0.x, r1.w, c1.w, -r0
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
log_pp r2.x, r2.x
log_pp r2.y, r2.y
log_pp r2.z, r2.z
mul_pp r3.xyz, r3.w, r3
mul_pp r1.xyz, r1, c1
texkill r0.xyzw
texld r0, t2, s5
mul_pp r4.xyz, r0.w, r0
mul_pp r4.xyz, r4, c4.z
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c4.z, -r4
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r3, r4
add_pp r3.xyz, -r2, r0
mul_pp r2.xyz, r3, c0
log_pp r0.x, r2.w
mul_pp r0.x, -r0, r4.w
mul_pp r4.xyz, r0.x, r2
mul_pp r2.x, r1.w, c1.w
mad_pp r1.xyz, r1, r3, r4
mad_pp r1.w, r0.x, c0, r2.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 112 [unity_LightmapFade]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecediikefkbmapoddgooiodmomedkmfbajdfabaaaaaabeafaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcamaeaaaaeaaaaaaaadabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaaeaaaaaa
egbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaal
bcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
jgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaa
acaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaa
acaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaa
dkaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 112 [unity_LightmapFade]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedabiihiacnjkmapjdiegchodfkcholpmnabaaaaaaoeahaaaaaeaaaaaa
daaaaaaapmacaaaabaahaaaalaahaaaaebgpgodjmeacaaaameacaaaaaaacpppp
giacaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaahaa
abaaacaaaaaaaaaaaaaaajaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaadaaaakbagaaaaacacaaaiiaabaapplaafaaaaadacaaadia
acaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoelaaeaioeka
ecaaaaadadaacpiaacaaoelaadaioekaecaaaaadacaacpiaacaaoeiaacaioeka
ecaaaaadaeaacpiaaaaaoelaabaioekaajaaaaadaeaaabiaadaaoelaadaaoela
ahaaaaacaeaaabiaaeaaaaiaagaaaaacaeaaabiaaeaaaaiaaeaaaaaeaeaadbia
aeaaaaiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaaeaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaadaappiaaeaaaakaaeaaaaae
adaachiaabaappiaadaaoeiaabaaoeibaeaaaaaeabaachiaaeaaaaiaadaaoeia
abaaoeiaapaaaaacadaacbiaacaaaaiaapaaaaacadaacciaacaaffiaapaaaaac
adaaceiaacaakkiaapaaaaacabaaciiaacaappiaacaaaaadabaachiaabaaoeia
adaaoeibafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadabaaciiaaeaappia
abaappibafaaaaadacaachiaabaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeia
abaaoekaaeaaaaaeadaaciiaabaappiaaaaappkaaaaappiaaeaaaaaeadaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
amaeaaaaeaaaaaaaadabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaaeaaaaaaegbobaaa
aeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaalbcaabaaa
abaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaaaaaaaaaa
ahaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaaaagabaaa
adaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaeb
dcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaajgahbaia
ebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaacpaaaaafpcaabaaaacaaaaaaegaobaaaacaaaaaa
aaaaaaaihcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaacaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaadkaabaaa
adaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaa
dkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaa
iaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
imaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"!!ARBfp1.0
# 52 ALU, 6 TEX
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
TEX R3, fragment.texcoord[2], texture[5], 2D;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xw, fragment.texcoord[0], texture[1], 2D;
MAD R5.xy, R5.wyzw, c[3].x, -c[3].y;
MUL R1.w, R1, c[1];
SLT R0.x, R1.w, c[2];
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[3].z;
MUL R6.xyz, R3.y, c[5];
MAD R6.xyz, R3.x, c[6], R6;
MAD R6.xyz, R3.z, c[4], R6;
DP3 R3.w, R6, R6;
RSQ R3.w, R3.w;
MUL R6.xyz, R3.w, R6;
MUL R5.zw, R5.xyxy, R5.xyxy;
ADD_SAT R4.y, R5.z, R5.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MAD R6.xyz, R3.w, fragment.texcoord[3], R6;
DP3 R3.w, R6, R6;
RSQ R3.w, R3.w;
ADD R4.y, -R4, c[3];
RSQ R4.y, R4.y;
MUL R6.xyz, R3.w, R6;
RCP R5.z, R4.y;
DP3 R3.w, R5, R6;
MUL R2.xyz, R2.w, R2;
MAX R3.w, R3, c[3];
DP3_SAT R6.z, R5, c[4];
DP3_SAT R6.x, R5, c[6];
DP3_SAT R6.y, R5, c[5];
DP3 R3.y, R6, R3;
MUL_SAT R3.x, R4, R4.w;
MUL R2.w, R3.x, c[4];
MUL R2.xyz, R2, R3.y;
MUL R2.xyz, R2, c[3].z;
POW R2.w, R3.w, R2.w;
MUL R1.xyz, R1, c[1];
KIL -R0.x;
TXP R0, fragment.texcoord[1], texture[3], 2D;
LG2 R0.x, R0.x;
LG2 R0.y, R0.y;
LG2 R0.z, R0.z;
LG2 R0.w, R0.w;
ADD R0, -R0, R2;
MUL R0.w, R0, R4;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[0], R1;
END
# 52 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"ps_2_0
; 55 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c3, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r0, t0, s0
texld r3, t2, s4
texld r4, t0, s1
texld r5, t2, s5
mov_pp r1.x, c2
mad_pp r1.x, r0.w, c1.w, -r1
cmp r1.x, r1, c3, c3.y
mov_pp r1, -r1.x
mul_pp r5.xyz, r5.w, r5
mul_pp r5.xyz, r5, c4.w
mul r6.xyz, r5.y, c5
mad r6.xyz, r5.x, c6, r6
mul_pp_sat r4.x, r4, r4.w
mad r6.xyz, r5.z, c4, r6
dp3_pp r7.x, t3, t3
mul_pp r4.x, r4, c5.w
mul_pp r3.xyz, r3.w, r3
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r0.xyz, r0, c1
texld r2, r2, s2
texkill r1.xyzw
texldp r1, t1, s3
dp3 r2.x, r6, r6
rsq r2.x, r2.x
mul r6.xyz, r2.x, r6
mov r2.x, r2.w
mad_pp r8.xy, r2, c3.z, c3.w
rsq_pp r2.x, r7.x
mad_pp r2.xyz, r2.x, t3, r6
mul_pp r6.xy, r8, r8
add_pp_sat r6.x, r6, r6.y
dp3_pp r7.x, r2, r2
rsq_pp r7.x, r7.x
add_pp r6.x, -r6, c3.y
rsq_pp r6.x, r6.x
mul_pp r2.xyz, r7.x, r2
rcp_pp r8.z, r6.x
dp3_pp r2.x, r8, r2
max_pp r2.x, r2, c3
pow r6.x, r2.x, r4.x
dp3_pp_sat r2.z, r8, c4
dp3_pp_sat r2.y, r8, c5
dp3_pp_sat r2.x, r8, c6
dp3_pp r2.x, r2, r5
mul_pp r2.xyz, r3, r2.x
mul_pp r2.xyz, r2, c4.w
mov r2.w, r6.x
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
log_pp r1.w, r1.w
add_pp r1, -r1, r2
mul_pp r3.x, r1.w, r4.w
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r4.x, r0.w, c1.w
mad_pp r0.xyz, r1, r0, r2
mad_pp r0.w, r3.x, c0, r4.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeopakgkkidjkmgjciijealoamgfgmcpnabaaaaaaeeaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcdmahaaaaeaaaaaaampabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaa
egbcbaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaa
acaaaaaadiaaaaakhcaabaaaaeaaaaaafgafbaaaadaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaaeaaaaaaagaabaaaadaaaaaa
aceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaaeaaaaaadcaaaaam
hcaabaaaaeaaaaaakgakbaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaaeaaaaaa
egaabaaaaeaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaeaaaaaadkaabaaaacaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaaefaaaaajpcaabaaaafaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadicaaaahccaabaaaacaaaaaadkaabaaaafaaaaaaakaabaaa
afaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaabjaaaaaf
icaabaaaacaaaaaaakaabaaaacaaaaaaapcaaaakbcaabaaaafaaaaaaaceaaaaa
olaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaeaaaaaabacaaaakccaabaaa
afaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaaeaaaaaa
bacaaaakecaabaaaafaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahccaabaaaadaaaaaadkaabaaaaeaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaafgafbaaaadaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaadaaaaaajgahbaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaafaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpichnjecgihpahdicjaajbpmahmlhpgcabaaaaaaliamaaaaaeaaaaaa
daaaaaaakaaeaaaaoealaaaaieamaaaaebgpgodjgiaeaaaagiaeaaaaaaacpppp
beaeaaaafeaaaaaaacaadmaaaaaafeaaaaaafeaaagaaceaaaaaafeaaaaaaaaaa
acababaaabacacaaadadadaaaeaeaeaaafafafaaaaaaacaaacaaaaaaaaaaaaaa
aaaaajaaabaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafaeaaapkaomafnblopdaedfdpdkmnbddpaaaaaaed
fbaaaaafafaaapkaolafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafagaaapka
aaaaaaebdkmnbddpaaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
abaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbabaaaaacacaaabia
aaaakklaabaaaaacacaaaciaaaaapplaagaaaaacacaaaeiaabaapplaafaaaaad
adaaadiaacaakkiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoela
aeaioekaecaaaaadacaacpiaacaaoeiaabaioekaecaaaaadaeaacpiaacaaoela
afaioekaecaaaaadafaacpiaaaaaoelaacaioekaecaaaaadadaacpiaadaaoeia
adaioekaafaaaaadabaaciiaabaappiaagaaaakaafaaaaadabaachiaabaaoeia
abaappiaaeaaaaaeagaacbiaacaappiaadaaaakaadaaffkaaeaaaaaeagaaccia
acaaffiaadaaaakaadaaffkafkaaaaaeabaadiiaagaaoeiaagaaoeiaadaakkka
acaaaaadabaaciiaabaappibadaappkaahaaaaacabaaciiaabaappiaagaaaaac
agaaceiaabaappiaaiaaaaadacaadbiaagaablkaagaaoeiaaiaaaaadacaadcia
aeaaoekaagaaoeiaaiaaaaadacaadeiaafaaoekaagaaoeiaafaaaaadabaaciia
aeaappiaagaaaakaafaaaaadaeaachiaaeaaoeiaabaappiaaiaaaaadabaaciia
acaaoeiaaeaaoeiaafaaaaadabaachiaabaappiaabaaoeiaafaaaaadacaaahia
aeaaffiaaeaaoekaaeaaaaaeacaaahiaaeaaaaiaagaablkaacaaoeiaaeaaaaae
acaaahiaaeaakkiaafaaoekaacaaoeiaaiaaaaadacaaaiiaacaaoeiaacaaoeia
ahaaaaacacaaaiiaacaappiaceaaaaacaeaachiaadaaoelaaeaaaaaeacaachia
acaaoeiaacaappiaaeaaoeiaceaaaaacaeaachiaacaaoeiaaiaaaaadacaacbia
agaaoeiaaeaaoeiaalaaaaadaeaaabiaacaaaaiaadaakkkaafaaaaadacaadbia
afaappiaafaaaaiaafaaaaadacaaabiaacaaaaiaaeaappkacaaaaaadabaaciia
aeaaaaiaacaaaaiaapaaaaacacaacbiaadaaaaiaapaaaaacacaacciaadaaffia
apaaaaacacaaceiaadaakkiaapaaaaacacaaciiaadaappiaacaaaaadabaacpia
abaaoeiaacaaoeibafaaaaadabaaciiaafaappiaabaappiaafaaaaadacaachia
abaaoeiaaaaaoekaafaaaaadacaachiaabaappiaacaaoeiaafaaaaadaaaacpia
aaaaoeiaabaaoekaaeaaaaaeadaaciiaabaappiaaaaappkaaaaappiaaeaaaaae
adaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcdmahaaaaeaaaaaaampabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaacpaaaaafpcaabaaaabaaaaaaegaobaaaabaaaaaabaaaaaah
bcaabaaaacaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaa
acaaaaaaakaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaacaaaaaa
egbcbaaaaeaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaa
afaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaadaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaapgapbaaa
acaaaaaadiaaaaakhcaabaaaaeaaaaaafgafbaaaadaaaaaaaceaaaaaomafnblo
pdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaaaeaaaaaaagaabaaaadaaaaaa
aceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaaeaaaaaadcaaaaam
hcaabaaaaeaaaaaakgakbaaaadaaaaaaaceaaaaaolafnblopdaedflpdkmnbddp
aaaaaaaaegacbaaaaeaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaeaaaaaaeeaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaeaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
icaabaaaacaaaaaadkaabaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaaeaaaaaaogbkbaaaabaaaaaa
eghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaeaaaaaahgapbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaaacaaaaaaegaabaaaaeaaaaaa
egaabaaaaeaaaaaaddaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaiadpaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpelaaaaafecaabaaaaeaaaaaadkaabaaaacaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaadeaaaaahbcaabaaaacaaaaaa
akaabaaaacaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaacaaaaaaakaabaaa
acaaaaaaefaaaaajpcaabaaaafaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadicaaaahccaabaaaacaaaaaadkaabaaaafaaaaaaakaabaaa
afaaaaaadiaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaaabeaaaaaaaaaaaed
diaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaabkaabaaaacaaaaaabjaaaaaf
icaabaaaacaaaaaaakaabaaaacaaaaaaapcaaaakbcaabaaaafaaaaaaaceaaaaa
olaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaaaeaaaaaabacaaaakccaabaaa
afaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaaeaaaaaa
bacaaaakecaabaaaafaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaaeaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaa
adaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaa
aagabaaaaeaaaaaadiaaaaahccaabaaaadaaaaaadkaabaaaaeaaaaaaabeaaaaa
aaaaaaebdiaaaaahocaabaaaadaaaaaaagajbaaaaeaaaaaafgafbaaaadaaaaaa
diaaaaahhcaabaaaacaaaaaaagaabaaaadaaaaaajgahbaaaadaaaaaaaaaaaaai
pcaabaaaabaaaaaaegaobaiaebaaaaaaabaaaaaaegaobaaaacaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaafaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"!!ARBfp1.0
# 13 ALU, 3 TEX
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2.w, fragment.texcoord[0], texture[1], 2D;
MUL R0.w, R0, c[1];
SLT R1.x, R0.w, c[2];
MUL R0.xyz, R0, c[1];
KIL -R1.x;
TXP R1, fragment.texcoord[1], texture[3], 2D;
ADD R1.xyz, R1, fragment.texcoord[2];
MUL R1.w, R1, R2;
MUL R2.xyz, R1, c[0];
MUL R2.xyz, R1.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R1, c[0], R0;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
"ps_2_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
def c3, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1
dcl t2.xyz
texld r1, t0, s1
texld r2, t0, s0
mov_pp r0.x, c2
mad_pp r0.x, r2.w, c1.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
mul_pp r2.xyz, r2, c1
texkill r0.xyzw
texldp r0, t1, s3
add_pp r3.xyz, r0, t2
mul_pp r1.xyz, r3, c0
mul_pp r0.x, r0.w, r1.w
mul_pp r4.xyz, r0.x, r1
mul_pp r1.x, r2.w, c1.w
mad_pp r2.xyz, r2, r3, r4
mad_pp r2.w, r0.x, c0, r1.x
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefieceddldhhjkpmieikmfldbhgbnbpldbllombabaaaaaafiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaaagbjbaaaadaaaaaadiaaaaaihcaabaaaacaaaaaajgahbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
ConstBuffer "$Globals" 128
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 112 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkgbgkakeolpegahheopfhmkdbongfekaabaaaaaapeaeaaaaaeaaaaaa
daaaaaaamiabaaaadiaeaaaamaaeaaaaebgpgodjjaabaaaajaabaaaaaaacpppp
eiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaacaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaaiaacaaahlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaac
abaaaiiaabaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbagaaaaac
acaaaiiaabaapplaafaaaaadacaaadiaacaappiaabaaoelaebaaaaababaaapia
ecaaaaadabaacpiaaaaaoelaabaioekaecaaaaadacaacpiaacaaoeiaacaioeka
afaaaaadaaaacpiaaaaaoeiaabaaoekaafaaaaadacaaciiaabaappiaacaappia
acaaaaadabaachiaacaaoeiaacaaoelaafaaaaadacaachiaabaaoeiaaaaaoeka
afaaaaadacaachiaacaappiaacaaoeiaaeaaaaaeadaaciiaacaappiaaaaappka
aaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcgiacaaaaeaaaaaaajkaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaa
abaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaa
aaaaaaaaahaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahbcaabaaaabaaaaaa
dkaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaahocaabaaaabaaaaaaagajbaaa
acaaaaaaagbjbaaaadaaaaaadiaaaaaihcaabaaaacaaaaaajgahbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaaakaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapadaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapalaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"!!ARBfp1.0
# 24 ALU, 5 TEX
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[2], texture[5], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
MUL R4.x, R3.w, c[1].w;
SLT R0.x, R4, c[3];
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[4].x;
DP4 R2.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.w, R2.w;
RCP R1.w, R1.w;
MAD R2.xyz, R2, c[4].x, -R1;
MAD_SAT R1.w, R1, c[2].z, c[2];
MAD R1.xyz, R1.w, R2, R1;
MUL R2.xyz, R3, c[1];
KIL -R0.x;
TXP R0, fragment.texcoord[1], texture[3], 2D;
TEX R3.w, fragment.texcoord[0], texture[1], 2D;
ADD R0.xyz, R0, R1;
MUL R0.w, R0, R3;
MUL R1.xyz, R0, c[0];
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R2, R0, R1;
MAD result.color.w, R0, c[0], R4.x;
END
# 24 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [unity_LightmapFade]
Float 3 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"ps_2_0
; 22 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c4, 0.00000000, 1.00000000, 8.00000000, 0
dcl t0.xy
dcl t1
dcl t2.xy
dcl t3
texld r1, t0, s0
texldp r2, t1, s3
texld r3, t2, s5
texld r4, t0, s1
mov_pp r0.x, c3
mad_pp r0.x, r1.w, c1.w, -r0
cmp r0.x, r0, c4, c4.y
mov_pp r0, -r0.x
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c4.z
mul_pp r1.xyz, r1, c1
texkill r0.xyzw
texld r0, t2, s4
mul_pp r4.xyz, r0.w, r0
mad_pp r4.xyz, r4, c4.z, -r3
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r4, r3
add_pp r3.xyz, r2, r0
mul_pp r2.xyz, r3, c0
mul_pp r0.x, r2.w, r4.w
mul_pp r4.xyz, r0.x, r2
mul_pp r2.x, r1.w, c1.w
mad_pp r1.xyz, r1, r3, r4
mad_pp r1.w, r0.x, c0, r2.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 112 [unity_LightmapFade]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedabgnnkojblklhiklnjgpiidiilkcnlbiabaaaaaapiaeaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpaadaaaaeaaaaaaapmaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaa
adaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaaabaaaaaaegbobaaaaeaaaaaa
egbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadccaaaal
bcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaa
aaaaaaaaahaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaa
aeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaadkaabaaaacaaaaaa
abeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaaagajbaaaacaaaaaafgafbaaa
abaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaahicaabaaaacaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaaacaaaaaaegacbaaaacaaaaaa
jgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaagaabaaaabaaaaaa
egacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
acaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaa
egacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_LightBuffer] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
SetTexture 4 [unity_LightmapInd] 2D 4
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Vector 112 [unity_LightmapFade]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddomgfehjpelgdaemcfhpgdcfbnegbnphabaaaaaajiahaaaaaeaaaaaa
daaaaaaammacaaaameagaaaageahaaaaebgpgodjjeacaaaajeacaaaaaaacpppp
diacaaaafmaaaaaaadaadiaaaaaafmaaaaaafmaaafaaceaaaaaafmaaaaaaaaaa
abababaaacacacaaadadadaaaeaeaeaaaaaaacaaacaaaaaaaaaaaaaaaaaaahaa
abaaacaaaaaaaaaaaaaaajaaabaaadaaaaaaaaaaaaacppppfbaaaaafaeaaapka
aaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkaecaaaaad
aaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiiaabaappkaaeaaaaaeabaacpia
aaaappiaabaappiaadaaaakbagaaaaacacaaaiiaabaapplaafaaaaadacaaadia
acaappiaabaaoelaebaaaaababaaapiaecaaaaadabaacpiaacaaoelaaeaioeka
ecaaaaadadaacpiaacaaoelaadaioekaecaaaaadacaacpiaacaaoeiaacaioeka
ecaaaaadaeaacpiaaaaaoelaabaioekaajaaaaadaeaaabiaadaaoelaadaaoela
ahaaaaacaeaaabiaaeaaaaiaagaaaaacaeaaabiaaeaaaaiaaeaaaaaeaeaadbia
aeaaaaiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaaeaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaadaappiaaeaaaakaaeaaaaae
adaachiaabaappiaadaaoeiaabaaoeibaeaaaaaeabaachiaaeaaaaiaadaaoeia
abaaoeiaacaaaaadabaachiaabaaoeiaacaaoeiaafaaaaadacaachiaabaaoeia
aaaaoekaafaaaaadabaaciiaacaappiaaeaappiaafaaaaadacaachiaabaappia
acaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoekaaeaaaaaeadaaciiaabaappia
aaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeiaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefcpaadaaaaeaaaaaaapmaaaaaafjaaaaae
egiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaad
aagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
pcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabbaaaaahbcaabaaa
abaaaaaaegbobaaaaeaaaaaaegbobaaaaeaaaaaaelaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadccaaaalbcaabaaaabaaaaaaakaabaaaabaaaaaackiacaaa
aaaaaaaaahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaabaaaaaa
agajbaaaacaaaaaafgafbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
adaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaacaaaaaa
dkaabaaaacaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaacaaaaaapgapbaaa
acaaaaaaegacbaaaacaaaaaajgahbaiaebaaaaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaoaaaaah
dcaabaaaacaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaa
acaaaaaaegaabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaa
adaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaacaaaaaadkaabaaaadaaaaaadiaaaaahhcaabaaa
acaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaa
dkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"!!ARBfp1.0
# 48 ALU, 6 TEX
PARAM c[7] = { program.local[0..2],
		{ 2, 1, 8, 0 },
		{ -0.40824828, -0.70710677, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[4], 2D;
TEX R3, fragment.texcoord[2], texture[5], 2D;
TEX R5.yw, fragment.texcoord[0].zwzw, texture[2], 2D;
TEX R4.xw, fragment.texcoord[0], texture[1], 2D;
MAD R5.xy, R5.wyzw, c[3].x, -c[3].y;
MUL R1.w, R1, c[1];
SLT R0.x, R1.w, c[2];
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[3].z;
MUL R6.xyz, R3.y, c[5];
MAD R6.xyz, R3.x, c[6], R6;
MAD R6.xyz, R3.z, c[4], R6;
DP3 R3.w, R6, R6;
RSQ R3.w, R3.w;
MUL R6.xyz, R3.w, R6;
MUL R5.zw, R5.xyxy, R5.xyxy;
ADD_SAT R4.y, R5.z, R5.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R3.w, R3.w;
MAD R6.xyz, R3.w, fragment.texcoord[3], R6;
DP3 R3.w, R6, R6;
RSQ R3.w, R3.w;
ADD R4.y, -R4, c[3];
RSQ R4.y, R4.y;
MUL R6.xyz, R3.w, R6;
RCP R5.z, R4.y;
DP3 R3.w, R5, R6;
MUL R2.xyz, R2.w, R2;
MAX R3.w, R3, c[3];
DP3_SAT R6.z, R5, c[4];
DP3_SAT R6.x, R5, c[6];
DP3_SAT R6.y, R5, c[5];
DP3 R3.y, R6, R3;
MUL_SAT R3.x, R4, R4.w;
MUL R2.w, R3.x, c[4];
MUL R2.xyz, R2, R3.y;
MUL R2.xyz, R2, c[3].z;
POW R2.w, R3.w, R2.w;
MUL R1.xyz, R1, c[1];
KIL -R0.x;
TXP R0, fragment.texcoord[1], texture[3], 2D;
ADD R0, R0, R2;
MUL R0.w, R0, R4;
MUL R2.xyz, R0, c[0];
MUL R2.xyz, R0.w, R2;
MAD result.color.xyz, R0, R1, R2;
MAD result.color.w, R0, c[0], R1;
END
# 48 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Float 2 [_Cutoff]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 1
SetTexture 2 [_BumpMap] 2D 2
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
"ps_2_0
; 51 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c3, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c4, -0.40824828, -0.70710677, 0.57735026, 8.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 128.00000000
def c6, 0.81649655, 0.00000000, 0.57735026, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3.xyz
texld r0, t0, s0
texld r3, t2, s4
texld r4, t0, s1
texld r5, t2, s5
mov_pp r1.x, c2
mad_pp r1.x, r0.w, c1.w, -r1
cmp r1.x, r1, c3, c3.y
mov_pp r1, -r1.x
mul_pp r5.xyz, r5.w, r5
mul_pp r5.xyz, r5, c4.w
mul r6.xyz, r5.y, c5
mad r6.xyz, r5.x, c6, r6
mul_pp_sat r4.x, r4, r4.w
mad r6.xyz, r5.z, c4, r6
dp3_pp r7.x, t3, t3
mul_pp r4.x, r4, c5.w
mul_pp r3.xyz, r3.w, r3
mov r2.y, t0.w
mov r2.x, t0.z
mul_pp r0.xyz, r0, c1
texld r2, r2, s2
texkill r1.xyzw
texldp r1, t1, s3
dp3 r2.x, r6, r6
rsq r2.x, r2.x
mul r6.xyz, r2.x, r6
mov r2.x, r2.w
mad_pp r8.xy, r2, c3.z, c3.w
rsq_pp r2.x, r7.x
mad_pp r2.xyz, r2.x, t3, r6
mul_pp r6.xy, r8, r8
add_pp_sat r6.x, r6, r6.y
dp3_pp r7.x, r2, r2
rsq_pp r7.x, r7.x
add_pp r6.x, -r6, c3.y
rsq_pp r6.x, r6.x
mul_pp r2.xyz, r7.x, r2
rcp_pp r8.z, r6.x
dp3_pp r2.x, r8, r2
max_pp r2.x, r2, c3
pow r6.x, r2.x, r4.x
dp3_pp_sat r2.z, r8, c4
dp3_pp_sat r2.y, r8, c5
dp3_pp_sat r2.x, r8, c6
dp3_pp r2.x, r2, r5
mul_pp r2.xyz, r3, r2.x
mul_pp r2.xyz, r2, c4.w
mov r2.w, r6.x
add_pp r1, r1, r2
mul_pp r3.x, r1.w, r4.w
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r3.x, r2
mul_pp r4.x, r0.w, c1.w
mad_pp r0.xyz, r1, r0, r2
mad_pp r0.w, r3.x, c0, r4.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0
eefiecedajffffghmmnphnmgfgkmonekbeecdaljabaaaaaacmaiaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcceahaaaaeaaaaaaamjabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafkaaaaad
aagabaaaafaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaa
adaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaafibiaaaeaahabaaa
afaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacagaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaambcaabaaaabaaaaaadkaabaaa
aaaaaaaadkiacaaaaaaaaaaaadaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaaaeaaaaaaegbcbaaa
aeaaaaaaeeaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaabaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
egbabaaaadaaaaaaeghobaaaafaaaaaaaagabaaaafaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaacaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaapgapbaaaabaaaaaadiaaaaakhcaabaaaadaaaaaafgafbaaa
acaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaadcaaaaamhcaabaaa
adaaaaaaagaabaaaacaaaaaaaceaaaaaolaffbdpaaaaaaaadkmnbddpaaaaaaaa
egacbaaaadaaaaaadcaaaaamhcaabaaaadaaaaaakgakbaaaacaaaaaaaceaaaaa
olafnblopdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaaeeaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadcaaaaajhcaabaaaabaaaaaaegacbaaaadaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaogbkbaaaabaaaaaaeghobaaaacaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaadaaaaaahgapbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaapaaaaahicaabaaa
abaaaaaaegaabaaaadaaaaaaegaabaaaadaaaaaaddaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaiadpaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaiadpelaaaaafecaabaaaadaaaaaadkaabaaa
abaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaa
deaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaacpaaaaaf
bcaabaaaabaaaaaaakaabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadicaaaahccaabaaaabaaaaaa
dkaabaaaaeaaaaaaakaabaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaa
abaaaaaaabeaaaaaaaaaaaeddiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
bkaabaaaabaaaaaabjaaaaaficaabaaaabaaaaaaakaabaaaabaaaaaaaoaaaaah
dcaabaaaaeaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaaeaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaaapcaaaak
bcaabaaaaeaaaaaaaceaaaaaolaffbdpdkmnbddpaaaaaaaaaaaaaaaaigaabaaa
adaaaaaabacaaaakccaabaaaaeaaaaaaaceaaaaaomafnblopdaedfdpdkmnbddp
aaaaaaaaegacbaaaadaaaaaabacaaaakecaabaaaaeaaaaaaaceaaaaaolafnblo
pdaedflpdkmnbddpaaaaaaaaegacbaaaadaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegbabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaeaaaaaadiaaaaahccaabaaaacaaaaaa
dkaabaaaadaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaacaaaaaaagajbaaa
adaaaaaafgafbaaaacaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaacaaaaaa
jgahbaaaacaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
afaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaaeaaaaaadkaabaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadcaaaaak
iccabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaacaaaaaadkaabaaa
aaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_SpecMap] 2D 2
SetTexture 2 [_BumpMap] 2D 1
SetTexture 3 [_LightBuffer] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
SetTexture 5 [unity_LightmapInd] 2D 5
ConstBuffer "$Globals" 160
Vector 32 [_SpecColor]
Vector 48 [_Color]
Float 144 [_Cutoff]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmfeadaobciahgmhcddhhekkeacpnddfnabaaaaaahaamaaaaaeaaaaaa
daaaaaaahaaeaaaajmalaaaadmamaaaaebgpgodjdiaeaaaadiaeaaaaaaacpppp
oeadaaaafeaaaaaaacaadmaaaaaafeaaaaaafeaaagaaceaaaaaafeaaaaaaaaaa
acababaaabacacaaadadadaaaeaeaeaaafafafaaaaaaacaaacaaaaaaaaaaaaaa
aaaaajaaabaaacaaaaaaaaaaaaacppppfbaaaaafadaaapkaaaaaaaeaaaaaialp
aaaaaaaaaaaaiadpfbaaaaafaeaaapkaomafnblopdaedfdpdkmnbddpaaaaaaed
fbaaaaafafaaapkaolafnblopdaedflpdkmnbddpaaaaaaaafbaaaaafagaaapka
aaaaaaebdkmnbddpaaaaaaaaolaffbdpbpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaiaadaachla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkabpaaaaacaaaaaajaadaiapkabpaaaaacaaaaaajaaeaiapkabpaaaaac
aaaaaajaafaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaaaiia
abaappkaaeaaaaaeabaacpiaaaaappiaabaappiaacaaaakbagaaaaacacaaaiia
abaapplaafaaaaadacaaadiaacaappiaabaaoelaabaaaaacadaaabiaaaaakkla
abaaaaacadaaaciaaaaapplaebaaaaababaaapiaecaaaaadabaacpiaacaaoeia
adaioekaecaaaaadacaacpiaacaaoelaaeaioekaecaaaaadadaacpiaadaaoeia
abaioekaecaaaaadaeaacpiaacaaoelaafaioekaecaaaaadafaacpiaaaaaoela
acaioekaafaaaaadacaaciiaacaappiaagaaaakaafaaaaadacaachiaacaaoeia
acaappiaaeaaaaaeagaacbiaadaappiaadaaaakaadaaffkaaeaaaaaeagaaccia
adaaffiaadaaaakaadaaffkafkaaaaaeacaadiiaagaaoeiaagaaoeiaadaakkka
acaaaaadacaaciiaacaappibadaappkaahaaaaacacaaciiaacaappiaagaaaaac
agaaceiaacaappiaaiaaaaadadaadbiaagaablkaagaaoeiaaiaaaaadadaadcia
aeaaoekaagaaoeiaaiaaaaadadaadeiaafaaoekaagaaoeiaafaaaaadacaaciia
aeaappiaagaaaakaafaaaaadaeaachiaaeaaoeiaacaappiaaiaaaaadacaaciia
adaaoeiaaeaaoeiaafaaaaadacaachiaacaappiaacaaoeiaafaaaaadadaaahia
aeaaffiaaeaaoekaaeaaaaaeadaaahiaaeaaaaiaagaablkaadaaoeiaaeaaaaae
adaaahiaaeaakkiaafaaoekaadaaoeiaaiaaaaadadaaaiiaadaaoeiaadaaoeia
ahaaaaacadaaaiiaadaappiaceaaaaacaeaachiaadaaoelaaeaaaaaeadaachia
adaaoeiaadaappiaaeaaoeiaceaaaaacaeaachiaadaaoeiaaiaaaaadadaacbia
agaaoeiaaeaaoeiaalaaaaadaeaaabiaadaaaaiaadaakkkaafaaaaadadaadbia
afaappiaafaaaaiaafaaaaadadaaabiaadaaaaiaaeaappkacaaaaaadacaaciia
aeaaaaiaadaaaaiaacaaaaadabaacpiaabaaoeiaacaaoeiaafaaaaadabaaciia
afaappiaabaappiaafaaaaadacaachiaabaaoeiaaaaaoekaafaaaaadacaachia
abaappiaacaaoeiaafaaaaadaaaacpiaaaaaoeiaabaaoekaaeaaaaaeadaaciia
abaappiaaaaappkaaaaappiaaeaaaaaeadaachiaaaaaoeiaabaaoeiaacaaoeia
abaaaaacaaaicpiaadaaoeiappppaaaafdeieefcceahaaaaeaaaaaaamjabaaaa
fjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacagaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaambcaabaaaabaaaaaadkaabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaeeaaaaafbcaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaabaaaaaaegbcbaaa
aeaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaadaaaaaaeghobaaaafaaaaaa
aagabaaaafaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaacaaaaaaabeaaaaa
aaaaaaebdiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaapgapbaaaabaaaaaa
diaaaaakhcaabaaaadaaaaaafgafbaaaacaaaaaaaceaaaaaomafnblopdaedfdp
dkmnbddpaaaaaaaadcaaaaamhcaabaaaadaaaaaaagaabaaaacaaaaaaaceaaaaa
olaffbdpaaaaaaaadkmnbddpaaaaaaaaegacbaaaadaaaaaadcaaaaamhcaabaaa
adaaaaaakgakbaaaacaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaa
egacbaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
adaaaaaaeeaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadcaaaaajhcaabaaa
abaaaaaaegacbaaaadaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaeeaaaaaficaabaaa
abaaaaaadkaabaaaabaaaaaadiaaaaahhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaadaaaaaahgapbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaapaaaaahicaabaaaabaaaaaaegaabaaaadaaaaaaegaabaaa
adaaaaaaddaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaiadp
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
elaaaaafecaabaaaadaaaaaadkaabaaaabaaaaaabaaaaaahbcaabaaaabaaaaaa
egacbaaaadaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaacpaaaaafbcaabaaaabaaaaaaakaabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadicaaaahccaabaaaabaaaaaadkaabaaaaeaaaaaaakaabaaaaeaaaaaa
diaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaaabeaaaaaaaaaaaeddiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaabkaabaaaabaaaaaabjaaaaaficaabaaa
abaaaaaaakaabaaaabaaaaaaaoaaaaahdcaabaaaaeaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaaapcaaaakbcaabaaaaeaaaaaaaceaaaaaolaffbdp
dkmnbddpaaaaaaaaaaaaaaaaigaabaaaadaaaaaabacaaaakccaabaaaaeaaaaaa
aceaaaaaomafnblopdaedfdpdkmnbddpaaaaaaaaegacbaaaadaaaaaabacaaaak
ecaabaaaaeaaaaaaaceaaaaaolafnblopdaedflpdkmnbddpaaaaaaaaegacbaaa
adaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaacaaaaaa
efaaaaajpcaabaaaadaaaaaaegbabaaaadaaaaaaeghobaaaaeaaaaaaaagabaaa
aeaaaaaadiaaaaahccaabaaaacaaaaaadkaabaaaadaaaaaaabeaaaaaaaaaaaeb
diaaaaahocaabaaaacaaaaaaagajbaaaadaaaaaafgafbaaaacaaaaaadiaaaaah
hcaabaaaabaaaaaaagaabaaaacaaaaaajgahbaaaacaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaafaaaaaadiaaaaahicaabaaaabaaaaaa
dkaabaaaaeaaaaaadkaabaaaabaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaaegiccaaaaaaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaapgapbaaa
abaaaaaaegacbaaaacaaaaaadcaaaaakiccabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Transparent/Cutout/Bumped Specular"
}