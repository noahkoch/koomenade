module RenderHelper
  def load_page html_safe_contents
    begin
      without_comments = clear_comments(html_safe_contents)
      with_queries = run_queries(without_comments)
      add_fields(add_forms(with_queries)).html_safe
    rescue
      return "Syntax Error"
    end
  end

  def clear_comments html_safe_contents
    kql_comments = html_safe_contents.scan(/\[\/\/kql::([^\]]*)/)

    if kql_comments.any?
      kql_comments.flatten.each do |query|
        html_safe_contents.gsub!("[//kql::#{query}]", "")
      end
    end

    return html_safe_contents
  end

  def run_queries html_safe_contents
    kql_queries = html_safe_contents.scan(/\[kql::([^\]]*)/)

    if kql_queries.any? 
      values = []
      kql_queries.flatten.each do |query|
        table, *query_methods = query.split(".")

        begin
          values << [query, KQLDataStore.get_store(current_user, table).run_methods(query_methods).get]
        rescue ArgumentError => e
          values << [query, "<span class='error'>#{e.message}</span>"]
        end
      end

      values.each do |value_array|
        string_to_replace, query_value = value_array
        html_safe_contents.gsub!("[kql::#{string_to_replace}]", query_value.to_s)
      end
    end

    return html_safe_contents
  end

  def add_forms html_safe_contents
    kql_forms = html_safe_contents.scan(/\[kqlform::([^\]]*)/)

    if kql_forms.any?
      values = []
      kql_forms.flatten.each do |form|
        table_name = form.split(" ").first
        values << [form, "method='post' action='?_store=#{table_name}'"]
      end

      values.each do |value_array|
        string_to_replace, query_value = value_array
        html_safe_contents.gsub!("[kqlform::#{string_to_replace}]", query_value)
      end
    end

    return html_safe_contents
  end

  def add_fields html_safe_contents
    kql_fields = html_safe_contents.scan(/\[kqlfield::([^\]]*)/)

    if kql_fields.any?
      values = []
      kql_fields.flatten.each do |field|
        table_name, field_name = field.split(":")
        values << [field, "name='#{table_name}[#{field_name}]'"]
      end

      values.each do |value_array|
        string_to_replace, query_value = value_array
        html_safe_contents.gsub!("[kqlfield::#{string_to_replace}]", query_value)
      end
    end

    return html_safe_contents
  end
end
