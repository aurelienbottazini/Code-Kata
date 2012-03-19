# Ruby 1.9.1 # pass input file as argument
def getis;gets.split.map(&:to_i);end;($fn=$*[0])&&$>=File::open($fn.chomp(".in")+".out","w");def each_case(nl=false)nc,
=getis;1.upto(nc){|c|print "Case ##{c}: ";nl&&puts;$fn&&STDOUT.puts([Time::now.strftime("%T"),c,?/,nc]*" ");yield}end

each_case{
  gets
  ar=getis.map{|e| e-1}
  puts (ar.length-ar.each_with_index.select{|e,i| e==i}.length).to_f
}
