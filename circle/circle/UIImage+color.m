//
//  UIImage+color.m
//  showTime
//
//  Created by msj on 16/8/24.
//  Copyright © 2016年 msj. All rights reserved.
//

#import "UIImage+color.h"

@implementation UIImage (color)
+ (UIImage *)ms_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize
{
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)ms_scaleToSize:(UIImage *)img ratio:(float)ratio
{
    UIGraphicsBeginImageContext(CGSizeMake(img.size.width*ratio, img.size.height*ratio));
    [img drawInRect:CGRectMake(0, 0, img.size.width*ratio, img.size.height*ratio)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
