//
//  CZQuestion.m
//  超级猜图
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZQuestion.h"

@implementation CZQuestion

//相当于构造方法（用NSDictionary 字典构造）
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

//提供类方法来调用initWithDict：dict方法，方便调用
+(instancetype)questionWithDick:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
    
    
}

@end
