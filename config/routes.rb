Rails.application.routes.draw do
  match "*route" => "application#cors_preflight_check", :via => [:options], :constraints => { :method => "OPTIONS" }

  get 'items' => 'item_types#index'
  get 'orders' => 'orders#index'
  put 'orders/:id/order_arrived' => 'orders#order_arrived'
  get 'components' => 'components#index'
  get 'issues' => 'issues#index'
  post 'issues' => 'issues#create'
  get 'issue_types' => 'issue_types#index'
  put 'issues/:id/start' => 'issues#start_issue'
  post 'equipment/set_beacon' => 'equipment#set_beacon'
  post 'components/set_beacon' => 'components#set_beacon'
  post 'images/equipment/:equipment_id' => 'images#create_equipment_image'
  post 'images/component/:component_id' => 'images#create_component_image'
  post 'images/detect_component_type' => 'images#detect_component_type'
end
