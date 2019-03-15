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
 *  File name       :      demoMineSettingCell.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineSettingCell.h"

@interface demoMineSettingCell ()

@property (strong, nonatomic) demoLabel *titleLabel;

@end

@implementation demoMineSettingCell

#pragma mark - LifeCyle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建UI
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Response Mehtods



#pragma mark - Delegate



#pragma mark - Private Methods

/**
 * 初始化视图
 */
- (void)initSubViews{
    
    UIView *baseView = self.contentView;
    
    [baseView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView.top).offset(0);
        make.left.equalTo(baseView.left).offset(8);
    }];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [baseView addSubview:self.rightStackView];
    [self.rightStackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView.top).offset(0);
        make.right.equalTo(baseView.right).offset(-10);
        make.bottom.equalTo(baseView.bottom).offset(0);
    }];
    
    [self.rightStackView addArrangedSubview:self.rightLabel];
    
    [self.rightStackView addArrangedSubview:self.rightImgBgView];
    [self.rightImgBgView addSubview:self.rightImg];
    [self.rightImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightImgBgView.left).offset(0);
        make.right.equalTo(self.rightImgBgView.right).offset(0);
        make.centerY.equalTo(self.rightImgBgView.centerY);
    }];
    
    [baseView addSubview:self.line];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.bottom).offset(0);
        make.left.equalTo(baseView.left).offset(8);
        make.right.equalTo(baseView.right).offset(-8);
        make.bottom.equalTo(baseView.bottom).offset(0);
        make.height.equalTo(1);
    }];
    
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLabel.text = title;
}
- (void)setRightContent:(NSString *)rightContent{
    _rightContent = rightContent;
    
    self.rightLabel.text = rightContent;
}

- (demoLabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[demoLabel alloc] init];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (demoView *)line{
    if (!_line){
        _line = [[demoView alloc] init];
        _line.backgroundColor = HEXCOLOR(0xe6e6e6);
    }
    return _line;
}

- (UIImageView *)rightImg{
    if (!_rightImg){
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"more"];
        [_rightImg setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _rightImg;
}
- (demoView *)rightImgBgView{
    if (!_rightImgBgView){
        _rightImgBgView = [[demoView alloc] init];
        _rightImgBgView.tag = 8888;
    }
    return _rightImgBgView;
}

- (UIStackView *)rightStackView{
    if (!_rightStackView){
        _rightStackView = [[UIStackView alloc] init];
        _rightStackView.axis = UILayoutConstraintAxisHorizontal;
        _rightStackView.spacing = 8;
    }
    return _rightStackView;
}

- (demoLabel *)rightLabel{
    if (!_rightLabel){
        _rightLabel = [[demoLabel alloc] init];
        _rightLabel.tag = 8889;
    }
    return _rightLabel;
}

@end
