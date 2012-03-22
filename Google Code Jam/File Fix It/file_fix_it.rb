1.upto(gets.to_i) do |case_number|

  n, m = gets.split.map(&:to_i)

  existing_directories = Array.new
  1.upto(n) do
    existing_directories << gets.chomp
  end

  need_to_create_directories = Array.new
  1.upto(m) do
    need_to_create_directories << gets.chomp
  end


  mkdir_commands_needed = 0
  need_to_create_directories.each do |directory_path|

    if !existing_directories.include?(directory_path)

      directory_path_splitted = directory_path.split('/')

      test_path = String.new
      directory_path_splitted[1..-1].each do |d|
        test_path << "/#{d}"

        if !existing_directories.include?(test_path)
          mkdir_commands_needed += 1
          existing_directories << test_path.clone
        end

      end



    end
  end


  puts "Case ##{case_number}: #{mkdir_commands_needed}"
end
