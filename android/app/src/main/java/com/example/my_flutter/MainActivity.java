package com.example.my_flutter;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.example.my_flutter";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, Result result) {
                        if (methodCall.method.equals("changeLife")) {
                            String message = "Toast msg for Life Changed by Native Toast";
                            Toast.makeText(MainActivity.this,message,Toast.LENGTH_LONG).show();
                            result.success(message);
                        }
                        if (methodCall.method.equals("showNativeView")) {
                            String message = "Open Next Activity of Android";
                            Intent myIntent = new Intent(MainActivity.this, NextActivity.class);
                            myIntent.putExtra("key", message); //Optional parameters
                            MainActivity.this.startActivity(myIntent);
                            result.success(message);
                        }
                    }
                }
        );

    }
}
