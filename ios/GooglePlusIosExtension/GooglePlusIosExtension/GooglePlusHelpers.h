//
//  GooglePlusHelpers
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import <GooglePlus/GooglePlus.h>

@class GTMOAuth2Authentication;

@interface GooglePlusHelpers : NSObject <UIApplicationDelegate, GPPSignInDelegate>

- (void) login;

@end
