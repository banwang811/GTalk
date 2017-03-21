//
//  GQTextMessageCell.h
//  Investment
//
//  Created by mac on 15/7/28.
//
//

#import <UIKit/UIKit.h>
#import "GQMessage.h"
#import "GQBaseMessageCell.h"

typedef NS_ENUM(NSUInteger, GQMessageCell_type) {
    GQMessageCell_leftText,
    GQMessageCell_rightText,
};

@interface GQTextMessageCell : GQBaseMessageCell

#pragma mark - leftTextCell
//气泡背景
@property (weak, nonatomic) IBOutlet UIImageView            *leftBackImageView;
//左头像
@property (weak, nonatomic) IBOutlet UIImageView            *leftHeadImageView;
//左聊天内容
@property (weak, nonatomic) IBOutlet UILabel                *leftContentLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *leftBackImageSpeaceWith;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *leftContentLabelSpeace;

#pragma mark - rightTextCell
//气泡背景
@property (weak, nonatomic) IBOutlet UIImageView            *rightBackImageView;
//右头像
@property (weak, nonatomic) IBOutlet UIImageView            *rightHeadImageView;
//右聊天内容
@property (weak, nonatomic) IBOutlet UILabel                *rightContentLabel;
//聊天内容右label距离左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *rightContentLabelSpeace;
//右边气泡背景距离左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint     *rightBackImageSpeaceWith;


@end
