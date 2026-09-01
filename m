Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A79376A0C
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274929; cv=none; b=Y44YaM9/vLW4uuLXyjLTSin3B6Ex8fnd5eQkBG+JItbqDzBqbSvSbnbyNpj5swXGYCNwA6sI6WSclD9giPyoBvSMc1M9Xk7mt5L2h7c+p/AznJ3U44YYV++b021sxODVPG0MkmX8v0BcFbHfu5plgqGyLhyQ8uGyu14WkESei9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274929; c=relaxed/simple;
	bh=KahhwWv3LV1Z5vSb8cR57abZncM8NUVD9NyltpQLZvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIXNy0oR7xkfZT51cRxTFfM57VuvbbmhgzIy3D6QvEm3nK3Ey+rxZ8ISsFZq8McBnXI59Jb3Jt+kcGn8EDGGMjx8giRMTXgaKwWnPKSw73g6f6Ccp1+koHFoXW1Kv0/HNXrtvZlBwiQkORL2ze9lriCSWnsoC53OLcJhmX/0dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oAgSiCpx; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAgSiCpx"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-853c947bfefso1159418b3a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274927; x=1788879727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fphDOyDXIc9z55x5SG5ifvoj7feVaMiS/8ezdRLSxrI=;
        b=oAgSiCpx0CenSw9DcYiQ7kW9LLLQ47ZllUvolsqiWQpmxpzMJQZ+QIltdSd/qJclJ4
         N6w+PXZ+8T6oTGOZ7QzBQuTnl+RQvr+svj7ASleNGVQfXOkHUu4oi2cssN1pVjXCaAga
         FtNL7WLEsBdCHRSs+2VISe9VBsFbRZNVfcO0vNRdFoRN4FW4m4/5KrzEjRepfecOr3Ke
         Of/bhhpjNOjpdQRhm5ZGoIy4rmlIqaaL2ON2pzHJA8CXiohUZDSHsat/7TcXsS9EswI3
         fbAh18BGP882VMCTXwfxliSSoRjFecEheXSVDVkHYckePyBQb0eqoAroJmv6K0+WdmCg
         Lumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274927; x=1788879727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fphDOyDXIc9z55x5SG5ifvoj7feVaMiS/8ezdRLSxrI=;
        b=XMISY3Poxivf8MLefz9mQddDmqFzu7Vb9472M1oiAbudBra5dYdFkMN9vntwmBs3WV
         84HEI20TzPbxJo1+VmwcMC3WaRpusjVNCMlxF1ItDQ94xiaHFVyhAx5YXvRLGdF9tSqF
         lGBy+rtMjGRxU5f89mX3q6kYaVIvXlUL4oE0hwZrNK2cQB8HuvTs9HlI2wuoXV/MjX/K
         a2f6RjcPmvJNly9PuN6soFF8VMOC4wZ65zDvSncLWHaTBme6yQjBP4rq307Vm4utxlV2
         iLjRDatxyNlLrdRAeZSj00EZ+XFTt0P340zX2SvcSO9WvxgHSYmn4qPrxUmDjmLq/Kl6
         ZtiQ==
X-Forwarded-Encrypted: i=1; AHgh+RphNsZyqTI2WVIFI1v3dF+5Ntj3uoucTfepGVX9dLdx5BX7oBltL8Ls8inxVKE7zF5V/15oAQ8=@vger.kernel.org
X-Gm-Message-State: AFuF++m3Jyns/qK4HQky0Up7oXlvg7tL51BU9RzQEepOOIEk0DsUdVze
	CubUvyrn/muQ5F2B+roalk7XAMfZzXGiERa59fL9PJ7aHYW9xS2CrG13
