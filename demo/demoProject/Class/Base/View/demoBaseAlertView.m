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
 *  File name       :      demoBaseAlertView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoBaseAlertView.h"

@interface demoBaseAlertView ()

@property (strong, nonatomic, readwrite) demoView *transparentView;
@property (strong, nonatomic, readwrite) demoView *mainView;

@end

@implementation demoBaseAlertView

#pragma mark - LifeCyle

- (id)init{
    if ((self = [super init])) {
        
        //[self initSubViews];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        
        //[self initSubViews];
        
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
    self.transparentView.alpha = 0;
    self.mainView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.alpha = 1;
        self.transparentView.alpha = 0.5;
    } completion:nil];
    
    /** 背景透明层 **/
    [self addSubview:self.transparentView];
    [self.transparentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    
    /** 弹框bgView **/
    [self addSubview:self.mainView];
    [self.mainView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(32);
        make.right.equalTo(self.right).offset(-32);
        make.centerY.equalTo(self.centerY);
    }];
    
    
}

/**
 弹框消失
 */
- (void)goBack:(id)sender{
    if ([sender isKindOfClass:UITapGestureRecognizer.class]) {
        if (self.isForbidTapBgDismiss) {
            return;
        }
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.transparentView.alpha = 0;
        self.mainView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoView *)transparentView{
    if (!_transparentView){
        _transparentView = [[demoView alloc] init];
        _transparentView.backgroundColor = [UIColor blackColor];
        _transparentView.alpha = .5f;
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack:)];
        [_transparentView addGestureRecognizer:bgTap];
    }
    return _transparentView;
}

- (demoView *)mainView{
    if (!_mainView){
        _mainView = [[demoView alloc] init];
        _mainView.layer.cornerRadius = 6.f;
        _mainView.clipsToBounds = YES;
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

@end
