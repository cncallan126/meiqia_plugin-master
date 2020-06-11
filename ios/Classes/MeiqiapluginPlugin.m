#import "MeiqiapluginPlugin.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "MQChatViewManager.h"

@implementation MeiqiapluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"meiqiaplugin"
            binaryMessenger:[registrar messenger]];
  MeiqiapluginPlugin* instance = [[MeiqiapluginPlugin alloc] init];
    aRegistrar = registrar;
  [registrar addMethodCallDelegate:instance channel:channel];
}

static NSObject<FlutterPluginRegistrar> *aRegistrar;

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"initMeiQia" isEqualToString:call.method]) {
            [self initMeiqiaSdk:call];
  }else if ([@"openChatPage" isEqualToString:call.method]) {
            [self openChatPage];
  }else if([@"sendTextMessage" isEqualToString:call.method]){
            [self sendTextMessage:call];
  }else if([@"setInfoAndSendTextMessage" isEqualToString:call.method]){
            [self setInfoAndSendTextMessage:call];
  }else if([@"setUserIdAndOpenMeiQia" isEqualToString:call.method]){
            [self setUserIdAndOpenMeiQia:call];
  }else {
            result(FlutterMethodNotImplemented);
  }
}




- (void)initMeiqiaSdk:(FlutterMethodCall*)call {
    NSString *appKey = call.arguments[@"Appkey"];
    
    [MQManager initWithAppkey:appKey completion:^(NSString *clientId, NSError *error) {
        if (!error) {
            NSLog(@"美洽 SDK：初始化成功");
        } else {
            NSLog(@"error:%@",error);
        }
    }];
    
    
}

- (void)openChatPage{
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    [chatViewManager setoutgoingDefaultAvatarImage:[UIImage imageNamed:@"meiqia-icon"]];
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [chatViewManager pushMQChatViewControllerInViewController:vc];
}

- (void)sendTextMessage:(FlutterMethodCall*)call{
    NSString *link = call.arguments[@"link"];
    NSString *imgPath = call.arguments[@"imgPath"];
    #pragma mark 预发送消息
            MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
           [chatViewManager setPreSendMessages: @[link]];
            UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
               vc.modalPresentationStyle = UIModalPresentationFullScreen;
               [chatViewManager pushMQChatViewControllerInViewController:vc];
}

- (void)setInfoAndSendTextMessage:(FlutterMethodCall*)call{
        NSString *name = call.arguments[@"name"];
        NSString *avatar = call.arguments[@"avatar"];
        NSString *userId = call.arguments[@"userId"];
        NSString *customId = call.arguments[@"userId"];
        NSString *link = call.arguments[@"link"];
        NSString *imgPath = call.arguments[@"imgPath"];

        //创建自定义信息
        NSDictionary* clientCustomizedAttrs = @{
        @"name" : name
        @"avatar" : avatar
        @"userId" : userId
        };

    #pragma mark 预发送消息
            MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
            //设置用户信息
            [chatViewManager setLoginCustomizedId:customId];
            [chatViewManager setClientInfo:clientCustomizedAttrs];
            //预发送消息
           [chatViewManager setPreSendMessages: @[link]];
            UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
               vc.modalPresentationStyle = UIModalPresentationFullScreen;
               [chatViewManager pushMQChatViewControllerInViewController:vc];
}


- (void)setUserIdAndOpenMeiQia:(FlutterMethodCall*)call{
        NSString *name = call.arguments[@"name"];
        NSString *avatar = call.arguments[@"avatar"];
        NSString *userId = call.arguments[@"userId"];
        NSString *customId = call.arguments[@"userId"];
        //创建自定义信息
        NSDictionary* clientCustomizedAttrs = @{
        @"name" : name
        @"avatar" : avatar
        @"userId" : userId
        };

        MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
        //设置用户信息
        [chatViewManager setLoginCustomizedId:customId];
        [chatViewManager setClientInfo:clientCustomizedAttrs];
        UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [chatViewManager pushMQChatViewControllerInViewController:vc];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    #pragma mark  集成第二步: 进入前台 打开meiqia服务
    [MQManager openMeiqiaService];
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    #pragma mark  集成第三步: 进入后台 关闭美洽服务
    [MQManager closeMeiqiaService];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    #pragma mark  集成第四步: 上传设备deviceToken
    [MQManager registerDeviceToken:deviceToken];
}

@end
