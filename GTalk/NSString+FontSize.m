//
//  NSString+FontSize.m
//  GTalk
//
//  Created by mac on 15/8/26.
//  Copyright (c) 2015年 banwang. All rights reserved.
//

#import "NSString+FontSize.h"

@implementation NSString (FontSize)

-(CGSize)getSizeWithMaxSize:(CGSize)maxSize WithFontSize:(int)fontSize
{
    CGSize size;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        size=[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
        
    }
    else
    {
        size=[self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}


@end
