//
//  SkyAssociationMenuView.h
//  iOSTest
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) // 获取屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) // 获取屏幕高度

@class SkyAssociationMenuView;

@protocol SkyAssociationMenuViewDelegate <NSObject>
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
 *  File name       :      SkyAssociationMenuView.h
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


- (NSInteger)assciationMenuView:(SkyAssociationMenuView*)asView countForClass:(NSInteger)idx;

/**
 *  获取第一级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1;

/**
 *  获取第二级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2;

/**
 *  获取第三级菜单选项的title
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 标题
 */
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3;
@optional
/**
 *  取消选择
 */
- (void)assciationMenuViewCancel;

/**
 *  选择第一级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1;
/**
 *  选择第二级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *
 *  @return 是否展示下一级
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2;
/**
 *  选择第三级菜单
 *
 *  @param asView 联想菜单
 *  @param idx_1  第一级
 *  @param idx_2  第二级
 *  @param idx_3  第三级
 *
 *  @return 是否dismiss
 */
- (BOOL)assciationMenuView:(SkyAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
@end

/**
 *  三级联动菜单
 */

typedef void(^ActionMultipleStringDoneBlock)(SkyAssociationMenuView *saView, NSArray *selectedIndexes, id selectedValues);
typedef void(^ActionMultipleStringCancelBlock)(SkyAssociationMenuView *saView);
typedef void(^ActionMultipleStringSelectedBlock)(SkyAssociationMenuView *saView ,NSInteger row ,NSInteger component);
typedef void(^ActionMultipleStringSelected_TableView_1_Block)(SkyAssociationMenuView *saView ,NSInteger leftIndex,NSInteger rightIndex);
typedef BOOL(^ActionMultipleStringSelected_TableView_2_Block)(SkyAssociationMenuView *saView ,NSInteger leftIndex,NSInteger rightIndex);

@interface SkyAssociationMenuView : UIView{
@private
    NSInteger sels[3];
}
extern __strong NSString *const IDENTIFIER;
@property (weak,nonatomic) id<SkyAssociationMenuViewDelegate> delegate;

@property (nonatomic, assign)CGFloat showRows;
@property (nonatomic, assign)CGFloat rowHeight;
@property (nonatomic, assign)CGFloat bottomSpace;// 底部留白空间 默认 0
@property (nonatomic, assign)BOOL isRelativeSelect;//是否联动 by vbon
@property (nonatomic, strong)UIView *customBottomView;//是否显示定制的底部 by vbon
@property (nonatomic, copy) void(^ClickCustomBottom)(void);//点击自定义的底部 by vbon
@property (nonatomic, assign)BOOL isMultableSelectInOneMenu;//是否在单级列表中多选。 by vbon
@property (nonatomic, strong)NSMutableArray *multableSelectedMenuArray;//单级列表中多选数组 by vbon
@property (nonatomic, assign)NSInteger multableSelectedMenuMaxCount;//单级列表中多选最多可以选中多少个 default is 3 by vbon
@property (nonatomic, copy) void(^goMultableSelectedMenuMaxCountWarning)(void);//单级列表中多选超过最大数时调用block。by vbon
@property (nonatomic, copy)ActionMultipleStringDoneBlock actionMultipleStringDoneBlock;
@property (nonatomic, copy)ActionMultipleStringSelected_TableView_1_Block actionMultipleStringSelected_TableView_1_Block;//点击第一个列表的回调
@property (nonatomic, copy)ActionMultipleStringSelected_TableView_2_Block actionMultipleStringSelected_TableView_2_Block;//点击第二个列表的回调
@property (nonatomic, assign)BOOL isShowTipsLabel;//是否显示列表顶部选择提示label。
@property (nonatomic, assign)BOOL isForbidenSelectedMorethan;//是否禁止右边的选择小于左边的
@property (nonatomic, strong)NSArray *tipsLabelStrArray;//类别顶部选择提示的文字数组

- (void)showViewWithRows:(NSArray *)strings initialSelection:(NSArray *)indexes doneBlock:(ActionMultipleStringDoneBlock)doneBlock cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil origin:(id)origin selectedBlock:(ActionMultipleStringSelectedBlock)selectedBlock;

- (void)showViewWithRows:(NSArray *)strings initialSelection:(NSArray *)indexes doneBlock:(ActionMultipleStringDoneBlock)doneBlock cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil origin:(id)origin selectedBlock:(ActionMultipleStringSelectedBlock)selectedBlock selectedTable_1:(ActionMultipleStringSelected_TableView_1_Block)selectedTable_1 selectedTable_2:(ActionMultipleStringSelected_TableView_2_Block)selectedTable_2;

/**
 *  当左边数据选择时，配置右边数据
 */
- (void)configRightTableViewWith:(NSInteger)selectedIndex;
/**
 *  设置选中项，-1为未选中
 *
 *  @param idx_1  第一级选中项
 *  @param idx_2  第二级选中项
 *  @param idx_3  第三级选中项
 */
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3;
/**
 *  菜单显示在View的下面
 *
 *  @param view 显示在该view下
 */
- (void)showAsDrawDownView:(UIView*) view;
/**
 *  隐藏菜单
 */
- (void)dismiss;
@end
