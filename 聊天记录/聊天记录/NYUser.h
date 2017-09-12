//
//  NYUser.h
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYUser : NSObject
@property (nonatomic, copy) NSString *uId;
@property (nonatomic, assign) BOOL isOnline;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)userWithDict:(NSDictionary *)dict;
@end
