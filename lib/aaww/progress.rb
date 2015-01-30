module Aaww
  class Progress
    include ActiveModel::Model

    attr_accessor :minutes_left, :printing_percentage, :message,
                  :printing_job_status_name

    def any?
      !printing_percentage.nil?
    end
  end
end
