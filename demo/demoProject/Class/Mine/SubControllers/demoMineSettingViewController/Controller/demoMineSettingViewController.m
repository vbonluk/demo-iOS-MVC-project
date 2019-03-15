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
 *  File name       :      demoMineSettingViewController.m
 *  Author          :      Vbon
 *  Copyright       :      Copyright © 2019 demoProject. All rights reserved.
 *  WebSite         :      www.demo.com
 *
 *  Description     :      demoProject source code
 *
 */



#import "demoMineSettingViewController.h"
#import "demoMineSettingCell.h"
#import "demoSystemPhotoAlbumHelper.h"
#import "demoUploadProfilePhotoApi.h"
#import <UIImageView+WebCache.h>
#import "demoMineApi.h"
#import "SkyAssociationMenuView.h"
#import "demoChangeUserNameViewController.h"
#import "demoChangeUserSexApi.h"

@interface demoMineSettingViewController ()

@property (strong, nonatomic) NSArray *localListArray;

@end

@implementation demoMineSettingViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initPageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)updateViewConstraints{
    
    
    
    
    [super updateViewConstraints];
}

#pragma mark - Overwrite Super Class



#pragma mark - Response Mehtods



#pragma mark - Delegate

/** tableView dataSources && delegate **/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{
    return self.localListArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    NSArray *arr = self.localListArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString *cellID = @"demoMineSettingCell";
    demoMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[demoMineSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *arr = self.localListArray[indexPath.section];
    cell.title = arr[indexPath.row];
    
    /** 横线 **/
    if (indexPath.row == arr.count - 1) {
        cell.line.hidden = YES;
    }else {
        cell.line.hidden = NO;
    }
    
    /** 右边箭头 **/
    cell.rightImgBgView.hidden = NO;
    
    /** 右边的view **/
    for (UIView *view in cell.rightStackView.subviews) {
        if (view.tag != 8888 && view.tag != 8889) {
            [view removeFromSuperview];
        }
    }
    
    cell.rightLabel.hidden = NO;
    cell.rightLabel.textColor = HEXCOLOR(0x333333);
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        /** 头像 **/
        cell.rightImgBgView.hidden = YES;
        demoView *bgView = [[demoView alloc] init];
        [cell.rightStackView addArrangedSubview:bgView];
        UIImageView *touxiang = [[UIImageView alloc] init];
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        [touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString ia_imageUrlPath:infoModel.userAvatar width:100]] placeholderImage:demoDefaultProfilePhoto];
        [bgView addSubview:touxiang];
        [touxiang makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.left).offset(0);
            make.right.equalTo(bgView.right).offset(0);
            make.centerY.equalTo(bgView.centerY);
            make.height.equalTo(35);
            make.width.equalTo(35);
        }];
        
    } else if (indexPath.section == 0 && indexPath.row == 1){
        /** 手机 **/
        cell.rightImgBgView.hidden = YES;
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        if ([StringUtil empty:infoModel.userPhone] == NO) {
            cell.rightLabel.text = infoModel.userPhone;
        }
        
    } else if (indexPath.section == 0 && indexPath.row == 2){
        /** 姓名 **/
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        if ([StringUtil empty:infoModel.userName] == NO) {
            cell.rightLabel.text = infoModel.userName;
        }
        
    } else if (indexPath.section == 0 && indexPath.row == 3){
        /** 性别 **/
        demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
        if ([StringUtil empty:infoModel.userGender] == NO) {
            
            if ([infoModel.userGender isEqualToString:@"male"]) {
                cell.rightLabel.text = @"男";
            } else if ([infoModel.userGender isEqualToString:@"female"]) {
                cell.rightLabel.text = @"女";
            }
        }else{
            cell.rightLabel.textColor = HEXCOLOR(0x999999);
            cell.rightLabel.text = @"未填写";
        }
        
    } else if (indexPath.section == 1 && indexPath.row == 0){
        /** 清除缓存 **/
        
    } else if (indexPath.section == 2 && indexPath.row == 0){
        /** 退出登录 **/
        cell.rightLabel.hidden = NO;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;{
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        /** 头像 **/
        [self clickTouXiang];
    } else if (indexPath.section == 0 && indexPath.row == 1){
        /** 手机 **/
        [self clickTel];
    } else if (indexPath.section == 0 && indexPath.row == 2){
        /** 姓名 **/
        [self clickName];
    } else if (indexPath.section == 0 && indexPath.row == 3){
        /** 性别 **/
        [self clickSex];
    } else if (indexPath.section == 1 && indexPath.row == 0){
        /** 清除缓存 **/
        [self clickRen];
    } else if (indexPath.section == 2 && indexPath.row == 0){
        /** 退出登录 **/
        [self clickLogout];
    }
    
}

#pragma mark - Private Methods

/**
 *  初始化页面
 */
- (void)initPageView{
    [super initPageView];
    
    self.navView.navTitleView.title = @"设置";
    
    self.mainTableView.backgroundColor = HEXCOLOR(0xececec);
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self pullRequest];
}

/**
 *  加载分页数据
 *  此方法分页专用，用于一个分页列表页面含有多个请求时，区分开分页请求和其他非分页请求
 */
- (void)pullRequestPage{
    [super pullRequestPage];
    
    demoMineApi *api = [[demoMineApi alloc] init];
    //api.animatingText = @"正在加载";
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
        [self loadPageDataWithApi:(demoBaseService *)request];
    } failure:nil];
    
    
}

