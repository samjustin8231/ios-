//
//  NYMessageModel.h
//  聊天记录
//
//  Created by sam on 2017/9/8.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

//定义结构体NYMessagesModelType


@interface NYMessageModel : NSObject


@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;

/**发送类型*/
@property (nonatomic, assign) NYMessagesModelType type;
/**是否隐藏时间*/
@property (nonatomic, assign) BOOL hideTime;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *)dict;

@end
