package com.ewhale.meiqiaplugin;

import android.content.Context;

import io.flutter.plugin.common.PluginRegistry.Registrar;

public class MeiQiaRequestHandler {
    private static Context aContext;

    public static void setRegistrar(Context context) {
        MeiQiaRequestHandler.aContext = context;
    }

    public Context getContext() {
        return aContext;
    }
}
