package com.long51xy.flutter.plugin.flutter_payu;

import android.annotation.SuppressLint;

import androidx.annotation.NonNull;

import org.json.JSONException;

import java.util.Map;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterPayuPlugin
 */
public class FlutterPayuPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private FlutterPayuDelegate flutterPayuDelegate;
    private ActivityPluginBinding pluginBinding;
    private MethodChannel channel;
    private static String CHANNEL_NAME = "flutter_payu";

    public FlutterPayuPlugin() {
    }


    /**
     * Plugin registration for Flutter version < 1.12
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(new FlutterPayuPlugin(registrar));
    }

    /**
     * Constructor for Flutter version < 1.12
     *
     * @param registrar
     */
    private FlutterPayuPlugin(Registrar registrar) {
        this.flutterPayuDelegate = new FlutterPayuDelegate(registrar.activity());
        registrar.addActivityResultListener(flutterPayuDelegate);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), CHANNEL_NAME);
        channel.setMethodCallHandler(this);
    }

    @SuppressLint("LongLogTag")
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case "doPayment":
                try {
                    flutterPayuDelegate.doPayment((Map<String, Object>) call.arguments, result);
                } catch (JSONException e) {
                    Log.d("Payu doPayment error={}", e.getMessage());
                    e.printStackTrace();
                }
                break;
            case "resync":
                flutterPayuDelegate.resync(result);
                break;    
            default:
                result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.flutterPayuDelegate = new FlutterPayuDelegate(binding.getActivity());
        this.pluginBinding = binding;
        binding.addActivityResultListener(flutterPayuDelegate);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {
        pluginBinding.removeActivityResultListener(flutterPayuDelegate);
        pluginBinding = null;
    }
}
