//
//  ViewController.m
//  PicBrowser
//
//  Created by sam on 2017/9/1.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property int curIndex;
@property NSArray * imageArray;

@property (weak, nonatomic) IBOutlet UILabel *tvIndex;
@property (weak, nonatomic) IBOutlet UILabel *tvTitle;
@property (weak, nonatomic) IBOutlet UIImageView *IvImage;

@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIButton *btnPrev;


- (IBAction)pre:(id)sender;
- (IBAction)next:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //NSLog(@"arrys size %d:",[self.imageArray count]);
    
    //从文件中读取plist文件的路径
    NSString * path = [[NSBundle mainBundle] pathForResource:@"pics.plist" ofType:nil];
    NSArray * array = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"count:%ld",array.count);
    NSLog(@"%@",array.description);
    self.imageArray = array;
    
    self.curIndex--;
    [self next:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pre:(id)sender {
    if(self.curIndex==0){
        self.curIndex = (int)(self.imageArray.count-1);
    }else{
        self.curIndex--;
    }

    
    NSDictionary *dict = self.imageArray[self.curIndex];
    self.tvIndex.text = [NSString stringWithFormat:@"%d/%ld",self.curIndex+1,self.imageArray.count];
    self.tvTitle.text = dict[@"title"];;
    self.IvImage.image = [UIImage imageNamed:dict[@"iconName"]];
    
    }

- (IBAction)next:(id)sender {
    
    
    if(self.curIndex==(self.imageArray.count-1)){
        self.curIndex = 0;
    }else{
        self.curIndex++;
    }
    
    NSDictionary *dict = self.imageArray[self.curIndex];
    self.tvIndex.text = [NSString stringWithFormat:@"%d/%ld",self.curIndex+1,self.imageArray.count];
    self.tvTitle.text = dict[@"title"];;
    self.IvImage.image = [UIImage imageNamed:dict[@"iconName"]];
    
    
}
@end
