// Upgrade NOTE: replaced 'SeperateSpecular' with 'SeparateSpecular'

Shader "EnvMapGlass" {
Properties {
_EnvMap ("EnvMap", 2D) = "black" { TexGen SphereMap }
}
SubShader {
SeparateSpecular On
Pass {
Name "BASE"
Cull Front 
//Blend One OneMinusDstColor
Blend One One
BindChannels {
Bind "Vertex", vertex 
Bind "normal", normal 
}
SetTexture [_EnvMap] {
combine texture 
}
}
Pass {
Name "BASE"
ZWrite on
Blend One One
BindChannels {
Bind "Vertex", vertex 
Bind "normal", normal 
}
SetTexture [_EnvMap] {
combine texture 
}
}
}
Fallback off 
}