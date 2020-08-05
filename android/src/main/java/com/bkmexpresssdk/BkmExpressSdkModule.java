package com.bkmexpresssdk;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import javax.annotation.Nullable;

import android.app.Activity;
import android.content.Context;

import android.util.Log;

import com.bkm.bexandroidsdk.core.BEXStarter;
import com.bkm.bexandroidsdk.core.BEXSubmitConsumerListener;
import com.bkm.bexandroidsdk.core.BEXPaymentListener;
import com.bkm.bexandroidsdk.n.bexdomain.PosResult;
import com.bkm.bexandroidsdk.en.Environment;

public class BkmExpressSdkModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;
    public String resultType = "0";
    public Callback globCall;
    public Environment env;

    public BkmExpressSdkModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "BkmExpressSdk";
    }

    @ReactMethod
    public void onFailure() {

    }

    @ReactMethod
    public void submitConsumer(String token, String environment, Callback callback) {
        globCall = callback;

        final Activity currentActivity = getCurrentActivity();
        if (isNotEmpty(token)) {
            if (environment.equals("PREPROD")) {
                env = Environment.PREPROD;
            } else {
                env = Environment.PROD;
            }

            BEXStarter.startSDKForSubmitConsumer(currentActivity, env, token, new BEXSubmitConsumerListener() {

                @Override
                public void onSuccess(String first6, String last2) {
                    globCall.invoke(first6 + "********" + last2, "0");
                }

                @Override
                public void onCancelled() {
                    globCall.invoke("", "1");
                }

                @Override
                public void onFailure(int errorId, String errorMsg) {
                    globCall.invoke(errorMsg, "2");
                }
            });
        }
    }

    @ReactMethod
    public void resubmitConsumer(String ticket, String environment, Callback callback) {
        globCall = callback;

        final Activity currentActivity = getCurrentActivity();
        if (isNotEmpty(ticket)) {
            if (environment.equals("PREPROD")) {
                env = Environment.PREPROD;
            } else {
                env = Environment.PROD;
            }

            BEXStarter.startSDKForReSubmitConsumer(currentActivity, env, ticket, new BEXSubmitConsumerListener() {

                @Override
                public void onSuccess(String first6, String last2) {
                    globCall.invoke(first6 + "********" + last2, "0");
                }

                @Override
                public void onCancelled() {
                    globCall.invoke("", "1");
                }

                @Override
                public void onFailure(int errorId, String errorMsg) {
                    globCall.invoke(errorMsg, "2");
                }
            });
        }
    }

    @ReactMethod
    public void payment(String token, String environment, Callback callback) {
        globCall = callback;

        final Activity currentActivity = getCurrentActivity();
        if (isNotEmpty(token)) {
            if (environment.equals("PREPROD")) {
                env = Environment.PREPROD;
            } else {
                env = Environment.PROD;
            }

            BEXStarter.startSDKForPayment(currentActivity, env, token, new BEXPaymentListener() {

                @Override
                public void onSuccess(PosResult posResult) {
                    globCall.invoke(posResult, "0");
                }

                @Override
                public void onCancelled() {
                    globCall.invoke("", "1");
                }

                @Override
                public void onFailure(int errorId, String errorMsg) {
                    globCall.invoke(errorMsg, "2");
                }
            });
        }
    }

    private boolean isNotEmpty(String test) {
        return test != null && !test.equals("");
    }
}
