//
//  UITableView+SetAndLayoutTableHeaderView.m
//  xfj
//
//  Created by Vbon on 2016/12/29.
//  Copyright © 2016年 bjy. All rights reserved.
//

#import "UITableView+SetAndLayoutTableHeaderView.h"

@implementation UITableView (SetAndLayoutTableHeaderView)

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
 *  File name       :      UITableView+SetAndLayoutTableHeaderView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


- (CGFloat)setAndLayoutTableHeaderView:(UIView *)header;{
    self.tableHeaderView = header;
    [header setNeedsLayout];
    [header layoutIfNeeded];
    //刷新布局后进行UILabel的宽度设置。
    [self parseTreeWithViewSubViewArray:header.subviews];
    CGFloat height = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = header.frame;
    frame.size.height = height;
    header.frame = frame;
    self.tableHeaderView = header;
    return height;
}


/**
 *
 *by Vbon
 *将UIView和subViews组成的结构看成是树，那么这里就形成了多叉树。
 *使用递归来遍历多叉树。
 *
 @param subViewArray subViews的数组
 */
- (void)parseTreeWithViewSubViewArray:(NSArray *)subViewArray{
    if (subViewArray.count == 0) {
        return;
    }
    for (UIView *subView in subViewArray) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)subView;
            //不设置这个属性会导致算出来的高度不准。
            label.preferredMaxLayoutWidth = label.frame.size.width;
        }
        if (subView.subviews.count > 0) {
            [self parseTreeWithViewSubViewArray:subView.subviews];
        }
    }
}

@end
