/// This file specifies all definition components belonging to all kind of objects (raw object, module, prototype).
/// `method` function needs to be implemented for each number of arguments separately
/// so we can keep the informations of the type of each argument.

/**
 Sets the name of the module that is exported to the JavaScript world.
 */
public func name(_ name: String) -> AnyDefinition {
  return ModuleNameDefinition(name: name)
}

// MARK: - Constants

/**
 Definition function setting the module's constants to export.
 */
public func constants(_ closure: () -> [String : Any?]) -> AnyDefinition {
  return ConstantsDefinition(constants: closure())
}

// MARK: - Methods

/**
 Factory function for methods without arguments.
 */
public func method<R>(
  _ name: String,
  _ closure: @escaping () -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [],
    closure
  )
}

/**
 Factory function for methods with one argument.
 */
public func method<R, A0: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self)],
    closure
  )
}

/**
 Factory function for methods with 2 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self)],
    closure
  )
}

/**
 Factory function for methods with 3 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self)],
    closure
  )
}

/**
 Factory function for methods with 4 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2, A3) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self)],
    closure
  )
}

/**
 Factory function for methods with 5 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2, A3, A4) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self)],
    closure
  )
}

/**
 Factory function for methods with 6 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2, A3, A4, A5) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self)],
    closure
  )
}

/**
 Factory function for methods with 7 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2, A3, A4, A5, A6) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self)],
    closure
  )
}

/**
 Factory function for methods with 8 arguments.
 */
public func method<R, A0: AnyMethodArgument, A1: AnyMethodArgument, A2: AnyMethodArgument, A3: AnyMethodArgument, A4: AnyMethodArgument, A5: AnyMethodArgument, A6: AnyMethodArgument, A7: AnyMethodArgument>(
  _ name: String,
  _ closure: @escaping (A0, A1, A2, A3, A4, A5, A6, A7) -> R
) -> AnyMethod {
  return ConcreteMethod(
    name,
    argTypes: [AnyArgumentType(A0.self), AnyArgumentType(A1.self), AnyArgumentType(A2.self), AnyArgumentType(A3.self), AnyArgumentType(A4.self), AnyArgumentType(A5.self), AnyArgumentType(A6.self), AnyArgumentType(A7.self)],
    closure
  )
}
