//
//  CZGoodsCell.m
//  UITableView团购
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZGoodsCell.h"

@interface CZGoodsCell()
@property (weak, nonatomic) IBOutlet UIImageView *ivIcon;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbBuyCount;

@end


@implementation CZGoodsCell

- (void)setGoods:(CZGoods *)goods{
    _goods = goods;
    
    self.ivIcon.image = [UIImage imageNamed:goods.icon];
    self.lbTitle.text = goods.title;
    self.lbPrice.text = [NSString stringWithFormat:@"$ %@",goods.price];
    self.lbBuyCount.text = [NSString stringWithFormat:@"%@ 人已经购买",goods.buyCount];
}

+ (CZGoodsCell *)goodsCellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"goods_cell";
    CZGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CZGoodsCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
