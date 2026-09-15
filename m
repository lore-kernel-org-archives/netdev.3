Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A1396B6F
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463956; cv=none; b=jR0WFNQgoCfr/OL2j7wV0GvBSS29lsC/w7eDJ01UCkuKbqvlyiLkElbTo7vPdA/b7mdDVtrHkpSNNp19bn9iHozjWiU/jc3fGYVVCvKXaT1VO3osoGJShu5I3Q9bDlBajtQSMd2ONiYKP5eGvP9/8Twh6Ga+ApDL3i3ETJFOd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463956; c=relaxed/simple;
	bh=VXyqUdyenrDAbg7zhVoC8Rcnf+A/UdQbnHwkXrLTOl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLWXdhHrG4evX5sRq9aFKcn3kHpUHoneCBI+rGwSAOHdGik7rZwypSxKEvCzOXU/TPd3WsOMRXa/AfKCawNNDD63fImbmfbFh8/04E2PmY0Xz7tr4kBuHFvJ8wdW/FWeb8LMJ7fnoTJMTaHYT5Fx0UssufvNie5Cl3RnuaZjE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=RkuLZo9i; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="RkuLZo9i"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260915091900f2f695a45600020731
        for <netdev@vger.kernel.org>;
        Tue, 15 Sep 2026 11:19:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=p0t/QhNpXV8HWcEe61E/DPmG7fB9BX0Gj53TM6dqJQw=;
 b=RkuLZo9in4jQjDbKCnl8OkJVt0YMw27PJSgOvvg4D8ZKse1MHKadIsMcUYNolEd/l3gyTH
 zCspQ1i3PMJpTiPG3bE93xfRssw7Ei1o+HBFLWueo+7xVwpg2CSmp/GfFPFbOV5IYRVyZ2Tr
 pymTqU4Fj97q6StMwncsktkgXFX+g0eIeGxPtPq0X++tdCfcR06GwUypMx7isFIkcfyjqgJC
 d+e/NwzpAxn+eft46kWt1eNq01I0+Kg/SKmj1UxPWTyQPJzEsAyVYtsj66AmIQ5a/2S+F+gD
 7ZhmtDkFEjjmKGnkzOabkeWDppVo+XgrEJOYVxS2m67YMdaezgAsQTvg==;
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
Subject: [PATCH net-next v3] net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state
Date: Tue, 15 Sep 2026 11:18:45 +0200
Message-ID: <20260915091856.1375914-1-alexander.sverdlin@siemens.com>
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

Program the PHY reset lines via the RST_REQ register before the MDIO bus
is registered, so that PHY IDs can be read during bus scan. Release only
the PHYs of ports that have a phy-handle in the device tree and keep the
unused ones held in reset. Driving both directions makes the resulting
state identical regardless of the PS_NOWAIT bootstrap: unused PHYs no
longer stay powered when PS_NOWAIT = 1 released them automatically.

A single 300ms delay after deasserting the needed resets ensures the PHYs
are ready for MDIO communication (refer to Intel XWAY, Maxlinear GPY111
datasheets or the Lantiq counterpart of the driver). The delay is skipped
when no PHY is released from reset.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- put unused PHYs into reset state (changed patch subject accordingly)
v2:
- Reverse Christmas tree.
- https://lore.kernel.org/all/20260908103030.4032992-1-alexander.sverdlin@siemens.com/
v1:
- https://lore.kernel.org/all/20260901165049.672446-1-alexander.sverdlin@siemens.com/

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 10 ++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 51 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  1 +
 4 files changed, 64 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 0b75be14dc109..4f95877c59d1d 100644
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
index 6150dc3ffb641..7c53ded178367 100644
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
index 66bf7e3319057..08c633b2caebf 100644
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
@@ -589,6 +590,52 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
 	gsw1xx_phylink_get_lpi_caps(config);
 }
 
+static int gsw1xx_setup(struct dsa_switch *ds)
+{
+	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
+	struct gswip_priv *gswip_priv = ds->priv;
+	u32 phy_mask = 0, active_mask = 0;
+	struct device_node *phy_np;
+	struct dsa_port *dp;
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
+		phy_mask |= GSW1XX_RST_REQ_PHY(dp->index);
+
+		/* Will the PHY be really used? */
+		phy_np = of_parse_phandle(dp->dn, "phy-handle", 0);
+		if (!phy_np)
+			continue;
+
+		of_node_put(phy_np);
+		active_mask |= GSW1XX_RST_REQ_PHY(dp->index);
+	}
+
+	if (!phy_mask)
+		return 0;
+
+	/* Deassert resets for PHYs referenced by active ports and hold the
+	 * unused ones in reset, so the state is identical regardless of the
+	 * PS_NOWAIT bootstrap.
+	 */
+	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask,
+				 phy_mask & ~active_mask);
+	if (ret)
+		return ret;
+
+	if (active_mask)
+		msleep(300);
+
+	return 0;
+}
+
 static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
 							 phy_interface_t interface)
 {
@@ -830,6 +877,7 @@ static const struct gswip_hw_info gsw12x_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -852,6 +900,7 @@ static const struct gswip_hw_info gsw140_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -874,6 +923,7 @@ static const struct gswip_hw_info gsw141_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
 	.port_setup		= gsw1xx_port_setup,
@@ -895,6 +945,7 @@ static const struct gswip_hw_info gsw150_data = {
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

