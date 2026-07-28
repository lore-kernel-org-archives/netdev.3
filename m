Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8933D3D11
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225166; cv=none; b=LkMdHkPmtXH5mFog+uIgs5BipDTW0uwtKbf6L5eGdnX1AskDBILi2ZrU6bSBeNJZA9rdK2LUDAQ9xNqLrA3aTcBY+fbUXAlNaE8ZmQRDDCfXMfRfxU6ojkT5JSudQomgGwC1+te669WlP56ZWuBh9qXgtiGy+rK2AwFb4J3OC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225166; c=relaxed/simple;
	bh=iIOnEnT2ZKL4CzLPIlXd97q4tIZypmBFREgU+JmhlzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VY6OLDO0XiocvPxS1IvR6pjsir+J+KLThTZKg7rYObtCHYxeHW3Oh38X0G4f1Oci2GstkHP+cg4kb4ULKlOfVN0H8kimK268LyblaHtHV/mZijuOHvEp7FObL5Wo0+jloUE4HssYcnaSoiWgKKlct6pr9tx1sgHfaxPrwHVItbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n8mR6XoJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n8mR6XoJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B25DE1A12B7;
	Tue, 28 Jul 2026 07:52:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 85AD4601BF;
	Tue, 28 Jul 2026 07:52:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7944711C13E11;
	Tue, 28 Jul 2026 09:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785225148; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=WhrMs3YJTGjtXLnrUcTBPwPUQDPxpjXzMNEW4YqDM14=;
	b=n8mR6XoJEtJNyc7xhGtW7m/dVxie1qzbp9I5EHyz4cfhCW8edA/cEnQCd161qJdLoCFjki
	J6AiL1ceQ8r0CjK+Sguk4Ks5Idfzwa1OYbYQ8ulLGh3eH3DHWewZMPRfbWRdaMNzaxlnWZ
	QjQwQad6OZV7RwvEq/RGXZSUsOyfCM7PJ/WxGZbD3lsWK47Fuy0AByewwrK0WncW+cSAQh
	guPdLhX2JV2q+f4lUS3VUQDaV/o0+DJalCvG0KUid1D9Tk9bRQWWbTQoIiX6yFtNNyP/6Y
	zjDoa9wAn2n9nRlCm8Hgx5N4sspr2euUk8F56ARfyn5XxmYYLHAPS+Tb3R/UGg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next] net: phy: micrel: Add loopback support for ksz9131
Date: Tue, 28 Jul 2026 09:52:20 +0200
Message-ID: <20260728075222.956780-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

ksz9131 is configured for local loopback in a similar fashion as the
ksz9031, with a need for full-duplex operation, but with some extra
steps to take as specified in section 4.13.1 :

1. Configure the following registers:
- MMD 1C, Register 15 = EEEE
- MMD 1C, Register 16 = EEEE
- MMD 1C, Register 18 = EEEE
- MMD 1C, Register 1B = EEEE

These 4 registers are marked as "Reserved" in the register map.

When setting loopback up without configuring these 4 registers, the PHY
appears to shut its RXC down, which can trigger failures on MACs that
require it, such as stmmac.

The datasheet does not specify to which state the registers must be
reset when disabling loopback, so let's restore them to their measured
initial values.

This was discovered when trying to use stmmac selftests on imx8mp with a
ksz9131 connected in RGMII.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/micrel.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 55df5efcfc86..ae830781824b 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1161,6 +1161,65 @@ static int ksz9031_set_loopback(struct phy_device *phydev, bool enable,
 				     5000, 500000, true);
 }
 
+/* KSZ9131-specific sequence to enable loopback, registers are undocumented
+ * in the datasheet but mentionned in the local loopback mode configuration
+ * steps.
+ *
+ * Without taking these steps, the PHY appears to disable its RXC while in
+ * loopback mode, which may be needed by some MACs such as stmmac.
+ */
+static int ksz9131_loopback_enable(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write_mmd(phydev, 0x1c, 0x15, 0xeeee);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, 0x1c, 0x16, 0xeeee);
+	if (ret)
+		return ret;
+
+	ret = phy_write_mmd(phydev, 0x1c, 0x18, 0xeeee);
+	if (ret)
+		return ret;
+
+	return phy_write_mmd(phydev, 0x1c, 0x1b, 0xeeee);
+}
+
+/* KSZ9131 datasheet doesn't state how to deal with the MMD 0x1c registers
+ * when disabling loopback.
+ *
+ * Set them back to their measured initial state when disabling loopback, and
+ * ignore errors while doing so.
+ */
+static void ksz9131_loopback_disable(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, 0x1c, 0x15, 0x6eff);
+	phy_write_mmd(phydev, 0x1c, 0x16, 0xe6ff);
+	phy_write_mmd(phydev, 0x1c, 0x18, 0x43ff);
+	phy_write_mmd(phydev, 0x1c, 0x1b, 0x07ff);
+}
+
+static int ksz9131_set_loopback(struct phy_device *phydev, bool enable,
+				int speed)
+{
+	int ret;
+
+	if (enable) {
+		ret = ksz9131_loopback_enable(phydev);
+		if (ret)
+			return ret;
+	}
+
+	ret = ksz9031_set_loopback(phydev, enable, speed);
+
+	if (ret || !enable)
+		ksz9131_loopback_disable(phydev);
+
+	return ret;
+}
+
 static int ksz9031_of_load_skew_values(struct phy_device *phydev,
 				       const struct device_node *of_node,
 				       u16 reg, size_t field_sz,
@@ -6993,6 +7052,7 @@ static struct phy_driver ksphy_driver[] = {
 	.cable_test_start	= ksz9x31_cable_test_start,
 	.cable_test_get_status	= ksz9x31_cable_test_get_status,
 	.get_features	= ksz9477_get_features,
+	.set_loopback	= ksz9131_set_loopback,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_KSZ8873MLL),
 	.name		= "Micrel KSZ8873MLL Switch",
-- 
2.55.0

