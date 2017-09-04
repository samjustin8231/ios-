//
//  CZGoodsCell.h
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZGoods.h"

@interface CZGoodsCell : UITableViewCell

@property(nonatomic,strong) CZGoods * goods;

+ (CZGoodsCell *) goodsCellWithTableView:(UITableView *) tableView;

@end
