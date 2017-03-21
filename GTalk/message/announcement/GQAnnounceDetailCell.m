//
//  GQAnnounceDetailCell.m
//  Investment
//
//  Created by mac on 15/7/31.
//
//

#import "GQAnnounceDetailCell.h"
#import "SNY_Toast.h"

@interface GQAnnounceDetailCell ()

@end

@implementation GQAnnounceDetailCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (UILabel *)line{
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor  colorWithHexColorString:@"ededed"];
        [self addSubview:self.line];
    }
    return _line;
}

+ (GQAnnounceDetailCell *)creatCell:(GQAnnounceDetail_type)type{
    GQAnnounceDetailCell *cell = nil;
    if (type == GQAnnounceDetail_normal) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GQAnnounceDetailCell" owner:self options:nil] objectAtIndex:0];
    }else if (type == GQAnnounceDetail_content){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GQAnnounceDetailCell" owner:self options:nil] objectAtIndex:1];
    }
    return cell;
}

- (CGFloat)calculateTitleHeight:(NSString *)title{
    CGSize size = [title getSizeWithMaxSize:CGSizeMake(gScreenWidth - 60 * 2, CGFLOAT_MAX) WithFontSize:15];
    if (size.height < 16) {
        return 93;
    }
    CGFloat hight = size.height - 15 + 93;
    return hight;
}


- (CGFloat)calculateContentHeight:(NSString *)content{
    CGSize size = [content getSizeWithMaxSize:CGSizeMake(gScreenWidth - 40, CGFLOAT_MAX) WithFontSize:12];
    if (size.height < 13) {
        return 40;
    }
    return size.height + 25;
}

@end
