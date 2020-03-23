module SearchAttributes
  # def search_all_fields(params)
  #   require "pry"; binding.pry
  #   self.where(
  #     self.column_names.select do |field|
  #       self.type_for_attribute(field).type == :integer
  #         "#{field} ilike '%#{params}%'"
  #     end.join(" or ")
  #   )
  # end
  def search_all_fields(params)
    query = []
    string_col = self.column_names.select { |field| self.type_for_attribute(field).type == :integer }
    datetime_col = self.column_names.select { |field| self.type_for_attribute(field).type == :datetime }
    string_col.each do |col|
      query << "#{col} ilike %#{params[col]}%"
    end
    query.join(" or ")
  end
  # def count_decimal
  #   self.unit_price.to_s.split('.').last.size
  # end
end
