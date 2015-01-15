//
//  GooglePlusIosExtension.m
//  GooglePlusIosExtension
//
//  Created by Aymeric Lamboley on 07/01/2015.
//  Copyright (c) 2015 DaVikingCode. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "GooglePlusHelpers.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

GooglePlusHelpers *googlePlusHelpers;

DEFINE_ANE_FUNCTION(init) {
    
    googlePlusHelpers = [[GooglePlusHelpers alloc] init];
    
    [googlePlusHelpers login];
    
    return NULL;
}


void GooglePlusContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION(init, NULL )
    };
    
    *numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = functionMap;
    
}

void GooglePlusContextFinalizer(FREContext ctx) {
    return;
}

void GooglePlusExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) {
    
    extDataToSet = NULL; // This example does not use any extension data.
    *ctxInitializerToSet = &GooglePlusContextInitializer;
    *ctxFinalizerToSet = &GooglePlusContextFinalizer;
}

void GooglePlusExtensionFinalizer() {
    return;
}