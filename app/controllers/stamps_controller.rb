class StampsController < ApplicationController
  def create
    @stamp = current_user.find_stamp_by(stamp_params_target_date)
    if @stamp == nil
      @stamp = Stamp.new(stamp_params)
    else
      @stamp.update(stamp_params)
    end

    if @stamp.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    stamp = Stamp.find(params[:id])
    if stamp.update(stamp_params)
      redirect_to root_url
    else
    end
  end

  def destroy
    stamp = Stamp.find(params[:id])
    stamp.destroy
    redirect_to root_url
  end

  def stamp_params
    params.require(:stamp).permit(:target_date, :status, :message, :user_id)
  end

  def stamp_params_target_date
    Date.new(
      stamp_params['target_date(1i)'].to_i,
      stamp_params['target_date(2i)'].to_i,
      stamp_params['target_date(3i)'].to_i)
  end
end
