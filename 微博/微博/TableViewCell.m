//
//  TableViewCell.m
//  微博
//
//  Created by sam on 2017/9/7.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *nameView;
@property(nonatomic,weak) UIImageView *vipView;
@property(nonatomic,weak) UILabel *textView;
@property(nonatomic,weak) UIImageView *pictureView;
@end

@implementation TableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconView=[[UIImageView alloc]init];
        [self.contentView addSubview:iconView];
        self.iconView=iconView;
        
        UILabel *nameView=[[UILabel alloc]init];
        nameView.font=[UIFont systemFontOfSize:14];
        [self.contentView addSubview:nameView];
        self.nameView=nameView;
        
        UIImageView *vipView=[[UIImageView alloc]init];
        vipView.image=[UIImage imageNamed:@"vip"];
        [self.contentView addSubview:vipView];
        self.vipView=vipView;
        
        UILabel *textView=[[UILabel alloc]init];
        textView.font=[UIFont systemFontOfSize:15];
        textView.numberOfLines=0;
        [self.contentView addSubview:textView];
        self.textView=textView;
        
        UIImageView *pictureView=[[UIImageView alloc]init];
        [self.contentView addSubview:pictureView];
        self.pictureView=pictureView;
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *ID= @"weiboCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setWeiboFrame:(CZWeiboFrame *)weiboFrame{
    _weiboFrame = weiboFrame;
    [self setData];
    [self setFrame];
}


#pragma mark - 其他方法
- (void)setData{
    CZWeibo *weibo = self.weiboFrame.weibo;
    self.iconView.image = [UIImage imageNamed:weibo.icon];
    self.nameView.text = weibo.name;
    if(weibo.vip){
        self.vipView.hidden = NO;
    }else{
        self.vipView.hidden = YES;
    }
    self.textView.text = weibo.text;
    if(weibo.picture){
        self.pictureView.hidden = NO;
        self.pictureView.image = [UIImage imageNamed:weibo.picture];
    }else{
        self.pictureView.hidden = YES;
    }
}

-(void)setFrame{
    self.iconView.frame = self.weiboFrame.iconFrame;
    self.nameView.frame = self.weiboFrame.nameFrame;
    if(self.weiboFrame.weibo.vip){
        self.vipView.frame = self.weiboFrame.vipFrame;
    }
    self.textView.frame = self.weiboFrame.textFrame;
    if(self.weiboFrame.weibo.picture){
        self.pictureView.frame = self.weiboFrame.picFrame;
    }
}

@end
