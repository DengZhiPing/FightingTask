//
//  TabbarController.m
//  MobileUniversity
//
//  Created by zhaojh on 16/8/15.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#import "TabbarController.h"
#import "HomeController.h"
#import "UserCenterVC.h"
#import "BaseNaviController.h"
#import "FindController.h"

@interface TabbarController ()<UITabBarControllerDelegate>

@property(nonatomic,strong)NSMutableArray* controllers;
@property(nonatomic,strong)NSArray* normalImages;
@property(nonatomic,strong)NSArray* selectImages;
@property(nonatomic,strong)NSArray* titles;

@end

@implementation TabbarController

-(instancetype)init{

    if (self = [super init]) {
        
         self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self initSetting];
    [self setupUI];
}

-(void)initSetting{

    self.titles = @[@"首页",@"发现",@"个人中心"];
    self.normalImages = @[@"home_normal",@"find_normal",@"user_normal"];
    self.selectImages = @[@"home_select",@"find_select",@"user_select"];
    
    NSArray* vcs = @[
                     [[HomeController alloc] init],
                     [[FindController alloc] init],
                     [[UserCenterVC alloc] init]
                     ];
    _controllers = [NSMutableArray array];
    [vcs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        BaseNaviController* naviVC = [[BaseNaviController alloc]initWithRootViewController:obj];
        
        [self.controllers addObject:naviVC];
    }];
   self.viewControllers = [NSArray arrayWithArray:self.controllers];
}

- (void)setupUI{
    
    for (NSInteger i = 0; i < self.controllers.count; i++) {
        
        UIViewController *vc = [self.controllers objectAtIndex:i];
        UIImage *mainNormalImage = [UIImage imageNamed:[self.normalImages objectAtIndex:i]];
        UIImage *mainSelectImage = [UIImage imageNamed:[self.selectImages objectAtIndex:i]];
        NSString *title = [self.titles objectAtIndex:i];
        
        mainNormalImage = [mainNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        mainSelectImage = [mainSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:mainNormalImage selectedImage:mainSelectImage];
        
    }
  
    //修改字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(0, 152, 255, 1.0),NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
}

#pragma mark - UITabbarViewControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    
}

@end
