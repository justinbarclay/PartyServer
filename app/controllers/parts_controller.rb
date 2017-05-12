# Controller handling all transactions to do with a Part

class PartsController < ApplicationController

  def create
    parts = Part.new(parts_params)

    if parts.save
      render status: :created, json: { success: true }
    else
      render status: :error, json: { success: false, errors: parts.errors.full_messages }
    end
  end

  def show
    part = Part.find_by(id: params[:part_id])

    if part.nil?
      render status: 404, json: { success: false, error: 'Part not found' }
    else
      render status: 200, json: { success: true, part: part }
    end
  end

  private

  def parts_params
    params.require(:part).permit(:name, :count, :room, :shelf)
  end

end
