class EnergiePdf
  extend CostHelper
  extend EngyHelper

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
    el04 = get_energies_by_month(energies, :el, "mnth04")
    el05 = get_energies_by_month(energies, :el, "mnth05")
    el06 = get_energies_by_month(energies, :el, "mnth06")
    el07 = get_energies_by_month(energies, :el, "mnth07")
    el08 = get_energies_by_month(energies, :el, "mnth08")
    el09 = get_energies_by_month(energies, :el, "mnth09")
    el10 = get_energies_by_month(energies, :el, "mnth10")
    el11 = get_energies_by_month(energies, :el, "mnth11")
    el12 = get_energies_by_month(energies, :el, "mnth12")
    el01 = get_energies_by_month(energies, :el, "mnth01")
    el02 = get_energies_by_month(energies, :el, "mnth02")
    el03 = get_energies_by_month(energies, :el, "mnth03")

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
          list.store.min[:mnth04] = footer_min(el04)
          list.store.min[:mnth05] = footer_min(el05)
          list.store.min[:mnth06] = footer_min(el06)
          list.store.min[:mnth07] = footer_min(el07)
          list.store.min[:mnth08] = footer_min(el08)
          list.store.min[:mnth09] = footer_min(el09)
          list.store.min[:mnth10] = footer_min(el10)
          list.store.min[:mnth11] = footer_min(el11)
          list.store.min[:mnth12] = footer_min(el12)
          list.store.min[:mnth01] = footer_min(el01)
          list.store.min[:mnth02] = footer_min(el02)
          list.store.min[:mnth03] = footer_min(el03)

          list.store.ave[:mnth04] = footer_ave(el04)
          list.store.ave[:mnth05] = footer_ave(el05)
          list.store.ave[:mnth06] = footer_ave(el06)
          list.store.ave[:mnth07] = footer_ave(el07)
          list.store.ave[:mnth08] = footer_ave(el08)
          list.store.ave[:mnth09] = footer_ave(el09)
          list.store.ave[:mnth10] = footer_ave(el10)
          list.store.ave[:mnth11] = footer_ave(el11)
          list.store.ave[:mnth12] = footer_ave(el12)
          list.store.ave[:mnth01] = footer_ave(el01)
          list.store.ave[:mnth02] = footer_ave(el02)
          list.store.ave[:mnth03] = footer_ave(el03)

          list.store.max[:mnth04] = footer_max(el04)
          list.store.max[:mnth05] = footer_max(el05)
          list.store.max[:mnth06] = footer_max(el06)
          list.store.max[:mnth07] = footer_max(el07)
          list.store.max[:mnth08] = footer_max(el08)
          list.store.max[:mnth09] = footer_max(el09)
          list.store.max[:mnth10] = footer_max(el10)
          list.store.max[:mnth11] = footer_max(el11)
          list.store.max[:mnth12] = footer_max(el12)
          list.store.max[:mnth01] = footer_max(el01)
          list.store.max[:mnth02] = footer_max(el02)
          list.store.max[:mnth03] = footer_max(el03)
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

          row.item(:mnth04).style(:color, '#0000ff') if eq_min(el04, mnth04)
          row.item(:mnth05).style(:color, '#0000ff') if eq_min(el05, mnth05)
          row.item(:mnth06).style(:color, '#0000ff') if eq_min(el06, mnth06)
          row.item(:mnth07).style(:color, '#0000ff') if eq_min(el07, mnth07)
          row.item(:mnth08).style(:color, '#0000ff') if eq_min(el08, mnth08)
          row.item(:mnth09).style(:color, '#0000ff') if eq_min(el09, mnth09)
          row.item(:mnth10).style(:color, '#0000ff') if eq_min(el10, mnth10)
          row.item(:mnth11).style(:color, '#0000ff') if eq_min(el11, mnth11)
          row.item(:mnth12).style(:color, '#0000ff') if eq_min(el12, mnth12)
          row.item(:mnth01).style(:color, '#0000ff') if eq_min(el01, mnth01)
          row.item(:mnth02).style(:color, '#0000ff') if eq_min(el02, mnth02)
          row.item(:mnth03).style(:color, '#0000ff') if eq_min(el03, mnth03)

          row.item(:mnth04).style(:color, '#ff0000') if eq_max(el04, mnth04)
          row.item(:mnth05).style(:color, '#ff0000') if eq_max(el05, mnth05)
          row.item(:mnth06).style(:color, '#ff0000') if eq_max(el06, mnth06)
          row.item(:mnth07).style(:color, '#ff0000') if eq_max(el07, mnth07)
          row.item(:mnth08).style(:color, '#ff0000') if eq_max(el08, mnth08)
          row.item(:mnth09).style(:color, '#ff0000') if eq_max(el09, mnth09)
          row.item(:mnth10).style(:color, '#ff0000') if eq_max(el10, mnth10)
          row.item(:mnth11).style(:color, '#ff0000') if eq_max(el11, mnth11)
          row.item(:mnth12).style(:color, '#ff0000') if eq_max(el12, mnth12)
          row.item(:mnth01).style(:color, '#ff0000') if eq_max(el01, mnth01)
          row.item(:mnth02).style(:color, '#ff0000') if eq_max(el02, mnth02)
          row.item(:mnth03).style(:color, '#ff0000') if eq_max(el03, mnth03)
         end
      end
    end

    # --------------------------------------------------
    # ガス代
    # --------------------------------------------------
    report.start_new_page
    report.page.item(:title).value("ガス代")
    gs04 = get_energies_by_month(energies, :gs, "mnth04")
    gs05 = get_energies_by_month(energies, :gs, "mnth05")
    gs06 = get_energies_by_month(energies, :gs, "mnth06")
    gs07 = get_energies_by_month(energies, :gs, "mnth07")
    gs08 = get_energies_by_month(energies, :gs, "mnth08")
    gs09 = get_energies_by_month(energies, :gs, "mnth09")
    gs10 = get_energies_by_month(energies, :gs, "mnth10")
    gs11 = get_energies_by_month(energies, :gs, "mnth11")
    gs12 = get_energies_by_month(energies, :gs, "mnth12")
    gs01 = get_energies_by_month(energies, :gs, "mnth01")
    gs02 = get_energies_by_month(energies, :gs, "mnth02")
    gs03 = get_energies_by_month(energies, :gs, "mnth03")

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
          list.store.min[:mnth04] = footer_min(gs04)
          list.store.min[:mnth05] = footer_min(gs05)
          list.store.min[:mnth06] = footer_min(gs06)
          list.store.min[:mnth07] = footer_min(gs07)
          list.store.min[:mnth08] = footer_min(gs08)
          list.store.min[:mnth09] = footer_min(gs09)
          list.store.min[:mnth10] = footer_min(gs10)
          list.store.min[:mnth11] = footer_min(gs11)
          list.store.min[:mnth12] = footer_min(gs12)
          list.store.min[:mnth01] = footer_min(gs01)
          list.store.min[:mnth02] = footer_min(gs02)
          list.store.min[:mnth03] = footer_min(gs03)

          list.store.ave[:mnth04] = footer_ave(gs04)
          list.store.ave[:mnth05] = footer_ave(gs05)
          list.store.ave[:mnth06] = footer_ave(gs06)
          list.store.ave[:mnth07] = footer_ave(gs07)
          list.store.ave[:mnth08] = footer_ave(gs08)
          list.store.ave[:mnth09] = footer_ave(gs09)
          list.store.ave[:mnth10] = footer_ave(gs10)
          list.store.ave[:mnth11] = footer_ave(gs11)
          list.store.ave[:mnth12] = footer_ave(gs12)
          list.store.ave[:mnth01] = footer_ave(gs01)
          list.store.ave[:mnth02] = footer_ave(gs02)
          list.store.ave[:mnth03] = footer_ave(gs03)

          list.store.max[:mnth04] = footer_max(gs04)
          list.store.max[:mnth05] = footer_max(gs05)
          list.store.max[:mnth06] = footer_max(gs06)
          list.store.max[:mnth07] = footer_max(gs07)
          list.store.max[:mnth08] = footer_max(gs08)
          list.store.max[:mnth09] = footer_max(gs09)
          list.store.max[:mnth10] = footer_max(gs10)
          list.store.max[:mnth11] = footer_max(gs11)
          list.store.max[:mnth12] = footer_max(gs12)
          list.store.max[:mnth01] = footer_max(gs01)
          list.store.max[:mnth02] = footer_max(gs02)
          list.store.max[:mnth03] = footer_max(gs03)
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

          row.item(:mnth04).style(:color, '#0000ff') if eq_min(gs04, mnth04)
          row.item(:mnth05).style(:color, '#0000ff') if eq_min(gs05, mnth05)
          row.item(:mnth06).style(:color, '#0000ff') if eq_min(gs06, mnth06)
          row.item(:mnth07).style(:color, '#0000ff') if eq_min(gs07, mnth07)
          row.item(:mnth08).style(:color, '#0000ff') if eq_min(gs08, mnth08)
          row.item(:mnth09).style(:color, '#0000ff') if eq_min(gs09, mnth09)
          row.item(:mnth10).style(:color, '#0000ff') if eq_min(gs10, mnth10)
          row.item(:mnth11).style(:color, '#0000ff') if eq_min(gs11, mnth11)
          row.item(:mnth12).style(:color, '#0000ff') if eq_min(gs12, mnth12)
          row.item(:mnth01).style(:color, '#0000ff') if eq_min(gs01, mnth01)
          row.item(:mnth02).style(:color, '#0000ff') if eq_min(gs02, mnth02)
          row.item(:mnth03).style(:color, '#0000ff') if eq_min(gs03, mnth03)

          row.item(:mnth04).style(:color, '#ff0000') if eq_max(gs04, mnth04)
          row.item(:mnth05).style(:color, '#ff0000') if eq_max(gs05, mnth05)
          row.item(:mnth06).style(:color, '#ff0000') if eq_max(gs06, mnth06)
          row.item(:mnth07).style(:color, '#ff0000') if eq_max(gs07, mnth07)
          row.item(:mnth08).style(:color, '#ff0000') if eq_max(gs08, mnth08)
          row.item(:mnth09).style(:color, '#ff0000') if eq_max(gs09, mnth09)
          row.item(:mnth10).style(:color, '#ff0000') if eq_max(gs10, mnth10)
          row.item(:mnth11).style(:color, '#ff0000') if eq_max(gs11, mnth11)
          row.item(:mnth12).style(:color, '#ff0000') if eq_max(gs12, mnth12)
          row.item(:mnth01).style(:color, '#ff0000') if eq_max(gs01, mnth01)
          row.item(:mnth02).style(:color, '#ff0000') if eq_max(gs02, mnth02)
          row.item(:mnth03).style(:color, '#ff0000') if eq_max(gs03, mnth03)
         end
      end
    end

    # --------------------------------------------------
    # 水道代
    # --------------------------------------------------
    report.start_new_page
    report.page.item(:title).value("水道代")
    wt04 = get_energies_by_month(energies, :wt, "mnth04")
    wt05 = get_energies_by_month(energies, :wt, "mnth05")
    wt06 = get_energies_by_month(energies, :wt, "mnth06")
    wt07 = get_energies_by_month(energies, :wt, "mnth07")
    wt08 = get_energies_by_month(energies, :wt, "mnth08")
    wt09 = get_energies_by_month(energies, :wt, "mnth09")
    wt10 = get_energies_by_month(energies, :wt, "mnth10")
    wt11 = get_energies_by_month(energies, :wt, "mnth11")
    wt12 = get_energies_by_month(energies, :wt, "mnth12")
    wt01 = get_energies_by_month(energies, :wt, "mnth01")
    wt02 = get_energies_by_month(energies, :wt, "mnth02")
    wt03 = get_energies_by_month(energies, :wt, "mnth03")

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
          list.store.min[:mnth04] = footer_min(wt04)
          list.store.min[:mnth05] = footer_min(wt05)
          list.store.min[:mnth06] = footer_min(wt06)
          list.store.min[:mnth07] = footer_min(wt07)
          list.store.min[:mnth08] = footer_min(wt08)
          list.store.min[:mnth09] = footer_min(wt09)
          list.store.min[:mnth10] = footer_min(wt10)
          list.store.min[:mnth11] = footer_min(wt11)
          list.store.min[:mnth12] = footer_min(wt12)
          list.store.min[:mnth01] = footer_min(wt01)
          list.store.min[:mnth02] = footer_min(wt02)
          list.store.min[:mnth03] = footer_min(wt03)

          list.store.ave[:mnth04] = footer_ave(wt04)
          list.store.ave[:mnth05] = footer_ave(wt05)
          list.store.ave[:mnth06] = footer_ave(wt06)
          list.store.ave[:mnth07] = footer_ave(wt07)
          list.store.ave[:mnth08] = footer_ave(wt08)
          list.store.ave[:mnth09] = footer_ave(wt09)
          list.store.ave[:mnth10] = footer_ave(wt10)
          list.store.ave[:mnth11] = footer_ave(wt11)
          list.store.ave[:mnth12] = footer_ave(wt12)
          list.store.ave[:mnth01] = footer_ave(wt01)
          list.store.ave[:mnth02] = footer_ave(wt02)
          list.store.ave[:mnth03] = footer_ave(wt03)

          list.store.max[:mnth04] = footer_max(wt04)
          list.store.max[:mnth05] = footer_max(wt05)
          list.store.max[:mnth06] = footer_max(wt06)
          list.store.max[:mnth07] = footer_max(wt07)
          list.store.max[:mnth08] = footer_max(wt08)
          list.store.max[:mnth09] = footer_max(wt09)
          list.store.max[:mnth10] = footer_max(wt10)
          list.store.max[:mnth11] = footer_max(wt11)
          list.store.max[:mnth12] = footer_max(wt12)
          list.store.max[:mnth01] = footer_max(wt01)
          list.store.max[:mnth02] = footer_max(wt02)
          list.store.max[:mnth03] = footer_max(wt03)
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

          row.item(:mnth04).style(:color, '#0000ff') if eq_min(wt04, mnth04)
          row.item(:mnth05).style(:color, '#0000ff') if eq_min(wt05, mnth05)
          row.item(:mnth06).style(:color, '#0000ff') if eq_min(wt06, mnth06)
          row.item(:mnth07).style(:color, '#0000ff') if eq_min(wt07, mnth07)
          row.item(:mnth08).style(:color, '#0000ff') if eq_min(wt08, mnth08)
          row.item(:mnth09).style(:color, '#0000ff') if eq_min(wt09, mnth09)
          row.item(:mnth10).style(:color, '#0000ff') if eq_min(wt10, mnth10)
          row.item(:mnth11).style(:color, '#0000ff') if eq_min(wt11, mnth11)
          row.item(:mnth12).style(:color, '#0000ff') if eq_min(wt12, mnth12)
          row.item(:mnth01).style(:color, '#0000ff') if eq_min(wt01, mnth01)
          row.item(:mnth02).style(:color, '#0000ff') if eq_min(wt02, mnth02)
          row.item(:mnth03).style(:color, '#0000ff') if eq_min(wt03, mnth03)

          row.item(:mnth04).style(:color, '#ff0000') if eq_max(wt04, mnth04)
          row.item(:mnth05).style(:color, '#ff0000') if eq_max(wt05, mnth05)
          row.item(:mnth06).style(:color, '#ff0000') if eq_max(wt06, mnth06)
          row.item(:mnth07).style(:color, '#ff0000') if eq_max(wt07, mnth07)
          row.item(:mnth08).style(:color, '#ff0000') if eq_max(wt08, mnth08)
          row.item(:mnth09).style(:color, '#ff0000') if eq_max(wt09, mnth09)
          row.item(:mnth10).style(:color, '#ff0000') if eq_max(wt10, mnth10)
          row.item(:mnth11).style(:color, '#ff0000') if eq_max(wt11, mnth11)
          row.item(:mnth12).style(:color, '#ff0000') if eq_max(wt12, mnth12)
          row.item(:mnth01).style(:color, '#ff0000') if eq_max(wt01, mnth01)
          row.item(:mnth02).style(:color, '#ff0000') if eq_max(wt02, mnth02)
          row.item(:mnth03).style(:color, '#ff0000') if eq_max(wt03, mnth03)
         end
      end
    end

    return report
  end

end
