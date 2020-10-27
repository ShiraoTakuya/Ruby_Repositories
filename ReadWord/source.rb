# coding: utf-8
require 'csv'
require 'zip'

def get_worddata(stPath)
	Zip::File.open(stPath) do |zip|
		zip.get_entry('word/document.xml').get_input_stream.read
	end
end

### MAIN BEGIN ###

puts "#データを取得"
stData = get_worddata('SET_PARAM.docx')

puts "#テキスト抽出"
stText = stData.scan(%r|<w:t>(.*?)</w:t>|).join("").force_encoding("utf-8")

puts "#アンケート結果抽出"
arSurvey = stText.scan(%r|アンケート([1-9]+)【(.*?)】【(.*?)】【(.*?)】【(.*?)】|)

puts "#抽出したデータを出力"
p arSurvey

### MAIN END ###