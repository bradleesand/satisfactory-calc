module FriendlyToS
  def to_s
    "#{self.class.name} #{respond_to?(:name) ? "(#{name})" : id}"
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.prepend FriendlyToS
end
