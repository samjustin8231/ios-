//
//  ViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/6.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "NYMessageCell.h"
#import "NYMessageModel.h"
#import "NYMessageFrameModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;


@end

@implementation ViewController

#pragma mark - 懒加载数据
- (NSMutableArray *)messageFrames{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NYMessageFrameModel * messageFrame = [[NYMessageFrameModel alloc] init];
        //这时候 arrayM中得最后一个就是前一个。
        NYMessageFrameModel *lastFrame = [arrayM lastObject];
        //当前要加进去的Frame
        NYMessageModel *message =[NYMessageModel messageWithDict:dict];
        message.hideTime = [message.time isEqualToString:lastFrame.message.time];
        
        messageFrame.message = message;
        
        [arrayM addObject:messageFrame];
    }
    _messageFrames = arrayM;
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView数据方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NYMessageCell * cell = [NYMessageCell messageCellWithTableView:tableView];
    NYMessageFrameModel *messageFrame = self.messageFrames[indexPath.row];
    
    cell.messageFrame = messageFrame;
    return cell;
}

#pragma mark - tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.messageFrames[indexPath.row] rowHeight];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
