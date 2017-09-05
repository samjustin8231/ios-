//
//  ViewController.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "NJCarGroup.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *carGroups;
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
- (NSArray *)carGroups{
    if (_carGroups == nil) {
        // 1.创建模型
        NJCarGroup *cg1 = [[NJCarGroup alloc] init];
        cg1.title = @"德系品牌";
        cg1.desc = @"高端大气上档次";
        cg1.cars = @[@"奥迪", @"宝马"];
        
        NJCarGroup *cg2 = [[NJCarGroup alloc] init];
        cg2.title = @"日韩品牌";
        cg2.desc = @"还不错";
        cg2.cars = @[@"本田", @"丰田", @"小田田"];
        
        NJCarGroup *cg3 = [[NJCarGroup alloc] init];
        cg3.title = @"欧美品牌";
        cg3.desc = @"价格昂贵";
        cg3.cars = @[@"劳斯莱斯", @"布加迪", @"小米"];
        // 2.将模型添加到数组中
        _carGroups = @[cg1, cg2, cg3];
    }
    // 3.返回数组
    return _carGroups;
}

#pragma mark - UITableViewDataSource协议的方法
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return self.carGroups.count;
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NJCarGroup * carGroup = self.carGroups[section];
    return carGroup.cars.count;
}
/**
 *  3.告知系统每一行显示什么内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //    indexPath.section; // 第几组
    //    indexPath.row; // 第几行
    // 1.创建cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NJCarGroup * carGroup = self.carGroups[indexPath.section];
    NSString * carName = carGroup.cars[indexPath.row];
    cell.textLabel.text = carName;
    
    // 3.返回要显示的控件
    return cell;
    
}
/**
 *  第section组头部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NJCarGroup * carGroup = self.carGroups[section];
    return carGroup.title;
}
/**
 *  第section组底部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NJCarGroup * carGroup = self.carGroups[section];
    return carGroup.desc;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondViewController *viewController = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 其他方法
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
