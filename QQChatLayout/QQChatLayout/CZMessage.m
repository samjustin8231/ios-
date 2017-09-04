//
//  CZMessage.m
//  QQChatLayout
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZMessage.h"

@implementation CZMessage
- (CZMessage *)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (CZMessage *)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
