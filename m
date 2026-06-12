Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6A37475C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274184; cv=none; b=J0wXTtFy18jS/km1IOSomCmKvqbIhgah3bbc0ansrLZh4yjE4YMSJSysdbfhuKvY/pOwS5CpvxX6O0OWAXMuTb3UPjKms32w3954ovZfNfQQ+exXTfpSVYypveRJabc9nLMWB9wZ5qczy0hCDqQicm+mLqv4zzsGIyTDodFbdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274184; c=relaxed/simple;
	bh=XS2Iu8bAmOY/7nGc0btT0t6HaHDprWJphlY95g9jrCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oo1rITVtrh/cFPhTbf3x1EIo8YPj/XLRWFjY2V/um1DiHve14Nuk+6vrV33Qme3GkZM/jf1OSLpPdQJaEocmLvNpbbUmzRExBaqf1UKyM3HfJa169ROKYs1WG26G/Pf6ozDtbQrskr6QiUFpned56wTjNQjLripDS7/IklKJ+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaiVZOeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaiVZOeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E89C1F00A3D;
	Fri, 12 Jun 2026 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781274182;
	bh=P8i8tOgTrcarxt/5goqC+TJ+bZplNbE2uU+AMTyqrek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CaiVZOeoNrbrFqo1IspazQ+ErvQK9m+/3N1VZbQ1jnG20s4NK2Kwr/pVam2mSuDZL
	 e1fkaIqWjlNjXonkELuAEwDCHI/HmKKPguee4QnDs33Sx7FEK9rSl0cTlrEkmj0U3p
	 ZB0FYO+e453arICZ4Lmbrh2rKpgmJuV4WXAosoTGIxUqrS0sYNz+tqcqgP9aoAmkVt
	 vxVfdqLsOowPDRf7dQE7Xd/qmIdW2wZR+swtHrGTHmMV1NCWxIv7Jrt3YrrYQV1lSM
	 qxX4WxG+/lLGrty0ZtHworeq1qe789vkvRBkvW6cCAOM5FHxIntaEj4kWdwIrbEE6A
	 +CtBXgteVX+Nw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 12 Jun 2026 16:22:50 +0200
Subject: [PATCH net-next 1/4] net: dsa: realtek: rtl8366rb: Switch to
 generic port_bridge* handlers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-rtl8366rb-improvements-v1-1-9232286fc20c@kernel.org>
References: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
In-Reply-To: <20260612-rtl8366rb-improvements-v1-0-9232286fc20c@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

The RTL8366RB is using its own sub-standard port isolation code.

Implement the required isolation helpers, use these directly in
the port setup callback, and switch over to the standard port
isolation code.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 108 ++++++++++++------------------------
 1 file changed, 36 insertions(+), 72 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 103039fe3086..8b57ef3bf03a 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -791,6 +791,35 @@ static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
 	return ret;
 }
 
+static int rtl8366rb_port_set_isolation(struct realtek_priv *priv, int port,
+					u32 mask)
+{
+	/* Bit 0 enables isolation so set this if we enable isolation
+	 * any of the ports an clear it if we disable on all of them.
+	 */
+	if (mask)
+		mask = RTL8366RB_PORT_ISO_PORTS(mask) | RTL8366RB_PORT_ISO_EN;
+
+	return regmap_write(priv->map, RTL8366RB_PORT_ISO(port),
+			    mask);
+}
+
+static int rtl8366rb_port_add_isolation(struct realtek_priv *priv, int port,
+					u32 mask)
+{
+	/* We assume isolation bit is on */
+	return regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(port),
+				  RTL8366RB_PORT_ISO_PORTS(mask),
+				  RTL8366RB_PORT_ISO_PORTS(mask));
+}
+
+static int rtl8366rb_port_remove_isolation(struct realtek_priv *priv, int port,
+					   u32 mask)
+{
+	return regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(port),
+				  RTL8366RB_PORT_ISO_PORTS(mask), 0);
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -868,16 +897,13 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 
 	/* Isolate all user ports so they can only send packets to itself and the CPU port */
 	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
-		ret = regmap_write(priv->map, RTL8366RB_PORT_ISO(i),
-				   RTL8366RB_PORT_ISO_PORTS(BIT(RTL8366RB_PORT_NUM_CPU)) |
-				   RTL8366RB_PORT_ISO_EN);
+		ret = rtl8366rb_port_set_isolation(priv, i, BIT(RTL8366RB_PORT_NUM_CPU));
 		if (ret)
 			return ret;
 	}
 	/* CPU port can send packets to all ports */
