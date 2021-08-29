/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 64;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Terminus:size=11" };

/* yellow */
/* static const char col_bg[]          = "#000000";
static const char col_fg[]          = "#c4aa83";
static const char col_1[]           = "#ffffff";
static const char col_2[]           = "#5e4e37";
static const char *colors[][3]      = {
    //               fg         bg          border
    [SchemeNorm] = { col_1,     col_bg,     col_2 },
    [SchemeSel]  = { col_bg,    col_fg,     col_fg },
    [SchemeHid]  = { col_1,     col_2,      col_bg },
}; */

/* mountain */
/* static const char col_bg[]          = "#262626";
static const char col_fg[]          = "#8aac8b";
static const char col_1[]           = "#f0f0f0";
static const char col_2[]           = "#4c4c4c";
static const char *colors[][3]      = {
    //               fg         bg          border
    [SchemeNorm] = { col_1,     col_bg,     col_2 },
    [SchemeSel]  = { col_bg,    col_fg,     col_fg },
    [SchemeHid]  = { col_1,     col_2,      col_bg },
}; */

/* monochrome */
static const char col_bg[]          = "#262626";
static const char col_fg[]          = "#ffffff";
static const char col_1[]           = "#4c4c4c";
static const char col_2[]           = "#b8bbc2";
static const char *colors[][3]      = {
    //               fg         bg          border
    [SchemeNorm] = { col_2,     col_bg,     col_1 },
    [SchemeSel]  = { col_fg,    col_bg,     col_fg },
    [SchemeHid]  = { col_bg,    col_2,      col_bg },
};

/* scratchpad */
typedef struct {
    const char *name;
    const void *cmd;
} Sp;
const char *spcmd1[] = {"st", "-n", "spterm", NULL };
const char *spcmd2[] = {"st", "-n", "spmusic", "-e", "ncmpcpp", NULL };
const char *spcmd3[] = {"pavucontrol", NULL };
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm",      spcmd1},
    {"spmusic",     spcmd2},
    {"pavucontrol", spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class            instance    title       tags mask     isfloating   monitor */
	{ "Arandr",         NULL,       NULL,       0,            1,           1 },
	{ "discord",        NULL,       NULL,       1 << 3,       0,           1 },
	{ "Lxappearance",   NULL,       NULL,       0,            1,           1 },
	{ "Nvidia-settings",NULL,       NULL,       0,            1,           1 },
	{ "obs",            NULL,       NULL,       1 << 4,       0,           1 },
	{ "Qalculate-gtk",  NULL,       NULL,       0,            1,           1 },
	{ "qBittorrent",    NULL,       NULL,       1 << 4,       0,           1 },
    { NULL,             "spterm",   NULL,       SPTAG(0),     1,           -1 },
    { NULL,             "spmusic",  NULL,       SPTAG(1),     1,           -1 },
    { NULL,             "pavucontrol",  NULL,   SPTAG(2),     1,           -1 },
}; 

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "TTT",      bstack },
	// { "===",      bstackhoriz },
	{ "[D]",      deck },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]        = { "dmenu_run", NULL };

