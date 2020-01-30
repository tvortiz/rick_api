class AppearanceController < ActionController::API
	include ActionController::MimeResponds # necessario para saber o tipo de requisição (HTML, JSON, XML)



	#no modo verbose, o servidor imprime informações extras junto com o "ruby server"
	$verbose = true




	# GET /Appearance/1
  	# GET /Appearance/1.json
	def show

		# pega o parâmetro ID da requisição
		id = params[:id]

		print "\nRequisição feita! ID requisitado: ", id, "\n" if $verbose



		# localiza a aparição do char
		ap = Appearance.find(id) # Appearance está ainda é STUB !!!
		air_date = ap.air_date

		print "A primeira aparição do char foi em: ", air_date, "\n\n" if $verbose


		# verifica o tipo de requisição que foi feita. Esta API deve aceitar apenas o tipo HTML e não aceitar JSON
    	respond_to do |format|
			format.html { render plain: air_date }
			format.json { render status: :bad_request }
			#format.js
		end


		# PARA USO FUTURO
    	#render status: 500
		#render status: :bad_request
		#render status: :not_found
		#render status: :request_timeout
		#render status: :too_many_requests

  	end

end
