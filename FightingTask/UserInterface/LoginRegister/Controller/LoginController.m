//
//  LoginController.m
//  MobileUniversity
//
//  Created by zhaojh on 16/8/17.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#import "LoginController.h"
#import "TestVC.h"

@interface LoginController ()

@end

@implementation LoginController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}



- (void)viewDidLoad {
    [super viewDidLoad];
   

    
}


- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)push:(id)sender {
    
        TestVC* vc = [[TestVC alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
}


@end
