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
 *  File name       :      demoHomeProjectCell.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoHomeProjectCell.h"

@interface demoHomeProjectCell ()

@property (strong, nonatomic) UIImageView *projectImageView;
@property (strong, nonatomic) demoLabel *projectLabel;
@property (strong, nonatomic) demoLabel *priceLabel;
@property (strong, nonatomic) demoLabel *locationLabel_1;
@property (strong, nonatomic) demoLabel *splitLine;
@property (strong, nonatomic) demoLabel *locationLabel_2;
@property (strong, nonatomic) UIStackView *projectTagsView;
@property (strong, nonatomic) demoLabel *commissionViewLabel;
@property (strong, nonatomic) demoLabel *commissionLabel;

@end

@implementation demoHomeProjectCell

#pragma mark - Lifecycle

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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Overwrite Super Class

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Response Mehtods



#pragma mark - Delegate



#pragma mark - Private Methods

- (void)setModel:(demoHomeProjectModel *)model{
    _model = model;
    NSString *pUrl = [NSString ia_imageUrlPath:model.projectMainPhoto width:205 *2];
    [self.projectImageView sd_setImageWithURL:[NSURL URLWithString:pUrl] placeholderImage:demoDefaultPlaceholderImage100X100];
    
    self.projectLabel.text = model.projectName;
    self.priceLabel.text = model.avgPrice;
    if ([StringUtil empty:model.areaName] == NO) {
        self.locationLabel_1.text = model.areaName;
    }
    
    if ([StringUtil empty:model.positioningDistance]) {
        self.locationLabel_2.hidden = YES;
        self.splitLine.hidden = YES;
    } else {
        self.locationLabel_2.hidden = NO;
        self.splitLine.hidden = NO;
    }
    self.locationLabel_2.text = model.positioningDistance;
    
    for (UIView *view in self.projectTagsView.subviews) {
        [self.projectTagsView removeArrangedSubview:view];
        [view removeFromSuperview];
    }
    
    for (NSString *tagStr in model.projectSellingPointTags) {
        demoLabel *tagLabel = [[demoLabel alloc] init];
        tagLabel.text = tagStr;
        tagLabel.font = kIAFontSmall;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        if (model.isOpen == 1) {
            // 即将开盘
            tagLabel.textColor = HEXCOLOR(0x33b16c);
            tagLabel.backgroundColor = HEXCOLOR(0xc3e7bd);
        } else {
            tagLabel.textColor = HEXCOLOR(0x996C33);
            tagLabel.backgroundColor = HEXCOLOR(0xffeacb);
        }
        [self.projectTagsView addArrangedSubview:tagLabel];
        CGSize tagLabel_size = [tagStr boundingRectWithSize:CGSizeMake(kDeviceWidth - self.projectImageView.frame.size.width - 30, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : tagLabel.font} context:nil].size;
        [tagLabel makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(tagLabel_size.width + 8);
            make.height.equalTo(tagLabel_size.height + 4);
        }];
        [tagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        
    }
    self.commissionLabel.text = model.tuanMaxCommission;
}

/**
 * 初始化视图
 */
