def require_seed_helper(key)
  require File.join(File.dirname(__FILE__), 'seed_helpers', key.to_s + '.rb')
end

module Seed
  require_seed_helper :equipment_types
  require_seed_helper :component_types
  require_seed_helper :equipment
  require_seed_helper :components
  require_seed_helper :item_types
  require_seed_helper :bill_of_materials
  require_seed_helper :issue_types
  require_seed_helper :issues
  require_seed_helper :orders
end
