# This file (IntegerArray.txt) contains all of the 100,000 integers
# between 1 and 100,000 (inclusive) in some order, with no integer
# repeated. Your task is to compute the number of inversions in the
# file given, where the ith row of the file indicates the ith entry
# of an array. Because of the large size of this array, you should
# implement the fast divide-and-conquer algorithm covered in the
# video lectures

def merge_sort(array)
  return array if array.size <= 1
  left = merge_sort array[0, array.size / 2]
  right = merge_sort array[array.size / 2, array.size]

  merge_and_count_inv(left, right)
end


@inversions = 0
def merge_and_count_inv first_array, second_array
  first_array_size = first_array.size
  second_array_size =  second_array.size
  merged_array_size = first_array_size + second_array_size
  merged_array = Array.new
  k = i = j = 0
  while k < merged_array_size
    copy_i = false
    copy_j = false
    if i == first_array_size
      copy_j = true
    elsif j == second_array_size
      copy_i = true
    else
      if first_array[i] < second_array[j]
        copy_i = true
      else
        copy_j = true
      end
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

  return merged_array
end

integers = File.open("./IntegerArray.txt", "r").readlines.map(&:to_i)

merge_sort(integers)
p @inversions
