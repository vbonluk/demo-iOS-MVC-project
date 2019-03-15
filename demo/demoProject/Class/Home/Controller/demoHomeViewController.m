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
 *  File name       :      demoHomeViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoHomeViewController.h"
#import "demoHomeSearchView.h"
#import "demoHomeApi.h"
#import "demoHomeProjectListHeaderView.h"
#import "demoHomeProjectCell.h"
#import "demoLocationManager.h"
#import "demoAppPrivacyPolicyView.h"
#import "demoHomeAskingView.h"
#import "demoWebViewController.h"
#import "demoCheckAppUpdateApi.h"
#import "demoCheckAppUpdateModel.h"
#import "demoAppUpdateView.h"

@interface demoHomeViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) demoHomeSearchView *searchBarView;
@property (strong, nonatomic) demoHomeModel *model;
@property (strong, nonatomic) demoHomeProjectListHeaderView *projectListHeeaderView;
@property (strong, nonatomic) UIView *footerView;
/** 当前请求的类型索引 **/
@property (assign, nonatomic) NSInteger currentRequestIndex;// default is 0 精选
/** 没有定位信息的请求 **/
@property (strong, nonatomic) demoHomeApi *apiWithoutLocation;
/** 首页提问弹框 **/
@property (strong, nonatomic) demoHomeAskingView *askingView;

@end

@implementation demoHomeViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
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

// tableView dataSources && delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *cellID = @"demoHomeProjectCell";
    demoHomeProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[demoHomeProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = self.listArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"demoHomeProjectCell" configuration:^(demoHomeProjectCell* cell) {
        cell.model = self.listArray[indexPath.row];
    }];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    demoHomeProjectModel *model = self.listArray[indexPath.row];
    
    
}

// UISearchBar代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;{
    
    return NO;
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    [super initPageView];
    
    self.navView.hidden = YES;
    
    self.mainTableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self.mainTableView registerClass:[demoHomeProjectCell class] forCellReuseIdentifier:@"demoHomeProjectCell"];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = kIAThemeColor;
    
    [self.view addSubview:bgColorView];
    [self.view addSubview:self.searchBarView];
    
    [bgColorView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.self.searchBarView.top).offset(0);
        make.height.equalTo(100);
    }];
    
    [self.searchBarView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.safeAreaLayoutGuideTop).offset(0);
            make.height.equalTo(56);
        } else {
            make.top.equalTo(self.view).offset(20);
            make.height.equalTo(44);
        }
        
    }];
    
    [self.mainTableView updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBarView.bottom).priorityHigh();
    }];
    
    /** headerView **/
    self.mainTableView.tableHeaderView = self.projectListHeeaderView;
    
    NSString *privacyPolicyMark = [demoUserDefaultManager getUserDefaultWithKey:kPrivacyPolicyMark];
    if ([privacyPolicyMark integerValue] == 0) {
        /** 隐私协议弹框 **/
        demoAppPrivacyPolicyView *privacyPolicyView = [[demoAppPrivacyPolicyView alloc] init];
        UIView *tipBgView = [[UIApplication sharedApplication] keyWindow];
        [tipBgView addSubview:privacyPolicyView];
        [privacyPolicyView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tipBgView.top).offset(0);
            make.left.equalTo(tipBgView.left).offset(0);
            make.right.equalTo(tipBgView.right).offset(0);
            make.bottom.equalTo(tipBgView.bottom).offset(0);
        }];
        
        [demoUserDefaultManager setUserDefaultWithKey:kPrivacyPolicyMark value:@"1"];
    }
    
//    CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
//    if (self.tabBarController.tabBar.hidden == YES || self.hidesBottomBarWhenPushed == YES) {
//        tabHeight = 0;
//    }
//    /** 底部提问view **/
//    [self.view addSubview:self.askingView];
//    [self.askingView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.left).offset(10);
//        make.right.equalTo(self.view.right).offset(-10);
//        make.bottom.equalTo(self.view.bottom).offset(-tabHeight-20);
//    }];
    
    [self checkVersionUpdate];
    
//    /** JPUSH 设置alias**/
//    demoUserInfoModel *userInfoModel = [demoUserInfoManager getUserInfoModel];
//    if (userInfoModel) {
//        NSString *phoneNumber = userInfoModel.userPhone;
//        if ([StringUtil empty:phoneNumber] == NO) {
//            demoBaseService *baseApi = [[demoBaseService alloc] init];
//            [baseApi apServiceSetLoginTag:@"alreadyLogin" alias:phoneNumber];
//        }
//    }
    
    [self pullRequest];
}

/**
 *  加载分页数据
 *  此方法分页专用，用于一个分页列表页面含有多个请求时，区分开分页请求和其他非分页请求
 */
