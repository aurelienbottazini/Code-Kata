def debug text
  STDERR.puts text
end

def all_working_lists_have_size_of_1? working_list

  working_list.each do |l|
    if l[1].size != 1
      return false
    end
  end
  return true
end

def find_best_answer_for_list list
  best_answer = String.new
  top_score = -1
  list.each do |l|

    if l[0] > top_score
      top_score = l[0]
      best_answer = l[1]
    end
  end

  [top_score, best_answer]
end

def add_to_subdivided_list list, letter_indexes, word, score

  if list[letter_indexes] == nil
    list[letter_indexes] = [score, [word]]
  else
    new_words = list[letter_indexes][1]
    new_words << word
    list[letter_indexes] = [score, new_words]
  end

  list
end


def subdivide_list_for_letter working_list, letter
  subdivided_lists = Hash.new

  score = working_list[0]
  words = working_list[1]

  words.each do |word|
    letter_indexes = (0 .. word.length - 1).find_all { |i| word[i,1] == letter }

    if letter_indexes.size > 0
      subdivided_lists = add_to_subdivided_list(Marshal.load(Marshal.dump(subdivided_lists)), letter_indexes, word, score)
    else
      subdivided_lists = add_to_subdivided_list(Marshal.load(Marshal.dump(subdivided_lists)), letter_indexes, word, score + 1)
    end


  end

  subdivided_lists.map { |element| element[1]}
end

def letter_is_present_in_at_least_1_word? working_list, letter

  working_list[1].each do |l|
    if l.index(letter)
      return true
    end
  end

  return false
end

1.upto(gets.to_i) do |case_number|

  n, m = gets.split.map(&:to_i)
  words_lists = Hash.new { |hash, key| hash[key] = Array.new }
  @plain_words = Array.new
  1.upto(n) do
    word = gets.chomp
    @plain_words << word
    words_lists[word.size] << word
  end

  l = Array.new
  1.upto(m) do
    l << gets.chomp
  end


  case_answers = Array.new
  l.each do |letters|
    answers = Array.new

    words_lists.each do |words|

      working_lists = [[0, Marshal.load(Marshal.dump(words[1]))]]

      letters.each_char do |letter|
        if all_working_lists_have_size_of_1?(working_lists)
          break
        end

        new_working_lists = Array.new
        working_lists.each_with_index do |working_list, index|
          if letter_is_present_in_at_least_1_word?(working_list, letter)
            divided_lists = subdivide_list_for_letter(Marshal.load(Marshal.dump(working_list)), letter)
            divided_lists.each do |l|
              new_working_lists << l
            end
          else
            new_working_lists << working_list
          end

        end
        working_lists = new_working_lists
      end

      answers << find_best_answer_for_list(working_lists)
    end

    top_score = 0
    answers.each do |answer|
      score =  answer[0]
      if top_score < score
        top_score = score
      end
    end

    answers =  answers.reject { |x| x[0] != top_score }

    last_index = 99999
    case_answer = String.new

    answers.map {|e| e[1][0] }.each do |answer|
      current_index = @plain_words.index(answer)
      if current_index < last_index
        case_answer = answer
      end

      last_index = current_index
    end
    case_answers << case_answer
  end

  final_answer = case_answers.join(' ')

  puts "Case ##{case_number}: #{final_answer}"
  debug "Solved #{case_number}"
end
