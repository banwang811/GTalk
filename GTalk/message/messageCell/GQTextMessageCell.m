//
//  GQTextMessageCell.m
//  Investment
//
//  Created by mac on 15/7/28.

////

#import "GQTextMessageCell.h"
#import "NSString+FontSize.h"

@implementation GQTextMessageCell

- (void)drawRect:(CGRect)rect{
    self.leftHeadImageView.layer.cornerRadius = self.leftHeadImageView.frame.size.width/2;
    self.leftHeadImageView.layer.masksToBounds = YES;
    self.rightHeadImageView.layer.cornerRadius = self.rightHeadImageView.frame.size.width/2;
    self.rightHeadImageView.layer.masksToBounds = YES;
}

+ (CGFloat)calculateHeight:(GQMessage *)message{
    CGSize size = [message.content getSizeWithMaxSize:CGSizeMake(gScreenWidth - 120, CGFLOAT_MAX) WithFontSize:14];
    CGFloat hight = size.height + 53 +1;
    return hight;
}

- (void)setMessage:(GQMessage *)message{
    [super setMessage:message];
    CGSize size =[message.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    if (message.isSelf) {
        //判断文本未满一行则调整label的大小和气泡背景的大小
        UIImage *rightHeadImage = nil;
        if (rightHeadImage) {
            self.rightHeadImageView.image = rightHeadImage;
        }else{
            self.rightHeadImageView.image = [UIImage imageNamed:@"touxiang"];
        }
        UIImage *image = [UIImage imageNamed:@"right"];
        self.rightBackImageView.image = [image stretchableImageWithLeftCapWidth:3 topCapHeight:25];
        if (size.width >= gScreenWidth - (52+8) *2) {
            self.rightContentLabelSpeace.constant = 52 + 8;
            self.rightBackImageSpeaceWith.constant = 52 + 4;
            self.rightContentLabel.text = message.content;
            
        }else{
            self.rightContentLabel.text = message.content;
            //0.5纠正计算时候小数点取舍造成的误差
            self.rightContentLabelSpeace.constant = gScreenWidth  - (size.width + 52 + 4*2 +0.5);
            self.rightBackImageSpeaceWith.constant = gScreenWidth - (size.width + 52 + 8 + 8 +0.5);
        }
    }else{
        //判断文本未满一行则调整label的大小和气泡背景的大小
        UIImage *image = [UIImage imageNamed:@"left"];
        self.leftBackImageView.image = [image stretchableImageWithLeftCapWidth:15 topCapHeight:30];
        if (size.width >= gScreenWidth - (52 +8) *2) {
            self.leftContentLabel.text = message.content;
            self.leftContentLabelSpeace.constant = 52 + 8;
            self.leftBackImageSpeaceWith.constant = 52 + 4;
        }else{
            self.leftContentLabelSpeace.constant = gScreenWidth  - (size.width + 52 + 4*2 +0.5);
            self.leftBackImageSpeaceWith.constant = gScreenWidth - (size.width + 52 + 8 + 8 +0.5);
            self.leftContentLabel.text = message.content;
        }
    }
} 
@end
