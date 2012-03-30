##
#
# NC_Classifier class
# The class inherit SVM_Classifier and other potential classifier module
# User needs to require all the module scripts included in this script.
# instance classifier_name: string
# public methods: approve(hash)
#
# bn82. Mar,29,2012
#

class NC_Classifier
	include SVM_Classifier
	
	attr_accessor :classifier_name
	
	# constructor
	def initialize(classifier_name)
		@classifier_name = classifier_name
	end
	
	#
	# pre-condition: 
	#  pre-process of calling specific classifier is done, e.g. svm_model, 
	#  svm_threshold and svm_order is set before calling approve
	#
	# @parameter- hash: a hash table of user data
	# @return- [boolean, type of soft result for the module used]
	#
	def approve(hash)
		if classifier_name == "svm"
			return svm_approve(hash)
		end
		#
		# ...other potential classifiers...
		#
	end
end
