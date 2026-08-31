# Payment Setup Guide

This guide explains how to add a payment button so readers can buy the full EPUB.

---

## Recommended: Lemon Squeezy (Zero Backend Required)

**Why Lemon Squeezy over Stripe:**
- Stripe Payment Links cannot auto-deliver digital files without a webhook server
- Lemon Squeezy handles file hosting, delivery, VAT, and receipts automatically
- Works on any static site with a single `<a>` tag

### Setup Steps

1. **Create a free account** at [lemonsqueezy.com](https://lemonsqueezy.com)

2. **Create a new store** (takes 2 minutes)

3. **Create a Digital Product:**
   - Product name: "100 Solopreneur Short Stories (EPUB)"
   - Price: $9 (adjust as you see fit)
   - Upload your `book.epub` file under "Files"

4. **Get your checkout URL** from the product page

5. **Replace the placeholder** in `index.html`:
   ```html
   <!-- Find this line: -->
   <a href="YOUR_PAYMENT_URL_HERE" ...>

   <!-- Replace with your Lemon Squeezy URL: -->
   <a href="https://yourstore.lemonsqueezy.com/buy/PRODUCT_ID?embed=1" ...>
   ```

6. **Also update** `src/introduction.md`:
   ```markdown
   <!-- Replace YOUR_LEMON_SQUEEZY_OR_GUMROAD_URL with your actual URL -->
   ```

### The Embed Overlay (Recommended)

The `?embed=1` parameter + Lemon Squeezy's JS script makes the checkout open as an overlay modal instead of redirecting to a new page:

```html
<!-- Already included in index.html: -->
<script src="https://assets.lemonsqueezy.com/lemon.js" defer></script>

<!-- Your button with embed=1: -->
<a href="https://yourstore.lemonsqueezy.com/buy/XXXX?embed=1" class="lemonsqueezy-button">
  Buy Full EPUB — $9
</a>
```

Buyers stay on your page. Checkout happens in a modal. Revenue lands in your account.

---

## Alternative: Gumroad

If you prefer Gumroad:

1. Create account at [gumroad.com](https://gumroad.com)
2. New Product → Digital → Upload your EPUB
3. Set price ($9 suggested)
4. Copy the product URL
5. Replace `YOUR_PAYMENT_URL_HERE` in `index.html` with the Gumroad URL

Gumroad also supports overlay checkout via their embed widget.

---

## Getting the EPUB

After pushing to GitHub, the GitHub Actions workflow builds the mdBook and generates an EPUB file at:

```
book/epub/output.epub
```

Download this file after a successful workflow run, then upload it to Lemon Squeezy or Gumroad.

To download from CI: go to your repo → Actions → latest workflow run → Artifacts.

---

## Testing the Flow

Before going live, test the full buyer journey:

1. Visit your GitHub Pages URL
2. Click the buy button
3. Complete a test purchase (Lemon Squeezy has a test mode)
4. Verify the EPUB arrives by email
5. Verify the EPUB opens correctly on Kindle/Apple Books/Calibre

---

## Pricing Suggestions

| Price | Notes |
|-------|-------|
| $0 | Free (build audience, no revenue) |
| $5 | Low friction, high conversion |
| $9 | Sweet spot for short-form collections |
| $19 | Justified if stories are very high quality |
| $29 | Premium tier, needs strong social proof |

Start at $9. Raise it if demand exists.
