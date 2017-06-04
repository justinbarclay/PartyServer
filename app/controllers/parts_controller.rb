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
    part = Part.includes(:units).find_by(id: params[:id])

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

  def update
    old_part = Part.find_by(id: params[:id])

    unless old_part
      render status: :error, json: {success: false, error: "Part not found"}
      return
    end
    diff = calculate_difference(old_part, Part.new(parts_params))
    PartHistory.new(user: current_user, change: diff).save

    
    if old_part.update(parts_params)
      render status: 201, json: {success: true }
    else
      render status: :error, json: { success: false,
                                    errors: old_part.errors.full_messages }
    end
  end

  def delete
    id = params[:id]
    
    if Part.exists?(id)
      Part.delete(id)
      render status: 200, json: { success: true }
    end
    render status: :error, json: { success: false, error: "What were you trying to delete?", id: id }
  end

  private

  def parts_params
    params.require(:part).permit(:name, :count, :room, :shelf, :value, :barcode,
                                 unit_parts_attributes: [unit_attributes:
                                                           [:name]])
  end
  
  def calculate_difference(old, new)
    old[:count] - new[:count]
  end
end
