class FutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record[attribute].past?
      record.errors[attribute] << (options[:message] || "can't be in the past!")
    end
  end
end
