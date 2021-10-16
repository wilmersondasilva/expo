import UIKit

/**
 Extends all modules with the functions used to build a module definition.
 Unfortunately they need to be scoped here, but hopefully this proposal
 https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md#builder-scoped-name-lookup
 will be implemented in the future.
 */
extension AnyModule {
  /**
   Creates module's lifecycle listener that is called right after module initialization.
   */
  public func onCreate(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleCreate, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the module is about to be deallocated.
   */
  public func onDestroy(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.moduleDestroy, closure)
  }

  /**
   Creates module's lifecycle listener that is called when the app context owning the module is about to be deallocated.
   */
  public func onAppContextDestroys(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appContextDestroys, closure)
  }

  /**
   Creates a listener that is called when the app is about to enter the foreground mode.
   */
  public func onAppEntersForeground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appEntersForeground, closure)
  }

  /**
   Creates a listener that is called when the app becomes active again.
   */
  public func onAppBecomesActive(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appBecomesActive, closure)
  }

  /**
   Creates a listener that is called when the app enters the background mode.
   */
  public func onAppEntersBackground(_ closure: @escaping () -> Void) -> AnyDefinition {
    return EventListener(.appEntersBackground, closure)
  }
}

// MARK: - View Managers

/**
 Creates the view manager definition that scopes other view-related definitions.
 */
public func viewManager(@ViewManagerDefinitionBuilder _ closure: () -> ViewManagerDefinition) -> AnyDefinition {
  return closure()
}

/**
 Defines the factory creating a native view when the module is used as a view.
 */
public func view(_ closure: @escaping () -> UIView) -> AnyDefinition {
  return ViewFactory(closure)
}

/**
 Creates a view prop that defines its name and setter.
 */
public func prop<ViewType: UIView, PropType>(_ name: String, _ setter: @escaping (ViewType, PropType) -> Void) -> AnyDefinition {
  return ConcreteViewProp(name, setter)
}
