module Api
  module V1

    class ApiController < ApplicationController
      before_action :require_valid_token
      skip_before_filter :require_login
      skip_before_filter :require_valid_token, only: :create

      protect_from_forgery except: [ :create, :upload ]

      def create
        if @user = login(params[:mail], params[:pass])
          api_key = @user.activate
          @access_token = api_key.token
          # ok
          render text: @access_token, status: 200
        else
          # not found
          render text: '', status: 404
        end
      end

      def upload
        file = params[:file]
        token = request.headers[:HTTP_ACCESS_TOKEN]
        if file.blank?
          # internal server error
          render text: 'DB date nothing.', status: 500
        else
          @user = User.find_by_token(token)
          begin
            importer = Importer.new(@user)
            importer.import(file)
          rescue => ex
            # internal server error
            render text: ex.message, status: 500
          else
            # ok
            render text: '', status: 200
          end
        end
      end

      private
      def require_valid_token
        token = request.headers[:HTTP_ACCESS_TOKEN]
        if !User.login?(token)
          render text: '', status: :unauthorized
        end
      end

    end

  end
end
