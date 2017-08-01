//
//  UIImage+YYChangePictureColor.h
//  YYProjectNew
//
//  Created by yangyh on 2017/8/1.
//  Copyright © 2017年 yangyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYChangePictureColor)

/**
 *  修改图片颜色（如何使用：[[UIImage imageNamed:@"image"] imageWithTintColor:[UIColor orangeColor]]; ）
 *
 *  @param tintColor 指定颜色
 *
 *  @return 图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

@end
