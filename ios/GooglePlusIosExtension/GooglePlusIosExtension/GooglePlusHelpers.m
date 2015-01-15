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

- (void) login {
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    
    signIn.clientID = @"103213343972-viosupja0di6kact26le0mvf720ab726.apps.googleusercontent.com";
    
    signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin, nil];
    
    [signIn setDelegate:self];
        
    if (![signIn trySilentAuthentication])
        [signIn authenticate];
}

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
    
    NSLog(@"here 1 ?");
    
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

@end
