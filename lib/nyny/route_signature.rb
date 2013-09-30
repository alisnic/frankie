module NYNY
  class RouteSignature
    NAME_PATTERN = /:(\S+)/

    attr_reader :pattern
    def initialize signature
      @pattern = pattern_for signature
    end

    def pattern_for signature
      return signature if signature.is_a? Regexp
      build_regex(signature.start_with?('/') ? signature : "/#{signature}")
    end

    def build_regex signature
      return %r(^#{signature}$) unless signature.include?(':')

      groups = signature.split('/').map do |part|
        next part if part.empty?
        next part unless part.start_with? ':'
        name = NAME_PATTERN.match(part)[1]
        %Q{(?<#{name}>\\S+)}
      end.select {|s| !s.empty? }.join('\/')

      %r(^\/#{groups}$)
    end

    def match path
      data = pattern.match path
      if data
        Hash[data.names.map {|n| [n.to_sym, URI.unescape(data[n])]}]
      end
    end
  end
end
