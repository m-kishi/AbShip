class BalancePdf
  extend CostHelper

  def self.create(balances)
    report = Thinreports::Report.new layout: "app/reports/balance.tlf"
    report.list(:balance_list) do |list|

      sub   = Hash.new(0)
      total = Hash.new(0)

      list.on_page_footer_insert do |footer|
        footer.item(:earn   ).value = to_currency(sub[:earn   ])
        footer.item(:bonus  ).value = to_currency(sub[:bonus  ])
        footer.item(:expense).value = to_currency(sub[:expense])
        footer.item(:special).value = to_currency(sub[:special])
        footer.item(:balance).value = to_currency(sub[:balance])

        sub = Hash.new(0)
      end

      list.on_footer_insert do |footer|
        footer.item(:earn   ).value = to_currency(total[:earn   ])
        footer.item(:bonus  ).value = to_currency(total[:bonus  ])
        footer.item(:expense).value = to_currency(total[:expense])
        footer.item(:special).value = to_currency(total[:special])
        footer.item(:balance).value = to_currency(total[:balance])
      end

      balances.each do |bln|
        next if bln["year"] == 9999

        year    = bln["year"   ]
        earn    = bln["earn"   ].to_i
        bonus   = bln["bnus"   ].to_i
        expense = bln["expense"].to_i
        special = bln["special"].to_i
        balance = bln["balance"].to_i

        list.add_row :year    => year,
                     :earn    => to_currency(earn   ),
                     :bonus   => to_currency(bonus  ),
                     :expense => to_currency(expense),
                     :special => to_currency(special),
                     :balance => to_currency(balance)

        sub[:earn   ] += earn
        sub[:bonus  ] += bonus
        sub[:expense] += expense
        sub[:special] += special
        sub[:balance] += balance

        total[:earn   ] += earn
        total[:bonus  ] += bonus
        total[:expense] += expense
        total[:special] += special
        total[:balance] += balance
      end
    end

    return report
  end

end
