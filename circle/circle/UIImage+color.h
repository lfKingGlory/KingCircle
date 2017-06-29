//
//  UIImage+color.h
//  showTime
//
//  Created by msj on 16/8/24.
//  Copyright © 2016年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)
+ (UIImage *)ms_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;
+ (UIImage *)ms_scaleToSize:(UIImage *)img ratio:(float)ratio;
@end
