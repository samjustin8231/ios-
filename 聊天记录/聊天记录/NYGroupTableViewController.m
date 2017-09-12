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
#import "Constant.h"
#import "NYUtils.h"

@interface NYGroupTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray * number;//保存要展示的数字

- (IBAction)createGroup;
- (IBAction)logout;

@end

@implementation NYGroupTableViewController

#pragma mark - 懒加载数据
- (NSArray *)groups{
    if(_groups==nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"groups.plist" ofType:nil];
//        NSLog(@"path:%@",path);
        
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"count of group:%ld",arrayDict.count);
        
        NSMutableArray *arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        
        for (NSDictionary *dict in arrayDict) {
            NYGroup *model = [NYGroup groupWithDict:dict];
            [arrayModels addObject:model];
        }
        _groups = arrayModels;
    }
    //NSLog(@"groups count:%ld",_groups.count);
    return _groups;
}

- (void)viewDidLoad {
    NSLog(@"NYGroupTableVC view did load");
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

#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 按钮点击事件
- (IBAction)createGroup {
//    NYGroupType groupType;
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *createGroupAction = [UIAlertAction actionWithTitle:@"创建组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        groupType = NYGroupTypeGroup;
        [self alertForCreateGroup];
    }];
    
    UIAlertAction *createChatRoom = [UIAlertAction actionWithTitle:@"创建聊天室" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        groupType = NYGroupTypeChatRoom
        [self alertForCreateGroup];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionSheetController addAction:cancelAction];
    [actionSheetController addAction:createChatRoom];
    [actionSheetController addAction:createGroupAction];
    
    [self presentViewController:actionSheetController animated:YES completion:nil];
    
    
    
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
        
        //clear data
        [NYUtils setUserId:@""];
        [NYUtils setNumber:@""];
        
        //关闭页面
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
    
    
    }

# pragma mark - 其他方法
-(void)loadData
{
    
}

-(void)alertForCreateGroup{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"建组" message:@"请输入用户id" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"多个用户id用;分割";
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click canncel");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"click ok");
        
        NSString *userIds = alertController.textFields[0].text;
        NSMutableArray *uIdArray = [NSMutableArray array];
        //自己
        [uIdArray addObject:[NYUtils userId]];
        
        if(![NYUtils isNullOfString:userIds]){
            
            //其他的userIds
            [uIdArray addObjectsFromArray:[userIds componentsSeparatedByString:@";"]];
        }
        
        NSLog(@"user count:%ld",uIdArray.count);
        
        //添加数据
        NYGroup *groupModel = [[NYGroup alloc] init];
        groupModel.groupId = alertController.textFields[0].text;
        
        for (NSString *uid in uIdArray) {
            NSLog(@"per user. uid:%@",uid);
            NYUser *user = [[NYUser alloc] init];
            user.uId = uid;
            user.isOnline = NO;
            
            [groupModel.users addObject:user];
            
        }
        
        NSLog(@"groupModel:%@,users count:%ld",groupModel,groupModel.users.count);
        [self.groups addObject:groupModel];
        
        //刷新
        [self.tableView reloadData];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
