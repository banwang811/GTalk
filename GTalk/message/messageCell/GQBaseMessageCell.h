//
//  GQBaseMessageCell.h
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import <UIKit/UIKit.h>
#import "GQMessage.h"

@interface GQBaseMessageCell : UITableViewCell

@property (nonatomic, strong) GQMessage             *message;

+ (CGFloat)calculateHeight:(GQMessage *)message;

@end
