authorization do
  role :admin do
	includes :guest
    has_permission_on [:users, :offers, :tools], :to => :all
    has_permission_on :authorization_rules, :to => :read
  end
  
  role :guest do
    has_permission_on [:offers, :tools], :to => :view
    
    has_permission_on [:users, :tools], :to => [:index, :show, :new, :create]

    has_permission_on :users, :to => [:change, :settings] do
      if_attribute :id => is { user.id }
    end

		has_permission_on :tools, :to => :change do
      if_attribute :user_id => is { user.id }
    end
  end

	role :pracodawca do
		includes :guest
		has_permission_on :offers, :to => [:create, :new]
		has_permission_on :offers, :to => [:create, :new, :edit, :update, :destroy, :delete] do
			if_attribute :user_id => is { user.id }
		end
	end
	
	role :pracownik do
		includes :guest
	end
end

privileges do
  privilege :change do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :moderate do
    includes :edit, :update, :delete, :destroy
  end
  
  privilege :view do
    includes :index, :show
  end
  
  privilege :act_as_god do
    includes :all
  end
  
  privilege :manage_all do
    includes :create, :new, :index, :show, :edit, :update, :delete, :destroy
  end
end