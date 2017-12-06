fun getNextBank(list: ArrayList<Int>): Int {
    var maxIndex = 0
    var maxVal = 0 

   for ((index, value) in list.withIndex()) {
        if (value > maxVal) {
            maxIndex = index
            maxVal = value
        }
    }

    return maxIndex
}

fun distributeNextBlock(blocksToDistribute: Int, prevBlockUsed: Int, list: ArrayList<Int>): ArrayList<Int> {
    return when(blocksToDistribute) {
        0 ->
            list
        else -> {
            val position = if (prevBlockUsed == list.size - 1) {
                0
            } else {
                prevBlockUsed + 1
            }

            val newVal = list.get(position) + 1
            list.set(position, newVal) 
            distributeNextBlock(blocksToDistribute - 1, position, list)
        }
    }
}

fun distribute(count: Int, seen: HashMap<String, Int>, list: ArrayList<Int>): Int {
    val nextIndex = getNextBank(list)
    val blocksToDistribute = list[nextIndex]

    list.set(nextIndex, 0)

    val newList = distributeNextBlock(blocksToDistribute, nextIndex, list)

    val key = newList.joinToString("-")
    val seenIn = seen.get(key)

    println("seenIn $seenIn")

    if (seenIn == null) {
        seen.put(key, count)
        return distribute(count + 1, seen, newList)
    } else {
        return count - seenIn
    }
}

fun main(args: Array<String>) {
    val seen = hashMapOf("" to 1)
    // val input = arrayListOf(0, 2, 7, 0)
    val input = arrayListOf(2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14)

    val res = distribute(0, seen, input)

    println(res)
}