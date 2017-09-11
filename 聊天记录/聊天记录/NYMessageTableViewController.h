//
//  ViewController.h
//  聊天记录
//
//  Created by sam on 2017/9/6.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYMessageFrameModel.h"

@interface NYMessageTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UINavigationBar *statusBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *statusTitle;

@property (nonatomic, copy) NSString *groupId;

@end

