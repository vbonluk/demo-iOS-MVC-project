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
 *  File name       :      demoAppUpdateView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoAppUpdateView.h"

@interface demoAppUpdateView ()

@property (strong, nonatomic) demoView *transparentView;
@property (strong, nonatomic) demoView *mainView;
@property (strong, nonatomic) demoLabel *titleLabel;
@property (strong, nonatomic) demoLabel *contentLabel;
@property (strong, nonatomic) demoButton *updateBtn;
@property (strong, nonatomic) demoButton *cancelBtn;

@end

@implementation demoAppUpdateView

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
    
    /** 图片 **/
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.mainView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"appUpdate"];
    [imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainView.top).offset(8);
        make.centerX.equalTo(self.mainView.centerX).offset(0);
    }];
    
    /** title **/
    [self.mainView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.bottom).offset(16);
        make.centerX.equalTo(self.mainView.centerX).offset(0);
    }];
    
    /** content **/
    [self.mainView addSubview:self.contentLabel];
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(16);
        make.left.equalTo(self.mainView.left).offset(16);
        make.right.equalTo(self.mainView.right).offset(-16);
    }];
    
    /** 按钮stackview **/
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 10;
    [self.mainView addSubview:stackView];
    [stackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.bottom).offset(16);
        make.left.equalTo(self.mainView.left).offset(10);
        make.right.equalTo(self.mainView.right).offset(-10);
        make.bottom.equalTo(self.mainView.bottom).offset(-8);
    }];
    
    /** 立即更新 **/
    [stackView addArrangedSubview:self.updateBtn];
    [self.updateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
    }];
    /** 暂不更新 **/
    [stackView addArrangedSubview:self.cancelBtn];
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
    }];
}

- (void)goBack{
    
    [UIView animateWithDuration:.25 animations:^{
        self.transparentView.alpha = 0;
        self.mainView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)goUpdate{
    NSString *iosUrl = self.model.checkAppUpdateIOSEntity.iosUrl;
    if ([StringUtil empty:iosUrl] == NO) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iosUrl]];
    }else{
        [demoHudHelper showHudWithText:@"更新路径错误，请反馈此问题" isStay:NO];
    }
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoView *)transparentView{
    if (!_transparentView){
        _transparentView = [[demoView alloc] init];
        _transparentView.backgroundColor = [UIColor blackColor];
        _transparentView.alpha = .5f;
        //UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
        //[_transparentView addGestureRecognizer:bgTap];
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

- (demoLabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[demoLabel alloc] init];
        _titleLabel.text = @"更新提示";
        _titleLabel.fontSize = 17;
    }
    return _titleLabel;
}

- (demoLabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[demoLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}

- (demoButton *)updateBtn{
    if (!_updateBtn){
        _updateBtn = [[demoButton alloc] init];
        _updateBtn.titleText = @"立即更新";
        _updateBtn.titleBgColor = kIAThemeColor;
        _updateBtn.cornerRadius = 6.f;
        [_updateBtn addTarget:self action:@selector(goUpdate) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}

- (demoButton *)cancelBtn{
    if (!_cancelBtn){
        _cancelBtn = [[demoButton alloc] init];
        _cancelBtn.titleText = @"暂不更新";
        _cancelBtn.titleColor = kIAFontColor666666;
        [_cancelBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)setModel:(demoCheckAppUpdateModel *)model{
    _model = model;
    
    self.contentLabel.text = model.checkAppUpdateIOSEntity.httpContent;
    
    NSString *checkUpdateState = model.checkAppUpdateIOSEntity.checkUpdateState;
    
    if ([checkUpdateState isEqualToString:@"must_update"]){
        self.cancelBtn.hidden = YES;
    }else{
        self.cancelBtn.hidden = NO;
    }
}

@end
