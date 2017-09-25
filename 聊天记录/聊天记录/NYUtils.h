//
//  NYUtils.h
//  聊天记录
//
//  Created by sam on 2017/9/12.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYGroup.h"

@interface NYUtils : NSObject

+ (NSString *)toNumber;
+ (void)setToNumber:(NSString *)toNumber;

+ (NSString *)userId;
+ (void)setUserId:(NSString *)userId;

+ (NSString *)number;
+ (void)setNumber:(NSString *)number;

+ (BOOL)isNullOfString:(NSString *)str;

+(NYGroup *)getGroupByGroupId:(NSString *)groupId;
@end
