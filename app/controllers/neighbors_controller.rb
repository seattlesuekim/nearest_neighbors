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
    @dump_hash = Neighbor::DUMP_HASH
    cookies.permanent[:uuid] = params[:keyid] unless cookies[:uuid]
    @neighbors = Neighbor.nearest_neighbors(params[:keyid], params[:n])
    #@famous_ppeople = Neighbor(query_wikipedia)
    render :show
  end

end