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

- (void) loginWithKey:(NSString *) key;
- (void) signOut;
- (void) disconnect;

- (void) shareURL:(NSString *) url andPrefillText:(NSString *) prefillText withNativeShareDialog:(BOOL) useNativeShareDialog;
- (void) sharePostWithTitle:(NSString *) title andDescription:(NSString *) description andThumbnailURL:(NSString *) thumbnailURL withNativeShareDialog:(BOOL) useNativeShareDialog;

- (void) dispatchEvent:(NSString *) event withParams:(NSString * ) params;

@end
