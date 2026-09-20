Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048353C584F
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923737; cv=none; b=ncptLNpP3uZFbAcMGv9mP/c4POh4pY/ChytgftJQXNyw3Y2yF/iF6QGoSTwyu39k1axjh9vzNg5cyaru5EKOAxZWpiqxZsr12mvN8o0KZhV4PS6itg8N6wSwGMPhKyDea6tVo1l5jfDp+DPKQ8gbxM3znlcTlMUbJqOy0ypcbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923737; c=relaxed/simple;
	bh=nfHCywuouAotZEtfin/UT97xewpGFIHFD6nChmuOl+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzCRqd77cQZh7ueMWyx5GHC9RT890dIEvSVGU3sn/qikOv62v6veZ1648e3YGMDPjJPq2dCNh0NXFDaqcb//JXls0byGCxw2jd+X18YypYPEbE7IQ188CiBUOGg59idFv7JC6lXY3Z+VAWDJpdmc6r0NMBCvkzJd4w43ZKS+6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtHYVrT6; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtHYVrT6"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc51dd43909so1311372a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923735; x=1790528535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEUQeU6k8z4p+pYvxi9WzB22HwI4F5YGnZw/HBsPBRQ=;
        b=UtHYVrT61ESOI0OhM00LGmtAx+mC/gVMXS6Z5ns7++uoP87cS1zHVQnh1u4/Psl8XZ
         hPoQbiorZ330tEc4SO9QdRq9u57D0M0fO2n1BEwqD3a8ee7n4EhngGvZc5vV1kre434h
         48bRzYl5gG+xw/rYMdE9voZlwYaPulEQ2xe/rS8+sAfMGStUVohqsspZo3IjmuKL+Qsd
         /T9K+pg0zLDTdmytAN+qSvPEvCKwXsnqdfyiSDqQGjFwchC0l9wSqnjgZLrDbqJ2Qxi8
         eTJdtgJdTPF1lMxHkHRq1q8M4GDQg799/eYKDMKgJJKyrAvkw22q9uqviVhm8yVKLc3H
         IU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923735; x=1790528535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEUQeU6k8z4p+pYvxi9WzB22HwI4F5YGnZw/HBsPBRQ=;
        b=YWB3E8q4cFD/hEpwKGWbBbTtcRrV+/vOu6lTrmSN8Vro++WQEHUqrKFYS7U5JluzJ4
         Dri+s0+FHhn2jOeM0Hs92dKhyC1UG1JA1tuMUAZnLGLYoPeJeEWN1oWs4ad6Sy2NwyzK
         diNCKAsGm/bZQm7hX9fN7beAmntj7L/z9kLXhujZV/7YjJuvd5rzo2PG3vcnwEwi2GZU
         ylyyX1HQHybUIIeAFavnbl0ko2BSVzcCbeophwdF3lrCG5gtAmXXmwJvMFF4Q1OYf961
         A2fe4BRfqJg2/o4IkmXjuzr9AbZBzhkVVOqhBaAl9129h1ZzwcRLFqge0DuCGPtxxBhI
         T8KA==
X-Forwarded-Encrypted: i=1; AKwUvBwb2XAFp6PMQoLAPpsNp4f6Pd2UtWno85uKVWUYZdsghJoe6bMOIaqEeaISKEi55VaLQF0FMxg=@vger.kernel.org
X-Gm-Message-State: AFuF++mDyrJqwzZ+/XGuytPRGjSaGu/RPN4VokAcFME5KM9dUo4UH5sD
	1ZKgPZXcI0wkr77w4xAQUykPZxm3mktHTZB9q7YvTLv19xhcrrMS3nem
X-Gm-Gg: AYBFou0VU6gBCeY0E0cUhiC+UYEj74gXo2kqj4VbE/OTbiRnJlp5M2SzaDQyYVVqMAL
	e6B4OZoL1igvB+s4Ft8cTx/AsoYFpZZ6uXAuxg0PuIpOQwSWJn4v+eGm9OmubiTWSIjTlsOrFf9
	YVTdCeG3QdPrq8Msfcsvj28eKw+i6YbMzNNXfWMYzlgq4D8jqS8AAYJeYSp07q3kgkVpbZXxIVy
	jKa+zxJ8PLD3Jxmt85egZ8vUY0mSLrPRqd3SSrUkEG10Ek3Plj9OFAoiza0odzRmoSZhQPidFCp
	1DTdLdZnJEOILmrl6HHTVAYg/EX+VG/39wBCV8QzCQzcqkqswWGQiK5b3ynLhLpSvUbeodzZZDn
	ydp7IC7ma8mTsVVsuHCzKFwzgMKWk6jAj50BV5jhgETU3tgODgi6TwMa7/dZBoPHg58o4ZwQv8K
	7EsjwhZ1e3jGZnptdiYhoisuO13hJJe6lTBIZl36P4DSvD2kqF2/kFtqKcVgLmxDs7db3Vtw==
