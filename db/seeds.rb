require 'faker'
require "open-uri"

# 1. Clean the database 🗑️
# On ne supprime plus les objets précédents, mais via les validations de modèles on empêche la création de doublons

# 2. Create the users
puts "Creating users ..."
felix = User.new(
    last_name: "Orain",
    first_name: "Félix",
    email: "felix.orain@gmail.com",
    password: "password"
)
if felix.valid?
  felix.save!
  puts "Félix created"
else
  puts "Félix not valid and so not created"
  puts felix.errors.messages
end

marion = User.new(
    first_name: "Marion",
    last_name: "Vives",
    email: "mvives.dev@gmail.com",
    password: "password"
)
if marion.valid?
  marion.save!
  puts "Marion created"
else
  puts "Marion not valid and so not created"
  puts marion.errors.messages
end

leo = User.new(
    first_name: "Léo",
    last_name: "Tremoureux",
    email: "ltremoureux@hotmail.fr",
    password: "password"
)
if leo.valid?
  leo.save!
  puts "Leo created"
else
  puts "Leo not valid and so not created"
  puts leo.errors.messages
end

caro = User.new(
    first_name: "Caro",
    last_name: "Cerbelaud",
    email: "caroline.cerbelaud@gmail.com",
    password: "password"
)
if caro.valid?
  caro.save!
  puts "Caro created"
else
  puts "Caro not valid and so not created"
  puts caro.errors.messages
end

puts "#{User.count} created"


# 2. Create the mouettes

mouettes_photos = [
  'premium_photo-1667099522599-6948e8559a4f_fmgmp4',
  'photo-1518279021261-4e9d3f2a3b60_usefpm',
  'photo-1502093323795-961ea813a668_teld8u',
  'photo-1520950134832-a75b08dd69a1_m8vrwj',
  'premium_photo-1681843802490-f4bf1df28ec7_cgdivk',
  'photo-1528731813177-bb458664c07b_gj4xyo',
  'photo-1430203185215-baf937220bfe_bjy84t',
  'premium_photo-1667573535701-556b9e103614_k5iqcb',
  'photo-1513954936412-0e067c8e6fe4_fixpjy',
  'photo-1534157252003-b15edc3e7e57_hqi9pn',
  'photo-1518138793089-8eaa76c44db9_alxg4g',
  'photo-1500516028599-28d4ab63b0bb_wbxdle',
  'blue-bird.JPG_f4xj7m',
  'premium_photo-1666257591782-a1facd821223_ba0nsd',
  'photo-1452879182034-69b22068677d_mgoavl',
  'photo-1508132979403-8348a56c812a_e0epht',
  'photo-1511421894098-86890001dadf_qlyjpj',
  'premium_photo-1663036704399-dc263b6023d2_dwqahn',
  'photo-1509908346098-12b72a6841e5_yjwi7p',
  'photo-1474829296978-7f2b714a320e_szt9fg',
  'u3x7cekkS16ajjtJcb5L_DSC_5869.jpg_eb8sj8',
  'photo-1519929436393-fe843baf2cec_tg0zzw',
  'premium_photo-1667667846223-0213b13d89c3_seixzw',
  'photo-1694824391391-ce0cde53c48e_ji8fnb',
  'photo-1514839136425-131608e01922_pn53ge',
  'premium_photo-1723719604216-bc4897f32c4f_ju79yy',
  'photo-1506364736389-da3ab3150527_gpntnu',
  'photo-1483613058497-0eba5da75ffb_lfhlkm',
  'photo-1462995708817-6ed9c9552a91_yexgh8',
  'photo-1511761884586-e0a748e2a028_vvkxni',
  'qqvrq6airlahpjpqkxsk'
]

