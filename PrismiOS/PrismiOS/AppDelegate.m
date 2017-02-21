//
//  AppDelegate.m
//  PrismiOS
//
//  Created by HanYoungsoo on 2017. 2. 18..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "AppDelegate.h"
#import <KakaoOpenSDK/KakaoOpenSDK.h>

@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *loginViewController;
@property (nonatomic, strong) UINavigationController *mainViewController;
@end

@implementation AppDelegate

- (void)setupEntryController {

    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"navigator"];
    self.mainViewController = [storyBoard instantiateViewControllerWithIdentifier:@"navigator"];
    
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"login"];
    [self.loginViewController pushViewController:viewController animated:YES];
    
    UIViewController *viewController2 = [storyBoard instantiateViewControllerWithIdentifier:@"main"];
    [self.mainViewController pushViewController:viewController2 animated:YES];
}

- (void)reloadRootViewController {
    BOOL isOpened = [KOSession sharedSession].isOpen;
    if (!isOpened) {
        [self.mainViewController popToRootViewControllerAnimated:YES];
    }
    self.window.rootViewController = isOpened ? self.mainViewController : self.loginViewController;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupEntryController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kakaoSessionDidChangeWithNotification:)
                                                 name:KOSessionDidChangeNotification
                                               object:nil];
    
    [self reloadRootViewController];
    return YES;
}

- (void)kakaoSessionDidChangeWithNotification:(NSNotification *)notification
{
    if ( ![[KOSession sharedSession] isOpen] ) {
        NSLog(@"세션변경!!!@)#()#@(*)*(@)(#*)@(#*)@(*#)");
        [self reloadRootViewController];
    }
}

//
//-(void)sessionCheck{
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    
//    __block UIStoryboard *storyboard;
//    __block UIViewController *viewController;
//    
//    [KOSessionTask accessTokenInfoTaskWithCompletionHandler:^(KOAccessTokenInfo *accessTokenInfo, NSError *error) {
//        if (error) {
//            switch (error.code) {
//                case KOErrorDeactivatedSession:
//                case KOErrorTokenNotFound:
//                    // 세션이 만료된(access_token, refresh_token이 모두 만료된 경우) 상태
//                    NSLog(@"세션만료! / 세션없음");
//
//                    storyboard = [UIStoryboard storyboardWithName:@"LogIn" bundle:nil];
//                    viewController = [storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
//                    
//                    self.window.rootViewController = viewController;
//                    [self.window makeKeyAndVisible];
//                    break;
//                default:
//                    // 예기치 못한 에러. 서버 에러
//                    break;
//            }
//        } else {
//            // 성공 (토큰이 유효함)
//            
//            [KOSessionTask meTaskWithCompletionHandler:^(KOUser* result, NSError *error) {
//                if (result) {
//                    // success
//
//                    storyboard = [UIStoryboard storyboardWithName:@"LogIn" bundle:nil];
//                    viewController = [storyboard instantiateViewControllerWithIdentifier:@"AppMain"];
//                
//                    self.window.rootViewController = viewController;
//                    [self.window makeKeyAndVisible];
//                    
//                } else {
//                    NSLog(@"사용자 정보를 얻어오지 못했습니다!");
//                }
//            }];
//        }
//        
//    }];
//}



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
    
    [KOSession handleDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
    
    if ([KOSession isKakaoAccountLoginCallback:url]) {
        return [KOSession handleOpenURL:url];
    }
    
    return YES;
}

@end
