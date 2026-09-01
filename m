Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736648C8A5
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281461; cv=none; b=pymPKqYoZ3TutmGGfETSVAfZMJMH28Ngm7+pzM3CKPEbB7s8fTWWVt/v+aCAbop6Dfp44HYBykDDzzca/JAt3u8V4BOc0f+oqddfOXLIXAU6J1mmwZMS4VDzRfbkizowBhkCYUEt+ghyTFzhzBml9HBJmdLB9HbRYTNUAwtx8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281461; c=relaxed/simple;
	bh=Ktoniz3KaUpJGaYPHbUdLkx/OpMpAg8WFjtQZ0YKu8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcpN2KoTCVMbUGLE6u0orB2zePhnges4QbeUXfzZF8mJm3wTsfh3f0kS9AGBViCupGtYP5Hu5EVMkoAYMPL3NMoud1byn6uQKNVl2sEh4aJG1e+PL5m864soJGgphmp+VIM7h+OfeV7S24PplVmdlKK18ea8vXD8EAUD3yvQPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=PWol28LP; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="PWol28LP"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026090116505223cb5024eb00020750
        for <netdev@vger.kernel.org>;
        Tue, 01 Sep 2026 18:50:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=S1OujqtbTSD7Jd1sRNsbECS+JnzF9Yt5HTTfig8ekrY=;
 b=PWol28LPTODO38aNnBolD4QWY9B+3ZGSh7qcpzCQQTgQvz7HsByaHPOjgrmaA6Lxzb2YBv
 PmSSV8N4S639RpAlNZgrozYHjBuyQky+iHeBReRJq7LU5u9hYUa1zNN4++4GFSqXQh9RVhw4
 HhXuJF2CMWzneTrQz4Y2sPSb/rAOZ0ZkyAoj0zbnRrZWWVogu9XV0SJGdo9n4BbtrUSCItPk
 N/OYQTq7CXr9F/iGOByikCdx2GurrlsFstIFsYuzYJoKhAzUQl9Mr5UEcV2St7UmyuM/74qb
 WzJUeXi5BpNBLUdAp5ueOyoSYw3DbOWoC9Y1bY1cJYCL0DfCuhx7y2lg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mxl-gsw1xx: deassert internal PHY resets before MDIO registration
Date: Tue,  1 Sep 2026 18:50:48 +0200
Message-ID: <20260901165049.672446-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

When the switch is bootstrapped with PS_NOWAIT = 0, the internal PHYs
default to a held-in-reset state. The driver previously only worked with
PS_NOWAIT = 1 where PHYs are released from reset automatically.

Deassert the PHY reset lines via the RST_REQ register before the MDIO bus
is registered, so that PHY IDs can be read during bus scan. Only release
PHYs for ports that have a phy-handle in the device tree, so unused ports
do not consume power. A single 300ms delay after deasserting all needed
resets ensures the PHYs are ready for MDIO communication (refer to Intel
XWAY, Maxlinear GPY111 datasheets or the Lantiq counterpart of the driver).

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 10 +++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 43 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  1 +
 4 files changed, 56 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index bc3686faad0d6..7af828577c27d 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -261,6 +261,8 @@ struct gswip_hw_info {
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
 	enum dsa_tag_protocol tag_protocol;
+
+	int (*setup)(struct dsa_switch *ds);
 	void (*phylink_get_caps)(struct dsa_switch *ds, int port,
 				 struct phylink_config *config);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index 0e8eedf64d3a3..61624f251aeb3 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -689,6 +689,16 @@ static int gswip_setup(struct dsa_switch *ds)
 	 */
 	regmap_write(priv->mdio, GSWIP_MDIO_MDC_CFG0, 0x0);
 
+	/* GSW1xx will wake up the PHYs here, so it makes sense that it happens
+	 * after the auto-polling deactivation above, but before the MDIO bus
+	 * registration below
+	 */
+	if (priv->hw_info->setup) {
+		err = priv->hw_info->setup(ds);
+		if (err)
+			return err;
+	}
+
 	/* Configure the MDIO Clock 2.5 MHz */
 	regmap_write_bits(priv->mdio, GSWIP_MDIO_MDC_CFG1, 0xff, 0x09);
 
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a1104b2f92a92..2b5a0b41b473c 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_mdio.h>
 #include <linux/phy/phy-common-props.h>
@@ -588,6 +589,44 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
 	gsw1xx_phylink_get_lpi_caps(config);
 }
 
+static int gsw1xx_setup(struct dsa_switch *ds)
+{
+	struct gswip_priv *gswip_priv = ds->priv;
+	struct gsw1xx_priv *priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
+	struct device_node *phy_np;
+	struct dsa_port *dp;
+	u32 phy_reset_mask = 0;
+	int ret;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		struct phylink_config cfg = {};
+
+		/* Is there an internal PHY on this port? */
+		gswip_priv->hw_info->phylink_get_caps(ds, dp->index, &cfg);
+		if (!test_bit(PHY_INTERFACE_MODE_INTERNAL, cfg.supported_interfaces))
+			continue;
+
+		/* Will the PHY be really used? */
+		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
+		if (!phy_np)
+			continue;
+
+		of_node_put(phy_np);
+		phy_reset_mask |= GSW1XX_RST_REQ_PHY(dp->index);
+	}
+
+	if (!phy_reset_mask)
+		return 0;
+
+	/* Deassert resets only for PHYs referenced by active ports */
+	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_reset_mask);
+	if (ret)
+		return ret;
+	msleep(300);
+
+	return 0;
+}
+
 static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
 							 phy_interface_t interface)
 {
@@ -829,6 +868,7 @@ static const struct gswip_hw_info gsw12x_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -851,6 +891,7 @@ static const struct gswip_hw_info gsw140_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -873,6 +914,7 @@ static const struct gswip_hw_info gsw141_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
 	.port_setup		= gsw1xx_port_setup,
@@ -894,6 +936,7 @@ static const struct gswip_hw_info gsw150_data = {
 		[5] = 1,
 		[6] = 11,
 	},
+	.setup			= gsw1xx_setup,
 	.phylink_get_caps	= gsw150_phylink_get_caps,
 	/* There is only a single RGMII_SLEW_CFG register in GSW150 and it is
 	 * unknown if RGMII slew configuration affects both RGMII ports
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index caa8f1008587a..a7976a5988bd8 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -110,6 +110,7 @@
 #define GSW1XX_SHELL_BASE			0xfa00
 #define  GSW1XX_SHELL_RST_REQ			0x01
 #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
+#define   GSW1XX_RST_REQ_PHY(p)			BIT(p)
 #define  GSW1XX_SHELL_MANU_ID			0x10
 #define   GSW1XX_SHELL_MANU_ID_PNUML		GENMASK(15, 12)
 #define   GSW1XX_SHELL_MANU_ID_MANID		GENMASK(11, 1)
-- 
2.55.0

