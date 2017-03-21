//
//  GQTextMessageView.m
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import "GQTextMessageView.h"

@implementation GQTextMessageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.lineBreakMode = NSLineBreakByCharWrapping;
        self.label.font = [UIFont systemFontOfSize:LABEL_FONT_SIZE];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.userInteractionEnabled = NO;
        self.label.multipleTouchEnabled = NO;
        [self addSubview:self.label];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    frame.size.width -= BUBBLE_ARROW_WIDTH;
    frame = CGRectInset(frame, BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING);
    if (self.messageModel.isSelf) {
        frame.origin.x = BUBBLE_VIEW_PADDING;
    }else{
        frame.origin.x = BUBBLE_VIEW_PADDING + BUBBLE_ARROW_WIDTH;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.label setFrame:frame];
}

- (CGSize)sizeThatFits:(CGSize)size{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize retSize;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        retSize = [self.messageModel.content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName:[[self class] textLabelFont],
                                                             }
                                                   context:nil].size;
    }else{
        retSize = [self.messageModel.content sizeWithFont:[[self class] textLabelFont] constrainedToSize:textBlockMinSize lineBreakMode:[[self class] textLabelLineBreakModel]];
    }
    
    CGFloat height = 40;
    if (2*BUBBLE_VIEW_PADDING + retSize.height > height) {
        height = 2*BUBBLE_VIEW_PADDING + retSize.height;
    }
    
    return CGSizeMake(retSize.width + BUBBLE_VIEW_PADDING*2 + BUBBLE_VIEW_PADDING, height);
    
}

#pragma mark - setter

- (void)setMessageModel:(GQMessage *)messageModel{
    [super setMessageModel:messageModel];
    self.label.text = messageModel.content;
}


+ (CGFloat)heightForBubbleWithObject:(GQMessage *)messageModel{
    CGSize textBlockMinSize = {TEXTLABEL_MAX_WIDTH, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    NSString *content = [NSString stringWithString:messageModel.content];
    if (systemVersion >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:[[self class] lineSpacing]];//调整行间距
        size = [content boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName:[[self class] textLabelFont],
                                               NSParagraphStyleAttributeName:paragraphStyle
                                               }
                                     context:nil].size;
    }else{
        size = [content sizeWithFont:[self textLabelFont]
                   constrainedToSize:textBlockMinSize
                       lineBreakMode:[self textLabelLineBreakModel]];
    }
    return 2 * BUBBLE_VIEW_PADDING + size.height;
}


+(UIFont *)textLabelFont
{
    return [UIFont systemFontOfSize:LABEL_FONT_SIZE];
}

+(CGFloat)lineSpacing{
    return LABEL_LINESPACE;
}

+(NSLineBreakMode)textLabelLineBreakModel
{
    return NSLineBreakByCharWrapping;
}

@end
