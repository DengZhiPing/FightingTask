//
//  MallNetManager.m
//  BusinessManager
//
//  Created by zhaojh on 16/8/2.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "JMNetWorking.h"
#import "AFSecurityPolicy.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase641.h"
#import "Utils.h"
#import "AFURLRequestSerialization.h"

static dispatch_once_t onceToken;
static JMNetWorking *_sharedManager = nil;
@implementation NSDate (NSDateHelper)

+(NSString *)nowString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter stringFromDate:[NSDate date]];
}

@end
@implementation NSString (Helper)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end

@implementation JMNetWorking
+ (instancetype)share {
    
    dispatch_once(&onceToken, ^{
        //设置服务器根地址
        _sharedManager = [[JMNetWorking alloc] initWithBaseURL:[NSURL URLWithString:[URL_Server stringByAppendingString:URL_Root]]];
    
        [_sharedManager settingManager];
    });
    
    return _sharedManager;
}

-(void)settingManager{
    [_sharedManager setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
    
    [_sharedManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G网络已连接");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络已连接");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络连接失败");
                break;
                
            default:
                break;
        }
    }];
    [_sharedManager.reachabilityManager startMonitoring];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

    _sharedManager.requestSerializer.timeoutInterval = 15;
    //发送json数据
    _sharedManager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
    //响应json数据
    _sharedManager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    //    [manager.requestSerializer setHTTPMethodsEncodingParametersInURI:[NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]]];
    //设置响应内容格式  经常因为服务器返回的格式不是标准json而出错 服务器可能返回text/html text/plain 作为json
    
    _sharedManager.responseSerializer.acceptableContentTypes =  [_sharedManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
}

-(void)addCustomHeader:(JMNetWorking*)manager{
    
    NSString *now = [NSDate nowString];
    NSString* str;
    if (now.length > 12) {
        str = [now substringWithRange:NSMakeRange(0, now.length - 2)];
    }
    [manager.requestSerializer setValue:str forHTTPHeaderField:@"timeStr"];
    [manager.requestSerializer setValue:@"ios900" forHTTPHeaderField:@"clientName"];
    
    NSString* pwdStr = [NSString stringWithFormat:@"%@%@%@",@"ios900",str,@"q#9asdjasj"];
    [manager.requestSerializer setValue:[pwdStr md5] forHTTPHeaderField:@"pwd"];
    
//    NSString *now = [NSDate nowString];
//    
//    NSString *rightpart = [NSString stringWithFormat:@"%@%@%@%@", @"12580777",[now substringToIndex:8],@"1.0",[now substringFromIndex:8]];
//    NSString *headerValue = [NSString stringWithFormat:@"%@#%@", now, [rightpart md5]];
//    [manager.requestSerializer setValue:headerValue forHTTPHeaderField:@"KW"];
//    [manager.requestSerializer setValue:@"IOS_12580" forHTTPHeaderField:@"clientName"];
//    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"terminalId"];
//    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"mallUserId"];

}

- (NSString*)encodedSendingBody:(id)params{
    NSString * dataStr;
    if ([params isKindOfClass:[NSString class]]) {
        dataStr = params;
    }else{
        NSError*error;
        NSData * data =  [NSJSONSerialization dataWithJSONObject:params
                                                         options:0
                                                           error:&error];
        dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    NSData *encodingData = [GTMBase641 encodeData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSString* base64EncodingString = [[NSString alloc] initWithBytes:[encodingData bytes] length:[encodingData length] encoding:NSUTF8StringEncoding];
    NSString* requestBody = [Utils stringToHex:base64EncodingString];
    return  requestBody;
}

- (NSURLSessionDataTask *)request:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    JMNetWorking *manager = [JMNetWorking share];
     [manager addCustomHeader:_sharedManager]; //请求头
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
         [parameters setObject:@"1.0" forKey:@"VERSION"];
    }
    NSLog(@"Request Body:%@",parameters);
    
    return [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        if (success) {
             success(task,responseObject);
        }
        NSLog(@"Response Data:%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
             failure(task,error);
        }
    }];
}

- (NSURLSessionDataTask *)requestGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    JMNetWorking *manager = [JMNetWorking share];
    [manager addCustomHeader:_sharedManager]; //请求头
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        [parameters setObject:@"1.0" forKey:@"VERSION"];
    }
    return [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failure(task,error);
    }];
}

- (NSURLSessionDataTask *)requestEncode:(NSString *)URLString
                             parameters:(id)parameters
                                success:(void (^)(NSURLSessionDataTask * task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{

    JMNetWorking *manager = [JMNetWorking share];
    _sharedManager.responseSerializer  = [AFHTTPResponseSerializer serializer];
         [manager addCustomHeader:_sharedManager]; //请求头
    
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        [parameters setObject:@"1.0" forKey:@"VERSION"];
    }
    NSLog(@"Request body: %@",parameters);
    //需要在AFN改两行代码
    return [manager POST:URLString parameters:[self encodedSendingBody:parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (!success) {
            return;
        }
        NSString* rspStr = [[[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding] baseHexDecode];
        NSError* error;
        id rsp = [NSJSONSerialization JSONObjectWithData:[rspStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
        
        success(task,rsp);
        if (error) {
            NSLog(@"Error == %@",error);
            return;
        }
        NSLog(@"Response Data:%@",[rsp mj_JSONString]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(task,error);
        }
    }];
}

-(NSURLSessionDataTask *)request:(NSString*)urlStr prams:(id)prams succeed:(void (^)(id responseObject))success showHUD:(BOOL)showHUD{

    if (showHUD) {
        [SVProgressHUD showWithStatus:@"数据处理中..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    }
   return [self request:urlStr parameters:prams success:^(NSURLSessionDataTask *task, id responseObject) {
       [SVProgressHUD dismiss];
       if (Succeed(responseObject)) {
           if (success) {
               success(responseObject);
           }
       }else{
           if ([responseObject[@"msg"] length] > 0) {
               [OMGToast showWithText:responseObject[@"msg"]];
           }
       }

   } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        [SVProgressHUD dismiss];
       if (showHUD) {
           [OMGToast showWithText:@"网络异常,请稍候重试!"];
       }
    }];
}

+(void)cancleAllRequest{

    [[_sharedManager operationQueue] cancelAllOperations];
}

//设置ip要重置单例 生效
+ (void)reset {
    _sharedManager = nil;
    onceToken = 0; 
}

@end
