package com.xfhy.basic_ui;

import android.content.Context;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * @author : xfhy
 * Create time : 2020-03-05 23:09
 * Description :  视图工厂类
 */
public class SampleViewFactory extends PlatformViewFactory {
    private final BinaryMessenger mMessenger;

    public SampleViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        mMessenger = messenger;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        return new SimpleViewControl(context, viewId, mMessenger);
    }
}
