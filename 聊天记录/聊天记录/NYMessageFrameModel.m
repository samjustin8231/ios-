//
//  NYMessageFrameModel.m
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import "NYMessageFrameModel.h"
#import "Constant.h"

@implementation NYMessageFrameModel


- (void)setMessage:(NYMessageModel *)message{
    _message = message;
    
    //计算frame
    CGFloat padding = 10;
    
    //time frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeWidth = 0;
    CGFloat timeHeight = bNormalH;
    CGSize timeSize = [self sizeWithText:message.time andMaxSize:CGSizeMake(355, MAXFLOAT) andFont:textFont];
    timeWidth = timeSize.width;
    timeX = (bScreenWidth - timeSize.width)/2;
    if(!message.hideTime){
        _timeFrame = CGRectMake(timeX, timeY, timeWidth, timeHeight);
    }
    
    //icon frame
    CGFloat iconX = 0;
    CGFloat iconY = CGRectGetMaxY(_timeFrame)+padding;
    CGFloat iconWidth = bIconW;
    CGFloat iconHeight = bIconH;
    if(message.type== NYMessagesModelTypeMe){//发送方在右边
        iconX = bScreenWidth - padding - iconWidth;
    }else{
        iconX = padding;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    //text frame
    CGFloat textX = 0;
    CGFloat textY = iconY;
    CGSize texSize = [self sizeWithText:message.text andMaxSize:CGSizeMake(355, MAXFLOAT) andFont:textFont];
    if(message.type == NYMessagesModelTypeMe){//发送方在右边
        textX = bScreenWidth - (padding + iconWidth + padding + texSize.width);
    }else{
        
        textX = padding + iconWidth + padding;
    }
    _textFrame = CGRectMake(textX, textY, texSize.width, texSize.height);
    
    //计算rowHeight
    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    _rowHeight = MAX(iconMaxY, textMaxY);
}


//根据给定的字符串、最大值size、给定的字体、来计算文字应该占用的大小

/**
 *  计算文字的尺寸
 *
 *  @param text    所要计算的文字
 *  @param maxSize 规定的文字尺寸范围,一般直限制宽度,而不限制高度
 *  @param font    计算文字时所用的字体"计算时用的字体大小,要和显示时的字体一样"
 *
 *  @return 计算出来的文字尺寸
 */
- (CGSize) sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font
{
    NSDictionary *attr = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

@end
