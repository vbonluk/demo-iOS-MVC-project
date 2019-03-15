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
 *  File name       :      demoLoginViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoLoginViewController.h"
#import "demoLoginPostApi.h"
#import "demoLoginModel.h"
#import <YYText/YYText.h>
#import "demoWebViewController.h"
#import "SkyAssociationMenuView.h"
#import "demoSendVerificationCodeApi.h"
#import "demoPrivacyPolicyPathApi.h"
#import "demoPrivacyPolicyPathModel.h"

@interface demoLoginViewController ()

@property (strong, nonatomic) demoLoginModel *loginModel;
@property (strong, nonatomic) demoPrivacyPolicyPathModel *privacyPolicyModel;

@property (strong, nonatomic) demoLabel *countryLabel;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *verificationCodeTextField;
@property (strong, nonatomic) demoButton *verificationCodeBtn;
@property (strong, nonatomic) demoButton *loginBtn;
@property (strong, nonatomic) demoLabel *quhaoTitleLabel;

@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation demoLoginViewController

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
    
    self.navView.navTitleView.title = @"";
    
    UIView *baseView = self.contentView;
    
    UIImageView *topImg = [[UIImageView alloc] init];
    topImg.image = [UIImage imageNamed:@"loginLogo"];
    [baseView addSubview:topImg];
    [topImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView.top).offset(80);
        make.left.equalTo(baseView.left).offset(25);
    }];
    
    demoView *areaView = [[demoView alloc] init];
    [baseView addSubview:areaView];
    [areaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImg.bottom).offset(30);
        make.left.equalTo(baseView.left).offset(30);
        make.right.equalTo(baseView.right).offset(-30);
        make.height.equalTo(44);
    }];
    
    /** 左边标题栏 **/
    demoLabel *areaTitleLabel = [[demoLabel alloc] init];
    areaTitleLabel.text = @"国家/地区";
    [areaView addSubview:areaTitleLabel];
    [areaTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(areaView.left).offset(0);
        make.centerY.equalTo(areaView.centerY);
    }];
    /** 竖线 **/
    demoView *shuxian_1 = [[demoView alloc] init];
    shuxian_1.backgroundColor = HEXCOLOR(0xdfdfdf);
    [areaView addSubview:shuxian_1];
    [shuxian_1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(areaTitleLabel.right).offset(8);
        make.centerY.equalTo(areaView.centerY).offset(0);
        make.height.equalTo(15);
        make.width.equalTo(1);
    }];
    /** 右边label **/
    [areaView addSubview:self.countryLabel];
    [self.countryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shuxian_1.right).offset(8);
        make.centerY.equalTo(areaView.centerY);
    }];
    /** 右边的箭头 **/
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.image = [UIImage imageNamed:@"more"];
    [areaView addSubview:rightImg];
    [rightImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.countryLabel.right).offset(0);
        make.right.equalTo(areaView.right).offset(0);
        make.centerY.equalTo(areaView.centerY);
    }];
    [rightImg setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    /** 底部横线 **/
    demoView *line_1 = [[demoView alloc] init];
    line_1.backgroundColor = shuxian_1.backgroundColor;
    [areaView addSubview:line_1];
    [line_1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(areaView.left).offset(0);
        make.right.equalTo(areaView.right).offset(0);
        make.bottom.equalTo(areaView.bottom).offset(0);
        make.height.equalTo(1);
    }];
    
    /** 国家/地区的按钮 **/
    demoButton *areaBtn = [[demoButton alloc] init];
    [areaBtn addTarget:self action:@selector(clickArea) forControlEvents:UIControlEventTouchUpInside];
    [areaView addSubview:areaBtn];
    [areaBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaView.top).offset(0);
        make.left.equalTo(areaView.left).offset(0);
        make.right.equalTo(areaView.right).offset(0);
        make.bottom.equalTo(areaView.bottom).offset(0);
    }];
    
    /** 手机号码bgView **/
    demoView *phoneView = [[demoView alloc] init];
    [baseView addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(areaView.bottom).offset(16);
        make.left.equalTo(baseView.left).offset(30);
        make.right.equalTo(baseView.right).offset(-30);
        make.height.equalTo(44);
    }];
    
    /** 左边标题栏 **/
    [phoneView addSubview:self.quhaoTitleLabel];
    [self.quhaoTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView.left).offset(0);
        make.centerY.equalTo(phoneView.centerY);
    }];
    /** 竖线 **/
    demoView *shuxian_2 = [[demoView alloc] init];
    shuxian_2.backgroundColor = HEXCOLOR(0xdfdfdf);
    [phoneView addSubview:shuxian_2];
    [shuxian_2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.quhaoTitleLabel.right).offset(8);
        make.centerY.equalTo(phoneView.centerY).offset(0);
        make.centerX.equalTo(shuxian_1.centerX);
        make.height.equalTo(15);
        make.width.equalTo(1);
    }];
    /** 右边输入框 **/
    [phoneView addSubview:self.phoneTextField];
    [self.phoneTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.top).offset(0);
        make.left.equalTo(shuxian_2.right).offset(8);
        make.right.equalTo(phoneView.right).offset(0);
        make.bottom.equalTo(phoneView.bottom).offset(0);
    }];
    
    /** 底部横线 **/
    demoView *line_2 = [[demoView alloc] init];
    line_2.backgroundColor = shuxian_1.backgroundColor;
    [phoneView addSubview:line_2];
    [line_2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView.left).offset(0);
        make.right.equalTo(phoneView.right).offset(0);
        make.bottom.equalTo(phoneView.bottom).offset(0);
        make.height.equalTo(1);
    }];
    
    /** 验证码bgView **/
    demoView *verificationCodeBgView = [[demoView alloc] init];
    [baseView addSubview:verificationCodeBgView];
    [verificationCodeBgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom).offset(16);
        make.left.equalTo(baseView.left).offset(30);
        make.right.equalTo(baseView.right).offset(-30);
        make.height.equalTo(44);
    }];
    /** 左边标题栏 **/
    demoLabel *verificationCodeTitleLabel = [[demoLabel alloc] init];
    verificationCodeTitleLabel.text = @"验证码";
    [verificationCodeBgView addSubview:verificationCodeTitleLabel];
    [verificationCodeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verificationCodeBgView.left).offset(0);
        make.centerY.equalTo(verificationCodeBgView.centerY);
    }];
    /** 竖线 **/
    demoView *shuxian_3 = [[demoView alloc] init];
    shuxian_3.backgroundColor = HEXCOLOR(0xdfdfdf);
    [verificationCodeBgView addSubview:shuxian_3];
    [shuxian_3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verificationCodeTitleLabel.right).offset(8);
        make.centerY.equalTo(verificationCodeBgView.centerY).offset(0);
        make.centerX.equalTo(shuxian_1.centerX);
        make.height.equalTo(15);
        make.width.equalTo(1);
    }];
    
    /** 右边验证码按钮 **/
    [verificationCodeBgView addSubview:self.verificationCodeBtn];
    [self.verificationCodeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationCodeBgView.top).offset(0);
        make.right.equalTo(verificationCodeBgView.right).offset(0);
        make.bottom.equalTo(verificationCodeBgView.bottom).offset(0);
        make.width.equalTo(100);
    }];
    
    /** 右边输入框 **/
    [verificationCodeBgView addSubview:self.verificationCodeTextField];
    [self.verificationCodeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationCodeBgView.top).offset(0);
        make.left.equalTo(shuxian_3.right).offset(8);
        make.right.equalTo(self.verificationCodeBtn.left).offset(0);
        make.bottom.equalTo(verificationCodeBgView.bottom).offset(0);
    }];
    
    /** 底部横线 **/
    demoView *line_3 = [[demoView alloc] init];
    line_3.backgroundColor = shuxian_1.backgroundColor;
    [verificationCodeBgView addSubview:line_3];
    [line_3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verificationCodeBgView.left).offset(0);
        make.right.equalTo(self.verificationCodeBtn.left).offset(-8);
        make.bottom.equalTo(verificationCodeBgView.bottom).offset(0);
        make.height.equalTo(1);
    }];
    
    /** 条款label **/
    YYLabel *tiaokuanLabel = [[YYLabel alloc] init];
    tiaokuanLabel.numberOfLines = 0;
    tiaokuanLabel.font = kIAFontSmall;
    tiaokuanLabel.textColor = HEXCOLOR(0x333333);
    tiaokuanLabel.preferredMaxLayoutWidth = kDeviceWidth - 60;
    NSString *tiaokuan_string = @"未注册账号的手机号，登录时将自动注册，并视为同意《用户服务协议》、《隐私政策》";
    tiaokuanLabel.text = tiaokuan_string;
    [baseView addSubview:tiaokuanLabel];
    [tiaokuanLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificationCodeBgView.bottom).offset(16);
        make.left.equalTo(verificationCodeBgView.left).offset(0);
        make.right.equalTo(verificationCodeBgView.right).offset(0);
    }];
    
    YYTextHighlight *highlight_1 = [[YYTextHighlight alloc] init];
    highlight_1.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击《用户服务协议》
        [self clickUserServiceProtocol];
    };
    YYTextHighlight *highlight_2 = [[YYTextHighlight alloc] init];
    highlight_2.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        //点击《隐私政策》
        [self clickPrivacyPolicy];
    };
    NSRange range1 = [tiaokuan_string rangeOfString:@"《用户服务协议》"];
    NSRange range2 = [tiaokuan_string rangeOfString:@"《隐私政策》"];
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:tiaokuan_string];
    [attributed yy_setTextHighlight:highlight_1 range:range1];
    [attributed yy_setTextHighlight:highlight_2 range:range2];
    [attributed yy_setColor:HEXCOLOR(0x53a2fe) range:range1];
    [attributed yy_setColor:HEXCOLOR(0x53a2fe) range:range2];
    tiaokuanLabel.attributedText = attributed;
    
    
    /** 登录按钮 **/
    [baseView addSubview:self.loginBtn];
    [self.loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tiaokuanLabel.bottom).offset(50);
        make.left.equalTo(verificationCodeBgView.left).offset(0);
        make.right.equalTo(verificationCodeBgView.right).offset(0);
        make.bottom.lessThanOrEqualTo(baseView.bottom).offset(-30);
        make.height.equalTo(44);
    }];
    
    [self pullRequest];
}

