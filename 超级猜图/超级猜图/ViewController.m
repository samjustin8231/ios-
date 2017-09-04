//
//  ViewController.m
//  超级猜图
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
