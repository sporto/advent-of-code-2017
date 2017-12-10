inputLengths = [list: 225,171,131,2,35,5,0,13,1,246,54,97,255,98,254, 110]
numbers = range(0, 256)

# inputLengths = [list: 3, 4, 1, 5] 
# numbers = range(0, 5)


type Accumulator =
  {
    list :: List<NumInteger>,
    skipSize :: NumInteger,
    currentPosition :: NumInteger,
  }

fun aggregate(num :: NumInteger, acc :: Accumulator ) -> Accumulator:
  var len = acc.list.length()
  
  var list2 = acc.list.drop(acc.currentPosition) + acc.list.take(acc.currentPosition)
  
  var section = list2.take(num).reverse()
  var tail = list2.drop(num)
  var complete = section + tail
  
  var corrected =  complete.drop(len - acc.currentPosition) + complete.take(len - acc.currentPosition)
  
  var currentPosition = num-modulo(acc.currentPosition + num + acc.skipSize, len)
  
  {
    list : corrected,
    skipSize  : acc.skipSize + 1,
    currentPosition : currentPosition,
  }
end

initial = {
  list: numbers,
  skipSize : 0,
  currentPosition : 0
}

processed = inputLengths.foldl(aggregate, initial)

processed

processed.list.take(2).foldl(lam(acc, n): acc * n end, 1)