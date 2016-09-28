//
//  AppDelegate.m
//  分享测试
//
//  Created by 李鹏辉 on 16/9/28.
//  Copyright © 2016年 company. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface AppDelegate ()<QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1104987830"]]) {//QQ
        return [TencentOAuth HandleOpenURL:url];
    }else{
        return YES;
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1104987830"]]) {//QQ
        return [TencentOAuth HandleOpenURL:url];
    }else{
        return YES;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//处理分享成功或者失败的信息
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    // 因为在我们的应用中可能不止实现一种分享途径，可能还有微信啊 微博啊这些，所以在这里最好判断一下。
    // QQAPPID:是你在QQ开放平台注册应用时候的AppID
    if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",@"1104987830"]]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }else {
        return YES;
    }
}

#pragma mark -- QQApiInterfaceDelegate
// 处理来自QQ的请求，调用sendResp
- (void)onReq:(QQBaseReq *)req {
    
}
- (void)onResp:(QQBaseReq *)resp {
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
            if ([sendResp.result isEqualToString:@"0"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"QQ分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"QQ分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
        }
        default:
        {
            break;
        }
    }
}



@end
