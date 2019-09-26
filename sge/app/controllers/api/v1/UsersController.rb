## curl -v -X POST -H "Content-Type: application/json" -c token -d '{"login":"mtsealves","email":"emmanoelcoelholima@gmail.com","password":"asdasd"}' http://localhost:3000/api/v1/login
## curl -v -b token http://localhost:3000/api/v1/usuarios

module Api
    module V1
        class UsersController < ApplicationController   
            def index
                users = User.order('created_at DESC');

                if users.blank?
                    render json: {status: 'SUCCESS', message: I18n.t('messages.users.none')}, status: :ok
                else
                    render json: {status: 'SUCCESS', message: I18n.t('messages.users.loaded'), data: users}, status: :ok
                end
            end

            def create
                user = User.new(user_params)

                if user.password.blank?
                    user.errors.add(:password, I18n.t('errors.messages.blank'))
                end

                if user.errors.size == 0 && user.save
                  render json: user, status: :created
                else
                  render json: { errors: user.errors.full_messages },
                         status: :unprocessable_entity
                end
            end

            def login
                user = User.find_by(login: params[:login])

                if user.authenticate(params[:password])
                    token = SecureRandom.hex(30)
            
                    response.set_cookie(
                        :token,
                        {
                            value: token,
                            expires: 1.minutes.from_now,
                            path: '/api',
                            secure: Rails.env.production?,
                            httponly: Rails.env.production?
                        }
                    )

                    @@logados[token] = {login: user.login, referrer: request.referrer, origem: request.headers[:x_forwarded_for] || request.remote_ip}

                    logger.info "Efetuando login do usuário #{@@logados[token]}"

                    render json: {status: 'SUCCESS', message: 'Usuário localizado'}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Nenhum usuário localizado'}, status: :unauthorized
                end
            end

            def logout
                logger.info "Efetuando logout do usuário #{@@logados[request.cookies["token"]]}"

                render json: {status: 'SUCCESS', message: 'Logout realizado'}, status: :ok
            end

            private    
            def user_params
                params.permit(:login, :password, :email)
            end
        end
    end
end