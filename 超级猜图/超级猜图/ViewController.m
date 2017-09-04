//
//  ViewController.m
//  超级猜图
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "CZQuestion.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *questions;
@end

@implementation ViewController

#pragma mark - 懒加载
- (NSArray *)questions{
    if(_questions==nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        for (NSDictionary *dict in arrayDict) {
            CZQuestion *model = [CZQuestion questionWithDick:dict];
            [arrayModels addObject:model];
        }
        _questions = arrayModels;
    }
    return _questions;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
