class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    def index
        camper = Camper.all
        render json: camper, only: [:id, :name, :age], status: :ok
    end

    def show
      cFind = Camper.find(params[:id])
    
      render json: cFind, status: :created, include: :activities, status: :ok
    end
    def create
        newguy = Camper.create!(camper_params)
        render json: newguy, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: {error: invalid.record.errors.full_messages}
    end
    private
    def camper_params
            params.permit(:name, :age)
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
      def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
      end

end

