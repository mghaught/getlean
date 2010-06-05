ab_test "Upgrades to Pro account" do
  description "How does pro pricing points increase pro upgrades"
  alternatives 2, 5, 10
  
  metrics :pro
end