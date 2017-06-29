//
//  MSNavigationController.m
//  circle
//
//  Created by msj on 2017/6/7.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSNavigationController.h"

@interface MSNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:[UIColor colorWithRed:51/255.0 green:48/255.0 blue:146/255.0 alpha:1.0]];
    [navigationBar setTranslucent:NO];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonOnClick)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    NSLog(@"self.viewControllers.count=====%ld",self.viewControllers.count);
    NSLog(@"navigationBar.items.count=====%ld",navigationBar.items.count);
    
    if ([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self popViewControllerAnimated:YES];
    });
    return NO;
}

- (void)backButtonOnClick
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}
@end
