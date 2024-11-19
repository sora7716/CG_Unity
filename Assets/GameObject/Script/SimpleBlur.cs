using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleBlur : MonoBehaviour
{
    public Shader shader;
    private Material material;
    
    private void Awake()
    {
        material = new Material(shader);//shaderÇäÑÇËìñÇƒÇΩìÆìIê∂ê¨
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination) 
    {
        RenderTexture buf1 = RenderTexture.GetTemporary(source.width/2,source.height/2,0,source.format);
        RenderTexture buf2 = RenderTexture.GetTemporary(source.width/4,source.height/4,0,source.format);
        RenderTexture buf3 = RenderTexture.GetTemporary(source.width/8,source.height/8,0,source.format);
        Graphics.Blit(source, buf1);
        Graphics.Blit(buf1,buf2);
        Graphics.Blit(buf2,buf3);

        Graphics.Blit(buf3, buf2);
        Graphics.Blit(buf2, buf1);
        Graphics.Blit(buf1, destination);

        RenderTexture.ReleaseTemporary(buf1);
        RenderTexture.ReleaseTemporary(buf2);
        RenderTexture.ReleaseTemporary(buf3);
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
