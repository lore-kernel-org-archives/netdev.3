Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881AD1E7C2E;
	Sat, 25 Apr 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086834; cv=none; b=n/1ZG8YFOyEtTmuY+4mu9DO6UHz4CRQBckqUNoSKbROseOqOzShd7Cxmd5Rli62e67dNPnIrXFECjzZnIVHYrFjkbbJ9hlUSLpva+fxZc9CT0sJDHm2QLz4WT/PMsprWGDnRH5VcDPE50HQdDGKoWEPKlfnjQ5noNBV+oz+D5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086834; c=relaxed/simple;
	bh=FQ72pww+/mixe+xBJtMa9I53y5V5rMN/mewcLI5MWIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGcly07G+zBWnAwdR2PeNxhh/OHMs+mXI9p3QVXMgU89QOq9uyAynWn0zE3BsABlHa8myrBthkHLxiq/he/vKD2mIcOs0IdC+8Tm7XAVcBBa0uvW7vXFgHfIgvj86WXuWoEb5W1I5D+dTo36UcUy+3kQoH5aV2DKItWvsBpWkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=dnwS4JhX; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="dnwS4JhX"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EA9410EE14;
	Sat, 25 Apr 2026 05:13:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777086830; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fkqO4m9zwMQAmeVjatzOo9rF5vxmaQn0sZxz2wcS6ws=;
	b=dnwS4JhXsHPe+6oPmfMIXy0mxN8VbmcZWg32KkWME4UF8B/RBIM/vxJp+MRnc0+IdQOc5I
	/RWMSyfetKu4U+luOWYmZNa+zgAK/neSPLf9se4UJQPWo3pM477862JCQRLKpdn9QTug0I
	47RNQogzxDOh/Gt8RXSJwf/tyknqZlOKs8s/tQ6mkuvMGJ6U2O33w3oc9TZxq7TRlbaN0s
	yVPBj3jLtpFxo/sI4gCrzG3tXwuCiaWWvyGgezcvFus79ejES97YbPV80oHa7NPfHjdJGd
	d5fDEg+VQXa6N6TgPESmr8RYNN1/52xE4dpc/Vm3Mx+ibrgavA38tzY+8E102Q==
From: Heiko Schocher <hs@nabladev.com>
To: netdev@vger.kernel.org
Cc: Heiko Schocher <hs@nabladev.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
Date: Sat, 25 Apr 2026 05:13:39 +0200
Message-Id: <20260425031339.3318-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Table 7-121 in datasheet says we have to set register 0xc6
to value 0x10 before CLK_O_SEL can be modified. No more infos
about this field found in datasheet. With this fix, setting
of CLK_O_SEL field in IO_MUX_CFG register worked through dts
property "ti,clk-output-sel" on a DP83869HMRGZR.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

 drivers/net/phy/dp83869.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..96a7d255f50f 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -31,6 +31,7 @@
 #define DP83869_RGMIICTL	0x0032
 #define DP83869_STRAP_STS1	0x006e
 #define DP83869_RGMIIDCTL	0x0086
+#define DP83869_ANA_PLL_PROG_PI	0x00c6
 #define DP83869_RXFCFG		0x0134
 #define DP83869_RXFPMD1		0x0136
 #define DP83869_RXFPMD2		0x0137
@@ -826,12 +827,22 @@ static int dp83869_config_init(struct phy_device *phydev)
 		dp83869_config_port_mirroring(phydev);
 
 	/* Clock output selection if muxing property is set */
-	if (dp83869->clk_output_sel != DP83869_CLK_O_SEL_REF_CLK)
+	if (dp83869->clk_output_sel != DP83869_CLK_O_SEL_REF_CLK) {
+		/*
+		 * Table 7-121 in datasheet says we have to set register 0xc6
+		 * to value 0x10 before CLK_O_SEL can be modified.
+		 */
+		ret = phy_write_mmd(phydev, DP83869_DEVADDR,
+				    DP83869_ANA_PLL_PROG_PI, 0x10);
+		if (ret)
+			return ret;
+
 		ret = phy_modify_mmd(phydev,
 				     DP83869_DEVADDR, DP83869_IO_MUX_CFG,
 				     DP83869_IO_MUX_CFG_CLK_O_SEL_MASK,
 				     dp83869->clk_output_sel <<
 				     DP83869_IO_MUX_CFG_CLK_O_SEL_SHIFT);
+	}
 
 	if (phy_interface_is_rgmii(phydev)) {
 		ret = phy_write_mmd(phydev, DP83869_DEVADDR, DP83869_RGMIIDCTL,
-- 
2.20.1