- (void)pullRequestPage{
    [super pullRequestPage];
    
    [self pullRequestWithIndex:self.currentRequestIndex];
}
/**
 *  请求数据
 */
- (void)pullRequestWithIndex:(NSInteger)index{
    
    NSString *projectType = @"";
    switch (index) {
        case 0:
            //默认,精选为空
            projectType = @"";
            break;
        case 1:
            projectType = @"住宅";
            break;
        case 2:
            projectType = @"商业";
            break;
        default:
            //默认,精选为空
            projectType = @"";
            break;
    }
    /** 进行无定位信息请求 **/
    self.apiWithoutLocation = [[demoHomeApi alloc] initWithLatitude:@"" longitude:@"" projectType:projectType];
    //api.animatingText = @"正在加载";
    [self.apiWithoutLocation startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self loadPageDataWithApi:(demoBaseService *)request];
    } failure:nil];
    
    demoLocationManager *locationManager = [[demoLocationManager alloc] init];
    [locationManager startSingleLocationWithCompletionBlock:^(CLLocation * _Nonnull location) {
        /** 进行有定位信息的请求 **/
        if (location.coordinate.latitude == 0 && location.coordinate.longitude == 0) {
            //获取定位最终还是失败,信号弱或者用户关闭权限
        } else {
            [self.apiWithoutLocation stop];
            NSString *true_latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            NSString *true_longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
            demoHomeApi *api = [[demoHomeApi alloc] initWithLatitude:true_latitude longitude:true_longitude projectType:projectType];
            //api.animatingText = @"正在加载";
            [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
                // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
                [self.listArray removeAllObjects];
                [self loadPageDataWithApi:(demoBaseService *)request];
            } failure:nil];
        }
    }];
    
}
/**
 加载分页数据到页面
 
 此方法用于区别不是分页列表的请求回调loadDataWithApi，页面的主要的分页列表的请求调用此回调。其他的依旧调用loadDataWithApi
 
 @param api demoBaseService
 */
- (void)loadPageDataWithApi:(demoBaseService *)api{
    [super loadPageDataWithApi:api];
    
    self.model = api.responseJSONModel;
    
    [self.mainTableView reloadData];
    
    /** headerView **/
    self.projectListHeeaderView.model = self.model;
    self.mainTableView.tableHeaderView = self.projectListHeeaderView;
    
    /** footerView */
    if (self.model.projectList.count > 0) {
        self.mainTableView.tableFooterView = self.footerView;
    }else{
        self.mainTableView.tableFooterView = [[UIView alloc] init];
    }
    
    
    
    
    // tell constraints they need updating
    [self.view setNeedsUpdateConstraints];
}

/**
 * 跳转系统消息中心
 *
 */
- (void)goSystemNotifiyCenter{
    
}

/**
 查看全部新房
 */
- (void)lookAllNewHouse{
    
}

/**
 点击广告图

 @param index <#index description#>
 */
- (void)clickBannerWithIndex:(NSInteger)index{
    if (self.model) {
        if (self.model.bannerList.count > index) {
            demoHomeBannerModel *bannerModel = self.model.bannerList[index];
            if ([StringUtil empty:bannerModel.url] == NO) {
                demoWebViewController *webVC = [[demoWebViewController alloc] init];
                webVC.urlString = bannerModel.url;
                webVC.navView.navTitleView.title = bannerModel.adTitle;
                webVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:webVC animated:YES];                
            }
        }
    }
}
/**
 自动处理上拉刷新控件，用于自动显示加载状态
 
 @return 加载列表的array数组的key
 */
- (NSString *)dateResultAutoComplete{
    return @"projectList";
}
/**
 是否隐藏自定义导航栏
 
 @return YES为隐藏，NO为不隐藏，默认NO
 */
- (BOOL)navigationHidden{
    return YES;
}

//*********** 检查更新版本 ***********
/**
 检查更新版本
 */
-(void)checkVersionUpdate{
    //上次更新时间
    NSString *lastCheckVersion_time = [[NSUserDefaults standardUserDefaults] stringForKey:demo_DATA_TIME_CHECK_VERSION_UPDATE];
    
//    //第一次获取,或者数据达到requestOnceTime更新时间
//    NSString *isFirstStart=[[NSUserDefaults standardUserDefaults] objectForKey:@"demoFirstStart"]; //第一次启动
//    if([isFirstStart intValue]!=1){ //不是否安装后第一次启动
//    }
    if([StringUtil empty:lastCheckVersion_time] || [self isMoreThanSevenDay:lastCheckVersion_time]) {
        [self checkNewVersionForApp];
    }
}

