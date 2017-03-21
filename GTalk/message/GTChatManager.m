//
//  GTChatManager.m
//  GTalk
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 banwang. All rights reserved.
//

#import "GTChatManager.h"

#define kIP @"mq.gqget.com"
//#define kIP @"activemq.gqihome.com"

//#define kTopic @"topic_sofeel"
#define kTopic @"xxx"

@interface GTChatManager ()

@property (nonatomic, strong) MQTTSession           *session;
@property (nonatomic, strong) NSString              *currentUser;

@end

@implementation GTChatManager

+ (GTChatManager *)shareManager{
    static GTChatManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[GTChatManager alloc] init];
    });
    return shareManager;
}

- (instancetype)init{
    if (self = [super init]) {
        self.currentUser = @"aTw_00012522";
    }
    return self;
}

- (void)logOut{

}

- (void)login{
     self.session = [[MQTTSession alloc] initWithClientId:self.currentUser];
    [self.session setDelegate:self];
    [self.session connectToHost:kIP port:1883];
}

- (void)subscribe:(NSString *)topic {
    [self.session subscribeTopic:topic];
}

- (void)sendMessage:(NSString *)msg toUser:(NSString *)toUser {
    NSDictionary *msgDict = @{@"to": toUser,
                              @"from": self.currentUser,
                              @"message": msg};
    NSData *pubData = [NSJSONSerialization dataWithJSONObject:msgDict
                                                      options:NSJSONWritingPrettyPrinted
                                                        error:nil];
    [self.session publishDataAtLeastOnce:pubData onTopic:kTopic];
}


#pragma mark - MQtt Callback methods
- (void)session:(MQTTSession*)sender handleEvent:(MQTTSessionEvent)eventCode {
    switch (eventCode) {
        case MQTTSessionEventConnected:
            if (self.delegate && [self.delegate respondsToSelector:@selector(didConnected)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didConnected];
                });
            }
            [self subscribe:kTopic];
            break;
        case MQTTSessionEventConnectionRefused:
            NSLog(@"connection refused");
            break;
        case MQTTSessionEventConnectionClosed:
            NSLog(@"connection closed");
            break;
        case MQTTSessionEventConnectionError:
            NSLog(@"connection error");
            NSLog(@"reconnecting...");
            [self.session connectToHost:kIP port:1883];
            break;
        case MQTTSessionEventProtocolError:
            NSLog(@"protocol error");
            break;
    }
}

- (void)session:(MQTTSession*)sender newMessage:(NSData*)data onTopic:(NSString*)topic {
    NSString *payloadString = [[NSString alloc] initWithData:data
                                                    encoding:NSUTF8StringEncoding];
    NSLog(@"%@",payloadString);
//    Message *message = [Message parseMessage:data];
    GQMessage *message = [[GQMessage alloc] init];
    message.isSelf = NO;
    message.content = [NSString stringWithFormat:@"%@",payloadString];
    message.messageType = gMessageBodyType_Text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didReceiveMessage:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didReceiveMessage:message];
        });
    }
}


@end
