# Budget du foyer

A shared household budget tracker. Plain HTML/React (loaded via CDN scripts,
no build step) backed by Supabase for shared, multi-user data.

## Deploy

This is a static site — no `npm install`, no build command needed.
`netlify.toml` already tells Netlify to just publish the repo root as-is.

To connect it on Netlify:
1. Netlify → Add new site → Import an existing project → GitHub → select this repo
2. Leave build command empty, publish directory `.` (already set in netlify.toml)
3. Deploy

## Configuration

Supabase credentials are set directly in `index.html` near the top of the
`<script>` block (`SUPABASE_URL` / `SUPABASE_ANON_KEY`). These are the public
anon key — safe to expose client-side, access is enforced by Row Level
Security policies in the database (see `supabase-schema.sql` if present).

## Features

- Multi-user accounts, one shared household per group (invite-code based)
- Monthly income / expense tracking with budget vs. actual
- CSV bank-statement import (French bank export format: date;label;amount)
  that keeps an editable transaction log per month, not just aggregated sums
- Selected month tab is remembered per browser between visits
