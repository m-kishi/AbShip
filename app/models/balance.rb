class Balance < ActiveRecord::Base
  belongs_to :user

  #年度順
  default_scope -> {
    order(:year)
  }

end
