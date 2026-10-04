Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99014756CB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791139375; cv=none; b=GPfLQ2852qIiVY9WfvGprel1OhDgxRn+z4UYoucJZnpOtRGD4kpTH3X8Ny6WWBlFKXkMA4SaP3gPy9ZcCHxJR2OmFpcIHXRsNfZTkjvfFyGCEgYUatQuD9SOd4ihBKreSmplAlgBq94EPyfO4pjjTzcgW5KfKxXYurSiAR277lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791139375; c=relaxed/simple;
	bh=c8QqcgF7ocZMljqDs1R3TUAV/GbB+QI1ABTrXNU4zfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jW8VoEvBTgU6SQYfN/wVYaNtNYCAB54eQRwIh8w28DUjMpdkGBsaDpSTujEhwHoaiA1WuL2s9BX6NWF9Cq72FVRg9Ju0fuKS907gjLneSt1nFLpAM6/vQArsrKndsDyj2sM0BnmgpKVTcz5uBKd26x0yJJ+66aj4D3xwgcfP0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKj7RbsF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKj7RbsF"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7bf792424so440494a91.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791139373; x=1791744173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri7RfvF5jW6amKjaENZTiBgapNpPsH0K5fFWNQhIJFY=;
        b=qKj7RbsF8f9ibw+K+eXZB7gHtqoqoTfQ++wlJl/ubjcHcEBTDjJmdsDf2NMgZeov0r
         19TzLQkJ8ou6k+/C+csSwQo+7NyP3m7TrsdEV+vpYnYyJruY7nGWkM+McI1PgastSj+e
         NakqemZSoOh3fZD1TED8xJ8Y5PHQBLFHb/c9NAVIVpeYoLfzfNxmN5iOzj1PT+PlvCPY
         6dTeOgIbXgPc/UlgNpv7J6+dR4VjmNoIVQ8XnJZRA2+PQL3U+em5Irj3G8iRS3T6g1JP
         EXl4nWOeRnQUxqozp8zeWlaC8sZ7c7Px7+99hPXV5jO2rYkWtnvIL3WiTcjatDSCjcis
         iLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791139373; x=1791744173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri7RfvF5jW6amKjaENZTiBgapNpPsH0K5fFWNQhIJFY=;
        b=LbhfEuGcxrINzsB3hyZvkdRa3+a2vG3wtWycSzklPTJaqZJYjhP2DsQk0q8sc5c3X9
         9Rr4HZbZN0fxC4Bo/7GAVuRj9dATgTDIoWnwz/V1rqoKmJEBCeGw99frWpBuB+6oCo8e
         CNW2n4uLr3tFyGS7lHlLYvrKWabOcdcSJndsNmHJ+cH8rIDN3f4+ewSGHEFbEEThZ7pU
         O70rM8/3LI1PXP1ZP4IWSWifXLsm4TXOWmhFL+jnt4fNFMv00zZ2FF26qb3Eh55cqwFl
         5plIG6lAUUMAS95O4oIbFYbRUDQl6kxqY5+cYMjvMZEo2pcB347Mcf0ZGxjkaAPI3uTt
         DJDQ==
X-Gm-Message-State: AFq9FYLWw/Rw3yfLMntjv2+68A5/ZduLTODmt0s+hciEcqZPU5MOQq0k
	FE03jLrA43sKcFsgg9ibRT7bWKld8OnigKk8fEsS5bL0UrP2F07BgnWmj7IvUG2iJjQ=
X-Gm-Gg: AYBFou1A/PwFWuGjJMVsl2PQiUQNyxyBdluAs0Y+wacNKMPrd8wWPwagQiad6wXVosN
	BYNd/SHk9ntHNk9pQjOC2AiWPC+C2FqJXOoPKxfmtjfwSp+5/JtG/USrCN3vMwenw/MqXSizuop
	3ATodolkpXwBz7qt/gXqPmQEhzdvVQPXnZtUiurJ5LjyWNOOEIoYaSuqCVhmtDewWyZkPKtLYoI
	3zzWnGSPJTgZ6//TL7czGPVm/OWVptQdMOkVl2iHk7MbsMBKBPUhtN1a1jA7hRSpbX3vOuO1M/9
	5NUXJYYgHVwaj3DjMxaeWcX5vpZNouUlo4NX8pveqjYFum65RK7qmMzzN5PPvn1jwp759CMbgEn
	WVtqAw80Mp5CBS9r1reBtREtYCFkbFTo1iKpy2qIfb0kTydjzgEaRiEAyhh49SFh5ZxmMbl9tDy
	e1CUPL5dAlOZeTX5k0Te82VpqCxP/iDM3ufmd1cD0XOCyGJn+pTdcgQadlY1DsE95UZivD1itYb
	LdSfvz7/rs4fi6c2v2d5I3Qtg==
X-Received: by 2002:a17:90b:388e:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-3a78673670bmr4239108a91.9.1791139372953;
        Sun, 04 Oct 2026 11:42:52 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b3ceasm7622579a91.10.2026.10.04.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:42:52 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: motorcomm: Add cable test support for internal YT861x PHYs
Date: Mon,  5 Oct 2026 02:42:43 +0800
Message-ID: <20261004184246.1260426-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YT921x switches integrate GbE PHYs of the YT861x family (PHY ID
0x01e04281) on the switch-internal MDIO bus exposed by the yt921x DSA
driver. Without a specific driver they bind to the generic PHY driver
and lack the cable diagnostic facility. Add a driver entry for them
with cable test support.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/phy/motorcomm.c | 119 +++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 90a4f86f2758..ef15fef304aa 100644
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
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -18,7 +19,9 @@
 #define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
