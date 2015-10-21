//
//  ViewController.m
//  PushDemo
//
//  Created by Africa on 15/10/21.
//  Copyright © 2015年 Africa. All rights reserved.
//

#import "ViewController.h"
#import "FHHomeDetailController.h"

//本地推送通知的key
static const NSString * kNotificationKey = @"localNotification";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 发送本地通知
- (IBAction)schedule:(UIButton *)sender
{
    //1.创建本地推送通知对象
    UILocalNotification   * ln = [[UILocalNotification alloc]init];
    
    //2.设置通知属性
    //音效名称  @"buyao.wav"
    ln.soundName = UILocalNotificationDefaultSoundName;
    //    ln.soundName = @"buyao.wav";
    
    //通知具体内容
    ln.alertBody = @"重大新闻：XXX被调查了";
    
    //锁屏界面显示的小标题（“滑动来”＋alertAction）
    ln.alertAction = @"查看新闻";
    
    //点击通知启动程序显示的图片
    ln.alertLaunchImage = @"2.png";
    
    //设置组动作
    ln.category = @"alert";
    
    //通知第一次发出的时间（5秒后发出）
    ln.fireDate = [NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]];
    
    //设置时区（跟随手机时区）
    ln.timeZone = [NSTimeZone defaultTimeZone];
    
    //设置app图标数字
    ln.applicationIconBadgeNumber = 5;
    
    //设置重复发出通知的时间间隔  系统默认接收64条通知   后面的会被忽略掉
    //    ln.repeatInterval = 0;
    
    //添加附加信息
    ln.userInfo = @{kNotificationKey:@"菲皇新闻"};
    
    //调度通知（启动任务，在规定的时间发出通知）
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
    
    //立即发送推送通知（基本上没有意义）
    //    [[UIApplication sharedApplication] presentLocalNotificationNow:ln];
    
}

- (IBAction)unschedule:(UIButton *)sender
{
    
#warning 这里取消本地推送没用   必须在发出之前取消
    //遍历所有的本地推送通知
    for (UILocalNotification * ln in [UIApplication sharedApplication].scheduledLocalNotifications)
    {
        if ([ln.userInfo[kNotificationKey] isEqualToString:@"菲皇新闻"])
        {
            //取消特定本地推送
            [[UIApplication sharedApplication] cancelLocalNotification:ln];
            
        }
    };
    
    //取消所有的本地通知
    //    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

//准备通过segue跳转视图控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UILocalNotification *)localNotification
{
    FHHomeDetailController * homeDetailController = segue.destinationViewController;
    homeDetailController.userinfo = localNotification.userInfo;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
