//
//  ViewController.m
//  登录注册多视图
//
//  Created by sam on 2017/9/5.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "RegViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tvUserName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registerCompletion:)
                                                 name:@"RegisterCompletionNotification"
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)registerCompletion:(NSNotification*)notification {
    NSDictionary *theData = [notification userInfo];
    NSString *username = [theData objectForKey:@"username"];
    NSLog(@"username = %@",username);
    
    self.tvUserName.text = username;
}

//跳转到注册页面
- (IBAction)regClick {
    //获取storyboard
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //根据idnetifier创建ViewContorller
    UIViewController *registerViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"registerViewController"];
    registerViewController.modalTransitionStyle =UIModalTransitionStyleCoverVertical;
    
    //页面跳转
    [self presentViewController:registerViewController animated:YES completion:^{
        NSLog(@"Present Modal View");
    }];
}

@end
