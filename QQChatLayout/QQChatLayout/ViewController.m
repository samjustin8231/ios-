//
//  ViewController.m
//  QQChatLayout
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"

@interface ViewController ()
@property(nonatomic,strong) NSMutableArray * messagesFrame;
@end

@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)messagesFrame{
    if(_messagesFrame==nil)
    {
        //plist数据路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        for (NSDictionary *dict in arrayDict) {
            //
            CZMessage *model = [CZMessage messageWithDict:dict];
            //创建frame
            CZMessageFrame *modelFrame = [[CZMessageFrame alloc] init];
            modelFrame.message = model;
            
            [arrayModels addObject:modelFrame];
        }
        _messagesFrame = arrayModels;
    }
    return _messagesFrame;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
