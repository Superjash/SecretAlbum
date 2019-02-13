// 这个属性我们已经在顶点着色器见到过了
varying highp vec2 textureCoordinate;

// 这个属性是画面的内容，由外部传入，值为0~1。
uniform sampler2D inputImageTexture;

void main()
{
    //这里只是简单的将当前位置上的图片读取出来赋值给GL。
    gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
}
