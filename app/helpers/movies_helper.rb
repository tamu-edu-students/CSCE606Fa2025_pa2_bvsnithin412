module MoviesHelper
	# Generates a sortable column header link with direction arrow
	def sort_link(column, title)
		current_dir = (params[:sort] == column && params[:direction] == 'asc') ? 'desc' : 'asc'
		arrow = if params[:sort] == column
			params[:direction] == 'asc' ? ' ▲' : ' ▼'
		else
			''
		end
		link_to "#{title}#{arrow}".html_safe, movies_path(sort: column, direction: current_dir)
	end
end
