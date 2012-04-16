##
# NC_Classifier unit test (calls a classifier implementation)
#
# mjz48. Apr,01,2012

require 'NC_Classifier.rb'

puts ""
puts "====================="
puts "NC_Classifier.test.rb"

# change when implementation changes
tfilename = "tdata/SVM_Classifier.test.data"

order = [:RevolvingUtilizationOfUnsecuredLines,
    :age,:NumberOfTime3059DaysPastDueNotWorse,:DebtRatio,
    :MonthlyIncome,:NumberOfOpenCreditLinesAndLoans,
    :NumberOfTimes90DaysLate,:NumberRealEstateLoansOrLines,
    :NumberOfTime6089DaysPastDueNotWorse,:NumberOfDependents]

puts "NC_Classifier Object created."
nc_classifier = NC_Classifier.new({
                  :model => "model_2_0.1_0.1",
                  :threshold => 0.5,
                  :order => order })

# get testcases
tfile = File.open(tfilename, "r")

tc_num = 1
line = tfile.gets()
while line != nil
  line = line.split(" ")
  user_input = {}

  # parse the result
  testcase_result = (line[0] == "1") ? true : false

  # parse the user input
  user_input[:SeriousDlqin2yrs] = "0"
  user_input[:name] = line[1]
  user_input[:RevolvingUtilizationOfUnsecuredLines] = line[2]
  user_input[:age] = line[3]
  user_input[:NumberOfTime3059DaysPastDueNotWorse] = line[4]
  user_input[:DebtRatio] = line[5]
  user_input[:MonthlyIncome] = line[6]
  user_input[:NumberOfOpenCreditLinesAndLoans] = line[7]
  user_input[:NumberOfTimes90DaysLate] = line[8]
  user_input[:NumberRealEstateLoansOrLines] = line[9]
  user_input[:NumberOfTime6089DaysPastDueNotWorse] = line[10]
  user_input[:NumberOfDependents] = line[11]

  classifier_result = nc_classifier.approve(user_input)

  print "TC#{tc_num} :: expected: #{testcase_result}, "
  print "actual: (#{classifier_result[0]}, #{classifier_result[1]})"
  if classifier_result[0] != testcase_result
    print "  <== Misclassified!"
  end
  puts ""

  # get new data
  line = tfile.gets()
  tc_num += 1
end

puts "Done."
