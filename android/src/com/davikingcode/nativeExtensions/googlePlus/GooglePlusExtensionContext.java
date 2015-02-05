package com.davikingcode.nativeExtensions.googlePlus;

import java.util.HashMap;
import java.util.Map;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.DebuggerHelperFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.DisconnectFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.IsAuthenticatedFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.LoginFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.ShareURLFunction;
import com.davikingcode.nativeExtensions.googlePlus.functions.SignOutFunction;

public class GooglePlusExtensionContext extends FREContext {

    @Override
    public void dispose() {
    }

    @Override
    public Map<String, FREFunction> getFunctions() {

        Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();

        functionMap.put("login", new LoginFunction());
        functionMap.put("isAuthenticated", new IsAuthenticatedFunction());
        functionMap.put("debuggerHelper", new DebuggerHelperFunction());
        functionMap.put("shareURL", new ShareURLFunction());
        functionMap.put("disconnect", new DisconnectFunction());
        functionMap.put("signOut", new SignOutFunction());

        return functionMap;
    }

    public void launchLoginActivity() {

        Intent i = new Intent(getActivity().getApplicationContext(), LoginActivity.class);

        getActivity().startActivity(i);
    }
    
    public void launchShareURLActivity(String url, String text) {

        Intent i = new Intent(getActivity().getApplicationContext(), ShareURLActivity.class);
        
        i.putExtra(ShareURLActivity.extraPrefix + ".url", url);
        i.putExtra(ShareURLActivity.extraPrefix + ".text", text);

        getActivity().startActivity(i);
    }
    
    public void launchDisconnectActivity(boolean signOut) {

        Intent i = new Intent(getActivity().getApplicationContext(), DisconnectActivity.class);
        
        i.putExtra(DisconnectActivity.extraPrefix + ".signOut", signOut);

        getActivity().startActivity(i);
    }
}