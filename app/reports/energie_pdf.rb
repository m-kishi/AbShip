class EnergiePdf
  extend CostHelper

  def self.create(energies)
    report = ThinReports::Report.new layout: "app/reports/energie.tlf"
    report.layout.config.list(:energie_list) do
      extend CostHelper

      use_stores min: Hash.new(0),
                 ave: Hash.new(0),
                 max: Hash.new(0)

      events.on :footer_insert do |e|
        e.section.item(:min04).value(to_currency(e.store.min[:mnth04]))
        e.section.item(:min05).value(to_currency(e.store.min[:mnth05]))
        e.section.item(:min06).value(to_currency(e.store.min[:mnth06]))
        e.section.item(:min07).value(to_currency(e.store.min[:mnth07]))
        e.section.item(:min08).value(to_currency(e.store.min[:mnth08]))
        e.section.item(:min09).value(to_currency(e.store.min[:mnth09]))
        e.section.item(:min10).value(to_currency(e.store.min[:mnth10]))
        e.section.item(:min11).value(to_currency(e.store.min[:mnth11]))
        e.section.item(:min12).value(to_currency(e.store.min[:mnth12]))
        e.section.item(:min01).value(to_currency(e.store.min[:mnth01]))
        e.section.item(:min02).value(to_currency(e.store.min[:mnth02]))
        e.section.item(:min03).value(to_currency(e.store.min[:mnth03]))

        e.section.item(:ave04).value(to_currency(e.store.ave[:mnth04]))
        e.section.item(:ave05).value(to_currency(e.store.ave[:mnth05]))
        e.section.item(:ave06).value(to_currency(e.store.ave[:mnth06]))
        e.section.item(:ave07).value(to_currency(e.store.ave[:mnth07]))
        e.section.item(:ave08).value(to_currency(e.store.ave[:mnth08]))
        e.section.item(:ave09).value(to_currency(e.store.ave[:mnth09]))
        e.section.item(:ave10).value(to_currency(e.store.ave[:mnth10]))
        e.section.item(:ave11).value(to_currency(e.store.ave[:mnth11]))
        e.section.item(:ave12).value(to_currency(e.store.ave[:mnth12]))
        e.section.item(:ave01).value(to_currency(e.store.ave[:mnth01]))
        e.section.item(:ave02).value(to_currency(e.store.ave[:mnth02]))
        e.section.item(:ave03).value(to_currency(e.store.ave[:mnth03]))

        e.section.item(:max04).value(to_currency(e.store.max[:mnth04]))
        e.section.item(:max05).value(to_currency(e.store.max[:mnth05]))
        e.section.item(:max06).value(to_currency(e.store.max[:mnth06]))
        e.section.item(:max07).value(to_currency(e.store.max[:mnth07]))
        e.section.item(:max08).value(to_currency(e.store.max[:mnth08]))
        e.section.item(:max09).value(to_currency(e.store.max[:mnth09]))
        e.section.item(:max10).value(to_currency(e.store.max[:mnth10]))
        e.section.item(:max11).value(to_currency(e.store.max[:mnth11]))
        e.section.item(:max12).value(to_currency(e.store.max[:mnth12]))
        e.section.item(:max01).value(to_currency(e.store.max[:mnth01]))
        e.section.item(:max02).value(to_currency(e.store.max[:mnth02]))
        e.section.item(:max03).value(to_currency(e.store.max[:mnth03]))
      end
    end

    # --------------------------------------------------
    # 電気代
    # --------------------------------------------------
    report.start_new_page
    report.page.item(:title).value("電気代")
    el04 = energies[:el].map {|el| el["mnth04"] }.select {|el| el > 0 }
    el05 = energies[:el].map {|el| el["mnth05"] }.select {|el| el > 0 }
    el06 = energies[:el].map {|el| el["mnth06"] }.select {|el| el > 0 }
    el07 = energies[:el].map {|el| el["mnth07"] }.select {|el| el > 0 }
    el08 = energies[:el].map {|el| el["mnth08"] }.select {|el| el > 0 }
    el09 = energies[:el].map {|el| el["mnth09"] }.select {|el| el > 0 }
    el10 = energies[:el].map {|el| el["mnth10"] }.select {|el| el > 0 }
    el11 = energies[:el].map {|el| el["mnth11"] }.select {|el| el > 0 }
    el12 = energies[:el].map {|el| el["mnth12"] }.select {|el| el > 0 }
    el01 = energies[:el].map {|el| el["mnth01"] }.select {|el| el > 0 }
    el02 = energies[:el].map {|el| el["mnth02"] }.select {|el| el > 0 }
    el03 = energies[:el].map {|el| el["mnth03"] }.select {|el| el > 0 }

    el_once = false
    energies[:el].each do |el|
      report.page.list(:energie_list) do |list|
        year   = el["year"]
        mnth04 = el["mnth04"]
        mnth05 = el["mnth05"]
        mnth06 = el["mnth06"]
        mnth07 = el["mnth07"]
        mnth08 = el["mnth08"]
        mnth09 = el["mnth09"]
        mnth10 = el["mnth10"]
        mnth11 = el["mnth11"]
        mnth12 = el["mnth12"]
        mnth01 = el["mnth01"]
        mnth02 = el["mnth02"]
        mnth03 = el["mnth03"]

       if !el_once
          el_once = true
          list.store.min[:mnth04] = el04.min
          list.store.min[:mnth05] = el05.min
          list.store.min[:mnth06] = el06.min
          list.store.min[:mnth07] = el07.min
          list.store.min[:mnth08] = el08.min
          list.store.min[:mnth09] = el09.min
          list.store.min[:mnth10] = el10.min
          list.store.min[:mnth11] = el11.min
          list.store.min[:mnth12] = el12.min
          list.store.min[:mnth01] = el01.min
          list.store.min[:mnth02] = el02.min
          list.store.min[:mnth03] = el03.min

          list.store.ave[:mnth04] = (el04.reduce(:+) / el04.size.to_f).ceil
          list.store.ave[:mnth05] = (el05.reduce(:+) / el05.size.to_f).ceil
          list.store.ave[:mnth06] = (el06.reduce(:+) / el06.size.to_f).ceil
          list.store.ave[:mnth07] = (el07.reduce(:+) / el07.size.to_f).ceil
          list.store.ave[:mnth08] = (el08.reduce(:+) / el08.size.to_f).ceil
          list.store.ave[:mnth09] = (el09.reduce(:+) / el09.size.to_f).ceil
          list.store.ave[:mnth10] = (el10.reduce(:+) / el10.size.to_f).ceil
          list.store.ave[:mnth11] = (el11.reduce(:+) / el11.size.to_f).ceil
          list.store.ave[:mnth12] = (el12.reduce(:+) / el12.size.to_f).ceil
          list.store.ave[:mnth01] = (el01.reduce(:+) / el01.size.to_f).ceil
          list.store.ave[:mnth02] = (el02.reduce(:+) / el02.size.to_f).ceil
          list.store.ave[:mnth03] = (el03.reduce(:+) / el03.size.to_f).ceil

          list.store.max[:mnth04] = el04.max
          list.store.max[:mnth05] = el05.max
          list.store.max[:mnth06] = el06.max
          list.store.max[:mnth07] = el07.max
          list.store.max[:mnth08] = el08.max
          list.store.max[:mnth09] = el09.max
          list.store.max[:mnth10] = el10.max
          list.store.max[:mnth11] = el11.max
          list.store.max[:mnth12] = el12.max
          list.store.max[:mnth01] = el01.max
          list.store.max[:mnth02] = el02.max
          list.store.max[:mnth03] = el03.max
        end

        list.add_row do |row|
          row.item(:year  ).value(year)
          row.item(:mnth04).value(to_currency(mnth04))
          row.item(:mnth05).value(to_currency(mnth05))
          row.item(:mnth06).value(to_currency(mnth06))
          row.item(:mnth07).value(to_currency(mnth07))
          row.item(:mnth08).value(to_currency(mnth08))
          row.item(:mnth09).value(to_currency(mnth09))
          row.item(:mnth10).value(to_currency(mnth10))
          row.item(:mnth11).value(to_currency(mnth11))
          row.item(:mnth12).value(to_currency(mnth12))
          row.item(:mnth01).value(to_currency(mnth01))
          row.item(:mnth02).value(to_currency(mnth02))
          row.item(:mnth03).value(to_currency(mnth03))

          row.item(:mnth04).style(:color, '#0000ff') if el04.min == mnth04
          row.item(:mnth05).style(:color, '#0000ff') if el05.min == mnth05
          row.item(:mnth06).style(:color, '#0000ff') if el06.min == mnth06
          row.item(:mnth07).style(:color, '#0000ff') if el07.min == mnth07
          row.item(:mnth08).style(:color, '#0000ff') if el08.min == mnth08
          row.item(:mnth09).style(:color, '#0000ff') if el09.min == mnth09
          row.item(:mnth10).style(:color, '#0000ff') if el10.min == mnth10
          row.item(:mnth11).style(:color, '#0000ff') if el11.min == mnth11
          row.item(:mnth12).style(:color, '#0000ff') if el12.min == mnth12
          row.item(:mnth01).style(:color, '#0000ff') if el01.min == mnth01
          row.item(:mnth02).style(:color, '#0000ff') if el02.min == mnth02
          row.item(:mnth03).style(:color, '#0000ff') if el03.min == mnth03

          row.item(:mnth04).style(:color, '#ff0000') if el04.max == mnth04
          row.item(:mnth05).style(:color, '#ff0000') if el05.max == mnth05
          row.item(:mnth06).style(:color, '#ff0000') if el06.max == mnth06
          row.item(:mnth07).style(:color, '#ff0000') if el07.max == mnth07
          row.item(:mnth08).style(:color, '#ff0000') if el08.max == mnth08
          row.item(:mnth09).style(:color, '#ff0000') if el09.max == mnth09
          row.item(:mnth10).style(:color, '#ff0000') if el10.max == mnth10
          row.item(:mnth11).style(:color, '#ff0000') if el11.max == mnth11
          row.item(:mnth12).style(:color, '#ff0000') if el12.max == mnth12
          row.item(:mnth01).style(:color, '#ff0000') if el01.max == mnth01
          row.item(:mnth02).style(:color, '#ff0000') if el02.max == mnth02
          row.item(:mnth03).style(:color, '#ff0000') if el03.max == mnth03
         end
      end
    end

    # --------------------------------------------------
    # ガス代
    # --------------------------------------------------
    report.start_new_page
    report.page.item(:title).value("ガス代")
    gs04 = energies[:gs].map {|gs| gs["mnth04"] }.select {|gs| gs > 0 }
    gs05 = energies[:gs].map {|gs| gs["mnth05"] }.select {|gs| gs > 0 }
    gs06 = energies[:gs].map {|gs| gs["mnth06"] }.select {|gs| gs > 0 }
    gs07 = energies[:gs].map {|gs| gs["mnth07"] }.select {|gs| gs > 0 }
    gs08 = energies[:gs].map {|gs| gs["mnth08"] }.select {|gs| gs > 0 }
    gs09 = energies[:gs].map {|gs| gs["mnth09"] }.select {|gs| gs > 0 }
    gs10 = energies[:gs].map {|gs| gs["mnth10"] }.select {|gs| gs > 0 }
    gs11 = energies[:gs].map {|gs| gs["mnth11"] }.select {|gs| gs > 0 }
    gs12 = energies[:gs].map {|gs| gs["mnth12"] }.select {|gs| gs > 0 }
    gs01 = energies[:gs].map {|gs| gs["mnth01"] }.select {|gs| gs > 0 }
    gs02 = energies[:gs].map {|gs| gs["mnth02"] }.select {|gs| gs > 0 }
    gs03 = energies[:gs].map {|gs| gs["mnth03"] }.select {|gs| gs > 0 }

    gs_once = false
    energies[:gs].each do |gs|
      report.page.list(:energie_list) do |list|
        year   = gs["year"]
        mnth04 = gs["mnth04"]
        mnth05 = gs["mnth05"]
        mnth06 = gs["mnth06"]
        mnth07 = gs["mnth07"]
        mnth08 = gs["mnth08"]
        mnth09 = gs["mnth09"]
        mnth10 = gs["mnth10"]
        mnth11 = gs["mnth11"]
        mnth12 = gs["mnth12"]
        mnth01 = gs["mnth01"]
        mnth02 = gs["mnth02"]
        mnth03 = gs["mnth03"]

       if !gs_once
          gs_once = true
          list.store.min[:mnth04] = gs04.min
          list.store.min[:mnth05] = gs05.min
          list.store.min[:mnth06] = gs06.min
          list.store.min[:mnth07] = gs07.min
          list.store.min[:mnth08] = gs08.min
          list.store.min[:mnth09] = gs09.min
          list.store.min[:mnth10] = gs10.min
          list.store.min[:mnth11] = gs11.min
          list.store.min[:mnth12] = gs12.min
          list.store.min[:mnth01] = gs01.min
          list.store.min[:mnth02] = gs02.min
          list.store.min[:mnth03] = gs03.min

          list.store.ave[:mnth04] = (gs04.reduce(:+) / gs04.size.to_f).ceil
          list.store.ave[:mnth05] = (gs05.reduce(:+) / gs05.size.to_f).ceil
          list.store.ave[:mnth06] = (gs06.reduce(:+) / gs06.size.to_f).ceil
          list.store.ave[:mnth07] = (gs07.reduce(:+) / gs07.size.to_f).ceil
          list.store.ave[:mnth08] = (gs08.reduce(:+) / gs08.size.to_f).ceil
          list.store.ave[:mnth09] = (gs09.reduce(:+) / gs09.size.to_f).ceil
          list.store.ave[:mnth10] = (gs10.reduce(:+) / gs10.size.to_f).ceil
          list.store.ave[:mnth11] = (gs11.reduce(:+) / gs11.size.to_f).ceil
          list.store.ave[:mnth12] = (gs12.reduce(:+) / gs12.size.to_f).ceil
          list.store.ave[:mnth01] = (gs01.reduce(:+) / gs01.size.to_f).ceil
          list.store.ave[:mnth02] = (gs02.reduce(:+) / gs02.size.to_f).ceil
          list.store.ave[:mnth03] = (gs03.reduce(:+) / gs03.size.to_f).ceil

          list.store.max[:mnth04] = gs04.max
          list.store.max[:mnth05] = gs05.max
          list.store.max[:mnth06] = gs06.max
          list.store.max[:mnth07] = gs07.max
          list.store.max[:mnth08] = gs08.max
          list.store.max[:mnth09] = gs09.max
          list.store.max[:mnth10] = gs10.max
          list.store.max[:mnth11] = gs11.max
          list.store.max[:mnth12] = gs12.max
          list.store.max[:mnth01] = gs01.max
          list.store.max[:mnth02] = gs02.max
          list.store.max[:mnth03] = gs03.max
        end

        list.add_row do |row|
          row.item(:year  ).value(year)
          row.item(:mnth04).value(to_currency(mnth04))
          row.item(:mnth05).value(to_currency(mnth05))
          row.item(:mnth06).value(to_currency(mnth06))
          row.item(:mnth07).value(to_currency(mnth07))
          row.item(:mnth08).value(to_currency(mnth08))
          row.item(:mnth09).value(to_currency(mnth09))
          row.item(:mnth10).value(to_currency(mnth10))
          row.item(:mnth11).value(to_currency(mnth11))
          row.item(:mnth12).value(to_currency(mnth12))
          row.item(:mnth01).value(to_currency(mnth01))
          row.item(:mnth02).value(to_currency(mnth02))
          row.item(:mnth03).value(to_currency(mnth03))

          row.item(:mnth04).style(:color, '#0000ff') if gs04.min == mnth04
          row.item(:mnth05).style(:color, '#0000ff') if gs05.min == mnth05
          row.item(:mnth06).style(:color, '#0000ff') if gs06.min == mnth06
          row.item(:mnth07).style(:color, '#0000ff') if gs07.min == mnth07
          row.item(:mnth08).style(:color, '#0000ff') if gs08.min == mnth08
          row.item(:mnth09).style(:color, '#0000ff') if gs09.min == mnth09
          row.item(:mnth10).style(:color, '#0000ff') if gs10.min == mnth10
          row.item(:mnth11).style(:color, '#0000ff') if gs11.min == mnth11
          row.item(:mnth12).style(:color, '#0000ff') if gs12.min == mnth12
          row.item(:mnth01).style(:color, '#0000ff') if gs01.min == mnth01
          row.item(:mnth02).style(:color, '#0000ff') if gs02.min == mnth02
          row.item(:mnth03).style(:color, '#0000ff') if gs03.min == mnth03

          row.item(:mnth04).style(:color, '#ff0000') if gs04.max == mnth04
          row.item(:mnth05).style(:color, '#ff0000') if gs05.max == mnth05
          row.item(:mnth06).style(:color, '#ff0000') if gs06.max == mnth06
          row.item(:mnth07).style(:color, '#ff0000') if gs07.max == mnth07
          row.item(:mnth08).style(:color, '#ff0000') if gs08.max == mnth08
          row.item(:mnth09).style(:color, '#ff0000') if gs09.max == mnth09
          row.item(:mnth10).style(:color, '#ff0000') if gs10.max == mnth10
          row.item(:mnth11).style(:color, '#ff0000') if gs11.max == mnth11
          row.item(:mnth12).style(:color, '#ff0000') if gs12.max == mnth12
          row.item(:mnth01).style(:color, '#ff0000') if gs01.max == mnth01
          row.item(:mnth02).style(:color, '#ff0000') if gs02.max == mnth02
          row.item(:mnth03).style(:color, '#ff0000') if gs03.max == mnth03
         end
      end
    end

    # --------------------------------------------------
    # 水道代
    # --------------------------------------------------
    report.start_new_page
    report.page.item(:title).value("水道代")
    wt04 = energies[:wt].map {|wt| wt["mnth04"] }.select {|wt| wt > 0 }
    wt05 = energies[:wt].map {|wt| wt["mnth05"] }.select {|wt| wt > 0 }
    wt06 = energies[:wt].map {|wt| wt["mnth06"] }.select {|wt| wt > 0 }
    wt07 = energies[:wt].map {|wt| wt["mnth07"] }.select {|wt| wt > 0 }
    wt08 = energies[:wt].map {|wt| wt["mnth08"] }.select {|wt| wt > 0 }
    wt09 = energies[:wt].map {|wt| wt["mnth09"] }.select {|wt| wt > 0 }
    wt10 = energies[:wt].map {|wt| wt["mnth10"] }.select {|wt| wt > 0 }
    wt11 = energies[:wt].map {|wt| wt["mnth11"] }.select {|wt| wt > 0 }
    wt12 = energies[:wt].map {|wt| wt["mnth12"] }.select {|wt| wt > 0 }
    wt01 = energies[:wt].map {|wt| wt["mnth01"] }.select {|wt| wt > 0 }
    wt02 = energies[:wt].map {|wt| wt["mnth02"] }.select {|wt| wt > 0 }
    wt03 = energies[:wt].map {|wt| wt["mnth03"] }.select {|wt| wt > 0 }

    wt_once = false
    energies[:wt].each do |wt|
      report.page.list(:energie_list) do |list|
        year   = wt["year"]
        mnth04 = wt["mnth04"]
        mnth05 = wt["mnth05"]
        mnth06 = wt["mnth06"]
        mnth07 = wt["mnth07"]
        mnth08 = wt["mnth08"]
        mnth09 = wt["mnth09"]
        mnth10 = wt["mnth10"]
        mnth11 = wt["mnth11"]
        mnth12 = wt["mnth12"]
        mnth01 = wt["mnth01"]
        mnth02 = wt["mnth02"]
        mnth03 = wt["mnth03"]

       if !wt_once
          wt_once = true
          list.store.min[:mnth04] = wt04.min
          list.store.min[:mnth05] = wt05.min
          list.store.min[:mnth06] = wt06.min
          list.store.min[:mnth07] = wt07.min
          list.store.min[:mnth08] = wt08.min
          list.store.min[:mnth09] = wt09.min
          list.store.min[:mnth10] = wt10.min
          list.store.min[:mnth11] = wt11.min
          list.store.min[:mnth12] = wt12.min
          list.store.min[:mnth01] = wt01.min
          list.store.min[:mnth02] = wt02.min
          list.store.min[:mnth03] = wt03.min

          list.store.ave[:mnth04] = (wt04.reduce(:+) / wt04.size.to_f).ceil
          list.store.ave[:mnth05] = (wt05.reduce(:+) / wt05.size.to_f).ceil
          list.store.ave[:mnth06] = (wt06.reduce(:+) / wt06.size.to_f).ceil
          list.store.ave[:mnth07] = (wt07.reduce(:+) / wt07.size.to_f).ceil
          list.store.ave[:mnth08] = (wt08.reduce(:+) / wt08.size.to_f).ceil
          list.store.ave[:mnth09] = (wt09.reduce(:+) / wt09.size.to_f).ceil
          list.store.ave[:mnth10] = (wt10.reduce(:+) / wt10.size.to_f).ceil
          list.store.ave[:mnth11] = (wt11.reduce(:+) / wt11.size.to_f).ceil
          list.store.ave[:mnth12] = (wt12.reduce(:+) / wt12.size.to_f).ceil
          list.store.ave[:mnth01] = (wt01.reduce(:+) / wt01.size.to_f).ceil
          list.store.ave[:mnth02] = (wt02.reduce(:+) / wt02.size.to_f).ceil
          list.store.ave[:mnth03] = (wt03.reduce(:+) / wt03.size.to_f).ceil

          list.store.max[:mnth04] = wt04.max
          list.store.max[:mnth05] = wt05.max
          list.store.max[:mnth06] = wt06.max
          list.store.max[:mnth07] = wt07.max
          list.store.max[:mnth08] = wt08.max
          list.store.max[:mnth09] = wt09.max
          list.store.max[:mnth10] = wt10.max
          list.store.max[:mnth11] = wt11.max
          list.store.max[:mnth12] = wt12.max
          list.store.max[:mnth01] = wt01.max
          list.store.max[:mnth02] = wt02.max
          list.store.max[:mnth03] = wt03.max
        end

        list.add_row do |row|
          row.item(:year  ).value(year)
          row.item(:mnth04).value(to_currency(mnth04))
          row.item(:mnth05).value(to_currency(mnth05))
          row.item(:mnth06).value(to_currency(mnth06))
          row.item(:mnth07).value(to_currency(mnth07))
          row.item(:mnth08).value(to_currency(mnth08))
          row.item(:mnth09).value(to_currency(mnth09))
          row.item(:mnth10).value(to_currency(mnth10))
          row.item(:mnth11).value(to_currency(mnth11))
          row.item(:mnth12).value(to_currency(mnth12))
          row.item(:mnth01).value(to_currency(mnth01))
          row.item(:mnth02).value(to_currency(mnth02))
          row.item(:mnth03).value(to_currency(mnth03))

          row.item(:mnth04).style(:color, '#0000ff') if wt04.min == mnth04
          row.item(:mnth05).style(:color, '#0000ff') if wt05.min == mnth05
          row.item(:mnth06).style(:color, '#0000ff') if wt06.min == mnth06
          row.item(:mnth07).style(:color, '#0000ff') if wt07.min == mnth07
          row.item(:mnth08).style(:color, '#0000ff') if wt08.min == mnth08
          row.item(:mnth09).style(:color, '#0000ff') if wt09.min == mnth09
          row.item(:mnth10).style(:color, '#0000ff') if wt10.min == mnth10
          row.item(:mnth11).style(:color, '#0000ff') if wt11.min == mnth11
          row.item(:mnth12).style(:color, '#0000ff') if wt12.min == mnth12
          row.item(:mnth01).style(:color, '#0000ff') if wt01.min == mnth01
          row.item(:mnth02).style(:color, '#0000ff') if wt02.min == mnth02
          row.item(:mnth03).style(:color, '#0000ff') if wt03.min == mnth03

          row.item(:mnth04).style(:color, '#ff0000') if wt04.max == mnth04
          row.item(:mnth05).style(:color, '#ff0000') if wt05.max == mnth05
          row.item(:mnth06).style(:color, '#ff0000') if wt06.max == mnth06
          row.item(:mnth07).style(:color, '#ff0000') if wt07.max == mnth07
          row.item(:mnth08).style(:color, '#ff0000') if wt08.max == mnth08
          row.item(:mnth09).style(:color, '#ff0000') if wt09.max == mnth09
          row.item(:mnth10).style(:color, '#ff0000') if wt10.max == mnth10
          row.item(:mnth11).style(:color, '#ff0000') if wt11.max == mnth11
          row.item(:mnth12).style(:color, '#ff0000') if wt12.max == mnth12
          row.item(:mnth01).style(:color, '#ff0000') if wt01.max == mnth01
          row.item(:mnth02).style(:color, '#ff0000') if wt02.max == mnth02
          row.item(:mnth03).style(:color, '#ff0000') if wt03.max == mnth03
         end
      end
    end

    return report
  end

end
