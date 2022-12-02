module Sorterable 
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_by(query_params)
      ordering = {}
      if query_params
        sort_order = { '+' => :asc, '-' => :desc }
        sorted_params = query_params.split(',')
        sorted_params.each do |attr|
          sort_sign = attr =~ /\A[+-]/ ? attr.slice!(0) : '+'
          ordering[attr] = sort_order[sort_sign]
        end
      end
      order(ordering)
    end
  end
end
