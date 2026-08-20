Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C43BE647
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257762; cv=none; b=pS9uriN1WgxyKrbKyvitUx/mdy6n/cus0eKg46Jk5NM+LQSpPRm/M1i0FA08xPZYvIf2qzIi67xsIqr5/agAbkkSnP14pC/7NauC0UOaqRstO8r0LKiEix2lU8MLzvipVoTtJO28/cLw/59cCMwEOvRchZn2iN/7sUAWVKMxbw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257762; c=relaxed/simple;
	bh=dXd204VjWEYCJCmib8LkNYSXH8VTQgeij3MMEHfYjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cB0n0Nz/fZOGPJl6jlfcEbHbYmguKWxfcSaMI1KTpKInzBE2qACF5h7m+hgc7+HQ4YufnbteIYVdC0oVN8WCrRfFv/2v/k52aQVl7XnnBnhud6IR5LRVcUIMs8LwaNQqybzSWRzGaCrsL/XjubfRURWq9fqMgEQnzTg2o2TuYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyWEJGmd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyWEJGmd"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso37918866b.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787257757; x=1787862557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGoy2n51LwvoRDVHhiJ0uQW/YIqwhoXjWTQlpvrOKkA=;
        b=PyWEJGmdXhzkh6OTJa7L4SjkwqQfDxodUxhqDjDU684+aEnYoeaoNdgf6LWM68jiLF
         QlfyQgJ4W1xaXxytKZqIGkpin4wefVzN6d6Sm97rUM0v3k6MJda2/JFo/JjQoHHLXqJP
         E0o3qGE8Lcpkq1xBqxZnod/Yqf2CnagxhePVrdWWO1WMHIEQnKUmL3sB8dS+wvcqZhln
         sWEus8wQ0vjzlEhsSxvu8PWRwtdvcNKZTIhI3AYBIuIn356KcEWQ9Irthn2EHkTQCtg5
         6AAe2fW0kjXkFMpCn2y/pu7WvA0DkEGCLsxlU37TMxhlj4v6Y6BXFT7OxAE+jyWxmPAh
         x9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787257757; x=1787862557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGoy2n51LwvoRDVHhiJ0uQW/YIqwhoXjWTQlpvrOKkA=;
        b=CFmEtMLNTO37xcogAjNGOYkW1rPny8OaBTd4vu5Daobmls1lPvQd8hP/F78wlUpvUr
         6OM69hPYSQtT2Idkq7O+Kew4Ln7Op6O4krxmbIe5bSO1086fXzKSP9JFqB4CuV8Du014
         fXiBhylIAoeQcLn7toaJOngMn9ab7wybvz/vtzLEnLWdF8x4HUA9/eNPcqsK0sUO8sgn
         yigP84aq3sjCwZ0BPxGWIsSINXaRXfF4gxPMslaXIVQqSYyEuXvQvXK/Eogq8Yc2g2zG
         oAO8sFPmLUOv4kxP/UyW9lwDocWaiV7I29r9hEPgZmYZsUvXi5ct7qtr+hO5qIqgTMCs
         uYfA==
X-Gm-Message-State: AOJu0YxmUjhgU97OZJnn9H5zNJxi6w0i3alsIck+rLeLXkmkBOUS9cz+
	lL/Hur4f5Vj9JemQUBHr87v0BAgds1AY2/IV5FdUiacRDDWVFpOGiwvjG86JkSKJzDsC
X-Gm-Gg: AR+sD11UWAy6Bb9dkMgJ7VwdTduFw9sZNfd2fKPaTcToEBAtNn39AEx55BI5oK8H8+O
	aCNjG53gbXY816vjiQxvn1wLwargnJDNFLwoJluNLrKt3WgQ1v6gZgoioatSNqXnSFqZpg5q0im
	q6feVyYqdRkE4wMepgXbkN6Tgjufl9nne2fca2Dp8GQt1C72vOLS5ddKuKtHsaKRMcDzTN2TCeG
	Uqd/hibO0QxV9RwotrIWpNc5M712VWN+Ew3clGWr+3FsVrc5GjatO3dgQZtqFiL0eEbGAjqVvYq
	lyKiE4331G7yWhlQPDJX0Z47/aT4P0xF26YRkSS3wjeYAfWC72jq2M1VrooFrbKNM1B+bln0cUJ
	veFg7YwqHxCi9g2stEN8+1/HeeErTb/3VD1FfQL5JqHCfbHv6Iz9HIO0CFy58hV31feqBLsbl5c
	3zr7FvpJ1PUeazcahW4jAl/7XJ5PYraku5uB+1xv6t2NiiyqEzCeHHkvrOSXVR9968S19i
X-Received: by 2002:a17:907:6094:b0:c1f:9c3b:96a7 with SMTP id a640c23a62f3a-c246a6269d2mr95089666b.17.1787257757256;
        Thu, 20 Aug 2026 13:29:17 -0700 (PDT)
