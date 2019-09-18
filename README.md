# vconrand: Convenient random number generators for V
A collection of useful, simple random number generators and sampling methods. I wrote this to make it more easy to translate R simulation code to V.

## Installation
To install vconrand, you can use [VPM](https://github.com/yue-best-practices/vpm).

```bash
$ vpm init
$ vpm get https://github.com/nevrome/vconrand vconrand
```

## Examples

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

}
```
