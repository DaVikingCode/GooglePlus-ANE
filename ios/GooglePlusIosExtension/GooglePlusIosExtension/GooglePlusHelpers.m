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
    
    if (error)
        NSLog(@"login failed");
    
    else if ([[GPPSignIn sharedInstance] authentication]) {
        
        NSLog(@"login success");
        
        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
        
        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://www.example.com/restaurant/sf/1234567/"]];
        [shareBuilder open];
    }
}

- (BOOL)application: (UIApplication *)application openURL: (NSURL *)url sourceApplication: (NSString *)sourceApplication annotation: (id)annotation {
    
    // will be overrided in Main file.
    return false;
}

@end
