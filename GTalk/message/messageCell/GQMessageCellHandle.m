//
//  GQMessageCellHandle.m
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import "GQMessageCellHandle.h"
#import "GQTextMessageCell.h"


@implementation GQMessageCellHandle

+ (GQBaseMessageCell *)creatCell:(GQMessage *)message{
    GQBaseMessageCell *cell = nil;
    NSInteger index = 0;
    //左右判定
    if (message.isSelf) {
        index = 1;
    }else{
        index = 0;
    }
    switch (message.messageType) {
        case gMessageBodyType_Text:
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GQTextMessageCell" owner:self options:nil] objectAtIndex:index];
            break;
        case gMessageBodyType_Image:
            
            break;
        case gMessageBodyType_Video:
            
            break;
        case gMessageBodyType_Location:
            
            break;
        case gMessageBodyType_Voice:
            
            break;
        case gMessageBodyType_File:
            
            break;
        case gMessageBodyType_System:
            
            break;
        default:
            break;
    }
    return cell;
}


+ (NSString *)cellIdentifier:(GQMessage *)message{
    NSString *identifier = nil;
    switch (message.messageType) {
        case gMessageBodyType_Text:
            identifier = @"GQTextMessageCell";
            break;
        case gMessageBodyType_Image:
            identifier = @"GQImageMessageCell";
            break;
        case gMessageBodyType_Video:
            identifier = @"GQVidoMessageCell";
            break;
        case gMessageBodyType_Location:
            identifier = @"GQLocationMessageCell";
            break;
        case gMessageBodyType_Voice:
            identifier = @"GQVoiceMessageCell";
            break;
        case gMessageBodyType_File:
            identifier = @"GQFileMessageCell";
            break;
        case gMessageBodyType_System:
            identifier = @"GQSystemMessageCell";
            break;
        default:
            break;
    }
    if (message.isSelf) {
        identifier = [NSString stringWithFormat:@"%@_right",identifier];
    }else{
        identifier = [NSString stringWithFormat:@"%@_left",identifier];
    }
    return identifier;
}


//计算高度
+ (CGFloat)calculateHeight:(GQMessage *)message{
    
    CGFloat hight = 0;
    switch (message.messageType) {
        case gMessageBodyType_Text:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_Image:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_Video:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_Location:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_Voice:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_File:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        case gMessageBodyType_System:
            hight = [GQTextMessageCell calculateHeight:message];
            break;
        default:
            break;
    }
    return  hight;
}


@end
