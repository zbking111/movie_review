class Movie < ApplicationRecord
  has_many :reviews, foreign_key: "movie_id"
  has_many :reviewed_users, through: :reviews, source: :user
  has_many :rates, foreign_key: "movie_id"
  has_many :rated_users, through: :rates, source: :user
  has_many :movie_characters, foreign_key: "movie_id", dependent: :destroy
  has_and_belongs_to_many :actors, join_table: 'movie_characters'
  has_many :characters, through: :movie_characters, source: :actor
  accepts_nested_attributes_for :characters

  validates :name, presence: true, length: {maximum: 100}
  validates :picture, presence: true
  validates :info, presence: true, length: {maximum: 1000}
  validates :date, presence: true
  mount_uploader :picture, PictureUploader

  scope :order_desc, ->{order created_at: :desc}
  scope :rate_score_desc, ->{order rate_score: :desc}
  scope :date_7_days_ago, -> {where date: 7.days.ago..Time.current}
  scope :date_30_days_later, -> {where date: 1.day.from_now..30.days.from_now}
  scope :date_desc, -> {order date: :desc}
  scope :date_asc, -> {order date: :asc}
end
