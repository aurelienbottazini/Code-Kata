def merge_sort(array)
  return array if array.size <= 1
  array_size = array.size
  left = merge_sort array[0, array_size / 2]
  right = merge_sort array[array_size / 2, array_size]

  merge_and_count_inv(left, right)
end

@inversions = 0
def merge_and_count_inv(first_array, second_array)
  first_array_size = first_array.size
  second_array_size =  second_array.size
  merged_array_size = first_array_size + second_array_size
  merged_array = []
  k = i = j = 0

  while k < merged_array_size
    copy_i = false

    if i == first_array_size
    elsif j == second_array_size
      copy_i = true
    else
      copy_i = true if first_array[i] < second_array[j]
    end

    if copy_i
      merged_array[k] = first_array[i]
      i += 1
    else
      merged_array[k] = second_array[j]
      @inversions += first_array_size - i
      j += 1
    end

    k += 1
  end

  merged_array
end

integers = File.open('./IntegerArray.txt', 'r').readlines.map(&:to_i)

merge_sort(integers)
p @inversions
