class User < ActiveRecord::Base
	xss_terminate
	has_permalink :dynamic_permalink, :update => true
	
	has_attached_file :logo, :styles => { :original => "500x200>", :thumb => "200x100>" },
			:url  => "/logos/:style/:id.:extension",
		  :path => ":rails_root/public/logos/:style/:id.:extension"
	#validates_attachment_size :logo, :less_than => 1.megabyte
  #validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
	
	has_attached_file :avatar, :styles => { :normal => "200x150#", :thumb => "200x100#" },
			:url  => "/avatars/:style/:id.:extension",
		  :path => ":rails_root/public/avatars/:style/:id.:extension"
  #validates_attachment_size :avatar, :less_than => 500.kilobytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

	acts_as_authentic do |c|
		login_field :email 
		validate_login_field false
		validate_email_field false
		validate_password_field false
	end
	
	has_many :tools, :dependent => :destroy, :order => "type_id DESC, name ASC"
	has_many :offers, :dependent => :destroy
	belongs_to :place
	
	validates_presence_of :email, :unless => :facebook?
	validates_format_of :email, :with => Authlogic::Regex.email, :unless => :facebook?
	validates_uniqueness_of :email, :unless => :facebook?
	validates_length_of :password, :within => 3..20, :if => :require_password_facebook?
	validates_confirmation_of :password, :if => :require_password_facebook?
	
	validates_uniqueness_of :company, :if => :firma?, :on => :update
	validates_presence_of :company, :if => :firma?, :on => :update
	
	validates_presence_of :place_id, :on => :update, :unless => :facebook?
	validates_presence_of :first_name, :last_name, :if => :osobaFizyczna?, :on => :update
	validates_length_of :first_name, :within => 0..255, :if => :osobaFizyczna?, :on => :update
	validates_length_of :last_name, :within => 0..255, :if => :osobaFizyczna?, :on => :update
	validates_length_of :github, :within => 0..255, :if => :pracownik?, :on => :update
	
  validates_acceptance_of :terms_of_service, :on => :create
  validates_acceptance_of :przetwarzanie_danych, :on => :create

	validates_inclusion_of :sex, :in => 0..1, :on => :update
	validates_inclusion_of :type_id, :in => 0..1
	validates_format_of :website, :with =>         /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :on => :update
	
	validates_format_of :phone, :with => /[0-9]{10}/, :on => :update, :unless => lambda { @phone.blank? }
	
  validates_inclusion_of :birthdate,
      :in => Date.new(1900)..18.years.ago.to_date,
      :message => 'musisz mieć ukończone 18 lat',
			:if => :pracownik_not_facebook?,
			:on => :update
  
  attr_accessor :terms_of_service, :facebook_session_key
	attr_protected :roles, :facebook_uid
	
	has_many :assignments, :dependent => :destroy
  has_many :roles, :through => :assignments
	
	after_create :create_roles
	
	def full_name
		if first_name.nil? || last_name.nil? || (firma? && company.nil?)
			return email.gsub('@','(at)')
		else
			firma? ? company : "#{first_name} #{last_name}"
		end
	end
	
	def dynamic_permalink
		if facebook?
			return full_name
		elsif pracownik?
			return full_name
		else
			return company
		end
	end
	
	def before_connect(s)
		self.first_name = s.user.first_name
		self.last_name = s.user.last_name
		self.birthdate = s.user.birthday_date
		self.sex = s.user.sex
		self.website = s.user.website
		self.place = Place.find_by_name(s.user.current_location)
	end
	
	def require_password_facebook?
		if facebook?
			false
		else
			self.send(:require_password?)
		end
	end
	
	def facebook?
		!facebook_uid.nil?
	end
	
	def pracownik_not_facebook?
		pracownik? && !facebook?
	end
	
	def pracownik_on_facebook?
		pracownik? && facebook?
	end
	
	def firma?
		pracodawca? && !self.osoba_prywatna
	end
	
	def osobaFizyczna?
		(pracodawca? || (pracownik? && !facebook?)) && self.osoba_prywatna
	end
	
	def pracownik?
		(type_id == 0)
	end
	
	def pracodawca?
		(type_id == 1)
	end
	
	def role_symbols
    roles.map { |role| role.name.underscore.to_sym }
  end
  
  def assign_role(role_name)
    role = Role.find_or_create_by_name(role_name)
    assignments.find_or_create_by_role_id(role.id)
  end
	
	def github?
		!self.github.nil? && self.github.length > 0
	end
	
	def github_user
		@github_user ||= GitHub::API.user(self.github)
		return @github_user
	end
	
	def repositories
		return [] unless github?
		self.github_user.repositories.reverse rescue []
	end
	
	def create_roles
		if pracownik?
			assign_role('Pracownik')
		else
			assign_role('Pracodawca')
		end
	end

end
