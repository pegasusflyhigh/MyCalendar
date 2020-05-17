# frozen_string_literal: true

require 'httparty'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
