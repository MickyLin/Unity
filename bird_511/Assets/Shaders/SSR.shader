Shader "Hidden/PlawiusSSR" {
Properties {
 _MainTex ("", any) = "" {}
 _Original ("", any) = "" {}
 _RimPower ("Rim Power", Range(0.5,8)) = 3
 _LinearStepK ("Linear Step Coefficient", Range(1,30)) = 30
 _Bias ("Z Bias", Range(0,0.2)) = 0.0001
 _MaxIter ("Max Raymarch Iterations", Range(16,256)) = 128
}
SubShader { 
 Pass {
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
#extension GL_ARB_shader_texture_lod : enable
varying vec2 xlv_TEXCOORD0;
uniform vec4 _CameraDepthTexture_TexelSize;
uniform sampler2D _CameraDepthTexture;
uniform mat4 _WorldToCamera;
uniform sampler2D _CameraNormalsTexture;
uniform vec4 _ProjInfo;
uniform mat4 _ProjMatrix;
uniform vec4 _MainTex_TexelSize;
uniform sampler2D _MainTex;
uniform float _Bias;
uniform float _LinearStepK;
uniform int _MaxIter;
uniform float _RimPower;
uniform vec4 _ZBufferParams;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_CameraNormalsTexture, xlv_TEXCOORD0);
  vec4 tmpvar_2;
  if ((tmpvar_1.w < 0.001)) {
    tmpvar_2 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    vec4 main_image_3;
    main_image_3 = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 tmpvar_4;
    bool tmpvar_5;
    tmpvar_5 = bool(0);
    float back_mul_6;
    float curr_dist_7;
    int curr_sample_num_8;
    vec3 screen_prev_position_9;
    vec3 screen_current_position_10;
    vec3 screen_reflect_delta_11;
    float screen_reflect_lenght_12;
    vec2 dy_13;
    vec2 dx_14;
    float lerp_factor_15;
    float tmpvar_16;
    tmpvar_16 = (1.0/(((_ZBufferParams.z * texture2DLod (_CameraDepthTexture, xlv_TEXCOORD0, 0.0).x) + _ZBufferParams.w)));
    if ((tmpvar_16 > _ProjectionParams.z)) {
      tmpvar_4 = main_image_3;
      tmpvar_5 = bool(1);
    } else {
      vec3 view_normal_17;
      mat3 tmpvar_18;
      tmpvar_18[0] = _WorldToCamera[0].xyz;
      tmpvar_18[1] = _WorldToCamera[1].xyz;
      tmpvar_18[2] = _WorldToCamera[2].xyz;
      vec3 tmpvar_19;
      tmpvar_19 = (tmpvar_18 * ((tmpvar_1.xyz * 2.0) - 1.0));
      view_normal_17.xy = tmpvar_19.xy;
      view_normal_17.z = -(tmpvar_19.z);
      vec3 tmpvar_20;
      tmpvar_20 = normalize(view_normal_17);
      vec3 tmpvar_21;
      tmpvar_21.xy = ((((xlv_TEXCOORD0 * _MainTex_TexelSize.zw) * _ProjInfo.xy) + _ProjInfo.zw) * tmpvar_16);
      tmpvar_21.z = tmpvar_16;
      vec3 tmpvar_22;
      tmpvar_22 = normalize(tmpvar_21);
      vec3 tmpvar_23;
      tmpvar_23 = normalize((tmpvar_22 - (2.0 * (dot (tmpvar_20, tmpvar_22) * tmpvar_20))));
      if ((tmpvar_23.z < 0.3)) {
        tmpvar_4 = main_image_3;
        tmpvar_5 = bool(1);
      } else {
        lerp_factor_15 = max (max (max (0.2, tmpvar_1.w), (1.0 - clamp (((tmpvar_23.z - 0.3) / 0.7), 0.0, 1.0))), pow ((1.0 - clamp (dot (tmpvar_20, tmpvar_22), 0.0, 1.0)), _RimPower));
        vec3 tmpvar_24;
        tmpvar_24 = (tmpvar_21 + tmpvar_23);
        vec4 tmpvar_25;
        tmpvar_25.w = 1.0;
        tmpvar_25.xyz = tmpvar_24;
        vec4 tmpvar_26;
        tmpvar_26 = (_ProjMatrix * tmpvar_25);
        vec3 tmpvar_27;
        tmpvar_27.xy = (((tmpvar_26.xyz / tmpvar_26.w).xy * 0.5) + 0.5);
        tmpvar_27.z = tmpvar_24.z;
        vec3 tmpvar_28;
        tmpvar_28.xy = tmpvar_27.xy;
        tmpvar_28.z = tmpvar_24.z;
        vec3 tmpvar_29;
        tmpvar_29.xy = xlv_TEXCOORD0;
        tmpvar_29.z = tmpvar_16;
        vec3 tmpvar_30;
        tmpvar_30 = (tmpvar_28 - tmpvar_29);
        dx_14 = dFdx(xlv_TEXCOORD0);
        dy_13 = dFdy(xlv_TEXCOORD0);
        screen_reflect_lenght_12 = _LinearStepK;
        vec3 tmpvar_31;
        tmpvar_31 = ((tmpvar_30 * (min (_CameraDepthTexture_TexelSize.x, _CameraDepthTexture_TexelSize.y) / sqrt(dot (tmpvar_30.xy, tmpvar_30.xy)))) * _LinearStepK);
        screen_reflect_delta_11 = tmpvar_31;
        screen_current_position_10 = (tmpvar_29 + tmpvar_31);
        screen_prev_position_9 = tmpvar_29;
        curr_sample_num_8 = 0;
        curr_dist_7 = 0.0;
        back_mul_6 = 1.0;
        while (true) {
          if ((curr_sample_num_8 >= _MaxIter)) {
            break;
          };
          if (((screen_current_position_10.x < 0.0) || (screen_current_position_10.x > 1.0))) {
            break;
          };
          if (((screen_current_position_10.y < 0.0) || (screen_current_position_10.y > 1.0))) {
            break;
          };
          if (((screen_current_position_10.z < 0.0) || (screen_current_position_10.z > _ProjectionParams.z))) {
            break;
          };
          float tmpvar_32;
          tmpvar_32 = (1.0/(((_ZBufferParams.z * texture2DGradARB (_CameraDepthTexture, screen_current_position_10.xy, dx_14, dy_13).x) + _ZBufferParams.w)));
          float tmpvar_33;
          tmpvar_33 = (screen_current_position_10.z - tmpvar_32);
          if ((tmpvar_33 >= 0.0)) {
            if ((tmpvar_33 <= _Bias)) {
              vec2 p_34;
              p_34 = (screen_current_position_10.xy - vec2(0.5, 0.5));
              float tmpvar_35;
              tmpvar_35 = clamp ((sqrt(dot (p_34, p_34)) * 2.0), 0.0, 1.0);
              float tmpvar_36;
              tmpvar_36 = max (max (lerp_factor_15, (tmpvar_35 * tmpvar_35)), (float(curr_sample_num_8) / float(_MaxIter)));
              lerp_factor_15 = tmpvar_36;
              main_image_3.xyz = mix (texture2DGradARB (_MainTex, (screen_prev_position_9.xy + ((tmpvar_32 - screen_prev_position_9.z) * screen_reflect_delta_11.xy)), dx_14, dy_13).xyz, main_image_3.xyz, vec3(tmpvar_36));
              main_image_3.w = tmpvar_36;
              tmpvar_4 = main_image_3;
              tmpvar_5 = bool(1);
              break;
            } else {
              back_mul_6 = 0.5;
              float tmpvar_37;
              tmpvar_37 = (screen_reflect_lenght_12 * 0.5);
              screen_reflect_lenght_12 = tmpvar_37;
              vec3 tmpvar_38;
              tmpvar_38 = (screen_reflect_delta_11 * 0.5);
              screen_reflect_delta_11 = tmpvar_38;
              curr_dist_7 = (curr_dist_7 - tmpvar_37);
              screen_current_position_10 = (screen_prev_position_9 + tmpvar_38);
            };
          } else {
            screen_prev_position_9 = screen_current_position_10;
            float tmpvar_39;
            tmpvar_39 = (screen_reflect_lenght_12 * back_mul_6);
            screen_reflect_lenght_12 = tmpvar_39;
            vec3 tmpvar_40;
            tmpvar_40 = (screen_reflect_delta_11 * back_mul_6);
            screen_reflect_delta_11 = tmpvar_40;
            curr_dist_7 = (curr_dist_7 + tmpvar_39);
            screen_current_position_10 = (screen_current_position_10 + tmpvar_40);
          };
          curr_sample_num_8 = (curr_sample_num_8 + 1);
        };
        if (tmpvar_5) {
        } else {
          tmpvar_4 = main_image_3;
          tmpvar_5 = bool(1);
        };
      };
    };
    tmpvar_2 = tmpvar_4;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
; 10 ALU, 1 FLOW
dcl_position o0
dcl_texcoord0 o1
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Matrix 0 [_ProjMatrix]
Matrix 4 [_WorldToCamera]
Vector 8 [_ProjectionParams]
Vector 9 [_ZBufferParams]
Float 10 [_RimPower]
Float 11 [_MaxIter]
Float 12 [_LinearStepK]
Float 13 [_Bias]
Vector 14 [_MainTex_TexelSize]
Vector 15 [_ProjInfo]
Vector 16 [_CameraDepthTexture_TexelSize]
Float 17 [min_lerp_factor]
SetTexture 0 [_CameraNormalsTexture] 2D 0
SetTexture 1 [_CameraDepthTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
; 117 ALU, 9 TEX, 11 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c19, -0.30000001, 1.42857146, 0.50000000, -0.00100000
defi i0, 255, 0, 1, 0
dcl_texcoord0 v0.xy
mov r0.z, c18.x
mov r0.xy, v0
texldl r0.x, r0.xyzz, s1
mad r0.x, r0, c9.z, c9.w
rcp r4.w, r0.x
add r3.x, r4.w, -c8.z
texld r0, v0, s0
mov r2, r0
cmp_pp r3.w, -r3.x, c18.y, c18.x
mov r0, c18.xxxy
cmp r1, -r3.x, r1, c18.xxxy
if_gt r3.w, c18.x
mad r2.xyz, r2, c18.z, c18.w
dp3 r3.x, r2, c6
mov r4.z, -r3.x
dp3 r4.y, r2, c5
dp3 r4.x, r2, c4
mul r3.xy, v0, c14.zwzw
mad r2.xy, r3, c15, c15.zwzw
dp3 r3.y, r4, r4
rsq r5.x, r3.y
mul r4.xyz, r5.x, r4
mov r2.z, r4.w
mul r2.xy, r2, r4.w
dp3 r3.x, r2, r2
rsq r3.x, r3.x
mul r3.xyz, r3.x, r2
dp3 r5.x, r4, r3
mul r5.xyz, r4, r5.x
mad r5.xyz, -r5, c18.z, r3
dp3 r5.w, r5, r5
rsq r5.w, r5.w
mul r5.xyz, r5.w, r5
add r5.w, r5.z, c19.x
cmp_pp r3.w, r5, r3, c18.x
cmp r1, r5.w, r1, c18.xxxy
if_gt r3.w, c18.x
add r6.xyz, r5, r2
mov r6.w, c18.y
dp4 r2.x, r6, c3
rcp r2.z, r2.x
dp4 r2.y, r6, c1
dp4 r2.x, r6, c0
mul r2.xy, r2, r2.z
mov r2.z, r4.w
mad r6.xy, r2, c19.z, c19.z
mov r2.xy, v0
add r6.xyz, r6, -r2
mul r5.xy, r6, r6
add r5.x, r5, r5.y
dp3_sat r4.x, r4, r3
rsq r5.x, r5.x
min r4.w, c16.x, c16.y
mul r4.w, r5.x, r4
mul r6.xyz, r6, r4.w
add r4.w, -r4.x, c18.y
mul r3.xyz, r6, c12.x
pow r6, r4.w, c10.x
add r4.w, r5.z, c19.x
mul_sat r5.x, r4.w, c19.y
mov r4.w, r6.x
max r5.y, r2.w, c17.x
add r5.x, -r5, c18.y
max r5.x, r5.y, r5
max r6.z, r5.x, r4.w
add r4.xyz, r3, r2
dsx r5.zw, v0.xyxy
dsy r5.xy, v0
mov r6.y, c18.x
mov r4.w, c18.y
loop aL, i0
add r6.x, r6.y, -c11
cmp r6.x, r6, c18, c18.y
mul_pp r6.x, r3.w, r6
break_eq r6.x, c18.x
add r6.x, -r4, c18.y
cmp r6.w, r6.x, c18.x, c18.y
cmp r6.x, r4, c18, c18.y
add_pp_sat r6.x, r6, r6.w
break_gt r6.x, c18.x
add r6.x, -r4.y, c18.y
cmp r6.w, r6.x, c18.x, c18.y
cmp r6.x, r4.y, c18, c18.y
add_pp_sat r6.x, r6, r6.w
break_gt r6.x, c18.x
add r6.x, -r4.z, c8.z
cmp r6.w, r6.x, c18.x, c18.y
cmp r6.x, r4.z, c18, c18.y
add_pp_sat r6.x, r6, r6.w
break_gt r6.x, c18.x
texldd r6.x, r4, s1, r5.zwzw, r5
mad r6.x, r6, c9.z, c9.w
rcp r6.x, r6.x
add r6.w, -r6.x, r4.z
if_ge r6.w, c18.x
if_le r6.w, c13.x
add r1.xy, -r4, c19.z
mul r1.xy, r1, r1
add r0.w, r1.x, r1.y
add r1.x, r6, -r2.z
rsq r0.w, r0.w
mad r1.xy, r1.x, r3, r2
texldd r1.xyz, r1, s2, r5.zwzw, r5
rcp r0.w, r0.w
mul_sat r0.w, r0, c18.z
mul r1.w, r0, r0
rcp r0.w, c11.x
add r0.xyz, r0, -r1
max r1.w, r6.z, r1
mul r0.w, r6.y, r0
max r6.z, r1.w, r0.w
mad r1.xyz, r6.z, r0, r1
mov r1.w, r6.z
mov r0, r1
mov_pp r3.w, c18.x
else
mul r3.xyz, r3, c19.z
add r4.xyz, r3, r2
mov r4.w, c19.z
endif
else
mov r2.xyz, r4
mul r3.xyz, r3, r4.w
add r4.xyz, r4, r3
endif
add r6.x, r6.y, c18.y
cmp r6.y, -r3.w, r6, r6.x
endloop
cmp r1, -r3.w, r1, r0
endif
endif
add r0.x, r2.w, c19.w
cmp oC0, r0.x, r1, c18.xxxy
"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraNormalsTexture] 2D 1
SetTexture 1 [_CameraDepthTexture] 2D 2
SetTexture 2 [_MainTex] 2D 0
ConstBuffer "$Globals" 272
Matrix 80 [_ProjMatrix]
Matrix 160 [_WorldToCamera]
Float 16 [_RimPower]
ScalarInt 20 [_MaxIter]
Float 24 [_LinearStepK]
Float 28 [_Bias]
Vector 48 [_MainTex_TexelSize]
Vector 144 [_ProjInfo]
Vector 240 [_CameraDepthTexture_TexelSize]
Float 256 [min_lerp_factor]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedafghjkaffllccdpjakfacbmenhloocbnabaaaaaabmbaaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfmapaaaa
eaaaaaaanhadaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dbaaaaahbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaagpbciddkeiaaaaal
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaalccaabaaaabaaaaaackiacaaaabaaaaaaahaaaaaa
akaabaaaacaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakecaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaabaaaaaabnaaaaai
ccaabaaaabaaaaaackiacaaaabaaaaaaafaaaaaackaabaaaacaaaaaabpaaaead
bkaabaaaabaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadiaaaaaiocaabaaaabaaaaaafgafbaaaaaaaaaaaagijcaaaaaaaaaaa
alaaaaaadcaaaaakocaabaaaabaaaaaaagijcaaaaaaaaaaaakaaaaaaagaabaaa
aaaaaaaafgaobaaaabaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaaaaaaaaa
amaaaaaakgakbaaaaaaaaaaajgahbaaaabaaaaaadgaaaaagicaabaaaadaaaaaa
ckaabaiaebaaaaaaadaaaaaabaaaaaahbcaabaaaaaaaaaaaegadbaaaadaaaaaa
egadbaaaadaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegadbaaaadaaaaaadiaaaaaigcaabaaa
abaaaaaaagbbbaaaabaaaaaakgilcaaaaaaaaaaaadaaaaaadcaaaaalgcaabaaa
abaaaaaafgagbaaaabaaaaaaagibcaaaaaaaaaaaajaaaaaakgilcaaaaaaaaaaa
ajaaaaaadiaaaaahdcaabaaaacaaaaaakgakbaaaacaaaaaajgafbaaaabaaaaaa
baaaaaahccaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaeeaaaaaf
ccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaahocaabaaaabaaaaaafgafbaaa
abaaaaaaagajbaaaacaaaaaabaaaaaahicaabaaaacaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaahbcaabaaaadaaaaaadkaabaaaacaaaaaadkaabaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaiaebaaaaaa
adaaaaaajgahbaaaabaaaaaabaaaaaahccaabaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaaeeaaaaafccaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
ecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaabnaaaaahecaabaaa
abaaaaaackaabaaaabaaaaaaabeaaaaajkjjjjdobpaaaeadckaabaaaabaaaaaa
deaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaa
dcaaaaajecaabaaaabaaaaaackaabaaaaaaaaaaabkaabaaaabaaaaaaabeaaaaa
jkjjjjlodicaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaagonllgdp
aaaaaaaiecaabaaaabaaaaaackaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadp
dgcaaaaficaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaaabaaaaaa
dkaabaaaabaaaaaadiaaaaaiicaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaa
aaaaaaaaabaaaaaabjaaaaaficaabaaaabaaaaaadkaabaaaabaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaabaaaaaadeaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
egacbaaaaaaaaaaafgafbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiocaabaaa
abaaaaaafgafbaaaaaaaaaaaagincaaaaaaaaaaaagaaaaaadcaaaaakocaabaaa
abaaaaaaagincaaaaaaaaaaaafaaaaaaagaabaaaaaaaaaaafgaobaaaabaaaaaa
dcaaaaakocaabaaaabaaaaaaagincaaaaaaaaaaaahaaaaaakgakbaaaaaaaaaaa
fgaobaaaabaaaaaaaaaaaaaiocaabaaaabaaaaaafgaobaaaabaaaaaaagincaaa
aaaaaaaaaiaaaaaaaoaaaaahgcaabaaaabaaaaaafgagbaaaabaaaaaapgapbaaa
abaaaaaadcaaaaapdcaabaaaaaaaaaaajgafbaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaa
dgaaaaafdcaabaaaacaaaaaaegbabaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaacaaaaaaddaaaaajccaabaaaabaaaaaa
bkiacaaaaaaaaaaaapaaaaaaakiacaaaaaaaaaaaapaaaaaaapaaaaahecaabaaa
abaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaafecaabaaaabaaaaaa
ckaabaaaabaaaaaaaoaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaackaabaaa
abaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaaabaaaaaa
alaaaaafgcaabaaaabaaaaaaagbbbaaaabaaaaaaamaaaaafdcaabaaaadaaaaaa
egbabaaaabaaaaaadiaaaaaihcaabaaaaeaaaaaaegacbaaaaaaaaaaakgikcaaa
aaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaakgikcaaa
aaaaaaaaabaaaaaaegacbaaaacaaaaaaclaaaaagicaabaaaabaaaaaabkiacaaa
aaaaaaaaabaaaaaadgaaaaaipcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaiadpdgaaaaafdcaabaaaaiaaaaaaegbabaaaabaaaaaadgaaaaai
pcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdgaaaaaf
ecaabaaaadaaaaaadkaabaaaaaaaaaaadgaaaaaflcaabaaaacaaaaaaegaibaaa
aeaaaaaadgaaaaafhcaabaaaahaaaaaaegacbaaaaaaaaaaadgaaaaafecaabaaa
aiaaaaaackaabaaaacaaaaaadgaaaaaficaabaaaadaaaaaaabeaaaaaaaaaaaaa
dgaaaaaficaabaaaaeaaaaaaabeaaaaaaaaaiadpdgaaaaaficaabaaaahaaaaaa
abeaaaaaaaaaaaaadaaaaaabcbaaaaaiicaabaaaaiaaaaaadkaabaaaadaaaaaa
bkiacaaaaaaaaaaaabaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaaaaaaaaaa
adaaaeaddkaabaaaaiaaaaaadbaaaaahicaabaaaaiaaaaaaakaabaaaahaaaaaa
abeaaaaaaaaaaaaadbaaaaahbcaabaaaajaaaaaaabeaaaaaaaaaiadpakaabaaa
ahaaaaaadmaaaaahicaabaaaaiaaaaaadkaabaaaaiaaaaaaakaabaaaajaaaaaa
bpaaaeaddkaabaaaaiaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaaaaaaaaaa
acaaaaabbfaaaaabdbaaaaahicaabaaaaiaaaaaabkaabaaaahaaaaaaabeaaaaa
aaaaaaaadbaaaaahbcaabaaaajaaaaaaabeaaaaaaaaaiadpbkaabaaaahaaaaaa
dmaaaaahicaabaaaaiaaaaaadkaabaaaaiaaaaaaakaabaaaajaaaaaabpaaaead
dkaabaaaaiaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaaaaaaaaaaacaaaaab
bfaaaaabdbaaaaahicaabaaaaiaaaaaackaabaaaahaaaaaaabeaaaaaaaaaaaaa
dbaaaaaibcaabaaaajaaaaaackiacaaaabaaaaaaafaaaaaackaabaaaahaaaaaa
dmaaaaahicaabaaaaiaaaaaadkaabaaaaiaaaaaaakaabaaaajaaaaaabpaaaead
dkaabaaaaiaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaaaaaaaaaaacaaaaab
bfaaaaabejaaaaanpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaajgafbaaaabaaaaaaegaabaaaadaaaaaadcaaaaalicaabaaa
aiaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaaajaaaaaadkiacaaaabaaaaaa
ahaaaaaaaoaaaaakicaabaaaaiaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpdkaabaaaaiaaaaaaaaaaaaaibcaabaaaajaaaaaackaabaaaahaaaaaa
dkaabaiaebaaaaaaaiaaaaaabnaaaaahccaabaaaajaaaaaaakaabaaaajaaaaaa
abeaaaaaaaaaaaaabpaaaeadbkaabaaaajaaaaaabnaaaaaibcaabaaaajaaaaaa
dkiacaaaaaaaaaaaabaaaaaaakaabaaaajaaaaaabpaaaeadakaabaaaajaaaaaa
aaaaaaaiicaabaaaaiaaaaaackaabaiaebaaaaaaaiaaaaaadkaabaaaaiaaaaaa
dcaaaaajgcaabaaaajaaaaaapgapbaaaaiaaaaaaagabbaaaacaaaaaaagabbaaa
aiaaaaaaejaaaaanpcaabaaaakaaaaaajgafbaaaajaaaaaaeghobaaaacaaaaaa
aagabaaaaaaaaaaajgafbaaaabaaaaaaegaabaaaadaaaaaaaaaaaaakgcaabaaa
ajaaaaaaagabbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaalpaaaaaalpaaaaaaaa
apaaaaahicaabaaaaiaaaaaajgafbaaaajaaaaaajgafbaaaajaaaaaaelaaaaaf
icaabaaaaiaaaaaadkaabaaaaiaaaaaaaaaaaaahicaabaaaaiaaaaaadkaabaaa
aiaaaaaadkaabaaaaiaaaaaaddaaaaahicaabaaaaiaaaaaadkaabaaaaiaaaaaa
abeaaaaaaaaaiadpdiaaaaahicaabaaaaiaaaaaadkaabaaaaiaaaaaadkaabaaa
aiaaaaaadeaaaaahicaabaaaaiaaaaaackaabaaaadaaaaaadkaabaaaaiaaaaaa
claaaaafccaabaaaajaaaaaadkaabaaaadaaaaaaaoaaaaahccaabaaaajaaaaaa
bkaabaaaajaaaaaadkaabaaaabaaaaaadeaaaaahicaabaaaagaaaaaadkaabaaa
aiaaaaaabkaabaaaajaaaaaadcaaaaakhcaabaaaagaaaaaapgapbaaaagaaaaaa
egacbaiaebaaaaaaakaaaaaaegacbaaaakaaaaaadgaaaaafpcaabaaaafaaaaaa
egaobaaaagaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaappppppppacaaaaab
bcaaaaabdgaaaaafhcaabaaaakaaaaaaegadbaaaacaaaaaadiaaaaaklcaabaaa
acaaaaaaegaibaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaadp
dcaaaaamhcaabaaaahaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaiaaaaaabfaaaaabdgaaaaaficaabaaaaeaaaaaa
abeaaaaaaaaaaadpdgaaaaaficaabaaaahaaaaaaakaabaaaajaaaaaabcaaaaab
dgaaaaafhcaabaaaajaaaaaaegadbaaaacaaaaaadiaaaaahlcaabaaaacaaaaaa
pgapbaaaaeaaaaaaegaibaaaajaaaaaadcaaaaajhcaabaaaajaaaaaaegacbaaa
ajaaaaaapgapbaaaaeaaaaaaegacbaaaahaaaaaadgaaaaafhcaabaaaaiaaaaaa
egacbaaaahaaaaaadgaaaaaficaabaaaahaaaaaaabeaaaaaaaaaaaaadgaaaaaf
hcaabaaaahaaaaaaegacbaaaajaaaaaabfaaaaabboaaaaahicaabaaaadaaaaaa
dkaabaaaadaaaaaaabeaaaaaabaaaaaadgaaaaaipcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdgaaaaaipcaabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbgaaaaabdhaaaaajpcaabaaaaaaaaaaa
pgapbaaaahaaaaaaegaobaaaafaaaaaaegaobaaaagaaaaaabcaaaaabdgaaaaai
pcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpbfaaaaab
bcaaaaabdgaaaaaipcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpbfaaaaabdhaaaaampccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpegaobaaaaaaaaaaadoaaaaab"
}
}
 }
 Pass {
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
varying vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
uniform sampler2D _Original;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = (tmpvar_1.xyz + (texture2D (_Original, xlv_TEXCOORD0).xyz * tmpvar_1.w));
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
; 10 ALU, 1 FLOW
dcl_position o0
dcl_texcoord0 o1
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
SetTexture 0 [_Original] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_3_0
; 2 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
texld r0, v0, s1
texld r1.xyz, v0, s0
mad oC0.xyz, r1, r0.w, r0
mov oC0.w, c0.x
"
}
SubProgram "d3d11 " {
SetTexture 0 [_Original] 2D 0
SetTexture 1 [_MainTex] 2D 1
"ps_4_0
eefiecednlmhmeojefaembgjmkkoncdmlcbhlcggabaaaaaakeabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeaaaaaa
eaaaaaaadjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
}
 }
 Pass {
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
#extension GL_ARB_shader_texture_lod : enable
varying vec2 xlv_TEXCOORD0;
uniform vec4 _CameraDepthTexture_TexelSize;
uniform sampler2D _CameraDepthTexture;
uniform mat4 _WorldToCamera;
uniform sampler2D _CameraNormalsTexture;
uniform vec4 _ProjInfo;
uniform mat4 _ProjMatrix;
uniform vec4 _MainTex_TexelSize;
uniform sampler2D _MainTex;
uniform float _Bias;
uniform float _LinearStepK;
uniform int _MaxIter;
uniform float _RimPower;
uniform vec4 _ZBufferParams;
uniform vec4 _ProjectionParams;
void main ()
{
  vec4 tmpvar_1;
  tmpvar_1 = texture2D (_CameraNormalsTexture, xlv_TEXCOORD0);
  vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  vec4 tmpvar_3;
  if ((tmpvar_1.w < 0.001)) {
    tmpvar_3 = tmpvar_2;
  } else {
    vec4 main_image_4;
    main_image_4 = tmpvar_2;
    vec4 tmpvar_5;
    bool tmpvar_6;
    tmpvar_6 = bool(0);
    float back_mul_7;
    float curr_dist_8;
    int curr_sample_num_9;
    vec3 screen_prev_position_10;
    vec3 screen_current_position_11;
    vec3 screen_reflect_delta_12;
    float screen_reflect_lenght_13;
    vec2 dy_14;
    vec2 dx_15;
    float lerp_factor_16;
    float tmpvar_17;
    tmpvar_17 = (1.0/(((_ZBufferParams.z * texture2DLod (_CameraDepthTexture, xlv_TEXCOORD0, 0.0).x) + _ZBufferParams.w)));
    if ((tmpvar_17 > _ProjectionParams.z)) {
      tmpvar_5 = tmpvar_2;
      tmpvar_6 = bool(1);
    } else {
      vec3 view_normal_18;
      mat3 tmpvar_19;
      tmpvar_19[0] = _WorldToCamera[0].xyz;
      tmpvar_19[1] = _WorldToCamera[1].xyz;
      tmpvar_19[2] = _WorldToCamera[2].xyz;
      vec3 tmpvar_20;
      tmpvar_20 = (tmpvar_19 * ((tmpvar_1.xyz * 2.0) - 1.0));
      view_normal_18.xy = tmpvar_20.xy;
      view_normal_18.z = -(tmpvar_20.z);
      vec3 tmpvar_21;
      tmpvar_21 = normalize(view_normal_18);
      vec3 tmpvar_22;
      tmpvar_22.xy = ((((xlv_TEXCOORD0 * _MainTex_TexelSize.zw) * _ProjInfo.xy) + _ProjInfo.zw) * tmpvar_17);
      tmpvar_22.z = tmpvar_17;
      vec3 tmpvar_23;
      tmpvar_23 = normalize(tmpvar_22);
      vec3 tmpvar_24;
      tmpvar_24 = normalize((tmpvar_23 - (2.0 * (dot (tmpvar_21, tmpvar_23) * tmpvar_21))));
      if ((tmpvar_24.z < 0.3)) {
        tmpvar_5 = tmpvar_2;
        tmpvar_6 = bool(1);
      } else {
        lerp_factor_16 = max (max (max (0.2, tmpvar_1.w), (1.0 - clamp (((tmpvar_24.z - 0.3) / 0.7), 0.0, 1.0))), pow ((1.0 - clamp (dot (tmpvar_21, tmpvar_23), 0.0, 1.0)), _RimPower));
        vec3 tmpvar_25;
        tmpvar_25 = (tmpvar_22 + tmpvar_24);
        vec4 tmpvar_26;
        tmpvar_26.w = 1.0;
        tmpvar_26.xyz = tmpvar_25;
        vec4 tmpvar_27;
        tmpvar_27 = (_ProjMatrix * tmpvar_26);
        vec3 tmpvar_28;
        tmpvar_28.xy = (((tmpvar_27.xyz / tmpvar_27.w).xy * 0.5) + 0.5);
        tmpvar_28.z = tmpvar_25.z;
        vec3 tmpvar_29;
        tmpvar_29.xy = tmpvar_28.xy;
        tmpvar_29.z = tmpvar_25.z;
        vec3 tmpvar_30;
        tmpvar_30.xy = xlv_TEXCOORD0;
        tmpvar_30.z = tmpvar_17;
        vec3 tmpvar_31;
        tmpvar_31 = (tmpvar_29 - tmpvar_30);
        dx_15 = dFdx(xlv_TEXCOORD0);
        dy_14 = dFdy(xlv_TEXCOORD0);
        screen_reflect_lenght_13 = _LinearStepK;
        vec3 tmpvar_32;
        tmpvar_32 = ((tmpvar_31 * (min (_CameraDepthTexture_TexelSize.x, _CameraDepthTexture_TexelSize.y) / sqrt(dot (tmpvar_31.xy, tmpvar_31.xy)))) * _LinearStepK);
        screen_reflect_delta_12 = tmpvar_32;
        screen_current_position_11 = (tmpvar_30 + tmpvar_32);
        screen_prev_position_10 = tmpvar_30;
        curr_sample_num_9 = 0;
        curr_dist_8 = 0.0;
        back_mul_7 = 1.0;
        while (true) {
          if ((curr_sample_num_9 >= _MaxIter)) {
            break;
          };
          if (((screen_current_position_11.x < 0.0) || (screen_current_position_11.x > 1.0))) {
            break;
          };
          if (((screen_current_position_11.y < 0.0) || (screen_current_position_11.y > 1.0))) {
            break;
          };
          if (((screen_current_position_11.z < 0.0) || (screen_current_position_11.z > _ProjectionParams.z))) {
            break;
          };
          float tmpvar_33;
          tmpvar_33 = (1.0/(((_ZBufferParams.z * texture2DGradARB (_CameraDepthTexture, screen_current_position_11.xy, dx_15, dy_14).x) + _ZBufferParams.w)));
          float tmpvar_34;
          tmpvar_34 = (screen_current_position_11.z - tmpvar_33);
          if ((tmpvar_34 >= 0.0)) {
            if ((tmpvar_34 <= _Bias)) {
              vec2 p_35;
              p_35 = (screen_current_position_11.xy - vec2(0.5, 0.5));
              float tmpvar_36;
              tmpvar_36 = clamp ((sqrt(dot (p_35, p_35)) * 2.0), 0.0, 1.0);
              float tmpvar_37;
              tmpvar_37 = max (max (lerp_factor_16, (tmpvar_36 * tmpvar_36)), (float(curr_sample_num_9) / float(_MaxIter)));
              lerp_factor_16 = tmpvar_37;
              main_image_4.xyz = mix (texture2DGradARB (_MainTex, (screen_prev_position_10.xy + ((tmpvar_33 - screen_prev_position_10.z) * screen_reflect_delta_12.xy)), dx_15, dy_14).xyz, main_image_4.xyz, vec3(tmpvar_37));
              main_image_4.w = tmpvar_37;
              tmpvar_5 = main_image_4;
              tmpvar_6 = bool(1);
              break;
            } else {
              back_mul_7 = 0.5;
              float tmpvar_38;
              tmpvar_38 = (screen_reflect_lenght_13 * 0.5);
              screen_reflect_lenght_13 = tmpvar_38;
              vec3 tmpvar_39;
              tmpvar_39 = (screen_reflect_delta_12 * 0.5);
              screen_reflect_delta_12 = tmpvar_39;
              curr_dist_8 = (curr_dist_8 - tmpvar_38);
              screen_current_position_11 = (screen_prev_position_10 + tmpvar_39);
            };
          } else {
            screen_prev_position_10 = screen_current_position_11;
            float tmpvar_40;
            tmpvar_40 = (screen_reflect_lenght_13 * back_mul_7);
            screen_reflect_lenght_13 = tmpvar_40;
            vec3 tmpvar_41;
            tmpvar_41 = (screen_reflect_delta_12 * back_mul_7);
            screen_reflect_delta_12 = tmpvar_41;
            curr_dist_8 = (curr_dist_8 + tmpvar_40);
            screen_current_position_11 = (screen_current_position_11 + tmpvar_41);
          };
          curr_sample_num_9 = (curr_sample_num_9 + 1);
        };
        if (tmpvar_6) {
        } else {
          tmpvar_5 = main_image_4;
          tmpvar_6 = bool(1);
        };
      };
    };
    tmpvar_3 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_3;
}


#endif
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
"vs_3_0
; 10 ALU, 1 FLOW
dcl_position o0
dcl_texcoord0 o1
def c5, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.z, c5.x
dp4 r0.x, v0, c0
mov r1.xy, v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.y, v0, c1
if_lt c4.y, r1.z
add r1.y, -v1, c5
mov r1.x, v1
endif
mov o0, r0
mov o1.xy, r1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 48 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecednmcjfgdkmnopdadinpffijihilppibboabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefchiabaaaa
eaaaabaafoaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaai
bcaabaaaaaaaaaaabkiacaaaaaaaaaaaadaaaaaaabeaaaaaaaaaaaaaaaaaaaai
ccaabaaaaaaaaaaabkbabaiaebaaaaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaaj
cccabaaaabaaaaaaakaabaaaaaaaaaaabkaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafbccabaaaabaaaaaaakbabaaaabaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
SubProgram "d3d9 " {
Matrix 0 [_ProjMatrix]
Matrix 4 [_WorldToCamera]
Vector 8 [_ProjectionParams]
Vector 9 [_ZBufferParams]
Float 10 [_RimPower]
Float 11 [_MaxIter]
Float 12 [_LinearStepK]
Float 13 [_Bias]
Vector 14 [_MainTex_TexelSize]
Vector 15 [_ProjInfo]
Vector 16 [_CameraDepthTexture_TexelSize]
Float 17 [min_lerp_factor]
SetTexture 0 [_CameraNormalsTexture] 2D 0
SetTexture 1 [_MainTex] 2D 1
SetTexture 2 [_CameraDepthTexture] 2D 2
"ps_3_0
; 117 ALU, 10 TEX, 11 FLOW
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c18, 0.00000000, 1.00000000, 2.00000000, -1.00000000
def c19, -0.30000001, 1.42857146, 0.50000000, -0.00100000
defi i0, 255, 0, 1, 0
dcl_texcoord0 v0.xy
mov r0.z, c18.x
mov r0.xy, v0
texldl r0.x, r0.xyzz, s2
mad r2.x, r0, c9.z, c9.w
rcp r5.w, r2.x
texld r0, v0, s0
add r4.x, r5.w, -c8.z
texld r2, v0, s1
mov r3, r0
mov r0, r2
cmp_pp r4.w, -r4.x, c18.y, c18.x
cmp r1, -r4.x, r1, r2
if_gt r4.w, c18.x
mad r3.xyz, r3, c18.z, c18.w
dp3 r4.x, r3, c6
mov r5.z, -r4.x
dp3 r5.y, r3, c5
dp3 r5.x, r3, c4
mul r4.xy, v0, c14.zwzw
mad r3.xy, r4, c15, c15.zwzw
dp3 r4.y, r5, r5
rsq r6.x, r4.y
mul r5.xyz, r6.x, r5
mov r3.z, r5.w
mul r3.xy, r3, r5.w
dp3 r4.x, r3, r3
rsq r4.x, r4.x
mul r4.xyz, r4.x, r3
dp3 r6.x, r5, r4
mul r6.xyz, r5, r6.x
mad r6.xyz, -r6, c18.z, r4
dp3 r6.w, r6, r6
rsq r6.w, r6.w
mul r6.xyz, r6.w, r6
add r6.w, r6.z, c19.x
cmp_pp r4.w, r6, r4, c18.x
cmp r1, r6.w, r1, r0
if_gt r4.w, c18.x
add r7.xyz, r6, r3
mov r7.w, c18.y
dp4 r3.x, r7, c3
rcp r3.z, r3.x
dp4 r3.y, r7, c1
dp4 r3.x, r7, c0
mul r3.xy, r3, r3.z
mov r3.z, r5.w
mad r7.xy, r3, c19.z, c19.z
mov r3.xy, v0
add r7.xyz, r7, -r3
mul r6.xy, r7, r7
add r6.x, r6, r6.y
dp3_sat r5.x, r5, r4
rsq r6.x, r6.x
min r5.w, c16.x, c16.y
mul r5.w, r6.x, r5
mul r7.xyz, r7, r5.w
add r5.w, -r5.x, c18.y
mul r4.xyz, r7, c12.x
pow r7, r5.w, c10.x
add r5.w, r6.z, c19.x
mul_sat r6.x, r5.w, c19.y
mov r5.w, r7.x
max r6.y, r3.w, c17.x
add r6.x, -r6, c18.y
max r6.x, r6.y, r6
max r7.z, r6.x, r5.w
add r5.xyz, r4, r3
dsx r6.zw, v0.xyxy
dsy r6.xy, v0
mov r7.y, c18.x
mov r5.w, c18.y
loop aL, i0
add r7.x, r7.y, -c11
cmp r7.x, r7, c18, c18.y
mul_pp r7.x, r4.w, r7
break_eq r7.x, c18.x
add r7.x, -r5, c18.y
cmp r7.w, r7.x, c18.x, c18.y
cmp r7.x, r5, c18, c18.y
add_pp_sat r7.x, r7, r7.w
break_gt r7.x, c18.x
add r7.x, -r5.y, c18.y
cmp r7.w, r7.x, c18.x, c18.y
cmp r7.x, r5.y, c18, c18.y
add_pp_sat r7.x, r7, r7.w
break_gt r7.x, c18.x
add r7.x, -r5.z, c8.z
cmp r7.w, r7.x, c18.x, c18.y
cmp r7.x, r5.z, c18, c18.y
add_pp_sat r7.x, r7, r7.w
break_gt r7.x, c18.x
texldd r7.x, r5, s2, r6.zwzw, r6
mad r7.x, r7, c9.z, c9.w
rcp r7.x, r7.x
add r7.w, -r7.x, r5.z
if_ge r7.w, c18.x
if_le r7.w, c13.x
add r1.xy, -r5, c19.z
mul r1.xy, r1, r1
add r1.x, r1, r1.y
rsq r1.z, r1.x
rcp r1.w, r1.z
mul_sat r1.w, r1, c18.z
mul r2.w, r1, r1
add r1.y, r7.x, -r3.z
mad r1.xy, r1.y, r4, r3
texldd r1.xyz, r1, s1, r6.zwzw, r6
rcp r1.w, c11.x
add r2.xyz, r2, -r1
max r2.w, r7.z, r2
mul r1.w, r7.y, r1
max r7.z, r2.w, r1.w
mad r1.xyz, r7.z, r2, r1
mov r1.w, r7.z
mov r2, r1
mov_pp r4.w, c18.x
else
mul r4.xyz, r4, c19.z
add r5.xyz, r4, r3
mov r5.w, c19.z
endif
else
mov r3.xyz, r5
mul r4.xyz, r4, r5.w
add r5.xyz, r5, r4
endif
add r7.x, r7.y, c18.y
cmp r7.y, -r4.w, r7, r7.x
endloop
cmp r1, -r4.w, r1, r2
endif
endif
add r2.x, r3.w, c19.w
cmp oC0, r2.x, r1, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_CameraNormalsTexture] 2D 1
SetTexture 1 [_MainTex] 2D 0
SetTexture 2 [_CameraDepthTexture] 2D 2
ConstBuffer "$Globals" 272
Matrix 80 [_ProjMatrix]
Matrix 160 [_WorldToCamera]
Float 16 [_RimPower]
ScalarInt 20 [_MaxIter]
Float 24 [_LinearStepK]
Float 28 [_Bias]
Vector 48 [_MainTex_TexelSize]
Vector 144 [_ProjInfo]
Vector 240 [_CameraDepthTexture_TexelSize]
Float 256 [min_lerp_factor]
ConstBuffer "UnityPerCamera" 128
Vector 80 [_ProjectionParams]
Vector 112 [_ZBufferParams]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
"ps_4_0
eefiecedpliojfbnejfamcojbmbbbpdenmfhojdaabaaaaaapeapaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeapaaaa
eaaaaaaamnadaaaafjaaaaaeegiocaaaaaaaaaaabbaaaaaafjaaaaaeegiocaaa
abaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacanaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
aaaaaaaadbaaaaahbcaabaaaacaaaaaadkaabaaaaaaaaaaaabeaaaaagpbciddk
eiaaaaalpcaabaaaadaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaalccaabaaaacaaaaaackiacaaaabaaaaaa
ahaaaaaaakaabaaaadaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakecaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpbkaabaaaacaaaaaa
bnaaaaaiccaabaaaacaaaaaackiacaaaabaaaaaaafaaaaaackaabaaaadaaaaaa
bpaaaeadbkaabaaaacaaaaaadcaaaaaphcaabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadiaaaaaiocaabaaaacaaaaaafgafbaaaaaaaaaaaagijcaaa
aaaaaaaaalaaaaaadcaaaaakocaabaaaacaaaaaaagijcaaaaaaaaaaaakaaaaaa
agaabaaaaaaaaaaafgaobaaaacaaaaaadcaaaaakhcaabaaaaeaaaaaaegiccaaa
aaaaaaaaamaaaaaakgakbaaaaaaaaaaajgahbaaaacaaaaaadgaaaaagicaabaaa
aeaaaaaackaabaiaebaaaaaaaeaaaaaabaaaaaahbcaabaaaaaaaaaaaegadbaaa
aeaaaaaaegadbaaaaeaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegadbaaaaeaaaaaadiaaaaai
gcaabaaaacaaaaaaagbbbaaaabaaaaaakgilcaaaaaaaaaaaadaaaaaadcaaaaal
gcaabaaaacaaaaaafgagbaaaacaaaaaaagibcaaaaaaaaaaaajaaaaaakgilcaaa
aaaaaaaaajaaaaaadiaaaaahdcaabaaaadaaaaaakgakbaaaadaaaaaajgafbaaa
acaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
eeaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaadiaaaaahocaabaaaacaaaaaa
fgafbaaaacaaaaaaagajbaaaadaaaaaabaaaaaahicaabaaaadaaaaaajgahbaaa
acaaaaaaegacbaaaaaaaaaaaaaaaaaahbcaabaaaaeaaaaaadkaabaaaadaaaaaa
dkaabaaaadaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaagaabaia
ebaaaaaaaeaaaaaajgahbaaaacaaaaaabaaaaaahccaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaafccaabaaaacaaaaaabkaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaabnaaaaah
ecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaajkjjjjdobpaaaeadckaabaaa
acaaaaaadeaaaaaiicaabaaaaaaaaaaadkaabaaaaaaaaaaaakiacaaaaaaaaaaa
baaaaaaadcaaaaajecaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaacaaaaaa
abeaaaaajkjjjjlodicaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaa
gonllgdpaaaaaaaiecaabaaaacaaaaaackaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaiadpdgcaaaaficaabaaaadaaaaaadkaabaaaadaaaaaaaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaadaaaaaaabeaaaaaaaaaiadpcpaaaaaficaabaaa
acaaaaaadkaabaaaacaaaaaadiaaaaaiicaabaaaacaaaaaadkaabaaaacaaaaaa
akiacaaaaaaaaaaaabaaaaaabjaaaaaficaabaaaacaaaaaadkaabaaaacaaaaaa
deaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaackaabaaaacaaaaaadeaaaaah
icaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaadcaaaaajhcaabaaa
aaaaaaaaegacbaaaaaaaaaaafgafbaaaacaaaaaaegacbaaaadaaaaaadiaaaaai
ocaabaaaacaaaaaafgafbaaaaaaaaaaaagincaaaaaaaaaaaagaaaaaadcaaaaak
ocaabaaaacaaaaaaagincaaaaaaaaaaaafaaaaaaagaabaaaaaaaaaaafgaobaaa
acaaaaaadcaaaaakocaabaaaacaaaaaaagincaaaaaaaaaaaahaaaaaakgakbaaa
aaaaaaaafgaobaaaacaaaaaaaaaaaaaiocaabaaaacaaaaaafgaobaaaacaaaaaa
agincaaaaaaaaaaaaiaaaaaaaoaaaaahgcaabaaaacaaaaaafgagbaaaacaaaaaa
pgapbaaaacaaaaaadcaaaaapdcaabaaaaaaaaaaajgafbaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadgaaaaafdcaabaaaadaaaaaaegbabaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaadaaaaaaddaaaaajccaabaaa
acaaaaaabkiacaaaaaaaaaaaapaaaaaaakiacaaaaaaaaaaaapaaaaaaapaaaaah
ecaabaaaacaaaaaaegaabaaaaaaaaaaaegaabaaaaaaaaaaaelaaaaafecaabaaa
acaaaaaackaabaaaacaaaaaaaoaaaaahccaabaaaacaaaaaabkaabaaaacaaaaaa
ckaabaaaacaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaafgafbaaa
acaaaaaaalaaaaafgcaabaaaacaaaaaaagbbbaaaabaaaaaaamaaaaafdcaabaaa
aeaaaaaaegbabaaaabaaaaaadiaaaaaihcaabaaaafaaaaaaegacbaaaaaaaaaaa
kgikcaaaaaaaaaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
kgikcaaaaaaaaaaaabaaaaaaegacbaaaadaaaaaaclaaaaagicaabaaaacaaaaaa
bkiacaaaaaaaaaaaabaaaaaadgaaaaafpcaabaaaagaaaaaaegaobaaaabaaaaaa
dgaaaaafdcaabaaaajaaaaaaegbabaaaabaaaaaadgaaaaafpcaabaaaahaaaaaa
egaobaaaabaaaaaadgaaaaafecaabaaaaeaaaaaadkaabaaaaaaaaaaadgaaaaaf
lcaabaaaadaaaaaaegaibaaaafaaaaaadgaaaaafhcaabaaaaiaaaaaaegacbaaa
aaaaaaaadgaaaaafecaabaaaajaaaaaackaabaaaadaaaaaadgaaaaaficaabaaa
aeaaaaaaabeaaaaaaaaaaaaadgaaaaaficaabaaaafaaaaaaabeaaaaaaaaaiadp
dgaaaaaficaabaaaaiaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaaiicaabaaa
ajaaaaaadkaabaaaaeaaaaaabkiacaaaaaaaaaaaabaaaaaadgaaaaaficaabaaa
aiaaaaaaabeaaaaaaaaaaaaaadaaaeaddkaabaaaajaaaaaadbaaaaahicaabaaa
ajaaaaaaakaabaaaaiaaaaaaabeaaaaaaaaaaaaadbaaaaahbcaabaaaakaaaaaa
abeaaaaaaaaaiadpakaabaaaaiaaaaaadmaaaaahicaabaaaajaaaaaadkaabaaa
ajaaaaaaakaabaaaakaaaaaabpaaaeaddkaabaaaajaaaaaadgaaaaaficaabaaa
aiaaaaaaabeaaaaaaaaaaaaaacaaaaabbfaaaaabdbaaaaahicaabaaaajaaaaaa
bkaabaaaaiaaaaaaabeaaaaaaaaaaaaadbaaaaahbcaabaaaakaaaaaaabeaaaaa
aaaaiadpbkaabaaaaiaaaaaadmaaaaahicaabaaaajaaaaaadkaabaaaajaaaaaa
akaabaaaakaaaaaabpaaaeaddkaabaaaajaaaaaadgaaaaaficaabaaaaiaaaaaa
abeaaaaaaaaaaaaaacaaaaabbfaaaaabdbaaaaahicaabaaaajaaaaaackaabaaa
aiaaaaaaabeaaaaaaaaaaaaadbaaaaaibcaabaaaakaaaaaackiacaaaabaaaaaa
afaaaaaackaabaaaaiaaaaaadmaaaaahicaabaaaajaaaaaadkaabaaaajaaaaaa
akaabaaaakaaaaaabpaaaeaddkaabaaaajaaaaaadgaaaaaficaabaaaaiaaaaaa
abeaaaaaaaaaaaaaacaaaaabbfaaaaabejaaaaanpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaajgafbaaaacaaaaaaegaabaaa
aeaaaaaadcaaaaalicaabaaaajaaaaaackiacaaaabaaaaaaahaaaaaaakaabaaa
akaaaaaadkiacaaaabaaaaaaahaaaaaaaoaaaaakicaabaaaajaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdkaabaaaajaaaaaaaaaaaaaibcaabaaa
akaaaaaackaabaaaaiaaaaaadkaabaiaebaaaaaaajaaaaaabnaaaaahccaabaaa
akaaaaaaakaabaaaakaaaaaaabeaaaaaaaaaaaaabpaaaeadbkaabaaaakaaaaaa
bnaaaaaibcaabaaaakaaaaaadkiacaaaaaaaaaaaabaaaaaaakaabaaaakaaaaaa
bpaaaeadakaabaaaakaaaaaaaaaaaaaiicaabaaaajaaaaaackaabaiaebaaaaaa
ajaaaaaadkaabaaaajaaaaaadcaaaaajgcaabaaaakaaaaaapgapbaaaajaaaaaa
agabbaaaadaaaaaaagabbaaaajaaaaaaejaaaaanpcaabaaaalaaaaaajgafbaaa
akaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaajgafbaaaacaaaaaaegaabaaa
aeaaaaaaaaaaaaakgcaabaaaakaaaaaaagabbaaaaiaaaaaaaceaaaaaaaaaaaaa
aaaaaalpaaaaaalpaaaaaaaaapaaaaahicaabaaaajaaaaaajgafbaaaakaaaaaa
jgafbaaaakaaaaaaelaaaaaficaabaaaajaaaaaadkaabaaaajaaaaaaaaaaaaah
icaabaaaajaaaaaadkaabaaaajaaaaaadkaabaaaajaaaaaaddaaaaahicaabaaa
ajaaaaaadkaabaaaajaaaaaaabeaaaaaaaaaiadpdiaaaaahicaabaaaajaaaaaa
dkaabaaaajaaaaaadkaabaaaajaaaaaadeaaaaahicaabaaaajaaaaaackaabaaa
aeaaaaaadkaabaaaajaaaaaaclaaaaafccaabaaaakaaaaaadkaabaaaaeaaaaaa
aoaaaaahccaabaaaakaaaaaabkaabaaaakaaaaaadkaabaaaacaaaaaadeaaaaah
icaabaaaamaaaaaadkaabaaaajaaaaaabkaabaaaakaaaaaaaaaaaaaiocaabaaa
akaaaaaaagajbaaaahaaaaaaagajbaiaebaaaaaaalaaaaaadcaaaaajhcaabaaa
amaaaaaapgapbaaaamaaaaaajgahbaaaakaaaaaaegacbaaaalaaaaaadgaaaaaf
pcaabaaaagaaaaaaegaobaaaamaaaaaadgaaaaaficaabaaaaiaaaaaaabeaaaaa
ppppppppdgaaaaafpcaabaaaahaaaaaaegaobaaaamaaaaaaacaaaaabbcaaaaab
dgaaaaafhcaabaaaalaaaaaaegadbaaaadaaaaaadiaaaaaklcaabaaaadaaaaaa
egaibaaaalaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaadpdcaaaaam
hcaabaaaaiaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaajaaaaaabfaaaaabdgaaaaaficaabaaaafaaaaaaabeaaaaa
aaaaaadpdgaaaaaficaabaaaaiaaaaaaakaabaaaakaaaaaabcaaaaabdgaaaaaf
hcaabaaaakaaaaaaegadbaaaadaaaaaadiaaaaahlcaabaaaadaaaaaapgapbaaa
afaaaaaaegaibaaaakaaaaaadcaaaaajhcaabaaaakaaaaaaegacbaaaakaaaaaa
pgapbaaaafaaaaaaegacbaaaaiaaaaaadgaaaaafhcaabaaaajaaaaaaegacbaaa
aiaaaaaadgaaaaaficaabaaaaiaaaaaaabeaaaaaaaaaaaaadgaaaaafhcaabaaa
aiaaaaaaegacbaaaakaaaaaabfaaaaabboaaaaahicaabaaaaeaaaaaadkaabaaa
aeaaaaaaabeaaaaaabaaaaaabgaaaaabdhaaaaajpcaabaaaaaaaaaaapgapbaaa
aiaaaaaaegaobaaaagaaaaaaegaobaaaahaaaaaabcaaaaabdgaaaaafpcaabaaa
aaaaaaaaegaobaaaabaaaaaabfaaaaabbcaaaaabdgaaaaafpcaabaaaaaaaaaaa
egaobaaaabaaaaaabfaaaaabdhaaaaajpccabaaaaaaaaaaaagaabaaaacaaaaaa
egaobaaaabaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
}
 }
}
}