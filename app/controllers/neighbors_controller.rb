class NeighborsController < ApplicationController
  def create
    @name = Neighbor.to_name(params[:keyid])
    cookies.permanent[:uuid] = params[:keyid] unless cookies[:uuid]
    @neighbors = Neighbor.nearest_neighbors(params[:keyid], params[:n])
    render :show
  end

  def is_famous?(name)
    File.open('vip.dat', 'r') do |f|
      f.each_line do |line|
        if line == "#{name}, yes"
          true
        elsif line == "#{name}, no"
          false
        else
          #false
        end
      end
    end
  end

end
