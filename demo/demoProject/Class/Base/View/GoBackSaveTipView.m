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
 *  File name       :      GoBackSaveTipView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  GoBackSaveTipView.m
//  xfj
//
//  Created by Vbon on 2018/5/7.
//Copyright © 2018年 bjy. All rights reserved.
//

#import "GoBackSaveTipView.h"

@implementation GoBackSaveTipView


- (void)awakeFromNib{
    [super awakeFromNib];
    
    _mainView.alpha = 0;
    _mainView.layer.cornerRadius = 6.f;
    _mainView.clipsToBounds = YES;
    _bgView.alpha = 0;
    _cancelBtn.alpha = 0;
    
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        blockSelf.mainView.alpha = 1;
        blockSelf.cancelBtn.alpha = 1;
        blockSelf.bgView.alpha = 0.5;
    } completion:nil];
    
}

- (void)goBack{
    __block typeof(self) blockSelf = self;
    [UIView animateWithDuration:.25 animations:^{
        blockSelf.mainView.alpha = 0;
        blockSelf.cancelBtn.alpha = 0;
        blockSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)goCancel:(id)sender {
    if (self.goBackBlock) {
        self.goBackBlock();
    }
    [self goBack];
}

- (IBAction)goTapBgView:(id)sender;{
    [self goBack];
}

- (IBAction)goContinueEdit:(id)sender {
    [self goBack];
}

@end
