//
//  NJHero.h
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJHero : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *intro;

- (instancetype) initWithDict: (NSDictionary *)dict;
+ (instancetype) heroWithDict: (NSDictionary *)dict;
@end
