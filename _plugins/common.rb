module Common

  class DynamicStaticFile < Jekyll::StaticFile
    def initialize(site, base, dir, name, dest)
      super(site, base, dir, name)
      @name = name
      @dest = dest
    end
    def destination(dest)
      @destination ||= {}
      @destination[@dest] ||= @site.in_dest_dir(@dest, Jekyll::URL.unescape_path(url))
    end
  end

end