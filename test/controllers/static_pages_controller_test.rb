require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get landing" do
    get :landing
    assert_response :success
  end

  test "should get casos" do
    get :casos
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

  test "should get distribuidores" do
    get :distribuidores
    assert_response :success
  end

  test "should get comprar" do
    get :comprar
    assert_response :success
  end

end
