//
//  NYMessageFrameModel.h
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "NYMessageModel.h"

@interface NYMessageFrameModel : NSObject

//文本
@property (nonatomic, assign) CGRect textFrame;

//时间
@property (nonatomic, assign) CGRect timeFrame;

//icon
@property (nonatomic, assign) CGRect iconFrame;

//rowHeight
@property (nonatomic, assign) CGFloat rowHeight;

//数据model
@property (nonatomic, strong) NYMessageModel *message;

@end
