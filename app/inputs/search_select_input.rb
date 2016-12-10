class SearchSelectInput < Formtastic::Inputs::StringInput
  def input_html_options
    relation = @object.send(attributized_method_name)
    opts = {}
    opts[:class] = ['select2-ajax'].concat([@options[:class]] || []).join(' ')
    opts["data-fields"] = (@options[:fields] || []).to_json
    opts["data-url"] = @options[:url] || ""
    opts["data-response_root"] = @options[:response_root] || @options[:url].to_s.split('/').last
    opts["data-display_name"] = @options[:display_name] || "name"
    opts["data-minimum_input_length"] = @options[:minimum_input_length] || 1
    opts["data-allow_clear"] = @options.key?(:allow_clear) ? @options[:allow_clear] : "false"
    opts["data-placeholder"] = @options[:placeholder]
    if opts["data-allow_clear"] && opts["data-placeholder"].blank?
      opts["data-placeholder"] = 'Search...'
    end
    opts["data-width"] = @options[:width] if @options[:width]
    opts["data-selected"] = relation.try(opts["data-display_name"].to_sym)
    super.merge opts
  end
end
