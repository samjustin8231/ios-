//
//  ViewController.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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


#pragma mark - UITableViewDataSource协议的方法
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 2;
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (0 == section) {
        // 第0组有多少行
        return 2;
    }else
    {
        // 第1组有多少行
        return 3;
    }
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
    
    // 2.设置数据
    // cell.textLabel.text = @"汽车";
    // 判断是第几组的第几行
    if (0 == indexPath.section) { // 第0组
        if (0 == indexPath.row) // 第0组第0行
        {
            cell.textLabel.text = @"奥迪";
        }else if (1 == indexPath.row) // 第0组第1行
        {
            cell.textLabel.text = @"宝马";
        }
        
    }else if (1 == indexPath.section) // 第1组
    {
        if (0 == indexPath.row) { // 第0组第0行
            cell.textLabel.text = @"本田";
        }else if (1 == indexPath.row) // 第0组第1行
        {
            cell.textLabel.text = @"丰田";
        }else if (2 == indexPath.row) // 第0组第2行
        {
            cell.textLabel.text = @"马自达";
        }
    }
    
    // 3.返回要显示的控件
    return cell;
    
}
/**
 *  第section组头部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // return @"标题";
    if (0 == section) {
        return @"德系品牌";
    }else
    {
        return @"日韩品牌";
    }
}
/**
 *  第section组底部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (0 == section) {
        return @"高端大气上档次";
    }else
    {
        return @"还不错";
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
