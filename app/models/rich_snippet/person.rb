module RichSnippet
  class Person < Thing
    attribute :given_name, :string
    attribute :additional_name, :string
    attribute :family_name, :string
    attribute :address, :reference
    attribute :birth_date, :date
    attribute :birth_place, :reference
    attribute :death_date, :date
    attribute :death_place, :reference
    attribute :childs, :referencelist
    attribute :email, :string
    attribute :gender, :string
    attribute :height, :float
    attribute :nationality, :string
    attribute :mother, :reference
    attribute :father, :reference
    attribute :siblings, :referencelist
    attribute :telephone, :string
    attribute :weight, :float
    attribute :work_location, :reference
    attribute :works_for, :reference

    def to_json(render_childs = false)
      json = {
        "@context": "http://schema.org",
        "@type": "Person",
        name: name,
        description: description,
        image: image ? image.binary_url : nil,
        url: url,
        givenName: given_name,
        additionalName: additional_name,
        familyName: family_name,
        address: address ? address.to_json : nil,
        birthDate: birth_date,
        birthPlace: {
          "@context": "http://schema.org",
          "@type": "Place",
          address: birth_place ? birth_place.to_json : nil
        },
        deathDate: death_date,
        "deathPlace": {
          "@context": "http://schema.org",
          "@type": "Place",
          address: death_place ? death_place.to_json : nil
        },
        email: email,
        gender: gender,
        height: height,
        nationality: nationality,
        workLocation: work_location ? work_location.to_json : nil,
        worksFor: works_for ? works_for.to_json : nil,
        telephone: telephone,
        weight: weight
      }

      if(render_childs)
        json[:children] = array_json(children)
        json[:siblings] = array_json(siblings)
        json[:parents] = [
          mother.to_json,
          father.to_json
        ]
      end

      return json.delete_if { |k, v| !v.present? }
    end
  end
end
