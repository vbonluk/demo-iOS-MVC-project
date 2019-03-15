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
 *  File name       :      demoMineHeaderView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineHeaderView.h"
#import <UIButton+WebCache.h>

@interface demoMineHeaderView ()

@property (strong, nonatomic) demoLabel *nameLabel;
@property (strong, nonatomic) demoLabel *telLabel;
@property (strong, nonatomic) demoButton *headPortraitBtn;
@property (strong, nonatomic) demoLabel *canWithdrawalMoneyLabel;
@property (strong, nonatomic) demoLabel *totalMoneyLabel;
@property (strong, nonatomic) demoLabel *expectMoneyLabel;
@property (strong, nonatomic) demoButton *withdrawalBtn;

@end

@implementation demoMineHeaderView

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
    
    UIView *baseView = self;
    
    [baseView addSubview:self.headPortraitBtn];
    [self.headPortraitBtn makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(baseView.safeAreaLayoutGuideTop).offset(16);
        } else {
            make.top.equalTo(baseView.top).offset(16);
        }
        
        make.left.equalTo(baseView.left).offset(10);
        make.height.equalTo(64);
        make.width.equalTo(64);
    }];
    
    demoView *infoBgView = [[demoView alloc] init];
    [baseView addSubview:infoBgView];
    [infoBgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headPortraitBtn.centerY).offset(0);
        make.left.equalTo(self.headPortraitBtn.right).offset(0);
    }];
    [infoBgView addSubview:self.nameLabel];
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoBgView.top).offset(0);
        make.left.equalTo(infoBgView.left).offset(10);
        make.right.greaterThanOrEqualTo(infoBgView.right).offset(0);
    }];
    
    [infoBgView addSubview:self.telLabel];
    [self.telLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.bottom).offset(10);
        make.left.equalTo(infoBgView.left).offset(10);
        make.right.equalTo(infoBgView.right).offset(0);
        make.bottom.equalTo(infoBgView.bottom).offset(0);
    }];
    
    demoButton *settingBtn = [[demoButton alloc] init];
    [settingBtn setImage:[UIImage imageNamed:@"MineSetting"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(clickSetting) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:settingBtn];
    [settingBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseView.right).offset(-10);
        make.centerY.equalTo(self.nameLabel.centerY);
        make.height.equalTo(50);
        make.width.equalTo(50);
    }];
    
    demoView *moneyBgView = [[demoView alloc] init];
    moneyBgView.backgroundColor = kIAThemeColor;
    moneyBgView.cornerRadius = 3.f;
    [baseView addSubview:moneyBgView];
    [moneyBgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headPortraitBtn.bottom).offset(30);
        make.left.equalTo(baseView.left).offset(10);
        make.right.equalTo(baseView.right).offset(-10);
        make.bottom.equalTo(baseView.bottom).offset(-16);
        make.height.equalTo(150);
    }];
    
    demoLabel *keti = [[demoLabel alloc] init];
    keti.text = @"可提现收入";
    keti.textColor = [UIColor whiteColor];
    [moneyBgView addSubview:keti];
    [keti makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyBgView.top).offset(16);
        make.left.equalTo(moneyBgView.left).offset(16);
    }];
    /** 可提现收入 **/
    [moneyBgView addSubview:self.canWithdrawalMoneyLabel];
    [self.canWithdrawalMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keti.bottom).offset(4);
        make.left.equalTo(moneyBgView.left).offset(16);
    }];
    
    demoButton *ketixianBtn = [[demoButton alloc] init];
    [ketixianBtn addTarget:self action:@selector(ketixianshouru) forControlEvents:UIControlEventTouchUpInside];
    [moneyBgView addSubview:ketixianBtn];
    [ketixianBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keti.top).offset(0);
        make.left.equalTo(keti.left).offset(0);
        make.right.equalTo(keti.right).offset(0);
        make.bottom.equalTo(self.canWithdrawalMoneyLabel.bottom).offset(0);
    }];
    
    
    /** 提现按钮 **/
    [moneyBgView addSubview:self.withdrawalBtn];
    [self.withdrawalBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.canWithdrawalMoneyLabel.bottom).offset(-10);
        make.right.equalTo(moneyBgView.right).offset(8);
    }];
    
    /** 累计收入 **/
    [moneyBgView addSubview:self.totalMoneyLabel];
    [self.totalMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyBgView.left).offset(16);
        make.bottom.equalTo(moneyBgView.bottom).offset(-16);
    }];
    
    demoLabel *totalTitleLabel = [[demoLabel alloc] init];
    totalTitleLabel.text = @"累计收入";
    totalTitleLabel.fontSize = 12;
    totalTitleLabel.textColor = [UIColor whiteColor];
    [moneyBgView addSubview:totalTitleLabel];
    [totalTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyBgView.left).offset(16);
        make.bottom.equalTo(self.totalMoneyLabel.top).offset(-4);
    }];
    
    demoButton *leijiBtn = [[demoButton alloc] init];
    [leijiBtn addTarget:self action:@selector(leijishouru) forControlEvents:UIControlEventTouchUpInside];
    [moneyBgView addSubview:leijiBtn];
    [leijiBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalTitleLabel.top).offset(0);
        make.left.equalTo(totalTitleLabel.left).offset(0);
        make.right.equalTo(totalTitleLabel.right).offset(0);
        make.bottom.equalTo(self.totalMoneyLabel.bottom).offset(0);
    }];
    
    /** 预计收入 **/
    [moneyBgView addSubview:self.expectMoneyLabel];
    [self.expectMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyBgView.centerX).offset(40);
        make.bottom.equalTo(moneyBgView.bottom).offset(-16);
    }];
    
    demoLabel *expectTitleLabel = [[demoLabel alloc] init];
    expectTitleLabel.text = @"预计收入";
    expectTitleLabel.fontSize = 12;
    expectTitleLabel.textColor = [UIColor whiteColor];
    [moneyBgView addSubview:expectTitleLabel];
    [expectTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.expectMoneyLabel.left).offset(0);
        make.bottom.equalTo(self.expectMoneyLabel.top).offset(-4);
    }];
    
    demoButton *yujiBtn = [[demoButton alloc] init];
    [yujiBtn addTarget:self action:@selector(yujishouru) forControlEvents:UIControlEventTouchUpInside];
    [moneyBgView addSubview:yujiBtn];
    [yujiBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(expectTitleLabel.top).offset(0);
        make.left.equalTo(expectTitleLabel.left).offset(0);
        make.right.equalTo(expectTitleLabel.right).offset(0);
        make.bottom.equalTo(self.expectMoneyLabel.bottom).offset(0);
    }];
}

