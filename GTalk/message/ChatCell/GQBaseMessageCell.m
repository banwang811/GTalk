//
//  GQBaseMessageCell.m
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import "GQBaseMessageCell.h"

@implementation GQBaseMessageCell

- (id)initWithMessageModel:(GQMessage *)messageModel reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImagePressed:)];
        CGFloat originX = HEAD_PADDING;
        if (messageModel.isSelf) {
            originX = self.bounds.size.width - HEAD_SIZE - HEAD_PADDING;
        }
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(originX, CELLPADDING, HEAD_SIZE, HEAD_SIZE)];
        [_headImageView addGestureRecognizer:tap];
        _headImageView.userInteractionEnabled = YES;
        _headImageView.multipleTouchEnabled = YES;
        _headImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headImageView];
        
        [self setupSubviewsForMessageModel:messageModel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = _headImageView.frame;
    frame.origin.x = _messageModel.isSelf ? (self.bounds.size.width - _headImageView.frame.size.width - HEAD_PADDING) : HEAD_PADDING;
    _headImageView.frame = frame;
}

- (void)headImagePressed:(UITapGestureRecognizer *)tapGestureRecognizer{
    //
}

+ (NSString *)cellIdentifierForMessageModel:(GQMessage *)messageModel
{
    NSString *identifier = @"MessageCell";
    if (messageModel.isSelf) {
        identifier = [identifier stringByAppendingString:@"Sender"];
    }
    else{
        identifier = [identifier stringByAppendingString:@"Receiver"];
    }
    
    switch (messageModel.messageType) {
        case gMessageBodyType_Text:
        {
            identifier = [identifier stringByAppendingString:@"Text"];
        }
            break;
        case gMessageBodyType_Image:
        {
            identifier = [identifier stringByAppendingString:@"Image"];
        }
            break;
        case gMessageBodyType_Voice:
        {
            identifier = [identifier stringByAppendingString:@"Audio"];
        }
            break;
        case gMessageBodyType_Location:
        {
            identifier = [identifier stringByAppendingString:@"Location"];
        }
            break;
        case gMessageBodyType_Video:
        {
            identifier = [identifier stringByAppendingString:@"Video"];
        }
            break;
            
        default:
            break;
    }
    
    return identifier;
}

#pragma mark - setter
- (void)setMessageModel:(GQMessage *)messageModel{
    _messageModel = messageModel;
    if (messageModel.isSelf) {
        UIImage *rightHeadImage = nil;
        if (rightHeadImage) {
            self.headImageView.image = rightHeadImage;
        }else{
            self.headImageView.image = [UIImage imageNamed:@"touxiang.png"];
        }
    }else{
        self.headImageView.image = [UIImage imageNamed:@"e.png"];
    }
}

#pragma mark - public
- (void)setupSubviewsForMessageModel:(GQMessage *)messageModel{
    if (messageModel.isSelf) {
        self.headImageView.frame = CGRectMake(self.bounds.size.width - HEAD_SIZE - HEAD_PADDING, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
    else{
        self.headImageView.frame = CGRectMake(0, CELLPADDING, HEAD_SIZE, HEAD_SIZE);
    }
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(GQMessage *)model{
    return HEAD_SIZE + CELLPADDING;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
