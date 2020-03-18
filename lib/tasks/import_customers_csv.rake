require 'csv'
require_relative 'helpers.rb'

  task create_models: :environment do
    Rake::Task["db:reset"].invoke
    datas = [
      ["db/data/merchants.csv", Merchant],
      ["db/data/customers.csv", Customer],
      ["db/data/items.csv", Item],
      ["db/data/invoices.csv", Invoice],
      ["db/data/invoice_items.csv", InvoiceItem],
      ["db/data/transactions.csv", Transaction]
    ]
    datas.each do |data|
      file = data[0]
      model = data[1]
      counter = import_from_csv(file, model)
      puts "Imported #{counter} #{model.name}s."
    end
end
