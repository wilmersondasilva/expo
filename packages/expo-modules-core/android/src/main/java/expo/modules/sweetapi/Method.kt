package expo.modules.sweetapi

class Method(
  private val name: String,
  private val body: (args: Array<out Any>) -> Unit
) {
}