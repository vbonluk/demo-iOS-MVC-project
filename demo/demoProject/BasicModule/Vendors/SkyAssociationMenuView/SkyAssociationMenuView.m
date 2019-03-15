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
 *  File name       :      SkyAssociationMenuView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  SkyAssociationMenuView.m
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SkyAssociationMenuView.h"
#import "UIApplication+demoGetCurrentViewController.h"

NSString *const IDENTIFIER = @"CELL";

@interface SkyAssociationMenuView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSMutableArray *tables;
    UIView *bgView;
    NSArray *dataArray;
    
    UIView *assistantBar;
    
    NSMutableArray *selectedIndexArray;
    NSMutableArray *selectedDataArray;
    
}
@end

@implementation SkyAssociationMenuView{
    UIButton *cancelBtn;
}

- (void)showViewWithRows:(NSArray *)strings initialSelection:(NSArray *)indexes doneBlock:(ActionMultipleStringDoneBlock)doneBlock cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil origin:(id)origin selectedBlock:(ActionMultipleStringSelectedBlock)selectedBlock;{
    
    [self.superview endEditing:YES];
    
    // 初始化菜单
    tables = [NSMutableArray array];
    for (int i = 0; i<strings.count; i ++) {
        [tables addObject:[[UITableView alloc] init]];
    }
    [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
        table.dataSource = self;
        table.delegate = self;
        table.frame = CGRectMake(0, 0, 0, 0);
        table.backgroundColor = [UIColor whiteColor];
        //            table.tableFooterView = [UIView new];
    }];
    
    _showRows = 6;
    _rowHeight = 44;
    
    dataArray = [NSArray array];
    selectedIndexArray = [NSMutableArray array];
    for (int i = 0; i < indexes.count; i ++) {
        [selectedIndexArray addObject:indexes[i]];
    }
    selectedDataArray = [NSMutableArray array];
    for (int i = 0; i < strings.count; i ++) {
        [selectedDataArray addObject:@""];
    }
    
    self.actionMultipleStringDoneBlock = doneBlock;
    
    dataArray = strings;
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = self.frame;
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    //assistant bar
    if ([NSObject isBangs]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] activityViewController].view.safeAreaInsets;
            assistantBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - safeAreaInsets.bottom, SCREEN_WIDTH, 44)];
        } else {
            // Fallback on earlier versions
        }
    }else{
        assistantBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44)];
    }
    assistantBar.backgroundColor  = [UIColor whiteColor];
    UIButton *cancleBtn_AssistantBar = [[UIButton alloc] initWithFrame:CGRectMake(8, 0, 40, 44)];
    [cancleBtn_AssistantBar setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn_AssistantBar addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn_AssistantBar.center = CGPointMake(cancleBtn_AssistantBar.center.x, assistantBar.frame.size.height / 2.0);
    [cancleBtn_AssistantBar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn_AssistantBar.titleLabel.font = kIAFontNormal;
    [assistantBar addSubview:cancleBtn_AssistantBar];
    
    if (dataArray.count > 1 || _isMultableSelectInOneMenu == YES) {
        UIButton *confirmBtn;
        if ([NSObject isBangs]) {
            if (@available(iOS 11.0, *)) {
                UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] activityViewController].view.safeAreaInsets;
                confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - safeAreaInsets.bottom - 40 - 8, 0, 40, 44)];
            } else {
                // Fallback on earlier versions
            }
        }else{
            confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 8, 0, 40, 44)];
        }
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        confirmBtn.center = CGPointMake(confirmBtn.center.x, assistantBar.frame.size.height / 2.0);
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = kIAFontNormal;
        [assistantBar addSubview:confirmBtn];
    }
    
    [cancelBtn addSubview:assistantBar];
    
    __block NSInteger sRows = 0;
    for (int i = 0; i < strings.count; i ++) {
        [cancelBtn addSubview:[tables objectAtIndex:i]];
        
        NSArray *arr = strings[i];
        if (sRows < arr.count) {
            sRows = arr.count;
        }
        if (i == strings.count - 1) {
            if (sRows < _showRows) {
                _showRows = sRows;
            }
        }
    }
    
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = .0f;
        /*
         [UIView animateWithDuration:.25f animations:^{
         self.alpha = 1.0f;
         [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
         CGRect rect = t.frame;
         rect.origin.y = SCREEN_HEIGHT - (_showRows * _rowHeight);
         rect.size.height = _showRows *_rowHeight;
         t.frame = rect;
         }];
         assistantBar.frame = CGRectMake(0, SCREEN_HEIGHT - _showRows * _rowHeight - 44, SCREEN_WIDTH, 44);
         }];
         */
        
        //by Vbon
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
            for (int i = 0; i < self->tables.count; i ++) {
                UITableView *t = self->tables[i];
                CGRect rect = t.frame;
                if ([NSObject isBangs]) {
                    if (@available(iOS 11.0, *)) {
                        UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] activityViewController].view.safeAreaInsets;
                        rect.origin.y = SCREEN_HEIGHT - safeAreaInsets.bottom - (self->_showRows * self->_rowHeight);
                    } else {
                        // Fallback on earlier versions
                    }
                }else{
                    rect.origin.y = SCREEN_HEIGHT - (self->_showRows * self->_rowHeight);
                }
                
                rect.size.height = self->_showRows *self->_rowHeight;
                t.frame = rect;
            }
            if ([NSObject isBangs]) {
                if (@available(iOS 11.0, *)) {
                    UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication] activityViewController].view.safeAreaInsets;
                    self->assistantBar.frame = CGRectMake(0, SCREEN_HEIGHT - safeAreaInsets.bottom - self->_showRows * self->_rowHeight - 44, SCREEN_WIDTH, 44);
                } else {
                    // Fallback on earlier versions
                }
            }else{
                self->assistantBar.frame = CGRectMake(0, SCREEN_HEIGHT - self->_showRows * self->_rowHeight - 44, SCREEN_WIDTH, 44);
            }
            
        } completion:^(BOOL finished) {
            [self->tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
                NSArray *firstArray = [strings firstObject];
                if (firstArray != nil && firstArray.count > 0) {
                    [t scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self->selectedIndexArray[idx] integerValue] inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
                }
            }];
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)showViewWithRows:(NSArray *)strings initialSelection:(NSArray *)indexes doneBlock:(ActionMultipleStringDoneBlock)doneBlock cancelBlock:(ActionMultipleStringCancelBlock)cancelBlockOrNil origin:(id)origin selectedBlock:(ActionMultipleStringSelectedBlock)selectedBlock selectedTable_1:(ActionMultipleStringSelected_TableView_1_Block)selectedTable_1 selectedTable_2:(ActionMultipleStringSelected_TableView_2_Block)selectedTable_2{
    [self showViewWithRows:strings initialSelection:indexes doneBlock:doneBlock cancelBlock:cancelBlockOrNil origin:(id)origin selectedBlock:selectedBlock];
    
    _actionMultipleStringSelected_TableView_1_Block = selectedTable_1;
    _actionMultipleStringSelected_TableView_2_Block = selectedTable_2;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        for(int i=0; i!=3; ++i) {
            sels[i] = -1;
        }
        
        dataArray = [NSArray array];
        selectedIndexArray = [NSMutableArray arrayWithArray:@[@0,@0,@0]];
        selectedDataArray = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
        
        if (_multableSelectedMenuArray == nil) {
            _multableSelectedMenuArray = [NSMutableArray array];
        }
        _multableSelectedMenuMaxCount = 3;
        
        CGFloat x = 0.f;
        CGFloat y = 0;
        CGFloat w = SCREEN_WIDTH;
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        bgView.frame = CGRectMake(x, y, w, SCREEN_HEIGHT);
        [self addSubview:bgView];
        
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //        self.userInteractionEnabled = YES;
        
    }
    return self;
}

