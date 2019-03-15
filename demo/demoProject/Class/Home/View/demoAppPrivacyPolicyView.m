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
 *  File name       :      demoAppPrivacyPolicyView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoAppPrivacyPolicyView.h"
#import <WebKit/WebKit.h>
#import "demoPrivacyPolicyPathApi.h"
#import "demoPrivacyPolicyPathModel.h"

@interface demoAppPrivacyPolicyView ()

@property (strong, nonatomic) demoView *transparentView;
@property (strong, nonatomic) demoView *mainView;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation demoAppPrivacyPolicyView

#pragma mark - LifeCyle

- (id)init{
    if ((self = [super init])) {
        
        [self initSubViews];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        
        //[self initSubViews];
        
    }
    
    return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];


}

- (void)updateConstraints{

	[super updateConstraints];
}

- (void)removeFromSuperview{
	[super removeFromSuperview];

}

- (void)dealloc{

}


#pragma mark - Overwrite Super Class



#pragma mark - Response Mehtods



#pragma mark - Delegate



#pragma mark - Private Methods

/**
 * 初始化视图
 */
- (void)initSubViews{
    self.transparentView.alpha = 0;
    self.mainView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.alpha = 1;
        self.transparentView.alpha = 0.5;
    } completion:nil];
    
    /** 背景透明层 **/
    [self addSubview:self.transparentView];
    [self.transparentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    
    /** 弹框bgView **/
    [self addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(32);
        make.right.equalTo(self.right).offset(-32);
        make.centerY.equalTo(self.centerY);
    }];
    
    /** 内容webView **/
    [self.mainView addSubview:self.webView];
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.top).offset(16);
        make.left.equalTo(self.mainView.left).offset(16);
        make.right.equalTo(self.mainView.right).offset(-16);
        make.height.equalTo(kDeviceHeight * 0.6);
    }];
    
    /** 分割线 **/
    demoView *line = [[demoView alloc] init];
    line.backgroundColor = HEXCOLOR(0xe6e6e6);
    [self.mainView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.webView.bottom).offset(16);
        make.left.equalTo(self.mainView.left).offset(0);
        make.right.equalTo(self.mainView.right).offset(0);
        make.height.equalTo(1);
    }];
    
    /** 仅浏览按钮 **/
    demoButton *leftBtn = [[demoButton alloc] init];
    leftBtn.titleColor = HEXCOLOR(0x53a2fe);
    leftBtn.titleText =  @"仅浏览";
    [leftBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:leftBtn];
    [leftBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(0);
        make.left.equalTo(self.mainView.left).offset(0);
        make.bottom.equalTo(self.mainView.bottom).offset(0);
        make.height.equalTo(44);
    }];
    
    /** 竖线分割线 **/
    demoView *line2 = [[demoView alloc] init];
    line2.backgroundColor = HEXCOLOR(0xe6e6e6);
    [self.mainView addSubview:line2];
    [line2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(0);
        make.left.equalTo(leftBtn.right).offset(0);
        make.centerX.equalTo(self.mainView.centerX);
        make.bottom.equalTo(self.mainView.bottom).offset(0);
        make.width.equalTo(1);
    }];
    
    /** 同意按钮 **/
    demoButton *rightBtn = [[demoButton alloc] init];
    rightBtn.titleColor = HEXCOLOR(0x53a2fe);
    rightBtn.titleText =  @"同意";
    [rightBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:rightBtn];
    [rightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(0);
        make.left.equalTo(line2.right).offset(0);
        make.right.equalTo(self.mainView.right).offset(0);
        make.bottom.equalTo(self.mainView.bottom).offset(0);
        make.height.equalTo(44);
    }];
    
    [self getPrivacyPath];
}

- (void)goBack{
    
    [UIView animateWithDuration:.25 animations:^{
        self.transparentView.alpha = 0;
        self.mainView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)getPrivacyPath{
//    demoPrivacyPolicyPathApi *api = [[demoPrivacyPolicyPathApi alloc] init];
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
//        demoPrivacyPolicyPathModel *privacyPolicyModel = api.responseJSONModel;
//
//        NSURL *url = [NSURL URLWithString:privacyPolicyModel.privacyClausesHtml];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
//
//    } failure:nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bzjj_privacy_policy.html" ofType:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
}
#pragma mark - Public Methods


#pragma mark - Getters and Setters

- (demoView *)transparentView{
    if (!_transparentView){
        _transparentView = [[demoView alloc] init];
        _transparentView.backgroundColor = [UIColor blackColor];
        _transparentView.alpha = .5f;
        //UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
        //[_transparentView addGestureRecognizer:bgTap];
    }
    return _transparentView;
}

- (demoView *)mainView{
    if (!_mainView){
        _mainView = [[demoView alloc] init];
        _mainView.layer.cornerRadius = 6.f;
        _mainView.clipsToBounds = YES;
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
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
        
    }
    return _webView;
}
@end
