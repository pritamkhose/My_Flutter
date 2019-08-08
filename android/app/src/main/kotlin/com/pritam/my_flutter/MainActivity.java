package com.pritam.my_flutter;

import android.content.Intent;
import android.os.BatteryManager;
import android.os.Bundle;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.pritam.my_flutter";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
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
                        else if (methodCall.method.equals("showNativeView")) {
                            String message = "Open Next Activity of Android";
                            Intent myIntent = new Intent(MainActivity.this, NextActivity.class);
                            myIntent.putExtra("key", message); //Optional parameters
                            MainActivity.this.startActivity(myIntent);
                            result.success(message);
                        }
                        else if (methodCall.method.equals("getBatteryLevel")) {
                            String  text = methodCall.argument("text");
                            String batteryLevel = getBatteryLevel();

                            if (batteryLevel != null) {
                                Toast.makeText(MainActivity.this, text + " your phone batter is " + batteryLevel,Toast.LENGTH_LONG).show();
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "Battery level not available.", null);
                            }
                        } else {
                            Toast.makeText(MainActivity.this, "No onMethodCall Implement" + methodCall.method,Toast.LENGTH_LONG).show();
                        }
                    }
                }
        );

    }

    private String getBatteryLevel() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager bm = (BatteryManager)getSystemService(BATTERY_SERVICE);
            int batLevel = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
            return batLevel + "";
        } else {
            return  "NA";
        }
    }
}
