class SearchController < ApplicationController
  def search
    load_data()
    @search = false;
    search_hash = Hash.new
    make_id = params.fetch("make", "-1").to_i
    model_id = params.fetch("model", "-1").to_i
    length = params.fetch("length", "-1").to_i
    width = params.fetch("width", "-1").to_i
    thickness = params.fetch("width", "-1").to_i
    volume = params.fetch("volume", "-1").to_i
    price = params.fetch("price", "-1").to_i
    condition = params.fetch("condition", "-1").to_i
    driving_time = params.fetch("driving_time", "-1").to_i
    address = params.fetch("address", "-1")
    if address != "-1"
      address = address.downcase.gsub(",", "")
    end
    tail = params.fetch("tail", "-1").to_i
    fin_config = params.fetch("fin_config", "-1").to_i
    fin_system = params.fetch("fin_system", "-1").to_i
    construction = params.fetch("construction", "-1").to_i
    artwork = params.fetch("artwork", "-1").to_i
    [make_id, model_id, length, width, thickness, volume, price, condition, driving_time, tail, fin_config, fin_system, construction, artwork].each do |param|
      if param != -1
        @search = true
      end
    end

    if @search

      if model_id != -1
        search_hash[:model_id] = model_id
      elsif make_id != -1
        make_models = Model.where({:make_id => make_id}).map_relation_to_array(:id)
        search_hash[:model_id] = make_models
      end

      if length == 1
        min_length = params.fetch("min_length").to_i
        max_length = params.fetch("max_length").to_i
        search_hash[:length] = (min_length..max_length)
      end

      if width == 1
        min_width = params.fetch("min_width").to_i
        max_width = params.fetch("max_width").to_i
        search_hash[:width] = (min_width..max_width)
      end

      if thickness == 1
        min_thickness = params.fetch("min_thickness").to_i
        max_thickness = params.fetch("max_thickness").to_i
        search_hash[:thickness] = (min_thickness..max_thickness)
      end

      if volume == 1
        min_volume = params.fetch("min_volume").to_i
        max_thickness = params.fetch("max_volume").to_i
        search_hash[:volume] = (min_volume..max_volume)
      end

      if price == 1
        min_price = params.fetch("min_price").to_i
        max_price = params.fetch("max_price").to_i
      end

      if condition != -1
        search_hash[:condition] = condition
      end

      if tail != -1
        search_hash[:tail] = tail
      end

      if fin_config != -1
        search_hash[:fin_config] = fin_config
      end

      if fin_system != -1
        search_hash[:fin_system] = fin_system
      end

      if construction != -1
        search_hash[:construction] = construction
      end

      if artwork != -1
        search_hash[:artwork] = true
      end

      @boards = Board.where(search_hash)
      if driving_time != -1 && address != ""

        shop_ids = @boards.map_relation_to_array(:shop_id)
        these_shops = Shop.where({:id => shop_ids})
        individual_ids = @boards.map_relation_to_array(:individual_id)
        these_individuals = User.where({:id => individual_ids})

        these_shops_addresses = these_shops.map_relation_to_array(:address)
        these_individuals_addresses = these_individuals.map_relation_to_array(:address)

        all_addresses = these_shops.map_relation_to_array(:address) + these_individuals.map_relation_to_array(:address)
        previous_destinations = Distance.where({:origin => address}).map_relation_to_array(:destination)
        
        new_addresses = all_addresses - previous_destinations
        if new_addresses.count > 0
          new_addresses_f = new_addresses.map { |x| x.gsub(/\s+/, "+")}
          new_addresses_f = new_addresses.map { |x| x.gsub(",", "")}
          url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" + address.gsub(/\s+/, "+") + "&destinations=" + new_addresses_f.join("|") + "&key=" + ENV.fetch("MAPS_KEY")
          raw_data = open(url).read
          parsed_data = JSON.parse(raw_data)
          data = parsed_data["rows"][0]["elements"]
          data.each_with_index do |vals, ind|
            d = Distance.new
            d.origin = address
            d.destination = new_addresses.at(ind)
            d.distance = vals["distance"]["value"]
            d.duration = vals["duration"]["value"]
            d.save
          end
        end

        right_addresses = Distance.where({:duration => (0..driving_time)}).map_relation_to_array(:destination)
        right_shops = Shop.where({:address => right_addresses}).map_relation_to_array(:id)
        right_individuals = User.where({:address => right_addresses}).map_relation_to_array(:id)
            
              
      end
      @boards = @boards.where({:shop_id => right_shops}).or(@boards.where({:individual_id => right_individuals}))
      @individual_board_locations = Hash.new
      @shop_board_locations = Hash.new
      @boards.each do |board|
        if board.owner_is_shop
          if !@shop_board_locations.key?(board.shop_id)
            @shop_board_locations[board.shop_id] = Array.new
          end            
          @shop_board_locations[board.shop_id].push(board)
        else
          if !@individual_board_locations.key?(board.individual_id)
            @individual_board_locations[board.individual_id] = Array.new
          end
          @individual_board_locations[board.shop_id].push(board)
        end
      end
    else
      @boards = Array.new
      @individual_board_locations = Hash.new
      @shop_board_locations = Hash.new
    end
    
    render({:template => "home/search.html.erb"})
  end
end