//
//  Utils.h
//  BusinessTool
//
//  Created by Chen dy on 3/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject 
{

}

+ (NSString *) stringFromHex:(NSString *)str;
+ (NSString *) stringToHex:(NSString *)str;

+(char*)Hex2Ascii:(const char *)hex;
+(char*)Ascii2Hex:(const char*)asc;


@end
