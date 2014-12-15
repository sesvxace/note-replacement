
Note Replacement v2.0 by Solistra
=============================================================================

Summary
-----------------------------------------------------------------------------
  This is a simple script that allows you to replace any text that you define
with another set of text in any note box. You may use strings, symbols, or
even regular expressions as tags, then define the text that replaces them
with a string or a block of Ruby code that returns a string (for the truly
insane). If you need to access the original state of the note box before
replacements are done, you can call the `original_note` method on the object.

  By default, this works with maps, actors, classes, skills, items, weapons,
armors, enemies, states, and tilesets -- basically, anything with notes.

Caveats
-----------------------------------------------------------------------------
  **NOTE:** This warning only applies to *dynamically* generated note tags --
simple replacements work exactly as intended as long as you follow the given
installation instructions. Your replacements are going to work absolutely
fine as long as you are not using a Proc object to generate them.

  Generally, script authors assume that note tag information will remain
static -- notes are defined in the database, and the database is where static
game information is stored. Unfortunately, this means that most scripts will
actually _cache_ note tag information instead of actually collecting the note
from the object when it is needed. As such, if the script is using a cache of
note tags, it will *never* be aware that the note has been replaced if you 
dynamically generate note tag contents.

  **This is not a failing of the note replacer.** It's an assumption that
note tag information will not change, and therefore has no need to be checked
after the initial loading of the game. There is nothing that this script can
do to change that.

License
-----------------------------------------------------------------------------
  This script is made available under the terms of the MIT Expat license.
View [this page](http://sesvxace.wordpress.com/license/) for more detailed
information.

Installation
-----------------------------------------------------------------------------
  Place this script below Materials, but above Main. Place this script below
the SES Core (v2.0 or higher) script if you are using it. For maximum
compatibility, place this script as high in your script list as possible.

