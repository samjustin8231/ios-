//
//  CZMessageFrame.h
//  QQChatLayout
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class CZMessage;
@interface CZMessageFrame : NSObject

@property(nonatomic,strong) CZMessage * message;

//属性对应的frame
@property(nonatomic,readonly) CGRect timeFrame;
@property(nonatomic,readonly) CGRect iconFrame;
@property(nonatomic,readonly) CGRect textFrame;

@property(nonatomic,readonly) CGFloat rowHeight;//行高
@end
