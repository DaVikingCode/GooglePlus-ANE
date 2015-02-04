package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.plus.PlusShare;

public class ShareURLActivity extends Activity {
	
	static public String extraPrefix = "com.davikingcode.nativeExtensions.googlePlus.ShareURLActivity";
	
	static private final int REQUEST_CODE_INTERACTIVE_POST = 1;
	static private final int REQUEST_CODE_GET_GOOGLE_PLAY_SERVICES = 2;
	
	private String _url;
	private String _text;
	
	@Override
    protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		Bundle extras = this.getIntent().getExtras();
		
		 _url = extras.getString(extraPrefix + ".url");
		_text = extras.getString(extraPrefix + ".text");
		
		startActivityForResult(getInteractivePostIntent(), REQUEST_CODE_INTERACTIVE_POST);
	}
	
	@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
		
        switch (requestCode) {
        
            case REQUEST_CODE_GET_GOOGLE_PLAY_SERVICES:
            	
                if (resultCode != RESULT_OK) {
                	
                	Log.d("GooglePlusANE", "Unable to sign the user in.");
                    finish();
                }
                break;

            case REQUEST_CODE_INTERACTIVE_POST:
            	
                if (resultCode != RESULT_OK)
                	GooglePlusExtension.context.dispatchStatusEventAsync("POST_NOT_SHARED", "");
                else
                	GooglePlusExtension.context.dispatchStatusEventAsync("POST_SHARED", "");
                
                finish();
                break;
        }
    }
	
	private Intent getInteractivePostIntent() {
		
		String action = "/?view=true";
        Uri callToActionUrl = Uri.parse(_url);
        String callToActionDeepLinkId = _url + action;

        PlusShare.Builder builder = new PlusShare.Builder(this);

        builder.addCallToAction("VIEW", callToActionUrl, callToActionDeepLinkId);

        builder.setContentUrl(Uri.parse(_url));

        builder.setText(_text);

        return builder.getIntent();
    }
}