/**
 加载分页数据到页面
 
 此方法用于区别不是分页列表的请求回调loadDataWithApi，页面的主要的分页列表的请求调用此回调。其他的依旧调用loadDataWithApi
 
 @param api demoBaseService
 */
- (void)loadPageDataWithApi:(demoBaseService *)api{
    [super loadPageDataWithApi:api];
    
    
    
    [self.mainTableView reloadData];
}

/**
 自动处理上拉刷新控件，用于自动显示加载状态
 
 @return 加载列表的array数组的key
 */
- (NSString *)dateResultAutoComplete{
    return nil;
}

/**
 点击 头像
 */
- (void)clickTouXiang{
    demoSystemPhotoAlbumHelper *helper = [[demoSystemPhotoAlbumHelper alloc] init];
    helper.isCropImage = YES;
    [helper setCropImageCallBack:^(UIImage * _Nonnull cropImage) {
        [self uploadProfilePhotoWithImage:cropImage];
    }];
    [helper showActionSheet];
}

- (void)uploadProfilePhotoWithImage:(UIImage *)image{
    demoUploadProfilePhotoApi *api_upload = [[demoUploadProfilePhotoApi alloc] initWithImage:image];
    demoMineApi *api_user_info = [[demoMineApi alloc] init];
    
    demoChainService *chainReq = [[demoChainService alloc] init];
    [chainReq addRequest:api_upload callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        [demoHudHelper showHudWithText:@"更换成功" isStay:NO];
    }];
    [chainReq addRequest:api_user_info callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
        [self.mainTableView reloadData];
    }];
    [chainReq start];
    
//
//    //api.animatingText = @"正在加载";
//    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
//        [demoHudHelper showHudWithText:@"更换成功" isStay:NO];
//    } failure:nil];
//
//    if ([StringUtil empty:[demoUserInfoManager getUserInfoModel].token] == NO) {
        demoMineApi *api = [[demoMineApi alloc] init];
        //api.animatingText = @"正在加载";
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            // 你可以直接在这里使用 self , 由YTKNetworking管理引用计数
            [self.mainTableView reloadData];
        } failure:nil];
//    }
}

/**
 点击 手机
 */
- (void)clickTel{
    
}

/**
 点击 姓名
 */
- (void)clickName{
    demoChangeUserNameViewController *changeUserName = [[demoChangeUserNameViewController alloc] init];
    [changeUserName setBackToTargetBlock:^(Class  _Nonnull __unsafe_unretained backTargetViewController) {
        // 马上进入刷新状态
        [self reloadPage];
    }];
    [self.navigationController pushViewController:changeUserName animated:YES];
}

/**
 点击 性别
 */
- (void)clickSex{
    NSArray *sexList = @[@"男",@"女"];
    NSInteger selectedIndex = 0;
    demoUserInfoModel *infoModel = [demoUserInfoManager getUserInfoModel];
    if ([StringUtil empty:infoModel.userGender] == NO) {
        if ([infoModel.userGender isEqualToString:@"male"]) {
            selectedIndex = 0;
        } else if ([infoModel.userGender isEqualToString:@"female"]) {
            selectedIndex = 1;
        }
    }
    
    SkyAssociationMenuView *saView = [[SkyAssociationMenuView alloc] init];
    [saView showViewWithRows:@[sexList] initialSelection:@[@(selectedIndex)] doneBlock:^(SkyAssociationMenuView *saView, NSArray *selectedIndexes, id selectedValues) {
        if (selectedIndexes.count != 0) {
            NSInteger selected = [[selectedIndexes firstObject] integerValue];
            NSString *sex = @"";
            if (selected == 0) {
                sex = @"male";
            }else{
                sex = @"female";
            }
            demoMineApi *api_user_info = [[demoMineApi alloc] init];
            demoChangeUserSexApi *changeSexApi = [[demoChangeUserSexApi alloc] initWithUserGender:sex];
            demoChainService *chainReq = [[demoChainService alloc] init];
            [chainReq addRequest:changeSexApi callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
                [demoHudHelper showHudWithText:@"设置成功" isStay:NO];
            }];
            [chainReq addRequest:api_user_info callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
                [self.mainTableView reloadData];
            }];
            [chainReq start];
        }
    } cancelBlock:nil origin:self.view selectedBlock:nil];
}

/**
 点击 清除缓存
 */
- (void)clickRen{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [demoHudHelper showHudWithText:@"清除缓存成功!" isStay:NO];
        });
    }];
    [[SDImageCache sharedImageCache] clearMemory];
}

/**
 点击 退出登录
 */
- (void)clickLogout{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [demoUserInfoManager cleanUserInfo];
            [self goBack];
        });
    }];
    
    [alert addAction:Action1];
    [alert addAction:Action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - Public Methods



#pragma mark - Getters and Setters

- (NSArray *)localListArray{
    if (!_localListArray){
        _localListArray = [[NSArray alloc] init];
        _localListArray = @[@[@"头像",@"手机",@"姓名",@"性别"],@[@"清除缓存"],@[@"退出登录"]];
        [self.mainTableView registerClass:[demoMineSettingCell class] forCellReuseIdentifier:@"demoMineSettingCell"];
    }
    return _localListArray;
}


@end
