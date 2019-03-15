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
 *  File name       :      demoButton.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoButton.h"

@implementation demoButton

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

/**
 配置默认样式
 */
- (void)configIAButton{
    self.titleLabel.font = kIAFontNormal;

    
}

/**
 快速设置Label的字体大小
 
 @param fontSize 字号
 */
- (void)setFontSize:(NSInteger)fontSize{
    _fontSize = fontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setTitleText:(NSString *)titleText{
    _titleText = titleText;
    [self setTitle:titleText forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setTitleBgColor:(UIColor *)titleBgColor{
    _titleBgColor = titleBgColor;
    [self setBackgroundColor:titleBgColor];
}

- (void)setTitleAlignment_Horizontal:(UIControlContentHorizontalAlignment)titleAlignment_Horizontal{
    _titleAlignment_Horizontal = titleAlignment_Horizontal;
    self.contentHorizontalAlignment = titleAlignment_Horizontal;
}

- (void)setTitleAlignment_Vertical:(UIControlContentVerticalAlignment)titleAlignment_Vertical{
    _titleAlignment_Vertical = titleAlignment_Vertical;
    self.contentVerticalAlignment = titleAlignment_Vertical;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

@end
