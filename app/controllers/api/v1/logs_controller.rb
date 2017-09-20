module Api
    module V1
        class LogsController < ApplicationController

            def index
                logs = Log.order('contexto');
                render json: {status: 'SUCCESS', message:'Loaded logs', data:logs},status: :ok
            end

            def create
                log = Log.new(log_params);
                if log.save
                    render json: {status: 'SUCCESS', message:'Saved logs', data:log},status: :ok

                else
                    render json: {status: 'ERROR', message:'Log not save ', data:log.errors},status: :unprocessable_entity

                end

            end

            def show
                log = Log.find(params[:id])
                render json: {status: 'SUCCESS', message:'Loaded log', data:log},status: :ok

            end

            def destroy
                  log = Log.find(params[:id])
                  log.destroy
                  render json: {status: 'SUCCESS', message:'Deleted log', data:log},status: :ok
                end

            def showByContexto
                log = Log.where(contexto: params[:contexto])
                render json: {status: 'SUCCESS', message:'Loaded log', data:log},status: :ok
            end

            def averageMessagesPerHour
                logs = Log.where(contexto: params[:contexto]).order('hora ASC')
                total_messages = logs.size
                averageMsg = total_messages

                if total_messages>1
                    lower_hour = logs.select(:hora)[0]['hora'].to_formatted_s(:time)
                    greater_hour = logs.select(:hora)[-1]['hora'].to_formatted_s(:time)
                    total_amount_hours = (greater_hour[0..2].to_i - lower_hour[0..2].to_i).abs

                    if total_amount_hours>0
                        averageMsg = total_messages.to_f / total_amount_hours.to_f
                    end
                end

                render json: {status: 'SUCCESS', message:'Loaded data', data:averageMsg},status: :ok
            end

            def maxNumMessages
                max_Num_Messages = map_num_msg_by_contexto.values.max
                render json: {status: 'SUCCESS', message:'Loaded data', data:max_Num_Messages},status: :ok

            end

            def minNumMessages
                min_Num_Messages = map_num_msg_by_contexto.values.min
                render json: {status: 'SUCCESS', message:'Loaded data', data:min_Num_Messages},status: :ok

            end

            def amountMessagePerContext
                amountMessagePerContext = map_num_msg_by_contexto
                render json: {status: 'SUCCESS', message:'Loaded data', data:amountMessagePerContext},status: :ok
            end

            private
            def log_params
                params.permit(:dia, :hora, :contexto, :tipo, :mensagem)
            end

            def map_num_msg_by_contexto
                logs = Log.order('contexto');
                map = Hash.new()
                logs.each do |log|
                    if map.has_key?(log['contexto'])
                        map[log['contexto']] +=1
                    else
                        map[log['contexto']] = 1
                    end

                end
                return map
            end

        end
    end
end
