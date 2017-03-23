module RichSnippet
  class PostalAddress < Thing
    attribute :address_country, :string
    attribute :address_locality, :string
    attribute :address_region, :string
    attribute :post_office_box_number, :string
    attribute :postal_code, :string
    attribute :street_address, :string
    attribute :email, :string
    attribute :telephone, :string
    attribute :fax_number, :string

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "PostalAddress",
        name: name,
        description: description,
        image: image ? image.binary_url : '',
        url: url,
        addressCountry: address_country,
        addressLocality: address_locality,
        addressRegion: address_region,
        postOfficeBoxNumber: post_office_box_number,
        postalCode: postal_code,
        streetAddress: street_address,
        email: email,
        telephone: telephone,
        faxNumber: fax_number
      }.delete_if { |k, v| !v.present? }
    end
  end
end
