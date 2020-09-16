module WorksHelper
  def link_to_work(work)
    link_to(work.nice_title, work_path(work.id))
  end
end
