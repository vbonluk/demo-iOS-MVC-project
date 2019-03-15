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
 *  File name       :      demoHomeModel.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    
#import "demoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface demoHomeModel : demoBaseModel

@property (strong, nonatomic) NSArray *bannerList;
@property (strong, nonatomic) NSArray *projectList;
@property (strong, nonatomic) NSArray *projectTypeArray;

@end

@interface demoHomeBannerModel : demoBaseModel

@property (copy, nonatomic) NSString *photoUrl;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *adTitle;

@end

@interface demoHomeProjectModel : demoBaseModel

@property (copy, nonatomic) NSString *projectId;
@property (copy, nonatomic) NSString *projectName;
@property (copy, nonatomic) NSString *avgPrice;
@property (copy, nonatomic) NSString *areaName;
@property (copy, nonatomic) NSString *projectMainPhoto;
@property (copy, nonatomic) NSString *positioningDistance;
@property (strong, nonatomic) NSArray *projectSellingPointTags;
@property (copy, nonatomic) NSString *tuanMaxCommission;
@property (assign, nonatomic) NSInteger isOpen;


@end

NS_ASSUME_NONNULL_END
