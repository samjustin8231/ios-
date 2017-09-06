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

@property (nonatomic, assign) int numEmptyAnswer;//


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

-(void)answerButtonClick:(UIButton *)sender{
    
    //在options中找到自己的位置并show
    for (UIButton *btn in self.viewOptions.subviews) {
//        if([[sender currentTitle] isEqualToString:[btn currentTitle]]){
//            NSLog(@"currentTitle:%@",[btn currentTitle]);
//            btn.hidden = NO;
//            break;
//        }
        if(sender.tag == btn.tag){
            btn.hidden = NO;
            self.numEmptyAnswer++;
            break;
        }
    }
    
    //点击的文字清空
    [sender setTitle:nil forState:UIControlStateNormal];
    [self setAnswerButtonsColor:[UIColor blackColor]];//恢复颜色
}

-(void)optionButtonClick:(UIButton *)sender{
    NSLog(@"option button click");
    
    //满了将不可点击
    BOOL isFull = YES;
    for (UIButton * btnAnswer in self.viewAnswer.subviews) {
        if([btnAnswer currentTitle].length==0){
            isFull = NO;
            break;
        }
    }
    if(isFull){
        return;
    }
    
    BOOL isFull1 = YES;
    //隐藏当前的
    sender.hidden = YES;
    NSString *optionTitle = [sender currentTitle];
    NSLog(@"title: %@",optionTitle);
    
    //显示到答案区第一个nil的地方
    NSMutableString *inputAnswer = [NSMutableString string];
    CZQuestion *model = self.questions[self.curIndex];
    NSLog(@"model:%@",model);
    for (UIButton * btnAnswer in self.viewAnswer.subviews) {
        
        if([btnAnswer currentTitle].length==0){
            [btnAnswer setTitle:optionTitle forState:UIControlStateNormal];
            btnAnswer.tag = sender.tag;//设置tag
            
            self.numEmptyAnswer--;
            NSLog(@"numEmptyAnswer:%i",self.numEmptyAnswer);
            
            //判断答案
            if(self.numEmptyAnswer==0){
                for (UIButton *btn in _viewAnswer.subviews) {
                    [inputAnswer appendString:btn.currentTitle];
                }
                
                NSLog(@"inputAnswer:%@",inputAnswer);
                if([model.answer isEqualToString:inputAnswer]){//正确
                    [self setAnswerButtonsColor:[UIColor blueColor]];
                    
                    //1s进入下一题
                    [self performSelector:@selector(nextQuestion) withObject:nil afterDelay:1];
                }else{
                    [self setAnswerButtonsColor:[UIColor redColor]];
                }
            }
            
            break;
        }
        
        
        
    }
    
    
    
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
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置背景
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bn_answer_highlighted" ] forState:UIControlStateHighlighted];
        
        [self.viewAnswer addSubview:btn];
        
        //添加点击事件
        [btn addTarget:self action:@selector(answerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.numEmptyAnswer = self.viewAnswer.subviews.count;//空答案的数目
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
        btn.tag = i;//设置tag
        [btn setTitle:options[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, y, answerButtonWidth, answerButtonHeight);
        
        //设置背景
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bn_option_highlighted" ] forState:UIControlStateHighlighted];
        
        [self.viewOptions addSubview:btn];

        //按钮添加点击事件
        [btn addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)setAnswerButtonsColor:(UIColor *)color{
    for (UIButton *btn in self.viewAnswer.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

@end
