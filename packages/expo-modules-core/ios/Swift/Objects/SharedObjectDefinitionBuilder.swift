
#if swift(>=5.4)
@resultBuilder
public struct SharedObjectDefinitionBuilder {
  public static func buildBlock(_ definitions: AnyDefinition...) -> SharedObjectDefinition {
    return SharedObjectDefinition(definitions: definitions)
  }
}
#endif
