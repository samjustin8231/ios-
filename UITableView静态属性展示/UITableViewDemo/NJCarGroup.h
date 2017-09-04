//
//  NJCarGroup.h
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJCarGroup : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *des;
@property (nonatomic, strong) NSArray *cars;
@end
