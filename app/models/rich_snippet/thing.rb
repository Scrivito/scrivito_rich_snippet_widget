module RichSnippet
  class Thing < Obj
    attribute :description, :string
    attribute :image, :reference
    attribute :title, :string
    attribute :url, :string

    def name
      self.title
    end

    def module
      self.class.name.demodulize.downcase
    end

    def type
      self.class.name.underscore
    end

    def array_json(attribute)
      o = []
      attribute.each do |elem|
        o << elem.to_json
      end
      return o
    end

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "Thing",
        name: name,
        description: description,
        image: image ? image.binary_url : '',
        url: url
      }.delete_if { |k, v| !v.present? }
    end

    def warnings
      []
    end
  end
end
