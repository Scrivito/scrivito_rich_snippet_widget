module RichSnippet
  class Event < Thing
    attribute :start_date, :date
    attribute :end_date, :date
    attribute :organizer, :reference
    attribute :in_language, :string
    attribute :offers, :referencelist, only: Offer
    attribute :location, :reference
    attribute :performers, :referencelist
    attribute :sub_events, :referencelist
    attribute :super_event, :reference
    attribute :event_status, :enum, values: ['auto','cancelled','rescheduled'], default: 'auto'

    def event_status_type
      return 'moron' if end_date < start_date
      if (event_status == 'auto') || (event_status == '')
        if Time.now < start_date
          'not started'
        elsif Time.now > end_date
          'completed'
        else
          'in process'
        end
      else
        event_status
      end
    end

    def warnings
      warns = []
      warns << 'End date is before start date!' if end_date < start_date
      warns << 'Start date is mandatory' if start_date.blank?
      warns << 'End date is recommendet' if end_date.blank?
      warns << 'Location is mandatory' if location.nil?
      warns << 'Event status is recommendet' if event_status.blank?
      warns << 'Offers are recommendet' if offers.empty?
      return warns
    end

    def to_json(render_childs = false)
      json = {
        "@context": "http://schema.org",
        "@type": "Event",
        name: name,
        description: description,
        image: image ? image.binary_url : nil,
        startDate: start_date,
        endDate: end_date,
        organizer: organizer ? organizer.to_json : nil,
        inLanguage: in_language,
        offers: array_json(offers),
        location: location ? location.to_json : nil,
        performers: array_json(performers),
        url: url,
        EventStatus: {
          "@context": "http://schema.org",
          "@type": "EventStatusType",
          description: event_status_type
        }
      }

      if render_childs
        json[:subEvents] = array_json(sub_events)
        json[:superEvent] = super_event ? super_event.to_json : nil
      end

      return json.delete_if { |k, v| !v.present? }
    end
  end
end
