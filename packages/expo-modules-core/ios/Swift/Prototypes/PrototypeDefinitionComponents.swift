/// These are the components that take part of the `PrototypeDefinition` and that can be used within `prototype(:)` component
/// aside from these that are allowed to be used in all object types (see `ObjectDefinitionComponents`).

/**
 Creates the prototype definition that scopes other prototype-related definitions.
 */
public func prototype<SharedObjectType: SharedObject>(_ sharedObjectType: SharedObjectType.Type, @PrototypeDefinitionBuilder<SharedObjectType> _ body: () -> PrototypeDefinition) -> PrototypeDefinition {
  #warning("Prototypes are not fully implemented yet. Use at your own risk.")
  return body()
}

/**
 Component specifying prototype's constructor without any arguments.
 */
public func constructor(_ closure: @escaping () -> AnySharedObject) -> AnyDefinition {
  return ConcreteMethod("constructor", argTypes: [], closure)
}

/**
 Component specifying prototype's constructor with one argument.
 */
public func constructor<A0: AnyMethodArgument>(
  _ body: @escaping (A0) -> AnySharedObject
) -> AnyDefinition {
  return ConcreteMethod(
    "constructor",
    argTypes: [AnyArgumentType(A0.self)],
    body
  )
}

// TODO: @tsapeta: Add more generics for `constructor`. Ideally if we can support more than one constructor.
