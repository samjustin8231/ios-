//
//  NYGroupTableViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYGroupTableViewController.h"
#import "ViewController.h"
#import "NYGroup.h"

@interface NYGroupTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;

@end

@implementation NYGroupTableViewController

- (NSArray *)groups{
    if(_groups==nil){
        NYGroup *group1 = [[NYGroup alloc] init];
        group1.groupId = @"123";
        
        NYGroup *group2 = [[NYGroup alloc] init];
        group2.groupId = @"456";
        
        _groups = @[group1,group2];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource显示方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NYGroup *groupModel = self.groups[indexPath.row];
    cell.textLabel.text = groupModel.groupId;
    return cell;
}

#pragma mark - tableView 交互方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click group cell");
//    ViewController *viewController = [[ViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    //获取数据
    NYGroup *groupSelected = self.groups[indexPath.row];
    
    UIStoryboard *storboard = self.storyboard;
    ViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"chatRoom"];
    
    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
