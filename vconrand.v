module vconrand

import rand
import time

pub fn runif(min f64, max f64) f64 {

  rand.seed(time.now().uni)

  range := max - min
  div := f64(C.RAND_MAX) / range
  res := min + (f64(rand.next(C.RAND_MAX)) / div)

  return res

}
