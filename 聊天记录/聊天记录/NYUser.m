//
//  NYUser.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYUser.h"

@implementation NYUser

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.uId=dict[@"uId"];
        self.isOnline=dict[@"isOnline"];
    }
    return self;
}
+(instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


@end
