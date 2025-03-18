class BookingsDailyCleaningJob < ApplicationJob
  queue_as :default

  def perform
    # bookings en pending (ni acceptés ni refusés)
    pending_bookings = Booking.where(status:"pending")
    Rails.logger.info("Pending bookings: #{pending_bookings.count}")
    pending_bookings.each do |booking|
      # si la date de début est passée -> rejected
      if booking.start_date < Date.today
        booking.update(status:"rejected")
        Rails.logger.info("Booking being rejected: #{booking.id}")
      # si la date de fin est passée -> abandoned
      elsif booking.end_date < Date.today
        booking.update(status:"abandoned")
        Rails.logger.info("Booking being abandoned: #{booking.id}")
      end
    end

    # bookings accepted
    accepted_bookings = Booking.where(status:"accepted")
    Rails.logger.info("Accepted bookings: #{accepted_bookings.count}")
    accepted_bookings.each do |booking|
      # si la date de fin est passée -> ended
      if booking.end_date < Date.today
        booking.update(status:"ended")
        Rails.logger.info("Booking being ended: #{booking.id}")
      end
    end

    # bookings rejected
    rejected_bookings = Booking.where(status:"rejected")
    Rails.logger.info("Rejected bookings: #{rejected_bookings.count}")
    rejected_bookings.each do |booking|
      # si la date de fin est passée -> abandoned	if booking.end_date < Date.today
      if booking.end_date < Date.today
        booking.update(status:"ended")
        Rails.logger.info("Booking being ended: #{booking.id}")
      end
    end
  end
end
