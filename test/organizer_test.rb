require "/home/richard/projects/music_organizer/src/organizer.rb"
require "fileutils"
TEST_ROOT = "/home/richard/projects/music_organizer/test"

describe Organizer do
	before :each do
		@dir_name = "music"
		FileUtils.cd TEST_ROOT
		FileUtils.mkdir @dir_name
	end

	after :each do
		FileUtils.cd TEST_ROOT
	 	FileUtils.rm_rf @dir_name
	end

	describe "standardize_song_names" do
		it "should remove leading and trailing whitespace" do
			@song = File.basename(File.new("#{@dir_name}/ Some Artist - A Song .mp3", "w").path)
			Organizer.new.standardize_song_names(@dir_name)
			FileUtils.cd "#{@dir_name}/Some Artist"
			Dir.glob("*.mp3").should == ["Some Artist - A Song.mp3"]
		end

		it "should capitalize artist name and song title" do
			@song = File.basename(File.new("#{@dir_name}/ some artist - a soNg .mp3", "w").path)
			Organizer.new.standardize_song_names(@dir_name)
			FileUtils.cd "#{@dir_name}/Some Artist"
			Dir.glob("*.mp3").should == ["Some Artist - A Song.mp3"]
		end

		it "should separate songs with non-standard file names" do
			song = File.basename(File.new("#{@dir_name}/Some Artist - A - Song.mp3", "w").path)

			Organizer.new.standardize_song_names(@dir_name)
			FileUtils.cd @dir_name
			Dir.glob("*").should include(Organizer::MISC)
			FileUtils.cd Organizer::MISC
			Dir.glob("*").should include(song)
		end

		it "should delete duplicate songs" do
			pending
			song = File.basename(File.new("#{@dir_name}/Some Artist - A Song.mp3", "w").path)
			song2 = File.basename(File.new("#{@dir_name}/Some Artist - A Song(2).mp3", "w").path)
			Organizer.new.standardize_song_names(@dir_name)
			FileUtils.cd "#{@dir_name}/Some Artist"
			Dir.glob("*.mp3").should == ["Some Artist - A Song.mp3"]
		end
	end
end
