package com.davikingcode.nativeExtensions.googlePlus;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

import java.lang.Override;

public class GooglePlusExtension implements FREExtension {

    @Override
    public FREContext createContext(String label) {

        return new GooglePlusExtensionContext();
    }

    @Override
    public void dispose() {
    }

    @Override
    public void initialize() {
    }
}