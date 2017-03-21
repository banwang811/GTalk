//
//  GQQuestionNoteView.h
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import <UIKit/UIKit.h>
#import "GQQuestion.h"

@protocol GQQuestionNoteViewDelegate <NSObject>

//选中问题的回调
- (void)didSelectQuestion:(GQQuestion *)question;

@end

@interface GQQuestionNoteView : UIView

@property (nonatomic, assign) id<GQQuestionNoteViewDelegate>   delegate;

- (void)requestRelatedQuestion:(NSString *)str;

- (void)requestRelatedAnswer:(NSString *)questionTitle questionId:(NSInteger)questionId
                                                         complete:(void(^)(NSArray *answerStrings))completeBlock
                                                           failed:(void(^)())failedBlock;

@end