mouettes_array = [
    {
        name: "Mouette Agile",
        availability: "✅ Disponible",
        accessories: "casque",
        description: "Excellente mouette de combat, fourbe et agile",
        photo: "",
        address: "6 Rue de la Visitation, 35000 Rennes",
        category: "Combattante"
    },
    {
        name: "ShowMouette",
        availability: "❌ Pas disponible",
        accessories: "casque",
        description: "Invaincue en 20 ans, cette mouette sait faire le show",
        photo: "",
        address: "1 Place Saint-Michel, 35500 Vitré",
        category: "Combattante"
    },
    {
        name: "MikeBecson",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "La MikeTyson de la mouette, des combats haut en couleurs à prévoir",
        photo: "",
        address: "18 Quai Duguay-Trouin, 35400 Saint-Malo",
        category: "Combattante"
    },
    {
        name: "SucreCroc",
        availability: "✅ Disponible",
        accessories: "casque",
        description: "Les coups de griffe elle connaît : rangez gauffres et glaces, elle se battra pour sa dose de sucre",
        photo: "",
        address: "12 Rue de Dinan, 35120 Dol-de-Bretagne",
        category: "Combattante"
    },
    {
        name: "Pluminator",
        availability: "✅ Disponible",
        accessories: "casque",
        description: "Star de la MMA (Mouette Martial Art) depuis 1995. On se souvient de ses combats longtemps",
        photo: "",
        address: "3 Place de l’Église, 35800 Dinard",
        category: "Combattante"
    },
    {
        name: "Migramouette",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Migration du nord au sud, elle en a vu du pays ! ",
        photo: "",
        address: "1 Rue Saint-Mathieu, 29200 Brest",
        category: "Conteuse d'histoires"
    },
    {
        name: "BzhWing",
        availability: "❌ Pas disponible",
        accessories: "slip",
        description: "De Saint Malo à Brest, elle connaît les légendes bretonnes sur le bout des ails",
        photo: "",
        address: "4 Place de la Résistance, 29000 Quimper",
        category: "Conteuse d'histoires"
    },
    {
        name: "Cont’Ailes",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Idéale pour une journée à la plage, elle vous contera ses plus belles histoires",
        photo: "",
        address: "10 Quai de la Douane, 29600 Morlaix",
        category: "Conteuse d'histoires"
    },
    {
        name: "Gwelican",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Ses yeux perçants, encadrés d'un doux contour doré, racontent mille histoires du vent et de la mer.",
        photo: "",
        address: "7 Rue de l’Odet, 29900 Concarneau",
        category: "Conteuse d'histoires"
    },
    {
        name: "Carg’ailes",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Avec ses ailes robustes et son flair infaillible, elle défie vents et marées pour déposer vos colis avec une précision chirurgicale.",
        photo: "",
        address: "15 Rue de la Baie, 29770 Audierne",
        category: "Factrice"
    },
    {
        name: "StormExpress",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Capable de naviguer à travers les tempêtes, elle transporte lettres et paquets comme une pro des airs.",
        photo: "",
        address: "5 Rue Saint-Sauveur, 22100 Dinan",
        category: "Factrice"
    },
    {
        name: "BecPilote",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Son bec agile, son sac en bandoulière et son sens de l’orientation la rendent imbattable sur les circuits de livraison.",
        photo: "",
        address: "2 Place du Martray, 22220 Tréguier",
        category: "Factrice"
    },
    {
        name: "PointeTemps",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Toujours ponctuelle, elle respecte les délais avec un professionnalisme qui ferait pâlir les meilleurs services postaux.",
        photo: "",
        address: "9 Quai de la République, 22300 Lannion",
        category: "Factrice"
    },
    {
        name: "FlècheCourte",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Service abordable, mais attendez-vous à des fourches de livraison et non des fourchettes",
        photo: "",
        address: "8 Rue des Frères Courbet, 22400 Lamballe",
        category: "Factrice"
    },
    {
        name: "Jingle Mouette",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Avec leurs cris harmonisés sur des clochettes, ils amènent la magie de Noël",
        photo: "Groupe_GingleMouet_bfcevr",
        address: "10 Rue de la Plage, 22660 Trévou-Tréguignec",
        category: "Groupe de zikmouëts"
    },
    {
        name: "Moueticanos",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Ces volatiles, sombreros sur la tête, marient maracas et marées pour des concerts caliente",
        photo: "Groupe_Moueticanos_ogqpa5",
        address: "3 Place de la République, 56000 Vannes",
        category: "Groupe de zikmouëts"
    },
    {
        name: "Mouetmatah",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Inspirés par l’énergie brute du rock celtique, ces mouettes bretonnes déchaînent les foules avec leurs solos de bec et leurs refrains criards, dignes des tempêtes d’Armorique.",
        photo: "Groupe_Mouetmatah_mi5jgp",
        address: "4 Rue du Port, 56100 Lorient",
        category: "Groupe de zikmouëts"
    },
    {
        name: "Moumou&Co",
        availability: "❌ Pas disponible",
        accessories: "chaussures",
        description: "La formation chill et jazzy de l’année. Ces mouettes coolos, saxophones et lunettes de soleil inclus, transforment chaque coucher de soleil en jam session inoubliable",
        photo: "Groupe_Moumou_co_bxsmhz",
        address: "9 Place du Marché, 56370 Sarzeau",
        category: "Groupe de zikmouëts"
    },
    {
        name: "Nique Ta Mouette",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Issus du Rap Français engagé, Nique ta Mouette promets des textes forts et rythmés",
        photo: "Groupe_Niquetamouette_asort1",
        address: "6 Quai des Voiliers, 56400 Auray",
        category: "Groupe de zikmouëts"
    },
    {
        name: "Albatreizh",
        availability: "❌ Pas disponible",
        accessories: "casque",
        description: "12min58 au 100km, une vraie sprinteuse",
        photo: "",
        address: "12 Rue Saint-Michel, 56340 Carnac",
        category: "Sprinteuse"
    },
    {
        name: "Mouette express",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Plus rapide qu'Hussein Bolt, un vrai bolide",
        photo: "",
        address: "Pointe du Raz, 29770 Plogoff",
        category: "Sprinteuse"
    },
    {
        name: "Mouettemarcher",
        availability: "✅ Disponible",
        accessories: "casque",
        description: "Sur le circuit de Mouette 1 depuis 10 ans, elle a roulé sa bosse",
        photo: "",
        address: "Fort La Latte, 22240 Plévenon",
        category: "Sprinteuse"
    },
    {
        name: "Superson’ailes",
        availability: "✅ Disponible",
        accessories: "casque",
        description: "Elle vole plus vite que le concorde et pollue moins",
        photo: "",
        address: "Phare d’Eckmühl, 29760 Penmarc’h",
        category: "Sprinteuse"
    },
    {
        name: "SpeedWing",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Plus vite que la musique, elle gagne toutes ses courses. ",
        photo: "",
        address: "Château de Fougères, 35300 Fougères",
        category: "Sprinteuse"
    },
    {
        name: "Mouette à l'ouest",
        availability: "✅ Disponible",
        accessories: "slip",
        description: "Sait voler, mais a des difficultés d'orientation, à utiliser en circuit fermé",
        photo: "",
        address: "Port de Camaret, 29570 Camaret-sur-Mer",
        category: "Sprinteuse"
    },
    {
        name: "OldieBird",
        availability: "✅ Disponible",
        accessories: "noeud papillon",
        description: "Mouette qui a perdu de sa superbe mais qui reste agréable à regarder",
        photo: "",
        address: "2 Rue de l’Église, 35470 Bain-de-Bretagne",
        category: "Top Modèle"
    },
    {
        name: "FluffySky",
        availability: "✅ Disponible",
        accessories: "noeud papillon",
        description: "Très jolie mouette, plumage fourni",
        photo: "",
        address: "5 Place de la Mairie, 22810 Belle-Isle-en-Terre",
        category: "Top Modèle"
    },
    {
        name: "ArtMouette",
        availability: "❌ Pas disponible",
        accessories: "chaussures",
        description: "La perfection de son plumage, digne d'une toile de maître, fait d'elle une muse naturelle et incontestée.",
        photo: "",
        address: "46 allée des Tilleuls, 35220 Chateaubourg",
        category: "Top Modèle"
    },
    {
        name: "Margot",
        availability: "✅ Disponible",
        accessories: "noeud papillon",
        description: "Son port altier et sa démarche gracieuse captivent tous les regards, que ce soit sur la plage ou en plein vol.",
        photo: "",
        address: "6 rue Emile L'Hote, 35400 Saint-Malo",
        category: "Top Modèle"
    },
    {
        name: "Gwélican",
        availability: "❌ Pas disponible",
        accessories: "chaussures",
        description: "Avec ses plumes d'un blanc nacré et ses reflets argentés, il brille comme une étoile filante dans le ciel.",
        photo: "",
        address: "25 boulevard Marbeuf, 35000 Rennes",
        category: "Top Modèle"
    },
    {
        name: "Jérômouette",
        availability: "✅ Disponible",
        accessories: "chaussures",
        description: "Passionnée, elle a plus d'une histoire à vous raconter !",
        photo: "a_very_happy_seagull_with_a_blue_scarf_a_yellow_bike_helmet_and_octagonal_glasses_q0l9ph",
        address: "78 mail François Mitterrand, 35000 Rennes",
        category: "Conteuse d'histoires"
    }
]


