//
//  NYGroupTableViewController.h
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NYGroupTableViewController : UIViewController
//group数据
@property (nonatomic, strong) NSMutableArray *groups;
//groupId
@property (nonatomic, copy) NSString *groupId;


@end
