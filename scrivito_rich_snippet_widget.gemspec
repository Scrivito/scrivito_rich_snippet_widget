$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scrivito_rich_snippet_widget/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scrivito_rich_snippet_widget"
  s.version     = ScrivitoRichSnippetWidget::VERSION
  s.authors     = ["Gert Geidel"]
  s.email       = ["gert.geidel@infopark.de"]
  s.homepage    = "https://scrivito.com"
  s.description = "Add a rich snippet to your page"
  s.summary     = "Add a rich snippet to your page"
  s.license     = "LPGL-3"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'scrivito'
end
