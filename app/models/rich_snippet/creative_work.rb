module RichSnippet
  class CreativeWork < Thing
    attribute :work_type, :enum, values: ['Book','Game','Movie','Photograph','Painting','Serie','WebPage','MusicComposition','SoftwareSourceCode']
    attribute :about, :string
    attribute :author, :reference
    attribute :contributor, :reference
    attribute :copyright_holder, :reference
    attribute :copyright_year, :integer
    attribute :date_created, :date
    attribute :date_published, :date
    attribute :genre, :string
    attribute :in_language, :string
    attribute :is_accessible_for_free, :enum, values: ['Yes', 'No'], default: 'No'
    attribute :is_based_on, :reference
    attribute :is_family_friendly, :enum, values: ['Yes', 'No'], default: 'Yes'
    attribute :license, :string
    attribute :offers, :referencelist
    attribute :position, :integer
    attribute :publisher, :reference
    attribute :thumbnail_url, :string
    attribute :typical_age_range, :string
    attribute :code_repository, :string
    attribute :programming_language, :string
    attribute :runtime_platform, :string

    #Book
    attribute :illustrator, :reference
    attribute :isbn, :string
    attribute :number_of_page, :integer

    #Movie
    attribute :actors, :referencelist
    attribute :director, :reference
    attribute :duration, :integer

    #WebPage
    attribute :breadcrumb, :string

    #MusicComposition
    attribute :composer, :reference
    attribute :lyricist, :reference
    attribute :lyrics, :string

    def to_json(render_childs = false)
      json = {
        "@context": "http://schema.org",
        "@type": work_type.presence || "CreativeWork",
        name: name,
        description: description,
        image: image ? image.binary_url : nil,
        url: url,
        about: about,
        author: author ? author.to_json : nil,
        contributor: contributor ? contributor.to_json : nil,
        copyrightHolder: copyright_holder ? copyright_holder.to_json : nil,
        copyrightYear: copyright_year,
        dateCreated: date_created,
        datePublished: date_published,
        genre: genre,
        inLanguage: in_language,
        isAccessibleForFree: is_accessible_for_free == 'Yes',
        isBasedOn: is_based_on ? is_based_on.to_json: nil,
        isFamilyFriendly: is_family_friendly == 'Yes',
        license: license,
        offers: array_json(offers),
        position: position,
        publisher: publisher ? publisher.to_json : nil,
        thumbnailUrl: thumbnail_url,
        typicalAgeRange: typical_age_range
      }

      if work_type == 'Book'
        json[:illustrator] = illustrator ? illustrator.to_json : nil
        json[:isbn] = isbn
        json[:numberOfPage] = number_of_page
      elsif work_type == 'Movie'
        json[:actors] = array_json(actors)
        json[:director] = director ? director.to_json : nil
        json[:duration] = duration
      elsif work_type == 'WebPage'
        json[:breadcrumb] = Obj.repson_to?('page_breadcrumb') ? obj.page_breadcrumb : breadcrumb
      elsif work_type == 'MusicComposition'
        json[:composer] = composer ? composer.to_json : nil
        json[:lyricist] = lyricist ? lyricist.to_json : nil
        json[:lyrics] = lyrics
      elsif work_type == 'SoftwareSourceCode'
        json[:codeRepository]= code_repository
        json[:programmingLanguage]= programming_language
        json[:runtimePlatform]= runtime_platform
      end

      return json.delete_if { |k, v| !v.present? }
    end
  end
end
