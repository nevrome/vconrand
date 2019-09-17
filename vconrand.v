module vconrand

import rand
import math

pub fn runif(min f64, max f64) f64 {

  range := max - min
  div := f64(C.RAND_MAX) / range
  res := min + (f64(rand.next(C.RAND_MAX)) / div)

  return res
}

pub fn runif_n(n int, min f64, max f64) []f64 {

  mut res := [f64(0)].repeat(n)
  for i := 0; i < n; i++ {
    res[i] = runif(min, max)
  }

  return res
}

// Box Muller
pub fn rnorm(mean f64, sd f64) f64 {

  mut x := 0.0
  mut y := 0.0
  mut r := 0.0

  for {
    x = 2.0 * f64(rand.next(C.RAND_MAX)) / f64(C.RAND_MAX - 1)
    y = 2.0 * f64(rand.next(C.RAND_MAX)) / f64(C.RAND_MAX - 1)
    r = x * x + y * y

    if (r != 0.0 && r <= 1.0) {
      break
    }
  }

  d := math.sqrt(-2.0 * math.log(r) / r)
  n1 := x * d
  //n2 := y * d
  res := n1 * sd + mean

  return res
}
