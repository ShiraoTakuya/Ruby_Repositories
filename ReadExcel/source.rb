# coding: utf-8
require 'csv'
require 'zip'

def get_sheetdata(stPath)
	Zip::File.open(stPath) do |zip|
		zip.get_entry('xl/worksheets/sheet1.xml').get_input_stream.read
	end
end

### MAIN BEGIN ###

puts "#sheet1のテキストデータを取得"
stSheet = get_sheetdata('SET_PARAM.xlsx')

puts "#セル番号とセルデータを取得"
arCellData = stSheet.scan(%r|<c[^>]*?r="(.*?)"[^>]*?>(.*?)</c>|)

puts "#セルデータから表示値抽出"
arCellData = arCellData.map do |f|
	[f[0], f[1].scan(%r|<v>(.*?)</v>|)[0][0]]
end

puts "#抽出したデータをハッシュ化"
hashCellData = Hash[*arCellData.flatten]

puts "#抽出したデータを出力"
puts hashCellData

### MAIN END ###
