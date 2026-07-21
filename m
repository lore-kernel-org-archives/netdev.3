Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551F3783AE;
	Tue, 21 Jul 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635117; cv=none; b=lT84T6b/WOaSFFHhOjxNuT6k4j4ZF+10ZIOY6Oum4uWgnpBhm1HTX254Ru/59utSuUPN+xrxOyqOQa1zwoZDvOJxJxjUcMh8dHtN+29GUtf5yeTgxxIDID8sINA/YUq8OuC4xnCgrTG4xcsqQN7Ece+PFhrH0upSoF7Z27QLAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635117; c=relaxed/simple;
	bh=satvRzjfbj06hxDpUvd4c62lJO3Z3vw9G35atL3xWKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kf/+BmONNQVsAt/x+Yk74LUp/Y/8qLWQdpICmToKMmuoSHBxR82g5PMYLm9dtgTuGLrpRY2bz8oHEEXOGUOaMMaEa50JOkQBWpfGYaPAKREbuM2tmRxWCpibDWgHnnsg24OmU6O1mKqhodBaMcwDiOIf6dUw39FF2H8j/M76lKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LQFHapx2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LQFHapx2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9B3C84E40E9F;
	Tue, 21 Jul 2026 11:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68D4C60368;
	Tue, 21 Jul 2026 11:58:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6790111BD3CB9;
	Tue, 21 Jul 2026 13:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784635109; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TbRt66DWq0Kax2nWpkRuQuxuobx/m8rLkvG747KBwKg=;
	b=LQFHapx21KVFtPunsPbh+HHXqTk1H7GVbBNTj7tQjCBFkZbuNXa967ZK8eUxdtYBo+awP3
	QXd4UWnXD46kGwqbUHlhPj2/GTNi5lY9gj+1WMyRJ6ASd87VIJJXnUlPRyBvunJYEW4YgY
	oNxQwhW+Av+BRKabgld4w+XGCtMfcuBvx359GEiIZDZzgpac9nuUN3an5DK6tiULWiIU6H
	mBBuCWZOi1jv+l9G1EvfYp+S2QT4V/AfPWB4a9S4zLk7a4aKpA8QNsU9WE/pF0ltSo7R49
	KNpoBclpoH7lUte+kjPQrQOqsflW2GjfRSugiD7l2FFCHCdicNGzq0hEt6SOUQ==
Message-ID: <b8f26ddd-4c95-44a2-b93f-ef198702c838@bootlin.com>
Date: Tue, 21 Jul 2026 13:58:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 00/12] net: pcs: Introduce support for fwnode
 PCS
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260717065448.1498335-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christian,

On 7/17/26 08:54, Christian Marangi wrote:
> This series introduce a most awaited feature that is correctly
> provide PCS with fwnode without having to use specific export symbol
> and additional handling of PCS in phylink.
I was finally able to spend a bit of time digging deeper, I ported the
mvpp2 driver to your new API to test that dynamic PCS selection for
internal PCSs still works, and it's all good :)

Congrats on that work !

This didn't exercise all code paths, especially with the fwnode API but
you've tested that enough on your side :)

Maxime

The patch I used for testing if you're curious :

(I'll send that once this series land, or you can include it but I don't
want to delay your work in case the patch goes through rounds of reviews...)

--- 8>< -----------------------------------------------------------------

From 38ad94b1e62bf3523097983dfb515f59b1634477 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 21 Jul 2026 13:52:57 +0200
Subject: [PATCH] net: marvell: mvpp2: Convert to the new PCS API

Following the introduction of the PCS framework, port mvpp2 to the new
PCS API.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 161 +++++++++++-------
 1 file changed, 95 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ccc24a1301f2..8d9663c7a023 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6499,21 +6499,6 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 		writel(ctrl4, port->base + MVPP22_GMAC_CTRL_4_REG);
 }
 
