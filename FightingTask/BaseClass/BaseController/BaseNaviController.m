//
//  BaseNaviController.m
//  MobileUniversity
//
//  Created by zhaojh on 16/8/15.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#import "BaseNaviController.h"

#define NaviBarColor    HexColor(@"#3a3a3a") //导航栏背景颜色
#define TitleFont      [UIFont systemFontOfSize:18] //标题字体

@implementation BaseNaviController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.enabled = YES;
    
    __weak typeof (self) weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    [self settingMyBar];
}

-(void)settingMyBar{
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:TitleFont,
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setBarTintColor:NaviBarColor];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 需要禁用的VC
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if (viewController == navigationController.viewControllers[0])
    {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToViewController:viewController animated:animated];
}


@end
