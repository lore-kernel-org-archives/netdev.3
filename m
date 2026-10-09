Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45D4F30C2
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791568803; cv=none; b=dFekwq3Ve1cW3ffL2cJ1XckiitjwMZG8X+APFNI14Rly1X7yxP2x0NB+XKxUHrCYvjhXOsIbVsK1ttXZRvLelxjNCgHRJcooWR5LtFKajWmWYYbL0BxgN5mBV89MJgbtzLwe2RR4DHzJ2v67eFNxEvUD2nT+KPKjCKEopshiUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791568803; c=relaxed/simple;
	bh=Gti7K1/QhSFZ+eoHXW5S9feHyQSr76WRiZbHs3IHiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoviADvdYvKX0fAwBexQcWNc4HFt2CFqlYrgep26798Xi9iO6fn8a7Nozjz2RnienRNaWCZ4U84J1WfM2FBw+IcnOZAsGdQJ951wuwZEO8u4pYieJ/ump1EBDE7hE2AngSWxfZBILkHxyQUnDbAGjRt9mPZZXAVehCjbcEgQl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZXClu4B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZXClu4B"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd76b1361dso44113285ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791568800; x=1792173600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvJvV0aRiulY6uBfalnUL+2S3Yp/YxHHNwR6ZIhHX3M=;
        b=CZXClu4BhIRDHZQx0u5Owf273gdg82RSyVaX4XTrnqWXuscNhRCiPMGQ+CsK26egPq
         ukS4gv1pYLedlevClDjwsa+9Liqqwd0W6sxgtxwCe8TbJKptYXPydooa2hVdp3wlkJZj
         1ilN+C8rgh5dETYVpsAAAQVKwWHe4Zlbg1ztDzcamBv8WtV2tlaRHEEzN+f0U815mfUx
         HyGBd68emKevW8nthP3XMIYSltSsPtJa6cm2lUR1viMRltP83fSRa2QpSwNCvhRHvWFt
         dseoa2v0ol1ARTm+AiVL3d81A1w0rjUteMmtzxSBciuaYXGPxCn/XwVWcKvWkOrMGKT/
         KQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791568800; x=1792173600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvJvV0aRiulY6uBfalnUL+2S3Yp/YxHHNwR6ZIhHX3M=;
        b=DwfORrTHNMq+qx5dAuCb0NBevWWzUE8VRX0hW9yOI56BK9mKp9jVp5nP3m+GwjynnW
         XH7AWmpAfLHyQoltkAo0l5l+ViWDMMzn8OLWjABjOq3jHZmq/aH3Iw8QoOcXYRWR2458
         yxB9wqdY1LkSvAI5smrtck4HxMPUJYArAKexQRb++6X/iGC2StHpQNLBmOx9HpwW0ToL
         bpRFE0pHonUqbxwJE3oQlMhNw4aRg9jsNgvTZMuShNvrcRKpJqBriVNYTfWjie3B+lhD
         2keaH/WADXBYEIf7/1IsAVigDa05kiLz1g5sDMGucncy0ZSmnxJeE88TYjOjHhsfB2yf
         6TYw==
X-Gm-Message-State: AFq9FYJ3Mq28mHsjYyIzx4yJIAM+5HXG17BV0vZFyF9Ykyo4SsoVk01C
	R3WkKpOdnC7AQ+2Etw/UzwRk0uD//XNQT/kBLrZojWCCW88L3dUP2eoB9AKwp9Ui
