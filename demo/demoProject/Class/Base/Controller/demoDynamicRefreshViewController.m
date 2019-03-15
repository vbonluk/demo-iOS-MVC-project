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
 *  File name       :      demoDynamicRefreshViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoDynamicRefreshViewController.h"
#import "demoDefaultResponse.h"

@interface demoDynamicRefreshViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic, readwrite) UITableView *mainTableView;

@property (strong, nonatomic, readwrite) MJRefreshNormalHeader *reFreshHeader;
@property (strong, nonatomic, readwrite) MJRefreshAutoNormalFooter *reFreshFooter;

/** 页码 **/
@property (assign, nonatomic, readwrite) NSInteger page;
/** 数据量 **/
@property (assign, nonatomic, readwrite) NSInteger pageSize;
/** 分页总数组 **/
@property (strong, nonatomic, readwrite) NSMutableArray *listArray;

@end

@implementation demoDynamicRefreshViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self initPageView];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        dispatch_async(dispatch_get_main_queue(),^{
            if ([self isShowRefreshFooter]) {
                //CGFloat mainTableHeight = [self.mainTableView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                CGFloat mainTableHeight = kDeviceHeight;
                CGFloat contentHeight = self.mainTableView.contentSize.height;
                if (contentHeight < mainTableHeight) {
                    self.reFreshFooter.hidden = YES;
                }else{
                    self.reFreshFooter.hidden = NO;
                }
            }
        });
    }
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    /** 移除base的scrollView **/
    [self.scrollerView removeFromSuperview];
    
    CGFloat navHeight = demoNavHeight;
    if ([self navigationHidden] == YES) {
        navHeight = 0;
    }else{
        /** 导航栏 **/
        [self.navView.backBtnView.btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.navView];
        [self.navView makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0,*)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(0);
            }else{
                make.top.equalTo(self.view.top).offset(demoStatusHeight);
            }
            make.left.equalTo(self.view.left).offset(0);
            make.right.equalTo(self.view.right).offset(0);
            make.height.equalTo(demoNavHeight);
        }];
    }
    
    CGFloat tabHeight = self.tabBarController.tabBar.frame.size.height;
    if (self.tabBarController.tabBar.hidden == YES || self.hidesBottomBarWhenPushed == YES) {
        tabHeight = 0;
    }
    /** mainTableView **/
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        if (@available(iOS 11.0,*)) {
            self.mainTableViewTop = make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(navHeight).priorityLow();
            self.mainTableViewBottom = make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0).priorityLow();
        }else{
            self.mainTableViewTop = make.top.equalTo(self.view.top).offset(navHeight + demoStatusHeight).priorityLow();
            self.mainTableViewBottom = make.bottom.equalTo(self.view.bottom).offset(-tabHeight);
        }
    }];
    
    /** 页码 **/
    self.page = 1; // default
    self.pageSize = 20; // default
    
    /** MJRefresh **/
    self.mainTableView.mj_header = self.reFreshHeader;
    // 马上进入刷新状态
    //[self.reFreshHeader beginRefreshing];
    
    if ([self isShowRefreshFooter]) {
        self.mainTableView.mj_footer = self.reFreshFooter;
    }
    
    /** 空白占位图 **/
    self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                            titleStr:@"暂无数据"
                                                           detailStr:@""];
}

/**
 *  下拉刷新
 */
- (void)pullRequest{
    [super pullRequest];
    
    [self pullRequestPage];
    
}

/**
 *  加载分页数据
 *  此方法分页专用，用于一个分页列表页面含有多个请求时，区分开分页请求和其他非分页请求
 */
- (void)pullRequestPage{
    
    
}

/**
 *  上拉请求数据
 */
- (void)getMoveDataSource{
    
   [self pullRequestPage];
    
}

/**
 刷新页面
 */
- (void)reloadPage{
    /** 页码 **/
    self.page = 1; // default
    self.pageSize = 20; // default
    [self.reFreshHeader beginRefreshing];
}

