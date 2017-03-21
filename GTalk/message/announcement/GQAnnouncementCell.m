//
//  GQAnnouncementCell.m
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import "GQAnnouncementCell.h"
#import "SNY_Toast.h"

@interface GQAnnouncementCell()

@end

@implementation GQAnnouncementCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutContentView:(NSString *)content{
    if (self.line == nil) {
        self.line = [[UILabel alloc] init];
        self.line.backgroundColor = [UIColor  lightGrayColor];
        [self addSubview:self.line];
    }
    self.line.frame = CGRectMake(0, [self calculateTitleHeight:content] - 0.5, gScreenWidth - 0, 0.5);
}

- (CGFloat)calculateTitleHeight:(NSString *)title{
    CGSize size = [title getSizeWithMaxSize:CGSizeMake(gScreenWidth - 20 - 45, CGFLOAT_MAX) WithFontSize:15];
    if (size.height < 16) {
        return 70;
    }
    CGFloat hight = size.height + 55;
    return hight;
}

@end
