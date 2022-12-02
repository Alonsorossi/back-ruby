module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(filtering_params)
      results = self
      filtering_params&.each do |key, value|
        value = value.reject(&:blank?) if value.is_a?(Array)
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end
  end
end
