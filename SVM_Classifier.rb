##
# SVM_Classifier module
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
module SVM_Classifier
  # change this if you move the svm_classify binaries in the "exec" directory
  @@module_path = "."
  @@exec_path = "#{@@module_path}/exec"
  @@model_path = "#{@@module_path}/models"
  @@tmp_path = "#{@@module_path}/tmp"

  # try not to change this
  @@exec_mac = "./#{@@exec_path}/mac_svm_classify"
  @@exec_windows = "#{@@exec_path}/windows_svm_classify"
  @@exec_linux = "./#{@@exec_path}/linux_svm_classify"

  # change this (to one of the three above) when you switch operating systems
  @@exec = @@exec_linux

  # svm specific defines
  @@predict_file = "#{@@tmp_path}/result_tmp.txt"
  
  # instances
  attr_accessor :threshold, :model, :order

  def svm_initialize(params = {})
    self.threshold = params[:threshold]
    self.model = @@model_path + "/" + params[:model]
    self.order = params[:order]
  end

  #
  # @parameters - hash of user values
  # @return - [boolean, float]
  #
  def svm_approve(hash = {})
    # convert to svm format and write to file
    user_input = convert_to_svm(hash)

    # run the svm classifier
    system "#{@@exec} -v 0 #{user_input} #{self.model} #{@@predict_file}"

    # read result
    file = File.open(@@predict_file, "r")
    line = file.gets
    predict = line.split(" ")[0].to_f

    # delete tmp files
    file.close
    File.delete(@@predict_file)
    File.delete(user_input)

    soft = (1 + Math.exp(-predict)) ** (-1)
    if soft > threshold
      return [true, soft]
    else
      return [false, soft]
    end
  end

  private

  #
  # @parameter: hash of user values
  # @return: name of the created svm file
  #
  def convert_to_svm(hash = {})
    user_id = hash[:id]
    file_name = "#{@@tmp_path}/#{user_id}_input.svm"
    user_file = File.new(file_name, "w")
    user_file.write("0 ")

    len = order.length
    i = 0
    while i < len
      begin
        param = hash[order[i]].to_f
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
