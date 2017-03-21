//
//  GQMessageCell.m
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import "GQMessageCell.h"
#import "GQTextMessageView.h"



@implementation GQMessageCell

- (id)initWithMessageModel:(GQMessage *)messageModel reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithMessageModel:messageModel reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headImageView.clipsToBounds = YES;
        self.headImageView.layer.cornerRadius = 3.0;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bubbleFrame = self.bubbleView.frame;
    bubbleFrame.origin.y = self.headImageView.frame.origin.y;
    if (self.messageModel.isSelf) {
        bubbleFrame.origin.y = self.headImageView.frame.origin.y;
        bubbleFrame.origin.x = self.headImageView.frame.origin.x - bubbleFrame.size.width - HEAD_PADDING;
        self.bubbleView.frame = bubbleFrame;
    }
    else{
        bubbleFrame.origin.x = HEAD_PADDING * 2 + HEAD_SIZE;
        self.bubbleView.frame = bubbleFrame;
    }
}

- (void)setMessageModel:(GQMessage *)messageModel{
    [super setMessageModel:messageModel];
    self.bubbleView.messageModel = self.messageModel;
    [self.bubbleView sizeToFit];
}

- (void)setupSubviewsForMessageModel:(GQMessage *)messageModel{
    [super setupSubviewsForMessageModel:messageModel];
    self.bubbleView = [self bubbleViewForMessageModel:messageModel];
    [self.contentView addSubview:self.bubbleView];
}

- (GQBaseContentView *)bubbleViewForMessageModel:(GQMessage *)messageModel{
    switch (messageModel.messageType) {
        case gMessageBodyType_Text:
        {
            return [[GQTextMessageView alloc] init];
        }
            break;
        default:
            break;
    }
    return nil;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(GQMessage *)messageModel{
    NSInteger bubbleHeight = [self bubbleViewHeightForMessageModel:messageModel];
    NSInteger headHeight = HEAD_PADDING * 2 + HEAD_SIZE;
    return MAX(headHeight, bubbleHeight + NAME_LABEL_HEIGHT + NAME_LABEL_PADDING) + CELLPADDING;
}

+ (CGFloat)bubbleViewHeightForMessageModel:(GQMessage *)messageModel{
    switch (messageModel.messageType) {
        case gMessageBodyType_Text:
        {
            return [GQTextMessageView heightForBubbleWithObject:messageModel];
        }
            break;
        default:
            break;
    }
    
    return HEAD_SIZE;
}

@end
