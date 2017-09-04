//
//  CZFooterView.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZFooterView.h"

@interface CZFooterView ()

@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *btnWaitView;
- (IBAction)btnLoadMoreClick:(id)sender;


@end

@implementation CZFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (CZFooterView *)footerView{
    CZFooterView *view = [[[NSBundle mainBundle]loadNibNamed:@"CZFooterView" owner:nil options:nil] firstObject];
    return view;
}

- (IBAction)btnLoadMoreClick:(id)sender {
    //隐藏正在加载
    self.btnLoadMore.hidden = YES;
    self.btnWaitView.hidden = NO;
    
    //
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //通过代理更新数据
        if([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]){
            [self.delegate footerViewUpdateData:self];
        }
        
        //显示正在加载
        self.btnLoadMore.hidden = NO;
        self.btnWaitView.hidden = YES;
    });
    
    
}
@end
