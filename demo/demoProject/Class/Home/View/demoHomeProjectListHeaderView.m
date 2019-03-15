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
 *  File name       :      demoHomeProjectListHeaderView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoHomeProjectListHeaderView.h"
#import "SDCycleScrollView.h"
#import "demoHomeBannerCell.h"

@interface demoHomeProjectListHeaderView ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *headerBannerView;

@property (strong, nonatomic) demoLabel *rightLabel_1;
@property (strong, nonatomic) UIView *rightLabel_underline_1;
@property (strong, nonatomic) UIButton *rightLabel_btn_1;
@property (strong, nonatomic) UIView *rightLabel_bgView_1;

@property (strong, nonatomic) demoLabel *rightLabel_2;
@property (strong, nonatomic) UIView *rightLabel_underline_2;
@property (strong, nonatomic) UIButton *rightLabel_btn_2;
@property (strong, nonatomic) UIView *rightLabel_bgView_2;

@property (strong, nonatomic) demoLabel *rightLabel_3;
@property (strong, nonatomic) UIView *rightLabel_underline_3;
@property (strong, nonatomic) UIButton *rightLabel_btn_3;
@property (strong, nonatomic) UIView *rightLabel_bgView_3;

@end

@implementation demoHomeProjectListHeaderView

@synthesize model = _model;

#pragma mark - LifeCyle

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

// Banner view delegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view;{
    return [demoHomeBannerCell class];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;{
    if (self.clickBannerBlock) {
        self.clickBannerBlock(index);
    }
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view;{
    
    demoHomeBannerCell *cell_banner = (demoHomeBannerCell *)cell;
    
    NSMutableArray *photoUrlsArr = [NSMutableArray array];
    for (demoHomeBannerModel *bannerModel in self.model.bannerList) {
        if ([StringUtil empty:bannerModel.photoUrl] == NO) {
            [photoUrlsArr addObject:[NSString ia_imageUrlPath:bannerModel.photoUrl]];
        }
    }
    if (photoUrlsArr.count > 0) {
        NSString *photoUrl = photoUrlsArr[index];
        [cell_banner.imageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:demoDefaultPlaceholderImage320X200];
    }
}

#pragma mark - Private Methods

/**
 * 初始化视图
 */
- (void)initSubViews{
    /** header background view **/
    UIView *hbgView = [[UIView alloc] init];
    hbgView.backgroundColor = kIAThemeColor;
    [self addSubview:hbgView];
    [hbgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.right.equalTo(self);
        make.height.equalTo(120);
    }];
    
    /** banner **/
    [self addSubview:self.headerBannerView];
    [self.headerBannerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(4);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.height.equalTo(kDeviceWidth * (2/5.0));
    }];
    
    /** labels **/
    [self.rightLabel_bgView_1 addSubview:self.rightLabel_1];
    [self.rightLabel_bgView_1 addSubview:self.rightLabel_underline_1];
    [self.rightLabel_bgView_1 addSubview:self.rightLabel_btn_1];
    [self addSubview:self.rightLabel_bgView_1];
    
    [self.rightLabel_bgView_2 addSubview:self.rightLabel_2];
    [self.rightLabel_bgView_2 addSubview:self.rightLabel_underline_2];
    [self.rightLabel_bgView_2 addSubview:self.rightLabel_btn_2];
    [self addSubview:self.rightLabel_bgView_2];
    
    [self.rightLabel_bgView_3 addSubview:self.rightLabel_3];
    [self.rightLabel_bgView_3 addSubview:self.rightLabel_underline_3];
    [self.rightLabel_bgView_3 addSubview:self.rightLabel_btn_3];
    [self addSubview:self.rightLabel_bgView_3];
    
    UIView *leftLabelView = [[UIView alloc] init];
    [self addSubview:leftLabelView];
    
    demoLabel *bigTitleLabel = [[demoLabel alloc] init];
    bigTitleLabel.text = @"精选新房";
    bigTitleLabel.font = [UIFont systemFontOfSize:25];
    bigTitleLabel.textColor = HEXCOLOR(0x333333);
    
    demoLabel *smallTitleLabel = [[demoLabel alloc] init];
    smallTitleLabel.text = @"超级项目专家精选高佣项目";
    smallTitleLabel.font = [UIFont systemFontOfSize:11];
    smallTitleLabel.textColor = HEXCOLOR(0x999999);
    
    [leftLabelView addSubview:bigTitleLabel];
    [leftLabelView addSubview:smallTitleLabel];
    
    [leftLabelView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerBannerView.bottom).offset(30);
        make.left.equalTo(self.left).offset(8);
        make.bottom.equalTo(self.bottom);
    }];
    
    [bigTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabelView.left).offset(0);
        make.top.equalTo(leftLabelView.top);
        make.bottom.equalTo(smallTitleLabel.top);
    }];
    [smallTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLabelView.left).offset(0);
        make.bottom.equalTo(leftLabelView.bottom);
    }];
    
    /** rightLabel_1 **/
    [self.rightLabel_1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.rightLabel_bgView_1);
        make.bottom.equalTo(self.rightLabel_underline_1.top).offset(-2);
    }];
    [self.rightLabel_underline_1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLabel_bgView_1.left).offset(4);
        make.right.equalTo(self.rightLabel_bgView_1.right).offset(-4);
        make.bottom.equalTo(self.rightLabel_bgView_1.bottom);
        make.height.equalTo(2);
    }];
    [self.rightLabel_bgView_1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLabelView.centerY);
        make.right.equalTo(self.rightLabel_bgView_2.left).offset(-16);
    }];
    [self.rightLabel_btn_1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.rightLabel_bgView_1);
    }];
    
    /** rightLabel_2 **/
    [self.rightLabel_2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.rightLabel_bgView_2);
        make.bottom.equalTo(self.rightLabel_underline_2.top).offset(-2);
    }];
    [self.rightLabel_underline_2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLabel_bgView_2.left).offset(4);
        make.right.equalTo(self.rightLabel_bgView_2.right).offset(-4);
        make.bottom.equalTo(self.rightLabel_bgView_2.bottom);
        make.height.equalTo(2);
    }];
    [self.rightLabel_bgView_2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLabelView.centerY);
        make.right.equalTo(self.rightLabel_bgView_3.left).offset(-16);
    }];
    [self.rightLabel_btn_2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.rightLabel_bgView_2);
    }];
    
    /** rightLabel_3 **/
    [self.rightLabel_3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.rightLabel_bgView_3);
        make.bottom.equalTo(self.rightLabel_underline_3.top).offset(-2);
    }];
    [self.rightLabel_underline_3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLabel_bgView_3.left).offset(4);
        make.right.equalTo(self.rightLabel_bgView_3.right).offset(-4);
        make.bottom.equalTo(self.rightLabel_bgView_3.bottom);
        make.height.equalTo(2);
    }];
    [self.rightLabel_bgView_3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLabelView.centerY);
        make.right.equalTo(self.right).offset(-8);
    }];
    [self.rightLabel_btn_3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.rightLabel_bgView_3);
    }];
}

