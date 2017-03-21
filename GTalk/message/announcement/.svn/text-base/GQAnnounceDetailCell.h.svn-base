//
//  GQAnnounceDetailCell.h
//  Investment
//
//  Created by mac on 15/7/31.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    GQAnnounceDetail_normal,
    GQAnnounceDetail_content,
}GQAnnounceDetail_type;

@interface GQAnnounceDetailCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel                            *content;

@property (weak, nonatomic) IBOutlet UILabel                            *gqTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel                            *dateLabel;

@property (nonatomic, strong) UILabel                                   *line;


+ (GQAnnounceDetailCell *)creatCell:(GQAnnounceDetail_type)type;

- (CGFloat)calculateTitleHeight:(NSString *)title;

- (CGFloat)calculateContentHeight:(NSString *)content;

- (void)layoutContentView;

@end
