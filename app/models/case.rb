class Case < ActiveRecord::Base

  before_save :only_one_featured

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates :title, presence: true
  validates_length_of :title, :minimum => 0, :maximum => 100, :allow_blank => true
  validates :description, presence: true
  # validates :eleapsed_time, presence: true
  validates :waist_before, numericality: true, allow_blank:true
  validates :waist_after, numericality: true, allow_blank:true
  validates :weight_before, numericality: true, allow_blank:true
  validates :weight_after, numericality: true, allow_blank:true
  # validates :product_used, presence: true


  private
    def only_one_featured
      if self.featured
        Case.update_all(featured: false)
        self.featured = true
      end
    end

end