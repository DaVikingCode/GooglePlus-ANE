package com.davikingcode.nativeExtensions.googlePlus.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.davikingcode.nativeExtensions.googlePlus.LoginActivity;

public class GetUserMailFunction extends BaseFunction {
	
	@Override
    public FREObject call(FREContext context, FREObject[] args) {

        super.call(context, args);
        
        try {
        	
        	return FREObject.newObject(LoginActivity.userMail);
        	
        } catch (FREWrongThreadException e) {
        	
        	e.printStackTrace();
        }

        return null;
    }

}
