//
//  CZGoods.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZGoods.h"

@implementation CZGoods

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)goodsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
