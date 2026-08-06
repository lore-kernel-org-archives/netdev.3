Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D3E38655B;
	Thu,  6 Aug 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024969; cv=none; b=XBELxfS3gcp4WWax9QnsDszpCMuBA1ZLK3rYlRu5zlALp89lH7ia6REhMd97BulKwsK+XXrgJPy+QKLp1qQf0wyah6LQscTDRM8dRxU9dw30nGFb8LYS1neUgkX+AleT+R3p+LoNLpKXyroI7odB8QET7ZWUIcqv624SZLABRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024969; c=relaxed/simple;
	bh=GjXqYj+rK1jjuAxZE+LIfZyqpnqI8dM7PEg0FDRDuCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVh0o89AGc/uy/momPNj5JuRMs5LDbi+ZicRs3AlWlakAmDX/fnK2dkgF3z2icyWKBzIiZZ/j2SGT6AHKUfqtyTjq/yXbeckqw6tbONjGQ6X3zRM94uPbsrWo5qWZ/ciAwKd0p0OirbYD2mTYCHSrwRN9PtdmAE+WWZNoUHHrNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8C2DF2020FE;
	Thu, 06 Aug 2026 16:02:40 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wrygC-0006S1-1T;
	Thu, 06 Aug 2026 16:02:40 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wrygC-0000000ElRW-1Xng;
	Thu, 06 Aug 2026 16:02:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support for enabling supplies
Date: Thu,  6 Aug 2026 16:02:39 +0200
Message-ID: <20260806140239.3518906-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806140239.3518906-1-o.rempel@pengutronix.de>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

The power supplies powering the IC may not necessarily be enabled by the
time the driver probes. The binding has been extended to describe the
different power rails, so have the driver enable them in case they are
specified.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/realtek.h        |  2 ++
 drivers/net/dsa/realtek/rtl8365mb_main.c |  5 +++
 drivers/net/dsa/realtek/rtl83xx.c        | 40 ++++++++++++++++++++----
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 6e0148cee8d8..ba31605423b1 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -166,6 +166,8 @@ struct realtek_variant {
 	u8 cmd_read;
 	u8 cmd_write;
 	size_t chip_data_sz;
+	/* NULL-terminated list of regulator supply names, or NULL */
+	const char *const *supplies;
 };
 
 /* RTL8366 library helpers */
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 728231d8f94c..52ec4e91306c 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -3334,6 +3334,10 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.phy_write = rtl8365mb_phy_write,
 };
 
+static const char *const rtl8365mb_supplies[] = {
+	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl", NULL,
+};
+
 const struct realtek_variant rtl8365mb_variant = {
 	.ds_ops = &rtl8365mb_switch_ops,
 	.ops = &rtl8365mb_ops,
@@ -3342,6 +3346,7 @@ const struct realtek_variant rtl8365mb_variant = {
 	.cmd_read = 0xb9,
 	.cmd_write = 0xb8,
 	.chip_data_sz = sizeof(struct rtl8365mb),
+	.supplies = rtl8365mb_supplies,
 };
 
 static const struct of_device_id rtl8365mb_of_match[] = {
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 35df809a5951..fb6aaaa60aa3 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/of_mdio.h>
 #include <linux/if_bridge.h>
 #include <linux/etherdevice.h>
@@ -113,6 +114,24 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_setup_user_mdio, "REALTEK_DSA");
 
+static int rtl83xx_enable_supplies(struct device *dev,
+				   const char *const *supplies)
+{
+	int i, ret, count = 0;
+
+	for (i = 0; supplies && supplies[i]; i++) {
+		ret = devm_regulator_get_enable_optional(dev, supplies[i]);
+		if (ret == -ENODEV)
+			continue;
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to enable %s supply\n",
+					     supplies[i]);
+		count++;
+	}
+
+	return count;
+}
+
 /**
  * rtl83xx_probe() - probe a Realtek switch
  * @dev: the device being probed
@@ -145,6 +164,7 @@ rtl83xx_probe(struct device *dev,
 		.lock = rtl83xx_lock,
 		.unlock = rtl83xx_unlock,
 	};
+	int num_supplies;
 	int ret;
 
 	var = of_device_get_match_data(dev);
@@ -195,17 +215,22 @@ rtl83xx_probe(struct device *dev,
 	priv->leds_disabled = of_property_read_bool(dev->of_node,
 						    "realtek,disable-leds");
 
-	/* TODO: if power is software controlled, set up any regulators here */
+	/* Enable the supplies before the RESET line is requested and driven,
+	 * so the chip is powered before current is forced into its pins.
+	 */
+	num_supplies = rtl83xx_enable_supplies(dev, var->supplies);
+	if (num_supplies < 0)
+		return ERR_PTR(num_supplies);
+
 	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
 	if (IS_ERR(priv->reset_ctl))
 		return dev_err_cast_probe(dev, priv->reset_ctl,
 					  "failed to get reset control\n");
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return ERR_CAST(priv->reset);
-	}
+	if (IS_ERR(priv->reset))
+		return dev_err_cast_probe(dev, priv->reset,
+					  "failed to get RESET GPIO\n");
 
 	dev_set_drvdata(dev, priv);
 
@@ -214,10 +239,13 @@ rtl83xx_probe(struct device *dev,
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
 		rtl83xx_reset_deassert(priv);
-		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
 
+	/* Wait for the chip to come up only if we powered and/or reset it. */
+	if (priv->reset_ctl || priv->reset || num_supplies)
+		msleep(REALTEK_HW_START_DELAY);
+
 	return priv;
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_probe, "REALTEK_DSA");
-- 
2.47.3

