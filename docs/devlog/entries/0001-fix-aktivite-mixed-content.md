# #0001 — Aktivite isteği mixed content düzeltmesi

- **Tarih:** 2026-10-23
- **Tür:** fix
- **Durum:** done
- **İlgili:** zeythan-dcbot `src/api/publicApi.js`
- **Commit/PR:** (yok)

## Özet
Sunucu aktiviteleri HTTPS sayfada yüklenmiyordu. Sebep, canlı `config.js` içindeki
`activityApiUrl` değerinin `http://31.42.127.74/...` olması ve tarayıcının bunu
mixed content olarak engellemesiydi. `activity.js`'e HTTPS güvenlik ağı eklendi;
bot tarafında public yanıtlara `no-store` verildi.

## Bağlam / Neden
Site `https://zeythann.com.tr`, API ise `https://zeythann.online/api/public/activity`
üzerinde çalışıyor. Live ortamda config dosyası 17 Ekim sürümünde kalmış ve HTTP IP
adresini kullanıyordu; HTTPS sayfadan HTTP `fetch` tarayıcı tarafından bloke edildiği
için aktivite bölümü hiç veri gösteremiyordu.

## Yapılanlar
| Dosya | Değişiklik |
|---|---|
| `activity.js` | `buildApiUrl()`: HTTPS sayfada `http://` API adresi varsa `https://zeythann.online/api/public/activity` (veya `activityApiHttps`) kullanılır |
| `index.html`, `aktiviteler.html` | `config.js` / `activity.js` sürüm parametreleri `20261023a` |
| `oyunlar.html`, `discord-vpn.html`, `goodbyedpi.html`, `yayincilarimiz.html` | `config.js` sürüm parametresi `20261023a` |
| `../ZEYTHAN-DCBOT/src/api/publicApi.js` | Public uçlara `Cache-Control: no-store` |

## Kararlar ve alternatifler
- **Karar:** İstemci tarafında HTTPS fallback. **Gerekçe:** Canlıda eski `config.js`
  kalırsa bile `activity.js` tek başına güncellenince veri görünür.
- **Reddedilen:** `http` → `https` şema yükseltmesi. **Neden:** `https://31.42.127.74`
  geçerli sertifikaya sahip değil.

## Etki
HTTPS sayfalarda aktivite isteği artık engellenmiyor. `config.js` doğru (https) sürümle
yayınlandığında fallback devreye girmez.

## Doğrulama
- `GET https://zeythann.online/api/public/activity?guild=832402784522731540` → 200,
  `online: 24`, 5 oyun + Talking.
- CORS preflight (`Origin: https://zeythann.com.tr`) → 204, `Access-Control-Allow-Origin: *`.
- `node --check activity.js` → OK, `node --check src/api/publicApi.js` → OK.

## Sonraki adımlar / Açık konular
- [ ] Güncel `config.js` + `activity.js` + HTML dosyalarını canlı sunucuya yükle
      (`zeythann.com.tr` origin'i bu makinede değil; deploy manuel).
- [ ] Botu yeniden başlat ki `no-store` başlığı devreye girsin.