+#define PHY_ID_INT861X		0x01e04281
 #define PHY_ID_YT8821		0x4f51ea19
+
 /* YT8521/YT8531S/YT8821 Register Overview
  *	UTP Register space	|	FIBER Register space
  *  ------------------------------------------------------------
@@ -298,6 +301,19 @@
 #define YT8531_SCR_CLK_SRC_REF_25M		4
 #define YT8531_SCR_CLK_SRC_SSC_25M		5
 
+/* TDR (cable diagnostic) test control */
+#define YT861X_TDR_CTRL_REG			0x80
+#define YT861X_TDR_CTRL_START			BIT(0)
+
+#define YT861X_TDR_STATUS_REG			0x84
+#define YT861X_TDR_STATUS_BUSY			BIT(15)
+#define YT861X_TDR_STATUS_PAIR_OK		0
+#define YT861X_TDR_STATUS_PAIR_UNKNOWN		1
+#define YT861X_TDR_STATUS_PAIR_SHORT		2
+#define YT861X_TDR_STATUS_PAIR_OPEN		3
+
+#define YT861X_TDR_PAIR_LENGTH_REG(n)		(0x87 + (n))	/* in cm */
+
 #define YT8821_SDS_EXT_CSR_CTRL_REG			0x23
 #define YT8821_SDS_EXT_CSR_VCO_LDO_EN			BIT(15)
 #define YT8821_SDS_EXT_CSR_VCO_BIAS_LPF_EN		BIT(8)
@@ -2538,6 +2554,95 @@ static int yt8521_get_features(struct phy_device *phydev)
 	return ret;
 }
 
+/**
+ * yt861x_cable_test_start() - start a cable diagnostic (TDR) test
+ * @phydev: a pointer to a &struct phy_device
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt861x_cable_test_start(struct phy_device *phydev)
+{
+	int ret;
+
+	/* auto sleep would abort the TDR test */
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8521_EXTREG_SLEEP_CONTROL1_REG,
+					 YT8521_ESC1R_SLEEP_SW, 0);
+	if (ret)
+		return ret;
+
+	return ytphy_write_ext_with_lock(phydev, YT861X_TDR_CTRL_REG,
+					 YT861X_TDR_CTRL_START);
+}
+
+/**
+ * yt861x_cable_test_get_status() - report cable diagnostic test results
+ * @phydev: a pointer to a &struct phy_device
+ * @finished: set to true when the test is complete
+ *
+ * Returns: 0 or negative errno code
+ */
+static int yt861x_cable_test_get_status(struct phy_device *phydev,
+					bool *finished)
+{
+	int ret;
+
+	*finished = false;
+
+	ret = ytphy_read_ext_with_lock(phydev, YT861X_TDR_STATUS_REG);
+	if (ret < 0)
+		return ret;
+
+	if (ret & YT861X_TDR_STATUS_BUSY)
+		return 0;
+
+	for (int pair = ETHTOOL_A_CABLE_PAIR_A; pair <= ETHTOOL_A_CABLE_PAIR_D;
+	     pair++) {
+		u8 code;
+
+		switch ((ret >> (2 * pair)) & 0x3) {
+		case YT861X_TDR_STATUS_PAIR_OK:
+			code = ETHTOOL_A_CABLE_RESULT_CODE_OK;
+			break;
+		case YT861X_TDR_STATUS_PAIR_SHORT:
+			code = ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
+			break;
+		case YT861X_TDR_STATUS_PAIR_OPEN:
+			code = ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
+			break;
+		default:
+			code = ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;
+		}
+
+		ethnl_cable_test_result(phydev, pair, code);
+
+		if (code != ETHTOOL_A_CABLE_RESULT_CODE_OK &&
+		    code != ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC) {
+			ret = ytphy_read_ext_with_lock(phydev,
+						       YT861X_TDR_PAIR_LENGTH_REG(pair));
+			if (ret >= 0)
+				ethnl_cable_test_fault_length(phydev, pair,
+							      ret);
+		}
+	}
+
+	/* restore auto sleep and restart the PHY to resume the link */
+	ret = ytphy_modify_ext_with_lock(phydev,
+					 YT8521_EXTREG_SLEEP_CONTROL1_REG,
+					 YT8521_ESC1R_SLEEP_SW,
+					 YT8521_ESC1R_SLEEP_SW);
+	if (ret)
+		return ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret)
+		return ret;
+
+	*finished = true;
+
+	return 0;
+}
+
 /**
  * yt8821_get_features - read mmd register to get 2.5G capability
  * @phydev: target phy_device struct
@@ -3173,6 +3278,15 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.suspend	= yt8521_suspend,
 		.resume		= yt8521_resume,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_INT861X),
+		.name			= "Internal YT861x Gigabit Ethernet",
+		.soft_reset		= genphy_soft_reset,
+		.suspend		= genphy_suspend,
+		.resume			= genphy_resume,
+		.cable_test_start	= yt861x_cable_test_start,
+		.cable_test_get_status	= yt861x_cable_test_get_status,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8821),
 		.name			= "YT8821 2.5Gbps PHY",
@@ -3194,7 +3308,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 
 module_phy_driver(motorcomm_phy_drvs);
 
-MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
+MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");
 MODULE_AUTHOR("Peter Geis");
 MODULE_AUTHOR("Frank");
 MODULE_LICENSE("GPL");
@@ -3205,6 +3319,7 @@ static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_INT861X) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
 	{ /* sentinel */ }
 };
-- 
2.53.0

