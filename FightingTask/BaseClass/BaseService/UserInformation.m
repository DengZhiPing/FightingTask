//
//  UserInformation.m
//  BusinessManager
//
//  Created by zhaojh on 16/7/21.
//  Copyright © 2016年 cmcc. All rights reserved.
//


#import "UserInformation.h"

@implementation UserInformation

- (void) encodeWithCoder: (NSCoder *)coder{
    
    [coder encodeObject:self.terminalId forKey:@"terminalId"];
    [coder encodeObject:self.area_code forKey:@"area_code"];
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:@(self.isLogin) forKey:@"isLogin"];
}

- (id)initWithCoder: (NSCoder *) coder{
    _terminalId = [[coder decodeObjectForKey:@"terminalId"] copy];
    _area_code = [[coder decodeObjectForKey:@"area_code"] copy];
    _userId = [[coder decodeObjectForKey:@"storeId"] copy];
    _isLogin = [[[coder decodeObjectForKey:@"isLogin"] copy] boolValue];
    
    return self;
}

+ (void)saveUserInfo{
    
    [NSKeyedArchiver archiveRootObject:AccountInfo toFile:[self getPath]];
}

+ (UserInformation *)shareUserInfo{
    static dispatch_once_t pred;
    static UserInformation *shared = nil;
    dispatch_once(&pred, ^{
    shared = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPath]];
         if (shared == nil) {
            shared = [[UserInformation alloc] init];
        }
    });
    return shared;
}

+ (NSString*)getPath{
    
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject];
    NSString* fileName = @"BusinessManagerUserInfo.plist";
    NSString *filePath = [docuPath stringByAppendingPathComponent:fileName];
    return filePath;
}



@end
