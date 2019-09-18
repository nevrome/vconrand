import vconrand
import rand
import time
import math

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

  // arbitrary
  mut arr := [0].repeat(200)
	for i := 0; i < 200; i++ {
		arr[i] = i
	}
  mut freq := [0].repeat(200)
  for i := 0; i < 200; i++ {
    freq[i] = distribution_function(i)
  }
  println('vconrand.rarb_int(arr, freq) = ' +
    vconrand.rarb_int(arr, freq).str()
  )
  println('vconrand.rarb_int_n(5, arr, freq) = ' +
    vconrand.rarb_int_n(5, arr, freq).str()
  )

  // sample
  println('vconrand.sample_int(arr, 5) = ' +
    vconrand.sample_int(arr, 5).str()
  )

}

fn distribution_function(i int) int {
  x := f64(i)
  res := 10.0 * math.sin(0.1 * (x - 0.1)) + 10.0
  return int(math.round(res))
}
