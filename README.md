[![Build Status](https://www.travis-ci.org/nevrome/vconrand.svg?branch=master)](https://www.travis-ci.org/nevrome/vconrand)

# vconrand: Convenient random number generators for V
A collection of useful, simple random number generators and sampling methods. I wrote this to make it more easy to translate R simulation code to V.

## Installation
To install vconrand, you can use [VPM](https://github.com/yue-best-practices/vpm).

```bash
$ vpm init
$ vpm get https://github.com/nevrome/vconrand vconrand
```

## Quickstart

```v
import vconrand
import rand
import time

fn main() {

  rand.seed(time.now().uni)

  // random number from a uniform distribution
  vconrand.runif(384.12, 399.54)
  vconrand.runif_n(5, 384.12, 399.54)

  // random number from a normal distribution
  vconrand.rnorm(14.81, 2.73)
  vconrand.rnorm_n(5, 14.81, 2.73)

  // random integer from an arbitrary distribution
  mut arr := [0].repeat(200)
	for i := 0; i < 200; i++ {
		arr[i] = i
	}
  mut freq := [0].repeat(200)
  for i := 0; i < 200; i++ {
    freq[i] = distribution_function(i)
  }
  vconrand.rarb_int(arr, freq).str()
  vconrand.rarb_int_n(5, arr, freq).str()

}

fn distribution_function(i int) int {
  x := f64(i)
  res := 10.0 * math.sin(0.1 * (x - 0.1)) + 10.0
  return int(math.round(res))
}
```

See `test/test.v` for some code that shows every function.
