#--
# Note Replacement v2.0 by Solistra
# =============================================================================
# 
# Summary
# -----------------------------------------------------------------------------
#   This is a simple script that allows you to replace any text that you define
# with another set of text in any note box. You may use strings, symbols, or
# even regular expressions as tags, then define the text that replaces them
# with a string or a block of Ruby code that returns a string (for the truly
# insane). If you need to access the original state of the note box before
# replacements are done, you can call the `original_note` method on the object.
# 
#   By default, this works with maps, actors, classes, skills, items, weapons,
# armors, enemies, states, and tilesets -- basically, anything with notes.
# 
# Caveats
# -----------------------------------------------------------------------------
#   **NOTE:** This warning only applies to *dynamically* generated note tags --
# simple replacements work exactly as intended as long as you follow the given
# installation instructions. Your replacements are going to work absolutely
# fine as long as you are not using a Proc object to generate them.
# 
#   Generally, script authors assume that note tag information will remain
# static -- notes are defined in the database, and the database is where static
# game information is stored. Unfortunately, this means that most scripts will
# actually _cache_ note tag information instead of actually collecting the note
# from the object when it is needed. As such, if the script is using a cache of
# note tags, it will *never* be aware that the note has been replaced if you 
# dynamically generate note tag contents.
# 
#   **This is not a failing of the note replacer.** It's an assumption that
# note tag information will not change, and therefore has no need to be checked
# after the initial loading of the game. There is nothing that this script can
# do to change that.
# 
# License
# -----------------------------------------------------------------------------
#   This script is made available under the terms of the MIT Expat license.
# View [this page](http://sesvxace.wordpress.com/license/) for more detailed
# information.
# 
# Installation
# -----------------------------------------------------------------------------
#   Place this script below Materials, but above Main. Place this script below
# the SES Core (v2.0 or higher) script if you are using it. For maximum
# compatibility, place this script as high in your script list as possible.
# 
#++

# SES
# =============================================================================
# The top-level namespace for all SES scripts.
module SES
  # NoteReplacer
  # ===========================================================================
  # Provides the {SES::NoteReplacer.replace} method for performing note
  # substitutions.
  module NoteReplacer
    # =========================================================================
    # BEGIN CONFIGURATION
    # =========================================================================
    
    # Define the tags you want to use and their replacements here.
    TAGS = {
      "<example>" => "replacement text",
    }
    
    # =========================================================================
    # END CONFIGURATION
    # =========================================================================
    
    # Performs substitutions.
    # 
    # @note The `@note` instance variable is defined here so that tags can
    #   access the content of the note box.
    # 
    # @param note [String] the note contents to perform substitutions on
    # @return [String] the note with applied replacements
    def self.replace(note)
      @note = note
      TAGS.each { |t, r| note.gsub!(t) { r.respond_to?(:call) ? r.call : r } }
      note
    end
    
    # Register this script with the SES Core if it exists.
    if SES.const_defined?(:Register)
      # Script metadata.
      Description = Script.new('Note Replacement', 2.0, :Solistra)
      Register.enter(Description)
    end
  end
end
# RPG
# =============================================================================
# Provides the basic data structures used by the RPG Maker VX Ace editor.
module RPG
  # Add the `note` and `original_note` methods to all of the data structures
  # which make use of note boxes.
  [Map, BaseItem, Tileset].each do |base_class|
    base_class.send(:define_method, :note) do
      SES::NoteReplacer.replace(@note.clone) unless @note.nil?
    end
    base_class.send(:define_method, :original_note) { @note }
  end
end
