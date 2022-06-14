module KobitaCollectionJsonView
  class Generator < Jekyll::Generator

    def generate(site)
      jsons = {}
      site.collections["datalake_kobita_app"].docs.each do |doc|
        unless jsons.key?(doc["post_type"])
          jsons[doc["post_type"]] = []
        end
        jsons[doc["post_type"]].push(doc.data)
      end

      jsons.each do |json_item_key, json_item_list|
        json_file = create_file("./generated/kobita_app/" + json_item_key + "s", "json")
        json_file.puts(json_item_list.to_json)
        json_file.close
        site.static_files << Common::DynamicStaticFile.new(site, site.source, "/generated/kobita_app/", json_item_key + "s.json", "/assets/")
      end

    end

    def create_file(path, extension)
      dir = File.dirname(path)

      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end

      path << ".#{extension}"
      File.new(path, 'w')
    end
  end

end