- 公式ドキュメント (めっちゃ詳しいのあるやんけ)
https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities

# default list 
  Capability Key	Capability Description
  AUDIT_WRITE	Write records to kernel auditing log.
  CHOWN	Make arbitrary changes to file UIDs and GIDs (see chown(2)).
  DAC_OVERRIDE	Bypass file read, write, and execute permission checks.
  FOWNER	Bypass permission checks on operations that normally require the file system UID of the process to match the UID of the file.
  FSETID	Don't clear set-user-ID and set-group-ID permission bits when a file is modified.
  KILL	Bypass permission checks for sending signals.
  MKNOD	Create special files using mknod(2).
  NET_BIND_SERVICE	Bind a socket to internet domain privileged ports (port numbers less than 1024).
  NET_RAW	Use RAW and PACKET sockets.
  SETFCAP	Set file capabilities.
  SETGID	Make arbitrary manipulations of process GIDs and supplementary GID list.
  SETPCAP	Modify process capabilities.
  SETUID	Make arbitrary manipulations of process UIDs.
  SYS_CHROOT	Use chroot(2), change root directory.

