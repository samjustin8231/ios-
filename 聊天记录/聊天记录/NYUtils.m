//
//  NYUtils.m
//  聊天记录
//
//  Created by sam on 2017/9/12.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYUtils.h"
#import "NYGroup.h"

static NSString *toNumber;
static NSString *userId;
static NSString *number;

@implementation NYUtils

+(NSString *)toNumber{
    return toNumber;
}
+(void)setToNumber:(NSString *)number{
    toNumber = number;
}

+(NSString *)userId{
    return userId;
}
+(void)setUserId:(NSString *)uid{
    userId = uid;
}

+(NSString *)number{
    return number;
}
+(void)setNumber:(NSString *)num{
    number = num;
}

+ (BOOL)isNullOfString:(NSString *)string{
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])
    {
        return YES;
        
        
    }else
    {
        
        return NO;
    }
}

+(NYGroup *)getGroupByGroupId:(NSString *)groupId{
    
    
    return nil;
}
@end
