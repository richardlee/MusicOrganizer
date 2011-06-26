require "/home/richard/projects/music_organizer/src/music_file.rb"
class Organizer
	MISC = "misc"

	def standardize_song_names dir_name
		FileUtils.cd dir_name
		FileUtils.mkdir MISC
		songs = Dir.glob "*.mp3"
		songs.collect do |song|
			begin
				file = MusicFile.new(song)
				FileUtils.mv song, file.formatted_filename
			rescue NonstandardFormatError
				FileUtils.mv song, "#{MISC}/#{song}"
			end
		end
		FileUtils.cd ".."
	end
end