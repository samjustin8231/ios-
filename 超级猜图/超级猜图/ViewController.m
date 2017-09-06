//
//  ViewController.m
//  超级猜图
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "CZQuestion.h"

@interface ViewController ()

//数据
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, assign) int curIndex;//当前question index

@property (weak, nonatomic) IBOutlet UILabel *lbIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UIView *viewAnswer;
@property (weak, nonatomic) IBOutlet UIView *viewOptions;


- (IBAction)btnNextClick;


@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.curIndex = -1;
    [self nextQuestion];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (NSArray *)questions{
    if(_questions==nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        for (NSDictionary *dict in arrayDict) {
            CZQuestion *model = [CZQuestion questionWithDick:dict];
            [arrayModels addObject:model];
        }
        _questions = arrayModels;
    }
    return _questions;
}

#pragma mark - 状态栏设置
//改变状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 点击action
- (IBAction)btnNextClick {
    NSLog(@"click");
    [self nextQuestion];
}

- (void)nextQuestion{
    self.curIndex++;
    
    //获取数据
    CZQuestion * model = self.questions[self.curIndex];
    
    //设置数据
    [self setData:model];
    
    //动态生成答案对应的button
    [self dynamicCreateAnswerButtons:model];
    
    //动态生成备选答案
    [self dynamicCreateOptionAnswerButtons:model];
}

#pragma mark - 其他方法
- (void)setData:(CZQuestion *)model{
    //显示题目
    self.lbIndex.text = [NSString stringWithFormat:@"%d / %ld",self.curIndex+1,self.questions.count];
    self.lbTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    
    //最后一题不可用
    self.btnNext.enabled = (self.curIndex != self.questions.count -1 );

}

- (void)dynamicCreateAnswerButtons:(CZQuestion *)model{
    CGFloat answerViewWidth = self.viewAnswer.frame.size.width;
    CGFloat answerButtonWidth = 35;
    CGFloat answerButtonHeight = 35;
    CGFloat buttonMargin = 10;
    
    //清空原有控件
    for (UIView *bbtn in self.viewAnswer.subviews) {
        [bbtn removeFromSuperview];
    }
    
    //动态生成答案对应的button
    int length = model.answer.length;
    CGFloat startX = (answerViewWidth - length*answerButtonWidth - (length-1)*buttonMargin)*0.5;//答案按钮开始
    
    for (int i=0; i<length; i++) {
        CGFloat x = startX + i*(answerButtonWidth + buttonMargin);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, answerButtonWidth, answerButtonHeight)];
        //设置背景
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bn_answer_highlighted" ] forState:UIControlStateHighlighted];
        
        [self.viewAnswer addSubview:btn];
    }
}

- (void)dynamicCreateOptionAnswerButtons:(CZQuestion *)model{
    CGFloat answerViewWidth = self.viewAnswer.frame.size.width;
    CGFloat answerButtonWidth = 35;
    CGFloat answerButtonHeight = 35;
    CGFloat buttonMargin = 10;
    int columns = 7;
    
    //清空
    [self.viewOptions.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat startX = (answerViewWidth - columns*answerButtonWidth - (columns-1)*buttonMargin)*0.5;//答案按钮开始
    
    NSArray *options = model.options;
    for (int i=0; i<options.count; i++) {
        
        int row = i/columns;
        int col = i%columns;
        CGFloat x = startX + col*(answerButtonWidth + buttonMargin);
        CGFloat y = row*(answerButtonHeight+buttonMargin);
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:options[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y, answerButtonWidth, answerButtonHeight);
        
        //设置背景
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bn_option_highlighted" ] forState:UIControlStateHighlighted];
        
        [self.viewOptions addSubview:btn];

    }
}

@end
