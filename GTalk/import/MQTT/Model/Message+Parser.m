//
//  SWMessage+Parser.m
//  MQTTMessenger
//
//  Created by 王 松 on 14-1-15.
//  Copyright (c) 2014年 Song.Wang. All rights reserved.
//

#import "Message+Parser.h"

@implementation Message (Parser)

+ (Message *)parseMessage:(NSData *)json{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json
                                                         options:NSJSONReadingAllowFragments
                                                           error:nil];
    Message *message = [[Message alloc] init];
    message.to = [dict objectForKey:@"to"];
    message.from = [dict objectForKey:@"from"];
    message.message = [dict objectForKey:@"message"];
    message.timestamp = [NSDate date];
    return message;
}

@end
