package com.davikingcode.nativeExtensions.googlePlus;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

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

        functionMap.put("login", new GooglePlusLogin());

        return functionMap;
    }
}