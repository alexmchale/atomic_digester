ActiveRecord::Base.send(:include, Protector)
ActiveRecord::Base.send(:include, Protector::ActiveRecord::Adapters::StrongParameters)
