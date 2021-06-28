module V1
  class GamesController < MainController
    before_action :set_game, only: %i[show update destroy]

    def index
      @games = Game.includes(:board, :plays).all
      json_response(@games,  each_serializer: GameSerializer)
    end

    def create
      @game = Game.create!(game_params)
      json_response @game, :created
    end

    def show
      json_response @game, include: %w[plays board.cells]
    end

    def update
      @game.update!(game_params)
      head :no_content
    end

    def destroy
      @game.destroy!
      head :no_content
    end

    private
      def game_params
        if action_create?
          parameters = params.permit :player, board_attributes: %i[cols rows mines_percentage]
        else
          params.permit(:player)
        end
      end

      def action_create?
        action_name == "create"
      end

      def set_game
        @game = Game.includes(:plays, board: :cells).find params[:id]
      end
  end
end
