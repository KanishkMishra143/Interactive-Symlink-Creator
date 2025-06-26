# Interactive Symlink Creator

A simple Bash script to safely create symlinks from a source directory to a destination directory, with interactive conflict resolution.

## Features

- Skips, overwrites, or renames existing conflicting files/folders interactively
- Supports empty directories gracefully
- Automatically creates the destination directory if it doesn’t exist

## Usage

```bash
./isc.sh /path/to/source /path/to/destination
```

## Example

```bash
./isc.sh ~/dotfiles ~/.config
```

This will attempt to symlink each item from `~/dotfiles` into `~/.config`.

If a conflict is detected (i.e., file/folder/link already exists at the destination), you will be prompted to:

1. **Skip** — leave the existing item untouched  
2. **Overwrite** — delete the existing item and create the symlink  
3. **Rename** — manually enter a new name for the symlink  

## Requirements

- Bash
- `ln`, `rm`, and standard Unix utilities

## Notes

- Symlinks are created with absolute paths.
- Existing symlinks or files are detected and handled interactively.

## License

MIT