-static struct phylink_pcs *mvpp2_select_pcs(struct phylink_config *config,
-					    phy_interface_t interface)
-{
-	struct mvpp2_port *port = mvpp2_phylink_to_port(config);
-
-	/* Select the appropriate PCS operations depending on the
-	 * configured interface mode. We will only switch to a mode
-	 * that the validate() checks have already passed.
-	 */
-	if (mvpp2_is_xlg(interface))
-		return &port->pcs_xlg;
-	else
-		return &port->pcs_gmac;
-}
-
 static int mvpp2_mac_prepare(struct phylink_config *config, unsigned int mode,
 			     phy_interface_t interface)
 {
@@ -6786,7 +6771,6 @@ static int mvpp2_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 }
 
 static const struct phylink_mac_ops mvpp2_phylink_ops = {
-	.mac_select_pcs = mvpp2_select_pcs,
 	.mac_prepare = mvpp2_mac_prepare,
 	.mac_config = mvpp2_mac_config,
 	.mac_finish = mvpp2_mac_finish,
@@ -6808,7 +6792,10 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
 	};
 	struct phylink_pcs *pcs;
 
-	pcs = mvpp2_select_pcs(&port->phylink_config, port->phy_interface);
+	if (mvpp2_is_xlg(port->phy_interface))
+		pcs = &port->pcs_xlg;
+	else
+		pcs = &port->pcs_gmac;
 
 	mvpp2_mac_prepare(&port->phylink_config, MLO_AN_INBAND,
 			  port->phy_interface);
@@ -6823,6 +6810,78 @@ static void mvpp2_acpi_start(struct mvpp2_port *port)
 			  SPEED_UNKNOWN, DUPLEX_UNKNOWN, false, false);
 }
 
+static int mvpp2_port_fill_pcs(struct phylink_config *config,
+			       struct phylink_pcs **available_pcs,
+			       unsigned int num_possible_pcs)
+{
+	struct mvpp2_port *port = mvpp2_phylink_to_port(config);
+
+	available_pcs[0] = &port->pcs_gmac;
+
+	if (mvpp2_port_supports_xlg(port)) {
+		if (num_possible_pcs < 2)
+			return -EINVAL;
+
+		available_pcs[1] = &port->pcs_xlg;
+	}
+
+	return 0;
+}
+
+static void mvpp2_port_init_pcs_xlg(struct phylink_pcs *pcs, bool has_comphy,
+				    phy_interface_t phy_mode)
+{
+	if (has_comphy) {
+		__set_bit(PHY_INTERFACE_MODE_5GBASER,
+			  pcs->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  pcs->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_XAUI,
+			  pcs->supported_interfaces);
+	} else if (phy_mode == PHY_INTERFACE_MODE_5GBASER) {
+		__set_bit(PHY_INTERFACE_MODE_5GBASER,
+			  pcs->supported_interfaces);
+	} else if (phy_mode == PHY_INTERFACE_MODE_10GBASER) {
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  pcs->supported_interfaces);
+	} else if (phy_mode == PHY_INTERFACE_MODE_XAUI) {
+		__set_bit(PHY_INTERFACE_MODE_XAUI,
+			  pcs->supported_interfaces);
+	}
+}
+
+static void mvpp2_port_init_pcs_gmac(struct phylink_pcs *pcs, bool has_comphy,
+				     phy_interface_t phy_mode)
+{
+	if (has_comphy) {
+		/* If a COMPHY is present, we can support any of the
+		 * serdes modes and switch between them.
+		 */
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pcs->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pcs->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pcs->supported_interfaces);
+	} else if (phy_mode == PHY_INTERFACE_MODE_2500BASEX) {
+		/* No COMPHY, with only 2500BASE-X mode supported */
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pcs->supported_interfaces);
+	} else if (phy_mode == PHY_INTERFACE_MODE_1000BASEX ||
+		   phy_mode == PHY_INTERFACE_MODE_SGMII) {
+		/* No COMPHY, we can switch between 1000BASE-X and SGMII
+		 */
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pcs->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pcs->supported_interfaces);
+	}
+
+	/* RGMII and MII are still routed through the gmac PCS */
+	phy_interface_set_rgmii(pcs->supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_MII, pcs->supported_interfaces);
+}
+
 /* In order to ensure backward compatibility for ACPI, check if the port
  * firmware node comprises the necessary description allowing to use phylink.
  */
