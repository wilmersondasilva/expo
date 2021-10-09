
public protocol AnyHostObject: AnyObject {
  #if swift(>=5.4)
  @ObjectDefinitionBuilder
  static func definition() -> ObjectDefinition
  #else
  static func definition() -> ObjectDefinition
  #endif
}
