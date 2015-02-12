//
//  GooglePlusIosExtension.m
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "GooglePlusHelpers.h"
#import "TypeConversion.h"

#import <objc/runtime.h>

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

GooglePlusHelpers* googlePlusHelpers;
TypeConversion* typeConverter;

DEFINE_ANE_FUNCTION(login) {
    
    NSString* key;
    [typeConverter FREGetObject:argv[0] asString:&key];
    
    uint32_t fetchGoogleUserEmail;
    FREGetObjectAsBool(argv[1], &fetchGoogleUserEmail);
    
    uint32_t fetchGooglePlusUser;
    FREGetObjectAsBool(argv[2], &fetchGooglePlusUser);
    
    uint32_t fetchGoogleUserID;
    FREGetObjectAsBool(argv[3], &fetchGoogleUserID);
    
    [googlePlusHelpers loginWithKey:key andShouldFetchGoogleUserEmail:fetchGoogleUserEmail andShouldFetchGooglePlusUser:fetchGooglePlusUser andShouldFetchGoogleUserID:fetchGoogleUserID];
    
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
    
    NSString* url;
    [typeConverter FREGetObject:argv[0] asString:&url];
    
    
    NSString* text;
    [typeConverter FREGetObject:argv[1] asString:&text];
    
    uint32_t nativeShareDialog;
    FREGetObjectAsBool(argv[2], &nativeShareDialog);
    
    [googlePlusHelpers shareURL:url andPrefillText:text withNativeShareDialog:nativeShareDialog];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(sharePost) {
    
    NSString* title;
    [typeConverter FREGetObject:argv[0] asString:&title];
    
    NSString* text;
    [typeConverter FREGetObject:argv[1] asString:&text];
    
    NSString* desc;
    [typeConverter FREGetObject:argv[2] asString:&desc];
    
    NSString* url;
    [typeConverter FREGetObject:argv[3] asString:&url];
    
    uint32_t nativeShareDialog;
    FREGetObjectAsBool(argv[4], &nativeShareDialog);
    
    [googlePlusHelpers sharePostWithTitle:title andText:text andDescription:desc andThumbnailURL:url withNativeShareDialog:nativeShareDialog];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(getUserMail) {
    
    FREObject result;
    
    if ([typeConverter FREGetString:[googlePlusHelpers getUserMail] asObject:&result] == FRE_OK)
        return result;
    
    return NULL;
}

DEFINE_ANE_FUNCTION(getUserID) {
    
    FREObject result;
    
    if ([typeConverter FREGetString:[googlePlusHelpers getUserID] asObject:&result] == FRE_OK)
        return result;
    
    return NULL;
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
    typeConverter = [[TypeConversion alloc] init];
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