X-Gm-Gg: AR+sD10Vyzh7MgJsnqGJFFJ6upREd7xLdEt8n0KnfrQ1EjZeCgr9PinWWKRz/MyUx5z
	na9zbKgSX2X1ZHlEoxp62En/cTbf2IQnNBtg6+41AIwd3V/Sl8h2mynsXpZ7CRW/OMahBsoVnO0
	ZIY2+cdDQjdMXPR0z6fjpKmoj6DhbcE/3thkhkEBuMMvHV06qFz8AcmNCMSBag5SfA7ESviJBpg
	8m8ubUGBQ3ePIjcv4nQIs5IuNRQFCTo9iLf6CV+QF5OmKQqwQ4RqCFgdDNxgmHoW8f/bkGVxQFb
	QQ4efMi2+qN6a73QXE52s+TonOjJIx9316mTElu38ACCUNPgIjNQYX0QAzhzvdXrAiAeqlPxn3P
	K5unKagrJdfOlVA3v6vNoc0wNyYFoPxXyVf8i3fWW8LdqlrX7dIlH80ra59xTxj8xTVVIBVZs3G
	o8rpgDaqFMufHvXEPR/QxC4mOEP4+j2i2VLq2fvv+sKbgtV3bnUOcVrW+DCl0=
X-Received: by 2002:a05:6a00:1591:b0:857:73c3:4467 with SMTP id d2e1a72fcca58-85bcc75002dmr4811294b3a.22.1788274925534;
        Tue, 01 Sep 2026 08:02:05 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:05 -0700 (PDT)
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
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v3 01/10] net: stmmac: move XPCS lifetime management to platform drivers
Date: Tue,  1 Sep 2026 23:01:01 +0800
Message-ID: <20260901150111.141037-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901150111.141037-1-coiaprant@gmail.com>
References: <20260901150111.141037-1-coiaprant@gmail.com>
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
callback is provided by the platform driver, the created XPCS is never
used. The phylink framework requires select_pcs() to actually return
the PCS to the core, so the pcs-handle property becomes effectively
useless without the matching callback. This is confusing for developers
who expect that specifying a pcs-handle in their device tree should be
sufficient to enable the PCS.

Second, and more critically, when stmmac_pcs_setup() fails to create
an XPCS (either because no pcs-handle is present and no pcs_mask is
configured), it falls through to the else branch and leaves
priv->hw->xpcs as NULL. This will silently override any XPCS that a
platform driver may have already set up during its own initialization,
for example in a pcs_init() callback or during probe. The platform
driver has no way to prevent this override because the common code
runs unconditionally after the platform-specific initialization.

After commit 93f84152e4ae ("net: stmmac: clean up
stmmac_mac_select_pcs()"), the common code no longer falls back to
priv->hw->phylink_pcs if select_pcs() is not set. This change
reinforces that each platform must manage its own PCS life cycle
explicitly, but the XPCS creation code in stmmac_pcs_setup() was not
updated to match this new expectation, leaving a gap where platform
drivers have no clean way to take control of XPCS creation.

Address all of these issues by introducing pcs_init() and pcs_exit()
callbacks in plat_stmmacenet_data. These callbacks give platform
drivers full control over when and how the XPCS is created, configured,
and destroyed. The common stmmac_pcs_setup() and stmmac_pcs_clean()
functions are simplified to just call these callbacks, removing the
confusing and error-prone XPCS creation logic from the common code.

Platforms that do not need an XPCS simply leave the callbacks as NULL
and no change in behavior occurs. Platforms that do need an XPCS can
now create it with the exact configuration they require, including
wrapping it with custom phylink_pcs_ops when necessary.

Existing platform drivers (intel, rzn1, socfpga) are updated to use
the new callbacks by moving their XPCS creation and cleanup logic into
pcs_init() and pcs_exit(). In their pcs_exit() implementations, the
pointer to the destroyed PCS is explicitly set to NULL to avoid
dangling pointer references.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 44 +++++++++++++++++--
 .../stmicro/stmmac/dwmac-renesas-gbeth.c      |  7 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-rzn1.c  |  7 ++-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  7 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 37 +++-------------
 5 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index f5f9fa67ecd77..fd5f01c8941c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -603,13 +603,47 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 	plat->mdio_bus_data->needs_reset = true;
 }
 
+static int intel_mgbe_pcs_init(struct stmmac_priv *priv)
+{
+	struct fwnode_handle *devnode, *pcsnode;
+	struct dw_xpcs *xpcs = NULL;
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
index afe98ff5bdcb0..d2f77f0c223a7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -426,36 +426,15 @@ int stmmac_mdio_reset(struct mii_bus *bus)
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
 		return dev_err_probe(priv->device, ret, "No xPCS found\n");
 
-	if (xpcs)
-		xpcs_config_eee_mult_fact(xpcs, priv->plat->mult_fact_100ns);
-
-	priv->hw->xpcs = xpcs;
-
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

