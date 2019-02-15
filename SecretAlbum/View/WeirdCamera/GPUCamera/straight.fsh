varying highp vec2 textureCoordinate; //highp属性负责变量精度，这个被加入可以提高效率
uniform sampler2D inputImageTexture; //接收一个图片的引用，当做2D的纹理，这个数据类型就是smpler2D。
void main()
{
    gl_FragColor = texture2D(inputImageTexture, textureCoordinate); //texture是GLSL（着色语言）特有的方法
}
