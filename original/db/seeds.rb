goo = Payload.create(:name => "Goo", :image_url => "goo.png")
poo = Payload.create(:name => "Poo", :image_url => "poo.png")
foo = Payload.create(:name => "Foo", :image_url => "foo.png")
flair = Payload.create(:name => "Flair", :image_url => "flair.png")
cb = Payload.create(:name => "Carebear", :image_url => "carebear.png")
hug = Payload.create(:name => "Hug", :image_url => "hug.png")
coconut = Payload.create(:name => "Coconut", :image_url => "coconut.png")


# Simulate System usage
pwd = "open4me"
base_data = {:password => pwd, :password_confirmation => pwd}
veteran_data = base_data.merge({:sign_in_count => 8, :current_sign_in_at => 8.days.ago, :last_sign_in_at => 10.days.ago, :created_at => 1.month.ago})
active_data = base_data.merge({:sign_in_count => 4, :current_sign_in_at => 2.days.ago, :last_sign_in_at => 4.days.ago, :created_at => 1.week.ago})
starts_data = base_data.merge({:sign_in_count => 2, :current_sign_in_at => 2.hours.ago, :last_sign_in_at => 2.days.ago, :created_at => 2.days.ago})

hotdog = User.create(veteran_data.merge(:name => "Hot Dog", :email => "hotdog@flingr.com", :pro => true))
falco = User.create(veteran_data.merge(:name => "Falco", :email => "falco@flingr.com"))
batman = User.create(veteran_data.merge(:name => "Batman", :email => "batman@flingr.com"))
mman = User.create(veteran_data.merge(:name => "Muffin Man", :email => "muffinman@flingr.com"))

boba = User.create(active_data.merge(:name => "Boba Fett", :email => "bobafett@flingr.com"))
imaiden = User.create(active_data.merge(:name => "iMaiden", :email => "imaiden@flingr.com"))
dude = User.create(active_data.merge(:name => "The Dude", :email => "dude@flingr.com", :pro => true))
ba = User.create(active_data.merge(:name => "Bad Ass", :email => "ba@flingr.com"))

pup = User.create(starts_data.merge(:name => "Just A Pup", :email => "pup@flingr.com", :pro => true))
noob = User.create(starts_data.merge(:name => "n00b", :email => "noob@flingr.com"))


hotdog.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Gary", :created_at => 18.days.ago)
hotdog.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Bart", :created_at => 15.days.ago)
hotdog.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Roger", :created_at => 11.days.ago)
hotdog.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Bobby", :created_at => 7.days.ago)
hotdog.flings.create(:payload => hug, :target_email => "t@t.com", :target_name => "Beth", :created_at => 3.days.ago)

falco.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Rick", :created_at => 17.days.ago)
falco.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Mike", :created_at => 14.days.ago)
falco.flings.create(:payload => hug, :target_email => "t@t.com", :target_name => "Chris", :created_at => 9.days.ago)
falco.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Jen", :created_at => 5.days.ago)
falco.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Yolanda", :created_at => 2.days.ago)
falco.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Earl", :created_at => 10.days.ago)
falco.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Fail", :created_at => 3.days.ago)

batman.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Barnes", :created_at => 13.days.ago)
batman.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Ben", :created_at => 15.days.ago)
batman.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Roger", :created_at => 14.days.ago)
batman.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Telly", :created_at => 14.days.ago)
batman.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Snookums", :created_at => 14.days.ago)

mman.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Olvie", :created_at => 19.days.ago)
mman.flings.create(:payload => hug, :target_email => "t@t.com", :target_name => "Bart", :created_at => 16.days.ago)
mman.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Babble", :created_at => 10.days.ago)
mman.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Islan", :created_at => 10.days.ago)
mman.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Cindy", :created_at => 10.days.ago)

boba.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Ulrich", :created_at => 7.days.ago)
boba.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Bart", :created_at => 6.days.ago)
boba.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Johnny", :created_at => 6.days.ago)
boba.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Jack", :created_at => 3.days.ago)
boba.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Terrence", :created_at => 3.days.ago)
boba.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Henry", :created_at => 1.days.ago)

imaiden.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Die", :created_at => 7.days.ago)
imaiden.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Ike", :created_at => 6.days.ago)
imaiden.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Laura", :created_at => 5.days.ago)
imaiden.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Null", :created_at => 1.days.ago)

dude.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Ulrich", :created_at => 7.days.ago)
dude.flings.create(:payload => hug, :target_email => "t@t.com", :target_name => "Bart", :created_at => 6.days.ago)
dude.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Gahr", :created_at => 4.days.ago)
dude.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Paul", :created_at => 3.days.ago)

ba.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Jeremy", :created_at => 7.days.ago)
ba.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Chris", :created_at => 3.days.ago)
ba.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Edith", :created_at => 2.days.ago)
ba.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Karen", :created_at => 1.days.ago)


pup.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Oli", :created_at => 7.days.ago)
pup.flings.create(:payload => foo, :target_email => "t@t.com", :target_name => "Mitch", :created_at => 3.days.ago)
pup.flings.create(:payload => poo, :target_email => "t@t.com", :target_name => "Stacie", :created_at => 2.days.ago)
pup.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Scott", :created_at => 1.days.ago)

noob.flings.create(:payload => coconut, :target_email => "t@t.com", :target_name => "Nelson", :created_at => 7.days.ago)
noob.flings.create(:payload => flair, :target_email => "t@t.com", :target_name => "Carrie", :created_at => 3.days.ago)
noob.flings.create(:payload => cb, :target_email => "t@t.com", :target_name => "Eric", :created_at => 2.days.ago)
noob.flings.create(:payload => goo, :target_email => "t@t.com", :target_name => "Corey", :created_at => 1.days.ago)



