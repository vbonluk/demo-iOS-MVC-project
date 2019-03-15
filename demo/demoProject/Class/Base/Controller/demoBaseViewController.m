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
 *  File name       :      demoBaseViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoBaseViewController.h"
#import "UIViewController+demoPopGesture.h"
#import "GoBackSaveTipView.h"

@interface demoBaseViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic, readwrite) UIScrollView *scrollerView;
@property (strong, nonatomic, readwrite) UIView *contentView;



@end

@implementation demoBaseViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
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
    /** 置顶自定义导航栏 **/
    [self.view bringSubviewToFront:self.navView];
    
    [super updateViewConstraints];
}

#pragma mark - Overwrite Super Class



#pragma mark - Response Mehtods



#pragma mark - Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    
    self.navigationController.navigationBarHidden = YES;
    
    /* ScrollerView + contentView */
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.contentView];
    //防止scrollerview偏移
    if (@available(iOS 11.0, *)) {
        self.scrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    __weak typeof(self)weakself = self;
    /** 导航栏 **/
    CGFloat navHeight = demoNavHeight;
    if ([self navigationHidden] == YES) {
        navHeight = 0;
    }else{
        /** 导航栏 **/
        [self.navView.backBtnView.btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.navView];
        
        [self.navView makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0,*)) {
                make.top.equalTo(weakself.view.mas_safeAreaLayoutGuideTop).offset(0);;
            }else{
                make.top.equalTo(self.view.top).offset(demoStatusHeight);
            }
            make.left.equalTo(self.view.left).offset(0);
            make.right.equalTo(self.view.right).offset(0);
            make.height.equalTo(demoNavHeight);
        }];
    }
    /** 底部栏 **/
    CGFloat tabHeight = demoTabBarHeight;
    if (self.tabBarController.tabBar.hidden == YES || self.hidesBottomBarWhenPushed == YES) {
        tabHeight = 0;
    }
    [self.scrollerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0,*)) {
            self.scrollerViewTop = make.top.equalTo(weakself.view.mas_safeAreaLayoutGuideTop).offset(navHeight);
            self.scrollerViewBottom = make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        }else{
            self.scrollerViewTop = make.top.equalTo(self.view.top).offset(navHeight + demoStatusHeight);
            self.scrollerViewBottom = make.bottom.equalTo(self.view).offset(-tabHeight);
        }
        
    }];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.scrollerView);
        make.width.equalTo(self.scrollerView.width);
        make.height.equalTo(self.scrollerView.height).offset(1).priority(749);
    }];
    
}
/**
 *  请求数据
 */
- (void)pullRequest{
    
    
    
}

/**
 加载数据到页面

 @param api demoBaseService
 */
