package com.flutterdev.own_task_01


import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel


class MainActivity: FlutterActivity() {

    private val BATTERY_CHANNEL = "com.flutterdev.own_task_01/battery"
    private var batteryEventChannel: EventChannel.EventSink? = null


    private val batteryReceiver = object : BroadcastReceiver() {
      override fun onReceive(context: Context, intent: Intent) {
            val level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
            val scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            val batteryPercentage = (level * 100) / scale
            batteryEventChannel?.success(batteryPercentage)
        }
    }


    // Overriding onCreate to configure the EventChannel properly
    override fun onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)

        // Create the EventChannel and set its StreamHandler
        EventChannel(flutterEngine?.dartExecutor, BATTERY_CHANNEL).apply {
            setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    // Register the receiver and set the event sink to send updates to Dart
                    batteryEventChannel = events
                    val filter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                    registerReceiver(batteryReceiver, filter)
                }

                override fun onCancel(arguments: Any?) {
                    // Clean up: unregister receiver and clear the event sink
                    batteryEventChannel = null
                    unregisterReceiver(batteryReceiver)
                }
            })
        }
    }
}
