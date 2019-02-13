//
//  GPUImageFilter+GPUImage3DFilter.m
//  SecretAlbum
//
//  Created by Jash on 2019/2/13.
//  Copyright © 2019 Jash. All rights reserved.
//

#import "GPUImage3DFilter.h"

NSString *const kGPUImage3DFragmentShaderString = SHADER_STRING
(
 // 图片的像素坐标
 varying highp vec2 textureCoordinate;
 // 图片
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     // 这张图片转成0~1，每个像素的值是多少
     lowp vec2 imagePixel = 1.0 / vec2(640.0,1136.0);
     
     // 对纹理坐标进行偏移，*5.0代表着偏移五个像素
     lowp vec4 right = texture2D(inputImageTexture, textureCoordinate + imagePixel * 5.0);
     lowp vec4 left = texture2D(inputImageTexture, textureCoordinate - imagePixel * 5.0);
     // 最终取left的r跟right的gb组成一个新的像素
     gl_FragColor = vec4(left.r,right.g,right.b,1.0);
 }
 );

@implementation GPUImage3DFilter
    
    - (instancetype)init
    {
        self = [super initWithFragmentShaderFromString:kGPUImage3DFragmentShaderString];
        if (self) {
            
        }
        return self;
    }

@end
