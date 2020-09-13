<h1 align="center">MP3split</h1>
<p align="center">A Shell script for splitting or slicing large mp3 audio files.</p>
<p align="center">
  <img src="https://diegosanchezp.github.io/blog/mp3split/mp3splitBanner.png">
</p>
The idea of this program is to take an mp3 file e.g a music 'mix' downloaded from youtube or another site and split it with a timestamps file found on youtube or another site, you might want to adjust it to the [format](#documentation).

## Table of Contents

1. [Required dependencies](#required-dependencies)
2. [Installation instructions](#installation-instructions)
3. [Documentation](#documentation)
4. [Usage example](#usage-example)
5. [Notes on errors](#notes-on-errors)
6. [Credits](#credits)

## Required dependencies <a name="required-dependencies"></a>
- FFmpeg

Install these dependencies with your package manager.

For example in Ubuntu and the rest of Debian based systems.

`sudo apt install ffmpeg`

## Installation instructions <a name="installation-instructions"></a>

1. Download the script  

```bash
wget https://raw.githubusercontent.com/diegosanchezp/mp3split/master/mp3split.sh -O ~/.local/bin/mp3split && chmod 755 ~/.local/bin/mp3split
```

This will put the shell script in the folder `~/.local/bin/` and can be accessed via terminal as a binary file.

Also the command above can be executed to update the script.

You must have the folder `~/.local/bin/` added to your `$PATH` variable, if you don't want to, install it to another folder.

## Documentation <a name="documentation"></a>
Usage:
	mp3split [OPTIONS] inputaudio tracklist
Options: 
	-s: do a simulation without writing anything to disk
  -h: print this help

The script will output all the splitted files in the current/working directory.   

The tracklist format is like those found on youtube comments of music videos.

```
'timestamp' 'Name of song'
```

Example

```
0:00 Xtract - Audiotool Day 2016
3:55 Alison space echo
```

Errors thrown in color red while processing each split are from ffmpeg.

## Usage example <a name="usage-example"></a>

Given the mp3 audio file [testsong.mp3](https://www.youtube.com/watch?v=WI4-HUn8dFc&list=PLayHeJP999S8bNQdUlOW87u5j3HxuE8in) and the tracklist `tracklist.txt` located in ~/test/ which is also the current/working directory.

tracklist.txt

```
0:00 Xtract - Audiotool Day 2016
3:55 Alison - space echo
7:25 Volt Age - Volt's Theme 
13:12 Lucy in Disguise - Southbound 
18:05 Lucy in Disguise - Echoes In Time
23:15 HOME - Flood
26:53 De Lorra/Augustus Wright - Let Us 
31:09 bl00dwave - Encounters
33:51 Emil Rottmayer - T.I.M.E ( Part 2 )
40:12 oDDling - Early Bird
43:22 hello meteor - at last light
```

Run the command 
```bash
mp3split testsong.mp3 tracklist.txt
```

It will output information about the created split files to `stdout`

```
=== Begin to create mp3 split files ===
Processed 0:00 to 3:55; Xtract - Audiotool Day 2016.mp3
Processed 3:55 to 7:25; Alison - space echo.mp3
Processed 7:25 to 13:12; Volt Age - Volt's Theme.mp3
Processed 13:12 to 18:05; Lucy in Disguise - Southbound.mp3
Processed 18:05 to 23:15; Lucy in Disguise - Echoes In Time.mp3
Processed 23:15 to 26:53; HOME - Flood.mp3
De Lorra/Augustus Wright - Let Us.mp3: No such file or directory
Processed 26:53 to 31:09; De Lorra/Augustus Wright - Let Us.mp3
Processed 31:09 to 33:51; bl00dwave - Encounters.mp3
Processed 33:51 to 40:12; Emil Rottmayer - T.I.M.E ( Part 2 ).mp3
Processed 40:12 to 43:22; oDDling - Early Bird.mp3
Processed 43:22 to 0:45:55.680000; hello meteor - at last light.mp3
```

And the splitted files 

```
3,1M	Alison - space echo.mp3
2,4M	bl00dwave - Encounters.mp3
5,8M	Emil Rottmayer - T.I.M.E ( Part 2 ).mp3
1,5M	hello meteor - at last light.mp3
3,4M	HOME - Flood.mp3
4,9M	Lucy in Disguise - Echoes In Time.mp3
5,2M	Lucy in Disguise - Southbound.mp3
3,1M	oDDling - Early Bird.mp3
5,3M	Volt Age - Volt's Theme.mp3
3,5M	Xtract - Audiotool Day 2016.mp3
```

## Notes on errors <a name="notes-on-errors"></a>
Be careful with the filenames with a slash '/' this might declare the filename as directory followed by a name as you can see in the example below there it was an error thrown by ffmpeg.

```
De Lorra/Augustus Wright - Let Us.mp3: No such file or directory
```

For this case the script wont stop it's execution and it will continue to process the other splits.

## Credits <a name="credits"></a>

I took as inspiration [Lukesmith booksplit script](https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/booksplit)
