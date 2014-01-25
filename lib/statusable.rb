module Statusable
  extend ActiveSupport::Concern

  # included do
  #   @statuses = {}
  # end

  class StatusDefinedError < StandardError; end

  module ClassMethods
    def status(statuses_with_translations)
      unless statuses.empty?
        raise StatusDefinedError, "Model statuses already defined #{statuses}"
      end
      @statuses = statuses_with_translations
      validates_inclusion_of :status, :in => status_keys,
        :message =>
          "статус должен быть одним из: #{statuses.values.join ', '}"
    end

    def statuses
      @statuses ||= {}
    end

    def status_keys
      statuses.keys.map(&:to_s)
    end

    def published
      where(status: 'published')
    end
  end

  def published?
    read_attribute(:status) == 'published'
  end

  def status_ru
    self.class.statuses[read_attribute(:status).to_sym]
  end
end