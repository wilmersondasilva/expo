// Copyright 2018-present 650 Industries. All rights reserved.

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

#ifdef __cplusplus
#import <jsi/jsi.h>
#import <ReactCommon/CallInvoker.h>

using namespace facebook;
#endif

typedef id _Nullable (^JSIAsyncFunctionBlock)(NSArray * _Nonnull, RCTPromiseResolveBlock _Nonnull, RCTPromiseRejectBlock _Nonnull);

@interface JSIObject : NSObject

// Some parts of the interface must be hidden for Swift – it can't import any C++ code.
#ifdef __cplusplus
@property (nonatomic) std::weak_ptr<jsi::Runtime> runtime;
@property (nonatomic) std::shared_ptr<jsi::Object> object;
@property (nonatomic) std::shared_ptr<react::CallInvoker> callInvoker;

- (instancetype)initFrom:(std::shared_ptr<jsi::Object>)object
             withRuntime:(std::shared_ptr<jsi::Runtime>)runtime
             callInvoker:(std::shared_ptr<react::CallInvoker>)callInvoker;

- (jsi::Object *)get;
#endif

- (void)setProperty:(nonnull NSString *)key toValue:(nullable JSIObject *)value NS_SWIFT_NAME(setProperty(_:_:));

// MARK: Function

- (void)setAsyncFunction:(nonnull NSString *)key argsCount:(NSInteger)argsCount block:(JSIAsyncFunctionBlock)block;

// MARK: Subscripting

- (nullable id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(nullable id)obj forKeyedSubscript:(NSString *)key;

@end
