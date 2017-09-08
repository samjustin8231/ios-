//
//  ViewController.h
//  聊天记录
//
//  Created by sam on 2017/9/6.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYMessageFrameModel.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *messageFrames;

@end

