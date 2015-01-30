module Aaww
  class Status
    include ActiveModel::Model

    attr_accessor :code, :description, :extended_description

    def error?
      code == 'error'
    end

    def ok?
      code == 'ok'
    end
  end
end
