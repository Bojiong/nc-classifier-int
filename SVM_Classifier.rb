##
# SVM_Classifier module
#
# instance: svm_thresold, svm_model, svm_order
# private method: convert_to_svm(hash)
# public method: svm_approve(hash)
#
# bn82. Mar,29,2012
#
module SVM_Classifier

# instances
attr_accessor :svm_threshold, :svm_model, :svm_order

# constructor
def initialize(svm_threshold, svm_model, svm_order)
	@svm_threshold = svm_threshold
	@svm_model = svm_model
	@svm_order = svm_order
end

#
# @parameters - hash of user values
# @return - [boolean, float]
#
def svm_approve(hash)
	# convert to svm
	user_input = convert_to_svm(hash)
	# run svm
	predict_file = "result_tmp.txt"
	system "./svm_classify -v 0 #{user_input} #{@svm_model} #{predict_file}"
	# read result
	file = File.open(predict_file, "r")
	line = file.gets
	predict  = line.split(" ")[0].to_f
	# delete rmp files
	file.close
	File.delete(predict_file)
	File.delete(user_input)
	soft = predict - svm_threshold
	if soft > 0
		return [TRUE, soft]
	else return [FALSE, soft]
	end
end

private

#
# @parameter: hash of user values
# @return: name of the created svm file 
#
def convert_to_svm(hash)
	user_name = hash[:name]
	file_name = "#{user_name}_input.svm"
	user_file = File.new(file_name, "w")
	user_file.write("0 ")
	
	len = svm_order.length
	i = 0
	while i < len
		begin
			param = hash[svm_order[i]].to_f
			rescue
				param = 0.0                  # default 0?????
		end
		i += 1
		user_file.write("#{i}:#{param} ")
	end
	user_file.write("\n")
	user_file.close
	return file_name
end

end

