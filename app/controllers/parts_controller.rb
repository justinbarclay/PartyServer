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

  def get
    part = Part.find_by(:partID)

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
