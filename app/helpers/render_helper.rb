module RenderHelper
  def load_page html_safe_contents
    kql_queries = html_safe_contents.scan(/\[kql::([^\]]*)/)

    if kql_queries.empty?
      return html_safe_contents
    else
      values = []
      kql_queries.each do |query|
        table, *query_methods = query.first.split(".")

        begin
          values << KQLDataStore.get_store(current_user, table).run_methods(query_methods).get
        rescue ArgumentError => e
          values << e.message
        end
      end

      return "#{html_safe_contents} <br> #{values.join('<br>')}".html_safe
    end
  end
end
