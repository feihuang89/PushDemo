# PushDemo
### 1.本地推送自定义Action实现快速操作界面，简单实现例如微信推送消息，在接收到推送消息的时候，下拉有按钮，点击按钮后弹出文本输入框

### 2.在锁屏界面接收到推送消息的时候左滑显示快速操作消息按钮

代码实现：

    //1.创建消息上面要显示的按钮
    UIMutableUserNotificationAction * action = [[UIMutableUserNotificationAction alloc]init];
    action.identifier = @"action";
    action.title = @"Accept";
    action.behavior = UIUserNotificationActionBehaviorTextInput;
    //点击启动程序
    action.activationMode = UIUserNotificationActivationModeForeground;
    
    //2.创建动作类别集合
    UIMutableUserNotificationCategory * categorys = [[UIMutableUserNotificationCategory alloc]init];
    categorys.identifier = @"alert"; //这组动作的唯一标识
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    //3.ios8之后必须先进行注册
    //询问用户是否允许发送通知
    UIUserNotificationSettings * uns = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObjects:categorys, nil]];
    //注册通知
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    
    
    
    
