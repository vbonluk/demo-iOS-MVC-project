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
 *  File name       :      demoDynamicRefreshViewController.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoBaseViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MJRefresh.h"
#import <LYEmptyView/LYEmptyViewHeader.h>

@interface demoDynamicRefreshViewController : demoBaseViewController

@property (strong, nonatomic, readonly) UITableView *mainTableView;
/** mainTableView顶部布局 **/
@property (strong, nonatomic) MASConstraint *mainTableViewTop;
/** mainTableView底部布局 **/
@property (strong, nonatomic) MASConstraint *mainTableViewBottom;
@property (strong, nonatomic, readonly) MJRefreshNormalHeader *reFreshHeader;
@property (strong, nonatomic, readonly) MJRefreshAutoNormalFooter *reFreshFooter;
/** 取消自动处理上拉刷新 **/
@property (assign, nonatomic) BOOL cancleAutoComplete;
/** 页码 **/
@property (assign, nonatomic, readonly) NSInteger page;// default is 1
/** 数据量 **/
@property (assign, nonatomic, readonly) NSInteger pageSize;// default is 20
/** 分页总数组 **/
@property (strong, nonatomic, readonly) NSMutableArray *listArray;

/**
 *  加载分页数据
 *  此方法分页专用，用于一个分页列表页面含有多个请求时，区分开分页请求和其他非分页请求
 */
- (void)pullRequestPage;

/**
 *  上拉请求数据
 */
- (void)getMoveDataSource;

/**
 加载分页数据到页面
 
 @param api demoBaseService
 */
- (void)loadPageDataWithApi:(demoBaseService *)api;

/**
 是否显示底部上拉刷新控件
 
 @return YES 显示，NO 不显示，默认 NO
 */
- (BOOL)isShowRefreshFooter;

/**
 自动处理上拉刷新控件，用于自动显示加载状态
 
 @return 加载列表的array数组的key
 */
- (NSString *)dateResultAutoComplete;

@end
