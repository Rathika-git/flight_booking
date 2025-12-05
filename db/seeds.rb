Airport.create([ { code: "SFO" }, { code: "NYC" } ])

Flight.create(
  departure_airport_id: Airport.first.id,
  arrival_airport_id: Airport.last.id,
  start_datetime: Time.now + 1.day,
  flight_duration: 120
)
