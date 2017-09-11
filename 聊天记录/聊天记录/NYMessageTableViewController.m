//
//  ViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/6.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYMessageTableViewController.h"

#import "NYMessageCell.h"
#import "NYMessageModel.h"
#import "NYMessageFrameModel.h"

@interface NYMessageTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;


- (IBAction)sendText;

- (IBAction)setOnlineOrOffline:(id)sender;

@end

@implementation NYMessageTableViewController

#pragma mark - 懒加载数据
- (NSMutableArray *)messageFrames{
    if(_messageFrames==nil){
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

    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"ViewContoller viewDidLoad");
    
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
    //如果内容为空，那么就直接返回
    if (text == nil) {
        return ;
    }
    //1，添加模型数据
    NYMessageModel *message = [[NYMessageModel alloc]init];
    //设置数据的值
    NSString *curTime = [self getCurrentTime];
    message.time = curTime;
    message.text = text;
    message.type = type;
    //设置内容的frame
    NYMessageFrameModel * fm = [[NYMessageFrameModel alloc]init];
    //将模型设置给frame
    fm.message = message;
    
    //添加到数值
    [self.messageFrames addObject:fm];
    
    //2,刷新表格
    [self.tableView reloadData];
    //关闭键盘
    [self scrollViewWillBeginDragging:self.tableView];
    //清空输入框的内容
    self.inputView.text = @"";
    
    //3,自动上移
    //移动的位置
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    //真正去的位置 atatScrollPosition ：滚到得位置
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
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

-(NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
//    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    [formatter setDateFormat:@"hh:mm"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}

#pragma mark - 按钮事件
- (IBAction)sendText {
    NSLog(@"send text click");
    
    NSString * content = self.inputView.text;
    
    [self addMessage:content type:NYMessagesModelTypeMe];
}

- (IBAction)setOnlineOrOffline:(id)sender {
    UISwitch *btnSwitch = (UISwitch *)sender;
    BOOL isOn = [btnSwitch isOn];
    if(isOn){
        
    }else{
        
    }
}
@end
