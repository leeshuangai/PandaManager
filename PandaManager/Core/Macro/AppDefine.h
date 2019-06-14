//
//  AppDefine.h
//  YQD
//
//  Created by lish on 2018/9/17.
//  Copyright © 2018年 lish. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10.0)

#endif

#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLog(...)
#endif

#define kObatainBundleResourceImage(BundleName,ImageName) [NSString stringWithFormat:@"%@.bundle/%@",BundleName,ImageName]


#define HEX(hex)                HEXA(hex,1)
#define HEXA(hex,a)             [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:a]

//废弃注释
#define kDEPRECATED(msg)                             __attribute__((deprecated(msg)))


#define METHOD_NOT_IMPLEMENTED()       NSAssert(NO, @"You must override %@ in a subclass", NSStringFromSelector(_cmd))


#define  kNAVBARHEIGHT (kIPhoneXSeries() ? 88 : 64)

#define  NAVIGATIONBARHEIGHT    44

#define  kSTATUSBARHEIGHT (kIPhoneXSeries()  ? 44 : 20)

#define  kTABBARHEIGHT      (kIPhoneXSeries()  ? (49.f+34.f) : 49.f)

#define  kSAFEAREABOTTOM (kIPhoneXSeries()  ? 34.f : 0.f)

#define  kSAFEAREATOP (kIPhoneXSeries()  ? 22 : 0)

#define kScale(length) kScreenScale * (length) / 2

#define kAdaptedWidth(width)  (AdaptedWidth(width))

#define kAdaptedHeight(height) (AdaptedWidth(height))

#define kSystemFontSize(size) [UIFont systemFontOfSize:(size)]

#define kBoldSystemFontSize(size) [UIFont boldSystemFontOfSize:(size)]

#define kAdaptedFontSize(R) TPSystemFontSize(TPAdaptedWidth(R))

#define kAdaptedBoldFontSize(R) TPBoldSystemFontSize(TPAdaptedWidth(R))


static inline CGFloat AdaptedWidth(CGFloat width){
    if (kScreenWidth <= 375) {
        return ceilf((width) * (kScreenWidth / 375.0));
    } else {
        return ceilf((width) * 1.1);
    }
}

static inline CGFloat AdaptedHeight(CGFloat height){
    
    if (kScreenWidth <= 375) {
        return ceilf((height) * (kScreenHeight  / 667.0));
    } else {
        return ceilf((height) * 1.1);
    }
    
}

static inline BOOL kIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}
#endif /* AppDefine_h */
