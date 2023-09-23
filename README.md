![power-button-circle-icon-black-round-minimalist-icon-isolated-on-white-background-power-on](https://user-images.githubusercontent.com/100489181/235271206-69f3aeff-9b17-456b-8fe9-df837423b076.jpg)
# termux-starterpack
This script installs essential packages for developers on Ubuntu-based systems without requiring root permissions. It installs packages for web development (e.g. Node.js, Angular, React), database management (e.g. MySQL, MongoDB), text editors (e.g. Sublime Text, Atom), version control (e.g. Git), and more.

The script first checks if you have root permissions. If not, it proceeds to install packages that don't require root access. It also checks if the visudo file exists, as some packages require editing the file to grant permission for the user to run them without root access. If the visudo file is missing, the script removes the packages that require root access to install.

The script displays a loading spinner while installing each package, which helps keep track of progress. It also informs the user if a package is already installed, and displays a message once all packages have been installed.

This script is useful for developers who want to set up their development environment quickly and easily, without the need for root permissions. The script can be modified to add or remove packages as needed, and can be adapted for use on other Linux distributions.

In summary, this script installs essential packages for developers on Ubuntu-based systems, without requiring root permissions. It checks if the visudo file exists and removes packages that require root access if it doesn't. It displays a loading spinner while installing each package and informs the user if a package is already 
installed.
            
                
BONUS


If you really just gotten started learning bash and the shell, the terminal, zsh
whatever you call it, then you should definitely check the Pure Bash Bible. (Not made by me btw)
it has all the resources, commands,everything you SHOULD learn about bash and more
and by the way, I left a copy of the Pure Bash Bible in the repo.


