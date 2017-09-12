//
//  NYUtils.h
//  聊天记录
//
//  Created by sam on 2017/9/12.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYUtils : NSObject

+ (NSString *)toNumber;
+ (void)setToNumber:(NSString *)toNumber;

+ (BOOL)isNullOfString:(NSString *)str;
@end
