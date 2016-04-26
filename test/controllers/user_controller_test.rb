require 'test_helper'

# ======================================================================
# User コントローラのテスト
# ======================================================================
class UserControllerTest < ActionController::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # routing '/user'
  # ------------------------------------------------------------
  test "should route to index" do
    assert_routing '/user', controller: 'user', action: 'index'
    assert_routing users_path, controller: 'user', action: 'index'
  end

  # ------------------------------------------------------------
  # routing '/user'
  # ------------------------------------------------------------
  test "should route to create" do
    assert_routing({ method: 'post', path: '/user' }, { controller: 'user', action: 'create' })
  end

  # ------------------------------------------------------------
  # routing '/user/new'
  # ------------------------------------------------------------
  test "should route to new" do
    assert_routing '/user/new', controller: 'user', action: 'new'
    assert_routing new_user_path, controller: 'user', action: 'new'
  end

  # ------------------------------------------------------------
  # routing '/user/:id/edit'
  # ------------------------------------------------------------
  test "should route to edit" do
    assert_routing '/user/1/edit', controller: 'user', action: 'edit', id: '1'
    assert_routing edit_user_path(1), controller: 'user', action: 'edit', id: '1'
  end

  # ------------------------------------------------------------
  # routing '/user/:id'
  # ------------------------------------------------------------
  test "should route to update(put)" do
    assert_routing({ method: 'put', path: '/user/1'    }, { controller: 'user', action: 'update', id: '1' })
    assert_routing({ method: 'put', path: user_path(1) }, { controller: 'user', action: 'update', id: '1' })
  end

  # ------------------------------------------------------------
  # routing '/user/:id'
  # ------------------------------------------------------------
  test "should route to update(patch)" do
    assert_routing({ method: 'patch', path: '/user/1' }, { controller: 'user', action: 'update', id: '1' })
  end

  # ------------------------------------------------------------
  # routing '/user/:id'
  # ------------------------------------------------------------
  test "should route to destroy" do
    assert_routing({ method: 'delete', path: '/user/1' }, { controller: 'user', action: 'destroy', id: '1' })
  end

  # ------------------------------------------------------------
  # action index
  # ------------------------------------------------------------
  test "should get index" do
    # ログイン
    login_user @user, '/auth'

    get :index
    assert_response :success
    assert_not_nil assigns(:users)
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
  # action edit
  # ------------------------------------------------------------
  test "should get edit" do
    # ログイン
    login_user @user, '/auth'

    get :edit, id: @user.id
    assert_response :success
    assert_not_nil assigns(:user)
  end

  # ------------------------------------------------------------
  # action create
  # ------------------------------------------------------------
  test "should post create with success" do
    # 件数更新
    assert_difference('User.count') do
      params = {
        mail: 'user1@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      post :create, user: params
    end
    assert_not_nil assigns(:user)

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'User was successfully created.', flash[:notice]
  end

  # ------------------------------------------------------------
  # action create
  # ------------------------------------------------------------
  test "should post create with failure" do
    # 他のテストでそれぞれ確認
    assert true
  end

  # ------------------------------------------------------------
  # action update
  # ------------------------------------------------------------
  test "should put update with success" do
    # ログイン
    login_user @user, '/auth'

    # 件数更新なし
    assert_difference('User.count', 0) do
      params = {
        password: 'password',
        password_confirmation: 'password'
      }
      put :update, id: @user.id, user: params
    end
    assert_not_nil assigns(:user)

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # ログアウトした
    assert_not logged_in?

    # メッセージを確認
    assert_equal 'Please login again.', flash[:notice]
  end

  # ------------------------------------------------------------
  # action update
  # ------------------------------------------------------------
  test "should put update with failure" do
    # 他のテストでそれぞれ確認
    assert true
  end

  # ------------------------------------------------------------
  # action destroy
  # ------------------------------------------------------------
  test "should delete destroy" do
    # ログイン
    login_user @user, '/auth'

    # 件数更新
    assert_difference('User.count', -1) do
      post :destroy, id: @user.id
    end

    # 関連情報の削除
    assert_equal 0, Expense.where(user_id: @user.id).count
    assert_equal 0, Summary.where(user_id: @user.id).count
    assert_equal 0, Graphic.where(user_id: @user.id).count
    assert_equal 0, Balance.where(user_id: @user.id).count
    assert_equal 0, Private.where(user_id: @user.id).count
    assert_equal 0, Energie.where(user_id: @user.id).count

    # ユーザ一覧画面へリダイレクト
    assert_redirected_to users_path

    # メッセージを確認
    assert_equal 'User was successfully destroyed.', flash[:notice]
  end

  # ------------------------------------------------------------
  # render index
  # ------------------------------------------------------------
  test "index should render correct template and layout" do
    # ログイン
    login_user @user, '/auth'

    get :index
    assert_template :index
    assert_template layout: 'layouts/application'
  end

  # ------------------------------------------------------------
  # new index
  # ------------------------------------------------------------
  test "title of index page should None" do
    # ログイン
    login_user @user, '/auth'

    get :index
    assert_select 'a.new-user-link', 'New User'
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
    params = {
      mail: 'user1@example.com',
      password: 'password',
      password_confirmation: 'not match password'
    }
    post :create, user: params
    assert_template :new
    assert_template layout: 'layouts/application', partial: '_form'
  end

  # ------------------------------------------------------------
  # new page
  # ------------------------------------------------------------
  test "title of new page should 'New User'" do
    get :new
    assert_select 'h1.title', 'New User'
  end

  # ------------------------------------------------------------
  # render edit
  # ------------------------------------------------------------
  test "edit should render correct template and layout" do
    # ログイン
    login_user @user, '/auth'

    get :edit, id: @user.id
    assert_template :edit
    assert_template layout: 'layouts/application', partial: '_form'
  end

  # ------------------------------------------------------------
  # render edit
  # ------------------------------------------------------------
  test "update with failure should render correct template and layout" do
    # ログイン
    login_user @user, '/auth'

    params = {
      mail: @user.mail,
      password: 'new password',
      password_confirmation: 'not match password'
    }
    put :update, id: @user.id, user: params
    assert_template :edit
    assert_template layout: 'layouts/application', partial: '_form'
  end

  # ------------------------------------------------------------
  # edit page
  # ------------------------------------------------------------
  test "title of edit page should 'Edit User'" do
    # ログイン
    login_user @user, '/auth'

    get :edit, id: @user.id
    assert_select 'h1.title', 'Edit User'
  end

  # ------------------------------------------------------------
  # require_login index
  # ------------------------------------------------------------
  test "index should require login" do
    # 未ログイン
    assert_not logged_in?

    # アクション実行
    get :index

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login edit
  # ------------------------------------------------------------
  test "edit should require login" do
    # 未ログイン
    assert_not logged_in?

    # アクション実行
    get :edit, id: @user.id

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login update
  # ------------------------------------------------------------
  test "update should require login" do
    # 未ログイン
    assert_not logged_in?

    # アクション実行
    params = {
      mail: @user.mail,
      password: 'new password',
      password_confirmation: 'new password'
    }
    put :update, id: @user.id, user: params

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

  # ------------------------------------------------------------
  # require_login destroy
  # ------------------------------------------------------------
  test "destroy should require login" do
    # 未ログイン
    assert_not logged_in?

    # アクション実行
    delete :destroy, id: @user.id

    # ログインページへリダイレクト
    assert_redirected_to login_path

    # メッセージを確認
    assert_equal 'Please login first.', flash[:alert]
  end

end
