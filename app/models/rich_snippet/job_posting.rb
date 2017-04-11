module RichSnippet
  class JobPosting < Thing
    attribute :base_salary, :integer
    attribute :date_posted, :date
    attribute :education_requirements, :string
    attribute :employment_type, :enum, values: ['full-time', 'part-time', 'contract', 'temporary', 'seasonal', 'internship']
    attribute :experience_requirements, :string
    attribute :hiring_organization, :reference
    attribute :job_benefits, :string
    attribute :job_location, :reference
    attribute :qualifications, :string
    attribute :salary_currency, :string
    attribute :skills, :string
    attribute :job_title, :string
    attribute :valid_through, :date
    attribute :work_hours, :string

    def to_json(render_childs = false)
      {
        "@context": "http://schema.org",
        "@type": "JobPosting",
        name: name,
        description: description,
        image: image ? image.binary_url : nil,
        url: url,
        baseSalary: base_salary,
        datePosted: date_posted,
        educationRequirements: education_requirements,
        employmentType: employment_type,
        experienceRequirements: experience_requirements,
        hiringOrganization: hiring_organization ? hiring_organization.to_json : nil,
        jobBenefits: job_benefits,
        jobLocation: {
          "@context": "http://schema.org",
          "@type": "Place",
          address: job_location ? job_location.to_json : nil,
        },
        qualifications: qualifications,
        salaryCurrency: salary_currency,
        skills: skills,
        title: job_title,
        validThrough: valid_through,
        workHours: work_hours
      }.delete_if { |k, v| !v.present? }
    end
  end
end
