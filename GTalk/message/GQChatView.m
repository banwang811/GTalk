//
//  GQChatView.m
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import "GQChatView.h"

@implementation GQChatView

NSString * const GQKeyboardShouldHideNotification = @"GQKeyboardShouldHideNotification";


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:GQKeyboardShouldHideNotification object:nil];
}
@end
