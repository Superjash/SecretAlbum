// 定义position 属性
attribute vec4 position;
//定义inputTextureCoordinate属性(纹理坐标)
attribute vec4 inputTextureCoordinate;

//传递数据给FSH，需要两个着色器必须声明同一个名称的varying属性
varying vec2 textureCoordinate;

void main()
{
    // 将外部传入的position直接赋值给gl，最终的数据为-1 ~ 1
    gl_Position = position;
    
    // 传递纹理坐标到VSH
    textureCoordinate = inputTextureCoordinate.xy;
}
