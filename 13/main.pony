use "collections"

primitive Fns
  fun input(): Array[(I16, I16)] =>
    [
      (0, 3)
      (1, 2)
      (2, 4)
      (4, 6)
      (6, 4)
      (8, 6)
      (10, 5)
      (12, 6)
      (14, 8)
      (16, 8)
      (18, 8)
      (20, 6)
      (22, 12)
      (24, 8)
      (26, 8)
      (28, 10)
      (30, 9)
      (32, 12)
      (34, 8)
      (36, 12)
      (38, 12)
      (40, 12)
      (42, 14)
      (44, 14)
      (46, 12)
      (48, 12)
      (50, 12)
      (52, 12)
      (54, 14)
      (56, 12)
      (58, 14)
      (60, 14)
      (62, 14)
      (64, 14)
      (70, 10)
      (72, 14)
      (74, 14)
      (76, 14)
      (78, 14)
      (82, 14)
      (86, 17)
      (88, 18)
      (96, 26)
    ]

  fun getPosition(range: I16, tick: I16): I16 =>
    var count: I16 = 0
    var mov: I16 = 1
    var pos: I16 = -1
    let max = range - 1

    while count <= tick do
      pos = pos + mov
      if pos > max then
        pos = max - 1
        mov = -1
      end
      if pos < 0 then
        pos = 1
        mov = 1
      end
      count = count + 1
    end

    pos


actor Main
  new create(env: Env) =>
    var layerMap = Map[I16, I16]

    let inputs = Fns.input()

    for input in inputs.values() do
      (let l, let r) = input
      layerMap.update(l, r)
    end

    var tick : I16 = 0
    var score : I16 = 0

    while tick <= 100 do
      let range = layerMap.get_or_else(tick, 0)

      if range > 0 then
        let pos = Fns.getPosition(range, tick)
        // env.out.print(pos.string())

        if pos == 0 then
          let severity = tick * range
          score = score + severity
        end
      end

      tick = tick + 1
    end

    env.out.print(score.string())

    // env.out.print(layerMap.size().string())
    // env.out.print("Hello")

    