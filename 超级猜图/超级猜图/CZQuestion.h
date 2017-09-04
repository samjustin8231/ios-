//
//  CZQuestion.h
//  超级猜图
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZQuestion : NSObject

@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionWithDick:(NSDictionary *)dict;

@end
