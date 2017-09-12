//
//  Constant.h
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#endif /* Constant_h */

#pragma mark - 尺寸
//#define bScreenWidth [[UIScreen mainScreen] bounds].size.width
#define bScreenWidth 375

#define bNormalH 44

#define bIconW 50

#define bIconH 50



#pragma mark - 字体
#define bBtnFont [UIFont systemFontOfSize:15.0f]

#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]




typedef enum {
    NYMessagesModelTypeMe = 0,//自己
    NYMessagesModelTypeOther = 1, //别人
    NYMessagesModelTypeSystem = 2 //系统消息
}NYMessagesModelType;

typedef enum {
    NYGroupTypeGroup = 0,
    NYGroupTypeChatRoom = 1,
    NYGroupType1V1 = 2
}NYGroupType;
