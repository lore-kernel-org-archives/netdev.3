Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3303BED2D;
	Fri, 27 Mar 2026 08:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601074; cv=none; b=qnLHCGtU9s3eMkBwS1vMq4kSsONTJqzHSn2oGNpep+YeL6VI/ha2jSeVJ9zbJZbQaK9J2ga9f6AYzSqgBaxd+Z/5aCl+bfllnSV/bc1GP06Qjyh5CpHYiRjX3/ScqLDHJksk8TWxNXusrcAjzsbjIvokKKnILRRrGg2oS5JG91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601074; c=relaxed/simple;
	bh=CxrbsCQ6XuKFJHXrUMibTBWs64fvzQGZkE6IpAkR5Ak=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=QJn/D2ibSumhU9+aSbkWFBW1fAP6x+otbhQSXwITpffLp4p7Q23YIAkA4OEzTnbHlsjjh3e60L7s8r3SIwT+O78+NgJ7Dcr7SwU7J5Cr1/dABXVcpDhWfLCFV7y9R+zNKosMrBAc7HXy07nJSCBsXQbpQr07gHbUknP2zxXExrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l8WxvpID; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l8WxvpID"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0vrlqWAvzqtkE7Yq3Q3lXBFXSsrrLWdunkj6F4t/aJA=; b=l8WxvpID/4w74usGue7jxKgtBS
	hDIhK8BL2FaVWpQFYZAaaN+BepKlx7Bon2k0rBwrh+ZNG5SBmH50lVJfKMHv/0HKanalkzN6ByF/o
	jFjHjK9WEpKm5vZQIiZfdLndeUYTLqkdvfzBUbd3PEj3Pm8Xw9PQMM18SoUp4B5XArqQk19Ifd6V+
	VgpnbgpbTJvlmplMwXo//FVawilXm3ijfsLsx8aEemoQBgiZ0uMNVo4fVlrxrVNKu5py9r/a8faje
	FMlmah7LD30i5Q8X5Z7exStQaSoOZ4YXzVDfwlOsqb18RmH7GBbcd87eshhRnUQhSfFPiutF0lM77
	SMMRjjZA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56498 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w62nl-000000005rJ-29xb;
	Fri, 27 Mar 2026 08:44:21 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w62nj-0000000E3Cq-1lPL;
	Fri, 27 Mar 2026 08:44:19 +0000
In-Reply-To: <acZDEg9wdjhBTHlL@shell.armlinux.org.uk>
References: <acZDEg9wdjhBTHlL@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 11/15] net: stmmac: qcom-ethqos: finally eliminate
 the switch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w62nj-0000000E3Cq-1lPL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Mar 2026 08:44:19 +0000

Move the RCLK delay configuration out of the switch, which just leaves
the RGMII_CONFIG_LOOPBACK_EN setting in all three paths. This makes it
trivial to eliminate the switch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 47 +++++++------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index b4c61cb24e1d..7690ae0bb008 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -444,8 +444,18 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 		rgmii_clrmask(ethqos, RGMII_CONFIG2_RX_PROG_SWAP,
 			      RGMII_IO_MACRO_CONFIG2);
 
-	switch (speed) {
-	case SPEED_1000:
+	if (speed != SPEED_1000) {
+		/* Write 0x5 to PRG_RCLK_DLY_CODE */
+		rgmii_updatel(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
+			      FIELD_PREP(SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
+					 5), SDCC_HC_REG_DDR_CONFIG);
+
+		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY,
+			      SDCC_HC_REG_DDR_CONFIG);
+
+		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN,
+			      SDCC_HC_REG_DDR_CONFIG);
+	} else {
 		/* PRG_RCLK_DLY = TCXO period * TCXO_CYCLES_CNT / 2 * RX delay ns,
 		 * in practice this becomes PRG_RCLK_DLY = 52 * 4 / 2 * RX delay ns
 		 */
@@ -460,39 +470,14 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
 				      FIELD_PREP(SDCC_DDR_CONFIG_PRG_RCLK_DLY,
 						 57), SDCC_HC_REG_DDR_CONFIG);
 		}
-		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_PRG_DLY_EN,
-			      SDCC_HC_REG_DDR_CONFIG);
-		rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN,
-			      loopback, RGMII_IO_MACRO_CONFIG);
-		break;
-
-	case SPEED_100:
-		/* Write 0x5 to PRG_RCLK_DLY_CODE */
-		rgmii_updatel(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
-			      FIELD_PREP(SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
-					 5), SDCC_HC_REG_DDR_CONFIG);
-		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY,
-			      SDCC_HC_REG_DDR_CONFIG);
-		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN,
-			      SDCC_HC_REG_DDR_CONFIG);
-		rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN,
-			      loopback, RGMII_IO_MACRO_CONFIG);
-		break;
 
-	case SPEED_10:
-		/* Write 0x5 to PRG_RCLK_DLY_CODE */
-		rgmii_updatel(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
-			      FIELD_PREP(SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_CODE,
-					 5), SDCC_HC_REG_DDR_CONFIG);
-		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY,
-			      SDCC_HC_REG_DDR_CONFIG);
-		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN,
+		rgmii_setmask(ethqos, SDCC_DDR_CONFIG_PRG_DLY_EN,
 			      SDCC_HC_REG_DDR_CONFIG);
-		rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN,
-			      loopback, RGMII_IO_MACRO_CONFIG);
-		break;
 	}
 
+	rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN, loopback,
+		      RGMII_IO_MACRO_CONFIG);
+
 	return 0;
 }
 
-- 
2.47.3

