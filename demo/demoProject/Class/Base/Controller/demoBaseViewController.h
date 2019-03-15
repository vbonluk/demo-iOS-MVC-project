//
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
 *  File name       :      demoBaseViewController.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoBaseService.h"
#import "demoBatchService.h"
#import "demoChainService.h"
#import "YTKBaseRequest+demoAnimatingAccessory.h"
#import "YTKBatchRequest+demoAnimatingAccessory.h"
#import "demoNavView.h"
#import "demoDefaultResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface demoBaseViewController : UIViewController

@property (strong, nonatomic, readonly) UIScrollView *scrollerView;
/** scrollView顶部布局 **/
@property (strong, nonatomic) MASConstraint *scrollerViewTop;
/** scrollView底部布局 **/
@property (strong, nonatomic) MASConstraint *scrollerViewBottom;
@property (strong, nonatomic, readonly) UIView *contentView;
@property (strong, nonatomic) demoNavView *navView;

/** 是否在编辑的时候禁止返回事件 **/
@property (nonatomic, assign) BOOL isNotAllowGoBackInEditing;
/** 用于记录点击返回的时候对比EditPageCheckViewArray的值有无变化，判断有无进行数据的填充.此数组存储默认值 **/
@property (nonatomic, strong) NSMutableArray *EditPageCheckViewTextArray;
/** 用于记录点击返回的时候对比EditPageCheckViewArray的值有无变化，判断有无进行数据的填充.此数组存储变化值 **/
@property (nonatomic, strong) NSMutableArray *EditPageCheckViewTextArray_modified;

/** 指定返回的目标ViewController **/
@property (strong, nonatomic) Class backTargetViewController;
/** 返回指定ViewController的block方法 **/
@property (copy, nonatomic) void(^backToTargetBlock)(Class backTargetViewController);

/**
 *  初始化页面
 */
- (void)initPageView;

/**
 *  请求数据
 */
- (void)pullRequest;

/**
 加载数据到页面
 
 @param api demoBaseService
 */
- (void)loadDataWithApi:(demoBaseService *)api;

/**
 返回目标ViewController
 */
- (void)goBack;

/**
 是否隐藏自定义导航栏

 @return YES为隐藏，NO为不隐藏，默认NO
 */
- (BOOL)navigationHidden;

/**
刷新页面
*/
- (void)reloadPage;
/**
 编辑页面的自定义检查选项是否为空，用于一些特殊条件，例如选择性别的时候是否点击了“男”，或者“女”，的按钮。
 */
- (BOOL)checkEditPageIsFillCustom;
/**
 *保存编辑页面的标签默认值
 */
- (void)configEditGoBackEditValueDefault;
/**
 *保存编辑页面的标签改变值
 */
- (void)configEditGoBackEditValueModifyed;
/**
 *保存加载view的时候，标签的默认值
 */
- (void)configGoBackEditPageValue:(NSMutableArray *)array dataArray:(NSArray *)EditPageCheckViewArray;

/**
 api返回错误，包含：业务错误、请求错误、参数错误等
 
 @param resultCode 错误类型
 */
- (void)apiCallBackErrorWithResultCode:(demoResultCode)resultCode api:(demoBaseService *)api;

@end

NS_ASSUME_NONNULL_END
