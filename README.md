# ScrivitoRichSnippetWidget
Add structured data to you page. Definitions are from https://schema.org

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'scrivito_rich_snippet_widget'
```

And then execute:
```bash
$ bundle
```

To make the content browser filter available add this to your content browser filter js:

Add this line to your JavaScript manifest **before** you load your content browser filter:

```js
//= require scrivito_rich_snippet_widget
```

```js
scrivito.content_browser.filters(filter) {
  if(filter.rich_snippet_filter) {
    rich_snippet_filter(filter.rich_snippet_filter)
  } else if (your filters) {
    // ... add your filters here
  } else {
    '_obj_class': {
      options: {
        // ... add your type defs here
        rich_snippets: {
          title: 'Rich Snippets',
          options: {
            rich_snippet_filter()
          }
        }
      }
    }
  }
}
```

## Add your own types

Create a modle at `/model/rich_snippet/new_type.rb` and add your attribute in this scheme:

```ruby
module RichSnippets
  class NewType < RichSnippet::Thing
    attribute my_attribute, :string
    attribute person, :refernce
    attribute children, :referencelist
    # ... more attributes

    def to_json
      {
        myAttribute: my_attribute,
        person: person ? person.to_json : nil, # render the json for another rich snippet
        children: array_json(children), # render an array of other rich snippets
        # ... definition for more attributes
      }
    end

    # optional method to add warnings rendered by the widget
    def warnings
      warns = []
      warns << "this attribute should be set!" if my_attribute.blank?
      return warns
    end
  end
end
```

The create the details view. You need to files:

```ruby
# add rich_snippet/new_type/details.html.erb
<%= render 'rich_snippet/new_type/details', obj: @obj %>
```

```ruby
# add rich_snippet/new_type/_details.html.erb
<%= render 'rich_snippet/thing/details', obj: obj, url_is_mandatory: false %>

<%= scrivito_details_for "Event attributes" do %>
  <%= scrivito_details_for 'My attribute' do %>
    <%= scrivito_tag :div, obj, :my_attribute %>
  <% end %>

  <%= scrivito_details_for 'Person do %>
    <%= scrivito_tag :div, obj, :person, data: {scrivito_editors_filter_context: {rich_snippet_filter: ['Person', 'Organizazion']}} %>
  <% end %>

  <%= scrivito_details_for 'Children' do %>
    <%= scrivito_tag :div, obj, :children, data: {scrivito_editors_filter_context: {rich_snippet_filter: ['Person']}} %>
  <% end %>

  ... More attributes ...
<% end %>
```

The filter definition like `data_scrivito_editors_filter_context={rich_snippet_filter: ['Person']}` can be used to show only the defined filters e.g. Person in this example.

In your contentbrowser filters, add the new types by using:

```js
scrivito.content_browser.filters(filter) {
  if(filter.rich_snippet_filter) {
    rich_snippet_filter(filter.rich_snippet_filter, ['NewType','AnotherType'])
  } else if (your filters) {
    // ... add your filters here
  } else {
    '_obj_class': {
      options: {
        // ... add your type defs here
        rich_snippets: {
          title: 'Rich Snippets',
          options: {
            rich_snippet_filter(undefined, ['NewType','AnotherType'])
          }
        }
      }
    }
  }
}
```
