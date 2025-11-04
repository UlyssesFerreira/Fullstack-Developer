users = [
  { full_name: "Alice Pereira", email: "alice@example.com", role: :no_admin, password: "123123" },
  { full_name: "Bruno Santos", email: "bruno@example.com", role: :no_admin, password: "123123" },
  { full_name: "Carla Lima", email: "carla@example.com", role: :no_admin, password: "123123" },
  { full_name: "Daniel Souza", email: "daniel@example.com", role: :admin, password: "123123" },
  { full_name: "Eduarda Rocha", email: "eduarda@example.com", role: :admin, password: "123123" }
]

users.each do |attrs|
  User.create!(attrs)
end
