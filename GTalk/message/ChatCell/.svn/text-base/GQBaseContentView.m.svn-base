//
//  GQBaseContentView.m
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import "GQBaseContentView.h"

@implementation GQBaseContentView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.multipleTouchEnabled = YES;
        _backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_backImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleViewPressed:)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - setter

- (void)setMessageModel:(GQMessage *)messageModel{
    _messageModel = messageModel;
    BOOL isReceiver = !messageModel.isSelf;
    NSString *imageName = isReceiver ? BUBBLE_LEFT_IMAGE_NAME : BUBBLE_RIGHT_IMAGE_NAME;
    NSInteger leftCapWidth = isReceiver?BUBBLE_LEFT_LEFT_CAP_WIDTH:BUBBLE_RIGHT_LEFT_CAP_WIDTH;
    NSInteger topCapHeight =  isReceiver?BUBBLE_LEFT_TOP_CAP_HEIGHT:BUBBLE_RIGHT_TOP_CAP_HEIGHT;
    self.backImageView.image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}

- (void)bubbleViewPressed:(UITapGestureRecognizer *)tapGestureRecognizer{
    
}

#pragma mark - public

+ (CGFloat)heightForBubbleWithObject:(GQMessage *)messageModel{
    return 30;
}

@end
