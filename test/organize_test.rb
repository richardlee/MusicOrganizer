require "../src/organize.rb"
require "fileutils"
TEST_ROOT = "/home/richard/projects/music_organizer/test"

describe Organize do
	before :each do
		@dir_name = "music"
		FileUtils.mkdir @dir_name
	end

	after :each do
		FileUtils.cd TEST_ROOT
	 	FileUtils.rm_rf @dir_name
	end

	describe "standardize_song_names" do
		before :each do
			@song = File.basename(File.new("#{@dir_name}/ Some Artist - A Song .mp3", "w").path)
		end
		
		it "should remove leading and trailing whitespace" do
			Organize.new.standardize_song_names(@dir_name, [@song])
			FileUtils.cd @dir_name
			Dir.glob("*").should == ["Some Artist - A Song.mp3"]
		end

		it "should capitalize artist name" do
			Organize.new.standardize_song_names(@dir_name, [@song])
			FileUtils.cd @dir_name
			Dir.glob("*").should == ["Some Artist - A Song.mp3"]
		end

		it "should separate songs with non-standard file names" do
			pending
			Organize.new.standardize_song_names(@dir_name, [@song])
			Dir.glob("*").should include(Organize::MISC)
			FileUtils.cd Organize::MISC
			Dir.glob.should include @song
		end
	end
end
