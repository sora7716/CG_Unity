using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HDR_PE_Attacher : MonoBehaviour
{
    public Material tonemappingMaterial;//各トーンマップシェーダー
    public Material halationCheckMaterial;//ハレーション確認用シェーダー
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        //HDR対応の一時テクスチャ
        RenderTexture tmp = RenderTexture.GetTemporary(source.width, source.height, 0, RenderTextureFormat.ARGBHalf);
        //トーンマップの適応
        Graphics.Blit(source, tmp, tonemappingMaterial);
        //ハレーション確認用シェーダ適用
        Graphics.Blit(tmp, destination, halationCheckMaterial);
        RenderTexture.ReleaseTemporary(tmp);
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
