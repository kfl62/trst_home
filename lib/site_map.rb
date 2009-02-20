# site_map.rb

require 'yaml'
module SiteMap

  SITEYAML = File.join(File.dirname(__FILE__), 'site_map.yml')
  SITEMAP = YAML::load_file(SITEYAML)

  def self.method_missing(meth, *args, &blk)
    SITEMAP.send(meth, *args, &blk) rescue super
  end

  def self.to_html
    ret = ""
    ret << "<table class='site_map'>\n  <thead>\n  <tr>\n"
    ret << "  <td>Nr.</td>\n"
    ret << "  <td>Adresă</td>\n"
    ret << "  <td>Nume</td>\n"
    ret << "  <td>Tip</td>\n"
    ret << "  <td>Browser</td>\n"
    ret << "  <td>Detalii</td>\n"
    ret << "  </thead>\n  <tbody>\n"
    sort_by{|name, data| data['order']}.each do |name, data|
      tr_tag = data['order'].to_i.even? ? "  <tr class='even'>\n" : "  <tr class='odd'>\n"
      ret << tr_tag
      ret << "    <td style='text-align:right;'>#{data['order']}.</td>\n"
      ret << "    <td><a href='http://#{name}' title='#{data['expl']}'>#{name}</a></td>\n"
      ret << "    <td>#{data['name']}</td>\n"
      ret << "    <td>#{data['kind']}</td>\n"
      ret << "    <td>#{data['browser']}</td>\n"
      ret << "    <td>#{data['expl']}</td>\n"
      ret << "  </tr>\n"
    end
    ret << "</tbody>\n</table>"
    ret
  end
  
end