# File CRUD app

## Open Modes

### Basic access modes (Must specify one and only one)

- O_RDONLY (00): Open for reading only.
- O_WRONLY (01): Open for writing only.
- O_RDWR (02): Open for both reading and writing.

### File creation flags (optional)

- O_CREAT (0100): Create the file if it does not exist. Also add permissions as third argument in this case.
- O_EXCL (0200): Used with O_CREAT. If the file already exists, open() will fail.

### Other flags
- O_APPEND (0400): Append to the end of the file on each write.
- O_TRUNC (01000): If the file exists and is opened for rw, truncate it to zero length.
- O_NONBLOCK (04000): Open in non-blocking mode.
- O_SYNC (010000): Open for synchronous IO.
- O_DSYNC (04000000): O_SYNC for data not necessarily metadata.
- O_RSYNC (010000000): For synchronous read operations

## Permissions

- 0400 - Read for user
- 0200 - Write for user
- 0100 - Execute for user
- 0040 - Read for group
- 0020 - Write for group
- 0010 - Execute for group
- 0004 - Read for others
- 0002 - Write for others
- 0001 - Execute for others