/**
 设置
 */
- (void)clickSetting{
    if (self.clickSettingBlock) {
        self.clickSettingBlock();
    }
}

/**
 提现
 */
- (void)tixian{
    if (self.clickTiXian) {
        self.clickTiXian();
    }
}

/**
 点击可提现收入
 */
- (void)ketixianshouru{
    if (self.clickKetixianshouru) {
        self.clickKetixianshouru();
    }
}
/**
 点击累计收入
 */
- (void)leijishouru{
    if (self.clickLeijishouru) {
        self.clickLeijishouru();
    }
}
/**
 点击预计收入
 */
- (void)yujishouru{
    if (self.clickYujishouru) {
        self.clickYujishouru();
    }
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoLabel *)nameLabel{
    if (!_nameLabel){
        _nameLabel = [[demoLabel alloc] init];
        _nameLabel.text = @"---";
    }
    return _nameLabel;
}

- (demoLabel *)telLabel{
    if (!_telLabel){
        _telLabel = [[demoLabel alloc] init];
        _telLabel.text = @"---";
    }
    return _telLabel;
}

- (demoButton *)headPortraitBtn{
    if (!_headPortraitBtn){
        _headPortraitBtn = [[demoButton alloc] init];
        _headPortraitBtn.layer.cornerRadius = 32;
        _headPortraitBtn.clipsToBounds = YES;
    }
    return _headPortraitBtn;
}

- (demoLabel *)canWithdrawalMoneyLabel{
    if (!_canWithdrawalMoneyLabel){
        _canWithdrawalMoneyLabel = [[demoLabel alloc] init];
        _canWithdrawalMoneyLabel.text = @"0.00";
        _canWithdrawalMoneyLabel.textColor = [UIColor whiteColor];
    }
    return _canWithdrawalMoneyLabel;
}

- (demoLabel *)totalMoneyLabel{
    if (!_totalMoneyLabel){
        _totalMoneyLabel = [[demoLabel alloc] init];
        _totalMoneyLabel.text = @"0.00";
        _totalMoneyLabel.textColor = [UIColor whiteColor];
    }
    return _totalMoneyLabel;
}

- (demoLabel *)expectMoneyLabel{
    if (!_expectMoneyLabel){
        _expectMoneyLabel = [[demoLabel alloc] init];
        _expectMoneyLabel.text = @"0.00";
        _expectMoneyLabel.textColor = [UIColor whiteColor];
    }
    return _expectMoneyLabel;
}

- (demoButton *)withdrawalBtn{
    if (!_withdrawalBtn){
        _withdrawalBtn = [[demoButton alloc] init];
        [_withdrawalBtn setImage:[UIImage imageNamed:@"MineTiXian"] forState:UIControlStateNormal];
        [_withdrawalBtn addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawalBtn;
}

- (void)setModel:(demoMineModel *)model{
    _model = model;
    
    self.nameLabel.text = model.userName;
    self.telLabel.text = model.userPhone;
    [self.headPortraitBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString ia_imageUrlPath:model.userAvatar width:100]] forState:UIControlStateNormal placeholderImage:demoDefaultProfilePhoto];
    
}

@end
