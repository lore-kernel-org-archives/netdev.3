Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFF4472559
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795540; cv=none; b=inWqwLfHWCInMisiW0T6FwCVxi5rGY4stUpTn7LDK3c1WJ3GcNrJC78DUR+AiqCPDCuUV3acP01hREuiFvv57RvXw4IihhErgbMeiyVnZosqHMcRBpaErVZx4SpZFMYxhf0fqHbxYInBgpQCCL7LXjreQFWLtGVFJzKHspYPWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795540; c=relaxed/simple;
	bh=puR3hcsKpnP6vV5Zl58WDpiYi4UfmWoBZ4wnS5ijiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5fWVUCedXg8RJACTsk8w3WhnPw307P4ihPZs/9XMWj62NeaU7reserbmN8F20TWLOyS1Z2mDKhCvTEXEXYK6h5VcGQKWwwAdgFxVhm2S6EcRg6zMEf70FQZVshSt0DB2arua00J7wDjOi7ISbx6MVt+SS+zvCzAwK7fY5i4yZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI3O3T4i; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UI3O3T4i"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964e7720afso2263209a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795538; x=1789400338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3aEYb5uf8Ywd6IPUhePKv9EQrcFVFS6EHQyfufoEjE=;
        b=UI3O3T4iGzvEB0cILW/TGWfjP1gZkN+8K9avsCp2k3PxlaL87Z0sXRCcyjATTVGV2M
         D25350fBCJ0qbmnqsn9ioibB0qbFi61Ly6ahxG+2m3Iw2stOhk5ptmJBqykA495Rt4TS
         M2shMkaDqhbGsqBi8hKQZo9TQ3x/FOt7eQ/rIvKy2yUGUYvc8gxzBDThx9avhpaj2jpb
         dArJVJfwa0jmjjxoeLyCzm/fK0Ovv4f58kseyr432H12HAXVooZY7/TzN912ws5nS3Hc
         MQjk5Grp5T1b67B23yxKqUI7IYuMj2/Azjj1fZVFTpDWraEvVti+EYuIqD45tpaiGRvB
         qVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795538; x=1789400338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3aEYb5uf8Ywd6IPUhePKv9EQrcFVFS6EHQyfufoEjE=;
        b=aaQS0A91zzmXJVQy1KNdpaVVw+WpnIQdb7AUZAnHt1X7coDO9FBMfGU2/gwGrv2Kvn
         3L3o29UxyzmoiEPfXt1kASAIVfZGCyi4O5+Gem+ty/aN5iczeXkVhRdB3Ky5YSD2MpIT
         9IT/pJwz9/2Od537jg2qnPcPgJCMocCMjyRqk8GQUhik9VFgJ4GKaUpuC/79+O53H4ja
         3WtCcfd0XMB/HKr9rv1kJ7PUAdXNNNwqffN2U7Q8GGtVkgx4Jc8PAEqXvBnS355aJI8X
         93utUT/G+qYypM8eERYUxhy/T1lo5PkB5laziYINcDlDD35tN4M4TOJ3zyeq0WJ1xuum
         C+RQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7LFQDeBTgmFp+Bu2a6rVntBNMOAYvNAadaa4vrusbvibjqZObEFZY2zova6kZraFWONmMszk=@vger.kernel.org
X-Gm-Message-State: AFuF++lybFSNiFPxW+cuQqqYP5cC94J7O/3vDKz4yh6byGoICze927iZ
	fo3UaxXT/srrY5Y4VavZTY6HCCILZARWhOfKKblQStZs0dr5EPzBlNE1
X-Gm-Gg: AYBFou2wkGmtPXN3eM9hX/2BWxF9a/hCAmNjoJWi+uEXN9bvt7sXrmiXS+HsrYOPzwu
	OUWmH8QDxqaowBS5ACz0kSkBEFlfmvZceeCRY8J9UFNGWOwFFYgGZsnLS7cnw09URLNayidqVt7
	+V/4HJxMTWuLhQBR1LcaOUrK4o1CSghlS4i1OTdQVH2h7yVCjyikFcHnZbdJ8nwAtUt0pgALrrX
	sTfYWKjHIJsDmQv+/YFJC3FdvLJGN6MJvuDjyYco900jzfbDXEEWo5/4o3+n62jToITqbmqmxur
	cZEPKCTq+E0SRgYEVQUZJx6aZlyqddPuPGCTEBWOIUzwJ9Ea9dw547YFZO8UqnttNUqxXZgkI2L
	83FNLPbSUU+FPZLacko8IKMP3OdnfgZ7LnclGCnGK7Uv8sYofC3vyV1Kf9ymRLiXgCe6eXHG7xD
	8AId2LJd4qflhjNRgYI/U3gAWWZJLVRuIodcjiSvElRYuNJu/rE1PAy6xeHeq1
X-Received: by 2002:a17:90b:5106:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-39b260feb03mr34662494a91.4.1788795538351;
        Mon, 07 Sep 2026 08:38:58 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:38:57 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/10] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Mon,  7 Sep 2026 23:37:06 +0800
Message-ID: <20260907153713.2572547-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
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

