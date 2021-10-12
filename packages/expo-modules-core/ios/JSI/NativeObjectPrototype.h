// Copyright 2018-present 650 Industries. All rights reserved.

#import <Foundation/Foundation.h>
#import <ExpoModulesCore/JSIObject.h>

#ifdef __cplusplus
#import <jsi/jsi.h>
#import <ReactCommon/CallInvoker.h>

using namespace facebook;
#endif // __cplusplus

@interface NativeObjectPrototype : JSIObject

@property (nonatomic, readonly) NSString *className;

#ifdef __cplusplus
- (instancetype)initWithRuntime:(std::shared_ptr<jsi::Runtime>)runtime
                    callInvoker:(std::shared_ptr<react::CallInvoker>)callInvoker
                      className:(nonnull NSString *)className;
#endif // __cplusplus

- (nonnull JSIObject *)makeObject;

@end