mouettes_array.each_with_index do |mouette, index|
  new_mouette = Mouette.new(
    name: mouette[:name],
    availability: mouette[:availability],
    rating: rand(1..5),
    address: mouette[:address],
    category: mouette[:category],
    accessories: mouette[:accessories],
    description: mouette[:description],
    price: rand(20..100),
    owner: User.all.sample
  )
  if mouette[:photo].blank?
    cloudinary_url = "https://res.cloudinary.com/#{ENV["CLOUDINARY_CLOUD_NAME"]}/image/upload/#{mouettes_photos[index]}.jpg"
    file = URI.parse(cloudinary_url).open
    new_mouette.photo.attach(io: file, filename: "#{new_mouette.name}.png", content_type: "image/png")
  else
    cloudinary_url = "https://res.cloudinary.com/#{ENV["CLOUDINARY_CLOUD_NAME"]}/image/upload/#{mouette[:photo]}.jpg"
    file = URI.parse(cloudinary_url).open
    new_mouette.photo.attach(io: file, filename: "#{new_mouette.name}.png", content_type: "image/png")
  end

  if new_mouette.valid?
    new_mouette.save!
    puts "New mouette created #{new_mouette.name}"
  else
    puts "New mouette not created as already existing"
    puts new_mouette.errors.messages
  end

end


#4. Create bookings to owner "Marion" for demos

marion = User.find_by(last_name:"Vives")
felix = User.find_by(last_name:"Orain")
caro = User.find_by(last_name:"Cerbelaud")
leo = User.find_by(last_name:"Tremoureux")

renters = [felix, caro, leo]

Mouette.where(category:"Groupe de zikmouëts").each do |mouette|
  mouette.update(owner:marion)
  random_date = rand(1..60)
  start_date = Date.today + random_date.days
  random_duration = rand(1..30)

  new_booking_to_marion = Booking.new(start_date: start_date, end_date: start_date + random_duration.days, mouette:mouette, renter:renters.sample)

  if new_booking_to_marion.valid?
    new_booking_to_marion.save!
    puts "New booking created for #{mouette.name}"
  else
    puts "Can't create booking, already exists"
    puts new_booking_to_marion.errors.messages
  end

  puts "update #{mouette.name} with #{mouette.owner.last_name} owner"
end

# 3. Display a message 🎉
puts "Finished! You now have : #{Mouette.count} mouettes, #{User.count} users and #{Booking.count} bookings. Congratulations !"
