/**
 The definition of the JavaScript prototype.
 */
public class PrototypeDefinition: ObjectDefinition {
  let sharedObjectType: AnySharedObject.Type

  var constructor: AnyMethod? {
    return methods.first(where: { $0.value.name == "constructor" })?.value
  }

  init(sharedObjectType: AnySharedObject.Type, components: [AnyDefinition]) {
    self.sharedObjectType = sharedObjectType

    super.init(components: components)
  }
}
