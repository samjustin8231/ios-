//
//  NJCarsGroup.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NJCarsGroup.h"
#import "NJCar.h"

@implementation NJCarsGroup
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        //嵌套的字典转模型
        self.title=dict[@"title"];
        
        //注意
        NSArray *dictcars=dict[@"cars"];
        //像下面这样写可以提高性能
        NSMutableArray *arrayM=[NSMutableArray arrayWithCapacity:dictcars.count];
        for (NSDictionary *dict  in dictcars) {
            NJCar *yycars=[[NJCar alloc]initWithDict:dict];
            [arrayM addObject:yycars];
        }
        // 赋值存储模型的数组给属性
        self.cars=arrayM;
    }
    return self;
}

+(instancetype)carsGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
