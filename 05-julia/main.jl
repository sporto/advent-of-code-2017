function toInt(n)
    parse(Int, n)
end

f = open("input.txt")
lines = readlines(f)
close(f)

nums = map(toInt, lines)
len = length(nums)
count = 0
index = 1

while index > 0 && index < len + 1
    move = nums[index]
    if move >= 3
        nums[index] = move - 1
    else
        nums[index] = move + 1
    end
    index += move
    count += 1
end

print(count)
