# require 'input_functions'
module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
  attr_accessor :title, :artist, :genre, :tracks
    
  def initialize (title, artist, genre)
    # insert lines here
    @title = title
    @artist = artist
    @genre = $genre_names[genre.to_i]
    # @genre = genre  
  end
end

class Track
  attr_accessor :name, :location

  def initialize (name, location)
    @name = name.chomp
    @location = location.chomp
  end
end

def read_track music_file 
  track_name = music_file.gets
  track_location = music_file.gets
  track = Track.new(track_name, track_location)
end

def read_tracks music_file 
  tracks = Array.new
  count = music_file.gets.to_i
  index = 0
  while index < count
    tracks << read_track(music_file)
    index += 1
  end
  tracks
end

def print_tracks tracks 
  index = 0
  while (index < tracks.length)
    print_track(tracks[index])
    index = index + 1
  end
  tracks
end

def read_album music_file
  album_artist = music_file.gets
  album_title = music_file.gets
  album_genre = music_file.gets
  album = Album.new(album_title, album_artist, album_genre)
  album
end


def print_album album
  puts 'Album title is ' + album.title.to_s
  puts 'Album artist is ' + album.artist.to_s
  # puts 'Genre is ' + album.genre.to_s
  puts 'Album artist is ' + $genre_names[album.genre.to_i]
  
  # print out the tracks
  print_tracks(album.tracks).to_s
end

def print_track track
  puts('Track title is: ' + track.name)
  puts('Track file location is: ' + track.location)
end

#******* HERE IS WHERE MY PROBLEM IS******

# search for track by name.
# Returns the index of the track or -1 if not found

# Put a while loop here that searches through the tracks
# Use the read_string() function from input_functions.
# NB: you might need to use .chomp to compare the strings correctly
def search_for_track_name(tracks, search_string)
  # search_string = gets.chomp 
  index = 0
  while (index < tracks.length)
    if (tracks[index].name == search_string)
      return index
    end
   	index += 1 
  end 
  return -1
end 


# Reads in an Album from a file and then prints all the album
# to the terminal

def main
  music_file = File.open("album.txt", 'r')
  if music_file
    album = read_album(music_file)
    album.tracks = read_tracks(music_file)
    music_file.close()
  end
  puts "Enter the track name you wish to find: "
  search_string = gets.chomp
  index = search_for_track_name(album.tracks, search_string)
  if index > -1
    puts "Found " + album.tracks[index].name + " at " + index.to_s
    # print_album(album)
  else
    puts "Entry not Found"
  end
end
main