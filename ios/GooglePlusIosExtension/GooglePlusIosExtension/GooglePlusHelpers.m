//
//  GooglePlusHelpers.m
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import "GooglePlusHelpers.h"
#import "GoogleOpenSource/GTLPlusConstants.h"

@interface GooglePlusHelpers ()

@end

@implementation GooglePlusHelpers

- (id) initWithContext:(FREContext) context {
    
    if (self = [super init]) {
        
        ctx = context;
    }
    
    return self;
}

- (void) loginWithKey:(NSString *) key {
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    
    signIn.clientID = key;
    
    signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin, nil];
    
    [signIn setDelegate:self];
    [[GPPShare sharedInstance] setDelegate:self];
        
    if (![signIn trySilentAuthentication])
        [signIn authenticate];
}

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    
    if (error) {
        
        [self dispatchEvent:@"LOGIN_FAILED" withParams:@""];
        //NSLog(@"login failed");
        
    } else if ([[GPPSignIn sharedInstance] authentication]) {
        
        [self dispatchEvent:@"LOGIN_SUCCESSED" withParams:@""];
        //NSLog(@"login success");
        
        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];//[[GPPShare sharedInstance] shareDialog];
        
        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.example.com/restaurant/sf/1234567/"]];
        [shareBuilder open];
    }
}

- (void)finishedSharing:(BOOL)shared {
    
    if (shared) {
        
        [self dispatchEvent:@"POST_SHARED" withParams:@""];
        //NSLog(@"User successfully shared!");
        
    } else {
        
        [self dispatchEvent:@"POST_NOT_SHARED" withParams:@""];
        //NSLog(@"User didn't share.");
    }
}

- (void) signOut {
    
    [[GPPSignIn sharedInstance] signOut];
}

- (void) disconnect {
    
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    
    if (error) {
        NSLog(@"Received error %@", error);
        
    } else {
        
        [self dispatchEvent:@"DISCONNECTED" withParams:@""];
        //NSLog(@"User is disconnected and the application isn't linked anymore to Google+");
    }
}

- (void) dispatchEvent:(NSString *) event withParams:(NSString * ) params {
    
    const uint8_t* par = (const uint8_t*) [params UTF8String];
    const uint8_t* evt = (const uint8_t*) [event UTF8String];
    
    FREDispatchStatusEventAsync(ctx, evt, par);
}

@end
