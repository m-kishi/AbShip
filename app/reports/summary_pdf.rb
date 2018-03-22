class SummaryPdf
  extend CostHelper

  def self.create(summaries)
    report = Thinreports::Report.new layout: "app/reports/summary.tlf"
    report.list(:summary_list) do |list|

      total = Hash.new(0)

      list.on_page_footer_insert do |footer|
        footer.item(:food).value = to_currency(total[:food])
        footer.item(:otfd).value = to_currency(total[:otfd])
        footer.item(:good).value = to_currency(total[:good])
        footer.item(:frnd).value = to_currency(total[:frnd])
        footer.item(:trfc).value = to_currency(total[:trfc])
        footer.item(:play).value = to_currency(total[:play])
        footer.item(:hous).value = to_currency(total[:hous])
        footer.item(:engy).value = to_currency(total[:engy])
        footer.item(:cnct).value = to_currency(total[:cnct])
        footer.item(:medi).value = to_currency(total[:medi])
        footer.item(:insu).value = to_currency(total[:insu])
        footer.item(:othr).value = to_currency(total[:othr])
        footer.item(:ttal).value = to_currency(total[:ttal])
        footer.item(:earn).value = to_currency(total[:earn])
        footer.item(:blnc).value = to_currency(total[:blnc])

        total = Hash.new(0)
      end

      # 自動改行するようにtlf側でオプションを指定
      # 1ページ1年(12行+footer)となるように高さを調整済み
      summaries.each do |sum|
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

        total[:food] += food
        total[:otfd] += otfd
        total[:good] += good
        total[:frnd] += frnd
        total[:trfc] += trfc
        total[:play] += play
        total[:hous] += hous
        total[:engy] += engy
        total[:cnct] += cnct
        total[:medi] += medi
        total[:insu] += insu
        total[:othr] += othr
        total[:ttal] += ttal
        total[:earn] += earn
        total[:blnc] += blnc
      end
    end

    return report
  end

end
