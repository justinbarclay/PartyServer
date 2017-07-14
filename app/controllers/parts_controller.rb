# Controller handling all transactions to do with a Part
# This controller si supposed to be a bit magical in that it handles all relational
# objects to do with a part as well. Such as creation of a part history and managing
# of associated units.
# When a part has units attached to it in a create or update requests, it will check to see if those untis exist in the DB, and if so create a relationship with the part.
# If a part previously had a relationship with a unit but when being updated, the unit no longers is in it's unit attributes, it will remove that unit.
# This is going to be really hacky to implement and will need to be refactored
class PartsController < ApplicationController
  before_action :authenticate_user

  def create
    part = Part.new(parts_params)

    units = build_units(units_params)
    puts units
    part.units << units unless units.empty?

    if part.save
      render status: :created, json: { success: true }
    else
      render status: :error, json: { success: false, errors: part.errors.full_messages }
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
      render status: :error, json: { success: false, error: 'Part not found' }
      return
    end
    diff = calculate_difference(old_part, Part.new(parts_params))
    PartHistory.new(user: current_user, change: diff).save

    units = build_units(units_params)
    old_part.units = units

    if old_part.update(parts_params)
      render status: 201, json: { success: true }
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
      return
    end
    render status: :error, json: { success: false, error: 'What were you trying to delete?', id: id }
  end

  def search
    @search = filter_params
    parts = []
    if @search['type'] == 'unit'
      puts :Test
      units = Unit.where("name like ? ", "%#{@search['query_term']}%")
      parts = units.flat_map do |unit|
        unit.parts
      end
      parts = parts.map do |part|
        part.slice(:name, :count, :room, :shelf, :updated_at, :id)
      end
    elsif @search['type'] == 'part'
      puts :test
      parts = Part.where("name like ?", "%#{@search['query_term']}%")
    else
      render status: error, json: { error: "Seach type unknown" }
      return
    end
    puts parts.to_s
    render status: 200, json: { parts: parts }
  end

  private

  def parts_params
    params.require(:part).permit(:name, :count, :room, :shelf, :value, :barcode)
  end

  def filter_params
    params.require(:filters).permit(:type, :query_term)
  end

  def units_params
    return [] unless params.require(:part).include?(:units)

    params.require(:part).permit(units: [:name]).tap do |part_params|
      return part_params[:units]
    end
  end
  
  def calculate_difference(old, new)
    old[:count] - new[:count]
  end

  # A functions that give a list of unit names returns an object of new or previously created units
  # If a unit exists, return that unit. If a unit does not exist with that name make a new unit
  def build_units(units)
    units.map do |unit|
      if Unit.exists?(name: unit['name'])
        Unit.find_by(name: unit['name'])
      else
        Unit.new(unit)
      end
    end
  end
  
end
