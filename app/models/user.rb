class User < ApplicationRecord
  attr_accessor :avatar_url

  validates :full_name, presence: true, length: { maximum: 100 }
  has_one_attached :avatar_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, {
    "no_admin" => 0,
    "admin" => 1
  }

  after_create_commit -> { broadcast_counters }
  after_destroy_commit -> { broadcast_counters }
  after_commit :attach_avatar_from_url, on: [ :create ], if: -> { avatar_url.present? }

  def attach_avatar_from_url
    require "open-uri"
    file = URI.open(avatar_url)
    avatar_image.attach(io: file, filename: File.basename(URI.parse(avatar_url).path))
  end

  private

  def broadcast_counters
    broadcast_update_to "users", target: "user_counters", html: ApplicationController.render(partial: "admin/dashboards/counters")
  end
end
