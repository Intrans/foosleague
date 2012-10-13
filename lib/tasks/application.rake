desc 'Get the application up and running from scratch.  This task will erase any existing data you have.'
task :setup do
	['db:drop', 'db:create', 'db:migrate', 'db:seed'].each do |task|
		Rake::Task[task].invoke
	end
end
