import vconrand
import rand
import time

fn main() {

  rand.seed(time.now().uni)

  // unif
  println('vconrand.runif(384.12, 399.54) = ' +
    vconrand.runif(384.12, 399.54).str()
  )
  println('vconrand.runif_n(5, 384.12, 399.54) = ' +
    vconrand.runif_n(5, 384.12, 399.54).str()
  )

  // norm
  println('vconrand.rnorm(14.81, 2.73) = ' +
    vconrand.rnorm(14.81, 2.73).str()
  )
  println('vconrand.rnorm_n(5, 14.81, 2.73) = ' +
    vconrand.rnorm_n(5, 14.81, 2.73).str()
  )

}
