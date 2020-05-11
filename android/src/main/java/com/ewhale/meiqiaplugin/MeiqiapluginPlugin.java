package com.ewhale.meiqiaplugin;

import android.content.Context;

import androidx.annotation.MainThread;
import androidx.annotation.NonNull;

import com.meiqia.core.MQManager;
import com.meiqia.core.callback.OnInitCallback;
import com.meiqia.meiqiasdk.util.MQConfig;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** MeiqiapluginPlugin */
public class MeiqiapluginPlugin implements FlutterPlugin, MethodCallHandler {

  private MeiqiapluginPlugin(Context context, MethodChannel channel){
    this.aContext = context;
    this.channel = channel;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "meiqiaplugin");
    MeiQiaHandler.setRegistrar(flutterPluginBinding.getApplicationContext());
    MeiQiaRequestHandler.setRegistrar(flutterPluginBinding.getApplicationContext());
    MeiQiaResponseHandler.setMethodChannel(channel);
    channel.setMethodCallHandler(new MeiqiapluginPlugin(flutterPluginBinding.getApplicationContext(),channel));
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "meiqiaplugin");
    MeiQiaHandler.setRegistrar(registrar.context());
    MeiQiaRequestHandler.setRegistrar(registrar.context());
    MeiQiaResponseHandler.setMethodChannel(channel);
    //MyApplication.setInstance(registrar);
    channel.setMethodCallHandler(new MeiqiapluginPlugin(registrar.context(),channel));
  }

  MethodChannel channel;
  Context aContext;

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("initMeiQia")){
      System.out.println("==========初始化");
      initMeiqiaSDK(call);
    } else if(call.method.equals("openChatPage")){
      System.out.println("==========进入聊天");
      MeiQiaHandler.openMeiQia(call,result);
    } else if(call.method.equals("sendTextMessage")){
      System.out.println("==========预发送消息");
      MeiQiaHandler.sendTextMessage(call,result);
    }else {
      result.notImplemented();
    }
  }

  private void initMeiqiaSDK(MethodCall call) {
    MQManager.setDebugMode(true);


    // 替换成自己的key
//    String meiqiaKey = "b09225108281af94bca144ea90076459";
    String meiqiaKey = call.argument("Appkey");
    MQConfig.init(aContext, meiqiaKey, new OnInitCallback() {
      @Override
      public void onSuccess(String s) {
        System.out.println("初始化成功");
      }

      @Override
      public void onFailure(int i, String s) {
        System.out.println("初始化失败");
      }
    });

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
