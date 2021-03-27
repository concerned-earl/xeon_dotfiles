//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
    /*Icon*/    /*Command*/     /*Update Interval*/ /*Update Signal*/
    // {" ",   "$HOME/.scripts/cpu.sh",            10, 0},
    {"",    "$HOME/.scripts/used_memory.sh",    10, 0},
    {"",    "$HOME/.scripts/volume.sh",         0,  10},
    {"",    "$HOME/.scripts/date.sh",           60, 0},
};
//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " ";
static unsigned int delimLen = 1;
