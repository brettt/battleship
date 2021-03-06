require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'

class ComputerTest < Minitest::Test

  def test_class_exist
    test = Computer.new(Board.new)
    result = test.nil?
    assert_equal false, result
  end

  def test_game_board
    test = Computer.new(Board.new)
    result = test.computer_board.game_board.nil?
    assert_equal false, result
  end

  def test_game_board_coordinates
    test = Computer.new(Board.new)
    result = test.computer_board.game_board["A"]["1"]
    assert_equal " ", result
  end

  def test_another_game_board_coordinates
    test = Computer.new(Board.new)
    result = test.computer_board.game_board["B"]["2"]
    assert_equal " ", result
  end

  def test_yet_another_game_board_coordinates
    test = Computer.new(Board.new)
    result = test.computer_board.game_board["C"]["3"]
    assert_equal " ", result
  end

  def test_random_coordinate #is possible to fail this
    test = Computer.new(Board.new)
    result = test.random_coordinate
    new_result = test.random_coordinate
    refute_equal result, new_result
  end

  def test_coordinates_avaiable
    test = Computer.new(Board.new)
    result = test.computer_board_available?("A1")
    assert_equal true, result
  end

  def test_coordinates_avaiable_miss
    test = Computer.new(Board.new)
    test.computer_board.game_board["A"]["1"] = "M"
    result = test.computer_board_available?("A1")
    assert_equal false, result
  end

  def test_coordinates_avaiable_hit
    test = Computer.new(Board.new)
    test.computer_board.game_board["A"]["1"] = "H"
    result = test.computer_board_available?("A1")
    assert_equal false, result
  end

  def test_coordinates_hit
    test = Computer.new(Board.new)
    test.opponent_board.ship_board["B"]["2"] = "S"
    result = test.ship_hit?("B2")
    assert_equal true, result
  end

  def test_coordinates_not_hit
    test = Computer.new(Board.new)
    test.computer_board.game_board["B"]["2"] = " "
    result = test.ship_hit?("B2")
    assert_equal false, result
  end

  def test_computer_shoot
    test = Computer.new(Board.new)
    coordinates = test.computer_shoot
    result = test.computer_board_available?(coordinates)
    assert_equal true, result
  end

  def test_close_numbers
    test = Computer.new(Board.new)
    result = test.close_numbers?(3, ["A2", "A3", "A4"])
    assert_equal true, result
  end

  def test_not_close_numbers
    test = Computer.new(Board.new)
    result = test.close_numbers?(3, ["B8", "B2", "B6"])
    refute_equal true, result
  end

  def test_close_letters
    test = Computer.new(Board.new)
    result = test.close_letters?(3, ["C1", "A1", "B1"])
    assert_equal true, result
  end

  def test_not_close_letters
    test = Computer.new(Board.new)
    result = test.close_letters?(3, ["C3", "F3", "B3"])
    refute_equal true, result
  end

  def test_same_num
    test = Computer.new(Board.new)
    result = test.same_num?(["F1", "G1", "D1"])
    assert_equal true, result
  end

  def test_not_same_num
    test = Computer.new(Board.new)
    result = test.same_num?(["F1", "G2", "D3"])
    refute_equal true, result
  end

  def test_same_letter
    test = Computer.new(Board.new)
    result = test.same_letter?(["F1", "F9", "F6"])
    assert_equal true, result
  end

  def test_not_same_letter
    test = Computer.new(Board.new)
    result = test.same_letter?(["F1", "D9", "F6"])
    refute_equal true, result
  end

  def test_computer_ship_creator_two
    test = Computer.new(Board.new)
    result = test.computer_ship_creator(2)
    assert_equal 2, result.length
  end

  def test_computer_ship_creator_four
    test = Computer.new(Board.new)
    result = test.computer_ship_creator(4)
    assert_equal 4, result.length
  end

  def test_ship_inserter
    test = Computer.new(Board.new)
    test.ship_inserter(["A1"])
    result = test.computer_board.ship_board["A"]["1"]
    assert_equal "S", result
  end

  def test_new_ship_inserter
    test = Computer.new(Board.new)
    test.ship_inserter(["D4"])
    result = test.computer_board.ship_board["D"]["4"]
    assert_equal "S", result
  end

  def test_different_ship_inserter
    test = Computer.new(Board.new)
    test.ship_inserter(["B2"])
    result = test.computer_board.ship_board["B"]["2"]
    assert_equal "S", result
  end

  def test_hit_or_miss_inserter #this won't work when boards change
    test = Computer.new(Board.new)
    result = test.hit_miss_inserter
    assert_equal "M", result
  end

  def test_new_hit_or_miss_inserter
    test = Computer.new(Board.new)
    result = test.hit_miss_inserter
    assert_equal "M", result
  end

  def test_different_hit_or_miss_inserter
    test = Computer.new(Board.new)
    result = test.hit_miss_inserter
    assert_equal "M", result
  end

  def test_computer_hit_counter
    test = Computer.new(Board.new)
    test.opponent_board.ship_board["A"]["1"] = "S"
    test.hit_miss_inserter("A1")
    test.opponent_board.ship_board["A"]["2"] = " "
    test.hit_miss_inserter("A2")
    result = test.hit_counter
    assert_equal 1, result
  end

  def test_computer_shot_counter
    test = Computer.new(Board.new)
    test.opponent_board.ship_board["A"]["1"] = "S"
    test.hit_miss_inserter("A1")
    test.opponent_board.ship_board["A"]["2"] = " "
    test.hit_miss_inserter("A2")
    result = test.computer_shots
    assert_equal 2, result
  end

end
