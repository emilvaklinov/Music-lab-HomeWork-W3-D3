

# require("pry")
require_relative("../Albums")
require_relative("../Artists")
#test delete_all
Albums.delete_all()
Artists.delete_all()

artist1 = Artists.new({'name' => 'Emil'})
artist2 = Artists.new({'name' => 'Digory'})
artist1.save()
artist2.save()
# # test update
# artist1.name = "Gemma"
# artist1.update()
# #test delete
# artist2.delete()
# #test all
# p Artists.all()
#
album1 = Albums.new({'artists_id' => artist1.id,'name' =>
  'Tropicana','genre' => 'jazz'})
album2 = Albums.new({'artists_id' => artist2.id,'name' =>
  'Popcorn','genre' => 'hip-hop'})

album1.save()
album2.save()
# test update
# album1.name = "Funky"
# album1.update()
# #test delete
# # album2.delete()
# #test all
p Albums.all()
