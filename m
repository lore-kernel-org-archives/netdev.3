Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1133A6F06
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678055; cv=none; b=ia6a6tcx5nSw8LHnW0epsjFQ0lJVs76lxGO8gsZropdX/9bTo5m/I0yEIr7kWDGz3iyGk7NKUxGxNFo1jk5Fkq4xeiMzmUTwVtbOwm46E+IJAZlVhEeddCX1Fx+7hLgzeYbV85fvtp6mziaU6jGj5PGt5DzxZj9paice5r52/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678055; c=relaxed/simple;
	bh=kq0vt9SckJqy94uGlHWiGVuBk0MckU/fwsg6pcjJXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuF0LtniGedo7cToEObEvX8t/QATI7p9q4PANbC3TUUoRx+p6YhM6KTVjRLHY/jT2sF/HNAA3eJD2zV/AaiVcTgdlyqaXu4UvzfiyyAw/mU9JS9fS8aALaCJtyb8EVcGaNbqnH0oR6R8525t4NmHXcIpYgmXMCBx5Yz7rA53skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJTc6Yef; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJTc6Yef"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a384b5f7so56271a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678053; x=1790282853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=kJTc6YefspVjC8YJvzw5AWp9n/uiBUxkQyJGmCUg7SLoNcbafb92w4VfxxELAtg8K0
         wwjc7mU/rCO81ZaEL/V5xBpjFO68uMJRapivuoA4+DOARH+22doKWMJEWZLmd/a6vFbZ
         SPVyUrFMW1pY4ZamzmLbXAg1n3XpEq6zKWA9rruWP8a+hL3DA80nwxhQf4qL9rU8pb9l
         deh0LQ0xt173rpVAnT4+ZzzKmrXlcx/C7O5mdDABxQ6T41CuGwDI4Wfpgp+DNezFCqmf
         aadPrlTgnNOFE9mURiCUMG05Fv4aZxm2zEB20O6hN9xGsp5M7TFH6bpPbQ1WLf3Ir4lk
         6f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678053; x=1790282853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Rz7MTGiT2Oa/TzTvQEqnIct/KOrKk64RBkMgo9sxQM=;
        b=JbsKFZLglVAPvZbZmTCFW34WrdsGMHmNmXoVsbOvZZcMD/StGgdZ7gVW0MaXNHWhvM
         bnE1VdDL2zqHbMTVUBTxU1Xhg0zuneTf+0uw1MrRI+0PQwXnoCvNKGQK7t9olb2CDCoI
         tRyo+0E1wPXdoEoJwsdAgPw/7CuPxE5lqh4dLKrxDLLqZrc4wqREyF/QtSBxqsSryYyY
         hQmMafcM/n9jA6GZcI8K9DSgGRuMj1KYoWd4BjGqGnW9Qeugm27kcee/37vZUkJneGKp
         Crrru/Kkt6BxnUV2YCA2r48Zj64MpJSJGG/Cm3Bm0/k6rnU3V+oWzqwU0xoVWSC6KP0+
         mmKg==
X-Forwarded-Encrypted: i=1; AKwUvBz9ROiaD+cTVLnUCejBGNNTqzEQwnfy5Auyfr1VDi9rJhZifn+qCrlDqnt6PvIzkTJx9usny3o=@vger.kernel.org
X-Gm-Message-State: AFuF++l8CwXZJrv9kdhTcY2niD0CtxAWkDaoL6J7x3AlZw1+ZCjc/bCL
	LwuPqOIDzJxADEYS36ieQ0U9urUlxfCOG/EUovNPJkJlDE48WMMovDA9
X-Gm-Gg: AYBFou3JgxH+Ck/kLW96sXOyeO7CEA3mY9OeCRm4VXMmccSpmYAgXTiNaxdKNcmynTP
	ca2Umo7kC4c0Txpp1xiNEXrrrv1X/0kZeFYEco6X8pFGIZjVUGcHqbuqTurHb3RVfGQtorkoA6J
	/KvLjFvfuppiWXTtxWEmEfbdTmSbblXp6JipjUMR4ZZkO5xLSCvdn6m6uD98g+OwcVnVtutXxPJ
	qDV/Bdaz90A5XJzeE64Gl2evuhFV9D8Z5MRAmKkGm+XEUt6EzFMVI2pfL1Sse7yjUSSRgUHii0y
	k8TI+hUhvjI1tmohWXVnqpR94zZESCG2bIG5u1gUB/8LCTwrER/O7hVYbpUFkKlAq8DXZ+RprD9
	4fFR/wU2RCRctAA7+77rXwDgWnrzfflhcFhBcPyxHs4JJhRHuCyzE5fBSb4b3xH+xqRDVIW0liT
	An/0vytFsFjN3L/mjHyonZEBkyqPitUQhoPXO0XMTFqhQSeg+a+vyNeL9lAgqmoYMk8klIug==
X-Received: by 2002:a17:90b:56c5:b0:39d:f95d:bd08 with SMTP id 98e67ed59e1d1-39e55008a3amr1261148a91.14.1789678053238;
        Thu, 17 Sep 2026 13:47:33 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:47:32 -0700 (PDT)
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
Subject: [PATCH net-next v7 03/11] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Fri, 18 Sep 2026 04:46:14 +0800
Message-ID: <20260917204624.2427486-4-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
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

