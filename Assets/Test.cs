using UnityEngine;
using System.Runtime.InteropServices;

public class Test : MonoBehaviour
{
    #if !UNITY_EDITOR && (UNITY_IOS || UNITY_WEBGL)
    [DllImport("__Internal")]
    #else
    [DllImport("mandelbrot")]
    #endif
    static extern void generate_image([Out] Color32[] buffer, int width, int height);

    const int Size = 512;

    void Start()
    {
        var startTime = Time.realtimeSinceStartup;

        var pixels = new Color32[Size * Size];
        generate_image(pixels, Size, Size);

        var endTime = Time.realtimeSinceStartup;
        Debug.Log("execution time = " + (endTime - startTime));

        var texture = new Texture2D(Size, Size);
        texture.wrapMode = TextureWrapMode.Clamp;
        texture.SetPixels32(pixels);
        texture.Apply();

        GetComponent<Renderer>().material.mainTexture = texture;
    }

    void Update()
      => transform.localRotation = Quaternion.Euler(33.3f * Time.time, 41.7f * Time.time, 0);
}
