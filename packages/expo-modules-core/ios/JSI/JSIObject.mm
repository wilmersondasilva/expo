// Copyright 2018-present 650 Industries. All rights reserved.

#import <ReactCommon/TurboModuleUtils.h>
#import <ExpoModulesCore/JSIConversions.h>
#import <ExpoModulesCore/JSIObject.h>
#import <ExpoModulesCore/ExpoModulesProxySpec.h>

@implementation JSIObject

- (instancetype)initFrom:(std::shared_ptr<jsi::Object>)object
             withRuntime:(std::shared_ptr<jsi::Runtime>)runtime
             callInvoker:(std::shared_ptr<react::CallInvoker>)callInvoker
{
  if (self = [super init]) {
    _runtime = runtime;
    _object = object;
    _callInvoker = callInvoker;
  }
  return self;
}

- (jsi::Object *)get
{
  return _object.get();
}

- (void)setProperty:(nonnull NSString *)key toValue:(nullable JSIObject *)value
{
  auto runtime = _runtime.lock();

  if (runtime) {
    _object->setProperty(*runtime, [key UTF8String], *[value get]);
  }
}

- (nullable id)objectForKeyedSubscript:(NSString *)key
{
  auto runtime = _runtime.lock();

  if (runtime) {
    auto value = _object->getProperty(*runtime, [key UTF8String]);
    return expo::convertJSIValueToObjCObject(*runtime, value, _callInvoker);
  }
  return nil;
}

- (void)setObject:(nullable id)obj forKeyedSubscript:(NSString *)key
{
  auto runtime = _runtime.lock();

  if (runtime) {
    _object->setProperty(*runtime, [key UTF8String], expo::convertObjCObjectToJSIValue(*runtime, obj));
  }
}

- (void)setAsyncFunction:(nonnull NSString *)key argsCount:(NSInteger)argsCount block:(JSIAsyncFunctionBlock)block
{
  auto runtime = _runtime.lock();

  if (!runtime) {
    return;
  }

  auto propId = jsi::PropNameID::forAscii(*runtime, [key UTF8String], [key length]);
  auto callInvoker = _callInvoker;
  auto jsiFn = jsi::Function::createFromHostFunction(*runtime, propId, argsCount, [callInvoker, block](jsi::Runtime &runtime, const jsi::Value &thisVal, const jsi::Value *args, size_t count) -> jsi::Value {
    NSArray *arguments = expo::convertJSIValuesToNSArray(runtime, args, count, callInvoker);

    // The function that is invoked as a setup of the JS `Promise`.
    auto promiseSetupFunc = [callInvoker, block, arguments](jsi::Runtime &runtime, std::shared_ptr<Promise> promise) {
      expo::callPromiseSetupWithBlock(runtime, callInvoker, promise, ^(RCTPromiseResolveBlock resolver, RCTPromiseRejectBlock rejecter) {
        block(arguments, resolver, rejecter);
      });
    };

    return createPromiseAsJSIValue(runtime, promiseSetupFunc);
  });

  _object->setProperty(*runtime, [key UTF8String], jsiFn);
}

@end
