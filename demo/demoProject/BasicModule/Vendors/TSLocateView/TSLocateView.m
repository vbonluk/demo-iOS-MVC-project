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
 *  File name       :      TSLocateView.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


//  UICityPicker.m
//  DDMates
//
//  Created by ShawnMa on 12/16/11.
//  Copyright (c) 2011 TelenavSoftware, Inc. All rights reserved.
//

#import "TSLocateView.h"

#define kDuration 0.3

@implementation TSLocateView

@synthesize titleLabel;
@synthesize locatePicker;
@synthesize locate;

- (id)initWithTitle:(NSString *)title Provinces:(NSArray *)provinces delegate:(id <UIActionSheetDelegate>)delegate{
    self = [[[NSBundle mainBundle] loadNibNamed:@"TSLocateView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        @try {
            if (_numberOfComponents == 0) {
                
            }
            self.delegate = delegate;
            self.titleLabel.text = title;
            self.locatePicker.dataSource = self;
            self.locatePicker.delegate = self;
            
            self.province = @"";
            self.city = @"";
            self.area = @"";
            
            self.ia_width = kDeviceWidth;
            self.locatePicker.backgroundColor=[UIColor whiteColor];
            //加载数据
            _provinces = provinces;
            
            _selectedIndexArray = [NSMutableArray arrayWithArray:@[@0,@0,@0]];
            
            cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
            
            //初始化默认数据
            self.locate = [[TSLocation alloc] init];
            
            self.locate.state = [[_provinces objectAtIndex:0] objectForKey:@"state"];
            if (cities.count > 0) {
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            }
            
            if (areas.count > 0) {
                self.locate.district = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
            _mainView.alpha = 0;
            _bgView.alpha = 0;
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.mainView.alpha = 1;
                weakSelf.bgView.alpha = 0.5;
            } completion:nil];
        }
        @catch (NSException *exception) {
            DDLogError(@"exception:%@",exception);
        }
        @finally {
            
        }
    }
    return self;
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _numberOfComponents;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            return [areas count]<=0? 1:[areas count];
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.isCustomComponentsWidth == NO) {
        return [UIScreen mainScreen].bounds.size.width / self.numberOfComponents;
    }else{
        if (component == 0) {
            return self.firstComponentsWidth;
        } else if(component == 1){
            return self.secondComponentsWidth;
        }else if(component == 2){
            return self.thirdComponentsWidth;
        }else{
            return 0;
        }
    }
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([areas count] > 0) {
                return [areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    @try {
        switch (component) {
            case 0:
                //第1级设置
                [_selectedIndexArray replaceObjectAtIndex:0 withObject:@(row)];
                if (self.isNotRelevancy == NO) {
                    //第2级设置
                    [_selectedIndexArray replaceObjectAtIndex:1 withObject:@(0)];
                    //第3级设置
                    [_selectedIndexArray replaceObjectAtIndex:2 withObject:@(0)];
                    
                    cities = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
                    [self.locatePicker selectRow:0 inComponent:1 animated:NO];
                    [self.locatePicker reloadComponent:1];
                    if (cities.count > 0) {
                        areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                        if (_numberOfComponents > 2) {
                            [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                            [self.locatePicker reloadComponent:2];
                        }
                        
                        self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                    }else{
                        areas = @[];
                    }
                    
                    self.locate.state = [[_provinces objectAtIndex:row] objectForKey:@"state"];
                    
                    if ([areas count] > 0) {
                        self.locate.district = [areas objectAtIndex:0];
                    } else{
                        self.locate.district = @"";
                        self.locate.street = @"";
                    }
                    if (_numberOfComponents > 2) {
                        [self.locatePicker reloadComponent:2];
                    }
                }
                
                break;
            case 1:
                //第2级设置
                [_selectedIndexArray replaceObjectAtIndex:1 withObject:@(row)];
                if (self.isNotRelevancy == NO) {
                    //第3级设置
                    [_selectedIndexArray replaceObjectAtIndex:2 withObject:@(0)];
                    if (cities.count > 0) {
                        areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                        self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                    }
                    
                    if ([areas count] > 0) {
                        self.locate.district = [areas objectAtIndex:0];
                    } else{
                        self.locate.district = @"";
                    }
                    if (_numberOfComponents > 2) {
                        [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                        [self.locatePicker reloadComponent:2];
                    }
                }
                
                break;
            case 2:
                //第3级设置
                [_selectedIndexArray replaceObjectAtIndex:2 withObject:@(row)];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        DDLogError(@"exception:%@",exception);
    }
    @finally {
        
    }
}





- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
//    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.mainView.layer addAnimation:animation forKey:@"DDLocateView"];
    
//    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
//    [view addSubview:self];
    
    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    
    //选中地址
    //if(_province!=nil){
        [self.locatePicker reloadComponent:0];
        for (int i=0; i<_provinces.count; i++) {
            if([ [[_provinces objectAtIndex:i] objectForKey:@"state"] isEqualToString:_province]){
                [self.locatePicker selectRow:i inComponent:0 animated:NO];
                cities = [[_provinces objectAtIndex:i] objectForKey:@"cities"];
                [self.locatePicker reloadComponent:1];
                if (_numberOfComponents > 2) {
                    [self.locatePicker reloadComponent:2];
                }
                self.locate.state = [[_provinces objectAtIndex:i] objectForKey:@"state"];
                
                for (int j=0; j<cities.count; j++) {
                    if( [[[cities objectAtIndex:j] objectForKey:@"city"]  isEqualToString:_city]){
                        
                        [self.locatePicker selectRow:j inComponent:1 animated:YES];
                        areas = [[cities objectAtIndex:j] objectForKey:@"areas"];
                        if (_numberOfComponents > 2) {
                            [self.locatePicker reloadComponent:2];
                        }
                        self.locate.city = [[cities objectAtIndex:j] objectForKey:@"city"];
                        
                        for (int k=0; k<areas.count; k++) {
                            NSString *areaName=[areas objectAtIndex:k];
                            if([areaName isEqualToString:_area]){
                                if (_numberOfComponents > 2) {
                                    [self.locatePicker selectRow:k inComponent:2 animated:YES];
                                }
                                self.locate.district=areaName;
                                break;
                            }
                        }
                        break;
                    }
                }
                break;
            }
            
        }
    //}

    
}




#pragma mark - Button lifecycle

- (IBAction)goCancel:(id)sender{
    [self closeThePikcer];
}


-(void)closeThePikcer{
    CATransition *animation = [CATransition  animation];
//    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.mainView.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }

}


- (IBAction)goConfirm:(id)sender {
    CATransition *animation = [CATransition  animation];
//    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.mainView.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}

@end
