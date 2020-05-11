package com.ewhale.meiqiaplugin;

import java.util.HashMap;

import io.flutter.plugin.common.MethodChannel;

public class MeiQiaResponseHandler {

    private static MethodChannel channel = null;

    public static void setMethodChannel(MethodChannel channel) {
        MeiQiaResponseHandler.channel = channel;
    }

}
