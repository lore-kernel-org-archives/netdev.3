Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2513FF1BB
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154039; cv=none; b=nE0x0YkTN+03Oo+ugK3qBP7p0D9aDttTFg0RH6TxAdIlLBYsC4nlUqOQoCzKaIk6n8ndLIWMPyaMD/XC8y62gGv8KDrkYlPOglBiUnwiIRyRWssIhzPET9bPre8d2KxF1x9hv4SXGSSOG50RvrL2R9+1ECq4IfFrwmNHg6kx+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154039; c=relaxed/simple;
	bh=eT2a6qket3zr+xMCwVPOMDGzAEf627qZ0dG3Xsua9YY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Jegp79I33t3hruGy8EnNJwgHWCfl/A0K4LKTg7zurBiW+/yh/fFj4vcSevwegwJnCx8dnum4G8JW/FDuQHlTcsZwmNLdC3yJPruuxIkt5TN2U+mOy995LNR+04zehVm6dt3G4CTUTsQf2utmIEuyBVjUUMs2h8GWabfqHZ9ZTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjBva1XP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjBva1XP"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso404925b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785154035; x=1785758835; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIw+cOF+jRX3nkh6neZHJ3ZXms9UEu4kIGlmRAilHSI=;
        b=TjBva1XPy37F8igu8yB0rtRmhBIEYEJ8CyPk9at1M4WT5YjYcCYKQkwu/RaElZ7rj1
         ykQ5vIuSncw5VC9c0qsHx0OO98gV8ibUpX7AztJJMr35uxlzcgsGVn+g2A5fL1Lujqg7
         MHCdKRutX+rOji9Cv2lITh+dvOj3Zrrd/JTONRzuIfdR/oAC5sURFYzX4w+0hcMn1ZAJ
         JAYzkkhK9yL1ShGbDEJQZHUmVdVrAd7wNEKF0+G/v5X4TQ3CetldjvJSnAyAQP1LgP1T
         NJG/sR8eNR6t0o1k2sm7y0g06fP3ZH7W5ubDBB48gs++eyhKWJkLYKEYP64QU9CbsKzO
         TCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154035; x=1785758835;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oIw+cOF+jRX3nkh6neZHJ3ZXms9UEu4kIGlmRAilHSI=;
        b=tBQAKWZzkoMq1c9+Q2p3ReafFy6fD0VAp4kzCOaEsHkjmXcNQcg6qVwxzkGqVDHdS3
         XQ/saYihr54RoELCuThAdJlsTtBC/bcv12F46TPFizSlO+3KLXvkWIX+u26qCI7+5X+6
         Kp+gRDJvm29lxLJlaXZXQGwP0hF4IfrBfnTP0p5ub1ynHzX748nZRpJ2VNycI0E1jvFC
         xDqjXi4PP40Vcy30Tv9mkpP3utfbqQAkHqKaqr2f6GsnOTinfw78edFj8srVRs1zorN+
         6j3pNNT33bCzoWTh6CjqI5aJ4sNW+xpa6fY027VA3tUgCAMMtrUjgKaYMC7RCQ+SPmaK
         DKiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaRMYRCu9u+vc64tVZi7SBsJ3n1v9EnTVKP12AYZe3O6IIvCv8I32flxf9o+jP1Spq78bswsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DudBFB9foLrdp5G1CcOwqLHGOhjJ/YUEQcfL6RunYidrZ0tA
	OVT7pczTguYvRDT+qt1acY6gGOCNRoq7S8+G/M5wNIO31ZDXX43hNxmy
X-Gm-Gg: AR+sD13f+CgamkAIpwhUGX/SDcnuWQ84rLYgUXXFBhNFdg22TjtD930ZEUPrYBwTafR
	+FXLAKqk5VkQclj1B47qX6SxAscpu3K/d6J0c3xGuVu0gIOhsHvQt+v/wMRVBAL7ZYdh2cykmmZ
	DEW4DcrzXkEWuFEqD0OiSvZDSJuHYInJX7SSFDazHqt0FdH26u+aQ/RwgV3S0E6640kvSaaEiDF
	dvvY8D7OVvtySvkdYsx3WYOrtunWpRu87kkbApKSvNyDeWHzEN6BOsd8nqP7gcxJy/F89WspGIL
	DMNLkJeUR/UNiMzEBT2u7qg12/fk5ZTdD2or1ghZC+KQFhdNV7Bbr2kOqLAyBW6DFrGWMzDKb1Q
	dRnZHwHp/BKt0wyzEw182Kqo3X4D7POl9+Vfep+3c38HXY0EhQP/6Wv+zMNCIMwMiO2RMsMURgU
	XW
