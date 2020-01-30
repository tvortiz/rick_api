class Appearance# < ApplicationRecord
	include ActiveModel::Validations 	# The ActiveModel::Validations module adds the ability to validate objects like in Active Record.
	include ActiveModel::Conversion 	# If a class defines persisted? and id methods, then you can include the ActiveModel::Conversion module in that class, and call the Rails conversion methods on objects of that class.
	extend ActiveModel::Naming 			# ActiveModel::Naming adds a number of class methods which make naming and routing easier to manage. The module defines the model_name class method which will define a number of accessors using some ActiveSupport::Inflector methods.

	# https://guides.rubyonrails.org/active_model_basics.html


	
	attr_accessor :char_id, :air_date, :character, :episode
	
	# requer a presença do ID e da data para validação
	validates_presence_of :char_id, :air_date



	# Método estático: FIND
	# Parâmetros:
	# - id: id do caracter a ser buscado
	# Retorno:
	# Objeto do tipo Appearance com a data preenchida ou nil caso não encontre.
  	def self.find (id)

  		ap = Appearance.new

  		ap.char_id = id
  		ap.character = Character.new id
  		ap.episode = Episode.new ap.character.episode.first
  		ap.air_date = ap.episode.air_date

  		return ap
  	end


end





# CLASS: CHARACTER
# Esta classe irá armazenar as inforções do personagens, utilizando o schema fornecido pela API externa do rickandmortyapi.com.
# A CLASSE AINDA ESTÁ STUB !!!
class Character
	attr_accessor :id, :name, :status, :species, :type, :gender, :origin, :location, :image, :episode, :url, :created

	def initialize (id)
  		@id = id
  		@episode = [1, 2, 3]
  		# ...
  	end

end


# CLASS: EPISODE
# Esta classe irá armazenar as inforções dos episódios, utilizando o schema fornecido pela API externa do rickandmortyapi.com.
# A CLASSE AINDA ESTÁ STUB !!!
class Episode
	attr_accessor :id, :name, :air_date, :episode, :characters, :url, :created	

	def initialize (id)
  		@id = id
  		@air_date = "September 10, 2017"
  	end

  	
end