Received: from i-UX410UAR.lan ([2a02:2168:87cb:3900:b204:3af:b369:d1c3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df622sm133458066b.46.2026.08.20.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 13:29:16 -0700 (PDT)
From: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	yangshiji66@outlook.com,
	Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Subject: [PATCH net v2] net: dsa: mt7530: do not advertise EEE on MT7621/MT7530 switch
Date: Thu, 20 Aug 2026 23:28:44 +0300
Message-ID: <20260820202844.1821687-1-vladislav.karmanov.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiji Yang <yangshiji66@outlook.com>

There are hardware defects in the MT7530 internal GE PHY EEE support:
with EEE advertised, some link partners cannot establish a stable
connection. On a 2-pair (4-wire) cable where both ends advertise gigabit,
1000BASE-T training cannot succeed, and instead of falling back to
100 Mbps the port flaps in a loop and no link/DHCP lease is obtained.
This is confined to the WAN / phylib bring-up path; the DSA/LAN side on
the same device is unaffected.

The MT7530 internal GE PHY advertises EEE by hardware default. The
eee-broken-100tx / eee-broken-1000t device-tree properties only take
effect during the late PHY config_init path, which is too late for these
link partners: they negotiate EEE before the OS disables it and then
fail to fall back cleanly.

Commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
advertisement") removed the early EEE-advertisement disable from
mtk_gephy_config_init(), on the rationale that "disabling EEE
advertisement before the PHY driver initialises keeps it off", i.e. that
the DSA subdriver already performs that early disable. That rationale
holds for MT7531, whose mt7531_setup() clears MDIO_AN_EEE_ADV on each
switch PHY, but not for MT7621 (and the dedicated MT7530 IC), whose
mt7530_setup() never had such a loop. So af3b4b0e59de removed the only
early EEE disable covering MT7621/MT7530, reintroducing the flapping.

Regarding the MAC-vs-PHY question: the broken hardware is the PHY (the
MT7530 internal GE PHY, PHY ID 0x03a29412, driven by mediatek-ge), and
MediaTek's own recommendation (Landen Chao, 2021) confirms it: "EEE of
the 10-year-old MT7530 internal gephy has many IOT problems, so it is
recommended to disable its EEE." However, the disable belongs on the
DSA side, not in the PHY driver: af3b4b0e59de itself established that
the PHY-driver-side disable "is somehow enabled afterwards" (it does
not stick), whereas the early disable done in the DSA setup path is what
keeps EEE off -- which is exactly why MT7531 does it in mt7531_setup()
and why af3b4b0e59de considered the mtk-ge disable redundant for MT7531.

Restore the early disable for the affected silicon by clearing
MDIO_AN_EEE_ADV on each switch PHY in mt7530_setup(), gated on a new
`broken_eee` flag in struct mt753x_info rather than an open-coded ID
check, mirroring the existing mt7531_setup() loop. Set broken_eee for
ID_MT7621 and ID_MT7530, which share the same mt7530_setup() and the
same internal GE PHY. Auto-negotiation then falls back to a stable
100 Mbps link instead of hanging at gigabit.

Tested on ASUS RT-AX53U (MT7621): a single clean
"Link is Up - 100Mbps/Full - flow control off" + DHCP lease on a 2-pair
cable, where the unpatched driver loops. Confirmed on kernel 6.12 and
6.18; also confirmed on Netgear R6220 and EdgeRouter-X (both MT7621).

Fixes: af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE advertisement")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
---
Changes in v2:
- Gate the disable on a new `broken_eee` flag in struct mt753x_info
  instead of an open-coded priv->id == ID_MT7621 check, so it is easy to
  extend to further affected silicon (suggested by Daniel Golle).
- Cover ID_MT7530 (the dedicated MT7530 IC, e.g. BananaPi R2) in addition
  to ID_MT7621: both share mt7530_setup() and the same internal GE PHY
  (suggested by Daniel Golle).
- Address the MAC-vs-PHY placement question in the commit message: the
  broken hardware is the PHY, but the disable belongs on the DSA side
  because af3b4b0e59de showed the PHY-driver-side disable does not stick
  (question by Andrew Lunn).

v1: https://lore.kernel.org/netdev/20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com/

 drivers/net/dsa/mt7530.c | 11 +++++++++++
 drivers/net/dsa/mt7530.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2a70fa4..cab46c6 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2446,6 +2446,15 @@ mt7530_setup(struct dsa_switch *ds)
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
 
+	if (priv->info->broken_eee) {
+		/* Disable EEE advertisement on the switch PHYs. */
+		for (i = MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
+		     i < MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr) + MT7530_NUM_PHYS;
+		     i++) {
+			mt7530_phy_write_c45(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+		}
+	}
+
 	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
@@ -3298,6 +3307,7 @@ static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
 const struct mt753x_info mt753x_table[] = {
 	[ID_MT7621] = {
 		.id = ID_MT7621,
+		.broken_eee = true,
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7530_setup,
 		.phy_read_c22 = mt7530_phy_read_c22,
@@ -3309,6 +3319,7 @@ const struct mt753x_info mt753x_table[] = {
 	},
 	[ID_MT7530] = {
 		.id = ID_MT7530,
+		.broken_eee = true,
 		.pcs_ops = &mt7530_pcs_ops,
 		.sw_setup = mt7530_setup,
 		.phy_read_c22 = mt7530_phy_read_c22,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 7e47cd9..fff310f 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -851,6 +851,7 @@ struct mt753x_info {
 	void (*mac_port_config)(struct dsa_switch *ds, int port,
 				unsigned int mode,
 				phy_interface_t interface);
+	bool broken_eee;
 };
 
 /* struct mt7530_priv -	This is the main data structure for holding the state
-- 
2.43.0

