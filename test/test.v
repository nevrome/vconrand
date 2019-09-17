module main

import vconrand
import rand
import time

fn main() {

  rand.seed(time.now().uni)

  println('vconrand.runif(384.12, 399.54) = ' +
    vconrand.runif(384.12, 399.54).str()
  )

  println('vconrand.runif_n(5, 384.12, 399.54) = ' +
    vconrand.runif_n(5, 384.12, 399.54).str()
  )

}
