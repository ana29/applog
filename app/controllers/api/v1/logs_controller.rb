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

            def update
                log = Log.find(params[:id])
                if log.update_attributes(log_params)
                  render json: {status: 'SUCCESS', message:'Updated log', data:log},status: :ok
                else
                  render json: {status: 'ERROR', message:'Log not updated', data:log.errors},status: :unprocessable_entity
                end
            end

            def showByContexto
                log = Log.where(contexto: params[:contexto])
                render json: {status: 'SUCCESS', message:'Loaded log', data:log},status: :ok

            end
            def metrics
                map = map_num_msg_by_contexto
                total_amount_hours = amountHour

                if total_amount_hours >0
                        average_msg = map.values.sum/total_amount_hours.to_f
                        max_num_messages = map.values.max/total_amount_hours.to_f
                        min_num_messages = map.values.min/total_amount_hours.to_f
                end
                metrics = "Average messages per hour = #{average_msg}, Highest number of messages per hour = #{max_num_messages}, Lowest number of messages per hour= #{min_num_messages}" 

                render json: {status: 'SUCCESS', message:'Loaded data', data:metrics},status: :ok
            end

            def averageMessagesPerHour
                logs = Log.where(contexto: params[:contexto]).order('hora ASC')
                total_messages = logs.size
                average_msg = total_messages
                total_amount_hours= amountHour

                if total_amount_hours >0
                        average_msg = total_messages.to_f / total_amount_hours.to_f
                end

                render json: {status: 'SUCCESS', message:'Loaded data', data:average_msg},status: :ok

            end


            def maxNumMessages
                max_num_messages = map_num_msg_by_contexto.values.max
                render json: {status: 'SUCCESS', message:'Loaded data', data:max_num_messages},status: :ok

            end

            def minNumMessages
                min_num_messages = map_num_msg_by_contexto.values.min
                render json: {status: 'SUCCESS', message:'Loaded data', data:min_num_messages},status: :ok

            end

            def amountMessagePerContext
                amountMessagePerContext = map_num_msg_by_contexto
                render json: {status: 'SUCCESS', message:'Loaded data', data:amountMessagePerContext},status: :ok

            end

            def oldestLog
                logs = Log.order('dia ASC')
                oldestLog = logs[0]
                render json: {status: 'SUCCESS', message:'Loaded data', data:oldestLog},status: :ok

            end

            def latestLog
                logs = Log.order('dia DESC')
                latestLog = logs[0]
                render json: {status: 'SUCCESS', message:'Loaded data', data:latestLog},status: :ok

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

            def amountHour
                logs = Log.order('hora ASC')
                total_amount_hours = 0

                if logs.size ==1
                    total_amount_hours = 1

                elsif logs.size >2
                    lower_hour = logs.select(:hora)[0]['hora'].to_formatted_s(:time)
                    greater_hour = logs.select(:hora)[-1]['hora'].to_formatted_s(:time)
                    total_amount_hours = (greater_hour[0..2].to_i - lower_hour[0..2].to_i).abs
                end

                return total_amount_hours

            end

        end
    end
end
