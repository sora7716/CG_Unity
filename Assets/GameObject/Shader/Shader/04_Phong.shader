Shader "Unlit/04_Phong"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
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
            fixed4 _Color;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float3 worldPosition : TEXCOORD0; // ワールド座標用
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPosition = mul(unity_ObjectToWorld, v.vertex).xyz; // ワールド座標を計算
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // 環境光
                fixed4 ambient = _Color * 0.3 * _LightColor0;

                // 視線ベクトル
                float3 eyeDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPosition);

                // ライトベクトル
                float3 lightDir = normalize(_WorldSpaceLightPos0);

                // 法線ベクトルの正規化
                i.normal = normalize(i.normal);

                // 鏡面反射光の計算
                float3 reflectDir = reflect(-lightDir, i.normal);
                fixed4 specular = pow(saturate(dot(reflectDir, eyeDir)), 20) * _LightColor0;

                // 拡散反射光の計算
                float intensity = saturate(dot(i.normal, lightDir));
                fixed4 diffuse = _Color * intensity * _LightColor0;

                // Phongシェーディング結果の計算
                fixed4 phong = ambient + diffuse + specular;
                return phong;
            }
            ENDCG
        }
    }
}
