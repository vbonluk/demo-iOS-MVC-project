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
 *  File name       :      demoChangeUserNameViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoChangeUserNameViewController.h"
#import "demoChangeUserNameApi.h"

@interface demoChangeUserNameViewController ()

@property (strong, nonatomic) UITextField *userNameTextField;

@end

@implementation demoChangeUserNameViewController

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
    
    self.navView.navTitleView.title = @"修改姓名";
    
    self.contentView.backgroundColor = HEXCOLOR(0xf4f4f4);
    
    UIView *baseView = self.contentView;
    [baseView addSubview:self.userNameTextField];
    [self.userNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView.top).offset(20);
        make.left.equalTo(baseView.left).offset(10);
        make.right.equalTo(baseView.right).offset(-10);
        make.height.equalTo(44);
    }];
    
    [self.userNameTextField becomeFirstResponder];
    
    demoButton *saveBtn = [[demoButton alloc] init];
    saveBtn.titleText = @"保存";
    saveBtn.backgroundColor = kIAThemeColor;
    saveBtn.cornerRadius = 6.f;
    [saveBtn addTarget:self action:@selector(clickSave) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:saveBtn];
    [saveBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameTextField.bottom).offset(30);
        make.left.equalTo(baseView.left).offset(10);
        make.right.equalTo(baseView.right).offset(-10);
        make.height.equalTo(44);
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

/**
 保存
 */
- (void)clickSave{
    [self.userNameTextField resignFirstResponder];
    if ([StringUtil empty:self.userNameTextField.text]) {
        [demoHudHelper showHudWithText:@"请填写姓名" isStay:NO];
        return;
    }
    demoChangeUserNameApi *api = [[demoChangeUserNameApi alloc] initWithUserName:self.userNameTextField.text];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [demoHudHelper showHudWithText:@"保存成功" isStay:NO hideCompletionBlock:^{        
            [self goBack];
        }];
    } failure:nil];
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (UITextField *)userNameTextField{
    if (!_userNameTextField){
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.layer.cornerRadius = 6.f;
        _userNameTextField.clipsToBounds = YES;
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        if ([StringUtil empty:infoModel.userName] == NO) {
            _userNameTextField.placeholder = infoModel.userName;
        }else{
            _userNameTextField.placeholder = @"请输入";
        }
    }
    return _userNameTextField;
}


@end