/**
 *  请求数据
 */
- (void)pullRequest{
    [super pullRequest];

    demoPrivacyPolicyPathApi *api = [[demoPrivacyPolicyPathApi alloc] init];
    api.animatingText = @"正在加载";
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
    
    if ([api isKindOfClass:demoLoginPostApi.class]) {
        /** 登录成功 **/
        self.loginModel = api.responseJSONModel;
        
        if (self.loginModel.status == 1 || self.loginModel.status == 2) {
            if ([StringUtil empty:self.loginModel.token] == NO) {
                if ([StringUtil empty:self.loginModel.message] == NO) {
                    [demoHudHelper showHudWithText:self.loginModel.message isStay:NO];
                }
                [demoUserInfoManager saveUserInfoModelWithKey:@"token" value:self.loginModel.token];
                NSString *phoneNumber = self.loginModel.phoneNumber;
                if ([StringUtil empty:phoneNumber] == NO) {
                    [api apServiceSetLoginTag:@"alreadyLogin" alias:phoneNumber];
                }
                [self goBack];
                if (self.loginSuccessBlock) {
                    self.loginSuccessBlock();
                }
            }
        }else{
            [demoHudHelper showHudWithText:self.loginModel.message isStay:NO];
        }
    }else if ([api isKindOfClass:[demoPrivacyPolicyPathApi class]]){
        self.privacyPolicyModel = api.responseJSONModel;
        
        
    }


}

