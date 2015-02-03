package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.content.IntentSender.SendIntentException;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.plus.Plus;
import com.google.android.gms.plus.model.people.Person;

public class LoginActivity extends Activity implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener {
	
	private static final int DIALOG_GET_GOOGLE_PLAY_SERVICES = 1;
	
	private static final int REQUEST_CODE_GET_GOOGLE_PLAY_SERVICES = 2;
	
    private GooglePlusExtensionContext _context = null;
    
    private GoogleApiClient mGoogleApiClient;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        _context = GooglePlusExtension.context;
        
        mGoogleApiClient = new GoogleApiClient.Builder(this).addApi(Plus.API).addScope(Plus.SCOPE_PLUS_PROFILE).addConnectionCallbacks(this).addOnConnectionFailedListener(this).build();
        
        Log.d("GooglePlusANE", "mGoogleApiClient created");
    }
    
    @Override
    public void onStart() {
        super.onStart();
        mGoogleApiClient.connect();
    }

    @Override
    public void onStop() {
        mGoogleApiClient.disconnect();
        super.onStop();
    }
    
   @Override
    public void onConnected(Bundle connectionHint) {
    	
    	Log.d("GooglePlusANE", "Connected!!!!!");
    	
    	Person person = Plus.PeopleApi.getCurrentPerson(mGoogleApiClient);
    	
    	if (person != null)
    		Log.d("GooglePlusANE", "Perso: " + person.getId());
    	else
    		Log.d("GooglePlusANE", "Perso: null?");
    }
    
    @Override
    public void onConnectionSuspended(int cause) {
    	
    	Log.d("GooglePlusANE", "onConnectionSuspended!!!!!");
    }
    
    @Override
    public void onConnectionFailed(ConnectionResult result) {
    	
    	Log.d("GooglePlusANE", "onConnectionFailed! code: " + Integer.toString(result.getErrorCode()) + " object: " + result.toString());
    	
    	if (result.hasResolution()) {
    		
    		try {
    			
    			result.startResolutionForResult(this, ConnectionResult.SIGN_IN_REQUIRED);
    			Log.d("GooglePlusANE", "onConnectionFailed! We're in the try");
    			
    		} catch (SendIntentException e) {
    			
    			mGoogleApiClient.connect();
    			
    			Log.d("GooglePlusANE", "onConnectionFailed! Error sending the resolution Intent, connect() again.");
    		}
    	}
    }
}