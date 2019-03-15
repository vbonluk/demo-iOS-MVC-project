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
 *  File name       :      demoAboutUsViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoAboutUsViewController.h"
#import "demoPrivacyPolicyPathApi.h"
#import "demoPrivacyPolicyPathModel.h"
#import <WebKit/WebKit.h>

@interface demoAboutUsViewController ()

@property (strong, nonatomic) demoPrivacyPolicyPathModel *model;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation demoAboutUsViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initPageView];
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

#pragma mark - Overwrite Super Class



#pragma mark - Response Mehtods



#pragma mark - Delegate



#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    [super initPageView];
    
    self.navView.navTitleView.title = @"关于我们";
    
    /** 内容webView **/
    [self.contentView addSubview:self.webView];
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(0);
        make.left.equalTo(self.contentView.left).offset(16);
        make.right.equalTo(self.contentView.right).offset(-16);
    }];
    
    demoLabel *versionLabel = [[demoLabel alloc] init];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    versionLabel.text = [NSString stringWithFormat:@"版本号：%@",appVersion];
    [self.contentView addSubview:versionLabel];
    [versionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.bottom).offset(16);
        make.left.equalTo(self.contentView.left).offset(0);
        make.right.equalTo(self.contentView.right).offset(0);
        make.bottom.equalTo(self.contentView.bottom).offset(-16);
    }];
    
    [self pullRequest];
}

/**
 *  请求数据
 */
- (void)pullRequest{
    [super pullRequest];

    demoPrivacyPolicyPathApi *api = [[demoPrivacyPolicyPathApi alloc] init];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self loadDataWithApi:(demoBaseService *)request];
    } failure:nil];
    
}

/**
 加载数据到页面
 
 @param api demoBaseService
 */
- (void)loadDataWithApi:(demoBaseService *)api{
    [super loadDataWithApi:api];
    
    self.model = api.responseJSONModel;
    
    NSURL *url = [NSURL URLWithString:self.model.aboutUsHtml];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];

}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

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
        
    }
    return _webView;
}


@end
