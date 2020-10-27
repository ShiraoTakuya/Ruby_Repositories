# coding: utf-8

### MAIN BEGIN ###

symbol = '._-=[]{}+#^!?%&@+*'.split('')

puts "記号なし"
puts [*'A'..'Z', *'a'..'z', *0..9].shuffle[0..11].join

puts "記号あり"
puts [*'A'..'Z', *'a'..'z', *0..9, *symbol].shuffle[0..11].join

### MAIN END ###