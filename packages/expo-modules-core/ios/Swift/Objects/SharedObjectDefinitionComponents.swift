
extension AnySharedObject {
  public static func name(_ name: String) -> AnyDefinition {
    return ModuleNameDefinition(name: name)
  }

  public static func constructor(_ closure: @escaping () -> Void) -> AnyMethod {
    return ConcreteMethod("constructor", argTypes: [], closure)
  }

  public static func method<R>(
    _ name: String,
    _ closure: @escaping (Self) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [],
      closure
    )
  }

  public static func method<R, A0: AnyMethodArgument>(
    _ name: String,
    _ closure: @escaping (Self, A0) -> R
  ) -> AnyMethod {
    return ConcreteMethod(
      name,
      argTypes: [AnyArgumentType(A0.self)],
      closure
    )
  }
}
