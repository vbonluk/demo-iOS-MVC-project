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
 *  File name       :      demoMineViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineViewController.h"
#import "demoMineApi.h"
#import "demoMineModel.h"
#import "demoMineCell.h"
#import "demoMineHeaderView.h"
#import "demoMineSettingViewController.h"
#import "demoMineTiXianView.h"
#import "demoAboutUsViewController.h"
#import <YYText/YYText.h>

@interface demoMineViewController ()

@property (strong, nonatomic) demoMineModel *model;
@property (strong, nonatomic) NSArray *localListArray;
@property (strong, nonatomic) demoMineHeaderView *headerView;

@end

@implementation demoMineViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [self initPageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self pullRequest];
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

/** tableView dataSources && delegate **/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.localListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *cellID = @"demoMineCell";
    demoMineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[demoMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.title = self.localListArray[indexPath.row];
    
    if ([cell.title isEqualToString:@"签约合伙人"]) {
        cell.rightLabel.textColor = HEXCOLOR(0x999999);
        cell.rightLabel.text = @"签约高级合伙人，享高额佣金";
    }else{
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = self.localListArray[indexPath.row];
    if ([title isEqualToString:@"我的微店"]) {
        demoMineTiXianView *alertView = [[demoMineTiXianView alloc] init];
        
        if (self.model.isAuthentication == 1) {
            //已签约
            alertView.contentLabel.text = @"请关注\"八爪找房\"小程序，并联络服务专员开通";
        } else {
            //未签约
            alertView.contentLabel.text = @"您需签约高级合伙人才能开通微店";
        }
        UIView *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:alertView];
        [alertView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(window.top).offset(0);
            make.left.equalTo(window.left).offset(0);
            make.right.equalTo(window.right).offset(0);
            make.bottom.equalTo(window.bottom).offset(0);
        }];
    } else if ([title isEqualToString:@"签约合伙人"]) {
        /** 签约合伙人 **/
        demoMineTiXianView *alertView = [[demoMineTiXianView alloc] init];
        alertView.titleLabel.text = @"签约合伙人";
        alertView.contentLabel.text = @"";
        alertView.contentLabel.alpha = 0;
        YYLabel *content_label_tap = [[YYLabel alloc] init];
        content_label_tap.numberOfLines = 0;
        //content_label_tap.font = [UIFont systemFontOfSize:15];
        //content_label_tap.textAlignment = NSTextAlignmentCenter;
        content_label_tap.textColor = kIAFontColor333333;
        content_label_tap.preferredMaxLayoutWidth = kDeviceWidth - 32*2 - 8*2;
        [alertView.mainView addSubview:content_label_tap];
        [content_label_tap makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(alertView.contentLabel.top).offset(0);
            make.left.equalTo(alertView.contentLabel.left).offset(0);
            make.right.equalTo(alertView.contentLabel.right).offset(0);
            make.bottom.equalTo(alertView.contentLabel.bottom).offset(0);
        }];
        
        NSString *content =  [NSString stringWithFormat:@"%@\n%@ %@",self.model.certificatedTitle,self.model.certificatedContent,self.model.certificatedPhoneNumber];
        content_label_tap.text = content;
        /** 使电话号码高亮 **/
        if ([StringUtil empty:self.model.certificatedPhoneNumber] == NO) {
            YYTextHighlight *highlight_1 = [[YYTextHighlight alloc] init];
            highlight_1.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                //点击电话号码
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.certificatedPhoneNumber]]];
                });
            };
            NSRange range1 = [content rangeOfString:self.model.certificatedPhoneNumber];
            NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:content];
            [attributed yy_setTextHighlight:highlight_1 range:range1];
            [attributed yy_setColor:HEXCOLOR(0x53a2fe) range:range1];
            [attributed yy_setAlignment:NSTextAlignmentCenter range:NSMakeRange(0, content.length)];
            [attributed yy_setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, content.length)];
            content_label_tap.attributedText = attributed;
        }
        
        UIView *window = [[UIApplication sharedApplication] keyWindow];
        [window addSubview:alertView];
        [alertView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(window.top).offset(0);
            make.left.equalTo(window.left).offset(0);
            make.right.equalTo(window.right).offset(0);
            make.bottom.equalTo(window.bottom).offset(0);
        }];
        
    } else if ([title isEqualToString:@"新手指南"]) {
        
    } else if ([title isEqualToString:@"关于我们"]) {
        demoAboutUsViewController *aboutUs = [[demoAboutUsViewController alloc] init];
        aboutUs.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUs animated:YES];
    }
    
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    [super initPageView];
    
    self.navView.navTitleView.title = @"";
    
    self.mainTableView.backgroundColor = HEXCOLOR(0xececec);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /** headerView **/
    self.mainTableView.tableHeaderView = self.headerView;
    
}

