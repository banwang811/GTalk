//
//  GQAnnouncementView.h
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import <UIKit/UIKit.h>
#import "GQMessageViewController.h"

@interface GQAnnouncementView : UIView

@property (nonatomic, strong) GQMessageViewController           *superViewController;

- (void)readAnnouncement:(NSInteger)AnnouncementId;

@end
