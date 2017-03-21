//
//  GQChatInputView.h
//  Investment
//
//  Created by mac on 15/7/28.
//
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
//view的高度
#define InputView_Hight                 53
//button,textview 距离左右边距的间隙
#define Speace_Width                    10
//button 距离上下边距的间隙
#define Button_Speace_Hight             10

//textview 的字体大小
#define Fount_Size                      14
//textview 距离上下边距的间隙
#define TextView_Speace_Hight           11

@interface GQChatInputView : UIView

@property (nonatomic, strong) HPGrowingTextView             *textView;

- (instancetype)initWithFrame:(CGRect)frame target:(id)target;

@end
