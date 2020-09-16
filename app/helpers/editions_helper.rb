module EditionsHelper
  def link_to_edition(work_id, edition)
    link_to(edition.description, work_edition_path(work_id, edition.id))
  end

  def link_to_title(work_id, edition)
    link_to(edition.title, work_edition_path(work_id, edition.id))
  end
end
