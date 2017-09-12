//
//  NYCall1ViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYCall1ViewController.h"
#import "NYPhoneViewController.h"

@interface NYCall1ViewController ()
- (IBAction)makeCall;

@end

@implementation NYCall1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.tabBarItem.title = @"111";
    //self.navigationItem.title = @"电话";
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

- (IBAction)makeCall {
    NSLog(@"make call");
    
    //跳转
    UIStoryboard *storboard = self.storyboard;
    NYPhoneViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"phonePager"];
    
    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
