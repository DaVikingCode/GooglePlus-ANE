//
//  GooglePlusHelpers
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import <GooglePlus/GooglePlus.h>
#import "FlashRuntimeExtensions.h"

@class GTMOAuth2Authentication;

@interface GooglePlusHelpers : NSObject <GPPSignInDelegate, GPPShareDelegate> {
    
    FREContext ctx;
}

- (id) initWithContext:(FREContext) context;

- (void) loginWithKey:(NSString *) key andExtendedPermissions:(BOOL) extended;
- (void) signOut;
- (void) disconnect;
- (BOOL) isAuthenticated;

- (void) shareURL:(NSString *) url andPrefillText:(NSString *) prefillText withImage:(NSString *) url;

- (NSString *) getUserMail;
- (NSString *) getUserID;

- (void) getUserInfo;

- (void) dispatchEvent:(NSString *) event withParams:(NSString * ) params;

@end
