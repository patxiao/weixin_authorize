# encoding: utf-8
module WeixinAuthorize

  class ResultHandler

    attr_accessor :code, :cn_msg, :en_msg, :result

    def initialize(code, en_msg, result={})
      @code   = code   || 0
      @en_msg = en_msg || "ok"
      @cn_msg = GLOBAL_CODES[@code.to_i]
      @result = package_result(result)
    end

    # This method is to valid the current request if is true or is false
    def is_ok?
      code == OK_CODE
    end

    # e.g.:
    # 45009: api freq out of limit(接口调用超过限制)
    def full_message
      "#{code}: #{en_msg}(#{cn_msg})."
    end

    def full_error_message
      full_message if !is_ok?
    end

    private

      # if define Rails constant
      # result = WeixinAuthorize::ResultHandler.new("0", "success", {:ok => "true"})
      # result.result["ok"] #=> true
      # result.result[:ok] #=> true
      # result.result['ok'] #=> true
      def package_result(result)
        if defined?(Rails)
          ActiveSupport::HashWithIndifferentAccess.new(result)
        else
          result
        end
      end

  end

end
