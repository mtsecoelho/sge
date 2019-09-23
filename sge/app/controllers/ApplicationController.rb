class ApplicationController < ActionController::API
    before_action :logout, :only => [:logout]
    before_action :valida_acesso, :except => [:login]
    
    private
    
    @@logados = {}

    def logout 
        token = request.cookies["token"]

        @@logados.delete(token)
    end

    def valida_acesso
        token = request.cookies["token"]
        logado = @@logados[token]

        if token.blank? || logado.blank? || logado[:referrer] != request.referrer || logado[:origem] != (request.headers[:x_forwarded_for] || request.remote_ip)
            logger.info "
            ##### Chamada não autorizada #####
            Origem: #{request.remote_ip}
            Referrer: #{request.referrer}
            Metodo: #{request.request_method}
            URL: #{request.original_url}
            "
            head(401)
        end
    end
end