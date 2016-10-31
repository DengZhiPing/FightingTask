//
//  HomeController.m
//  MobileUniversity
//
//  Created by zhaojh on 16/8/15.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#import "HomeController.h"
#import "TabbarController.h"
#import "TestVC.h"
#import "LoginController.h"

@implementation HomeController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton* bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = CGRectMake(100, 100, 100, 100);
    bu.backgroundColor = [UIColor orangeColor];
    [bu addTarget:self action:@selector(buAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
    
    
    
    
}

-(void)buAction{

//    TestVC* vc = [[TestVC alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];

    LoginController* loginVC = [[LoginController alloc]init];

    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
