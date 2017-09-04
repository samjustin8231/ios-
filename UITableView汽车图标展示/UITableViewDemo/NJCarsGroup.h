//
//  NJCarsGroup.h
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJCarsGroup : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *cars;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)carsGroupWithDict:(NSDictionary *)dict;
@end
