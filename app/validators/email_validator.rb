class EmailValidator < ActiveModel::EachValidator
  EMAIL_PATTERN = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def validate_each(record, attribute, value)
    return if record.send(attribute) =~ EMAIL_PATTERN

    record.errors[attribute] << (options[:message] || "is not a valid e-mail address")
  end
end