- (void)loadDataWithApi:(demoBaseService *)api{
    /** 检查编辑模式 **/
    if (self.isNotAllowGoBackInEditing) {
        [self configEditGoBackEditValueDefault];
        //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

/**
 *保存编辑页面的标签默认值
 */
- (void)configEditGoBackEditValueDefault{
    
    //    [self configGoBackEditPageValue:self.EditPageCheckViewTextArray dataArray:nil];
}
/**
 *保存编辑页面的标签改变值
 */
- (void)configEditGoBackEditValueModifyed{
    
    //    [self configGoBackEditPageValue:self.EditPageCheckViewTextArray_modified dataArray:nil];
}

/**
 *保存加载view的时候，标签的默认值
 */
- (void)configGoBackEditPageValue:(NSMutableArray *)array dataArray:(NSArray *)EditPageCheckViewArray{
    [array removeAllObjects];
    if (EditPageCheckViewArray.count > 0) {
        for (UIView *view in EditPageCheckViewArray) {
            if (view == nil || [view isKindOfClass:[UIView class]] == NO) {
                return;
            }else{
                [view resignFirstResponder];//使键盘弹出
                
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *contentView = (UILabel *)view;
                    UILabel *saveView = [[UILabel alloc] init];
                    saveView.text = contentView.text;
                    if ([StringUtil empty:contentView.text]) {
                        saveView.text = @"";
                    }
                    [array addObject:saveView];
                }
                if ([view isKindOfClass:[UITextField class]]) {
                    UITextField *contentView = (UITextField *)view;
                    UITextField *saveView = [[UITextField alloc] init];
                    saveView.text = contentView.text;
                    if ([StringUtil empty:contentView.text]) {
                        saveView.text = @"";
                    }
                    [array addObject:saveView];
                }
                if ([view isKindOfClass:[UITextView class]]) {
                    UITextView *contentView = (UITextView *)view;
                    UITextView *saveView = [[UITextView alloc] init];
                    saveView.text = contentView.text;
                    if ([StringUtil empty:contentView.text]) {
                        saveView.text = @"";
                    }
                    [array addObject:saveView];
                }
            }
        }
    }else{
        
    }
}

/**
 检查编辑页面的元素是否已经填写了内容，返回YES则为已经填写内容
 
 @return <#return value description#>
 */
- (BOOL)checkEditPageIsEditContent{
    if (self.EditPageCheckViewTextArray.count == self.EditPageCheckViewTextArray_modified.count) {
        for (int i = 0; i < self.EditPageCheckViewTextArray.count; i ++) {
            UIView *view = self.EditPageCheckViewTextArray[i];
            UIView *view_modified = self.EditPageCheckViewTextArray_modified[i];
            if ([view isKindOfClass:[UILabel class]] && [view_modified isKindOfClass:[UILabel class]]) {
                UILabel *contentView = (UILabel *)view;
                UILabel *contentView_modified = (UILabel *)view_modified;
                if ([contentView.text isEqualToString:contentView_modified.text] == NO) {
                    return YES;
                }
            }
            if ([view isKindOfClass:[UITextField class]] && [view_modified isKindOfClass:[UITextField class]]) {
                UITextField *contentView = (UITextField *)view;
                UITextField *contentView_modified = (UITextField *)view_modified;
                if ([contentView.text isEqualToString:contentView_modified.text] == NO) {
                    return YES;
                }
            }
            if ([view isKindOfClass:[UITextView class]] && [view_modified isKindOfClass:[UITextView class]]) {
                UITextView *contentView = (UITextView *)view;
                UITextView *contentView_modified = (UITextView *)view_modified;
                if ([contentView.text isEqualToString:contentView_modified.text] == NO) {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

/**
 编辑页面的自定义检查选项是否为空，用于一些特殊条件，例如选择性别的时候是否点击了“男”，或者“女”，的按钮。
 */
- (BOOL)checkEditPageIsFillCustom{
    
    return NO;
}

#pragma mark - Public Methods

- (void)goBack{
    if (self.isNotAllowGoBackInEditing) {
        @try {
            //记录点击返回的时候，标签的值
            [self configEditGoBackEditValueModifyed];
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",exception);
        }
        @finally {
            
        }
        
        
        BOOL isAlreadyTip = NO;//是否已经弹窗提示
        if ([self checkEditPageIsEditContent] == YES) {
            isAlreadyTip = YES;
            GoBackSaveTipView *tip = [[[NSBundle mainBundle] loadNibNamed:@"GoBackSaveTipView" owner:nil options:nil] firstObject];
            tip.frame = [UIScreen mainScreen].bounds;
            [tip setGoBackBlock:^{
                self.isNotAllowGoBackInEditing = NO;
                [self goBack];
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:tip];
        }
        //自定义判断
        if ([self checkEditPageIsFillCustom] == YES) {
            if (isAlreadyTip == NO) {
                isAlreadyTip = YES;
                GoBackSaveTipView *tip = [[[NSBundle mainBundle] loadNibNamed:@"GoBackSaveTipView" owner:nil options:nil] firstObject];
                tip.frame = [UIScreen mainScreen].bounds;
                [tip setGoBackBlock:^{
                    self.isNotAllowGoBackInEditing = NO;
                    [self goBack];
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:tip];
            }
        }
        
        if ([self checkEditPageIsEditContent] == NO && [self checkEditPageIsFillCustom] == NO) {
            self.isNotAllowGoBackInEditing = NO;
            [self goBack];
        }
    } else {
        if (self.backToTargetBlock) {
            self.backToTargetBlock(self.backTargetViewController);
        }
        if (self.backTargetViewController) {
            BOOL isBack = NO;
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:self.backTargetViewController]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    isBack = YES;
                }
            }
            if (isBack == NO) {
                if (self.presentingViewController && self.navigationController.viewControllers.count == 1) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }else{
            if (self.presentingViewController && self.navigationController.viewControllers.count == 1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}
/**
 是否隐藏自定义导航栏
 
 @return YES为隐藏，NO为不隐藏，默认NO
 */
- (BOOL)navigationHidden{
    return NO;
}

/**
 刷新页面
 */
- (void)reloadPage{
    [self pullRequest];
}

/**
 api返回错误，包含：业务错误、请求错误、参数错误等
 
 @param resultCode 错误类型
 */
- (void)apiCallBackErrorWithResultCode:(demoResultCode)resultCode api:(demoBaseService *)api{
    
}

#pragma mark - Getters and Setters

- (UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] init];
        _scrollerView.delegate = self;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (demoNavView *)navView{
    if (!_navView){
        _navView = [[demoNavView alloc] init];
    }
    return _navView;
}

- (NSMutableArray *)EditPageCheckViewTextArray{
    if (!_EditPageCheckViewTextArray){
        _EditPageCheckViewTextArray = [[NSMutableArray alloc] init];
        
    }
    return _EditPageCheckViewTextArray;
}

- (NSMutableArray *)EditPageCheckViewTextArray_modified{
    if (!_EditPageCheckViewTextArray_modified){
        _EditPageCheckViewTextArray_modified = [[NSMutableArray alloc] init];
        
    }
    return _EditPageCheckViewTextArray_modified;
}

@end