- (void)tapBtn_1{
    if (self.tapTpypWithIndex) {
        self.tapTpypWithIndex(0);
    }
    self.rightLabel_1.textColor = HEXCOLOR(0x333333);
    self.rightLabel_2.textColor = HEXCOLOR(0x999999);
    self.rightLabel_3.textColor = HEXCOLOR(0x999999);
    
    self.rightLabel_underline_1.hidden = NO;
    self.rightLabel_underline_2.hidden = YES;
    self.rightLabel_underline_3.hidden = YES;
}

- (void)tapBtn_2{
    if (self.tapTpypWithIndex) {
        self.tapTpypWithIndex(1);
    }
    self.rightLabel_1.textColor = HEXCOLOR(0x999999);
    self.rightLabel_2.textColor = HEXCOLOR(0x333333);
    self.rightLabel_3.textColor = HEXCOLOR(0x999999);
    
    self.rightLabel_underline_1.hidden = YES;
    self.rightLabel_underline_2.hidden = NO;
    self.rightLabel_underline_3.hidden = YES;
}

- (void)tapBtn_3{
    if (self.tapTpypWithIndex) {
        self.tapTpypWithIndex(2);
    }
    self.rightLabel_1.textColor = HEXCOLOR(0x999999);
    self.rightLabel_2.textColor = HEXCOLOR(0x999999);
    self.rightLabel_3.textColor = HEXCOLOR(0x333333);
    
    self.rightLabel_underline_1.hidden = YES;
    self.rightLabel_underline_2.hidden = YES;
    self.rightLabel_underline_3.hidden = NO;
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (demoHomeModel *)model{
    if (!_model) {
        _model = [[demoHomeModel alloc] init];
    }
    return _model;
}

- (void)setModel:(demoHomeModel *)model{
    _model = model;
    
    NSMutableArray *photoUrlsArr = [NSMutableArray array];
    for (demoHomeBannerModel *bannerModel in self.model.bannerList) {
        if ([StringUtil empty:bannerModel.photoUrl] == NO) {
            [photoUrlsArr addObject:[NSString ia_imageUrlPath:bannerModel.photoUrl]];
        }
    }
    if (photoUrlsArr.count > 0) {
        self.headerBannerView.imageURLStringsGroup = photoUrlsArr;
    }
}

- (SDCycleScrollView *)headerBannerView{
    if (!_headerBannerView) {
        _headerBannerView = [[SDCycleScrollView alloc] init];
        _headerBannerView.backgroundColor = [UIColor clearColor];
        _headerBannerView.delegate = self;
    }
    return _headerBannerView;
}

- (demoLabel *)rightLabel_1{
    if (!_rightLabel_1) {
        _rightLabel_1 = [[demoLabel alloc] init];
        _rightLabel_1.text = @"精选";
        _rightLabel_1.textColor = HEXCOLOR(0x333333);
        _rightLabel_1.font = kIAFontNormal;
    }
    return _rightLabel_1;
}

- (UIView *)rightLabel_underline_1{
    if (!_rightLabel_underline_1) {
        _rightLabel_underline_1 = [[UIView alloc] init];
        _rightLabel_underline_1.backgroundColor = HEXCOLOR(0xd3b17f);
    }
    return _rightLabel_underline_1;
}

- (UIButton *)rightLabel_btn_1{
    if (!_rightLabel_btn_1) {
        _rightLabel_btn_1 = [[UIButton alloc] init];
        [_rightLabel_btn_1 addTarget:self action:@selector(tapBtn_1) forControlEvents:UIControlEventTouchUpInside];
        [_rightLabel_btn_1 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    }
    return _rightLabel_btn_1;
}

- (UIView *)rightLabel_bgView_1{
    if (!_rightLabel_bgView_1) {
        _rightLabel_bgView_1 = [[UIView alloc] init];
        _rightLabel_bgView_1.backgroundColor = [UIColor clearColor];
    }
    return _rightLabel_bgView_1;
}

- (demoLabel *)rightLabel_2{
    if (!_rightLabel_2) {
        _rightLabel_2 = [[demoLabel alloc] init];
        _rightLabel_2.text = @"住宅";
        _rightLabel_2.textColor = HEXCOLOR(0x999999);
        _rightLabel_2.font = kIAFontNormal;
    }
    return _rightLabel_2;
}

- (UIView *)rightLabel_underline_2{
    if (!_rightLabel_underline_2) {
        _rightLabel_underline_2 = [[UIView alloc] init];
        _rightLabel_underline_2.backgroundColor = HEXCOLOR(0xd3b17f);
        _rightLabel_underline_2.hidden = YES;
    }
    return _rightLabel_underline_2;
}

- (UIButton *)rightLabel_btn_2{
    if (!_rightLabel_btn_2) {
        _rightLabel_btn_2 = [[UIButton alloc] init];
        [_rightLabel_btn_2 addTarget:self action:@selector(tapBtn_2) forControlEvents:UIControlEventTouchUpInside];
        [_rightLabel_btn_2 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    }
    return _rightLabel_btn_2;
}

- (UIView *)rightLabel_bgView_2{
    if (!_rightLabel_bgView_2) {
        _rightLabel_bgView_2 = [[UIView alloc] init];
        _rightLabel_bgView_2.backgroundColor = [UIColor clearColor];
    }
    return _rightLabel_bgView_2;
}

- (demoLabel *)rightLabel_3{
    if (!_rightLabel_3) {
        _rightLabel_3 = [[demoLabel alloc] init];
        _rightLabel_3.text = @"商业";
        _rightLabel_3.textColor = HEXCOLOR(0x999999);
        _rightLabel_3.font = kIAFontNormal;
    }
    return _rightLabel_3;
}

- (UIView *)rightLabel_underline_3{
    if (!_rightLabel_underline_3) {
        _rightLabel_underline_3 = [[UIView alloc] init];
        _rightLabel_underline_3.backgroundColor = HEXCOLOR(0xd3b17f);
        _rightLabel_underline_3.hidden = YES;
    }
    return _rightLabel_underline_3;
}

- (UIButton *)rightLabel_btn_3{
    if (!_rightLabel_btn_3) {
        _rightLabel_btn_3 = [[UIButton alloc] init];
        [_rightLabel_btn_3 addTarget:self action:@selector(tapBtn_3) forControlEvents:UIControlEventTouchUpInside];
        [_rightLabel_btn_3 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    }
    return _rightLabel_btn_3;
}

- (UIView *)rightLabel_bgView_3{
    if (!_rightLabel_bgView_3) {
        _rightLabel_bgView_3 = [[UIView alloc] init];
        _rightLabel_bgView_3.backgroundColor = [UIColor clearColor];
    }
    return _rightLabel_bgView_3;
}


@end
