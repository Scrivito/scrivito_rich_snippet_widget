module RichSnippet
  class Offer < Thing
    attribute :availability_starts, :date
    attribute :availability_ends, :date
    attribute :availability, :string
    attribute :price, :string
    attribute :price_currency, :string
    attribute :item_condition, :enum, values: ['Damaged','New','Refurbished','Used']
    attribute :inventory_level, :integer
    attribute :seller, :reference

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "Offer",
        name: name,
        image: image ? image.binary_url : '',
        description: description,
        url: url,
        availability: {
          '@context': "http://schema.org",
          '@type': "ItemAvailability",
          description: availability
        },
        inventoryLevel: inventory_level,
        availabilityStarts: availability_starts,
        availabilityEnds: availability_ends,
        price: price,
        priceCurrency: price_currency,
        itemCondition: "https://schema.org/#{item_condition}Condition",
        seller: seller ? seller.to_json : nil
      }.delete_if { |k, v| !v.present? }
    end

    def warnings
      warns = []
      warns << "Price in the form xx.yy" if price.contains(',')
      return warns
    end
  end
end
