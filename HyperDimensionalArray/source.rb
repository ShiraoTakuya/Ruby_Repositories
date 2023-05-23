# coding: utf-8
require 'RubyXL'

#Arrayクラスにaverage機能を追加
class Array
	def average
		self.inject(:+) / self.length
	end
end

#ハッシュの最下層のデータを全て抽出してフラット配列に変換
def all_data(hash)
	ar = []
	return hash unless hash.kind_of?(Hash)
	hash.to_a&.transpose[1]&.each do |f|
		ar << all_data(f)
	end
	ar.flatten
end

def select_hash(hashDatabase, ar)
	return hashDatabase unless hashDatabase.kind_of?(Hash)

	#ハッシュをセレクト
	hash = hashDatabase
	hash = hash.select{|f1, f2|	f1 == ar[0]} unless (ar[0] == "*")

	#フォルダをハッシュ化
	hash.each do |f1, f2|
		hash[f1] = select_hash(f2, ar[1..-1])
	end

	hash
end

def ReadSetData(stPath)
	RubyXL::Parser.parse(stPath)[0].map do |row|
		row.cells.map do |cell|
			val = cell.value.to_s
		end
	end
end

def ConvertTextFileToArray(stPath)
	arPathAndData = []
	File.read(stPath).split("\n").map do |f2|
			stPath + '/' + f2.gsub("\t",'/')
	end
end

def AnalysisDataUseSetDataFromDir(stPath, arSetDataRow)
	#テキストファイルパスの階層構造をハッシュとして取得する
	hashDatabase = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc)}
	Dir.glob(stPath + '/**/*.txt').each do |f|
		ConvertTextFileToArray(f).each do |f2|
			eval('hashDatabase["' + f2.split('/')[0..-2].join('"]["') + '"] = f2.split(\'/\')[-1].to_f')
		end
	end
	
	#データベースにフィルタ反映
	hash = select_hash(hashDatabase, arSetDataRow)

	#数値抽出 & 演算
	all_data(hash).average
end

def main()
	puts "#調査する条件を取得"
	arSetData = ReadSetData('SET_PARAM.xlsx')
	
	puts "#調査条件で演算処理をする"
	arAnalysisData = arSetData.map do |arSetDataRow|
		[arSetDataRow, AnalysisDataUseSetDataFromDir('AR', arSetDataRow)]
	end
	
	puts "#調査結果を出力"
	arAnalysisData.each_with_index do |data, i|
		puts "\nNo." + (i+1).to_s
		puts "演算条件: " + data[0].to_s
		puts "計算結果: " + data[1].to_s + "\n"
	end
end

main()
