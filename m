Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E84746C8;
	Wed, 12 Aug 2026 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549636; cv=none; b=fsyEvwv4umLI+E7pfdeRp9SBNXjLi18iNp52RnOPcghzvCXKzvm1pu0J4Cba+YNxBkYr9nuAKcZ8cfsIecO7dKg4dRBPDm1L+EAJxH5FUcgqKP9vA75k5WeVTwVQPKzhaapV96yQxa0v+ifljTKoF9xpnDjJ+spu07r3AQ8i6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549636; c=relaxed/simple;
	bh=gvucimwkPlky5WPR/mJhkMtSVdyal08lqRwnxvaFSt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKs6y29i1VxYASmyyeOg81DQGGcPWAakHo4NGMrkEswfsVEtzf01TgzAXbJAmk0PDdpTf9/ySNgm73Ev/2/qfq0yGqAXAsRAAZ4O7yH6YnP4SZqptOJH5n4kzRDc8SSSas/GDZtKrietVO7V5T/AwUPrnM7Kltiq/LEJFlkam/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=ToIcrMZP; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="ToIcrMZP"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786549630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5DNA2j9LgophSFdTvr9ptz5iK62Pxe4CZ/O8iholho=;
	b=ToIcrMZPBvFGxNnn9MU4znWUvtlSa/29yOJpkedi7dZQi2TQ4CGt0ZOitWdDfrb1LbPWP7
	orV7DwwHwPL1HUU1iNVnk2N09FokIwGCbcHrNUbl2cfm7RrCw1AVOlcm3N4G9yBOEK4huH
	9rhtqrYI9mY7JtfE38cTxXrkAG+1R5boA6BXR8J9z/L6wRSQ2jIHcatq7PfWWvS7j6FetX
	qi9/NLKPrRTyVtDO9hq5kG0IIgwUZ+UX+jxeQKf9eoF0b1H/UL/efBCn+CoyudobxkhICv
	tUUvgWPu6+djxJnSVGs1rIgVnW/i3i2Evn6dB5DWqJIIPxqD5YfAFUmpYOCc1g==
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
Subject: [PATCH net-next v3 2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
Date: Wed, 12 Aug 2026 17:47:08 +0200
Message-ID: <20260812154708.2201266-3-tillo@tillo.ch>
In-Reply-To: <20260812154708.2201266-1-tillo@tillo.ch>
References: <20260812154708.2201266-1-tillo@tillo.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cheap XGS-PON ONT sticks identifying as vendor "OEM", PN "XGSPONST2001"
have broken TX_FAULT and LOS indicators (driven by the ONU serial
passthrough wires) and need a longer T_START_UP than the SFF-8472
default. The Fiberstore XGS-SFP-ONT-MACI MAC-mode ONT stick has the
same ONT-class TX_FAULT/LOS wiring and startup behaviour. Apply the
existing sfp_fixup_potron handler to both, which masks both signals
and bumps T_START_UP to T_START_UP_BAD_GPON.

The XGSPONST2001 returns the 12 legitimate PN characters followed by
non-printable garbage on cold power-up reads (the same module reads
back clean and space-padded after a warm reseat), which defeats
exact-length matching precisely on the boot where the quirk must
apply: the kernel honors the spurious TX_FAULT and the SFP state
machine eventually disables the module. Match its part as a prefix
using SFP_QUIRK_F_PREFIX.

The XGS-SFP-ONT-MACI PN is the product name (XGS-SFP-ONT-MAC-I)
truncated at the 16-byte field width, so the field is fully occupied
by legitimate characters and a plain exact-match SFP_QUIRK_F entry is
correct.

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
---
 drivers/net/phy/sfp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 15033cbf7..2ec91466a 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -557,6 +557,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
+	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
+	// mask both signals and extend T_START_UP via the potron fixup. The
+	// PN is the product name (XGS-SFP-ONT-MAC-I) truncated at the 16-byte
+	// field width, so the field is fully occupied and matches exactly.
+	SFP_QUIRK_F("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
@@ -617,6 +624,14 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+
+	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
+	// LOS indicators and slow startup, just like potron. On cold
+	// power-up the EEPROM vendor PN field reads back with non-printable
+	// garbage past the legitimate string instead of space padding, so
+	// match the part as a prefix.
+	SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron),
+
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
-- 
2.47.3

