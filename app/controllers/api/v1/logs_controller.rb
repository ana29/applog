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

            def showByContexto
                log = Log.where(contexto: params[:contexto])
                render json: {status: 'SUCCESS', message:'Loaded log', data:log},status: :ok


            end

            def mediaMensagem
                logs = Log.where(contexto: params[:contexto]).order('hora DESC')

                menorHora = logs.select(:hora)[0]['hora'].to_formatted_s(:time)
                maiorHora = logs.select(:hora)[-1]['hora'].to_formatted_s(:time)
                quantHoras = (maiorHora[0..2].to_i - menorHora[0..2].to_i).abs
                quantMsg = logs.size
                if quantHoras>0
                    mediaMsg = (quantMsg.to_f/quantHoras.to_f)
                else
                    mediaMsg = quantMsg
                end


                render json: {status: 'SUCCESS', message:'Loaded log', data:mediaMsg},status: :ok
            end

            def maiorNumMensagens
                msgs = map_log.max
                render json: {status: 'SUCCESS', message:'Loaded logs', data:msgs},status: :ok

            end

            def menorNumMensagens
                msgs = map_log.min
                render json: {status: 'SUCCESS', message:'Loaded logs', data:msgs},status: :ok

            end


            private
            def log_params
                params.permit(:dia, :hora, :contexto, :tipo, :mensagem)
            end

            def map_log
                logs = Log.order('contexto');
                msgs = Hash.new()
                logs.each do |log|
                    msgs[log['contexto']] = log['hora']
                end
                return msgs
            end

        end
    end
end
