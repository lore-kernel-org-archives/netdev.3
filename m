Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC54357A2F;
	Thu, 22 Jan 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099976; cv=none; b=FidAYBWnHCL7NO+Xc7t8KJS2xzEMJJooJHKCmI9ix1LeKngeX9OWhvw6a7i6gUkS3BxgszAIXpgF7ylYMCRsLcakjW9O5vdP5kNsIVlqSeGg/4kFHaBvjuKym8jk88Lj3ftVbcblSf2/td2jp5PLaVLbKJu4R4ResLgVfuvCMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099976; c=relaxed/simple;
	bh=BcUs3GJ/DNPCIe5L/+Bm2foqHbeMpC18YNl7ARu5+/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjWr5iwwAfSxLk/Bvp7GExtUGBRSFWqfFlvv+DyjzFTrh25QBzlJnBTUMIcByMOuKSdbpqzynsBpo4t4MCmPCM0jJMAlGL0cEQ6bWmWLJIVm146hh06IyMX1KL0nXbe0VCZjtDC9D7kL3P8tU8coPQEVtAwFQGGYXMKtiDARZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixiQ-000000001Ro-1qVL;
	Thu, 22 Jan 2026 16:39:26 +0000
Date: Thu, 22 Jan 2026 16:39:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 5/6] net: dsa: mxl-gsw1xx: only setup SerDes PCS
 if it exists
Message-ID: <fd46a821b1535751cd7b478a04a9ffe1e9d4d289.1769099517.git.daniel@makrotopia.org>
References: <cover.1769099517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769099517.git.daniel@makrotopia.org>

Older Intel GSW150 chip doesn't have a SGMII/1000Base-X/2500Base-X PCS.
Prepare for supporting Intel GSW150 by skipping PCS reset and
initialization in case no .mac_select_pcs operation is defined.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: rebase on top of current net-next
v5: no changes
v4: no changes
v3: no changes
v2: new patch

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 37 ++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index ba72111a53ad0..c6fa93229349a 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -615,6 +615,28 @@ static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
 				priv, &config);
 }
 
+static int gsw1xx_serdes_pcs_init(struct gsw1xx_priv *priv)
+{
+	/* do nothing if the chip doesn't have a SerDes PCS */
+	if (!priv->gswip.hw_info->mac_select_pcs)
+		return 0;
+
+	priv->pcs.ops = &gsw1xx_pcs_ops;
+	priv->pcs.poll = true;
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  priv->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  priv->pcs.supported_interfaces);
+	if (priv->gswip.hw_info->supports_2500m)
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  priv->pcs.supported_interfaces);
+	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
+
+	/* assert SGMII reset to power down SGMII unit */
+	return regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
+			       GSW1XX_RST_REQ_SGMII_SHELL);
+}
+
 static int gsw1xx_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
@@ -667,20 +689,7 @@ static int gsw1xx_probe(struct mdio_device *mdiodev)
 	if (IS_ERR(priv->shell))
 		return PTR_ERR(priv->shell);
 
-	priv->pcs.ops = &gsw1xx_pcs_ops;
-	priv->pcs.poll = true;
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  priv->pcs.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  priv->pcs.supported_interfaces);
-	if (priv->gswip.hw_info->supports_2500m)
-		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-			  priv->pcs.supported_interfaces);
-	priv->tbi_interface = PHY_INTERFACE_MODE_NA;
-
-	/* assert SGMII reset to power down SGMII unit */
-	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
-			      GSW1XX_RST_REQ_SGMII_SHELL);
+	ret = gsw1xx_serdes_pcs_init(priv);
 	if (ret < 0)
 		return ret;
 
-- 
2.52.0
