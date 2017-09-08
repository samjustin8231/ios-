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

@interface ViewController ()

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
    //设置cell不可选中
    self.tableView.allowsSelection = NO;
    //设置背景颜色，要将cell颜色清空
    self.tableView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1.0];
    //移除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //监听通知中心 监听keyboardChange
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - textField 代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"click return");
    NSString * content = self.inputView.text;
    [self addMessage:content type:NYMessagesModelTypeMe];
    
    return YES;
}

#pragma mark - 其他方法
- (void)addMessage:(NSString *)text type:(NYMessagesModelType)type{
    //data
    NYMessageModel *message = [[NYMessageModel alloc] init];
    message.time = @"23:32";
    message.text = text;
    message.type = type;
    
    //frame
    NYMessageFrameModel *frame = [[NYMessageFrameModel alloc] init];
    frame.message = message;
    
    //add to array
    [self.messageFrames addObject:frame];
    
    //reload
    [self.tableView reloadData];
    
    //清空输入框的内容
    self.inputView.text = @"";
    //scroll to bottom
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(void)keyboardDidChangeFrame:(NSNotification *)noti
{
    //改变window的背景颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //  键盘退出的frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    //键盘实时y
    CGFloat keyY = frame.origin.y;
    
    //屏幕的高度
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //动画时间
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //执行动画
    [UIView animateWithDuration:keyDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
    }];
    
}
@end
