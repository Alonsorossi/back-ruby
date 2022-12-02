module Paginable
  extend ActiveSupport::Concern

  module ClassMethods
    DEFAULT_PAGINATION = 10

    def offset_params(pagination_params)
      return 0 if !pagination_params.respond_to?('has_key?')
      return 0 if pagination_params[:number].nil?

      index = pagination_params[:number].to_i - 1
      (index * limit_params(pagination_params).to_i) || 0
    end

    def limit_params(pagination_params)
      if pagination_params.respond_to?('has_key?')
        if pagination_params[:size]
          pagination_params[:size] || DEFAULT_PAGINATION
        else
          DEFAULT_PAGINATION
        end
      else
        DEFAULT_PAGINATION
      end
    end

    def paginate_by(pagination_params)
      limit(limit_params(pagination_params))
        .offset(offset_params(pagination_params))
    end
  end
end
