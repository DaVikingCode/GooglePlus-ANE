//
//  GooglePlusIosExtension.m
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "GooglePlusHelpers.h"

#import <objc/runtime.h>

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

GooglePlusHelpers *googlePlusHelpers;

DEFINE_ANE_FUNCTION(login) {
    
    uint32_t stringLength;
    const uint8_t *key;
    
    FREGetObjectAsUTF8(argv[0], &stringLength, &key);
    
    uint32_t fetchGoogleUserEmail;
    FREGetObjectAsBool(argv[1], &fetchGoogleUserEmail);
    
    uint32_t fetchGooglePlusUser;
    FREGetObjectAsBool(argv[2], &fetchGooglePlusUser);
    
    uint32_t fetchGoogleUserID;
    FREGetObjectAsBool(argv[3], &fetchGoogleUserID);
    
    [googlePlusHelpers loginWithKey:[NSString stringWithUTF8String:(char*) key] andShouldFetchGoogleUserEmail:fetchGoogleUserEmail andShouldFetchGooglePlusUser:fetchGooglePlusUser andShouldFetchGoogleUserID:fetchGoogleUserID];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(signOut) {
    
    [googlePlusHelpers signOut];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(disconnect) {
    
    [googlePlusHelpers disconnect];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(isAuthenticated) {
    
    FREObject retBool = nil;
    FRENewObjectFromBool([googlePlusHelpers isAuthenticated], &retBool);
    
    return retBool;
}

DEFINE_ANE_FUNCTION(shareURL) {
    
    uint32_t string1Length;
    const uint8_t *url;
    
    FREGetObjectAsUTF8(argv[0], &string1Length, &url);
    
    uint32_t string2Length;
    const uint8_t *text;
    
    FREGetObjectAsUTF8(argv[1], &string2Length, &text);
    
    uint32_t nativeShareDialog;
    FREGetObjectAsBool(argv[2], &nativeShareDialog);
    
    [googlePlusHelpers shareURL:[NSString stringWithUTF8String:(char*) url] andPrefillText:[NSString stringWithUTF8String:(char*) text] withNativeShareDialog:nativeShareDialog];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(sharePost) {
    
    uint32_t string1Length;
    const uint8_t *title;
    
    FREGetObjectAsUTF8(argv[0], &string1Length, &title);
    
    uint32_t string2Length;
    const uint8_t *desc;
    
    FREGetObjectAsUTF8(argv[1], &string2Length, &desc);
    
    uint32_t string3Length;
    const uint8_t *url;
    
    FREGetObjectAsUTF8(argv[2], &string3Length, &url);
    
    uint32_t nativeShareDialog;
    FREGetObjectAsBool(argv[3], &nativeShareDialog);
    
    [googlePlusHelpers sharePostWithTitle:[NSString stringWithUTF8String:(char*) title] andDescription:[NSString stringWithUTF8String:(char*) desc] andThumbnailURL:[NSString stringWithUTF8String:(char*) url] withNativeShareDialog:nativeShareDialog];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(getUserMail) {
    
    const char *str = [[googlePlusHelpers getUserMail] UTF8String];
    
    FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &retStr);
    
    return retStr;
}

DEFINE_ANE_FUNCTION(getUserID) {
    
    const char *str = [[googlePlusHelpers getUserID] UTF8String];
    
    FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &retStr);
    
    return retStr;
}

bool applicationOpenURLSourceApplication(id self, SEL _cmd, UIApplication* application, NSURL* url, NSString* sourceApplication, id annotation) {
    
    return [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
}

void GooglePlusContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    Class objectClass = object_getClass(delegate);
    
    NSString *newClassName = [NSString stringWithFormat:@"Custom_%@", NSStringFromClass(objectClass)];
    Class  modDelegate = NSClassFromString(newClassName);
    
    if (modDelegate == nil) {
        
        modDelegate = objc_allocateClassPair(objectClass, [newClassName UTF8String], 0);
        
        SEL selectorToOverride1 = @selector(application:openURL:sourceApplication:annotation:);
        
        Method m1 = class_getInstanceMethod(objectClass, selectorToOverride1);
        
         class_addMethod(modDelegate, selectorToOverride1, (IMP)applicationOpenURLSourceApplication, method_getTypeEncoding(m1));
        
        objc_registerClassPair(modDelegate);
    }
    
    object_setClass(delegate, modDelegate);
    
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION(login, NULL),
        MAP_FUNCTION(signOut, NULL),
        MAP_FUNCTION(disconnect, NULL),
        MAP_FUNCTION(isAuthenticated, NULL),
        MAP_FUNCTION(shareURL, NULL),
        MAP_FUNCTION(sharePost, NULL),
        MAP_FUNCTION(getUserMail, NULL),
        MAP_FUNCTION(getUserID, NULL)
    };
    
    *numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = functionMap;
    
    googlePlusHelpers = [[GooglePlusHelpers alloc] initWithContext:ctx];
}

void GooglePlusContextFinalizer(FREContext ctx) {
    return;
}

void GooglePlusExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    
    extDataToSet = NULL;
    *ctxInitializerToSet = &GooglePlusContextInitializer;
    *ctxFinalizerToSet = &GooglePlusContextFinalizer;
}

void GooglePlusExtensionFinalizer() {
    return;
}