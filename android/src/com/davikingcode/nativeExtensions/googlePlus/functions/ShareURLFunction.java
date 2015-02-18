package com.davikingcode.nativeExtensions.googlePlus.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.davikingcode.nativeExtensions.googlePlus.GooglePlusExtension;

public class ShareURLFunction extends BaseFunction {
	
	@Override
    public FREObject call(FREContext context, FREObject[] args) {

        super.call(context, args);
        
        String url = getStringFromFREObject(args[0]);
        String text = getStringFromFREObject(args[1]);
        String imageURL = getStringFromFREObject(args[2]);

        GooglePlusExtension.context.launchShareURLActivity(url, text, imageURL);

        return null;
    }

}
