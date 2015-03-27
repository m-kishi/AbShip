class Private < ActiveRecord::Base

  #秘密の登録処理
  def self.import
    balance = 0
    Private.delete_all
    expenses = Expense.privates
    expenses.each do |exp|
      date = exp.date.strftime("%Y-%m")
      name = exp.name
      cost = exp.type == "PRVI" ? exp.cost : exp.type == "PRVO" ? -exp.cost : 0
      blnc = cost + balance
      Private.create(
        date: date,
        name: name,
        cost: cost,
        blnc: blnc
      )
      balance = blnc
    end
  end

end
