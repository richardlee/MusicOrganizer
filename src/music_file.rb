class NonstandardFormatError < StandardError; end

class MusicFile

	attr_reader :artist, :song_title, :extension

	def initialize song
		@artist, @song_title, @extension = MusicFile.split_song_filename song
	end

	def self.split_song_filename song
		raise NonstandardFormatError if song.split('-').size != 2
		artist, song_with_extension = song.split('-')
		song_name = song_with_extension.split "."
		extension = song_name.delete song_name.last
		[artist.strip, song_name.join(" ").strip, extension]
	end
end
