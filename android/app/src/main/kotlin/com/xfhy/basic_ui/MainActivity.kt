package com.xfhy.basic_ui

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //参考: https://flutter.dev/docs/development/platform-integration/platform-channels

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.xfhy.basic_ui/util").setMethodCallHandler { call, result ->
            //判断方法名是否支持
            if (call.method == "isEmpty") {
                val arguments = call.arguments
                result.success(StringUtil.isEmpty(arguments as? String))
                print("success")
            } else {
                //方法名暂不支持
                result.notImplemented()
                print("fail")
            }
        }
    }
}
