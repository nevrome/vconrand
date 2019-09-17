module vconrand

import rand

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
