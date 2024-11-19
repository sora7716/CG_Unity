using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PostEffectAttacher : MonoBehaviour
{
    public Shader shader;   
    private Material material;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void Awake()
    {
        material = new Material(shader);//shader‚ğŠ„‚è“–‚Ä‚½“®“I¶¬
    }

    private void OnRenderImage(RenderTexture source,RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
    
}
