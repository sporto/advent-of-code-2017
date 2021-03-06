use "collections"

primitive Fns
  fun inputs1(): Array[(U32, U32)] =>
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

  fun inputs2(): Array[(U32, U32)] =>
    [
      (0, 3)
      (1, 2)
      (4, 4)
      (6, 4)
    ]

  fun inputAsMap(inputsToUse: Array[(U32, U32)]): Map[U32, U32] =>
    var layerMap = Map[U32, U32]

    for input in inputsToUse.values() do
      (let l, let r) = input
      layerMap.update(l, r)
    end

    layerMap

  fun getPosition(range: U32, tick: U32): U32 =>
    var count: U32 = 0
    var mov: U32 = 1
    var pos: U32 = -1
    let max = range - 1

    while count <= tick do
      pos = pos + mov

      mov = if pos >= max then
        -1
      elseif pos <= 0 then
        1
      else
        mov
      end

      count = count + 1
    end

    pos

  fun scenario(env: Env, layerMap: Map[U32, U32], startTick: U32): U32 =>
    // env.out.print("startTick " +  startTick.string())
    var tick = startTick
    var layer : U32 = 0
    var score : U32 = 0

    while layer <= 100 do
      let range = layerMap.get_or_else(layer, 0)
      // env.out.print("range " +  range.string())

      if range > 0 then
        let pos = Fns.getPosition(range, tick)
        // env.out.print("layer " + layer.string())
        // env.out.print("pos" + pos.string())

        if pos == 0 then
          let severity = layer * range
          score = score + severity
        end
      end

      layer = layer + 1
      tick = tick + 1
    end

    score

  fun part1(env: Env) =>
    let layerMap = inputAsMap(inputs2())
    let score = scenario(env, layerMap, 4)
    env.out.print(score.string())

  fun part2(env: Env) =>
    let layerMap = inputAsMap(inputs1())
    var score : U32 = 1
    var tick : U32 = 0

    while (score > 0) and (tick < 10000) do
      score = scenario(env, layerMap, tick)

      env.out.print("tick " + tick.string())
      env.out.print("score " + score.string())

      tick = tick + 1
    end

    env.out.print((tick - 1).string())


actor Main
  new create(env: Env) =>
    Fns.part2(env)