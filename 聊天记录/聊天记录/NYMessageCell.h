//
//  NYMessageCell.h
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NYMessageFrameModel;

@interface NYMessageCell : UITableViewCell
@property (nonatomic, strong) NYMessageFrameModel *messageFrame;

+(instancetype)messageCellWithTableView:(UITableView *)tableView;
@end
