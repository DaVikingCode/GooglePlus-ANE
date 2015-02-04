package com.davikingcode.nativeExtensions.googlePlus.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.davikingcode.nativeExtensions.googlePlus.GooglePlusExtension;

import java.lang.Override;

public class LoginFunction extends BaseFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        super.call(context, args);

        Log.d("GooglePlusANE", getStringFromFREObject(args[0]));

        GooglePlusExtension.context.launchLoginActivity();

        return null;
    }
}