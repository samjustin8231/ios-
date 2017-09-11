//
//  NYPhoneViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYPhoneViewController.h"
#import "NYNavigationViewController.h"
#import "NYTabBarController.h"

@interface NYPhoneViewController ()
- (IBAction)hungUp;

@end

@implementation NYPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)hungUp {
    NSLog(@"login");
    
    //tabBar 选中第二页
    self.tabBarController.selectedIndex = 2;
    
    //viewController.statusTitle.titleView
//    [self presentViewController:viewController animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
