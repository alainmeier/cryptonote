class StaticPagesController < ApplicationController
  def stats
    year = Message.where(created_at: 1.year.ago..Time.now)

    @stats = {
      created_alltime: Message.all.count,
      created_year: year.count,
      created_month: year.where(created_at: 1.month.ago..Time.now).count,
      created_week: year.where(created_at: 1.week.ago..Time.now).count,
      created_day: year.where(created_at: 1.day.ago..Time.now).count
    }
  end
end