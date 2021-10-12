/**
 Result builder that creates a `PrototypeDefinition` from given components.
 */
@resultBuilder
public struct PrototypeDefinitionBuilder<SharedObjectType: SharedObject> {
  public static func buildBlock(_ components: AnyDefinition...) -> PrototypeDefinition {
    return PrototypeDefinition(sharedObjectType: SharedObjectType.self, components: components)
  }
}
