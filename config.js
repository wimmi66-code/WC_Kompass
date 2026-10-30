// WC-Kompass – Verbindung zur gemeinsamen Datenbank (Supabase)
// Solange beide Felder leer sind, speichert die App Bewertungen nur auf dem jeweiligen Gerät (Testmodus).
// Trage hier die Werte aus Supabase ein: Project Settings → API (bzw. "Data API" und "API Keys").
window.WC_KOMPASS_CONFIG = {
  supabaseUrl: '',   // z. B. 'https://abcdefghijklmno.supabase.co'
  supabaseKey: ''    // der öffentliche Schlüssel: "anon public" oder "publishable" (NICHT der "service_role"/"secret"-Schlüssel!)
};
