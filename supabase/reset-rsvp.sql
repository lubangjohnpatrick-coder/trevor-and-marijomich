-- ==========================================================================
--  Clear the RSVP replies
--  Run this in the Supabase SQL Editor.
--    Dashboard -> SQL Editor -> New query -> paste everything -> Run
--
--  READ SECTION 1 FIRST. It prints the current counts so you can see what is
--  about to go. Section 2 does the deleting. Section 3 prints the result.
--
--  This is IRREVERSIBLE. There is no undo and no backup: once the rows are
--  gone they are gone. If any real guest has already replied and you want to
--  keep it, stop after section 1 and tell me the number instead.
-- ==========================================================================


-- --------------------------------------------------------------------------
-- 1. What is there right now
--    Run this on its own first if you want to look before you leap.
-- --------------------------------------------------------------------------
select 'rsvps'       as table_name, count(*) as rows from public.rsvps
union all select 'wishes',        count(*) from public.wishes
union all select 'invitations',   count(*) from public.invitations
union all select 'admins',        count(*) from public.admins;

-- The same thing, in more detail, so you can tell test rows from real ones:
select id, name, email, attendance, pax, dietary, message, created_at
from public.rsvps
order by created_at desc;


-- --------------------------------------------------------------------------
-- 2. Delete
-- --------------------------------------------------------------------------

-- The replies themselves. This is the whole point of the script.
delete from public.rsvps;

-- Test rows left in the message wall by connection checks. Matched on the name
-- AND the message so a real guest is never caught by this, whatever they are
-- called. Safe to run whether or not those rows are still there.
delete from public.wishes
where (name = '__p__'   and message = '__p__')
   or (name = 'A guest' and message = 'Congrats!')
   or (name = 'Guest Probe' and message = 'Guest Probe')
   or (name = 'Probe2'  and message = 'Probe2')
   or (name = 'ZZ Test Cleanup');


-- --------------------------------------------------------------------------
--    DO NOT DELETE FROM public.invitations
--
--    That table is the guest list. Every personal link is one of its rows:
--    index.html?invite=ana goes to get_invitation('ana'), which reads that
--    table. Emptying it does not just tidy up -- it breaks every invitation
--    you have already sent, and each guest then opens the generic cover with
--    "Dear Invited Person," instead of their own name. There is no way to
--    undo that except re-creating the links one by one.
--
--    To retire a single guest instead of the whole list, mark them inactive:
--      update public.invitations set active = false where token = 'ana';
--    The link then resolves to the generic cover rather than 404-ing, and the
--    row -- and its private note -- is still there if you change your mind.
-- --------------------------------------------------------------------------

-- To wipe the message wall completely as well, uncomment this. Guests can post
-- on it, so only do it if you are also wiping the RSVPs for a clean slate.
-- delete from public.wishes;


-- --------------------------------------------------------------------------
-- 3. Confirm
--    rsvps should now read 0.
-- --------------------------------------------------------------------------
select 'rsvps' as table_name, count(*) as rows from public.rsvps
union all select 'wishes',      count(*) from public.wishes
union all select 'invitations', count(*) from public.invitations
union all select 'admins',      count(*) from public.admins;

-- ==========================================================================
--  Nothing else is needed after this. rsvps.id is a uuid with a
--  gen_random_uuid() default, not an auto-increment, so there is no sequence
--  to reset and new replies will carry on normally.
-- ==========================================================================
