class Flight < ApplicationRecord
  belongs_to :departure_airport, class_name: "Airport"
  belongs_to :arrival_airport, class_name: "Airport"
  has_many :bookings
  has_many :passengers, through: :bookings
  validates :start_datetime, presence: true
  validates :flight_duration, presence: true
  
#   def self.search(departure_code, arrival_code, date, num_tickets)
#     return none if departure_code.blank? || arrival_code.blank? || date.blank?
    
#     departure_airport = Airport.find_by(code: departure_code)
#     arrival_airport = Airport.find_by(code: arrival_code)
    
#     return none unless departure_airport && arrival_airport
    
#     where(departure_airport: departure_airport, arrival_airport: arrival_airport)
#       .where("DATE(start_datetime) = ?", date)
#   end
end


