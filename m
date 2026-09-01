Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89A3D8100
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274951; cv=none; b=VxZMHFRCEZADLp+qcZe8AcWBFXdJWvWA+ySWrNl0qOD8JSqN66GSBPxH7NOnDu9JyiHbhAF5bKUbwea3dTC6mLaLk+DxGYD9KgCD1knwoBP87VJsgjVQIac2s/GjW5LMcZN4Qhk9dwvSvz0xuy1EKgBBIBk/JAwxQYejSPjq6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274951; c=relaxed/simple;
	bh=puR3hcsKpnP6vV5Zl58WDpiYi4UfmWoBZ4wnS5ijiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isUJ1ezoYSSaJ65NfqDQUjtTB41EVbmwBlQJV2jsEVv9BJvdUb3oF5sM/oZd4+H4lgfTAgMi2aVjpwNCjtwfsFd97CAoaLLliiCFyP68IU4NjYmO8lHwIzYFgpvThBuu+06FddwCBTW0OHDSj04bkrz1BKm8Ys9DrnS9PMlv0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dthL7zDV; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dthL7zDV"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1cb94b583so433184a12.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788274949; x=1788879749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3aEYb5uf8Ywd6IPUhePKv9EQrcFVFS6EHQyfufoEjE=;
        b=dthL7zDVS7pmd54Q7GgVU2wElDdRjieQ3QHvheiQ2d82CJYJpd59OCM83qDHj5QOiB
         RTrg2ESpMaXLWcr8UB9dBhSLWBD4FwyhrntiU550oZ1Kt19tZZYFNOrXKM/J4cWVbvQq
         zkMOWaTyYJPYb9Kr09MoGrsSSBFsNndQ2VoMSkaW9+jh9lJ+c9qn27RfsekWWaP1GOOl
         RIxOYGv+Gvy7sUyzoSU5wpeC89Ic1lL5XZVsmnjHIgBIkRpWmwk/PG1xP+j7hw7IH2Y/
         OOEX28ElK26XZITXwB3xxcmJMeU/FD8ur4/HX63kLUPLaAlFCz8HYO+iq2QSXd9NMfW7
         ukGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788274949; x=1788879749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3aEYb5uf8Ywd6IPUhePKv9EQrcFVFS6EHQyfufoEjE=;
        b=NO6jr+tego1qwwzakcHSMFa8QP3B2LWQcH6Qlbn3aLE0uoraaFZK5lpZr4JoeW3R/y
         0CQ9Mnrx57AKYeqAUEPu/jOTKYlZucZOHSXQcQy33ApTcLljjb1Zp4GLcyHNXQUYAJuw
         H33jhFU2izNAUcnNmCdtCgPfcKK6U5zIeaVz8o2Jr5nV+GLIdnK+ThcIgKfhYT75Odrk
         BeL5+EeJFzzvaM3Abivx0x9nUIDYDpHt7RMA05uIXj8OPThRBtbsb/fN504c/Sv7jQRN
         /rzC0WuYhIbxG5TYCsCGKFCHaiSdQRwCXx0+Pdj7jO+ZiXpa1aGe5y0BOwRiLfNeTfKD
         hNdw==
X-Forwarded-Encrypted: i=1; AHgh+RqzI/OKz5MUQ61YkPGRJR+trtX4a+rbvQVlL7IlnMB5Mn0e6EEwPAzcB66utyERMNB1GuHfFWY=@vger.kernel.org
X-Gm-Message-State: AFuF++mRpc/pG8OVQfxFkV5Adqlq8p1rDBv8o5p8ySoSm2j72+Ddmpzz
	QH6M9AS/4umKDoM2nELH3/xNuxuMr60GfRgXooQ5nRugjKWY2bIdQifM
X-Gm-Gg: AR+sD13zDKrsuAa1P6E6SgCrxnMhDrv9s8aCsJ++ObvwVX5Q66kJOsxXKPFpJUR9UIW
	+MNW2rhKoRPVeHs7svNO83zq7imEQQY/2LSYmpAlQdaPbLLwnxjBK7L93+QeGhxzwXzpM13qE6d
	D49k1VICpkHD0fLN6TCB2Cai6ap8RZV6XLeiXhWYshOeJPhdMHi2u7lWvQBiwwvcDH2NkWOvLg3
	J73cV7y6h9GXBI7R9hjZr+cJTmX40MN26CGoOMu8j05T1lXedr2iVUT1ntS37tva058flxmyqx8
	OodRM0n+NYJyhKewQaBo8OuCxb/NRfrYbjdkTCFohmNpBbTFsDk6jekOja0qQyMuoWRpT6D2FGI
	/YVrSNUJ979CUNuqPhL5usY/AVQVY/JyPNTcVDlPuY6DiCnFpLsQkE+VcKHWT15W5XDjOwHth9e
	7KKKq6VhefY5Q3tWkJq7lz5LM9RhbGa8ZqtRDFx+1zBB6HeHeMS3/1zO4gymQ=
X-Received: by 2002:a05:6a00:b46:b0:848:30c3:45dd with SMTP id d2e1a72fcca58-8562b499a35mr49867000b3a.11.1788274948514;
        Tue, 01 Sep 2026 08:02:28 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0716846sm27914b3a.45.2026.09.01.08.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:02:27 -0700 (PDT)
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
Subject: [PATCH net-next v3 03/10] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Tue,  1 Sep 2026 23:01:03 +0800
Message-ID: <20260901150111.141037-4-coiaprant@gmail.com>
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

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the GRF register pipe_sgmii_mac_sel.

Add support for this selection by introducing
the "rockchip,sgmii-mac-sel" DT property.

The hardware reset value is GMAC1 (1). If the property is set to 0,
the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
remains at GMAC1.

This is necessary for boards such as the Ariaboard Photonicat, which
uses the SGMII interface connected to GMAC0.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 7843356a4dd47..919bb97a4b182 100644
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
+					priv->sgmii_mac_sel > 0);
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

