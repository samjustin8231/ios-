//
//  CZWeibo.m
//  微博
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZWeibo.h"

@implementation CZWeibo

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)weiboWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
