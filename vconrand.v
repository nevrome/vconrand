module vconrand

import rand
import math

/**
 * runif - random number generator with an uniform distribution
 *
 * The implemented solution most likely does not cover the full range
 * of precision of f64, because it is limited to INT_MAX possible
 * values.
 *
 * @param min lower limit of the distribution
 * @param max upper limit of the distribution
 *
 * @return a random value between min and max
 */
pub fn runif(min f64, max f64) f64 {

  range := max - min
  div := f64(C.RAND_MAX) / range
  res := min + (f64(rand.next(C.RAND_MAX)) / div)

  return res
}

/**
 * runif_n - runif but for an array of random values
 *
 * Uses runif and therefore has the same precision issue.
 *
 * @param n length of the resulting array
 * @param min lower limit of the distribution
 * @param max upper limit of the distribution
 *
 * @return an array of random values between min and max
 */
pub fn runif_n(n int, min f64, max f64) []f64 {

  mut res := [f64(0)].repeat(n)
  for i := 0; i < n; i++ {
    res[i] = runif(min, max)
  }

  return res
}

/**
 * rnorm - random number generator with a normal distribution
 *
 * Uses the Box Muller transform algorithm to get normally distributed
 * random numbers from the uniform rand.next().
 *
 * @param mean mean of the underlying normal distribution
 * @param sd standard deviation of the underlying normal distribution
 *
 * @return a random value sampled from the defined normal distribution
 */
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

/**
 * rnorm_n - rnorm but for an array of random values
 *
 * Uses rnorm.
 *
 * @param n length of the resulting array
 * @param mean mean of the underlying normal distribution
 * @param sd standard deviation of the underlying normal distribution
 *
 * @return an array of random values sampled from the defined normal distribution
 */
pub fn rnorm_n(n int, mean f64, sd f64) []f64 {

  mut res := [f64(0)].repeat(n)
  for i := 0; i < n; i++ {
    res[i] = rnorm(mean, sd)
  }

  return res
}
