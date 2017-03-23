module RichSnippet
  class Product < Thing
    attribute :mpn, :string
    attribute :brand, :reference
    attribute :offers, :referencelist
    attribute :awards, :stringlist
    attribute :category, :string
    attribute :color, :string
    attribute :height, :float
    attribute :width, :float
    attribute :depth, :float
    attribute :weight, :float
    attribute :item_condition, :enum, values: ['Damaged','New','Refurbished','Used']
    attribute :manufacturer, :reference
    attribute :release_date, :date

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org/",
        "@type": "Product",
        name: name,
        image: image,
        description: description,
        mpn: mpn,
        award: awards,
        brand: brand ? brand.to_json : nil,
        offers: array_json(offers),
        itemCondition: "https://schema.org/#{item_condition}Condition",
        category: category,
        color: color,
        height: height,
        width: width,
        depth: depth,
        weight: weight,
        manufacturer: manufacturer ? manufacturer.to_json : nil,
        releaseDate: release_date
      }.delete_if { |k, v| !v.present? }
    end
  end
end
