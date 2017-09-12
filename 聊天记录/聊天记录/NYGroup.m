//
//  NYGroup.m
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYGroup.h"
#import "NYUser.h"

@implementation NYGroup

- (instancetype)initWithDict:(NSDictionary *)dict{
    if(self=[super init]){
        //嵌套的字典转模型
        self.groupId=dict[@"groupId"];
        
        //注意
        NSArray *dictcars=dict[@"users"];
        //像下面这样写可以提高性能
        NSMutableArray *arrayM=[NSMutableArray arrayWithCapacity:dictcars.count];
        for (NSDictionary *dict  in dictcars) {
            NYUser *yycars=[[NYUser alloc]initWithDict:dict];
            [arrayM addObject:yycars];
        }
        // 赋值存储模型的数组给属性
        self.users=arrayM;
    }
    return self;
    
}

+ (instancetype)groupWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (NSString *)description{
    NSString *desGroup = [NSString stringWithFormat:@"groupId:%@",self.groupId];
 
    NSMutableString *des = [NSMutableString string];
    [des appendString:desGroup];
    
    [des appendString:@"下面是users "];
    for (NYUser *user in self.users) {
        [des appendString:user.description];
    }
    return des;
}
@end
