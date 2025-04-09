# Problem

- on Compute Canada clusters (e.g., Beluga), Julia is basically unusable because of precompilation times
- e.g. 2235 seconds for getting past `using Pigeons`!


# Cause

- after some investigations, it turns out the issue is the increasingly bloated number of files in Julia depot
    - huge number of files, 100k not uncommon
    - certain network file systems slow to a crawl when faced by that


# Solution

The scripts in `bin` implements a workaround. To use it:

- Remove from .bashrc and your session any manually specified `$JULIA_DEPOT_PATH` (this script will generate one automatically instead)

- Add to you `.bashrc`: 

```
export PATH="$PATH:/path/to/zip_depot/bin"
load_depot
```

- Behind the scene, when you log in, `load_depot` will use an archived zip 
    depot (in `~/.depot.zip`), copy that single file to a temporary local storage, unzip there, and use the temporary location as the depot for this session. 

- When you make a change to your julia depot, type `save_depot`, this will zip the current $JULIA_DEPOT_PATH into 
    `~/.depot.zip` overriding previous changes. 

    - If you have a separate terminal open, use `load_depot` to force reloading the new depot after updating it. 