##
# SVM_Classifier module
#
#
#
# instance:
#   svm_thresold, svm_model, svm_order
#
# public methods:
#   svm_approve(hash)
#
# private methods:
#   convert_to_svm(hash)
#
# bn82. Mar,29,2012
# mjz48. Apr,01,2012
#
class SVM_Classifier

# instances
attr_accessor :svm_threshold, :svm_model, :svm_order

# constructor
  def initialize(params = {})
    self.svm_threshold = params[:svm_threshold]
    self.svm_model = params[:svm_model]
    self.svm_order = params[:svm_order]
  end

  #
  # @parameters - hash of user values
  # @return - [boolean, float]
  #
  def approve(hash = {})

    # some defines... >_<
    #svm_command = "./svm_classify"  # for linux/mac
    svm_command = "exec/svm_classify.exe" # for windows
    predict_file = "result_tmp.txt"

    # convert to svm format and write to file
    user_input = convert_to_svm(hash)

    # run the svm classifier
    system "#{svm_command} -v 0 #{user_input} #{self.svm_model} #{predict_file}"

    # read result
    file = File.open(predict_file, "r")
    line = file.gets
    predict = line.split(" ")[0].to_f

    # delet tmp files
    file.close
    File.delete(predict_file)
    File.delete(user_input)

    soft = predict - svm_threshold
    if soft > 0
      return [TRUE, soft]
    else
      return [FALSE, soft]
    end
  end

  private

  #
  # @parameter: hash of user values
  # @return: name of the created svm file
  #
  def convert_to_svm(hash = {})
    user_id = hash[:id]
    file_name = "#{user_id}_input.svm"
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
    user_file.close()
    return file_name
  end
end
