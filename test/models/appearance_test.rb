require 'test_helper'


# Testa a classe Character, analisando se os dados obtidos da API estão corretos.
class CharTest < ActiveSupport::TestCase
   
	test "Checar personagem ID 1" do

		Appearance.new

		# busca o personagem com ID = 1
		c = Character.new 1

		assert_equal 1, c.id
		assert_equal 'Rick Sanchez', c.name
		assert_equal 'Alive', c.status
		assert_equal 'Human', c.species
		assert_equal '', c.type
		assert_equal 'Male', c.gender
		assert_equal 'Earth (C-137)', c.origin
		assert_equal 'Earth (Replacement Dimension)', c.location
		assert_equal 'https://rickandmortyapi.com/api/character/avatar/1.jpeg', c.image
		assert_equal 'https://rickandmortyapi.com/api/character/1', c.url
		assert_equal '2017-11-04T18:48:46.250Z', c.created
		
	end
   


	test "Checar personagem ID 2" do

		Appearance.new

		# busca o personagem com ID = 1
		c = Character.new 2

		assert_equal 2, c.id
		assert_equal 'Morty Smith', c.name
		assert_equal 'Alive', c.status
		assert_equal 'Human', c.species
		assert_equal '', c.type
		assert_equal 'Male', c.gender
		assert_equal 'Earth (C-137)', c.origin
		assert_equal 'Earth (Replacement Dimension)', c.location
		assert_equal 'https://rickandmortyapi.com/api/character/avatar/2.jpeg', c.image
		assert_equal 'https://rickandmortyapi.com/api/character/2', c.url
		assert_equal '2017-11-04T18:50:21.651Z', c.created
		
	end



	test "Chechar personagem que não existe" do

		Appearance.new

		c = Character.new 967461674

		assert_equal 0, c.id

	end


end







# Testa a classe Episode, analisando se os dados obtidos da API estão corretos.
class EpisodeTest < ActiveSupport::TestCase
   
	test "Checar episódio ID 1" do

		Appearance.new

		# busca o personagem com ID = 1
		ep = Episode.new 1

		assert_equal 1, ep.id
		assert_equal 'Pilot', ep.name
		assert_equal '02/12/2013', ep.air_date
		assert_equal 'S01E01', ep.episode
		assert_equal 'https://rickandmortyapi.com/api/episode/1', ep.url
		assert_equal '2017-11-10T12:56:33.798Z', ep.created
		
	end

end




# Faz o teste de Integração da classe Appearance, que utiliza as classes Episode e Character
class AppearanceTest < ActionDispatch::IntegrationTest
   
	test "Obter data id 1" do

		assert_equal '02/12/2013', Appearance.find(1).air_date
		assert_equal '02/12/2013', Appearance.find(2).air_date
		assert_equal '27/01/2014', Appearance.find(3).air_date
		assert_equal '27/01/2014', Appearance.find(4).air_date
		assert_equal '27/01/2014', Appearance.find(5).air_date
		assert_equal '27/08/2017', Appearance.find(6).air_date
		assert_equal '07/04/2014', Appearance.find(7).air_date
		assert_equal '10/09/2017', Appearance.find(8).air_date

		# checa por personagens com ID inexistente
		assert_equal '', Appearance.find(344941347).air_date
		assert_equal 0,  Appearance.find(684134713).char_id


		
	end

end
