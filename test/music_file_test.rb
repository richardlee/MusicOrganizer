require "/home/richard/projects/music_organizer/src/music_file.rb"
require "fileutils"
TEST_ROOT = "/home/richard/projects/music_organizer/test"

describe MusicFile do
	before :each do
		@dir_name = "music"
		FileUtils.cd TEST_ROOT
		FileUtils.mkdir @dir_name
	end

	after :each do
		FileUtils.cd TEST_ROOT
	 	FileUtils.rm_rf @dir_name
	end

	describe "split_song_filename" do
		it "should return artist and song and extension" do
			song = File.basename(File.new("#{@dir_name}/ Some Artist - A Song .mp3", "w").path)
			MusicFile.split_song_filename(song).should == ["Some Artist", "A Song", "mp3"]
		end

		it "should raise an exception when there are multiple dashes in the filename" do
			song = File.basename(File.new("#{@dir_name}/ Some Artist - A - Song .mp3", "w").path)
			lambda{MusicFile.split_song_filename(song)}.should raise_error(NonstandardFormatError)
		end

		it "should take whatever is past the last period to be the extension" do
			song = File.basename(File.new("#{@dir_name}/ Some Artist - A Song.with.periods .mp3", "w").path)
			MusicFile.split_song_filename(song).should == ["Some Artist", "A Song with periods", "mp3"]
		end
	end

	describe "formatted_filename" do
		it "should return 'Artist - SongTitle.Extension'" do
			song = MusicFile.new(File.basename(File.new("#{@dir_name}/Some Artist - A Song.mp3", "w").path))
			song.formatted_filename.should == "Some Artist - A Song.mp3"
		end
	end

	describe "formatted_artist" do
		it "should capitalize each word in the artist name" do
			song = MusicFile.new(File.basename(File.new("#{@dir_name}/ some artist - A Song .mp3", "w").path))
			song.formatted_artist.should == "Some Artist"
		end
	end

	describe "formatted_song_title" do
		it "should capitalize each word in the artist name" do
			song = MusicFile.new(File.basename(File.new("#{@dir_name}/ some artist - a song .mp3", "w").path))
			song.formatted_song_title.should == "A Song"
		end
	end
end