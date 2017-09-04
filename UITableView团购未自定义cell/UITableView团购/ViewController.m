//
//  ViewController.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "CZGoods.h"

@interface ViewController ()<UITableViewDataSource>

@property (nonatomic, strong) NSArray *goods;

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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//
//}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CZGoods *model = self.goods[indexPath.row];
    
    static NSString * ID = @"goods_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:model.icon];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$ %@   %@人已经购买",model.price,model.buyCount];
    
    return cell;
}

#pragma mark - 隐藏状态条
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
