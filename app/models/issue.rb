class Issue < ApplicationRecord
  belongs_to :issue_type
  belongs_to :component
  has_one :bill_of_material, :through => :issue_type
  has_many :item_types, :through => :bill_of_material
  has_many :bill_of_materials_item_types, :through => :bill_of_material

  scope :outstanding_issues, -> {where.not(:status => 'finished').where.not(:status => 'released').where.not(:status => 'cancelled')}
  scope :not_started_issues, -> {where(:status => 'not_started')}
  scope :issues_with_available_items, -> {joins(:bill_of_material).joins(:bill_of_materials_item_types).joins(:item_types).where('item_types.items_count >= bill_of_materials_item_types.item_type_count')}

  enum :status => [:not_started, :started, :finished, :released, :cancelled]
  enum :activity_type => []

  validates_presence_of :status
  validates_presence_of :priority
  validates_presence_of :component
  validates :priority, numericality: { greater_than_or_equal_to: 0 }

  before_validation do
    if self.status.nil?
      self.status = 'not_started'
    end
    if self.priority.nil? && !self.issue_type.nil?
      self.priority = self.issue_type.priority
    end
  end

  before_update do
    if self.status == 'started' && self.status_was == 'not_started'
      self.reserve_items
    end
    if self.status == 'finished' && (self.status_was == 'not_started' || self.status_was == 'started')
      self.reserve_items
    end
    true
  end

  after_create :order_new_items

  def find_next_available_issue
    Issue.not_started_issues.order('priority ASC, created_at ASC')
  end

  def reserve_items
    self.bill_of_materials_item_types.each do |bill|
      Item.available_items.where(:item_type => bill.item_type).limit(bill.item_type_count).update_all(:is_reserved => true)
    end
  end

  def remove_used_items
    self.bill_of_materials_item_types.each do |bill|
      Item.available_items.where(:item_type => bill.item_type).limit(bill.item_type_count).where(:is_reserved => false).destroy_all
    end
  end

  def order_new_items
    self.bill_of_materials_item_types.each do |bill|
      number_of_items_needed = bill.item_type_count - Item.available_items.where(:item_type => bill.item_type).count

      if number_of_items_needed > 0
        Order.create(:item_type => bill.item_type, :item_count => number_of_items_needed)
      end
    end
  end
end
