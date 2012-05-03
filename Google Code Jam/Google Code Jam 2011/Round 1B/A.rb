# -*- coding: utf-8 -*-
def debug text
  STDERR.puts text
end

1.upto(gets.to_i) do |case_number|

  n = gets.to_i

  match_results = Array.new(n)
  1.upto(n) do |i|
    match_results[i-1] = Array.new
    line = gets.chomp
    line.each_char do |char|
      if char == '.'
        char = -1
      else
        char = char.to_i
      end
      match_results[i-1] << char
    end
  end

  teams = Array.new(3)
  teams_stats = Array.new # [0] = played [1] = won
  #calculate wp
  0.upto(n-1) do |i|
    teams[i] = Array.new
    teams_stats[i] = Array.new
    games_won = 0.0
    games_played = 0.0
    match_results[i].each do |result|
      if result != -1
        games_played += 1
      end

      if result == 1
        games_won += 1
      end

    end
    teams_stats[i][0] = games_played
    teams_stats[i][1] = games_won
    teams[i][0] = games_won / games_played #wp
  end

  # owp
  0.upto(n-1) do |i|
    owp = 0.0
    opponents = 0
    0.upto(n-1) do |j|
      if i != j
        if match_results[j][i] != -1
          games_played = teams_stats[j][0] - 1
          games_won = teams_stats[j][1]

          if match_results[j][i] == 1
            games_won = games_won - 1
          end
          wp = games_won / games_played
          owp = owp + wp
          opponents += 1
        end
      end
    end

    teams[i][1] = owp / opponents #owp - wrong because it is average of all opponents
  end



  # oowp
  0.upto(n-1) do |i|
    oowp = 0.0
    opponents = 0
    0.upto(n-1) do |j|
      if j != i
        if match_results[j][i] != -1
          oowp = oowp + teams[j][1]
          opponents += 1
        end
      end
    end
    teams[i][2] = oowp / opponents
  end


  puts "Case ##{case_number}:"
  teams.each do |result|
    # RPI = 0.25 * WP + 0.50 * OWP + 0.25 * OOWP
    rpi = 0.25 * result[0] + 0.50 * result[1] + 0.25 * result[2]
    puts rpi
  end

  debug "Solved #{case_number}"
end
