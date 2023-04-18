class ShiftTypesController < ApplicationController

  def new
    @shift_type = ShiftType.new
  end

  def create
    @shift_type = ShiftType.new(shift_type_params)
    @shift_type.save
    redirect_to shift_types_path
  end

  def index
    @shift_types = ShiftType.all
  end

  def edit
    @shift_type = ShiftType.find(params[:id])
  end

  def update
    shift_type = ShiftType.find(params[:id])
    shift_type.update(shift_type_params)
    redirect_to shift_types_path
  end

  def destroy
    @shift_type = ShiftType.find(params[:id])
    @shift_type.destroy
    redirect_to shift_types_path
  end

  private

  def shift_type_params
    params.require(:shift_type).permit(:start_time, :end_time, :break_time)
  end

end
