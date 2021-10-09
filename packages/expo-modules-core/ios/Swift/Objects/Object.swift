
open class BaseObject {
  required public init() {}
}

public typealias Object = AnyHostObject & BaseObject & AnyMethodArgument

public class DemoModule: Module {
  public func definition() -> ModuleDefinition {
    name("DemoModule")

    method("createObject") {
      return DemoObject()
    }

    method("destroyObject") { (object: DemoObject) in
      object.destroy()
    }

    objects([DemoObject.self])
  }
}

public class DemoObject: Object {
  public static func definition() -> ObjectDefinition {
    name("DemoObject")

    constructor {
      print("new DemoObject() has been called in JS")
    }

    method("increment") { demoObject in
      demoObject.counter += 1
    }
  }

  var counter = 0

  func destroy() {
    print("Goodbye!")
  }
}

