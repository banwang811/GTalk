//
//  ViewController.m
//  Guide
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 huajun. All rights reserved.
//

#import "GTGuideController.h"
#import "GTLoginViewController.h"

@interface GTGuideController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView         *webView;
@property (nonatomic, strong) UIView            *myview;


@end

@implementation GTGuideController

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, gScreenWidth, gScreenHeight)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.myview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myview];
    [self.view addSubview:self.webView];

    NSURL *path = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"ani"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"start"];
    if (range.location != NSNotFound) {
        GQAppDelegate.window.rootViewController = [GTLoginViewController new];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
