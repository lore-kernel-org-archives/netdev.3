Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035493E0750;
	Thu,  6 Aug 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002732; cv=none; b=DS+++ieLzdOrqVL3A71P9gys9MPIiRpfMj0aWRW3Aaph8Tidsa3ZYyZznsyWPIuPcjAvN2RGUGGTxezaFI7y18Mmf8DnZ3K0Jhbs35cIeiCMyJeGe+GAwtIalMhVlIFMadqYFdLpiNFKwms3zCR4pG/ebMtwFSYgPk2cwIs1sDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002732; c=relaxed/simple;
	bh=3Uee9QlelAJa/+eZhKNdJt6eh1UWOvF/qy9/C118x3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZ6E+NBSa5NQ7ItAoEVA3Z9+oFM6N+TLxXQmiJ0WJGKjv5h5AOaWRckhK9U7kjVWj3FVhsxVMDEtKbkK/uptYhJ+0uZf4vkCtgaD4c3qojzn8v89Cb5+Ha/NIzwSZyKWS5mXUYWwJNuwh3FpIm7SKwluJjFO/wd93g70tejY9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=MhzpjOMf; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="MhzpjOMf"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786002190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMs4Ns5Z86mqpGgEPKo3+FdRfWj1qIv5Nn6aB/XjqX0=;
	b=MhzpjOMfecX5Qcbjv1srNz03SZULUv2vYfyL5cGF6kGG2BpykWl+4J9zM2ZDNkvDgfmQfX
	EEBZDrhJn+OlaVF34h8g2ZcD7ujqlCpSA9mybnGIiOX48/k9PJjwM+IHikqgJvvAjq/pQO
	xWYtoLtz82JKDQklBoZU11RGoy3oti/zRt08LlLCoabPOlcrqfou6nXfvOu/qTQaCyn2zZ
	p4Ltl7SzRR5KYFDfCOFsaJPQhK7QIDJm3vxyRXGQQRSqJU9r0cf2IBQgUR4xHBEUMwQmNV
	YcE9mNd/3huPxA8MVPPpD05e5R/NSoavrwnI/rXJNcbM2kmJByWg7EA/wfg7Hg==
To: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Martino Dell'Ambrogio <tillo@tillo.ch>
Subject: [PATCH net-next v2 1/2] net: sfp: allow prefix matching in quirk lookup
Date: Thu,  6 Aug 2026 09:43:07 +0200
Message-ID: <20260806074308.1996917-2-tillo@tillo.ch>
In-Reply-To: <20260806074308.1996917-1-tillo@tillo.ch>
References: <20260806074308.1996917-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some clone SFP modules (notably XGS-PON ONT sticks) ship malformed
EEPROMs where the vendor PN field is filled with non-printable garbage
past the trailing legitimate characters instead of SFF-8472 mandated
space padding. The current sfp_match() requires an exact full-field
length match: sfp_strlen() returns 16 (no trailing spaces or NULs to
strip), but strlen() of the quirk string is shorter, so the length
comparison rejects the entry before strncmp() is even called and the
quirk silently never applies. The kernel then honors the module's
spurious TX_FAULT signal and the SFP state machine eventually disables
the module.

Add a prefix_match flag to struct sfp_quirk and a SFP_QUIRK_F_PREFIX
macro. When set, sfp_match() compares only strlen() leading bytes of
the quirk string, ignoring trailing field bytes. Existing exact-match
quirks are unaffected (prefix_match defaults to false via zero-init in
the existing SFP_QUIRK macros).

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 23 ++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 6c25b73..dfb2b88 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -516,6 +516,14 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
 #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
 #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
+/* Like SFP_QUIRK_F, but matches as a prefix. Use for clone modules
+ * that fill EEPROM trailing bytes with garbage instead of the
+ * SFF-8472-mandated space padding, so sfp_strlen can't trim the
+ * field down to the legitimate length.
+ */
+#define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
+	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, \
+	  .prefix_match = true }
 
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
@@ -629,13 +637,16 @@ static size_t sfp_strlen(const char *str, size_t maxlen)
 	return size;
 }
 
-static bool sfp_match(const char *qs, const char *str, size_t len)
+static bool sfp_match(const char *qs, const char *str, size_t len, bool prefix)
 {
+	size_t qs_len;
+
 	if (!qs)
 		return true;
-	if (strlen(qs) != len)
+	qs_len = strlen(qs);
+	if (prefix ? qs_len > len : qs_len != len)
 		return false;
-	return !strncmp(qs, str, len);
+	return !strncmp(qs, str, qs_len);
 }
 
 static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
@@ -648,8 +659,10 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
 	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
 
 	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
-		if (sfp_match(q->vendor, id->base.vendor_name, vs) &&
-		    sfp_match(q->part, id->base.vendor_pn, ps))
+		if (sfp_match(q->vendor, id->base.vendor_name, vs,
+			      q->prefix_match) &&
+		    sfp_match(q->part, id->base.vendor_pn, ps,
+			      q->prefix_match))
 			return q;
 
 	return NULL;
diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index 879dff7..867e45e 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -12,6 +12,7 @@ struct sfp_quirk {
 	void (*support)(const struct sfp_eeprom_id *id,
 			struct sfp_module_caps *caps);
 	void (*fixup)(struct sfp *sfp);
+	bool prefix_match;
 };
 
 struct sfp_socket_ops {
-- 
2.47.3

