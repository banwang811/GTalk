//
//  GQQuestionNoteView.m
//  Investment
//
//  Created by mac on 15/7/29.
//
//

#import "GQQuestionNoteView.h"
#import "GQQuestionCell.h"

@interface GQQuestionNoteView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView               *tableView;

@property (nonatomic, strong) NSMutableArray            *models;

@end

@implementation GQQuestionNoteView


- (void)layoutSubviews{
    _tableView.frame = CGRectMake(0, 8, gScreenWidth, self.frame.size.height - 28);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.models = [NSMutableArray array];
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 8, gScreenWidth, self.frame.size.height - 28) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 27;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (GQQuestionCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GQQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GQQuestionCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GQQuestionCell" owner:self options:nil] firstObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    [cell layoutContenView];
    GQQuestion *question = [self.models objectAtIndex:indexPath.row];
    cell.titleLabel.text = question.title;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectQuestion:)]) {
        GQQuestion *question = [self.models objectAtIndex:indexPath.row];
        [self.delegate didSelectQuestion:question];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//获取相关提示问题
- (void)requestRelatedQuestion:(NSString *)str{
    NSDictionary *parameter = @{@"title":str};
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,GETORDER_FindFaqByTiTle] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject
                                                          options:NSJSONReadingMutableContainers
                                                            error:nil];
        NSLog(@"%@",dic);
        if([[dic objectForKey:@"success"] integerValue]==1){
            NSDictionary *data = [dic objectForKey:@"data"];
            NSArray *infos = [data objectForKey:@"dataList"];
            [self.models removeAllObjects];
            if (![infos isKindOfClass:[NSNull class]]){
                for (NSDictionary *info in infos) {
                    GQQuestion *question = [[GQQuestion alloc] init];
                    [question setValuesForKeysWithDictionary:info];
                    question.questionId = [[info objectForKey:@"id"] integerValue];
                    [self.models addObject:question];
                }
            }
            [self.tableView reloadData];
        }else{
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

//获取问题答案
- (void)requestRelatedAnswer:(NSString *)questionTitle questionId:(NSInteger)questionId
                    complete:(void(^)(NSArray *answerStrings))completeBlock
                      failed:(void(^)())failedBlock{
    NSDictionary *parameter = nil;
    if (questionId != -1) {
        parameter = @{@"id":[NSNumber numberWithInteger:questionId]};
    }else{
        if (![questionTitle isEqualToString:@""]) {
            parameter = @{@"title":questionTitle};
        }else{
            return;
        }
    }
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableArray *questionAnswers = [NSMutableArray array];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,GETORDER_FindOneFaq] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:responseObject
                                                          options:NSJSONReadingMutableContainers
                                                            error:nil];
        if([[dic objectForKey:@"success"] integerValue]==1){
            NSDictionary *data = [dic objectForKey:@"data"];
            NSArray *answers = [data objectForKey:@"dataList"];
            if (![answers isKindOfClass:[NSNull class]]) {
                if ([answers count]> 10) {
                    for (int i = 0; i< 10; i++) {
                        NSDictionary *info = [answers objectAtIndex:i];
                        GQQuestion *question = [[GQQuestion alloc] init];
                        [question setValuesForKeysWithDictionary:info];
                        question.questionId = [[info objectForKey:@"id"] integerValue];
                        NSString *answerString = [NSString stringWithFormat:@"%@\n\n%@",question.title,question.content];
                        [questionAnswers addObject:answerString];
                    }
                }else{
                    for (NSDictionary *info in answers) {
                        GQQuestion *question = [[GQQuestion alloc] init];
                        [question setValuesForKeysWithDictionary:info];
                        question.questionId = [[info objectForKey:@"id"] integerValue];
                        NSString *answerString = [NSString stringWithFormat:@"%@\n\n%@",question.title,question.content];
                        [questionAnswers addObject:answerString];
                    }
                }
            }
            if (completeBlock) {
                completeBlock(questionAnswers);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock();
        }
    }];
}

@end
