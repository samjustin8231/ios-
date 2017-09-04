//
//  CZHeaderView.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZHeaderView.h"

@interface CZHeaderView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation CZHeaderView

+ (CZHeaderView *)headView{
    CZHeaderView *view = [[[NSBundle mainBundle]loadNibNamed:@"CZHeaderView" owner:nil options:nil] firstObject];
    return view;

}

@end
