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
 *  File name       :      demoHomeSearchView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoHomeSearchView.h"
#import "demoSearchBarView.h"

@interface demoHomeSearchView ()

@property (strong, nonatomic) demoSearchBarView *searchBarView;
@property (strong, nonatomic) UIButton *systemNotificationBtn;

@end

@implementation demoHomeSearchView

#pragma mark - LifeCyle

- (id)init{
    if ((self = [super init])) {
        
        [self initSubViews];
        
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
    
    self.backgroundColor = kIAThemeColor;
    
    [self addSubview:self.searchBarView];
    
    [self.searchBarView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.searchBarView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.bottom).offset(0).priorityHigh();
        make.top.equalTo(self);
    }];
    [self addSubview:self.systemNotificationBtn];
    [self.systemNotificationBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBarView.right);
        make.right.equalTo(self);
        make.bottom.equalTo(self.searchBarView.bottom);
        make.width.equalTo(50);
        make.top.equalTo(self.searchBarView.top);
    }];
    

}

/**
 跳转系统消息中心
 
 */
- (void)goSystemNotifiy{
    if (self.goSystemNotifiyCenterBlock) {
        self.goSystemNotifiyCenterBlock();
    }
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoSearchBarView *)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[demoSearchBarView alloc] init];
    }
    return _searchBarView;
}

- (UIButton *)systemNotificationBtn{
    if (!_systemNotificationBtn) {
        _systemNotificationBtn = [[UIButton alloc] init];
        [_systemNotificationBtn setImage:[UIImage imageNamed:@"SystemNotification"] forState:UIControlStateNormal];
        [_systemNotificationBtn addTarget:self action:@selector(goSystemNotifiy) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _systemNotificationBtn;
}

- (void)setSearchBarDelegate:(id<UISearchBarDelegate>)searchBarDelegate{
    _searchBarDelegate = searchBarDelegate;
    self.searchBarView.searchBarDelegate = searchBarDelegate;
}

@end