X-Gm-Gg: AYBFou3zRS+kJsFoJCHDea6uOC/+0MBiUMCezuS+ED+ihLJIEEyQHTUtaPrm+lZ9O3V
	yTvA3YpJy6D3WEW4TobtFMXo0EqcCb3HAsEvEYxpQCLVk545MvxuMLOgi8tBqpaMS6hCSb72Gl7
	wJrROUQe/JdxANFeExGymUzl3CG9UYf6PwjRwWfEetko3HAsKLVQI8TD5ALpbqTLyyylnm61JJo
	LwsY9HH7AJwh0cQFrF6KE8v7Pp2On84CirPo2jDwiAQXcnUZrdIh7WJvlygnPQtOjvV2GkgznmQ
	VrZYdKGDxuWtfZpGaH5ajD74DiJuCM0S71h6oBj8jxjIiMegzNIjILBmwQLgzvE5WfS0TnzpKYy
	q4d8yQOAqJkHJgZB+1bcZSxos6xi88xJ5kunBJswezbN4qaXQzbXmYzCYc0GQnDKIIReUuWrYOg
	lffcf4iuNooFGTx6l9s8IhPSbjzinqxngn2+5zyTjcLjGw/95gUzcx2wqSxHgPQkLUf31Mum2P8
	5DtsIY73ZI0FuWquqPyK19ldQ==
X-Received: by 2002:a17:902:ccd1:b0:2e5:a350:34f5 with SMTP id d9443c01a7336-2e842dfe6c1mr25314525ad.51.1791568799559;
        Fri, 09 Oct 2026 10:59:59 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e74asm14167105ad.29.2026.10.09.10.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:59:56 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: phy: motorcomm: Add driver entry for internal YT861x PHYs
Date: Sat, 10 Oct 2026 01:59:31 +0800
Message-ID: <20261009175936.428256-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009175936.428256-1-mmyangfl@gmail.com>
References: <20261009175936.428256-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT921x switches integrate GbE PHYs of the YT861x family on the
switch-internal MDIO bus exposed by the yt921x DSA driver. Add a driver
entry for them.

The PHY ID 0x01e04281 is live captured from the switch-internal MDIO
bus. The switch SerDes PCS does follow the pattern, 0x4f51e899, though.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig     |  3 ++-
 drivers/net/phy/motorcomm.c | 39 +++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d3835597e379..30e9d22c8d1a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -363,7 +363,8 @@ config MOTORCOMM_PHY
 	tristate "Motorcomm PHYs"
 	help
 	  Enables support for Motorcomm network PHYs.
-	  Currently supports YT85xx Gigabit Ethernet PHYs.
+	  Currently supports YT85xx Gigabit Ethernet PHYs, YT861x PHYs
+	  integrated in YT921x switches, and YT8821 2.5Gbps PHYs.
 
 config NATIONAL_PHY
 	tristate "National Semiconductor PHYs"
diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 90a4f86f2758..7078c4a0225d 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/861x/8821 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -18,6 +18,8 @@
 #define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
+/* Live captured from YT921x switch internal MDIO bus */
+#define PHY_ID_INT861X		0x01e04281
 #define PHY_ID_YT8821		0x4f51ea19
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
@@ -2538,6 +2540,29 @@ static int yt8521_get_features(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * yt861x_config_init() - apply the auto sleep setting to the PHY
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Auto sleep is enabled by default and a BMCR soft reset does not restore it,
+ * so apply the setting from config_init. It can be disabled with the
+ * "motorcomm,auto-sleep-disabled" device property.
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt861x_config_init(struct phy_device *phydev)
+{
+	bool sleep;
+
+	sleep = !device_property_read_bool(&phydev->mdio.dev,
+					   "motorcomm,auto-sleep-disabled");
+
+	return ytphy_modify_ext_with_lock(phydev,
+					 YT8521_EXTREG_SLEEP_CONTROL1_REG,
+					 YT8521_ESC1R_SLEEP_SW,
+					 sleep ? YT8521_ESC1R_SLEEP_SW : 0);
+}
+
 /**
  * yt8821_get_features - read mmd register to get 2.5G capability
  * @phydev: target phy_device struct
@@ -3173,6 +3198,15 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_INT861X),
+		.name			= "YT861x Internal Gigabit Ethernet",
+		.flags			= PHY_IS_INTERNAL,
+		.config_init		= yt861x_config_init,
+		.soft_reset		= genphy_soft_reset,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
 		.name			= "YT8821 2.5Gbps PHY",
@@ -3194,7 +3228,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
 MODULE_LICENSE("GPL");
@@ -3205,6 +3239,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_INT861X) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
 	{ /* sentinel */ }
 };
-- 
2.53.0

