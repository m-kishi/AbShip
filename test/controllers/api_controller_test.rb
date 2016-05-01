require 'test_helper'

module Api
  module V1

    # ======================================================================
    # API コントローラのテスト
    # ======================================================================
    class ApiControllerTest < ActionController::TestCase

      # ------------------------------------------------------------
      # routing '/api/v1/login'
      # ------------------------------------------------------------
      test "should route to create" do
        assert_routing({ method: 'post', path: '/api/v1/login' }, { controller: 'api/v1/api', action: 'create' })
      end

      # ------------------------------------------------------------
      # routing 'api/v1/upload'
      # ------------------------------------------------------------
      test "should route to upload" do
        assert_routing({ method: 'post', path: '/api/v1/upload' }, { controller: 'api/v1/api', action: 'upload' })
      end

      # ------------------------------------------------------------
      # action create
      # ------------------------------------------------------------
      test "should post create with success" do
        # ログインしてアクセストークンを発行
        params = {
          mail: 'kishi3@example.com',
          pass: 'kishi3@example.com'
        }
        post :create, params

        # レスポンスの検証
        assert_response :success
        assert_not_nil assigns(:user)
        assert_not_nil assigns(:access_token)

        # アクセストークンの検証
        assert_equal "6f6b960c729c81a956d084e0e4e9e758", response.body
      end

      # ------------------------------------------------------------
      # action create
      # ------------------------------------------------------------
      test "should post create with failure" do
        # ログイン失敗
        params = {
          mail: 'kishi3@example.com',
          pass: 'invalid password'
        }
        post :create, params

        # レスポンスの検証
        assert_response :not_found
      end

      # ------------------------------------------------------------
      # action upload
      # ------------------------------------------------------------
      test "should post upload with success" do
        # 送信データ
        file = fixture_file_upload('db/success.db', 'text/plain')

        # HTTPヘッダの設定
        token = users(:kishi3).api_key.token
        @request.headers[:HTTP_ACCESS_TOKEN] = token

        # アップロード
        post :upload, { file: file }

        # レスポンスの検証
        assert_response :success
        assert_equal '', response.body
      end

      # ------------------------------------------------------------
      # action upload
      # ------------------------------------------------------------
      test "should post upload with data nothing" do
        # HTTPヘッダの設定
        token = users(:kishi3).api_key.token
        @request.headers[:HTTP_ACCESS_TOKEN] = token

        # アップロード
        post :upload, { file: '' }

        # レスポンスの検証
        assert_response :internal_server_error
        assert_equal "DB data nothing.", response.body
      end

      # ------------------------------------------------------------
      # action upload
      # ------------------------------------------------------------
      test "should post upload with internal server error" do
        # 送信データ
        file = fixture_file_upload('db/invalid.db', 'text/plain')

        # HTTPヘッダの設定
        token = users(:kishi3).api_key.token
        @request.headers[:HTTP_ACCESS_TOKEN] = token

        # アップロード
        post :upload, { file: file }

        # レスポンスの検証
        assert_response :internal_server_error
        assert_equal "undefined method `force_encoding' for nil:NilClass", response.body
      end

      # ------------------------------------------------------------
      # require_valid_token upload
      # ------------------------------------------------------------
      test "upload should require valid token" do
        # アクション実行
        post :upload, { file: '' }

        # レスポンスの検証
        assert_response :unauthorized
        assert_equal '', response.body
      end

    end

  end
end
