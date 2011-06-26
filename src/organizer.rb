class Organizer
	MISC = "misc"

	def standardize_song_names dir_name, songs
		FileUtils.cd dir_name
		songs.collect do |song|
			artist, song_name = song.split('-')
			artist = artist.split.map(&:capitalize).join(" ")
			song_name, extension = (song_name.split ".")
			FileUtils.mv song, "#{artist.strip} - #{song_name.strip}.#{extension}"
		end
		FileUtils.cd ".."
	end

	def split_artist_and_song song
	end
end