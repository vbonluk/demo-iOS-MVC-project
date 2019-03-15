/*
 *
 *
 *               dddddddd
 *               d::::::d
 *               d::::::d
 *               d::::::d
 *               d:::::d
 *       ddddddddd:::::d     eeeeeeeeeeee       mmmmmmm    mmmmmmm      ooooooooooo
 *     dd::::::::::::::d   ee::::::::::::ee   mm:::::::m  m:::::::mm  oo:::::::::::oo
 *    d::::::::::::::::d  e::::::eeeee:::::eem::::::::::mm::::::::::mo:::::::::::::::o
 *   d:::::::ddddd:::::d e::::::e     e:::::em::::::::::::::::::::::mo:::::ooooo:::::o
 *   d::::::d    d:::::d e:::::::eeeee::::::em:::::mmm::::::mmm:::::mo::::o     o::::o
 *   d:::::d     d:::::d e:::::::::::::::::e m::::m   m::::m   m::::mo::::o     o::::o
 *   d:::::d     d:::::d e::::::eeeeeeeeeee  m::::m   m::::m   m::::mo::::o     o::::o
 *   d:::::d     d:::::d e:::::::e           m::::m   m::::m   m::::mo::::o     o::::o
 *   d::::::ddddd::::::dde::::::::e          m::::m   m::::m   m::::mo:::::ooooo:::::o
 *    d:::::::::::::::::d e::::::::eeeeeeee  m::::m   m::::m   m::::mo:::::::::::::::o
 *     d:::::::::ddd::::d  ee:::::::::::::e  m::::m   m::::m   m::::m oo:::::::::::oo
 *      ddddddddd   ddddd    eeeeeeeeeeeeee  mmmmmm   mmmmmm   mmmmmm   ooooooooooo
 *
 *
 *  File created    :      2019/03/15
 *  File name       :      demoBaseWebViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoBaseWebViewController.h"
#import <YLProgressBar.h>

@interface demoBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) YLProgressBar *loadingPageProgressBar;
@property (strong, nonatomic) demoButton *refreshBtn;

@end

@implementation demoBaseWebViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //[self initPageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)updateViewConstraints{
    
    
    
    
    [super updateViewConstraints];
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [self removeAllScriptMsgHandle];
}

#pragma mark - Overwrite Super Class



#pragma mark - Response Mehtods



#pragma mark - Delegate

/** WKNavigationDelegate **/
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // 页面开始加载时调用
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    // 页面加载失败时调用
    [self.loadingPageProgressBar setProgress:0.0f animated:NO];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    // 当内容开始返回时调用
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // 页面加载完成之后调用
    // 获取页面title。
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if (!error) {
            if ([data isKindOfClass:NSString.class]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navView.navTitleView.title = (NSString *)data;
                });
            }
        }
    }];
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    //提交发生错误时调用
    [self.loadingPageProgressBar setProgress:0.0f animated:NO];
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    // 接收到服务器跳转请求即服务重定向时之后调用
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    
    NSString * urlStr = navigationAction.request.URL.absoluteString;
    //DDLogWarn(@"发送跳转请求：%@",urlStr);
    //自己定义的协议头
    NSString *htmlHeadString = @"test://";
    if([urlStr hasPrefix:htmlHeadString]){
        /** 拦截路径跳转原生页面 **/
        
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    
    //NSString * urlStr = navigationResponse.response.URL.absoluteString;
    //DDLogWarn(@"当前跳转地址：%@",urlStr);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //需要响应身份验证时调用 同样在block中需要传入用户身份凭证
    //用户身份信息
    NSURLCredential * newCred = [[NSURLCredential alloc] initWithUser:@"user123" password:@"123" persistence:NSURLCredentialPersistenceNone];
    //为 challenge 的发送方提供 credential
    [challenge.sender useCredential:newCred forAuthenticationChallenge:challenge];
    completionHandler(NSURLSessionAuthChallengeUseCredential,newCred);
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    //进程被终止时调用
}

/** WKUIDelegate **/


