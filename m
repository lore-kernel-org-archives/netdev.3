Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7047CA74;
	Thu,  1 Oct 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894399; cv=none; b=P6VXrcyPk6iJVd0cf9CvpyeKFOed9P1Sm2S47ZFbKGqTIZIS/xxzP3ECeOGWL/e5MFgQgvkHCkMpGeU8XyiG/P4X52MnMYFun0cVy7s6A1jwBJm7UQTpjs5BFxeHsnvRB1rOmMgqrgjbcT8Qc7+5+0YVqepXkms39BFb8A8+ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894399; c=relaxed/simple;
	bh=TJVSVi18BAutSUcCWkyUR64EpqcdpmJqmOn1EoIdi5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxypxD75lf12BBfLCYacywPzi8r/xLd4JeXqSHTxW5xsGtT0KQl55PsnsvnoCf9/ooqAtcznd2JNVLvgE/p5qvOCnzMOkBjD+RNPmlCSDpKNGLBkDok3c2Dbov/5EnZTT7Cc4PF4RlObRZr/eCcSzEXvNwrCwbcbf/hjkEyajwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=jXhNfWdI; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="jXhNfWdI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C9571073CF;
	Fri, 02 Oct 2026 00:39:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1790894390; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=z1KtkvhbsHdex4xQM2wbRp8dWV7ggUIOWI5xc9hUyq0=;
	b=jXhNfWdI1GarFVKRdjy2fpv8YMnHSCwnfuFxzCapJLPK4bM3cqVIF06e2RMnF89lmOL3Zs
	g52zv4/2O/9cssCb5MOQqyaDspENDcvT0W+eQMoT0vaP3NRB2vrHOSnywgYhkcd7lsorZK
	CFSCwq+hFSDFjek/5Av5piQUtwGvsS9rvKemO7HhhXmonO4syWz5u9ueUjAaUonWsCpOLw
	0AOJSaWmKgjbZxGnrgxJ2voJ/XKjjGxXRTnIHQRSQWeyTG8gqih27GVe1b5v78YH4235p5
	DDcrIcT1mJce7z8rUjNd+uURgZp+fpGdSFr6XVEyslIKMiqREk4nnkZx1Sv4jg==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [net-next,PATCH] enetc: Set eMDIO MDC rate to 2.5 MHz only on i.MX95
Date: Fri,  2 Oct 2026 00:38:52 +0200
Message-ID: <20261001223947.60189-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current eMDIO MDC rate is 2.5 MHz on i.MX95 B0. It was pointed
out by NXP, that the MDC rate is divided down from clock of different
frequency and using different division ratio on different SoCs. The
clock which feed the divider do not seem to be available on all SoCs
and therefore their rate cannot be read out of clock tree. Configure
the i.MX95 eMDIO MDC rate to 2.5 MHz to match the 802.3 specification
and reinstate previous divider ratio for all other SoCs. This way the
other SoCs are unaffected by the i.MX95 specific change.

Fixes: 587acb86d646 ("enetc: Increase eMDIO MDC rate to 2.5 MHz")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c    | 12 ++++++------
 .../net/ethernet/freescale/enetc/enetc_pci_mdio.c    |  5 +++--
 include/linux/fsl/enetc_mdio.h                       |  1 +
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index a90a04a47befd..7ed9b9120f447 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -22,9 +22,9 @@
  /* external MDIO only - driven on neg MDC edge */
 #define MDIO_CFG_NEG		BIT(23)
 
-#define ENETC_EMDIO_CFG \
+#define ENETC_EMDIO_CFG(mdc_div) \
 	(MDIO_CFG_HOLD(2) | \
-	 MDIO_CFG_CLKDIV(66) | \
+	 MDIO_CFG_CLKDIV(mdc_div) | \
 	 MDIO_CFG_NEG)
 
 #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
@@ -63,7 +63,7 @@ int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
 	u16 dev_addr;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	dev_addr = regnum & 0x1f;
 	mdio_cfg &= ~MDIO_CFG_ENC45;
 
@@ -95,7 +95,7 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
 	u32 mdio_ctl, mdio_cfg;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	mdio_cfg |= MDIO_CFG_ENC45;
 
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
@@ -133,7 +133,7 @@ int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 	u16 dev_addr, value;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	dev_addr = regnum & 0x1f;
 	mdio_cfg &= ~MDIO_CFG_ENC45;
 
@@ -176,7 +176,7 @@ int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
 	u16 value;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	mdio_cfg |= MDIO_CFG_ENC45;
 
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index e108cac8288d3..6704033067ecc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -71,6 +71,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	mdio_priv = bus->priv;
 	mdio_priv->hw = hw;
 	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	mdio_priv->mdc_div = ent->driver_data;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	pcie_flr(pdev);
@@ -125,8 +126,8 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
-	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID), 0, 0, 258 },
+	{ PCI_DEVICE(NETC_EMDIO_VEN_ID, NETC_EMDIO_DEV_ID), 0, 0, 66 },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 623ccfcbf39c3..7dfd65622c95d 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -33,6 +33,7 @@ struct enetc_hw;
 struct enetc_mdio_priv {
 	struct enetc_hw *hw;
 	int mdio_base;
+	int mdc_div;
 };
 
 #if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
-- 
2.53.0

