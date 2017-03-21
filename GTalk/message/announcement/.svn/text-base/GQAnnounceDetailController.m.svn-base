//
//  GQAnnounceDetailController.m
//  Investment
//
//  Created by mac on 15/7/30.
//
//

#import "GQAnnounceDetailController.h"
#import "SNY_Toast.h"
#import "GQAnnounceDetailCell.h"

@interface GQAnnounceDetailController ()

@property (weak, nonatomic) IBOutlet UITableView       *tableView;

@property (nonatomic, assign) CGFloat                   hight;

@end

@implementation GQAnnounceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"公告详情";
    [self customBackWhiteBarItem];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        GQAnnounceDetailCell *cell = [GQAnnounceDetailCell creatCell:GQAnnounceDetail_normal];
        self.hight = [cell  calculateTitleHeight:self.model.title];
        return self.hight;
    }else {
        GQAnnounceDetailCell *cell = [GQAnnounceDetailCell creatCell:GQAnnounceDetail_content];
        return [cell calculateContentHeight:self.model.content];
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        GQAnnounceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQAnnounceDetail_normal"];
        if (cell == nil) {
            cell = [GQAnnounceDetailCell creatCell:GQAnnounceDetail_normal];
        }
        cell.gqTitleLabel.text = self.model.title;
        cell.dateLabel.text = self.model.sendTime;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.line.frame = CGRectMake(20, self.hight - 0.5, gScreenWidth - 40, 0.5);
        return cell;
    }else{
        GQAnnounceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQAnnounceDetail_content"];
        if (cell == nil) {
            cell = [GQAnnounceDetailCell creatCell:GQAnnounceDetail_content];
        }
        cell.content.text = self.model.content;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}


@end
