//
//  StringHelper.h
//  PTLog
//
//  Created by Ellen Miner on 1/2/09.
//  Copyright 2009 RaddOnline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (StringHelper)

/*
- (UILabel *)RAD_newSizedCellLabelWithSystemFontOfSize:(CGFloat)size;
- (void)RAD_resizeLabel:(UILabel *)aLabel WithSystemFontOfSize:(CGFloat)size;
*/

- (NSString *) baseHexEncode;
- (NSString *) baseHexDecode;

- (NSString *) fromHex; 
- (NSString *) toHex;

- (NSString *) md5;
- (NSString *) trim;
- (NSInteger) length2;


- (NSString *) documentPath;


//@interface NSString (NSString_JavaAPI)
- (NSInteger) compareTo: (NSString*) comp;
- (NSInteger) compareToIgnoreCase: (NSString*) comp;
- (bool) contains: (NSString*) substring;
- (bool) endsWith: (NSString*) substring;
- (bool) startsWith: (NSString*) substring;
- (NSInteger) indexOf: (NSString*) substring;
- (NSInteger) indexOf:(NSString *)substring startingFrom: (NSInteger) index;
- (NSInteger) lastIndexOf: (NSString*) substring;
- (NSInteger) lastIndexOf:(NSString *)substring startingFrom: (NSInteger) index;
- (NSString*) substringFromIndex:(NSInteger)from toIndex: (NSInteger) to;
- (NSArray*) split: (NSString*) token;
- (NSString*) replace: (NSString*) target withString: (NSString*) replacement;
- (NSArray*) split: (NSString*) token limit: (NSInteger) maxResults;


//@interface NSString(MPTidbits)

- (BOOL)isEmpty;
- (BOOL)isEmptyIgnoringWhitespace:(BOOL)ignoreWhitespace;
- (NSString *)stringByTrimmingWhitespace;


//custom
-(BOOL)isEmail;
- (BOOL)isMobileNumber;
-(BOOL)isValidateEmail;
-(BOOL)isValidatePwd;
- (BOOL)isValidateByRegex:(NSString *)regex;
- (BOOL)isValidateNumber;
+(NSString*) stringFromInteger:(NSInteger)num;
+(NSString*) stringFromFloat:(float)num;


/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithUnit:(BOOL)unit;

//订单显示价格
- (NSString *)priceStringWithOrderList;

//新统一
/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)covertStringToPriceStringWithUnit:(BOOL)unit;

/**
 *@日期格式转换函数
 *date所要转化的日期 格式为"yyyyMMddHHmmss"
 *type转化的格式  1:@"yyyy-MM-dd HH:mm:ss"
 *              2:@"yyyy-MM-dd"
 **/
- (NSString *)switchDateReturnType:(NSUInteger)type;
/**
 *  是否是正确的身份证号
 *
 *  @return YES/NO
 */
-(BOOL) isCorrectCardID;

- (BOOL)isCarNumber;

-(BOOL)judgeTelephoneLength;
-(BOOL)judgeTelephone;
-(BOOL)judgeEmail;
-(BOOL)judgeIdentityCard;
-(BOOL)judgeMoney;
-(BOOL)judgeNum;

@end