//
//  GTLoginViewController.m
//  GTalk
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 banwang. All rights reserved.
//

#import "GTLoginViewController.h"
#import "GTChatManager.h"
#import "GQMessageViewController.h"
#import "MQTTSession.h"

@interface GTLoginViewController ()<GTChatManagerDelagete>

@property (weak, nonatomic) IBOutlet UITextField *accounTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation GTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accounTextField.text = @"banwang811@127.0.0.1";
    self.passwordTextField.text = @"1";
    self.view.backgroundColor = [UIColor redColor];
    [GTChatManager shareManager].delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}


- (IBAction)loginClick:(UIButton *)sender {
    [[GTChatManager shareManager] login];
}

- (IBAction)logoutClick:(UIButton *)sender {
}

- (void)didConnected{
    GQMessageViewController *controller = [[GQMessageViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
