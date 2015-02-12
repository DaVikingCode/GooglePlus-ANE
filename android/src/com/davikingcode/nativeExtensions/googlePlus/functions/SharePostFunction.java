package com.davikingcode.nativeExtensions.googlePlus.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.davikingcode.nativeExtensions.googlePlus.GooglePlusExtension;

public class SharePostFunction extends BaseFunction {
	
	@Override
    public FREObject call(FREContext context, FREObject[] args) {

        super.call(context, args);
        
        String title = getStringFromFREObject(args[0]);
        String text = getStringFromFREObject(args[1]);
        String description = getStringFromFREObject(args[2]);
        String thumbnailURL = getStringFromFREObject(args[3]);

        GooglePlusExtension.context.launchSharePostActivity(title, text, description, thumbnailURL);

        return null;
    }

}
