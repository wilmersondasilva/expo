// Copyright 2018-present 650 Industries. All rights reserved.

#import <React/RCTBridge.h>
#import <ExpoModulesCore/JSIObject.h>
#import <ExpoModulesCore/NativeObjectPrototype.h>

@class SwiftInteropBridge;

@interface JSIRuntime : NSObject

- (instancetype)initWithBridge:(nonnull RCTBridge *)bridge mediator:(nonnull SwiftInteropBridge *)mediator;

- (nonnull JSIObject *)global;
- (nonnull JSIObject *)mainObject;
- (nonnull JSIObject *)createObject;
- (nonnull NativeObjectPrototype *)createPrototype:(nonnull NSString *)className;

//- (void)registerModuleObject:(nonnull JSIObject *)moduleObject withName:(nonnull NSString *)name;

@end
