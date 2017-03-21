//
//  GQAnnouncementModel.h
//  Investment
//
//  Created by mac on 15/7/30.
//
//

#import <Foundation/Foundation.h>

@interface GQAnnouncementModel : NSObject

//主键
@property (nonatomic, assign) NSInteger                         AnnouncementId;
//标题
@property (nonatomic, strong) NSString                          *title;
//发送时间
@property (nonatomic, strong) NSString                          *sendTime;
//内容
@property (nonatomic, strong) NSString                          *content;
//状态（0：未读，1：已读）
@property (nonatomic, assign) NSInteger                         state;

@end