/**
 *  加载分页数据
 *  此方法分页专用，用于一个分页列表页面含有多个请求时，区分开分页请求和其他非分页请求
 */
- (void)pullRequestPage{
    [super pullRequestPage];

    demoMineApi *api = [[demoMineApi alloc] init];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self loadPageDataWithApi:(demoBaseService *)request];
    } failure:nil];
}

/**
 加载分页数据到页面
 
 此方法用于区别不是分页列表的请求回调loadDataWithApi，页面的主要的分页列表的请求调用此回调。其他的依旧调用loadDataWithApi
 
 @param api demoBaseService
 */
- (void)loadPageDataWithApi:(demoBaseService *)api{
    [super loadPageDataWithApi:api];
    
    self.model = api.responseJSONModel;
    
    self.headerView.model = self.model;
    
    [self.mainTableView reloadData];
}

/**
 自动处理上拉刷新控件，用于自动显示加载状态
 
 @return 加载列表的array数组的key
 */
- (NSString *)dateResultAutoComplete{
    return nil;
}

/**
 是否隐藏自定义导航栏
 
 @return YES为隐藏，NO为不隐藏，默认NO
 */
- (BOOL)navigationHidden{
    return YES;
}
#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (NSArray *)localListArray{
    if (!_localListArray){
        _localListArray = [[NSArray alloc] init];
        _localListArray = @[@"我的微店",@"签约合伙人",@"关于我们"];
        [self.mainTableView registerClass:[demoMineCell class] forCellReuseIdentifier:@"demoMineCell"];
    }
    return _localListArray;
}

- (demoMineHeaderView *)headerView{
    if (!_headerView){
        _headerView = [[demoMineHeaderView alloc] init];
        __weak typeof(self) weakSelf = self;
        /** 设置 **/
        [_headerView setClickSettingBlock:^{
            demoMineSettingViewController *setting = [[demoMineSettingViewController alloc] init];
            setting.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:setting animated:YES];
        }];
        /** 提现 **/
        [_headerView setClickTiXian:^{
            demoMineTiXianView *alertView = [[demoMineTiXianView alloc] init];
            UIView *window = [[UIApplication sharedApplication] keyWindow];
            [window addSubview:alertView];
            [alertView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(window.top).offset(0);
                make.left.equalTo(window.left).offset(0);
                make.right.equalTo(window.right).offset(0);
                make.bottom.equalTo(window.bottom).offset(0);
            }];
        }];
//        /** 可提现收入 **/
//        [_headerView setClickKetixianshouru:^{
//            demoMineInComeViewController *income = [[demoMineInComeViewController alloc] init];
//            income.page_Type = Page_Type_ketixian;
//            income.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:income animated:YES];
//        }];
//        /** 累计收入 **/
//        [_headerView setClickLeijishouru:^{
//            demoMineInComeViewController *income = [[demoMineInComeViewController alloc] init];
//            income.page_Type = Page_Type_leiji;
//            income.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:income animated:YES];
//        }];
//        /** 预计收入 **/
//        [_headerView setClickYujishouru:^{
//            demoMineInComeViewController *income = [[demoMineInComeViewController alloc] init];
//            income.page_Type = Page_Type_yuji;
//            income.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:income animated:YES];
//        }];
        CGFloat height = [_headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        _headerView.frame = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, _headerView.frame.size.width, height);
    }
    return _headerView;
}

@end
