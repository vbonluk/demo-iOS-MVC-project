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
 *  File name       :      demoBackBtnView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoBackBtnView.h"
#import "demoBaseViewController.h"

@interface demoBackBtnView ()

@property (strong, nonatomic) UIStackView *viewsStackView;
@property (strong, nonatomic) UIView *imageBgView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic, readwrite) UIButton *btn;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation demoBackBtnView

/**
 初始化方法
 
 @return 返回Label
 */
- (id)init{
    if((self = [super init])){
        [self configIAButton];
    }
    return self;
}

/**
 初始化方法
 
 @param frame frame
 @return Label
 */
- (id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        [self configIAButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([StringUtil empty:self.title] == NO) {
        self.titleLabel.hidden = NO;
    }else{
        self.titleLabel.hidden = YES;
    }
    
    self.titleLabel.text = self.title;
}

/**
 配置默认样式
 */
- (void)configIAButton{
//    self.backgroundColor = [UIColor yellowColor];
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
        //make.width.equalTo(80);
    }];
    
    [self addSubview:self.viewsStackView];
    [self.viewsStackView addArrangedSubview:self.imageBgView];
    [self.imageBgView addSubview:self.imageView];
    [self.viewsStackView addArrangedSubview:self.titleLabel];
    
    [self addSubview:self.btn];
    
    [self.viewsStackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
        make.width.greaterThanOrEqualTo(80);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.right.equalTo(self.right).offset(0);
        make.bottom.equalTo(self.bottom).offset(0);
    }];
    
    [self.imageBgView makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.height);
    }];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageBgView.left).offset(0);
        make.right.lessThanOrEqualTo(self.imageBgView.right).offset(0);
        make.centerY.equalTo(self.imageBgView.centerY);
    }];
}

- (void)setIsWhtieImage:(BOOL)isWhtieImage{
    if (isWhtieImage) {
        self.imageView.image = [UIImage imageNamed:@"back_white"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"back_black"];
    }
}

- (UIView *)imageBgView{
    if (!_imageBgView){
        _imageBgView = [[UIView alloc] init];
        _imageBgView.backgroundColor = [UIColor clearColor];
    }
    return _imageBgView;
}

- (UIImageView *)imageView{
    if (!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"back_black"];
    }
    return _imageView;
}

- (UIButton *)btn{
    if (!_btn){
        _btn = [[UIButton alloc] init];
        
    }
    return _btn;
}

- (UIStackView *)viewsStackView{
    if (!_viewsStackView){
        _viewsStackView = [[UIStackView alloc] init];
        _viewsStackView.axis = UILayoutConstraintAxisHorizontal;
    }
    return _viewsStackView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HEXCOLOR(0x333333);
        _titleLabel.font = kIAFontNormal;
    }
    return _titleLabel;
}

@end
