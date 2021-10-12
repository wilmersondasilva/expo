
// Keep it the same as in `NativeSharedObject.h` where it's aliased from `NSUInteger`.
typealias SharedObjectId = UInt

@objc
class SharedObjectRegistry: NativeSharedObjectRegistry {
  var sharedObjects = [SharedObjectId: AnySharedObject]()

  override func invalidateObject(withId objectId: SharedObjectId) {
    super.invalidateObject(withId: objectId)
  }
}
