use "ponytest"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  new make() =>
    None

  fun tag tests(test: PonyTest) =>
    test(_TestGetPosition)

class iso _TestGetPosition is UnitTest
  fun name(): String => "Get Position"

  fun apply(h: TestHelper) =>
    let inputs : Array[(U32, U32, U32)] = [
      // range, tick, expected
      (1,       0,    0)

      (2,       0,    0)
      (2,       1,    1)
      (2,       2,    0)
      (2,      10,    0)

      (3,       2,    2)
      (3,       3,    1)
      (3,       4,    0)
      (3,       5,    1)
      (3,       6,    2)
      (3,       7,    1)
      (3,       8,    0)
      (3,       9,    1)
      (3,      10,    2)

      (4,      10,    2)
      (4,      11,    1)
      (4,      16,    2)
    ]

    for input in inputs.values() do
      (let range, let tick, let expected) = input
      let actual = Fns.getPosition(range, tick)
      h.assert_eq[U32](actual, expected)
    end

