//
//  NJHero.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NJHero.h"

@implementation NJHero

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        self.icon=dict[@"icon"];
        self.name=dict[@"name"];
        self.intro=dict[@"intro"];
    }
    return self;
}

+ (instancetype)heroWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
