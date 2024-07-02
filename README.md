# Deploy Tools

This Repo aims to ease compilation and deployment code to STM32 boards.
Most of the projects are oriented towards its use in Robomaster Competition.

## Prerequisites:

If you would like to use this repo, you'll need:
* Ubuntu host
* Git
* VSCode
* GNU-ARM toolchain
* CubeMx(Optional)

1. If you're on Ubuntu, first run the following:

        sudo apt install git

        git clone "thisRepoSSHCloneCommand"

        cd deployTools

        sudo bash initialSetup/runMeUbuntu.sh

1. Then, register the created ssh keys to your Github account.
1. Download the gnu-arm-none-eabi toolchain. After that, run

        sudo bash initialSetup/setUpCrossCompiler.sh

1. (Optional) Download CubeMx 

        sudo bash initialSetup/setUpCubeMx.sh

1. When VS prompts if you want to install the recommended extensions, click on yes

### Tools used installed by the repo

* Docker
* Some VS Code extensions 
* screen

## If your completely new:

1. Make sure you've got git installed on your machine.
1. Go to this repo clone button, and select the ssh option
1. Run the `runMeUbuntu.sh` file to generate the ssh keys
1. Add the ssh keys to your github account 
1. Continue cloning all the repos you need


* Ctrl+Shift+P -> will open the command pallete. 
    * From the command palette you can run tasks.
## Contents brief:

TODO: 
* Why is this the repo structure
* What each folder does
* How to run a task
* Configure Docker to do the complete installation of the tools 

### /builderImages

Contains DockerFiles to make containerized development.
Tho most tools will be installed locally, the compilation needs to be the same across all team members, so to keep it standarized it must be done through the container. 

### /initialSetup

Contains a series of bash scripts that aim to facilitate the installation of the tools you'll be using.

### /.vscode
Contains configuration files to ease development for your projects. 
IT achieves so in two ways, tasks, which are a number of small automations. Standard extentions, to make sure evryone has whats required to make clean code on this and other repos easier.

### /.vscode
TBD
