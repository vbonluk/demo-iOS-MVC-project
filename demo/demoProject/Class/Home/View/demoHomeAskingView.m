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
 *  File name       :      demoHomeAskingView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoHomeAskingView.h"

@interface demoHomeAskingView ()



@end

@implementation demoHomeAskingView

#pragma mark - LifeCyle

- (id)init{
    if ((self = [super init])) {
        
        [self initSubViews];
        
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
    
    self.backgroundColor = kIAThemeColor;
    self.layer.cornerRadius = 6.f;
    self.clipsToBounds = YES;
    
    /** 按钮 **/
    demoButton *x_btn = [[demoButton alloc] init];
    [x_btn setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    [x_btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:x_btn];
    [x_btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.centerY.equalTo(self.centerY).offset(0);
    }];
    
    demoLabel *titleLabel = [[demoLabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"没有你想要的楼盘？对我们有疑问？";
    titleLabel.fontSize = 15;
    [self addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(x_btn.right).offset(10);
    }];
    
    demoLabel *subTitleLabel = [[demoLabel alloc] init];
    subTitleLabel.text = @"10年项目专家帮你接项目";
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.fontSize = 12;
    [self addSubview:subTitleLabel];
    [subTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.bottom).offset(2);
        make.left.equalTo(x_btn.right).offset(10);
        make.bottom.equalTo(self.bottom).offset(-10);
    }];
    
    /** 提问按钮 **/
    demoButton *asking_btn = [[demoButton alloc] init];
    asking_btn.titleText = @"提问>";
    asking_btn.fontSize = 15;
    [asking_btn addTarget:self action:@selector(asking) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:asking_btn];
    [asking_btn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.right).offset(-10);
        make.top.equalTo(self.top).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
}

- (void)goBack{
    
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)asking{
    if (self.askingBlock) {
        self.askingBlock();
    }
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters



@end