- (void)initSubViews{
    
    [self.contentView addSubview:self.projectImageView];
    [self.contentView addSubview:self.projectLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.locationLabel_1];
    [self.contentView addSubview:self.locationLabel_2];
    [self.contentView addSubview:self.projectTagsView];
    [self.contentView addSubview:self.commissionViewLabel];
    [self.contentView addSubview:self.commissionLabel];
    
    /** projectImageView **/
    [self.projectImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.top).offset(16);
        make.left.equalTo(self.contentView.left).offset(8);
        make.bottom.lessThanOrEqualTo(self.contentView.bottom).offset(-16);
        make.height.equalTo(80).priority(751);
        make.width.equalTo(102);
    }];
    
    /** projectLabel **/
    [self.projectLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.projectImageView.top);
        make.left.equalTo(self.projectImageView.right).offset(8);
        make.bottom.equalTo(self.locationLabel_1.top).offset(-2);
    }];
    [self.projectLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.projectLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    /** priceLabel **/
    [self.priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.projectImageView.top);
        make.left.equalTo(self.projectLabel.right).offset(8);
        make.right.equalTo(self.contentView.right).offset(-8);
    }];
    
    /** 分割线 **/
    [self.contentView addSubview:self.splitLine];
    
    [self.splitLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel_1.top);
        make.left.equalTo(self.locationLabel_1.right).offset(16);
        make.right.equalTo(self.locationLabel_2.left).offset(-16);
    }];
    
    /** locationLabel_1 **/
    [self.locationLabel_1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.projectLabel.left);
    }];
    
    /** locationLabel_2 **/
    [self.locationLabel_2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel_1.top);
    }];
    
    /** projectTagsView **/
    [self.projectTagsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationLabel_1.bottom).offset(2);
        make.left.equalTo(self.projectLabel.left);
        //make.right.lessThanOrEqualTo(self.contentView.right);
        make.bottom.equalTo(self.commissionViewLabel.top).offset(-4);
        make.height.equalTo(self.locationLabel_1.height);
    }];
    
    /** commissionViewLabel **/
    [self.commissionViewLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.projectLabel.left);
        make.right.equalTo(self.commissionLabel.left).offset(-2);
        make.width.equalTo(18);
        make.height.equalTo(18);
    }];
    
    /** commissionLabel **/
    [self.commissionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.commissionViewLabel.centerY);
        make.right.lessThanOrEqualTo(self.contentView.right).offset(-8);
    }];
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters


- (UIImageView *)projectImageView{
    if (!_projectImageView){
        _projectImageView = [[UIImageView alloc] init];
        
    }
    return _projectImageView;
}

- (demoLabel *)projectLabel{
    if (!_projectLabel){
        _projectLabel = [[demoLabel alloc] init];
        _projectLabel.font = kIAFontNormal;
        _projectLabel.textColor = HEXCOLOR(0x333333);
    }
    return _projectLabel;
}

- (demoLabel *)priceLabel{
    if (!_priceLabel){
        _priceLabel = [[demoLabel alloc] init];
        _priceLabel.font = kIAFontNormal;
        _priceLabel.textColor = HEXCOLOR(0x333333);
        _priceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _priceLabel;
}

- (demoLabel *)locationLabel_1{
    if (!_locationLabel_1){
        _locationLabel_1 = [[demoLabel alloc] init];
        _locationLabel_1.font = [UIFont systemFontOfSize:13];
        _locationLabel_1.textColor = HEXCOLOR(0x333333);
    }
    return _locationLabel_1;
}

- (demoLabel *)splitLine{
    if (!_splitLine){
        _splitLine = [[demoLabel alloc] init];
        _splitLine.text = @"|";
        _splitLine.font = self.locationLabel_1.font;
        _splitLine.textColor = self.locationLabel_1.textColor;
    }
    return _splitLine;
}

- (demoLabel *)locationLabel_2{
    if (!_locationLabel_2){
        _locationLabel_2 = [[demoLabel alloc] init];
        _locationLabel_2.font = [UIFont systemFontOfSize:13];
        _locationLabel_2.textColor = HEXCOLOR(0x333333);
    }
    return _locationLabel_2;
}

- (UIStackView *)projectTagsView{
    if (!_projectTagsView){
        _projectTagsView = [[UIStackView alloc] init];
        _projectTagsView.axis = UILayoutConstraintAxisHorizontal;
        _projectTagsView.spacing = 4;
    }
    return _projectTagsView;
}

- (demoLabel *)commissionViewLabel{
    if (!_commissionViewLabel){
        _commissionViewLabel = [[demoLabel alloc] init];
        _commissionViewLabel.text = @"赚";
        _commissionViewLabel.backgroundColor = HEXCOLOR(0xff6638);
        _commissionViewLabel.textColor = [UIColor whiteColor];
        _commissionViewLabel.layer.cornerRadius = 2.f;
        _commissionViewLabel.clipsToBounds = YES;
        _commissionViewLabel.font = [UIFont systemFontOfSize:10];
        _commissionViewLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commissionViewLabel;
}

- (demoLabel *)commissionLabel{
    if (!_commissionLabel){
        _commissionLabel = [[demoLabel alloc] init];
        _commissionLabel.font = kIAFontSmall;
        _commissionLabel.textColor = HEXCOLOR(0xff4d1f);
    }
    return _commissionLabel;
}

@end
