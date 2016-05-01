require 'test_helper'

# ======================================================================
# Ship コントローラのテスト
# ======================================================================
class ShipControllerTest < ActionController::TestCase

  def setup
    @user = users(:kishi)
    login_user @user, '/auth'
  end

  # ------------------------------------------------------------
  # routing '/ship/expense'
  # ------------------------------------------------------------
  test "should route to expense" do
    # rootと被っているため assert_routing は使えない
    assert_recognizes({ controller: 'ship', action: 'expense' }, expense_path)
    assert_recognizes({ controller: 'ship', action: 'expense' }, '/ship/expense')
  end

  # ------------------------------------------------------------
  # routing '/ship/summary'
  # ------------------------------------------------------------
  test "should route to summary" do
    assert_routing summary_path   , controller: 'ship', action: 'summary'
    assert_routing '/ship/summary', controller: 'ship', action: 'summary'
  end

  # ------------------------------------------------------------
  # routing '/ship/graphic'
  # ------------------------------------------------------------
  test "should route to graphic" do
    assert_routing graphic_path   , controller: 'ship', action: 'graphic'
    assert_routing '/ship/graphic', controller: 'ship', action: 'graphic'
  end

  # ------------------------------------------------------------
  # routing '/ship/balance'
  # ------------------------------------------------------------
  test "should route to balance" do
    assert_routing balance_path   , controller: 'ship', action: 'balance'
    assert_routing '/ship/balance', controller: 'ship', action: 'balance'
  end

  # ------------------------------------------------------------
  # routing '/ship/private'
  # ------------------------------------------------------------
  test "should route to private" do
    assert_routing private_path   , controller: 'ship', action: 'private'
    assert_routing '/ship/private', controller: 'ship', action: 'private'
  end

  # ------------------------------------------------------------
  # routing '/ship/uploads'
  # ------------------------------------------------------------
  test "should route to uploads" do
    assert_routing uploads_path   , controller: 'ship', action: 'uploads'
    assert_routing '/ship/uploads', controller: 'ship', action: 'uploads'
  end

  # ------------------------------------------------------------
  # routing '/ship/imports'
  # ------------------------------------------------------------
  test "should route to imports" do
    assert_routing({ method: 'post', path: imports_path    }, { controller: 'ship', action: 'imports' })
    assert_routing({ method: 'post', path: '/ship/imports' }, { controller: 'ship', action: 'imports' })
  end

  # ------------------------------------------------------------
  # routing '/ship/pdf/summary
  # ------------------------------------------------------------
  test "should route to summary_pdf" do
    assert_routing summary_pdf_path   , controller: 'ship', action: 'summary_pdf'
    assert_routing '/ship/pdf/summary', controller: 'ship', action: 'summary_pdf'
  end

  # ------------------------------------------------------------
  # routing '/ship/pdf/balance
  # ------------------------------------------------------------
  test "should route to balance_pdf" do
    assert_routing balance_pdf_path   , controller: 'ship', action: 'balance_pdf'
    assert_routing '/ship/pdf/balance', controller: 'ship', action: 'balance_pdf'
  end

  # ------------------------------------------------------------
  # routing '/ship/pdf/energie
  # ------------------------------------------------------------
  test "should route to energie_pdf" do
    assert_routing energie_pdf_path   , controller: 'ship', action: 'energie_pdf'
    assert_routing '/ship/pdf/energie', controller: 'ship', action: 'energie_pdf'
  end


  # ------------------------------------------------------------
  # action expense
  # ------------------------------------------------------------
  test "should get expense" do
    get :expense, year: 2015, mnth: 11
    assert_response :success
    assert_not_nil assigns(:expense)
    assert_not_nil assigns(:expenses)
    assert assigns(:expense_selected)
  end

  # ------------------------------------------------------------
  # action summary
  # ------------------------------------------------------------
  test "should get summary" do
    get :summary, year: 2015, mnth: 11
    assert_response :success
    assert_not_nil assigns(:summary)
    assert assigns(:summary_selected)
  end

  # ------------------------------------------------------------
  # action graphic
  # ------------------------------------------------------------
  test "should get graphic" do
    get :graphic, year: 2015, mnth: 11
    assert_response :success
    assert_not_nil assigns(:graphic)
    assert_not_nil assigns(:graphics)
    assert assigns(:graphic_selected)
  end

  # ------------------------------------------------------------
  # action balance
  # ------------------------------------------------------------
  test "should get balance" do
    get :balance
    assert_response :success
    assert_not_nil assigns(:balances)
    assert assigns(:balance_selected)
  end

  # ------------------------------------------------------------
  # action private
  # ------------------------------------------------------------
  test "should get private" do
    get :private
    assert_response :success
    assert_not_nil assigns(:privates)
    assert assigns(:private_selected)
  end

  # ------------------------------------------------------------
  # action uploads
  # ------------------------------------------------------------
  test "should get uploads" do
    get :uploads
    assert_response :success
    assert assigns(:uploads_selected)
  end

  # ------------------------------------------------------------
  # action imports
  # ------------------------------------------------------------
  test "should post imports with blank file" do
    post :imports, file: ''
    assert assigns(:uploads_selected)

    # メッセージを確認
    assert_equal 'DB file not selected.', flash[:alert]
  end

  # ------------------------------------------------------------
  # action imports
  # ------------------------------------------------------------
  test "should post imports with success" do
    # ファイルパスは"test/fixtures"配下から
    post :imports, file: fixture_file_upload('db/success.db', 'text/plain')
    assert_not assigns(:uploads_selected)

    # 取り込み件数の確認
    assert_equal 6991, Expense.where(user_id: @user.id).count
    assert_equal   60, Summary.where(user_id: @user.id).count
    assert_equal   60, Graphic.where(user_id: @user.id).count
    assert_equal    6, Balance.where(user_id: @user.id).count
    assert_equal   34, Private.where(user_id: @user.id).count

    # 支出一覧ページへリダイレクト
    assert_redirected_to expense_path(year: Date.today.year, mnth: Date.today.month)
  end

  # ------------------------------------------------------------
  # action uploads
  # ------------------------------------------------------------
  test "should post imports with failure" do
    post :imports, file: fixture_file_upload('db/failure.db', 'text/plain')
    assert assigns(:uploads_selected)

    # メッセージを確認
    assert_match /.+ is out of range for .+/, flash[:alert]
  end

  # ------------------------------------------------------------
  # action summary_pdf
  # ------------------------------------------------------------
  test "should get summary_pdf with no data" do
    @user.summaries.delete_all

    get :summary_pdf

    # メッセージを確認
    assert_equal 'No Summaries Data.', flash[:alert]
  end

  # ------------------------------------------------------------
  # action summary_pdf
  # ------------------------------------------------------------
  test "should get summary_pdf with success" do
    get :summary_pdf
    assert_equal 'application/pdf', response.header["Content-Type"]
    assert_equal 'inline; filename="summary.pdf"', response.header["Content-Disposition"]
  end

  # ------------------------------------------------------------
  # action balance_pdf
  # ------------------------------------------------------------
  test "should get balance_pdf with no data" do
    @user.balances.delete_all

    get :balance_pdf

    # メッセージを確認
    assert_equal 'No Balances Data.', flash[:alert]
  end

  # ------------------------------------------------------------
  # action balance_pdf
  # ------------------------------------------------------------
  test "should get balance_pdf with success" do
    get :balance_pdf
    assert_equal 'application/pdf', response.header["Content-Type"]
    assert_equal 'inline; filename="balance.pdf"', response.header["Content-Disposition"]
  end

  # ------------------------------------------------------------
  # action energie_pdf
  # ------------------------------------------------------------
  test "should get energie_pdf with no data" do
    @user.energies.delete_all

    get :energie_pdf

    # メッセージを確認
    assert_equal 'No Energies Data.', flash[:alert]
  end

  # ------------------------------------------------------------
  # action energie_pdf
  # ------------------------------------------------------------
  test "should get energie_pdf with success" do
    get :energie_pdf
    assert_equal 'application/pdf', response.header["Content-Type"]
    assert_equal 'inline; filename="energie.pdf"', response.header["Content-Disposition"]
  end


  # ------------------------------------------------------------
  # render expense
  # ------------------------------------------------------------
  test "expense should render correct template and layout" do
    get :expense, year: 2015, mnth: 11
    assert_template :expense
    assert_template layout: 'layouts/application', partial: '_header'
  end

  # ------------------------------------------------------------
  # expense page
  # ------------------------------------------------------------
  test "title of expense page should 2015-11" do
    get :expense, year: 2015, mnth: 11
    assert_select 'h1.header', '2015年11月'
  end

  # ------------------------------------------------------------
  # render summary
  # ------------------------------------------------------------
  test "summary should render correct template and layout" do
    get :summary, year: 2015, mnth: 11
    assert_template :summary
    assert_template layout: 'layouts/application', partial: '_header'
  end

  # ------------------------------------------------------------
  # summary page
  # ------------------------------------------------------------
  test "title of summary page should 2015-11" do
    get :summary, year: 2015, mnth: 11
    assert_select 'h1.header', '2015年11月'
  end

  # ------------------------------------------------------------
  # render graphic
  # ------------------------------------------------------------
  test "graphic should render correct template and layout" do
    get :graphic, year: 2015, mnth: 11
    assert_template :graphic
    assert_template layout: 'layouts/application', partial: '_header'
  end

  # ------------------------------------------------------------
  # graphic page
  # ------------------------------------------------------------
  test "title of graphic page should '2015-11'" do
    get :graphic, year: 2015, mnth: 11
    assert_select 'h1.header', '2015年11月'
  end

  # ------------------------------------------------------------
  # render balance
  # ------------------------------------------------------------
  test "balance should render correct template and layout" do
    get :balance
    assert_template :balance
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # balance page
  # ------------------------------------------------------------
  test "title of balance page should None" do
    # タイトルなし
    assert true
  end

  # ------------------------------------------------------------
  # render private
  # ------------------------------------------------------------
  test "private should render correct template and layout" do
    get :private
    assert_template :private
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # private page
  # ------------------------------------------------------------
  test "title of private page should None" do
    # タイトルなし
    assert true
  end

  # ------------------------------------------------------------
  # render uploads
  # ------------------------------------------------------------
  test "uploads should render correct template and layout" do
    get :uploads
    assert_template :uploads
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # uploads page
  # ------------------------------------------------------------
  test "title of uploads page should 'Upload'" do
    get :uploads
    assert_select 'h1.title', 'Upload'
  end

  # ------------------------------------------------------------
  # render nothing(summary_pdf)
  # ------------------------------------------------------------
  test "summary_pdf should render correct template and layout" do
    @user.summaries.delete_all

    get :summary_pdf

    assert_template :nothing
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # render nothing(balance_pdf)
  # ------------------------------------------------------------
  test "balance_pdf should render correct template and layout" do
    @user.balances.delete_all

    get :balance_pdf

    assert_template :nothing
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # render nothing(energie_pdf)
  # ------------------------------------------------------------
  test "energie_pdf should render correct template and layout" do
    @user.energies.delete_all

    get :energie_pdf

    assert_template :nothing
    assert_template layout: 'layouts/application'
  end


  # ------------------------------------------------------------
  # require_login expense
  # ------------------------------------------------------------
  test "expense should require login" do
    # ログアウト
    logout_user

    # ログアウト状態
    assert_not logged_in?

    # アクション実行
    get :expense

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login summary
  # ------------------------------------------------------------
  test "summary should require login" do
    logout_user
    assert_not logged_in?

    get :summary
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login graphic
  # ------------------------------------------------------------
  test "graphic should require login" do
    logout_user
    assert_not logged_in?

    get :graphic
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login balance
  # ------------------------------------------------------------
  test "balance should require login" do
    logout_user
    assert_not logged_in?

    get :balance
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login private
  # ------------------------------------------------------------
  test "private should require login" do
    logout_user
    assert_not logged_in?

    get :private
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login uploads
  # ------------------------------------------------------------
  test "uploads should require login" do
    logout_user
    assert_not logged_in?

    get :uploads
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login imports
  # ------------------------------------------------------------
  test "imports should require login" do
    logout_user
    assert_not logged_in?

    post :imports
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login summary_pdf
  # ------------------------------------------------------------
  test "summary_pdf should require login" do
    logout_user
    assert_not logged_in?

    get :summary_pdf
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login balance_pdf
  # ------------------------------------------------------------
  test "balance_pdf should require login" do
    logout_user
    assert_not logged_in?

    get :balance_pdf
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login energie_pdf
  # ------------------------------------------------------------
  test "energie_pdf should require login" do
    logout_user
    assert_not logged_in?

    get :energie_pdf
    assert_redirected_to login_path
    assert_equal 'Please login first.', flash[:alert]
  end

end
