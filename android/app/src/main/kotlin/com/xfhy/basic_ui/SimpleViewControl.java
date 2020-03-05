package com.xfhy.basic_ui;

import android.content.Context;
import android.graphics.Color;
import android.view.View;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * @author : xfhy
 * Create time : 2020-03-05 23:12
 * Description :  原生视图封装类
 */
class SimpleViewControl implements PlatformView, MethodChannel.MethodCallHandler {

    //缓存原生视图
    private final View view;
    private final MethodChannel mMethodChannel;

    public SimpleViewControl(Context context, int viewId, BinaryMessenger messenger) {
        view = new View(context);
        view.setBackgroundColor(Color.rgb(255, 0, 0));

        //用View id注册方法通道
        mMethodChannel = new MethodChannel(messenger, "samples.chenhang/native_views_" + viewId);
        //设置方法通道回调
        mMethodChannel.setMethodCallHandler(this);
    }

    //返回原生视图
    @Override
    public View getView() {
        return view;
    }

    //原生视图销毁回调
    @Override
    public void dispose() {

    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        //方法名完全匹配
        if (call.method.equals("changeBackgroundColor")) {
            //修改视图背景,返回成功
            view.setBackgroundColor(Color.rgb(0, 0, 255));
            result.success(0);
        } else {
            //调用方发起了一个不支持的API调用
            result.notImplemented();
        }
    }
}
