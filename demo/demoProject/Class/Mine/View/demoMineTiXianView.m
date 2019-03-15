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
 *  File name       :      demoMineTiXianView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineTiXianView.h"

@interface demoMineTiXianView ()



@end

@implementation demoMineTiXianView

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
    [super initSubViews];
    
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.top).offset(32);
        make.left.equalTo(self.mainView.left).offset(8);
        make.right.equalTo(self.mainView.right).offset(-8);
    }];
    
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(25);
        make.left.equalTo(self.mainView.left).offset(8);
        make.right.equalTo(self.mainView.right).offset(-8);
    }];
    
    /** 横线 **/
    demoView *line = [[demoView alloc] init];
    line.backgroundColor = kIASplitLineColor;
    [self.mainView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.bottom).offset(32);
        make.left.equalTo(self.mainView.left).offset(0);
        make.right.equalTo(self.mainView.right).offset(0);
        make.height.equalTo(1);
    }];
    
    /** 按钮 **/
    demoButton *okBtn = [[demoButton alloc] init];
    okBtn.titleText = @"好的";
    okBtn.titleColor = kIAThemeColor;
    [okBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:okBtn];
    [okBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.bottom).offset(0);
        make.left.equalTo(self.mainView.left).offset(0);
        make.right.equalTo(self.mainView.right).offset(0);
        make.bottom.equalTo(self.mainView.bottom).offset(0);
        make.height.equalTo(44);
    }];
    
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoLabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[demoLabel alloc] init];
        _titleLabel.fontSize = 17;
        _titleLabel.text = @"温馨提示";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (demoLabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[demoLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"暂无可提现收入";
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
