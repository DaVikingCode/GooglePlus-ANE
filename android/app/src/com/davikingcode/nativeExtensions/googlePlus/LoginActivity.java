package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

import com.davikingcode.nativeExtensions.googlePlus.GooglePlusExtension;
import com.davikingcode.nativeExtensions.googlePlus.GooglePlusExtensionContext;

import java.lang.Override;
import java.lang.String;

public class LoginActivity extends Activity {

    private GooglePlusExtensionContext _context = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        _context = GooglePlusExtension.context;

        Log.d("GooglePlusANE", String.valueOf(_context.getResourceId("layout.sign_in_activity")));

        setContentView(_context.getResourceId("layout.sign_in_activity"));
    }
}