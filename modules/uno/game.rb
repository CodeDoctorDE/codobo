# frozen_string_literal: true

class UnoModule
  def message; end
  class MatchMaking
    class Game
      def initialize(bot, channel, private)
        @bot = bot
        @channel = channel
        @private = private
        @mode = :lobby
      end

      def ingame!(users)
        if users.length > 1
          @players = users
          Thread.new do
            30.downto(0) do |i|
              @channel.send_temporary_message format(@language.getJson(event.server.id)['matchmaking']['ingame-countdown'], s: i), 5
              sleep 1
            end
            check
            @mode = :ingame
          end
          true
        else
          false
        end
      end

      def lobby!(users)
        if users.length > 1
          @players = users
          Thread.new do
            30.downto(0) do |i|
              @channel.send_temporary_message format(@language.getJson(event.server.id)['matchmaking']['lobby-countdown'], s: i), 5
              sleep 1
            end
            check
            @mode = :lobby
          end
          true
        else
          false
        end
      end

      def lobby?
        @mode == :lobby
      end

      def ingame?
        @mode = :ingame
      end
      
      attr_accessor :private

      def leave(player)
        @players.delete(player)
        check
      end

      def check
        channel.delete if players.length < 2
      end

      def delete
        channel.delete
      end
      attr_reader :players
    end

    def initialize(bot, category)
      @bot = bot
      @category = category
      @games = []
      createHub
    end

    def createHub
      @hubChannel = @category.server.create_channel(@language.getJson(event.server.id)['category']['hub']['name'], topic: @language.getJson(event.server.id)['category']['hub']['topic'])
      @hubChannel.category = @category
    end

    def deleteHub
      @hubChannel.delete
    end

    def new(privateRound)
      game = Game.new(bot, category, privateRound)
      @games.push(game)
      game
    end

    def get(user)
      @games.each do |game|
        game if game.players.includes? user
      end
    end

    def join(user, game)
      leave(user)
      game.join(user)
    end

    def leave(user)
      @games.each do |game|
        game.leave(user)
      end
    end

    def reset
      @games.each { |game| delete(game) }
    end

    def delete(game)
      @game.delete
      @games.delete(game)
    end
end
end
