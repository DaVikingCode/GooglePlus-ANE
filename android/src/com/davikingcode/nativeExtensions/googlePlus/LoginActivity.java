package com.davikingcode.nativeExtensions.googlePlus;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.plus.Plus;
import com.google.android.gms.plus.model.people.Person;

public class LoginActivity extends Activity implements GoogleApiClient.ConnectionCallbacks, GoogleApiClient.OnConnectionFailedListener {

    private GooglePlusExtensionContext _context = null;
    
    private GoogleApiClient mGoogleApiClient;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        _context = GooglePlusExtension.context;
        
        mGoogleApiClient = new GoogleApiClient.Builder(this).addApi(Plus.API).addConnectionCallbacks(this).addOnConnectionFailedListener(this).build();
        
        Log.d("GooglePlusANE", "mGoogleApiClient created");
        
        mGoogleApiClient.connect();
        
        Log.d("GooglePlusANE", "mGoogleApiClient connect");
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
    	
    	Log.d("GooglePlusANE", "onConnectionFailed!!!!!");
    }
}