class FlingMailer < ActionMailer::Base
  
  def fling_email(fling)  
    data = {:fling => fling} 
    recipients fling.target_email
    from "flingr@flingr.martyhaught.com"  
    subject "Achtung! #{fling.payload.name} is coming your way!"
    sent_on Time.now 
    body data
  end
end
