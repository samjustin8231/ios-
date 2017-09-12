//
//  NYCall1ViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYCall1ViewController.h"
#import "NYPhoneViewController.h"
#import "NYUtils.h"



@interface NYCall1ViewController ()
- (IBAction)makeCall;

@end

@implementation NYCall1ViewController

-(void)viewDidAppear:(BOOL)animated{
    if(![NYUtils isNullOfString:NYUtils.toNumber]){
        
    }else{
        self.inputNumber.text = @"";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"NYCall1ViewController view did load");
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

#pragma mark - button click
- (IBAction)makeCall {
    NSLog(@"make call");
    
    if([NYUtils isNullOfString:self.inputNumber.text]){
        return;
    }
    
    //跳转
    UIStoryboard *storboard = self.storyboard;
    NYPhoneViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"phonePager"];
    
    //save toNumber
    NYUtils.toNumber = self.inputNumber.text;
    
    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)digitClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *content = [btn currentTitle];
    
    NSMutableString *origin = [[NSMutableString alloc] initWithString:self.inputNumber.text];
    
    [origin appendString:content];
    self.inputNumber.text = origin;
}
@end
