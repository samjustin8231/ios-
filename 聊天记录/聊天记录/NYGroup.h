//
//  NYGroup.h
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NYUser;

@interface NYGroup : NSObject


@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, strong) NSMutableArray *users;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary*)dict;

@end
