require_relative 'game'


game = Game.new

game.intro
game.play until game.game_over?(game.current_player)