#include "movestack.c"
static Key keys[] = {
    /* modifier             key        function        argument */
    { MODKEY,               XK_d,      spawn,          SHCMD("$HOME/.scripts/dmenu.sh") },
    { MODKEY,               XK_Return, spawn,          SHCMD("$TERM") },
    { MODKEY,               XK_space,  zoom,           {0} },
    { MODKEY,               XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,               XK_k,      focusstack,     {.i = -1 } },
    { MODKEY|ShiftMask,     XK_j,      movestack,      {.i = +1 } },
    { MODKEY|ShiftMask,     XK_k,      movestack,      {.i = -1 } },
    // { MODKEY,               XK_i,      incnmaster,     {.i = +1 } },
    // { MODKEY,               XK_o,      incnmaster,     {.i = -1 } },
    { MODKEY,               XK_h,      setmfact,       {.f = -0.02} },
    { MODKEY,               XK_l,      setmfact,       {.f = +0.02} },
    { MODKEY,               XK_Tab,    view,           {0} },
    { MODKEY,               XK_q,      killclient,     {0} },
    { MODKEY,               XK_a,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,               XK_r,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,               XK_s,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,               XK_e,      setlayout,      {.v = &layouts[3]} },
    // { MODKEY,               XK_r,      setlayout,      {.v = &layouts[4]} },
    { MODKEY,               XK_w,      setlayout,      {.v = &layouts[4]} },
    { MODKEY|ShiftMask,     XK_space,  togglefloating, {0} },
    { MODKEY,               XK_f,      togglefullscr,  {0} },
    { MODKEY,               XK_0,      view,           {.ui = ~0 } },
    { MODKEY,               XK_i,      focusmaster,    {0} },
    // { MODKEY,               XK_z,      setlayout,      {0} }, 
    // { MODKEY|ShiftMask,     XK_0,      tag,            {.ui = ~0 } },
    // { MODKEY,               XK_b,      togglebar,      {0} },
    // { MODKEY,               XK_comma,  focusmon,       {.i = -1 } },
    // { MODKEY,               XK_period, focusmon,       {.i = +1 } },
    // { MODKEY|ShiftMask,     XK_comma,  tagmon,         {.i = -1 } },
    // { MODKEY|ShiftMask,     XK_period, tagmon,         {.i = +1 } },
    TAGKEYS(                XK_1,                      0)
    TAGKEYS(                XK_2,                      1)
    TAGKEYS(                XK_3,                      2)
    TAGKEYS(                XK_4,                      3)
    TAGKEYS(                XK_5,                      4)
    // TAGKEYS(                XK_6,                      5)
    // TAGKEYS(                XK_7,                      6)
    // TAGKEYS(                XK_8,                      7)
    // TAGKEYS(                XK_9,                      8)
    { MODKEY|ShiftMask,     XK_Escape, quit,           {0} },

    /* Scratchpad */
    { MODKEY,               XK_z,      togglescratch,  {.ui = 0 } },
    { MODKEY,               XK_m,      togglescratch,  {.ui = 1 } },
    { MODKEY,               XK_n,      togglescratch,  {.ui = 2 } },

    /* Audio/music */
    { 0,                    XF86XK_AudioLowerVolume,   spawn,      SHCMD("amixer -q set Master 1%-; kill -44 $(pidof dwmblocks)") },
    { 0,                    XF86XK_AudioRaiseVolume,   spawn,      SHCMD("amixer -q set Master 1%+; kill -44 $(pidof dwmblocks)") },
    { 0,                    XF86XK_AudioMute,          spawn,      SHCMD("amixer -q set Master toggle") },
    { 0,                    XF86XK_AudioMicMute,       spawn,      SHCMD("amixer -q set Capture toggle") },
    { 0,                    XF86XK_AudioPlay,          spawn,      SHCMD("mpc toggle && ~/.scripts/current_song.sh") },
    { 0,                    XF86XK_AudioStop,          spawn,      SHCMD("mpc stop ; killall mpd && notify-send \\\"mpd-offline\\\"") },
    { 0,                    XF86XK_AudioPrev,          spawn,      SHCMD("mpc prev") },
    { 0,                    XF86XK_AudioNext,          spawn,      SHCMD("mpc next") },

    /* Screenshot */
    { 0,                    XK_Print,  spawn,          SHCMD("$HOME/.scripts/clipboard_screenshot.sh") },
    { ShiftMask,            XK_Print,  spawn,          SHCMD("$HOME/.scripts/area_screenshot.sh") },
    { MODKEY|ShiftMask,     XK_Print,  spawn,          SHCMD("$HOME/.scripts/screenshot.sh") },

    /* Brightness */
    { 0,                    XF86XK_MonBrightnessUp,    spawn,      SHCMD("xbacklight -inc 5") },
    { 0,                    XF86XK_MonBrightnessDown,  spawn,      SHCMD("xbacklight -dec 5") },

    /* Menu */
    { MODKEY,               XK_x,      spawn,          SHCMD("$HOME/.scripts/xmenu.sh") },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	// { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
