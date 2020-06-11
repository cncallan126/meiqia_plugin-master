import 'dart:async';

import 'package:flutter/services.dart';

class Meiqiaplugin {
  static  MethodChannel _channel =
  const MethodChannel('meiqiaplugin')..setMethodCallHandler(_handler);

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///初始化美洽
  static Future<String> initMeiQia(String Appkey)async{
    String result = await _channel.invokeMethod("initMeiQia",{
      "Appkey":Appkey
    });
  }

  ///打开聊天界面
  static Future openChatPage()async{
    await _channel.invokeMethod("openChatPage");
  }

  ///发送预消息文本
  static Future sendTextMessage({String link,String imgPath})async{
    await _channel.invokeMethod("sendTextMessage",{
      "link":link,
      "imgPath":imgPath
    });
  }

  ///设置用户信息并启动页面---预发送消息
  static Future setInfoAndSendTextMessage({String link,String imgPath,String name,String avatar,String userId})async{
    await _channel.invokeMethod("setInfoAndSendTextMessage",{
      "link":link,
      "imgPath":imgPath,
      "name":name,
      "avatar":avatar,
      "userId":userId
    });
  }

  ///设置用户id并启动页面---没有预发送消息
  static Future setUserIdAndOpenMeiQia({String name,String avatar,String userId})async{
    await _channel.invokeMethod("setUserIdAndOpenMeiQia",{
      "name":name,
      "avatar":avatar,
      "userId":userId
    });
  }



  static Future<dynamic> _handler(MethodCall methodCall) {
    if (methodCall.method == "" ) {
//      _initController
//          .add(methodCall.arguments);
    }else if(methodCall.method==''){
//      _openChatPageController
//          .add(methodCall.arguments);
    }
    return Future.value(true);
  }
}
