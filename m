Received: from srv5.3e8.eu (srv5.3e8.eu [94.16.113.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52173476079;
	Sun, 20 Sep 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.16.113.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933145; cv=none; b=k2y7HZ0+e/rInzfC/+OK2fu4lNIdvyAZZu7ByUIybcBG17HuQ7lVGeEf7ljQ/dKTxwpuc/Xmp1lLRIqrI2DqZpgQvwcy2r9vjrQFISMIEtuDdsg3DlhcQM3w12DK6GVkFjoaFqe6reziiP46sl0L9rhB+Gy9sTOzE7JyAN3D3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933145; c=relaxed/simple;
	bh=d98KwMOdSSS6/LbeZLUTqbaWIjeLwg0awjUjRtvVyV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebuDL3/A0oCzMfxdQY9FjWp1ZRHbBhXeNPWYhB3l6Xmi80Fjzz5vvT9lj2YvNaOZJGaTpxTRjo9DYj11C1M6aZU+vdLsv5k9/BIqhf/ZJWfzeS6sPxxHafVapmc5/jCUoIPFs6jbNpzFSWW4Tpi3CLzIdHmLq8U+OVQJz15gYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu; spf=pass smtp.mailfrom=3e8.eu; dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b=HbmYU/9b; arc=none smtp.client-ip=94.16.113.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=3e8.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3e8.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3e8.eu header.i=@3e8.eu header.b="HbmYU/9b"
Received: from jan-pc (p200300ed470838a07b81aa82380735d8.dip0.t-ipconnect.de [IPv6:2003:ed:4708:38a0:7b81:aa82:3807:35d8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by srv5.3e8.eu (Postfix) with ESMTPSA id 0E3AC120164;
	Sun, 20 Sep 2026 21:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu; s=mail20211217;
	t=1789932625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gS3OdTOABmGL12LA6Ch0K0Lgkvic+upjCgNAW0yqXJA=;
	b=HbmYU/9bRGSR787302LEycjZtVYOhOgX4K0gLK73lQQz5bcPohOj67JYp3rT4AVaJsHuRY
	gEuql3bYRcovdmFfF3IW8BlJlSUACI8NwftGns6KgQc/gbokvJAOR2haoTQ8Cd4/0vwS7N
	53114ES3QdATxEce/nIh62vekqKDHU5a/zDh224jotRcPR+d9AJ0ckyYjxkethGJfpuCJW
	oSSuZAarZgFQKHH+BnGWX+z0beTlyrz+/gh69F+8o6rjfqfwv+TXtFciRkHRaucsS/12ih
	ZdzvrLgUQaifyc7aO9i/zvh3DgNfXFY13HjhPsv/3VAz6J1rK6rB16Wn11uO6w==
From: Jan Hoffmann <jan@3e8.eu>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Hoffmann <jan@3e8.eu>
Subject: [PATCH net-next] net: sfp: add quirk for XikeStor SKT-2.5G-100M
Date: Sun, 20 Sep 2026 21:26:10 +0200
Message-ID: <20260920192632.72729-2-jan@3e8.eu>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This 2.5G copper SFP module contains a RTL8221B-VB-CG PHY which can be
accessed using Rollball protocol.

Add a SFP quirk to enable Rollball protocol. It includes a small delay
to avoid unnecessary attempts at reading PHY registers before the
module is ready.

Note: The RTL8221B PHY in this module becomes stuck in a broken state
after attempting to read some registers on MMD 30 while it has already
established a link (this is a general issue with this PHY which happens
when it is configured for rate adaptation mode). This includes the
registers 2/3/8 which are read by "get_phy_c45_ids" during PHY probing.
However, the PHY takes about 4 seconds to establish a link after reset,
so in practice any host that supports TX_DISABLE should be unaffected,
as that puts the PHY into reset.

Signed-off-by: Jan Hoffmann <jan@3e8.eu>
---
 drivers/net/phy/sfp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 2ec91466acdf..6bbb02117217 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -432,6 +432,19 @@ static void sfp_fixup_rollball_wait4s(struct sfp *sfp)
 	sfp->module_t_wait = msecs_to_jiffies(4000);
 }
 
+static void sfp_fixup_xikestor_2_5g(struct sfp *sfp)
+{
+	sfp_fixup_rollball(sfp);
+
+	/* This module does not immediately respond to Rollball commands. Add
+	 * a small delay to avoid unnecessary PHY access attempts. Note that
+	 * the delay should not be too long, as the RTL8221B-VB-CG PHY inside
+	 * breaks when reading some registers from MMD 30 if it has already
+	 * established a link (which takes about 4 seconds after reset).
+	 */
+	sfp->module_t_wait = msecs_to_jiffies(1000);
+}
+
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
@@ -636,6 +649,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
 
+	SFP_QUIRK_F("XikeStor", "SKT-2.5G-100M", sfp_fixup_xikestor_2_5g),
+
 	SFP_QUIRK_S("ZOERAX", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 };
 
-- 
2.55.0

