#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "head/TXCustomModel.h"
#import "head/TXCommonHandler.h"

// 阿里的一键登录服务
// SDK文档：https://help.aliyun.com/zh/pnvs/developer-reference/the-ios-client-access?spm=5176.11662647.console-base_help.dexternal.261e54b81FTQdK
// Hook 工具类
%hook TXCommonUtils

// 判断设备蜂窝网络是否开启
+ (BOOL)checkDeviceCellularDataEnable {
    return NO;
}

// 判断当前上网卡是否是中国联通
+ (BOOL)isChinaUnicom {
    return NO; // 强制返回 NO
}

// 判断当前上网卡是否是中国移动
+ (BOOL)isChinaMobile {
    return NO; // 强制返回 NO
}

// 判断当前上网卡是否是中国电信
+ (BOOL)isChinaTelecom {
    return NO; // 强制返回 NO
}

// 获取当前上网卡运营商名称
+ (NSString *)getCurrentCarrierName {
    return @"";
}

// 获取当前上网网络类型
+ (NSString *)getNetworktype {
    return @"Unknown"; // 返回未知网络类型
}

// 判断设备是否有SIM卡
+ (BOOL)simSupportedIsOK {
    return NO; // 强制返回 NO，表示无 SIM 卡
}

// 判断无线网络是否开启
+ (BOOL)isWWANOpen {
    return NO;
}

// 判断无Wi-Fi下无线网络是否开启
+ (BOOL)reachableViaWWAN {
    return NO;
}

%end

// Hook主要判断手机号登录的类
%hook TXCommonHandler

// Hook 设置 SDK 密钥方法
- (void)setAuthSDKInfo:(NSString * _Nonnull)info complete:(void (^)(NSDictionary * _Nonnull resultDic))complete {
    if (complete) {
        complete(@{ @"resultCode": @600002, @"msg": @"设置密钥失败" });
    }
}

// Hook 获取一键登录 Token 方法
- (void)getLoginTokenWithTimeout:(NSTimeInterval)timeout controller:(UIViewController *_Nonnull)controller model:(TXCustomModel *_Nullable)model complete:(void (^)(NSDictionary * _Nonnull resultDic))complete {
    if (complete) {
        complete(@{ @"resultCode": @600011, @"msg": @"获取 Token 失败" });
    }
}

// Hook 注销授权页方法
- (void)cancelLoginVCAnimated:(BOOL)flag complete:(void (^)(void))complete {
    if (complete) {
        complete(); // 执行回调但阻止后续行为
    }
}

// Hook 一键登录预取号方法
- (void)accelerateLoginPageWithTimeout:(NSTimeInterval)timeout complete:(void (^)(NSDictionary * _Nonnull resultDic))complete {
    if (complete) {
        complete(@{ @"resultCode": @600002, @"msg": @"预取号失败" });
    }
}

%end
