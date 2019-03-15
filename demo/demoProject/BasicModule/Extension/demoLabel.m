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
 *  File name       :      demoLabel.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */




#import "demoLabel.h"

@implementation demoLabel


/**
 初始化方法

 @return 返回Label
 */
- (id)init{
    if((self = [super init])){
        [self configIALabel];
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
        [self configIALabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    
}

- (void)updateConstraints{
    [super updateConstraints];
    
    @try {
        if ([StringUtil empty:self.text] == NO) {
            /** Label 行间距 **/
            if (self.lineSpace > 0) {
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                [paragraphStyle setLineSpacing:self.lineSpace];//调整行间距
                [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
                self.attributedText = attributedString;
            }
        }
    }
    @catch (NSException *exception) {
        DDLogError(@"exception:%@",exception);
    }
    @finally {
        
    }
}

/**
 配置默认样式
 */
- (void)configIALabel{
    self.textColor = HEXCOLOR(0x333333);
    self.font = kIAFontNormal;
    
    
}

/**
 快速设置Label的字体大小

 @param fontSize 字号
 */
- (void)setFontSize:(NSInteger)fontSize{
    _fontSize = fontSize;
    self.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

@end
