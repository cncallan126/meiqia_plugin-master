package com.ewhale.meiqiaplugin;


import android.content.Context;
import android.content.Intent;

import com.meiqia.meiqiasdk.controller.ControllerImpl;
import com.meiqia.meiqiasdk.util.MQConfig;
import com.meiqia.meiqiasdk.util.MQIntentBuilder;

import java.io.File;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

//import com.meiqia.core.bean.MQEnterpriseConfig;

public class MeiQiaHandler {
    private static Context mcontext;


    public static void setRegistrar(Context context) {
        mcontext = context;
    }


    public static void openMeiQia(MethodCall call,MethodChannel.Result result){
        //设置上线参数，可选
        //MCOnlineConfig onlineConfig = new MCOnlineConfig();
//启动对话界面

        MQConfig.registerController(new ControllerImpl(mcontext));
        Intent intent = new MQIntentBuilder(mcontext).build();
        mcontext.startActivity(intent);
//        startActivity(intent);
    }

    public static void sendTextMessage(MethodCall call,MethodChannel.Result result){
        //设置上线参数，可选
        //MCOnlineConfig onlineConfig = new MCOnlineConfig();
        //启动对话界面
        String link = call.argument("link");
        String imgPath = call.argument("imgPath");
        MQConfig.registerController(new ControllerImpl(mcontext));
        Intent intent = new MQIntentBuilder(mcontext)
                .setPreSendTextMessage(link)
                .setPreSendImageMessage(new File(imgPath))
                .build();
        mcontext.startActivity(intent);
//        startActivity(intent);
    }


}
