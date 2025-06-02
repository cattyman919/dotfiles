/* user and group to drop privileges to */
static const char *user  = "senohebat";
static const char *group = "senohebat";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
  [PAM] =    "#556B2F",   /* waiting for PAM - DarkOliveGreen */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = ":)";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x13";

/* enable or disable (1 means enable, 0 disable) bell sound when password is incorrect */
static const int xbell = 0;

/* PAM service that's used for authentication */
static const char* pam_service = "login";
