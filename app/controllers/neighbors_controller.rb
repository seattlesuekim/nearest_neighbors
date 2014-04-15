class NeighborsController < ApplicationController

  #def index
  #  if cookies[:uuid]
  #
  #  end
  #end

  def show
    @dump_hash = Neighbor::DUMP_HASH
    render :show
  end

  def create
    cookies.permanent[:uuid] = params[:keyid] unless cookies[:uuid]
    @neighbors = Neighbor.nearest_neighbors(params[:keyid], params[:n])
    render :show
  end
end
