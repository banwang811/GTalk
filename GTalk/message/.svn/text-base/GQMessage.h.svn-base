//
//  GQMessage.h
//  Investment
//
//  Created by mac on 15/7/28.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GQMessageType) {
    gMessageBodyType_Text = 1,
    gMessageBodyType_Image,
    gMessageBodyType_Video,
    gMessageBodyType_Location,
    gMessageBodyType_Voice,
    gMessageBodyType_File,
    gMessageBodyType_System
};

@interface GQMessage : NSObject

@property (nonatomic, assign) BOOL                          isSelf;

@property (nonatomic, strong) NSString                      *date;

@property (nonatomic, strong) NSString                      *from;

@property (nonatomic, strong) NSString                      *to;

@property (nonatomic, strong) NSString                      *content;

@property (nonatomic, assign) GQMessageType                 messageType;

@end