/**
 加载分页数据到页面
 
 此方法用于区别不是分页列表的请求回调loadDataWithApi，页面的主要的分页列表的请求调用此回调。其他的依旧调用loadDataWithApi
 
 @param api demoBaseService
 */
- (void)loadPageDataWithApi:(demoBaseService *)api{
    
    if (self.page == 1) {
        [self.listArray removeAllObjects];
    }
    
    /** 结束头部刷新 **/
    [self.mainTableView.mj_header endRefreshing];
    
    //self.reFreshFooter.hidden = NO;
    /** 结束尾部刷新 **/
    if ([self isShowRefreshFooter]) {
        [self.mainTableView.mj_footer endRefreshing];
        if ([self.mainTableView numberOfRowsInSection:0] == 0) {
            self.reFreshFooter.hidden = YES;
        }else{
            self.reFreshFooter.hidden = NO;
        }
    }
    
    if (self.cancleAutoComplete == NO) {
        
        /** 自动处理上拉刷新控件 **/
        NSString *arrayKey = [self dateResultAutoComplete];
        if ([StringUtil empty:arrayKey] == NO) {
            demoDefaultResponse *defaultResponse = [demoDefaultResponse yy_modelWithJSON:api.responseString];
            if (defaultResponse.resultCode == demoResultCode_SUCCESS) {
                /** 请求成功 **/
                id data = defaultResponse.extend;
                if (data) {
                    if ([data isKindOfClass:[NSDictionary class]]) {
                        NSArray *array = [self arrayKeyFindWithResponseDictionary:data arrayKey:arrayKey];
                        if (array) {
                            if ([array isKindOfClass:[NSArray class]]) {
                                if (array.count > 0) {
                                    if (array.count < self.pageSize) {
                                        /** 有数据但是数据量不足铺满pageSize，表示已经到最后一页 **/
                                        //self.reFreshFooter.hidden = YES;
                                        [self.reFreshFooter endRefreshingWithNoMoreData];
                                    }else{
                                        /** 数据正常，不做处理 , 可以继续翻页 **/
                                    }
                                    /** 拼接数组 **/
                                    NSArray *arr = [self jointArray:api arrayKey:arrayKey array:array];
                                    [self.listArray addObjectsFromArray:arr];
                                }else{
                                    /** 无数据 **/
                                    //self.reFreshFooter.hidden = YES;
                                    [self.reFreshFooter endRefreshingWithNoMoreData];
                                }
                            }else{
                                DDLogError(@"error to complete array with key in dictionary : \n %@",data);
                            }
                        }else{
                            DDLogError(@"error to complete array with key in dictionary : \n %@",data);
                        }
                    } else {
                        if ([data isKindOfClass:[NSArray class]]) {
                            /** extend 没有包一层，直接就是数组 因为无法通过key来判断该数组是否为分页数组，故不做处理**/
                            //DDAssert(NO, @"分页处理错误：extend 没有包一层，直接就是数组");
                            
                            /** 处理 extend 首层为数组等的情况 **/
                            /** 此时的responseJSONModel为数组 **/
                            NSArray *array = (NSArray *)data;
                            if (array == nil) {
                                DDLogError(@"model list 转换出错！");
                            }
                            if (array.count > 0) {
                                if (array.count < self.pageSize) {
                                    /** 有数据但是数据量不足铺满pageSize，表示已经到最后一页 **/
                                    //self.reFreshFooter.hidden = YES;
                                    [self.reFreshFooter endRefreshingWithNoMoreData];
                                }else{
                                    /** 数据正常，不做处理 , 可以继续翻页 **/
                                }
                                /** 拼接数组 **/
                                NSArray *arr = [self jointArray:api arrayKey:arrayKey array:array];
                                [self.listArray addObjectsFromArray:arr];
                            }else{
                                /** 无数据 **/
                                //self.reFreshFooter.hidden = YES;
                                [self.reFreshFooter endRefreshingWithNoMoreData];
                            }
                        }else{
                            /** extend 返回其他类型 **/
                            DDLogError(@"error to complete array with key in : \n %@",data);
                        }
                    }
                } else {
                    /** extend 无数据 **/
                    DDLogError(@"extend is no data : \n %@",defaultResponse);
                }
            }else{
                /** 请求成功但是没有拿到数据，或者不是列表的请求 **/
                //self.reFreshFooter.hidden = YES;
                //[self.reFreshFooter endRefreshingWithNoMoreData];
            }
        }
    }
}

