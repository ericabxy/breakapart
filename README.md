# Breakapart

_Breakapart_ is a [multidirectional shooter](https://en.wikipedia.org/wiki/Shoot_%27em_up#Multidirectional_shooters) game for RetroArch.

The game is programmed in Lua using object-oriented programming concepts as described in [_Programming in Lua (first edition)_, Chapter 16](https://www.lua.org/pil/16.html).

## Getting Started

1. Locate your RetroArch Downloads directory and make sure the file "Breakapart.lutro" is saved there.
2. If you have not already, start RetroArch using your desktop launcher or command-line interface.
3. Using your RetroPad, navigate to the RetroArch Main Menu and select "Load Content".
4. Navigate to "Downloads" and select "Breakapart.lutro" from the list.
5. If you're asked which core to select, choose "Lua Engine (Lutro)".

## Developers

### Running the Latest Release from the Git Repository

_Breakapart_ can be run directly from the source code repository. First, clone the remote Git repository. The following command retrieves _Breakapart_ from the GitHub address.

    git clone https://github.com/ericabxy/breakapart

If you don't already have Lutro installed as a LibRetro core, you can initialize the Lutro submodule that's included with _Breakapart_.

    git submodule init
    git submodule update

Then build Lutro with the following command.

    make -C libretro-lutro

Finally, assuming you already have RetroArch installed on your computer, run RetroArch with the command-line option to load the included Lutro build as a LibRetro core.

Before committing any changes to the repository, make sure to clean up any build files with the following command.

    make -C libretro-lutro clean
