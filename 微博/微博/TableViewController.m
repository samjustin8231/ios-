//
//  TableViewController.m
//  微博
//
//  Created by sam on 2017/9/7.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "TableViewController.h"
#import "CZWeibo.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 懒加载数据
- (NSArray *)weiboFrames{
    if (!_weiboFrames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"weibos.plist" ofType:nil];
        NSArray *arrDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrModel = [NSMutableArray array];
        
        for (NSDictionary *dict in arrDict) {
            //创建数据模型
            CZWeibo *modelData = [CZWeibo weiboWithDict:dict];
            
            CZWeiboFrame *modelFrame = [[CZWeiboFrame alloc] init];
            
            modelFrame.weibo = modelData;
            
            [arrModel addObject:modelFrame];
        }
        _weiboFrames = arrModel;
    }
    return _weiboFrames;}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.weiboFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据
    CZWeiboFrame *weiboFrame = self.weiboFrames[indexPath.row];
    
    //创建cell
    TableViewCell * cell = [TableViewCell cellWithTableView:tableView];
    
    //设置数据
    cell.weiboFrame = weiboFrame;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZWeiboFrame * frame = self.weiboFrames[indexPath.row];
    return frame.rowHeight;
}

#pragma mark - 其他方法
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
