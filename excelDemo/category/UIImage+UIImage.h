//
//  UIImage+UIImage.h
//  BSBDJ16
//
//  Created by 黄明鹏 on 16/6/15.
//  Copyright © 2016年 黄明鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (UIImage)
//返回一个没被渲染的图片@end
+(UIImage*)imagewithName:(NSString*)name;
/********高斯模糊*************/
/**
 *  CoreImage图片高斯模糊
 *
 *  @param image 图片
 *  @param blur  模糊数值(默认是10)
 *
 *  @return 重新绘制的新图片
 */

+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
/**
 *  vImage模糊图片
 *
 *  @param image 原始图片
 *  @param blur  模糊数值(0-1)
 *
 *  @return 重新绘制的新图片
 */
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
