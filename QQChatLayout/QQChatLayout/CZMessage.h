//
//  CZMessage.h
//  QQChatLayout
//
//  Created by sam on 2017/9/4.
//  Copyright © 2017年 sam. All rights reserved.
//

#import <Foundation/Foundation.h>

//枚举类型
typedef enum {
    CZMessageTypeMe = 0,
    CZMessageTypeOther = 1
}CZMessageType;

@interface CZMessage : NSObject

@property(nonatomic,copy) NSString * text;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,assign) CZMessageType type;

- (CZMessage *)initWithDict:(NSDictionary *)dict;
+ (CZMessage *)messageWithDict:(NSDictionary *)dict;
@end
