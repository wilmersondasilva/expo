
open class BaseSharedObject {
  required public init() {}
}

public typealias SharedObject = AnySharedObject & BaseSharedObject & AnyMethodArgument

public class DemoModule: Module {
  public func definition() -> ModuleDefinition {
    name("DemoModule")

    method("createObject") {
      return DemoObject()
    }

    method("destroyObject") { (object: DemoObject) in
      object.destroy()
    }

    prototype(DemoObject.self) {
      name("DemoObject")

      constructor {
        // `new DemoObject()` has been called in JS
        return DemoObject()
      }

      method("increment") { (demoObject: DemoObject) in
        demoObject.counter += 1
      }
    }
  }
}

public class DemoObject: SharedObject {
  var counter = 0

  func destroy() {
    print("Goodbye!")
  }
}
