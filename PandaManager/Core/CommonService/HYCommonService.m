//
//  HYCommonService.m
//  TeamDevelop
//
//  Created by lish on 2019/6/5.
//  Copyright © 2019 develop. All rights reserved.
//

#import "HYCommonService.h"
#import "TabBarViewController.h"
#import "HYLoginViewController.h"
@interface HYCommonService()<TZImagePickerControllerDelegate,UINavigationControllerDelegate>




@end
@implementation HYCommonService

+ (instancetype)shareInstance {
    
    static dispatch_once_t once;
    static id __singleton__;
    dispatch_once( &once, ^{
        __singleton__ = [[self alloc] init];
        
    } );
    
    return __singleton__;
    
}
+ (BOOL)isNeedLogin {
    
    if (![HYUserManager shareInstance].currentUser.userId.isNotBlank) {
        
        
        HYLoginViewController *loginvc = [[HYLoginViewController alloc]init];
        
        UIViewController *vc = [NSObject getCurrentVC];
        [vc presentViewController:loginvc animated:YES completion:nil];
        
        return YES;
    }else{
        return NO;
    }
    
    
}
+ (void)needLogin {
    
    if (![HYUserManager shareInstance].currentUser.userId.isNotBlank) {
        
        
        HYLoginViewController *loginvc = [[HYLoginViewController alloc]init];
        
        UIViewController *vc = [NSObject getCurrentVC];
        [vc presentViewController:loginvc animated:YES completion:nil];
        
        return;
    }
    
    
}
+ (void)hy_navigationPushController:(UIViewController *)controller {
    
    [[NSObject getCurrentVC].navigationController pushViewController:controller animated:YES];
    
}
+ (void)swicthTabRootController {
    
    CATransition *trans = [[CATransition alloc] init];
    trans.type = kCATransitionPush;
    trans.subtype = kCATransitionFromRight;
    trans.duration = 0.25;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:trans forKey:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarViewController alloc]init];
    
}

+ (void)switchLoginController{
    
    HYLoginViewController *vc = [[HYLoginViewController alloc]init];
    
    CATransition *trans = [[CATransition alloc] init];
    trans.type = kCATransitionPush;
    trans.subtype = kCATransitionFromRight;
    trans.duration = 0.25;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:trans forKey:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    

}

- (void)presentPhotoPickerWithMaxCount:(NSInteger)maxCount finshedHandle:(ImagePickerControllerfFinshed)finshedHandle cancleHandle:(ImagePickerControllerfFinshedCancle)cancaleHandle {
    
    if (maxCount < 1) maxCount = 1;
    
    TZImagePickerController *photoPickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:maxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    photoPickerController.sortAscendingByModificationDate = NO;
    photoPickerController.allowTakePicture = YES;
    photoPickerController.allowCrop = NO;
    photoPickerController.photoWidth = 640;
    photoPickerController.allowPreview = NO;
    photoPickerController.statusBarStyle = UIStatusBarStyleDefault;
    photoPickerController.naviBgColor = COLOR_JJ_DEFAULT_WHITE;
    photoPickerController.naviTitleColor = COLOR_JJ_TEXT_MAIN;
    photoPickerController.naviTitleFont = kSystemFontSize(18);
    photoPickerController.barItemTextColor = COLOR_JJ_TEXT_MAIN;
    photoPickerController.barItemTextFont = kSystemFontSize(14);
    photoPickerController.navigationBar.tintColor = COLOR_JJ_TEXT_MAIN;
    photoPickerController.alwaysEnableDoneBtn = NO;
    photoPickerController.allowPickingGif = NO;
    photoPickerController.allowPickingOriginalPhoto = NO;
    photoPickerController.allowPickingVideo = NO;
    photoPickerController.isSelectOriginalPhoto = NO;
    
    
    photoPickerController.cropRect = CGRectMake((kScreenWidth - kScreenWidth) / 2.0, (kScreenHeight - kScreenWidth) / 2.0, kScreenWidth, kScreenWidth);
    photoPickerController.delegate = self;
    
    [[NSObject getCurrentVC] presentViewController:photoPickerController animated:YES completion:nil];
    
    self.finshedBlock = finshedHandle;
    
    self.cacleBlock = cancaleHandle;
    
}


#pragma mark - imagePickerController Delegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    
    
    if (self.finshedBlock) {
        self.finshedBlock(photos);
    }
    
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
    if (self.cacleBlock) {
        self.cacleBlock();
    }
}



@end
