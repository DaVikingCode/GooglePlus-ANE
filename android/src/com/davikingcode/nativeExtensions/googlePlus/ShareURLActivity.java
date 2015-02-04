package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.plus.PlusShare;

public class ShareURLActivity extends Activity {
	
	private static final int REQUEST_CODE_INTERACTIVE_POST = 1;
    private static final int REQUEST_CODE_GET_GOOGLE_PLAY_SERVICES = 2;
	
	@Override
    protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		Log.d("GooglePlusANE", "ShareURLActivity");
		
		startActivityForResult(getInteractivePostIntent(), REQUEST_CODE_INTERACTIVE_POST);
	}
	
	@Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
		
		Log.d("GooglePlusANE", "onActivityResult?");
		
        switch (requestCode) {
            case REQUEST_CODE_GET_GOOGLE_PLAY_SERVICES:
                if (resultCode != RESULT_OK) {
                    Log.e("GooglePlusANE", "Unable to sign the user in.");
                    finish();
                }
                break;

            case REQUEST_CODE_INTERACTIVE_POST:
                if (resultCode != RESULT_OK) {
                    Log.e("GooglePlusANE", "Failed to create interactive post");
                }
                break;
        }
    }
	
	private Intent getInteractivePostIntent() {
		
        PlusShare.Builder builder = new PlusShare.Builder(this);

        builder.setContentUrl(Uri.parse("https://github.com/DaVikingCode/Instagram-ANE"));
        
        builder.setText("An awesome ANE");

        return builder.getIntent();
    }
}
