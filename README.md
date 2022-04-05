# cube
BorgBackup wrapper to facilitate assimilation

Assimilating the shoulders of giants: https://www.borgbackup.org/ https://github.com/borgbackup/borg 

## Install

```bash
mkdir -p ~/.local/bin 2>/dev/null
cd ~/.local/bin
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/hash.blake2 -o ~/.local/bin/.cube.b2
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/hash.sha256 -o ~/.local/bin/.cube.sha256
curl -sL https://raw.githubusercontent.com/alexxroche/cube/main/cube -o ~/.local/bin/cube
chmod 0555 ~/.local/bin/cube
chmod 0444 ~/.local/bin/{.cube.b2,.cube.sha256} 
which b2sum >/dev/null && b2sum -c ~/.local/bin/.cube.b2 && ~/.local/bin/cube \
|| { 
    sha256sum -c ~/.local/bin/.cube.sha256 && ~/.local/bin/cube || echo "[e] cube hashes failed. Do not use" 
}
```

### ABOUT

```txt
   cube is a wrapper to borgbackup for human users. [0]
 It is able to install borg and enough config to back itself up.

 The presumption is that you will have a NAS to which you want to backup,
  and that you will have cube, run by cron because "If a human has to be
  involved, then it is a snapshot and NOT a backup!"


 [0] and totally not a way to remove resistence, {~~is futile~~} to addoption.

 The config file dictates the actions of cube.
 It expects to have a list of file & directories to include
  and files & directories to exclude.
 e.g. FILTER_FILE="$HOME/.config/cube/filter.json"

# List the features and options:
cube -h

```

## configuration

When first run, `cube` will create two (2) example configuration files, ( by
default in $HOME/.config/cube/ )

edit `$HOME/.config/cube/config.ini`
and change 
```ini
BORG_PASSPHRASE="fUAtHVhCmMIVDQb57jYLwHIH0POFTD3vcDK08A5JvOF1l-oyi52qfYSLoiRBMS"
SALT="87CQbbvNliv8"
```

Get some nice fresh entropy in those two.

Change `BORG_REPO` to the location where you want borg to create the backup.

(Check all of the other defaults match your requirements.)

Lastly, edit `~/.config/cube/filter.json` to specify what to backup and,
importantly, what to ignore. (Caches, thumbnails, and libraries can be recreated.)

## cron

You can run cube from cron, (as you should).
```crontab
# run cube at 3:03 every morning
3 3 * * * ~/.local/bin/cube
```

### history
cube spawned into this quadrant in 2020-02-15T23:51:02Z
with the filters hard-coded. The current incarnation was created
to separate variables from the script so that a b2sum hash could be recorded,
(see hash.blake2) and permit updates to a local config while maintaining
the ability to detect corruption.

