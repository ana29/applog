Rails.application.routes.draw do
    namespace 'api' do
        namespace 'v1' do
            resources :logs
            get 'contexto/:contexto' => 'logs#showByContexto'
            get 'averageMessagesPerHour/:contexto' => 'logs#averageMessagesPerHour'
            get 'maxNumMessages/' => 'logs#maxNumMessages'
            get 'minNumMessages/' => 'logs#minNumMessages'
            get 'amountMessagePerContext/' => 'logs#amountMessagePerContext'
            get 'oldestLog/' => 'logs#oldestLog'
            get 'latestLog/' => 'logs#latestLog'

            get 'maxNumMessagesPerHour/' => 'logs#maxNumMessagesPerHour'
            get 'minNumMessagesPerHour/' => 'logs#minNumMessagesPerHour'

        end
    end
end
