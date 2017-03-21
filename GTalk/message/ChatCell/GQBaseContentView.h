//
//  GQBaseContentView.h
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import <UIKit/UIKit.h>
#import "GQMessage.h"

#define BUBBLE_LEFT_IMAGE_NAME @"left" // bubbleView 的背景图片
#define BUBBLE_RIGHT_IMAGE_NAME @"right"
#define BUBBLE_ARROW_WIDTH 5 // bubbleView中，箭头的宽度
#define BUBBLE_VIEW_PADDING 8 // bubbleView 与 在其中的控件内边距

#define BUBBLE_RIGHT_LEFT_CAP_WIDTH 8 // 文字在右侧时,bubble用于拉伸点的X坐标
#define BUBBLE_RIGHT_TOP_CAP_HEIGHT 25 // 文字在右侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_LEFT_LEFT_CAP_WIDTH 15 // 文字在左侧时,bubble用于拉伸点的X坐标
#define BUBBLE_LEFT_TOP_CAP_HEIGHT 30 // 文字在左侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_PROGRESSVIEW_HEIGHT 10 // progressView 高度

@interface GQBaseContentView : UIView

@property (nonatomic, strong) GQMessage *messageModel;

@property (nonatomic, strong) UIImageView *backImageView;

- (void)bubbleViewPressed:(id)sender;

+ (CGFloat)heightForBubbleWithObject:(GQMessage *)messageModel;

@end
