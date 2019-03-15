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
 *  File name       :      demoSystemPhotoAlbumHelper.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */


    

#import "demoSystemPhotoAlbumHelper.h"
#import "AppPermissionTools.h"
#import "UIApplication+demoGetCurrentViewController.h"
#import <TOCropViewController.h>

@interface demoSystemPhotoAlbumHelper ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,TOCropViewControllerDelegate>

@end

@implementation demoSystemPhotoAlbumHelper

- (void)showActionSheet{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[AppPermissionTools shareInstance] CheckPermissionWithType:AppPermissionType_Camera]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
            [currentVC presentViewController:controller
                               animated:YES
                             completion:nil];
        }
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([[AppPermissionTools shareInstance] CheckPermissionWithType:AppPermissionType_PhotoAlbum]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
            [currentVC presentViewController:controller
                               animated:YES
                             completion:nil];
        }
    }];
    UIAlertAction *Action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:Action1];
    [alert addAction:Action2];
    [alert addAction:Action3];
    
    UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
    [currentVC presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Delegate
//UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIImageOrientation imageOrientation=portraitImg.imageOrientation;
        if(imageOrientation!=UIImageOrientationUp){
            // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
            UIGraphicsBeginImageContext(portraitImg.size);
            [portraitImg drawInRect:CGRectMake(0, 0, portraitImg.size.width, portraitImg.size.height)];
            portraitImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            // 调整图片角度完毕
        }
        if (self.isCropImage) {
            UIViewController *currentVC = [[UIApplication sharedApplication] activityViewController];
            TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:portraitImg];
            cropViewController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetSquare;
            cropViewController.aspectRatioPickerButtonHidden = YES;
            cropViewController.resetButtonHidden = YES;
            cropViewController.delegate = self;
            [currentVC presentViewController:cropViewController animated:YES completion:nil];
        }else{
            if (self.originImageCallBack) {
                self.originImageCallBack(portraitImg);
            }
        }
    }];
}
// TOCropViewController
- (void)cropViewController:(nonnull TOCropViewController *)cropViewController
            didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect
                     angle:(NSInteger)angle;{
    [cropViewController dismissViewControllerAnimated:YES completion:^{    
        if (self.cropImageCallBack) {
            self.cropImageCallBack(image);
        }
    }];
}

@end
