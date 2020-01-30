class AppearanceController < ActionController::API
	include ActionController::MimeResponds # necessario para saber o tipo de requisição (HTML, JSON, XML)



	# No modo verbose, o servidor imprime informações no console junto com o "ruby server"
	$verbose = true




	# GET /Appearance/1
  	# GET /Appearance/1.json
	def show

		# pega o parâmetro ID da requisição
		id = params[:id]

		# verifica se ID é um número
		if !id.match(/^(\d)+$/)
			render status: :bad_request
			return
		end

		print "\nRequisição feita! ID requisitado: ", id.class, "\n" if $verbose



		# localiza a aparição do char
		ap = Appearance.find(id)

		# verifica se o personagem foi encontrado
		if ap.char_id == 0
			render status: :not_found
			return
		else
			air_date = ap.air_date
		end

		print "A primeira aparição do char foi em: ", air_date, "\n\n" if $verbose


		# verifica o tipo de requisição que foi feita. Esta API deve aceitar apenas o tipo HTML e não aceitar JSON
    	respond_to do |format|
			format.html { render plain: air_date }
			format.json { render status: :bad_request }
			#format.js
		end


  	end

end
