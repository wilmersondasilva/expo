// Copyright 2018-present 650 Industries. All rights reserved.

#ifdef __cplusplus

#import <vector>
#import <jsi/jsi.h>
#import <ExpoModulesCore/JSIRuntime.h>

#if __has_include(<ExpoModulesCore/ExpoModulesCore-Swift.h>)
// When `use_frameworks!` is used in the Podfile, the generated Swift header is not local.
#import <ExpoModulesCore/ExpoModulesCore-Swift.h>
#else
#import "ExpoModulesCore-Swift.h"
#endif

using namespace facebook;

namespace expo {

class JSI_EXPORT ExpoModulesHostObject : public jsi::HostObject {
public:
  ExpoModulesHostObject(SwiftInteropBridge *interopBridge);

  virtual ~ExpoModulesHostObject();

  virtual jsi::Value get(jsi::Runtime &, const jsi::PropNameID &name);

  virtual void set(jsi::Runtime &, const jsi::PropNameID &name, const jsi::Value &value);

  virtual std::vector<jsi::PropNameID> getPropertyNames(jsi::Runtime &rt);

private:
  SwiftInteropBridge *interopBridge;
}; // class ExpoModulesHostObject

} // namespace expo

#endif
