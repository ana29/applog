Rails.application.routes.draw do
    namespace 'api' do
        namespace 'v1' do
            resources :logs
            get 'contexto/:contexto' => 'logs#showByContexto'
            get 'mediaMensagem/:contexto' => 'logs#mediaMensagem'
            get 'maiorNumMensagens/' => 'logs#maiorNumMensagens'
            get 'menorNumMensagens/' => 'logs#menorNumMensagens'

        end
    end
end
