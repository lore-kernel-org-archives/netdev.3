Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14792476078;
	Wed, 12 Aug 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549636; cv=none; b=UsKmG8B6LELjXH7bNjuIvejbJx1mBEWtLaL9MV2b6XgxnXmUmxUafYZYO5vQ2aCtGj+s9HyWOSLM5fSAmukiQXo2FzilfczIkxEo8D3h/BdP6IwBc6ohPTS4HPVG07a1bLpi/Uf4QxJESWG8hg/LJUN9B/yvAdiM2CvXQs10tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549636; c=relaxed/simple;
	bh=xYij7cP4aMkKLMLz/KFRIFGJAYoimqbAB8pTryfke1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrV5apMXfLDCILVIA8Y3pZKKSKL1UoixQfvik+RmXBDZfbAswsmbOp9+++5Sn1mfPtwh+NwGZmeYA9RRK1fa932AY8iHBTiAOYEQin323l375pHnFCeLxq54CrbDuunPRFIdlFoo2A6kbKKNnrgA7V8uld+K2ihCPKSC1WLCfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=VTGyR2EK; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="VTGyR2EK"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786549629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvKESIbkwTEkD/xyFWfOzJ7l0WnKrLj1CBe9odDSTjE=;
	b=VTGyR2EK4Y1ytBk7i2EWw83OW2JbNF5Rr1xPjMSYTBSKi86pwp1Uxqvchuth751fwhS446
	A9zcjoMGdIAX9xdv5cOkb6wWpqev/GtHKmu2hlQZlkLH+RHG5ufQxKVCQtLfMKe4fy5owv
	cgtXPlvMs9onIge4MH7i/QPj9iUgnekZTideP/KFqtq592a1pjq856pwUuj51tjxNMcmoq
	EwdkvFbnecY0UV/VRvMqtJZf6W7aK2Ne+Poo8LeQQ0IxdHolIUygZ2ZT+CqBmDm8MPJhXY
	8znJID2GsrwQHwltPJiYJ0BFJd218MYnZMJX0vJGAa6um03LM3JQlTAB0QVE6Q==
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
Subject: [PATCH net-next v3 1/2] net: sfp: allow prefix matching in quirk lookup
Date: Wed, 12 Aug 2026 17:47:07 +0200
Message-ID: <20260812154708.2201266-2-tillo@tillo.ch>
In-Reply-To: <20260812154708.2201266-1-tillo@tillo.ch>
References: <20260812154708.2201266-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some clone SFP modules return EEPROM reads where the vendor PN field
contains non-printable garbage past the trailing legitimate characters
instead of the SFF-8472 mandated space padding. The current sfp_match()
requires an exact full-field length match: sfp_strlen() returns 16 (no
trailing spaces or NULs to strip), but strlen() of the quirk string is
shorter, so the length comparison rejects the entry before strncmp() is
even called and the quirk silently never applies.

Add a part_prefix_match flag to struct sfp_quirk and a
SFP_QUIRK_F_PREFIX macro. When set, sfp_match() compares only strlen()
leading bytes of the quirk part string, ignoring trailing field bytes.
The vendor name comparison always stays exact. Existing exact-match
quirks are unaffected (part_prefix_match defaults to false via zero-init
in the existing SFP_QUIRK macros).

This patch only adds the mechanism; the first user is added by the
following patch.

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
---
 drivers/net/phy/sfp.c | 23 ++++++++++++++++++-----
 drivers/net/phy/sfp.h |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 508b6cc8e..15033cbf7 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -516,6 +516,15 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
 #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
 #define SFP_QUIRK_F(_v, _p, _f) SFP_QUIRK(_v, _p, NULL, _f)
+/* Like SFP_QUIRK_F, but matches the part as a prefix; the vendor name
+ * is still matched exactly. Use for modules whose EEPROM vendor PN
+ * field reads back with garbage past the legitimate characters instead
+ * of the SFF-8472-mandated space padding, so sfp_strlen can't trim the
+ * field down to the legitimate length.
+ */
+#define SFP_QUIRK_F_PREFIX(_v, _p, _f) \
+	{ .vendor = _v, .part = _p, .support = NULL, .fixup = _f, \
+	  .part_prefix_match = true }
 
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
@@ -629,13 +638,16 @@ static size_t sfp_strlen(const char *str, size_t maxlen)
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
@@ -648,8 +660,9 @@ static const struct sfp_quirk *sfp_lookup_quirk(const struct sfp_eeprom_id *id)
 	ps = sfp_strlen(id->base.vendor_pn, ARRAY_SIZE(id->base.vendor_pn));
 
 	for (i = 0, q = sfp_quirks; i < ARRAY_SIZE(sfp_quirks); i++, q++)
-		if (sfp_match(q->vendor, id->base.vendor_name, vs) &&
-		    sfp_match(q->part, id->base.vendor_pn, ps))
+		if (sfp_match(q->vendor, id->base.vendor_name, vs, false) &&
+		    sfp_match(q->part, id->base.vendor_pn, ps,
+			      q->part_prefix_match))
 			return q;
 
 	return NULL;
diff --git a/drivers/net/phy/sfp.h b/drivers/net/phy/sfp.h
index 879dff7af..19fe29d84 100644
--- a/drivers/net/phy/sfp.h
+++ b/drivers/net/phy/sfp.h
@@ -12,6 +12,7 @@ struct sfp_quirk {
 	void (*support)(const struct sfp_eeprom_id *id,
 			struct sfp_module_caps *caps);
 	void (*fixup)(struct sfp *sfp);
+	bool part_prefix_match;
 };
 
 struct sfp_socket_ops {
-- 
2.47.3

