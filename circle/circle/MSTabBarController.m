//
//  MSTabBarController.m
//  circle
//
//  Created by msj on 2017/6/7.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSTabBarController.h"

@interface MSTabBarController ()

@end

@implementation MSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [self dropShadowWithOffset:CGSizeMake(1, -1) radius:5 color:[UIColor grayColor] opacity:0.4];
}

- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.tabBar.bounds];
    self.tabBar.layer.shadowPath = path.CGPath;
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    self.tabBar.clipsToBounds = NO;
}
@end
