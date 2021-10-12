// Copyright 2018-present 650 Industries. All rights reserved.

#import <unordered_map>
#import <functional>

#import <ExpoModulesCore/NativeSharedObject.h>
#import <ExpoModulesCore/NativeSharedObjectRegistry.h>

using namespace expo;
using namespace facebook;

@interface JSIRuntime (WithNativeRuntime)
- (jsi::Runtime *)runtime;
@end

@implementation NativeSharedObjectRegistry {
  jsi::Runtime *_runtime;
  std::unordered_map<SharedObjectId, NativeSharedObject *> _registry;
  std::function<void(SharedObjectId)> _invalidator;
}

- (instancetype)initWithRuntime:(JSIRuntime *)runtime
{
  if (self = [super init]) {
    _runtime = [runtime runtime];
    _invalidator = ^(SharedObjectId objectId){
      _registry.erase(objectId);
    };
  }
  return self;
}

- (void)createNativeSharedObject:(SharedObjectId)objectId
{
  NativeSharedObject *object = new NativeSharedObject(*_runtime, objectId, _invalidator);
  _registry[objectId] = object;
}

- (void)invalidateObjectWithId:(SharedObjectId)objectId
{
  _registry.erase(objectId);
}

@end
