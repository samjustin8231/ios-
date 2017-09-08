//
//  CZWeiboFrame.m
//  微博
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "CZWeiboFrame.h"
#import "CZWeibo.h"


#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

@implementation CZWeiboFrame

//重写weibo的set方法同时设置控件的frame
- (void)setWeibo:(CZWeibo *)weibo{
    _weibo = weibo;
    
    //提取统一的间距
    CGFloat margin = 10;
    //1.头像
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //2.昵称
    // 获取昵称字符串
    NSString *nickName = weibo.name;
    // 根据Label中文字的内容，动态计算Label的高和宽
    CGSize nameSize = [self sizeWithText:nickName andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:nameFont];
    
    CGFloat nameX = CGRectGetMaxX(_iconFrame) +margin;
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    CGFloat nameY = iconY + (iconH - nameH)/2;
    _nameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //3.会员
    CGFloat vipW = 10;
    CGFloat vipH = 10;
    CGFloat vipX = CGRectGetMaxX(_nameFrame) + margin;
    CGFloat vipY = nameY;
    _vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    //4.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconFrame) +margin;
    CGSize textSize = [self sizeWithText:weibo.text andMaxSize:CGSizeMake(355, MAXFLOAT) andFont:textFont];

    CGFloat textW = textSize.width;
    CGFloat textH = textSize.height;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    
    //5.配图
    CGFloat picW = 100;
    CGFloat picH = 100;
    CGFloat picX = iconX;
    CGFloat picY = CGRectGetMaxY(_textFrame) + margin;
    _picFrame = CGRectMake(picX, picY, picW, picH);
    
    //6.计算设置每行行高
    if (self.weibo.picture) {
        self.rowHeight = CGRectGetMaxY(_picFrame) + margin;
    }
    else
    {
        self.rowHeight = CGRectGetMaxY(_textFrame) +margin;
    }
}

- (CGSize) sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}


@end
