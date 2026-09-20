Received: from mail-pz2-f2.google.com (mail-pz2-f2.google.com [74.125.228.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C3515D4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923756; cv=none; b=gM1YgvZKNEAUAJYCtt5iSd6BS2i8MSOldiWuB//EB/PiwP/UBR87+SPJlWOWE67ksjwL0cQoU9rJsY4V9bW+YKoWOZtMK2sJb45PC7TaPMJSni0C4NZ3S8ztQnsXVfiHUHad6NLtgbueWmuIwai7ro281dwEf57lGZzKzcGdpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923756; c=relaxed/simple;
	bh=kq0vt9SckJqy94uGlHWiGVuBk0MckU/fwsg6pcjJXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipr/Rf6bU5XcXxKS/XmvVmzCCL2NkG4ZPHBOlFC169/eIZvR8KZksIg6OysWhImLLH6cnEfSxRMQnxAhq4ibstktTt+HxlqJWC7INizR+5B9OVqvTkSTTY8QmovBqXuB1EDxn8zNers98sUu+TUZa4pMo6oM7KvQA+5UKOUXYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Kj9Ksc; arc=none smtp.client-ip=74.125.228.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Kj9Ksc"
Received: by mail-pz2-f2.google.com with SMTP id 41be03b00d2f7-cc4c181b42bso1622617a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923754; x=1790528554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=g2Kj9KscFoyJYRzVRZmyzi0QT6d6oeV4BLGr13GOm+HyQf2pW94rnXndqfB4MUCtwT
         sHS1sNybLZW6eCT1+HiUwMBdVVaC2Es3MGRk3TJ+c77PuDN1KBWNSz7j9wMMQTHuzpOd
         Xd1sTShyadbCVcLQU3IQhOhJRUFWJML2M6iR3nSuixyOFmXmc1IswZBVdr2KqchNXTI3
         L74Bu6FSsIJWcdf5Bffs4nblExl0zSG7cC3A3ThfiDmzJ1F8DpV+Asw3IdO1BhzrvpAV
         iQhHAFw3sdGGf8RQ+bko7ChPD9JOPpWFZC5HOMnQq66wiR2MAwIlvI7E/d/I4T7Yz9Xx
         84+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923754; x=1790528554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=jMcBsUXser54wrcvR6qGO/SmtJ9mYqLV90jMAkVI88EtncmFku1zKwrHvLry5lgIz7
         wCHf17JqijbtQmSLspOI3bKfCFTgbMncIeTmUYrYnc2y4i2gzjcuUWfSdViB2WZAQmts
         ONAZAZb4OzRgvrcQcuaLsh1ydGqGNH3G0pLa9OBNjQ+deq6QLehtxTX8wi5o4+FGQEAq
         npkOVE9K11tkgBSBh767JmrKkMhR5GPEPPp7avxNyPdVgmkxd4I/9UpuEMVLoAfJTzpG
         XTpD9xHncsjH8dPLDtacZpoF3M+AYIVWEvdNn22BNLjLgvW3D61tnQfMYProYPpzEjWn
         XJVg==
X-Forwarded-Encrypted: i=1; AKwUvBxdMhR8M4Vj9Vmv0aSk1pPvw4F52nZQVH2mJsnWg/GjAhKJEOSQqcm4GaaQwJimkrl7HsGTpc0=@vger.kernel.org
X-Gm-Message-State: AFuF++moM/mDZZiLuOmfvNMKR12hrWgTVWIRIovZAcKeXTJJUedoA3eE
	BhBU61XbZe0urSlb2jGxJ2XtOCIyVYwqBX7hDRAMIDUS5GowDY4rIJUT
X-Gm-Gg: AYBFou2BBYVxOnfTjJeLpm2v1ctjV8K1Slpe3zWeHkOO2EtisLsh55K2ZC0KOxqFX8r
	W3erTOenCTTYtszMNqAS4PlqBhi6l4021w98iHcCVtDPYW/RFta9IPpvbQ5aaRYHiYjxFPxjrGs
	Bm1K8UPJ+i/mvfxE5siAI7pMgF04LgqBFHe5suxE9U28PbsTvl9U3KZNNOT46/ySFSQ400f4E36
	egaEsdKBEbQtk8zS83m1Xq0i720MpKx+xkIbgNEKdPE6Qwetq1a6gMVnnqXsGDbyWNwKg8joLo5
	JlSaSOxi201BFTQ5LW9w+ZzH/sP3+Kf4BtMpFa69huhjU9H9W9O0+Tnw+gt5T2tyZ5GCaAHEiDf
	UMX6FFjZdPnDjcZUSG8DNG08sJbK917BtfSUl3qwtAcDLumhUvCpfaxlXOG40lVMD31ofDu770N
	UMdNZ7IxfGPOJcVDihDgNhl6YP9baX/oozbJLfxvqdszvK4Ekcanc4rNcFGVBld2fCMP0LgGtV6
	4eDROPG
X-Received: by 2002:a05:6a00:bd88:b0:870:8e80:3ac0 with SMTP id d2e1a72fcca58-874dc7ee0b6mr12066553b3a.11.1789923754245;
        Sun, 20 Sep 2026 10:02:34 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:02:32 -0700 (PDT)
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
Subject: [PATCH net-next v9 03/11] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Mon, 21 Sep 2026 01:01:07 +0800
Message-ID: <20260920170116.3624104-4-coiaprant@gmail.com>
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

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the GRF register pipe_sgmii_mac_sel.

Add support for this selection by introducing
the "rockchip,sgmii-mac-sel" DT property.

From the RK3568 TRM (Part1, Page 229), the PIPE_GRF_XPCS_CON0
bit 1 (pipe_sgmii_mac_sel) is defined as:

    0: SGMII routed to GMAC0
    1: SGMII routed to GMAC1

The hardware reset value is 1 (GMAC1). If the property is set to 0,
the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
remains at GMAC1.

This is necessary for boards such as the Ariaboard Photonicat, which
uses the SGMII interface connected to GMAC0.

Out-of-range values are rejected by dtschema, so the driver does not
duplicate the range check.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 7843356a4dd47..7b867e7520064 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -186,6 +186,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_xpcs_phy_ready;
 	struct combphy_reg pipe_pcie1l0_sel;
 	struct combphy_reg pipe_pcie1l1_sel;
+	struct combphy_reg pipe_sgmii_mac_sel;
 	struct combphy_reg u3otg0_port_en;
 	struct combphy_reg u3otg1_port_en;
 };
@@ -212,6 +213,7 @@ struct rockchip_combphy_priv {
 	bool enable_ssc;
 	bool ext_refclk;
 	struct clk *refclk;
+	u32 sgmii_mac_sel;
 };
 
 static void rockchip_combphy_updatel(struct rockchip_combphy_priv *priv,
@@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
 
 	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
 
+	priv->sgmii_mac_sel = 1;
+	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
+
 	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
 	/* fallback to old behaviour */
 	if (PTR_ERR(priv->phy_rst) == -ENOENT)
@@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		break;
 
 	case PHY_TYPE_SGMII:
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
+					     priv->sgmii_mac_sel > 0);
 		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
@@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
+	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
 	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
 	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
 	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
-- 
2.47.3

