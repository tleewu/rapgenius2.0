class Track < ActiveRecord::Base
  VERSIONS = ["bonus", "regular"]

  validates :name, :album_id, presence: true
  validates :version, inclusion: { in: VERSIONS}

  belongs_to :album,
    class_name: 'Album',
    foreign_key: :album_id,
    primary_key: :id

  has_many :comments,
    class_name: 'Note',
    foreign_key: :track_id,
    primary_key: :id
end
