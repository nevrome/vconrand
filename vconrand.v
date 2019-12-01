module vconrand

import rand
import math

/**
 * ###########################
 * ########## runif ##########
 * ###########################
 */

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
 * ###########################
 * ########## rnorm ##########
 * ###########################
 */

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

/**
 * ###########################
 * ########## rarb ###########
 * ###########################
 */


/**
 * rarb_int - random number selector with an arbitrary distribution
 *
 * Returns a random number from arr[] according to the
 * distribution array defined by freq[]. The code was translated from
 * https://www.geeksforgeeks.org/random-number-generator-in-arbitrary-probability-distribution-fashion
 *
 * @param arr[] array from which the output numbers are selected
 * @param freq[] array of the same length n as arr[] that assigns a probability to that value
 *
 * @return a random value sampled from arr[] based on the distribution in freq[]
 */
pub fn rarb_int(arr[] int, freq[] int) int {
    // get length
    l := arr.len
		// Create and fill prefix array
    mut prefix := [0].repeat(l)
    prefix[0] = freq[0]
    for i := 1; i < l; i++ {
        prefix[i] = prefix[i - 1] + freq[i]
    }
    // prefix[n-1] is sum of all frequencies. Generate a random number
    // with value from 1 to this sum
    r := (rand.next(prefix[l - 1])) + 1
    // Find index of ceiling of r in prefix array
    indexc := find_ceil(prefix, r, 0, l - 1)
    return arr[indexc]
}

// Utility function to find ceiling of r in arr[l..h]
fn find_ceil(arr[] int, r int, l int, h int) int {
		mut mid := 0
		mut le := l
		mut he := h
		for {
			mid = (le + he) / 2
			if r > arr[mid] { le = mid + 1 }  else { he = mid }
			if !(le < he) { break }
		}
		mut res := 0
		if arr[le] >= r { res = le } else { res = -1 }
    return res
}

/**
 * rarb_int_n - rarb_int but for an array of random values
 *
 * Uses rarb_int.
 *
 * @param n length of the resulting array
 * @param arr[] array from which the output numbers are selected
 * @param freq[] array of the same length n as arr[] that assigns a probability to that value
 *
 * @return an array of random values sampled from from arr[] based on the distribution in freq[]
 */
pub fn rarb_int_n(n int, arr[] int, freq[] int) []int {

  mut res := [0].repeat(n)
  for i := 0; i < n; i++ {
    res[i] = rarb_int(arr, freq)
  }

  return res
}

/**
 * ############################
 * ########## sample ##########
 * ############################
 */

pub fn sample<T>(arr[] T, size int) []T {

  mut res := [arr[1]].repeat(size)
  for i := 0; i < size; i++ {
    res[i] = arr[rand.next(arr.len)]
  }

  return res

}
