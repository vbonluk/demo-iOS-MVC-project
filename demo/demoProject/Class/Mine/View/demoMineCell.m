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
 *  File name       :      demoMineCell.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineCell.h"

@interface demoMineCell ()

@property (strong, nonatomic) demoLabel *titleLabel;

@end

@implementation demoMineCell

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
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"more"];
    [baseView addSubview:imgView];
    [imgView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(baseView.right).offset(-8);
        make.centerY.equalTo(self.titleLabel.centerY);
    }];
    [imgView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [baseView addSubview:self.rightLabel];
    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.centerY).offset(0);
        make.left.equalTo(self.titleLabel.right).offset(0);
        make.right.equalTo(imgView.left).offset(0);
    }];
    
    demoView *line = [[demoView alloc] init];
    line.backgroundColor = HEXCOLOR(0xe6e6e6);
    [baseView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
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

- (demoLabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[demoLabel alloc] init];
        _titleLabel.numberOfLines = 0;
        
    }
    return _titleLabel;
}

- (demoLabel *)rightLabel{
    if (!_rightLabel){
        _rightLabel = [[demoLabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

@end
