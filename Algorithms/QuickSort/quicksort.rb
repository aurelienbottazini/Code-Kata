@comparisons = 0

def quicksort(array, start_index, end_index, pivot_mode)
  if start_index < end_index
    pivot_index = 0
    case pivot_mode
    when 0
      pivot_index = start_index
    when 1
      pivot_index = end_index
    else
      pivot_index = find_median_index(array, start_index, end_index)
    end

    array[start_index],
    array[pivot_index] = array[pivot_index], array[start_index]

    @comparisons += end_index - start_index
    pivot_index = partition(array, start_index, start_index, end_index)
    quicksort(array, start_index, pivot_index - 1, pivot_mode)
    quicksort(array, pivot_index + 1, end_index, pivot_mode)
  end
  array
end

def find_median_index(array, start_index, last_index)
  middle = array[(start_index + last_index) / 2]
  start = array[start_index]
  last = array[last_index]

  median = [start, last, middle].sort[1]
  if median == start
    return start_index
  elsif median == middle
    return (start_index + last_index) / 2
  else
    return last_index
  end
end

def partition(array, pivot_index, start_index, end_index)
  pivot = array[pivot_index]
  i = j = start_index + 1
  while j <= end_index
    if array[j] < pivot
      array[j], array[i] = array[i], array[j]
      i += 1
    end
    j += 1
  end

  array[pivot_index], array[i -1] = array[i - 1], array[pivot_index]

  i - 1
end

integers = File.open('./QuickSort.txt', 'r').readlines.map(&:to_i)
quicksort(integers.clone, 0, integers.size - 1, 0)
p @comparisons
@comparisons = 0
quicksort(integers.clone, 0, integers.size - 1, 1)
p @comparisons
@comparisons = 0
quicksort(integers.clone, 0, integers.size - 1, 2)
p @comparisons
