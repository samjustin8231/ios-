//
//  ViewController.m
//  UITableViewDemo
//
//  Created by sam on 2017/9/3.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "ViewController.h"
#import "NJHero.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *heros;
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
- (NSArray *)heros{
    if (_heros == nil) {
        // 1.获得全路径
        NSString *fullPath =  [[NSBundle mainBundle] pathForResource:@"heros" ofType:@"plist"];
        // 2.更具全路径加载数据
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        // 3.字典转模型
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:dictArray.count];
        for (NSDictionary *dict in dictArray) {
            NJHero *hero = [NJHero heroWithDict:dict];
            [models addObject:hero];
        }
        // 4.赋值数据
        _heros = [models copy];    }
    // 3.返回数组
    return _heros;
}

#pragma mark - UITableViewDataSource协议的方法
/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 1;
}
/**
 *  2.第section组有多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heros.count;
}
/**
 *  3.告知系统每一行显示什么内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    NJHero * hero = self.heros[indexPath.row];
    
    cell.textLabel.text = hero.name;
    cell.detailTextLabel.text = hero.intro;
    cell.imageView.image = [UIImage imageNamed:hero.icon];
    
    // 2.3设置cell的辅助视图
    // cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    if (0 == indexPath.row) {
        cell.accessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }else
    {
        cell.accessoryView = [[UISwitch alloc] init];
    }
    //    UIButton *btn = [[UIButton alloc] init];
    //    btn.backgroundColor = [UIColor redColor];
    //    cell.accessoryView = btn;
    
    
    // 2.4设置cell的背景颜色
    cell.backgroundColor = [UIColor blueColor];
    
    // 设置选中状态的背景
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor purpleColor];
    cell.selectedBackgroundView = view2;
    
    // 3.返回要显示的控件
    return cell;
    
}

#pragma mark 隐藏statusBar
- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
