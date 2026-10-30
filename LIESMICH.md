# WC-Kompass – Anleitung

Mit dem WC-Kompass findest du öffentliche Toiletten in ganz Deutschland auf einer Karte und bewertest sie nach **Sauberkeit**, **Zugänglichkeit** und **Gesamteindruck**, dazu Besonderheiten wie kostenlos, rollstuhlgerecht oder Wickeltisch.

- **Karte und Toiletten:** stammen aus OpenStreetMap, der freien Weltkarte, und sind kostenlos, ohne Konto.
- **Bewertungen:** werden in einer kostenlosen Supabase-Datenbank gespeichert. Dann sehen alle, die die App nutzen, dieselben Bewertungen.
- **Ohne Supabase** läuft die App im Testmodus. Bewertungen bleiben dann nur auf dem jeweiligen Handy.

## Inhalt des Ordners

| Datei | Zweck |
|---|---|
| index.html | die App |
| config.js | hier trägst du später die zwei Supabase-Werte ein |
| supabase-einrichtung.sql | legt die Datenbank an, wird einmal in Supabase eingefügt |
| manifest.webmanifest, sw.js, icons/ | Installation als App |

---

## Teil A: App auf GitHub veröffentlichen (wie bei den anderen Apps)

1. github.com → **+** → **New repository** → Name `WC-Kompass` → **Public** → **Create repository**
2. **uploading an existing file** → Inhalt des Ordners einschließlich `icons` hineinziehen. Die Datei `LIESMICH.md` kannst du weglassen, die SQL-Datei auch. → **Commit changes**
3. **More** → **Settings** → **Pages** → Branch **main**, **/ (root)** → **Save**
4. Nach 1–3 Minuten erreichbar unter `https://wimmi66-code.github.io/WC-Kompass/`

Die App läuft jetzt schon, im Testmodus.

---

## Teil B: Gemeinsame Datenbank bei Supabase (einmalig, ca. 15 Minuten)

Supabase gibt es nur auf Englisch. Die englischen Begriffe stehen **fett**, die Übersetzung in Klammern.

### B1. Konto und Projekt anlegen

1. Öffne **supabase.com** und klicke auf **Start your project** (Projekt starten).
2. Melde dich mit **Continue with GitHub** (mit GitHub fortfahren) an. Dein GitHub-Konto reicht, ein neues Passwort brauchst du nicht.
3. Falls nach einer **Organization** (Organisation) gefragt wird: Name z. B. `Carsten`, **Type**: Personal, **Plan**: **Free** (kostenlos) → **Create organization**.
4. **New project** (neues Projekt):
   - **Project name**: `wc-kompass`
   - **Database Password** (Datenbank-Passwort): auf **Generate a password** klicken und das Passwort sicher notieren. Für die App brauchst du es nicht.
   - **Region**: **Central EU (Frankfurt)**. Dann liegen die Daten in Deutschland.
   - → **Create new project** (Projekt erstellen). Die Einrichtung dauert 1–2 Minuten.

### B2. Datenbank-Tabellen anlegen

1. Klicke links auf **SQL Editor**, das Symbol mit `>_`.
2. Klicke auf **New query** (neue Abfrage) bzw. das **+**.
3. Öffne die Datei `supabase-einrichtung.sql` mit dem Editor (Rechtsklick → Öffnen mit → Editor), markiere alles mit **Strg + A** und kopiere es mit **Strg + C**.
4. Füge den Text in Supabase ein (**Strg + V**) und klicke unten rechts auf **Run** (Ausführen).
5. Unten muss **Success. No rows returned** (Erfolgreich, keine Zeilen zurückgegeben) stehen. Meldungen mit „NOTICE … skipping“ sind normal.

### B3. Die zwei Werte für die App holen

1. Klicke links unten auf das Zahnrad **Project Settings** (Projekteinstellungen).
2. **Project URL** (Projekt-Adresse): Unter **Data API** oder **API** steht eine Adresse wie `https://abcdefghijk.supabase.co`. Kopiere sie.
   - Alternativ: oben im Projekt auf **Connect** klicken, dort steht sie auch.
3. **Schlüssel:** Unter **API Keys** gibt es den öffentlichen Schlüssel. Er heißt je nach Ansicht
   - **Publishable key** (beginnt mit `sb_publishable_…`) oder
   - **anon public** (langer Text, beginnt mit `eyJ…`).
   Kopiere einen davon.
   - ⚠️ **Niemals** den **secret**- oder **service_role**-Schlüssel nehmen. Der darf nicht in die App.

### B4. Werte in die App eintragen

1. Öffne bei GitHub dein Repository `WC-Kompass` und klicke auf die Datei **config.js**.
2. Klicke oben rechts auf das **Stift-Symbol** (Edit this file, Datei bearbeiten).
3. Trage die beiden Werte zwischen die Hochkommas ein:
   ```js
   supabaseUrl: 'https://abcdefghijk.supabase.co',
   supabaseKey: 'sb_publishable_xxxxxxxxxxxx'
   ```
4. Klicke oben rechts auf **Commit changes…** und dann noch einmal auf **Commit changes**.
5. Warte 1–2 Minuten und öffne die App neu. Im Info-Fenster (ⓘ) steht dann „Bewertungen werden gemeinsam gespeichert“.

---

## Teil C: Aufs Handy

- **iPhone:** Link in Safari → **Teilen** → **Zum Home-Bildschirm**
- **Android:** Chrome → **App installieren**
- Erlaube beim ersten Tippen auf „Standort“ die Ortung, dann springt die Karte zu dir.

## So benutzt du die App

- **Hineinzoomen** bis auf Stadtteil-Ebene, dann werden die Toiletten geladen.
- **Punkt antippen** zeigt Details, Bewertungen, Kommentare und einen Routen-Link.
- **Bewerten:** 1–5 Sterne für Sauberkeit, Zugänglichkeit und Gesamt, dazu Besonderheiten ankreuzen und optional einen Kommentar schreiben.
- **Melden (+):** Fehlt eine Toilette, verschiebst du die Karte, bis das Kreuz auf ihr liegt, und tippst auf „Hier eintragen“.
- **Filter:** z. B. nur ab 4 Sterne, rollstuhlgerecht, kostenlos oder mit Wickeltisch.

## Gut zu wissen

- **Supabase pausiert kostenlose Projekte**, wenn sie etwa eine Woche nicht genutzt werden. Dann meldet die App „Bewertungen konnten nicht geladen werden“. In Supabase das Projekt öffnen und auf **Restore project** (Projekt wiederherstellen) klicken. Die Daten bleiben erhalten.
- **Schutz:** Die Datenbank erlaubt nur Lesen und neue Einträge. Niemand kann über die App Bewertungen ändern oder löschen. Unpassende Kommentare löschst du selbst in Supabase: links **Table Editor** → `ratings` → Zeile anklicken → **Delete** (Löschen).
- **Öffentlich machen:** Für einen kleinen Kreis reicht das so. Willst du die App irgendwann öffentlich bewerben, brauchst du in Deutschland ein Impressum und eine Datenschutzerklärung.
- **Kartendaten:** © OpenStreetMap-Mitwirkende. Die kostenlosen Dienste (Karte, Toilettensuche, Ortssuche) sind für private Nutzung in kleinem Umfang gedacht.

## Aktualisieren

Geänderte Dateien bei GitHub erneut hochladen und in `sw.js` die Version hochzählen (`wc-kompass-v2` …).
