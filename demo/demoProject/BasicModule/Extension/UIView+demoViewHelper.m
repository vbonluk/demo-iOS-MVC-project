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
 *  File name       :      UIView+demoViewHelper.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "UIView+demoViewHelper.h"

@implementation UIView (demoViewHelper)

- (void)setIa_x:(CGFloat)ia_x
{
    CGRect frame = self.frame;
    frame.origin.x = ia_x;
    self.frame = frame;
}

- (CGFloat)ia_x
{
    return self.frame.origin.x;
}

- (void)setIa_y:(CGFloat)ia_y
{
    CGRect frame = self.frame;
    frame.origin.y = ia_y;
    self.frame = frame;
}

- (CGFloat)ia_y
{
    return self.frame.origin.y;
}

- (void)setIa_width:(CGFloat)ia_width
{
    CGRect frame = self.frame;
    frame.size.width = ia_width;
    self.frame = frame;
}

- (CGFloat)ia_width
{
    return self.frame.size.width;
}

- (void)setIa_height:(CGFloat)ia_height
{
    CGRect frame = self.frame;
    frame.size.height = ia_height;
    self.frame = frame;
}

- (CGFloat)ia_height
{
    return self.frame.size.height;
}

- (void)setIa_size:(CGSize)ia_size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = ia_size;
    self.frame = frame;
}

- (CGSize)ia_size
{
    return self.frame.size;
}

@end
