1.upto(gets.to_i) do |case_number|
  first_answer = gets.to_i
  first_arrangement = Array.new
  0.upto(3) do
    first_arrangement << gets.split(' ').map(&:to_i)
  end

  second_answer = gets.to_i
  second_arrangement = Array.new
  0.upto(3) do
    second_arrangement << gets.split(' ').map(&:to_i)
  end

  union = first_arrangement[first_answer-1] & second_arrangement[second_answer-1]
  answer = nil
  case union.size
  when 0
    answer = "Volunteer cheated!"
  when 1
    answer = union[0]
  when 1..4
    answer = "Bad magician!"
  end




  puts "Case ##{case_number}: #{answer}"
end
