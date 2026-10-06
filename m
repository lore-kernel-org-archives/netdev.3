Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE32456E11
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318247; cv=none; b=ghtUPGfAuugvzWkvdxQrCEurIEyZ5DEOVsS+DlGRq3lYBZfFPBh2IxOyPDHNO9otABBl/QPIjPqPGHFJ3qAKRJ7BvOtt4yy24k5P/as6fCOzMU19BRsd6Wh4P3TY+WnD6/Y1GJht0heRyMVBSPpbjsocYrqOf1ItTFbiQJGqtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318247; c=relaxed/simple;
	bh=J/Lu3OQHoMqX8RH8EGFYizmZvLr2h7FE3KKLVrxf3hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZOlL4GViGBG6TZ6doyZLsEyNnIpKKjMeL6oS3GDfDUTvS02Rm9Ny9Z802WbwEa6ulc5jMH/Z5sERD7mZWQi/i8U8BDCw68itSsSCdKQ5cjg5S7gqmkNGgyrSwsnEyy1sBzWtS09tVneQsu0Fzt8jVMw5IWizzaaDe+X4jpZC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCu7T9N1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCu7T9N1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbee846deecso2431338a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791318245; x=1791923045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLwYfTdXyDPQuumFFWIFzFC4aHDNR/bZf79M03BhnEQ=;
        b=kCu7T9N1bughVeXg5leC6PEpd5NAjtFCuC4CTwp8Dqvr7Desnq4e7cCGw1oSBD0ypf
         sVjeRmSIWzZVGclHGHex7y3oF7t8swiamyTJgGpERk2c2A31uez54OoWjU3Cyt2R00tQ
         SDcxOTF2I9ONMEM3o8Z7yRkYiaeBJhe3iK2qiI9/iNg4GfOZILCv2wnCKERNpZ6U3OfR
         J3N0uRq8/bzgDi168C5jQ+hoSG8iRU/KrFPb42MUWZ+mjeNVydwGFuosgAIV65XqJddh
         ZBcDayOma2HQVRmDWwS3ZS1TyCN/I0A8xikxUxEHJPNpBgquLAW/HaffTvYxA2Q4VIjH
         O9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318245; x=1791923045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLwYfTdXyDPQuumFFWIFzFC4aHDNR/bZf79M03BhnEQ=;
        b=q8gZppECDoZAJW/PrVTc+D8sExPbPCz/xHYC0P2VCSkpzxp9APj6838R1dTTs8CxV+
         qkwQwPQUenl2tJKCvbP4fSBat8US6XxdAwCsQ2/2+5SJyxYRgw3A6vJYJwueZgdNle5v
         A0pKR0femPM0dLHRzgXzMhfdV3/1HHxJo0DBBzVMZonHkkN8x2QE+Inh567B8/u2f8wH
         uHB7UX/7YATQjsZ/x3zmV5MzPn6vdE9vPvHcJPMRB6cNSWBdorl6dB0iNMxIOavH2gSN
         FP7xGqSM5yRk5jY7GtE0U2zCmn1AlogWpc/PQ6vqcZSsGbWV2mbH2fo+WmnwggiJ6TSM
         LT3A==
X-Gm-Message-State: AFq9FYJ1t3DAcQ9dJY7McqiXU7ILzpGsa9iC+pFSAtcnwFzSP25XNQ7R
	G1Fquq2U4hvvjnwoyiOKTYgvuJLuhyTSAuK7B7TkIe/u/qWMxEg5TFETJ3czDeF4a2E=
X-Gm-Gg: AYBFou1u/sIm+1i7rxl3tIduDhMjnFXOC+6WVxEZiXjUuvP5bEQ9+of2+kTxwwhEv0C
	+U6YR8LMPFcObmDb9LnAo/z1j3D5vrySyZEitwVAPpHO6Dtr7dqfjicJKYgjmK5kaMxQLYC49ou
	tl20lBIFHVAR342hYVS3HmVNqHiqT+DqL5YyvxJRZTWjLLtr6c4P892NDB6Vw5kPjtdI+S0tOAv
	vuePT+QcsYIbWmH5JmhMIPr3taTo+d82yEBZCkDw3dVYHMRcu1dn1s2S3YCYjsJOthGM3TLVcsy
	/FLzDbnNo3PN+FEBqCSx78PY2gBbzHewLryCJqKAyHRfxNevUUEZ5NvmSZFniDtH16w89rVekbU
	GSRni4LQ2yzbF2wt4gqhj/LW6e5nigPblBUBxWjIJr3cpaWKlvHMGB4VVbuF3Bti4KM/HZb1aIw
	5EjZFSNjf4m4suBvrPihzJ3k/4Db+RuA2DNvtywnZINKlFX0mIWXonbp9atybdwKAs2VIouau5C
	LdWRrUZTh25/PbnzN0AWPjQOQ==
X-Received: by 2002:a17:90b:3943:b0:3a8:2c7e:8986 with SMTP id 98e67ed59e1d1-3a8a17f9e4cmr270135a91.17.1791318245012;
        Tue, 06 Oct 2026 13:24:05 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a92da735sm383218a12.17.2026.10.06.13.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 13:24:03 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: phy: motorcomm: Add driver entry for internal YT861x PHYs
Date: Wed,  7 Oct 2026 04:23:47 +0800
Message-ID: <20261006202352.1616626-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006202352.1616626-1-mmyangfl@gmail.com>
References: <20261006202352.1616626-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT921x switches integrate GbE PHYs of the YT861x family on the
switch-internal MDIO bus exposed by the yt921x DSA driver. Without a
specific driver they bind to the generic PHY driver. Add a driver entry
for them.

The PHY ID 0x01e04281 is live captured from the switch-internal MDIO
bus. The switch SerDes PCS does follow the pattern, 0x4f51e899, though.

Auto sleep can be disabled with the "motorcomm,auto-sleep-disabled"
device property, as with the other Motorcomm PHYs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/phy/Kconfig     |  3 ++-
 drivers/net/phy/motorcomm.c | 38 +++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

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
index 90a4f86f2758..3ebd911f4400 100644
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
@@ -3173,6 +3198,14 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_INT861X),
+		.name			= "Internal YT861x Gigabit Ethernet",
+		.config_init		= yt861x_config_init,
+		.soft_reset		= genphy_soft_reset,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
 		.name			= "YT8821 2.5Gbps PHY",
@@ -3194,7 +3227,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
 MODULE_LICENSE("GPL");
@@ -3205,6 +3238,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_INT861X) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
 	{ /* sentinel */ }
 };
-- 
2.53.0

