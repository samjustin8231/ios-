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
#import "NYUtils.h"

@interface NYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfUserId;

@property (weak, nonatomic) IBOutlet UITextField *tfCode;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

- (IBAction)getCode;

- (IBAction)login;

@end

@implementation NYLoginViewController

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    
    if([NYUtils isNullOfString:[NYUtils userId]]){
        self.tfUserId.text = @"";
        self.tfNumber.text = @"";
    }
}

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
    
    NSString *sUID = self.tfUserId.text;
    NSString *sNumber = self.tfNumber.text;
    NSLog(@"uid:%@ \nnumber:%@",sUID,sNumber);
    
    if(sUID==nil||sUID.length==0||sNumber==nil||sNumber.length==0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入user和number" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"click canncel");
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //save number and userId
    self.number = self.tfNumber.text;
    
    [NYUtils setUserId:self.tfUserId.text];
    [NYUtils setNumber:self.tfNumber.text];
//    userId = [NSString stringWithFormat:@"userId:%@ number:%@",self.tfUserId.text,self.tfNumber.text];
    
    //跳转
    UIStoryboard *storboard = self.storyboard;
    NYNavigationViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"navigationView1"];

    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
}
@end
