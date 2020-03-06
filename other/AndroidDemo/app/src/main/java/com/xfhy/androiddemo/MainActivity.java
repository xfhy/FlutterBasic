package com.xfhy.androiddemo;

import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;

import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;


/**
 * 在已有Android工程时嵌入Flutter
 */
public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btn_view).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //开启一个Activity  Flutter的Activity是在一个新的进程  而且进入非常缓慢
                launchFlutter();
            }
        });

        addViewToFrameLayout();
    }

    private void addViewToFrameLayout() {
        FlutterEngine flutterEngine2 = new FlutterEngine(this.getApplicationContext());
        flutterEngine2.getDartExecutor().executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault());
        flutterEngine2.getNavigationChannel().pushRoute("/my_blue_page");

        FlutterView flutterView = new FlutterView(this);
        flutterView.attachToFlutterEngine(flutterEngine2);
        FrameLayout frameLayout = findViewById(R.id.fl_view);
        frameLayout.addView(flutterView);
    }

    void launchFlutter() {
        //需要在清单文件中注册  <activity android:name="io.flutter.embedding.android.FlutterActivity" />

        //方式1
        //startActivity(FlutterActivity.withCachedEngine("my flutter engine").build(this));

        //方式2
        startActivity(FlutterActivity.withNewEngine().initialRoute("/my_route").build(this));
    }

}
