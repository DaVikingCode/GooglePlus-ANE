package com.davikingcode.nativeExtensions.googlePlus;

import android.content.Context;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import java.lang.Exception;
import java.lang.Override;

public class GooglePlusLogin implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Context appContext = context.getActivity().getApplicationContext();

        try {

            Log.d("GooglePlusANE", args[0].getAsString());

        } catch (Exception e) {

        }

        return null;
    }
}