#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        if (rect.origin.y == 0) {
            rect.origin.y = SCREEN_HEIGHT;
        }
        rect.size.height = self->_showRows *self->_rowHeight;
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
        t.layer.borderColor = [UIColor lightGrayColor].CGColor;
        t.layer.borderWidth = .25f;
        if ([t respondsToSelector:@selector(setSeparatorInset:)]) {
            [t setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([t respondsToSelector:@selector(setLayoutMargins:)]) {
            [t setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  确定选择
 */
- (void)confirm{
    [self dismiss];
    
    [self configData];
}

- (void)configData{
    [selectedIndexArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = self->dataArray[idx];
        [self->selectedDataArray replaceObjectAtIndex:idx withObject:arr[[obj integerValue]]];
    }];
    if (self.actionMultipleStringDoneBlock) {
        self.actionMultipleStringDoneBlock(self,selectedIndexArray,selectedDataArray);
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        self->sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
    }];
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        if (self->sels[i] > 0) {
            [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:self->sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        }
        if((self->sels[i] != -1 && !t.superview) || !i) {
            //            [cancelBtn addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
}

- (void)showAsDrawDownView:(UIView *)view {
    
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
            
            [self->tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
                CGRect rect = t.frame;
                rect.origin.y = SCREEN_HEIGHT - (self->_showRows * self->_rowHeight);
                rect.size.height = self->_showRows *self->_rowHeight;
                t.frame = rect;
            }];
        }];
    }
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
            [self->tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
                CGRect rect = t.frame;
                rect.origin.y = SCREEN_HEIGHT;
                rect.size.height = self->_showRows *self->_rowHeight;
                t.frame = rect;
            }];
            self->assistantBar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44);
        } completion:^(BOOL finished) {
            [self->bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (_isMultableSelectInOneMenu) {
        if (!_multableSelectedMenuArray) {
            _multableSelectedMenuArray = [NSMutableArray array];
        }
        if (_multableSelectedMenuArray.count == 0) {
            
        }
        BOOL isHightLight = NO;
        for (int i = 0; i < _multableSelectedMenuArray.count; i ++) {
            NSNumber *num = _multableSelectedMenuArray[i];
            if ([num integerValue] == indexPath.row) {
                isHightLight = YES;
            }
        }
        if (isHightLight) {
            cell.textLabel.textColor = kIAThemeColor;
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }else{
        __block int selectArr;
        [tables enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == tableView) {
                selectArr = [self->selectedIndexArray[idx] intValue];
            }
        }];
        if (indexPath.row == selectArr) {
            cell.textLabel.textColor = kIAThemeColor;
        }else{
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 10088) {
            [view removeFromSuperview];
        }
    }
    if(tableView == [tables objectAtIndex:0]){
        NSArray *arr = dataArray[0];
        if (indexPath.row > arr.count - 1) {
            if (_customBottomView) {
                _customBottomView.tag = 10088;
                cell.textLabel.text = @"";
                [cell.contentView addSubview:_customBottomView];
            }
        } else {
            if (dataArray.count != 0) {
                cell.textLabel.text = dataArray[0][indexPath.row];
            }else{
                cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
            }
        }
    }else if(tableView == [tables objectAtIndex:1]){
        if (dataArray.count != 0) {
            cell.textLabel.text = dataArray[1][indexPath.row];
        }else{
            cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
        }
    }else if(tableView == [tables objectAtIndex:2]){
        if (dataArray.count != 0) {
            cell.textLabel.text = dataArray[2][indexPath.row];
        }else{
            cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSInteger __block count;
    //    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //        if(obj == tableView) {
    //            if (dataArray.count != 0) {
    //                NSArray *arr = dataArray[idx];
    //                count = arr.count;
    //            }else{
    //                count = [_delegate assciationMenuView:self countForClass:idx];
    //            }
    //            *stop = YES;
    //        }
    //    }];
    
    //    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSArray *arr = dataArray[idx];
    //        count = arr.count;
    //    }];
    //    return count;
    
    if (tableView == [tables objectAtIndex:0]) {
        NSArray *arr = dataArray[0];
        return _customBottomView == nil ? arr.count : arr.count + 1;
    }else if (tableView == [tables objectAtIndex:1]) {
        NSArray *arr = dataArray[1];
        return arr.count;
    }else if (tableView == [tables objectAtIndex:2]) {
        NSArray *arr = dataArray[2];
        return arr.count;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1;
    UITableView *t2;
    if (tables.count > 1) {
        t1 = [tables objectAtIndex:1];
        if (tables.count > 2) {
            t2 = [tables objectAtIndex:2];
        }
    }
    BOOL isNexClass = true;
    if(tableView == t0){
        if (dataArray.count != 0) {
            if (dataArray.count > 1) {
                isNexClass = YES;
            }else{
                isNexClass = NO;
            }
            NSArray *aaarray = dataArray[0];
            if (_customBottomView && indexPath.row == aaarray.count - 1 + 1) {
                //选中自定义view
                if (_ClickCustomBottom) {
                    _ClickCustomBottom();
                }
            } else {
                [selectedIndexArray replaceObjectAtIndex:0 withObject:@(indexPath.row)];
                NSArray *selectArr = dataArray[0];
                [selectedDataArray replaceObjectAtIndex:0 withObject:selectArr[indexPath.row]];
                
                //单级菜单的多选
                if (_isMultableSelectInOneMenu == YES) {
                    isNexClass = YES;
                    if (!_multableSelectedMenuArray) {
                        _multableSelectedMenuArray = [NSMutableArray array];
                    }
                    NSMutableArray *tempArray = _multableSelectedMenuArray;
                    BOOL isExisting = NO;
                    for (int i = 0; i < _multableSelectedMenuArray.count; i ++) {
                        NSNumber *num = _multableSelectedMenuArray[i];
                        int row = [num intValue];
                        if (row == indexPath.row) {
                            isExisting = YES;//防止重复添加
                            [tempArray removeObjectAtIndex:i];
                        }
                    }
                    if (isExisting == NO) {
                        if (_multableSelectedMenuArray.count < _multableSelectedMenuMaxCount) {
                            [tempArray addObject:@(indexPath.row)];
                        }else{
                            if (_goMultableSelectedMenuMaxCountWarning) {
                                _goMultableSelectedMenuMaxCountWarning();
                            }
                        }
                    }
                    _multableSelectedMenuArray = tempArray;
                }
                if (_actionMultipleStringSelected_TableView_1_Block) {
                    if (t1) {
                        _actionMultipleStringSelected_TableView_1_Block(self,indexPath.row,[selectedIndexArray[1] integerValue]);
                    }else{
                        _actionMultipleStringSelected_TableView_1_Block(self,indexPath.row,0);
                    }
                }
            }
        }else{
            if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
                isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
            }
        }
        if(isNexClass) {
            if (t1) {
                [t1 reloadData];
            }
            [self adjustTableViews];
        }else{
            [self saveSels];
            [self dismiss];
            [self configData];
        }
    }else if(tableView == t1) {
        BOOL isForbiden = YES;
        if (t1) {
            if (_actionMultipleStringSelected_TableView_2_Block) {
                isForbiden = _actionMultipleStringSelected_TableView_2_Block(self,[selectedIndexArray[0] integerValue],indexPath.row);
            }
        }else{
            if (_actionMultipleStringSelected_TableView_2_Block) {
                isForbiden = _actionMultipleStringSelected_TableView_2_Block(self,0,indexPath.row);
            }
        }
        if (isForbiden == NO) {
            return;
        }
        if (dataArray.count != 0) {
            if (dataArray.count > 2) {
                isNexClass = YES;
            }else{
                isNexClass = NO;
            }
            [selectedIndexArray replaceObjectAtIndex:1 withObject:@(indexPath.row)];
            NSArray *selectArr = dataArray[1];
            [selectedDataArray replaceObjectAtIndex:1 withObject:selectArr[indexPath.row]];
        }else{
            if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
                isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
            }
        }
        if(isNexClass){
            if (t2) {
                [t2 reloadData];
            }
            [self adjustTableViews];
        }else{
            [self saveSels];
            [self dismiss];
            [self configData];//by Vbon
        }
    }else if(tableView == t2) {
        if (dataArray.count != 0) {
            isNexClass = NO;
            [selectedIndexArray replaceObjectAtIndex:2 withObject:@(indexPath.row)];
            NSArray *selectArr = dataArray[2];
            [selectedDataArray replaceObjectAtIndex:2 withObject:selectArr[indexPath.row]];
        }else{
            if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
                isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
            }
        }
        if(isNexClass) {
            [self saveSels];
            [self dismiss];
            [self configData];//by Vbon
        }
    }
    
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;{
    if (_isShowTipsLabel) {
        return 30;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    //顶部提示label
    if (_isShowTipsLabel) {
        CGFloat tipsLabelWidth = 0;
        if (tables.count > 0) {
            tipsLabelWidth = kDeviceWidth / tables.count;
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tipsLabelWidth, 30)];
            tipLabel.font = [UIFont systemFontOfSize:12];
            tipLabel.textColor = HEXCOLOR(0x999999);
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.backgroundColor = [UIColor whiteColor];
            [tables enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UITableView *tb = obj;
                if (tb == tableView) {
                    if (self->_tipsLabelStrArray.count > idx) {
                        tipLabel.text = self->_tipsLabelStrArray[idx];
                    }
                }
            }];
            return tipLabel;
        }
    }
    return [[UIView alloc] init];
}

- (void)configRightTableViewWith:(NSInteger)selectedIndex{
//    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1;
    UITableView *t2;
    if (tables.count > 1) {
        t1 = [tables objectAtIndex:1];
        if (tables.count > 2) {
            t2 = [tables objectAtIndex:2];
        }
    }
    if (t1) {
        [selectedIndexArray replaceObjectAtIndex:1 withObject:@(selectedIndex)];
        [t1 reloadData];
        [t1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    
}

@end
