
#if swift(>=5.4)
@resultBuilder
public struct ObjectDefinitionBuilder {
  public static func buildBlock(_ definitions: AnyDefinition...) -> ObjectDefinition {
    return ObjectDefinition(definitions: definitions)
  }
}
#endif
