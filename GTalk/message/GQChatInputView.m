//
//  GQChatInputView.m
//  Investment
//
//  Created by mac on 15/7/28.
//
//

#import "GQChatInputView.h"
#import "GQChatView.h"
@interface GQChatInputView()

@property (nonatomic, strong) UIButton                        *writeButton;

@property (nonatomic, strong) UILabel                         *line;
//文本框的delegate
@property (nonatomic, assign) id<HPGrowingTextViewDelegate>   textViewDelegate;

@end

@implementation GQChatInputView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:GQKeyboardShouldHideNotification
                                                  object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target{
    if (self = [super initWithFrame:frame]) {
        self.textViewDelegate = target;
        [self setContentView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(hideKeyBoard)
                                                     name:GQKeyboardShouldHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)setContentView{
    [self addSubview:self.writeButton];
    [self addSubview:self.textView];
    [self addSubview:self.line];
}

- (UIButton *)writeButton{
    if (_writeButton == nil) {
        _writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeButton.frame = CGRectMake(Speace_Width, Button_Speace_Hight, 33, 33);
        [_writeButton setImage:[UIImage imageNamed:@"text.png"] forState:UIControlStateNormal];
        [_writeButton addTarget:self action:@selector(writeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeButton;
}

- (HPGrowingTextView *)textView{
    if (_textView == nil) {
        _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(Speace_Width * 2 + 33, TextView_Speace_Hight, self.frame.size.width - (Speace_Width *3 + 33), 31)];
        _textView.font = [UIFont systemFontOfSize:Fount_Size];
        _textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
        _textView.layer.borderColor = [[UIColor redColor]CGColor];
        _textView.layer.borderWidth = 1.0;
        _textView.layer.cornerRadius = 4.0f;
        
        _textView.isScrollable = NO;
        _textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        _textView.minNumberOfLines = 1;
        _textView.maxNumberOfLines = 6;
        _textView.delegate = self.textViewDelegate;
        _textView.returnKeyType = UIReturnKeySend;
        [_textView.layer setMasksToBounds:YES];
    }
    return _textView;
}

- (UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}

- (void)writeButtonClick{
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }else{
        [_textView becomeFirstResponder];
    }
}

- (void)hideKeyBoard{
    if ([_textView isFirstResponder]) {
        [_textView resignFirstResponder];
    }
}

@end
