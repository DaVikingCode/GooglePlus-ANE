package com.davikingcode.nativeExtensions.googlePlus;

import android.content.Intent;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.GooglePlusLoginFunction;

import java.lang.Override;
import java.util.HashMap;
import java.util.Map;

public class GooglePlusExtensionContext extends FREContext {

    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {

        Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();

        functionMap.put("login", new GooglePlusLoginFunction());

        return functionMap;
    }

    public void launchLoginActivity() {

        Intent i = new Intent(getActivity().getApplicationContext(), LoginActivity.class);

        getActivity().startActivity(i);
    }
}