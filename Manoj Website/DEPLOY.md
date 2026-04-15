# Deploying to Zoho Catalyst

## Step 1 — Install the Catalyst CLI (one-time)

```bash
npm install -g zcatalyst-cli
```

---

## Step 2 — Create a project on Catalyst Console (one-time)

1. Go to **https://catalyst.zoho.com**
2. Click **New Project** → give it a name (e.g. `manoj-portfolio`)
3. Once created, open the project and go to **Settings → Project Details**
4. Copy the **Project ID** and **Project Key**
5. Paste them into `catalyst.json`:

```json
{
  "projectId": 1234567890,
  "projectKey": "abcdefghijklmnopqrstuvwxyz123456",
  "projectName": "manoj-portfolio"
}
```

---

## Step 3 — Login from terminal

```bash
catalyst login
```

This will open a browser tab — sign in with your Zoho account.

---

## Step 4 — Initialise the project (run inside this folder)

```bash
cd "/Users/jaswa-zsbch1582/Desktop/Manoj Website "
catalyst init
```

When prompted:
- **Choose an existing project** → select `manoj-portfolio`
- **Project directory** → press Enter (use current folder)
- Skip functions / data store if asked — choose **Web Client** only

---

## Step 5 — Move files into the Catalyst web-client folder

Catalyst expects static files inside `client/<web-client-name>/app/`.
Run this once to set up the structure:

```bash
mkdir -p "client/manoj-portfolio/app"
cp index.html "client/manoj-portfolio/app/"
cp -r Images  "client/manoj-portfolio/app/"
cp -r assets  "client/manoj-portfolio/app/"
```

---

## Step 6 — Deploy

```bash
catalyst deploy --only web_client
```

Your site will be live at:
```
https://<project-name>-<project-id>.catalystapps.com
```

---

## Re-deploying after edits

Whenever you update `index.html`, just re-run steps 5 & 6:

```bash
cp index.html "client/manoj-portfolio/app/index.html"
catalyst deploy --only web_client
```

---

## Trouble-shooting

| Error | Fix |
|---|---|
| `catalyst: command not found` | Run `npm install -g zcatalyst-cli` again |
| `Unauthorised` | Run `catalyst login` |
| `Project not found` | Double-check `projectId` in `catalyst.json` |
| `404 on site` | Make sure `index.html` is inside `client/manoj-portfolio/app/` |
| PDF not downloading | Confirm `Images/Manoj_Kumar_Resume.pdf` was copied to `app/Images/` |
