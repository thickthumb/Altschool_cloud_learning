
# The List of Commands




**Be sure to have created a new user, confirm working directory as instructed
and create directories**

 'whoami && pwd'

 'mkdir code test personal misc && ls'

   'cd /home/thickthumb/test'

    'cd ~/test '

**create copy and move files**

    'touch ~/misc/fileB && head -c 200 /dev/urandom > ~/misc/fileB && cat ~/misc/fileB'

      'cp ~/misc/FileA ~/misc/fileC '

      'mv ~/misc/fileB ~/misc/fileD && cat ~/misc/fileD'

**create tar files and zip**

      'tar cf ~/misc/misc.tf ~/misc/FileA  ~/misc/FileC ~/misc/fileD && ls'

      'gzip misc.tf && ls'

**User add with activities and setting lock, expiry, and 
force to change on password**

      'sudo useradd tinythumb'

      'sudo passwd -e tinythumb && sudo chage -l tinythumb > /home/tinythumb/passexp.txt'

      'sudo passwd -l engineering'

**creating a no shell user **

      'sudo adduser  --shell /sbin/nologin noshelluser '

      'cat /etc/passwd | grep noshelluser > /home/tinythumb/result.txt'

**Disabling password authentication for ssh, replace with no 
on line 58 if permitted**

     ' sudo vim /etc/ssh/sshd_config'

**Disabling root login for ssh, see line 34 to set to no if 
permitted**

      'sudo vim /etc/ssh/sshd_config'
