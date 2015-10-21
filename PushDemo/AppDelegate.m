//
//  AppDelegate.m
//  PushDemo
//
//  Created by Africa on 15/10/21.
//  Copyright © 2015年 Africa. All rights reserved.
//

#import "AppDelegate.h"
#import "FHHomeDetailController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //注册本地推送通知
    //    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
    //
    //        //categories动作（按钮）的类别集合
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    //
    //    }
    
    //判断是否注册成功
    //    NSLog(@"currentUserNotificationSettings = %@",[[UIApplication sharedApplication] currentUserNotificationSettings]);
    
    //1.创建消息上面要显示的按钮
    UIMutableUserNotificationAction * action = [[UIMutableUserNotificationAction alloc]init];
    action.identifier = @"action";
    action.title = @"Accept";
    action.behavior = UIUserNotificationActionBehaviorTextInput;
    //点击启动程序
    action.activationMode = UIUserNotificationActivationModeForeground;
    
    
    UIMutableUserNotificationAction * action2 = [[UIMutableUserNotificationAction alloc]init];
    action2.identifier = @"action2";
    action2.title = @"refuse";
    //点击启动程序
    action2.activationMode = UIUserNotificationActivationModeBackground;
    action2.authenticationRequired = YES; //需要解锁才能处理
    action2.destructive = YES;
    
    //创建动作类别集合
    UIMutableUserNotificationCategory * categorys = [[UIMutableUserNotificationCategory alloc]init];
    categorys.identifier = @"alert"; //这组动作的唯一标识
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    
    //ios8之后必须先进行注册
    //询问用户是否允许发送通知
    UIUserNotificationSettings * uns = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObjects:categorys, nil]];
    //注册通知
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake((kScreenWidth - 200)/2, 100, 200, 100);
    label.font = [UIFont systemFontOfSize:11];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    [[[self.window.rootViewController.childViewControllers firstObject] view] addSubview:label];
    
    UILocalNotification *note = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (note) {
        label.text = @"点击本地通知启动的程序";
        
        FHHomeDetailController * homeDetailVC = [self.window.rootViewController.childViewControllers firstObject];
        [homeDetailVC performSegueWithIdentifier:@"homeDetail" sender:note];
        
    } else {
        label.text = @"直接点击app图标启动的程序";
    }
    
    return YES;
}
//成功注册registerUserNotificationSettings：后回调
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"注册成功：%@",notificationSettings);
}

/**
 点击本地通知会触发：
 1.如果app在打开状态，直接触发
 2.如果app在后台，点击通知进入应用程序会触发
 3.如果app处于kill状态，点击通知会走didFinishLaunchingWithOptions
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"点击了本地通知");
    
}
/**
 *  在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
 */
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    NSLog(@"%@",identifier);
    
    completionHandler();
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
