class ActivitiesController < ApplicationController
    def index
        render json: Activity.all
    end
    def show
        foundAct = Activity.find(params[:id])
        render json: foundAct, status: :created
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Activity not found"}, status: :not_found
    end
    def destroy
        foundAct = Activity.find(params[:id])
        foundAct.destroy
        render json: foundAct
    rescue ActiveRecord::RecordNotFound
        render json: {error: "Activity not found"}, status: :not_found
    end
end
