# Controller handling all transactions to do with a Part

class PartsController < ApplicationController
  before_action :authenticate_user

  def create

    parts = Part.new(parts_params)

    if parts.save
      render status: :created, json: { success: true }
    else
      render status: :error, json: { success: false, errors: parts.errors.full_messages }
    end
  end

  def show
    part = Part.includes(:units).find_by(id: params[:part_id])
    if part.nil?
      render status: 404, json: { success: false, error: 'Part not found' }
    else
      render status: 200, json: { success: true, part: part }
    end
  end

  def index
    parts = Part.all

    render status: 200, json: { success: true, parts: parts }
  end

  private

  def parts_params
    params.require(:part).permit(:name, :count, :room, :shelf, unit_parts_attributes: [unit_attributes: [ :name ]])
  end
end
