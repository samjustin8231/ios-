//
//  NYGroupTableViewController.m
//  聊天记录
//
//  Created by sam on 2017/9/11.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYGroupTableViewController.h"
#import "NYMessageTableViewController.h"
#import "NYLoginViewController.h"
#import "NYGroup.h"

@interface NYGroupTableViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)createGroup;
- (IBAction)logout;

@end

@implementation NYGroupTableViewController

#pragma mark - 懒加载数据
- (NSArray *)groups{
    if(_groups==nil){
        _groups = [NSMutableArray array];
        
        NYGroup *group1 = [[NYGroup alloc] init];
        group1.groupId = @"123";
        
        NYGroup *group2 = [[NYGroup alloc] init];
        group2.groupId = @"456";
        
        [_groups addObject:group1];
        [_groups addObject:group2];
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
    //获取数据
    NYGroup *groupSelected = self.groups[indexPath.row];
    NSLog(@"select group item:%@",groupSelected.groupId);
    
    UIStoryboard *storboard = self.storyboard;
    NYMessageTableViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"chatRoom"];
    
    //viewController.statusTitle.titleView
    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 按钮点击事件
- (IBAction)createGroup {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"建组" message:@"请输入用户id" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"多个用户id用;分割";
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click canncel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click ok");
        
        //添加数据
        NYGroup *groupModel = [[NYGroup alloc] init];
        groupModel.groupId = alertController.textFields[0].text;
        NSLog(@"data %@",groupModel.groupId);
        [self.groups addObject:groupModel];
        
        //刷新
        [self.tableView reloadData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)logout {
    //跳到登录界面
    NSLog(@"logout");
    
    //弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注销" message:@"确定注销吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click canncel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click ok");
        
        //跳转
        UIStoryboard *storboard = self.storyboard;
        NYLoginViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"loginPager"];
        
        //viewController.statusTitle.titleView
        [self presentViewController:viewController animated:YES completion:nil];

    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    }


@end
