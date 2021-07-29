# PaperMC
A cli tool written in bash meant to be used to download papermc files.

## Usage:
```bash

# PaperMC lets you query for versions
./papermc.bash listVersions

# Query for Build numbers
./papermc.bash listBuilds 1.17.1

# Or download a paperclip jar:
./papermc.bash get 1.17.1 latest # Saves the latest build for 1.17.1 into paperclip.jar
./papermc.bash get latest latest # Saves the latest build for the latest minecraft into paperclip.jar
./papermc.bash get 1.17.1 137 > customfile.jar # Saves build 137 for minecraft 1.17.1 into customfile.jar
```

The tool automatically decides whether to save the jar to a file or print it to stdout depending on if its piped. (`if [ -t 1 ];`)

This allows you to automatically download the latest version of papermc like in the v1 of the api, but with the new v2 api.