X-Received: by 2002:a05:6a00:2ea4:b0:878:3519:aff8 with SMTP id d2e1a72fcca58-8783528fd86mr4832913b3a.55.1789923735267;
        Sun, 20 Sep 2026 10:02:15 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:02:13 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v9 01/11] net: stmmac: move XPCS lifetime management to platform drivers
Date: Mon, 21 Sep 2026 01:01:05 +0800
Message-ID: <20260920170116.3624104-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920170116.3624104-1-coiaprant@gmail.com>
References: <20260920170116.3624104-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current XPCS creation logic in stmmac_pcs_setup() is problematic
for several reasons.

First, if a device tree specifies a "pcs-handle" but no select_pcs()
callback is provided by the platform driver, the created XPCS cannot be
used by phylink for PCS operations. The framework requires select_pcs()
to return the PCS to the core, so the pcs-handle property becomes
effectively useless for link management without the matching callback.
The XPCS is still consulted by stmmac_phylink_setup() and
stmmac_init_phy(), which makes the configuration silently half-working
rather than clearly broken.

Second, and more critically, when a platform driver sets pcs_init()
and creates an XPCS inside that callback, the common code afterwards
still runs unconditionally and overwrites priv->hw->xpcs with the
local xpcs variable, which stays NULL. The platform driver has no way
to prevent this override because the common code runs after the
platform-specific initialization.

After commit 93f84152e4ae ("net: stmmac: clean up
stmmac_mac_select_pcs()"), the common code no longer falls back to
priv->hw->phylink_pcs if select_pcs() is not set. This change
reinforces that each platform must manage its own PCS life cycle
explicitly, but the XPCS creation code in stmmac_pcs_setup() was not
updated to match this new expectation, leaving a gap where platform
drivers have no clean way to take control of XPCS creation.

Address all of these issues by simplifying the existing pcs_init() and
pcs_exit() dispatch in stmmac_pcs_setup() and stmmac_pcs_clean(). The
common stmmac_pcs_setup() now calls plat->pcs_init() if present, and
stmmac_pcs_clean() calls plat->pcs_exit() if present, removing the
confusing and error-prone XPCS creation logic from the common code.

Platforms that do not need an XPCS simply leave the callbacks as NULL
and no change in behavior occurs. Platforms that do need an XPCS can
now create it with the exact configuration they require, including
wrapping it with custom phylink_pcs_ops when necessary.

Note that this also removes the generic "pcs-handle" parsing from the
common code. A glue that does not set pcs_init() now leaves
priv->hw->xpcs as NULL, and "pcs-handle" becomes a no-op for it. No
in-tree platform relies on this path: every DTS that pairs a dwmac node
with a PCS goes through a glue that sets pcs_init() (Intel, Renesas,
RZ/N1, SoCFPGA, Rockchip).

The Intel mGbE glue is updated to create its XPCS inside its own
pcs_init() implementation, and the renesas-gbeth, rzn1 and socfpga
pcs_exit() callbacks now explicitly clear priv->hw->phylink_pcs after
destroying the PCS to avoid dangling pointer references.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 44 +++++++++++++++++--
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  7 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |  7 ++-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  7 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 39 +++-------------
 5 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index f5f9fa67ecd77..4308dccbf2570 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -603,13 +603,47 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 	plat->mdio_bus_data->needs_reset = true;
 }
 
+static int intel_mgbe_pcs_init(struct stmmac_priv *priv)
+{
+	struct fwnode_handle *devnode, *pcsnode;
+	struct dw_xpcs *xpcs;
+	int addr;
+
+	devnode = dev_fwnode(priv->device);
+
+	if (fwnode_property_present(devnode, "pcs-handle")) {
+		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
+		xpcs = xpcs_create_fwnode(pcsnode);
+		fwnode_handle_put(pcsnode);
+	} else {
+		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
+		xpcs = xpcs_create_mdiodev(priv->mii, addr);
+	}
+
+	if (IS_ERR(xpcs))
+		return PTR_ERR(xpcs);
+
+	xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
+
+	priv->hw->xpcs = xpcs;
+	return 0;
+}
+
+static void intel_mgbe_pcs_exit(struct stmmac_priv *priv)
+{
+	if (!priv->hw->xpcs)
+		return;
+
+	xpcs_destroy(priv->hw->xpcs);
+	priv->hw->xpcs = NULL;
+}
+
 static struct phylink_pcs *intel_mgbe_select_pcs(struct stmmac_priv *priv,
 						 phy_interface_t interface)
 {
-	/* plat->mdio_bus_data->has_xpcs has been set true, so there
-	 * should always be an XPCS. The original code would always
-	 * return this if present.
-	 */
+	if (!priv->hw->xpcs)
+		return NULL;
+
 	return xpcs_to_phylink_pcs(priv->hw->xpcs);
 }
 
