//
//  CZWeiboFrame.h
//  微博
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@class CZWeibo;

@interface CZWeiboFrame : NSObject


@property (nonatomic, strong) CZWeibo *weibo;

@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, assign) CGRect nameFrame;
@property (nonatomic, assign) CGRect vipFrame;
@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect picFrame;

@property (nonatomic, assign) CGFloat rowHeight;

@end
