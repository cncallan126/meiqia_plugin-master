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

//  ///进入初始化
//  static StreamController _initController = new StreamController.broadcast();
//  static  Stream get responseFromInit => _initController.stream;
//
//  ///打开聊天界面
//  static StreamController _openChatPageController = new StreamController.broadcast();
//  static  Stream get responseFromOpenChatPage => _openChatPageController.stream;


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
