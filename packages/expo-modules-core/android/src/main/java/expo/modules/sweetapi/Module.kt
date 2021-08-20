package expo.modules.sweetapi



interface Module {
  fun definition(): ModuleDefinition

  fun module(block: ModuleDefinition.() -> Unit): ModuleDefinition {
    return ModuleDefinition().also(block)
  }
}