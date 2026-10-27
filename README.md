# eFootball Tournament Hub — Online starter

This package contains a mobile-friendly tournament web app for Mishal, Sham, Sanay, Bilal, Najmu, Ali, Shiyas, Shafin, Nihal, Sabith, Anzil and Nafih.

## Included
- `index.html` — web app with league table, result entry/edit/delete, fixtures counter, CSV export and print.
- `supabase_schema.sql` — shared online database schema.
- Local mode works without setup. Online mode synchronizes results between browsers via Supabase Realtime.

## Make it online (one-time setup)

1. Create a free project at https://supabase.com/ and wait for it to finish provisioning.
2. Open **SQL Editor** in your Supabase dashboard.
3. Paste the complete contents of `supabase_schema.sql` and run it.
4. Open **Project Settings → API** (or Connect) and copy the Project URL and the **anon/public** key (new projects may show a publishable key).
   - Never use a `service_role` or secret key in the browser.
5. Open `index.html` in a browser, press **Connect online**, paste the URL and public key, then connect.
6. To make it accessible to friends via a website link, publish `index.html` as a static site:
   - Create a GitHub repository and upload `index.html`.
   - In the repository, open **Settings → Pages**, choose deploy from the `main` branch and `/ (root)`, then save.
   - Open the Pages URL and connect it to the same Supabase project on each device. The URL/key config is saved in each browser.
   - Other static hosts such as Netlify or Cloudflare Pages also work.

## Important security limitation
This is a quick-start public tournament. The SQL policies allow anyone with the app's project URL and public key to insert, edit, and delete match results. Only share the site with your group if everyone is trusted. For a public website, use Supabase Auth and admin-only write policies before publishing. The public anon/publishable key is designed for browser use; never place a service-role/secret key in the app.

## Rules
Win = 3 points, draw = 1 each, loss = 0. Standings sort by points, goal difference, then goals scored. A 12-player single round-robin has 66 fixtures.
