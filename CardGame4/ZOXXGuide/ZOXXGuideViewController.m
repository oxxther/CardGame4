//
//  ZOXXGuideViewController.m
//  CardGame4
//
//  Created by macos on 2020/4/23.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXGuideViewController.h"
#import <WebKit/WebKit.h>

@interface ZOXXGuideViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *BackBar;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic) WKWebView *webView;

@end

@implementation ZOXXGuideViewController

- (instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.backBtn.adjustsImageWhenHighlighted = NO;
    WKWebViewConfiguration *wc = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wc];
    self.webView = webView;
    webView.scrollView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:webView];
    
    NSString *bundleStr = [[NSBundle mainBundle] pathForResource:@"xinshouyindao" ofType:@"html"];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:bundleStr]]];
   
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.BackBar.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(self.BackBar.frame));
}

- (IBAction)click2Begin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
