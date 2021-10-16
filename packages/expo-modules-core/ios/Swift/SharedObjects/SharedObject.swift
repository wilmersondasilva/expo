/**
 Base version of the shared object that makes sure the object can be initialized without arguments.
 */
open class BaseSharedObject {
  required public init() {}
}

/**
 Shared object base class that joins the base implementation and protocol requirements.
 */
public typealias SharedObject = AnySharedObject & BaseSharedObject & AnyMethodArgument
