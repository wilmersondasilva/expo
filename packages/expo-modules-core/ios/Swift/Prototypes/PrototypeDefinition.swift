/**
 The definition of the JavaScript prototype.
 Basically it's like an object but with associated `SharedObject` type.
 */
public class PrototypeDefinition: ObjectDefinition {
  /**
   The shared object type associated with the prototype.
   */
  let sharedObjectType: AnySharedObject.Type

  /**
   Returns the constructor method that is invoked when the prototype instance is created in JavaScript.
   */
  var constructor: AnyMethod? {
    return methods.first(where: { $0.value.name == "constructor" })?.value
  }

  /**
   Initializes the prototype definition with associated shared object type.
   */
  init(sharedObjectType: AnySharedObject.Type, components: [AnyDefinition]) {
    self.sharedObjectType = sharedObjectType

    super.init(components: components)
  }
}
