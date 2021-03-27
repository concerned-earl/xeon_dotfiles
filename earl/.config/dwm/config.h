/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Terminus:size=11" };
static char normbgcolor[]           = "#222222";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#eeeeee";
static char selbordercolor[]        = "#005577";
static char selbgcolor[]            = "#005577";
static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
 };

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
}; 

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	// { ">M>",      centeredfloatingmaster },
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
// static const char *termcmd[]  = { "st", NULL };
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", NULL };

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_u,      spawn,          SHCMD("$HOME/.scripts/xmenu.sh") },
    { MODKEY,                       XK_d,      spawn,          SHCMD("$HOME/.scripts/dmenu.sh") },
    { MODKEY,                       XK_Return, spawn,          SHCMD("$TERMINAL") },
    { MODKEY,                       XK_space,  zoom,           {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_o,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { MODKEY,                       XK_q,      killclient,     {0} },
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} }, // tiling
    { MODKEY,                       XK_y,      setlayout,      {.v = &layouts[1]} }, // floating
    { MODKEY,                       XK_r,      setlayout,      {.v = &layouts[2]} }, // monocle
    { MODKEY,                       XK_e,      setlayout,      {.v = &layouts[3]} }, // center
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
    { MODKEY,                       XK_f,      togglefullscr,  {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    // { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} }, // center floating (wtf is this layout about)
    // { MODKEY,                       XK_z,      setlayout,      {0} }, 
    // { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
    // { MODKEY,                       XK_b,      togglebar,      {0} },
    // { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    // { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    // { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    // { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    { MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    { MODKEY|ShiftMask,             XK_Escape,  quit,          {0} },
    /* Audio/music */
    { 0,            XF86XK_AudioLowerVolume,    spawn,      SHCMD("amixer -q set Master 1%-; kill -44 $(pidof dwmblocks)") },
    { 0,            XF86XK_AudioRaiseVolume,    spawn,      SHCMD("amixer -q set Master 1%+; kill -44 $(pidof dwmblocks)") },
    { 0,            XF86XK_AudioMute,           spawn,      SHCMD("amixer -q set Master toggle") },
    { 0,            XF86XK_AudioPlay,           spawn,      SHCMD("mpc toggle && notify-send \\\"Music\\\" \\\"$(mpc status | grep \\\"#\\\")\\\"") },
    { 0,            XF86XK_AudioStop,           spawn,      SHCMD("mpc stop ; killall mpd && notify-send \\\"Music\\\" \\\"mpd stopped\\\"") },
    { 0,            XF86XK_AudioPrev,           spawn,      SHCMD("mpc prev") },
    { 0,            XF86XK_AudioNext,           spawn,      SHCMD("mpc next") },
    /* Screenshot */
    { 0,                            XK_Print,   spawn,      SHCMD("$HOME/.scripts/clipboard_screenshot.sh") },  // Saves selected area screenshot into clipboard
    { ShiftMask,                    XK_Print,   spawn,      SHCMD("$HOME/.scripts/area_screenshot.sh") },       // Takes screenshot of selected area
    { MODKEY|ShiftMask,             XK_Print,   spawn,      SHCMD("$HOME/.scripts/screenshot.sh") },            // Takes fullscreen picture

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
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