/** WKUserContentController delegate **/
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;{
    // JS调用OC 代理
    
    DDLogWarn(@"%@",NSStringFromSelector(_cmd));
    DDLogWarn(@"%@",message.body);
    
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showAlertString:@"没有参数"];
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        NSString *info = [NSString stringWithFormat:@"%@",message.body];
        [self showAlertString:info];
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        NSArray *array = message.body;
        NSString *info = [NSString stringWithFormat:@"有两个参数: %@, %@ !!",array.firstObject,array.lastObject];
        [self showAlertString:info];
    }
    
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    [super initPageView];
    
    //self.navView.navTitleView.title = @"";
    
    /** 移除base的scrollView **/
    [self.scrollerView removeFromSuperview];
    
    /** 底部栏 **/
    CGFloat tabHeight = demoTabBarHeight;
    if (self.tabBarController.tabBar.hidden == YES || self.hidesBottomBarWhenPushed == YES) {
        tabHeight = 0;
    }
    /** webView **/
    [self.view addSubview:self.webView];
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0,*)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(demoNavHeight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        }else{
            make.top.equalTo(self.view.top).offset(demoNavHeight + demoStatusHeight);
            make.bottom.equalTo(self.view.bottom).offset(-tabHeight);
        }
        
        
    }];
    
    /** ProgressBar **/
    [self.view addSubview:self.loadingPageProgressBar];
    [self.loadingPageProgressBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.top).offset(0);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.height.equalTo(1);
    }];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    /** 刷新按钮 **/
    [self.navView addSubview:self.refreshBtn];
    [self.refreshBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.backBtnView.top).offset(0);
        make.right.equalTo(self.navView.right).offset(0);
        make.bottom.equalTo(self.navView.backBtnView.bottom).offset(0);
        make.width.equalTo(50);
    }];
    
    [self pullRequest];
}

/**
 *  请求数据
 */
- (void)pullRequest{
    [super pullRequest];

    
}

/**
 加载数据到页面
 
 @param api demoBaseService
 */
- (void)loadDataWithApi:(demoBaseService *)api{
    [super loadDataWithApi:api];
    
    
    

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.loadingPageProgressBar setAlpha:1.0f];
        [self.loadingPageProgressBar setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress  >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.loadingPageProgressBar setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.loadingPageProgressBar setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/**
 点击刷新
 */
- (void)clickRefresh{
    if (self.webView.loading == NO) {
        [self.webView reload];
    }
}

#pragma mark - Public Methods

- (void)loadWebPageWithUrlString:(NSString *)urlString;{
    /*
    // 测试专用
    if (0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testOC&JS" ofType:@"html"];
        NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
        [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
        return;
    }
     */
    
    
    if ([StringUtil empty:urlString] == NO) {
        self.urlString = urlString;
        NSURL *url = [NSURL URLWithString:self.urlString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

/**
 处理网页弹框
 */
- (void)showAlertString:(NSString *)alertString{
    [demoHudHelper showHudWithText:alertString isStay:NO];
}

/**
 移除所有脚本处理器
 */
- (void)removeAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"showMobile"];
    [controller removeScriptMessageHandlerForName:@"showName"];
    [controller removeScriptMessageHandlerForName:@"showSendMsg"];
}

#pragma mark - Getters and Setters
- (void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    NSURL *url = [NSURL URLWithString:self.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (WKWebView *)webView{
    if (!_webView){
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 最小字体默认为0
        config.preferences.minimumFontSize = 10;
        // 是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        WKUserContentController *userCC = config.userContentController;
        //JS调用OC 添加处理脚本
        [userCC addScriptMessageHandler:self name:@"showMobile"];
        [userCC addScriptMessageHandler:self name:@"showName"];
        [userCC addScriptMessageHandler:self name:@"showSendMsg"];
        
    }
    return _webView;
}

- (YLProgressBar *)loadingPageProgressBar{
    if (!_loadingPageProgressBar){
        _loadingPageProgressBar = [[YLProgressBar alloc] init];
        _loadingPageProgressBar.type               = YLProgressBarTypeFlat;
        _loadingPageProgressBar.progressTintColor  = kIAThemeColor;
        _loadingPageProgressBar.hideStripes        = YES;
        _loadingPageProgressBar.trackTintColor = [UIColor clearColor];
        _loadingPageProgressBar.uniformTintColor = YES;
    }
    return _loadingPageProgressBar;
}

- (demoButton *)refreshBtn{
    if (!_refreshBtn){
        _refreshBtn = [[demoButton alloc] init];
        [_refreshBtn setImage:[UIImage imageNamed:@"WebViewRefresh"] forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(clickRefresh) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

@end
