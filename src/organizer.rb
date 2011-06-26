require "/home/richard/projects/music_organizer/src/music_file.rb"
require 'fileutils'

class Organizer
	MISC = "misc"

	def standardize_song_names dir_name
		FileUtils.cd dir_name
		FileUtils.mkdir MISC unless File.directory? MISC
		songs = Dir.glob "*.mp3"
		songs.each do |song|
			begin
				file = MusicFile.new(song)
				FileUtils.mkdir file.formatted_artist unless File.directory? file.formatted_artist
				FileUtils.mv song, "#{file.formatted_artist}/#{file.formatted_filename}"
			rescue NonstandardFormatError
				FileUtils.mv song, "#{MISC}/#{song}"
			end
		end
		FileUtils.cd ".."
	end
end