/**
 是否隐藏自定义导航栏
 
 @return YES为隐藏，NO为不隐藏，默认NO
 */
- (BOOL)navigationHidden{
    return YES;
}

/**
 点击国家地区
 */
- (void)clickArea{
    [self.contentView endEditing:YES];
    NSArray *arr2 = [NSArray arrayWithObjects:@"中国" , @"香港(中国)" ,@"澳门(中国)", nil];
    NSInteger selected = 0;
    if ([self.quhaoTitleLabel.text isEqualToString:@"+86"]) {
        selected = 0;
    } else if ([self.quhaoTitleLabel.text isEqualToString:@"+852"]) {
        selected = 1;
    }else{
        selected = 2;
    }
    __block typeof(self) blockSelf = self;
    SkyAssociationMenuView *saView = [[SkyAssociationMenuView alloc] init];
    [saView showViewWithRows:@[arr2] initialSelection:@[@(selected)] doneBlock:^(SkyAssociationMenuView *saView, NSArray *selectedIndexes, id selectedValues) {
        if (selectedIndexes.count != 0) {
            NSInteger selected = [[selectedIndexes firstObject] integerValue];
            if (selected == 0) {
                blockSelf.quhaoTitleLabel.text = @"+86";
                blockSelf.countryLabel.text = @"中国";
            } else if (selected == 1){
                blockSelf.quhaoTitleLabel.text = @"+852";
                blockSelf.countryLabel.text = @"香港";
            }else{
                blockSelf.quhaoTitleLabel.text = @"+853";
                blockSelf.countryLabel.text = @"澳门";
            }
        }
    } cancelBlock:nil origin:self.view selectedBlock:nil];
}

/**
 点击验证码按钮
 */
