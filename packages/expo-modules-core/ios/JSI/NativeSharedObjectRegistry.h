// Copyright 2018-present 650 Industries. All rights reserved.

#import <ExpoModulesCore/JSIRuntime.h>
#import <ExpoModulesCore/NativeSharedObject.h>

@interface NativeSharedObjectRegistry : NSObject

- (instancetype)initWithRuntime:(JSIRuntime *)runtime;

- (void)createNativeSharedObject:(SharedObjectId)objectId;

- (void)invalidateObjectWithId:(SharedObjectId)objectId;

@end
