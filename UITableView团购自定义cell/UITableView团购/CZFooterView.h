//
//  CZFooterView.h
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CZFooterView;

#pragma mark - 创建footerViewDelegate
@protocol CZFooterViewDelegate <NSObject>
@required
-(void) footerViewUpdateData:(CZFooterView *)footerView;
@end

@interface CZFooterView : UIView
@property (nonatomic,weak) id<CZFooterViewDelegate> delegate;
+ (CZFooterView *) footerView;
@end
