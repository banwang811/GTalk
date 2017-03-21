//
//  GQMessageCellHandle.h
//  Investment
//
//  Created by mac on 15/8/28.
//
//

#import <Foundation/Foundation.h>
#import "GQBaseMessageCell.h"


@interface GQMessageCellHandle : NSObject

+ (GQBaseMessageCell *)creatCell:(GQMessage *)message;

+ (NSString *)cellIdentifier:(GQMessage *)message;

+ (CGFloat)calculateHeight:(GQMessage *)message;

@end
