static struct Config config = {
	/* font, separate different fonts with comma */
	.font                   = "DejaVu Sans Mono:size=11",

	/* colors */
	.background_color       = "#262626",
	.foreground_color       = "#f0f0f0",
	//.selbackground_color    = "#c4aa83",
	.selbackground_color    = "#000000",
	.selforeground_color    = "#ffffff",
	.separator_color        = "#f0f0f0",
	.border_color           = "#f0f0f0",

	/* sizes in pixels */
	.width_pixels           = 125,  /* minimum width of a menu */
	.height_pixels          = 30,   /* height of a single menu item */
	.border_pixels          = 1,    /* menu border */
	.separator_pixels       = 3,    /* space around separator */
	.gap_pixels             = 0,    /* gap between menus */

	/* text alignment, set to LeftAlignment, CenterAlignment or RightAlignment */
	.alignment              = LeftAlignment,

	/*
	 * The variables below cannot be set by X resources.
	 * Their values must be less than .height_pixels.
	 */

	/* geometry of the right-pointing isoceles triangle for submenus */
	.triangle_width         = 3,
	.triangle_height        = 7,

	/* the icon size is equal to .height_pixels - .iconpadding * 2 */
	.iconpadding            = 2,

	/* area around the icon, the triangle and the separator */
	.horzpadding            = 8,
};

/*
 * KEYBINDINGS
 *
 * Look at your /usr/include/X11/keysymdef.h  (or the equivalent file
 * in your system) for a list of key symbol constants, and change the
 * macros below accordingly.  All key symbol constants begin with the
 * prefix XK_.
 *
 * For example, to use vim-like key bindings, set KEYSYMLEFT to XK_h,
 * KEYSYMDOWN to XK_j, KEYSYMUP to XK_k, etc.
 *
 * Note that the regular keys like ArrowUp, ArrowDown, Tab, Home, etc
 * will ALWAYS work, so you do not need to set them.
 *
 * If you do not want to set a key binding, keep it with the value of
 * XK_VoidSymbol
 */
#define KSYMFIRST   XK_g    /* select first item */
#define KSYMLAST    XK_G    /* select last item */
#define KSYMUP      XK_k    /* select previous item */
#define KSYMDOWN    XK_j    /* select next item */
#define KSYMLEFT    XK_h    /* close current menu */
#define KSYMRIGHT   XK_l    /* enter selected item */
