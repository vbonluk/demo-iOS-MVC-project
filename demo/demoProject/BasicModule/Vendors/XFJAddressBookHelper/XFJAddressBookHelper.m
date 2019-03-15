//
//  XFJAddressBookHelper.m
//  xfj
//
//  Created by Vbon on 2017/8/10.
//  Copyright © 2017年 bjy. All rights reserved.
//

#import "XFJAddressBookHelper.h"
#import "AppPermissionTools.h"

@implementation XFJAddressBookHelper

+ (instancetype)sharedInstance;{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)goAddressBook:(UIViewController *)targerViewController callBack:(void(^)(NSString *phoneNum,NSString *name))callBack;{
    if ([[AppPermissionTools shareInstance] CheckPermissionWithType:AppPermissionType_AddressBook]) {
        
        _targerViewController = targerViewController;
        _callBack = callBack;
        
        if([[UIDevice currentDevice].systemVersion floatValue] >= 9.0){
            CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
            contactVc.delegate = self;
            [targerViewController presentViewController:contactVc animated:YES completion:nil];
        }else{
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
 *  File name       :      XFJAddressBookHelper.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


        }
    }
}
/*  ios 9 以下
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController*) peoplePicker;{
    [_targerViewController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    return YES;
    
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    //取联系人姓名
    NSString *cantactName = (__bridge NSString *)ABRecordCopyCompositeName(person);
    NSLog(@"name ----- : %@", cantactName);
    //判断点击区域
    if(property == kABPersonPhoneProperty){
        //取出当期点击区域中所有的内容
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        //根据点击的那一行对性的identifier取出所在的索引
        long index = ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);
        
        //根据索引取出相应的值
        NSString *contactPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, index);
        NSLog(@"phone ----- : %@", contactPhone);
        
        @try {
            if (_callBack) {
                _callBack(contactPhone,cantactName);
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@",exception);
        }
        @finally {
            
        }
        
    }
    return NO;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    
}


-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    [self peoplePickerNavigationController:peoplePicker shouldContinueAfterSelectingPerson:person property:property identifier:identifier];
}
*/
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    
    DDLogWarn(@"name:%@%@",contact.familyName,contact.givenName);
    CNLabeledValue * phoneLabValue = [contact.phoneNumbers lastObject];
    
    NSString *contactPhone = [phoneLabValue.value stringValue];
    NSString *cantactName = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    
    //去除数字以外的所有字符
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    contactPhone  = [[contactPhone componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    @try {
        if (_callBack) {
            _callBack(contactPhone,cantactName);
        }
    }
    @catch (NSException *exception) {
        DDLogError(@"exception:%@",exception);
    }
    @finally {
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
