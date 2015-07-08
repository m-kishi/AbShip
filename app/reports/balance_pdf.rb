class BalancePdf
  extend CostHelper

  def self.create(balances)
    report = ThinReports::Report.new layout: "app/reports/balance.tlf"
    report.layout.config.list(:balance_list) do
      extend CostHelper

      use_stores :sub   => Hash.new(0),
                 :total => Hash.new(0)

      events.on :page_footer_insert do |e|
        e.section.item(:earn   ).value(to_currency(e.store.sub[:earn   ]))
        e.section.item(:bonus  ).value(to_currency(e.store.sub[:bonus  ]))
        e.section.item(:expense).value(to_currency(e.store.sub[:expense]))
        e.section.item(:special).value(to_currency(e.store.sub[:special]))
        e.section.item(:balance).value(to_currency(e.store.sub[:balance]))
        e.store.sub = Hash.new(0)
      end

      events.on :footer_insert do |e|
        e.section.item(:earn   ).value(to_currency(e.store.total[:earn   ]))
        e.section.item(:bonus  ).value(to_currency(e.store.total[:bonus  ]))
        e.section.item(:expense).value(to_currency(e.store.total[:expense]))
        e.section.item(:special).value(to_currency(e.store.total[:special]))
        e.section.item(:balance).value(to_currency(e.store.total[:balance]))
      end
    end
    report.start_new_page

    balances.each do |bln|
      next if bln["year"] == 9999
      report.page.list(:balance_list) do |list|
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

        list.store.sub[:earn   ] += earn
        list.store.sub[:bonus  ] += bonus
        list.store.sub[:expense] += expense
        list.store.sub[:special] += special
        list.store.sub[:balance] += balance

        list.store.total[:earn   ] += earn
        list.store.total[:bonus  ] += bonus
        list.store.total[:expense] += expense
        list.store.total[:special] += special
        list.store.total[:balance] += balance
      end
    end

    return report
  end

end
