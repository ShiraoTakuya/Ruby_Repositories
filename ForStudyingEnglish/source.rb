# coding: utf-8
require 'csv'
require 'win32/clipboard'
require 'win32ole' 

def open_csv(str)
	arr = []
	CSV.foreach(str) do |row|
		arr.push(row)
	end
	arr
end

def write_csv(str, arr)
	CSV.open(str, 'w') do |csv|
		arr.each do |ar|
			csv << ar
		end
	end
end

def add_csv(str, ar)
	CSV.open(str, 'a') do |csv|
		csv << ar
	end
end

def select_exam(arr)
	intRand = 0
	floutTh = rand()
	10.times do
		intRand = rand(1..arr.size-1)
		break if arr[intRand][1].to_i == 0
		break if arr[intRand][2].to_f / arr[intRand][1].to_f < floutTh
	end
	intRand
end

### MAIN BEGIN ###

return if ARGV[0] == nil

if ARGV[0] == "ADD"
	str = Win32::Clipboard.data(Win32::Clipboard::UNICODETEXT).gsub("\r\n","\n").split("\n").compact.reject(&:empty?)[0]
	add_csv("SET_PARAM.csv", [str,"0","0"])
end

if ARGV[0] == "EXAM"
	ar = open_csv("SET_PARAM.csv")
	intRand = select_exam(ar)

	# issue EXAM
	wsh = WIN32OLE.new('WScript.Shell')
	intAnswer = wsh.Popup(ar[intRand][0], 0, "EXAM", 1)
	ar[intRand][1] = (ar[intRand][1].to_i + 1).to_s
	ar[intRand][2] = (ar[intRand][2].to_i + 1).to_s if intAnswer == 1

	# output result of EXAM
	write_csv("SET_PARAM.csv", ar)
end

### MAIN END ###
