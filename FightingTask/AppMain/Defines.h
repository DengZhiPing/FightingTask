//
//  Defines.h
//  MobileUniversity
//
//  Created by zhaojh on 16/8/15.
//  Copyright © 2016年 nanjing. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#import "SVProgressHUD.h"
#import "OMGToast.h"
#import "StringHelper.h"
#import "UIColor+Hex.h"
#import "API_Defines.h"
#import "BaseModel.h"

#define IOS_DEBUG
#ifdef IOS_DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)

#else
#define NSLog(...){}

#endif



//-----------APP--------------//
#define  BUNDLE_ID     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define  APP_VERSION   [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]
#define  BUILD_VERSION [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]
#define  SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
#define  MyWindow      (((AppDelegate *)[[UIApplication sharedApplication] delegate]).window)
#define  NavigationH 64
#define  TabbarH 44

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//----------判断机型-------------//
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6sPlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//----------判断ios系统------------//
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

//----------带参数-----------------//
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HexColor(str)          [UIColor colorWithHexString:str]
#define HexAColor(str,float)   [UIColor colorWithHexString:str alpha:float]
#define CHENK_VALUE(value) [UnitMetiodManager exchangeTheReturnValueToString:value]

#define AccountInfo ([UserInformation shareUserInfo])





#endif /* Defines_h */
