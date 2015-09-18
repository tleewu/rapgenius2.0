class Album < ActiveRecord::Base
  STYLES = ["live", "studio"]

  validates :name, :band_id, presence: true
  validates :style, inclusion: { in: STYLES}

  has_many :tracks,
    dependent: :destroy,
    class_name: 'Track',
    foreign_key: :album_id,
    primary_key: :id

  belongs_to :band,
    class_name: 'Band',
    foreign_key: :band_id,
    primary_key: :id 

end
