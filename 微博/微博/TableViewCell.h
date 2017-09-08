//
//  TableViewCell.h
//  微博
//
//  Created by sam on 2017/9/7.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZWeibo.h"
#import "CZWeiboFrame.h"

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) CZWeiboFrame *weiboFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
