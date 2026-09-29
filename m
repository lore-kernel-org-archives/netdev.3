Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DA349B15
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686313; cv=none; b=EuNYwdos0CZ/g4Lgkq1p8wpzMJSZQygjWrcsmGx7Dku62Os2gQzgAwGKt7T/00icXFNV2psJzwYYSFQ/PtKfaroQIxfrWh2iR2+fEBOvqTVn1ossxTkirwLiHuDsJ/ag8g3ALwytHtXl2G5dytF3opHw4jnfZGn6cxU97Ljw2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686313; c=relaxed/simple;
	bh=1Zfq4zCKHXLy0bBN/ObQ95XXcQ7SZtKOv91lns9/oEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drQ/CYRJxDebTSr00nNA0Nl1wDqJd3RhQZbs/ADc6jCtqx6HCGr3zR7ij2yUZtJ+KzO3UlS+NgTR2rZcEATM+4UUDZSZ5STjNoF3RqjvbMuHRETIYuNxT/5w28CX+VD05CNuFUnuF35cI09YUZGTCT4AgI2cerQjhjgC8iFo6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=jgSB9OD+; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="jgSB9OD+"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260929125146f319ce4fe1000207dc
        for <netdev@vger.kernel.org>;
        Tue, 29 Sep 2026 14:51:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Eih0EfRJbD6yL67ydAkhmizL4dvmSfIyS3bEYQP+kAc=;
 b=jgSB9OD+z71L3tpYktkuiU24k5uGWImf3GqBjdzjh0S03B1x8NvoulONNDv4Ol8QKSdksG
 eDARhzF6WBYxcOy9imE8p/kDmLxKEZQnx3GbgfhiYfcuTyy1DvtP11pjfYvFlm+6PZArN7CO
 yz0MP1J0gjocmLganAIa6EJ86Kpu78o5nPrwmunpLL8P8I39/SjJUOORT4EXH9Zc+FMmdpZ5
 RHjdQCBeMxcOYrz7Z+XaILCqtra21a52KmXsZT/zeZjyOtsBzKcUgWBKC8CQ1nuoD+6UTDMN
 QGxsMZR3ZChFr3pmcw/1H6Ian7HKA9M70fY8n+4wo/6nSHG/y6D/AtEQ==;
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
Subject: [PATCH net-next v5] net: dsa: mxl-gsw1xx: force internal PHYs into a known reset state
Date: Tue, 29 Sep 2026 14:51:41 +0200
Message-ID: <20260929125143.2890583-1-alexander.sverdlin@siemens.com>
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

When bootstrapped with PS_NOWAIT = 0 the internal PHYs stay held in
reset, so the driver only worked with PS_NOWAIT = 1 where they are
released automatically.

Add a ->setup() hook, run before the MDIO bus is registered so PHY IDs
are readable during the bus scan, that programs the RST_REQ PHY reset
lines: release the PHYs of used ports and hold all other internal PHYs
in reset. Driving both directions yields the same state regardless of
the PS_NOWAIT bootstrap and keeps unused PHYs from staying powered.

A single 300ms settle delay is applied only when at least one PHY is
released.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v5:
- didn't add Daniel's Reviewed-by: (because of loop condition change)
- reverted to ->phylink_get_caps() usage as in v3 to differentiate 4-phys
  from 5-phys switches
- !dsa_is_unused_port() instead of dsa_port_is_user()
- dropped redundant masking in regmap_update_bits()
- added comment to GSW1XX_RST_REQ_PHY()
v4:
- dropped PHY_INTERFACE_MODE_INTERNAL and "phy-handle" dance
- now correctly asserting the reset bits of the unused PHYs
- https://lore.kernel.org/all/20260922104124.311334-1-alexander.sverdlin@siemens.com/
v3:
- put unused PHYs into reset state (changed patch subject accordingly)
- https://lore.kernel.org/all/20260915091856.1375914-1-alexander.sverdlin@siemens.com/
v2:
- Reverse Christmas tree.
- https://lore.kernel.org/all/20260908103030.4032992-1-alexander.sverdlin@siemens.com/
v1:
- https://lore.kernel.org/all/20260901165049.672446-1-alexander.sverdlin@siemens.com/

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 ++
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 10 ++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 38 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 ++
 4 files changed, 52 insertions(+)

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
index 66bf7e3319057..9a3be7d2e4fa3 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -589,6 +589,37 @@ static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
 	gsw1xx_phylink_get_lpi_caps(config);
 }
 
+static int gsw1xx_setup(struct dsa_switch *ds)
+{
+	struct gsw1xx_priv *priv = container_of(ds->priv, struct gsw1xx_priv, gswip);
+	struct gswip_priv *gswip_priv = ds->priv;
+	u32 active_mask = 0;
+	u32 phy_mask = 0;
+	int port, ret;
+
+	for (port = 0; port < gswip_priv->hw_info->max_ports; port++) {
+		struct phylink_config cfg = {};
+
+		gswip_priv->hw_info->phylink_get_caps(ds, port, &cfg);
+		if (!test_bit(PHY_INTERFACE_MODE_INTERNAL, cfg.supported_interfaces))
+			break;
+
+		phy_mask |= GSW1XX_RST_REQ_PHY(port);
+
+		if (!dsa_is_unused_port(ds, port))
+			active_mask |= GSW1XX_RST_REQ_PHY(port);
+	}
+
+	ret = regmap_update_bits(priv->shell, GSW1XX_SHELL_RST_REQ, phy_mask, ~active_mask);
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
@@ -830,6 +864,7 @@ static const struct gswip_hw_info gsw12x_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -852,6 +887,7 @@ static const struct gswip_hw_info gsw140_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -874,6 +910,7 @@ static const struct gswip_hw_info gsw141_data = {
 		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
 		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
 	},
+	.setup			= gsw1xx_setup,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
 	.port_setup		= gsw1xx_port_setup,
@@ -895,6 +932,7 @@ static const struct gswip_hw_info gsw150_data = {
 		[5] = 1,
 		[6] = 11,
 	},
+	.setup			= gsw1xx_setup,
 	.phylink_get_caps	= gsw150_phylink_get_caps,
 	/* There is only a single RGMII_SLEW_CFG register in GSW150 and it is
 	 * unknown if RGMII slew configuration affects both RGMII ports
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index caa8f1008587a..81bc00eabbfb3 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -110,6 +110,8 @@
 #define GSW1XX_SHELL_BASE			0xfa00
 #define  GSW1XX_SHELL_RST_REQ			0x01
 #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
+/* Valid only for internal-PHY ports (vary per switch type) */
+#define   GSW1XX_RST_REQ_PHY(p)			BIT(p)
 #define  GSW1XX_SHELL_MANU_ID			0x10
 #define   GSW1XX_SHELL_MANU_ID_PNUML		GENMASK(15, 12)
 #define   GSW1XX_SHELL_MANU_ID_MANID		GENMASK(11, 1)
-- 
2.55.0

