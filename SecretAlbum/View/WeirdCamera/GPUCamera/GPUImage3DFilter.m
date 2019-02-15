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
 
 uniform highp vec2 imagePixel;
 
 uniform highp vec2 offset;
 
 void main()
 {
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
    
- (void)setupFilterForSize:(CGSize)filterFrameSize
{
    runSynchronouslyOnVideoProcessingQueue(^{
        [GPUImageContext setActiveShaderProgram:self->filterProgram];
        CGSize imagePixel;
        imagePixel.width = 1.0 / filterFrameSize.width;
        imagePixel.height = 1.0 / filterFrameSize.height;
        [self setSize:imagePixel forUniformName:@"imagePixel"];
        [self setPoint:self.offset forUniformName:@"offset"];
//        NSLog(@"%f, %f", self.offset.x, self.offset.y);
    });
}

@end
