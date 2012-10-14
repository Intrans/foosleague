AttributeNormalizer.configure do |config|

  config.normalizers[:twitter] = lambda do |value, options|
    value.is_a?(String) ? value.gsub('@', '').gsub(' ', '').strip.downcase : value
  end
end
