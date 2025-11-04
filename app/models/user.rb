class User < ApplicationRecord
  validates :full_name, presence: true, length: { maximum: 100 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, {
    "no_admin" => 0,
    "admin" => 1
  }

  after_create_commit -> { broadcast_counters }
  after_destroy_commit -> { broadcast_counters }

  private

  def broadcast_counters
    broadcast_update_to "users", target: "user_counters", html: ApplicationController.render(partial: "admin/dashboards/counters")
  end
end
