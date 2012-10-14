AttributeNormalizer.configure do |config|

  config.normalizers[:twitter] = lambda do |value, options|
    value.is_a?(String) ? value.gsub('@', '').gsub(' ', '').strip : value
  end
end