X-Received: by 2002:a05:6a00:928f:b0:842:446a:4cb5 with SMTP id d2e1a72fcca58-84e4df6f4dbmr7705050b3a.0.1785154035317;
        Mon, 27 Jul 2026 05:07:15 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533d1637sm2935168b3a.33.2026.07.27.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:07:14 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: andrew+netdev@lunn.ch,
	rmk+kernel@armlinux.org.uk,
	alexandre.torgue@foss.st.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	mcoquelin.stm32@gmail.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: [PATCH net-next v2] net: phylink: add phylink_pcs_loopback() method for PCS loopback support
Date: Mon, 27 Jul 2026 20:07:04 +0800
Message-Id: <20260727120704.2319467-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some Ethernet MAC drivers (such as stmmac) need to perform PCS-level
loopback for selftest purposes when no external PHY is present. Add a
new phylink_pcs_loopback() method that allows MAC drivers to request
PCS loopback mode through the phylink framework.

Implement the pcs_loopback callback in the stmmac integrated PCS
using the GMAC_AN_CTRL_ELE register bit. Add a helper function
stmmac_selftest_get_pcs() in stmmac selftests to unify PCS lookup
across glue driver PCS and integrated PCS. Update the selftest
enable/disable paths to use the new helper.

Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 17 +++++++
 .../stmicro/stmmac/stmmac_selftests.c         | 51 ++++++++++++++++---
 drivers/net/phy/phylink.c                     | 19 +++++++
 include/linux/phylink.h                       | 16 ++++++
 4 files changed, 95 insertions(+), 8 deletions(-)

v2:
  - Implement pcs_loopback callback in stmmac integrated PCS using
    GMAC_AN_CTRL_ELE register bit.
  - Add stmmac_selftest_get_pcs() helper to unify PCS lookup across glue
    driver PCS and integrated PCS.
  - Add NULL check in phylink_pcs_loopback() wrapper.
v1: https://lore.kernel.org/netdev/20260724085224.3321663-1-zxyan0222@gmail.com/

Note on loopback direction:
The pcs_loopback callback uses a simple enable/disable boolean, matching
the existing phy_loopback() API. Direction is not needed at this level:
selftest loopback is always host-side (TX looped back to RX). The
future ethtool user-space loopback API can handle direction selection
at a higher layer.

Note on phylink_set_loopback() vs phylink_pcs_loopback():
This patch follows the same pattern as phy_loopback() - a direct
callback on the PCS object. Keeping the API minimal avoids introducing
a new phylink-level loopback abstraction with location enumeration
before Björn's ethtool loopback series lands upstream. Once that
series is merged, phylink_pcs_loopback() can serve as a building block
for a higher-level phylink_set_loopback() if needed.

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index df37af5ab837..90a21a2f7e87 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -168,6 +168,22 @@ static void dwmac_integrated_pcs_an_restart(struct phylink_pcs *pcs)
 	}
 }
 
