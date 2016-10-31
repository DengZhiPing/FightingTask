//
//  BaseController.m
//  MobileUniversity
//
//  Created by zhaojh on 16/8/15.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#import "BaseController.h"
#import "JMArrowView.h"


@interface BaseController ()

@end

@implementation BaseController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self settingBackItem];
    
   
}

-(void)leftDrawerButtonPress:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)settingBackItem{

    if (self == self.navigationController.viewControllers[0]) {
        return;
    }
   
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    JMArrowViewCreat(CGRectMake(0, 0, 40, 40))
    .pramsSetting(80, 18, 2, [UIColor lightGrayColor])
    .tapAction(^(){
        [self leftDrawerButtonPress:nil];
    }).addAction(backView, ArrowLeft);
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithCustomView:backView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
}



@end
