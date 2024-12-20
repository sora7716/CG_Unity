Shader "Unlit/17_ ScanNoise"
{
   Properties
   {
     _MainTex("MainTex",2D)=""{}
   }

   SubShader 
   {
      Pass
      {
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag
         #include "UnityCG.cginc"

         struct appdata
         {
            float4 vertex:POSITION;
            float2 uv:TEXCOORD0;
         };
         struct v2f
         {
            float4 vertex:SV_POSITION;
            float2 uv :TEXCOORD0;
         };
         sampler2D _MainTex;//必ず_MainTexとする
         float4 _MainTex_ST;
         v2f vert(appdata v)
         {
            v2f o;
            o.vertex=UnityObjectToClipPos(v.vertex);
            o.uv=v.uv;
            return o;
         }
         fixed4 frag(v2f i):SV_Target
         {
         float _Speed=0.2;
         float _Width=0.03;
         float _Power=0.5;
         float sbTime=-frac(_Time.y*_Speed);
         float seTime=sbTime+_Width;
         float2 uv;
         uv.x=i.uv+sin(smoothstep(sbTime,seTime,i.uv.y)*2*3*3.14159)*_Power;
         uv.y=i.uv.y;
         float shift = 0.005;
         fixed r=tex2D(_MainTex,i.uv+float2(-shift,0)).r;
         fixed g=tex2D(_MainTex,i.uv+float2(0,0)).g;
         fixed b=tex2D(_MainTex,i.uv+float2(shift,0)).b;
         fixed4 col=tex2D(_MainTex,uv)*fixed4(r,g,b,1);
         return fixed4(col.r,col.g,col.b,1);
         }
         ENDCG
      }
   }
}
