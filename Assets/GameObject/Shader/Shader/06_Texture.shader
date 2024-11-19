Shader "Unlit/06_Texture"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;      // 法線用に別のテクスチャ座標レジスタ
                float3 worldPosition : TEXCOORD2; // ワールド座標用にさらに別のレジスタ
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex).xyz; // ワールド座標を計算
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // テクスチャ
                float2 tiling = _MainTex_ST.xy;
                float2 offset = _MainTex_ST.zw;
                _Color = tex2D(_MainTex, i.uv * tiling + offset)*_Color;

                // 環境光
                fixed4 ambient = _Color * 0.3 * _LightColor0;

                // 視線ベクトル
                float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);

                // ライトベクトル
                float3 lightDir = normalize(_WorldSpaceLightPos0.xyz);

                // 法線ベクトルの正規化
                float3 normal = normalize(i.normal);

                // 鏡面反射光の計算
                float3 reflectDir = reflect(-lightDir, normal);
                fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

                // 拡散反射光の計算
                float intensity = saturate(dot(normal, lightDir));
                fixed4 diffuse = _Color * intensity * _LightColor0;

                // Phongシェーディング結果の計算
                fixed4 phong = ambient+ diffuse + specular;

                return phong;
            }
            ENDCG
        }
    }
}
