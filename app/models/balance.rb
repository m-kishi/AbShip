class Balance < ApplicationRecord
  belongs_to :user

  #年度順
  default_scope -> {
    order(:year)
  }

end
