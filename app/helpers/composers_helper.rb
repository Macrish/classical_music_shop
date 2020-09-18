module ComposersHelper
  def link_to_composer(composer)
    link_to(composer.whole_name, composer_path(composer.id))
  end
end
