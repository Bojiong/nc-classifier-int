##
#
# NC_Classifier class
# Defined interface for the NC_Classifier
#
# public methods:
#   approve(hash)
#
# bn82. Mar,29,2012
# mjz48. Apr,01,2012
#

class NC_Classifier

  # constructor
  def initialize(params = {})
  end

  #
  # pre-condition:
  #  pre-process of calling specific classifier is done, e.g. svm_model,
  #  svm_threshold and svm_order is set before calling approve
  #
  # @parameter - hash: a hash table of classifier parameters (user data)
  # @return - (boolean, type of soft result for the module used)
  #
  def approve(hash = {})
  end
end
