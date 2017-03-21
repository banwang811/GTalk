//
//  GQMessageViewController.m
//  Investment
//
//  Created by iMac on 15/7/26.
//
//

#import "GQMessageViewController.h"
#import "GQMessage.h"
#import "GQChatInputView.h"
#import "GQSendManager.h"
#import "GQChatView.h"
#import "GQMessageCell.h"

@interface GQMessageViewController ()<UITableViewDataSource,
                                    UITableViewDelegate,
                                    HPGrowingTextViewDelegate,
                                    GTChatManagerDelagete
                                    >

@property (nonatomic, strong) UITableView                           *tableView;

@property (nonatomic, strong) NSMutableArray                        *messages;

@property (nonatomic, strong) GQChatInputView                       *chatInputView;

@property (nonatomic, assign) CGFloat                               keyBoardHight;

@property (nonatomic, assign) NSMutableArray                        *questions;


@end

@implementation GQMessageViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (instancetype)init{
    if (self = [super init]) {
        self.messages = [NSMutableArray array];
        self.questions = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GTChatManager shareManager].delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    //聊天列表
    [self.view addSubview:self.tableView];
    //输入view
    [self.view addSubview:self.chatInputView];
    //提示问题view
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHiden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//输入框
- (GQChatInputView *)chatInputView{
    if (_chatInputView == nil) {
        _chatInputView = [[GQChatInputView alloc] initWithFrame:CGRectMake(0, gScreenHeight - InputView_Hight , gScreenWidth, InputView_Hight) target:self];
        _chatInputView.backgroundColor = [UIColor whiteColor];
    }
    return _chatInputView;
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[GQChatView alloc] initWithFrame:CGRectMake(0, 0, gScreenWidth, gScreenHeight - 64 - InputView_Hight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GQMessage *message = [self.messages objectAtIndex:indexPath.row];
    return [GQMessageCell tableView:tableView heightForRowAtIndexPath:indexPath withObject:message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GQMessage *message = [self.messages objectAtIndex:indexPath.row];
    NSString *identifier = [GQBaseMessageCell cellIdentifierForMessageModel:message];
    GQBaseMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GQMessageCell alloc] initWithMessageModel:message reuseIdentifier:identifier];
    }
    cell.messageModel = message;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma makr - HPGrowingTextViewDelegate

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView{
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView{
    NSCharacterSet *whiltSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *textStr = [growingTextView.text stringByTrimmingCharactersInSet:whiltSpace];
    if (textStr == nil || [textStr isEqualToString:@""] || textStr.length == 0){
        return ;
    }
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = self.chatInputView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.chatInputView.frame = r;
    

    //改变tableView的大小
    CGRect frame = self.tableView.frame;
    frame.size.height = self.view.frame.size.height - (self.chatInputView.frame.size.height + _keyBoardHight);
    self.tableView.frame = frame;
    [self scrollBottomWithAnimation:NO];
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([@"\n" isEqualToString:text]){
        //
        NSCharacterSet *whiltSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *textStr = [growingTextView.text stringByTrimmingCharactersInSet:whiltSpace];
        if (textStr == nil || [textStr isEqualToString:@""] || textStr.length == 0){
            return NO;
        }
        //将问题刷新到聊天界面
        GQMessage *message = [[GQSendManager shareManager] sendTextMessageWithString:growingTextView.text
                                                                            fromSelf:YES];
        [[GTChatManager shareManager] sendMessage:growingTextView.text toUser:@""];
        [self.messages addObject:message];
        [self.tableView reloadData];
        [self scrollBottomWithAnimation:YES];
        growingTextView.text = nil;
        return NO;
    }
    return YES;
}

#pragma mark - 键盘事件
- (void)keyboardWillShow:(NSNotification *)notification{
    CGSize kbSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _keyBoardHight = kbSize.height;
    NSTimeInterval curve = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] intValue];
    __weak GQMessageViewController *weakSelf = self;
    [UIView animateWithDuration:curve animations:^{
        //改变chatInputView的大小
        CGRect frame = weakSelf.chatInputView.frame;
        frame.origin.y = (weakSelf.view.frame.size.height - kbSize.height) - frame.size.height;
        [weakSelf.chatInputView setFrame:frame];
        
       //改变tableView的大小
        frame = weakSelf.tableView.frame;
        frame.size.height = weakSelf.view.frame.size.height - (weakSelf.chatInputView.frame.size.height + kbSize.height);
        weakSelf.tableView.frame = frame;
        [weakSelf scrollBottomWithAnimation:NO];
    }];
}

- (void)keyboardWillHiden:(NSNotification *)notification{
    NSTimeInterval curve = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] intValue];
    __weak GQMessageViewController *weakSelf = self;
    [UIView animateWithDuration:curve animations:^{
        //改变chatInputView的大小
        CGRect frame = weakSelf.chatInputView.frame;
        frame.origin.y = weakSelf.view.frame.size.height - frame.size.height;
        [weakSelf.chatInputView setFrame:frame];
        
        //改变tableView的大小
        frame = weakSelf.tableView.frame;
        frame.size.height = weakSelf.view.frame.size.height - weakSelf.chatInputView.frame.size.height;
        weakSelf.tableView.frame = frame;
        [weakSelf.tableView reloadData];
    }];
}

- (void)scrollBottomWithAnimation:(BOOL)animation{
    CGFloat height = self.tableView.frame.size.height;
    if (self.tableView.contentSize.height > height){
        [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, self.tableView.contentSize.height - height) animated:animation];
    }
}

#pragma mark - GQQuestionNoteViewDelegate
- (void)didReceiveMessage:(GQMessage *)message{
    //去服务器请求问题答案
    [self.messages addObject:message];
    [self.tableView reloadData];
    [self scrollBottomWithAnimation:YES];
}

#pragma mark - 请求接口

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
