module RandomKobitaFragmentJsonView
  class Generator < Jekyll::Generator

    def generate(site)
      docs = []
      site.collections["datalake_kobita_app"].docs.each do |doc|
        if doc["post_type"] == "kobita-fragment"
          docs.push(doc.data)
        end
      end

      json_file = create_file("./generated/kobita_app/random-kobita", "json")
      json_file.puts(docs.sample.to_json)
      json_file.close
      site.static_files << Common::DynamicStaticFile.new(site, site.source, "/generated/kobita_app/", "random-kobita.json", "/assets/")

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