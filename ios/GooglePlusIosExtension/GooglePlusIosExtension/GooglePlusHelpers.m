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
    
    if (error)
        [self dispatchEvent:@"LOGIN_FAILED" withParams:@""];
        
    else if ([[GPPSignIn sharedInstance] authentication])
        [self dispatchEvent:@"LOGIN_SUCCESSED" withParams:@""];
}

- (void) shareURL:(NSString *) url andPrefillText:(NSString *) prefillText withNativeShareDialog:(BOOL) useNativeShareDialog {
    
    id<GPPShareBuilder> shareBuilder = useNativeShareDialog ? [[GPPShare sharedInstance] nativeShareDialog] : [[GPPShare sharedInstance] shareDialog];
    
    [shareBuilder setURLToShare:[NSURL URLWithString:url]];
    [shareBuilder setPrefillText:prefillText];
    [shareBuilder open];
}

- (void) sharePostWithTitle:(NSString *) title andDescription:(NSString *) description andThumbnailURL:(NSString *) thumbnailURL withNativeShareDialog:(BOOL) useNativeShareDialog {
    
    id<GPPShareBuilder> shareBuilder = useNativeShareDialog ? [[GPPShare sharedInstance] nativeShareDialog] : [[GPPShare sharedInstance] shareDialog];
    
    [shareBuilder setTitle:title description:description thumbnailURL:[NSURL URLWithString:thumbnailURL]];
    [shareBuilder open];
}

- (void)finishedSharing:(BOOL)shared {
    
    if (shared)
        [self dispatchEvent:@"POST_SHARED" withParams:@""];
    
    else
        [self dispatchEvent:@"POST_NOT_SHARED" withParams:@""];
}

- (void) signOut {
    
    [[GPPSignIn sharedInstance] signOut];
}

- (void) disconnect {
    
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    
    if (error)
        NSLog(@"Received error %@", error);
        
    else
        [self dispatchEvent:@"DISCONNECTED" withParams:@""];
}

- (void) dispatchEvent:(NSString *) event withParams:(NSString * ) params {
    
    const uint8_t* par = (const uint8_t*) [params UTF8String];
    const uint8_t* evt = (const uint8_t*) [event UTF8String];
    
    FREDispatchStatusEventAsync(ctx, evt, par);
}

@end
