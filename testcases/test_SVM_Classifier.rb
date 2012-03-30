##
# test case for SVM module
# 
# bn82. Mar,29,2012

require '../SVM_Classifier.rb'
require '../NC_Classifier.rb'

# hash sequence messed up in creation
hash = {:age => "45", :SeriousDlqin2yrs => 1, :NumberOfTime3059DaysPastDueNotWorse => 2,
		:name => "XYZ", :RevolvingUtilizationOfUnsecuredLines => 0.766126609,
		:NumberOfOpenCreditLinesAndLoans => 0, :NumberRealEstateLoansOrLines => 6,
		:DebtRatio => 0.802982129, :MonthlyIncome => 9120, :NumberOfOpenCreditLinesAndLoans => 13,
		:NumberOfTime6089DaysPastDueNotWorse => 0, :NumberOfDependents => 2}
		
order = [:RevolvingUtilizationOfUnsecuredLines,
		:age,:NumberOfTime3059DaysPastDueNotWorse,:DebtRatio,
		:MonthlyIncome,:NumberOfOpenCreditLinesAndLoans,
		:NumberOfTimes90DaysLate,:NumberRealEstateLoansOrLines,
		:NumberOfTime6089DaysPastDueNotWorse,:NumberOfDependents]
		

c = NC_Classifier.new("svm")

puts "NC_Classifier Object created."

c.svm_model = "model_2_0.1_0.1"
c.svm_threshold = 0
c.svm_order = order

#
# used for debug convert_to_svm
# To use: 
# 	comment out line 47 "private" in file SVM_Classifier.rb
#	delete "=begin" and "=end" below
#
=begin
user_input = c.convert_to_svm(hash,order)

file = File.open(user_input, "r")
puts file.gets
=end

result = c.approve(hash)

puts result[0]
puts result[1]

puts "Done"

