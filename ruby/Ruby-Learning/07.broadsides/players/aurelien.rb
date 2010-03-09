require 'logger'
file = File.open("./log/aurelien.log", File::WRONLY | File::APPEND | File::CREAT)
logger = Logger.new(file)
logger.level = Logger::INFO

$stdout.sync = true

shots = (1..10).map { |y| ("A".."J").map { |x| "#{x}#{y}" } }.flatten.
  sort_by { rand }

ARGF.each_line do |line|
  case line
  when /\AINFO SETUP (.*)/
    logger.info $1
  when /\AINFO SHOTS (.*)/         # shots results
    logger.info $1
  when /\AINFO WINNER (.*)/
    logger.info $1
  when /\AACTION SHIPS\b/       # ship placement
    puts "SHIPS 5:A1:H 4:A2:H 3:A3:H 3:A4:H 2:A5:H"
  when /\AACTION SHOTS (\d)/    # asking us to shoot - nbr of shoots
    # as argument
    targets = (1..$1.to_i).map {
      target = shots.shift
      shots.push(target)
      target
    }
    puts "SHOTS #{targets.join(' ')}"
  when /\AACTION FINISH\b/      # game ending, 20 seconds to closing gracefully
    puts "FINISH"
  end
end

logger.close