/**
 加载数据到页面
 
 @param api demoBaseService
 */
- (void)loadDataWithApi:(demoBaseService *)api{
    [super loadDataWithApi:api];
    
}

/**
 自动处理上拉刷新控件，用于自动显示加载状态

 @return 加载列表的array数组的key
 */
- (NSString *)dateResultAutoComplete{
    return @"";
}

/**
 用于存储分页listArray，告知当前model的类型
 
 @return 加载列表的array数组的model类型
 */
- (Class)dateResultListClass{
    
    return demoBaseModel.class;
}

- (NSArray *)arrayKeyFindWithResponseDictionary:(NSDictionary *)responseDictionary arrayKey:(NSString *)arrayKey{
    @try {
        NSArray *allKey = responseDictionary.allKeys;
        for (NSString *key in allKey) {
            if ([key isEqualToString:arrayKey]) {
                id object = [responseDictionary objectForKey:key];
                if ([object isKindOfClass:[NSArray class]]) {
                    return (NSArray *)object;
                }else{
                    DDLogError(@"error to complete array with key in dictionary : \n %@",responseDictionary);
                }
            }else{
                id object = [responseDictionary objectForKey:key];
                if ([object isKindOfClass:[NSArray class]]) {
                    /** NSArray **/
                    
                }else if ([object isKindOfClass:[NSDictionary class]]){
                    /** NSDictionary **/
                    return [self arrayKeyFindWithResponseDictionary:(NSDictionary *)object arrayKey:arrayKey];
                }else{
                    /** string **/
                    
                }
            }
        }
    }
    @catch (NSException *exception) {
        DDLogError(@"arrayKeyFindWithResponseDictionary,exception: \n %@",exception);
    }
    @finally {
        
    }
    return nil;
}

- (NSArray *)jointArray:(demoBaseService *)api arrayKey:(NSString *)arrayKey array:(NSArray *)array{
    demoBaseModel *c = api.responseJSONModel;
    Class class = c.class;
    NSDictionary *d = [class modelContainerPropertyGenericClass];
    if (d) {
        if ([d allKeys] > 0) {
            if ([[d allKeys] containsObject:arrayKey]) {
                id value = [d objectForKey:arrayKey];
                if (value) {
                    demoBaseModel *value_model = value;
                    Class value_class = value_model.class;
                    NSString *json = [array yy_modelToJSONString];
                    NSArray *dataArray = [NSArray yy_modelArrayWithClass:value_class json:json];
                    return dataArray;
                }
            }
        }
    }
    return [NSArray array];
}

#pragma mark - Public Methods

/**
 是否显示底部上拉刷新控件

 @return YES 显示，NO 不显示，默认 NO
 */
- (BOOL)isShowRefreshFooter{
    return NO;
}

#pragma mark - Getters and Setters

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.tableFooterView = [[UIView alloc] init];
    }
    return _mainTableView;
}

- (MJRefreshNormalHeader *)reFreshHeader{
    if (!_reFreshHeader){
        __block typeof(self) blockSelf = self;
        _reFreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //需要将页码设置为1
            blockSelf.page = 1;
            [blockSelf pullRequest];
        }];
        _reFreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _reFreshHeader;
}

- (MJRefreshAutoNormalFooter *)reFreshFooter{
    if (!_reFreshFooter){
        __block typeof(self) blockSelf = self;
        _reFreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            //页码
            blockSelf.page++;
            [blockSelf getMoveDataSource];
        }];
        [_reFreshFooter setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        [_reFreshFooter setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    }
    return _reFreshFooter;
}

- (NSMutableArray *)listArray{
    if (!_listArray){
        _listArray = [[NSMutableArray alloc] init];
        
    }
    return _listArray;
}
@end
