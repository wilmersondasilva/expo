
public struct ObjectDefinition: AnyDefinition {
  let name: String?
  let methods: [String: AnyMethod]

  init(definitions: [AnyDefinition]) {
    self.name = definitions
      .compactMap { $0 as? ModuleNameDefinition }
      .last?
      .name

    self.methods = definitions
      .compactMap { $0 as? AnyMethod }
      .reduce(into: [String: AnyMethod]()) { dict, method in
        dict[method.name] = method
      }
  }
}
