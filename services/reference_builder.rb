# Links user models with companies

module ReferenceBuilder
  def self.build_references(users, company_by_id)
    users.each do |user|
      user.company = company_by_id[user.company_id]
      user.company.add_user(user)
    end
  end
end
