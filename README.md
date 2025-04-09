# Problem

- on Compute Canada clusters (e.g., Beluga), Julia is basically unusable because of precompilation times
- e.g. 2235 seconds for getting past `using Pigeons`!


# Cause

- after some investigations, it turns out the issue is the increasingly bloated number of files in Julia depot
    - huge number of files, 100k not uncommon
    - certain network file systems slow to a crawl when faced by that


# Solution

The script in `main.sh` implements a workaround. To use it:

- Remove any manually specified `$JULIA_DEPOT_PATH` (this script will generate one automatically instead)

- Add to you `.bashrc`: 

```
source /path/to/main.sh
```

- When you make a change to your julia depot, type `save_depot`, this will zip the depot

- If you have a second terminal open, use `load_depot` to force reloading the new depot. 