class Mouette < ApplicationRecord
  include PgSearch::Model


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :owner, class_name: "User"
  has_many :bookings
  has_one_attached :photo

  # pg_search_scope :search_by_name_and_category,
  #   against: [ :name, :category ],
  #   using: {
  #     tsearch: { prefix: true }
  #   }

  pg_search_scope :search,
  against: [ :name, :category, :description, :accessories ],
  using: {
    tsearch: {
      highlight: {
        prefix: true,
        StartSel: '<b>',
        StopSel: '</b>',
        MaxWords: 123,
        MinWords: 456,
        ShortWord: 4,
        HighlightAll: true,
        MaxFragments: 3,
        FragmentDelimiter: '&hellip;'
      }
    }
  }

  ACCESSORIES = ["casque", "slip", "chaussures", "noeud papillon"]
  AVAILABILITY = ["✅ Disponible", "❌ Pas disponible"]
  CATEGORIES = ["Combattante", "Sprinteuse", "Factrice", "Groupe de zikmouëts", "Top Modèle", "Conteuse d'histoires"]

  validates :name, :availability, :price, :photo, :description, :category, presence: true
  # validates :name, :uniqueness: true { message: "Name already taken" }

  validates :availability, inclusion: {
      in: AVAILABILITY,
      message: "Doit choisir : #{AVAILABILITY}"
  }

  validates :accessories, inclusion: {
      in: ACCESSORIES,
      message: "Doit choisir : #{ACCESSORIES}"
  }

  validates :category, inclusion: {
    in: CATEGORIES,
    message: "Doit choisir : #{CATEGORIES}"
  }

  validates :price, numericality: { greater_than: 0, message: "doit être un nombre supérieur à 0" }

  validates :description, length: { minimum: 10 }
  # validates :rating, presence: true, numericality: { greater_than_or_equal_to: 0,less_than_or_equal_to: 5 }

  # Eviter qu'un owner créé deux fois de suite la même mouette (ou la seed)
  validates_uniqueness_of :name, scope: %i[photo description owner category price availability]
  # Eviter qu'un faussaire de mouettes fasse des copies de mouettes illégales
  validates_uniqueness_of :name, scope: %i[photo description]
  after_create :send_new_mouette_email

  private

  def send_new_mouette_email
    MailAdapter::Brevo.new.send_new_mouette_email_now
  end
end
