shader_type spatial;

uniform sampler2D viewport_texture : source_color;

struct v2f
{
  float4 vertex : SV_POSITION;
  float4 screenPos : TEXCOORD0;
};

void fragment(){
  float2 uv = i.screenPos.xy / i.screenPos.w;
  fixed4 portalCol = tex2D(_MainTex, uv);
}