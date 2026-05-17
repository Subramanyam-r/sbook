# _plugins/last_modified.rb
require 'jekyll-last-modified-at/determinator'

Jekyll::Hooks.register :site, :pre_render do |site|
  # Process standard site pages
  site.pages.each do |page|
    next unless page.path # Skip virtual layout pages
    
    begin
      # Use the official Determinator API
      determinator = Jekyll::LastModifiedAt::Determinator.new(site.source, page.path)
      # Map the string formatted output straight to Just the Docs' expected variable
      page.data['last_modified_date'] ||= determinator.to_s
    rescue => e
      Jekyll.logger.warn "LastModifiedAt Plugin:", "Could not resolve date for #{page.path}: #{e.message}"
    end
  end

  # Process site documents and collections (where Just the Docs content lives)
  site.documents.each do |doc|
    next unless doc.path
    
    begin
      determinator = Jekyll::LastModifiedAt::Determinator.new(site.source, doc.path)
      doc.data['last_modified_date'] ||= determinator.to_s
    rescue => e
      Jekyll.logger.warn "LastModifiedAt Plugin:", "Could not resolve date for #{doc.path}: #{e.message}"
    end
  end
end
