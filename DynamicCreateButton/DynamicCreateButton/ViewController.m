//
//  ViewController.m
//  DynamicCreateButton
//
//  Created by sam on 2017/9/1.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//要显示一个界面的时候，首先创建这个界面对应的控制器
//控制器创建好以后，接着创建控制器所管理的那个view，当这个view加载完毕以后
//就开始执行viewDidLoad方法
//只要viewDidLoad方法被执行了，就表示控制器所管理的view创建好了
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad");
    
    //动态创建自己的按钮
    //1.创建按钮（UIButton）
    // UIButton *button = [[UIButton alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //2.给按钮设置文字
    [button setTitle:@"我要上iPhone" forState:UIControlStateNormal];
    
    //3.设置高亮状态下的显示文字和颜色
    [button setTitle:@"摸我一下" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor redColor]  forState:UIControlStateNormal];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    
    //4.设置默认状态下的背景图片
    UIImage *imageNarmal = [UIImage imageNamed:@"speaker"];
    UIImage *imageHighLighted = [UIImage imageNamed:@"mute"];
    [button setBackgroundImage:imageNarmal forState:UIControlStateNormal];
    
    
    //5.设置高亮状态下的背景图片
    [button setBackgroundImage:imageHighLighted forState:UIControlStateHighlighted];
    
    //注册点击事件
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:(UIControlEventTouchUpInside)];
    
    //6.设置按钮的frame
    button.frame = CGRectMake(50, 100, 100, 100);
    
    //把动态创建的按钮加到控制器所管理的那个view中
    [self.view addSubview:button];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击事件
- (void)buttonClicked{
    NSLog(@"clicked");
}

@end
