class EnergiePdf
  extend CostHelper
  extend EngyHelper

  def self.create(energies)
    report = Thinreports::Report.new layout: "app/reports/energie.tlf"
    print_new_page(report, energies, :el)
    print_new_page(report, energies, :gs)
    print_new_page(report, energies, :wt)

    return report
  end

  def self.print_new_page(report, energies, sym)
    report.start_new_page

    title = { el: "電気代", gs: "ガス代", wt: "水道代"}[sym]
    report.page.item(:title).value = title

    report.list(:energie_list) do |list|

      min = Hash.new(0)
      ave = Hash.new(0)
      max = Hash.new(0)

      list.on_footer_insert do |footer|
        footer.item(:min04).value = to_currency(min[:mnth04])
        footer.item(:min05).value = to_currency(min[:mnth05])
        footer.item(:min06).value = to_currency(min[:mnth06])
        footer.item(:min07).value = to_currency(min[:mnth07])
        footer.item(:min08).value = to_currency(min[:mnth08])
        footer.item(:min09).value = to_currency(min[:mnth09])
        footer.item(:min10).value = to_currency(min[:mnth10])
        footer.item(:min11).value = to_currency(min[:mnth11])
        footer.item(:min12).value = to_currency(min[:mnth12])
        footer.item(:min01).value = to_currency(min[:mnth01])
        footer.item(:min02).value = to_currency(min[:mnth02])
        footer.item(:min03).value = to_currency(min[:mnth03])

        footer.item(:ave04).value = to_currency(ave[:mnth04])
        footer.item(:ave05).value = to_currency(ave[:mnth05])
        footer.item(:ave06).value = to_currency(ave[:mnth06])
        footer.item(:ave07).value = to_currency(ave[:mnth07])
        footer.item(:ave08).value = to_currency(ave[:mnth08])
        footer.item(:ave09).value = to_currency(ave[:mnth09])
        footer.item(:ave10).value = to_currency(ave[:mnth10])
        footer.item(:ave11).value = to_currency(ave[:mnth11])
        footer.item(:ave12).value = to_currency(ave[:mnth12])
        footer.item(:ave01).value = to_currency(ave[:mnth01])
        footer.item(:ave02).value = to_currency(ave[:mnth02])
        footer.item(:ave03).value = to_currency(ave[:mnth03])

        footer.item(:max04).value = to_currency(max[:mnth04])
        footer.item(:max05).value = to_currency(max[:mnth05])
        footer.item(:max06).value = to_currency(max[:mnth06])
        footer.item(:max07).value = to_currency(max[:mnth07])
        footer.item(:max08).value = to_currency(max[:mnth08])
        footer.item(:max09).value = to_currency(max[:mnth09])
        footer.item(:max10).value = to_currency(max[:mnth10])
        footer.item(:max11).value = to_currency(max[:mnth11])
        footer.item(:max12).value = to_currency(max[:mnth12])
        footer.item(:max01).value = to_currency(max[:mnth01])
        footer.item(:max02).value = to_currency(max[:mnth02])
        footer.item(:max03).value = to_currency(max[:mnth03])
      end

      cost04 = get_energies_by_month(energies, sym, "mnth04")
      cost05 = get_energies_by_month(energies, sym, "mnth05")
      cost06 = get_energies_by_month(energies, sym, "mnth06")
      cost07 = get_energies_by_month(energies, sym, "mnth07")
      cost08 = get_energies_by_month(energies, sym, "mnth08")
      cost09 = get_energies_by_month(energies, sym, "mnth09")
      cost10 = get_energies_by_month(energies, sym, "mnth10")
      cost11 = get_energies_by_month(energies, sym, "mnth11")
      cost12 = get_energies_by_month(energies, sym, "mnth12")
      cost01 = get_energies_by_month(energies, sym, "mnth01")
      cost02 = get_energies_by_month(energies, sym, "mnth02")
      cost03 = get_energies_by_month(energies, sym, "mnth03")

      min[:mnth04] = footer_min(cost04);  ave[:mnth04] = footer_ave(cost04);  max[:mnth04] = footer_max(cost04)
      min[:mnth05] = footer_min(cost05);  ave[:mnth05] = footer_ave(cost05);  max[:mnth05] = footer_max(cost05)
      min[:mnth06] = footer_min(cost06);  ave[:mnth06] = footer_ave(cost06);  max[:mnth06] = footer_max(cost06)
      min[:mnth07] = footer_min(cost07);  ave[:mnth07] = footer_ave(cost07);  max[:mnth07] = footer_max(cost07)
      min[:mnth08] = footer_min(cost08);  ave[:mnth08] = footer_ave(cost08);  max[:mnth08] = footer_max(cost08)
      min[:mnth09] = footer_min(cost09);  ave[:mnth09] = footer_ave(cost09);  max[:mnth09] = footer_max(cost09)
      min[:mnth10] = footer_min(cost10);  ave[:mnth10] = footer_ave(cost10);  max[:mnth10] = footer_max(cost10)
      min[:mnth11] = footer_min(cost11);  ave[:mnth11] = footer_ave(cost11);  max[:mnth11] = footer_max(cost11)
      min[:mnth12] = footer_min(cost12);  ave[:mnth12] = footer_ave(cost12);  max[:mnth12] = footer_max(cost12)
      min[:mnth01] = footer_min(cost01);  ave[:mnth01] = footer_ave(cost01);  max[:mnth01] = footer_max(cost01)
      min[:mnth02] = footer_min(cost02);  ave[:mnth02] = footer_ave(cost02);  max[:mnth02] = footer_max(cost02)
      min[:mnth03] = footer_min(cost03);  ave[:mnth03] = footer_ave(cost03);  max[:mnth03] = footer_max(cost03)

      energies[sym].each do |energy|
        year   = energy["year"]
        mnth04 = energy["mnth04"]
        mnth05 = energy["mnth05"]
        mnth06 = energy["mnth06"]
        mnth07 = energy["mnth07"]
        mnth08 = energy["mnth08"]
        mnth09 = energy["mnth09"]
        mnth10 = energy["mnth10"]
        mnth11 = energy["mnth11"]
        mnth12 = energy["mnth12"]
        mnth01 = energy["mnth01"]
        mnth02 = energy["mnth02"]
        mnth03 = energy["mnth03"]

        list.add_row do |row|
          row.item(:year  ).value = year
          row.item(:mnth04).value = to_currency(mnth04)
          row.item(:mnth05).value = to_currency(mnth05)
          row.item(:mnth06).value = to_currency(mnth06)
          row.item(:mnth07).value = to_currency(mnth07)
          row.item(:mnth08).value = to_currency(mnth08)
          row.item(:mnth09).value = to_currency(mnth09)
          row.item(:mnth10).value = to_currency(mnth10)
          row.item(:mnth11).value = to_currency(mnth11)
          row.item(:mnth12).value = to_currency(mnth12)
          row.item(:mnth01).value = to_currency(mnth01)
          row.item(:mnth02).value = to_currency(mnth02)
          row.item(:mnth03).value = to_currency(mnth03)

          row.item(:mnth04).style(:color, '#0000ff') if eq_min(cost04, mnth04)
          row.item(:mnth05).style(:color, '#0000ff') if eq_min(cost05, mnth05)
          row.item(:mnth06).style(:color, '#0000ff') if eq_min(cost06, mnth06)
          row.item(:mnth07).style(:color, '#0000ff') if eq_min(cost07, mnth07)
          row.item(:mnth08).style(:color, '#0000ff') if eq_min(cost08, mnth08)
          row.item(:mnth09).style(:color, '#0000ff') if eq_min(cost09, mnth09)
          row.item(:mnth10).style(:color, '#0000ff') if eq_min(cost10, mnth10)
          row.item(:mnth11).style(:color, '#0000ff') if eq_min(cost11, mnth11)
          row.item(:mnth12).style(:color, '#0000ff') if eq_min(cost12, mnth12)
          row.item(:mnth01).style(:color, '#0000ff') if eq_min(cost01, mnth01)
          row.item(:mnth02).style(:color, '#0000ff') if eq_min(cost02, mnth02)
          row.item(:mnth03).style(:color, '#0000ff') if eq_min(cost03, mnth03)

          row.item(:mnth04).style(:color, '#ff0000') if eq_max(cost04, mnth04)
          row.item(:mnth05).style(:color, '#ff0000') if eq_max(cost05, mnth05)
          row.item(:mnth06).style(:color, '#ff0000') if eq_max(cost06, mnth06)
          row.item(:mnth07).style(:color, '#ff0000') if eq_max(cost07, mnth07)
          row.item(:mnth08).style(:color, '#ff0000') if eq_max(cost08, mnth08)
          row.item(:mnth09).style(:color, '#ff0000') if eq_max(cost09, mnth09)
          row.item(:mnth10).style(:color, '#ff0000') if eq_max(cost10, mnth10)
          row.item(:mnth11).style(:color, '#ff0000') if eq_max(cost11, mnth11)
          row.item(:mnth12).style(:color, '#ff0000') if eq_max(cost12, mnth12)
          row.item(:mnth01).style(:color, '#ff0000') if eq_max(cost01, mnth01)
          row.item(:mnth02).style(:color, '#ff0000') if eq_max(cost02, mnth02)
          row.item(:mnth03).style(:color, '#ff0000') if eq_max(cost03, mnth03)
        end
      end
    end
  end

end
