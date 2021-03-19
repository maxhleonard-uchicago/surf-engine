namespace :sample do
  desc "TODO"
  task boards: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "ci_models.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      m = Model.new
      m.name = row["name"]
      m.make_id = 1
      m.image = row["full_image"]
      m.logo = row["logo"]
      m.webpage = row["webpage"]
      m.save
    end
  end

  task shops: :environment do
    require "csv"
    csv_text = File.read(Rails.root.join("lib", "csvs", "ci_dims.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      3.times do
        b = Board.new
        b.model_id = row["model_id"]
        b.length = row["length"].to_i
        b.width = row["width"].to_i
        b.thickness = row["thickness"].to_i
        b.liters = row["liters"]
        b.tail = [0,0,0,0,0,0,0,0,0,1,1,2,4,6].sample
        if [3, 8, 16].include?(b.model_id)
          b.fin_config = 2
        elsif b.model_id == 4
          b.fin_config = 4
        elsif [17, 21, 20].include?(b.model_id)
          b.fin_config = 6
        else
          b.fin_config = [0,1].sample
        end

        b.fin_system = [0,0,0,0,0,1,1,1,1,1,2].sample
        b.construction = [0,0,0,0,1].sample
        b.shop_id = [1,2,3].sample
        b.owner_is_shop = true
        b.condition = 3
        b.artwork = false
        b.save
      end
    end
  end        
end
