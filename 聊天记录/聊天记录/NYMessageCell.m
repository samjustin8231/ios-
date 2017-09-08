//
//  NYMessageCell.m
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYMessageCell.h"
#import "NYMessageModel.h"
#import "NYMessageFrameModel.h"
#import "Constant.h"

@interface NYMessageCell ()

//时间
@property (nonatomic, weak) UILabel *timeView;
//正文
@property (nonatomic, weak) UILabel *textView;
//头像
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation NYMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageFrame:(NYMessageFrameModel *)messageFrame{
    _messageFrame = messageFrame;
    //get data model
    NYMessageModel *model = messageFrame.message;
    
    //1.set frame
    //time frame
    _timeView.frame = messageFrame.timeFrame;
    
    //icon frame
    _iconView.frame = messageFrame.iconFrame;
    
    //text frame
    _textView.frame = messageFrame.textFrame;
    
    //2.set data
    //time data
    _timeView.text = model.time;
    
    //icon data
    if(model.type == NYMessagesModelTypeMe){
        self.iconView.image = [UIImage imageNamed:@"Jobs"];
    }else{
        self.iconView.image = [UIImage imageNamed:@"Gatsby"];
    }
    
    //text data
    _textView.text = model.text;
    if(model.type==NYMessagesModelTypeMe){
        [_textView setBackgroundColor:[UIColor colorWithRed:255/255 green:192/255 blue:203/255 alpha:1]];
    }else{
        [_textView setBackgroundColor:[UIColor colorWithRed:127/255 green:255/255 blue:212/255 alpha:1]];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        NYMessageModel *model = self.messageFrame.message;
        
        //1时间
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        time.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:time];
        self.timeView = time;
        
        
        //正文
        UILabel *text = [[UILabel alloc]init];
        text.font = bBtnFont;
        text.numberOfLines = 0;//自动换行
//        text.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);//设置按钮文字的内边距
        
        [self.contentView addSubview:text];
        self.textView = text;
        
        //头像
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.iconView = icon;
    }
    return self;
}

+(instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"messageCell";
    NYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
@end
