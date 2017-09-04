//
//  ViewController.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "CZGoodsCell.h"
#import "CZGoods.h"
#import "CZFooterView.h"
#import "CZHeaderView.h"

@interface ViewController ()<UITableViewDataSource,CZFooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *goods;

@end


@implementation ViewController


#pragma mark - 懒加载数据
- (NSArray *) goods{
    if(_goods==nil){
        NSString * path = [[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil];
        NSArray * arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray * arrayModels = [NSMutableArray arrayWithCapacity:arrayDict.count];
        for (NSDictionary *dict in arrayDict) {
            CZGoods *model = [CZGoods goodsWithDict:dict];
            [arrayModels addObject:model];
        }
        _goods = arrayModels;
    }
    return _goods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.backgroundColor = [UIColor redColor];

    //设置footerView
    CZFooterView *footerView = [CZFooterView footerView];
    //设置代理
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
    
    //设置headerView
    CZHeaderView *headerView = [CZHeaderView headView];
    self.tableView.tableHeaderView = headerView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源代理方法
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取数据模型
    CZGoods *model = self.goods[indexPath.row];
    
    //创建自定义cell
    CZGoodsCell * cell = [CZGoodsCell goodsCellWithTableView:tableView];
    
    //设置数据
    cell.goods = model;
    
    return cell;
}

#pragma mark - FooterView代理方法
- (void)footerViewUpdateData:(CZFooterView *)footerView{
    CZGoods * model = [[CZGoods alloc] init];
    model.title = @"红烧鱼";
    model.price = @"12";
    model.buyCount = @"32";
    
    [self.goods addObject:model];
    [self.tableView reloadData];
    
    //滚动到最后一行
    NSIndexPath * idxPath = [NSIndexPath indexPathForRow:self.goods.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idxPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark - 隐藏状态条
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
