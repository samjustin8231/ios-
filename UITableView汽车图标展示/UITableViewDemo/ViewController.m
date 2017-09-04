//
//  ViewController.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "NJCar.h"
#import "NJCarsGroup.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *cars;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (NSArray *)cars{
    if (_cars==nil) {
        
        NSString *fullpath= [[NSBundle mainBundle]pathForResource:@"cars.plist" ofType:nil];
        NSArray  *arrayM=[NSArray arrayWithContentsOfFile:fullpath];
        
        NSMutableArray *carsarray=[NSMutableArray array];
        for (NSDictionary  *dict in arrayM) {
            NJCarsGroup *carsgroup=[NJCarsGroup carsGroupWithDict:dict];
            [carsarray addObject:carsgroup];
        }
        _cars=[carsarray copy];
    }
    return _cars;
}

#pragma mark - UITableViewDataSource协议的方法
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return self.cars.count;
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NJCarsGroup * carsGroup = self.cars[section];
    return carsGroup.cars.count;
}
/**
 *  3.告知系统每一行显示什么内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"car";
    //4.1去缓存中去取cell
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    //4.2若没有，则创建cell,并盖章
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    //4.3设置cell的数据
    //设置对应的组
    NJCarsGroup *carsgroup=self.cars[indexPath.section];
    //设置对应的行
    NJCar *yycars=carsgroup.cars[indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:yycars.icon];
    cell.textLabel.text=yycars.name;
    //4.4返回cell
    return cell;
    
}

//设置每组的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NJCarsGroup *carsgroup=self.cars[section];
    return carsgroup.title;
}

//设置索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //利用kvc取出所有的标题
    NSArray *title=[self.cars valueForKeyPath:@"title"];
    return title;
}


#pragma mark 隐藏statusBar
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
