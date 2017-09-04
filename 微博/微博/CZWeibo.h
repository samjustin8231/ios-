//
//  CZWeibo.h
//  微博
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZWeibo : NSObject
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,assign,getter=isVip)BOOL vip;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) weiboWithDict:(NSDictionary *)dict;

@end
