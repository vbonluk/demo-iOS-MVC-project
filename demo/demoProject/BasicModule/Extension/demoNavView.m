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
 *  File name       :      demoNavView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoNavView.h"

@interface demoNavView ()



@end

@implementation demoNavView

#pragma mark - LifeCyle

- (id)init{
    if ((self = [super init])) {
        
        [self initSubViews];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        
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
    
    self.backgroundColor = [UIColor whiteColor];
    
    /** 返回按钮 **/
    [self addSubview:self.backBtnView];
    [self.backBtnView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(5);
    }];
    
    /** 导航栏标题 **/
    [self addSubview:self.navTitleView];
    [self.navTitleView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtnView.centerY);
        make.centerX.equalTo(self.centerX);
        make.width.equalTo(kDeviceWidth / 2.f);
    }];
    
    /** 下横线 **/
    [self addSubview:self.line];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.height.equalTo(.5);
    }];
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoBackBtnView *)backBtnView{
    if (!_backBtnView){
        _backBtnView = [[demoBackBtnView alloc] init];
        
    }
    return _backBtnView;
}

- (demoNavTitleView *)navTitleView{
    if (!_navTitleView){
        _navTitleView = [[demoNavTitleView alloc] init];
        _navTitleView.title = @"我是一个标题";
        _navTitleView.titleColor = HEXCOLOR(0x333333);
        
    }
    return _navTitleView;
}

- (demoView *)line{
    if (!_line){
        _line = [[demoView alloc] init];
        _line.backgroundColor = HEXCOLOR(0x999999);
    }
    return _line;
}

@end
