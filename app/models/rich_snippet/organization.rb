module RichSnippet
  class Organization < Thing
    attribute :address, :reference
    attribute :founder, :reference
    attribute :founding_date, :date
    attribute :legal_name, :string
    attribute :logo, :reference
    attribute :number_of_employees, :integer
    attribute :parent_organization, :reference
    attribute :sub_organizations, :referencelist
    attribute :telephone, :string

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "Organization",
        name: name,
        description: description,
        image: image ? image.binary_url : '',
        url: url,
        address: address ? address.to_json : nil,
        founder: founder ? founder.to_json : nil,
        foundingDate: founding_date,
        legalName: legal_name,
        logo: logo ? logo.binary_url : nil,
        numberOfEmployees: number_of_employees,
        parentOrganization: parent_organization ? parent_organization.to_json : nil,
        subOrganizations: array_json(sub_organizations),
        telephone: telephone
      }.delete_if { |k, v| !v.present? }
    end
  end
end
