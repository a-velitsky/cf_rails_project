FactoryGirl.define do 
	sequence(:email) {|n|  "user#{n}@test.com"}
	factory :user do
		email
		password "123456789"
		first_name "Peter"
		last_name "Example"
		admin false

		factory :admin_user do
			admin true
		end
	end	
end