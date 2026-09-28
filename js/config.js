/* ==========================================================================
   SITE CONFIG  —  Trevor & Marijomich wedding invitation
   --------------------------------------------------------------------------
   THIS IS THE ONLY FILE YOU NEED TO EDIT TO GO LIVE.

   Everything the guests send — replies, wishes and the guest list — is
   stored in Supabase and read back through the admin page at admin.html.
   There is no spreadsheet and no second service to maintain.
   ========================================================================== */

window.SITE_CONFIG = {

  /* ----------------------------------------------------------------------
     1) SUPABASE  —  the only backend
     ----------------------------------------------------------------------
     It holds three things:
       invitations  one row per personal guest link
       wishes       the message wall
       rsvps        every reply, listed in the admin page

     How to fill this in:
       a. Go to https://supabase.com and create a free project.
       b. Open  Project Settings  ->  API.
       c. Copy the "Project URL" into supabaseUrl.
       d. Copy the "publishable" key into supabaseAnonKey.
          (NEVER paste the secret key here. It bypasses every security rule
           and must stay on a server.)

     While these two values are empty the site still works: everything is
     kept in the visitor's own browser so you can test the whole flow.
     ---------------------------------------------------------------------- */
  /* Your own Supabase project.
     The publishable key is designed to be public — the safety comes from the
     row level security rules in supabase/schema.sql, not from hiding it. */
  supabaseUrl: 'https://wlbokudjkiwujaicrtzf.supabase.co',
  supabaseAnonKey: 'sb_publishable_yiKXE5J7xk1rwZ-t7xZovw_nSbcy9A7',

  /* ----------------------------------------------------------------------
     2) OPTIONAL EXTRAS
     ---------------------------------------------------------------------- */

  /* Background music.
     Either drop an .mp3 into assets/audio/ and point to it here,
     or paste a YouTube video id and it will play in a hidden player.
     The music button stays hidden until one of these is filled in. */
  musicAudioSrc: '',
  musicVideoId: '',

  /* Admin fallback passcode. Left empty on purpose: the admin page is served
     by a real Supabase account, so this local-only shortcut is never needed
     and there is no reason to publish a password in the repository. */
  localAdminPasscode: '',

  /* ----------------------------------------------------------------------
     3) WEDDING DETAILS
     Edit these if any detail changes. Most of them are also written
     directly in index.html — this block feeds the countdown.
     ---------------------------------------------------------------------- */
  wedding: {
    groom: 'Trevor George White',
    bride: 'Marijomich Denniece Torres',
    /* 4:00 PM Philippine time on 4 January 2027 */
    startISO: '2027-01-04T16:00:00+08:00',
    endISO: '2027-01-04T22:00:00+08:00',
    venue: 'Hacienda Solange Indang',
    venueLine2: '@ EMV Flower Farm',
    mapsQuery: 'Hacienda Solange Indang EMV Flower Farm',
    /* Seats reserved per guest, used on the welcome screen and the RSVP form */
    defaultSeats: 2
  }
};
