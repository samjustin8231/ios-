//
//  NJCar.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NJCar.h"

@implementation NJCar
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        self.name=dict[@"name"];
        self.icon=dict[@"icon"];
    }
    return self;
}
+(instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
