class SummaryPdf
  extend CostHelper

  def self.create(summaries)
    report = ThinReports::Report.new layout: "app/reports/summary.tlf"
    report.layout.config.list(:summary_list) do
      extend CostHelper

      use_stores :total => Hash.new(0)

      events.on :page_footer_insert do |e|
        e.section.item(:food).value(to_currency(e.store.total[:food]))
        e.section.item(:otfd).value(to_currency(e.store.total[:otfd]))
        e.section.item(:good).value(to_currency(e.store.total[:good]))
        e.section.item(:frnd).value(to_currency(e.store.total[:frnd]))
        e.section.item(:trfc).value(to_currency(e.store.total[:trfc]))
        e.section.item(:play).value(to_currency(e.store.total[:play]))
        e.section.item(:hous).value(to_currency(e.store.total[:hous]))
        e.section.item(:engy).value(to_currency(e.store.total[:engy]))
        e.section.item(:cnct).value(to_currency(e.store.total[:cnct]))
        e.section.item(:medi).value(to_currency(e.store.total[:medi]))
        e.section.item(:insu).value(to_currency(e.store.total[:insu]))
        e.section.item(:othr).value(to_currency(e.store.total[:othr]))
        e.section.item(:ttal).value(to_currency(e.store.total[:ttal]))
        e.section.item(:earn).value(to_currency(e.store.total[:earn]))
        e.section.item(:blnc).value(to_currency(e.store.total[:blnc]))
      end
    end

    cnt = 0
    summaries.each do |sum|
      if cnt % 12 == 0
        report.start_new_page
      end
      cnt = cnt + 1
      report.page.list(:summary_list) do |list|
        year = sum["year"]
        mnth = sum["mnth"]
        food = sum["food"].to_i
        otfd = sum["otfd"].to_i
        good = sum["good"].to_i
        frnd = sum["frnd"].to_i
        trfc = sum["trfc"].to_i
        play = sum["play"].to_i
        hous = sum["hous"].to_i
        engy = sum["engy"].to_i
        cnct = sum["cnct"].to_i
        medi = sum["medi"].to_i
        insu = sum["insu"].to_i
        othr = sum["othr"].to_i
        ttal = sum["ttal"].to_i
        earn = sum["earn"].to_i
        blnc = sum["blnc"].to_i

        list.add_row :mnth => sprintf("%04d/%02d", year, mnth),
                     :food => to_currency(food),
                     :otfd => to_currency(otfd),
                     :good => to_currency(good),
                     :frnd => to_currency(frnd),
                     :trfc => to_currency(trfc),
                     :play => to_currency(play),
                     :hous => to_currency(hous),
                     :engy => to_currency(engy),
                     :cnct => to_currency(cnct),
                     :medi => to_currency(medi),
                     :insu => to_currency(insu),
                     :othr => to_currency(othr),
                     :ttal => to_currency(ttal),
                     :earn => to_currency(earn),
                     :blnc => to_currency(blnc)

        list.store.total[:food] += food
        list.store.total[:otfd] += otfd
        list.store.total[:good] += good
        list.store.total[:frnd] += frnd
        list.store.total[:trfc] += trfc
        list.store.total[:play] += play
        list.store.total[:hous] += hous
        list.store.total[:engy] += engy
        list.store.total[:cnct] += cnct
        list.store.total[:medi] += medi
        list.store.total[:insu] += insu
        list.store.total[:othr] += othr
        list.store.total[:ttal] += ttal
        list.store.total[:earn] += earn
        list.store.total[:blnc] += blnc
      end
    end

    return report
  end

end
