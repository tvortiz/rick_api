require 'test_helper'

class AppearanceControllerTest < ActionDispatch::IntegrationTest


  # realiza testes de GETs com na API interna (que chama a externa pelo model)

  test "GET ID 1" do
    get 'http://127.0.0.1:3000/appearance/1'
    assert_response :success
    assert_equal '02/12/2013', @response.body
  end

  test "GET ID 2" do
    get 'http://127.0.0.1:3000/appearance/2'
    assert_response :success
    assert_equal '02/12/2013', @response.body
  end

  test "GET ID 5" do
    get 'http://127.0.0.1:3000/appearance/5'
    assert_response :success
    assert_equal '27/01/2014', @response.body
  end

  test "GET ID 8" do
    get 'http://127.0.0.1:3000/appearance/8'
    assert_response :success
    assert_equal '10/09/2017', @response.body
  end



  # verifica casos onde a ID é inexistente

  test "GET ID INEXISTENTE" do
    get 'http://127.0.0.1:3000/appearance/83317961316314'
    assert_response :not_found
    assert_equal ' ', @response.body
  end


  # verifica casos onde o parâmetro não é um inteiro

  test "GET ID PARAMETRO ERRADO" do
    get 'http://127.0.0.1:3000/appearance/1a'
    assert_response :bad_request
    assert_equal ' ', @response.body
  end


  # verifica se a API retorna um pedido de JSON
  # (nas instruções não é claro se é para permitir, foi bloqueado por falta de informações)
  
  test "GET JSON" do
    get 'http://127.0.0.1:3000/appearance/1.json'
    assert_response :bad_request
    assert_equal ' ', @response.body
  end

  
end
