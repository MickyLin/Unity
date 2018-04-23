// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'PositionFog()' with multiply of UNITY_MATRIX_MVP by position
// Upgrade NOTE: replaced 'V2F_POS_FOG' with 'float4 pos : SV_POSITION'

Shader "Reflective/Glass" {  
    Properties {  
        _Color ("Main Color", Color) = (1,1,1,1)  
        _SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)  
        _Shininess ("Shininess", Range (0.01, 1)) = 0.078125  
        _ReflectColor ("Reflect Strength", Color) = (1,1,1,0.5)  
        _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}  
        _Parallax ("Height", Range (0.005, 0.08)) = 0.02  
        _Cube ("Reflection Cubemap", Cube) = "_Skybox" { TexGen CubeReflect }  
    }  
    SubShader   
    {  
        LOD 300  
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}  
        Blend one OneMinusDstColor  
        ZWrite Off  
 
        // First pass does reflection cubemap  
        Pass   
        {   
            Name "BASE" 
            Tags {"LightMode" = "Always"}  
CGPROGRAM  
#pragma vertex vert  
#pragma fragment frag  
#pragma fragmentoption ARB_fog_exp2  
#pragma fragmentoption ARB_precision_hint_fastest  
#include "UnityCG.cginc"  
 
struct v2f {  
    float4 pos : SV_POSITION;  
    float2 uv : TEXCOORD0;  
    float3 I : TEXCOORD1;  
};  
 
uniform float4 _MainTex_ST;  
 
v2f vert(appdata_tan v)  
{  
    v2f o;  
    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);  
    o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);  
 
    // calculate object space reflection vector   
    float3 viewDir = ObjSpaceViewDir( v.vertex );  
    float3 I = reflect( -viewDir, v.normal );  
 
    // transform to world space reflection vector  
    o.I = mul( (float3x3)unity_ObjectToWorld, I );  
 
    return o;   
}  
 
uniform sampler2D _MainTex;  
uniform samplerCUBE _Cube;  
uniform float4 _ReflectColor;  
 
half4 frag (v2f i) : COLOR  
{  
    half4 texcol = tex2D (_MainTex, i.uv);  
    half4 reflcol = texCUBE( _Cube, i.I );  
    reflcol *= texcol.a;  
    return reflcol * _ReflectColor;  
}   
ENDCG  
        }  
 
        UsePass "Parallax Specular/PPL" 
 
    }  
    FallBack "Reflective/VertexLit", 1  
}