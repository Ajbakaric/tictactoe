require './lib/game'  # Adjust the path accordingly
require 'rspec'

RSpec.describe Game do
  let(:player_one_name) { 'Player 1' }
  let(:player_two_name) { 'Player 2' }
  let(:game) { Game.new('Player 1', 'Player 2') }

  describe '#initialize' do
    it 'initializes a new game with correct player names and an empty board' do
      expect(game.instance_variable_get(:@player_one_name)).to eq(player_one_name)
      expect(game.instance_variable_get(:@player_two_name)).to eq(player_two_name)
      expect(game.instance_variable_get(:@board)).to eq(Array.new(3) { Array.new(3, '_') })
    end
  end

  describe '#add_to_board' do
    it 'updates the board with the correct symbol at the specified coordinates' do
      game.add_to_board(0, 0, 'X')
      expect(game.instance_variable_get(:@board)).to eq([['X', '_', '_'], ['_', '_', '_'], ['_', '_', '_']])
    end
  end

  describe '#check_winner' do
    it 'detects a winner when there is a row of the same symbol' do
      game.add_to_board(0, 0, 'X')
      game.add_to_board(0, 1, 'X')
      game.add_to_board(0, 2, 'X')
      expect(game.check_winner).to be true
    end

    it 'detects a winner when there is a column of the same symbol' do
      game.add_to_board(0, 0, 'O')
      game.add_to_board(1, 0, 'O')
      game.add_to_board(2, 0, 'O')
      expect(game.check_winner).to be true
    end

    it 'detects a winner when there is a diagonal of the same symbol' do
      game.add_to_board(0, 0, 'X')
      game.add_to_board(1, 1, 'X')
      game.add_to_board(2, 2, 'X')
      expect(game.check_winner).to be true
    end

    it 'returns false when there is no winner' do
      expect(game.check_winner).to be false
    end
  end

  # You can add more tests for other methods such as player_turn, player_choice, display_board, etc.
end