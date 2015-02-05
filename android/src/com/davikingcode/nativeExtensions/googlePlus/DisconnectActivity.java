package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.plus.Plus;

public class DisconnectActivity extends Activity implements GoogleApiClient.ConnectionCallbacks {
	
	static public String extraPrefix = "com.davikingcode.nativeExtensions.googlePlus.DisconnectActivity";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		LoginActivity.mGoogleApiClient.registerConnectionCallbacks(this);
		
		Bundle extras = this.getIntent().getExtras();
		
		boolean signOut = extras.getBoolean(extraPrefix + ".signOut");
		
		if (signOut)
			Plus.AccountApi.revokeAccessAndDisconnect(LoginActivity.mGoogleApiClient);
		else
			Plus.AccountApi.clearDefaultAccount(LoginActivity.mGoogleApiClient);
	}

	@Override
	public void onConnected(Bundle connectionHint) {
		
		LoginActivity.isConnected = false;
		
		GooglePlusExtension.context.dispatchStatusEventAsync("DISCONNECTED", "");
		
		finish();
	}

	@Override
	public void onConnectionSuspended(int cause) {

		Log.d("GooglePlusANE", "onConnectionSuspended!!!!!");
	}
}
