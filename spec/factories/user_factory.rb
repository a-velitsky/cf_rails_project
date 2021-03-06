FactoryGirl.define do 

	sequence(:email) {|n|  "user#{n}@test.com"}
	factory :user do
		email
		password "123456789"
		first_name "Peter"
		last_name "Example"
		admin false
	end

	factory :admin_user, class: User do
		email
		password "123456789"
		first_name "Admin"
		last_name "Example"
		admin true
	end	
end