@@ -733,6 +767,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		plat->mdio_bus_data->pcs_mask = BIT_U32(INTEL_MGBE_XPCS_ADDR);
 		plat->default_an_inband = true;
+		plat->pcs_init = intel_mgbe_pcs_init;
+		plat->pcs_exit = intel_mgbe_pcs_exit;
 		plat->select_pcs = intel_mgbe_select_pcs;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
index 19f34e18bfef2..9af32c26f9c14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -81,8 +81,11 @@ static int renesas_gmac_pcs_init(struct stmmac_priv *priv)
 
 static void renesas_gmac_pcs_exit(struct stmmac_priv *priv)
 {
-	if (priv->hw->phylink_pcs)
-		miic_destroy(priv->hw->phylink_pcs);
+	if (!priv->hw->phylink_pcs)
+		return;
+
+	miic_destroy(priv->hw->phylink_pcs);
+	priv->hw->phylink_pcs = NULL;
 }
 
 static struct phylink_pcs *renesas_gmac_select_pcs(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
index 13634965bc19a..01df4776edb3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
@@ -35,8 +35,11 @@ static int rzn1_dwmac_pcs_init(struct stmmac_priv *priv)
 
 static void rzn1_dwmac_pcs_exit(struct stmmac_priv *priv)
 {
-	if (priv->hw->phylink_pcs)
-		miic_destroy(priv->hw->phylink_pcs);
+	if (!priv->hw->phylink_pcs)
+		return;
+
+	miic_destroy(priv->hw->phylink_pcs);
+	priv->hw->phylink_pcs = NULL;
 }
 
 static struct phylink_pcs *rzn1_dwmac_select_pcs(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 1d7f0a57d2889..6d4bc1fe8f751 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -539,8 +539,11 @@ static int socfpga_dwmac_pcs_init(struct stmmac_priv *priv)
 
 static void socfpga_dwmac_pcs_exit(struct stmmac_priv *priv)
 {
-	if (priv->hw->phylink_pcs)
-		lynx_pcs_destroy(priv->hw->phylink_pcs);
+	if (!priv->hw->phylink_pcs)
+		return;
+
+	lynx_pcs_destroy(priv->hw->phylink_pcs);
+	priv->hw->phylink_pcs = NULL;
 }
 
 static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index afe98ff5bdcb0..7396b68899c66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -426,35 +426,14 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 int stmmac_pcs_setup(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct fwnode_handle *devnode, *pcsnode;
-	struct dw_xpcs *xpcs = NULL;
-	int addr, ret;
-
-	devnode = dev_fwnode(priv->device);
-
-	if (priv->plat->pcs_init) {
-		ret = priv->plat->pcs_init(priv);
-	} else if (fwnode_property_present(devnode, "pcs-handle")) {
-		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
-		xpcs = xpcs_create_fwnode(pcsnode);
-		fwnode_handle_put(pcsnode);
-		ret = PTR_ERR_OR_ZERO(xpcs);
-	} else if (priv->plat->mdio_bus_data &&
-		   priv->plat->mdio_bus_data->pcs_mask) {
-		addr = ffs(priv->plat->mdio_bus_data->pcs_mask) - 1;
-		xpcs = xpcs_create_mdiodev(priv->mii, addr);
-		ret = PTR_ERR_OR_ZERO(xpcs);
-	} else {
+	int ret;
+
+	if (!priv->plat->pcs_init)
 		return 0;
-	}
 
+	ret = priv->plat->pcs_init(priv);
 	if (ret)
-		return dev_err_probe(priv->device, ret, "No xPCS found\n");
-
-	if (xpcs)
-		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
-
-	priv->hw->xpcs = xpcs;
+		return dev_err_probe(priv->device, ret, "Failed to initialize PCS\n");
 
 	return 0;
 }
@@ -463,14 +442,10 @@ void stmmac_pcs_clean(struct net_device *ndev)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
-	if (priv->plat->pcs_exit)
-		priv->plat->pcs_exit(priv);
-
-	if (!priv->hw->xpcs)
+	if (!priv->plat->pcs_exit)
 		return;
 
-	xpcs_destroy(priv->hw->xpcs);
-	priv->hw->xpcs = NULL;
+	priv->plat->pcs_exit(priv);
 }
 
 struct stmmac_clk_rate {
-- 
2.47.3