@@ -7082,28 +7141,17 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 			port->phylink_config.mac_capabilities |=
 				MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 
-		if (mvpp2_port_supports_xlg(port)) {
-			/* If a COMPHY is present, we can support any of
-			 * the serdes modes and switch between them.
-			 */
-			if (comphy) {
-				__set_bit(PHY_INTERFACE_MODE_5GBASER,
-					  port->phylink_config.supported_interfaces);
-				__set_bit(PHY_INTERFACE_MODE_10GBASER,
-					  port->phylink_config.supported_interfaces);
-				__set_bit(PHY_INTERFACE_MODE_XAUI,
-					  port->phylink_config.supported_interfaces);
-			} else if (phy_mode == PHY_INTERFACE_MODE_5GBASER) {
-				__set_bit(PHY_INTERFACE_MODE_5GBASER,
-					  port->phylink_config.supported_interfaces);
-			} else if (phy_mode == PHY_INTERFACE_MODE_10GBASER) {
-				__set_bit(PHY_INTERFACE_MODE_10GBASER,
-					  port->phylink_config.supported_interfaces);
-			} else if (phy_mode == PHY_INTERFACE_MODE_XAUI) {
-				__set_bit(PHY_INTERFACE_MODE_XAUI,
-					  port->phylink_config.supported_interfaces);
-			}
+		if (!mvpp2_port_supports_xlg(port))
+			port->phylink_config.num_possible_pcs = 1;
+		else
+			port->phylink_config.num_possible_pcs = 2;
+
+		port->phylink_config.fill_available_pcs = mvpp2_port_fill_pcs;
 
+		mvpp2_port_init_pcs_xlg(&port->pcs_xlg, comphy, phy_mode);
+		mvpp2_port_init_pcs_gmac(&port->pcs_gmac, comphy, phy_mode);
+
+		if (mvpp2_port_supports_xlg(port)) {
 			if (comphy)
 				port->phylink_config.mac_capabilities |=
 					MAC_10000FD | MAC_5000FD;
@@ -7115,35 +7163,16 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 					MAC_10000FD;
 		}
 
-		if (mvpp2_port_supports_rgmii(port)) {
-			phy_interface_set_rgmii(port->phylink_config.supported_interfaces);
-			__set_bit(PHY_INTERFACE_MODE_MII,
-				  port->phylink_config.supported_interfaces);
-		}
+		phy_interface_copy(port->phylink_config.pcs_interfaces,
+				   port->pcs_gmac.supported_interfaces);
 
-		if (comphy) {
-			/* If a COMPHY is present, we can support any of the
-			 * serdes modes and switch between them.
-			 */
-			__set_bit(PHY_INTERFACE_MODE_SGMII,
-				  port->phylink_config.supported_interfaces);
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-				  port->phylink_config.supported_interfaces);
-			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-				  port->phylink_config.supported_interfaces);
-		} else if (phy_mode == PHY_INTERFACE_MODE_2500BASEX) {
-			/* No COMPHY, with only 2500BASE-X mode supported */
-			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-				  port->phylink_config.supported_interfaces);
-		} else if (phy_mode == PHY_INTERFACE_MODE_1000BASEX ||
-			   phy_mode == PHY_INTERFACE_MODE_SGMII) {
-			/* No COMPHY, we can switch between 1000BASE-X and SGMII
-			 */
-			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-				  port->phylink_config.supported_interfaces);
-			__set_bit(PHY_INTERFACE_MODE_SGMII,
-				  port->phylink_config.supported_interfaces);
-		}
+		if (mvpp2_port_supports_xlg(port))
+			phy_interface_or(port->phylink_config.pcs_interfaces,
+					 port->phylink_config.pcs_interfaces,
+					 port->pcs_xlg.supported_interfaces);
+
+		phy_interface_copy(port->phylink_config.supported_interfaces,
+				   port->phylink_config.pcs_interfaces);
 
 		phylink = phylink_create(&port->phylink_config, port_fwnode,
 					 phy_mode, &mvpp2_phylink_ops);
-- 
2.55.0


