require 'test_helper'

# ======================================================================
# Graphic モデルのテスト
# ======================================================================
class GraphicTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    g001 = graphics(:g001)
    assert_not_nil g001.user
    assert_equal @user.id, g001.user.id
  end

  # ------------------------------------------------------------
  # default_scope
  # ------------------------------------------------------------
  test "default scope with order" do
    prevy = 0
    prevm = 0
    Graphic.all.each do |gph|
      if prevy == gph.year
        assert prevm < gph.mnth
      else
        assert prevy < gph.year
      end
      prevy = gph.year
      prevm = gph.mnth
    end
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get" do
    graphic = Graphic.get(2018, 9)
    assert_equal 2018, graphic.year
    assert_equal    9, graphic.mnth
    assert_equal 1000, graphic.food
    assert_equal 2000, graphic.otfd
    assert_equal 3000, graphic.engy_elc
    assert_equal 4000, graphic.engy_gas
    assert_equal 5000, graphic.engy_wtr
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get with empty" do
    graphic = Graphic.get(2004, 4)
    assert_equal 2004, graphic.year
    assert_equal    4, graphic.mnth
    assert_equal    0, graphic.food
    assert_equal    0, graphic.otfd
    assert_equal    0, graphic.engy_elc
    assert_equal    0, graphic.engy_gas
    assert_equal    0, graphic.engy_wtr
 end

  # ------------------------------------------------------------
  # scope data
  # ------------------------------------------------------------
  test "scope data with in range" do
    data = Graphic.data(2021, 7)
    assert_equal 13, data.length

    assert_equal 2020, data[0].year
    assert_equal    7, data[0].mnth
    assert_equal 2000, data[0].food
    assert_equal 3000, data[0].otfd
    assert_equal 4000, data[0].engy_elc
    assert_equal 5000, data[0].engy_gas
    assert_equal 6000, data[0].engy_wtr

    assert_equal 2020, data[1].year
    assert_equal    8, data[1].mnth
    assert_equal 3000, data[1].food
    assert_equal 4000, data[1].otfd
    assert_equal 5000, data[1].engy_elc
    assert_equal 6000, data[1].engy_gas
    assert_equal 7000, data[1].engy_wtr

    assert_equal 2020, data[2].year
    assert_equal    9, data[2].mnth
    assert_equal 4000, data[2].food
    assert_equal 5000, data[2].otfd
    assert_equal 6000, data[2].engy_elc
    assert_equal 7000, data[2].engy_gas
    assert_equal 8000, data[2].engy_wtr

    assert_equal 2020, data[3].year
    assert_equal   10, data[3].mnth
    assert_equal 5000, data[3].food
    assert_equal 6000, data[3].otfd
    assert_equal 7000, data[3].engy_elc
    assert_equal 8000, data[3].engy_gas
    assert_equal 9000, data[3].engy_wtr

    assert_equal 2020, data[4].year
    assert_equal   11, data[4].mnth
    assert_equal 6000, data[4].food
    assert_equal 7000, data[4].otfd
    assert_equal 8000, data[4].engy_elc
    assert_equal 9000, data[4].engy_gas
    assert_equal 1010, data[4].engy_wtr

    assert_equal 2020, data[5].year
    assert_equal   12, data[5].mnth
    assert_equal 7000, data[5].food
    assert_equal 8000, data[5].otfd
    assert_equal 9000, data[5].engy_elc
    assert_equal 1010, data[5].engy_gas
    assert_equal 2020, data[5].engy_wtr

    assert_equal 2021, data[6].year
    assert_equal    1, data[6].mnth
    assert_equal 8000, data[6].food
    assert_equal 9000, data[6].otfd
    assert_equal 1010, data[6].engy_elc
    assert_equal 2020, data[6].engy_gas
    assert_equal 3030, data[6].engy_wtr

    assert_equal 2021, data[7].year
    assert_equal    2, data[7].mnth
    assert_equal 9000, data[7].food
    assert_equal 1010, data[7].otfd
    assert_equal 2020, data[7].engy_elc
    assert_equal 3030, data[7].engy_gas
    assert_equal 4040, data[7].engy_wtr

    assert_equal 2021, data[8].year
    assert_equal    3, data[8].mnth
    assert_equal 1010, data[8].food
    assert_equal 2020, data[8].otfd
    assert_equal 3030, data[8].engy_elc
    assert_equal 4040, data[8].engy_gas
    assert_equal 5050, data[8].engy_wtr

    assert_equal 2021, data[9].year
    assert_equal    4, data[9].mnth
    assert_equal 2020, data[9].food
    assert_equal 3030, data[9].otfd
    assert_equal 4040, data[9].engy_elc
    assert_equal 5050, data[9].engy_gas
    assert_equal 6060, data[9].engy_wtr

    assert_equal 2021, data[10].year
    assert_equal    5, data[10].mnth
    assert_equal 3030, data[10].food
    assert_equal 4040, data[10].otfd
    assert_equal 5050, data[10].engy_elc
    assert_equal 6060, data[10].engy_gas
    assert_equal 7070, data[10].engy_wtr

    assert_equal 2021, data[11].year
    assert_equal    6, data[11].mnth
    assert_equal 4040, data[11].food
    assert_equal 5050, data[11].otfd
    assert_equal 6060, data[11].engy_elc
    assert_equal 7070, data[11].engy_gas
    assert_equal 8080, data[11].engy_wtr

    assert_equal 2021, data[12].year
    assert_equal    7, data[12].mnth
    assert_equal 5050, data[12].food
    assert_equal 6060, data[12].otfd
    assert_equal 7070, data[12].engy_elc
    assert_equal 8080, data[12].engy_gas
    assert_equal 9090, data[12].engy_wtr

  end

  # ------------------------------------------------------------
  # scope data
  # ------------------------------------------------------------
  test "scope data with not in range" do
    data = Graphic.data(2100, 1)
    assert_equal 13, data.length

    dt = Date.new(2100, 1, 1) - 1.year
    data.each do |d|
      assert_equal dt.year , d.year
      assert_equal dt.month, d.mnth
      assert_equal        0, d.food
      assert_equal        0, d.otfd
      assert_equal        0, d.engy_elc
      assert_equal        0, d.engy_gas
      assert_equal        0, d.engy_wtr

      dt = dt + 1.month
    end
  end

  # ------------------------------------------------------------
  # scope data
  # ------------------------------------------------------------
  test "scope data with include empty" do
    data = Graphic.data(2051, 1)
    assert_equal 13, data.length

    assert_equal 2050, data[2].year
    assert_equal    3, data[2].mnth
    assert_equal    0, data[2].food
    assert_equal    0, data[2].otfd
    assert_equal    0, data[2].engy_elc
    assert_equal    0, data[2].engy_gas
    assert_equal    0, data[2].engy_wtr

    assert_equal 2050, data[5].year
    assert_equal    6, data[5].mnth
    assert_equal    0, data[5].food
    assert_equal    0, data[5].otfd
    assert_equal    0, data[5].engy_elc
    assert_equal    0, data[5].engy_gas
    assert_equal    0, data[5].engy_wtr

    assert_equal 2050, data[8].year
    assert_equal    9, data[8].mnth
    assert_equal    0, data[8].food
    assert_equal    0, data[8].otfd
    assert_equal    0, data[8].engy_elc
    assert_equal    0, data[8].engy_gas
    assert_equal    0, data[8].engy_wtr

    assert_equal 2050, data[11].year
    assert_equal   12, data[11].mnth
    assert_equal    0, data[11].food
    assert_equal    0, data[11].otfd
    assert_equal    0, data[11].engy_elc
    assert_equal    0, data[11].engy_gas
    assert_equal    0, data[11].engy_wtr
  end

  # ------------------------------------------------------------
  # to_title
  # ------------------------------------------------------------
  test "to_title" do
    g001 = graphics(:g001)
    assert_equal "2015年11月", g001.to_title

    g106 = graphics(:g106)
    assert_equal "2017年03月", g106.to_title
  end

end
