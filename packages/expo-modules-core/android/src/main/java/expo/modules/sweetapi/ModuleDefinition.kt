package expo.modules.sweetapi

class ModuleDefinition {
  var name = "This module has no name. Please provide the unique name for this module."
  var constants = emptyMap<String, Any?>()
  val methods = mutableMapOf<String, Method>()

  infix fun name(name: String) {
    this.name = name
  }

  infix fun constants(value: () -> Map<String, Any?>) {
    constants = value()
  }

  inline fun method(
    name: String,
    crossinline body: () -> Unit
  ) {
    methods[name] = Method(name) { body() }
  }

  inline fun <reified P0> method(
    name: String,
    crossinline body: (p0: P0) -> Unit
  ) {
    methods[name] = Method(name) { body(it[0] as P0) }
  }

  inline fun <reified P0, reified P1>method(
    name: String,
    crossinline body: (p0: P0, p1: P1) -> Unit
  ) {
    methods[name] = Method(name) { body(it[0] as P0, it[1] as P1) }
  }

  inline fun <reified P0, reified P1, reified P2>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2) -> Unit
  ) {
    methods[name] = Method(name) { body(it[0] as P0, it[1] as P1, it[2] as P2) }
  }

  inline fun <reified P0, reified P1, reified P2, reified P3>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2, p3: P3) -> Unit
  ) {
    methods[name] = Method(name) { body(it[0] as P0, it[1] as P1, it[2] as P2, it[3] as P3) }
  }

  inline fun <reified P0, reified P1, reified P2, reified P3, reified P4>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2, p3: P3, p4: P4) -> Unit
  ) {
    methods[name] = Method(name) {
      body(it[0] as P0, it[1] as P1, it[2] as P2, it[3] as P3, it[4] as P4)
    }
  }

  inline fun <reified P0, reified P1, reified P2, reified P3, reified P4, reified P5>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2, p3: P3, p4: P4, p5: P5) -> Unit
  ) {
    methods[name] = Method(name) {
      body(it[0] as P0, it[1] as P1, it[2] as P2, it[3] as P3, it[4] as P4, it[5] as P5)
    }
  }

  inline fun <reified P0, reified P1, reified P2, reified P3, reified P4, reified P5, reified P6>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2, p3: P3, p4: P4, p5: P5, p6: P6) -> Unit
  ) {
    methods[name] = Method(name) {
      body(it[0] as P0, it[1] as P1, it[2] as P2, it[3] as P3, it[4] as P4, it[5] as P5, it[6] as P6)
    }
  }


  inline fun <reified P0, reified P1, reified P2, reified P3, reified P4, reified P5, reified P6, reified P7>method(
    name: String,
    crossinline body: (p0: P0, p1: P1, p2: P2, p3: P3, p4: P4, p5: P5, p6: P6, p7: P7) -> Unit
  ) {
    methods[name] = Method(name) {
      body(it[0] as P0, it[1] as P1, it[2] as P2, it[3] as P3, it[4] as P4, it[5] as P5, it[6] as P6, it[7] as P7)
    }
  }
}