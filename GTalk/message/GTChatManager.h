//
//  GTChatManager.h
//  GTalk
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 banwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQMessage.h"

@protocol GTChatManagerDelagete <NSObject>

- (void)didConnected;

- (void)didReceiveMessage:(GQMessage *)message;

@end

@interface GTChatManager : NSObject

@property (nonatomic, assign) id <GTChatManagerDelagete> delegate;

+ (GTChatManager *)shareManager;

- (void)login;

- (void)logOut;

- (void)sendMessage:(NSString *)msg toUser:(NSString *)toUser;

@end