-	ret = regmap_write(priv->map, RTL8366RB_PORT_ISO(RTL8366RB_PORT_NUM_CPU),
-			   RTL8366RB_PORT_ISO_PORTS(dsa_user_ports(ds)) |
-			   RTL8366RB_PORT_ISO_EN);
+	ret = rtl8366rb_port_set_isolation(priv, RTL8366RB_PORT_NUM_CPU,
+					   dsa_user_ports(ds));
 	if (ret)
 		return ret;
 
@@ -1184,70 +1210,6 @@ rtl8366rb_port_disable(struct dsa_switch *ds, int port)
 		return;
 }
 
-static int
-rtl8366rb_port_bridge_join(struct dsa_switch *ds, int port,
-			   struct dsa_bridge bridge,
-			   bool *tx_fwd_offload,
-			   struct netlink_ext_ack *extack)
-{
-	struct realtek_priv *priv = ds->priv;
-	unsigned int port_bitmap = 0;
-	int ret, i;
-
-	/* Loop over all other ports than the current one */
-	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
-		/* Current port handled last */
-		if (i == port)
-			continue;
-		/* Not on this bridge */
-		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
-			continue;
-		/* Join this port to each other port on the bridge */
-		ret = regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(i),
-					 RTL8366RB_PORT_ISO_PORTS(BIT(port)),
-					 RTL8366RB_PORT_ISO_PORTS(BIT(port)));
-		if (ret)
-			dev_err(priv->dev, "failed to join port %d\n", port);
-
-		port_bitmap |= BIT(i);
-	}
-
-	/* Set the bits for the ports we can access */
-	return regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(port),
-				  RTL8366RB_PORT_ISO_PORTS(port_bitmap),
-				  RTL8366RB_PORT_ISO_PORTS(port_bitmap));
-}
-
-static void
-rtl8366rb_port_bridge_leave(struct dsa_switch *ds, int port,
-			    struct dsa_bridge bridge)
-{
-	struct realtek_priv *priv = ds->priv;
-	unsigned int port_bitmap = 0;
-	int ret, i;
-
-	/* Loop over all other ports than this one */
-	for (i = 0; i < RTL8366RB_PORT_NUM_CPU; i++) {
-		/* Current port handled last */
-		if (i == port)
-			continue;
-		/* Not on this bridge */
-		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
-			continue;
-		/* Remove this port from any other port on the bridge */
-		ret = regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(i),
-					 RTL8366RB_PORT_ISO_PORTS(BIT(port)), 0);
-		if (ret)
-			dev_err(priv->dev, "failed to leave port %d\n", port);
-
-		port_bitmap |= BIT(i);
-	}
-
-	/* Clear the bits for the ports we can not access, leave ourselves */
-	regmap_update_bits(priv->map, RTL8366RB_PORT_ISO(port),
-			   RTL8366RB_PORT_ISO_PORTS(port_bitmap), 0);
-}
-
 /**
  * rtl8366rb_drop_untagged() - make the switch drop untagged and C-tagged frames
  * @priv: SMI state container
@@ -1801,8 +1763,8 @@ static const struct dsa_switch_ops rtl8366rb_switch_ops = {
 	.get_strings = rtl8366_get_strings,
 	.get_ethtool_stats = rtl8366_get_ethtool_stats,
 	.get_sset_count = rtl8366_get_sset_count,
-	.port_bridge_join = rtl8366rb_port_bridge_join,
-	.port_bridge_leave = rtl8366rb_port_bridge_leave,
+	.port_bridge_join = rtl83xx_port_bridge_join,
+	.port_bridge_leave = rtl83xx_port_bridge_leave,
 	.port_vlan_filtering = rtl8366rb_vlan_filtering,
 	.port_vlan_add = rtl8366_vlan_add,
 	.port_vlan_del = rtl8366_vlan_del,
@@ -1830,6 +1792,8 @@ static const struct realtek_ops rtl8366rb_ops = {
 	.is_vlan_valid	= rtl8366rb_is_vlan_valid,
 	.enable_vlan	= rtl8366rb_enable_vlan,
 	.enable_vlan4k	= rtl8366rb_enable_vlan4k,
+	.port_add_isolation = rtl8366rb_port_add_isolation,
+	.port_remove_isolation = rtl8366rb_port_remove_isolation,
 	.phy_read	= rtl8366rb_phy_read,
 	.phy_write	= rtl8366rb_phy_write,
 };

-- 
2.54.0

