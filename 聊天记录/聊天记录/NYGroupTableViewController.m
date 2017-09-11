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
#import "NYUser.h"

@interface NYGroupTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)NSArray * groupsType;//
@property (nonatomic,strong)NSArray * number;//保存要展示的数字



- (IBAction)createGroup;
- (IBAction)logout;

@end

@implementation NYGroupTableViewController

#pragma mark - 懒加载数据
- (NSArray *)groups{
    if(_groups==nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"groups.plist" ofType:nil];
        NSLog(@"path:%@",path);
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"count of group:%ld",arrayDict.count);
        
        NSMutableArray *arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        for (NSDictionary *dict in arrayDict) {
            NYGroup *model = [NYGroup groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    NSLog(@"groups count:%ld",_groups.count);
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取需要展示的数据
    [self loadData];
    
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NYGroup *groupModel = self.groups[indexPath.row];
    cell.textLabel.text = groupModel.groupId;
    NSString *count = [NSString stringWithFormat:@"(%ld)",groupModel.users.count];
    cell.detailTextLabel.text = count;
    return cell;
}

#pragma mark tableView 交互方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    NYGroup *groupSelected = self.groups[indexPath.row];
    NSLog(@"select group item:%@",groupSelected.groupId);
    
    UIStoryboard *storboard = self.storyboard;
    NYMessageTableViewController *viewController = [storboard instantiateViewControllerWithIdentifier:@"chatRoom"];
    viewController.groupId = groupSelected.groupId;
    //viewController.statusTitle.titleView
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.groupsType.count;//根据数组的元素个数返回几行数据
            break;
            
        default:
            break;
    }
    
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.groupsType[row];
            break;
        
        default:
            break;
    }
    
    return title;
}


#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 按钮点击事件
- (IBAction)createGroup {
    
    // 初始化pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
    [self.view addSubview:self.pickerView];
    
    // 显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    //指定数据源和委托
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"建组" message:@"请输入用户id" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        
//        textField.placeholder = @"多个用户id用;分割";
//    }];
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"click canncel");
//    }];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"click ok");
//        
//        //添加数据
//        NYGroup *groupModel = [[NYGroup alloc] init];
//        groupModel.groupId = alertController.textFields[0].text;
//        NSLog(@"data %@",groupModel.groupId);
//        [self.groups addObject:groupModel];
//        
//        //刷新
//        [self.tableView reloadData];
//    }];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
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
    
    //关闭页面
//    [self presentViewController:alertController animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
    }

# pragma mark - 其他方法
-(void)loadData
{
    //需要展示的数据以数组的形式保存
    self.groupsType = @[@"普通群组",@"聊天室"];
}


@end