- (void)clickVerificationCode:(demoButton *)verificationCodeBtn{
    [self.contentView endEditing:YES];
    
    BOOL isSended = [self getVerificationCode];
    if (isSended == NO) {
        return;
    }
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [verificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                verificationCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [verificationCodeBtn setTitle:[NSString stringWithFormat:@"(%@)重新发送",strTime] forState:UIControlStateNormal];
                //To do
                [UIView commitAnimations];
                verificationCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

/**
 获取验证码
 */
- (BOOL)getVerificationCode{
    if ([ValidateUtil validateMobileNumberFormat:self.phoneTextField.text] == NO) {
        [demoHudHelper showHudWithText:@"请正确填写手机号码" isStay:NO];
        return NO;
    }
    NSString *quhao = [self.quhaoTitleLabel.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    demoSendVerificationCodeApi *api = [[demoSendVerificationCodeApi alloc] initWithPhoneAreaCode:quhao phoneNumber:self.phoneTextField.text];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [demoHudHelper showHudWithText:@"发送成功" isStay:NO];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        __weak typeof(self) weakSelf = self;
        dispatch_source_cancel(weakSelf.timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.verificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            self.verificationCodeBtn.userInteractionEnabled = YES;
        });
    }];
    
    return YES;
}

/**
 登录
 */
- (void)clickLogin{
    if ([ValidateUtil validateMobileNumberFormat:self.phoneTextField.text] == NO) {
        [demoHudHelper showHudWithText:@"请正确填写手机号码" isStay:NO];
        return;
    }
    if ([StringUtil empty:self.verificationCodeTextField.text]) {
        [demoHudHelper showHudWithText:@"请填写验证码" isStay:NO];
        return;
    }
    NSString *quhao = [self.quhaoTitleLabel.text stringByReplacingOccurrencesOfString:@"+" withString:@""];
    demoLoginPostApi *api = [[demoLoginPostApi alloc] initWithPhoneAreaCode:quhao phoneNumber:self.phoneTextField.text verifyCode:self.verificationCodeTextField.text];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self loadDataWithApi:(demoBaseService *)request];
    } failure:nil];
    
}

/**
 点击《用户服务协议》
 */
- (void)clickUserServiceProtocol{
    [self.contentView endEditing:YES];
    NSString *url = self.privacyPolicyModel.serverClausesHtml;
    if ([StringUtil empty:url] == NO) {
        demoWebViewController *webVC = [[demoWebViewController alloc] init];
        webVC.navView.navTitleView.title = @"用户服务协议";
        webVC.urlString = url;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [self pullRequest];
    }
}
/**
 点击《隐私政策》
 */
- (void)clickPrivacyPolicy{
    [self.contentView endEditing:YES];
    NSString *url = self.privacyPolicyModel.privacyClausesHtml;
    if ([StringUtil empty:url] == NO) {
        demoWebViewController *webVC = [[demoWebViewController alloc] init];
        webVC.navView.navTitleView.title = @"隐私政策";
        webVC.urlString = url;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else{
        [self pullRequest];
    }
}

- (void)apiCallBackErrorWithResultCode:(demoResultCode)resultCode api:(demoBaseService *)api{
    [super apiCallBackErrorWithResultCode:resultCode api:api];
    
    if ([api isKindOfClass:[demoSendVerificationCodeApi class]]) {
        
        __weak typeof(self) weakSelf = self;
        dispatch_source_cancel(weakSelf.timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.verificationCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
            self.verificationCodeBtn.userInteractionEnabled = YES;
        });
    }
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoLabel *)countryLabel{
    if (!_countryLabel){
        _countryLabel = [[demoLabel alloc] init];
        _countryLabel.text = @"中国";
    }
    return _countryLabel;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField){
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.placeholder = @"请填写手机号码";
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _phoneTextField;
}

- (UITextField *)verificationCodeTextField{
    if (!_verificationCodeTextField){
        _verificationCodeTextField = [[UITextField alloc] init];
        _verificationCodeTextField.placeholder = @"请填写";
        _verificationCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _verificationCodeTextField;
}

- (demoButton *)verificationCodeBtn{
    if (!_verificationCodeBtn){
        _verificationCodeBtn = [[demoButton alloc] init];
        _verificationCodeBtn.titleText = @"发送验证码";
        _verificationCodeBtn.cornerRadius = 3.f;
        _verificationCodeBtn.layer.borderWidth = 1.f;
        _verificationCodeBtn.layer.borderColor = kIAThemeColor.CGColor;
        _verificationCodeBtn.titleColor = kIAThemeColor;
        _verificationCodeBtn.fontSize = 13;
        [_verificationCodeBtn addTarget:self action:@selector(clickVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationCodeBtn;
}

- (demoButton *)loginBtn{
    if (!_loginBtn){
        _loginBtn = [[demoButton alloc] init];
        _loginBtn.titleText = @"登  录";
        _loginBtn.backgroundColor = kIAThemeColor;
        _loginBtn.cornerRadius = 22.f;
        _loginBtn.titleColor = [UIColor whiteColor];
        [_loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (demoLabel *)quhaoTitleLabel{
    if (!_quhaoTitleLabel){
        _quhaoTitleLabel = [[demoLabel alloc] init];
        _quhaoTitleLabel.text = @"+86";
    }
    return _quhaoTitleLabel;
}

@end
