# coding: utf-8

def ConvertTextFileToArray(strPath)
	File.read(strPath).split("\n").map do |f|
		(strPath + '/' + f.gsub("\t",'/')).split('/')
	end
end

def HierarchyToHashDatabase(strPath)
	# Generation of Flexible Hash Container
	hashDatabase = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc)}

	Dir.glob(strPath + '/**/*.*').each do |f1|
		ConvertTextFileToArray(f1).each do |f2|
			eval('hashDatabase["' + f2[0..-2].join('"]["') + '"] = f2[-1].to_f')
		end
	end

	return hashDatabase
end

def main()
	pp HierarchyToHashDatabase('Hiererchy')
end

main()
