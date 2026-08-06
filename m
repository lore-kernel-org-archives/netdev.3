Received: from mail.mdapi.ch (mail.mdapi.ch [31.3.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034593E025C;
	Thu,  6 Aug 2026 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.3.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002734; cv=none; b=ApIfTIYfJoqAs5G6IjYuTBBpA7OC56Ggs8p6Y8Ao49mFGKT9zYeGQovCEcucJ3RNp+RRTqEHweU1vayk28sZIQ+gdYNGKoJzCZz62yJw5M+zWF5iv0uDXkguxFSGqB+vpp3uq57jXPwRjR7+X3yVlswEYnAhffPXTQfVp15eTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002734; c=relaxed/simple;
	bh=DmiNJr0sx2i2m8gMshQhabxmIEBn9TSZeZFjbP3sGxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyxQf+T9R0Nc0Iam+FbFl8hYWgpH2kB5oYxvMQVOmVKb9YJroksK3OQZc+N/cGCHZYfIU5KDngIyTYO7hi8qnpPAeeL/7VISqhvUUdU90+FTtQMks2JF3aTb3AXERM2mNYuRC9OJo/3kcubQO8Sjaq4LK/gGgKPmo14KSXZ94to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch; spf=pass smtp.mailfrom=tillo.ch; dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b=hVhZtSu5; arc=none smtp.client-ip=31.3.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tillo.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tillo.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tillo.ch header.i=@tillo.ch header.b="hVhZtSu5"
From: Martino Dell'Ambrogio <tillo@tillo.ch>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tillo.ch; s=mail202603;
	t=1786002190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfmahgUDVtODjXPaE88NZE5KdvDFwkzyTNm1j7tZ2a0=;
	b=hVhZtSu54MrqEgBpnLqF4Zv/fWBFmV+DQH3e+DxFxl2Kn4yB/lcdaLqDfHr0azJH+ZHgwt
	qivWhPeg8Zh9W6mXyf8cHhiwtvEKyIjfolREULNzzSoz+BP9OaPRrOTOHCdR330C/1KZTR
	rfD0f2hx6M4ulUQpr72K/ZmGlzE49kZk2y6GKXMuO0CUoTfBqDepM+4+UAVQlLTsq0N5o+
	vpjN4bHp6LnG5Szs870xYCjpjE9LDkDfzL8mwRQtD/9G/WQ/v5QoDiilJZ264Ie5JGU+dD
	MGS90ARaBTriXeEKKypEf03BWR71wCMfRVGpX/gmApQnOHC05wKlW/APELiL0g==
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
Subject: [PATCH net-next v2 2/2] net: sfp: add quirks for OEM XGSPONST2001 and FS XGS-SFP-ONT-MACI
Date: Thu,  6 Aug 2026 09:43:08 +0200
Message-ID: <20260806074308.1996917-3-tillo@tillo.ch>
In-Reply-To: <20260806074308.1996917-1-tillo@tillo.ch>
References: <20260806074308.1996917-1-tillo@tillo.ch>
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

Both modules fail to space-pad the EEPROM vendor PN field past the
legitimate string as SFF-8472 mandates (the XGSPONST2001 fills it with
non-printable garbage), which defeats exact-length matching:
sfp_strlen() cannot trim the field, so a plain SFP_QUIRK_F entry would
silently never apply and the kernel would honor the spurious TX_FAULT
and eventually disable the module. Match both entries as prefixes
using SFP_QUIRK_F_PREFIX.

Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index dfb2b88..4d8219e 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -556,6 +556,13 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault),
 
+	// Fiberstore XGS-SFP-ONT-MACI is a MAC-mode XGS-PON ONT stick with
+	// ONT-class serial-passthrough TX_FAULT/LOS wiring and slow startup;
+	// mask both signals and extend T_START_UP via the potron fixup. The
+	// EEPROM vendor PN field is not space-padded past the legitimate
+	// string, so match it as a prefix.
+	SFP_QUIRK_F_PREFIX("FS", "XGS-SFP-ONT-MACI", sfp_fixup_potron),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
@@ -616,6 +623,14 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
+
+	// OEM XGSPONST2001 is an XGS-PON ONT stick with broken TX_FAULT and
+	// LOS indicators and slow startup, just like potron. The EEPROM
+	// vendor PN field is filled with non-printable garbage past the
+	// legitimate string instead of space padding, so match it as a
+	// prefix.
+	SFP_QUIRK_F_PREFIX("OEM", "XGSPONST2001", sfp_fixup_potron),
+
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
-- 
2.47.3

