//
//  CZGoods.h
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZGoods : NSObject

@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (instancetype) initWithDict: (NSDictionary *) dict;
+ (instancetype) goodsWithDict: (NSDictionary *) dict;

@end
