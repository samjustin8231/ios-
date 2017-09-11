//
//  NYLoginViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYLoginViewController.h"
#import "NYNavigationViewController.h"
#import "NYGroupTableViewController.h"


@interface NYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)getCode;

- (IBAction)login;

@end

@implementation NYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getCode {
}

- (IBAction)login {
    NSLog(@"login");
    
    //跳转
    UIStoryboard *storboard = self.storyboard;
    NYNavigationViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"navigationView1"];
    
    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
    
}
@end
