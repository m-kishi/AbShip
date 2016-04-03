require 'test_helper'

# ======================================================================
# Auth コントローラのテスト
# ======================================================================
class AuthControllerTest < ActionController::TestCase

  # ------------------------------------------------------------
  # routing '/login'
  # ------------------------------------------------------------
  test "should route to login" do
    assert_routing '/login', controller: 'auth', action: 'new'
    assert_routing login_path, controller: 'auth', action: 'new'
  end

  # ------------------------------------------------------------
  # routing '/logout'
  # ------------------------------------------------------------
  test "should route to logout" do
    assert_routing({ method: 'post', path: '/logout'   }, { controller: 'auth', action: 'destroy' })
    assert_routing({ method: 'post', path: logout_path }, { controller: 'auth', action: 'destroy' })
  end

  # ------------------------------------------------------------
  # routing '/auth'
  # ------------------------------------------------------------
  test "should route to create" do
    assert_routing({ method: 'post', path: 'auth' }, { controller: 'auth', action: 'create' })
  end

  # ------------------------------------------------------------
  # routing '/auth/:id'
  # ------------------------------------------------------------
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: '/auth/1' }, { controller: 'auth', action: 'destroy', id: '1' })
  end

  # ------------------------------------------------------------
  # action new
  # ------------------------------------------------------------
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  # ------------------------------------------------------------
  # action create
  # ------------------------------------------------------------
  test "should post create with success" do
    # アクション実行
    post :create, mail: 'kishi@example.com', password: 'kishi@example.com'

    # ログインできた
    assert logged_in?

    # ユーザの確認
    assert_not_nil assigns(:user)

    # 支出画面へリダイレクト
    assert_redirected_to expense_path(year: Date.today.year, mnth: Date.today.month)
  end

  # ------------------------------------------------------------
  # action create
  # ------------------------------------------------------------
  test "should post create with failure" do
    # アクション実行
    post :create, mail: 'kishi@example.com', password: 'incorrect'

    # ログイン失敗
    assert_not logged_in?

    # ユーザの確認(nil)
    assert_nil assigns(:user)

    # メッセージを確認
    assert_equal 'Login failed.', flash[:alert]
  end

  # ------------------------------------------------------------
  # action destroy
  # ------------------------------------------------------------
  test "should delete destroy" do
    # ログイン
    @user = users(:kishi)
    login_user @user, '/auth'

    # ログインできた
    assert logged_in?

    # アクション実行
    post :destroy, id: @user.id

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # ログアウトした
    assert_not logged_in?

    # メッセージを確認
    assert_equal 'Logged out.', flash[:notice]
  end

  # ------------------------------------------------------------
  # render new
  # ------------------------------------------------------------
  test "new should render correct template and layout" do
    get :new
    assert_template :new
    assert_template layout: 'layouts/application', partial: '_form'
  end

  # ------------------------------------------------------------
  # render new
  # ------------------------------------------------------------
  test "create with failure should render correct template and layout" do
    post :create, mail: 'kishi@example.com', password: 'incorrect'
    assert_template :new
    assert_template layout: 'layouts/application', partial: '_form'
  end

  # ------------------------------------------------------------
  # new page
  # ------------------------------------------------------------
  test "title of new page should 'Login'" do
    get :new
    assert_select 'h1.title', 'Login'
  end

  # ------------------------------------------------------------
  # require_login destroy
  # ------------------------------------------------------------
  test "destroy should require login" do
    # 未ログイン
    assert_not logged_in?

    # アクション実行
    delete :destroy, id: 0

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

end
