//
//  NSString+FontSize.h
//  GTalk
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 banwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FontSize)

-(CGSize)getSizeWithMaxSize:(CGSize)maxSize WithFontSize:(int)fontSize;

@end
