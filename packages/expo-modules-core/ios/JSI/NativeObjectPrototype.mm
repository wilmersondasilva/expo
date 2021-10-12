// Copyright 2018-present 650 Industries. All rights reserved.

#import <sstream>

#import <ExpoModulesCore/JSIObject.h>
#import <ExpoModulesCore/NativeObjectPrototype.h>

@implementation NativeObjectPrototype {
  std::shared_ptr<jsi::Function> _constructor;
}

- (instancetype)initWithRuntime:(std::shared_ptr<jsi::Runtime>)runtime
                    callInvoker:(std::shared_ptr<react::CallInvoker>)callInvoker
                      className:(nonnull NSString *)className
{
  std::shared_ptr<jsi::Function> constructor = [NativeObjectPrototype createConstructor:className inRuntime:runtime];
  std::shared_ptr<jsi::Object> prototype = [NativeObjectPrototype createPrototypeForConstructor:constructor inRuntime:runtime];

  if (self = [super initFrom:prototype withRuntime:runtime callInvoker:callInvoker]) {
    _constructor = constructor;
    _className = className;
  }
  return self;
}

/**
 Creates a new object by calling the prototype's constructor.
 */
- (nonnull JSIObject *)makeObject
{
  auto runtime = self.runtime.lock();

  if (!runtime) {
    @throw [NSException exceptionWithName:@"ERR_RUNTIME_POINTER_EXPIRED" reason:@"Weak smart pointer to `jsi::Runtime` has expired." userInfo:nil];
  }
  auto object = std::make_shared<jsi::Object>(_constructor->callAsConstructor(*runtime).asObject(*runtime));
  return [[JSIObject alloc] initFrom:object withRuntime:runtime callInvoker:self.callInvoker];
}

#pragma mark: Creating constructor and its prototype

+ (std::shared_ptr<jsi::Function>)createConstructor:(nonnull NSString *)name inRuntime:(std::shared_ptr<jsi::Runtime>)runtime
{
  // Get C-string of the class name.
  const char *className = [name UTF8String];

  // Create a string buffer of the source code to evaluate.
  std::stringstream source;
  source << "function " << className << "() { return this; };" << className << ";";
  std::shared_ptr<jsi::StringBuffer> sourceBuffer = std::make_shared<jsi::StringBuffer>(source.str());

  // Evaluate the code and obtain returned value (the constructor function).
  jsi::Value evaluationResult = runtime->evaluateJavaScript(sourceBuffer, "");
  return std::make_shared<jsi::Function>(evaluationResult.asObject(*runtime).asFunction(*runtime));
}

+ (std::shared_ptr<jsi::Object>)createPrototypeForConstructor:(std::shared_ptr<jsi::Function>)constructor inRuntime:(std::shared_ptr<jsi::Runtime>)runtime
{
  std::shared_ptr<jsi::Object> prototype = std::make_shared<jsi::Object>(*runtime);
  constructor->setProperty(*runtime, "prototype", *prototype);
  return prototype;
}

@end
