

# No modo verbose, o servidor imprime informações no console junto com o "ruby server"
$verbose = true



class Appearance# < ApplicationRecord
	include ActiveModel::Validations 	# The ActiveModel::Validations module adds the ability to validate objects like in Active Record.
	include ActiveModel::Conversion 	# If a class defines persisted? and id methods, then you can include the ActiveModel::Conversion module in that class, and call the Rails conversion methods on objects of that class.
	extend ActiveModel::Naming 			# ActiveModel::Naming adds a number of class methods which make naming and routing easier to manage. The module defines the model_name class method which will define a number of accessors using some ActiveSupport::Inflector methods.

	# https://guides.rubyonrails.org/active_model_basics.html



	attr_accessor :char_id, :air_date, :character, :episode
	
	# requer a presença do ID e da data para validação
	validates_presence_of :char_id, :air_date






	# Mantem uma hash com os personagens e episódios que for carregando da API rickandmortyapi.com para performance.
	# Isto só é indicado pois a data que se quer obter não será alterada, caso fossem informações com nível de atualização rápida, isto não seria viável.
	@@loaded_characters = {}
	@@loaded_episodes = {}
	



	# Método estático: FIND
	# Parâmetros:
	# - id: id do caracter a ser buscado
	# Retorno:
	# Objeto do tipo Appearance com a data preenchida ou nil caso não encontre.
  	def self.find (id)


  		# procura na lista de personagens pra ver se este já foi buscado para otimizar a performance
  		if @@loaded_characters[id] != nil

  			print "Puxando da memória o personagem com id = " , id, "\n" if $verbose
  			return @@loaded_characters[id]

  		else
  			# cria uma nova instância
	  		ap = Appearance.new
	  		ap.char_id = id

	  		# consume a API externa pegando os dados do personagem
	  		ap.character = Character.new id

	  		# verifica se foi encontrado
	  		if ap.character.id == 0
	  			ap.char_id = 0
	  			ap.air_date = ''
	  			return ap
	  		end


	  		# procura na lista de episódios pra ver se este já foi buscado para otimizar a performance
  			if @@loaded_episodes[ap.character.episode.first] != nil
  				print "Puxando da memória o episódio com id = " , ap.character.episode.first, "\n" if $verbose
  				ap.episode = @@loaded_episodes[ap.character.episode.first]
  			else
  				# consume a API externa pegando os dados do episódio
		  		ap.episode = Episode.new ap.character.episode.first

		  		# adiciona o objeto na lista de episódios já carregados da API externa
		  		@@loaded_episodes[ap.character.episode.first] = ap.episode
		  	end


	  		# preenche a data para fácil exibição no controller
	  		ap.air_date = ap.episode.air_date

	  		# adiciona o objeto na lista de personagens já carregados da API externa
	  		@@loaded_characters[id] = ap

	  		# retorna o valor buscado
  			return ap
	  	end
  		
  	end


end





# CLASS: CHARACTER
# Esta classe irá armazenar as inforções do personagens, utilizando o schema fornecido pela API externa do rickandmortyapi.com.
class Character
	attr_accessor :id, :name, :status, :species, :type, :gender, :origin, :location, :image, :episode, :url, :created

	def initialize (id)

		# faz a requisição externa da API
		print "Consumindo a API externa character/" , id, "\n" if $verbose
		hash_with_values = getJson("https://rickandmortyapi.com/api/character/" + id.to_s)

		# verifica se ocorreu algum erro no retorno da API
		if hash_with_values == nil or hash_with_values['error'] != nil
			@id = 0
			return
		end

  		@id = 		hash_with_values['id']
  		@name = 	hash_with_values['name']
  		@status = 	hash_with_values['status']
  		@species = 	hash_with_values['species']
  		@type = 	hash_with_values['type']
  		@gender = 	hash_with_values['gender']
  		@origin = 	hash_with_values['origin']['name']
  		@location = hash_with_values['location']['name']
  		@image = 	hash_with_values['image']
  		@episode = 	hash_with_values['episode']
  		@url = 		hash_with_values['url']
  		@created = 	hash_with_values['created']

  		# formata o array de personagens, deixando apenas o ID deles
  		@episode.each { |ep| ep.delete!('https://rickandmortyapi.com/api/episode/') }
  	end

end


# CLASS: EPISODE
# Esta classe irá armazenar as inforções dos episódios, utilizando o schema fornecido pela API externa do rickandmortyapi.com.
class Episode
	attr_accessor :id, :name, :air_date, :episode, :characters, :url, :created	

	def initialize (id)

		# faz a requisição externa da API
		print "Consumindo a API externa episode/" , id, "\n" if $verbose
		hash_with_values = getJson("https://rickandmortyapi.com/api/episode/" + id.to_s)

		# verifica se ocorreu algum erro no retorno da API
		if hash_with_values == nil or hash_with_values['error'] != nil
			@id = 0
			return
		end

		# preenche a classe
  		@id 		= hash_with_values['id']
  		@name  		= hash_with_values['name']
  		@air_date 	= hash_with_values['air_date']
  		@episode 	= hash_with_values['episode']
  		@characters = hash_with_values['characters']
  		@url 		= hash_with_values['url']
  		@created 	= hash_with_values['created']
  		
  		# formata o array de personagens, deixando apenas o ID deles
  		@characters.each { |char| char.delete!('https://rickandmortyapi.com/api/character/') }

  		# formata a data para formato brasileiro
  		@air_date = DateTime.strptime(@air_date, '%B %d, %Y').strftime('%d/%m/%Y')

  	end

  	
end



# utilizando net/http por ser do ruby e não precisar de gem, menos chances de dar erros e possuí uma performance melhor
require 'net/http'
require 'json'

# Método: getJson
# Parâmetros:
# - url: url do GET JSON da API rickandmortyapi.com
# Retorno:
# Objeto do tipo HASH com onde cada chave é uma string com o campo do JSON
def getJson (url)

	# converte a URL para URI
	uri = URI.parse(url)

	# faz a requisição do modo completo para poder obter a resposta do servidor
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	request = Net::HTTP::Get.new(uri.request_uri)

	response = http.request(request)

	if response.code == "200"
		return JSON.parse(response.body)
	else
		return nil
	end
end


