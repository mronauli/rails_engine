require 'csv'

def import_from_csv(file, model)
  counter = 0
  CSV.foreach(file, headers: true) do |row|
    my_row = row.to_hash
    my_row.delete('id')
    object = model.create(my_row)
    counter += 1 if object.persisted?
  end
  counter
end
