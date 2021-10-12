
public class ObjectDefinition: AnyDefinition {
  /**
   Name of the object. Can be an empty string if not provided in the definition.
   */
  var name: String

  /**
   Dictionary with all methods defined by the object.
   */
  let methods: [String: AnyMethod]

  /**
   Dictionary with all constants defined by the object.
   */
  let constants: [String: Any?]

  init(components: [AnyDefinition]) {
    self.name = components
      .compactMap { $0 as? ModuleNameDefinition }
      .last?
      .name ?? ""

    self.methods = components
      .compactMap { $0 as? AnyMethod }
      .reduce(into: [String: AnyMethod]()) { dict, method in
        dict[method.name] = method
      }

    self.constants = components
      .compactMap { $0 as? ConstantsDefinition }
      .reduce(into: [String: Any?]()) { dict, definition in
        dict.merge(definition.constants) { $1 }
      }
  }
}
