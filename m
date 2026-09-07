Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F44AA003;
	Mon,  7 Sep 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789143; cv=none; b=ENSFUo98+KrthH4ARwmDsOCco634wtuabDWtfidY8YgMMfiPcQFNXSItltrcC+kMsp8tH45V/ORkULEQzpKK4Yc/XwOLVkvMBvfRL2W0PMbJ2m6hxuw0KbVnojHVdduRA1EKGVdd+TCr2BRn2d8Qgl3W/Oze/sWYUucrQzHnpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789143; c=relaxed/simple;
	bh=n5mHZO2dtuZjdZ9S9QtPa1SGWE5JjpGaKWTuV8yEV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kObZgV70H8oc33gRLx72D3/UgQeM97QvtaDZoomxrx1TdgYcSnXJ6lmZq02aCxSj1kAiNizK2ANRlkpf+gWQOBnefH4JEkV3C2dAS6En79/7iIm0q2EzV2fvikxe5g+O2iOwAodkEzXXOR5F1jiUS89f/pB2Vcg9ic2XuSdbeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=GLpYcuvX; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="GLpYcuvX"
Received: from email.seznam.cz
	by smtpc-mxd-8df7dc6f5-w2xkj
	(smtpc-mxd-8df7dc6f5-w2xkj [2a02:598:128:8a00::1000:a0a])
	id 40e0e4c1c0078e5c4294daaf;
	Mon, 07 Sep 2026 15:52:16 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788789136; bh=bhyTkY15bsw02prmRZjnmef4XjP33gI3tw1ZFD52sDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=GLpYcuvX8CwDeRo0LpSsYh9YZ8lGeYZ/iaEhAEX1iUJGqXcEtwOd3mYpkigQeIpBI
	 Sx6mSayRpD7d8IS0eYahizMMNvSJC/ZPDKsf7GDqIF30NzhHz9wTC6/iarVKz5yLxp
	 e/jrjpzZWE3gF0v7ubkVUYUqedHVLGCUqGpRlfMYHZxGk84bvMCXx3hG5BWFJqs32s
	 ne9hoeMGJWFvjpkuqTEb3J2VOL1agmu0n8oVbxP6l4hHDGpXgEb5RFciV7EgxJNSbr
	 12tM+TtZdM3zzGxPCl3hoTzMy8fBsYbBAkKyr+PgzFnza7IhfEQXDBVJLRh0ctcOtu
	 ExoDSmQYdLsKQ==
Received: from arch-zen ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id b95f2925-7f48-4fac-8166-846b8cb56ea2;
	Mon, 07 Sep 2026 15:49:46 +0200
From: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jan Havran (Advantech Czech)" <havran.jan@email.cz>
Subject: [PATCH net 1/3] net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
Date: Mon,  7 Sep 2026 15:48:16 +0200
Message-ID: <20260907134818.16670-2-havran.jan@email.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>
References: <20260907134818.16670-1-havran.jan@email.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gsw1xx_pcs_config() releases the SGMII shell from reset via
gsw1xx_pcs_reset() and only afterwards programs NCO_CTRL to select the
SerDes clock rate (1G NCO1 vs 2.5G NCO2). The chip boot loader uses the
other order: NCO_CTRL -> RST_REQ -> SGMII_PHY_HWBU_CTRL (GSW145 data
sheet, section 3.2.8, table 13).

Program NCO_CTRL before gsw1xx_pcs_reset() to follow that order. On an
Armada 7040 board driving a GSW145 whose switch comes up at 2.5G (pin strap
PS_SUBTYPE_MD[2] = 1, pin LED42 / PS1 bit 14; GSW145 data sheet tables 23
and 25), a 1 Gbps SGMII link only carried traffic with this change. It
matters when the rate the switch is left at - by the straps or by the boot
loader - differs from the rate the driver selects, which is likely why it
has not been seen before.

Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index a1104b2f92a92..b8d8fefaa3a15 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -352,8 +352,22 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	/* mark PCS configuration as incomplete */
 	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
 
-	if (!reconf)
+	if (!reconf) {
+		/* setup SerDes clock speed */
+		if (interface == PHY_INTERFACE_MODE_2500BASEX)
+			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
+		else
+			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
+
+		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
+					 GSW1XX_SGMII_HSP_MASK |
+					 GSW1XX_SGMII_SEL,
+					 nco_ctrl);
+		if (ret)
+			return ret;
+
 		ret = gsw1xx_pcs_reset(priv, interface);
+	}
 
 	if (ret)
 		return ret;
@@ -423,19 +437,6 @@ static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 		return ret;
 
 	if (!reconf) {
-		/* setup SerDes clock speed */
-		if (interface == PHY_INTERFACE_MODE_2500BASEX)
-			nco_ctrl = GSW1XX_SGMII_2G5 | GSW1XX_SGMII_2G5_NCO2;
-		else
-			nco_ctrl = GSW1XX_SGMII_1G | GSW1XX_SGMII_1G_NCO1;
-
-		ret = regmap_update_bits(priv->clk, GSW1XX_CLK_NCO_CTRL,
-					 GSW1XX_SGMII_HSP_MASK |
-					 GSW1XX_SGMII_SEL,
-					 nco_ctrl);
-		if (ret)
-			return ret;
-
 		ret = gsw1xx_pcs_phy_xaui_write(priv, 0x30, 0x80);
 		if (ret)
 			return ret;
-- 
2.39.5