- (void)checkNewVersionForApp{
    
    demoCheckAppUpdateApi *api = [[demoCheckAppUpdateApi alloc] init];
    api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self configUpdateTip:request];
    } failure:nil];
}

/**
 //根据更新需求配置弹框
 
 @param request <#resoultDic description#>
 */
- (void)configUpdateTip:(YTKBaseRequest *)request{
    demoCheckAppUpdateApi *api = (demoCheckAppUpdateApi *)request;
    demoCheckAppUpdateModel *model = api.responseJSONModel;
    
    NSString *checkUpdateState = model.checkAppUpdateIOSEntity.checkUpdateState;
    
    if (checkUpdateState != nil && ![checkUpdateState isEqualToString:@""]) {
        if ([checkUpdateState isEqualToString:@"no_update"]) {
            
        }else{
            /** 更新view **/
            demoAppUpdateView *updateTipView = [[demoAppUpdateView alloc] init];
            updateTipView.model = model;
            UIView *tipBgView = [[UIApplication sharedApplication] keyWindow];
            [tipBgView addSubview:updateTipView];
            [updateTipView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tipBgView.top).offset(0);
                make.left.equalTo(tipBgView.left).offset(0);
                make.right.equalTo(tipBgView.right).offset(0);
                make.bottom.equalTo(tipBgView.bottom).offset(0);
            }];
            if ([checkUpdateState isEqualToString:@"recommend_update"]){
                //请求数据成功纪录数据和时间
                long long now = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] longLongValue];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld",now] forKey:demo_DATA_TIME_CHECK_VERSION_UPDATE];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else if ([checkUpdateState isEqualToString:@"must_update"]){
                
            }
        }
    }
}
/**
 //版本 计算时间差
 
 @param previousTime <#previousTime description#>
 @return <#return value description#>
 */
- (BOOL)isMoreThanSevenDay:(NSString*)previousTime{
    
    long long previous = [previousTime longLongValue];
    
    long long now = [[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] longLongValue];
    
    long long difference = now - previous;
    
    //1天
    if (difference > 60*60*requestVersionOnceTime){
        return YES;
    }
    return NO;
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoHomeSearchView *)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[demoHomeSearchView alloc] init];
        _searchBarView.searchBarDelegate = self;
        __weak typeof(self) weakSelf = self;
        [_searchBarView setGoSystemNotifiyCenterBlock:^{
            [weakSelf goSystemNotifiyCenter];
        }];
    }
    return _searchBarView;
}

- (demoHomeModel *)model{
    if (!_model) {
        _model = [[demoHomeModel alloc] init];
    }
    return _model;
}

- (demoHomeProjectListHeaderView *)projectListHeeaderView{
    if (!_projectListHeeaderView) {
        _projectListHeeaderView = [[demoHomeProjectListHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        __block typeof(self) blockSelf = self;
        /** 点击类型 **/
        [_projectListHeeaderView setTapTpypWithIndex:^(NSInteger index) {
            blockSelf.currentRequestIndex = index;
            [blockSelf.reFreshHeader beginRefreshing];
        }];
        /** 点击广告图 **/
        [_projectListHeeaderView setClickBannerBlock:^(NSInteger index) {
            [blockSelf clickBannerWithIndex:index];
        }];
        CGFloat height = [_projectListHeeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        _projectListHeeaderView.frame = CGRectMake(_projectListHeeaderView.frame.origin.x, _projectListHeeaderView.frame.origin.y, _projectListHeeaderView.frame.size.width, height);
    }
    return _projectListHeeaderView;
}

- (UIView *)footerView{
    if (!_footerView){
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"查看全部新房" forState:UIControlStateNormal];
        btn.titleLabel.font = kIAFontNormal;
        [btn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(lookAllNewHouse) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 16.f;
        btn.clipsToBounds = YES;
        [btn setBackgroundColor:HEXCOLOR(0xf4f4f4)];
        [_footerView addSubview:btn];
        
        CGFloat width = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(kDeviceWidth, 100) options:0 attributes:@{NSFontAttributeName: btn.titleLabel.font} context:nil].size.width;
        
        __weak typeof(_footerView) weakFooter = _footerView;
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakFooter.mas_top).offset(16);
            make.centerX.equalTo(weakFooter.centerX);
            make.width.equalTo(width + 50);
            make.bottom.equalTo(weakFooter.bottom).offset(-16);
        }];
        
        CGFloat height = [_footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        _footerView.frame = CGRectMake(_footerView.frame.origin.x, _footerView.frame.origin.y, _footerView.frame.size.width, height);
    }
    return _footerView;
}

- (demoHomeAskingView *)askingView{
    if (!_askingView){
        _askingView = [[demoHomeAskingView alloc] init];
        [_askingView setAskingBlock:^{
            
        }];
    }
    return _askingView;
}

@end
