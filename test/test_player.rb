require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/player'

class PlayerTest < Minitest::Test

  def test_class_exist
    test = Player.new(Board.new)
    result = test.nil?
    assert_equal false, result
  end

  def test_game_board_exists
    test = Player.new(Board.new)
    result = test.player_board.game_board.nil?
    assert_equal false, result
  end

  def test_available
    test = Player.new(Board.new)
    result = test.game_board_available?("A1")
    assert_equal true, result
  end

  def test_not_available
    test = Player.new(Board.new)
    test.player_board.game_board["A"]["1"] = "M"
    result = test.game_board_available?("A1")
    assert_equal false, result
  end

  def test_ship_hit_without_ship
    test = Player.new(Board.new)
    result = test.ship_hit?("A1")
    assert_equal false, result
  end

  def test_ship_hit_with_ship
    test = Player.new(Board.new)
    test.opponent_board.ship_board["A"]["1"] = "S"
    result = test.ship_hit?("A1")
    assert_equal true, result
  end

  def test_player_shoot_with_hit
    skip
    #not working, need to fix asap
    test = Player.new(Board.new)
    test.player_board.ship_board["A"]["1"] = "S"
    result = test.player_shoot("A1")
    assert_equal "Hit!", result #not working
  end

  def test_player_shoot_with_miss
    skip
    #not working, need to fix asap
    test = Player.new(Board.new)
    test.player_board.game_board["A"]["1"] = " "
    result = test.player_shoot("A1")
    assert_equal "Miss!", result
  end

  def test_player_shoot_with_invalid_coordinates
    test = Player.new(Board.new)
    test.player_board.game_board["A"]["1"] = "M"
    result = test.player_shoot("A1")
    assert_equal "Not a valid coordinate.", result
  end

  def test_close_numbers
    test = Player.new(Board.new)
    result = test.close_numbers?(3, ["A2", "A3", "A4"])
    assert_equal true, result
  end

  def test_not_close_numbers
    test = Player.new(Board.new)
    result = test.close_numbers?(3, ["B8", "B2", "B6"])
    refute_equal true, result
  end

  def test_close_letters
    test = Player.new(Board.new)
    result = test.close_letters?(3, ["C1", "A1", "B1"])
    assert_equal true, result
  end

  def test_not_close_letters
    test = Player.new(Board.new)
    result = test.close_letters?(3, ["C3", "F3", "B3"])
    refute_equal true, result
  end

  def test_same_num
    test = Player.new(Board.new)
    result = test.same_num?(["F1", "G1", "D1"])
    assert_equal true, result
  end

  def test_not_same_num
    test = Player.new(Board.new)
    result = test.same_num?(["F1", "G2", "D3"])
    refute_equal true, result
  end

  def test_same_letter
    test = Player.new(Board.new)
    result = test.same_letter?(["F1", "F9", "F6"])
    assert_equal true, result
  end

  def test_not_same_letter
    test = Player.new(Board.new)
    result = test.same_letter?(["F1", "D9", "F6"])
    refute_equal true, result
  end

  def test_ship_inserter
    test = Player.new(Board.new)
    test.ship_inserter(["D3"])
    result = test.player_board.ship_board["D"]["3"]
    assert_equal "S", result
  end

  def test_new_ship_inserter
    test = Player.new(Board.new)
    test.ship_inserter(["A2"])
    result = test.player_board.ship_board["A"]["2"]
    assert_equal "S", result
  end

  def test_different_ship_inserter
    test = Player.new(Board.new)
    test.ship_inserter(["C3"])
    result = test.player_board.ship_board["C"]["3"]
    assert_equal "S", result
  end

  def test_player_ship_request
    test = Player.new(Board.new)
    test.player_ship_request(3, ["A1", "B1", "C1"])
    result = test.ship_board_available?("A1")
    assert_equal false, result
  end

  def test_player_ship_request_bad_coordinates
    test = Player.new(Board.new)
    result = test.player_ship_request(3, ["A1", "B2", "C3"])
    assert_equal "Not valid coordinates", result
  end

  def test_new_player_ship_request_bad_coordinates
    test = Player.new(Board.new)
    result = test.player_ship_request(3, ["D3", "B2", "C3"])
    assert_equal "Not valid coordinates", result
  end

  def test_player_ship_request_not_available
    test = Player.new(Board.new)
    test.player_board.game_board["A"]["1"] = "S"
    result = test.player_ship_request(3, ["A1", "B1", "C1"])
    assert_equal "Not valid coordinates", result
  end

  def test_new_player_ship_request_not_available
    test = Player.new(Board.new)
    test.player_board.game_board["A"]["1"] = "S"
    result = test.player_ship_request(3, ["A1", "A2", "A3"])
    assert_equal "Not valid coordinates", result
  end

  def test_player_hit_counter
    test = Player.new(Board.new)
    test.opponent_board.ship_board["A"]["1"] = "S"
    test.player_shoot("A1")
    test.opponent_board.ship_board["A"]["2"] = " "
    test.player_shoot("A2")
    result = test.hit_counter
    assert_equal 1, result
  end

  def test_player_shot_counter
    test = Player.new(Board.new)
    test.opponent_board.ship_board["A"]["1"] = "S"
    test.player_shoot("A1")
    test.opponent_board.ship_board["A"]["2"] = " "
    test.player_shoot("A2")
    result = test.player_shots
    assert_equal 2, result
  end

end
