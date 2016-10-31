//
//  UserInformation.h
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define AccountInfo ([UserInformation shareUserInfo]) 

@interface UserInformation : NSObject

//用户信息类
@property(nonatomic,copy)NSString* userId;      //商户id
@property(nonatomic,copy)NSString* terminalId;
@property(nonatomic,copy)NSString* area_code;

@property(nonatomic,assign)BOOL isLogin;


+ (void)saveUserInfo; //保存用户信息
+ (UserInformation *)shareUserInfo;  //获取用户信息

@end
