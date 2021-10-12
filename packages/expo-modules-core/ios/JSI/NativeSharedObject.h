// Copyright 2018-present 650 Industries. All rights reserved.

typedef NSUInteger SharedObjectId;

#ifdef __cplusplus

#import <jsi/jsi.h>

using namespace facebook;

namespace expo {

class JSI_EXPORT NativeSharedObject : public jsi::Object {
private:
  SharedObjectId objectId;
  std::function<void(SharedObjectId)> invalidator;

public:
  NativeSharedObject(jsi::Runtime &runtime, SharedObjectId objectId, std::function<void(SharedObjectId)> invalidator)
    : jsi::Object(runtime), objectId(objectId), invalidator(invalidator) {};

protected:
  ~NativeSharedObject() {
    invalidator(objectId);
  };
};

}

#endif
