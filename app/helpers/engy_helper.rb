module EngyHelper

  #==============================
  # 0より大きい値のみを抽出
  #==============================
  def gt0(list)
    list.select {|item| item > 0 }
  end

  #==============================
  # 該当月の光熱費のリストを返す
  # energies : Energieモデルのリスト
  # engy     : 対象光熱費(シンボル)
  # mnth     : 対象月(文字列)
  #==============================
  def get_energies_by_month(energies, engy, mnth)
    energies[engy].map {|eng| eng[mnth] }
  end

  #==============================
  # 光熱費の最小値を取得
  #==============================
  def footer_min(costs)
    gt0(costs).min || 0
  end

  #==============================
  # 光熱費の平均値を取得
  #==============================
  def footer_ave(costs)
    ((costs.reduce(:+) || 0) / costs.size.to_f).ceil
  end

  #==============================
  # 光熱費の最大値を取得
  #==============================
  def footer_max(costs)
    gt0(costs).max || 0
  end

  #==============================
  # 最小値と等しい(文字色変更用)
  #==============================
  def eq_min(costs, cost)
    # 空なら-1と比較するのは0で最小としたくないため
    cost == (gt0(costs).min || -1)
  end

  #==============================
  # 最大値と等しい(文字色変更用)
  #==============================
  def eq_max(costs, cost)
    # 空なら-1と比較するのは0で最大としたくないため
    cost == (gt0(costs).max || -1)
  end

end
