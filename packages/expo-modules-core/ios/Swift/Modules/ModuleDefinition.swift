
/**
 A protocol that must be implemented to be a part of module's definition and the module definition itself.
 */
public protocol AnyDefinition {}

/**
 The definition of the module. It is used to define some parameters
 of the module and what it exports to the JavaScript world.
 See `ModuleDefinitionBuilder` for more details on how to create it.
 */
public class ModuleDefinition: ObjectDefinition {
  /**
   The module's type associated with the definition. It's used to create the module instance.
   */
  var type: AnyModule.Type?

  let eventListeners: [EventListener]
  let viewManager: ViewManagerDefinition?
  let prototypes: [PrototypeDefinition]

  /**
   Initializer that is called by the `ModuleDefinitionBuilder` results builder.
   */
  override init(components: [AnyDefinition]) {
    self.eventListeners = components.compactMap { $0 as? EventListener }

    self.viewManager = components
      .compactMap { $0 as? ViewManagerDefinition }
      .last

    self.prototypes = components
      .compactMap { $0 as? PrototypeDefinition }

    super.init(components: components)
  }

  /**
   Sets the module type that the definition is associated with. We can't pass this in the initializer
   as it's called by the results builder that doesn't have access to the type.
   */
  func withType(_ type: AnyModule.Type) -> Self {
    self.type = type

    // Use the type name if the name is not in the definition or was defined empty.
    if name.isEmpty {
      name = String(describing: type)
    }
    return self
  }
}

/**
 Module's name definition. Returned by `name()` in module's definition.
 */
internal struct ModuleNameDefinition: AnyDefinition {
  let name: String
}

/**
 A definition for module's constants. Returned by `constants(() -> SomeType)` in module's definition.
 */
internal struct ConstantsDefinition: AnyDefinition {
  let constants: [String : Any?]
}
