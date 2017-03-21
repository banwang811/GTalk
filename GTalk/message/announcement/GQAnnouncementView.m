//
//  GQAnnouncementView.m
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import "GQAnnouncementView.h"
#import "GQAnnouncementCell.h"
#import "GQAnnouncementModel.h"
#import "GQAnnounceDetailController.h"

@interface GQAnnouncementView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray            *models;

@property (nonatomic, strong) UITableView               *tableView;

@property (nonatomic, strong) GQAnnouncementCell        *recordCell;

@property (nonatomic, assign) NSInteger                 pageCount;

@property (nonatomic, assign) NSInteger                 pageSize;

@property (nonatomic, assign) NSInteger                 totalNumber;

@end

@implementation GQAnnouncementView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.pageCount = 1;
        self.pageSize = 10;
        self.models = [NSMutableArray array];
        [self addSubview:self.tableView];
        [self refreshData];
    }
    return self;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)refreshData{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView  addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView headerBeginRefreshing];
    
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"加载中...";
}


- (void)headerRereshing{
    [self requestAnnouncement:NO];
}

- (void)footerRereshing{
    [self requestAnnouncement:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GQAnnouncementModel *model = [self.models objectAtIndex:indexPath.row];
    return [self.recordCell calculateTitleHeight:model.title];
}

//紧用户计算高度，防止重复创建消耗资源
- (GQAnnouncementCell *)recordCell{
    if (_recordCell == nil) {
        _recordCell = [[[NSBundle mainBundle] loadNibNamed:@"GQAnnouncementCell" owner:self options:nil] firstObject];
    }
    return _recordCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GQAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQAnnouncementCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GQAnnouncementCell" owner:self options:nil] firstObject];
    }
    GQAnnouncementModel *model = [self.models objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = model.sendTime;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell layoutContentView:model.title];
    if (model.state == 0) {
        cell.backgroundColor = [UIColor colorWithHexColorString:@"ededed"];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GQAnnounceDetailController *controller= [[GQAnnounceDetailController alloc] init];
    GQAnnouncementModel *model = [self.models objectAtIndex:indexPath.row];
    controller.model = model;
    model.state = 1;
    if ([self.superViewController isKindOfClass:[GQMessageViewController class]]) {
        [self.superViewController.navigationController pushViewController:controller animated:YES];
    }
    [self readAnnouncement:model.AnnouncementId];
}

//刷新
- (void)requestAnnouncement:(BOOL)isLoadMore{
    NSString *str = [[GQSecurityManager shareManager] getAccount];
    NSString *mobile = (str != nil ?str:@"");
    NSDictionary *parameter = nil;
    if (isLoadMore) {
        if ([self.models count] >= self.totalNumber) {
            [self.tableView footerEndRefreshing];
            [WDAutoDisplayAlert showMessage:@"没有更多的数据"];
            return;
        }
        parameter = @{@"mobile":mobile,
                      @"page":[NSNumber numberWithInteger:self.pageCount+1],
                      @"pageSize":[NSNumber numberWithInteger:self.pageSize]};
    }else{
        parameter = @{@"mobile":mobile,
                      @"page":@"1",
                      @"pageSize":@"10"};
    }
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,GETORDER_Notice] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (isLoadMore) {
            [self.tableView footerEndRefreshing];
        }else{
            [self.models removeAllObjects];
            [self.tableView headerEndRefreshing];
        }
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject
                                                          options:NSJSONReadingMutableContainers
                                                            error:nil];
        if([[dic objectForKey:@"success"] integerValue]==1){
            NSDictionary *data = [dic objectForKey:@"data"];
            self.totalNumber = [[data objectForKey:@"totalRecs"] integerValue];
            self.pageCount = [[data objectForKey:@"page"] integerValue];
            NSArray *infos = [data objectForKey:@"dataList"];
            if (![infos isKindOfClass:[NSNull class]]) {
                for (NSDictionary *info in infos) {
                    GQAnnouncementModel *model =  [[GQAnnouncementModel alloc] init];
                    [model setValuesForKeysWithDictionary:info];
                    model.AnnouncementId = [[info objectForKey:@"id"] integerValue];
                    [self.models addObject:model];
                }
            }
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isLoadMore) {
            [self.tableView footerEndRefreshing];
        }else{
            [self.tableView headerEndRefreshing];
        }
        [WDAutoDisplayAlert showMessage:@"请求失败，请重新尝试!"];
    }];
}


- (void)readAnnouncement:(NSInteger)AnnouncementId{
    NSString *str = [[GQSecurityManager shareManager] getAccount];
    NSString *mobile = (str != nil ?str:@"");
    NSDictionary *parameter = @{@"mobile":mobile,
                                @"id":[NSNumber numberWithInteger:AnnouncementId]};
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,GETORDER_SetNotice] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject
                                                          options:NSJSONReadingMutableContainers
                                                            error:nil];
        NSLog(@"%@",dic);
        if([[dic objectForKey:@"success"] integerValue]==1){
            if (AnnouncementId == -1) {
                for (GQAnnouncementModel *model in self.models) {
                    model.state = 1;
                }
            }
            [self.tableView reloadData];
        }else{
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WDAutoDisplayAlert showMessage:@"请求失败，请重新尝试!"];
    }];

}

@end
