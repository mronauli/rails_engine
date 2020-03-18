require 'csv'

def import_from_csv(file, model)
  counter = 0
  CSV.foreach(file, headers: true) do |row|
    my_row = row.to_hash
    if my_row['unit_price']
      my_row['unit_price'] = (my_row['unit_price'].to_r / (100)).to_f
    end
    object = model.create(my_row)
    counter += 1 if object.persisted?
  end
  counter
end