+static int dwmac_integrated_pcs_loopback(struct phylink_pcs *pcs, bool enable)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	void __iomem *an_control = spcs->base + GMAC_AN_CTRL(0);
+	u32 ctrl;
+
+	ctrl = readl(an_control);
+	if (enable)
+		ctrl |= GMAC_AN_CTRL_ELE;
+	else
+		ctrl &= ~GMAC_AN_CTRL_ELE;
+	writel(ctrl, an_control);
+
+	return 0;
+}
+
 static const struct phylink_pcs_ops dwmac_integrated_pcs_ops = {
 	.pcs_inband_caps = dwmac_integrated_pcs_inband_caps,
 	.pcs_enable = dwmac_integrated_pcs_enable,
@@ -175,6 +191,7 @@ static const struct phylink_pcs_ops dwmac_integrated_pcs_ops = {
 	.pcs_get_state = dwmac_integrated_pcs_get_state,
 	.pcs_config = dwmac_integrated_pcs_config,
 	.pcs_an_restart = dwmac_integrated_pcs_an_restart,
+	.pcs_loopback = dwmac_integrated_pcs_loopback,
 };
 
 void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 29e824bd90ca..77a457b2fa5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -19,6 +19,7 @@
 #include <net/udp.h>
 #include <net/tc_act/tc_gact.h>
 #include "stmmac.h"
+#include "stmmac_pcs.h"
 
 struct stmmachdr {
 	__be32 version;
@@ -374,23 +375,51 @@ static int stmmac_test_mac_loopback(struct stmmac_priv *priv)
 	return __stmmac_test_loopback(priv, &attr);
 }
 
+static struct phylink_pcs *stmmac_selftest_get_pcs(struct stmmac_priv *priv)
+{
+	/* Try glue driver's PCS first, then the integrated PCS. */
+	if (priv->hw->phylink_pcs)
+		return priv->hw->phylink_pcs;
+
+	if (priv->integrated_pcs)
+		return &priv->integrated_pcs->pcs;
+
+	return NULL;
+}
+
 static int stmmac_test_phy_loopback(struct stmmac_priv *priv)
 {
 	struct stmmac_packet_attrs attr = { };
+	struct phylink_pcs *pcs;
 	int ret;
 
-	if (!priv->dev->phydev)
-		return -EOPNOTSUPP;
+	if (priv->dev->phydev) {
+		ret = phy_loopback(priv->dev->phydev, true, 0);
+		if (ret)
+			return ret;
 
-	ret = phy_loopback(priv->dev->phydev, true, 0);
-	if (ret)
+		attr.dst = priv->dev->dev_addr;
+		ret = __stmmac_test_loopback(priv, &attr);
+
+		phy_loopback(priv->dev->phydev, false, 0);
 		return ret;
+	}
 
-	attr.dst = priv->dev->dev_addr;
-	ret = __stmmac_test_loopback(priv, &attr);
+	/* Use PCS loopback for interfaces without an external PHY. */
+	pcs = stmmac_selftest_get_pcs(priv);
+	if (pcs) {
+		ret = phylink_pcs_loopback(pcs, true);
+		if (ret)
+			return ret;
 
-	phy_loopback(priv->dev->phydev, false, 0);
-	return ret;
+		attr.dst = priv->dev->dev_addr;
+		ret = __stmmac_test_loopback(priv, &attr);
+
+		phylink_pcs_loopback(pcs, false);
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static int stmmac_test_mmc(struct stmmac_priv *priv)
@@ -1986,6 +2015,9 @@ void stmmac_selftest_run(struct net_device *dev,
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
 				ret = phy_loopback(dev->phydev, true, 0);
+			else
+				ret = phylink_pcs_loopback(stmmac_selftest_get_pcs(priv),
+							   true);
 			if (!ret)
 				break;
 			fallthrough;
@@ -2019,6 +2051,9 @@ void stmmac_selftest_run(struct net_device *dev,
 			ret = -EOPNOTSUPP;
 			if (dev->phydev)
 				ret = phy_loopback(dev->phydev, false, 0);
+			else
+				ret = phylink_pcs_loopback(stmmac_selftest_get_pcs(priv),
+							   false);
 			if (!ret)
 				break;
 			fallthrough;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59dfe35afa54..69242caffaef 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -997,6 +997,25 @@ int phylink_pcs_pre_init(struct phylink *pl, struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL_GPL(phylink_pcs_pre_init);
 
+/**
+ * phylink_pcs_loopback() - Enable or disable loopback at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ * @enable: true to enable loopback, false to disable
+ *
+ * Enable or disable loopback mode at the PCS level. This is used by MAC
+ * drivers for selftest purposes when no external PHY is present.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int phylink_pcs_loopback(struct phylink_pcs *pcs, bool enable)
+{
+	if (pcs && pcs->ops->pcs_loopback)
+		return pcs->ops->pcs_loopback(pcs, enable);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(phylink_pcs_loopback);
+
 static void phylink_mac_config(struct phylink *pl,
 			       const struct phylink_link_state *state)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 2bc0db3d52ac..66c7016d4acd 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -518,6 +518,7 @@ struct phylink_pcs {
  *		    the MAC.
  * @pcs_pre_init: configure PCS components necessary for MAC hardware
  *                initialization e.g. RX clock for stmmac.
+ * @pcs_loopback: enable/disable loopback mode at the PCS.
  */
 struct phylink_pcs_ops {
 	int (*pcs_validate)(struct phylink_pcs *pcs, unsigned long *supported,
@@ -542,6 +543,7 @@ struct phylink_pcs_ops {
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
+	int (*pcs_loopback)(struct phylink_pcs *pcs, bool enable);
 };
 
 #if 0 /* For kernel-doc purposes only. */
@@ -717,8 +719,22 @@ void pcs_enable_eee(struct phylink_pcs *pcs);
  */
 int pcs_pre_init(struct phylink_pcs *pcs);
 
+/**
+ * pcs_loopback() - Enable or disable loopback at the PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ * @enable: true to enable loopback, false to disable
+ *
+ * Enable or disable loopback mode at the PCS level. This is used by MAC
+ * drivers for selftest purposes when no external PHY is present.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int pcs_loopback(struct phylink_pcs *pcs, bool enable);
+
 #endif
 
+int phylink_pcs_loopback(struct phylink_pcs *pcs, bool enable);
+
 struct phylink *phylink_create(struct phylink_config *,
 			       const struct fwnode_handle *,
 			       phy_interface_t,

base-commit: 1df10cef2d1e7f9f2fb7eddb67fc70d3abf101f9
-- 
2.34.1

