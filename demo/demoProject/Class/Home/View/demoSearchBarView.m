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
 *  File name       :      demoSearchBarView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoSearchBarView.h"
#import "UISearchBar+demoSearchBar.h"

@interface demoSearchBarView ()

@property (strong, nonatomic) UIView *searchBgView;
@property (strong, nonatomic) UISearchBar *searchBar;


@end

@implementation demoSearchBarView

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
    self.searchBgView.backgroundColor = [UIColor clearColor];
    [self.searchBgView addSubview:self.searchBar];
    
    [self addSubview:self.searchBgView];
    
    //搜索栏
    [self.searchBgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.searchBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.searchBgView);
    }];
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (UIView *)searchBgView{
    if (!_searchBgView) {
        _searchBgView = [[UIView alloc] init];
    }
    return _searchBgView;
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"输入关键字进行搜索";
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_searchBar setCustomerStyle];
    }
    return _searchBar;
}

- (void)setSearchBarDelegate:(id<UISearchBarDelegate>)searchBarDelegate{
    _searchBarDelegate = searchBarDelegate;
    self.searchBar.delegate = searchBarDelegate;
}

@end
